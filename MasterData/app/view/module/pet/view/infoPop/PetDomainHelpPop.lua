local var_0_0 = g.core.config.help_text_info
local PetDomainHelpPop = class("PetDomainHelpPop", require("app.fairyGUI.pet.UI_PetDomainHelpPop"), function()
	return fgui.GComponent:create({
		resName = "PetDomainHelpPop",
		pkgPath = "ui/pet/pet",
		isFullScreen = true,
		pkgName = "pet"
	}, ...)
end)

function PetDomainHelpPop:ctor()
	self:_initView()
end

function PetDomainHelpPop:_initView()
	local var_3_0 = var_0_0.get(6000002, 1)

	self.m_nameTxt:setText(var_3_0.name)
	self.m_descTxt:setText(var_3_0.text)
end

return PetDomainHelpPop
