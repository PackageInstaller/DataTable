-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/mission/AnheimmMissionView.lua

module("logic.extensions.timelimitedchallenge.view.mission.AnheimmMissionView", package.seeall)

local AnheimmMissionView = class("AnheimmMissionView", MissionView)

function AnheimmMissionView:unbindEvents()
	AnheimmMissionView.super.unbindEvents(self)
end

function AnheimmMissionView:bindEvents()
	AnheimmMissionView.super.bindEvents(self)
end

function AnheimmMissionView:onExit()
	AnheimmMissionView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.RefreshAnheiMMChallenge, self._onDailyReset, self)
end

function AnheimmMissionView:buildUI()
	AnheimmMissionView.super.buildUI(self)
end

function AnheimmMissionView:onEnter()
	self:onEnterInherit()
	self._videoButton.gameObject:SetActive(false)
	MissionModel.instance:setForceResetOneKey(true)

	self._fmtChanged = false

	local monsterId = AnheimmModel.instance:getCurMonsterId()

	self._monsterCfg = AnheimmConfig.instance:getChallengeCfgById(monsterId)
	self._creepCfgs = AnheimmConfig.instance:getCreepCfgsById(self._monsterCfg.creepsMasterId)

	self:_setDescStr(self._monsterCfg.name)
	self:_setTitleName()
	GlobalDispatcher:addListener(GlobalNotify.RefreshAnheiMMChallenge, self._onDailyReset, self)
end

function AnheimmMissionView:_onDailyReset()
	FloatWordMgr.instance:show("暗黑梦梦挑战已刷新")
	self:_onClickClose()
end

function AnheimmMissionView:_onClickRule()
	UIStateManager.instance:push(ViewName.AnheimmpassruleView)
end

function AnheimmMissionView:_enterBattle()
	local cfg = TimeLimitedConfig.instance:getCfgById(8)
	local funcCfg = FuncOpenConfig.instance:getFunctionOpenById(cfg.openFuncId)

	UIJumper.instance:pushOneStack(funcCfg.view, true)
	BattleFacade.instance:startAnheimm()
	MissionModel.instance:setRuleDesc(lang("击败敌阵所有精灵即可过关"), self._txtValidatorDesc.text)
	AnHeiMMChallengeAgent.instance:sendPM_AnHeiMMChallengeChallengeReq(nil, nil, function(msg, status)
		self:_setMaskBlock(false)

		if status == -15201 then
			self:_onClickClose()
		end
	end)
end

function AnheimmMissionView:_onFormationChangeFinish()
	AnheimmMissionView.super._onFormationChangeFinish(self)

	local ruleId = AnheimmModel.instance:getCurRuleId()
	local ruleCfg = AnheimmConfig.instance:getRuleCfgById(ruleId)

	print("formConditionId = " .. tostring(ruleCfg.formConditionId) .. " perfectWinId = " .. tostring(ruleCfg.perfectWinId))

	local formConditionId = checknumber(ruleCfg.formConditionId)

	if formConditionId > 0 then
		local cfg = FormationValidatorConfig.instance:getFormationValidatorCfg(formConditionId)

		if cfg then
			local isMatch = FormationValidatorController.instance:isFormationValidatorMatchOnStart(formConditionId, self:_getCurFormation(), true)

			goutil.setActive(self._topDesc.gameObject, true)
			goutil.setActive(self._txtValidatorDesc.gameObject, true)

			self._txtValidatorDesc.text = ruleCfg.missionDesc

			self._imgYes:SetActive(isMatch)
			self._imgNo:SetActive(not isMatch)
		end

		return
	end

	local perfectWinId = checknumber(ruleCfg.perfectWinId)

	if perfectWinId > 0 then
		local cfg = AnheimmConfig.instance:getPerfectWinOpCfg(perfectWinId)

		if cfg then
			local isMatch = true
			local winOpType = cfg.type

			goutil.setActive(self._topDesc.gameObject, true)
			goutil.setActive(self._txtValidatorDesc.gameObject, true)

			self._txtValidatorDesc.text = ruleCfg.missionDesc

			print("winOpType = " .. winOpType)

			if winOpType == GameEnum.BattleWinnerOpType.MyPosIdMustActive then
				isMatch = self:_isMatchMyPosIdMustActive(cfg.params)
			elseif winOpType == GameEnum.BattleWinnerOpType.MyActivePetContainsAttrs then
				isMatch = self:_isMatchMyActivePetContainsAttrs(cfg.params)
			elseif winOpType == GameEnum.BattleWinnerOpType.ActiveCount then
				isMatch = self:_isMatchActiveCount(cfg.params)
			end

			self._imgYes:SetActive(isMatch)
			self._imgNo:SetActive(not isMatch)
		end

		return
	end

	self:_initValidatorDesc()
end

function AnheimmMissionView:_isMatchActiveCount(params)
	local positions = FormationNewModel.instance:GetCurTeam():GetCurFormation():GetPositions()
	local needPetCount = checknumber(params)

	for i = 1, 9 do
		local petMo = BagPetsController.instance:getPet(positions[i])

		if petMo then
			needPetCount = needPetCount - 1
		end
	end

	return needPetCount <= 0
end

function AnheimmMissionView:_isMatchMyActivePetContainsAttrs(params)
	local positions = FormationNewModel.instance:GetCurTeam():GetCurFormation():GetPositions()
	local attrs = string.split(params, ",")
	local needPetCount = checknumber(attrs[1])

	table.remove(attrs, 1)

	for i = 1, 9 do
		local petMo = BagPetsController.instance:getPet(positions[i])

		if petMo then
			for _, v in ipairs(attrs) do
				if petMo:checkHasRace(v) then
					needPetCount = needPetCount - 1

					break
				end
			end
		end
	end

	return needPetCount <= 0
end

function AnheimmMissionView:_isMatchMyPosIdMustActive(params)
	local positions = FormationNewModel.instance:GetCurTeam():GetCurFormation():GetPositions()
	local posIds = string.splitToNumber(params, ",")

	for _, v in ipairs(posIds) do
		local petMo = BagPetsController.instance:getPet(positions[v + 1])

		if petMo == nil then
			return false
		end
	end

	return true
end

return AnheimmMissionView
