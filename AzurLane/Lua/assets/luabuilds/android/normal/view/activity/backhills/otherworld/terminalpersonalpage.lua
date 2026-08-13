class = var_0_10000

local var_0_0 = "TerminalPersonalPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))
local var_0_2 = "otherworld_personal_name"

ActivityConst = var_2
var_0_1.BIND_EVENT_ACT_ID = var_2.OTHER_WORLD_TERMINAL_EVENT_ID
pg = var_2
var_0_1.config = var_2.roll_attr
var_0_1.NAME_ID = 1001
var_0_1.LV_ID = 1002
var_0_1.JOB_ID = 1003
var_0_1.GUARDIAN_ID = 1004
var_0_1.PROPERTY_IDS = (function(arg_1_0)
	local var_1_0 = {}

	for iter_1_0 = arg_1_0[1], arg_1_0[2] do
		if var_0_1.config[iter_1_0] then
			table = var_6

			var_6.insert(var_1_0, iter_1_0)
		end
	end

	return var_1_0
end)({
	2001,
	2006
})
var_0_1.ABILITY_IDS = var_2({
	3000,
	3193
})
var_0_1.RANDOM_ABILITY_CNT = 8

function var_0_1.getUIName(arg_2_0)
	return "TerminalPersonalPage"
end

function var_0_1.OnLoaded(arg_3_0)
	local var_3_0 = arg_3_0._tf

	tostring = var_1_10002
	OtherworldTerminalLayer = var_1_10003
	var_3_0.name = var_1_10002(var_1_10003.PAGE_PERSONAL)

	local var_3_1 = arg_3_0._tf

	arg_3_0.infoTF = var_1.Find(var_3_1, "frame/info")
	setText = var_1

	local var_3_2 = arg_3_0.infoTF
	local var_3_3 = var_2.Find(var_3_2, "title/content/Text")

	i18n = var_3_2

	var_1(var_3_3, var_3_2("personal_info_title"))

	local var_3_4 = arg_3_0.infoTF

	arg_3_0.nameTitle = var_1.Find(var_3_4, "infos/name/title")

	local var_3_5 = arg_3_0.infoTF

	arg_3_0.nameInput = var_1.Find(var_3_5, "infos/name/box/InputField")

	local var_3_6 = arg_3_0.infoTF

	arg_3_0.jobTitle = var_1.Find(var_3_6, "infos/job/title")

	local var_3_7 = arg_3_0.infoTF

	arg_3_0.jobValue = var_1.Find(var_3_7, "infos/job/value")

	local var_3_8 = arg_3_0.infoTF

	arg_3_0.guardianTitle = var_1.Find(var_3_8, "infos/guardian/title")

	local var_3_9 = arg_3_0.infoTF

	arg_3_0.guardianValue = var_1.Find(var_3_9, "infos/guardian/value")

	local var_3_10 = arg_3_0.infoTF

	arg_3_0.lvTitle = var_1.Find(var_3_10, "level/lv/title")

	local var_3_11 = arg_3_0.infoTF

	arg_3_0.lvValue = var_1.Find(var_3_11, "level/lv/value")

	local var_3_12 = arg_3_0.infoTF

	arg_3_0.lvSlider = var_1.Find(var_3_12, "level/slider")

	local var_3_13 = arg_3_0.infoTF

	arg_3_0.lvUpgradeTF = var_1.Find(var_3_13, "level/slider/upgrade")
	setActive = var_1

	var_1(arg_3_0.lvUpgradeTF, false)

	local var_3_14 = arg_3_0._tf

	arg_3_0.propertyTF = var_1.Find(var_3_14, "frame/property")
	setText = var_1

	local var_3_15 = arg_3_0.propertyTF
	local var_3_16 = var_2.Find(var_3_15, "title/content/Text")

	i18n = var_3_15

	var_1(var_3_16, var_3_15("personal_property_title"))

	local var_3_17 = arg_3_0.propertyTF

	arg_3_0.propertyContent = var_1.Find(var_3_17, "content")

	local var_3_18 = arg_3_0.propertyTF

	arg_3_0.propertyTpl = var_1.Find(var_3_18, "tpl")
	setActive = var_1

	var_1(arg_3_0.propertyTpl, false)

	setActive = var_1

	local var_3_19 = arg_3_0.propertyTpl

	var_1(var_2.Find(var_3_19, "upgrade"), false)

	PLATFORM_CODE = var_1
	PLATFORM_CH = var_2

	if var_1 ~= var_2 then
		PLATFORM_CODE = var_1
		PLATFORM_CHT = var_2

		if var_1 == var_2 then
			local var_3_20 = arg_3_0._tf

			arg_3_0.abilityTF = var_1.Find(var_3_20, "frame/ability")
			setActive = var_1

			local var_3_21 = arg_3_0._tf

			var_1(var_2.Find(var_3_21, "frame/ability_2"), false)
		else
			local var_3_22 = arg_3_0._tf

			arg_3_0.abilityTF = var_1.Find(var_3_22, "frame/ability_2")
			setActive = var_1

			local var_3_23 = arg_3_0._tf

			var_1(var_2.Find(var_3_23, "frame/ability"), false)
		end

		setActive = var_1

		var_1(arg_3_0.abilityTF, true)

		setText = var_1

		local var_3_24 = arg_3_0.abilityTF
		local var_3_25 = var_2.Find(var_3_24, "title/content/Text")

		i18n = var_3_24

		var_1(var_3_25, var_3_24("personal_ability_title"))

		local var_3_26 = arg_3_0.abilityTF

		arg_3_0.abilityContent = var_1.Find(var_3_26, "content")

		local var_3_27 = arg_3_0.abilityTF

		arg_3_0.abilityTpl = var_1.Find(var_3_27, "tpl")
		setActive = var_1

		var_1(arg_3_0.abilityTpl, false)

		local var_3_28 = arg_3_0._tf

		arg_3_0.randomBtn = var_1.Find(var_3_28, "frame/random_btn")
		setText = var_1

		local var_3_29 = arg_3_0.randomBtn
		local var_3_30 = var_2.Find(var_3_29, "Text")

		i18n = var_3_29

		var_1(var_3_30, var_3_29("personal_random"))

		local var_3_31 = arg_3_0._tf

		arg_3_0.randomGreyBtn = var_1.Find(var_3_31, "frame/random_btn_grey")
		setText = var_1

		local var_3_32 = arg_3_0.randomGreyBtn
		local var_3_33 = var_2.Find(var_3_32, "Text")

		i18n = var_3_32

		var_1(var_3_33, var_3_32("personal_random"))

		local var_3_34 = arg_3_0._tf

		arg_3_0.effectTF = var_1.Find(var_3_34, "effect")
		setActive = var_1

		var_1(arg_3_0.effectTF, false)

		getProxy = var_1
		PlayerProxy = var_2

		local var_3_35 = var_1(var_2)

		arg_3_0.playerId = var_1.getRawData(var_3_35).id
		getProxy = var_1
		PlayerProxy = var_3_35

		local var_3_36 = var_1(var_3_35)

		arg_3_0.showName = var_1.getRawData(var_3_36).name

		return
	end
end

function var_0_1.OnInit(arg_4_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_4_0 = var_1_10001(var_1_10002)

	arg_4_0.activity = var_1.getActivityById(var_4_0, var_0_1.BIND_EVENT_ACT_ID)
	assert = var_1

	var_1(arg_4_0.activity, "not exist bind event act, id" .. var_0_1.BIND_EVENT_ACT_ID)

	local var_4_1 = arg_4_0.nameInput
	local var_4_2 = var_1.GetComponent

	typeof = var_3
	InputField = var_4

	local var_4_3 = var_4_2(var_4_1, var_3(var_4)).onValueChanged

	var_1.AddListener(var_4_3, function()
		if arg_4_0.unlockRandom then
			nameValidityCheck = var_0
			getInputText = var_2_10001

			if not var_0(var_2_10001(arg_4_0.nameInput), 4, 14, {
				"spece_illegal_tip",
				"login_newPlayerScene_name_tooShort",
				"login_newPlayerScene_name_tooLong",
				"login_newPlayerScene_invalideName"
			}) then
				var_2_10001 = arg_4_0

				var_0.SetDefaultName(var_2_10001)
			else
				local var_5_0 = arg_4_0

				getInputText = var_2_10001
				var_5_0.showName = var_2_10001(arg_4_0.nameInput)
				setInputText = var_5_0

				var_5_0(arg_4_0.nameInput, arg_4_0.showName)

				local var_5_1 = arg_4_0

				var_0.SetLocalName(var_5_1, arg_4_0.showName)
			end

			return
		end
	end)

	onButton = var_1

	local var_4_4 = arg_4_0
	local var_4_5 = arg_4_0.randomBtn

	local function var_4_6()
		setActive = var_2_10000

		var_2_10000(arg_4_0.effectTF, false)

		setActive = var_2_10000

		var_2_10000(arg_4_0.effectTF, true)

		setActive = var_2_10000

		var_2_10000(arg_4_0.randomBtn, false)

		setActive = var_2_10000

		var_2_10000(arg_4_0.randomGreyBtn, false)

		local var_6_0 = arg_4_0
		local var_6_1 = var_0.managedTween

		LeanTween = var_2

		var_6_1(var_6_0, var_2.delayedCall, function()
			OtherworldMapScene = var_3_10000
			var_3_10000.personalRandomData = {}

			local var_7_0 = arg_4_0

			var_0.UpdateView(var_7_0, true)

			setActive = var_0

			var_0(arg_4_0.effectTF, false)

			setActive = var_0

			var_0(arg_4_0.randomBtn, arg_4_0.unlockRandom)

			setActive = var_0

			var_0(arg_4_0.randomGreyBtn, not arg_4_0.unlockRandom)

			return
		end, var_0_1.RANDOM_CHANGE_TIME, nil)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_4_4, var_4_5, var_4_6, var_1_10005)

	onButton = var_1

	local var_4_7 = arg_4_0
	local var_4_8 = arg_4_0.randomGreyBtn

	local function var_4_9()
		pg = var_2_10000

		local var_8_0 = var_2_10000.TipsMgr.GetInstance()
		local var_8_1 = var_0.ShowTips

		i18n = var_2_10002

		var_8_1(var_8_0, var_2_10002("personal_random_tip"))

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_4_7, var_4_8, var_4_9, var_1_10005)

	local var_4_10 = arg_4_0.activity

	arg_4_0.unlockRandom = var_1.IsFinishAllMain(var_4_10)
	setActive = var_1

	var_1(arg_4_0.randomBtn, arg_4_0.unlockRandom)

	setActive = var_1

	var_1(arg_4_0.randomGreyBtn, not arg_4_0.unlockRandom)

	setActive = var_1

	local var_4_11 = arg_4_0.infoTF

	var_1(var_2.Find(var_4_11, "infos/name/box/edit"), arg_4_0.unlockRandom)

	if arg_4_0.unlockRandom and arg_4_0:GetLocalName() ~= "" then
		arg_4_0.showName = arg_4_0:GetLocalName()
	end

	local var_4_12 = arg_4_0.nameInput
	local var_4_13 = var_1.GetComponent

	typeof = var_3
	InputField = var_4
	var_4_13(var_4_12, var_3(var_4)).interactable = arg_4_0.unlockRandom

	arg_4_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_9_0, arg_9_1)
	if arg_9_0.contextData.upgrade then
		local var_9_0 = arg_9_0.activity
		local var_9_2

		if not var_2.GetLastShowConfig(var_9_0) then
			local var_9_1 = arg_9_0.activity

			var_9_2 = var_2.GetShowConfig(var_9_1)
		end

		arg_9_0.showCfg = {}
		ipairs = var_3

		for iter_9_0, iter_9_1 in var_3(var_9_2) do
			arg_9_0.showCfg[iter_9_1[1]] = iter_9_1[2]
		end

		arg_9_0:UpdateInfo(arg_9_1)
		arg_9_0:UpdateProperty(arg_9_1)
		arg_9_0:UpdateAbility(arg_9_1)

		if arg_9_0.contextData.upgrade then
			arg_9_0.upgradeCfg = {}
			ipairs = var_3

			local var_9_3 = arg_9_0.activity

			for iter_9_2, iter_9_3 in var_3(var_4.GetShowConfig(var_9_3)) do
				arg_9_0.upgradeCfg[iter_9_3[1]] = iter_9_3[2]
			end

			arg_9_0:PlayUpgradeAnims()
		end

		return
	end
end

function var_0_1.SetDefaultName(arg_10_0)
	setInputText = var_1_10001

	var_1_10001(arg_10_0.nameInput, arg_10_0.showName)

	return
end

function var_0_1.UpdateInfo(arg_11_0, arg_11_1)
	arg_11_0:SetDefaultName()

	local var_11_0 = arg_11_0
	local var_11_1 = arg_11_0.GetRollAttrInfoById(var_11_0, var_0_1.NAME_ID, arg_11_1)

	setText = var_11_0

	var_11_0(arg_11_0.nameTitle, var_11_1 .. "：")

	local var_11_2, var_11_3 = arg_11_0:GetRollAttrInfoById(var_0_1.JOB_ID, arg_11_1)

	setText = var_5

	var_5(arg_11_0.jobTitle, var_11_2 .. "：")

	setText = var_5

	var_5(arg_11_0.jobValue, var_11_3)

	local var_11_4, var_11_5 = arg_11_0:GetRollAttrInfoById(var_0_1.GUARDIAN_ID, arg_11_1)

	setText = var_7

	var_7(arg_11_0.guardianTitle, var_11_4 .. "：")

	setText = var_7

	var_7(arg_11_0.guardianValue, var_11_5)

	local var_11_6, var_11_7 = arg_11_0:GetRollAttrInfoById(var_0_1.LV_ID, arg_11_1)

	setText = var_9

	var_9(arg_11_0.lvTitle, var_11_6 .. "：")

	setText = var_9

	var_9(arg_11_0.lvValue, var_11_7)

	setSlider = var_9

	local var_11_8 = arg_11_0.lvSlider
	local var_11_9 = 0
	local var_11_10 = 1

	tonumber = var_1_10013

	var_9(var_11_8, var_11_9, var_11_10, var_1_10013(var_11_7) / var_0_1.config[var_0_1.LV_ID].random_value[2])

	if arg_11_1 then
		OtherworldMapScene = var_9

		local var_11_11 = var_9.personalRandomData

		var_11_11[var_0_1.JOB_ID] = var_11_3
		OtherworldMapScene = var_11_11

		local var_11_12 = var_11_11.personalRandomData

		var_11_12[var_0_1.GUARDIAN_ID] = var_11_5
		OtherworldMapScene = var_11_12
		var_11_12.personalRandomData[var_0_1.LV_ID] = var_11_7
	end

	return
end

function var_0_1.UpdateProperty(arg_12_0, arg_12_1)
	local var_12_0 = 0

	ipairs = var_1_10003

	for iter_12_0, iter_12_1 in var_1_10003(var_0_1.PROPERTY_IDS) do
		var_12_0 = var_12_0 + 1

		if arg_12_0.propertyContent.childCount < var_12_0 then
			cloneTplTo = var_8

			local var_12_2

			if not var_8(arg_12_0.propertyTpl, arg_12_0.propertyContent) then
				local var_12_1 = arg_12_0.propertyContent

				var_12_2 = var_8.GetChild(var_12_1, var_12_0 - 1)
			end

			var_12_2.name = iter_12_1

			local var_12_3, var_12_4 = arg_12_0:GetRollAttrInfoById(iter_12_1, arg_12_1)

			setText = var_11

			var_11(var_12_2:Find("name"), var_12_3)

			setText = var_11

			var_11(var_12_2:Find("value/Text"), var_12_4)

			if arg_12_1 then
				OtherworldMapScene = var_11
				var_11.personalRandomData[iter_12_1] = var_12_4
			end
		end
	end

	for iter_12_2 = 1, arg_12_0.propertyContent.childCount - 1 do
		if var_12_0 < iter_12_2 then
			setActive = iter_12_1

			local var_12_5 = arg_12_0.propertyContent

			iter_12_1(var_8.GetChild(var_12_5, iter_12_2 - 1), false)
		end
	end

	return
end

function var_0_1.UpdateAbility(arg_13_0, arg_13_1)
	local var_13_0 = {}

	if arg_13_1 then
		var_1_10004 = arg_13_0
		var_13_0 = arg_13_0.GetRandomAbilityIds(var_1_10004)
	else
		OtherworldMapScene = var_1_10003

		if var_1_10003.personalRandomData then
			pairs = var_1_10003
			OtherworldMapScene = var_1_10004

			for iter_13_0, iter_13_1 in var_1_10003(var_1_10004.personalRandomData) do
				table = var_1_10008

				if var_1_10008.contains(var_0_1.ABILITY_IDS, iter_13_0) then
					table = var_1_10008

					var_1_10008.insert(var_13_0, iter_13_0)
				end
			end
		else
			pairs = var_1_10003

			for iter_13_2, iter_13_3 in var_1_10003(arg_13_0.showCfg) do
				table = var_1_10008

				if var_1_10008.contains(var_0_1.ABILITY_IDS, iter_13_2) then
					table = var_1_10008

					var_1_10008.insert(var_13_0, iter_13_2)
				end
			end
		end
	end

	table = var_1_10003

	var_1_10003.sort(var_13_0)

	ipairs = var_3

	for iter_13_4, iter_13_5 in var_3(var_13_0) do
		if arg_13_0.abilityContent.childCount < iter_13_4 then
			cloneTplTo = var_8

			local var_13_2

			if not var_8(arg_13_0.abilityTpl, arg_13_0.abilityContent) then
				local var_13_1 = arg_13_0.abilityContent

				var_13_2 = var_8.GetChild(var_13_1, iter_13_4 - 1)
			end

			var_13_2.name = iter_13_4

			local var_13_3, var_13_4 = arg_13_0:GetRollAttrInfoById(iter_13_5, arg_13_1)

			setText = var_11

			var_11(var_13_2:Find("name"), var_13_3)

			setText = var_11

			var_11(var_13_2:Find("value/Text"), var_13_4)

			if arg_13_1 then
				OtherworldMapScene = var_11
				var_11.personalRandomData[iter_13_5] = var_13_4
			end
		end
	end

	for iter_13_6 = 1, arg_13_0.abilityContent.childCount do
		if #var_13_0 < iter_13_6 then
			setActive = var_7

			local var_13_5 = arg_13_0.abilityContent

			var_7(var_8.GetChild(var_13_5, iter_13_6 - 1), false)
		end
	end

	return
end

function var_0_1.GetRollAttrInfoById(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = ""

	if arg_14_2 then
		local var_14_1 = var_0_1.config[arg_14_1].random_value

		table = var_1_10005

		if var_1_10005.contains(var_0_1.PROPERTY_IDS, arg_14_1) or arg_14_1 == var_0_1.LV_ID then
			math = var_1_10005
			var_14_0 = var_1_10005.random(var_14_1[1], var_14_1[2])
		else
			math = var_1_10005
			var_14_0 = var_14_1[var_1_10005.random(#var_14_1)]
		end
	else
		var_14_0 = arg_14_0.showCfg[arg_14_1] or var_0_1.config[arg_14_1].default_value
		OtherworldMapScene = var_4

		if var_4.personalRandomData then
			OtherworldMapScene = var_4
			var_14_0 = var_4.personalRandomData[arg_14_1]
		end
	end

	local var_14_2 = var_0_1.config[arg_14_1].name

	tostring = var_1_10005

	local var_14_3 = var_1_10005(var_14_0)
end

function var_0_1.GetRandomAbilityIds(arg_15_0)
	local var_15_0 = {}

	for iter_15_0 = 1, #var_0_1.ABILITY_IDS do
		table = var_1_10006

		var_1_10006.insert(var_15_0, iter_15_0)
	end

	shuffle = var_2

	var_2(var_15_0)

	local var_15_1 = {}

	for iter_15_1 = 1, var_0_1.RANDOM_ABILITY_CNT do
		table = var_1_10007

		var_1_10007.insert(var_15_1, var_0_1.ABILITY_IDS[var_15_0[iter_15_1]])
	end

	return var_15_1
end

var_0_1.UPGRADE_TAG_SHOW_TIME = 2
var_0_1.LV_ANIM_TIME = 0.5
var_0_1.PROPERTY_TPL_ANIM_TIME = 0.5
var_0_1.ABILITY_TPL_ANIM_TIME = 0.5
var_0_1.RANDOM_CHANGE_TIME = 0.8

function var_0_1.PlayUpgradeAnims(arg_16_0)
	seriesAsync = var_1_10001

	var_1_10001({
		function(arg_17_0)
			local var_17_0 = arg_16_0

			var_1.PlayLevelAnim(var_17_0, arg_17_0)

			return
		end,
		function(arg_18_0)
			local var_18_0 = arg_16_0

			var_1.PlayPropertyAnim(var_18_0, arg_18_0)

			return
		end,
		function(arg_19_0)
			local var_19_0 = arg_16_0

			var_1.PlayAbilityAnim(var_19_0, arg_19_0)

			return
		end
	}, function()
		arg_16_0.contextData.upgrade = nil

		return
	end)

	return
end

function var_0_1.GetStaticInfo(arg_21_0, arg_21_1)
	tonumber = var_1_10002

	local var_21_0

	if not arg_21_0.showCfg[arg_21_1] then
		var_21_0 = var_0_1.config[arg_21_1].default_value
	end

	local var_21_1 = var_1_10002(var_21_0)

	tonumber = var_21_0

	local var_21_2

	if not arg_21_0.upgradeCfg[arg_21_1] then
		var_21_2 = var_21_1
	end

	local var_21_3 = var_21_0(var_21_2)

	return var_21_1, var_21_3, var_21_3 - var_21_1 ~= 0
end

function var_0_1.PlayLevelAnim(arg_22_0, arg_22_1)
	local var_22_0, var_22_1, var_22_2 = arg_22_0:GetStaticInfo(var_0_1.LV_ID)

	setActive = var_1_10005

	var_1_10005(arg_22_0.lvUpgradeTF, var_22_2)

	if var_22_2 then
		local var_22_3 = arg_22_0
		local var_22_4 = arg_22_0.managedTween

		LeanTween = var_7

		var_22_4(var_22_3, var_7.delayedCall, function()
			setActive = var_2_10000

			var_2_10000(arg_22_0.lvUpgradeTF, false)

			return
		end, var_0_1.UPGRADE_TAG_SHOW_TIME, nil)

		local var_22_5 = arg_22_0
		local var_22_6 = arg_22_0.managedTween

		LeanTween = var_7

		local var_22_7 = var_7.value
		local var_22_8

		go = var_9

		local var_22_9 = var_22_6(var_22_5, var_22_7, var_22_8, var_9(arg_22_0.lvValue), var_22_0, var_22_1, var_0_1.LV_ANIM_TIME)
		local var_22_10 = var_5.setOnUpdate

		System = var_22_7

		local var_22_11 = var_22_10(var_22_9, var_22_7.Action_float(function(arg_24_0)
			setText = var_2_10001

			local var_24_0 = arg_22_0.lvValue

			math = var_2_10003

			var_2_10001(var_24_0, var_2_10003.floor(arg_24_0))

			return
		end))
		local var_22_12 = var_5.setOnComplete

		System = var_7

		var_22_12(var_22_11, var_7.Action(function()
			arg_22_1()

			return
		end))

		local var_22_13 = var_0_1.config[var_0_1.LV_ID].random_value[2]
		local var_22_14 = arg_22_0
		local var_22_15 = arg_22_0.managedTween

		LeanTween = var_8

		local var_22_16 = var_8.value
		local var_22_17

		go = var_10

		local var_22_18 = var_22_15(var_22_14, var_22_16, var_22_17, var_10(arg_22_0.lvSlider), var_22_0 / var_22_13, var_22_1 / var_22_13, var_0_1.LV_ANIM_TIME)
		local var_22_19 = var_6.setOnUpdate

		System = var_22_16

		var_22_19(var_22_18, var_22_16.Action_float(function(arg_26_0)
			setSlider = var_2_10001

			var_2_10001(arg_22_0.lvSlider, 0, 1, arg_26_0)

			return
		end))
	else
		arg_22_1()
	end

	return
end

function var_0_1.PlayPropertyAnim(arg_27_0, arg_27_1)
	local var_27_0 = {}

	for iter_27_0 = 1, #var_0_1.PROPERTY_IDS do
		if iter_27_0 > arg_27_0.propertyContent.childCount then
			cloneTplTo = var_1_10008

			if not var_1_10008(arg_27_0.propertyTpl, arg_27_0.propertyContent) then
				local var_27_1 = arg_27_0.propertyContent

				var_1_10008 = var_1_10008.GetChild(var_27_1, iter_27_0 - 1)
			end

			local var_27_2 = var_0_1.PROPERTY_IDS[iter_27_0]
			local var_27_3, var_27_4, var_27_5 = arg_27_0:GetStaticInfo(var_27_2)

			if var_7 then
				setText = var_1_10013

				var_1_10013(var_1_10008:Find("name"), var_0_1.config[var_27_2].name)

				setText = var_1_10013

				var_1_10013(var_1_10008:Find("value/Text"), var_27_3)
			end

			if var_27_5 then
				table = var_1_10013

				var_1_10013.insert(var_27_0, function(arg_28_0)
					setActive = var_2_10001

					local var_28_0 = var_1_10008

					var_2_10001(var_2.Find(var_28_0, "upgrade"), var_27_5)

					local var_28_1 = arg_27_0
					local var_28_2 = var_1.managedTween

					LeanTween = var_3

					var_28_2(var_28_1, var_3.delayedCall, function()
						setActive = var_3_10000

						local var_29_0 = var_1_10008

						var_3_10000(var_1.Find(var_29_0, "upgrade"), false)

						return
					end, var_0_1.UPGRADE_TAG_SHOW_TIME, nil)

					local var_28_3 = arg_27_0
					local var_28_4 = var_1.managedTween

					LeanTween = var_3

					local var_28_5 = var_3.value
					local var_28_6

					go = var_5

					local var_28_7 = var_28_4(var_28_3, var_28_5, var_28_6, var_5(var_1_10008), var_27_3, var_27_4, var_0_1.PROPERTY_TPL_ANIM_TIME)
					local var_28_8 = var_1.setOnUpdate

					System = var_28_5

					local var_28_9 = var_28_8(var_28_7, var_28_5.Action_float(function(arg_30_0)
						setText = var_3_10001

						local var_30_0 = var_1_10008
						local var_30_1 = var_2.Find(var_30_0, "value/Text")

						math = var_30_0

						var_3_10001(var_30_1, var_30_0.floor(arg_30_0))

						return
					end))
					local var_28_10 = var_1.setOnComplete

					System = var_3

					var_28_10(var_28_9, var_3.Action(function()
						arg_28_0()

						return
					end))

					return
				end)
			end
		end
	end

	seriesAsync = var_3

	var_3(var_27_0, function()
		arg_27_1()

		return
	end)

	return
end

function var_0_1.GetDynamicInfo(arg_33_0, arg_33_1)
	local var_33_0 = {}
	local var_33_1 = {}

	pairs = var_1_10004

	for iter_33_0, iter_33_1 in var_1_10004(arg_33_0.showCfg) do
		table = var_1_10009

		if var_1_10009.contains(var_0_1.ABILITY_IDS, iter_33_0) then
			table = var_1_10009

			var_1_10009.insert(var_33_0, iter_33_0)
		end
	end

	table = var_4

	var_4.sort(var_33_0)

	pairs = var_4

	for iter_33_2, iter_33_3 in var_4(arg_33_0.upgradeCfg) do
		table = var_1_10009

		if var_1_10009.contains(var_0_1.ABILITY_IDS, iter_33_2) then
			table = var_1_10009

			var_1_10009.insert(var_33_1, iter_33_2)
		end
	end

	table = var_4

	var_4.sort(var_33_1)

	local var_33_2

	if #var_33_0 == #var_33_1 then
		underscore = var_4
		var_33_2 = var_4.any(var_33_1, function(arg_34_0)
			table = var_2_10001

			return not var_2_10001.contains(var_33_0, arg_34_0)
		end)

		if false then
			var_33_2 = false
		end
	else
		var_33_2 = true
	end

	return var_33_0, var_33_1, var_33_2
end

function var_0_1.PlayAbilityAnim(arg_35_0, arg_35_1)
	local var_35_0, var_35_1, var_35_2 = arg_35_0:GetDynamicInfo()

	if var_35_2 then
		local var_35_3 = {}

		for iter_35_0 = 1, #var_35_1 do
			local var_35_4 = iter_35_0 > #var_35_0
			local var_35_5 = var_35_1[iter_35_0]

			if var_35_4 then
				cloneTplTo = var_1_10012

				if not var_1_10012(arg_35_0.abilityTpl, arg_35_0.abilityContent) then
					var_1_10013 = arg_35_0.abilityContent
					var_1_10012 = var_1_10012.GetChild(var_1_10013, iter_35_0 - 1)
				end

				GetOrAddComponent = var_1_10013

				local var_35_6 = var_1_10012

				typeof = var_1_10015
				CanvasGroup = var_1_10016
				var_1_10013 = var_1_10013(var_35_6, var_1_10015(var_1_10016))
				var_1_10013.alpha = var_35_4 and 0 or 1

				if var_35_0[iter_35_0] ~= var_35_5 then
					if not var_35_4 then
						table = var_1_10013

						var_1_10013.insert(var_35_3, function(arg_36_0)
							local var_36_0 = arg_35_0
							local var_36_1 = var_1.managedTween

							LeanTween = var_2_10003

							local var_36_2 = var_2_10003.value
							local var_36_3

							go = var_2_10005

							local var_36_4 = var_36_1(var_36_0, var_36_2, var_36_3, var_2_10005(var_1_10012), 1, 0, var_0_1.ABILITY_TPL_ANIM_TIME)
							local var_36_5 = var_1.setEase

							LeanTweenType = var_36_2

							local var_36_6 = var_36_5(var_36_4, var_36_2.easeInBack)
							local var_36_7 = var_1.setOnUpdate

							System = var_3

							local var_36_8 = var_36_7(var_36_6, var_3.Action_float(function(arg_37_0)
								GetOrAddComponent = var_3_10001

								local var_37_0 = var_1_10012

								typeof = var_3_10003
								CanvasGroup = var_3_10004
								var_3_10001(var_37_0, var_3_10003(var_3_10004)).alpha = arg_37_0

								return
							end))
							local var_36_9 = var_1.setOnComplete

							System = var_3

							var_36_9(var_36_8, var_3.Action(function()
								setText = var_3_10000

								local var_38_0 = var_1_10012

								var_3_10000(var_1.Find(var_38_0, "name"), var_0_1.config[var_35_5].name)

								setText = var_3_10000

								local var_38_1 = var_1_10012

								var_3_10000(var_1.Find(var_38_1, "value/Text"), arg_35_0.upgradeCfg[var_35_5])
								arg_36_0()

								return
							end))

							return
						end)
					end

					table = var_1_10013

					var_1_10013.insert(var_35_3, function(arg_39_0)
						if var_35_4 then
							setText = var_1
							var_2_10003 = var_1_10012

							var_1(var_2.Find(var_2_10003, "name"), var_0_1.config[var_35_5].name)

							setText = var_1
							var_2_10003 = var_1_10012

							var_1(var_2.Find(var_2_10003, "value/Text"), arg_35_0.upgradeCfg[var_35_5])
						end

						local var_39_0 = arg_35_0
						local var_39_1 = var_1.managedTween

						LeanTween = var_2_10003

						local var_39_2 = var_2_10003.value
						local var_39_3

						go = var_2_10005

						local var_39_4 = var_39_1(var_39_0, var_39_2, var_39_3, var_2_10005(var_1_10012), 0, 1, var_0_1.ABILITY_TPL_ANIM_TIME)
						local var_39_5 = var_1.setEase

						LeanTweenType = var_39_2

						local var_39_6 = var_39_5(var_39_4, var_39_2.easeOutBack)
						local var_39_7 = var_1.setOnUpdate

						System = var_3

						local var_39_8 = var_39_7(var_39_6, var_3.Action_float(function(arg_40_0)
							GetOrAddComponent = var_3_10001

							local var_40_0 = var_1_10012

							typeof = var_3_10003
							CanvasGroup = var_3_10004
							var_3_10001(var_40_0, var_3_10003(var_3_10004)).alpha = arg_40_0

							return
						end))
						local var_39_9 = var_1.setOnComplete

						System = var_3

						var_39_9(var_39_8, var_3.Action(function()
							arg_39_0()

							return
						end))

						return
					end)
				end
			end
		end

		seriesAsync = var_6

		var_6(var_35_3, function()
			arg_35_1()

			return
		end)
	else
		arg_35_1()
	end

	return
end

function var_0_1.GetLocalName(arg_43_0)
	if not arg_43_0.unlockRandom then
		return ""
	end

	PlayerPrefs = var_1

	return var_1.GetString(var_0_2 .. arg_43_0.playerId)
end

function var_0_1.SetLocalName(arg_44_0, arg_44_1)
	if not arg_44_0.unlockRandom then
		return
	end

	PlayerPrefs = var_2

	var_2.SetString(var_0_2 .. arg_44_0.playerId, arg_44_1)

	PlayerPrefs = var_2

	var_2.Save()

	return
end

function var_0_1.OnDestroy(arg_45_0)
	arg_45_0:cleanManagedTween()

	return
end

return var_0_1
