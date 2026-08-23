local ShopTabCell = class("ShopTabCell", require("app.fairyGUI.shop.UI_ShopTabCell"))
local var_0_2 = g.core.const.ConstMgr.ShopConst
local var_0_3 = g.core.model.User.shopData
local var_0_4 = {
	[g.core.const.ConstMgr.ShopConst.SHOP_TYPE.GUILD] = 201,
	[g.core.const.ConstMgr.ShopConst.SHOP_TYPE.ARENA] = 202,
	[g.core.const.ConstMgr.ShopConst.SHOP_TYPE.REBEL] = 203,
	[g.core.const.ConstMgr.ShopConst.SHOP_TYPE.WUSH] = 204,
	[g.core.const.ConstMgr.ShopConst.SHOP_TYPE.WUSH_TOWER] = 613,
	[g.core.const.ConstMgr.ShopConst.SHOP_TYPE.CROSS_SERVER_ARENA] = 5000009,
	[g.core.const.ConstMgr.ShopConst.SHOP_TYPE.TOWER] = 475,
	[g.core.const.ConstMgr.ShopConst.SHOP_TYPE.TOWER_HARD] = 478,
	[g.core.const.ConstMgr.ShopConst.SHOP_TYPE.MYSTERY] = 804,
	[g.core.const.ConstMgr.ShopConst.SHOP_TYPE.BLAZING_ARENA] = 928,
	[g.core.const.ConstMgr.ShopConst.SHOP_TYPE.OUTPOST_SHOP] = 955
}
local var_0_5 = {
	[g.core.const.ConstMgr.ShopConst.SHOP_TYPE.GUILD] = {
		[g.core.const.ConstMgr.ShopConst.SHOP_PLAY_VALUE.FREE] = 206
	},
	[g.core.const.ConstMgr.ShopConst.SHOP_TYPE.ARENA] = {
		[g.core.const.ConstMgr.ShopConst.SHOP_PLAY_VALUE.FREE] = 207
	},
	[g.core.const.ConstMgr.ShopConst.SHOP_TYPE.REBEL] = {
		[g.core.const.ConstMgr.ShopConst.SHOP_PLAY_VALUE.FREE] = 208
	},
	[g.core.const.ConstMgr.ShopConst.SHOP_TYPE.WUSH] = {
		[g.core.const.ConstMgr.ShopConst.SHOP_PLAY_VALUE.WUSH_FREE] = 209
	},
	[g.core.const.ConstMgr.ShopConst.SHOP_TYPE.WUSH_TOWER] = {
		[g.core.const.ConstMgr.ShopConst.SHOP_PLAY_VALUE.FREE] = 614
	},
	[g.core.const.ConstMgr.ShopConst.SHOP_TYPE.CROSS_SERVER_ARENA] = {
		[g.core.const.ConstMgr.ShopConst.SHOP_PLAY_VALUE.FREE] = 5000010
	},
	[g.core.const.ConstMgr.ShopConst.SHOP_TYPE.TOWER] = {
		[g.core.const.ConstMgr.ShopConst.SHOP_PLAY_VALUE.FREE] = 476
	},
	[g.core.const.ConstMgr.ShopConst.SHOP_TYPE.TOWER_HARD] = {
		[g.core.const.ConstMgr.ShopConst.SHOP_PLAY_VALUE.FREE] = 479
	},
	[g.core.const.ConstMgr.ShopConst.SHOP_TYPE.MYSTERY] = {
		[g.core.const.ConstMgr.ShopConst.SHOP_PLAY_VALUE.MYSTERY_FREE] = 805
	},
	[g.core.const.ConstMgr.ShopConst.SHOP_TYPE.BLAZING_ARENA] = {
		[g.core.const.ConstMgr.ShopConst.SHOP_PLAY_VALUE.FREE] = 929
	},
	[g.core.const.ConstMgr.ShopConst.SHOP_TYPE.OUTPOST_SHOP] = {
		[g.core.const.ConstMgr.ShopConst.SHOP_PLAY_VALUE.FREE] = 954
	}
}

function ShopTabCell:ctor()
	self.m_buttonController = self:getController("button")
	self._minHeight = self.m_bg:getHeight()
	self._tabParams = nil
	self._info = nil
	self._sub = nil
	self._isSelectedSub = false
	self._subRedPointList = {}

	self:_initComp()
	self:_addListener()
end

function ShopTabCell:_initComp()
	self:_initUI()
end

function ShopTabCell:updateCell(arg_3_1)
	self._tabParams = arg_3_1
	self._info = arg_3_1.info
	self._sub = arg_3_1.subInfo

	self:setTitle(arg_3_1.name)

	local var_3_0, var_3_1 = self:_getIconUrl(self._info.tab_type, self._info.shop_type)

	self:setIcon(var_3_0)
	self:setSelectedIcon(var_3_1)

	if self._info.shop_type == var_0_2.SHOP_TYPE.SHOP_CAR then
		self.m_styleController:setSelectedIndex(1)
	else
		self.m_styleController:setSelectedIndex(0)
	end

	local var_3_2

	if self._sub then
		var_3_2 = #self._sub or 0
	end

	self.m_subList:setNumItems(var_3_2)
	self.m_subList:resizeToFit(var_3_2)

	self._maxHeight = self.m_subBg:getPosition().y + self.m_subBg:getHeight()

	self.m_hasSubController:setSelectedIndex(var_3_2 > 0 and 1 or 0)
	self.m_isSeasonController:setSelectedIndex(self._info.season_function > 0 and 1 or 0)

	if self._info.season_function > 0 then
		self.m_seasonStatusController:setSelectedIndex(var_0_3:isSeasonOpen(self._info.season_function) and 1 or 0)
	end

	if self._info.tab_type == var_0_2.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE then
		if var_0_4[self._info.shop_type] and var_0_4[self._info.shop_type] > 0 then
			self.m_redPointComp:setId(var_0_4[self._info.shop_type])
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
				redPointComp = self.m_redPointComp
			})
		end

		for iter_3_0, iter_3_1 in pairs(self._subRedPointList) do
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
				redPointComp = iter_3_1
			})
		end
	end

	if self._info.shop_type == var_0_2.SHOP_TYPE.SHOP_CAR then
		-- block empty
	end
end

function ShopTabCell:onSelected(arg_4_1)
	if self._sub and arg_4_1 and arg_4_1 < #self._sub then
		self.m_subList:setSelectedIndex(arg_4_1)
		self:_onClickSub()
	else
		self:_onClick()
	end
end

function ShopTabCell:_initUI()
	self.m_subList:setIniter()
	self.m_subList:setItemRenderer(handler(self, self._onSubItemRenderer))
end

function ShopTabCell:_addListener()
	self.m_buttonController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onButtonStateChange))
	self:addClickListener(handler(self, self._onClick))
	self.m_subList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickSub))
end

function ShopTabCell:_onSubItemRenderer(arg_7_1, arg_7_2)
	arg_7_2:setTitle(self._sub[arg_7_1 + 1].info.name_1)

	local var_7_0 = arg_7_2:getChild("redPointComp")

	if var_7_0 and self._info.tab_type == var_0_2.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE then
		local var_7_1 = var_0_5[self._sub[arg_7_1 + 1].info.shop_type] or {}
		local var_7_2 = var_7_1[self._sub[arg_7_1 + 1].info.shop_first]

		if var_7_1[self._sub[arg_7_1 + 1].info.shop_first] and var_7_2 > 0 then
			self._subRedPointList[arg_7_1] = var_7_0

			var_7_0:setId(var_7_2)
		end
	end
end

function ShopTabCell:_getIconUrl(arg_8_1, arg_8_2)
	local var_8_0 = ""

	if arg_8_1 == 3 then
		var_8_0 = arg_8_2 == 2 and "ui://shop/icon_yanxi_" or arg_8_2 == 3 and "ui://shop/icon_heiyuan_" or arg_8_2 == 4 and "ui://shop/icon_xunbao_" or arg_8_2 == 5 and "ui://shop/icon_zhanbei_" or arg_8_2 == 6 and "ui://shop/icon_wuzi_" or arg_8_2 == 8 and "ui://shop/icon_lianmei_" or arg_8_2 == var_0_2.SHOP_TYPE.PEAK_ARENA and "ui://shop/icon_wangzhejingji_" or arg_8_2 == var_0_2.SHOP_TYPE.MINE and "ui://shop/icon_qianshaomiying_" or arg_8_2 == var_0_2.SHOP_TYPE.TOWER and "ui://shop/icon_tansuo_" or arg_8_2 == var_0_2.SHOP_TYPE.TOWER_HARD and "ui://shop/icon_zhanchong_" or arg_8_2 == var_0_2.SHOP_TYPE.UNITE_TOKEN_NORMAL and "ui://shop/icon_xushi_" or arg_8_2 == var_0_2.SHOP_TYPE.CRYSTAL and "ui://shop/icon_qingbao_" or arg_8_2 == var_0_2.SHOP_TYPE.WUSH_TOWER and "ui://shop/icon_huancai_" or arg_8_2 == var_0_2.SHOP_TYPE.GUILD_WAR and "ui://shop/icon_shunxixingdong_" or arg_8_2 == var_0_2.SHOP_TYPE.TEAM_PVP and "ui://shop/icon_dingjunshan_" or arg_8_2 == var_0_2.SHOP_TYPE.CROSS_SERVER_ARENA and "ui://shop/icon_kunshou_" or arg_8_2 == var_0_2.SHOP_TYPE.KNIGHT_SOUL and "ui://shop/icon_gongmingka_" or arg_8_2 == var_0_2.SHOP_TYPE.RED_CLIFF and "ui://shop/icon_haidao_" or arg_8_2 == var_0_2.SHOP_TYPE.PRECIOUS and "ui://shop/icon_mibao_" or arg_8_2 == var_0_2.SHOP_TYPE.MYSTERY and "ui://shop/icon_shiyuemijing_" or arg_8_2 == var_0_2.SHOP_TYPE.BOUNTY and "ui://shop/icon_shangjin_" or arg_8_2 == var_0_2.SHOP_TYPE.TEAM_BATTLE and "ui://shop/icon_huangjintianji_" or arg_8_2 == var_0_2.SHOP_TYPE.ALLIANCE and "ui://shop/icon_gonghuilianmeng_" or arg_8_2 == var_0_2.SHOP_TYPE.NEW_SLG and "ui://shop/icon_tianshu_" or arg_8_2 == var_0_2.SHOP_TYPE.ROLE_SKIN and "ui://shop/icon_zhanshutaozhuang_" or arg_8_2 == var_0_2.SHOP_TYPE.PUBG and "ui://shop/icon_sihai_" or arg_8_2 == var_0_2.SHOP_TYPE.BLAZING_ARENA and "ui://shop/icon_baolie_" or arg_8_2 == var_0_2.SHOP_TYPE.SPIRE and "ui://shop/icon_mocheng_" or arg_8_2 == var_0_2.SHOP_TYPE.ELDER_BOSS and "ui://shop/icon_linjie_" or arg_8_2 == var_0_2.SHOP_TYPE.SHOP_CAR and "ui://shop/icon_kuaijiecaigou_" or arg_8_2 == var_0_2.SHOP_TYPE.OUTPOST_SHOP and "ui://shop/icon_shaotacaigou_" or arg_8_2 == var_0_2.SHOP_TYPE.DOMAIN_SHOP and "ui://shop/icon_gaojirichangben_" or arg_8_2 == var_0_2.SHOP_TYPE.ANCIENTS and "ui://shop/icon_miyucaigou_" or "ui://shop/icon_shuaxin_"
	elseif arg_8_1 == 4 then
		var_8_0 = "ui://shop/icon_shuaxin_"
	end

	return var_8_0 .. "0", var_8_0 .. "1"
end

function ShopTabCell:_onButtonStateChange()
	local var_9_0

	if not self._sub or #self._sub <= 0 then
		do return end

		var_9_0 = self._maxHeight
	end

	if self.m_buttonController:getSelectedIndex() == 0 then
		self._isSelectedSub = false
		self._selectedSubIndex = -1
		var_9_0 = self._minHeight
	end

	self:setHeight(var_9_0)

	for iter_9_0, iter_9_1 in pairs(self._subRedPointList) do
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = iter_9_1
		})
	end
end

function ShopTabCell:_onClick()
	if self._sub and #self._sub > 0 then
		if not self._isSelectedSub then
			self.m_subList:setSelectedIndex(0)
			self:_onClickSub()
		end

		return
	end

	self:dispatchCompEvent(var_0_2.SHOP_EVENT_TAB_CHANGE, self._tabParams)
end

function ShopTabCell:_onClickSub()
	if self._sub and #self._sub > 0 then
		local var_11_0 = self.m_subList:getSelectedIndex()

		if self._sub[var_11_0 + 1] and self._selectedSubIndex ~= var_11_0 then
			self._selectedSubIndex = var_11_0

			self:dispatchCompEvent(var_0_2.SHOP_EVENT_TAB_CHANGE, self._sub[var_11_0 + 1])
		end

		self._isSelectedSub = true
	end
end

return ShopTabCell
