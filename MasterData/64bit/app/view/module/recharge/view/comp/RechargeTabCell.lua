local var_0_0 = g.core.const.ConstMgr.ShopConst
local RechargeTabCell = class("RechargeTabCell", require("app.fairyGUI.recharge.UI_RechargeTabCell"))
local var_0_2 = {
	[g.core.const.ConstMgr.ShopConst.SHOP_TYPE.HOT_SALE] = 217,
	[g.core.const.ConstMgr.ShopConst.SHOP_TYPE.MONTH_CARD] = 191,
	[g.core.const.ConstMgr.ShopConst.SHOP_TYPE.GIFT] = 196,
	[g.core.const.ConstMgr.ShopConst.SHOP_TYPE.RECHARGE_SKIN] = 289
}
local var_0_3 = {
	[g.core.const.ConstMgr.ShopConst.SHOP_TYPE.HOT_SALE] = {
		[g.core.const.ConstMgr.ShopConst.RECHARGE_HOT_VALUE.HOT_GIFT] = 218,
		[g.core.const.ConstMgr.ShopConst.RECHARGE_HOT_VALUE.HOT_MONTH_CARD] = 219,
		[g.core.const.ConstMgr.ShopConst.RECHARGE_HOT_VALUE.HOT_GM_PUSHGIFT] = 713
	},
	[g.core.const.ConstMgr.ShopConst.SHOP_TYPE.GIFT] = {
		[g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.GIFT] = 176,
		[g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.LIMIT_GIFT] = 190,
		[g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.THEME_GIFT] = 315,
		[g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.CULTIVATE_GIFT] = 783,
		[g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.ACTIVITY_RETURN] = 493,
		[g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.MONTH_GIFT] = 947,
		[g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.GACHA_GIFT] = 419,
		[g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.LEVEL_GIFT] = 339,
		[g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.PRECIOUS_RECRUIT] = 781,
		[g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.BOUNTY_GIFT] = 779,
		[g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.NEO_GIFT] = 1063,
		[g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.WEDDING] = 803,
		[g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.RECRUIT_SPRING] = 866,
		[g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.RETRO_GIFT] = 873,
		[g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.WEDDING_ACTIVITY] = 886,
		[g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.WITCH_CULTIVATE_GIFT] = 906,
		[g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.SUCCUBA_LAUNCH] = 930,
		[g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.FURNITURE_GIFT] = 949
	},
	[g.core.const.ConstMgr.ShopConst.SHOP_TYPE.RECHARGE_SKIN] = {
		[g.core.const.ConstMgr.ShopConst.RECHARGE_SKIN_VALUE.RECHARGE] = 290
	}
}

function RechargeTabCell:ctor()
	self.m_buttonController = self:getController("button")
	self._subRedPointList = {}
	self._isRefreshRedPoint = false
	self._minHeight = self.m_bg:getHeight()
	self._info = nil
	self._sub = nil
	self._isSelectedSub = false

	self:_initComp()
	self:_addListener()
end

function RechargeTabCell:_initComp()
	self:_initUI()
end

function RechargeTabCell:updateCell(arg_3_1)
	self._tabParams = arg_3_1
	self._info = arg_3_1.info
	self._sub = arg_3_1.subInfo

	self:setTitle(arg_3_1.name)
	self.m_title1:setText(arg_3_1.name)

	local var_3_0, var_3_1 = self:_getIconUrl(self._info.tab_type, self._info.shop_type)

	self:setIcon(var_3_0)
	self:setSelectedIcon(var_3_1)

	local var_3_2

	if self._sub then
		var_3_2 = #self._sub or 0
	end

	self.m_subList:setNumItems(var_3_2)
	self.m_subList:resizeToFit(var_3_2)

	self._maxHeight = self.m_subBg:getPosition().y + self.m_subBg:getHeight()

	self.m_hasSubController:setSelectedIndex(var_3_2 > 0 and 1 or 0)

	if self._info.tab_type == 6 then
		self.m_isHotSaleController:setSelectedIndex(2)
	elseif self._info.tab_type == 7 then
		self.m_isHotSaleController:setSelectedIndex(1)
	else
		self.m_isHotSaleController:setSelectedIndex(0)
	end

	self:_refreshShopRedPoint()
end

function RechargeTabCell:_refreshShopRedPoint()
	if var_0_2[self._info.shop_type] and var_0_2[self._info.shop_type] > 0 then
		self.m_redPointComp:setId(var_0_2[self._info.shop_type])
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp,
			customData = {
				shopType = self._info.shop_type
			}
		})
	end

	for iter_4_0, iter_4_1 in pairs(self._subRedPointList) do
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = iter_4_1,
			customData = {
				shopType = self._info.shop_type
			}
		})
	end
end

function RechargeTabCell:onSelected(arg_5_1)
	if self._sub and arg_5_1 and arg_5_1 < #self._sub then
		self.m_subList:setSelectedIndex(arg_5_1)
		self:_onClickSub()
	else
		self:_onClick()
	end
end

function RechargeTabCell:_initUI()
	self.m_subList:setIniter()
	self.m_subList:setItemRenderer(handler(self, self._onSubItemRenderer))
end

function RechargeTabCell:_addListener()
	self.m_buttonController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onButtonStateChange))
	self:addClickListener(handler(self, self._onClick))
	self.m_subList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickSub))
end

function RechargeTabCell:_onSubItemRenderer(arg_8_1, arg_8_2)
	local var_8_0 = arg_8_2:getChild("redPointComp")

	if var_8_0 then
		local var_8_1 = var_0_3[self._sub[arg_8_1 + 1].info.shop_type] or {}
		local var_8_2 = var_8_1[self._sub[arg_8_1 + 1].info.shop_first]

		if var_8_1[self._sub[arg_8_1 + 1].info.shop_first] and var_8_2 > 0 then
			self._subRedPointList[arg_8_1] = var_8_0

			var_8_0:setId(var_8_2)
		end
	end

	arg_8_2:setTitle(self._sub[arg_8_1 + 1].info.name_1)
end

function RechargeTabCell:_getIconUrl(arg_9_1, arg_9_2)
	local var_9_0 = ""

	if arg_9_1 == 1 then
		if arg_9_2 == 19 then
			var_9_0 = "ui://recharge/icon_chongzhi_"

			if g.core.platform.PlatformProxy:isDmmPC() then
				var_9_0 = "ui://recharge/icon_rexiao_"
			end
		else
			var_9_0 = arg_9_2 == var_0_0.SHOP_TYPE.MONTH_CARD and "ui://recharge/icon_yueka_" or "ui://recharge/icon_chongzhi_"
		end
	elseif arg_9_1 == 2 then
		var_9_0 = "ui://recharge/icon_baowu_"
	elseif arg_9_1 == 5 then
		var_9_0 = "ui://recharge/icon_libao_"
	elseif arg_9_1 == 6 then
		var_9_0 = "ui://recharge/icon_pifutubiao_"
	elseif arg_9_1 == 7 then
		var_9_0 = "ui://recharge/icon_rexiao_"
	end

	return var_9_0 .. "0", var_9_0 .. "1"
end

function RechargeTabCell:_onButtonStateChange()
	local var_10_0

	if not self._sub or #self._sub <= 0 then
		do return end

		var_10_0 = self._maxHeight
	end

	if self.m_buttonController:getSelectedIndex() == 0 then
		self._isSelectedSub = false
		self._selectedSubIndex = -1
		var_10_0 = self._minHeight
	end

	self:setHeight(var_10_0)

	for iter_10_0, iter_10_1 in pairs(self._subRedPointList) do
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = iter_10_1
		})
	end
end

function RechargeTabCell:_onClick()
	if self._sub and #self._sub > 0 then
		if not self._isSelectedSub then
			self.m_subList:setSelectedIndex(0)
			self:_onClickSub()
		end

		return
	end

	self:dispatchCompEvent(var_0_0.SHOP_EVENT_TAB_CHANGE, self._tabParams)
end

function RechargeTabCell:_onClickSub()
	if self._sub and #self._sub > 0 then
		local var_12_0 = self.m_subList:getSelectedIndex()

		if self._sub[var_12_0 + 1] and self._selectedSubIndex ~= var_12_0 then
			self._selectedSubIndex = var_12_0

			self:dispatchCompEvent(var_0_0.SHOP_EVENT_TAB_CHANGE, self._sub[var_12_0 + 1])

			for iter_12_0, iter_12_1 in pairs(self._subRedPointList) do
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
					redPointComp = iter_12_1
				})
			end
		end

		self._isSelectedSub = true
	end
end

return RechargeTabCell
