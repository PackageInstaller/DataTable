local var_0_0 = g.core.model.User.mineData
local var_0_1 = g.core.common.ServerTime
local CommonKnight = require("app.view.common.CommonKnight")
local var_0_3 = {
	[g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.JIAO_GUO] = "ui://mine/pic_qsmy_dijiaoguo",
	[g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.LIN_DONG] = "ui://mine/pic_qsmy_dilindong",
	[g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.DONG_XI] = "ui://mine/pic_qsmy_didongxi",
	[g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.LI_JIN] = "ui://mine/pic_qsmy_dilijin"
}
local var_0_4 = {
	[g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.JIAO_GUO] = "ui://mine/bg_qsmy_jiaoguo_2",
	[g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.LIN_DONG] = "ui://mine/bg_qsmy_lindong_2",
	[g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.DONG_XI] = "ui://mine/bg_qsmy_dongxi_2",
	[g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.LI_JIN] = "ui://mine/bg_qsmy_lijin_2"
}
local var_0_5 = g.core.const.ConstMgr.ShopConst.SHOP_ITEM_ID.MINE_SHIELD_ITEM
local MineShieldPop = class("MineShieldPop", require("app.fairyGUI.mine.UI_MineShieldPop"), function()
	return fgui.GComponent:create({
		pkgName = "mine",
		resName = "MineShieldPop",
		pkgPath = "ui/mine/mine"
	})
end)

function MineShieldPop:ctor()
	self:showAtCenter()
	self:initMineShieldPlayerView()
	self.m_title:setText(self.m_popPanel:getTitle())
	self.m_buyAndUseBtn:addClickListener(handler(self, self._onBuyAndUseClick))
	self.m_tipsBtn:addClickListener(handler(self, self.onClickHelpBtn))
end

function MineShieldPop:onLoad()
	self:initMineShieldPlayerView()
	self:newSchedule(handler(self, self._onUpdateCD), 1)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MINE_GETSHIELD, self._onGetShield, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self._onGetShield, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FLUSH_RED_POINT, self._onGetShield, self)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp
	})
end

function MineShieldPop:initMineShieldPlayerView()
	local var_4_0 = var_0_0:getCityObjById((var_0_0:getOwnCity())):getCfg()

	self.m_siteLoader:setURL(var_0_3[tonumber(var_4_0.camp)])
	self.m_groupLoader:setURL(var_0_4[tonumber(var_4_0.camp)])

	local var_4_1 = g.core.model.User:getAssistantDressId()

	self.m_playerComp:addChild((CommonKnight.new((g.core.common.GlobalFunc.getRoleSkinParamsBySnapShot((g.core.model.User:packUser()))))))

	self._shieldEff = self._shieldEff or self.m_shieldComp:addEffectSpine({
		isLoop = true,
		name = "eff_ui_mine_shield"
	})

	self.m_effDescTxt:setText(g.core.common.Goods:convert({
		type = g.core.common.Goods.TYPE_RESOURCE,
		value = var_0_5
	}).desc)
	self:_onUpdateCD()
	self:updateShieldBuyView()
	self:onShowByEmpty()
end

function MineShieldPop:onClickHelpBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.component.HelpPop").new({
		id = 308
	}), {
		touchDisappear = true
	})
end

function MineShieldPop:_onGetShield()
	self:updateShieldBuyView()
	g.core.module.ModuleManager:tip(g.core.lang:get(307557))
end

function MineShieldPop:updateShieldBuyView()
	if var_0_0:getCanFreeGetShieldNum() > 0 then
		self.m_hasCostController:setSelectedIndex(0)
		self.m_buyAndUseBtn:setGrayed(false)
	else
		self.m_hasCostController:setSelectedIndex(1)

		local var_7_0 = g.core.config.shop_score_info.get(g.core.config.resource_info.get(var_0_5).shop_id)

		if g.core.model.User.shopData:getBuyLimitLeft(var_7_0) > 0 then
			local var_7_1 = {
				type = var_7_0.price_type_1,
				value = var_7_0.price_value_1
			}
			local var_7_2, var_7_3, var_7_4 = g.core.model.User.shopData:getBuyItemPrice(var_7_0, 1, 1)

			var_7_1.size = var_7_2

			self.m_costComp:updateByTVS(var_7_1)
			self.m_buyAndUseBtn:setGrayed(false)
		else
			self.m_buyAndUseBtn:setGrayed(true)
		end
	end
end

function MineShieldPop:onShowByEmpty()
	if var_0_0:getCanFreeGetShieldNum() > 0 or g.core.model.User.shopData:getBuyLimitLeft((g.core.config.shop_score_info.get(g.core.config.resource_info.get(var_0_5).shop_id))) > 0 then
		return
	end

	self.m_hasCostController:setSelectedIndex(2)
	self.m_refreshTimeTxt:setText(g.core.lang:get(307556, {
		time = var_0_1:getAwardLeftTime(24, 0, 0)
	}))
end

function MineShieldPop:_onBuyAndUseClick()
	if var_0_0:getCanFreeGetShieldNum() > 0 then
		g.core.network.GameNetProxy:send_C2S_Mine_GetShield({
			is_buy = 0
		})
	else
		local var_9_0 = g.core.config.shop_score_info.get(g.core.config.resource_info.get(var_0_5).shop_id)

		if g.core.model.User.shopData:getBuyLimitLeft(var_9_0) > 0 then
			local var_9_1, var_9_2, var_9_3 = g.core.model.User.shopData:getBuyItemPrice(var_9_0, 1, 1)

			if g.core.model.User.bagData:getOwnNum(var_9_0.price_type_1, var_9_0.price_value_1) < var_9_1 then
				g.core.module.ModuleManager:tip(g.core.lang:get(408304))
			else
				g.core.network.GameNetProxy:send_C2S_Mine_GetShield({
					is_buy = 1
				})
			end
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(307555))
		end
	end
end

function MineShieldPop:_onUpdateCD()
	local var_10_0 = var_0_0:isMeHasShield()

	self.m_hasShieldController:setSelectedIndex(var_10_0 and 1 or 0)

	if var_10_0 then
		self.m_shieldTimeTxt:setText((var_0_0:getShieldLastTimeStr()))
	end

	self:onShowByEmpty()
end

function MineShieldPop:onUnload()
	self:cancelAllSchedule()
end

return MineShieldPop
