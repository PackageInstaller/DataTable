local EquipMagicalSkillDescTip = class("EquipMagicalSkillDescTip", require("app.fairyGUI.tip.UI_EquipMagicalSkillDescTip"), function()
	return fgui.GComponent:create({
		resName = "EquipMagicalSkillDescTip",
		pkgPath = "ui/tip/tip",
		pkgName = "tip"
	})
end)

function EquipMagicalSkillDescTip:ctor(arg_2_1)
	self._data = arg_2_1

	self:getView():center(true)
end

function EquipMagicalSkillDescTip:onLoad()
	self:updateView(self._data)
end

function EquipMagicalSkillDescTip:updateView(arg_4_1)
	local var_4_0 = arg_4_1.skillId

	if arg_4_1.isPassive then
		var_4_0 = g.core.config.passive_skill_info.get(var_4_0).passive_skill_value
	end

	local var_4_1 = g.core.config.skill_info.get(var_4_0)

	self.m_bgPanel:setTitle(var_4_1.curtain_name)
	self.m_styleController:setSelectedIndex(2)

	arg_4_1.skillId = var_4_0
	arg_4_1.isPassive = false

	self.m_descComp:updateComp(arg_4_1)

	local var_4_2 = var_4_1.split_description_2

	if var_4_1.split_description_2 ~= "" and var_4_2 ~= "0" then
		self.m_numController:setSelectedIndex(1)

		var_4_2 = arg_4_1.isPassive and g.core.utils.String.formatPassiveSkillDesc(arg_4_1.skillId) or g.core.utils.String.formatSkillSplitDesc(arg_4_1.skillId)

		self.m_descText2:setText(var_4_2)
	else
		self.m_numController:setSelectedIndex(0)
	end
end

return EquipMagicalSkillDescTip
