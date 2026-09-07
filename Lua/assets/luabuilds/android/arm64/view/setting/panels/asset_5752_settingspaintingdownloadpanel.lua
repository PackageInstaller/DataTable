local SettingsPaintingDownloadPanel = class("SettingsPaintingDownloadPanel", import(".SettingsBasePanel"))

function SettingsPaintingDownloadPanel:GetUIName()
	return "SettingsPaintingDownload"
end

function SettingsPaintingDownloadPanel:GetTitle()
	return i18n("painting_prefs_setting_label")
end

function SettingsPaintingDownloadPanel:GetTitleEn()
	return "  / Painting Download"
end

SettingsPaintingDownloadPanel.None = 0
SettingsPaintingDownloadPanel.Min = 1
SettingsPaintingDownloadPanel.Max = 2

function SettingsPaintingDownloadPanel:OnInit()
	self.btns = {}

	for iter_4_0, iter_4_1 in ipairs({
		self._tf:Find("prefs/1"),
		self._tf:Find("prefs/2")
	}) do
		onToggle(self, iter_4_1, function(arg_5_0)
			if arg_5_0 then
				if iter_4_0 == getProxy(SettingsProxy):GetPaintingDownloadPrefs() then
					return
				else
					getProxy(SettingsProxy):SetPaintingDownloadPrefs(iter_4_0)
					pg.TipsMgr.GetInstance():ShowTips(i18n("painting_prefs_switch_succ"))
				end
			end

			return
		end, SFX_PANEL)
		setText(iter_4_1:Find("Text"), i18n("painting_prefs_setting_" .. iter_4_0))

		self.btns[iter_4_0] = iter_4_1
	end

	return
end

function SettingsPaintingDownloadPanel:OnUpdate()
	local var_6_0 = getProxy(SettingsProxy):GetPaintingDownloadPrefs()

	if IsUnityEditor and var_6_0 == SettingsPaintingDownloadPanel.None then
		var_6_0 = SettingsPaintingDownloadPanel.Max

		return
	end

	triggerToggle(self.btns[var_6_0], true)

	return
end

return SettingsPaintingDownloadPanel
