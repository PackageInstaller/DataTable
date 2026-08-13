class = var_0_10000

local var_0_0 = "CommanderLockFlagSettingPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3

function var_0_1.getUIName(arg_1_0)
	return "CommanderLockFlagSettingui"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_0, "frame/close_btn")

	local var_2_1 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_1, "frame/cancel")

	local var_2_2 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_2, "frame/confirm")

	local var_2_3 = arg_2_0._tf

	arg_2_0.allBtn = var_1.Find(var_2_3, "frame/title/all_btn")

	local var_2_4 = arg_2_0.allBtn

	arg_2_0.allSel = var_1.Find(var_2_4, "Image")

	local var_2_5 = arg_2_0._tf

	arg_2_0.ssrToggle = var_1.Find(var_2_5, "frame/toggles/rarity/ssr")

	local var_2_6 = arg_2_0._tf

	arg_2_0.srToggle = var_1.Find(var_2_6, "frame/toggles/rarity/sr")

	local var_2_7 = arg_2_0._tf

	arg_2_0.rToggle = var_1.Find(var_2_7, "frame/toggles/rarity/r")
	UIItemList = var_1

	local var_2_8 = var_1.New
	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_3.Find(var_2_9, "frame/toggles/scrollrect/content/talent")
	local var_2_11 = arg_2_0._tf

	arg_2_0.talentUIlist = var_2_8(var_2_10, var_4.Find(var_2_11, "frame/toggles/scrollrect/content/talent/tpl"))

	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_1.Find(var_2_12, "frame/desc/Text")
	local var_2_14 = var_1.GetComponent

	typeof = var_4
	Text = var_2_11
	arg_2_0.descTxt = var_2_14(var_2_13, var_4(var_2_11))
	setText = var_1

	local var_2_15 = arg_2_0._tf
	local var_2_16 = var_3.Find(var_2_15, "frame/title/rarity")

	i18n = var_4

	var_1(var_2_16, var_4("word_rarity") .. ": ")

	setText = var_1

	local var_2_17 = arg_2_0._tf
	local var_2_18 = var_3.Find(var_2_17, "frame/title/talent")

	i18n = var_4

	var_1(var_2_18, var_4("word_talent") .. ": ")

	setText = var_1

	local var_2_19 = arg_2_0._tf
	local var_2_20 = var_3.Find(var_2_19, "frame/desc/Text")

	i18n = var_4

	var_1(var_2_20, var_4("commander_lock_setting_title"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.closeBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.cancelBtn

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10006)

	onButton = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.confirmBtn

	local function var_3_11()
		local var_7_0 = arg_3_0

		if not var_0.UnselAnyTalent(var_7_0) then
			local var_7_1 = arg_3_0

			if var_0.UnselAnyRarity(var_7_1) then
				local var_7_2 = arg_3_0.contextData.msgBox
				local var_7_3 = var_0.ExecuteAction
				local var_7_4 = "Show"
				local var_7_5 = {}

				i18n = var_2_10005
				var_7_5.content = var_2_10005("commander_unsel_lock_flag_tip")

				function var_7_5.onYes()
					local var_8_0 = arg_3_0

					var_0.Conform(var_8_0)

					return
				end

				var_7_3(var_7_2, var_7_4, var_7_5)
			else
				local var_7_6 = arg_3_0

				var_0.Conform(var_7_6)
			end

			return
		end
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_9, var_3_10, var_3_11, var_1_10006)

	return
end

function var_0_1.UnselAnyTalent(arg_9_0)
	pairs = var_1_10001

	for iter_9_0, iter_9_1 in var_1_10001(arg_9_0.talentList) do
		if iter_9_1 == true then
			return false
		end
	end

	return true
end

function var_0_1.UnselAnyRarity(arg_10_0)
	pairs = var_1_10001

	for iter_10_0, iter_10_1 in var_1_10001(arg_10_0.rarityList) do
		if iter_10_1 == true then
			return false
		end
	end

	return true
end

function var_0_1.Conform(arg_11_0)
	arg_11_0:SaveRarityConfig(arg_11_0.rarityList)
	arg_11_0:SaveTalentConfig(arg_11_0.talentList)
	arg_11_0:Hide()

	return
end

function var_0_1.Show(arg_12_0)
	var_0_1.super.Show(arg_12_0)
	arg_12_0:InitRarity()
	arg_12_0:InitTalent()

	return
end

function var_0_1.InitRarity(arg_13_0)
	local var_13_0 = arg_13_0:GetRarityConfig()

	arg_13_0.rarityList = {}
	onToggle = var_2

	local var_13_1 = arg_13_0
	local var_13_2 = arg_13_0.ssrToggle

	local function var_13_3(arg_14_0)
		arg_13_0.rarityList[var_0_2] = arg_14_0

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_13_1, var_13_2, var_13_3, var_1_10007)

	onToggle = var_2

	local var_13_4 = arg_13_0
	local var_13_5 = arg_13_0.srToggle

	local function var_13_6(arg_15_0)
		arg_13_0.rarityList[var_0_3] = arg_15_0

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_13_4, var_13_5, var_13_6, var_1_10007)

	onToggle = var_2

	local var_13_7 = arg_13_0
	local var_13_8 = arg_13_0.rToggle

	local function var_13_9(arg_16_0)
		arg_13_0.rarityList[var_0_4] = arg_16_0

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_13_7, var_13_8, var_13_9, var_1_10007)

	triggerToggle = var_2

	var_2(arg_13_0.ssrToggle, var_13_0[var_0_2])

	triggerToggle = var_2

	var_2(arg_13_0.srToggle, var_13_0[var_0_3])

	triggerToggle = var_2

	var_2(arg_13_0.rToggle, var_13_0[var_0_4])

	return
end

function var_0_1.InitTalent(arg_17_0)
	local var_17_0 = arg_17_0:GetTalentConfig()

	arg_17_0.talentList = {}
	arg_17_0.talentCards = {}
	CommanderCatUtil = var_2

	local var_17_1 = var_2.GetAllTalentNames()
	local var_17_2 = arg_17_0.talentUIlist

	var_3.make(var_17_2, function(arg_18_0, arg_18_1, arg_18_2)
		UIItemList = var_2_10003

		if arg_18_0 == var_2_10003.EventUpdate then
			local var_18_0 = var_17_1[arg_18_1 + 1].id
			local var_18_1 = var_17_1[arg_18_1 + 1].name

			onToggle = var_5

			local var_18_2 = arg_17_0
			local var_18_3 = arg_18_2

			local function var_18_4(arg_19_0)
				arg_17_0.talentList[var_18_0] = arg_19_0

				local var_19_0 = arg_17_0

				var_1.UpdateAllBtnStyle(var_19_0)

				return
			end

			SFX_PANEL = var_2_10010

			var_5(var_18_2, var_18_3, var_18_4, var_2_10010)

			setText = var_5

			var_5(arg_18_2:Find("Text"), var_18_1)

			arg_18_2.gameObject.name = var_18_0
			arg_17_0.talentCards[var_18_0] = arg_18_2
		end

		return
	end)

	local var_17_3 = arg_17_0.talentUIlist

	var_3.align(var_17_3, #var_17_1)

	pairs = var_3

	for iter_17_0, iter_17_1 in var_3(var_17_0) do
		if arg_17_0.talentCards[iter_17_0] then
			triggerToggle = var_1_10008

			var_1_10008(arg_17_0.talentCards[iter_17_0], iter_17_1)
		end
	end

	onButton = var_3

	local var_17_4 = arg_17_0
	local var_17_5 = arg_17_0.allBtn

	local function var_17_6()
		local var_20_0 = arg_17_0

		if var_0.AnyCardUnSelected(var_20_0) then
			local var_20_1 = arg_17_0

			var_0.TriggerAllCardTrue(var_20_1)
		else
			local var_20_2 = arg_17_0

			var_0.TriggerAllCardFalse(var_20_2)
		end

		local var_20_3 = arg_17_0

		var_0.UpdateAllBtnStyle(var_20_3)

		return
	end

	SFX_PANEL = var_1_10008

	var_3(var_17_4, var_17_5, var_17_6, var_1_10008)
	arg_17_0:UpdateAllBtnStyle()

	return
end

function var_0_1.UpdateAllBtnStyle(arg_21_0)
	setActive = var_1_10001

	var_1_10001(arg_21_0.allSel, not arg_21_0:AnyCardUnSelected())

	return
end

function var_0_1.AnyCardUnSelected(arg_22_0)
	pairs = var_1_10001

	for iter_22_0, iter_22_1 in var_1_10001(arg_22_0.talentCards) do
		local var_22_0 = iter_22_1
		local var_22_1 = iter_22_1.GetComponent

		typeof = var_1_10009
		Toggle = var_1_10011

		if not var_22_1(var_22_0, var_1_10009(var_1_10011)).isOn then
			return true
		end
	end

	return false
end

function var_0_1.TriggerAllCardTrue(arg_23_0)
	pairs = var_1_10001

	for iter_23_0, iter_23_1 in var_1_10001(arg_23_0.talentCards) do
		triggerToggle = var_1_10006

		var_1_10006(iter_23_1, true)
	end

	return
end

function var_0_1.TriggerAllCardFalse(arg_24_0)
	pairs = var_1_10001

	for iter_24_0, iter_24_1 in var_1_10001(arg_24_0.talentCards) do
		triggerToggle = var_1_10006

		var_1_10006(iter_24_1, false)
	end

	return
end

function var_0_1.GetRarityConfig(arg_25_0)
	getProxy = var_1_10001
	SettingsProxy = var_1_10003

	local var_25_0 = var_1_10001(var_1_10003)

	return (var_1.GetCommanderLockFlagRarityConfig(var_25_0))
end

function var_0_1.SaveRarityConfig(arg_26_0, arg_26_1)
	getProxy = var_1_10002
	SettingsProxy = var_1_10004

	local var_26_0 = var_1_10002(var_1_10004)

	var_2.SaveCommanderLockFlagRarityConfig(var_26_0, arg_26_1)

	return
end

function var_0_1.GetTalentConfig(arg_27_0)
	getProxy = var_1_10001
	SettingsProxy = var_1_10003

	local var_27_0 = var_1_10001(var_1_10003)

	return (var_1.GetCommanderLockFlagTalentConfig(var_27_0))
end

function var_0_1.SaveTalentConfig(arg_28_0, arg_28_1)
	getProxy = var_1_10002
	SettingsProxy = var_1_10004

	local var_28_0 = var_1_10002(var_1_10004)

	var_2.SaveCommanderLockFlagTalentConfig(var_28_0, arg_28_1)

	return
end

function var_0_1.OnDestroy(arg_29_0)
	return
end

return var_0_1
