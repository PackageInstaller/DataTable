local var_0_0 = class("SettingsWorldPanle", import(".SettingsBasePanel"))

function var_0_0.GetUIName(arg_1_0)
	return "SettingsWorld"
end

function var_0_0.GetTitle(arg_2_0)
	return i18n("world_setting_title")
end

function var_0_0.GetTitleEn(arg_3_0)
	return "  / OPERATION SETTINGS"
end

function var_0_0.OnInit(arg_4_0)
	arg_4_0.uilist = UIItemList.New(arg_4_0._tf:Find("options"), arg_4_0._tf:Find("options/notify_tpl"))

	arg_4_0.uilist:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			arg_4_0:UpdateItem(arg_5_1 + 1, arg_5_2)
		end

		return
	end)

	arg_4_0.worldbossProgressTip = findTF(arg_4_0._tf, "world_boss")

	return
end

function var_0_0.UpdateItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.list[arg_6_1]

	arg_6_2:Find("mask/Text"):GetComponent("ScrollText"):SetText(arg_6_0.list[arg_6_1].title)
	onButton(arg_6_0, arg_6_2:Find("mask/Text"), function()
		pg.m02:sendNotification(NewSettingsMediator.SHOW_DESC, var_6_0)

		return
	end, SFX_PANEL)
	removeOnToggle(arg_6_2:Find("on"))

	if arg_6_0:GetDefaultValue(arg_6_0.list[arg_6_1]) then
		triggerToggle(arg_6_2:Find("on"), true)
	else
		triggerToggle(arg_6_2:Find("off"), true)
	end

	onToggle(arg_6_0, arg_6_2:Find("on"), function(arg_8_0)
		arg_6_0:OnItemSwitch(var_6_0, arg_8_0)

		return
	end, SFX_UI_TAG, SFX_UI_CANCEL)

	return
end

function var_0_0.OnItemSwitch(arg_9_0, arg_9_1, arg_9_2)
	getProxy(SettingsProxy):SetWorldFlag(arg_9_1.key, arg_9_2)

	return
end

function var_0_0.GetDefaultValue(arg_10_0, arg_10_1)
	return getProxy(SettingsProxy):GetWorldFlag(arg_10_1.key)
end

function var_0_0.GetList(arg_11_0)
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

function var_0_0.DisplayWorldBossProgressTipSettings(arg_12_0)
	local var_12_0 = pg.NewStoryMgr.GetInstance():IsPlayed("WorldG190")

	setActive(arg_12_0.worldbossProgressTip, var_12_0)

	if var_12_0 then
		arg_12_0:InitWorldBossProgressTipSettings()
	end

	return
end

function var_0_0.InitWorldBossProgressTipSettings(arg_13_0)
	local var_13_9000
	local var_13_0 = arg_13_0:GetWorldBossProgressTipConfig()
	local var_13_1 = getProxy(SettingsProxy)
	local var_13_2 = var_13_1.GetWorldBossProgressTipFlag(var_13_9000)
	local var_13_3 = arg_13_0.worldbossProgressTip:Find("notify_tpl")

	var_13_3.Find(var_13_1, "mask/Text"):GetComponent("ScrollText"):SetText(i18n("world_boss_progress_tip_title"))

	for iter_13_0 = 1, #arg_13_0:GetWorldBossProgressTipConfig() do
		(function(arg_14_0, arg_14_1)
			local var_14_0 = tostring(var_13_0[arg_14_0])

			onToggle(arg_13_0, arg_14_1, function(arg_15_0)
				if arg_15_0 then
					getProxy(SettingsProxy):WorldBossProgressTipFlag(var_14_0)
				end

				return
			end, SFX_PANEL)

			if tostring(var_13_0[arg_14_0]) == var_13_2 then
				triggerToggle(arg_14_1, true)
			end

			return
		end)(iter_13_0, var_13_3:Find(tostring(iter_13_0)))
	end

	onButton(arg_13_0, var_13_3:Find("mask/Text"), function()
		pg.m02:sendNotification(NewSettingsMediator.SHOW_DESC, {
			desc = i18n("world_boss_progress_tip_desc")
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.GetWorldBossProgressTipConfig(arg_17_0)
	table.insert({}, "")
	table.insert({}, pg.gameset.joint_boss_ticket.description[1] .. "&" .. pg.gameset.joint_boss_ticket.description[1] + pg.gameset.joint_boss_ticket.description[2])
	table.insert({}, pg.gameset.joint_boss_ticket.description[1] + pg.gameset.joint_boss_ticket.description[2])

	return {}
end

function var_0_0.OnUpdate(arg_18_0)
	arg_18_0.list = arg_18_0:GetList()

	arg_18_0.uilist:align(#arg_18_0.list)
	arg_18_0:DisplayWorldBossProgressTipSettings()

	return
end

return var_0_0
