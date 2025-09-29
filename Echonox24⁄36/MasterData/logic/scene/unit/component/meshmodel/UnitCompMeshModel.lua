-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/component/meshmodel/UnitCompMeshModel.lua

module("logic.scene.unit.component.meshmodel.UnitCompMeshModel", package.seeall)

local M = class("UnitCompMeshModel", UnitComponentBase)

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._prefabLoader = self:getPrefabLoader(unit)
	self._lookAtDirection = Vector3.New()
	self._size = Vector3.New()
	self._originalSizey = 0
	self._animationPlayer = nil
	self._isManualUpdateEnable = true
	self._url = nil
	self._curAnimState = UnitAnimState.Idle
	self._isLoop = true
	self._playSpeed = 1
	self._scale = 1
	self._goStandardRoot = false
end

function M:getPrefabLoader(unit)
	return PrefabLoader.Get(unit.go)
end

function M:onInit()
	self._mover = self._unit.mover
	self._isManualUpdateEnable = true
end

function M:setPlaySpeed(playSpeed)
	if self._playSpeed == playSpeed then
		return
	end

	self._playSpeed = playSpeed

	self:_updatePlaySpeed()
end

function M:_updatePlaySpeed()
	if not self._animationPlayer then
		return
	end

	self._animationPlayer:SetSpeed(self._playSpeed)
end

function M:getAnimState()
	return self._curAnimState
end

function M:getAnimIsLoop()
	return self._isLoop
end

function M:lookAt(x, y, z)
	local cx, cz = self._mover:getPos()

	self:lookAtDir(x - cx, 0, z - cz)
end

function M:lookAtVec3(point)
	self:lookAt(point.x, point.y, point.z)
end

function M:lookAtDir(dx, dy, dz)
	self._lookAtDirection:Set(dx, dy, dz)

	if self._animationPlayer then
		self._animationPlayer:LookAtDirection(dx, dz)
	end
end

function M:lookAtDirVec3(direction)
	self:lookAtDir(direction.x, direction.y, direction.z)
end

function M:getLookAtDir()
	return self._lookAtDirection:Get()
end

function M:getLookAtDirInVec3(point)
	point.x = self._lookAtDirection.x
	point.y = self._lookAtDirection.y
	point.z = self._lookAtDirection.z
end

function M:setBody(url)
	if self._url == url then
		return
	end

	self:clear()

	if not url then
		return
	end

	self._url = url

	self._prefabLoader:load(url, self._onBodyLoaded, self, true)
end

function M:getInst()
	return self._prefabLoader and self._prefabLoader:getInst() or nil
end

function M:getStandardRoot()
	return self._goStandardRoot
end

function M:getAnimationPlayer()
	return self._animationPlayer
end

function M:_onBodyLoaded(loader)
	local roleGo = self._prefabLoader:getInst()

	self._goStandardRoot = goutil.findChild(roleGo, "chest")
	self._animationPlayer = AnimationPlayer.Get(roleGo)
	self._animationPlayer.isManualUpdateEnable = self._isManualUpdateEnable

	self._animationPlayer:SetListener(self._onAnimationEvent, self)
	self._animationPlayer:SetMappedAnimationListener(self._getMappedAnimation, self)
	self._animationPlayer:LookAtDirection(self._lookAtDirection.x, self._lookAtDirection.z)
	self:_onBeforeDispatchMeshModelLoaded()

	local x, y, z = MeshBuilderUtils.CalculateCharacterModelSize(roleGo, 0, 0, 0)

	self._size:Set(x, math.min(3, y), z)

	self._originalSizey = y

	if self._curAnimState then
		local animState = self._curAnimState

		self:play(animState, self._isLoop, true)
		self:forceUpdate()
	end

	self:_updatePlaySpeed()
	self._unit:dispatchInnerEvent(UnitActionType.MeshModelLoaded)
	self:_onAfterDispatchMeshModelLoaded()
end

function M:_onBeforeDispatchMeshModelLoaded()
	return
end

function M:_onAfterDispatchMeshModelLoaded()
	return
end

function M:play(animState, isLoop, isForceRestart)
	if not animState then
		return
	end

	if not isForceRestart and self._isLoop and isLoop and self._curAnimState == animState then
		return
	end

	self._curAnimState = animState
	self._isLoop = isLoop or false

	self:_onPlayAnimation(animState, isLoop)

	if self._animationPlayer then
		self._animationPlayer:PlayAnimation(self._curAnimState, self._isLoop, isForceRestart)
	end
end

function M:_onPlayAnimation(animState, isLoop)
	return
end

function M:setDefaultAnim(animState)
	self._curAnimState = animState
end

function M:jumpToTime(time)
	if self._animationPlayer then
		self._animationPlayer:JumpToTime(time)
	end
end

function M:setFrozen(frozen)
	if self._animationPlayer then
		self._animationPlayer:SetFrozen(frozen)
	end
end

function M:forceUpdate()
	if self._animationPlayer then
		self._animationPlayer:Evaluate()
	end
end

function M:exchangeActivePlayable()
	if self._animationPlayer then
		self._animationPlayer:ExchangeActivePlayable()
	end
end

function M:containsAnimation(animationName)
	if self._animationPlayer then
		return self._animationPlayer:ContainsAnimation(animationName)
	end

	return false
end

function M:getAnimationDuration(animationName)
	if self._animationPlayer then
		return self._animationPlayer:GetAnimationDuration(animationName)
	end

	return 0
end

function M:getAnimationLength(animationName)
	if self._animationPlayer then
		return self._animationPlayer:GetAnimationLength(animationName)
	end
end

function M:getAnimationEffectFrameTime(name, idx)
	if self._animationPlayer then
		local frameIndexs = self._animationPlayer:GetAnimationFrameIndexs(name)
		local arrayFrameIndex = string.split(frameIndexs, "#")
		local frameIdx = arrayFrameIndex[idx]

		if not string.nilorempty(frameIdx) then
			return tonumber(frameIdx) / 30
		else
			printWarn(string.format("动作[%s]的第%s个爆点没有配置，请检查，模型路径：%s", name, idx, self._url))
		end
	end

	return 0
end

function M:getBodySize()
	return self._size
end

function M:getOriginalBodySizeY()
	return self._originalSizey
end

function M:setManualUpdateEnable(isManualUpdateEnable)
	self._isManualUpdateEnable = isManualUpdateEnable

	if self._animationPlayer then
		self._animationPlayer.isManualUpdateEnable = isManualUpdateEnable
	end
end

function M:clear()
	if self._prefabLoader then
		self._prefabLoader:clear()
	end

	self._animationPlayer = nil
	self._goStandardRoot = nil
	self._url = nil
end

function M:onDestroy()
	self._prefabLoader = nil
	self._animationPlayer = nil
	self._goStandardRoot = nil
	self._url = nil
end

function M:_onAnimationEvent(animationName)
	self._unit:dispatchInnerEvent(UnitActionType.AnimationEvent, AnimationEventName.Complete, animationName)
end

function M:_getMappedAnimation(animationName)
	return animationName
end

return M
