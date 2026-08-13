class = var_0_10000

local var_0_0 = "MainBottomPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.MainBasePanel"))

function var_0_1.GetBtns(arg_1_0)
	local var_1_0 = {}

	MainMallBtn = var_1_10002

	local var_1_1 = var_1_10002.New

	findTF = var_1_10003

	local var_1_2 = var_1_10003(arg_1_0._tf, "mallBtn")

	findTF = var_4
	var_1_0[1] = var_1_1(var_1_2, var_4(arg_1_0._tf, "tags"), arg_1_0.event)
	MainDockBtn = var_2

	local var_1_3 = var_2.New

	findTF = var_1_2
	var_1_0[2] = var_1_3(var_1_2(arg_1_0._tf, "dockBtn"), arg_1_0.event)
	MainEquipBtn = var_2

	local var_1_4 = var_2.New

	findTF = var_3
	var_1_0[3] = var_1_4(var_3(arg_1_0._tf, "equipButton"), arg_1_0.event)
	MainLiveBtn = var_2

	local var_1_5 = var_2.New

	findTF = var_3
	var_1_0[4] = var_1_5(var_3(arg_1_0._tf, "liveButton"), arg_1_0.event)
	MainTechBtn = var_2

	local var_1_6 = var_2.New

	findTF = var_3
	var_1_0[5] = var_1_6(var_3(arg_1_0._tf, "technologyButton"), arg_1_0.event)
	MainTaskBtn = var_2

	local var_1_7 = var_2.New

	findTF = var_3
	var_1_0[6] = var_1_7(var_3(arg_1_0._tf, "taskButton"), arg_1_0.event)
	MainBuildBtn = var_2

	local var_1_8 = var_2.New

	findTF = var_3
	var_1_0[7] = var_1_8(var_3(arg_1_0._tf, "buildButton"), arg_1_0.event)
	MainGuildBtn = var_2

	local var_1_9 = var_2.New

	findTF = var_3
	var_1_0[8] = var_1_9(var_3(arg_1_0._tf, "guildButton"), arg_1_0.event)

	return var_1_0
end

function var_0_1.GetDirection(arg_2_0)
	Vector2 = var_1_10001

	return var_1_10001(0, -1)
end

return var_0_1
