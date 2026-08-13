class = var_0_10000

local var_0_0 = "BossRushPassedCombatLoadLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BossRushPassedLayer"))

var_0_1.GROW_TIME = 0.55

function var_0_1.getUIName(arg_1_0)
	return "BossRushPassedUI"
end

function var_0_1.didEnter(arg_2_0)
	arg_2_0.tweenObjs = {}
	pg = var_1

	local var_2_0 = var_1.UIMgr.GetInstance()

	var_1.OverlayPanel(var_2_0, arg_2_0._tf)
	arg_2_0:updateSlider(arg_2_0.curIndex)
	arg_2_0:initSliderArea(arg_2_0.curIndex)

	local var_2_1 = arg_2_0._tf

	var_1.GetComponent(var_2_1, "Animator").enabled = false

	arg_2_0:combatPreload()

	return
end

function var_0_1.willExit(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_3_0, arg_3_0._tf)

	ipairs = var_1

	for iter_3_0, iter_3_1 in var_1(arg_3_0.tweenObjs) do
		LeanTween = var_1_10006

		var_1_10006.cancel(iter_3_1)
	end

	arg_3_0.tweenObjs = {}

	return
end

function var_0_1.onBackPressed(arg_4_0)
	return
end

function var_0_1.initData(arg_5_0)
	arg_5_0.curIndex = arg_5_0.contextData.curIndex

	return
end

function var_0_1.combatPreload(arg_6_0)
	PoolMgr = var_1_10001

	local var_6_0 = var_1_10001.GetInstance()

	var_1.DestroyAllSprite(var_6_0)

	arg_6_0._loadObs = {}
	ys = var_1

	local var_6_1 = var_1.Battle.BattleFXPool.GetInstance()

	var_1.Init(var_6_1)

	ys = var_1

	local var_6_2 = var_1.Battle.BattleResourceManager.GetInstance()

	var_1.Init(var_6_2)

	CombatLoadUI = var_2

	local var_6_3, var_6_4 = var_2.GetTotalResourceList(arg_6_0.contextData)

	ipairs = var_4

	for iter_6_0, iter_6_1 in var_4(var_6_3) do
		var_1:AddPreloadResource(iter_6_1)
	end

	ipairs = var_4

	for iter_6_2, iter_6_3 in var_4(var_6_4) do
		var_1:AddPreloadCV(iter_6_3)
	end

	local function var_6_5()
		local var_7_0 = arg_6_0

		var_0.updateSlider(var_7_0, arg_6_0.curIndex + 1)

		local var_7_1 = arg_6_0
		local var_7_2 = var_0.emit

		ChallengePassedCombatLoadMediator = var_3

		var_7_2(var_7_1, var_3.FINISH, arg_6_0._loadObs)

		return
	end

	local var_6_6 = 0

	local function var_6_7(arg_8_0)
		local var_8_0
		local var_8_1 = var_6_6 == 0 and 0 or arg_8_0 / var_6_6
		local var_8_2 = arg_6_0

		var_2.moveSlider(var_8_2, var_8_1)

		return
	end

	pg = iter_6_2

	local var_6_8 = iter_6_2.UIMgr.GetInstance()
	local var_6_9 = var_7.GetMainCamera(var_6_8)

	setActive = iter_6_3

	iter_6_3(var_6_9, true)

	var_6_6 = var_1:StartPreload(var_6_5, var_6_7)

	return
end

function var_0_1.initSliderArea(arg_9_0)
	local var_9_0 = arg_9_0.curIndex

	if arg_9_0.contextData.maxIndex < var_9_0 then
		var_9_0 = var_9_0 % var_2 == 0 and var_2 or var_9_0 % var_2
	end

	local var_9_1 = 1 / (var_2 - 1)

	arg_9_0.curpercent = (var_9_0 - 1) * var_9_1
	arg_9_0.nextprecent = var_9_0 * var_9_1
	arg_9_0.deltaPercent = arg_9_0.nextprecent - arg_9_0.curpercent

	return
end

function var_0_1.moveSlider(arg_10_0, arg_10_1)
	arg_10_0.sliderSC.value = arg_10_0.curpercent + arg_10_0.deltaPercent * arg_10_1

	return
end

return var_0_1
