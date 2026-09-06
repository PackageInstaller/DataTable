-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/round/BattleRoundBirth.lua

module("logic.extensions.battle.model.round.BattleRoundBirth", package.seeall)

local BattleRoundBirth = class("BattleRoundBirth", BattleRoundBase)

function BattleRoundBirth:ctor()
	self.roundType = BattleRoundBase.RoundBirth
end

function BattleRoundBirth:start()
	BattleRoundBirth.super.start(self)

	BattleModel.instance.isBirthing = true
	self._isOpenView = nil

	local scene = SceneMgr.instance:getCurScene()

	self._units = scene:getSortingUnits()
	self._evts = self._evts or {}

	for i, v in ipairs(self._units) do
		if v.isShowedEnterSkill == false then
			local skinCfg = PetSkinConfig.instance:getPetSkinCfg(v.modelId) or {}

			if checknumber((checknumber(skinCfg.enterSkillId))) > 0 then
				local evt = BattleEvtEnter.New()

				evt.unit = v

				table.insert(self._evts, evt)
			end
		end
	end

	if BattleController.instance.preloadModelsOnLoadScene then
		self:_openBattleStart()
	else
		self:_birthAll()
	end

	local scene = SceneMgr.instance:getScene(SceneType.Battle)

	if scene and scene.camera then
		local mainCamera = scene.camera:resetCamera()
	end
end

function BattleRoundBirth:finish()
	BattleModel.instance.isBirthing = nil

	ViewMgr.instance:close(ViewName.BattleStart)
	GlobalDispatcher:dispatch(GlobalNotify.OnBattleUnitsCreated)
	GlobalDispatcher:dispatch(GlobalNotify.BattleRoundBirthFinish)
	BattleRoundBirth.super.finish(self)

	if BattleModel.instance:isErrorCheck() then
		TipsFacade.instance:openCommonTips("精灵资源异常，自动跳过战斗")
		TipsFacade.instance:openCommonTips("精灵资源异常，自动跳过战斗")
		TipsFacade.instance:openCommonTips("精灵资源异常，自动跳过战斗")

		BattleRoundHandler.instance.passAllRounds = true
	end
end

function BattleRoundBirth:update(deltaTime)
	self:_openBattleStart()

	if not BattleController.instance.battleStartEffFinished then
		return
	end

	self._currEvt = self._currEvt or self:popEvent()

	if self._currEvt and not self._currEvt.isPause then
		if not self._currEvt.isToggled then
			self._currEvt:handleEvt()
		end

		if self._currEvt.isToggled then
			if self._currEvt.update then
				self._currEvt:update(deltaTime)
			end

			if self._currEvt:isDone() then
				self._currEvt:checkCharacterAttrs()
				self._currEvt:finish()
				self._currEvt:clear()

				self._currEvt = nil
			end
		end

		if self._currEvt and self._currEvt.errorChecker and self._currEvt:errorChecker() then
			BattleModel.instance:setErrorCheck()
		end
	end
end

function BattleRoundBirth:_openBattleStart()
	if self._isOpenView then
		return
	end

	if not self:_isBasicLoaded() then
		return
	end

	self._isOpenView = true

	print("open battle start view")
	ViewMgr.instance:open(ViewName.BattleStart)
end

function BattleRoundBirth:_doBirth(idx)
	self._currTime = 0
	self._currIndex = idx

	if self._units[idx] then
		self._lastUnit = self._units[idx]

		self._units[idx]:onBirth()
	else
		self._isDone = true
	end
end

function BattleRoundBirth:_birthAll()
	if BattleController.instance.preloadModelsOnLoadScene then
		return
	end

	for i = 1, #self._units do
		if not self._units[i].isBorn then
			self._units[i]:onBirth()
		end
	end
end

function BattleRoundBirth:_isBasicLoaded()
	for i = 1, #self._units do
		if not self._units[i].isBorn then
			return
		end
	end

	local scene = SceneMgr.instance:getCurScene()

	if not scene.resPreLoad:isLoadedFirstSkill() then
		return
	end

	return true
end

function BattleRoundBirth:isDone()
	if not BattleController.instance.battleStartEffFinished then
		return
	end

	if self._currEvt then
		if not self._currEvt:isDone() then
			return
		end

		if self._evts and #self._evts > 0 then
			return
		end
	end

	for i = 1, #self._units do
		if not self._units[i].isShowedEnterSkill then
			return
		end
	end

	if not self:_isBasicLoaded() then
		return
	end

	return true
end

return BattleRoundBirth
