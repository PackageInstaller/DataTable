class = var_0_10000

local var_0_0 = "MainRightPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.MainConcealablePanel"))

function var_0_1.GetBtns(arg_1_0)
	local var_1_0 = {}

	MainMemoryBtn = var_1_10002

	local var_1_1 = var_1_10002.New

	findTF = var_1_10003
	var_1_0[1] = var_1_1(var_1_10003(arg_1_0._tf, "memoryButton"), arg_1_0.event)
	MainCollectionBtn = var_2

	local var_1_2 = var_2.New

	findTF = var_3
	var_1_0[2] = var_1_2(var_3(arg_1_0._tf, "collectionButton"), arg_1_0.event)
	MainRankBtn = var_2

	local var_1_3 = var_2.New

	findTF = var_3
	var_1_0[3] = var_1_3(var_3(arg_1_0._tf, "rankButton"), arg_1_0.event)
	MainFriendBtn = var_2

	local var_1_4 = var_2.New

	findTF = var_3
	var_1_0[4] = var_1_4(var_3(arg_1_0._tf, "friendButton"), arg_1_0.event)
	MainMailBtn = var_2

	local var_1_5 = var_2.New

	findTF = var_3
	var_1_0[5] = var_1_5(var_3(arg_1_0._tf, "mailButton"), arg_1_0.event)
	MainNoticeBtn = var_2

	local var_1_6 = var_2.New

	findTF = var_3
	var_1_0[6] = var_1_6(var_3(arg_1_0._tf, "noticeButton"), arg_1_0.event)
	MainSettingsBtn = var_2

	local var_1_7 = var_2.New

	findTF = var_3
	var_1_0[7] = var_1_7(var_3(arg_1_0._tf, "settingButton"), arg_1_0.event)
	MainFormationBtn = var_2

	local var_1_8 = var_2.New

	findTF = var_3
	var_1_0[8] = var_1_8(var_3(arg_1_0._tf, "formationButton"), arg_1_0.event)
	MainBattleBtn = var_2

	local var_1_9 = var_2.New

	findTF = var_3
	var_1_0[9] = var_1_9(var_3(arg_1_0._tf, "combatBtn"), arg_1_0.event)

	return var_1_0
end

function var_0_1.GetDirection(arg_2_0)
	Vector2 = var_1_10001

	return var_1_10001(1, 0)
end

return var_0_1
