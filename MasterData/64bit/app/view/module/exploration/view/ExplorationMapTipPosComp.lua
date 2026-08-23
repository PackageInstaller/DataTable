local ExplorationAnglePosIcon = require("app.view.module.exploration.view.ExplorationAnglePosIcon")
local ExplorationMapTipPosComp = class("ExplorationMapTipPosComp", ExplorationAnglePosIcon, require("app.fairyGUI.exploration.UI_ExplorationMapTipPosComp"))

function ExplorationMapTipPosComp:ctor()
	ExplorationAnglePosIcon.ctor(self)

	self._baseRotation = -50
	self._rotationNode = self.m_rotateImg

	self:updateRoleIcon()
	self:addClickListener(handler(self, self._onClicked))
end

function ExplorationMapTipPosComp:updateRoleIcon()
	self.m_headText:getChild("icon"):updateAsUser(g.core.model.User:getUserData())
end

function ExplorationMapTipPosComp:calcBorderAngle()
	ExplorationAnglePosIcon.calcBorderAngle(self)
end

function ExplorationMapTipPosComp:_updateArrow(arg_4_1, arg_4_2)
	return ExplorationAnglePosIcon._updateArrow(self, arg_4_1, arg_4_2)
end

function ExplorationMapTipPosComp:updateCompAngleAndPos(arg_5_1, arg_5_2, arg_5_3)
	ExplorationAnglePosIcon.updateCompAngleAndPos(self, arg_5_2, arg_5_1, arg_5_3)
end

function ExplorationMapTipPosComp:_onClicked()
	self:dispatchCompEvent("moveToRole")
end

return ExplorationMapTipPosComp
