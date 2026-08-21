local var_0_0 = class("MainRightPanel", import("...base.MainConcealablePanel"))

function var_0_0.GetBtns(arg_1_0)
	return {
		MainMemoryBtn.New(findTF(arg_1_0._tf, "memoryButton"), arg_1_0.event),
		MainCollectionBtn.New(findTF(arg_1_0._tf, "collectionButton"), arg_1_0.event),
		MainRankBtn.New(findTF(arg_1_0._tf, "rankButton"), arg_1_0.event),
		MainFriendBtn.New(findTF(arg_1_0._tf, "friendButton"), arg_1_0.event),
		MainMailBtn.New(findTF(arg_1_0._tf, "mailButton"), arg_1_0.event),
		MainNoticeBtn.New(findTF(arg_1_0._tf, "noticeButton"), arg_1_0.event),
		MainSettingsBtn.New(findTF(arg_1_0._tf, "settingButton"), arg_1_0.event),
		MainFormationBtn.New(findTF(arg_1_0._tf, "formationButton"), arg_1_0.event),
		MainBattleBtn.New(findTF(arg_1_0._tf, "combatBtn"), arg_1_0.event)
	}
end

function var_0_0.GetDirection(arg_2_0)
	return Vector2(1, 0)
end

return var_0_0
