-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/defaultwork/WorkBattlePlayBossAnimation.lua

module("logic.battle.battleflow.defaultwork.WorkBattlePlayBossAnimation", package.seeall)

local M = class("WorkBattlePlayBossAnimation", WorkBase)

function M:onEnter(context)
	if context.model:getGamePlay() ~= BattleEnum.GamePlayType.NORMAL then
		self:_onAnimationPlayFinish()

		return
	end

	local dungeonCode = BattleEnterUtil.getCurrentDungeonCode()
	local hasAnimation = false

	if dungeonCode then
		local dungeonCO = DungeonConfig.instance:getDungeonCfgById(dungeonCode)

		if dungeonCO and not string.nilorempty(dungeonCO.video) then
			GlobalDispatcher:addEventListener(EventType.BOSS_ANIMATION_PLAY_FINISH, self._onAnimationPlayFinish, self)
			ViewMgr.instance:open(ViewName.BattlePlayAnimation, dungeonCO.video)

			hasAnimation = true
		end
	end

	if not hasAnimation then
		self:_onAnimationPlayFinish()
	end
end

function M:onExit(isInterrupt)
	ViewMgr.instance:close(ViewName.BattlePlayAnimation)
	GlobalDispatcher:removeEventListener(EventType.BOSS_ANIMATION_PLAY_FINISH, self._onAnimationPlayFinish, self)
end

function M:_onAnimationPlayFinish()
	self:onDone(WorkResult.Succeed)
end

return M
