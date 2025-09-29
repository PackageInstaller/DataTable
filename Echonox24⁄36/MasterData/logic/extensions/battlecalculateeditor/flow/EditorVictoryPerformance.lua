-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlecalculateeditor/flow/EditorVictoryPerformance.lua

module("logic.extensions.battlecalculateeditor.flow.EditorVictoryPerformance", package.seeall)

local M = class("EditorVictoryPerformance")
local TEMP_ROTATION_MAP = {
	[100043] = -20,
	[100010] = -20,
	[100021] = -25,
	[100056] = 30,
	[100007] = -15,
	[100031] = -25,
	[100053] = -15,
	[100008] = -15,
	[100019] = -20,
	[100011] = -25,
	[100005] = 15,
	[100047] = 16,
	[100028] = -30
}

function M:ctor()
	self._resLoader = BattleMultiResLoaderIncludeModel.New()
	self._goVictory = false
	self._directorSetter = false
	self._modelCode = false
end

function M:reset()
	SpaceX.OutlineFeatureUtils.UpdateOutlineDepth(false)

	if self._unit then
		self._unit:returnSelf()
	end

	if self._goVictory then
		goutil.destroy(self._goVictory)

		self._goVictory = nil
	end

	self._resLoader:clear()
	self:_resumeSceneEnvironment()

	if self._directorSetter then
		self._directorSetter:Clear()

		self._directorSetter = nil
	end

	self._modelCode = nil
end

function M:destroy()
	self:reset()
end

function M:start()
	SpaceX.OutlineFeatureUtils.UpdateOutlineDepth(true)

	self._modelCode = 100008

	self:_startloadRes()
end

function M:stop()
	SpaceX.BattleCalculateEditorEnterUtil.CloseCalculateEditor()
	self:destroy()
end

function M:onSwitchScene()
	self:_setupSceneEnvironment()
end

function M:onSwitchHero(modelId)
	local co = ModelConfig.instance:getModelConfig(modelId)

	if not co then
		return
	end

	self._modelCode = modelId and modelId or self._modelCode

	self:_showSelectUnit()
	self:_playTimeline()
end

function M:_setupSceneEnvironment()
	SkillPerformanceAssistant:hideSceneObjectRoot()
	SkillPerformanceAssistant:hideUIProperties()

	local fullscreenRoot = ViewMgr.instance:getRoot(ViewRootType.FullScreen)

	goutil.setActive(fullscreenRoot, false)

	local battleScene = SceneMgr.instance:getScene(SceneType.BattleCalculateEditor)

	battleScene.stage:activeAdditionScene()
	battleScene.light:activePerformanceLight()
	SpaceX.BattleCalculateEditorEnterUtil.OnSceneLightUpdate(battleScene.light:getAdditionLightGameObject())
end

function M:_resumeSceneEnvironment()
	SpaceX.BattleCalculateEditorEnterUtil.OnSceneLightUpdate(nil)
	SkillPerformanceAssistant:showSceneObjectRoot()
	SkillPerformanceAssistant:showUIProperties()

	local fullscreenRoot = ViewMgr.instance:getRoot(ViewRootType.FullScreen)

	goutil.setActive(fullscreenRoot, true)

	local curSceneType = SceneMgr.instance:getCurSceneType()
	local curSceneId = SceneMgr.instance:getCurSceneId()
	local battleScene = SceneMgr.instance:getScene(SceneType.BattleCalculateEditor)

	if curSceneId == self._sceneId and curSceneType > 0 then
		battleScene.stage:activeMainScene()
		battleScene.light:activeNormalLight()
	end
end

function M:_startloadRes()
	VirtualCameraMgr.instance:setBlendDuration(0)

	self._modelCode = self:_getModelId()

	self._resLoader:addNormalRes(BattleResourceName.CalculateVictory)

	if self._modelCode then
		local modelCO = ModelConfig.instance:getModelConfig(self._modelCode)

		self._resLoader:addModelRes(ModelCOUtil.getHighModelUrl(modelCO))
	end

	self._resLoader:load(self._onResourceLoaded, self)
end

function M:_onResourceLoaded()
	local resource = self._resLoader:getResource(BattleResourceName.CalculateVictory)

	self._goVictory = goutil.clone(resource:GetMainAsset())

	self:_setupSceneEnvironment()
	self:_showSelectUnit()
	self:_playTimeline()
	self:_openWindow()
end

function M:_openWindow()
	local goVictory = self._goVictory
	local sceneRoot = SceneMgr.instance:getSceneRoot()

	if goVictory then
		goutil.addChildToParent(goVictory, sceneRoot)
		goutil.setActive(goVictory, true)
		SpaceX.BattleCalculateEditorEnterUtil.OpenCalculateEditor(self._onSelect, self)
	end
end

function M:_onSelect(type, param)
	if type == "sceneSwitch" then
		SpaceX.BattleCalculateEditorEnterUtil.OnSceneLightUpdate(nil)

		local model = BattleMgr.instance:getModel()

		model:setScenePath(param)
		SceneMgr.instance:enter(SceneType.BattleCalculateEditor, model:getSceneCode(), 0, 0)
	elseif type == "heroSwitch" then
		self:onSwitchHero(param)
	end
end

function M:_showSelectUnit()
	local unit = self:_changeUnit(self._modelCode)

	if unit then
		local heroroot = goutil.findChild(self._goVictory, "heroroot")

		SkillPerformanceAssistant:switchUnit2HighModel(unit)
		unit.property:clearAllState()
		unit.stateEffect:clearAllStateEffect()
		unit.meshModel:lookAtDirVec3(MeshModelDirection.Forward)
		unit.meshModel:setPlaySpeed(1)
		unit.meshModel:play(UnitAnimState.VictoryIdle, true, true)
		unit.effectPlayer:clearAllEffect()

		local goUnit = unit:getGameObject()

		BattleCalculateEditorUnitGenerator.addUnitToRoot(unit, heroroot)
	end
end

function M:_playTimeline()
	return
end

function M:_changeUnit(modelId)
	if self._unit then
		self._unit:returnSelf()
	end

	local entityInfo = BattleUnitUtil.createHeroEntityInfoWithoutAttr(modelId)
	local unit = BattleCalculateEditorUnitGenerator.createUnit(entityInfo)

	unit.meshModelMover:playIdle()
	entityInfo:returnSelf()

	self._unit = unit

	return unit
end

function M:_getModelId()
	local modelCode = self._modelCode
	local modelCO = ModelConfig.instance:getModelConfig(modelCode)

	return modelCode
end

return M
