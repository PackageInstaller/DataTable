local var_0_0 = class("CommanderLockFlagSettingPage", import("view.base.BaseSubView"))
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3

function var_0_0.getUIName(arg_1_0)
	return "CommanderLockFlagSettingui"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.closeBtn = arg_2_0._tf:Find("frame/close_btn")
	arg_2_0.cancelBtn = arg_2_0._tf:Find("frame/cancel")
	arg_2_0.confirmBtn = arg_2_0._tf:Find("frame/confirm")
	arg_2_0.allBtn = arg_2_0._tf:Find("frame/title/all_btn")
	arg_2_0.allSel = arg_2_0.allBtn:Find("Image")
	arg_2_0.ssrToggle = arg_2_0._tf:Find("frame/toggles/rarity/ssr")
	arg_2_0.srToggle = arg_2_0._tf:Find("frame/toggles/rarity/sr")
	arg_2_0.rToggle = arg_2_0._tf:Find("frame/toggles/rarity/r")
	arg_2_0.talentUIlist = UIItemList.New(arg_2_0._tf:Find("frame/toggles/scrollrect/content/talent"), arg_2_0._tf:Find("frame/toggles/scrollrect/content/talent/tpl"))
	arg_2_0.descTxt = arg_2_0._tf:Find("frame/desc/Text"):GetComponent(typeof(Text))

	setText(arg_2_0._tf:Find("frame/title/rarity"), i18n("word_rarity") .. ": ")
	setText(arg_2_0._tf:Find("frame/title/talent"), i18n("word_talent") .. ": ")
	setText(arg_2_0._tf:Find("frame/desc/Text"), i18n("commander_lock_setting_title"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.cancelBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.confirmBtn, function()
		if arg_3_0:UnselAnyTalent() or arg_3_0:UnselAnyRarity() then
			arg_3_0.contextData.msgBox:ExecuteAction("Show", {
				content = i18n("commander_unsel_lock_flag_tip"),
				onYes = function()
					arg_3_0:Conform()

					return
				end
			})
		else
			arg_3_0:Conform()
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UnselAnyTalent(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.talentList) do
		if iter_9_1 == true then
			return false
		end
	end

	return true
end

function var_0_0.UnselAnyRarity(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.rarityList) do
		if iter_10_1 == true then
			return false
		end
	end

	return true
end

function var_0_0.Conform(arg_11_0)
	arg_11_0:SaveRarityConfig(arg_11_0.rarityList)
	arg_11_0:SaveTalentConfig(arg_11_0.talentList)
	arg_11_0:Hide()

	return
end

function var_0_0.Show(arg_12_0)
	var_0_0.super.Show(arg_12_0)
	arg_12_0:InitRarity()
	arg_12_0:InitTalent()

	return
end

function var_0_0.InitRarity(arg_13_0)
	local var_13_0 = arg_13_0:GetRarityConfig()

	arg_13_0.rarityList = {}

	onToggle(arg_13_0, arg_13_0.ssrToggle, function(arg_14_0)
		arg_13_0.rarityList[var_0_1] = arg_14_0

		return
	end, SFX_PANEL)
	onToggle(arg_13_0, arg_13_0.srToggle, function(arg_15_0)
		arg_13_0.rarityList[var_0_2] = arg_15_0

		return
	end, SFX_PANEL)
	onToggle(arg_13_0, arg_13_0.rToggle, function(arg_16_0)
		arg_13_0.rarityList[var_0_3] = arg_16_0

		return
	end, SFX_PANEL)
	triggerToggle(arg_13_0.ssrToggle, var_13_0[var_0_1])
	triggerToggle(arg_13_0.srToggle, var_13_0[var_0_2])
	triggerToggle(arg_13_0.rToggle, var_13_0[var_0_3])

	return
end

function var_0_0.InitTalent(arg_17_0)
	arg_17_0.talentList = {}
	arg_17_0.talentCards = {}

	local var_17_0 = CommanderCatUtil.GetAllTalentNames()

	arg_17_0.talentUIlist:make(function(arg_18_0, arg_18_1, arg_18_2)
		if arg_18_0 == UIItemList.EventUpdate then
			local var_18_0 = var_17_0[arg_18_1 + 1].id

			onToggle(arg_17_0, arg_18_2, function(arg_19_0)
				arg_17_0.talentList[var_18_0] = arg_19_0

				arg_17_0:UpdateAllBtnStyle()

				return
			end, SFX_PANEL)
			setText(arg_18_2:Find("Text"), var_17_0[arg_18_1 + 1].name)

			arg_18_2.gameObject.name = var_17_0[arg_18_1 + 1].id
			arg_17_0.talentCards[var_17_0[arg_18_1 + 1].id] = arg_18_2
		end

		return
	end)
	arg_17_0.talentUIlist:align(#CommanderCatUtil.GetAllTalentNames())

	for iter_17_0, iter_17_1 in pairs((arg_17_0:GetTalentConfig())) do
		if arg_17_0.talentCards[iter_17_0] then
			triggerToggle(arg_17_0.talentCards[iter_17_0], iter_17_1)
		end
	end

	onButton(arg_17_0, arg_17_0.allBtn, function()
		if arg_17_0:AnyCardUnSelected() then
			arg_17_0:TriggerAllCardTrue()
		else
			arg_17_0:TriggerAllCardFalse()
		end

		arg_17_0:UpdateAllBtnStyle()

		return
	end, SFX_PANEL)
	arg_17_0:UpdateAllBtnStyle()

	return
end

function var_0_0.UpdateAllBtnStyle(arg_21_0)
	setActive(arg_21_0.allSel, not arg_21_0:AnyCardUnSelected())

	return
end

function var_0_0.AnyCardUnSelected(arg_22_0)
	for iter_22_0, iter_22_1 in pairs(arg_22_0.talentCards) do
		if not iter_22_1:GetComponent(typeof(Toggle)).isOn then
			return true
		end
	end

	return false
end

function var_0_0.TriggerAllCardTrue(arg_23_0)
	for iter_23_0, iter_23_1 in pairs(arg_23_0.talentCards) do
		triggerToggle(iter_23_1, true)
	end

	return
end

function var_0_0.TriggerAllCardFalse(arg_24_0)
	for iter_24_0, iter_24_1 in pairs(arg_24_0.talentCards) do
		triggerToggle(iter_24_1, false)
	end

	return
end

function var_0_0.GetRarityConfig(arg_25_0)
	return (getProxy(SettingsProxy):GetCommanderLockFlagRarityConfig())
end

function var_0_0.SaveRarityConfig(arg_26_0, arg_26_1)
	getProxy(SettingsProxy):SaveCommanderLockFlagRarityConfig(arg_26_1)

	return
end

function var_0_0.GetTalentConfig(arg_27_0)
	return (getProxy(SettingsProxy):GetCommanderLockFlagTalentConfig())
end

function var_0_0.SaveTalentConfig(arg_28_0, arg_28_1)
	getProxy(SettingsProxy):SaveCommanderLockFlagTalentConfig(arg_28_1)

	return
end

function var_0_0.OnDestroy(arg_29_0)
	return
end

return var_0_0
