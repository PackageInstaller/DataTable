-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aixinmm/view/AixinmmMissionView.lua

module("logic.extensions.arena.view.AixinmmMissionView", package.seeall)

local AixinmmMissionView = class("AixinmmMissionView", MissionView)

function AixinmmMissionView:ctor()
	AixinmmMissionView.super.ctor(self)
end

function AixinmmMissionView:onEnter()
	self:onEnterInherit()

	local masterId = self:getFirstParam()
	local mcfg = AixinmmConfig.instance:getMonsterCfg(masterId)

	self:_setMaskBlock(false)
	self:_setDescStr(mcfg.name .. "挑战", "", lang("击败所有敌方精灵可获得胜利"))
	GlobalDispatcher:addListener(AixinmmController.PM_AiXinMMClgChallengeRes, self._onMissionBattleResBack, self)
end

function AixinmmMissionView:onExit()
	AixinmmMissionView.super.onExit(self)
	GlobalDispatcher:removeListener(AixinmmController.PM_AiXinMMClgChallengeRes, self._onMissionBattleResBack, self)
end

function AixinmmMissionView:_startNow()
	GlobalDispatcher:removeListener(GlobalNotify.FormationRefresh, self._startNow, self)
	self:_setMaskBlock(true)
	self:_setBattleResultTxtTitle()

	local masterId = self:getFirstParam()

	AiXinMMClgAgent.instance:sendPM_AiXinMMClgChallengeReq(masterId)
end

return AixinmmMissionView
