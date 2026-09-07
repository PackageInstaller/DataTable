local SettingsStorySpeedPanel = class("SettingsStorySpeedPanel", import(".SettingsBasePanel"))

function SettingsStorySpeedPanel:GetUIName()
	return "SettingsStorySpeed"
end

function SettingsStorySpeedPanel:GetTitle()
	return i18n("story_setting_label")
end

function SettingsStorySpeedPanel:GetTitleEn()
	return "  / AUTO SPEED"
end

function SettingsStorySpeedPanel:OnInit()
	local var_4_0 = self._tf:Find("speeds")

	self.btns = {}

	for iter_4_0 = 1, var_4_0.childCount do
		local var_4_1 = var_4_0:GetChild(iter_4_0 - 1)

		onToggle(self, var_4_1, function(arg_5_0)
			if arg_5_0 then
				getProxy(SettingsProxy):SetStorySpeed(Story.STORY_AUTO_SPEED[iter_4_0])
			end

			return
		end, SFX_PANEL)
		setText(var_4_1:Find("Text"), i18n("setting_story_speed_" .. iter_4_0))

		self.btns[iter_4_0] = var_4_1
	end

	return
end

function SettingsStorySpeedPanel:OnUpdate()
	triggerToggle(self.btns[table.indexof(Story.STORY_AUTO_SPEED, (getProxy(SettingsProxy):GetStorySpeed())) or 2], true)

	return
end

return SettingsStorySpeedPanel
