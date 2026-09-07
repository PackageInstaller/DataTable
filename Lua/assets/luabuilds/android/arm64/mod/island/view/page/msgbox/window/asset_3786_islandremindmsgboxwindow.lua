local IslandRemindMsgboxWindow = class("IslandRemindMsgboxWindow", import(".IslandCommonMsgboxWindow"))

function IslandRemindMsgboxWindow:getUIName()
	return "IslandCommonMsgBoxWithRemind"
end

function IslandRemindMsgboxWindow:OnLoaded()
	IslandRemindMsgboxWindow.super.OnLoaded(self)

	self.remindToggle = self._tf:Find("remind")

	setText(self._tf:Find("remind/Text"), i18n("island_no_remind_today"))

	return
end

function IslandRemindMsgboxWindow:OnInit()
	IslandRemindMsgboxWindow.super.OnInit(self)
	onButton(self, self.confirmBtn, function()
		local var_4_0

		if self.onYes then
			self.onYes()

			var_4_0 = self.flag and GetZeroTime() or 0
		end

		self:SaveValue(self.settings.key, var_4_0)
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function IslandRemindMsgboxWindow:OnShow()
	IslandRemindMsgboxWindow.super.OnShow(self)

	self.flag = false

	assert(self.settings.key)
	self:Flush(self.settings)

	return
end

function IslandRemindMsgboxWindow:Flush(arg_6_1)
	onToggle(self, self.remindToggle, function(arg_7_0)
		self.flag = arg_7_0

		return
	end, SFX_PANEL)
	triggerToggle(self.remindToggle, self.flag)

	return
end

function IslandRemindMsgboxWindow:SaveValue(arg_8_1, arg_8_2)
	PlayerPrefs.SetInt(arg_8_1, arg_8_2)
	PlayerPrefs.Save()

	return
end

return IslandRemindMsgboxWindow
