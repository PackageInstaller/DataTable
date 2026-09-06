-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantoneseopera/controller/CantoneseOperaController.lua

module("logic.extensions.cantoneseopera.controller.CantoneseOperaController", package.seeall)

local CantoneseOperaController = class("CantoneseOperaController", BaseController)

function CantoneseOperaController:ctor()
	CantoneseOperaController.super.ctor(self)
end

function CantoneseOperaController:onInit()
	self:onReset()
end

function CantoneseOperaController:onReset()
	self.curNodeId = 0
	self.hasGoTimeToday = 0
	self.userEndNum = 0
	self.hasGainPrizeNodes = {}
end

function CantoneseOperaController:getActivityId()
	return 188001
end

function CantoneseOperaController:getInfo()
	CantoneseOperaIntroduceAgent.instance:sendPM_CantoneseOperaIntroduceGetInfoReq(self:getActivityId())
end

function CantoneseOperaController:onGetInfo(msg)
	self.activityId = msg.activityId
	self.curNodeId = msg.curNodeId
	self.hasGoTimeToday = msg.hasGoTimeToday
	self.userEndNum = msg.userEndNum
	self.hasGainPrizeNodes = msg.hasGainPrizeNodes or {}

	GlobalDispatcher:dispatch(GlobalNotify.OnCantoneseOperaInfo)
end

function CantoneseOperaController:moveNext()
	if self.hasGoTimeToday > 0 then
		TipsFacade.instance:openCommonTips(lang("明天再来继续探索吧~"))
	else
		CantoneseOperaIntroduceAgent.instance:sendPM_CantoneseOperaIntroduceGoReq(self:getActivityId())
	end
end

function CantoneseOperaController:onMoveNext(msg)
	self.activityId = msg.activityId
	self.curNodeId = msg.curNodeId
	self.hasGoTimeToday = self.hasGoTimeToday + 1

	GlobalDispatcher:dispatch(GlobalNotify.OnCantoneseOperaMove)
end

function CantoneseOperaController:checkHasGetPrize(prizeNodeId)
	return (table.indexof(self.hasGainPrizeNodes or {}, prizeNodeId))
end

function CantoneseOperaController:sendGainPrize(prizeNodeId)
	local hasGet = table.indexof(self.hasGainPrizeNodes or {}, prizeNodeId)

	if not hasGet then
		CantoneseOperaIntroduceAgent.instance:sendPM_CantoneseOperaIntroduceGainPrizeReq(self:getActivityId(), prizeNodeId)
	end

	return hasGet
end

function CantoneseOperaController:onGetPrize(msg)
	self.activityId = msg.activityId
	self.userEndNum = msg.userEndNum

	local prizeNodeId = msg.prizeNodeId

	self.hasGainPrizeNodes = self.hasGainPrizeNodes or {}

	table.insert(self.hasGainPrizeNodes, prizeNodeId)

	local infoCfg = CantoneseOperaConfig.instance:getActivityCfg(self.activityId) or {}
	local planCfg = CantoneseOperaConfig.instance:getPlanCfg(infoCfg.planId, prizeNodeId) or {}

	if checknumber(planCfg.isLast) == 1 then
		UIStateManager.instance:push(ViewName.CantoneseoperapopView, prizeNodeId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnCantoneseOperaInfo)
end

CantoneseOperaController.instance = CantoneseOperaController.New()

return CantoneseOperaController
