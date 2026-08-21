local var_0_0 = class("BeatMonsterController")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.mediator = BeatMonsterMeidator.New(arg_1_0)
	arg_1_0.model = BeatMonsterModel.New(arg_1_0)

	return
end

function var_0_0.SetUp(arg_2_0, arg_2_1, arg_2_2)
	seriesAsync({
		function(arg_3_0)
			arg_2_0.OnDisenabelUIEvent = arg_2_2

			arg_2_0:InitStage(arg_2_1)

			local var_3_0 = arg_2_0.model:GetPlayableStory()

			if not var_3_0 then
				arg_3_0()

				return
			end

			arg_2_0.mediator:PlayStory(var_3_0, arg_3_0)

			return
		end,
		function(arg_4_0)
			if arg_2_1.hp > 0 then
				arg_2_0.mediator:DoCurtainUp(arg_4_0)
			else
				arg_4_0()
			end

			return
		end,
		function(arg_5_0)
			arg_2_0.mediator:OnInited()

			return
		end
	})

	return
end

function var_0_0.NetData(arg_6_0, arg_6_1)
	arg_6_0.model:UpdateData(arg_6_1)
	arg_6_0.mediator:OnMonsterHpUpdate(arg_6_0.model.mosterNian.hp)

	local var_6_0 = arg_6_0.isFake or arg_6_0.model.mosterNian.hp <= 0

	arg_6_0.mediator:OnAttackCntUpdate(arg_6_0.model.attackCnt, var_6_0)

	return
end

function var_0_0.InitStage(arg_7_0, arg_7_1)
	arg_7_0.model:AddMonsterNian(arg_7_1.hp, arg_7_1.maxHp)
	arg_7_0.model:AddFuShun()
	arg_7_0.mediator:OnAddMonsterNian(arg_7_0.model.mosterNian.hp, arg_7_0.model.mosterNian.maxHp)
	arg_7_0.mediator:OnAddFuShun(arg_7_0.model.mosterNian.hp)
	arg_7_0.model:SetAttackCnt(arg_7_1.leftCount)

	local var_7_0 = arg_7_0.isFake or arg_7_0.model.mosterNian.hp <= 0

	arg_7_0.mediator:OnAttackCntUpdate(arg_7_0.model.attackCnt, var_7_0)
	arg_7_0.model:SetStorys(arg_7_1.storys)

	return
end

function var_0_0.Input(arg_8_0, arg_8_1)
	if arg_8_0.isOnAction then
		return
	end

	arg_8_0:RemoveInputTimer()
	arg_8_0:UpdateActionStr(arg_8_1)

	local var_8_0 = arg_8_0.model:IsMatchAction()
	local var_8_1 = var_8_0 and 0.5 or BeatMonsterNianConst.INPUT_TIME

	if var_8_0 then
		arg_8_0.OnDisenabelUIEvent(true)

		arg_8_0.isOnAction = true
	end

	arg_8_0.inputTimer = Timer.New(function()
		arg_8_0:UpdateActionStr("")

		if var_8_0 then
			arg_8_0:StartAction(arg_8_0.model:GetMatchAction(), (arg_8_0.model:GetMonsterAction()))
		end

		return
	end, var_8_1, 1)

	arg_8_0.inputTimer:Start()

	return
end

function var_0_0.StartAction(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:RemoveAnimationTimer()

	local var_10_0

	seriesAsync({
		function(arg_11_0)
			arg_10_0:SendRequestToServer(function(arg_12_0)
				var_10_0 = arg_12_0

				arg_11_0()

				return
			end)

			return
		end,
		function(arg_13_0)
			arg_10_0.mediator:OnChangeFuShunAction(arg_10_1)
			arg_10_0.mediator:OnChangeNianAction(arg_10_2)

			arg_10_0.animationTimer = Timer.New(arg_13_0, 2, 1)

			arg_10_0.animationTimer:Start()

			return
		end,
		function(arg_14_0)
			arg_10_0.mediator:OnUIHpUpdate(arg_10_0.model.mosterNian.hp, arg_10_0.model.mosterNian.maxHp, arg_14_0)

			return
		end,
		function(arg_15_0)
			local var_15_0 = arg_10_0.model:GetPlayableStory()

			if not var_15_0 then
				arg_15_0()

				return
			end

			arg_10_0.mediator:PlayStory(var_15_0, arg_15_0)

			return
		end,
		function(arg_16_0)
			if not var_10_0 or #var_10_0 == 0 then
				arg_16_0()

				return
			end

			arg_10_0.mediator:DisplayAwards(var_10_0, arg_16_0)

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
	if arg_18_0.isFake then
		arg_18_0:NetData({
			hp = arg_18_0.model:RandomDamage(),
			maxHp = arg_18_0.model:GetMonsterMaxHp(),
			leftCount = arg_18_0.model:GetAttackCount() - 1,
			storys = {}
		})
		arg_18_1()
	else
		pg.m02:sendNotification(GAME.ACT_BEAT_MONSTER_NIAN, {
			cmd = 1,
			activity_id = ActivityConst.BEAT_MONSTER_NIAN_2020,
			callback = arg_18_1
		})
	end

	return
end

function var_0_0.UpdateActionStr(arg_19_0, arg_19_1)
	arg_19_0.model:UpdateActionStr(arg_19_1)
	arg_19_0.mediator:OnInputChange((arg_19_0.model:GetActionStr()))

	return
end

function var_0_0.RemoveInputTimer(arg_20_0)
	if arg_20_0.inputTimer then
		arg_20_0.inputTimer:Stop()

		arg_20_0.inputTimer = nil
	end

	return
end

function var_0_0.RemoveAnimationTimer(arg_21_0)
	if arg_21_0.animationTimer then
		arg_21_0.animationTimer:Stop()

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
	arg_22_0.mediator:OnUIHpUpdate(10, 10)

	return
end

function var_0_0.Dispose(arg_23_0)
	arg_23_0:RemoveAnimationTimer()
	arg_23_0:RemoveInputTimer()
	arg_23_0.mediator:Dispose()
	arg_23_0.model:Dispose()

	arg_23_0.OnDisenabelUIEvent = nil

	return
end

return var_0_0
