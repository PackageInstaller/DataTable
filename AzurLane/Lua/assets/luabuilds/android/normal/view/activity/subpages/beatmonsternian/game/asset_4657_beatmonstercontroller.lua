class = var_0_10000

local var_0_0 = var_0_10000("BeatMonsterController")

function var_0_0.Ctor(arg_1_0)
	BeatMonsterMeidator = var_1_10001
	arg_1_0.mediator = var_1_10001.New(arg_1_0)
	BeatMonsterModel = var_1
	arg_1_0.model = var_1.New(arg_1_0)

	return
end

function var_0_0.SetUp(arg_2_0, arg_2_1, arg_2_2)
	seriesAsync = var_1_10003

	var_1_10003({
		function(arg_3_0)
			arg_2_0.OnDisenabelUIEvent = arg_2_2

			local var_3_0 = arg_2_0

			var_1.InitStage(var_3_0, arg_2_1)

			local var_3_1 = arg_2_0.model

			if not var_1.GetPlayableStory(var_3_1) then
				arg_3_0()

				return
			end

			local var_3_2 = arg_2_0.mediator

			var_2.PlayStory(var_3_2, var_1, arg_3_0)

			return
		end,
		function(arg_4_0)
			if arg_2_1.hp > 0 then
				local var_4_0 = arg_2_0.mediator

				var_1.DoCurtainUp(var_4_0, arg_4_0)
			else
				arg_4_0()
			end

			return
		end,
		function(arg_5_0)
			local var_5_0 = arg_2_0.mediator

			var_1.OnInited(var_5_0)

			return
		end
	})

	return
end

function var_0_0.NetData(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.model

	var_2.UpdateData(var_6_0, arg_6_1)

	local var_6_1 = arg_6_0.mediator

	var_2.OnMonsterHpUpdate(var_6_1, arg_6_0.model.mosterNian.hp)

	local var_6_2 = arg_6_0.mediator
	local var_6_3 = var_2.OnAttackCntUpdate
	local var_6_4 = arg_6_0.model.attackCnt
	local var_6_5

	if not arg_6_0.isFake then
		var_6_5 = arg_6_0.model.mosterNian.hp <= 0
	end

	var_6_3(var_6_2, var_6_4, var_6_5)

	return
end

function var_0_0.InitStage(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.model

	var_2.AddMonsterNian(var_7_0, arg_7_1.hp, arg_7_1.maxHp)

	local var_7_1 = arg_7_0.model

	var_2.AddFuShun(var_7_1)

	local var_7_2 = arg_7_0.model.mosterNian.hp
	local var_7_3 = arg_7_0.model.mosterNian.maxHp
	local var_7_4 = arg_7_0.mediator

	var_4.OnAddMonsterNian(var_7_4, var_7_2, var_7_3)

	local var_7_5 = arg_7_0.mediator

	var_4.OnAddFuShun(var_7_5, var_7_2)

	local var_7_6 = arg_7_0.model

	var_4.SetAttackCnt(var_7_6, arg_7_1.leftCount)

	local var_7_7 = arg_7_0.mediator
	local var_7_8 = var_4.OnAttackCntUpdate
	local var_7_9 = arg_7_0.model.attackCnt
	local var_7_10

	if not arg_7_0.isFake then
		var_7_10 = arg_7_0.model.mosterNian.hp <= 0
	end

	var_7_8(var_7_7, var_7_9, var_7_10)

	local var_7_11 = arg_7_0.model

	var_4.SetStorys(var_7_11, arg_7_1.storys)

	return
end

function var_0_0.Input(arg_8_0, arg_8_1)
	if arg_8_0.isOnAction then
		return
	end

	arg_8_0:RemoveInputTimer()
	arg_8_0:UpdateActionStr(arg_8_1)

	local var_8_0 = arg_8_0.model

	if var_2.IsMatchAction(var_8_0) then
		var_8_0 = 0.5
	else
		BeatMonsterNianConst = var_8_0
		var_8_0 = var_8_0.INPUT_TIME
	end

	if var_2 then
		arg_8_0.OnDisenabelUIEvent(true)

		arg_8_0.isOnAction = true
	end

	Timer = var_4
	arg_8_0.inputTimer = var_4.New(function()
		local var_9_0 = arg_8_0.model
		local var_9_1 = var_0.GetMatchAction(var_9_0)
		local var_9_2 = arg_8_0.model
		local var_9_3 = var_1.GetMonsterAction(var_9_2)
		local var_9_4 = arg_8_0

		var_2.UpdateActionStr(var_9_4, "")

		if var_0 then
			local var_9_5 = arg_8_0

			var_2.StartAction(var_9_5, var_9_1, var_9_3)
		end

		return
	end, var_8_0, 1)

	local var_8_1 = arg_8_0.inputTimer

	var_4.Start(var_8_1)

	return
end

function var_0_0.StartAction(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0

	arg_10_0.RemoveAnimationTimer(var_10_0)

	local var_10_1

	seriesAsync = var_10_0

	var_10_0({
		function(arg_11_0)
			local var_11_0 = arg_10_0

			var_1.SendRequestToServer(var_11_0, function(arg_12_0)
				var_10_1 = arg_12_0

				arg_11_0()

				return
			end)

			return
		end,
		function(arg_13_0)
			local var_13_0 = arg_10_0.mediator

			var_1.OnChangeFuShunAction(var_13_0, arg_10_1)

			local var_13_1 = arg_10_0.mediator

			var_1.OnChangeNianAction(var_13_1, arg_10_2)

			local var_13_2 = arg_10_0

			Timer = var_13_1
			var_13_2.animationTimer = var_13_1.New(arg_13_0, 2, 1)

			local var_13_3 = arg_10_0.animationTimer

			var_1.Start(var_13_3)

			return
		end,
		function(arg_14_0)
			local var_14_0 = arg_10_0.model.mosterNian.hp
			local var_14_1 = arg_10_0.model.mosterNian.maxHp
			local var_14_2 = arg_10_0.mediator

			var_3.OnUIHpUpdate(var_14_2, var_14_0, var_14_1, arg_14_0)

			return
		end,
		function(arg_15_0)
			local var_15_0 = arg_10_0.model

			if not var_1.GetPlayableStory(var_15_0) then
				arg_15_0()

				return
			end

			local var_15_1 = arg_10_0.mediator

			var_2.PlayStory(var_15_1, var_1, arg_15_0)

			return
		end,
		function(arg_16_0)
			if not var_10_1 or #var_10_1 == 0 then
				arg_16_0()

				return
			end

			local var_16_0 = arg_10_0.mediator

			var_1.DisplayAwards(var_16_0, var_10_1, arg_16_0)

			return
		end,
		function(arg_17_0)
			arg_10_0.isOnAction = false

			arg_10_0.OnDisenabelUIEvent(false)

			return
		end
	})

	return
end

function var_0_0.SendRequestToServer(arg_18_0, arg_18_1)
	local var_18_1

	if arg_18_0.isFake then
		local var_18_0 = arg_18_0

		var_18_1 = arg_18_0.NetData
		var_1_10004 = {}
		var_1_10006 = arg_18_0.model
		var_1_10004.hp = var_5.RandomDamage(var_1_10006)
		var_1_10006 = arg_18_0.model
		var_1_10004.maxHp = var_5.GetMonsterMaxHp(var_1_10006)
		var_1_10006 = arg_18_0.model
		var_1_10004.leftCount = var_5.GetAttackCount(var_1_10006) - 1
		var_1_10004.storys = {}

		var_18_1(var_18_0, var_1_10004)
		arg_18_1()
	else
		pg = var_18_1

		local var_18_2 = var_18_1.m02
		local var_18_3 = var_2.sendNotification

		GAME = var_1_10004

		local var_18_4 = var_1_10004.ACT_BEAT_MONSTER_NIAN
		local var_18_5 = {
			cmd = 1
		}

		ActivityConst = var_1_10006
		var_18_5.activity_id = var_1_10006.BEAT_MONSTER_NIAN_2020
		var_18_5.callback = arg_18_1

		var_18_3(var_18_2, var_18_4, var_18_5)
	end

	return
end

function var_0_0.UpdateActionStr(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.model

	var_2.UpdateActionStr(var_19_0, arg_19_1)

	local var_19_1 = arg_19_0.model
	local var_19_2 = var_2.GetActionStr(var_19_1)
	local var_19_3 = arg_19_0.mediator

	var_3.OnInputChange(var_19_3, var_19_2)

	return
end

function var_0_0.RemoveInputTimer(arg_20_0)
	if arg_20_0.inputTimer then
		local var_20_0 = arg_20_0.inputTimer

		var_1.Stop(var_20_0)

		arg_20_0.inputTimer = nil
	end

	return
end

function var_0_0.RemoveAnimationTimer(arg_21_0)
	if arg_21_0.animationTimer then
		local var_21_0 = arg_21_0.animationTimer

		var_1.Stop(var_21_0)

		arg_21_0.animationTimer = nil
	end

	return
end

function var_0_0.ReStartGame(arg_22_0)
	arg_22_0.isFake = true

	arg_22_0:NetData({
		leftCount = 10,
		hp = 10,
		maxHp = 10,
		storys = {}
	})

	local var_22_0 = arg_22_0.mediator

	var_1.OnUIHpUpdate(var_22_0, 10, 10)

	return
end

function var_0_0.Dispose(arg_23_0)
	arg_23_0:RemoveAnimationTimer()
	arg_23_0:RemoveInputTimer()

	local var_23_0 = arg_23_0.mediator

	var_1.Dispose(var_23_0)

	local var_23_1 = arg_23_0.model

	var_1.Dispose(var_23_1)

	arg_23_0.OnDisenabelUIEvent = nil

	return
end

return var_0_0
