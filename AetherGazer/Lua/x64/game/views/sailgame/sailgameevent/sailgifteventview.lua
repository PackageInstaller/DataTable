local var_0_0 = import("game.views.sailGame.sailGameEvent.SailGameEventBaseView")
local var_0_1 = class("SailShopEventView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdVoyagesGiftEventPopUI"
end

function var_0_1.RefreshReward(arg_2_0)
	local var_2_0 = SailGameData:GetCurGameData(arg_2_0.activityID_).eventList[arg_2_0.curStageIndex_].giftInfo

	arg_2_0.rewardIcon_.sprite = ItemTools.getItemSprite(var_2_0.itemID)
	arg_2_0.rewardNumText_.text = var_2_0.itemNum

	SetActive(arg_2_0.rewardPanelGo_, true)
end

function var_0_1.AcceptEvent(arg_3_0)
	arg_3_0.tipsIndex_ = SailGameConst.GAME_COMMON_TIPS_INDEX.SUCCESS

	SailGameAction.EventOperate(arg_3_0.activityID_, arg_3_0.curStageIndex_, nil)
end

return var_0_1
