local BaseSkillDescComp = class("BaseSkillDescComp", require("app.fairyGUI.base_new.UI_BaseSkillDescComp"))

function BaseSkillDescComp:ctor()
	return
end

function BaseSkillDescComp:updateSkillDesc(arg_2_1)
	if not arg_2_1 then
		return
	end

	self.m_skillNameTxt:setText(arg_2_1.name)

	if arg_2_1.enableRich then
		self.m_descTxt:enableRich()
	end

	self.m_descTxt:setText(arg_2_1.desc)
end

return BaseSkillDescComp
