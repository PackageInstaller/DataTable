-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/scene/stage/RetrieveSceneStage.lua

module("logic.extensions.retrieve.scene.stage.RetrieveSceneStage", package.seeall)

local M = class("RetrieveSceneStage", SceneStageBase)
local kMainSceneBgName = "s410_obj_plan_b"

function M:onInit()
	self._resLoader = false
	self._sceneName = false
	self._sceneNodeMap = false
	self._sceneCardRoot = false
	self._bgSceneMatSetter = false
	self._curActiveName = false
end

function M:load(sceneId)
	local resLoader = self._resLoader

	if not resLoader then
		self._resLoader = MultiResLoader.New()
		resLoader = self._resLoader
	end

	self._sceneNodeMap = {}

	local sceneCO = SceneConfig.instance:getSceneCO(sceneId)

	self._sceneName = SceneCOUtil.getSceneName(sceneCO)

	resLoader:addResPath(GameUrl.getSceneUrl(sceneCO.resPath), false)
	resLoader:addResPath(ResName.RetrieveMainView, false)
	resLoader:addResPath(ResName.RetrieveRoleShowView, false)

	local bgResList = LotteryUtil.getAllLotteryBgRes()

	for i = 1, #bgResList do
		resLoader:addResPath(bgResList[i], false)
	end

	resLoader:load(self._onAllResourceLoaded, false, self)
end

function M:_onAllResourceLoaded()
	local resLoader = self._resLoader

	if not resLoader:isAllSuccess() and enableErrorLog then
		printError("load resource failed!")
	end

	self:_onAllLoaded()
	self:_cacheSceneNode()
	self:_cacheSceneBgCom()
	self:activeSceneByName(RetrieveEnum.SceneNameMap.Main)
end

function M:_cacheSceneNode()
	for _, v in pairs(RetrieveEnum.SceneNameMap) do
		local sceneNode = self:getGoList(v, 10)[1]

		if not goutil.isNil(sceneNode) then
			table.insert(self._sceneNodeMap, sceneNode)
		end
	end

	self._sceneCardRoot = self:getGoList("retrieve_ten_card_show_scene_view", 100)[1]
end

function M:_cacheSceneBgCom()
	local bgSceneGo = self:getGoList(kMainSceneBgName, 100)[1]

	if bgSceneGo and not goutil.isNil(bgSceneGo) then
		self._bgSceneMatSetter = bgSceneGo:GetComponent("MeshRenderer")
	elseif isInEditorMode then
		printError("无法找到抽卡主场景中背景面片", kMainSceneBgName)
	end
end

function M:getSceneName()
	return "false"
end

function M:changeBgScene(name)
	if string.nilorempty(name) then
		return
	end

	local resPath = GameUrl.getRetrieveSceneBgMat(name)
	local resLoader = self._resLoader
	local _matRes = resLoader:getResource(resPath)

	if self._bgSceneMatSetter and _matRes then
		self._bgSceneMatSetter.material = _matRes:GetMainAsset()
	end
end

function M:activeSceneByName(name)
	self._curActiveName = name

	for _, v in pairs(self._sceneNodeMap) do
		goutil.setActive(v, name == v.name)
	end
end

function M:actionShowScene()
	for _, v in pairs(self._sceneNodeMap) do
		goutil.setActive(v, RetrieveEnum.SceneNameMap.Show == v.name)
	end
end

function M:actionResultScene()
	for _, v in pairs(self._sceneNodeMap) do
		goutil.setActive(v, RetrieveEnum.SceneNameMap.Result == v.name)
	end
end

function M:getSceneCardRoot()
	return self._sceneCardRoot
end

function M:getGoList(name, num)
	local goList = {}

	GameObjectUtils.FindChildRecursivelyBySceneName(self._sceneName, 100, name, goList)

	return goList
end

function M:unload()
	if self._resLoader then
		self._resLoader:clear()
	end

	self._sceneNodeMap = false
end

function M:onLeaveScene(isDeepClean)
	self._lastActiveScene = self._curActiveName

	self:activeSceneByName("empty")
end

function M:onReturnScene(isDeepClean)
	if self._lastActiveScene then
		self:activeSceneByName(self._lastActiveScene)

		self._lastActiveScene = false
	end
end

function M:onReturnSceneFinished(isDeepClean)
	return
end

return M
