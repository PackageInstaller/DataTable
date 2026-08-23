local CommonSkillDescComp = class("CommonSkillDescComp", require("app.fairyGUI.tip.UI_CommonSkillDescComp"))

function CommonSkillDescComp:ctor()
	self:_initListView()
end

function CommonSkillDescComp:_initListView()
	self.m_descList:setIniter()
	self.m_descList:setItemRendererAsync1(handler(self, self._onItemRenderer), 0.1, true)
end

function CommonSkillDescComp:_onItemRenderer(arg_3_1, arg_3_2)
	if self._skillsDescList[arg_3_1 + 1] then
		arg_3_2:updateTalentCell(self._skillsDescList[arg_3_1 + 1])
	end
end

function CommonSkillDescComp:updateDescComp(arg_4_1, arg_4_2)
	self._skillData = arg_4_2

	self.m_skillIcon:updateIcon({
		skillId = arg_4_1,
		skillExtraData = self._skillData.skillExtraData
	})
	self.m_descText:getChild("title"):enableRich()
	self.m_descText:setTitle((g.core.utils.String.formatSkillDesc(arg_4_1)))

	if self._skillData.tipsText then
		self.m_tipsText:setTitle(self._skillData.tipsText)
	end

	self._skillsDescList = self._skillData.descList or {}

	self.m_descList:setNumItems1(#self._skillsDescList)
end

return CommonSkillDescComp
