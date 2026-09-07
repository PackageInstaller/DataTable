local MainSettingsBtn = class("MainSettingsBtn", import(".MainBaseBtn"))

function MainSettingsBtn:OnClick()
	self:emit(NewMainMediator.GO_SCENE, SCENE.SETTINGS)

	return
end

return MainSettingsBtn
