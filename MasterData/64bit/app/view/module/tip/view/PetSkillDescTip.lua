local PetSkillDescTip = class("PetSkillDescTip", require("app.fairyGUI.tip.UI_PetSkillDescTip"), function()
	return fgui.GComponent:create({
		resName = "PetSkillDescTip",
		pkgName = "tip",
		pkgPath = "ui/tip/tip"
	})
end)

function PetSkillDescTip:ctor(arg_2_1)
	self._data = arg_2_1

	self:getView():center(true)
end

function PetSkillDescTip:onLoad()
	self:updateView(self._data)
end

function PetSkillDescTip:updateView(arg_4_1)
	local var_4_0 = arg_4_1.skillId

	if arg_4_1.isPassive then
		var_4_0 = g.core.config.passive_skill_info.get(var_4_0).passive_skill_value
	end

	local var_4_1 = g.core.config.skill_info.get(var_4_0)

	self.m_bgPanel:setTitle(var_4_1.curtain_name)

	if arg_4_1.isForceStyle then
		self.m_styleController:setSelectedIndex(3)
	elseif var_4_1.skill_type == 1 then
		self.m_styleController:setSelectedIndex(0)
	elseif var_4_1.skill_type == 14 then
		self.m_styleController:setSelectedIndex(2)
	else
		self.m_styleController:setSelectedIndex(1)
	end

	local var_4_2 = arg_4_1

	var_4_2.skillId = var_4_0
	var_4_2.isPassive = false

	self.m_descComp:updateComp(var_4_2)

	local var_4_3 = var_4_1.split_description_2

	if var_4_1.split_description_2 ~= "" and var_4_3 ~= "0" then
		self.m_numController:setSelectedIndex(1)

		var_4_3 = var_4_2.isPassive and g.core.utils.String.formatPassiveSkillDesc(arg_4_1.skillId) or g.core.utils.String.formatSkillSplitDesc(arg_4_1.skillId)

		self.m_descText2:setText(var_4_3)
	else
		self.m_numController:setSelectedIndex(0)
	end
end

return PetSkillDescTip
