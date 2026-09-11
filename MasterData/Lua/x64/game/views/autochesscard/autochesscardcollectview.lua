local AutoChessCardCollectView = class("AutoChessCardCollectView", ReduxView)

function AutoChessCardCollectView:UIName()
	return "Widget/System/Activity_AutoChess_Main/Illustrated/Activity_collect_IllustratedDetailUI"
end

function AutoChessCardCollectView:UIParent()
	return manager.ui.uiMain.transform
end

function AutoChessCardCollectView:Init()
	self:InitUI()
	self:AddListeners()
end

function AutoChessCardCollectView:InitUI()
	self:BindCfgUI()

	self.tabStateController_ = self.controller_:GetController("tabState")
	self.cardUiList_ = LuaList.New(handler(self, self.IndexItem), self.uiList_, AutoChessCardCollectItem)
	self.URFactoryItem_ = AutoChessURFactoryItem.New(self.URItemGo_)
end

function AutoChessCardCollectView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.cardIdList_[arg_5_1], arg_5_1, self.URFactoryItem_:GetItem(self.cardIdList_[arg_5_1]))
	arg_5_2:SetSelectHandler(handler(self, self.OnSelectCard))
end

function AutoChessCardCollectView:AddListeners()
	self:AddBtnListener(self.rBtn_, nil, function()
		if self.cardType_ == AutoChessCardConst.CARD_TYPE.R then
			return
		end

		self.cardType_ = AutoChessCardConst.CARD_TYPE.R

		self:RefreshUI()
	end)
	self:AddBtnListener(self.sRBtn_, nil, function()
		if self.cardType_ == AutoChessCardConst.CARD_TYPE.SR then
			return
		end

		self.cardType_ = AutoChessCardConst.CARD_TYPE.SR

		self:RefreshUI()
	end)
	self:AddBtnListener(self.uRBtn_, nil, function()
		if self.cardType_ == AutoChessCardConst.CARD_TYPE.UR then
			return
		end

		self.cardType_ = AutoChessCardConst.CARD_TYPE.UR

		self:RefreshUI()
	end)
end

function AutoChessCardCollectView:OnEnter()
	self.cardType_ = getData("autoChessCard", "collectPage") or AutoChessCardConst.CARD_TYPE.UR

	self:RefreshUI()

	local var_10_0 = 0

	for iter_10_0, iter_10_1 in pairs((AutoChessCardData:GetCardList())) do
		if iter_10_1 > 0 then
			var_10_0 = var_10_0 + 1
		end
	end

	self.txtCollect_.text = string.format("%d/%d", var_10_0, #AutoChessCardCfg.get_id_list_by_is_card_pool[1])
end

function AutoChessCardCollectView:OnTop()
	manager.windowBar:SwitchBar({
		HOME_BAR,
		BACK_BAR
	})
end

function AutoChessCardCollectView:OnExit()
	manager.windowBar:HideBar()
end

function AutoChessCardCollectView:RefreshUI()
	saveData("autoChessCard", "collectPage", self.cardType_)

	self.txtUR_.text = GetTips(AutoChessCardConst.CARD_TYPE_TIPS[AutoChessCardConst.CARD_TYPE.UR])
	self.txtSR_.text = GetTips(AutoChessCardConst.CARD_TYPE_TIPS[AutoChessCardConst.CARD_TYPE.SR])
	self.txtR_.text = GetTips(AutoChessCardConst.CARD_TYPE_TIPS[AutoChessCardConst.CARD_TYPE.R])

	self.tabStateController_:SetSelectedIndex(tostring(self.cardType_ - 1))

	self.cardIdList_ = AutoChessCardCfg.get_id_list_by_type_is_card_pool[self.cardType_][1]

	self.cardUiList_:StartScroll(#self.cardIdList_, getData("autoChessCard", "collectCard_" .. self.cardType_) or 0)
end

function AutoChessCardCollectView:OnSelectCard(arg_14_1, arg_14_2)
	saveData("autoChessCard", "collectCard_" .. self.cardType_, arg_14_2)
	JumpTools.OpenPageByJump("/autoChessCardDetailView", {
		cardId = arg_14_1
	})
	OperationRecorder.RecordButtonTouch({
		button_name = "activity_autochess_collect_item_touch",
		type = 4,
		activity_id = AutoChessData:GetActivityID(),
		item_id = arg_14_1
	})
	OperationRecorder.RecordButtonTouch({
		source = 2,
		button_name = "activity_autochess_item_homepage_touch",
		activity_id = AutoChessData:GetActivityID(),
		item_id = arg_14_1
	})
end

function AutoChessCardCollectView:Dispose()
	if self.cardUiList_ then
		self.cardUiList_:Dispose()

		self.cardUiList_ = nil
	end

	self.URFactoryItem_:Dispose()
	AutoChessCardCollectView.super.Dispose(self)
end

return AutoChessCardCollectView
