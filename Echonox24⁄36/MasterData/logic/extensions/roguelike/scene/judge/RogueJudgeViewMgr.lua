-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/scene/judge/RogueJudgeViewMgr.lua

module("logic.extensions.roguelike.scene.judge.RogueJudgeViewMgr", package.seeall)

local M = class("RogueJudgeViewMgr", ISceneFlowComp)

function M:onEnter()
	self:_setEvent(true)
	ViewMgr.instance:close(ViewName.MainUIView)
	ViewMgr.instance:close(ViewName.RogueTestMenu)
	ViewMgr.instance:close(ViewName.RogueMap)

	local monsterId = RogueMgr.instance:getModel():getCurMonsterId()
	local eventInfo = RogueMgr.instance:getModel():getCurEventInfo()

	if monsterId then
		ViewMgr.instance:open(ViewName.RogueMonsterJudge, monsterId)
		RogueMgr.instance:getModel():setCurMonsterId(nil)
	elseif eventInfo then
		ViewMgr.instance:open(ViewName.RogueEventJudge, eventInfo)
		RogueMgr.instance:getModel():setCurEventInfo(nil)
	end
end

function M:onExit()
	self:_setEvent(false)
	ViewMgr.instance:close(ViewName.RogueMonsterJudge)
	ViewMgr.instance:close(ViewName.RogueEventJudge)
end

function M:_setEvent(add)
	if add then
		-- block empty
	end
end

return M
