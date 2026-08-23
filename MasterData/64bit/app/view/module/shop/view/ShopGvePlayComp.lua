local ShopGvePlayComp = class("ShopGvePlayComp", require("app.fairyGUI.shop.UI_ShopGvePlayComp"))
local var_0_1 = g.core.model.User.shopData
local var_0_2 = g.core.const.ConstMgr.ShopConst
local var_0_3 = g.core.model.User.recruitData

function ShopGvePlayComp:ctor()
	self._info = nil
	self._shopInfoList = nil
	self._showList = nil
	self._isUnlock = true

	self.m_itemList:setVirtual()
	self.m_itemList:setItemRenderer(handler(self, self._onItemListRender))
	self.m_tabList:setIniter()
	self.m_tabList:setItemRenderer(handler(self, self._onTabListRenderer))
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onChangeTab))
end

function ShopGvePlayComp:_onItemListRender(arg_2_1, arg_2_2)
	if self._showList and self._showList[arg_2_1 + 1] then
		arg_2_2:updateCell(self._showList[arg_2_1 + 1], arg_2_1, self._info, self._isUnlock)
	end
end

function ShopGvePlayComp:_onTabListRenderer(arg_3_1, arg_3_2)
	if self._subInfo then
		local var_3_0 = self._subInfo[arg_3_1 + 1] or nil

		if var_3_0 then
			arg_3_2:setTitle(var_3_0.name_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
				redPointComp = arg_3_2,
				customData = {
					shopType = var_3_0.shop_type,
					themeValue = var_3_0.shop_first
				}
			})
		end
	end
end

function ShopGvePlayComp:_onChangeTab()
	local var_4_0 = self._subInfo[self.m_tabList:getSelectedIndex() + 1]

	if self._info.id ~= var_4_0.id then
		self._info = var_4_0

		self:_updateCurShowItemListData()
	end
end

function ShopGvePlayComp:updateComp(arg_5_1)
	if arg_5_1 then
		g.core.common.ActivitySort:setSortTp(g.core.common.ActivitySort.SHOP_SHOW)

		self._info = arg_5_1.info
		self._subInfo = arg_5_1.subInfo

		if arg_5_1.subInfo then
			self.m_tabList:setNumItems(#arg_5_1.subInfo)
			self.m_tabList:setSelectedIndex(0)
			self:_updateItemListData()
		else
			self:_updateItemListData()
		end

		self.m_enterTransition:play()
	end
end

function ShopGvePlayComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SHOP_SHOPPING, handler(self, self._onShop), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ITEM_USE, handler(self, self._onRcvItemUse), self)
end

function ShopGvePlayComp:_updateItemListData(arg_7_1)
	if self._info then
		local var_7_0 = {}

		var_7_0 = arg_7_1 and var_0_1:getInfo(self._info.shop_type, arg_7_1, true) or var_0_1:getInfo(self._info.shop_type, self._info.shop_first, true)

		if self._subInfo then
			self._shopInfoList = {}

			for iter_7_0, iter_7_1 in pairs(var_7_0) do
				self._shopInfoList[iter_7_1.shop_second] = self._shopInfoList[iter_7_1.shop_second] or {}

				if self._info.shop_type == var_0_2.SHOP_TYPE.UNITE_TOKEN_NORMAL then
					if var_0_3:isUniteTokenActOpen(iter_7_1.activity_id) then
						table.insert(self._shopInfoList[iter_7_1.shop_second], iter_7_1)
					end
				else
					table.insert(self._shopInfoList[iter_7_1.shop_second], iter_7_1)
				end
			end
		else
			self._shopInfoList = var_7_0 or {}

			if self._info.shop_type == var_0_2.SHOP_TYPE.UNITE_TOKEN_NORMAL then
				for iter_7_2 = #self._shopInfoList, 1, -1 do
					if not var_0_3:isUniteTokenActOpen(self._shopInfoList[iter_7_2].activity_id) then
						table.remove(self._shopInfoList, iter_7_2)
					end
				end
			end
		end

		self:_updateCurShowItemListData()
	end
end

function ShopGvePlayComp:_updateCurShowItemListData()
	if self._info then
		if self._info.open_type == 0 then
			self._isUnlock = true
		else
			local var_8_0 = {}

			var_8_0.buy_ban_type = self._info.open_type
			var_8_0.buy_ban_value = self._info.open_value
			self._isUnlock = not var_0_1:checkBuyBan(var_8_0)
		end
	end

	self._showList = self._subInfo and (self._shopInfoList[self._info.shop_second] or {}) or self._shopInfoList

	if self._hasUpdate then
		self:_updateItemList()
	else
		self:newScheduleOnce(handler(self, self._updateItemList), 0.2)

		self._hasUpdate = true
	end
end

function ShopGvePlayComp:_updateItemList()
	if self._isIgnoreListTransition then
		self.m_itemList:setNumItems(#self._showList)
	else
		self.m_itemList:setNumItems(0)
		self.m_itemList:setNumItems(#self._showList)
		self.m_itemList:transitionShowCells("listCardAUiLeftIn", 0.03, 1)
	end
end

function ShopGvePlayComp:_onShop(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if self:isVisible() then
		local var_10_0 = g.core.config.shop_score_info.get(arg_10_4.info.id)

		self._isIgnoreListTransition = true

		self:_updateItemListData(var_10_0.shop_first)

		self._isIgnoreListTransition = false

		if var_10_0.type == g.core.common.Goods.TYPE_ITEM and g.core.config.item_info.get(var_10_0.value).if_open == 1 then
			g.core.network.GameNetProxy:send_C2S_Item_Use({
				id = var_10_0.value,
				num = var_10_0.size * arg_10_4.info.num
			})

			return
		end

		g.core.module.ModuleManager:awardSummary((arg_10_4.awards == nil or nil) and {
			{
				type = var_10_0.type,
				value = var_10_0.value,
				size = var_10_0.size * arg_10_4.info.num
			}
		})
	end
end

function ShopGvePlayComp:_onRcvItemUse(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if self:isVisible() then
		g.core.module.ModuleManager:awardSummary(arg_11_4.awards)
	end
end

function ShopGvePlayComp:_onCrossDay()
	if self._info.shop_first == 1 and self:isVisible() then
		self:_updateItemListData()
	end
end

return ShopGvePlayComp
