-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/mission/mission/AceteamMissionFmtView.lua

module("logic.extensions.aceteam.view.mission.mission.AceteamMissionFmtView", package.seeall)

local AceteamMissionFmtView = class("AceteamMissionFmtView", MissionFmtView)

function AceteamMissionFmtView:onEnter()
	self._isHideZdl = true

	AceteamMissionFmtView.super.onEnter(self)
end

function AceteamMissionFmtView:_getCreepCos()
	local monsterCfg = self:_getMonsterCo()

	return AceTeamConfig.instance:getCreepsCfg(monsterCfg.creepsMasterId)
end

function AceteamMissionFmtView:_getMonsterCo()
	local params = self:getOpenParam()
	local creepsMasterId = params[1]

	return AceTeamConfig.instance:getMonsterCfg(creepsMasterId)
end

function AceteamMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()

	if self._isHideZdl then
		self._powerTxt.text = "？？？"
		self._speed.text = "？？？"
	end
end

function AceteamMissionFmtView:_onClickPower()
	if self._isHideZdl then
		FloatWordMgr.instance:show("全员战斗力:？？？")
	else
		AceteamMissionFmtView.super._onClickPower(self)
	end
end

function AceteamMissionFmtView:_onClickSpeed()
	if self._isHideZdl then
		FloatWordMgr.instance:show("全员速度:？？？")
	else
		AceteamMissionFmtView.super._onClickSpeed(self)
	end
end

function AceteamMissionFmtView:_selectItem(index, isUp)
	if self._isHideZdl then
		if self._infoSeats[index] then
			local param = clone(self._infoSeats[index])

			param.hideZdl = true

			CommonTipsMgr.instance:showPetTips(param)
		end
	else
		AceteamMissionFmtView.super._selectItem(self, index, isUp)
	end
end

return AceteamMissionFmtView
