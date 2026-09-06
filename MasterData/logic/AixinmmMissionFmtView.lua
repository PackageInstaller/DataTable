-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aixinmm/view/AixinmmMissionFmtView.lua

module(..., package.seeall)

local AixinmmMissionFmtView = class("AixinmmMissionFmtView", MissionFmtView)

function AixinmmMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()

	self._powerTxt.text = "？？？"
	self._speed.text = "？？？"
end

function AixinmmMissionFmtView:_getCreepCos()
	local masterId = self:getFirstParam()

	return AixinmmConfig.instance:getCreepCfgs(masterId) or {}
end

function AixinmmMissionFmtView:_selectItem(index)
	if self._infoSeats[index] then
		local param = clone(self._infoSeats[index])

		param.hideZdl = true

		CommonTipsMgr.instance:showPetTips(param)
	end
end

return AixinmmMissionFmtView
