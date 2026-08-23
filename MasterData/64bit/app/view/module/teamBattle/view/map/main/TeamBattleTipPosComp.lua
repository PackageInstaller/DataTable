local ExplorationAnglePosIcon = require("app.view.module.exploration.view.ExplorationAnglePosIcon")
local TeamBattleTipPosComp = class("TeamBattleTipPosComp", ExplorationAnglePosIcon, require("app.fairyGUI.teamBattle.UI_TeamBattleTipPosComp"))

function TeamBattleTipPosComp:ctor()
	ExplorationAnglePosIcon.ctor(self)

	self._baseRotation = -50
	self._rotationNode = self.m_rotateImg

	self:updateRoleIcon()
	self:addClickListener(handler(self, self._onClicked))
end

function TeamBattleTipPosComp:updateRoleIcon()
	self.m_headText:setIcon(g.core.common.Path:getRoleHeadIcon(g.core.config.knight_base_info.get(g.core.config.knight_info.get(g.core.model.User:getUserData().base_id).res_id).icon_id))
end

function TeamBattleTipPosComp:calcBorderAngle()
	ExplorationAnglePosIcon.calcBorderAngle(self)
end

function TeamBattleTipPosComp:_updateArrow(arg_4_1, arg_4_2)
	return ExplorationAnglePosIcon._updateArrow(self, arg_4_1, arg_4_2)
end

function TeamBattleTipPosComp:updateCompAngleAndPos(arg_5_1, arg_5_2, arg_5_3)
	ExplorationAnglePosIcon.updateCompAngleAndPos(self, arg_5_2, arg_5_1, arg_5_3)
end

function TeamBattleTipPosComp:_onClicked()
	self:dispatchCompEvent("moveToRole")
end

return TeamBattleTipPosComp
