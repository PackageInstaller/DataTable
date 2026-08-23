local FragSellPop = class("FragSellPop", require("app.fairyGUI.infoPop.UI_FragSellPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/infoPop/infoPop",
		resName = "FragSellPop",
		pkgName = "infoPop"
	}, ...)
end)

function FragSellPop:ctor(arg_2_1, arg_2_2)
	self._datas = arg_2_1
	self._selectedFragDic = {
		count = 0,
		idxMap = {}
	}
	self._selectedTabDic = {
		count = 0,
		idxMap = {}
	}
	self._priceMap = {}
	self._rewardMap = {}
	self._qualityKeyMap = {}

	if arg_2_1[1] then
		self._priceInfo = g.core.common.Goods:convert({
			type = arg_2_1[1].priceType,
			value = arg_2_1[1].priceValue
		})
	else
		self.m_isEmptyController:setSelectedIndex(1)
	end

	self._priceInfo2 = nil

	self:_initUIWithParams(arg_2_2)
	self:showAtCenter()
end

function FragSellPop:_initUIWithParams(arg_3_1)
	if arg_3_1.title then
		self.m_popPanel:setTitle(arg_3_1.title)
	end

	if arg_3_1.btnTitle then
		self.m_sellBtn:setTitle(arg_3_1.btnTitle)
	end

	if arg_3_1.emptyTitle then
		self.m_emptyComp:setTitle(arg_3_1.emptyTitle)
	end

	self._fragNameId = arg_3_1.fragNameId
	self._qualitySignArr = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.qualityArr) do
		table.insert(self._qualitySignArr, {
			selected = 0,
			quality = iter_3_1
		})

		self._qualityKeyMap[iter_3_1] = #self._qualitySignArr
	end

	self.m_fragList:setVirtual(self)
	self.m_fragList:setItemRenderer(handler(self, self._onFragListItemRender))
	self.m_fragList:setNumItems(#self._datas)
	self.m_tabList:setVirtual(self)
	self.m_tabList:setItemRenderer(handler(self, self._onTabListItemRender))
	self.m_tabList:setNumItems(#self._qualitySignArr)
	self.m_sellBtn:addClickListener(handler(self, self._onSellClick))
end

function FragSellPop:onLoad(arg_4_1, arg_4_2)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SELL, self._onSellSucceed, self)
	self:_updatePriceComp()
end

function FragSellPop:onUnload()
	return
end

function FragSellPop:_onTabListItemRender(arg_6_1, arg_6_2)
	arg_6_2:updateBtn(self._qualitySignArr[arg_6_1 + 1])
end

function FragSellPop:_onFragListItemRender(arg_7_1, arg_7_2)
	arg_7_2:updateCell(self._datas[arg_7_1 + 1], arg_7_1 + 1)
end

function FragSellPop:_onSellClick()
	if self._selectedFragDic.count == 0 then
		local var_8_0 = {}

		var_8_0.frag = g.core.lang:get(self._fragNameId or 108034)

		g.core.module.ModuleManager:tip(g.core.lang:get(201583, var_8_0))

		return
	end

	local var_8_1 = self._selectedFragDic.count
	local var_8_2 = g.core.lang:get(self._fragNameId or 108034)
	local var_8_3 = ""
	local var_8_4

	if #self._rewardMap > 1 then
		var_8_3 = g.core.lang:get(102540, {
			costNum = var_8_1,
			costName = var_8_2,
			num = self._rewardMap[1].num,
			name = self._rewardMap[1].info.name,
			num2 = self._rewardMap[2].num,
			name2 = self._rewardMap[2].info.name
		})
	else
		var_8_3 = g.core.lang:get(102536, {
			costNum = var_8_1,
			costName = var_8_2,
			num = self._rewardMap[1].num,
			name = self._rewardMap[1].info.name
		})
		var_8_4 = require("app.view.base.pop.BaseConfirmPop").new
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		desc = var_8_3,
		title = g.core.lang:get(201530),
		onConfirm = handler(self, self._doSell)
	}))
end

function FragSellPop:_doSell()
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(self._selectedFragDic.idxMap) do
		table.insert(var_9_0, {
			type = self._datas[iter_9_0].type,
			value = self._datas[iter_9_0].value,
			size = self._datas[iter_9_0].size
		})
	end

	g.core.network.GameNetProxy:send_C2S_Sell({
		consumes = var_9_0
	})
end

function FragSellPop:_onSellSucceed()
	local var_10_0 = {}

	if self._rewardMap[1] then
		var_10_0.num1 = self._rewardMap[1].num or ""
	end

	if self._rewardMap[1] and self._rewardMap[1].info then
		var_10_0.name1 = self._rewardMap[1].info.name or ""
	end

	if self._rewardMap[2] then
		var_10_0.num2 = self._rewardMap[2].num or ""
	end

	if self._rewardMap[2] and self._rewardMap[2].info then
		var_10_0.name2 = self._rewardMap[2].info.name or ""
	end

	g.core.module.ModuleManager:tip(g.core.lang:get(201533, var_10_0))
	self:dispatchCompEvent("FragSellPopClose", {})
	g.core.module.ModuleManager:popComponent()
end

function FragSellPop:receiveCompEvent(arg_11_1)
	local var_11_0 = ...

	if not var_11_0 then
		return
	end

	local var_11_1 = var_11_0.idx
	local var_11_2 = var_11_0.selectIdx

	if arg_11_1 == "FragCellClicked" then
		if var_11_2 == 0 then
			self:addPrice(self._datas[var_11_1].priceType, self._datas[var_11_1].priceValue, self._datas[var_11_1].priceSize, -self._datas[var_11_1].size)
		else
			self:addPrice(self._datas[var_11_1].priceType, self._datas[var_11_1].priceValue, self._datas[var_11_1].priceSize, self._datas[var_11_1].size)
		end

		self:_changeSelectedFragDic(var_11_1, var_11_2)
	elseif arg_11_1 == "TabItemClicked" then
		if self._qualityKeyMap[var_11_0.quality] and self._qualitySignArr[self._qualityKeyMap[var_11_0.quality]] then
			self._qualitySignArr[self._qualityKeyMap[var_11_0.quality]].selected = var_11_2
		end

		self:_changeFragItemSelectedStatueByQuality(var_11_0.quality, var_11_2)
		self:clearPrice()

		for iter_11_0, iter_11_1 in pairs(self._selectedFragDic.idxMap) do
			self:addPrice(self._datas[iter_11_0].priceType, self._datas[iter_11_0].priceValue, self._datas[iter_11_0].priceSize, self._datas[iter_11_0].size)
		end
	end

	self:_updatePriceComp()
end

function FragSellPop:addPrice(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if not self._priceMap[arg_12_2] then
		self._priceMap[arg_12_2] = 0

		if self._priceInfo.value ~= arg_12_2 then
			self._priceInfo2 = g.core.common.Goods:convert({
				type = arg_12_1,
				value = arg_12_2
			})
		end
	end

	self._priceMap[arg_12_2] = self._priceMap[arg_12_2] + arg_12_3 * arg_12_4
end

function FragSellPop:clearPrice()
	for iter_13_0, iter_13_1 in pairs(self._priceMap) do
		self._priceMap[iter_13_0] = 0
	end
end

function FragSellPop:_changeFragItemSelectedStatueByQuality(arg_14_1, arg_14_2)
	local var_14_0 = 0

	for iter_14_0, iter_14_1 in ipairs(self._datas) do
		if iter_14_1.quality == arg_14_1 then
			if iter_14_1.selected ~= arg_14_2 then
				iter_14_1.selected = arg_14_2

				self:_changeSelectedFragDic(iter_14_0, arg_14_2)
			end

			var_14_0 = var_14_0 + 1
		end
	end

	self.m_fragList:setNumItems(#self._datas)

	if var_14_0 == 0 and arg_14_2 == 1 then
		local var_14_1 = {}

		var_14_1.frag = g.core.lang:get(self._fragNameId or 108034)

		g.core.module.ModuleManager:tip(g.core.lang:get(201582, var_14_1))
	end
end

function FragSellPop:_changeSelectedFragDic(arg_15_1, arg_15_2)
	if arg_15_2 == 0 then
		self._selectedFragDic.idxMap[arg_15_1] = nil
		self._selectedFragDic.count = self._selectedFragDic.count - self._datas[arg_15_1].size
	else
		self._selectedFragDic.idxMap[arg_15_1] = true
		self._selectedFragDic.count = self._selectedFragDic.count + self._datas[arg_15_1].size
	end
end

function FragSellPop:_updatePriceComp()
	if not self._priceInfo then
		return
	end

	local var_16_0 = {
		self.m_sellRewardComp,
		self.m_sellRewardComp2
	}
	local var_16_1 = 0
	local var_16_2 = false

	self._rewardMap = {}

	for iter_16_0, iter_16_1 in pairs(self._priceMap) do
		if iter_16_1 ~= 0 then
			var_16_1 = var_16_1 + 1

			if self._priceInfo.value == iter_16_0 then
				var_16_0[var_16_1]:updateByTVS({
					type = self._priceInfo.type,
					value = self._priceInfo.value,
					size = iter_16_1
				})

				self._rewardMap[var_16_1] = {
					num = iter_16_1,
					info = self._priceInfo
				}
			else
				var_16_0[var_16_1]:updateByTVS({
					type = self._priceInfo2.type,
					value = self._priceInfo2.value,
					size = iter_16_1
				})

				self._rewardMap[var_16_1] = {
					num = iter_16_1,
					info = self._priceInfo2
				}
			end

			var_16_2 = true
		end
	end

	if not var_16_2 then
		self.m_sellRewardComp:updateByTVS({
			size = 0,
			type = self._priceInfo.type,
			value = self._priceInfo.value
		})
	end

	self.m_priceNumController:setSelectedIndex(var_16_1 > 1 and 1 or 0)
end

return FragSellPop
