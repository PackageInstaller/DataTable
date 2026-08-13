class = var_0_10000

local var_0_0 = "MainRightPanel4Mellow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.MainBasePanel"))

function var_0_1.GetBtns(arg_1_0)
	local var_1_0 = {}

	MainMemoryBtn = var_1_10002

	local var_1_1 = var_1_10002.New

	findTF = var_1_10004
	var_1_0[1] = var_1_1(var_1_10004(arg_1_0._tf, "2/menor"), arg_1_0.event)
	MainCollectionBtn = var_2

	local var_1_2 = var_2.New

	findTF = var_4
	var_1_0[2] = var_1_2(var_4(arg_1_0._tf, "2/collection"), arg_1_0.event)
	MainRankBtn4Mellow = var_2

	local var_1_3 = var_2.New

	findTF = var_4
	var_1_0[3] = var_1_3(var_4(arg_1_0._tf, "2/rank"), arg_1_0.event)
	MainFriendBtn = var_2

	local var_1_4 = var_2.New

	findTF = var_4
	var_1_0[4] = var_1_4(var_4(arg_1_0._tf, "2/friend"), arg_1_0.event)
	MainFormationBtn = var_2

	local var_1_5 = var_2.New

	findTF = var_4
	var_1_0[5] = var_1_5(var_4(arg_1_0._tf, "1/formation"), arg_1_0.event)
	MainBattleBtn = var_2

	local var_1_6 = var_2.New

	findTF = var_4
	var_1_0[6] = var_1_6(var_4(arg_1_0._tf, "1/battle"), arg_1_0.event)

	return var_1_0
end

function var_0_1.GetDirection(arg_2_0)
	Vector2 = var_1_10001

	return var_1_10001(1, 0)
end

function var_0_1.SetEffectVisible(arg_3_0, arg_3_1)
	setActive = var_1_10002
	findTF = var_1_10004

	var_1_10002(var_1_10004(arg_3_0._tf, "1/battle/FX"), arg_3_1)

	return
end

return var_0_1
