local var_0_0 = class("BossRushPassedCombatLoadLayer", import(".BossRushPassedLayer"))

var_0_0.GROW_TIME = 0.55

function var_0_0.getUIName(arg_1_0)
	return "BossRushPassedUI"
end

function var_0_0.didEnter(arg_2_0)
	arg_2_0.tweenObjs = {}

	pg.UIMgr.GetInstance():OverlayPanel(arg_2_0._tf)
	arg_2_0:updateSlider(arg_2_0.curIndex)
	arg_2_0:initSliderArea(arg_2_0.curIndex)

	arg_2_0._tf:GetComponent("Animator").enabled = false

	arg_2_0:combatPreload()

	return
end

function var_0_0.willExit(arg_3_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_3_0._tf)

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.tweenObjs) do
		LeanTween.cancel(iter_3_1)
	end

	arg_3_0.tweenObjs = {}

	return
end

function var_0_0.onBackPressed(arg_4_0)
	return
end

function var_0_0.initData(arg_5_0)
	arg_5_0.curIndex = arg_5_0.contextData.curIndex

	return
end

function var_0_0.combatPreload(arg_6_0)
	PoolMgr.GetInstance():DestroyAllSprite()

	arg_6_0._loadObs = {}

	ys.Battle.BattleFXPool.GetInstance():Init()

	local var_6_0 = ys.Battle.BattleResourceManager.GetInstance()

	var_6_0:Init()

	local var_6_1, var_6_2 = CombatLoadUI.GetTotalResourceList(arg_6_0.contextData)

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		var_6_0:AddPreloadResource(iter_6_1)
	end

	for iter_6_2, iter_6_3 in ipairs(var_6_2) do
		var_6_0:AddPreloadCV(iter_6_3)
	end

	local var_6_3 = 0

	setActive(pg.UIMgr.GetInstance():GetMainCamera(), true)

	var_6_3 = var_6_0:StartPreload(function()
		arg_6_0:updateSlider(arg_6_0.curIndex + 1)
		arg_6_0:emit(ChallengePassedCombatLoadMediator.FINISH, arg_6_0._loadObs)

		return
	end, function(arg_8_0)
		arg_6_0:moveSlider(var_6_3 == 0 and 0 or arg_8_0 / var_6_3)

		return
	end)

	return
end

function var_0_0.initSliderArea(arg_9_0)
	local var_9_0 = arg_9_0.curIndex

	if arg_9_0.contextData.maxIndex < arg_9_0.curIndex then
		var_9_0 = var_9_0 % arg_9_0.contextData.maxIndex == 0 and arg_9_0.contextData.maxIndex or var_9_0 % arg_9_0.contextData.maxIndex
	end

	local var_9_1 = 1 / (arg_9_0.contextData.maxIndex - 1)

	arg_9_0.curpercent = (var_9_0 - 1) * (1 / (arg_9_0.contextData.maxIndex - 1))
	arg_9_0.nextprecent = var_9_0 * var_9_1
	arg_9_0.deltaPercent = arg_9_0.nextprecent - arg_9_0.curpercent

	return
end

function var_0_0.moveSlider(arg_10_0, arg_10_1)
	arg_10_0.sliderSC.value = arg_10_0.curpercent + arg_10_0.deltaPercent * arg_10_1

	return
end

return var_0_0
