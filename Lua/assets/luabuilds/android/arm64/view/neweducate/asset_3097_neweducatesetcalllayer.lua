local NewEducateSetCallLayer = class("NewEducateSetCallLayer", import("view.newEducate.base.NewEducateBaseUI"))

function NewEducateSetCallLayer:getUIName()
	return "NewEducateSetCallUI"
end

function NewEducateSetCallLayer:init()
	self:initData()
	self:findUI()
	self:addListener()

	return
end

function NewEducateSetCallLayer:initData()
	self.defaultName = i18n("child_default_callname")
	self.lockNamed = PLATFORM_CODE == PLATFORM_CH and LOCK_NAMED

	return
end

function NewEducateSetCallLayer:findUI()
	self.bgTF = self._tf:Find("Image")
	self.blurPanel = self._tf:Find("bg")
	self.callInput = self._tf:Find("bg/panel/input/nickname")
	self.sureBtn = self._tf:Find("bg/panel/sure_button")

	setText(self.sureBtn:Find("Image"), i18n("word_ok"))
	setText(self.callInput:Find("Placeholder"), i18n("child_callname_tip"))

	self.callInput:GetComponent(typeof(InputField)).interactable = not self.lockNamed

	setActive(self._tf:Find("bg/panel/input/pan"), not self.lockNamed)

	return
end

function NewEducateSetCallLayer:addListener()
	onButton(self, self.sureBtn, function()
		local var_6_0 = getInputText(self.callInput)

		if var_6_0 == "" then
			return
		end

		if not nameValidityCheck(var_6_0, 4, 14, {
			"spece_illegal_tip",
			"login_newPlayerScene_name_tooShort",
			"login_newPlayerScene_name_tooLong",
			"login_newPlayerScene_invalideName"
		}) then
			return
		end

		self:emit(NewEducateSetCallediator.ON_SET_CALL, var_6_0)

		return
	end, SFX_PANEL)

	return
end

function NewEducateSetCallLayer:didEnter()
	setImageSprite(self.bgTF, LoadSprite("bg/" .. self.contextData.char:getConfig("name_background")), false)
	self:OverlayPanel(self.blurPanel, {
		groupDelta = 1,
		pbList = {
			self.blurPanel
		}
	})
	setInputText(self.callInput, self.defaultName)

	return
end

function NewEducateSetCallLayer:onBackPressed()
	return
end

function NewEducateSetCallLayer:willExit()
	if self.contextData.callback then
		self.contextData.callback()
	end

	self:UnOverlayPanel(self.blurPanel, self._tf)

	return
end

return NewEducateSetCallLayer
