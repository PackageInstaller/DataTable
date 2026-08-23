local TeamBattleKnightCutComp = class("TeamBattleKnightCutComp", require("app.fairyGUI.teamBattle.UI_TeamBattleKnightCutComp"))

function TeamBattleKnightCutComp:updateKnight()
	self.m_knightPicComp:updateKnight(...)
end

function TeamBattleKnightCutComp:setAlphaRect()
	self.m_knightPicComp:setAlphaRect(...)
end

return TeamBattleKnightCutComp
