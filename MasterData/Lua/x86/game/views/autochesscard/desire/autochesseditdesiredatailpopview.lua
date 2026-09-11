local AutoChessEditDesireDatailPopView = class("AutoChessEditDesireDatailPopView", ReduxView)

function AutoChessEditDesireDatailPopView:UIName()
	return "Widget/System/Activity_AutoChess_Main/TradingCard/Activity_AutoChess_WishPopUI"
end

function AutoChessEditDesireDatailPopView:UIParent()
	return manager.ui.uiPop.transform
end

function AutoChessEditDesireDatailPopView:Init()
	self:BindCfgUI()
	self:InitUI()
	self:AddListeners()
end

function AutoChessEditDesireDatailPopView:InitUI()
	self.needDesireItem_ = AutoChessDesireItem.New(self.cardGo_)
	self.desireItemList_ = {}

	for iter_4_0 = 1, 3 do
		table.insert(self.desireItemList_, AutoChessDesireItem.New(self["cardGo" .. iter_4_0 .. "_"]))
	end

	self.okHandler_ = nil
	self.cancelHandler_ = nil
	self.popStateController_ = self.controller_:GetController("popState")
	self.dropDownController_ = self.controller_:GetController("dropDown")
	self.btnGreyController_ = self.btnController_:GetController("grey")
	self.desireBlessItemList_ = {}

	for iter_4_1, iter_4_2 in ipairs(GameSetting.auto_chess_2_wish_texts.value) do
		local var_4_0 = AutoChessDesireBlessItem.New(Object.Instantiate(self.blessGo_, self.blessTrans_), handler(self, self.onSelectBlessItem))

		var_4_0:SetData(iter_4_2)
		var_4_0:SetActive(true)
		table.insert(self.desireBlessItemList_, var_4_0)
	end

	self.URFactoryItem_ = AutoChessURFactoryItem.New(self.URItemGo_)
end

function AutoChessEditDesireDatailPopView:onSelectBlessItem(arg_5_1)
	self.dropDownController_:SetSelectedState("hide")

	self.txtSelectBless_.text = GetTips(arg_5_1)

	if self.mode_ then
		self.context.selectBlessId = arg_5_1
	else
		self.context.blessId = arg_5_1
	end
end

function AutoChessEditDesireDatailPopView:BuildContext(arg_6_1)
	local var_6_0 = {
		playerId = arg_6_1.PlayerID,
		cardId = arg_6_1.CardID
	}

	if arg_6_1.BlessID == 0 then
		var_6_0.blessId = GameSetting.auto_chess_2_wish_texts.value[1] or arg_6_1.BlessID
	end

	local var_6_1 = {}

	var_6_1[1] = arg_6_1.CardList[1] or 0
	var_6_1[2] = arg_6_1.CardList[2] or 0
	var_6_1[3] = arg_6_1.CardList[3] or 0
	var_6_0.otherList = var_6_1
	self.context = var_6_0
end

function AutoChessEditDesireDatailPopView:AddListeners()
	self:AddBtnListener(self.okBtn_, nil, function()
		if self.okHandler_ then
			self.okHandler_()
		end
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		if self.cancelHandler_ then
			self.cancelHandler_()
		end
	end)
	self:AddBtnListener(self.addMyBtn_, nil, function()
		if self.addMyBtnHandle_ then
			self.addMyBtnHandle_()
		end
	end)
	self:AddBtnListener(self.addNeedBtn1_, nil, function()
		if self.addNeedBtn1Handle_ then
			self.addNeedBtn1Handle_()
		end
	end)
	self:AddBtnListener(self.addNeedBtn2_, nil, function()
		if self.addNeedBtn2Handle_ then
			self.addNeedBtn2Handle_()
		end
	end)
	self:AddBtnListener(self.addNeedBtn3_, nil, function()
		if self.addNeedBtn3Handle_ then
			self.addNeedBtn3Handle_()
		end
	end)
	self:AddBtnListener(self.openSelectBtn_, nil, function()
		if self.dropDownController_:GetSelectedState() == "show" then
			self.dropDownController_:SetSelectedState("hide")
		else
			self.dropDownController_:SetSelectedState("show")

			for iter_14_0, iter_14_1 in ipairs(self.desireBlessItemList_) do
				if self.mode_ then
					iter_14_1:SetState(self.context.selectBlessId)
				else
					iter_14_1:SetState(self.context.blessId)
				end
			end
		end
	end)
end

function AutoChessEditDesireDatailPopView:OnExit()
	self.dropDownController_:SetSelectedState("hide")
end

function AutoChessEditDesireDatailPopView:OnEnter()
	self.onUpdateSelectCard = nil

	local var_16_0 = AutoChessCardData:GetDesireInfo()

	self.popStateController_:SetSelectedState("myWish")

	self.okHandler_ = handler(self, function()
		self:onEditConfirmDesire(var_16_1)
	end)
	self.cancelHandler_ = handler(self, self.OnCancelDesire)
	self.addMyBtnHandle_ = handler(self, self.OnAddMyCard)
	self.addNeedBtn1Handle_ = handler(self, self.OnAddProvideCard)
	self.addNeedBtn2Handle_ = handler(self, self.OnAddProvideCard)
	self.addNeedBtn3Handle_ = handler(self, self.OnAddProvideCard)

	self.needDesireItem_:SetOwnNumState(0)
	self:UpdateDesireInfo(var_16_0)

	self.txtSelectBless_.text = GetTips(self.context.blessId)
end

function AutoChessEditDesireDatailPopView:OnTop()
	if self.onUpdateSelectCard then
		self.onUpdateSelectCard()
		self:RefreshUI()
	end

	if self.params_.type == 2 then
		for iter_18_0 = 1, 3 do
			if self.context.otherList[iter_18_0] ~= 0 and not table.indexof(self.oldOtherList, self.context.otherList[iter_18_0]) then
				self.desireItemList_[iter_18_0]:PlayAnim()
			end
		end
	end
end

function AutoChessEditDesireDatailPopView:UpdateDesireInfo(arg_19_1)
	self:BuildContext(arg_19_1)
	self:RefreshUI()
end

function AutoChessEditDesireDatailPopView:UpdateMyCard()
	if self.params_.selectList == nil or #self.params_.selectList == 0 then
		return
	end

	self.context.cardId = self.params_.selectList[1]

	local var_20_0 = AutoChessCardCfg[self.context.cardId]

	if AutoChessCardData:GetCardNum(self.context.cardId) > 0 then
		self.needDesireItem_:SetOwnNumState(0)
	else
		self.needDesireItem_:SetOwnNumState(1)
	end

	if self.context.otherList[1] ~= 0 and AutoChessCardCfg[self.context.otherList[1]].type ~= var_20_0.type then
		self.context.otherList[1] = 0
		self.context.otherList[2] = 0
		self.context.otherList[3] = 0
	end
end

function AutoChessEditDesireDatailPopView:UpdateOtherCard()
	if self.params_.selectList == nil or #self.params_.selectList == 0 then
		return
	end

	self.oldOtherList = {}

	for iter_21_0, iter_21_1 in ipairs(self.context.otherList) do
		if iter_21_1 ~= 0 then
			table.insert(self.oldOtherList, iter_21_1)
		end

		self.context.otherList[iter_21_0] = self.params_.selectList[iter_21_0] and self.params_.selectList[iter_21_0] or 0
	end
end

function AutoChessEditDesireDatailPopView:RefreshUI()
	self.txtBless_.text = GetTips(self.context.blessId)

	local var_22_0 = self.mode_ ~= AutoChessCardConst.DESIRE_TYPE.MY

	self.needDesireItem_:SetData(self.context.cardId, self.URFactoryItem_:GetItem(self.context.cardId))
	self.needDesireItem_:SetWishState(0)

	if self.context.cardId == 0 then
		self.needDesireItem_:SetEmptyState(1)
	else
		self.needDesireItem_:SetEmptyState(0)
	end

	for iter_22_0 = 1, 3 do
		self.desireItemList_[iter_22_0]:SetOwnNumState(0)
		self.desireItemList_[iter_22_0]:SetSelectState(false)
		self.desireItemList_[iter_22_0]:SetData(self.context.otherList[iter_22_0], self.URFactoryItem_:GetItem(self.context.otherList[iter_22_0]))
		self.desireItemList_[iter_22_0]:RefreshWishState(var_22_0)
		self.desireItemList_[iter_22_0]:SetActive(true)

		if self.context.otherList[iter_22_0] == 0 then
			if self.context.cardId == 0 then
				self.desireItemList_[iter_22_0]:SetEmptyState(2)
			else
				self.desireItemList_[iter_22_0]:SetEmptyState(1)
			end
		else
			self.desireItemList_[iter_22_0]:SetEmptyState(0)
		end
	end

	if self.context.cardId == 0 then
		self.btnGreyController_:SetSelectedState("grey")

		return
	end

	if self.context.otherList[1] == 0 and self.context.otherList[2] == 0 and self.context.otherList[3] == 0 then
		self.btnGreyController_:SetSelectedState("grey")

		return
	end

	self.btnGreyController_:SetSelectedState("normal")
end

function AutoChessEditDesireDatailPopView:onEditConfirmDesire(arg_23_1)
	if self.context.cardId == 0 then
		return
	end

	if self.context.blessId == 0 then
		return
	end

	if self.context.otherList[1] == 0 and self.context.otherList[2] == 0 and self.context.otherList[3] == 0 then
		return
	end

	AutoChessCardAction.EditDesire(arg_23_1, self.context)
end

function AutoChessEditDesireDatailPopView:OnCancelDesire()
	self:Back()
end

function AutoChessEditDesireDatailPopView:OnAddMyCard()
	self.dropDownController_:SetSelectedState("hide")

	self.onUpdateSelectCard = handler(self, self.UpdateMyCard)

	if self.context.cardId == 0 then
		JumpTools.OpenPageByJump("autoChessDesireSelectPopView", {
			mode = 1,
			selectCard = {}
		})
	else
		JumpTools.OpenPageByJump("autoChessDesireSelectPopView", {
			mode = 1,
			selectCard = {
				self.context.cardId
			}
		})
	end
end

function AutoChessEditDesireDatailPopView:OnAddProvideCard()
	self.dropDownController_:SetSelectedState("hide")

	if self.context.cardId == 0 then
		ShowTips(GetTips("AUTO_CHESS_2_WISH_UNSET"))

		return
	end

	self.onUpdateSelectCard = handler(self, self.UpdateOtherCard)

	local var_26_0 = {}

	for iter_26_0, iter_26_1 in pairs(self.context.otherList) do
		if iter_26_1 ~= 0 then
			table.insert(var_26_0, iter_26_1)
		end
	end

	JumpTools.OpenPageByJump("autoChessDesireSelectPopView", {
		mode = 2,
		selectCard = var_26_0,
		myCardId = self.context.cardId
	})
end

function AutoChessEditDesireDatailPopView:Dispose()
	for iter_27_0, iter_27_1 in ipairs(self.desireBlessItemList_) do
		iter_27_1:Dispose()
	end

	self.needDesireItem_:Dispose()

	for iter_27_2 = 1, 3 do
		self.desireItemList_[iter_27_2]:Dispose()
	end

	self.URFactoryItem_:Dispose()
	AutoChessEditDesireDatailPopView.super.Dispose(self)
end

return AutoChessEditDesireDatailPopView
