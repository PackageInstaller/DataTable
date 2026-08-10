local var_0_0 = class("TugGameObject")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.speed = 0
	arg_1_0.anger = 0
	arg_1_0.constSpeed = arg_1_1.constSpeed or 0
	arg_1_0.angerAddSpeed = arg_1_1.angerAddSpeed or 0
	arg_1_0.angerStart = arg_1_1.angerStart or 0
	arg_1_0.angerMax = arg_1_1.angerMax or 0
	arg_1_0.angerDecay = arg_1_1.angerDecay or 0
	arg_1_0.superAttackTimes = arg_1_1.superAttackTimes or 0
	arg_1_0.skillASpeed = arg_1_1.skillASpeed or 0
	arg_1_0.skillBSpeed = arg_1_1.skillBSpeed or 0
	arg_1_0.state = SpKaliConst.TugEnemyState.none
	arg_1_0.attackTimes = 0
	arg_1_0.CDTime = 0
	arg_1_0.NowCDTime = 0
	arg_1_0.speedList = {}
	arg_1_0.effectTime = 1
end

function var_0_0.UpdatePlayGameData2(arg_2_0, arg_2_1)
	if arg_2_0.NowCDTime <= 0 then
		arg_2_0:UpdateAnger(arg_2_1)
	else
		arg_2_0.NowCDTime = Mathf.Clamp(arg_2_0.NowCDTime - arg_2_1, 0, arg_2_0.CDTime)
	end
end

function var_0_0.SetCDTime(arg_3_0, arg_3_1)
	arg_3_0.CDTime = arg_3_1 or 0
	arg_3_0.NowCDTime = arg_3_1
end

function var_0_0.ReduceEffectTime(arg_4_0)
	arg_4_0.effectTime = 0
end

function var_0_0.EnterCdTime(arg_5_0)
	arg_5_0.NowCDTime = arg_5_0.CDTime
	arg_5_0.state = SpKaliConst.TugEnemyState.CdState
	arg_5_0.effectTime = 1
end

function var_0_0.UpdateAnger(arg_6_0, arg_6_1)
	if arg_6_0.state == SpKaliConst.TugEnemyState.defense then
		arg_6_0.anger = Mathf.Clamp(arg_6_0.anger + arg_6_0.angerAddSpeed * arg_6_1, 0, arg_6_0.angerMax)
	elseif arg_6_0.state == SpKaliConst.TugEnemyState.attack then
		arg_6_0.anger = Mathf.Clamp(arg_6_0.anger - arg_6_0.angerDecay * arg_6_1, 0, arg_6_0.angerMax)
	elseif arg_6_0.state == SpKaliConst.TugEnemyState.SuperAttack then
		arg_6_0.anger = Mathf.Clamp(arg_6_0.anger - arg_6_0.angerDecay * arg_6_1, 0, arg_6_0.angerMax)
	end

	if arg_6_0.state == SpKaliConst.TugEnemyState.CdState then
		if arg_6_0.anger == arg_6_0.angerMax then
			arg_6_0.attackTimes = arg_6_0.attackTimes + 1

			if arg_6_0.attackTimes % arg_6_0.superAttackTimes == 0 then
				arg_6_0.state = SpKaliConst.TugEnemyState.SuperAttack
			else
				arg_6_0.lastState = arg_6_0.state
				arg_6_0.state = SpKaliConst.TugEnemyState.attack
			end
		end

		if arg_6_0.anger == 0 then
			arg_6_0.state = SpKaliConst.TugEnemyState.defense
		end
	else
		local var_6_0 = arg_6_0.anger > 0 and (arg_6_0.state == SpKaliConst.TugEnemyState.attack or arg_6_0.state == SpKaliConst.TugEnemyState.SuperAttack)
		local var_6_1 = arg_6_0.anger < arg_6_0.angerMax and arg_6_0.state == SpKaliConst.TugEnemyState.defense

		if not var_6_0 and not var_6_1 then
			arg_6_0:EnterCdTime()
		end
	end

	arg_6_0:SetBehaviorByState()
end

function var_0_0.SetSpeedList(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.speedList[arg_7_1] = arg_7_2
end

function var_0_0.ResetSkillSpeed(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.speedList) do
		arg_8_0.speedList[iter_8_0] = 0
	end
end

function var_0_0.SetBehaviorByState(arg_9_0)
	arg_9_0.gameManager = TugGame.GetInstance()

	if arg_9_0.state == SpKaliConst.TugEnemyState.defense then
		-- block empty
	elseif arg_9_0.state == SpKaliConst.TugEnemyState.attack then
		-- block empty
	elseif arg_9_0.state == SpKaliConst.TugEnemyState.SuperAttack then
		-- block empty
	end
end

function var_0_0.GetCDFillAmount(arg_10_0)
	return 1 - arg_10_0.NowCDTime / arg_10_0.CDTime
end

function var_0_0.SetState(arg_11_0, arg_11_1)
	arg_11_0.state = arg_11_1
end

function var_0_0.UpdateSelfState(arg_12_0, arg_12_1)
	arg_12_0.anger = Mathf.Clamp(arg_12_0.anger + arg_12_0.angerAddSpeed * arg_12_1, 0, arg_12_0.angerMax)
end

function var_0_0.UpdatePlayGameData1(arg_13_0, arg_13_1)
	arg_13_0:UpdateSelfState(arg_13_1)
end

function var_0_0.AddAnger(arg_14_0, arg_14_1)
	arg_14_0.anger = Mathf.Clamp(arg_14_0.anger + arg_14_1, 0, arg_14_0.angerMax)
end

function var_0_0.GetAngerFillAmount(arg_15_0)
	return arg_15_0.anger / arg_15_0.angerMax
end

return var_0_0
