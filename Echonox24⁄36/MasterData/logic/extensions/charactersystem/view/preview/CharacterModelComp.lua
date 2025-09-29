-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/preview/CharacterModelComp.lua

module("logic.extensions.charactersystem.view.preview.CharacterModelComp", package.seeall)

local M = class("CharacterModelComp", ViewComponent)
local kDefaultAnim = MainPerformEnum.AnimFullName.ChoukaIdle
local kScenePath = "scene/checkerboard/characterscene.prefab"
local kLightCode = LightName.BattleAdditional
local RotateFactor = 0.3

function M:ctor()
	self._heroId = nil
	self._heroCfgInfo = nil
	self._dragPos = Vector3.New()
end

function M:buildUI()
	self._canvasGroupHero = self:getUIComponent("role_model_preview_view_-1699531164", ComponentType.CanvasGroup)
	self._rawImageHero = self:getUIComponent("role_model_preview_view_-1010415341", UIComponentType.RawImage)
	self._photoSpace = PhotoSpace.Get(self._rawImageHero.gameObject)

	self._photoSpace:clear()
end

function M:onEnter()
	local param = self:getFirstParam()

	self._heroId = type(param) == "number" and param or param.heroId
	self._heroCfgInfo = CharacterConfig.instance:getCfgInfoByID(self._heroId)
	self._modelCO = ModelConfig.instance:getModelConfig(self._heroCfgInfo.modelId)
	self._modelPath = GameUrl.getMainSceneMeshModelUrl(self._modelCO.mainSceneResName)
	self._idleAnimPath = GameUrl.getMainSceneMeshModelClipUrl(self._modelCO.mainSceneResName, kDefaultAnim)
	self._scenePath = kScenePath
	self._resList = {
		self._idleAnimPath,
		self._modelPath,
		self._scenePath
	}

	self:_showPhoto(false)
	self:_refreshView()
	LightMgr.instance:turnOn(kLightCode)
	self:_refreshPosition(true)
	self:bindDispatchEvent()
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:bindDispatchEvent()
	GlobalDispatcher:addEventListener(EventType.HERO_PREVIEW_CAM_CTRL, self._onCamCtrl, self)
	GlobalDispatcher:addEventListener(EventType.HERO_PREVIEW_POS_CTRL, self._onPosCtrl, self)
end

function M:unbindDispatchEvent()
	GlobalDispatcher:removeEventListener(EventType.HERO_PREVIEW_CAM_CTRL, self._onCamCtrl, self)
	GlobalDispatcher:removeEventListener(EventType.HERO_PREVIEW_POS_CTRL, self._onPosCtrl, self)
end

function M:onExit()
	LightMgr.instance:turnOff(kLightCode)
	self:_refreshPosition(false)
	self._photoSpace:clear()

	self._resMap = nil

	self:unbindDispatchEvent()
end

function M:destroyUI()
	if self._photoSpace then
		self._photoSpace:clear()
	end
end

function M:_refreshView()
	self._photoSpace:show(nil, 4)
	self._photoSpace:setModelLoadCallback(self._resLoaded, self._allResLoaded, self)
	self._photoSpace:addResList(self._resList)
	self._photoSpace:setCameraTag(SceneTag.RTCamera)

	local camCo = CharacterPreviewConfig.instance:getCameraCo(self._heroId)

	self._photoSpace:setCameraPosition(camCo.pos)
	self._photoSpace:setCameraRotation(camCo.rot)
	self._photoSpace:setCameraFov(camCo.fov)
end

function M:_resLoaded(res)
	self._resMap = self._resMap or {}
	self._resMap[res.ResPath] = {
		res = res
	}
end

function M:_allResLoaded()
	local sceneResData = self:_getResource(self._scenePath)
	local sceneGo = goutil.clone(sceneResData.res:GetMainAsset())

	self._photoSpace:showTarget(sceneGo, true)

	sceneResData.go = sceneGo

	local modelResData = self:_getResource(self._modelPath)
	local modelGo = goutil.clone(modelResData.res:GetMainAsset())

	modelResData.go = modelGo

	local transfInfo = CharacterPreviewConfig.instance:getPreviewTransfInfo(self._heroId)
	local pos = transfInfo.pos
	local rot = transfInfo.rot

	Astral.TransformUtil.SetLocalPos(modelGo.transform, pos.x, pos.y, pos.z)
	Astral.TransformUtil.SetLocalRotation(modelGo.transform, rot.x, rot.y, rot.z)

	local animationPlayer = AnimationPlayer.Get(modelGo)
	local animRes = self:_getResource(self._idleAnimPath)

	if animRes then
		local animClip = animRes.res:GetMainAsset()

		animationPlayer:ReplaceClip(kDefaultAnim, animClip)
		animationPlayer:PlayAnimation(kDefaultAnim, true, true)
		animationPlayer:Evaluate()
	end

	local modelId = self._heroCfgInfo.modelId
	local xinMao = Astral.SimpleLuaComponentContainer.Add(modelGo.gameObject, UnitCompHeroXinMao)

	xinMao:setInfo(modelId, modelGo.gameObject)
	self._photoSpace:showTarget(modelGo, true)
	self._photoSpace:enableTouch(nil, Handler.New(self._onBeginDrag, self), Handler.New(self._onDrag, self))
	self:_showPhoto(true)
end

function M:_showPhoto(active)
	self._canvasGroupHero.alpha = active and 1 or 0
end

function M:_getResource(path)
	return self._resMap[path]
end

function M:_refreshPosition(lightOn)
	local producer = self._photoSpace:getProducer()

	if producer then
		if not lightOn then
			local pos = PhotoUtil.GetPosition(producer.counter)

			GameUtils.setPos(producer.producerContainer, pos.x, pos.y, pos.z)
		else
			GameUtils.setPos(producer.producerContainer, 500, 500, 0)
		end
	end
end

function M:_onBeginDrag(x, y, pointerId)
	self._dragPos:Set(x, y)

	if goutil.isNil(self._tranfModel) then
		self._tranfModel = self:_getResource(self._modelPath).go.transform
	end
end

function M:_onDrag(x, y, pointerId)
	local degree = (self._dragPos.x - x) * RotateFactor

	self._dragPos:Set(x, y)

	local rotX, rotY, rotZ = Astral.TransformUtil.GetLocalRotation(self._tranfModel, nil, nil, nil)

	Astral.TransformUtil.SetLocalRotation(self._tranfModel, rotX, rotY + degree, rotZ)
end

function M:_onCamCtrl(e, camCo)
	self._photoSpace:setCameraPosition(camCo.pos)
	self._photoSpace:setCameraRotation(camCo.rot)
	self._photoSpace:setCameraFov(camCo.fov)
end

function M:_onPosCtrl(e, posCo)
	local modelRes = self:_getResource(self._modelPath)
	local modelGo = modelRes.go
	local pos = posCo.pos
	local rot = posCo.rot

	Astral.TransformUtil.SetLocalPos(modelGo.transform, pos.x, pos.y, pos.z)
	Astral.TransformUtil.SetLocalRotation(modelGo.transform, rot.x, rot.y, rot.z)
end

return M
