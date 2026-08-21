-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Entity\\Entity.lua

local Model = require("Entity/Model")
local EntityFactory = Framework.Entity.EntityFactory
local EntityController = Framework.Entity.EntityController
local Entity = Class("Entity")
local Const = Const
local Vector3 = Vector3
local Slot = Slot

function Entity:ctor(entityId, entityName)
	self.entityType = Const.WORLD_ENTITY_UNKNOWN
	self.id = tonumber(entityId)
	self.name = entityName
	self.logicGroup = GameFsm.getCurState().stateName
	self.controller = EntityFactory.CreateEntity(self.id, self.name, self.logicGroup)
	self.gameObject = self.controller.gameObject
	self.modelLoaded = false
	self._cachedPos = Vector3(0, 0, 0)

	self:registerCallback()
	self:initEntityComponent()
end

function Entity:isDestroyed()
	return self._isDestroyed and true or false
end

function Entity:destroy()
	self._isDestroyed = true

	self:onDeselected()
	self:revertChilds()
	self:releaseModel()
	EntityFactory.ReleaseEntity(self.id)
	self:clearCallback()

	self.controller = nil
	self.gameObject = nil
end

function Entity:registerCallback()
	self.objectSelectedCallback = Slot(self.OnEntitySelected, self)
	self.objectLongTapCallback = Slot(self.OnEntityLongTap, self)

	self.controller:RegisterDelegate(Const.ENTITY_DELEGATE_EVENT.OnObjectSelected, self.objectSelectedCallback)
	self.controller:RegisterDelegate(Const.ENTITY_DELEGATE_EVENT.OnObjectLongTap, self.objectLongTapCallback)
end

function Entity:clearCallback()
	self.controller:CancelDelegate(Const.ENTITY_DELEGATE_EVENT.OnObjectSelected)
	self.controller:CancelDelegate(Const.ENTITY_DELEGATE_EVENT.OnObjectLongTap)

	if self.objectSelectedCallback then
		self.objectSelectedCallback = nil
	end

	if self.objectLongTapCallback then
		self.objectLongTapCallback = nil
	end

	if self.enterTriggerCallback then
		self.enterTriggerCallback = nil
	end

	if self.exitTriggerCallback then
		self.exitTriggerCallback = nil
	end

	if self.modelLoadedCallback then
		self.modelLoadedCallback = nil
	end

	if self.mModelLoadedCallback then
		self.mModelLoadedCallback = nil
	end
end

function Entity:addModelLoadedDelegate(func)
	self.entityModel:addLoadedCallback(func)
end

function Entity:setEntityLayer(layerString)
	EntityFactory.SetEntityLayer(self.id, layerString)
end

function Entity:initEntityComponent()
	return
end

function Entity:getLayer()
	return Const.LAYER_UNDEFINED
end

function Entity:createModel(modelData)
	self:_createModel(modelData)
end

function Entity:_createModel(modelData)
	if not self.modelLoadedCallback then
		self.modelLoadedCallback = Slot(self.OnModelLoadedEnd, self)
	end

	if self.entityModel ~= nil then
		self.entityModel:destroy()

		self.entityModel = nil
	end

	self.modelLoaded = false

	if self.entityModel == nil and modelData then
		self.entityModel = Model(self.modelLoadedCallback, self.id)

		self.entityModel:setModelData(modelData)
		self.entityModel:loadGameObject()
	end

	return self.entityModel
end

function Entity:releaseModel()
	self:_releaseModel()
end

function Entity:_releaseModel()
	if self.entityModel then
		self.entityModel:destroy()

		self.entityModel = nil
	end

	self.controller:OnModelReleased()

	self.modelLoaded = false
end

function Entity:isModelLoaded()
	return self.modelLoaded
end

function Entity:recreateModel(modelData)
	self:createModel(modelData)
end

function Entity:OnModelLoadedEnd()
	self.controller:InitModelAfterLoaded(self.entityModel.modelGameObject)

	self.modelLoaded = true

	self.entityModel:setModelLayer(self:getLayer())
	self.entityModel:setOutline(false)

	if self.mModelLoadedCallback then
		self.mModelLoadedCallback()
	end
end

function Entity:OnEntitySelected(keepAutoNav)
	return
end

function Entity:OnEntityLongTap()
	return
end

function Entity:playAnimator(animName)
	if self.modelLoaded and self.entityModel then
		animName = self:_checkMotionChanged(animName)

		self.entityModel:playAnimation(animName, true)
	end
end

function Entity:playAnimationWithNTime(animName, normalizedTime)
	if self.modelLoaded and self.entityModel then
		animName = self:_checkMotionChanged(animName)

		self.entityModel:playAnimationWithNTime(animName, normalizedTime)
	end
end

function Entity:playAnimationWithDuration(animName, duration)
	if self.modelLoaded and self.entityModel then
		animName = self:_checkMotionChanged(animName)

		self.entityModel:playAnimationWithDuration(animName, duration)
	end
end

function Entity:setAnimSpeed(animSpeed)
	if self.modelLoaded and self.entityModel then
		self.entityModel:setAnimSpeed("speed", animSpeed)
	end
end

function Entity:getAnimatorStateInfo()
	if self.modelLoaded and self.entityModel then
		return self.entityModel:getAnimatorStateInfo()
	end
end

function Entity:changeMotion(oldStateName, newStateName)
	if not self._motionChangeDict then
		self._motionChangeDict = {}
	end

	self._motionChangeDict[oldStateName] = newStateName
end

function Entity:recoverMotion(oldStateName)
	if self._motionChangeDict then
		self._motionChangeDict[oldStateName] = nil
	end
end

function Entity:_checkMotionChanged(stateName)
	if self._motionChangeDict and self._motionChangeDict[stateName] then
		return self._motionChangeDict[stateName]
	else
		return stateName
	end
end

function Entity:setModelVisible(isVisible)
	if self.modelLoaded and self.entityModel then
		self.entityModel:setModelVisible(isVisible)
	end
end

function Entity:addMaterial(materialPath)
	if self.modelLoaded and self.entityModel then
		self.entityModel:addMaterial(materialPath)
	end
end

function Entity:delMaterial(materialPath)
	if self.modelLoaded and self.entityModel then
		self.entityModel:delMaterial(materialPath)
	end
end

function Entity:recoverMaterial(...)
	if self.modelLoaded and self.entityModel then
		self.entityModel:recoverMaterial()
	end
end

function Entity:fadeInTransparency(alpha, duration)
	if self.modelLoaded and self.entityModel then
		self.entityModel:setMaterialTransparency()
		self.entityModel:smoothSetMaterialTrans(1, alpha, duration)
	end
end

function Entity:fadeOutTransparency(alpha, duration)
	if self.modelLoaded and self.entityModel then
		if duration <= 0 then
			self:_revertTransparency()
		else
			if not self.slotOfRevertTran then
				self.slotOfRevertTran = Slot(self._revertTransparency, self)
			end

			self.entityModel:smoothSetMaterialTrans(alpha, 1, duration, self.slotOfRevertTran)
		end
	end
end

function Entity:_revertTransparency()
	if self.modelLoaded and self.entityModel then
		self.entityModel:revertMaterialTransparency()
	end
end

function Entity:modelTransform(commonModelId)
	return
end

function Entity:recoverModelTransform()
	return
end

function Entity:startAnimationOffset(clipUrl)
	if not self.animOffsetAux then
		self:addAnimationOffsetAux()
	end

	if self.animOffsetAux then
		self.animOffsetAux:StartAnimationOffset(clipUrl)
	end
end

function Entity:stopAnimationOffset()
	if self.animOffsetAux then
		self.animOffsetAux:StopAnimationOffset()
	end
end

function Entity:showNum(number, numType, stateInfo)
	if not self.topNumAux then
		self:addTopNumAux()
	end

	if self.topNumAux and numType then
		self.topNumAux:ShowNum(numType, number or 0, stateInfo)
	end
end

function Entity:addNavmeshAgent()
	if not self.controller then
		return
	end

	self.navMeshAgent = self.controller:AddNavmeshAgent()

	if not self.navMeshAgent then
		return
	end

	self.navMeshAgent.angularSpeed = 1000
	self.navMeshAgent.acceleration = 1000
	self.navMeshAgent.autoBraking = true
	self.navMeshAgent.updateRotation = false
	self.navMeshAgent.stoppingDistance = 0
end

function Entity:addBoxCollider()
	local collider = self.controller:AddBoxCollider()

	collider.center = Vector3(0, 1.5, 0)
	collider.size = Vector3(2, 3, 2)
	collider.isTrigger = true
end

function Entity:addMovementAux()
	self.movementAux = self.controller:AddMovementAux()

	if not self.movementAux then
		return
	end
end

function Entity:addTopNumAux()
	self.topNumAux = self.controller:AddTopNumAux()

	if not self.topNumAux then
		return
	end
end

function Entity:addAnimationOffsetAux()
	self.animOffsetAux = self.controller:AddAnimationOffsetAux()

	if not self.animOffsetAux then
		return
	end
end

function Entity:addChild(child, localPosition)
	if not self._childList then
		self._childList = {}
	end

	table.insert(self._childList, child)

	child.gameObject.transform.parent = self.gameObject.transform
	child.gameObject.transform.localPosition = localPosition
end

function Entity:revertChilds()
	if not self._childList then
		return
	end

	for index, child in ipairs(self._childList) do
		if not tolua.isnull(child) and child.gameObject ~= nil then
			child.gameObject.transform.parent = nil

			if child.turnOn then
				child:TurnOff()
			end
		end
	end

	self._childList = {}
end

function Entity:addSelectedEffect(controller, localPosition)
	self.selectedEffect = controller

	local controllerTransform = controller.gameObject.transform

	if controllerTransform and self.gameObject then
		controllerTransform.parent = self.gameObject.transform
		controllerTransform.localPosition = localPosition
	end
end

function Entity:onDeselected()
	if self.selectedEffect then
		local controller = self.selectedEffect

		controller.gameObject.transform.parent = nil

		if controller.turnOn then
			controller:TurnOff()
		end

		self.selectedEffect = nil
	end
end

function Entity:playSelectedEffect()
	if self.entityType then
		local selectedEffectId, selectedEffectControl = EffectManager:getSelectedEffect(self.entityType)

		if selectedEffectControl then
			self:addSelectedEffect(selectedEffectControl, Vector3(0, 0.05, 0))
			selectedEffectControl:TurnOn()
		end
	end
end

function Entity:getPositionXYZ()
	if self.controller then
		local x, y, z

		x, y, z = self.controller:GetPosition(x, y, z)

		return x, y, z
	end
end

function Entity:getPosition()
	if self.controller then
		self:getPositionByCache()

		return Vector3(self._cachedPos.x, self._cachedPos.y, self._cachedPos.z)
	end
end

function Entity:getPositionByCache()
	if self.controller then
		local x, y, z

		x, y, z = self.controller:GetPosition(x, y, z)
		self._cachedPos.x = x
		self._cachedPos.y = y
		self._cachedPos.z = z

		return self._cachedPos
	end
end

function Entity:getInteractPosArray()
	local x, y, z = self:getPositionXYZ()

	return {
		x,
		y,
		z
	}
end

function Entity:getRotation()
	if self.controller then
		local x, y, z

		x, y, z = self.controller:GetRotation(x, y, z)

		return Vector3(x, y, z)
	end
end

function Entity:getRotationXYZ()
	if self.controller then
		local x, y, z

		x, y, z = self.controller:GetRotation(x, y, z)

		return x, y, z
	end
end

function Entity:teleport(x, y, z)
	if self.controller then
		self.controller:Teleport(x, y, z)
	end
end

function Entity:teleportInTime(endPos, time, callBack)
	if self.controller then
		self.controller:TeleportInTime(endPos, time, callBack)
	end
end

function Entity:setRotate(y, x, z)
	local rotate = y or 0
	local x = 0 or x
	local z = 0 or z

	if self.controller then
		self.controller:Rotate(x, rotate, z)
	end
end

function Entity:setRotation(y, x, z)
	local x = x or 0
	local z = z or 0

	if y and self.controller then
		self.controller:SetRotation(x, y, z)
	end
end

function Entity:setFaceToPos(x, y, z)
	local x0, y0, z0 = self:getPositionXYZ()
	local dir = math.atan2(x - x0, z - z0) / math.pi * 180

	self:setRotation(dir)
end

function Entity:setVisible(visible)
	if self.controller then
		self.controller:SetVisible(visible)
	end
end

function Entity:getVisible()
	if self.controller then
		return self.controller:GetVisible()
	end

	return false
end

return Entity
