local var_0_0 = class("BeatMonsterModel")

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
	arg_7_0.actionStr = (not arg_7_1 or arg_7_1 == "") and "" or arg_7_0.actionStr .. arg_7_1

	return
end

function var_0_0.SetStorys(arg_8_0, arg_8_1)
	arg_8_0.storys = arg_8_1

	return
end

function var_0_0.GetPlayableStory(arg_9_0)
	if not arg_9_0.storys or type(arg_9_0.storys) ~= "table" then
		return
	end

	local var_9_0 = pg.NewStoryMgr.GetInstance()

	for iter_9_0, iter_9_1 in pairs(arg_9_0.storys) do
		if iter_9_1[1] >= arg_9_0.mosterNian.hp and not var_9_0:IsPlayed(iter_9_1[2]) then
			return iter_9_1[2]
		end
	end

	return
end

function var_0_0.GetActionStr(arg_10_0)
	return arg_10_0.actionStr
end

function var_0_0.IsMatchAction(arg_11_0)
	return BeatMonsterNianConst.MatchAction(arg_11_0.actionStr)
end

function var_0_0.GetMatchAction(arg_12_0)
	return BeatMonsterNianConst.GetMatchAction(arg_12_0.actionStr)
end

function var_0_0.GetMonsterAction(arg_13_0)
	return BeatMonsterNianConst.GetMonsterAction(arg_13_0.actionStr)
end

function var_0_0.RandomDamage(arg_14_0)
	return math.max(arg_14_0.mosterNian.hp - math.random(1, 2), 0)
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
