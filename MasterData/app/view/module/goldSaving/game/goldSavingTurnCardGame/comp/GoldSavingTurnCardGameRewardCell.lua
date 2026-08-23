local GoldSavingTurnCardGameRewardCell = class("GoldSavingTurnCardGameRewardCell", require("app.fairyGUI.goldSaving.UI_GoldSavingTurnCardGameRewardCell"))

function GoldSavingTurnCardGameRewardCell:ctor()
	self.m_iconComp:getChild("bgLoader"):setVisible(false)
end

function GoldSavingTurnCardGameRewardCell:updateRewardCell(arg_2_1)
	if arg_2_1 then
		self.m_iconComp:updateIcon(arg_2_1)
		self.m_num:setText(arg_2_1.size)
	else
		self:setVisible(false)
	end
end

return GoldSavingTurnCardGameRewardCell
