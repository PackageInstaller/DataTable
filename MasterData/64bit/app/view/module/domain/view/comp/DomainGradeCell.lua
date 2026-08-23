local DomainGradeCell = class("DomainGradeCell", require("app.fairyGUI.domainDungeon.UI_DomainGradeCell"))

function DomainGradeCell:ctor()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRender))
end

function DomainGradeCell:_onAwardItemRender(arg_2_1, arg_2_2)
	arg_2_2:updateIcon(self._award[arg_2_1 + 1])
end

function DomainGradeCell:updateGradeCell(arg_3_1)
	self.m_gradeLoader:setURL("ui://domainDungeon/pic_mnly_" .. arg_3_1.grade)
	self.m_descTxt:setText(arg_3_1.desc)

	self._award = arg_3_1.award

	self.m_awardList:setNumItems(#self._award)
end

return DomainGradeCell
