local var_0_0 = g.core.model.User.teamPvpData
local var_0_1 = g.core.const.ConstMgr.TeamPvpConst
local TeamPVPMapInfoComp = class("TeamPVPMapInfoComp", require("app.fairyGUI.teamPVP.UI_TeamPVPMapInfoComp"))

function TeamPVPMapInfoComp:ctor()
	return
end

function TeamPVPMapInfoComp:updateMapInfo(arg_2_1)
	self.m_mapName:setText(arg_2_1.name)
	self.m_mapDesc:setText(arg_2_1.des)
	self.m_mapLoader:setURL(g.core.common.Path:getTeamPVPThumbnail(arg_2_1.mapId))
end

function TeamPVPMapInfoComp:updateAddition()
	local var_3_0 = {
		type = 0
	}

	var_3_0.value = var_0_0:isHotTime() and var_0_0:getTeamPVPParameterById(var_0_1.PARAMETER_ID.HOT_TIME_SCORE) / 10 or 0

	self.m_timeAddition:updateComp(var_3_0)
	self.m_teamAddition:updateComp({
		type = 1,
		value = var_0_0:getAddition()
	})
end

return TeamPVPMapInfoComp
