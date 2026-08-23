local ShopOneKeyBuyPop = class("ShopOneKeyBuyPop", require("app.fairyGUI.shop.UI_ShopOneKeyBuyPop"), function()
	return fgui.GComponent:create({
		resName = "ShopOneKeyBuyPop",
		pkgPath = "ui/shop/shop",
		pkgName = "shop"
	})
end)
local var_0_1 = g.core.model.User.shopData
local var_0_2 = g.core.model.User.bagData
local var_0_3 = g.core.event.EventManager
local var_0_4 = g.core.event.enum
local var_0_5 = g.core.network.GameNetProxy
local var_0_6 = g.core.module.ModuleManager
local ShopTabCell = require("app.view.module.shop.view.ShopTabCell")
local var_0_8 = "EVENT_SHOP_ONE_KEY_BUY_FINISH"

function ShopOneKeyBuyPop:ctor(arg_2_1)
	self:getView():center(true)

	self._shopCarList = arg_2_1.shopCarList or {}
	self._buyList = {}
	self._requestList = {}
	self._groupList = {}
	self._groupMap = {}
	self._allAwards = {}
	self._curIndex = 1
	self._totalRequestCount = 0
	self._curBuyItemIndex = 0
	self._isFinished = false
	self._displayedGroupCount = 0
	self._isRevealingGroup = false
	self._hasListenShop = false
	self._hasShownAwards = false
	self._hasDispatchedFinish = false
	self._groupBuyCount = {}
	self._groupHandledCount = {}

	self.m_list:setIniter(self)
	self.m_list:doFairyBatching(false)
	self.m_list:setItemRenderer(handler(self, self._onListRender))

	if self.m_clickArea then
		self.m_clickArea:addClickListener(handler(self, self._onClickBtn))
	end

	local var_2_0 = self.m_popPanel:getChild("closeBtn")

	if var_2_0 then
		var_2_0:setVisible(false)
	end

	self:addEventListener(fgui.UIEventType.ExitFinish, handler(self, self._onPopExit))
	self:_buildBuyList()
	self.m_list:setNumItems(0)
	self.m_stateController:setSelectedIndex(0)
	self:_updateProgress()

	local var_2_1 = self.m_progress and self.m_progress:getTransition("loop")

	if var_2_1 then
		var_2_1:play(-1, 0)
	end

	if self._totalRequestCount > 0 then
		self:_startNextBuy()
	else
		self:_onAllRequestsDone()
	end
end

function ShopOneKeyBuyPop:_calcCanBuyWithAmount(arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = 0

	if arg_3_1.price_add_id_1 == 0 then
		var_3_0 = math.floor(arg_3_3 / arg_3_1.price_size_1)
		var_3_0 = math.min(var_3_0, arg_3_2)
	else
		local var_3_1 = var_0_1._shopInfo[arg_3_1.id] or 0
		local var_3_2 = 0

		for iter_3_0 = 1, arg_3_2 do
			local var_3_3 = var_0_1:getBuyPrice(arg_3_1.price_add_id_1, var_3_1 + iter_3_0)

			if arg_3_3 < var_3_2 + var_3_3 then
				break
			end

			var_3_2 = var_3_2 + var_3_3
			var_3_0 = iter_3_0
		end
	end

	return var_3_0
end

function ShopOneKeyBuyPop:_buildBuyList()
	self._buyList = {}
	self._requestList = {}

	for iter_4_0, iter_4_1 in ipairs(self._shopCarList) do
		if not var_0_1:checkBuyBan(iter_4_1) then
			local var_4_0 = var_0_1:getBuyLimitLeft(iter_4_1)
			local var_4_1 = iter_4_1.buy_num or 1
			local var_4_2 = true

			if var_4_0 == nil or var_4_0 < 0 then
				var_4_2 = false
			elseif var_4_0 <= 0 then
				var_4_2 = false
			else
				var_4_1 = math.min(var_4_1, var_4_0)
			end

			if var_4_2 and var_4_1 > 0 and var_0_1:getBuyItemNum(iter_4_1, 1) > 0 then
				local var_4_3 = var_0_1:getShopInfoByScoreInfo({
					shop_type = iter_4_1.shop_type,
					shop_first = iter_4_1.shop_first,
					shop_second = iter_4_1.shop_second
				})
				local var_4_4 = {
					failNum = 0,
					shopItem = iter_4_1,
					shopInfo = var_4_3
				}

				if var_4_3 then
					var_4_4.shopId = var_4_3.id or 0
				end

				var_4_4.requestNum = var_4_1
				self._groupBuyCount[iter_4_1.shop_type] = (self._groupBuyCount[iter_4_1.shop_type] or 0) + 1

				table.insert(self._requestList, var_4_4)
				table.insert(self._buyList, var_4_4)
			end
		end
	end

	self._totalRequestCount = #self._requestList
end

function ShopOneKeyBuyPop:_addBuyItemResult(arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_1.shopItem.shop_type

	self._groupHandledCount[var_5_0] = (self._groupHandledCount[arg_5_1.shopItem.shop_type] or 0) + 1

	local var_5_1 = self._groupMap[var_5_0]

	if not self._groupMap[var_5_0] then
		local var_5_2 = {
			buyItemCount = 0
		}

		if arg_5_1.shopInfo then
			var_5_2.shopName = arg_5_1.shopInfo.type_name or ""
		end

		var_5_2.shopIcon = ShopTabCell._getIconUrl(nil, 3, var_5_0)
		var_5_2.items = {}
		var_5_1 = var_5_2
		self._groupMap[var_5_0] = var_5_2

		table.insert(self._groupList, var_5_1)
	end

	var_5_1.buyItemCount = var_5_1.buyItemCount + 1

	if arg_5_2 and arg_5_3 > 0 then
		self:_addItemToGroup(var_5_1, arg_5_1.shopItem.type, arg_5_1.shopItem.value, arg_5_1.shopItem.size * arg_5_3, true, nil)
	end

	if arg_5_1.failNum > 0 then
		self:_addItemToGroup(var_5_1, arg_5_1.shopItem.type, arg_5_1.shopItem.value, arg_5_1.shopItem.size * arg_5_1.failNum, false, "资源不足")
	end

	if self._groupHandledCount[var_5_0] >= self._groupBuyCount[var_5_0] then
		self:_refreshList()
	end
end

function ShopOneKeyBuyPop:_addItemToGroup(arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1.items) do
		if iter_6_1.type == arg_6_2 and iter_6_1.value == arg_6_3 and iter_6_1.isSuccess == arg_6_5 then
			iter_6_1.size = iter_6_1.size + arg_6_4
			iter_6_1.buyItemCount = iter_6_1.buyItemCount + 1

			return
		end
	end

	table.insert(arg_6_1.items, {
		buyItemCount = 1,
		type = arg_6_2,
		value = arg_6_3,
		size = arg_6_4,
		isSuccess = arg_6_5,
		failReason = arg_6_6
	})
end

function ShopOneKeyBuyPop:_onListRender(arg_7_1, arg_7_2)
	self._cellList = self._cellList or {}
	self._cellList[arg_7_1 + 1] = arg_7_2

	if self._isFinished and arg_7_1 == #self._groupList then
		arg_7_2:updateSummaryCell({
			goodList = self._allAwards
		})
	else
		local var_7_0 = self._groupList[arg_7_1 + 1]

		if self._groupList[arg_7_1 + 1] then
			arg_7_2:updateBuyCell({
				shopName = var_7_0.shopName,
				shopIcon = var_7_0.shopIcon,
				goodList = var_7_0.items,
				finishcallback = handler(self, self._onGroupRevealFinish),
				progresscallback = handler(self, self._onIconRevealed)
			})
		end
	end
end

function ShopOneKeyBuyPop:_updateProgress()
	local var_8_0 = self.m_progress:getChild("progressTxt")

	if var_8_0 then
		var_8_0:setText(math.min(self._curBuyItemIndex, #self._buyList) .. "/" .. #self._buyList)
	end
end

function ShopOneKeyBuyPop:_startNextBuy()
	if self._curIndex > self._totalRequestCount then
		if not self._isRevealingGroup and self._displayedGroupCount >= #self._groupList then
			self:_onAllRequestsDone()
		end

		return
	end

	local var_9_0 = self._requestList[self._curIndex]
	local var_9_1 = self:_calcCanBuyWithAmount(self._requestList[self._curIndex].shopItem, self._requestList[self._curIndex].requestNum, (var_0_2:getOwnNum(self._requestList[self._curIndex].shopItem.price_type_1, self._requestList[self._curIndex].shopItem.price_value_1)))

	if var_9_1 < self._requestList[self._curIndex].requestNum then
		var_9_0.failNum = var_9_0.failNum + (var_9_0.requestNum - var_9_1)
		var_9_0.requestNum = var_9_1
	end

	if var_9_0.requestNum <= 0 then
		var_9_0.isSuccess = false

		self:_addBuyItemResult(var_9_0, false, 0)
		self:_gotoNextRequest()

		return
	end

	if not self._hasListenShop then
		var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_SHOP_SHOPPING, self._onShopResult, self, 1)

		self._hasListenShop = true
	end

	var_0_5:send_C2S_Shop_Shopping({
		cost_idx = 0,
		info = {
			id = var_9_0.shopItem.id,
			num = var_9_0.requestNum
		},
		shop_id = var_9_0.shopId
	})
end

function ShopOneKeyBuyPop:_onShopResult(arg_10_1, arg_10_2, arg_10_3)
	if self._isFinished then
		return
	end

	local var_10_0 = self._requestList[self._curIndex]

	if not self._requestList[self._curIndex] then
		self:_gotoNextRequest()

		return
	end

	if arg_10_3 and arg_10_3.info and arg_10_3.info.id == var_10_0.shopItem.id then
		var_10_0.isSuccess = true

		local var_10_1 = arg_10_3.info.num or var_10_0.requestNum

		if arg_10_3.awards then
			for iter_10_0, iter_10_1 in ipairs(arg_10_3.awards) do
				self:_addAward(iter_10_1.type, iter_10_1.value, iter_10_1.size)
			end
		else
			self:_addAward(var_10_0.shopItem.type, var_10_0.shopItem.value, var_10_0.shopItem.size * var_10_1)
		end

		self:_addBuyItemResult(var_10_0, true, var_10_1)
	else
		var_10_0.isSuccess = false
		var_10_0.failNum = var_10_0.failNum + var_10_0.requestNum
		var_10_0.requestNum = 0

		self:_addBuyItemResult(var_10_0, false, 0)
	end

	self:_gotoNextRequest()
end

function ShopOneKeyBuyPop:_onIconRevealed(arg_11_1)
	self._curBuyItemIndex = self._curBuyItemIndex + (arg_11_1.buyItemCount or 1)

	self:_updateProgress()
end

function ShopOneKeyBuyPop:_refreshList()
	self:_tryShowNextGroup()
end

function ShopOneKeyBuyPop:_tryShowNextGroup()
	if self._isRevealingGroup then
		return
	end

	if #self._groupList <= self._displayedGroupCount then
		return
	end

	self._isRevealingGroup = true
	self._displayedGroupCount = self._displayedGroupCount + 1

	self.m_list:setNumItems(self._displayedGroupCount)
	self.m_list:scrollToView(self._displayedGroupCount - 1, false)
end

function ShopOneKeyBuyPop:_onGroupRevealFinish()
	self._isRevealingGroup = false

	self:_tryShowNextGroup()

	if self._curIndex > self._totalRequestCount then
		self:_onAllRequestsDone()
	end
end

function ShopOneKeyBuyPop:_gotoNextRequest()
	self._curIndex = self._curIndex + 1

	self:_startNextBuy()
end

function ShopOneKeyBuyPop:_onAllRequestsDone()
	if self._isFinished then
		return
	end

	if self._isRevealingGroup or self._displayedGroupCount < #self._groupList then
		return
	end

	self._isFinished = true
	self._curBuyItemIndex = #self._buyList

	self.m_list:setNumItems(#self._groupList + 1)
	self.m_stateController:setSelectedIndex(1)
	self.m_list:scrollToView(#self._groupList)
	self:_updateProgress()

	local var_16_0 = self.m_progress and self.m_progress:getTransition("loop")

	if var_16_0 then
		var_16_0:stop()
	end

	if self.m_clickArea then
		self.m_clickArea:setTouchable(true)
	end

	local var_16_1 = self.m_popPanel:getChild("closeBtn")

	if var_16_1 then
		var_16_1:setVisible(true)
	end
end

function ShopOneKeyBuyPop:_onClickBtn()
	if self._isFinished then
		self:close()
	else
		self:_skip()
	end
end

function ShopOneKeyBuyPop:_skip()
	if self._isFinished then
		return
	end

	while self._curIndex <= self._totalRequestCount do
		if self._requestList[self._curIndex] and self._requestList[self._curIndex].isSuccess == nil then
			self._requestList[self._curIndex].isSuccess = false
			self._requestList[self._curIndex].failNum = self._requestList[self._curIndex].failNum + self._requestList[self._curIndex].requestNum
			self._requestList[self._curIndex].requestNum = 0

			self:_addBuyItemResult(self._requestList[self._curIndex], false, 0)
		end

		self._curIndex = self._curIndex + 1
	end

	for iter_18_0, iter_18_1 in ipairs(self._groupList) do
		for iter_18_2, iter_18_3 in ipairs(iter_18_1.items) do
			iter_18_3.played = true
		end
	end

	self:cancelAllSchedule()

	if self._cellList then
		for iter_18_4, iter_18_5 in ipairs(self._cellList) do
			if iter_18_5 and iter_18_5.finishRevealNow then
				iter_18_5:finishRevealNow()
			end
		end
	end

	self._curBuyItemIndex = #self._buyList

	self:_updateProgress()

	self._isRevealingGroup = false
	self._displayedGroupCount = #self._groupList

	self.m_list:setNumItems(self._displayedGroupCount)
	self:_onAllRequestsDone()
end

function ShopOneKeyBuyPop:close()
	self:cancelAllSchedule()
	var_0_6:popModule()
end

function ShopOneKeyBuyPop:_onPopExit()
	if not self._hasDispatchedFinish then
		self._hasDispatchedFinish = true

		var_0_3:dispatchEvent(var_0_8)
	end
end

function ShopOneKeyBuyPop:_addAward(arg_21_1, arg_21_2, arg_21_3)
	for iter_21_0, iter_21_1 in ipairs(self._allAwards) do
		if iter_21_1.type == arg_21_1 and iter_21_1.value == arg_21_2 then
			iter_21_1.size = iter_21_1.size + arg_21_3

			return
		end
	end

	table.insert(self._allAwards, {
		isSuccess = true,
		skipAnim = true,
		type = arg_21_1,
		value = arg_21_2,
		size = arg_21_3
	})
end

function ShopOneKeyBuyPop:onUnload()
	var_0_3:removeListenerWithTarget(self)
	self:cancelAllSchedule()

	if not self._hasShownAwards and #self._allAwards > 0 then
		self._hasShownAwards = true

		var_0_6:awardSummary(self._allAwards)
	end
end

return ShopOneKeyBuyPop
