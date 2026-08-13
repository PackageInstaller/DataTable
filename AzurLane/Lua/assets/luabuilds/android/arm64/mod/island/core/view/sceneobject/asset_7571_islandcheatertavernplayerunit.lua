class = var_0_10000

local var_0_0 = "IslandCheaterTavernPlayerUnit"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandSceneUnit"))
local var_0_2 = {
	Question = 1
}

function var_0_1.OnAttach(arg_1_0, arg_1_1)
	var_0_1.super.OnAttach(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_0._go
	local var_1_1 = var_2.GetComponent

	typeof = var_5
	CharacterHandleController = var_1_10007
	arg_1_0.characterHandleController = var_1_1(var_1_0, var_5(var_1_10007))

	local var_1_2 = arg_1_0.characterHandleController

	var_2.AddStateEnterFunc(var_1_2, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0

		var_2.StateEnterHandle(var_2_0, arg_2_0, arg_2_1)

		return
	end)

	local var_1_3 = arg_1_0.characterHandleController

	var_2.AddStateExitFunc(var_1_3, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0

		var_2.StateExitHandle(var_3_0, arg_3_0, arg_3_1)

		return
	end)

	local var_1_4 = arg_1_0.characterHandleController

	var_2.AddStateUpdateFunc(var_1_4, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0

		var_2.StateUpdateHandle(var_4_0, arg_4_0, arg_4_1)

		return
	end)

	arg_1_0.objTfList = {}
	arg_1_0._tf = arg_1_0._go.transform

	local var_1_5 = arg_1_0._tf
	local var_1_6 = var_2.GetChild(var_1_5, 0)
	local var_1_7 = var_2.GetComponent

	typeof = var_5
	Animator = var_1_10007
	arg_1_0.animator = var_1_7(var_1_6, var_5(var_1_10007))
	IslandShipDressHelperMiniGameNew = var_2
	arg_1_0.shipDressHelper = var_2.New()
	getProxy = var_2
	IslandProxy = var_1_6

	local var_1_8 = var_2(var_1_6)
	local var_1_9 = var_2.GetIsland(var_1_8)
	local var_1_10 = var_2.GetCheaterTavernAgency(var_1_9)
	local var_1_11 = var_2.GetPlayerData(var_1_10, arg_1_0.id)

	PlayRoomTools = var_1_9

	local var_1_12 = var_1_9.GetGameViewID(var_1_11.player_info.user_view)
	local var_1_13 = arg_1_0.shipDressHelper

	var_5.SetShipId(var_1_13, 0, var_1_12.dress_list)

	local var_1_14 = arg_1_0.id

	getProxy = var_6
	PlayerProxy = var_8

	local var_1_15 = var_6(var_8)
	local var_1_16

	if var_1_14 == var_6.getRawData(var_1_15).id then
		pg = var_1_16
		var_1_16 = var_1_16.ViewUtils.SetLayer

		local var_1_17 = arg_1_0._tf

		Layer = var_9

		var_1_16(var_1_17, var_9.UIHidden)
	else
		pg = var_1_16

		local var_1_18 = var_1_16.ViewUtils.SetLayer
		local var_1_19 = arg_1_0._tf

		Layer = var_9

		var_1_18(var_1_19, var_9.Default)
	end

	local var_1_20 = arg_1_0.shipDressHelper

	var_6.OnRoleLoaded(var_1_20, arg_1_0._tf, nil, function(arg_5_0)
		if var_0 then
			pg = var_1

			local var_5_0 = var_1.ViewUtils.SetLayer
			local var_5_1 = arg_5_0.transform

			Layer = var_2_10004

			var_5_0(var_5_1, var_2_10004.UIHidden)
		end

		return
	end)

	Timer = var_6
	arg_1_0.playInAnimationTimer = var_6.New(function()
		math = var_2_10000

		local var_6_0 = (var_2_10000.random() - 0.5) * 0.5

		for iter_6_0 = 1, arg_1_0.animator.layerCount do
			local var_6_1 = arg_1_0.animator

			var_5.Play(var_6_1, "sit_idle", iter_6_0 - 1, var_6_0)
		end

		return
	end, 2, 1)

	local var_1_21 = arg_1_0.playInAnimationTimer

	var_6.Start(var_1_21)

	return
end

function var_0_1.StateEnterHandle(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == var_0_2.Question then
		arg_7_0.effectLoaded = false
		arg_7_0.effectUnloaded = false
		IslandCheaterTavernConst = var_3

		local var_7_0 = var_3.quesAnimionshowEffectFrame

		IslandCheaterTavernConst = var_1_10004
		arg_7_0.showEffectTime = var_7_0 / var_1_10004.quesAnimionTotalFrame
		IslandCheaterTavernConst = var_3

		local var_7_1 = var_3.quesAnimionUnshowEffectFrame

		IslandCheaterTavernConst = var_4
		arg_7_0.unShowEffectTime = var_7_1 / var_4.quesAnimionTotalFrame
	end

	return
end

function var_0_1.StateUpdateHandle(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == var_0_2.Question then
		local var_8_0 = arg_8_0.animator
		local var_8_1 = var_3.GetCurrentAnimatorStateInfo(var_8_0, 0).normalizedTime % 1

		if not arg_8_0.effectLoaded and var_8_1 >= arg_8_0.showEffectTime then
			arg_8_0.effectLoaded = true

			arg_8_0:LoadEffect(arg_8_2)
		end

		if not arg_8_0.effectUnloaded and var_8_1 >= arg_8_0.unShowEffectTime then
			arg_8_0.effectUnloaded = true

			arg_8_0:UnLoadEffect(arg_8_2)
		end
	end

	return
end

function var_0_1.StateExitHandle(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == var_0_2.Question then
		arg_9_0.effectUnloaded = true

		arg_9_0:UnLoadEffect(arg_9_2)
	end

	return
end

function var_0_1.LoadEffect(arg_10_0, arg_10_1)
	if arg_10_0.objTfList[arg_10_1] then
		setActive = var_1_10003

		var_1_10003(var_2, true)

		setParent = var_1_10003

		var_1_10003(var_2, arg_10_0._tf)

		return
	end

	pg = var_1_10003

	local var_10_0 = var_1_10003.island_unit_item[arg_10_1].model

	LoadAny = var_1_10005

	local var_10_1 = var_1_10005(var_10_0, nil)

	Object = var_1_10006

	local var_10_2 = var_1_10006.Instantiate(var_10_1)
	local var_10_3 = arg_10_0.objTfList

	var_10_3[arg_10_1] = var_10_2.transform
	setParent = var_10_3

	var_10_3(arg_10_0.objTfList[arg_10_1], arg_10_0._tf)

	return
end

function var_0_1.UnLoadEffect(arg_11_0, arg_11_1)
	if arg_11_0.objTfList[arg_11_1] then
		setActive = var_2

		var_2(arg_11_0.objTfList[arg_11_1], false)
	end

	return
end

function var_0_1.DestroyInteractiveTools(arg_12_0)
	pairs = var_1_10001

	for iter_12_0, iter_12_1 in var_1_10001(arg_12_0.objTfList) do
		Object = var_1_10006

		var_1_10006.Destroy(iter_12_1.gameObject)
	end

	arg_12_0.objTfList = {}

	return
end

function var_0_1.OnPlayerQuestion(arg_13_0, arg_13_1)
	if arg_13_1 then
		pg = var_1_10002

		local var_13_0 = var_1_10002.ViewUtils.SetLayer
		local var_13_1 = arg_13_0._tf

		Layer = var_1_10005

		var_13_0(var_13_1, var_1_10005.Default)

		if arg_13_0.questTimer then
			local var_13_2 = arg_13_0.questTimer

			var_2.Stop(var_13_2)
		end

		Timer = var_2

		local var_13_3 = var_2.New

		local function var_13_4()
			pg = var_2_10000

			local var_14_0 = var_2_10000.ViewUtils.SetLayer
			local var_14_1 = arg_13_0._tf

			Layer = var_2_10003

			var_14_0(var_14_1, var_2_10003.UIHidden)

			return
		end

		IslandCheaterTavernConst = var_5
		arg_13_0.questTimer = var_13_3(var_13_4, var_5.qusanimationTime, 1)

		local var_13_5 = arg_13_0.questTimer

		var_2.Start(var_13_5)
	end

	for iter_13_0 = 1, arg_13_0.animator.layerCount do
		local var_13_6 = arg_13_0.animator

		var_6.CrossFadeInFixedTime(var_13_6, "question", 0, iter_13_0 - 1)
	end

	return
end

function var_0_1.OnPlayWinAnimation(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 then
		pg = var_1_10003

		local var_15_0 = var_1_10003.ViewUtils.SetLayer
		local var_15_1 = arg_15_0._tf

		Layer = var_1_10006

		var_15_0(var_15_1, var_1_10006.Default)

		local var_15_2 = "winseat0" .. arg_15_2

		CheatTavernCameraMgr = var_4

		local var_15_3 = var_4.instance

		var_4.ActiveVirtualCamera(var_15_3, var_15_2)

		if arg_15_0.winTimer then
			local var_15_4 = arg_15_0.winTimer

			var_4.Stop(var_15_4)
		end

		Timer = var_4

		local var_15_5 = var_4.New

		local function var_15_6()
			pg = var_2_10000

			local var_16_0 = var_2_10000.ViewUtils.SetLayer
			local var_16_1 = arg_15_0._tf

			Layer = var_2_10003

			var_16_0(var_16_1, var_2_10003.UIHidden)

			local var_16_2 = "lookSeet0" .. arg_15_2

			CheatTavernCameraMgr = var_1

			local var_16_3 = var_1.instance

			var_1.ActiveVirtualCamera(var_16_3, var_16_2)

			return
		end

		IslandCheaterTavernConst = var_7
		arg_15_0.winTimer = var_15_5(var_15_6, var_7.winAnimationTime, 1)

		local var_15_7 = arg_15_0.winTimer

		var_4.Start(var_15_7)
	end

	for iter_15_0 = 1, arg_15_0.animator.layerCount do
		local var_15_8 = arg_15_0.animator

		var_7.CrossFadeInFixedTime(var_15_8, "win01", 0, iter_15_0 - 1)
	end

	return
end

function var_0_1.OnPlayerOut(arg_17_0, arg_17_1, arg_17_2)
	getProxy = var_1_10003
	PlayerProxy = var_1_10005

	local var_17_0 = var_1_10003(var_1_10005)

	if arg_17_1 == var_3.getRawData(var_17_0).id then
		local var_17_1 = "failoutSeet0" .. arg_17_2

		pg = var_4

		local var_17_2 = var_4.ViewUtils.SetLayer
		local var_17_3 = arg_17_0._tf

		Layer = var_1_10007

		var_17_2(var_17_3, var_1_10007.Default)

		CheatTavernCameraMgr = var_17_2

		local var_17_4 = var_17_2.instance

		var_4.ActiveVirtualCamera(var_17_4, var_17_1)

		if arg_17_0.outTimer then
			local var_17_5 = arg_17_0.outTimer

			var_4.Stop(var_17_5)
		end

		Timer = var_4
		arg_17_0.outTimer = var_4.New(function()
			local var_18_0 = "lookSeet0" .. arg_17_2

			CheatTavernCameraMgr = var_1

			local var_18_1 = var_1.instance

			var_1.ActiveVirtualCamera(var_18_1, var_18_0)

			return
		end, 3, 1)

		local var_17_6 = arg_17_0.outTimer

		var_4.Start(var_17_6)
	end

	for iter_17_0 = 1, arg_17_0.animator.layerCount do
		local var_17_7 = arg_17_0.animator

		var_7.CrossFadeInFixedTime(var_17_7, "fallout", 0, iter_17_0 - 1)
	end

	return
end

function var_0_1.OnDetach(arg_19_0)
	local var_19_0 = arg_19_0.shipDressHelper

	var_1.Destroy(var_19_0)

	if arg_19_0.outTimer then
		local var_19_1 = arg_19_0.outTimer

		var_1.Stop(var_19_1)
	end

	if arg_19_0.questTimer then
		local var_19_2 = arg_19_0.questTimer

		var_1.Stop(var_19_2)
	end

	if arg_19_0.playInAnimationTimer then
		local var_19_3 = arg_19_0.playInAnimationTimer

		var_1.Stop(var_19_3)
	end

	if arg_19_0.winTimer then
		local var_19_4 = arg_19_0.winTimer

		var_1.Stop(var_19_4)
	end

	arg_19_0:DestroyInteractiveTools()

	return
end

return var_0_1
