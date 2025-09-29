-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/scene/judge/RogueJudgeSceneStage.lua

module("logic.extensions.roguelike.scene.judge.RogueJudgeSceneStage", package.seeall)

local M = class("RogueJudgeSceneStage", SceneStageBase)

function M:onInit()
	self._resLoader = false
	self._sceneName = false
end

function M:load(sceneId)
	local resLoader = self._resLoader

	if not resLoader then
		self._resLoader = MultiResLoader.New()
		resLoader = self._resLoader
	end

	local sceneCO = SceneConfig.instance:getSceneCO(sceneId)

	self._sceneName = SceneCOUtil.getSceneName(sceneCO)

	resLoader:addResPath(GameUrl.getSceneUrl(sceneCO.resPath), false)
	resLoader:load(self._onAllResourceLoaded, false, self)
end

function M:initRogue()
	if RogueMgr.instance:isInRogue() then
		return
	end

	local tb = {}

	tb.roleIds = {}

	local allRoleState = RoguelikeModel.instance:getAllRoleState()

	if allRoleState == nil then
		print("组队完成但是没角色")

		return
	end

	for k, v in pairs(allRoleState) do
		table.insert(tb.roleIds, v.code)
	end

	RogueMgr.instance:enter(tb)
	FloatWordMgr.instance:show("选择角色完成")
end

function M:_onAllResourceLoaded()
	local resLoader = self._resLoader

	if not resLoader:isAllSuccess() and enableErrorLog then
		printError("load resource failed!")
	end

	SceneUtil.removeArtTestSceneGameObject(self._sceneName)
	VirtualCameraMgr.instance:setActiveCamera(VirtualCameraName.RogueJudge)
	VirtualCameraMgr.instance:setFollowConfiner("confiner_roguelike_judge")
	SceneLoadUtils.SetActiveScene(self._sceneName)
	self:_onAllLoaded()
	MainCameraMgr.instance:setCameraVisible(true)
end

function M:unload()
	if self._resLoader then
		self._resLoader:clear()
	end
end

return M
