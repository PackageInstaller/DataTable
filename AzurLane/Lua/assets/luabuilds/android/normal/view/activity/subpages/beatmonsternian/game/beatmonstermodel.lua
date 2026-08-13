class = var_0_10000

local var_0_0 = var_0_10000("BeatMonsterModel")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.controller = arg_1_1
	arg_1_0.fuShun = nil
	arg_1_0.mosterNian = nil
	arg_1_0.attackCnt = 0
	arg_1_0.actionStr = ""

	return
end

function var_0_0.AddFuShun(arg_2_0)
	arg_2_0.fuShun = {}

	return
end

function var_0_0.AddMonsterNian(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.mosterNian = {
		hp = arg_3_1,
		maxHp = arg_3_2
	}

	return
end

function var_0_0.UpdateMonsterHp(arg_4_0, arg_4_1)
	arg_4_0.mosterNian.hp = arg_4_1

	return
end

function var_0_0.UpdateData(arg_5_0, arg_5_1)
	arg_5_0:UpdateMonsterHp(arg_5_1.hp)

	arg_5_0.mosterNian.maxHp = arg_5_1.maxHp

	arg_5_0:SetAttackCnt(arg_5_1.leftCount)

	return
end

function var_0_0.SetAttackCnt(arg_6_0, arg_6_1)
	arg_6_0.attackCnt = arg_6_1

	return
end

function var_0_0.UpdateActionStr(arg_7_0, arg_7_1)
	if not arg_7_1 or arg_7_1 == "" then
		arg_7_0.actionStr = ""
	else
		arg_7_0.actionStr = arg_7_0.actionStr .. arg_7_1
	end

	return
end

function var_0_0.SetStorys(arg_8_0, arg_8_1)
	arg_8_0.storys = arg_8_1

	return
end

function var_0_0.GetPlayableStory(arg_9_0)
	if arg_9_0.storys then
		type = var_1_10002

		if var_1_10002(var_1) ~= "table" then
			return
		end

		pg = var_1_10002

		local var_9_0 = var_1_10002.NewStoryMgr.GetInstance()

		pairs = var_1_10003

		for iter_9_0, iter_9_1 in var_1_10003(var_1) do
			local var_9_1 = iter_9_1[1]
			local var_9_2 = iter_9_1[2]

			if var_9_1 >= arg_9_0.mosterNian.hp and not var_9_0:IsPlayed(var_9_2) then
				return var_9_2
			end
		end

		return
	end
end

function var_0_0.GetActionStr(arg_10_0)
	return arg_10_0.actionStr
end

function var_0_0.IsMatchAction(arg_11_0)
	BeatMonsterNianConst = var_1_10001

	return var_1_10001.MatchAction(arg_11_0.actionStr)
end

function var_0_0.GetMatchAction(arg_12_0)
	BeatMonsterNianConst = var_1_10001

	return var_1_10001.GetMatchAction(arg_12_0.actionStr)
end

function var_0_0.GetMonsterAction(arg_13_0)
	BeatMonsterNianConst = var_1_10001

	return var_1_10001.GetMonsterAction(arg_13_0.actionStr)
end

function var_0_0.RandomDamage(arg_14_0)
	math = var_1_10001

	local var_14_0 = var_1_10001.random(1, 2)

	math = var_2

	return var_2.max(arg_14_0.mosterNian.hp - var_14_0, 0)
end

function var_0_0.GetMonsterMaxHp(arg_15_0)
	return arg_15_0.mosterNian.maxHp
end

function var_0_0.GetAttackCount(arg_16_0)
	return arg_16_0.attackCnt
end

function var_0_0.Dispose(arg_17_0)
	return
end

return var_0_0
