local var_0_0 = class("MainBottomPanel4Mellow", import("...base.MainBasePanel"))

function var_0_0.GetBtns(arg_1_0)
	return {
		MainMallBtn.New(findTF(arg_1_0._tf, "frame/shop"), findTF(arg_1_0._tf, "tags"), arg_1_0.event),
		MainDockBtn.New(findTF(arg_1_0._tf, "frame/dock"), arg_1_0.event),
		MainEquipBtn.New(findTF(arg_1_0._tf, "frame/storage"), arg_1_0.event),
		MainLiveBtn.New(findTF(arg_1_0._tf, "frame/live"), arg_1_0.event),
		MainTechBtn.New(findTF(arg_1_0._tf, "frame/tech"), arg_1_0.event),
		MainTaskBtn.New(findTF(arg_1_0._tf, "frame/task"), arg_1_0.event),
		MainBuildBtn.New(findTF(arg_1_0._tf, "frame/build"), arg_1_0.event),
		MainGuildBtn.New(findTF(arg_1_0._tf, "frame/guild"), arg_1_0.event)
	}
end

function var_0_0.GetDirection(arg_2_0)
	return Vector2(0, -1)
end

return var_0_0
