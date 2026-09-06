-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/mission/AnheimmMissionFmtView.lua

module("logic.extensions.timelimitedchallenge.view.mission.AnheimmMissionFmtView", package.seeall)

local AnheimmMissionFmtView = class("AnheimmMissionFmtView", MissionFmtView)

function AnheimmMissionFmtView:_getCreepCos()
	local monsterCfg = self:_getMonsterCo()

	return AnheimmConfig.instance:getCreepCfgsById(monsterCfg.creepsMasterId)
end

function AnheimmMissionFmtView:_getMonsterCo()
	local monsterId = AnheimmModel.instance:getCurMonsterId()

	return AnheimmConfig.instance:getChallengeCfgById(monsterId)
end

function AnheimmMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()

	self._powerTxt.text = "？？？"
	self._speed.text = "？？？"
end

function AnheimmMissionFmtView:_onClickPower()
	FloatWordMgr.instance:show("全员战斗力:？？？")
end

function AnheimmMissionFmtView:_onClickSpeed()
	FloatWordMgr.instance:show("全员速度:？？？")
end

function AnheimmMissionFmtView:_selectItem(index, isUp)
	if self._infoSeats[index] then
		local param = clone(self._infoSeats[index])

		param.hideZdl = true

		CommonTipsMgr.instance:showPetTips(param)
	end
end

return AnheimmMissionFmtView
