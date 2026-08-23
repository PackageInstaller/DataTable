local ExplorationTurnCardGameRewardCell = class("ExplorationTurnCardGameRewardCell", require("app.fairyGUI.richman.UI_RichmanTurnCardGameRewardCell"))

function ExplorationTurnCardGameRewardCell:ctor()
	self.m_iconComp:getChild("bgLoader"):setVisible(false)
end

function ExplorationTurnCardGameRewardCell:updateRewardCell(arg_2_1)
	if arg_2_1 then
		self.m_iconComp:updateIcon(arg_2_1)
		self.m_num:setText(arg_2_1.size)
	else
		self:setVisible(false)
	end
end

return ExplorationTurnCardGameRewardCell
