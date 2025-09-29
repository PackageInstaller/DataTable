-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewcalculate/BattleCalculateExpProgress.lua

module("logic.extensions.battle.viewcalculate.BattleCalculateExpProgress", package.seeall)

local M = class("BattleCalculateExpProgress")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
	self.LevelUpDuration = 1.2
	self._tweenIdExp = 0

	self:buildUI()
	self:bindEvents()
end

function M:OnDisable()
	self:destroyUI()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()

	self.mainGO = false
end

function M:buildUI()
	self._tweenIdExp = nil
	self._imgExpProgress = self.mainGO:GetComponent(UIComponentType.Image)
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:destroyUI()
	if self._tweenIdExp and self._tweenIdExp > 0 then
		TweenUtil.killTween(self._tweenIdExp)
	end

	self._tweenIdExp = false
end

function M:setCharacterParam(characterParam, callback, handle)
	if not characterParam then
		return
	end

	self._addExpFinish = callback
	self._addExpFinishHandle = handle
	self._characterParam = characterParam

	local beginProgress, endProgress = self:_calcuClampProgress()

	self:_playIncrExpMovie(beginProgress, endProgress)
	self:_playIncrLevelMovie(self._characterParam.oldLevel, self._characterParam.newLevel)
end

function M:_playIncrExpMovie(beginValue, endValue, levelDuration)
	local listener
	local propgress = 0

	function listener(value, isFinish)
		if not self._tweenIdExp then
			return
		end

		propgress = value % 1

		if value ~= 0 and propgress == 0 then
			propgress = 1
		end

		self._imgExpProgress.fillAmount = propgress

		if isFinish then
			if endValue % 1 == 0 then
				self._imgExpProgress.fillAmount = 0
			end

			if self._addExpFinish then
				self._addExpFinish(self._addExpFinishHandle)
			end
		end
	end

	levelDuration = levelDuration or self.LevelUpDuration
	self._tweenIdExp = TweenUtil.tweenNumber(listener, nil, beginValue, endValue, levelDuration)
end

function M:_calcuClampProgress()
	local characterParam = self._characterParam

	if CharacterExpConfig.instance:isMaxLevel(characterParam.oldLevel) then
		return 1, 1
	end

	local oldProgress = false
	local newProgress = false

	if characterParam.quality then
		oldProgress = CharacterExpConfig.instance:calcLevelProgress(characterParam.oldLevel, characterParam.quality, characterParam.oldExp)
		newProgress = CharacterExpConfig.instance:calcLevelProgress(characterParam.newLevel, characterParam.quality, characterParam.newExp)
	else
		oldProgress = PlayerConfig.instance:calcLevelProgress(characterParam.oldLevel, characterParam.oldExp)
		newProgress = PlayerConfig.instance:calcLevelProgress(characterParam.newLevel, characterParam.newExp)
	end

	local clampProgress = characterParam.newLevel - characterParam.oldLevel

	clampProgress = clampProgress + newProgress

	return oldProgress, clampProgress
end

function M:_playIncrLevelMovie(beginValue, endValue)
	if endValue <= beginValue then
		return
	end

	self:_playLevelUpEffect()
end

function M:_playLevelUpEffect()
	local levelDuration = 0.3

	self:_playIncrExpMovie(0, 1, levelDuration)
end

function M:_showUpgradeLevelFinish()
	return
end

return M
