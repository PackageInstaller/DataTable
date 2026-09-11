local SailShopEventView = class("SailShopEventView", (import("game.views.sailGame.sailGameEvent.SailGameEventBaseView")))

function SailShopEventView:UIName()
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdVoyagesTransactionEventPopUI"
end

function SailShopEventView:InitUI()
	self:BindCfgUI()

	self.itemList_ = LuaList.New(handler(self, self.IndexItem), self.uiList_, SailShopItem)
end

function SailShopEventView:Dispose()
	self.itemList_:Dispose()

	self.itemList_ = nil

	SailShopEventView.super.Dispose(self)
end

function SailShopEventView:RefreshUI()
	self.shopDataList_ = SailGameData:GetCurGameData(self.activityID_).eventList[self.curStageIndex_].shopInfo

	self.itemList_:StartScroll(#self.shopDataList_)
	self:RefreshTitle()
end

function SailShopEventView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.activityID_, self.shopDataList_[arg_5_1], arg_5_1)
end

function SailShopEventView:OnEventOperateSuccess(arg_6_1)
	if arg_6_1 ~= SailGameConst.EVENT_COMMON_OPERATE.OVER then
		self.shopDataList_ = SailGameData:GetCurGameData(self.activityID_).eventList[self.curStageIndex_].shopInfo

		self.itemList_:StartScroll(#self.shopDataList_)
	else
		SailGameAction.SetEventEndMark(self.activityID_, SailGameConst.GAME_COMMON_TIPS_INDEX.SUCCESS)
		SailGameTools.GoToGameView(self.activityID_)
	end
end

return SailShopEventView
