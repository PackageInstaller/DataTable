-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/work/display/WorkJudgeMapAnimation.lua

module("logic.extensions.roguelike.flow.work.display.WorkJudgeMapAnimation", package.seeall)

local M = class("WorkJudgeMapAnimation", WorkBase)

function M:onEnter(context)
	local mapMgr = RogueMgr.instance:getMapMgr()
	local scene = SceneMgr.instance:getScene(SceneType.RunGroup)

	if context.isDown then
		if RoguelikeConst.IsPreloadScene then
			scene.stage:activeJudgeScene()
			mapMgr:generateColliders()
			self:onDone(WorkResult.Succeed)
		else
			mapMgr:generateJudgeGrids(function()
				mapMgr:generateColliders()
				self:onDone(WorkResult.Succeed)
			end)
		end
	else
		if RoguelikeConst.IsPreloadScene then
			scene.stage:recoverSceneByExitJudgeScene()
		end

		mapMgr:clearJudgeGrids()
		self:onDone(WorkResult.Succeed)
	end
end

function M:onExit(isInterrupt)
	return
end

return M
