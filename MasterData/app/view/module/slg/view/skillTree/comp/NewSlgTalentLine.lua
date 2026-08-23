local NewSlgTalentLine = class("NewSlgTalentLine", require("app.fairyGUI.newSlg.UI_NewSlgTalentLine"))

function NewSlgTalentLine:ctor()
	self._talentStruct = nil
end

function NewSlgTalentLine:refreshComp()
	if self._talentStruct then
		self:updateCompByStruct(self._talentStruct)
	end
end

function NewSlgTalentLine:updateCompByStruct(arg_3_1)
	self._talentStruct = arg_3_1

	self:updateLine(arg_3_1)
end

function NewSlgTalentLine:updateLine(arg_4_1)
	arg_4_1 = arg_4_1 or self._talentStruct

	self.m_preLineTypeController:setSelectedIndex(arg_4_1:getPreLineType())
	self.m_nextLineTypeController:setSelectedIndex(arg_4_1:getNextLineType())
	self.m_preIsActiveController:setSelectedIndex(arg_4_1:isActive() and arg_4_1:getPreIsUnlock() and 1 or 0)
	self.m_nextIsActiveController:setSelectedIndex(arg_4_1:isActive() and arg_4_1:getChildIsUnlock() and 1 or 0)
end

return NewSlgTalentLine
