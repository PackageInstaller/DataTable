local var_0_0 = g.core.event.enum
local var_0_1 = g.core.event.EventManager
local DrawKnight = require("app.view.common.DrawKnight")
local var_0_3 = g.core.const.ConstMgr.SpineConst
local var_0_4 = g.core.model.User.gmPassCardData
local PassCardNewLayer = class("PassCardNewLayer", require("app.fairyGUI.newPassCard.UI_PassCardNewLayer"), function()
	return fgui.GComponent:create({
		pkgName = "newPassCard",
		isFullScreen = true,
		pkgPath = "ui/newPassCard/newPassCard",
		resName = "PassCardNewLayer"
	}, ...)
end)

function PassCardNewLayer:ctor()
	self:addBg("bg/newPassCard/bg_newpass_main.jpg")
	self:updatePassCardView()
	self.m_seasonComp:updateSeasonInfo()
	self:initPicView()
	self.m_enterTransition:play()
end

function PassCardNewLayer:onLoad()
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_PASSCARD_ACTIVITY_GETINFO, handler(self, self.updatePassCardView), self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_PASSCARD_ACTIVITY_UPDATE, handler(self, self.updatePassCardView), self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_PASSCARD_ACTIVITY_LEVELAWARD, handler(self, self.onLevelAward), self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_PASSCARD_ACTIVITY_BUYLEVEL, handler(self, self.onBuyLevelAward), self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_PASSCARD_ACTIVITY_TASKAWARD, handler(self, self.onTaskAward), self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_RECHARGE_OPRECHARGE, handler(self, self.onRecharge), self)
	var_0_1:addEventListener(var_0_0.EVENT_CROSS_DAY_NOTIFY, self._onCrossDay, self)
	g.core.network.GameNetProxy:send_C2S_PasscardActivity_GetInfo({})
end

function PassCardNewLayer:_onCrossDay()
	if var_0_4:isInOpenTime() then
		g.core.network.GameNetProxy:send_C2S_PasscardActivity_GetInfo({})
	else
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function PassCardNewLayer:updatePassCardView()
	self.m_contentComp:updatePassCardComp()
	self.m_lvComp:updatePassCardLvComp()
end

function PassCardNewLayer:onRecharge(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	g.core.module.ModuleManager:awardSummary(arg_6_4.awards)
	self:updatePassCardView()
end

function PassCardNewLayer:onLevelAward(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	g.core.module.ModuleManager:awardSummary(arg_7_4.awards)
	self:updatePassCardView()
end

function PassCardNewLayer:onBuyLevelAward(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	g.core.module.ModuleManager:tip(g.core.lang:get(422502))
	self:updatePassCardView()
end

function PassCardNewLayer:onTaskAward(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	g.core.module.ModuleManager:awardSummary(arg_9_4.awards)
	self:updatePassCardView()
end

function PassCardNewLayer:initPicView()
	local var_10_0 = var_0_4:getActivityCfg()
	local var_10_1 = var_10_0.show_2
	local var_10_2 = g.core.config.knight_base_info.get(var_10_0.show)

	self._knightSpine = DrawKnight.new({
		isAlphaNode = true,
		scale = 1,
		isShowBg = false,
		resId = var_10_2.painted_id
	})

	self._knightSpine:setAlphaRect(var_0_3.MASK_TYPE.HORIZON, cc.rect(-250, 0, 400, 0), 250)
	self.m_knightComp:addChild(self._knightSpine)
	self.m_isHighController:setSelectedIndex(var_10_0.id >= 8 and 1 or 0)
	self.m_knightComp:setScale(var_10_0.knight_scale_1 / 1000)
	self.m_detailBtn1:setTitle(var_10_2.name)

	local var_10_3 = g.core.config.artifact_info.get(var_10_1)

	self.m_artifactLoader:setIcon(g.core.common.Path:getArtifactPic(var_10_3.res_id))
	self.m_artifactLoader:setScale(var_10_0.knight_scale_2 / 1000)
	self.m_detailBtn2:setTitle(var_10_3.name)

	self._knightCfg = var_10_2
	self._artifactCfg = var_10_3

	self.m_detailBtn1:addClickListener(handler(self, self._onKnightDetail))
	self.m_detailBtn2:addClickListener(handler(self, self._onArtifactDetail))
end

function PassCardNewLayer:_onKnightDetail()
	if self._knightCfg then
		g.core.common.GlobalFunc.pushInfoPop((g.core.common.Goods:convert({
			type = g.core.common.Goods.TYPE_KNIGHT,
			value = self._knightCfg.id
		})))
	end
end

function PassCardNewLayer:_onArtifactDetail()
	if self._artifactCfg then
		g.core.common.GlobalFunc.pushInfoPop((g.core.common.Goods:convert({
			type = g.core.common.Goods.TYPE_ARTIFACT,
			value = self._artifactCfg.id
		})))
	end
end

return PassCardNewLayer
