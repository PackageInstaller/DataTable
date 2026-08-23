local ThemeThirdBossTalentLine = class("ThemeThirdBossTalentLine", require("app.fairyGUI.summerThemeThirdBoss.UI_ThemeThirdBossTalentLine"))

function ThemeThirdBossTalentLine:ctor()
	self._talentStruct = nil
end

function ThemeThirdBossTalentLine:refreshComp()
	if self._talentStruct then
		self:updateCompByStruct(self._talentStruct)
	end
end

function ThemeThirdBossTalentLine:updateCompByStruct(arg_3_1)
	self._talentStruct = arg_3_1

	self:updateLine(arg_3_1)
end

function ThemeThirdBossTalentLine:updateLine(arg_4_1)
	arg_4_1 = arg_4_1 or self._talentStruct

	self.m_preLineTypeController:setSelectedIndex(arg_4_1:getPreLineType())
	self.m_nextLineTypeController:setSelectedIndex(arg_4_1:getNextLineType())
	self.m_preIsActiveController:setSelectedIndex(arg_4_1:isActive() and arg_4_1:getPreIsUnlock() and 1 or 0)
	self.m_nextIsActiveController:setSelectedIndex(arg_4_1:isActive() and arg_4_1:getChildIsUnlock() and 1 or 0)
end

return ThemeThirdBossTalentLine
