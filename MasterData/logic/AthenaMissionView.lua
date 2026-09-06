-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/athena/AthenaMissionView.lua

module("logic.extensions.timelimitedchallenge.view.athena.AthenaMissionView", package.seeall)

local AthenaMissionView = class("AthenaMissionView", MissionView)

function AthenaMissionView:onEnter()
	local openParam = self:getOpenParam()

	self._challengeId, self._stageCfg, self._supportPlan = openParam[1], openParam[2], openParam[3]

	self:onEnterInherit()
	MissionModel.instance:setForceResetOneKey(true)

	self._titleTxt.text = self._stageCfg.name
	self._descTxt.text = self._stageCfg.WinDesc

	self:_setMaskBlock(false)

	self._fmtChanged = false

	self._videoButton.gameObject:SetActive(false)
	goutil.setActive(self._btnOneKey.gameObject, not self._supportPlan)
	goutil.setActive(self._btnClean.gameObject, false)
	goutil.setActive(self._txtValidatorDesc.gameObject, false)
	self:_setTxtDesc(self._stageCfg.missionCondition)
end

function AthenaMissionView:onExit()
	AthenaMissionView.super.onExit(self)
end

function AthenaMissionView:_setTitleName()
	self._titleTxt.text = string.nilorempty(self._titleStr) and self._levelStr or self._titleStr .. " " .. self._levelStr
end

function AthenaMissionView:_onClickStart()
	if self._supportPlan then
		if EscortModel.instance:IsPickupEscort() and self._viewPresentor.viewName ~= ViewName.EscortMission then
			FloatWordMgr.instance:show("护送期间不能进行其他战斗!")

			return
		end

		if not self:_isFormationValidatorMatchOnStart() then
			return
		end

		local hasOneKey = GameUtil.GetActive(self._btnOneKey)

		if self:_isCurFormationEmpty() then
			if hasOneKey then
				TipsFacade.instance:openPopupWindowWithX(lang("tip"), lang("fight_unformation"), function()
					return
				end, function()
					self:_onClickOneKey()
				end, lang("fight_goto_fmt"), lang("一键布阵"))
			else
				TipsFacade.instance:openTipWindow(lang("tip"), lang("fight_unformation"), nil, lang("fight_goto_fmt"))
			end

			return
		end

		if self:needCheckNumLimit() and self:checkFormationEmptyAndPosNumLimit(function()
			self:_startClg()
		end, hasOneKey, function()
			self:_onClickOneKey()
		end) then
			return
		end

		self:_startClg()
	else
		AthenaMissionView.super._onClickStart(self)
	end
end

function AthenaMissionView:_enterBattle()
	if self._supportPlan then
		local formInfo = AthenaModel.instance:getWitFormation(self._challengeId)
		local simpleForm = formInfo:createFormPb()

		BattleModel.instance:setEndDialogId(self._stageCfg.winDialogId)
		AthenaModel.instance:setBattleType(self._challengeId, 1)
		WaterLightHeroTowerAgent.instance:sendPM_WaterLightHeroTowerWisdomChallengeReq(self._challengeId, simpleForm)
	else
		AthenaModel.instance:setBattleType(self._challengeId, 2)

		if not FormationController.instance:SaveFormationEx(function()
			if self._supportPlan then
				BattleFacade.instance:startTimeLimitedChallenge()
			end

			WaterLightHeroTowerAgent.instance:sendPM_WaterLightHeroTowerPowerChallengeReq(self._challengeId)
		end) then
			if self._supportPlan then
				BattleFacade.instance:startTimeLimitedChallenge()
			end

			WaterLightHeroTowerAgent.instance:sendPM_WaterLightHeroTowerPowerChallengeReq(self._challengeId)
		end
	end

	UIJumper.instance:pushOneStack(self:_getMainView(), true)
end

function AthenaMissionView:checkFormationEmptyAndPosNumLimit(callback, hasOneKey, onekeyCallBack)
	if self._supportPlan then
		local formation = AthenaModel.instance:getWitFormation(self._challengeId)
		local empty = not formation

		for i = 1, 9 do
			local pos = formation:GetPosition(i)

			if not pos then
				empty = true
			end

			if pos > 0 then
				empty = false
			end
		end

		if empty then
			TipsFacade.instance:openTipWindow(lang("tip"), lang("fight_unformation"), function()
				return
			end, lang("fight_goto_fmt"))
		end

		return empty
	else
		return AthenaMissionView.super.checkFormationEmptyAndPosNumLimit(self, callback, hasOneKey, onekeyCallBack)
	end
end

function AthenaMissionView:_getMainView()
	return ViewName.AthenaMainView
end

function AthenaMissionView:_getCurFormation()
	if self._supportPlan then
		return AthenaModel.instance:getWitFormation(self._challengeId)
	else
		return AthenaMissionView.super._getCurFormation(self)
	end
end

return AthenaMissionView
