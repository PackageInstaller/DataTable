local var_0_0 = class("TowerClimbingMap")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1.gameView
	arg_1_0.view = arg_1_1
	arg_1_0.map = arg_1_2

	return
end

function var_0_0.Init(arg_2_0, arg_2_1)
	arg_2_0.blocks = {}
	arg_2_0.groundContainer = arg_2_0._tf:Find("game")
	arg_2_0.blockPlayCon = arg_2_0.groundContainer:Find("block_play_con")

	setAnchoredPosition(arg_2_0.blockPlayCon, {
		x = 0,
		y = 0
	})

	arg_2_0.blockContainer = arg_2_0.blockPlayCon:Find("blocks")
	arg_2_0.hearts = {
		arg_2_0._tf:Find("prints/score/hearts/1"),
		arg_2_0._tf:Find("prints/score/hearts/2"),
		arg_2_0._tf:Find("prints/score/hearts/3")
	}
	arg_2_0.score = arg_2_0._tf:Find("prints/score/Text"):GetComponent(typeof(Text))
	arg_2_0.heartProgress = arg_2_0._tf:Find("prints/score/progress")
	arg_2_0.heartProgressTxt = arg_2_0._tf:Find("prints/score/progress/Text"):GetComponent(typeof(Text))
	arg_2_0.bg = TowerClimbBgMgr.New(arg_2_0._tf:Find("bgs"))

	arg_2_0.bg:Init(arg_2_0.map.id, arg_2_1)

	arg_2_0.npc = arg_2_0._tf:Find("prints/npc")

	arg_2_0:LoadEffect(arg_2_0.map.id)

	arg_2_0.tip = arg_2_0._tf:Find("prints/tip")

	setActive(arg_2_0.tip, false)

	arg_2_0.timers = {}

	return
end

function var_0_0.LoadEffect(arg_3_0, arg_3_1)
	if TowerClimbingGameSettings.MAPID2EFFECT[arg_3_1] then
		for iter_3_0, iter_3_1 in ipairs(TowerClimbingGameSettings.MAPID2EFFECT[arg_3_1]) do
			arg_3_0:LoadSingleEffect(iter_3_1[1], iter_3_1[2])
		end
	end

	return
end

function var_0_0.LoadSingleEffect(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	PoolMgr.GetInstance():GetUI(arg_4_1, true, function(arg_5_0)
		if not arg_4_0.groundContainer then
			PoolMgr.GetInstance():ReturnUI(arg_4_1, arg_5_0)
		else
			arg_5_0.name = arg_4_1

			SetParent(arg_5_0, arg_4_0.groundContainer)

			arg_5_0.transform.anchoredPosition3D = Vector3(arg_4_2[1], arg_4_2[2], -200)

			setActive(arg_5_0, true)

			if arg_4_3 then
				arg_4_3(arg_5_0)
			end
		end

		return
	end)

	return
end

function var_0_0.ReturnEffect(arg_6_0, arg_6_1)
	if TowerClimbingGameSettings.MAPID2EFFECT[arg_6_1] then
		for iter_6_0, iter_6_1 in ipairs(TowerClimbingGameSettings.MAPID2EFFECT[arg_6_1]) do
			local var_6_0 = arg_6_0.groundContainer:Find(iter_6_1[1])

			if var_6_0 then
				PoolMgr.GetInstance():ReturnUI(iter_6_1[1], var_6_0.gameObject)
			end
		end
	end

	return
end

function var_0_0.OnReachAwardScore(arg_7_0)
	if LOCK_TOWERCLIMBING_AWARD then
		return
	end

	if arg_7_0.tipTimer then
		arg_7_0.tipTimer:Stop()

		arg_7_0.tipTimer = nil
	end

	setActive(arg_7_0.tip, true)

	arg_7_0.tipTimer = Timer.New(function()
		setActive(arg_7_0.tip, false)
		arg_7_0.tipTimer:Stop()

		arg_7_0.tipTimer = nil

		return
	end, 3, 1)

	arg_7_0.tipTimer:Start()

	local var_7_0 = arg_7_0.groundContainer:InverseTransformPoint(arg_7_0.npc.position)
	local var_7_1 = arg_7_0.groundContainer:InverseTransformPoint(arg_7_0.player._tf.position)

	local function var_7_2()
		local function var_9_0()
			setActive(arg_7_0.awardEffect1, true)

			arg_7_0.awardTimer = Timer.New(function()
				setActive(arg_7_0.awardEffect1, false)

				return
			end, 2, 1)

			arg_7_0.awardTimer:Start()

			return
		end

		if not arg_7_0.awardEffect1 then
			arg_7_0:LoadSingleEffect(TowerClimbingGameSettings.AWARDEFFECT1, {
				var_7_0.x,
				var_7_0.y
			}, function(arg_12_0)
				arg_7_0.awardEffect1 = arg_12_0

				var_9_0()

				return
			end)
		else
			(function()
				setActive(arg_7_0.awardEffect1, true)

				arg_7_0.awardTimer = Timer.New(function()
					setActive(arg_7_0.awardEffect1, false)

					return
				end, 2, 1)

				arg_7_0.awardTimer:Start()

				return
			end)()
		end

		return
	end

	local function var_7_3()
		local var_13_0 = Vector3(var_7_0.x, var_7_1.y + 200, -200)

		table.insert({}, Vector3(var_7_1.x, var_7_1.y, -200))
		table.insert({}, var_13_0)
		table.insert({}, var_13_0)
		table.insert({}, Vector3(var_7_0.x, var_7_0.y, -200))

		arg_7_0.awardEffect.transform.localPosition = Vector3(var_7_1.x, var_7_1.y, -200)

		setActive(arg_7_0.awardEffect, true)
		LeanTween.moveLocal(arg_7_0.awardEffect, {}, 1):setOnComplete(System.Action(function()
			setActive(arg_7_0.awardEffect, false)
			var_7_2()

			return
		end))

		return
	end

	if not arg_7_0.awardEffect then
		arg_7_0:LoadSingleEffect(TowerClimbingGameSettings.AWARDEFFECT, {
			var_7_1.x,
			var_7_1.y
		}, function(arg_15_0)
			arg_7_0.awardEffect = arg_15_0

			var_7_3()

			return
		end)
	else
		(function()
			local var_13_0 = Vector3(var_7_0.x, var_7_1.y + 200, -200)

			table.insert({}, Vector3(var_7_1.x, var_7_1.y, -200))
			table.insert({}, var_13_0)
			table.insert({}, var_13_0)
			table.insert({}, Vector3(var_7_0.x, var_7_0.y, -200))

			arg_7_0.awardEffect.transform.localPosition = Vector3(var_7_1.x, var_7_1.y, -200)

			setActive(arg_7_0.awardEffect, true)
			LeanTween.moveLocal(arg_7_0.awardEffect, {}, 1):setOnComplete(System.Action(function()
				setActive(arg_7_0.awardEffect, false)
				var_7_2()

				return
			end))

			return
		end)()
	end

	return
end

function var_0_0.GetFirstBlock(arg_16_0)
	return arg_16_0.blocks[1]
end

function var_0_0.GetHitBlock(arg_17_0, arg_17_1)
	local var_17_0 = _.detect(arg_17_0.blocks, function(arg_18_0)
		return arg_18_0.go == arg_17_1
	end)

	if var_17_0 then
		return var_17_0
	end

	return
end

function var_0_0.OnCreateGround(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0.ground = arg_19_1

	TowerClimbingResMgr.GetGround(arg_19_1.name, function(arg_20_0)
		arg_19_0.groundGo = arg_20_0
		arg_20_0.name = "manjuu"

		SetParent(arg_20_0.transform, arg_19_0.groundContainer)

		arg_20_0.transform.anchoredPosition = arg_19_1.position

		setActive(arg_20_0, true)
		arg_20_0:GetComponent("SpineAnimUI"):SetAction("normal", 0)
		setText(arg_19_0.groundGo.transform:Find("Text"), "")
		arg_19_2()

		return
	end)

	return
end

function var_0_0.TranslateBlockPosition(arg_21_0, arg_21_1)
	return arg_21_0.blockContainer:InverseTransformVector(arg_21_0.groundContainer:TransformVector(arg_21_1))
end

function var_0_0.OnCreateBlock(arg_22_0, arg_22_1, arg_22_2)
	TowerClimbingResMgr.GetBlock(arg_22_1.type, function(arg_23_0)
		SetParent(arg_23_0, arg_22_0.blockContainer)

		arg_23_0.transform.anchoredPosition = arg_22_0:TranslateBlockPosition(arg_22_1.position)
		arg_23_0.name = TowerClimbingGameSettings.BLOCK_NAME

		setActive(arg_23_0, true)
		table.insert(arg_22_0.blocks, {
			go = arg_23_0,
			block = arg_22_1,
			colliders = arg_23_0:GetComponentsInChildren(typeof(UnityEngine.Collider2D)):ToTable()
		})
		arg_22_0:OnActiveBlock(arg_22_1)

		local var_23_0 = arg_23_0.transform:Find("firer")

		if var_23_0 then
			local var_23_1 = var_23_0:GetComponent(typeof(Animation))

			arg_22_0.timers[arg_22_1.level] = Timer.New(function()
				var_23_1:Play("action")

				return
			end, math.random(TowerClimbingGameSettings.FIRE_TIME[1], TowerClimbingGameSettings.FIRE_TIME[2]), -1)

			arg_22_0.timers[arg_22_1.level]:Start()
		end

		arg_22_2()

		return
	end)

	return
end

function var_0_0.OnActiveBlock(arg_25_0, arg_25_1)
	for iter_25_0, iter_25_1 in ipairs(_.detect(arg_25_0.blocks, function(arg_26_0)
		return arg_26_0.block.level == arg_25_1.level
	end).colliders) do
		iter_25_1.enabled = arg_25_1.isActive
	end

	return
end

function var_0_0.SinkHandler(arg_27_0, arg_27_1, arg_27_2)
	LeanTween.value(arg_27_0.blockPlayCon.gameObject, arg_27_0.blockPlayCon.anchoredPosition.y, arg_27_0.blockPlayCon.anchoredPosition.y - arg_27_1, 0.2):setOnUpdate(System.Action_float(function(arg_28_0)
		setAnchoredPosition(arg_27_0.blockPlayCon, {
			y = arg_28_0
		})

		return
	end)):setEase(LeanTweenType.easeOutQuad):setOnComplete(System.Action(arg_27_2))

	return
end

function var_0_0.OnBlockDestory(arg_29_0, arg_29_1)
	if arg_29_0.timers[arg_29_1] then
		arg_29_0.timers[arg_29_1]:Stop()

		arg_29_0.timers[arg_29_1] = nil
	end

	local var_29_0 = _.detect(arg_29_0.blocks, function(arg_30_0)
		return arg_30_0.block.level == arg_29_1
	end)

	TowerClimbingResMgr.ReturnBlock(var_29_0.block.type, var_29_0.go)

	return
end

function var_0_0.OnSink(arg_31_0, arg_31_1, arg_31_2)
	arg_31_0.bg:DoMove(arg_31_1, arg_31_2)
	arg_31_2()

	return
end

function var_0_0.OnPlayerLifeUpdate(arg_32_0, arg_32_1)
	triggerToggle(arg_32_0.hearts[3], arg_32_1 >= 3)
	triggerToggle(arg_32_0.hearts[2], arg_32_1 >= 2)
	triggerToggle(arg_32_0.hearts[1], arg_32_1 >= 1)

	arg_32_0.heartProgressTxt.text = arg_32_1 .. "/" .. 3

	setFillAmount(arg_32_0.heartProgress, arg_32_1 / 3)

	return
end

function var_0_0.OnScoreUpdate(arg_33_0, arg_33_1)
	arg_33_0.score.text = arg_33_1

	return
end

function var_0_0.OnCreatePlayer(arg_34_0, arg_34_1, arg_34_2)
	arg_34_0.player = TowerClimbingPlayer.New(arg_34_0, arg_34_1)

	arg_34_0.player:Init(arg_34_2)

	return
end

function var_0_0.OnEnableStab(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = _.detect(arg_35_0.blocks, function(arg_36_0)
		return arg_36_0.block.level == arg_35_1.level
	end)

	assert(var_35_0)

	local var_35_1 = var_35_0.go:GetComponent(typeof(UnityEngine.Collider2D))

	for iter_35_0, iter_35_1 in ipairs(var_35_0.colliders) do
		if iter_35_1 ~= var_35_1 then
			iter_35_1.enabled = arg_35_2
		end
	end

	return
end

function var_0_0.OnEnableGround(arg_37_0, arg_37_1)
	arg_37_0.groundGo:GetComponent(typeof(UnityEngine.Collider2D)).enabled = arg_37_1

	return
end

function var_0_0.GetPlayer(arg_38_0)
	return arg_38_0.player
end

function var_0_0.SendEvent(arg_39_0, arg_39_1, ...)
	arg_39_0.view.controller[arg_39_1](arg_39_0.view.controller, unpack({
		...
	}))

	return
end

function var_0_0.OnGroundRuning(arg_40_0)
	arg_40_0.groundGo:GetComponent("SpineAnimUI"):SetAction("up", 0)

	return
end

function var_0_0.OnGroundPositionChange(arg_41_0, arg_41_1)
	setAnchoredPosition(arg_41_0.groundGo.transform, arg_41_1)

	return
end

function var_0_0.OnGroundSleepTimeChange(arg_42_0, arg_42_1)
	local var_42_0 = math.ceil(arg_42_1)

	if var_42_0 > 0 then
		setText(arg_42_0.groundGo.transform:Find("Text"), var_42_0)
	else
		setText(arg_42_0.groundGo.transform:Find("Text"), "")
	end

	return
end

function var_0_0.Dispose(arg_43_0)
	if arg_43_0.awardTimer then
		arg_43_0.awardTimer:Stop()

		arg_43_0.awardTimer = nil
	end

	arg_43_0.bg:Clear()
	arg_43_0:ReturnEffect(arg_43_0.map.id)

	if arg_43_0.awardEffect then
		PoolMgr.GetInstance():ReturnUI(arg_43_0.awardEffect.name, arg_43_0.awardEffect)

		arg_43_0.awardEffect = nil
	end

	if arg_43_0.awardEffect1 then
		PoolMgr.GetInstance():ReturnUI(arg_43_0.awardEffect1.name, arg_43_0.awardEffect1)

		arg_43_0.awardEffect1 = nil
	end

	if arg_43_0.tipTimer then
		arg_43_0.tipTimer:Stop()
	end

	arg_43_0.tipTimer = nil

	local var_43_0 = arg_43_0.timers or {}

	for iter_43_0, iter_43_1 in pairs(var_43_0) do
		iter_43_1:Stop()
	end

	arg_43_0.timers = nil

	if arg_43_0.player then
		arg_43_0.player:Dispose()

		arg_43_0.player = nil
	end

	if arg_43_0.ground and not IsNil(arg_43_0.groundGo) then
		TowerClimbingResMgr.ReturnGround(arg_43_0.ground.name, arg_43_0.groundGo)
	end

	if arg_43_0.blocks then
		for iter_43_2, iter_43_3 in ipairs(arg_43_0.blocks) do
			if not IsNil(iter_43_3.go) then
				TowerClimbingResMgr.ReturnBlock(iter_43_3.block.type, iter_43_3.go)
			end
		end

		arg_43_0.blocks = nil
	end

	return
end

return var_0_0
