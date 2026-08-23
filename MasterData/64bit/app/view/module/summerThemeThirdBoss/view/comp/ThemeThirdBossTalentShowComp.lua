local ThemeThirdBossTalentShowComp = class("ThemeThirdBossTalentShowComp", require("app.fairyGUI.summerThemeThirdBoss.UI_ThemeThirdBossTalentShowComp"))

function ThemeThirdBossTalentShowComp:ctor()
	self._attrList = {}
	self._skillInfoList = {}

	self.m_attrList:setIniter(self)
	self.m_attrList:setItemRenderer(handler(self, self._onRenderAttrList))
	self.m_skillList:setIniter(self)
	self.m_skillList:setItemRenderer(handler(self, self._onRenderSkillList))
end

function ThemeThirdBossTalentShowComp:_onRenderAttrList(arg_2_1, arg_2_2)
	arg_2_2:getChild("attrName"):setText(self._attrList[arg_2_1 + 1].attrName)
	arg_2_2:getChild("attrValue"):setText(self._attrList[arg_2_1 + 1].attrValue)
end

function ThemeThirdBossTalentShowComp:_onRenderSkillList(arg_3_1, arg_3_2)
	arg_3_2:updateSkillCell(self._skillInfoList[arg_3_1 + 1])
end

function ThemeThirdBossTalentShowComp:updateShowComp(arg_4_1, arg_4_2)
	self._attrList = arg_4_1

	self.m_attrList:setNumItems(#arg_4_1)
	self.m_attrList:resizeToFit(#arg_4_1)

	self._skillInfoList = arg_4_2

	self.m_skillList:setNumItems(#arg_4_2)
	self.m_skillList:resizeToFit(#arg_4_2)
	self.m_hasTalentController:setSelectedIndex(#arg_4_2 > 0 and 1 or 0)
end

return ThemeThirdBossTalentShowComp
