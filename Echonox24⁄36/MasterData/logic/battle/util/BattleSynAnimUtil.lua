-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/util/BattleSynAnimUtil.lua

module("logic.battle.util.BattleSynAnimUtil", package.seeall)

function BattleSynAnimUtil.playAnimSyn(anim, name)
	local activeFlow = BattleMgr.instance:getActiveBattleFlow()

	if activeFlow and activeFlow.loopAnimSynMgr then
		activeFlow.loopAnimSynMgr:playAnimSyn(anim, name)
	end
end

function BattleSynAnimUtil.stopAnim(anim)
	local activeFlow = BattleMgr.instance:getActiveBattleFlow()

	if activeFlow and activeFlow.loopAnimSynMgr then
		activeFlow.loopAnimSynMgr:stopAnim(anim)
	end
end

return BattleSynAnimUtil
