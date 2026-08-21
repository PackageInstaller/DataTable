local var_0_0 = class("MainRightPanel4Mellow", import("...base.MainBasePanel"))

function var_0_0.GetBtns(arg_1_0)
	return {
		MainMemoryBtn.New(findTF(arg_1_0._tf, "2/menor"), arg_1_0.event),
		MainCollectionBtn.New(findTF(arg_1_0._tf, "2/collection"), arg_1_0.event),
		MainRankBtn4Mellow.New(findTF(arg_1_0._tf, "2/rank"), arg_1_0.event),
		MainFriendBtn.New(findTF(arg_1_0._tf, "2/friend"), arg_1_0.event),
		MainFormationBtn.New(findTF(arg_1_0._tf, "1/formation"), arg_1_0.event),
		MainBattleBtn.New(findTF(arg_1_0._tf, "1/battle"), arg_1_0.event)
	}
end

function var_0_0.GetDirection(arg_2_0)
	return Vector2(1, 0)
end

function var_0_0.SetEffectVisible(arg_3_0, arg_3_1)
	setActive(findTF(arg_3_0._tf, "1/battle/FX"), arg_3_1)

	return
end

return var_0_0
