class = var_0_10000

local var_0_0 = "SecretsAbyssPersonalPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.BackHills.OtherWorld.TerminalPersonalPage"))
local var_0_2 = "otherworld_personal_name"

var_0_1.BIND_EVENT_ACT_ID = 50094
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
var_0_1.personalRandomData = nil

function var_0_1.getUIName(arg_2_0)
	return "SecretsAbyssPersonalPage"
end

function var_0_1.OnLoaded(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.infoTF = var_1.Find(var_3_0, "frame/info")

	local var_3_1 = arg_3_0.infoTF

	arg_3_0.nameTitle = var_1.Find(var_3_1, "infos/name/title")

	local var_3_2 = arg_3_0.infoTF

	arg_3_0.nameInput = var_1.Find(var_3_2, "infos/name/box/InputField")

	local var_3_3 = arg_3_0.infoTF

	arg_3_0.jobTitle = var_1.Find(var_3_3, "infos/job/title")

	local var_3_4 = arg_3_0.infoTF

	arg_3_0.jobValue = var_1.Find(var_3_4, "infos/job/value")

	local var_3_5 = arg_3_0.infoTF

	arg_3_0.guardianTitle = var_1.Find(var_3_5, "infos/guardian/title")

	local var_3_6 = arg_3_0.infoTF

	arg_3_0.guardianValue = var_1.Find(var_3_6, "infos/guardian/value")

	local var_3_7 = arg_3_0.infoTF

	arg_3_0.lvTitle = var_1.Find(var_3_7, "level/lv/title")

	local var_3_8 = arg_3_0.infoTF

	arg_3_0.lvValue = var_1.Find(var_3_8, "level/lv/value")

	local var_3_9 = arg_3_0.infoTF

	arg_3_0.lvSlider = var_1.Find(var_3_9, "level/slider/slider")

	local var_3_10 = arg_3_0.lvSlider
	local var_3_11 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_3_0.lvSliderImage = var_3_11(var_3_10, var_3(var_1_10004))

	local var_3_12 = arg_3_0.infoTF

	arg_3_0.lvUpgradeTF = var_1.Find(var_3_12, "level/slider/upgrade")
	setActive = var_1

	var_1(arg_3_0.lvUpgradeTF, false)

	local var_3_13 = arg_3_0._tf

	arg_3_0.propertyTF = var_1.Find(var_3_13, "frame/property")

	local var_3_14 = arg_3_0.propertyTF

	arg_3_0.propertyContent = var_1.Find(var_3_14, "content")

	local var_3_15 = arg_3_0.propertyTF

	arg_3_0.propertyTpl = var_1.Find(var_3_15, "tpl")
	setActive = var_1

	var_1(arg_3_0.propertyTpl, false)

	setActive = var_1

	local var_3_16 = arg_3_0.propertyTpl

	var_1(var_2.Find(var_3_16, "upgrade"), false)

	PLATFORM_CODE = var_1
	PLATFORM_CH = var_2

	if var_1 ~= var_2 then
		PLATFORM_CODE = var_1
		PLATFORM_CHT = var_2

		if var_1 == var_2 then
			local var_3_17 = arg_3_0._tf

			arg_3_0.abilityTF = var_1.Find(var_3_17, "frame/ability")
			setActive = var_1

			local var_3_18 = arg_3_0._tf

			var_1(var_2.Find(var_3_18, "frame/ability_2"), false)
		else
			local var_3_19 = arg_3_0._tf

			arg_3_0.abilityTF = var_1.Find(var_3_19, "frame/ability_2")
			setActive = var_1

			local var_3_20 = arg_3_0._tf

			var_1(var_2.Find(var_3_20, "frame/ability"), false)
		end

		setActive = var_1

		var_1(arg_3_0.abilityTF, true)

		local var_3_21 = arg_3_0.abilityTF

		arg_3_0.abilityContent = var_1.Find(var_3_21, "content")

		local var_3_22 = arg_3_0.abilityTF

		arg_3_0.abilityTpl = var_1.Find(var_3_22, "tpl")
		setActive = var_1

		var_1(arg_3_0.abilityTpl, false)

		local var_3_23 = arg_3_0._tf

		arg_3_0.randomBtn = var_1.Find(var_3_23, "frame/random_btn")

		local var_3_24 = arg_3_0._tf

		arg_3_0.helpBtn = var_1.Find(var_3_24, "frame/help_tips")

		local var_3_25 = arg_3_0._tf

		arg_3_0.effectTF = var_1.Find(var_3_25, "effect")
		setActive = var_1

		var_1(arg_3_0.effectTF, false)

		local var_3_26 = arg_3_0._tf

		arg_3_0.quitBtn = var_1.Find(var_3_26, "frame/close_btn")
		getProxy = var_1
		PlayerProxy = var_3_26

		local var_3_27 = var_1(var_3_26)

		arg_3_0.playerId = var_1.getRawData(var_3_27).id
		getProxy = var_1
		PlayerProxy = var_3_27

		local var_3_28 = var_1(var_3_27)

		arg_3_0.showName = var_1.getRawData(var_3_28).name

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

		local var_6_0 = arg_4_0
		local var_6_1 = var_0.managedTween

		LeanTween = var_2

		var_6_1(var_6_0, var_2.delayedCall, function()
			var_0_1.personalRandomData = {}

			local var_7_0 = arg_4_0

			var_0.UpdateView(var_7_0, true)

			setActive = var_0

			var_0(arg_4_0.effectTF, false)

			setActive = var_0

			var_0(arg_4_0.randomBtn, arg_4_0.unlockRandom)

			return
		end, var_0_1.RANDOM_CHANGE_TIME, nil)

		if arg_4_0.randomCallback then
			local var_6_2 = arg_4_0

			var_0.randomCallback(var_6_2)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_4_4, var_4_5, var_4_6, var_1_10005)

	onButton = var_1

	local var_4_7 = arg_4_0
	local var_4_8 = arg_4_0.helpBtn

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

	setActive = var_1

	var_1(arg_4_0.randomBtn, arg_4_0.unlockRandom)

	setActive = var_1

	var_1(arg_4_0.helpBtn, not arg_4_0.unlockRandom)

	setActive = var_1

	local var_4_10 = arg_4_0.infoTF

	var_1(var_2.Find(var_4_10, "infos/name/box/edit"), arg_4_0.unlockRandom)

	if arg_4_0.unlockRandom and arg_4_0:GetLocalName() ~= "" then
		arg_4_0.showName = arg_4_0:GetLocalName()
	end

	local var_4_11 = arg_4_0.nameInput
	local var_4_12 = var_1.GetComponent

	typeof = var_3
	InputField = var_4

	local var_4_13 = var_4_12(var_4_11, var_3(var_4))

	var_4_13.interactable = arg_4_0.unlockRandom
	onButton = var_4_13

	var_4_13(arg_4_0, arg_4_0.quitBtn, function()
		local var_9_0 = arg_4_0

		var_0.Hide(var_9_0)

		return
	end)

	onButton = var_4_13

	local var_4_14 = arg_4_0
	local var_4_15 = arg_4_0._tf

	var_4_13(var_4_14, var_3.Find(var_4_15, "mask"), function()
		local var_10_0 = arg_4_0

		var_0.Hide(var_10_0)

		return
	end)
	arg_4_0:UpdateView()

	return
end

function var_0_1.UnlockRandom(arg_11_0)
	arg_11_0.unlockRandom = true

	return
end

function var_0_1.SetUpgrade(arg_12_0)
	arg_12_0.upgradeFlag = true

	return
end

function var_0_1.SetBossRushNode(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.currentBossRushNode = arg_13_1
	arg_13_0.lastBossRushNode = arg_13_2

	return
end

function var_0_1.GetActivitySingleEventOption(arg_14_0, arg_14_1)
	ipairs = var_1_10002
	pg = var_1_10003

	for iter_14_0, iter_14_1 in var_1_10002(var_1_10003.activity_single_event.all) do
		pg = var_1_10007

		if var_1_10007.activity_single_event[iter_14_1].story == arg_14_1:getConfig("story") then
			return var_1_10007.options
		end
	end

	return
end

function var_0_1.GetCurrentEvent(arg_15_0)
	return arg_15_0.currentBossRushNode
end

function var_0_1.RegisterRandomCallback(arg_16_0, arg_16_1)
	arg_16_0.randomCallback = arg_16_1

	return
end

function var_0_1.UpdateView(arg_17_0, arg_17_1)
	local var_17_0

	if arg_17_0.upgradeFlag or #arg_17_0:GetActivitySingleEventOption(arg_17_0.currentBossRushNode) == 0 then
		var_17_0 = arg_17_0:GetActivitySingleEventOption(arg_17_0.lastBossRushNode)
	else
		var_17_0 = arg_17_0:GetActivitySingleEventOption(arg_17_0.currentBossRushNode)
	end

	arg_17_0.showCfg = {}
	ipairs = var_3

	for iter_17_0, iter_17_1 in var_3(var_17_0) do
		arg_17_0.showCfg[iter_17_1[1]] = iter_17_1[2]
	end

	arg_17_0:UpdateInfo(arg_17_1)
	arg_17_0:UpdateProperty(arg_17_1)
	arg_17_0:UpdateAbility(arg_17_1)

	if arg_17_0.upgradeFlag then
		arg_17_0.upgradeCfg = {}
		ipairs = var_3

		for iter_17_2, iter_17_3 in var_3(arg_17_0:GetActivitySingleEventOption(arg_17_0.currentBossRushNode)) do
			arg_17_0.upgradeCfg[iter_17_3[1]] = iter_17_3[2]
		end

		arg_17_0:PlayUpgradeAnims()
	end

	return
end

function var_0_1.UpdateInfo(arg_18_0, arg_18_1)
	arg_18_0:SetDefaultName()

	local var_18_0 = arg_18_0
	local var_18_1 = arg_18_0.GetRollAttrInfoById(var_18_0, var_0_1.NAME_ID, arg_18_1)

	setText = var_18_0

	var_18_0(arg_18_0.nameTitle, var_18_1 .. "：")

	local var_18_2, var_18_3 = arg_18_0:GetRollAttrInfoById(var_0_1.JOB_ID, arg_18_1)

	setText = var_5

	var_5(arg_18_0.jobTitle, var_18_2 .. "：")

	setText = var_5

	var_5(arg_18_0.jobValue, var_18_3)

	local var_18_4, var_18_5 = arg_18_0:GetRollAttrInfoById(var_0_1.GUARDIAN_ID, arg_18_1)

	setText = var_7

	var_7(arg_18_0.guardianTitle, var_18_4 .. "：")

	setText = var_7

	var_7(arg_18_0.guardianValue, var_18_5)

	local var_18_6, var_18_7 = arg_18_0:GetRollAttrInfoById(var_0_1.LV_ID, arg_18_1)

	setText = var_9

	var_9(arg_18_0.lvTitle, var_18_6 .. "：")

	setText = var_9

	var_9(arg_18_0.lvValue, var_18_7)

	local var_18_8 = arg_18_0.lvSliderImage

	tonumber = var_10
	var_18_8.fillAmount = var_10(var_18_7) / var_0_1.config[var_0_1.LV_ID].random_value[2]

	if arg_18_1 then
		var_0_1.personalRandomData[var_0_1.JOB_ID] = var_18_3
		var_0_1.personalRandomData[var_0_1.GUARDIAN_ID] = var_18_5
		var_0_1.personalRandomData[var_0_1.LV_ID] = var_18_7
	end

	return
end

function var_0_1.UpdateProperty(arg_19_0, arg_19_1)
	local var_19_0 = 0

	ipairs = var_1_10003

	for iter_19_0, iter_19_1 in var_1_10003(var_0_1.PROPERTY_IDS) do
		var_19_0 = var_19_0 + 1

		if arg_19_0.propertyContent.childCount < var_19_0 then
			cloneTplTo = var_8

			local var_19_2

			if not var_8(arg_19_0.propertyTpl, arg_19_0.propertyContent) then
				local var_19_1 = arg_19_0.propertyContent

				var_19_2 = var_8.GetChild(var_19_1, var_19_0 - 1)
			end

			var_19_2.name = iter_19_1

			local var_19_3, var_19_4 = arg_19_0:GetRollAttrInfoById(iter_19_1, arg_19_1)

			setText = var_11

			var_11(var_19_2:Find("name"), var_19_3)

			setText = var_11

			var_11(var_19_2:Find("value/Text"), var_19_4)

			if arg_19_1 then
				var_0_1.personalRandomData[iter_19_1] = var_19_4
			end
		end
	end

	for iter_19_2 = 1, arg_19_0.propertyContent.childCount - 1 do
		if var_19_0 < iter_19_2 then
			setActive = iter_19_1

			local var_19_5 = arg_19_0.propertyContent

			iter_19_1(var_8.GetChild(var_19_5, iter_19_2 - 1), false)
		end
	end

	return
end

function var_0_1.UpdateAbility(arg_20_0, arg_20_1)
	local var_20_0 = {}

	if arg_20_1 then
		var_20_0 = arg_20_0:GetRandomAbilityIds()
	elseif var_0_1.personalRandomData then
		pairs = var_1_10003

		for iter_20_0, iter_20_1 in var_1_10003(var_0_1.personalRandomData) do
			table = var_1_10008

			if var_1_10008.contains(var_0_1.ABILITY_IDS, iter_20_0) then
				table = var_1_10008

				var_1_10008.insert(var_20_0, iter_20_0)
			end
		end
	else
		pairs = var_1_10003

		for iter_20_2, iter_20_3 in var_1_10003(arg_20_0.showCfg) do
			table = var_1_10008

			if var_1_10008.contains(var_0_1.ABILITY_IDS, iter_20_2) then
				table = var_1_10008

				var_1_10008.insert(var_20_0, iter_20_2)
			end
		end
	end

	table = var_1_10003

	var_1_10003.sort(var_20_0)

	ipairs = var_3

	for iter_20_4, iter_20_5 in var_3(var_20_0) do
		if arg_20_0.abilityContent.childCount < iter_20_4 then
			cloneTplTo = var_8

			local var_20_2

			if not var_8(arg_20_0.abilityTpl, arg_20_0.abilityContent) then
				local var_20_1 = arg_20_0.abilityContent

				var_20_2 = var_8.GetChild(var_20_1, iter_20_4 - 1)
			end

			var_20_2.name = iter_20_4

			local var_20_3, var_20_4 = arg_20_0:GetRollAttrInfoById(iter_20_5, arg_20_1)

			setScrollText = var_11

			var_11(var_20_2:Find("name_mask/name"), var_20_3)

			setText = var_11

			var_11(var_20_2:Find("value/Text"), var_20_4)

			if arg_20_1 then
				var_0_1.personalRandomData[iter_20_5] = var_20_4
			end
		end
	end

	for iter_20_6 = 1, arg_20_0.abilityContent.childCount do
		if #var_20_0 < iter_20_6 then
			setActive = var_7

			local var_20_5 = arg_20_0.abilityContent

			var_7(var_8.GetChild(var_20_5, iter_20_6 - 1), false)
		end
	end

	return
end

function var_0_1.GetRollAttrInfoById(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = ""

	if arg_21_2 then
		local var_21_1 = var_0_1.config[arg_21_1].random_value

		table = var_1_10005

		if var_1_10005.contains(var_0_1.PROPERTY_IDS, arg_21_1) or arg_21_1 == var_0_1.LV_ID then
			math = var_1_10005
			var_21_0 = var_1_10005.random(var_21_1[1], var_21_1[2])
		else
			math = var_1_10005
			var_21_0 = var_21_1[var_1_10005.random(#var_21_1)]
		end
	else
		var_21_0 = arg_21_0.showCfg[arg_21_1] or var_0_1.config[arg_21_1].default_value

		if var_0_1.personalRandomData then
			var_21_0 = var_0_1.personalRandomData[arg_21_1]
		end
	end

	local var_21_2 = var_0_1.config[arg_21_1].name

	tostring = var_1_10005

	local var_21_3 = var_1_10005(var_21_0)
end

function var_0_1.GetRandomAbilityIds(arg_22_0)
	local var_22_0 = {}

	for iter_22_0 = 1, #var_0_1.ABILITY_IDS do
		table = var_1_10006

		var_1_10006.insert(var_22_0, iter_22_0)
	end

	shuffle = var_2

	var_2(var_22_0)

	local var_22_1 = {}

	for iter_22_1 = 1, var_0_1.RANDOM_ABILITY_CNT do
		table = var_1_10007

		var_1_10007.insert(var_22_1, var_0_1.ABILITY_IDS[var_22_0[iter_22_1]])
	end

	return var_22_1
end

var_0_1.UPGRADE_TAG_SHOW_TIME = 2
var_0_1.LV_ANIM_TIME = 0.5
var_0_1.PROPERTY_TPL_ANIM_TIME = 0.5
var_0_1.ABILITY_TPL_ANIM_TIME = 0.5
var_0_1.RANDOM_CHANGE_TIME = 0.8

function var_0_1.PlayUpgradeAnims(arg_23_0)
	seriesAsync = var_1_10001

	var_1_10001({
		function(arg_24_0)
			local var_24_0 = arg_23_0

			var_1.PlayLevelAnim(var_24_0, arg_24_0)

			return
		end,
		function(arg_25_0)
			local var_25_0 = arg_23_0

			var_1.PlayPropertyAnim(var_25_0, arg_25_0)

			return
		end,
		function(arg_26_0)
			local var_26_0 = arg_23_0

			var_1.PlayAbilityAnim(var_26_0, arg_26_0)

			return
		end
	}, function()
		arg_23_0.upgradeFlag = nil

		return
	end)

	return
end

function var_0_1.PlayLevelAnim(arg_28_0, arg_28_1)
	local var_28_0, var_28_1, var_28_2 = arg_28_0:GetStaticInfo(var_0_1.LV_ID)

	setActive = var_1_10005

	var_1_10005(arg_28_0.lvUpgradeTF, var_28_2)

	if var_28_2 then
		local var_28_3 = arg_28_0
		local var_28_4 = arg_28_0.managedTween

		LeanTween = var_7

		var_28_4(var_28_3, var_7.delayedCall, function()
			setActive = var_2_10000

			var_2_10000(arg_28_0.lvUpgradeTF, false)

			return
		end, var_0_1.UPGRADE_TAG_SHOW_TIME, nil)

		local var_28_5 = arg_28_0
		local var_28_6 = arg_28_0.managedTween

		LeanTween = var_7

		local var_28_7 = var_7.value
		local var_28_8

		go = var_9

		local var_28_9 = var_28_6(var_28_5, var_28_7, var_28_8, var_9(arg_28_0.lvValue), var_28_0, var_28_1, var_0_1.LV_ANIM_TIME)
		local var_28_10 = var_5.setOnUpdate

		System = var_28_7

		local var_28_11 = var_28_10(var_28_9, var_28_7.Action_float(function(arg_30_0)
			setText = var_2_10001

			local var_30_0 = arg_28_0.lvValue

			math = var_2_10003

			var_2_10001(var_30_0, var_2_10003.floor(arg_30_0))

			return
		end))
		local var_28_12 = var_5.setOnComplete

		System = var_7

		var_28_12(var_28_11, var_7.Action(function()
			arg_28_1()

			return
		end))

		local var_28_13 = var_0_1.config[var_0_1.LV_ID].random_value[2]
		local var_28_14 = arg_28_0
		local var_28_15 = arg_28_0.managedTween

		LeanTween = var_8

		local var_28_16 = var_8.value
		local var_28_17

		go = var_10

		local var_28_18 = var_28_15(var_28_14, var_28_16, var_28_17, var_10(arg_28_0.lvSlider), var_28_0 / var_28_13, var_28_1 / var_28_13, var_0_1.LV_ANIM_TIME)
		local var_28_19 = var_6.setOnUpdate

		System = var_28_16

		var_28_19(var_28_18, var_28_16.Action_float(function(arg_32_0)
			arg_28_0.lvSliderImage.fillAmount = arg_32_0

			return
		end))
	else
		arg_28_1()
	end

	return
end

function var_0_1.PlayAbilityAnim(arg_33_0, arg_33_1)
	local var_33_0, var_33_1, var_33_2 = arg_33_0:GetDynamicInfo()

	if var_33_2 then
		local var_33_3 = {}

		for iter_33_0 = 1, #var_33_1 do
			local var_33_4 = iter_33_0 > #var_33_0
			local var_33_5 = var_33_1[iter_33_0]

			if var_33_4 then
				cloneTplTo = var_1_10012

				if not var_1_10012(arg_33_0.abilityTpl, arg_33_0.abilityContent) then
					var_1_10013 = arg_33_0.abilityContent
					var_1_10012 = var_1_10012.GetChild(var_1_10013, iter_33_0 - 1)
				end

				GetOrAddComponent = var_1_10013

				local var_33_6 = var_1_10012

				typeof = var_1_10015
				CanvasGroup = var_1_10016
				var_1_10013 = var_1_10013(var_33_6, var_1_10015(var_1_10016))
				var_1_10013.alpha = var_33_4 and 0 or 1

				if var_33_0[iter_33_0] ~= var_33_5 then
					if not var_33_4 then
						table = var_1_10013

						var_1_10013.insert(var_33_3, function(arg_34_0)
							local var_34_0 = arg_33_0
							local var_34_1 = var_1.managedTween

							LeanTween = var_2_10003

							local var_34_2 = var_2_10003.value
							local var_34_3

							go = var_2_10005

							local var_34_4 = var_34_1(var_34_0, var_34_2, var_34_3, var_2_10005(var_1_10012), 1, 0, var_0_1.ABILITY_TPL_ANIM_TIME)
							local var_34_5 = var_1.setEase

							LeanTweenType = var_34_2

							local var_34_6 = var_34_5(var_34_4, var_34_2.easeInBack)
							local var_34_7 = var_1.setOnUpdate

							System = var_3

							local var_34_8 = var_34_7(var_34_6, var_3.Action_float(function(arg_35_0)
								GetOrAddComponent = var_3_10001

								local var_35_0 = var_1_10012

								typeof = var_3_10003
								CanvasGroup = var_3_10004
								var_3_10001(var_35_0, var_3_10003(var_3_10004)).alpha = arg_35_0

								return
							end))
							local var_34_9 = var_1.setOnComplete

							System = var_3

							var_34_9(var_34_8, var_3.Action(function()
								setText = var_3_10000

								local var_36_0 = var_1_10012

								var_3_10000(var_1.Find(var_36_0, "name"), var_0_1.config[var_33_5].name)

								setText = var_3_10000

								local var_36_1 = var_1_10012

								var_3_10000(var_1.Find(var_36_1, "value/Text"), arg_33_0.upgradeCfg[var_33_5])
								arg_34_0()

								return
							end))

							return
						end)
					end

					table = var_1_10013

					var_1_10013.insert(var_33_3, function(arg_37_0)
						if var_33_4 then
							setText = var_1
							var_2_10003 = var_1_10012

							var_1(var_2.Find(var_2_10003, "name"), var_0_1.config[var_33_5].name)

							setText = var_1
							var_2_10003 = var_1_10012

							var_1(var_2.Find(var_2_10003, "value/Text"), arg_33_0.upgradeCfg[var_33_5])
						end

						local var_37_0 = arg_33_0
						local var_37_1 = var_1.managedTween

						LeanTween = var_2_10003

						local var_37_2 = var_2_10003.value
						local var_37_3

						go = var_2_10005

						local var_37_4 = var_37_1(var_37_0, var_37_2, var_37_3, var_2_10005(var_1_10012), 0, 1, var_0_1.ABILITY_TPL_ANIM_TIME)
						local var_37_5 = var_1.setEase

						LeanTweenType = var_37_2

						local var_37_6 = var_37_5(var_37_4, var_37_2.easeOutBack)
						local var_37_7 = var_1.setOnUpdate

						System = var_3

						local var_37_8 = var_37_7(var_37_6, var_3.Action_float(function(arg_38_0)
							GetOrAddComponent = var_3_10001

							local var_38_0 = var_1_10012

							typeof = var_3_10003
							CanvasGroup = var_3_10004
							var_3_10001(var_38_0, var_3_10003(var_3_10004)).alpha = arg_38_0

							return
						end))
						local var_37_9 = var_1.setOnComplete

						System = var_3

						var_37_9(var_37_8, var_3.Action(function()
							arg_37_0()

							return
						end))

						return
					end)
				end
			end
		end

		seriesAsync = var_6

		var_6(var_33_3, function()
			arg_33_1()

			return
		end)
	else
		arg_33_1()
	end

	return
end

function var_0_1.Show(arg_41_0)
	var_0_1.super.Show(arg_41_0)

	arg_41_0.isActive = true
	pg = var_1

	local var_41_0 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_41_0, arg_41_0._tf)

	return
end

function var_0_1.Hide(arg_42_0)
	var_0_1.super.Hide(arg_42_0)

	arg_42_0.isActive = false
	pg = var_1

	local var_42_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_42_0, arg_42_0._tf)

	return
end

function var_0_1.IsActive(arg_43_0)
	return arg_43_0.isActive
end

function var_0_1.OnDestroy(arg_44_0)
	arg_44_0:cleanManagedTween()

	return
end

return var_0_1
