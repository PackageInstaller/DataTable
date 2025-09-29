-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/uirole/PhotoModelUnit.lua

module("logic.common.viewlib.uirole.PhotoModelUnit", package.seeall)

local M = class("PhotoModelUnit")

function M.Get(go)
	return Astral.SimpleLuaComponentContainer.Add(go, PhotoModelUnit)
end

function M:ctor(container)
	self._go = container.gameObject
	self._photo = Astral.PhotoBase.Add(self._go)

	local unitGo = goutil.create("PhotoUnit", false)

	self._unit = Astral.LuaComponentContainer.Add(unitGo, UnitPhotoModel)
	self._isTurnOn = false
	self._isEnableScanLine = false
	self._targetGoes = {}
	self._multiLoader = MultiResLoader.New()

	goutil.addChildToParent(unitGo, self._go)
	unitGo:SetActive(false)

	self._modelLoadedCallback = nil
	self._modelLoadedCallbackObj = nil

	self._unit:addInnerEventListener(UnitActionType.SpineLoaded, self._onModelLoaded, self)

	self._showAnimIndex = 1
	self._showAnims = {}
end

function M:getUnit()
	return self._unit
end

function M:setSpineLoadedCallback(callback, callbackObj)
	self._modelLoadedCallback = callback
	self._modelLoadedCallbackObj = callbackObj
end

function M:_onModelLoaded()
	self:setFace(self._faceResName)

	self._faceResName = nil

	if self._modelLoadedCallback then
		if self._modelLoadedCallbackObj then
			self._modelLoadedCallback(self._modelLoadedCallbackObj, self._unit.spine, self._bodyLoadedParmTable)
		else
			self._modelLoadedCallback(self._unit.spine)
		end
	end

	self:setAnimation()
end

function M:showUnit(modelId)
	local modelCO = ModelConfig.instance:getModelConfig(modelId)

	if not modelCO then
		if enableWarnLog then
			printWarn("can't find ModelCO,modelId=", modelId)
		end

		return nil
	end

	self._unit.spine:setBody(self:getTempUrl())
	self:_turnOn()
end

function M:getTempUrl()
	return "character/yanzuo_skin_p.prefab"
end

function M:showUnitLiveWholeByID(modelId, faceResName)
	local modelCO = ModelConfig.instance:getModelConfig(modelId)

	if not modelCO then
		if enableWarnLog then
			printWarn("can't find ModelCO,modelId=", modelId)
		end

		return nil
	end

	self._faceResName = faceResName

	local url = self:getTempUrl()

	if url == self._unit.spine._url then
		self:_onModelLoaded()
	else
		self._unit.spine:setBody(url)
		self:_turnOn()
	end
end

function M:showUnitLiveWhole(res)
	if not res then
		if enableWarnLog then
			printWarn("can't find res,res=", res)
		end

		return nil
	end

	self._unit.spine:setBody(self:getTempUrl())
	self:_turnOn()
end

function M:showEffects(...)
	local urls = {
		...
	}

	if not urls then
		return
	end

	self:_turnOn()
	self:_clearAllEffect()

	local len = #urls

	for i = 1, len do
		self._multiLoader:addResPath(urls[i], true)
	end

	self._multiLoader:load(self._onAllLoaded, self._onOneLoaded, self)
end

function M:_onOneLoaded(res)
	if res.IsSuccess then
		local inst = goutil.clone(res:GetAsset(nil, nil))

		self._photo:ShowTarget(inst, true)

		self._targetGoes[res.ResPath] = inst

		if self._effectLoadedCallback then
			if self._effectLoadedCallbackObj then
				self._effectLoadedCallback(self._effectLoadedCallbackObj, inst, res)
			else
				self._effectLoadedCallback(inst, res)
			end
		end
	end
end

function M:_turnOn()
	if self._isTurnOn then
		return
	end

	self._isTurnOn = true

	self._photo:TurnOn()
	self._photo:ShowTarget(self._unit.go, false)
	self._unit.go:SetActive(true)
	self._photo:SetCameraRotation(0, 0, 0)
	PhotoBaseExtension.ResetCamera(self._photo)
	self._photo:SetCameraPosition(0, 1, -2)
end

function M:_clearAllEffect()
	for k, v in pairs(self._targetGoes) do
		goutil.destroy(v)

		self._targetGoes[k] = nil
	end

	self._multiLoader:clear()
end

function M:setCameraPosition(x, y, z)
	self._photo:SetCameraPosition(x, y, z)
end

function M:setCameraRotation(x, y, z)
	self._photo:SetCameraRotation(x, y, z)
end

function M:setCameraPerspective(fieldOfView)
	PhotoBaseExtension.SetCameraPerspective(self._photo, fieldOfView)
end

function M:setCameraOrthographic(orthographicSize)
	PhotoBaseExtension.SetCameraOrthographic(self._photo, orthographicSize)
end

function M:setCameraPostProcessing(renderPostProcessing, volumeLayerMask)
	PhotoBaseExtension.SetCameraPostProcessing(self._photo, renderPostProcessing, volumeLayerMask)
end

function M:setCameraTag(tag)
	PhotoBaseExtension.SetCameraTag(self._photo, tag)
end

function M:setMaterial(material)
	PhotoBaseExtension.SetMaterial(self._photo, material)
end

function M:setBgColor(colorStr)
	PhotoBaseExtension.SetCameraBgColor(self._photo, colorStr)
end

function M:getGO()
	return self._go
end

function M:clear()
	self:_setSpineEvent(false)

	if self._unit.spine._prefabLoader then
		self._unit.spine:clear()
	end

	if self._unit.go then
		if not goutil.isNil(self._go) then
			goutil.addChildToParent(self._unit.go, self._go)
		end

		self._unit.go:SetActive(false)
	end

	self:_clearAllEffect()
	self._photo:TurnOff()

	self._isTurnOn = false
end

function M:OnDestroy()
	self:clear()
	goutil.destroy(self._unit.go)

	if self._unit then
		self._unit:removeInnerEventListener(UnitActionType.SpineLoaded, self._onModelLoaded, self)
	end

	self._unit = nil
	self._photo = nil
	self._material = nil
end

function M:setDirection(direction)
	self._unit.spine:setDirection(direction)
end

function M:setFace(skinName)
	skinName = skinName or "changtai"
end

function M:setBodyLoadedParm(parmTable)
	self._bodyLoadedParmTable = parmTable
end

function M:setIsShowEgg(isShowEgg)
	self._isShowEgg = isShowEgg
end

function M:getBodyLoadedParm()
	return self._bodyLoadedParmTable
end

function M:setSpineColor(colorStr)
	self._unit.material:setMainColor(colorStr)
end

function M:getSpineColor()
	self._unit.material:getMainColor()
end

function M:doColor(endValue, duration)
	self._unit.material:doColor(endValue, duration)
end

function M:doFofade(to, duration)
	return self._unit.material:doMainAlpha(to, duration)
end

function M:killAll(complete)
	self._unit.material:killAll(complete)
end

function M:ToggleScanLine(enable, scanLineMap, flickerMap, mainColorAnim)
	if self._isEnableScanLine == enable then
		return
	end

	self._isEnableScanLine = enable

	self._unit.material:ToggleScanLine(enable, scanLineMap, flickerMap, mainColorAnim)
end

function M:play(animState, isLoop)
	self._unit.spine:play(animState, isLoop)
end

function M:getAnimState()
	return self._unit.spine:getAnimState()
end

function M:setAnimation()
	local skeAnim = self._unit.spine:getSkeletonAnimation()

	if not skeAnim then
		return
	end

	local isIdleAnim = true
	local isShowAnim = false

	table.clear(self._showAnims)

	if isShowAnim then
		if isIdleAnim then
			table.insert(self._showAnims, UnitAnimState.Idle)
			table.insert(self._showAnims, UnitAnimState.Idle)
		else
			printError("该人物没有idle动作")
		end

		table.insert(self._showAnims, UnitAnimState.Show)

		self._showAnimIndex = 1

		if #self._showAnims ~= 0 then
			self:_setSpineEvent(true)

			local currentAnim = self._showAnims[self._showAnimIndex]

			self:play(currentAnim)
		end
	else
		self:_setSpineEvent(true)
		self:play(UnitAnimState.Idle, true)
	end
end

function M:_onSpineEvent(eventId, actionType, animationName, eventName, eventParam)
	if eventName == SpineEventName.Complete then
		local showAnimNum = #self._showAnims

		self._showAnimIndex = self._showAnimIndex + 1

		if showAnimNum < self._showAnimIndex then
			self._showAnimIndex = 1
		end

		local currentAnim = self._showAnims[self._showAnimIndex]

		self._unit.spine:resetCurAnimState()
		self:play(currentAnim)
	end
end

function M:_setSpineEvent(add)
	if add then
		self._unit:addInnerEventListener(UnitActionType.SpineEvent, self._onSpineEvent, self)
	else
		self._unit:removeInnerEventListener(UnitActionType.SpineEvent, self._onSpineEvent, self)
	end
end

function M:getRenderTexture()
	return self._photo.producer.rtCamera.targetTexture
end

return M
