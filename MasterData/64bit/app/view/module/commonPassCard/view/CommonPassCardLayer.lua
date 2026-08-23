local var_0_0 = g.core.event.enum
local var_0_1 = g.core.event.EventManager
local DrawKnight = require("app.view.common.DrawKnight")
local var_0_3 = g.core.const.ConstMgr.SpineConst
local var_0_4 = g.core.model.User.commonPassCardDataMgr
local CommonPassCardLayer = class("CommonPassCardLayer", require("app.fairyGUI.commonPassCard.UI_CommonPassCardLayer"), function()
	return fgui.GComponent:create({
		pkgName = "commonPassCard",
		isFullScreen = true,
		pkgPath = "ui/commonPassCard/commonPassCard",
		resName = "CommonPassCardLayer"
	}, ...)
end)

function CommonPassCardLayer:ctor(arg_2_1)
	self:addBg("bg/newPassCard/bg_newpass_main.jpg")

	self._actId = arg_2_1.activityId

	self:updatePassCardView()
	self.m_seasonComp:updateSeasonInfo(self._actId)
	self:initPicView()
	self.m_enterTransition:play()
end

function CommonPassCardLayer:onLoad()
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_COMMON_PASSCARD_GETINFO, handler(self, self.updatePassCardView), self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_COMMON_PASSCARD_UPDATELEVEL, handler(self, self.updatePassCardView), self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_COMMON_PASSCARD_LEVELAWARD, handler(self, self.onLevelAward), self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_COMMON_PASSCARD_BUYLEVEL, handler(self, self.onBuyLevelAward), self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_COMMON_PASSCARD_TASKAWARD, handler(self, self.onTaskAward), self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_RECHARGE_OPRECHARGE, handler(self, self.onRecharge), self)
	var_0_1:addEventListener(var_0_0.EVENT_CROSS_DAY_NOTIFY, self._onCrossDay, self)
	g.core.network.GameNetProxy:send_C2S_CommonPasscard_GetInfo({
		id = self._actId
	})
end

function CommonPassCardLayer:_onCrossDay()
	self._commonPassCardData = var_0_4:getPassCardData(self._actId)

	if self._commonPassCardData:isInOpenTime() then
		g.core.network.GameNetProxy:send_C2S_CommonPasscard_GetInfo({
			id = self._actId
		})
	else
		g.core.module.ModuleManager:popAllPopup()
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function CommonPassCardLayer:updatePassCardView()
	self.m_contentComp:updatePassCardComp(self._actId)
	self.m_lvComp:updatePassCardLvComp(self._actId)
end

function CommonPassCardLayer:onRecharge(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	g.core.module.ModuleManager:awardSummary(arg_6_4.awards)
	self:updatePassCardView()
end

function CommonPassCardLayer:onLevelAward(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	g.core.module.ModuleManager:awardSummary(arg_7_4.awards)
	self:updatePassCardView()
end

function CommonPassCardLayer:onBuyLevelAward(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	g.core.module.ModuleManager:tip(g.core.lang:get(422502))
	self:updatePassCardView()
end

function CommonPassCardLayer:onTaskAward(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	g.core.module.ModuleManager:awardSummary(arg_9_4.awards)
	self:updatePassCardView()
end

function CommonPassCardLayer:initPicView()
	self._commonPassCardData = var_0_4:getPassCardData(self._actId)

	local var_10_0 = self._commonPassCardData:getActivityCfg()
	local var_10_1 = g.core.config.knight_base_info.get(var_10_0.show)

	self._knightSpine = DrawKnight.new({
		isAlphaNode = true,
		scale = 1,
		isShowBg = false,
		resId = var_10_1.painted_id
	})

	self._knightSpine:setAlphaRect(var_0_3.MASK_TYPE.HORIZON, cc.rect(-250, 0, 400, 0), 250)
	self.m_knightComp:addChild(self._knightSpine)
	self.m_detailBtn1:setTitle(var_10_1.name)

	local var_10_2 = g.core.config.artifact_info.get(var_10_0.show_2)

	self.m_artifactLoader:setIcon(g.core.common.Path:getArtifactPic(var_10_2.res_id))
	self.m_detailBtn2:setTitle(var_10_2.name)

	self._knightCfg = var_10_1
	self._artifactCfg = var_10_2

	self.m_detailBtn1:addClickListener(handler(self, self._onKnightDetail))
	self.m_detailBtn2:addClickListener(handler(self, self._onArtifactDetail))
	self.m_topBarComp:setResInfoById(var_10_0.interface)
	self.m_topBarComp:setTitle(g.core.config.function_info.get(var_10_0.function_id).name)
end

function CommonPassCardLayer:_onKnightDetail()
	if self._knightCfg then
		g.core.common.GlobalFunc.pushInfoPop((g.core.common.Goods:convert({
			type = g.core.common.Goods.TYPE_KNIGHT,
			value = self._knightCfg.id
		})))
	end
end

function CommonPassCardLayer:_onArtifactDetail()
	if self._artifactCfg then
		g.core.common.GlobalFunc.pushInfoPop((g.core.common.Goods:convert({
			type = g.core.common.Goods.TYPE_ARTIFACT,
			value = self._artifactCfg.id
		})))
	end
end

return CommonPassCardLayer
