local var_0_0 = class("MainBottomPanel", import("...base.MainBasePanel"))

function var_0_0.GetBtns(arg_1_0)
	return {
		MainMallBtn.New(findTF(arg_1_0._tf, "mallBtn"), findTF(arg_1_0._tf, "tags"), arg_1_0.event),
		MainDockBtn.New(findTF(arg_1_0._tf, "dockBtn"), arg_1_0.event),
		MainEquipBtn.New(findTF(arg_1_0._tf, "equipButton"), arg_1_0.event),
		MainLiveBtn.New(findTF(arg_1_0._tf, "liveButton"), arg_1_0.event),
		MainTechBtn.New(findTF(arg_1_0._tf, "technologyButton"), arg_1_0.event),
		MainTaskBtn.New(findTF(arg_1_0._tf, "taskButton"), arg_1_0.event),
		MainBuildBtn.New(findTF(arg_1_0._tf, "buildButton"), arg_1_0.event),
		MainGuildBtn.New(findTF(arg_1_0._tf, "guildButton"), arg_1_0.event)
	}
end

function var_0_0.GetDirection(arg_2_0)
	return Vector2(0, -1)
end

return var_0_0
