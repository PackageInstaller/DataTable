-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/mission/mission/AceteamMissionView.lua

module("logic.extensions.aceteam.view.mission.mission.AceteamMissionView", package.seeall)

local AceteamMissionView = class("AceteamMissionView", MissionView)

function AceteamMissionView:buildUI()
	AceteamMissionView.super.buildUI(self)
end

function AceteamMissionView:onExit()
	AceteamMissionView.super.onExit(self)
	GlobalDispatcher:removeListener(AceTeamController.AceTeamSetMatchFormRes, self._onMissionBattleResBack, self)
	GlobalDispatcher:removeListener(AceTeamController.AceTeamFightBossRes, self._onMissionBattleResBack, self)
	AceTeamModel.instance:resetFormationMo()
end

function AceteamMissionView:onEnter()
	GlobalDispatcher:addListener(AceTeamController.AceTeamFightBossRes, self._onMissionBattleResBack, self)
	GlobalDispatcher:addListener(AceTeamController.AceTeamSetMatchFormRes, self._onMissionBattleResBack, self)
	self:onEnterInherit()
	self._videoButton.gameObject:SetActive(false)
	MissionModel.instance:setForceResetOneKey(true)

	local params = self:getOpenParam()
	local creepsMasterId = params[1]
	local monsterCfg = AceTeamConfig.instance:getMonsterCfg(creepsMasterId)

	self:_setTxtDesc(monsterCfg.effectDesc)
	self:_setDescStr(monsterCfg.name)
	self:_setTitleName()
	self:setRuleDesc()
end

function AceteamMissionView:_saveFormationEx()
	return false
end

function AceteamMissionView:_onClickClose()
	AceteamMissionView.super._onClickClose(self)
end

function AceteamMissionView:_enterBattle()
	local simpleForm = self:_getCurFormation():createFormPb()

	simpleForm.formId = 0

	AceTeamController.instance:sendPM_AceTeamFightBossReq(simpleForm)
end

function AceteamMissionView:_getCurFormation()
	return AceTeamModel.instance:GetCurFormation()
end

function AceteamMissionView:_isCurFormationEmpty()
	local fmt = self:_getCurFormation()
	local empty = true

	for i = 1, 9 do
		local petId = fmt:GetPosition(i)

		if checknumber(petId) > 0 then
			empty = false

			break
		end
	end

	return empty
end

function AceteamMissionView:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	local numPos = self:_getCurFormation():getCurExistPetNumber()
	local totalPos = self:_maxPetNum()
	local petsNum = BagModel.instance:diffRacePetCount()
	local showNum = -1
	local boo = false

	if totalPos <= petsNum and numPos < totalPos then
		boo = true
		showNum = totalPos
	elseif petsNum < totalPos and petsNum > 0 and numPos < petsNum then
		boo = true
		showNum = petsNum
	end

	if showNum > 0 then
		if hasOneKey then
			TipsFacade.instance:openPopupWindowWithX(lang("tip"), string.format(lang("fight_fmt_num"), tostring(showNum)), posLimitCallback, onekeyCallBack, lang("aceteammissionview__1"), lang("aceteammissionview__2"))
		else
			TipsFacade.instance:openPopupWindow(lang("tip"), string.format(lang("fight_fmt_num"), tostring(showNum)), posLimitCallback)
		end
	end

	return boo
end

return AceteamMissionView
