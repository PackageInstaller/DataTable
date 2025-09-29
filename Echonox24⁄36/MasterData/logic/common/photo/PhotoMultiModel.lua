-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/photo/PhotoMultiModel.lua

module("logic.common.photo.PhotoMultiModel", package.seeall)

local M = class("PhotoMultiModel")
local CAMERA_POS_Z = -2

function M.Get(go)
	return Astral.LuaComponentContainer.Add(go, M)
end

function M:ctor(container)
	self._go = container.gameObject
	self._transform = self._go.transform
	self._photo = Astral.PhotoBase.Add(self._go)
	self._multiLoader = MultiResLoader.New()
	self._arrayResPath = {}
	self._dictModelContainer = {}
	self._dictModelGO = {}
	self._modelsLoadedHandler = Handler.New()
	self._defaultAnimName = nil
	self._fixAnimationTable = nil
	self._posInfoList = nil
	self._lightCode = nil
end

function M:showModels(resList, textureFormat, antiAliasing)
	self:turnOnLight(true)
	goutil.setActive(self._go, true)

	textureFormat = textureFormat or UnityEngine.RenderTextureFormat.ARGB32
	antiAliasing = antiAliasing or 1

	local width = RectTransformUtils.GetWidth(self._transform)
	local height = RectTransformUtils.GetHeight(self._transform)

	self._photo:TurnOn(width, height, textureFormat, antiAliasing)
	self._photo:SetCameraPosition(0, 0, CAMERA_POS_Z)
	self:_clearResource()

	self._arrayResPath = resList

	self._multiLoader:setResPaths(resList)
	self._multiLoader:load(self._onAllLoaded, self._onOneLoaded, self)
end

function M:setCameraPosition(x, y, z)
	self._photo:SetCameraPosition(x, y, z)
end

function M:getCamera()
	return self._photo:GetCamera()
end

function M:getPhoto()
	return self._photo
end

function M:_onOneLoaded(res)
	if res.IsSuccess then
		local inst = goutil.clone(res:GetAsset(nil, nil))
		local container = goutil.create("modelContainer", false)

		goutil.addChildToParent(inst, container)
		self._photo:ShowTarget(container, true)

		self._dictModelContainer[res.ResPath] = container
		self._dictModelGO[res.ResPath] = inst

		goutil.setActive(container, false)
	end
end

function M:_onAllLoaded()
	if self._posInfoList then
		self:changeContainerTransform(self._posInfoList)
	end

	self:activeContainers(true)

	if self._fixAnimationTable then
		for _, go in pairs(self._dictModelGO) do
			local anim = AnimationPlayer.Get(go)

			for animA, animB in pairs(self._fixAnimationTable) do
				anim:FixAnimation(animA, animB)
			end
		end
	end

	if not string.nilorempty(self._defaultAnimName) then
		self:playAnim(self._defaultAnimName, true, true)
	end

	self._modelsLoadedHandler:call()
end

function M:setModelsLoadedCallback(callback, callbackObj)
	self._modelsLoadedHandler:setListener(callback, callbackObj)
end

function M:setDefaultAnim(name)
	self._defaultAnimName = name
end

function M:setFixAnimation(t)
	self._fixAnimationTable = t
end

function M:setContainerPosInfos(posInfoList)
	self._posInfoList = posInfoList
end

function M:setLightCode(code)
	self._lightCode = code
end

function M:enableTouch(clickHandler, beginDragHandler, dragHandler, endDragHandler)
	if not self._raycastProxy then
		self._clickHandler = clickHandler
		self._beginDragHandler = beginDragHandler
		self._dragHandler = dragHandler
		self._endDragHandler = endDragHandler
		self._raycastProxy = RaycastProxy.Get(self._go)

		self._raycastProxy:SetClickListener(self._onClick, self)
		self._raycastProxy:SetBeginDragListener(self._onBeginDrag, self)
		self._raycastProxy:SetDragListener(self._onDrag, self)
		self._raycastProxy:SetEndDragListener(self._onEndDrag, self)
	end
end

function M:activeContainers(active)
	for _, container in pairs(self._dictModelContainer) do
		goutil.setActive(container, active)
	end
end

function M:changeContainerTransform(posInfoList)
	for i, posInfo in ipairs(posInfoList) do
		local resPath = self._arrayResPath[i]

		if resPath then
			local container = self._dictModelContainer[resPath]

			Astral.TransformUtil.SetLocalPos(container.transform, posInfo[1], posInfo[2], posInfo[3])
			Astral.TransformUtil.SetLocalRotation(container.transform, posInfo[4], posInfo[5], posInfo[6])
			Astral.TransformUtil.SetLocalScale(container.transform, posInfo[7], posInfo[7], posInfo[7])
		end
	end
end

function M:playAnim(aniName, isLoop, isForceRestart)
	for _, go in pairs(self._dictModelGO) do
		local anim = AnimationPlayer.Get(go)

		anim:PlayAnimation(aniName, isLoop, isForceRestart)
	end
end

function M:showUIReflection()
	UIReflectionFacade.instance:setReflectionAlpha(0.5)

	for _, go in pairs(self._dictModelGO) do
		goutil.addComponentOnce(go, typeof(SpaceX.UI3dReflection))
	end

	local go = self:getModelInst(1)
	local reflection = goutil.addComponentOnce(go, typeof(SpaceX.UI3dReflection))

	reflection:CreatePlane()
	self:updateUIRefPanelPosY()
end

function M:updateUIRefPanelPosY()
	local go = self:getContainer(1)
	local posY = Astral.TransformUtil.GetPosY(go.transform)

	UIReflectionFacade.instance:setPlanePosY(posY * -1)
end

function M:turnOnLight(on)
	if self._lightCode then
		if on then
			LightMgr.instance:turnOn(self._lightCode)
		else
			LightMgr.instance:turnOff(self._lightCode)
		end
	end
end

function M:getModelInst(idx)
	local path = self._arrayResPath[idx]

	if path then
		return self._dictModelGO[path]
	end
end

function M:getContainer(idx)
	local path = self._arrayResPath[idx]

	if path then
		return self._dictModelContainer[path]
	end
end

function M:getContainerRotation(idx)
	local container = self:getContainer(idx)
	local rotaX, rotaY, rotaZ = 0, 0, 0

	if container then
		rotaX, rotaY, rotaZ = Astral.TransformUtil.GetLocalRotation(container.transform, 0, 0, 0)
	end

	return rotaX, rotaY, rotaZ
end

function M:setContainerRotationY(idx, rotationY)
	local container = self:getContainer(idx)

	if container then
		local rotaX, _, rotaZ = self:getContainerRotation(idx)

		Astral.TransformUtil.SetLocalRotation(container.transform, rotaX, rotationY, rotaZ)
	end
end

function M:setCameraCullingMask(cullingMask)
	local cam = PhotoBaseExtension.GetCamera(self._photo)

	cam.cullingMask = cullingMask
end

function M:setCameraTag(tag)
	PhotoBaseExtension.SetCameraTag(self._photo, tag)
end

function M:_onClick(isHit, clickCount)
	if self._clickHandler then
		self._clickHandler:call(isHit, clickCount)
	end
end

function M:_onBeginDrag(posX, posY, pointerId)
	if self._beginDragHandler then
		self._beginDragHandler:call(posX, posY, pointerId)
	end
end

function M:_onDrag(posX, posY, pointerId)
	if self._dragHandler then
		self._dragHandler:call(posX, posY, pointerId)
	end
end

function M:_onEndDrag(posX, posY, pointerId)
	if self._endDragHandler then
		self._endDragHandler:call(posX, posY, pointerId)
	end
end

function M:_clearResource()
	table.clear(self._arrayResPath)
	table.clear(self._dictModelContainer)
	table.clear(self._dictModelGO)
	self._multiLoader:clear()

	if self._photo and not goutil.isNil(self._photo.producer) then
		self._photo:RemoveAllTargets()
	end
end

function M:clear()
	self:_clearResource()
	self:turnOnLight(false)
	self._photo:TurnOff()
	goutil.setActive(self._go, false)
end

function M:OnDestroy()
	self:clear()

	self._go = nil
	self._transform = nil
	self._photo = nil
	self._multiLoader = nil
	self._arrayResPath = nil
	self._dictModelContainer = nil
	self._dictModelGO = nil

	self._modelsLoadedHandler:clear()

	self._modelsLoadedHandler = nil
	self._defaultAnimName = nil
	self._fixAnimationTable = nil
	self._posInfoList = nil
	self._lightCode = nil
end

return M
