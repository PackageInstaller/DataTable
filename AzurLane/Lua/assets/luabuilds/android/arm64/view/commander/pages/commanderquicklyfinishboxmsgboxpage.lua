local var_0_0 = class("CommanderQuicklyFinishBoxMsgBoxPage", import(".CommanderMsgBoxPage"))

function var_0_0.getUIName(arg_1_0)
	return "CommanderQuicklyFinishBoxUI"
end

function var_0_0.OnInit(arg_2_0)
	var_0_0.super.OnInit(arg_2_0)

	arg_2_0.ssrToggle = arg_2_0._tf:Find("frame/bg/content/rarity/ssr")
	arg_2_0.srToggle = arg_2_0._tf:Find("frame/bg/content/rarity/sr")
	arg_2_0.rToggle = arg_2_0._tf:Find("frame/bg/content/rarity/r")
	arg_2_0.descTxt = arg_2_0._tf:Find("frame/bg/content/rarity/Text"):GetComponent(typeof(Text))

	return
end

function var_0_0.Show(arg_3_0, arg_3_1)
	var_0_0.super.Show(arg_3_0, arg_3_1)

	arg_3_0.descTxt.text = i18n("acceleration_tips_3")

	onButton(arg_3_0, arg_3_0.confirmBtn, function()
		local var_4_0, var_4_1, var_4_2, var_4_3 = getProxy(CommanderProxy):CalcQuickItemUsageCnt(arg_3_0.toggleFlags)

		if var_4_0 <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("noacceleration_tips"))

			return
		end

		if arg_3_1.onYes then
			arg_3_1.onYes(var_4_0, var_4_1, var_4_2, arg_3_0.toggleFlags)
		end

		arg_3_0:SaveConfig()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	arg_3_0:InitToggle()
	arg_3_0:UpdateContent()

	return
end

function var_0_0.UpdateContent(arg_5_0)
	local var_5_0, var_5_1, var_5_2, var_5_3 = getProxy(CommanderProxy):CalcQuickItemUsageCnt(arg_5_0.toggleFlags)

	setText(arg_5_0.text1, (i18n("acceleration_tips_1", var_5_0, var_5_1)))
	setText(arg_5_0.text2, (i18n("acceleration_tips_2", var_5_3[1], var_5_3[2], var_5_3[3])))

	return
end

function var_0_0.InitToggle(arg_6_0)
	arg_6_0.toggleFlags = {}

	onToggle(arg_6_0, arg_6_0.ssrToggle, function(arg_7_0)
		arg_6_0.toggleFlags[1] = arg_7_0

		arg_6_0:UpdateContent()

		return
	end, SFX_PANEL)
	onToggle(arg_6_0, arg_6_0.srToggle, function(arg_8_0)
		arg_6_0.toggleFlags[2] = arg_8_0

		arg_6_0:UpdateContent()

		return
	end, SFX_PANEL)
	onToggle(arg_6_0, arg_6_0.rToggle, function(arg_9_0)
		arg_6_0.toggleFlags[3] = arg_9_0

		arg_6_0:UpdateContent()

		return
	end, SFX_PANEL)

	local var_6_0 = arg_6_0:GetConfig()

	triggerToggle(arg_6_0.ssrToggle, var_6_0[1])
	triggerToggle(arg_6_0.srToggle, var_6_0[2])
	triggerToggle(arg_6_0.rToggle, var_6_0[3])

	return
end

function var_0_0.GetConfig(arg_10_0)
	return (getProxy(SettingsProxy):GetCommanderQuicklyToolRarityConfig())
end

function var_0_0.SaveConfig(arg_11_0)
	getProxy(SettingsProxy):SaveCommanderQuicklyToolRarityConfig(arg_11_0.toggleFlags)

	return
end

return var_0_0
