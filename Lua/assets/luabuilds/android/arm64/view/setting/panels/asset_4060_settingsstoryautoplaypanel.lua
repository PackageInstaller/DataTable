local SettingsStoryAutoPlayPanel = class("SettingsStoryAutoPlayPanel", import(".SettingsBasePanel"))

function SettingsStoryAutoPlayPanel:GetUIName()
	return "SettingsStoryAutoplay"
end

function SettingsStoryAutoPlayPanel:GetTitle()
	return i18n("story_autoplay_setting_label")
end

function SettingsStoryAutoPlayPanel:GetTitleEn()
	return "  / AUTO"
end

function SettingsStoryAutoPlayPanel:OnInit()
	self.btns = {}

	for iter_4_0, iter_4_1 in ipairs({
		self._tf:Find("speeds/1"),
		self._tf:Find("speeds/2")
	}) do
		onToggle(self, iter_4_1, function(arg_5_0)
			if arg_5_0 then
				getProxy(SettingsProxy):SetStoryAutoPlayFlag(iter_4_0 - 1)
			end

			return
		end, SFX_PANEL)
		setText(iter_4_1:Find("Text"), i18n("story_autoplay_setting_" .. iter_4_0))

		self.btns[iter_4_0] = iter_4_1
	end

	return
end

function SettingsStoryAutoPlayPanel:OnUpdate()
	triggerToggle(self.btns[getProxy(SettingsProxy):GetStoryAutoPlayFlag() and 2 or 1], true)

	return
end

return SettingsStoryAutoPlayPanel
