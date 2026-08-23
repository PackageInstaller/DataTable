local BattleResultBioCardNameText = class("BattleResultBioCardNameText", require("app.fairyGUI.battleResult.UI_BattleResultBioCardNameText"))

function BattleResultBioCardNameText:setName(arg_1_1, arg_1_2)
	self:setTitle("")

	if arg_1_1 then
		self:setTitle(arg_1_1)
	end

	self.m_isMineController:setSelectedIndex(arg_1_2 and 1 or 0)
end

return BattleResultBioCardNameText
