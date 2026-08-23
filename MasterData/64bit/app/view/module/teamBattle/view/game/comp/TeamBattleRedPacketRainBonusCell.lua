local TeamBattleRedPacketRainBonusCell = class("TeamBattleRedPacketRainBonusCell", require("app.fairyGUI.teamBattle.UI_TeamBattleRedPacketRainBonusCell"))

function TeamBattleRedPacketRainBonusCell:ctor()
	self.m_iconComp:getChild("bgLoader"):setVisible(false)
end

function TeamBattleRedPacketRainBonusCell:updateView(arg_2_1)
	self.m_iconComp:updateIcon(arg_2_1)
	self.m_numTxt:setText("×" .. arg_2_1.size)
end

function TeamBattleRedPacketRainBonusCell:playBonusAnim()
	self.m_enterTransition:play(handler(self, self._onAnimEnd))
end

function TeamBattleRedPacketRainBonusCell:_onAnimEnd()
	self:removeFromParent()
end

function TeamBattleRedPacketRainBonusCell:onLoad()
	self.m_enterTransition:play()
	self.m_eff:removeAllEffect()
	self.m_eff:addEffectSpine({
		isLoop = false,
		anim = "play",
		name = "eff_ui_richman_text"
	})
end

return TeamBattleRedPacketRainBonusCell
