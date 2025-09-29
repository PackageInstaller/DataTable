-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/defaultwork/WorkPreviewTargetCameraEffect.lua

module("logic.battle.battleflow.defaultwork.WorkPreviewTargetCameraEffect", package.seeall)

local M = class("WorkPreviewTargetCameraEffect", WorkBase)

function M:ctor()
	M.super.ctor(self)
end

function M:onEnter(context)
	if OOPUtil.isInstanceOf(context, LevelBattleFlowBase) then
		local cmd = BattlePreviewTaskTargetCommand:create()

		cmd:setCommandHandler(self)
		cmd:execute(context, context.winCondition:getAdditionalWinConditionTags(), context.winCondition:getAdditionalLoseConditionTags())
	else
		self:onCommandFinish()
	end
end

function M:onExit(isInterrupt)
	self:_clearUnitSigns()
end

function M:onCommandFinish()
	self:onDone(WorkResult.Succeed)
end

function M:_clearUnitSigns()
	local unitMgr = self.context.unitMgr
	local units = unitMgr:getAllUnits()

	for _, unit in pairs(units) do
		if unit.property:isMaskEnable(BattleUnitFlagMask.MaskAttackable) then
			unit.uiProxy:destroySignUI()
		end
	end
end

return M
