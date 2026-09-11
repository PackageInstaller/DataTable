local AutoChessOpenCardMainView = class("AutoChessOpenCardMainView", ReduxView)

function AutoChessOpenCardMainView:UIName()
	return "Widget/System/Activity_AutoChess_Main/Unpack/Activity_Unpack_MainUI"
end

function AutoChessOpenCardMainView:UIParent()
	return manager.ui.uiMain.transform
end

function AutoChessOpenCardMainView:Init()
	self:InitUI()
	self:AddListeners()
end

function AutoChessOpenCardMainView:InitUI()
	self:BindCfgUI()

	self.ultraRareItem = AutoChessCardCollectInfoItem.New(self.ultraRareGo_, AutoChessCardConst.CARD_TYPE.UR)
	self.supRareItem = AutoChessCardCollectInfoItem.New(self.superRareGo_, AutoChessCardConst.CARD_TYPE.SR)
	self.normRareItem = AutoChessCardCollectInfoItem.New(self.RareGo_, AutoChessCardConst.CARD_TYPE.R)
	self.item1_ = AutoChessOpenCardItem.New(self.itemGo1_)
	self.item2_ = AutoChessOpenCardItem.New(self.itemGo2_)
	self.tipsController_ = self.controller_:GetController("obtainTips")
end

function AutoChessOpenCardMainView:AddListeners()
	self:AddBtnListener(self.lookDetailBtn_, nil, function()
		self.tipsController_:SetSelectedState("hide")
		JumpTools.OpenPageByJump("autoChessOpenCardInfoPopView")
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_gacha_rules",
			activity_id = AutoChessData:GetActivityID()
		})
	end)
	self:AddBtnListener(self.openOneBtn_, nil, function()
		if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_AUTO_CHESS_CARD_ITEM) < 1 then
			ShowTips(GetTips("AUTO_CHESS_2_INSUFFICIENT_PACK"))

			return
		end

		if self.IsOpen then
			return
		end

		self.IsOpen = true

		self:OnPlayAnimBack(AutoChessCardConst.OPEN_CARD_MODE_SINGLE)
	end)
	self:AddBtnListener(self.opemMoreBtn_, nil, function()
		if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_AUTO_CHESS_CARD_ITEM) < 5 then
			ShowTips(GetTips("AUTO_CHESS_2_INSUFFICIENT_PACK"))

			return
		end

		if self.IsOpen then
			return
		end

		self.IsOpen = true

		self:OnPlayAnimBack(AutoChessCardConst.OPEN_CARD_MODE_MULTI)
	end)
	self:AddBtnListener(self.collectBtn_, nil, function()
		JumpTools.OpenPageByJump("/autoChessCardCollectView")
	end)
	self:AddBtnListener(self.btn1_, nil, function()
		self.tipsController_:SetSelectedState("show")

		self.txtTips_.text = GetTips("AUTO_CHESS_2_SOURCE_EXCHANGE_TIP")
	end)
	self:AddBtnListener(self.btn2_, nil, function()
		self.tipsController_:SetSelectedState("show")

		self.txtTips_.text = GetTips("AUTO_CHESS_2_SOURCE_BATTLE_TIP")
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self.tipsController_:SetSelectedState("hide")
	end)
end

function AutoChessOpenCardMainView:OnPlayAnimBack(arg_13_1)
	self:StopTimer()
	manager.windowBar:HideBar()
	self.tipsController_:SetSelectedState("hide")
	AutoChessCardAction.OpenCard(arg_13_1, function(arg_14_0, arg_14_1)
		AnimatorTools.PlayAnimatorWithCallback(self.anim_, "UI_Activity_Unpack_MainUI_out", function()
			JumpTools.OpenPageByJump("/autoChessOpenCardView", {
				mode = arg_14_0,
				cardList = arg_14_1
			})

			self.IsOpen = false
		end, false, 0, 0)
	end)
end

function AutoChessOpenCardMainView:StopTimer()
	AnimatorTools.Stop()
end

function AutoChessOpenCardMainView:OnEnter()
	self.IsOpen = false

	self.tipsController_:SetSelectedState("hide")
	self:RefreshCardCollection()
	self:RefreshOpenCardItem()
	self:BindRedPoint()
end

function AutoChessOpenCardMainView:RefreshCardCollection()
	self.ultraRareItem:RefreshUI()
	self.supRareItem:RefreshUI()
	self.normRareItem:RefreshUI()
end

function AutoChessOpenCardMainView:RefreshOpenCardItem()
	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_EXCHANGE_CARD) then
		self.item2_:SetData(ActivityConst.ACTIVITY_AUTO_CHESS_EXCHANGE_CARD)
		self.item2_:SetActive(true)
	else
		self.item2_:SetActive(false)
	end

	self.item1_:SetData(ActivityConst.ACTIVITY_AUTO_CHESS_PVP_4_8)
	self.item1_:SetActive(true)
end

function AutoChessOpenCardMainView:OnTop()
	manager.windowBar:SwitchBar({
		HOME_BAR,
		BACK_BAR,
		CurrencyConst.CURRENCY_TYPE_AUTO_CHESS_CARD_ITEM
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_AUTO_CHESS_CARD_ITEM, false)
end

function AutoChessOpenCardMainView:OnExit()
	self.tipsController_:SetSelectedState("hide")

	if AutoChessCardData:GetCardBagPower() >= GameSetting.auto_chess_2_pack_energy_max.value[1] then
		saveData("auto_chess_4_8", "card_power_is_show", 0)
	end

	manager.redPoint:setTip(RedPointConst.AUTO_CHESS_4_8_OPEN_CARD_VIEW, 0)
	manager.windowBar:HideBar()
	self.anim_:Rebind()
	self:UnBindRedPoint()
end

function AutoChessOpenCardMainView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.item1_:GetBtnTransform(), RedPointConst.AUTO_CHESS_4_8_OPEN_CARD_VIEW)
end

function AutoChessOpenCardMainView:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.item1_:GetBtnTransform(), RedPointConst.AUTO_CHESS_4_8_OPEN_CARD_VIEW)
end

function AutoChessOpenCardMainView:Dispose()
	self:StopTimer()
	self.ultraRareItem:Dispose()
	self.supRareItem:Dispose()
	self.normRareItem:Dispose()
	self.item1_:Dispose()
	self.item2_:Dispose()
	AutoChessOpenCardMainView.super.Dispose(self)
end

return AutoChessOpenCardMainView
