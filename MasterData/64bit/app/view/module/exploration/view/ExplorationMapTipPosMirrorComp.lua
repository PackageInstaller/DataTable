local ExplorationAnglePosIcon = require("app.view.module.exploration.view.ExplorationAnglePosIcon")
local ExplorationMapTipPosMirrorComp = class("ExplorationMapTipPosMirrorComp", ExplorationAnglePosIcon, require("app.fairyGUI.exploration.UI_ExplorationMapTipPosMirrorComp"))

function ExplorationMapTipPosMirrorComp:ctor()
	ExplorationAnglePosIcon.ctor(self)

	self._baseRotation = -50
	self._rotationNode = self.m_rotationImg

	self.m_icon:setURL("icon/exploration/icon_slmj_jingzi_128.png")
	self:addClickListener(handler(self, self._onClicked))
end

function ExplorationMapTipPosMirrorComp:calcBorderAngle()
	ExplorationAnglePosIcon.calcBorderAngle(self)
end

function ExplorationMapTipPosMirrorComp:_updateArrow(arg_3_1, arg_3_2)
	return ExplorationAnglePosIcon._updateArrow(self, arg_3_1, arg_3_2)
end

function ExplorationMapTipPosMirrorComp:updateCompAngleAndPos(arg_4_1, arg_4_2, arg_4_3)
	ExplorationAnglePosIcon.updateCompAngleAndPos(self, arg_4_2, arg_4_1, arg_4_3)
end

function ExplorationMapTipPosMirrorComp:_onClicked()
	self:dispatchCompEvent("moveToMirror")
end

return ExplorationMapTipPosMirrorComp
