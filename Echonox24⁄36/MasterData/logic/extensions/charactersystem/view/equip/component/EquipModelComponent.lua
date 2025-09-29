-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/component/EquipModelComponent.lua

module("logic.extensions.charactersystem.view.equip.component.EquipModelComponent", package.seeall)

local M = class("EquipModelComponent")
local YShadowPos = {
	220,
	340,
	370
}

function M:ctor(imageContainer)
	self._compContainer = imageContainer
	self._equipModel = Astral.LuaComponentContainer.Add(imageContainer.gameObject, EquipPhotoModel)

	self._equipModel:setModelLoadCallback(self._onModelLoaded, self)
	self._equipModel:setAttachEffectCallback(self._onAttachEffect, self)
	self._equipModel:updateRes(ResName.Equip_model, nil, UnityEngine.RenderTextureFormat.ARGBHalf)
	self._equipModel:setCameraPostProcessing(true, SceneLayer.UI3D_Value)
	self._equipModel:setCameraCullingLayer(SceneLayer.UI3D_Value)
	self._equipModel:setCameraTag("RTCamera")

	self._materialSetter = goutil.addComponentOnce(imageContainer.gameObject, typeof(UIReflectionMaterialSetter))
end

function M:setModelPos(pos)
	self._posInfo = pos
end

function M:refreshView()
	if not self._equipMo then
		return
	end

	local part = self._equipMo:getPart()
	local index = EquipEnum.PartTypeList2Index[part]
	local attachPointPos = self._posInfo[index].attachPointPos

	self._equipModel:setAttachPosition(index, attachPointPos.x, attachPointPos.y, attachPointPos.z)

	local attachPointRotation = self._posInfo[index].attachPointRotation

	self._equipModel:setAttachRotation(index, attachPointRotation.x, attachPointRotation.y, attachPointRotation.z)

	local cameraPos = self._posInfo[index].cameraPos

	self._equipModel:setCameraPosition(cameraPos.x, cameraPos.y, cameraPos.z)
	self._equipModel:setRotation(0, 0, 0)
	self._equipModel:clearAttachEffect(index)
	self._equipModel:attachEffect(index, GameUrl.getEquipMeshModelUrl(self._equipMo:getModelId()))

	local targetPos = self._posInfo[index].targetPos

	self._equipModel:setTargetPos(targetPos.x, targetPos.y, targetPos.z)
	self._equipModel:setTargetRotationY(180)
	VolumeMgr.instance:setPosition(VolumeName.UIJiaoshiqi, self._equipModel:getCameraPosition())

	self._materialSetter.YOffset = YShadowPos[index]
end

function M:onEnter()
	LightMgr.instance:turnOn(LightName.UIEquip)
	VolumeMgr.instance:turnOn(VolumeName.UIJiaoshiqi)
end

function M:onExit()
	LightMgr.instance:turnOff(LightName.UIEquip)
	VolumeMgr.instance:turnOff(VolumeName.UIJiaoshiqi)
end

function M:_onModelLoaded()
	self:refreshView()
end

function M:_clickEquipModel()
	return
end

function M:setEquipData(mo)
	self._equipMo = mo
end

function M:_beginDragEquipModel(posX, posY, pointerId)
	self._beginX = posX
end

function M:_onDragEquipModel(posX, posY, pointerId)
	local deltaX = posX - self._beginX
	local _, rotaY, _ = self._equipModel:getTargetRotation()

	self._equipModel:setDragRotationY(rotaY, -deltaX)

	self._beginX = posX
end

function M:_endDragEquipModel()
	if not self._equipModel:checkStopAuto() then
		settimer(3, self._restartAutoRota, self, false)
	end
end

function M:_restartAutoRota()
	self._equipModel:setNeedAutoRotate(true, true)
end

function M:OnDestroy()
	if self._equipModel then
		self._equipModel:clear()
	end

	self._equipModel = nil
end

function M:_onAttachEffect(inst)
	local animationPlayer = AnimationPlayer.Get(inst)

	animationPlayer:PlayAnimation("idle1", true, false)
	goutil.setActive(inst, true)
end

return M
