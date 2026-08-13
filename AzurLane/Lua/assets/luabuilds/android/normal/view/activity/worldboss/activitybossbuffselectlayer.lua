class = var_0_10000

local var_0_0 = "ActivityBossBuffSelectLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "ActivityBossBuffSelectUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.buffList = var_1.Find(var_2_0, "BuffList")

	local var_2_1 = arg_2_0.buffList
	local var_2_2 = var_1.Find(var_2_1, "ScrollView")

	arg_2_0.buffScrollComp = var_1.GetComponent(var_2_2, "LScrollRect")

	local var_2_3 = arg_2_0._tf

	arg_2_0.activeBuffRect = var_1.Find(var_2_3, "Active")

	local var_2_4 = arg_2_0.activeBuffRect
	local var_2_5 = var_1.Find(var_2_4, "ScrollView")

	arg_2_0.activeBuffScrollComp = var_1.GetComponent(var_2_5, "LScrollRect")

	local var_2_6 = arg_2_0._tf

	arg_2_0.startBtn = var_1.Find(var_2_6, "Start")

	local var_2_7 = arg_2_0._tf

	arg_2_0.top = var_1.Find(var_2_7, "top")
	setText = var_1

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_2.Find(var_2_8, "BuffList/Title/Text")

	i18n = var_2_8

	var_1(var_2_9, var_2_8("activityboss_sp_all_buff"))

	setText = var_1

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_2.Find(var_2_10, "Rewards/Desc")

	i18n = var_2_10

	var_1(var_2_11, var_2_10("activityboss_sp_best_score"))

	setText = var_1

	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_2.Find(var_2_12, "Rewards/Reward/Text")

	i18n = var_2_12

	var_1(var_2_13, var_2_12("activityboss_sp_display_reward"))

	setText = var_1

	local var_2_14 = arg_2_0._tf
	local var_2_15 = var_2.Find(var_2_14, "Active/Title/Text")

	i18n = var_2_14

	var_1(var_2_15, var_2_14("activityboss_sp_active_buff"))

	setText = var_1

	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_2.Find(var_2_16, "Active/PT/Title")

	i18n = var_2_16

	var_1(var_2_17, var_2_16("activityboss_sp_score_bonus"))

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0.buffDatas = {}
	_ = var_1

	local var_3_0 = var_1.map
	local var_3_1 = arg_3_0.contextData.spEnemyInfo

	arg_3_0.buffs = var_3_0(var_2.GetSelectableBuffs(var_3_1), function(arg_4_0)
		ActivityBossBuff = var_2_10001

		local var_4_0 = var_2_10001.New({
			configId = arg_4_0
		})

		arg_3_0.buffDatas[var_4_0] = {}

		return var_4_0
	end)
	getProxy = var_1
	ActivityProxy = var_2

	local var_3_2 = var_1(var_2)
	local var_3_3 = var_1.getActivityByType

	ActivityConst = var_3

	local var_3_4 = var_3_3(var_3_2, var_3.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2)

	_ = var_3_2

	var_3_2.each(var_3_4:GetHistoryBuffs(), function(arg_5_0)
		_ = var_2_10001

		local var_5_0 = var_2_10001.detect(arg_3_0.buffs, function(arg_6_0)
			return arg_6_0:GetConfigID() == arg_5_0
		end)

		arg_3_0.buffDatas[var_5_0].selected = true

		return
	end)

	local var_3_5 = arg_3_0.contextData.spEnemyInfo

	arg_3_0.rewards = var_2.GetRewards(var_3_5)

	local var_3_6 = arg_3_0.contextData.spEnemyInfo

	arg_3_0.targets = var_2.GetScoreTargets(var_3_6)
	arg_3_0.score = arg_3_0.contextData.score

	function arg_3_0.buffScrollComp.onUpdateItem(arg_7_0, arg_7_1)
		local var_7_0 = arg_3_0

		var_2.UpdateBuffItem(var_7_0, arg_7_0 + 1, arg_7_1)

		return
	end

	local var_3_7 = arg_3_0.activeBuffScrollComp

	function var_3_7.onUpdateItem(arg_8_0, arg_8_1)
		local var_8_0 = arg_3_0

		var_2.UpdateActiveBuffItem(var_8_0, arg_8_0 + 1, arg_8_1)

		return
	end

	onButton = var_3_7

	local var_3_8 = arg_3_0
	local var_3_9 = arg_3_0.top
	local var_3_10 = var_4.Find(var_3_9, "back_btn")

	local function var_3_11()
		local var_9_0 = arg_3_0

		var_0.closeView(var_9_0)

		return
	end

	SOUND_BACK = var_6

	var_3_7(var_3_8, var_3_10, var_3_11, var_6)

	onButton = var_3_7

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.top
	local var_3_14 = var_4.Find(var_3_13, "option")

	local function var_3_15()
		local var_10_0 = arg_3_0

		var_0.quickExitFunc(var_10_0)

		return
	end

	SFX_PANEL = var_6

	var_3_7(var_3_12, var_3_14, var_3_15, var_6)

	onButton = var_3_7

	local var_3_16 = arg_3_0
	local var_3_17 = arg_3_0._tf
	local var_3_18 = var_4.Find(var_3_17, "Rewards/Reward")

	local function var_3_19()
		local var_11_0 = arg_3_0
		local var_11_1 = var_0.emit

		ActivityBossBuffSelectMediator = var_2_10002

		local var_11_2 = var_2_10002.SHOW_REWARDS
		local var_11_3 = arg_3_0.rewards
		local var_11_4 = arg_3_0.targets
		local var_11_5 = var_3_4

		var_11_1(var_11_0, var_11_2, var_11_3, var_11_4, var_5.GetHighestScore(var_11_5))

		return
	end

	SFX_PANEL = var_6

	var_3_7(var_3_16, var_3_18, var_3_19, var_6)

	onButton = var_3_7

	local var_3_20 = arg_3_0
	local var_3_21 = arg_3_0.startBtn

	local function var_3_22()
		local var_12_0 = arg_3_0
		local var_12_1 = var_0.emit

		ActivityBossBuffSelectMediator = var_2_10002

		var_12_1(var_12_0, var_2_10002.ON_START, arg_3_0.activeBuffs)

		return
	end

	SFX_PANEL = var_6

	var_3_7(var_3_20, var_3_21, var_3_22, var_6)

	pg = var_3_7

	local var_3_23 = var_3_7.UIMgr.GetInstance()

	var_2.BlurPanel(var_3_23, arg_3_0._tf)

	setText = var_2

	local var_3_24 = arg_3_0._tf

	var_2(var_3.Find(var_3_24, "Rewards/Score"), var_3_4:GetHighestScore())
	arg_3_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_13_0)
	local var_13_0 = arg_13_0.buffScrollComp

	var_1.SetTotalCount(var_13_0, #arg_13_0.buffs)
	arg_13_0:UpdateActiveBuffs()

	return
end

function var_0_1.UpdateBuffItem(arg_14_0, arg_14_1, arg_14_2)
	tf = var_1_10003

	local var_14_0 = var_1_10003(arg_14_2)
	local var_14_1 = arg_14_0.buffs[arg_14_1]
	local var_14_2 = arg_14_0.buffDatas[var_14_1]

	setActive = var_1_10006

	var_1_10006(var_14_0:Find("Selected"), var_14_2.selected)

	setText = var_1_10006

	var_1_10006(var_14_0:Find("Name/Text"), var_14_1:GetDesc())

	setText = var_1_10006

	var_1_10006(var_14_0:Find("PT/Text"), "+" .. var_14_1:GetBonusText())

	GetImageSpriteFromAtlasAsync = var_1_10006

	local var_14_3 = var_14_1:GetIconPath()
	local var_14_4 = ""
	local var_14_5 = var_14_0

	var_1_10006(var_14_3, var_14_4, var_14_0.Find(var_14_5, "Item/Icon"))

	onButton = var_1_10006

	local var_14_6 = arg_14_0
	local var_14_7 = var_14_0

	local function var_14_8()
		var_14_2.selected = not var_14_2.selected

		local var_15_0 = arg_14_0

		var_0.UpdateView(var_15_0)

		return
	end

	SFX_PANEL = var_14_5

	var_1_10006(var_14_6, var_14_7, var_14_8, var_14_5)

	return
end

function var_0_1.UpdateActiveBuffs(arg_16_0)
	_ = var_1_10001
	arg_16_0.activeBuffs = var_1_10001.select(arg_16_0.buffs, function(arg_17_0)
		return arg_16_0.buffDatas[arg_17_0].selected
	end)
	math = var_1

	local var_16_0 = var_1.max

	math = var_2

	local var_16_1 = var_16_0(var_2.floor((#arg_16_0.activeBuffs - 1) / 5) + 1, 4) * 5
	local var_16_2 = arg_16_0.activeBuffScrollComp

	var_2.SetTotalCount(var_16_2, var_16_1)

	_ = var_2

	local var_16_3 = var_2.reduce(arg_16_0.activeBuffs, 0, function(arg_18_0, arg_18_1)
		return arg_18_0 + arg_18_1:GetBonus()
	end)

	Mathf = var_3

	local var_16_4 = var_3.Round(var_16_3 * 100)

	setText = var_3

	local var_16_5 = arg_16_0.activeBuffRect

	var_3(var_4.Find(var_16_5, "PT/Text"), "+" .. var_16_4 .. "%")

	return
end

function var_0_1.UpdateActiveBuffItem(arg_19_0, arg_19_1, arg_19_2)
	tf = var_1_10003

	local var_19_0 = var_1_10003(arg_19_2)
	local var_19_1 = arg_19_0.activeBuffs[arg_19_1]

	setActive = var_1_10005

	local var_19_2 = var_19_0
	local var_19_3 = var_19_0.Find(var_19_2, "Icon")

	tobool = var_19_2

	var_1_10005(var_19_3, var_19_2(var_19_1))

	if not var_19_1 then
		return
	end

	GetImageSpriteFromAtlasAsync = var_1_10005

	var_1_10005(var_19_1:GetIconPath(), "", var_19_0:Find("Icon"))

	return
end

function var_0_1.willExit(arg_20_0)
	pg = var_1_10001

	local var_20_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_20_0, arg_20_0._tf)

	return
end

return var_0_1
