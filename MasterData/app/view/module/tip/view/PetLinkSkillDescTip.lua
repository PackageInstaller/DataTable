local PetLinkSkillDescTip = class("PetLinkSkillDescTip", require("app.fairyGUI.tip.UI_PetLinkSkillDescTip"), function()
	return fgui.GComponent:create({
		resName = "PetLinkSkillDescTip",
		pkgPath = "ui/tip/tip",
		pkgName = "tip"
	})
end)

function PetLinkSkillDescTip:ctor(arg_2_1)
	self._data = arg_2_1

	self:getView():center(true)
end

function PetLinkSkillDescTip:onLoad()
	self:updateView(self._data)
end

function PetLinkSkillDescTip:updateView(arg_4_1)
	local var_4_0 = arg_4_1.skillId

	if arg_4_1.isPassive then
		var_4_0 = g.core.config.passive_skill_info.get(var_4_0).passive_skill_value
	end

	self.m_bgPanel:setTitle(g.core.config.skill_info.get(var_4_0).curtain_name)

	arg_4_1.skillId = var_4_0
	arg_4_1.isPassive = false

	self.m_descComp:updateComp(arg_4_1)
end

return PetLinkSkillDescTip
