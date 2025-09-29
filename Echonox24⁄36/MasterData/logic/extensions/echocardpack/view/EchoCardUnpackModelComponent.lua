-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/echocardpack/view/EchoCardUnpackModelComponent.lua

module("logic.extensions.echocardpack.view.EchoCardUnpackModelComponent", package.seeall)

local M = class("EchoCardUnpackModelComponent")
local unpackState = EchoCardPackController.UnpackState
local unpackFive = 5
local audioNames = {
	[GameEnum.QualityEnum.D] = CriwareAudioEnum.ui_canxiang_dakai_b,
	[GameEnum.QualityEnum.C] = CriwareAudioEnum.ui_canxiang_dakai_b,
	[GameEnum.QualityEnum.B] = CriwareAudioEnum.ui_canxiang_dakai_b,
	[GameEnum.QualityEnum.A] = CriwareAudioEnum.ui_canxiang_dakai_a,
	[GameEnum.QualityEnum.S] = CriwareAudioEnum.ui_canxiang_dakai_s
}

function M:ctor(imageContainer)
	self._compContainer = imageContainer
	self._goContainer = imageContainer.gameObject
end

function M:_setEvents(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ECHO_UNPACK_STATE_CHANGE, self._handleUnpackStateChange, self)
		GlobalDispatcher:addEventListener(EventType.ECHO_UNPACK_SHOW_NEXT, self._handleUnpackShowNext, self)
		GlobalDispatcher:addEventListener(EventType.ECHO_UNPACK_SHOW_QUALITY_EFFECT, self._handleQualityEffect, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ECHO_UNPACK_STATE_CHANGE, self._handleUnpackStateChange, self)
		GlobalDispatcher:removeEventListener(EventType.ECHO_UNPACK_SHOW_NEXT, self._handleUnpackShowNext, self)
		GlobalDispatcher:removeEventListener(EventType.ECHO_UNPACK_SHOW_QUALITY_EFFECT, self._handleQualityEffect, self)
	end
end

function M:onEnter()
	self:_setEvents(true)
	LightMgr.instance:turnOn(LightName.UIEchoCardPack)

	self._hasShowBaoDin = false
	self._hasShowFlyEffect = false
	self._num = EchoCardPackController.instance:getUnpackNum()
	self._isFirstToEnd = true
end

function M:onEnterFinished()
	self._photo = Astral.LuaComponentContainer.Add(self._goContainer, PhotoModel)

	self._photo:setModelLoadCallback(self._onResLoad, self)
	self._photo:updateRes(ResName.EchoCardUnpackPosModel, nil, UnityEngine.RenderTextureFormat.RGB111110Float)
	self._photo:setCameraPostProcessing(true, SceneLayer.UI3D_Value)
	self._photo:setCameraCullingLayer(SceneLayer.UI3D_Value)
	self._photo:setCameraTag(SceneTag.RTCamera)
	self._photo:setCameraPosition(0, 34.44, 10.6)
	self._photo:setRotation(0, -180, 0)
	self._photo:setCameraOrthographic(50)
	VolumeMgr.instance:turnOn(VolumeName.EchoCardPack, self._onVolumeLoad, self)
end

function M:onExit()
	self:_setEvents(false)
	removetimer(self._hideModel, self)
	LightMgr.instance:turnOff(LightName.UIEchoCardPack)
	VolumeMgr.instance:turnOff(VolumeName.EchoCardPack)

	if self._tweener then
		self._tweener:Kill(false)
	end

	if self._tweenerHV then
		self._tweenerHV:Kill(false)
	end

	if self._photo then
		self._photo:clear()
	end

	if self._multiResLoader then
		self._multiResLoader:clear()
	end
end

function M:destroyUI()
	self._multiResLoader = nil
	self._photo = nil
end

function M:_onVolumeLoad(volumeUnit)
	if volumeUnit and self._photo then
		local x, y, z = self._photo:getCameraPosition()

		volumeUnit:setPosition(x, y, z)
	end
end

function M:_onResLoad(inst)
	self._mainGo = inst

	goutil.setActive(self._mainGo, true)

	self._positions = {}
	self._goRandomPos = {}

	for i = 1, unpackFive do
		local goPos = goutil.findChild(self._mainGo, "pos" .. i)
		local x, y, z = GameUtils.getLocalPos(goPos)

		self._positions[i] = {
			x = x,
			y = y,
			z = z
		}
		self._goRandomPos[i] = goutil.findChild(self._mainGo, "randomPos" .. i)
	end

	if self._num == unpackFive then
		self._goStart = goutil.findChild(self._mainGo, "fiveStart")
		self._goEnd = goutil.findChild(self._mainGo, "fiveEnd")
	else
		self._goStart = goutil.findChild(self._mainGo, "oneStart")
		self._goEnd = goutil.findChild(self._mainGo, "oneEnd")
	end

	self._startX, self._startY = GameUtils.getLocalPos(self._goStart)
	self._endX, self._endY = GameUtils.getLocalPos(self._goEnd)
	self._distanceX = self._endX - self._startX
	self._isActivityUnpack = EchoCardPackController.instance:isActivityUnpack()
	self._cardModelPath = self._isActivityUnpack and ResName.EchoCardUnpackActivityModel or ResName.EchoCardUnpackNormalModel
	self._multiResLoader = MultiResLoader.New()

	self._multiResLoader:addResPath(self._cardModelPath)
	self._multiResLoader:addResPath(ResName.EchoCardUnpackEffect)
	self._multiResLoader:addResPath(ResName.EchoCardUnpackResultEffect)
	self._multiResLoader:addResPath(ResName.EchoCardUnpackCardFlyEffect)

	local itemId = EchoCardPackController.instance:getEchoCardPackId()

	self._textureUrl = GameUrl.getEchoCardPackDynamic(itemId)

	self._multiResLoader:addResPath(self._textureUrl)
	self._multiResLoader:load(self._onResLoaded, nil, self)
end

function M:_onResLoaded()
	if not self._multiResLoader:isAllSuccess() then
		return
	end

	self:_initModel()
	self:_initEffect()
	self:_initQualityEffect()
	self:_initFlyEffect()
end

function M:_initModel()
	local res = self._multiResLoader:getResource(self._cardModelPath)
	local prefab = res and res:GetMainAsset()

	self._cardGo = prefab and goutil.clone(prefab)

	GameUtils.setLocalPos(self._cardGo, 1000, 1000, 1000)

	local textureRes = self._multiResLoader:getResource(self._textureUrl)
	local go = goutil.findChild(self._cardGo, "amiObj/echo_pack_card")
	local materialSetter = MaterialSetter.Get(go)

	materialSetter:SetTexture(UnityEngine.Shader.PropertyToID("_BaseMap"), textureRes:GetMainAsset())
	self:_cloneCards()
end

function M:_cloneCards()
	self:_initRandomGoPosition()

	self._goCards = {}
	self._goCards[1] = self._cardGo

	local pos = self._num == unpackFive and self._randomPos[1] or self._randomPos[3]

	goutil.addChildToParent(self._cardGo, self._mainGo)
	GameUtils.setLocalPos(self._cardGo, pos.x, pos.y, pos.z)
	GameUtils.setLocalRotation(self._cardGo, 0, 0, self._randomRotations[3])

	if self._num == unpackFive then
		for i = 2, self._num do
			if not self._goCards[i] then
				self._goCards[i] = goutil.clone(self._cardGo)

				goutil.addChildToParent(self._goCards[i], self._mainGo)

				pos = self._randomPos[i]

				GameUtils.setLocalPos(self._goCards[i], pos.x, pos.y, pos.z)
				GameUtils.setLocalRotation(self._goCards[i], 0, 0, self._randomRotations[i])
			end
		end
	end

	self._guiAnimations = {}

	for i = 1, #self._goCards do
		self._guiAnimations[i] = goutil.addComponentOnce(self._goCards[i], typeof(Astral.GUITimelineAniLua))

		self._guiAnimations[i]:PlayAniByName("open")
		self._guiAnimations[i]:PauseAni()

		local goAni = goutil.findChild(self._goCards[i], "amiObj")

		Astral.LuaComponentContainer.Add(goAni, EchoCardUnpackAnimationComponent)
	end

	self._aniTime = self._guiAnimations[1]:GetTrackEndTime("open")
end

function M:_initEffect()
	local res = self._multiResLoader:getResource(ResName.EchoCardUnpackEffect)
	local prefab = res and res:GetMainAsset()

	self._effectGo = prefab and goutil.clone(prefab)
	self._effectGuiAnimation = goutil.addComponentOnce(self._effectGo, typeof(Astral.GUITimelineAniLua))

	self._effectGuiAnimation:PlayAniByName("open")
	self._effectGuiAnimation:PauseAni()
	goutil.addChildToParent(self._effectGo, goutil.findChild(self._mainGo, "effectGo"))

	local goName = self._num == unpackFive and "wubao" or "yibao"

	self._effectAniTime = self._effectGuiAnimation:GetTrackEndTime(self._num == unpackFive and "five" or "one")
	self._goOneEffect = goutil.findChild(self._effectGo, "yibao")
	self._goFiveEffect = goutil.findChild(self._effectGo, "wubao")

	goutil.setActive(self._goOneEffect, self._num ~= unpackFive)
	goutil.setActive(self._goFiveEffect, self._num == unpackFive)

	self._goEffects = {}
	self._goEffects[GameEnum.QualityEnum.B] = goutil.findChild(self._effectGo, goName .. "/low")
	self._goEffects[GameEnum.QualityEnum.A] = goutil.findChild(self._effectGo, goName .. "/in")
	self._goEffects[GameEnum.QualityEnum.S] = goutil.findChild(self._effectGo, goName .. "/higt")
	self._results = EchoCardPackController.instance:getCacheResult()
	self._maxQuality = EchoCardPackController.instance:getMaxQuality()

	for key, obj in pairs(self._goEffects) do
		goutil.setActive(obj, key == self._maxQuality)
	end

	local curEffectGo = self._goEffects[self._maxQuality]

	if curEffectGo then
		self._goOpenEffect = goutil.findChild(curEffectGo, "kabaoguang")
		self._goCursor = goutil.findChild(curEffectGo, "guangbiao")
		self._goExplosion = goutil.findChild(curEffectGo, "baodian")

		goutil.setActive(self._goOpenEffect, false)
		goutil.setActive(self._goCursor, false)
		goutil.setActive(self._goExplosion, false)
		goutil.addChildToParent(self._goCursor, self._mainGo)

		local x, y, z = GameUtils.getLocalPos(self._goCursor)

		self._cursorPosZ = z
	end

	self._cursorActive = false
end

function M:_initQualityEffect()
	local res = self._multiResLoader:getResource(ResName.EchoCardUnpackResultEffect)
	local prefab = res and res:GetMainAsset()

	self._qualityEffectGo = prefab and goutil.clone(prefab)
	self._qualityGo = goutil.findChild(self._mainGo, "qualityGo")

	goutil.addChildToParent(self._qualityEffectGo, self._qualityGo)

	self._goQualityEffects = {}
	self._goQualityEffects[GameEnum.QualityEnum.B] = goutil.findChild(self._qualityEffectGo, "low")
	self._goQualityEffects[GameEnum.QualityEnum.A] = goutil.findChild(self._qualityEffectGo, "in")
	self._goQualityEffects[GameEnum.QualityEnum.S] = goutil.findChild(self._qualityEffectGo, "higt")
	self._goEffectTop = goutil.findChild(self._qualityEffectGo, "kaibaozhanshi")

	self:showQualityEffect(nil, true)
	EchoCardPackController.instance:setModelInitState(true)
end

function M:_initFlyEffect()
	local res = self._multiResLoader:getResource(ResName.EchoCardUnpackCardFlyEffect)
	local prefab = res and res:GetMainAsset()

	self._flyEffectGo = prefab and goutil.clone(prefab)

	goutil.addChildToParent(self._flyEffectGo, self._mainGo)

	local goFiveFlyEffect = goutil.findChild(self._flyEffectGo, "five")
	local goOneFlyEffect = goutil.findChild(self._flyEffectGo, "one")

	goutil.setActive(goFiveFlyEffect, self._num == unpackFive)
	goutil.setActive(goOneFlyEffect, self._num ~= unpackFive)
	goutil.setActive(self._flyEffectGo, false)
end

function M:_handleQualityEffect(e, quality)
	self:showQualityEffect(quality)
end

function M:showQualityEffect(quality, isHideQuality)
	quality = quality and quality or self._maxQuality

	for key, obj in pairs(self._goQualityEffects) do
		goutil.setActive(obj, key == quality and not isHideQuality)
	end
end

function M:setGuiAnimationsTime(value)
	if value < 0 then
		value = 0
	elseif value > 1 then
		value = 1
	end

	local time = self._aniTime * value

	for i = 1, #self._guiAnimations do
		self._guiAnimations[i]:SetAniTime(time)
		self._guiAnimations[i]:Evaluate()
	end

	time = self._effectAniTime * value

	self._effectGuiAnimation:SetAniTime(time)
	self._effectGuiAnimation:Evaluate()

	if value > 0.6 and not self._hasShowFlyEffect then
		goutil.setActive(self._flyEffectGo, true)

		self._hasShowFlyEffect = true
	end

	if value > 0.8 and not self._hasShowBaoDin then
		self._hasShowBaoDin = true

		goutil.setActive(self._goExplosion, true)
		CriwareAudioFacade.instance:playOnceSEbyId(audioNames[self._maxQuality], nil, nil, nil)
		self:showQualityEffect()
	end

	local isShowCursor = value > 0.1 and value < 0.8

	if self._cursorActive ~= isShowCursor then
		self._cursorActive = not self._cursorActive

		goutil.setActive(self._goCursor, self._cursorActive)
		goutil.setActive(self._goOpenEffect, self._cursorActive)
	end

	if self._cursorActive then
		local x = self._startX + value * self._distanceX

		GameUtils.setLocalPos(self._goCursor, x, self._startY, self._cursorPosZ)
	end
end

function M:_handleUnpackShowNext()
	local state = EchoCardPackController.instance:getUnpackState()

	if state == unpackState.UnInOrder then
		EchoCardPackController.instance:setUnpackState(unpackState.Ordering)
		GlobalDispatcher:dispatchEvent(EventType.ECHO_UNPACK_STATE_CHANGE)
		self:_clearUpCard()
	end
end

function M:_handleUnpackStateChange()
	local state = EchoCardPackController.instance:getUnpackState()

	if state == unpackState.UnpackEnd and self._isFirstToEnd then
		self._isFirstToEnd = false

		settimer(0.3, self._hideModel, self, false)
	end
end

function M:_hideModel()
	for i = 1, #self._goCards do
		goutil.setActive(self._goCards[i], false)
	end

	GameUtils.setLocalRotation(self._mainGo, 0, 0, 0)
	GameUtils.setLocalPos(self._qualityGo, 0, -34, 0)
	goutil.setActive(self._effectGo, false)
end

function M:_initRandomGoPosition()
	self._randomPos = {}
	self._randomRotations = {}

	for i = 1, unpackFive do
		local x, y, z = GameUtils.getLocalPos(self._goRandomPos[i])
		local pos = {}

		pos.x = math.random(x - 10, x + 10)
		pos.y = math.random(y - 8, y + 8)
		pos.z = z
		self._randomPos[i] = pos
		self._randomRotations[i] = math.random(-45, 45)
	end
end

function M:_clearUpCard()
	if not EchoCardPackController.instance:getModelInitState() then
		return
	end

	if self._tweener then
		self._tweener:Kill(false)
	end

	self._tweener = DoTweenUtil.To(0, 1, 0.5, function(value)
		if self._num == unpackFive then
			for i = 1, self._num do
				local go = self._goCards[i]
				local x = self._randomPos[i].x + (self._positions[i].x - self._randomPos[i].x) * value
				local y = self._randomPos[i].y + (self._positions[i].y - self._randomPos[i].y) * value

				GameUtils.setLocalPos(go, x, y, self._randomPos[i].z)

				local z = self._randomRotations[i] - self._randomRotations[i] * value

				GameUtils.setLocalRotation(go, 0, 0, z)
			end
		else
			local go = self._goCards[1]
			local idex = 3
			local x = self._randomPos[idex].x + (self._positions[idex].x - self._randomPos[idex].x) * value
			local y = self._randomPos[idex].y + (self._positions[idex].y - self._randomPos[idex].y) * value

			GameUtils.setLocalPos(go, x, y, self._randomPos[idex].z)

			local z = self._randomRotations[idex] - self._randomRotations[idex] * value

			GameUtils.setLocalRotation(go, 0, 0, z)
		end
	end)

	self._tweener:OnComplete(function()
		EchoCardPackController.instance:setUnpackState(unpackState.InOrder)
		GlobalDispatcher:dispatchEvent(EventType.ECHO_UNPACK_STATE_CHANGE)
	end)
	self._tweener:SetTarget(self._mainGo)
end

function M:switchHV()
	if not self._mainGo then
		return
	end

	local isHorizontal = EchoCardPackController.instance:getHorizontalState()

	if self._tweenerHV then
		self._tweenerHV:Kill(false)
	end

	local startRotation = isHorizontal and -90 or 0
	local targetRotation = isHorizontal and 0 or -90

	goutil.setActive(self._goEffectTop, false)

	self._tweenerHV = DoTweenUtil.ToWithEase(startRotation, targetRotation, 0.4, DG.Tweening.Ease.OutQuad, function(value)
		GameUtils.setLocalRotation(self._mainGo, 0, 0, value)
	end)

	self._tweenerHV:OnComplete(function()
		goutil.setActive(self._goEffectTop, true)
	end)
	self._tweenerHV:SetTarget(self._mainGo)

	if isHorizontal then
		GameUtils.setLocalPos(self._qualityGo, 0, -34, 0)
		GameUtils.setLocalPos(self._goEffectTop, -4.8, 88.6, 5)

		for key, obj in pairs(self._goQualityEffects) do
			GameUtils.setLocalPos(obj, 0, 0, 0)
		end
	else
		GameUtils.setLocalPos(self._qualityGo, 0, -72, 0)
		GameUtils.setLocalPos(self._goEffectTop, -4.8, 180.9, 5)

		for key, obj in pairs(self._goQualityEffects) do
			GameUtils.setLocalPos(obj, 0, -21.4, 0)
		end
	end
end

return M
