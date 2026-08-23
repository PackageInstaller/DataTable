local TeamBattleTurnCardGameRewardCell = class("TeamBattleTurnCardGameRewardCell", require("app.fairyGUI.teamBattle.UI_TeamBattleTurnCardGameRewardCell"))

function TeamBattleTurnCardGameRewardCell:ctor()
	self.m_iconComp:getChild("bgLoader"):setVisible(false)
end

function TeamBattleTurnCardGameRewardCell:updateRewardCell(arg_2_1)
	if arg_2_1 then
		self.m_iconComp:updateIcon(arg_2_1)
		self.m_num:setText(arg_2_1.size)
	else
		self:setVisible(false)
	end
end

return TeamBattleTurnCardGameRewardCell
