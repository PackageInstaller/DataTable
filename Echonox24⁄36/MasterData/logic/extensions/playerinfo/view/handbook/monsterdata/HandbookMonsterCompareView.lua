-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/monsterdata/HandbookMonsterCompareView.lua

module("logic.extensions.playerinfo.view.handbook.monsterdata.HandbookMonsterCompareView", package.seeall)

local M = class("HandbookMonsterCompareView", ViewComponent)

function M:buildUI()
	self._rawImg = self:getUIComponent("handbook_mosterdata_preview_view_229375611", UIComponentType.RawImage)
	self._photoUnit = Astral.LuaComponentContainer.Add(self._rawImg.gameObject, PhotoMultiModel)

	self._photoUnit:setDefaultAnim(UnitAnimState.Idle2)
	self._photoUnit:setLightCode(8)
	self._photoUnit:setModelsLoadedCallback(self._onModelsLoaded, self)
	self._photoUnit:enableTouch(nil, Handler.New(self._onBeginDragModel, self), Handler.New(self._onDragModel, self), Handler.New(self._onEndDragModel, self))
end

function M:onEnter()
	local monsterId = self:getFirstParam()
	local handbookCfg = HandbookConfig.instance:getConfigByKey(ConfigName.GalleryMonster, monsterId)
	local cfgMonster = MonsterConfig.instance:getMonsterCO(monsterId)
	local leftModelId = cfgMonster.modelId
	local rightModelId = HandbookConfig.instance:getConst("CompareRightModelId").numValue
	local leftModelCO = ModelConfig.instance:getModelConfig(leftModelId)
	local rightModelCO = ModelConfig.instance:getModelConfig(rightModelId)
	local leftClipCO = CutImageConfig.instance:getClipCO(leftModelId)
	local leftInfo = leftClipCO:getDoubleModelClipInfoArr("leftPosInfo")
	local rightInfo = handbookCfg and handbookCfg.posRightInfo or nil

	self._photoUnit:setContainerPosInfos({
		leftInfo,
		rightInfo
	})
	self._photoUnit:showModels({
		GameUrl.getHighMeshModelUrl(leftModelCO.resName),
		GameUrl.getHighMeshModelUrl(rightModelCO.resName)
	})
end

function M:onExit()
	self._photoUnit:clear()
end

function M:_onBeginDragModel(posX, posY, pointerId)
	self._lastPosX = posX
end

function M:_onDragModel(posX, posY, pointerId)
	local deltaX = posX - self._lastPosX

	self:_rotaModel(deltaX)

	self._lastPosX = posX
end

function M:_onEndDragModel(posX, posY, pointerId)
	return
end

function M:_rotaModel(deltaX)
	local _, rotaY, _ = self._photoUnit:getContainerRotation(1)
	local rotationY = rotaY + -deltaX

	self._photoUnit:setContainerRotationY(1, rotationY)
end

function M:_onModelsLoaded()
	self._photoUnit:showUIReflection()
	self._photoUnit:setCameraCullingMask(Astral.LayerUtil.GetLayerMask(SceneLayer.UI3D, SceneLayer.Unit))
	self._photoUnit:setCameraTag(SceneTag.RendererFeatureCamera)
end

return M
