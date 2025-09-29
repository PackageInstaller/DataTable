-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/preface/flow/PrefaceBattleWorkExit.lua

module("logic.extensions.preface.flow.PrefaceBattleWorkExit", package.seeall)

local M = class("PrefaceBattleWorkExit", WorkBase)

function M:ctor(isLastBattle)
	self._isLastBattle = isLastBattle
end

function M:onEnter(context)
	self.model = context.model

	SceneMgr.instance:exitCurScene()
	VirtualCameraMgr.instance:clearFollowConfiner()

	if self._isLastBattle then
		PrefaceController.instance:simulationCloseSystem()
	end

	GuideController.instance:tryEnterFirstScene()
	self:onDone(WorkResult.Succeed)
end

return M
