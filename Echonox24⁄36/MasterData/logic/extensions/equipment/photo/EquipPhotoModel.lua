-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/photo/EquipPhotoModel.lua

module("logic.extensions.equipment.photo.EquipPhotoModel", package.seeall)

local M = class("EquipPhotoModel", PhotoModel)
local ROTATE_DELTA_Y = 1
local Initial_Angle = 180
local Rotate_Area = 40
local Drag_Area = 20
local Drag_Back_Speed = 6
local Deceleration_Zone = 15
local Limit_rate = 0.05

function M:ctor(container)
	M.super.ctor(self, container)

	self._attachEffectHandler = Handler.New()
end

function M:clear()
	self:_clearTimer()
	M.super.clear(self)
end

function M:attachEffect(index, resPath, aniName, loop)
	local attachName = "pos" .. index

	getres(resPath, function(res)
		if res.IsSuccess then
			res:Retain()
			table.insert(self._resDict, res)

			if self._modelGo then
				local inst = goutil.clone(res:GetMainAsset())
				local parentGo = goutil.findChild(self._modelGo, attachName)

				if parentGo then
					goutil.addChildToParent(inst, parentGo)
					self._attachEffectHandler:call(inst, aniName, loop, index)
				end
			end
		end
	end, nil)
end

function M:getTransform()
	if not self._modelGo then
		return
	end

	return self._modelGo.transform
end

function M:setLocalScale(scaleFactor)
	TransformUtils.SetLocalScale(self._modelGo.transform, scaleFactor, scaleFactor, scaleFactor)
end

function M:setTargetPos(x, y, z)
	if not self._modelGo then
		return
	end

	Astral.TransformUtil.SetLocalPos(self._modelGo.transform, x, y, z)
end

function M:setAttachRotation(index, x, y, z)
	local attachName = "pos" .. index

	M.super.clearAttachEffect(self, attachName, x, y, z)
end

function M:setAttachPosition(index, x, y, z)
	local attachName = "pos" .. index

	M.super.setAttachPosition(self, attachName, x, y, z)
end

function M:clearAttachEffect(index)
	local attachName = "pos" .. index

	if not self._modelGo then
		return
	end

	local parentGo = goutil.findChild(self._modelGo, attachName)

	if parentGo then
		local trs = parentGo.transform
		local count = trs.childCount

		for i = count, 1, -1 do
			local child = trs:GetChild(i - 1).gameObject
			local matcher = string.match(child.name, "empty_battle_")

			if not matcher then
				UnityEngine.GameObject.Destroy(child.gameObject)
			end
		end
	end
end

function M:playerComposeEffect()
	return
end

function M:_onLoaded(res)
	if res.IsSuccess then
		res:Retain()
		table.insert(self._resDict, res)

		local inst = goutil.clone(res:GetMainAsset())

		self._modelGo = inst
		self._animationPlayer = AnimationPlayer.Get(self._modelGo)

		self._photo:ShowTarget(inst, true)

		self._emptyGos = {}

		table.insert(self._emptyGos, goutil.findChild(self._modelGo, "pos1/empty_battle_01"))
		table.insert(self._emptyGos, goutil.findChild(self._modelGo, "pos2/empty_battle_02"))
		table.insert(self._emptyGos, goutil.findChild(self._modelGo, "pos3/empty_battle_03"))

		for i = 1, 3 do
			goutil.setActive(self._emptyGos[i], false)
		end

		self._modelLoadedHandler:call(inst, res)
	elseif self._backupResPath ~= nil then
		printError("加载失败尝试加载备份", self._backupResPath)
		self:updateRes(self._backupResPath)
	end
end

function M:showEmptyGo(index, isShow)
	if self._emptyGos[index] then
		goutil.setActive(self._emptyGos[index], isShow)
	end
end

function M:getEmptyInst(index)
	return self._emptyGos[index]
end

function M:setEmptyPos(Config)
	for index = 1, EquipEnum.MaxPartType do
		local vec = Config and Config[index] or Vector3.New(0, 0, 0)

		Astral.TransformUtil.SetLocalPos(self._emptyGos[index].transform, vec.x, vec.y, vec.z)
	end
end

function M:getModelGo()
	return self._modelGo
end

function M:setCameraPostProcessing(isOpen)
	M.super.setCameraPostProcessing(self, isOpen, SceneLayer.UI3D_Value)
end

function M:hideEquip(index, hide)
	if not self._modelGo then
		return
	end

	local pos = goutil.findChild(self._modelGo, "pos" .. index)

	goutil.setActive(pos, not hide)
end

function M:getAniPlayer(index)
	if not self._modelGo then
		return
	end

	local parentGo = goutil.findChild(self._modelGo, "pos" .. index)

	if parentGo then
		local trs = parentGo.transform
		local count = trs.childCount

		for i = count, 1, -1 do
			local child = trs:GetChild(i - 1).gameObject
			local matcher = string.match(child.name, "empty_battle_")

			if not matcher then
				return AnimationPlayer.Get(child)
			end
		end
	end

	return false
end

function M:getEquipInst(index)
	if not self._modelGo then
		return
	end

	local parentGo = goutil.findChild(self._modelGo, "pos" .. index)

	if parentGo then
		local trs = parentGo.transform
		local count = trs.childCount

		for i = count, 1, -1 do
			local child = trs:GetChild(i - 1).gameObject
			local matcher = string.match(child.name, "empty_battle_")

			if not matcher then
				return child
			end
		end
	end

	return false
end

function M:showEquip(index)
	if not self._modelGo then
		return
	end

	goutil.setActive(goutil.findChild(self._modelGo, "pos" .. index), true)
end

function M:setAttachEffectCallback(callback, callbackObj)
	self._attachEffectHandler:setListener(callback, callbackObj)
end

function M:setNeedAutoRotate(isNeed, startNow)
	self._rotateWithDrag = false

	M.super.setNeedAutoRotate(self, isNeed, startNow)
end

function M:_doAutoRotation()
	local rotaY = 0

	if self._rotateWithDrag then
		rotaY = self:_checkDragAutoAngle()
	else
		rotaY = self:_checkAutoAngle()
	end

	self:setTargetRotationY(rotaY)
end

function M:_checkAutoAngle()
	local _, rotaY, _ = self:getTargetRotation()

	if rotaY <= Initial_Angle - Rotate_Area then
		rotaY = Initial_Angle - Rotate_Area + 1
		self._turnLeft = true
	elseif rotaY >= Initial_Angle + Rotate_Area then
		rotaY = Initial_Angle + Rotate_Area - 1
		self._turnLeft = false
	elseif self._turnLeft then
		rotaY = rotaY + ROTATE_DELTA_Y * self:_getLeftSpeedRate(rotaY)
	else
		rotaY = rotaY - ROTATE_DELTA_Y * self:_getRightSpeedRate(rotaY)
	end

	return rotaY
end

function M:_getLeftSpeedRate(rotaY)
	if rotaY < Initial_Angle + Rotate_Area - Deceleration_Zone then
		return 1
	end

	local dis = Initial_Angle + Rotate_Area - rotaY
	local rate = dis / Deceleration_Zone

	if rate < Limit_rate then
		self._turnLeft = false
	end

	return rate
end

function M:_getRightSpeedRate(rotaY)
	if rotaY > Initial_Angle - Rotate_Area + Deceleration_Zone then
		return 1
	end

	local dis = rotaY + Rotate_Area - Initial_Angle
	local rate = dis / Deceleration_Zone

	if rate < Limit_rate then
		self._turnLeft = true
	end

	return rate
end

function M:setTargetRotationY(rotationY)
	rotationY = Mathf.Clamp(rotationY, Initial_Angle - Rotate_Area, Initial_Angle + Rotate_Area)

	M.super.setTargetRotationY(self, rotationY)
end

function M:setDragRotationY(rotationY, drag)
	self:_clearTimer()

	local newRotationY = rotationY + drag

	self._rotateWithDrag = false

	if newRotationY < Initial_Angle - Rotate_Area then
		if drag < 0 then
			drag = drag / (2 + (Initial_Angle - Rotate_Area - newRotationY))
		end

		newRotationY = rotationY + drag
		self._rotateWithDrag = true
	elseif newRotationY > Initial_Angle + Rotate_Area then
		if drag > 0 then
			drag = drag / (2 + (newRotationY - Initial_Angle - Rotate_Area))
		end

		newRotationY = rotationY + drag
		self._rotateWithDrag = true
	end

	newRotationY = Mathf.Clamp(newRotationY, Initial_Angle - Rotate_Area - Drag_Area, Initial_Angle + Rotate_Area + Drag_Area)

	M.super.setTargetRotationY(self, newRotationY)
end

function M:_checkDragAutoAngle()
	local _, rotaY, _ = self:getTargetRotation()

	if rotaY >= Initial_Angle - Rotate_Area and rotaY <= Initial_Angle + Rotate_Area then
		self._rotateWithDrag = false
	elseif rotaY < Initial_Angle - Rotate_Area then
		if rotaY < Initial_Angle - Rotate_Area - Drag_Area then
			rotaY = Initial_Angle - Rotate_Area - Drag_Area + 1
		end

		self._turnLeft = true
	elseif rotaY > Initial_Angle + Rotate_Area then
		if rotaY >= Initial_Angle + Rotate_Area + Drag_Area then
			rotaY = Initial_Angle + Rotate_Area + Drag_Area - 1
		end

		self._turnLeft = false
	elseif self._turnLeft then
		rotaY = rotaY + Drag_Back_Speed
	else
		rotaY = rotaY - Drag_Back_Speed
	end

	return rotaY
end

function M:_clearTimer()
	removetimer(self._restartAutoRota, self)
end

function M:_restartAutoRota()
	return
end

function M:checkStopAuto()
	return self._rotateWithDrag
end

function M:OnDestroy()
	M.super.OnDestroy(self)

	self._attachEffectHandler = nil
end

return M
