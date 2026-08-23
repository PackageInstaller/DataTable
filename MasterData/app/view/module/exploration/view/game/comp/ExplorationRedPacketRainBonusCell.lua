local ExplorationRedPacketRainBonusCell = class("ExplorationRedPacketRainBonusCell", require("app.fairyGUI.exploration.UI_ExplorationRedPacketRainBonusCell"))

function ExplorationRedPacketRainBonusCell:ctor()
	self.m_iconComp:getChild("bgLoader"):setVisible(false)
end

function ExplorationRedPacketRainBonusCell:updateView(arg_2_1)
	self.m_iconComp:updateIcon(arg_2_1)
	self.m_numTxt:setText("×" .. arg_2_1.size)
end

function ExplorationRedPacketRainBonusCell:playBonusAnim()
	self.m_enterTransition:play(handler(self, self._onAnimEnd))
end

function ExplorationRedPacketRainBonusCell:_onAnimEnd()
	self:removeFromParent()
end

function ExplorationRedPacketRainBonusCell:onLoad()
	self.m_enterTransition:play()
end

return ExplorationRedPacketRainBonusCell
