local var_0_0 = class("TerminalPersonalPage", import("view.base.BaseSubView"))
local var_0_1 = "otherworld_personal_name"

var_0_0.BIND_EVENT_ACT_ID = ActivityConst.OTHER_WORLD_TERMINAL_EVENT_ID
var_0_0.config = pg.roll_attr
var_0_0.NAME_ID = 1001
var_0_0.LV_ID = 1002
var_0_0.JOB_ID = 1003
var_0_0.GUARDIAN_ID = 1004
var_0_0.PROPERTY_IDS = (function(arg_1_0)
	for iter_1_0 = arg_1_0[1], arg_1_0[2] do
		if var_0_0.config[iter_1_0] then
			table.insert({}, iter_1_0)
		end
	end

	return {}
end)({
	2001,
	2006
})
var_0_0.ABILITY_IDS = (function(arg_1_0)
	for iter_1_0 = arg_1_0[1], arg_1_0[2] do
		if var_0_0.config[iter_1_0] then
			table.insert({}, iter_1_0)
		end
	end

	return {}
end)({
	3000,
	3193
})
var_0_0.RANDOM_ABILITY_CNT = 8

function var_0_0.getUIName(arg_2_0)
	return "TerminalPersonalPage"
end

function var_0_0.OnLoaded(arg_3_0)
	arg_3_0._tf.name = tostring(OtherworldTerminalLayer.PAGE_PERSONAL)
	arg_3_0.infoTF = arg_3_0._tf:Find("frame/info")

	setText(arg_3_0.infoTF:Find("title/content/Text"), i18n("personal_info_title"))

	arg_3_0.nameTitle = arg_3_0.infoTF:Find("infos/name/title")
	arg_3_0.nameInput = arg_3_0.infoTF:Find("infos/name/box/InputField")
	arg_3_0.jobTitle = arg_3_0.infoTF:Find("infos/job/title")
	arg_3_0.jobValue = arg_3_0.infoTF:Find("infos/job/value")
	arg_3_0.guardianTitle = arg_3_0.infoTF:Find("infos/guardian/title")
	arg_3_0.guardianValue = arg_3_0.infoTF:Find("infos/guardian/value")
	arg_3_0.lvTitle = arg_3_0.infoTF:Find("level/lv/title")
	arg_3_0.lvValue = arg_3_0.infoTF:Find("level/lv/value")
	arg_3_0.lvSlider = arg_3_0.infoTF:Find("level/slider")
	arg_3_0.lvUpgradeTF = arg_3_0.infoTF:Find("level/slider/upgrade")

	setActive(arg_3_0.lvUpgradeTF, false)

	arg_3_0.propertyTF = arg_3_0._tf:Find("frame/property")

	setText(arg_3_0.propertyTF:Find("title/content/Text"), i18n("personal_property_title"))

	arg_3_0.propertyContent = arg_3_0.propertyTF:Find("content")
	arg_3_0.propertyTpl = arg_3_0.propertyTF:Find("tpl")

	setActive(arg_3_0.propertyTpl, false)
	setActive(arg_3_0.propertyTpl:Find("upgrade"), false)

	if PLATFORM_CODE == PLATFORM_CH or PLATFORM_CODE == PLATFORM_CHT then
		arg_3_0.abilityTF = arg_3_0._tf:Find("frame/ability")

		setActive(arg_3_0._tf:Find("frame/ability_2"), false)
	else
		arg_3_0.abilityTF = arg_3_0._tf:Find("frame/ability_2")

		setActive(arg_3_0._tf:Find("frame/ability"), false)
	end

	setActive(arg_3_0.abilityTF, true)
	setText(arg_3_0.abilityTF:Find("title/content/Text"), i18n("personal_ability_title"))

	arg_3_0.abilityContent = arg_3_0.abilityTF:Find("content")
	arg_3_0.abilityTpl = arg_3_0.abilityTF:Find("tpl")

	setActive(arg_3_0.abilityTpl, false)

	arg_3_0.randomBtn = arg_3_0._tf:Find("frame/random_btn")

	setText(arg_3_0.randomBtn:Find("Text"), i18n("personal_random"))

	arg_3_0.randomGreyBtn = arg_3_0._tf:Find("frame/random_btn_grey")

	setText(arg_3_0.randomGreyBtn:Find("Text"), i18n("personal_random"))

	arg_3_0.effectTF = arg_3_0._tf:Find("effect")

	setActive(arg_3_0.effectTF, false)

	arg_3_0.playerId = getProxy(PlayerProxy):getRawData().id
	arg_3_0.showName = getProxy(PlayerProxy):getRawData().name

	return
end

function var_0_0.OnInit(arg_4_0)
	arg_4_0.activity = getProxy(ActivityProxy):getActivityById(var_0_0.BIND_EVENT_ACT_ID)

	assert(arg_4_0.activity, "not exist bind event act, id" .. var_0_0.BIND_EVENT_ACT_ID)
	arg_4_0.nameInput:GetComponent(typeof(InputField)).onValueChanged:AddListener(function()
		if not arg_4_0.unlockRandom or not nameValidityCheck(getInputText(arg_4_0.nameInput), 4, 14, {
			"spece_illegal_tip",
			"login_newPlayerScene_name_tooShort",
			"login_newPlayerScene_name_tooLong",
			"login_newPlayerScene_invalideName"
		}) then
			arg_4_0:SetDefaultName()
		else
			arg_4_0.showName = getInputText(arg_4_0.nameInput)

			setInputText(arg_4_0.nameInput, arg_4_0.showName)
			arg_4_0:SetLocalName(arg_4_0.showName)
		end

		return
	end)
	onButton(arg_4_0, arg_4_0.randomBtn, function()
		setActive(arg_4_0.effectTF, false)
		setActive(arg_4_0.effectTF, true)
		setActive(arg_4_0.randomBtn, false)
		setActive(arg_4_0.randomGreyBtn, false)
		arg_4_0:managedTween(LeanTween.delayedCall, function()
			OtherworldMapScene.personalRandomData = {}

			arg_4_0:UpdateView(true)
			setActive(arg_4_0.effectTF, false)
			setActive(arg_4_0.randomBtn, arg_4_0.unlockRandom)
			setActive(arg_4_0.randomGreyBtn, not arg_4_0.unlockRandom)

			return
		end, var_0_0.RANDOM_CHANGE_TIME, nil)

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.randomGreyBtn, function()
		pg.TipsMgr.GetInstance():ShowTips(i18n("personal_random_tip"))

		return
	end, SFX_PANEL)

	arg_4_0.unlockRandom = arg_4_0.activity:IsFinishAllMain()

	setActive(arg_4_0.randomBtn, arg_4_0.unlockRandom)
	setActive(arg_4_0.randomGreyBtn, not arg_4_0.unlockRandom)
	setActive(arg_4_0.infoTF:Find("infos/name/box/edit"), arg_4_0.unlockRandom)

	if arg_4_0.unlockRandom and arg_4_0:GetLocalName() ~= "" then
		arg_4_0.showName = arg_4_0:GetLocalName()
	end

	arg_4_0.nameInput:GetComponent(typeof(InputField)).interactable = arg_4_0.unlockRandom

	arg_4_0:UpdateView()

	return
end

function var_0_0.UpdateView(arg_9_0, arg_9_1)
	if arg_9_0.contextData.upgrade then
		local var_9_0 = arg_9_0.activity:GetLastShowConfig() or arg_9_0.activity:GetShowConfig()

		arg_9_0.showCfg = {}

		for iter_9_0, iter_9_1 in ipairs(var_9_0) do
			arg_9_0.showCfg[iter_9_1[1]] = iter_9_1[2]
		end

		arg_9_0:UpdateInfo(arg_9_1)
		arg_9_0:UpdateProperty(arg_9_1)
		arg_9_0:UpdateAbility(arg_9_1)

		if arg_9_0.contextData.upgrade then
			arg_9_0.upgradeCfg = {}

			for iter_9_2, iter_9_3 in ipairs(arg_9_0.activity:GetShowConfig()) do
				arg_9_0.upgradeCfg[iter_9_3[1]] = iter_9_3[2]
			end

			arg_9_0:PlayUpgradeAnims()
		end

		return
	end
end

function var_0_0.SetDefaultName(arg_10_0)
	setInputText(arg_10_0.nameInput, arg_10_0.showName)

	return
end

function var_0_0.UpdateInfo(arg_11_0, arg_11_1)
	arg_11_0:SetDefaultName()
	setText(arg_11_0.nameTitle, arg_11_0:GetRollAttrInfoById(var_0_0.NAME_ID, arg_11_1) .. "：")

	local var_11_0, var_11_1 = arg_11_0:GetRollAttrInfoById(var_0_0.JOB_ID, arg_11_1)

	setText(arg_11_0.jobTitle, var_11_0 .. "：")
	setText(arg_11_0.jobValue, var_11_1)

	local var_11_2, var_11_3 = arg_11_0:GetRollAttrInfoById(var_0_0.GUARDIAN_ID, arg_11_1)

	setText(arg_11_0.guardianTitle, var_11_2 .. "：")
	setText(arg_11_0.guardianValue, var_11_3)

	local var_11_4, var_11_5 = arg_11_0:GetRollAttrInfoById(var_0_0.LV_ID, arg_11_1)

	setText(arg_11_0.lvTitle, var_11_4 .. "：")
	setText(arg_11_0.lvValue, var_11_5)
	setSlider(arg_11_0.lvSlider, 0, 1, tonumber(var_11_5) / var_0_0.config[var_0_0.LV_ID].random_value[2])

	if arg_11_1 then
		OtherworldMapScene.personalRandomData[var_0_0.JOB_ID] = var_11_1
		OtherworldMapScene.personalRandomData[var_0_0.GUARDIAN_ID] = var_11_3
		OtherworldMapScene.personalRandomData[var_0_0.LV_ID] = var_11_5
	end

	return
end

function var_0_0.UpdateProperty(arg_12_0, arg_12_1)
	local var_12_0 = 0

	for iter_12_0, iter_12_1 in ipairs(var_0_0.PROPERTY_IDS) do
		var_12_0 = var_12_0 + 1

		if var_12_0 > arg_12_0.propertyContent.childCount then
			local var_12_1 = cloneTplTo(arg_12_0.propertyTpl, arg_12_0.propertyContent) or arg_12_0.propertyContent:GetChild(var_12_0 - 1)

			var_12_1.name = iter_12_1

			local var_12_2, var_12_3 = arg_12_0:GetRollAttrInfoById(iter_12_1, arg_12_1)

			setText(var_12_1:Find("name"), var_12_2)
			setText(var_12_1:Find("value/Text"), var_12_3)

			if arg_12_1 then
				OtherworldMapScene.personalRandomData[iter_12_1] = var_12_3
			end
		end
	end

	for iter_12_2 = 1, arg_12_0.propertyContent.childCount - 1 do
		if var_12_0 < iter_12_2 then
			setActive(arg_12_0.propertyContent:GetChild(iter_12_2 - 1), false)
		end
	end

	return
end

function var_0_0.UpdateAbility(arg_13_0, arg_13_1)
	local var_13_0 = {}

	if arg_13_1 then
		var_13_0 = arg_13_0:GetRandomAbilityIds()
	elseif OtherworldMapScene.personalRandomData then
		for iter_13_0, iter_13_1 in pairs(OtherworldMapScene.personalRandomData) do
			if table.contains(var_0_0.ABILITY_IDS, iter_13_0) then
				table.insert(var_13_0, iter_13_0)
			end
		end
	else
		for iter_13_2, iter_13_3 in pairs(arg_13_0.showCfg) do
			if table.contains(var_0_0.ABILITY_IDS, iter_13_2) then
				table.insert(var_13_0, iter_13_2)
			end
		end
	end

	table.sort(var_13_0)

	for iter_13_4, iter_13_5 in ipairs(var_13_0) do
		if iter_13_4 > arg_13_0.abilityContent.childCount then
			local var_13_1 = cloneTplTo(arg_13_0.abilityTpl, arg_13_0.abilityContent) or arg_13_0.abilityContent:GetChild(iter_13_4 - 1)

			var_13_1.name = iter_13_4

			local var_13_2, var_13_3 = arg_13_0:GetRollAttrInfoById(iter_13_5, arg_13_1)

			setText(var_13_1:Find("name"), var_13_2)
			setText(var_13_1:Find("value/Text"), var_13_3)

			if arg_13_1 then
				OtherworldMapScene.personalRandomData[iter_13_5] = var_13_3
			end
		end
	end

	for iter_13_6 = 1, arg_13_0.abilityContent.childCount do
		if iter_13_6 > #var_13_0 then
			setActive(arg_13_0.abilityContent:GetChild(iter_13_6 - 1), false)
		end
	end

	return
end

function var_0_0.GetRollAttrInfoById(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = ""

	if arg_14_2 then
		var_14_0 = (table.contains(var_0_0.PROPERTY_IDS, arg_14_1) or arg_14_1 == var_0_0.LV_ID) and math.random(var_0_0.config[arg_14_1].random_value[1], var_0_0.config[arg_14_1].random_value[2]) or var_0_0.config[arg_14_1].random_value[math.random(#var_0_0.config[arg_14_1].random_value)]
	else
		var_14_0 = arg_14_0.showCfg[arg_14_1] or var_0_0.config[arg_14_1].default_value

		if OtherworldMapScene.personalRandomData then
			var_14_0 = OtherworldMapScene.personalRandomData[arg_14_1]
		end
	end

	local var_14_2 = tostring(var_14_0)
end

function var_0_0.GetRandomAbilityIds(arg_15_0)
	for iter_15_0 = 1, #var_0_0.ABILITY_IDS do
		table.insert({}, iter_15_0)
	end

	shuffle({})

	for iter_15_1 = 1, var_0_0.RANDOM_ABILITY_CNT do
		table.insert({}, var_0_0.ABILITY_IDS[({})[iter_15_1]])
	end

	return {}
end

var_0_0.UPGRADE_TAG_SHOW_TIME = 2
var_0_0.LV_ANIM_TIME = 0.5
var_0_0.PROPERTY_TPL_ANIM_TIME = 0.5
var_0_0.ABILITY_TPL_ANIM_TIME = 0.5
var_0_0.RANDOM_CHANGE_TIME = 0.8

function var_0_0.PlayUpgradeAnims(arg_16_0)
	seriesAsync({
		function(arg_17_0)
			arg_16_0:PlayLevelAnim(arg_17_0)

			return
		end,
		function(arg_18_0)
			arg_16_0:PlayPropertyAnim(arg_18_0)

			return
		end,
		function(arg_19_0)
			arg_16_0:PlayAbilityAnim(arg_19_0)

			return
		end
	}, function()
		arg_16_0.contextData.upgrade = nil

		return
	end)

	return
end

function var_0_0.GetStaticInfo(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.showCfg[arg_21_1] or var_0_0.config[arg_21_1].default_value
	local var_21_1 = tonumber(var_21_0)
	local var_21_2 = arg_21_0.upgradeCfg[arg_21_1] or var_21_1
	local var_21_3 = tonumber(var_21_2)

	return var_21_1, var_21_3, var_21_3 - var_21_1 ~= 0
end

function var_0_0.PlayLevelAnim(arg_22_0, arg_22_1)
	local var_22_0, var_22_1, var_22_2 = arg_22_0:GetStaticInfo(var_0_0.LV_ID)

	setActive(arg_22_0.lvUpgradeTF, var_22_2)

	if var_22_2 then
		arg_22_0:managedTween(LeanTween.delayedCall, function()
			setActive(arg_22_0.lvUpgradeTF, false)

			return
		end, var_0_0.UPGRADE_TAG_SHOW_TIME, nil)
		arg_22_0:managedTween(LeanTween.value, nil, go(arg_22_0.lvValue), var_22_0, var_22_1, var_0_0.LV_ANIM_TIME):setOnUpdate(System.Action_float(function(arg_24_0)
			setText(arg_22_0.lvValue, math.floor(arg_24_0))

			return
		end)):setOnComplete(System.Action(function()
			arg_22_1()

			return
		end))
		arg_22_0:managedTween(LeanTween.value, nil, go(arg_22_0.lvSlider), var_22_0 / var_0_0.config[var_0_0.LV_ID].random_value[2], var_22_1 / var_0_0.config[var_0_0.LV_ID].random_value[2], var_0_0.LV_ANIM_TIME):setOnUpdate(System.Action_float(function(arg_26_0)
			setSlider(arg_22_0.lvSlider, 0, 1, arg_26_0)

			return
		end))
	else
		arg_22_1()
	end

	return
end

function var_0_0.PlayPropertyAnim(arg_27_0, arg_27_1)
	for iter_27_0 = 1, #var_0_0.PROPERTY_IDS do
		local var_27_0 = iter_27_0 > arg_27_0.propertyContent.childCount

		if iter_27_0 > arg_27_0.propertyContent.childCount then
			local var_27_1 = cloneTplTo(arg_27_0.propertyTpl, arg_27_0.propertyContent) or arg_27_0.propertyContent:GetChild(iter_27_0 - 1)
			local var_27_2 = var_0_0.PROPERTY_IDS[iter_27_0]
			local var_27_3, var_27_4, var_27_5 = arg_27_0:GetStaticInfo(var_0_0.PROPERTY_IDS[iter_27_0])

			if var_27_0 then
				setText(var_27_1:Find("name"), var_0_0.config[var_27_2].name)
				setText(var_27_1:Find("value/Text"), var_27_3)
			end

			if var_27_5 then
				table.insert({}, function(arg_28_0)
					setActive(var_27_1:Find("upgrade"), var_27_5)
					arg_27_0:managedTween(LeanTween.delayedCall, function()
						setActive(var_27_1:Find("upgrade"), false)

						return
					end, var_0_0.UPGRADE_TAG_SHOW_TIME, nil)
					arg_27_0:managedTween(LeanTween.value, nil, go(var_27_1), var_27_3, var_27_4, var_0_0.PROPERTY_TPL_ANIM_TIME):setOnUpdate(System.Action_float(function(arg_30_0)
						setText(var_27_1:Find("value/Text"), math.floor(arg_30_0))

						return
					end)):setOnComplete(System.Action(function()
						arg_28_0()

						return
					end))

					return
				end)
			end
		end
	end

	seriesAsync({}, function()
		arg_27_1()

		return
	end)

	return
end

function var_0_0.GetDynamicInfo(arg_33_0, arg_33_1)
	local var_33_0 = {}
	local var_33_1 = {}

	for iter_33_0, iter_33_1 in pairs(arg_33_0.showCfg) do
		if table.contains(var_0_0.ABILITY_IDS, iter_33_0) then
			table.insert({}, iter_33_0)
		end
	end

	table.sort({})

	for iter_33_2, iter_33_3 in pairs(arg_33_0.upgradeCfg) do
		if table.contains(var_0_0.ABILITY_IDS, iter_33_2) then
			table.insert(var_33_1, iter_33_2)
		end
	end

	table.sort(var_33_1)

	return {}, var_33_1, #{} ~= #var_33_1 or underscore.any(var_33_1, function(arg_34_0)
		return not table.contains(var_33_0, arg_34_0)
	end)
end

function var_0_0.PlayAbilityAnim(arg_35_0, arg_35_1)
	local var_35_0, var_35_1, var_35_2 = arg_35_0:GetDynamicInfo()

	if var_35_2 then
		local var_35_3 = {}

		for iter_35_0 = 1, #var_35_1 do
			local var_35_4 = iter_35_0 > #var_35_0
			local var_35_5 = var_35_1[iter_35_0]

			if iter_35_0 > #var_35_0 then
				local var_35_6 = cloneTplTo(arg_35_0.abilityTpl, arg_35_0.abilityContent) or arg_35_0.abilityContent:GetChild(iter_35_0 - 1)

				GetOrAddComponent(var_35_6, typeof(CanvasGroup)).alpha = var_35_4 and 0 or 1

				if var_35_0[iter_35_0] ~= var_35_5 then
					if not var_35_4 then
						table.insert(var_35_3, function(arg_36_0)
							arg_35_0:managedTween(LeanTween.value, nil, go(var_35_6), 1, 0, var_0_0.ABILITY_TPL_ANIM_TIME):setEase(LeanTweenType.easeInBack):setOnUpdate(System.Action_float(function(arg_37_0)
								GetOrAddComponent(var_35_6, typeof(CanvasGroup)).alpha = arg_37_0

								return
							end)):setOnComplete(System.Action(function()
								setText(var_35_6:Find("name"), var_0_0.config[var_35_5].name)
								setText(var_35_6:Find("value/Text"), arg_35_0.upgradeCfg[var_35_5])
								arg_36_0()

								return
							end))

							return
						end)
					end

					table.insert(var_35_3, function(arg_39_0)
						if var_35_4 then
							setText(var_35_6:Find("name"), var_0_0.config[var_35_5].name)
							setText(var_35_6:Find("value/Text"), arg_35_0.upgradeCfg[var_35_5])
						end

						arg_35_0:managedTween(LeanTween.value, nil, go(var_35_6), 0, 1, var_0_0.ABILITY_TPL_ANIM_TIME):setEase(LeanTweenType.easeOutBack):setOnUpdate(System.Action_float(function(arg_40_0)
							GetOrAddComponent(var_35_6, typeof(CanvasGroup)).alpha = arg_40_0

							return
						end)):setOnComplete(System.Action(function()
							arg_39_0()

							return
						end))

						return
					end)
				end
			end
		end

		seriesAsync(var_35_3, function()
			arg_35_1()

			return
		end)
	else
		arg_35_1()
	end

	return
end

function var_0_0.GetLocalName(arg_43_0)
	if not arg_43_0.unlockRandom then
		return ""
	end

	return PlayerPrefs.GetString(var_0_1 .. arg_43_0.playerId)
end

function var_0_0.SetLocalName(arg_44_0, arg_44_1)
	if not arg_44_0.unlockRandom then
		return
	end

	PlayerPrefs.SetString(var_0_1 .. arg_44_0.playerId, arg_44_1)
	PlayerPrefs.Save()

	return
end

function var_0_0.OnDestroy(arg_45_0)
	arg_45_0:cleanManagedTween()

	return
end

return var_0_0
