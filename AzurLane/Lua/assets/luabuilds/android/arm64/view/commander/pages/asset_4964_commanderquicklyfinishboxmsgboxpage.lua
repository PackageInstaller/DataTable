class = var_0_10000

local var_0_0 = "CommanderQuicklyFinishBoxMsgBoxPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".CommanderMsgBoxPage"))

function var_0_1.getUIName(arg_1_0)
	return "CommanderQuicklyFinishBoxUI"
end

function var_0_1.OnInit(arg_2_0)
	var_0_1.super.OnInit(arg_2_0)

	local var_2_0 = arg_2_0._tf

	arg_2_0.ssrToggle = var_1.Find(var_2_0, "frame/bg/content/rarity/ssr")

	local var_2_1 = arg_2_0._tf

	arg_2_0.srToggle = var_1.Find(var_2_1, "frame/bg/content/rarity/sr")

	local var_2_2 = arg_2_0._tf

	arg_2_0.rToggle = var_1.Find(var_2_2, "frame/bg/content/rarity/r")

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "frame/bg/content/rarity/Text")
	local var_2_5 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.descTxt = var_2_5(var_2_4, var_4(var_1_10006))

	return
end

function var_0_1.Show(arg_3_0, arg_3_1)
	var_0_1.super.Show(arg_3_0, arg_3_1)

	local var_3_0 = arg_3_0.descTxt

	i18n = var_1_10003
	var_3_0.text = var_1_10003("acceleration_tips_3")
	onButton = var_3_0

	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0.confirmBtn

	local function var_3_3()
		getProxy = var_2_10000
		CommanderProxy = var_2_10002

		local var_4_0 = var_2_10000(var_2_10002)
		local var_4_1, var_4_2, var_4_3, var_4_4 = var_0.CalcQuickItemUsageCnt(var_4_0, arg_3_0.toggleFlags)

		if var_4_1 <= 0 then
			pg = var_4

			local var_4_5 = var_4.TipsMgr.GetInstance()
			local var_4_6 = var_4.ShowTips

			i18n = var_2_10007

			var_4_6(var_4_5, var_2_10007("noacceleration_tips"))

			return
		end

		if arg_3_1.onYes then
			arg_3_1.onYes(var_4_1, var_4_2, var_4_3, arg_3_0.toggleFlags)
		end

		local var_4_7 = arg_3_0

		var_4.SaveConfig(var_4_7)

		local var_4_8 = arg_3_0

		var_4.Hide(var_4_8)

		return
	end

	SFX_PANEL = var_1_10007

	var_3_0(var_3_1, var_3_2, var_3_3, var_1_10007)
	arg_3_0:InitToggle()
	arg_3_0:UpdateContent()

	return
end

function var_0_1.UpdateContent(arg_5_0)
	getProxy = var_1_10001
	CommanderProxy = var_1_10003

	local var_5_0 = var_1_10001(var_1_10003)
	local var_5_1, var_5_2, var_5_3, var_5_4 = var_1.CalcQuickItemUsageCnt(var_5_0, arg_5_0.toggleFlags)

	i18n = var_1_10005

	local var_5_5 = var_1_10005("acceleration_tips_1", var_5_1, var_5_2)

	i18n = var_1_10006

	local var_5_6 = var_1_10006("acceleration_tips_2", var_5_4[1], var_5_4[2], var_5_4[3])

	setText = var_7

	var_7(arg_5_0.text1, var_5_5)

	setText = var_7

	var_7(arg_5_0.text2, var_5_6)

	return
end

function var_0_1.InitToggle(arg_6_0)
	arg_6_0.toggleFlags = {}
	onToggle = var_1

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.ssrToggle

	local function var_6_2(arg_7_0)
		arg_6_0.toggleFlags[1] = arg_7_0

		local var_7_0 = arg_6_0

		var_1.UpdateContent(var_7_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_6_0, var_6_1, var_6_2, var_1_10006)

	onToggle = var_1

	local var_6_3 = arg_6_0
	local var_6_4 = arg_6_0.srToggle

	local function var_6_5(arg_8_0)
		arg_6_0.toggleFlags[2] = arg_8_0

		local var_8_0 = arg_6_0

		var_1.UpdateContent(var_8_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_6_3, var_6_4, var_6_5, var_1_10006)

	onToggle = var_1

	local var_6_6 = arg_6_0
	local var_6_7 = arg_6_0.rToggle

	local function var_6_8(arg_9_0)
		arg_6_0.toggleFlags[3] = arg_9_0

		local var_9_0 = arg_6_0

		var_1.UpdateContent(var_9_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_6_6, var_6_7, var_6_8, var_1_10006)

	local var_6_9 = arg_6_0:GetConfig()

	triggerToggle = var_1_10002

	var_1_10002(arg_6_0.ssrToggle, var_6_9[1])

	triggerToggle = var_1_10002

	var_1_10002(arg_6_0.srToggle, var_6_9[2])

	triggerToggle = var_1_10002

	var_1_10002(arg_6_0.rToggle, var_6_9[3])

	return
end

function var_0_1.GetConfig(arg_10_0)
	getProxy = var_1_10001
	SettingsProxy = var_1_10003

	local var_10_0 = var_1_10001(var_1_10003)

	return (var_1.GetCommanderQuicklyToolRarityConfig(var_10_0))
end

function var_0_1.SaveConfig(arg_11_0)
	getProxy = var_1_10001
	SettingsProxy = var_1_10003

	local var_11_0 = var_1_10001(var_1_10003)

	var_1.SaveCommanderQuicklyToolRarityConfig(var_11_0, arg_11_0.toggleFlags)

	return
end

return var_0_1
