local SailShopEventView = class("SailShopEventView", (import("game.views.sailGame.sailGameEvent.SailGameEventBaseView")))

function SailShopEventView:UIName()
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdVoyagesGiftEventPopUI"
end

function SailShopEventView:RefreshReward()
	local var_2_0 = SailGameData:GetCurGameData(self.activityID_).eventList[self.curStageIndex_].giftInfo

	self.rewardIcon_.sprite = ItemTools.getItemSprite(var_2_0.itemID)
	self.rewardNumText_.text = var_2_0.itemNum

	SetActive(self.rewardPanelGo_, true)
end

function SailShopEventView:AcceptEvent()
	self.tipsIndex_ = SailGameConst.GAME_COMMON_TIPS_INDEX.SUCCESS

	SailGameAction.EventOperate(self.activityID_, self.curStageIndex_, nil)
end

return SailShopEventView
