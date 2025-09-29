-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/photo/PhotoUnit.lua

module("logic.common.photo.PhotoUnit", package.seeall)

local PhotoUnit = class("PhotoUnit", UnitBase)
local kDefaultsFace = "changtai"

function PhotoUnit.Get(go)
	return Astral.SimpleLuaComponentContainer.Add(go, PhotoUnit)
end

function PhotoUnit:_initComponents()
	self:_addComponent("ani", PhotoUnitCompAni)
end

function PhotoUnit:ctor(container)
	self._compList = {}
	self._go = container.gameObject
	self._photo = Astral.PhotoBase.Add(self._go)

	local unitGo = goutil.create("PhotoUnit", false)

	self._unit = Astral.LuaComponentContainer.Add(unitGo, UnitPhotoSpine)
	self._targetGoes = {}
	self._multiLoader = MultiResLoader.New()

	goutil.addChildToParent(unitGo, self._go)
	unitGo:SetActive(false)

	self._isTurnOn = false
	self._isEnableScanLine = false
	self._spineLoadedCallback = nil
	self._spineLoadedCallbackObj = nil
	self._isPlayNormalAnimation = true

	self._unit:addInnerEventListener(UnitActionType.SpineLoaded, self._onSpineLoaded, self)

	self._isPlayOnce = false
end

function PhotoUnit:getUnit()
	return self._unit
end

function PhotoUnit:setSpineLoadedCallback(callback, callbackObj, param)
	self._spineLoadedCallback = callback
	self._spineLoadedCallbackObj = callbackObj
	self._spineLoadedCallbackParam = param
end

function PhotoUnit:removeSpineLoadCallback()
	self._spineLoadedCallback = nil
	self._spineLoadedCallbackObj = nil
	self._spineLoadedCallbackParam = nil
end

function PhotoUnit:setShowXinMaoSlot(needCache)
	self._needCacheXinmao = needCache

	if needCache then
		if not self._xinmaoSlotMap then
			self._xinmaoSlotMap = {}
		end
	else
		self._xinmaoSlotMap = false
	end
end

function PhotoUnit:_onSpineLoaded()
	self:setFace(self._faceResName)

	if self._needCacheXinmao then
		self:_cacheSlotData()
	end

	if self._spineLoadedCallback then
		if self._spineLoadedCallbackObj then
			self._spineLoadedCallback(self._spineLoadedCallbackObj, self._spineLoadedCallbackParam, self._unit.spine, self._bodyLoadedParmTable)
		else
			self._spineLoadedCallback(self._unit.spine, self._bodyLoadedParmTable)
		end
	end

	self.ani:setAnimation()

	local skeAnim = self._unit.spine:getSkeletonAnimation()

	if skeAnim then
		self:_setSpineEvent(true)
	end
end

function PhotoUnit:showUnit(modelId)
	self._modelId = modelId

	local defualtFace = ExpressionConfig.instance:getDefaultFace(self._modelId)

	defualtFace = defualtFace or kDefaultsFace
	self._defaultFace = defualtFace

	local modelCO = ModelConfig.instance:getModelConfig(modelId)

	if not modelCO then
		if enableWarnLog then
			printWarn("can't find ModelCO,modelId=", modelId)
		end

		return nil
	end

	self._unit.spine:setBody(GameUrl.getSpineUrl(modelCO.resName))
	self:_turnOn()
end

function PhotoUnit:showUnitLiveWholeByID(modelId, faceResName)
	self._modelId = modelId

	local defualtFace = ExpressionConfig.instance:getDefaultFace(self._modelId)

	defualtFace = defualtFace or kDefaultsFace
	self._defaultFace = defualtFace

	local modelCO = ModelConfig.instance:getModelConfig(modelId)

	if not modelCO then
		if enableWarnLog then
			printWarn("can't find ModelCO,modelId=", modelId)
		end

		return nil
	end

	self._faceResName = faceResName

	local url = GameUrl.getSpineUrl(modelCO.liveWholeIconName)

	if url == self._unit.spine._url then
		self:_onSpineLoaded()
	else
		self._unit.spine:setBody(url)
		self:_turnOn()
	end
end

function PhotoUnit:showUnitLiveWhole(res)
	if not res then
		if enableWarnLog then
			printWarn("can't find res,res=", res)
		end

		return nil
	end

	self._unit.spine:setBody(GameUrl.getSpineUrl(res))
	self:_turnOn()
end

function PhotoUnit:showEffects(...)
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

function PhotoUnit:_onOneLoaded(res)
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

function PhotoUnit:_turnOn()
	if self._isTurnOn then
		return
	end

	self._isTurnOn = true

	self._photo:TurnOn()
	self._photo:ShowTarget(self._unit.go, false)
	self._unit.go:SetActive(true)
	self._photo:SetCameraPosition(0, 0, 0)
	self._photo:SetCameraRotation(0, 0, 0)
	PhotoBaseExtension.ResetCamera(self._photo)
end

function PhotoUnit:_clearAllEffect()
	for k, v in pairs(self._targetGoes) do
		goutil.destroy(v)

		self._targetGoes[k] = nil
	end

	self._multiLoader:clear()
end

function PhotoUnit:setCameraPosition(x, y, z)
	self._photo:SetCameraPosition(x, y, z)
end

function PhotoUnit:setCameraRotation(x, y, z)
	self._photo:SetCameraRotation(x, y, z)
end

function PhotoUnit:setCameraPerspective(fieldOfView)
	PhotoBaseExtension.SetCameraPerspective(self._photo, fieldOfView)
end

function PhotoUnit:setCameraOrthographic(orthographicSize)
	PhotoBaseExtension.SetCameraOrthographic(self._photo, orthographicSize)
end

function PhotoUnit:setCameraPostProcessing(renderPostProcessing, volumeLayerMask)
	PhotoBaseExtension.SetCameraPostProcessing(self._photo, renderPostProcessing, volumeLayerMask)
end

function PhotoUnit:setCameraTag(tag)
	PhotoBaseExtension.SetCameraTag(self._photo, tag)
end

function PhotoUnit:setMaterial(material)
	PhotoBaseExtension.SetMaterial(self._photo, material)
end

function PhotoUnit:setBgColor(colorStr)
	PhotoBaseExtension.SetCameraBgColor(self._photo, colorStr)
end

function PhotoUnit:setPlayNormalAnimation(isAutoPlay)
	self._isPlayNormalAnimation = isAutoPlay
end

function PhotoUnit:getGO()
	return self._go
end

function PhotoUnit:clear()
	self:_setSpineEvent(false)

	if self._unit.spine._skeletonLoader then
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
	self._isShowEnter = false
	self._showEnterFromLeft = false
	self._isShowXiuXian = false
end

function PhotoUnit:OnDestroy()
	self.ani:onDestroy()
	self:clear()
	goutil.destroy(self._unit.go)

	if self._unit then
		self._unit:removeInnerEventListener(UnitActionType.SpineLoaded, self._onSpineLoaded, self)
	end

	self._unit = nil
	self._photo = nil
end

function PhotoUnit:setDirection(direction)
	self._unit.spine:setDirection(direction)
end

function PhotoUnit:setFace(skinName)
	self._faceResName = skinName or self._defaultFace

	if self._unit and self._unit.spine:getSkeletonAnimation() and self._unit.spine:getSkeletonAnimation().Skeleton.Data:FindSkin(self._faceResName) then
		local skeletonAnimation = self._unit.spine:getSkeletonAnimation()
		local skin = skeletonAnimation.Skeleton.Skin

		if skin then
			local curSkinName = skin.Name

			if curSkinName == self._faceResName then
				return
			end
		end

		skeletonAnimation.initialSkinName = self._faceResName

		skeletonAnimation.Skeleton:SetSkin(self._faceResName)
		skeletonAnimation.Skeleton:SetSlotsToSetupPose()
		skeletonAnimation.AnimationState:Apply(skeletonAnimation.Skeleton)
	end
end

function PhotoUnit:_cacheSlotData()
	if not self._xinmaoSlotMap then
		self._xinmaoSlotMap = {}
	else
		table.clear(self._xinmaoSlotMap)
	end

	local skeletonAnimation = self._unit.spine:getSkeletonAnimation()

	if skeletonAnimation then
		local maxSlotCount = skeletonAnimation.Skeleton.Slots.Count

		for i = 0, maxSlotCount - 1 do
			local slot = skeletonAnimation.Skeleton.Slots.Items[i]

			if slot and string.starts(slot.Data.Name, "xinmao_") then
				self._xinmaoSlotMap[slot.Data.Name] = slot.Data.AttachmentName
			end
		end
	end
end

function PhotoUnit:setAnchoringAttachment(active)
	if self._xinmaoSlotMap then
		for slotName, attachementName in pairs(self._xinmaoSlotMap) do
			self:setAttachment(slotName, active and attachementName or nil)
		end
	end
end

function PhotoUnit:setAttachment(slotName, attachmentName)
	local skeletonAnimation = self._unit.spine:getSkeletonAnimation()

	if skeletonAnimation then
		local slot = skeletonAnimation.Skeleton:FindSlot(slotName)

		if slot then
			skeletonAnimation.Skeleton:SetAttachment(slotName, attachmentName)
		end
	end
end

function PhotoUnit:setBodyLoadedParm(parmTable)
	self._bodyLoadedParmTable = parmTable
end

function PhotoUnit:setIsShowEgg(isShowEgg)
	self._isShowEgg = isShowEgg
end

function PhotoUnit:setIsShowEnter(isShowEnter)
	self._isShowEnter = isShowEnter
end

function PhotoUnit:setShowEnterFromLeft(fromLeft)
	self._showEnterFromLeft = fromLeft
end

function PhotoUnit:setIsShowXiuXian(isShowXiuXian)
	self._isShowXiuXian = isShowXiuXian
end

function PhotoUnit:setShadow(enable)
	return
end

function PhotoUnit:getBodyLoadedParm()
	return self._bodyLoadedParmTable
end

function PhotoUnit:setSpineColor(colorStr)
	self._unit.material:setMainColor(colorStr)
end

function PhotoUnit:getSpineColor()
	self._unit.material:getMainColor()
end

function PhotoUnit:doColor(endValue, duration)
	self._unit.material:doColor(endValue, duration)
end

function PhotoUnit:doFofade(to, duration)
	return self._unit.material:doMainAlpha(to, duration)
end

function PhotoUnit:killAll(complete)
	self._unit.material:killAll(complete)
end

function PhotoUnit:ToggleScanLine(enable, scanLineMap, flickerMap, mainColorAnim)
	if self._isEnableScanLine == enable then
		return
	end

	self._isEnableScanLine = enable

	self._unit.material:ToggleScanLine(enable, scanLineMap, flickerMap, mainColorAnim)
end

function PhotoUnit:toggleMask(enable, maskPos, maskFactor)
	if self._isEnableMask == enable then
		return
	end

	self._isEnableMask = enable

	self._unit.material:toggleMask(enable, maskPos, maskFactor)
end

function PhotoUnit:toggleSilhouette(enable)
	self._unit.material:toggleSilhouette(enable)
end

function PhotoUnit:play(animState, isLoop)
	self._unit.spine:play(animState, isLoop)
end

function PhotoUnit:playOnce(animState)
	self._isPlayOnce = true

	self:_setSpineEvent(true)
	self._unit.spine:play(animState, false)
end

function PhotoUnit:getAnimState()
	if self._unit then
		return self._unit.spine:getAnimState()
	end
end

function PhotoUnit:_onSpineEvent(eventId, actionType, animationName, eventName, eventParam)
	if eventName == SpineEventName.Complete then
		if self._isPlayOnce then
			self._isPlayOnce = false

			local defaultState = self._unit.spine:getDefaultAnimState()

			self:play(defaultState, true)

			return
		end

		self._unit.spine:resetCurAnimState()
		self.ani:_onSpineEvent(eventId, actionType, animationName, eventName, eventParam)
	end
end

function PhotoUnit:_setSpineEvent(add)
	if self._isAdd == add then
		return
	end

	self._isAdd = add

	if add then
		self._unit:addInnerEventListener(UnitActionType.SpineEvent, self._onSpineEvent, self)
	else
		self._unit:removeInnerEventListener(UnitActionType.SpineEvent, self._onSpineEvent, self)
	end
end

function PhotoUnit:getRenderTexture()
	return self._photo.producer.rtCamera.targetTexture
end

return PhotoUnit
