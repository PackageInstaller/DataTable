local CommonSkillPop = class("CommonSkillPop", require("app.fairyGUI.tip.UI_CommonSkillPop"), function()
	return fgui.GComponent:create({
		resName = "CommonSkillPop",
		pkgName = "tip",
		pkgPath = "ui/tip/tip"
	})
end)

function CommonSkillPop:ctor(arg_2_1)
	self._skillData = arg_2_1

	self:showAtCenter()
end

function CommonSkillPop:onLoad()
	self:updateView()
end

function CommonSkillPop:updateView()
	local var_4_0 = self._skillData.skillId

	if self._skillData.isPassive then
		var_4_0 = g.core.config.passive_skill_info.get(var_4_0).passive_skill_value
	end

	local var_4_1 = g.core.config.skill_info.get(var_4_0)

	self.m_bgPanel:setTitle(var_4_1.curtain_name)

	local var_4_2 = var_4_1.split_description_2

	if var_4_1.split_description_2 ~= "" and var_4_2 ~= "0" then
		var_4_2 = self._skillData.isPassive and g.core.utils.String.formatPassiveSkillDesc(self._skillData.skillId) or g.core.utils.String.formatSkillSplitDesc(self._skillData.skillId)

		self.m_descText2:setText(var_4_2)
	else
		self.m_extraDescGroup:setVisible(false)
	end

	self.m_descComp:updateDescComp(var_4_0, self._skillData)
end

function CommonSkillPop:_onItemRenderer(arg_5_1, arg_5_2)
	if self._skillsDescList[arg_5_1 + 1] then
		arg_5_2:updateCell(self._skillsDescList[arg_5_1 + 1])
	end
end

return CommonSkillPop
