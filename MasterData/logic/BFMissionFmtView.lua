-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/BFMissionFmtView.lua

module("logic.extensions.mission.view.BFMissionFmtView", package.seeall)

local BFMissionFmtView = class("BFMissionFmtView", MissionFmtView)

function BFMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

function BFMissionFmtView:_getCreepCos()
	local fightId = checknumber(self._viewPresentor._openParam[1])
	local monsterId = checknumber(self._viewPresentor._openParam[2])
	local isHell = checkbool(self._viewPresentor._openParam[3])
	local levelCfg, cCfg

	if isHell == true then
		levelCfg = BreakFormationConfig.instance:getHellMonsterCfg(fightId, monsterId)
		cCfg = BreakFormationConfig.instance:getHellCreepCfg(fightId, monsterId)
	else
		levelCfg = BreakFormationConfig.instance:getMonsterCfg(fightId, monsterId)
		cCfg = BreakFormationConfig.instance:getCreepCfg(fightId, monsterId)
	end

	return cCfg
end

function BFMissionFmtView:_getMonsterCo()
	local fightId = checknumber(self._viewPresentor._openParam[1])
	local monsterId = checknumber(self._viewPresentor._openParam[2])
	local isHell = checkbool(self._viewPresentor._openParam[3])
	local levelCfg, cCfg

	return isHell == true and BreakFormationConfig.instance:getHellMonsterCfg(fightId, monsterId) or BreakFormationConfig.instance:getMonsterCfg(fightId, monsterId)
end

return BFMissionFmtView
