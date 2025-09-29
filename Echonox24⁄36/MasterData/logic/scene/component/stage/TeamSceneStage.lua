-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/component/stage/TeamSceneStage.lua

module("logic.scene.component.stage.TeamSceneStage", package.seeall)

local TeamSceneStage = class("TeamSceneStage", SceneStageBase)
local positionKey = "map510_sm_cube_pos"
local lightKey = "map510_emi_pos"
local campkey = "map510_decal_pos"
local emptykey = "team_empty_pos"
local kBaseColorID = UnityEngine.Shader.PropertyToID("_BaseColor")
local kBaseMapID = UnityEngine.Shader.PropertyToID("_BaseMap")

function TeamSceneStage:onInit()
	self._resLoader = false
	self._mainSceneName = false
	self._posList = false
	self._lightList = false
	self._campList = false
	self._emptyEffectList = false
end

function TeamSceneStage:load(sceneId)
	local resLoader = self._resLoader

	if not resLoader then
		self._resLoader = MultiResLoader.New()
		resLoader = self._resLoader
	end

	local sceneCO = SceneConfig.instance:getSceneCO(sceneId)

	self._mainSceneName = SceneCOUtil.getSceneName(sceneCO)

	resLoader:addResPath(GameUrl.getSceneUrl(sceneCO.resPath), false)
	resLoader:load(self._onAllResourceLoaded, false, self)
end

function TeamSceneStage:getSceneName()
	return self._mainSceneName
end

function TeamSceneStage:_onAllResourceLoaded()
	local resLoader = self._resLoader

	if not resLoader:isAllSuccess() and enableErrorLog then
		printError("load resource failed!")
	end

	self._posList = self:getGoList(positionKey)
	self._lightList = self:getGoList(lightKey)
	self._campList = self:getGoList(campkey)
	self._lightMatSetter = {}
	self._campMatSetter = {}

	for i = 1, #self._lightList do
		self._lightMatSetter[i] = MaterialSetter.Get(self._lightList[i])

		if self._lightMatSetter[i] then
			self._lightMatSetter[i]:SetGameObject(self._lightList[i])
		end

		goutil.setActive(self._lightList[i], false)
	end

	for i = 1, #self._campList do
		self._campMatSetter[i] = MaterialSetter.Get(self._campList[i])

		if self._campMatSetter[i] then
			self._campMatSetter[i]:SetGameObject(self._campList[i])
		end

		goutil.setActive(self._campList[i], false)
	end

	self._emptyEffectList = self:getGoList(emptykey)

	for i = 1, #self._emptyEffectList do
		goutil.setActive(self._emptyEffectList[i], false)
	end

	SceneUtil.removeArtTestSceneGameObject(self._mainSceneName)
	self:_onAllLoaded()
end

function TeamSceneStage:unload()
	if self._resLoader then
		self._resLoader:clear()
	end

	table.clear(self._posList)
	table.clear(self._lightList)
	table.clear(self._campList)

	for i = 1, #self._lightMatSetter do
		self._lightMatSetter[i]:Clear()
	end

	for i = 1, #self._campMatSetter do
		self._campMatSetter[i]:Clear()
	end

	table.clear(self._lightMatSetter)
	table.clear(self._campMatSetter)
	table.clear(self._emptyEffectList)
end

function TeamSceneStage:getGoList(name)
	local goList = {}

	GameObjectUtils.FindChildRecursivelyBySceneName(self._mainSceneName, 100, name, goList)

	return goList
end

function TeamSceneStage:getPosList()
	return self._posList
end

function TeamSceneStage:getLightList()
	return self._lightList
end

function TeamSceneStage:getCampList()
	return self._campList
end

function TeamSceneStage:getEmptyList()
	return self._emptyEffectList
end

function TeamSceneStage:getPosKey()
	return positionKey
end

function TeamSceneStage:getLightKey()
	return lightKey
end

function TeamSceneStage:getCampKey()
	return campkey
end

function TeamSceneStage:getEmptyKey()
	return emptykey
end

function TeamSceneStage:setEemptyState(index, active)
	goutil.setActive(self._emptyEffectList[index], active)
end

function TeamSceneStage:setLight(index, colorString)
	if not self._lightMatSetter then
		return
	end

	if not colorString then
		goutil.setActive(self._lightList[index], false)

		return
	end

	goutil.setActive(self._lightList[index], true)
	self._lightMatSetter[index]:SetColor(kBaseColorID, colorString.r, colorString.g, colorString.b)
end

function TeamSceneStage:setCamp(index, texture)
	if not self._campMatSetter then
		return
	end

	goutil.setActive(self._campList[index], texture and true or false)

	if texture then
		self._campMatSetter[index]:SetTexture(kBaseMapID, texture)
	end
end

return TeamSceneStage
