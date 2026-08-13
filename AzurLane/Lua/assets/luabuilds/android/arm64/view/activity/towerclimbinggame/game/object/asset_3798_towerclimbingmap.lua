class = var_0_10000

local var_0_0 = var_0_10000("TowerClimbingMap")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1.gameView
	arg_1_0.view = arg_1_1
	arg_1_0.map = arg_1_2

	return
end

function var_0_0.Init(arg_2_0, arg_2_1)
	arg_2_0.blocks = {}

	local var_2_0 = arg_2_0._tf

	arg_2_0.groundContainer = var_2.Find(var_2_0, "game")

	local var_2_1 = arg_2_0.groundContainer

	arg_2_0.blockPlayCon = var_2.Find(var_2_1, "block_play_con")
	setAnchoredPosition = var_2

	var_2(arg_2_0.blockPlayCon, {
		x = 0,
		y = 0
	})

	local var_2_2 = arg_2_0.blockPlayCon

	arg_2_0.blockContainer = var_2.Find(var_2_2, "blocks")

	local var_2_3 = {}
	local var_2_4 = arg_2_0._tf

	var_2_3[1] = var_3.Find(var_2_4, "prints/score/hearts/1")

	local var_2_5 = arg_2_0._tf

	var_2_3[2] = var_3.Find(var_2_5, "prints/score/hearts/2")

	local var_2_6 = arg_2_0._tf

	var_2_3[3] = var_3.Find(var_2_6, "prints/score/hearts/3")
	arg_2_0.hearts = var_2_3

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_2.Find(var_2_7, "prints/score/Text")
	local var_2_9 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_2_0.score = var_2_9(var_2_8, var_5(var_1_10007))

	local var_2_10 = arg_2_0._tf

	arg_2_0.heartProgress = var_2.Find(var_2_10, "prints/score/progress")

	local var_2_11 = arg_2_0._tf
	local var_2_12 = var_2.Find(var_2_11, "prints/score/progress/Text")
	local var_2_13 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_2_0.heartProgressTxt = var_2_13(var_2_12, var_5(var_1_10007))
	TowerClimbBgMgr = var_2

	local var_2_14 = var_2.New
	local var_2_15 = arg_2_0._tf

	arg_2_0.bg = var_2_14(var_4.Find(var_2_15, "bgs"))

	local var_2_16 = arg_2_0.bg

	var_2.Init(var_2_16, arg_2_0.map.id, arg_2_1)

	local var_2_17 = arg_2_0._tf

	arg_2_0.npc = var_2.Find(var_2_17, "prints/npc")

	arg_2_0:LoadEffect(arg_2_0.map.id)

	local var_2_18 = arg_2_0._tf

	arg_2_0.tip = var_2.Find(var_2_18, "prints/tip")
	setActive = var_2

	var_2(arg_2_0.tip, false)

	arg_2_0.timers = {}

	return
end

function var_0_0.LoadEffect(arg_3_0, arg_3_1)
	TowerClimbingGameSettings = var_1_10002

	if var_1_10002.MAPID2EFFECT[arg_3_1] then
		ipairs = var_1_10003

		for iter_3_0, iter_3_1 in var_1_10003(var_2) do
			local var_3_0 = iter_3_1[1]
			local var_3_1 = iter_3_1[2]

			arg_3_0:LoadSingleEffect(var_3_0, var_3_1)
		end
	end

	return
end

function var_0_0.LoadSingleEffect(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	PoolMgr = var_1_10004

	local var_4_0 = var_1_10004.GetInstance()

	var_4.GetUI(var_4_0, arg_4_1, true, function(arg_5_0)
		if not arg_4_0.groundContainer then
			PoolMgr = var_1

			local var_5_0 = var_1.GetInstance()

			var_1.ReturnUI(var_5_0, arg_4_1, arg_5_0)
		else
			arg_5_0.name = arg_4_1
			SetParent = var_1

			var_1(arg_5_0, arg_4_0.groundContainer)

			local var_5_1 = arg_5_0.transform

			Vector3 = var_2_10002
			var_5_1.anchoredPosition3D = var_2_10002(arg_4_2[1], arg_4_2[2], -200)
			setActive = var_5_1

			var_5_1(arg_5_0, true)

			if arg_4_3 then
				arg_4_3(arg_5_0)
			end
		end

		return
	end)

	return
end

function var_0_0.ReturnEffect(arg_6_0, arg_6_1)
	TowerClimbingGameSettings = var_1_10002

	if var_1_10002.MAPID2EFFECT[arg_6_1] then
		ipairs = var_1_10003

		for iter_6_0, iter_6_1 in var_1_10003(var_2) do
			local var_6_0 = iter_6_1[1]
			local var_6_1 = arg_6_0.groundContainer

			if var_9.Find(var_6_1, var_6_0) then
				PoolMgr = var_1_10010

				local var_6_2 = var_1_10010.GetInstance()

				var_1_10010.ReturnUI(var_6_2, var_6_0, var_9.gameObject)
			end
		end
	end

	return
end

function var_0_0.OnReachAwardScore(arg_7_0)
	LOCK_TOWERCLIMBING_AWARD = var_1_10001

	if var_1_10001 then
		return
	end

	if arg_7_0.tipTimer then
		local var_7_0 = arg_7_0.tipTimer

		var_1.Stop(var_7_0)

		arg_7_0.tipTimer = nil
	end

	setActive = var_1

	var_1(arg_7_0.tip, true)

	Timer = var_1
	arg_7_0.tipTimer = var_1.New(function()
		setActive = var_2_10000

		var_2_10000(arg_7_0.tip, false)

		local var_8_0 = arg_7_0.tipTimer

		var_0.Stop(var_8_0)

		arg_7_0.tipTimer = nil

		return
	end, 3, 1)

	local var_7_1 = arg_7_0.tipTimer

	var_1.Start(var_7_1)

	local var_7_2 = arg_7_0.groundContainer
	local var_7_3 = var_1.InverseTransformPoint(var_7_2, arg_7_0.npc.position)
	local var_7_4 = arg_7_0.groundContainer
	local var_7_5 = var_2.InverseTransformPoint(var_7_4, arg_7_0.player._tf.position)

	local function var_7_6()
		local function var_9_0()
			setActive = var_3_10000

			var_3_10000(arg_7_0.awardEffect1, true)

			local var_10_0 = arg_7_0

			Timer = var_3_10001
			var_10_0.awardTimer = var_3_10001.New(function()
				setActive = var_4_10000

				var_4_10000(arg_7_0.awardEffect1, false)

				return
			end, 2, 1)

			local var_10_1 = arg_7_0.awardTimer

			var_0.Start(var_10_1)

			return
		end

		if not arg_7_0.awardEffect1 then
			local var_9_1 = {
				var_7_3.x,
				var_7_3.y
			}
			local var_9_2 = arg_7_0
			local var_9_3 = var_2.LoadSingleEffect

			TowerClimbingGameSettings = var_2_10005

			var_9_3(var_9_2, var_2_10005.AWARDEFFECT1, var_9_1, function(arg_12_0)
				arg_7_0.awardEffect1 = arg_12_0

				var_9_0()

				return
			end)
		else
			var_9_0()
		end

		return
	end

	local function var_7_7()
		Vector3 = var_2_10000

		local var_13_0 = var_2_10000(var_7_3.x, var_7_5.y + 200, -200)
		local var_13_1 = {}

		table = var_2

		local var_13_2 = var_2.insert
		local var_13_3 = var_13_1

		Vector3 = var_2_10005

		var_13_2(var_13_3, var_2_10005(var_7_5.x, var_7_5.y, -200))

		table = var_13_2

		var_13_2.insert(var_13_1, var_13_0)

		table = var_2

		var_2.insert(var_13_1, var_13_0)

		table = var_2

		local var_13_4 = var_2.insert
		local var_13_5 = var_13_1

		Vector3 = var_5

		var_13_4(var_13_5, var_5(var_7_3.x, var_7_3.y, -200))

		local var_13_6 = arg_7_0.awardEffect.transform

		Vector3 = var_3
		var_13_6.localPosition = var_3(var_7_5.x, var_7_5.y, -200)
		setActive = var_13_6

		var_13_6(arg_7_0.awardEffect, true)

		LeanTween = var_13_6

		local var_13_7 = var_13_6.moveLocal(arg_7_0.awardEffect, var_13_1, 1)
		local var_13_8 = var_2.setOnComplete

		System = var_5

		var_13_8(var_13_7, var_5.Action(function()
			setActive = var_3_10000

			var_3_10000(arg_7_0.awardEffect, false)
			var_7_6()

			return
		end))

		return
	end

	if not arg_7_0.awardEffect then
		local var_7_8 = {
			var_7_5.x,
			var_7_5.y
		}
		local var_7_9 = arg_7_0
		local var_7_10 = arg_7_0.LoadSingleEffect

		TowerClimbingGameSettings = var_1_10009

		var_7_10(var_7_9, var_1_10009.AWARDEFFECT, var_7_8, function(arg_15_0)
			arg_7_0.awardEffect = arg_15_0

			var_7_7()

			return
		end)
	else
		var_7_7()
	end

	return
end

function var_0_0.GetFirstBlock(arg_16_0)
	return arg_16_0.blocks[1]
end

function var_0_0.GetHitBlock(arg_17_0, arg_17_1)
	_ = var_1_10002

	if var_1_10002.detect(arg_17_0.blocks, function(arg_18_0)
		return arg_18_0.go == arg_17_1
	end) then
		return var_2
	end

	return
end

function var_0_0.OnCreateGround(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0.ground = arg_19_1
	TowerClimbingResMgr = var_1_10003

	var_1_10003.GetGround(arg_19_1.name, function(arg_20_0)
		arg_19_0.groundGo = arg_20_0
		arg_20_0.name = "manjuu"
		SetParent = var_1

		var_1(arg_20_0.transform, arg_19_0.groundContainer)

		local var_20_0 = arg_20_0.transform

		var_20_0.anchoredPosition = arg_19_1.position
		setActive = var_20_0

		var_20_0(arg_20_0, true)

		local var_20_1 = arg_20_0:GetComponent("SpineAnimUI")

		var_1.SetAction(var_20_1, "normal", 0)

		setText = var_2

		local var_20_2 = arg_19_0.groundGo.transform

		var_2(var_4.Find(var_20_2, "Text"), "")
		arg_19_2()

		return
	end)

	return
end

function var_0_0.TranslateBlockPosition(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.blockContainer
	local var_21_1 = var_2.InverseTransformVector
	local var_21_2 = arg_21_0.groundContainer

	return var_21_1(var_21_0, var_5.TransformVector(var_21_2, arg_21_1))
end

function var_0_0.OnCreateBlock(arg_22_0, arg_22_1, arg_22_2)
	TowerClimbingResMgr = var_1_10003

	var_1_10003.GetBlock(arg_22_1.type, function(arg_23_0)
		SetParent = var_2_10001

		var_2_10001(arg_23_0, arg_22_0.blockContainer)

		local var_23_0 = arg_23_0.transform
		local var_23_1 = arg_22_0

		var_23_0.anchoredPosition = var_2.TranslateBlockPosition(var_23_1, arg_22_1.position)
		TowerClimbingGameSettings = var_23_0
		arg_23_0.name = var_23_0.BLOCK_NAME
		setActive = var_1

		var_1(arg_23_0, true)

		local var_23_2 = arg_23_0
		local var_23_3 = arg_23_0.GetComponentsInChildren

		typeof = var_4
		UnityEngine = var_2_10006

		local var_23_4 = var_23_3(var_23_2, var_4(var_2_10006.Collider2D))
		local var_23_5 = var_1.ToTable(var_23_4)

		table = var_2

		var_2.insert(arg_22_0.blocks, {
			go = arg_23_0,
			block = arg_22_1,
			colliders = var_23_5
		})

		local var_23_6 = arg_22_0

		var_2.OnActiveBlock(var_23_6, arg_22_1)

		TowerClimbingGameSettings = var_2

		local var_23_7 = var_2.FIRE_TIME[1]

		TowerClimbingGameSettings = var_23_4

		local var_23_8 = var_23_4.FIRE_TIME[2]

		math = var_23_6

		local var_23_9 = var_23_6.random(var_23_7, var_23_8)
		local var_23_10 = arg_23_0.transform

		if var_5.Find(var_23_10, "firer") then
			local var_23_11 = var_5
			local var_23_12 = var_5.GetComponent

			typeof = var_2_10009
			Animation = var_2_10011

			local var_23_13 = var_23_12(var_23_11, var_2_10009(var_2_10011))
			local var_23_14 = arg_22_0.timers
			local var_23_15 = arg_22_1.level

			Timer = var_9
			var_23_14[var_23_15] = var_9.New(function()
				local var_24_0 = var_23_13

				var_0.Play(var_24_0, "action")

				return
			end, var_23_9, -1)

			local var_23_16 = arg_22_0.timers[arg_22_1.level]

			var_7.Start(var_23_16)
		end

		arg_22_2()

		return
	end)

	return
end

function var_0_0.OnActiveBlock(arg_25_0, arg_25_1)
	_ = var_1_10002

	local var_25_0 = var_1_10002.detect(arg_25_0.blocks, function(arg_26_0)
		return arg_26_0.block.level == arg_25_1.level
	end)

	ipairs = var_1_10003

	for iter_25_0, iter_25_1 in var_1_10003(var_25_0.colliders) do
		iter_25_1.enabled = arg_25_1.isActive
	end

	return
end

function var_0_0.SinkHandler(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_0.blockPlayCon.anchoredPosition.y
	local var_27_1 = arg_27_0.blockPlayCon.anchoredPosition.y - arg_27_1

	LeanTween = var_1_10005

	local var_27_2 = var_1_10005.value(arg_27_0.blockPlayCon.gameObject, var_27_0, var_27_1, 0.2)
	local var_27_3 = var_5.setOnUpdate

	System = var_8

	local var_27_4 = var_27_3(var_27_2, var_8.Action_float(function(arg_28_0)
		setAnchoredPosition = var_2_10001

		var_2_10001(arg_27_0.blockPlayCon, {
			y = arg_28_0
		})

		return
	end))
	local var_27_5 = var_5.setEase

	LeanTweenType = var_8

	local var_27_6 = var_27_5(var_27_4, var_8.easeOutQuad)
	local var_27_7 = var_5.setOnComplete

	System = var_8

	var_27_7(var_27_6, var_8.Action(arg_27_2))

	return
end

function var_0_0.OnBlockDestory(arg_29_0, arg_29_1)
	local var_29_1

	if arg_29_0.timers[arg_29_1] then
		local var_29_0 = arg_29_0.timers[arg_29_1]

		var_29_1.Stop(var_29_0)

		var_29_1 = arg_29_0.timers
		var_29_1[arg_29_1] = nil
	end

	_ = var_29_1

	local var_29_2 = var_29_1.detect(arg_29_0.blocks, function(arg_30_0)
		return arg_30_0.block.level == arg_29_1
	end)

	TowerClimbingResMgr = var_1_10003

	var_1_10003.ReturnBlock(var_29_2.block.type, var_29_2.go)

	return
end

function var_0_0.OnSink(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0.bg

	var_3.DoMove(var_31_0, arg_31_1, arg_31_2)
	arg_31_2()

	return
end

function var_0_0.OnPlayerLifeUpdate(arg_32_0, arg_32_1)
	triggerToggle = var_1_10002

	var_1_10002(arg_32_0.hearts[3], arg_32_1 >= 3)

	triggerToggle = var_1_10002

	var_1_10002(arg_32_0.hearts[2], arg_32_1 >= 2)

	triggerToggle = var_1_10002

	var_1_10002(arg_32_0.hearts[1], arg_32_1 >= 1)

	local var_32_0 = arg_32_0.heartProgressTxt

	var_32_0.text = arg_32_1 .. "/" .. 3
	setFillAmount = var_32_0

	var_32_0(arg_32_0.heartProgress, arg_32_1 / 3)

	return
end

function var_0_0.OnScoreUpdate(arg_33_0, arg_33_1)
	arg_33_0.score.text = arg_33_1

	return
end

function var_0_0.OnCreatePlayer(arg_34_0, arg_34_1, arg_34_2)
	TowerClimbingPlayer = var_1_10003
	arg_34_0.player = var_1_10003.New(arg_34_0, arg_34_1)

	local var_34_0 = arg_34_0.player

	var_3.Init(var_34_0, arg_34_2)

	return
end

function var_0_0.OnEnableStab(arg_35_0, arg_35_1, arg_35_2)
	_ = var_1_10003

	local var_35_0 = var_1_10003.detect(arg_35_0.blocks, function(arg_36_0)
		return arg_36_0.block.level == arg_35_1.level
	end)

	assert = var_1_10004

	var_1_10004(var_35_0)

	local var_35_1 = var_35_0.go
	local var_35_2 = var_4.GetComponent

	typeof = var_1_10007
	UnityEngine = var_1_10009

	local var_35_3 = var_35_2(var_35_1, var_1_10007(var_1_10009.Collider2D))

	ipairs = var_5

	for iter_35_0, iter_35_1 in var_5(var_35_0.colliders) do
		if iter_35_1 ~= var_35_3 then
			iter_35_1.enabled = arg_35_2
		end
	end

	return
end

function var_0_0.OnEnableGround(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0.groundGo
	local var_37_1 = var_2.GetComponent

	typeof = var_1_10005
	UnityEngine = var_1_10007
	var_37_1(var_37_0, var_1_10005(var_1_10007.Collider2D)).enabled = arg_37_1

	return
end

function var_0_0.GetPlayer(arg_38_0)
	return arg_38_0.player
end

function var_0_0.SendEvent(arg_39_0, arg_39_1, ...)
	local var_39_0 = arg_39_0.view.controller[arg_39_1]
	local var_39_1 = var_2

	unpack = var_1_10006

	var_39_0(var_39_1, var_1_10006({
		...
	}))

	return
end

function var_0_0.OnGroundRuning(arg_40_0)
	local var_40_0 = arg_40_0.groundGo
	local var_40_1 = var_1.GetComponent(var_40_0, "SpineAnimUI")

	var_1.SetAction(var_40_1, "up", 0)

	return
end

function var_0_0.OnGroundPositionChange(arg_41_0, arg_41_1)
	setAnchoredPosition = var_1_10002

	var_1_10002(arg_41_0.groundGo.transform, arg_41_1)

	return
end

function var_0_0.OnGroundSleepTimeChange(arg_42_0, arg_42_1)
	math = var_1_10002

	local var_42_0 = var_1_10002.ceil(arg_42_1)

	if 0 < var_42_0 then
		setText = var_3

		local var_42_1 = arg_42_0.groundGo.transform

		var_3(var_5.Find(var_42_1, "Text"), var_42_0)
	else
		setText = var_3

		local var_42_2 = arg_42_0.groundGo.transform

		var_3(var_5.Find(var_42_2, "Text"), "")
	end

	return
end

function var_0_0.Dispose(arg_43_0)
	if arg_43_0.awardTimer then
		local var_43_0 = arg_43_0.awardTimer

		var_1.Stop(var_43_0)

		arg_43_0.awardTimer = nil
	end

	local var_43_1 = arg_43_0.bg

	var_1.Clear(var_43_1)
	arg_43_0:ReturnEffect(arg_43_0.map.id)

	if arg_43_0.awardEffect then
		PoolMgr = var_1

		local var_43_2 = var_1.GetInstance()

		var_1.ReturnUI(var_43_2, arg_43_0.awardEffect.name, arg_43_0.awardEffect)

		arg_43_0.awardEffect = nil
	end

	if arg_43_0.awardEffect1 then
		PoolMgr = var_1

		local var_43_3 = var_1.GetInstance()

		var_1.ReturnUI(var_43_3, arg_43_0.awardEffect1.name, arg_43_0.awardEffect1)

		arg_43_0.awardEffect1 = nil
	end

	if arg_43_0.tipTimer then
		local var_43_4 = arg_43_0.tipTimer

		var_1.Stop(var_43_4)
	end

	arg_43_0.tipTimer = nil
	pairs = var_1

	local var_43_5

	if not arg_43_0.timers then
		var_43_5 = {}
	end

	for iter_43_0, iter_43_1 in var_1(var_43_5) do
		iter_43_1:Stop()
	end

	arg_43_0.timers = nil

	if arg_43_0.player then
		local var_43_6 = arg_43_0.player

		var_1.Dispose(var_43_6)

		arg_43_0.player = nil
	end

	if arg_43_0.ground then
		IsNil = var_1

		if not var_1(arg_43_0.groundGo) then
			TowerClimbingResMgr = var_1

			var_1.ReturnGround(arg_43_0.ground.name, arg_43_0.groundGo)
		end
	end

	if arg_43_0.blocks then
		ipairs = var_1

		for iter_43_2, iter_43_3 in var_1(arg_43_0.blocks) do
			IsNil = var_1_10006

			if not var_1_10006(iter_43_3.go) then
				TowerClimbingResMgr = var_1_10006

				var_1_10006.ReturnBlock(iter_43_3.block.type, iter_43_3.go)
			end
		end

		arg_43_0.blocks = nil
	end

	return
end

return var_0_0
