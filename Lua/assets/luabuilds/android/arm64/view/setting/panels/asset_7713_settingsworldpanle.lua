local SettingsWorldPanle = class("SettingsWorldPanle", import(".SettingsBasePanel"))

function SettingsWorldPanle:GetUIName()
	return "SettingsWorld"
end

function SettingsWorldPanle:GetTitle()
	return i18n("world_setting_title")
end

function SettingsWorldPanle:GetTitleEn()
	return "  / OPERATION SETTINGS"
end

function SettingsWorldPanle:OnInit()
	self.uilist = UIItemList.New(self._tf:Find("options"), self._tf:Find("options/notify_tpl"))

	self.uilist:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			self:UpdateItem(arg_5_1 + 1, arg_5_2)
		end

		return
	end)

	self.worldbossProgressTip = findTF(self._tf, "world_boss")

	return
end

function SettingsWorldPanle:UpdateItem(arg_6_1, arg_6_2)
	local var_6_0 = self.list[arg_6_1]

	arg_6_2:Find("mask/Text"):GetComponent("ScrollText"):SetText(self.list[arg_6_1].title)
	onButton(self, arg_6_2:Find("mask/Text"), function()
		pg.m02:sendNotification(NewSettingsMediator.SHOW_DESC, var_6_0)

		return
	end, SFX_PANEL)
	removeOnToggle(arg_6_2:Find("on"))

	if self:GetDefaultValue(self.list[arg_6_1]) then
		triggerToggle(arg_6_2:Find("on"), true)
	else
		triggerToggle(arg_6_2:Find("off"), true)
	end

	onToggle(self, arg_6_2:Find("on"), function(arg_8_0)
		self:OnItemSwitch(var_6_0, arg_8_0)

		return
	end, SFX_UI_TAG, SFX_UI_CANCEL)

	return
end

function SettingsWorldPanle:OnItemSwitch(arg_9_1, arg_9_2)
	getProxy(SettingsProxy):SetWorldFlag(arg_9_1.key, arg_9_2)

	return
end

function SettingsWorldPanle:GetDefaultValue(arg_10_1)
	return getProxy(SettingsProxy):GetWorldFlag(arg_10_1.key)
end

function SettingsWorldPanle:GetList()
	return {
		{
			key = "story_tips",
			title = i18n("world_setting_quickmode"),
			desc = i18n("world_setting_quickmodetip")
		},
		{
			key = "consume_item",
			title = i18n("world_setting_submititem"),
			desc = i18n("world_setting_submititemtip")
		},
		{
			key = "auto_save_area",
			title = i18n("world_setting_mapauto"),
			desc = i18n("world_setting_mapautotip")
		}
	}
end

function SettingsWorldPanle:DisplayWorldBossProgressTipSettings()
	local var_12_0 = pg.NewStoryMgr.GetInstance():IsPlayed("WorldG190")

	setActive(self.worldbossProgressTip, var_12_0)

	if var_12_0 then
		self:InitWorldBossProgressTipSettings()
	end

	return
end

function SettingsWorldPanle:InitWorldBossProgressTipSettings()
	local var_13_0 = self:GetWorldBossProgressTipConfig()
	local var_13_1 = getProxy(SettingsProxy)
	local var_13_2 = var_13_1:GetWorldBossProgressTipFlag()

	local function var_13_3(arg_14_0, arg_14_1)
		local var_14_0 = tostring(var_13_0[arg_14_0])

		onToggle(self, arg_14_1, function(arg_15_0)
			if arg_15_0 then
				getProxy(SettingsProxy):WorldBossProgressTipFlag(var_14_0)
			end

			return
		end, SFX_PANEL)

		if var_14_0 == var_13_2 then
			triggerToggle(arg_14_1, true)
		end

		return
	end

	local var_13_4 = self.worldbossProgressTip:Find("notify_tpl")

	var_13_4.Find(var_13_1, "mask/Text"):GetComponent("ScrollText"):SetText(i18n("world_boss_progress_tip_title"))

	for iter_13_0 = 1, #var_13_0 do
		var_13_3(iter_13_0, var_13_4:Find(tostring(iter_13_0)))
	end

	onButton(self, var_13_4:Find("mask/Text"), function()
		pg.m02:sendNotification(NewSettingsMediator.SHOW_DESC, {
			desc = i18n("world_boss_progress_tip_desc")
		})

		return
	end, SFX_PANEL)

	return
end

function SettingsWorldPanle:GetWorldBossProgressTipConfig()
	local var_17_0 = {}

	table.insert(var_17_0, "")
	table.insert(var_17_0, pg.gameset.joint_boss_ticket.description[1] .. "&" .. pg.gameset.joint_boss_ticket.description[1] + pg.gameset.joint_boss_ticket.description[2])
	table.insert(var_17_0, pg.gameset.joint_boss_ticket.description[1] + pg.gameset.joint_boss_ticket.description[2])

	return var_17_0
end

function SettingsWorldPanle:OnUpdate()
	self.list = self:GetList()

	self.uilist:align(#self.list)
	self:DisplayWorldBossProgressTipSettings()

	return
end

return SettingsWorldPanle
