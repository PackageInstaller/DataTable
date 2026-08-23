local KsMath = require("app.core.utils.KsMath")
local RecruitUniteTokenTwentyComp = class("RecruitUniteTokenTwentyComp", require("app.fairyGUI.recruitUniteToken.UI_RecruitUniteTokenTwentyComp"))

function RecruitUniteTokenTwentyComp:ctor()
	self._minY = -630
	self._maxY = 0
	self._pos = self.m_childComp:getPosition()
end

function RecruitUniteTokenTwentyComp:onLoad()
	return
end

function RecruitUniteTokenTwentyComp:tTouchMove(arg_3_1)
	self.m_childComp:setY((KsMath.rangeIn(self.m_childComp:getY() - arg_3_1:getInput():getTouch():getDelta().y, self._minY, self._maxY)))
end

function RecruitUniteTokenTwentyComp:updateChildComp(arg_4_1)
	self.m_childComp:updateCompShow(arg_4_1)
end

function RecruitUniteTokenTwentyComp:setShareState()
	self.m_childComp:setShareState()
end

function RecruitUniteTokenTwentyComp:resetShareState()
	self.m_childComp:resetShareState()
end

function RecruitUniteTokenTwentyComp:getIsNewByIndex(arg_7_1)
	return self.m_childComp:getIsNewByIndex(arg_7_1)
end

function RecruitUniteTokenTwentyComp:resetPosition()
	self.m_childComp:setPosition(self._pos)
end

return RecruitUniteTokenTwentyComp
