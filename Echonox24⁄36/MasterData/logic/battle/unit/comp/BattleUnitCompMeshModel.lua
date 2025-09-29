-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/BattleUnitCompMeshModel.lua

module("logic.battle.unit.comp.BattleUnitCompMeshModel", package.seeall)

local M = class("BattleUnitCompMeshModel", UnitCompMeshModel, IBattleUnitComponent)

M.QueueAnimationType = {
	AutoToDefault = 2,
	AutoToIdle = 1,
	StayLast = 4,
	LoopLast = 3
}

function M:getPrefabLoader(unit)
	return BattleUnitPrefabLoader.Get(unit.go)
end

function M:onInit()
	M.super.onInit(self)

	self._goAvatar = self._unit.mountRoot:getAvatarRoot()
	self._prefabLoader._go = self._goAvatar
	self._meshModelMover = self._unit.meshModelMover
	self._cacheModelLoader = BattleMultiResLoaderIncludeModel.New()
	self._backAnimation = false
	self._backAnimationLoop = false
	self._isProcessQueueAnimation = false
	self._animationQueue = {}
	self._hasVictimReverse = false
	self._isLowModel = false

	self:onReuse()
end

function M:onReuse()
	self._forbiddenUpdateSpeed = false

	self._size:Set(1, 1.5, 1)

	self._isLoop = true
	self._isManualUpdateEnable = true
	self._curAnimState = UnitAnimState.Idle
	self._extraSpeedRate = 1
end

function M:onReset()
	self:clear()
	self:clearQueue()
	self._cacheModelLoader:clear()
end

function M:clear()
	if self._prefabLoader then
		self._unit:dispatchInnerEvent(UnitActionType.BattleBodyClear)
	end

	self._extraSpeedRate = 1
	self._forbiddenUpdateSpeed = false
	self._scale = false

	M.super.clear(self)
end

function M:onDestroy()
	M.super.onDestroy(self)
	self._cacheModelLoader:clear()

	self._cacheModelLoader = nil
	self._goAvatar = nil
	self._bodyGo = false
	self._isLowModel = false
end

function M:onEnable()
	self:forceUpdate()
end

function M:setDefaultAnimation(animationName, isLoop)
	self._curAnimState = animationName
	self._isLoop = isLoop
end

function M:loadCacheModel(modelCO)
	local url = ModelCOUtil.getLowModelUrl(modelCO)

	if url then
		self._cacheModelLoader:clear()
		self._cacheModelLoader:addModelRes(url)
		self._cacheModelLoader:load()
	end
end

function M:setBody(url)
	if not url then
		self:clear()

		local modelCO = ModelConfig.instance:getModelConfig(self._unit.property:getModelCode())
		local x, y = ModelCOUtil.getEmptyModelSize(modelCO)

		self._size:Set(x, y, 0)
		self._unit:dispatchInnerEvent(UnitActionType.MeshModelLoaded)

		return
	end

	M.super.setBody(self, url)
end

function M:setScale(scale)
	if self._scale == scale then
		return
	end

	self._scale = scale

	local roleGo = self._prefabLoader:getInst()

	Astral.TransformUtil.SetLocalScale(roleGo.transform, scale, scale, scale)
end

function M:_onBeforeDispatchMeshModelLoaded()
	local modelId = self._unit.property:getModelCode()
	local modelCO = ModelConfig.instance:getModelConfig(modelId)

	self._isLowModel = self._url == ModelCOUtil.getLowModelUrl(modelCO)

	if self._isLowModel then
		local flagScale = modelCO.flagScale

		self:setScale(flagScale)

		local x, y, z = self._size:Get()

		self._size:Set(x * flagScale, y * flagScale, z * flagScale)
	end

	self:_beforeDispatchMeshLoaded()
end

function M:_onAfterDispatchMeshModelLoaded()
	local stateEffect = self._unit.stateEffect

	if stateEffect then
		stateEffect:refreshStateEffect()
	end
end

function M:isLowModel()
	return self._isLowModel
end

function M:hasLoadedRes()
	local res = self._prefabLoader:getRes()

	return res and res.IsSuccess
end

function M:setVictimReverse()
	self._hasVictimReverse = true

	local trans = self._unit.go.transform

	TransformUtils.SetLocalScale(trans, -trans.localScale.x, trans.localScale.y, trans.localScale.z)
end

function M:revertVictimReverse()
	if self._hasVictimReverse then
		self._hasVictimReverse = false

		local trans = self._unit.go.transform

		TransformUtils.SetLocalScale(trans, -trans.localScale.x, trans.localScale.y, trans.localScale.z)
	end
end

function M:onUpdateTimeScale(timeScale)
	if not self._forbiddenUpdateSpeed then
		self:setPlaySpeed(timeScale)
	end
end

function M:playAndAutoIdleIfExists(animationName)
	local mappedAnimation = self._unit.meshModelMover:getMappedAnimation(animationName)

	if self:containsAnimation(mappedAnimation) then
		self:playAnimationQueue(mappedAnimation, M.QueueAnimationType.AutoToIdle)

		return true
	end

	return false
end

function M:setPlaySpeed(playSpeed)
	M.super.setPlaySpeed(self, playSpeed * self._extraSpeedRate)
end

function M:setNextAnimationExtraPlaySpeed(extraSpeedRate)
	self._extraSpeedRate = extraSpeedRate
end

function M:_onPlayAnimation(animState, isLoop)
	local mappedIdle = self._unit.meshModelMover:getMappedAnimation(UnitAnimState.Idle)
	local mappedIdle1 = self._unit.meshModelMover:getMappedAnimation(UnitAnimState.Idle1)

	if (mappedIdle1 == animState or mappedIdle == animState) and isLoop then
		self:setPlaySpeed(1)

		self._forbiddenUpdateSpeed = true
	else
		self._forbiddenUpdateSpeed = false

		self:setPlaySpeed(BattleTime.timeScale)
	end

	self._extraSpeedRate = 1
end

function M:play(animState, isLoop, isForceRestart)
	if not BattleUnitUtil.canPlayAnimation(self._unit, animState) then
		return
	end

	M.super.play(self, animState, isLoop, isForceRestart)
end

function M:playAndAutoIdle(animationName)
	self:playAnimationQueue(animationName, M.QueueAnimationType.AutoToIdle)
end

function M:playAnimationQueue(animationOrList, queueAnimationType)
	self:clearQueue()

	if TypeUtil.isString(animationOrList) then
		table.insert(self._animationQueue, animationOrList)
	else
		BattleTableUtil.insertto(self._animationQueue, animationOrList)
	end

	if queueAnimationType == M.QueueAnimationType.AutoToIdle then
		self._backAnimation = UnitAnimState.Idle
		self._backAnimationLoop = true
	elseif queueAnimationType == M.QueueAnimationType.AutoToDefault then
		self._backAnimation = self._curAnimState
		self._backAnimationLoop = self._isLoop
	elseif queueAnimationType == M.QueueAnimationType.LoopLast then
		self._backAnimation = self._animationQueue[#self._animationQueue]
		self._backAnimationLoop = true
	else
		self._backAnimation = false
		self._backAnimationLoop = false
	end

	self._isProcessQueueAnimation = true

	self:_processQueueAnimation()
end

function M:_processQueueAnimation()
	if #self._animationQueue <= 0 then
		if self._backAnimation then
			local mappedAnimation = self._meshModelMover:getMappedAnimation(self._backAnimation)

			self:play(mappedAnimation, self._backAnimationLoop, true)
		end

		self._backAnimation = false
		self._backAnimationLoop = false
		self._isProcessQueueAnimation = false
	else
		local animationName = table.remove(self._animationQueue)

		self:play(animationName, false, true)
	end
end

function M:clearQueue()
	self._isProcessQueueAnimation = false
	self._backAnimation = false
	self._backAnimationLoop = false

	BattleTableUtil.clearTable(self._animationQueue)
end

function M:frozenAnimation(animationName, time)
	self:play(animationName, false, true)
	self:jumpToTime(time)
	self:setFrozen(true)
	self:forceUpdate()
end

function M:frozenAnimationToLastFrame(animationName)
	local duration = self:getAnimationDuration(animationName)

	self:frozenAnimation(animationName, duration)
end

function M:playFromTime(animationName, loop, time)
	self:play(animationName, loop)
	self:jumpToTime(time)
	self:setFrozen(false)
end

function M:mapResourceAnimation(keyAnimation, valueAnimation)
	if self._animationPlayer then
		self._animationPlayer:MapAnimation(keyAnimation, valueAnimation)
	end
end

function M:_onAnimationEvent(animationName)
	M.super._onAnimationEvent(self, animationName)

	if self._isProcessQueueAnimation then
		self:_processQueueAnimation()
	end
end

function M:_beforeDispatchMeshLoaded()
	self:_fixAnimation()

	local goInst = self:getInst()

	self._bodyGo = GameObjectUtils.FindGameObjectWithTag(goInst, SceneTag.CommonGamePlay)
end

function M:_fixAnimation()
	self._animationPlayer:FixAnimation(UnitAnimState.Idle, UnitAnimState.Idle1)
	self._animationPlayer:FixAnimation(UnitAnimState.Idle2, UnitAnimState.Idle)
	self._animationPlayer:FixAnimation(UnitAnimState.Hit2, UnitAnimState.Hit)

	local hitList = UnitAnimState.HitList

	for _, state in ipairs(hitList) do
		self._animationPlayer:FixAnimation(state, UnitAnimState.Idle2)
	end
end

function M:setVisible(state)
	goutil.setActive(self._goAvatar, state)
end

function M:getBodyGo()
	return self._bodyGo
end

function M:_getMappedAnimation(animationName)
	if not BattleUnitUtil.canPlayAnimation(self._unit, animationName) then
		return ""
	end

	return self._unit.meshModelMover:getMappedAnimation(animationName)
end

return M
