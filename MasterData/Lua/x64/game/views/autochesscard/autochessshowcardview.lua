local AutoChessShowCardView = class("AutoChessShowCardView", ReduxView)

function AutoChessShowCardView:UIName()
	return "Widget/System/Activity_AutoChess_Main/Unpack/Activity_Unpack_SingleDrawUI"
end

function AutoChessShowCardView:UIParent()
	return manager.ui.uiMain.transform
end

function AutoChessShowCardView:Init()
	self:InitUI()
	self:AddListeners()
end

function AutoChessShowCardView:InitUI()
	self:BindCfgUI()

	self.choiceController = self.controller_:GetController("choice")
	self.cardItemList = {}
end

function AutoChessShowCardView:AddListeners()
	self:AddBtnListener(self.skipBtn_, nil, function()
		self:StopTimer()
		JumpTools.OpenPageByJump("autoChessShowCardListPop", {
			mode = self.mode_,
			cardList = self.cardList_
		})
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_gacha_skip",
			activity_id = AutoChessData:GetActivityID()
		})
	end)
end

function AutoChessShowCardView:OnEnter()
	gameContext:SetUrlAndParams("/autoChessOpenCardMainView")

	self.mode_ = self.params_.mode
	self.cardList_ = self.params_.cardList

	if self.mode_ == AutoChessCardConst.OPEN_CARD_MODE_SINGLE then
		self.choiceController:SetSelectedState("CardPanelSingle")
		self:RefreshOneUI()
	else
		self.choiceController:SetSelectedState("CardPanelEven")
		self:RefreshMoreUI()
	end

	self:StopTimer()

	self.timer_ = Timer.New(function()
		JumpTools.OpenPageByJump("autoChessShowCardListPop", {
			mode = self.mode_,
			cardList = self.cardList_
		})
	end, 2, 1)

	self.timer_:Start()
end

function AutoChessShowCardView:RefreshOneUI()
	for iter_9_0, iter_9_1 in ipairs(self.cardList_) do
		if self.cardItemList[iter_9_0] then
			self.cardItemList[iter_9_0]:SetData(iter_9_1)
		else
			local var_9_0 = AutoChessCardItem.New(self.onePanelTrans_:GetChild(iter_9_0 - 1).gameObject)

			var_9_0:SetData(iter_9_1)

			self.cardItemList[iter_9_0] = var_9_0
		end
	end
end

function AutoChessShowCardView:RefreshMoreUI()
	for iter_10_0, iter_10_1 in ipairs(self.cardList_) do
		if self.cardItemList[iter_10_0] then
			self.cardItemList[iter_10_0]:SetData(iter_10_1)
		else
			local var_10_0 = AutoChessCardItem.New(self["morePanelTrans" .. iter_10_0 % 5 + 1 .. "_"]:GetChild(iter_10_0 % 5).gameObject)

			var_10_0:SetData(iter_10_1)

			self.cardItemList[iter_10_0] = var_10_0
		end
	end
end

function AutoChessShowCardView:OnExit()
	self.anim_:Rebind()
end

function AutoChessShowCardView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function AutoChessShowCardView:Dispose()
	self:StopTimer()

	for iter_13_0, iter_13_1 in ipairs(self.cardItemList) do
		iter_13_1:Dispose()
	end

	AutoChessShowCardView.super.Dispose(self)
end

return AutoChessShowCardView
