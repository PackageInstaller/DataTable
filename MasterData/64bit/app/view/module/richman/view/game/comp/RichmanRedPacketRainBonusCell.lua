local RichmanRedPacketRainBonusCell = class("RichmanRedPacketRainBonusCell", require("app.fairyGUI.richman.UI_RichmanRedPacketRainBonusCell"))

function RichmanRedPacketRainBonusCell:ctor()
	self.m_iconComp:getChild("bgLoader"):setVisible(false)
end

function RichmanRedPacketRainBonusCell:updateView(arg_2_1)
	self.m_iconComp:updateIcon(arg_2_1)
	self.m_numTxt:setText("×" .. arg_2_1.size)
end

function RichmanRedPacketRainBonusCell:playBonusAnim()
	self.m_enterTransition:play(handler(self, self._onAnimEnd))
end

function RichmanRedPacketRainBonusCell:_onAnimEnd()
	self:removeFromParent()
end

function RichmanRedPacketRainBonusCell:onLoad()
	self.m_enterTransition:play()
	self.m_eff:removeAllEffect()
	self.m_eff:addEffectSpine({
		name = "eff_ui_richman_text",
		anim = "play",
		isLoop = false
	})
end

return RichmanRedPacketRainBonusCell
