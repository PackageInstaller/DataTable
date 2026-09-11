local AutoChessDesireSelectPopView = class("AutoChessDesireSelectPopView", ReduxView)

function AutoChessDesireSelectPopView:UIName()
	return "Widget/System/Activity_AutoChess_Main/TradingCard/Activity_AutoChess_WishSetPopUI"
end

function AutoChessDesireSelectPopView:UIParent()
	return manager.ui.uiPop.transform
end

function AutoChessDesireSelectPopView:Init()
	self:InitUI()
	self:AddListeners()
end

function AutoChessDesireSelectPopView:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.uiList_, AutoChessCardNumItem)
	self.stateController_ = self.controller_:GetController("state")
	self.wishController_ = self.wishController_:GetController("switch")
	self.btnGreyController_ = self.btnController_:GetController("grey")
	self.data_ = {}
	self.URFactoryItem_ = AutoChessURFactoryItem.New(self.URItemGo_)
end

function AutoChessDesireSelectPopView:IndexItem(arg_5_1, arg_5_2)
	local var_5_0 = self.canSelectList_[arg_5_1]

	arg_5_2:SetData(self.canSelectList_[arg_5_1], table.indexof(self.selectList_, self.canSelectList_[arg_5_1]) ~= false, self.URFactoryItem_:GetItem(self.canSelectList_[arg_5_1]))
	arg_5_2:SetSelectHandler(handler(self, self.OnSelectItem))

	if self.params_.mode == 1 then
		if AutoChessCardData:GetCardNum(var_5_0) > 0 then
			arg_5_2:SetOwnNumState("hide")
		else
			arg_5_2:SetOwnNumState("none")
		end
	else
		arg_5_2:SetOwnNumState("own")
	end
end

function AutoChessDesireSelectPopView:OnSelectItem(arg_6_1, arg_6_2)
	if arg_6_1 then
		if (self.params_.mode == 1 and 1 or 3) <= #self.selectList_ then
			table.remove(self.selectList_, 1)
			table.insert(self.selectList_, arg_6_2)
		else
			table.insert(self.selectList_, arg_6_2)
		end
	else
		table.remove(self.selectList_, table.indexof(self.selectList_, arg_6_2))
	end

	self.list_:Refresh()
	self:RefreshSelectNum()
end

function AutoChessDesireSelectPopView:AddListeners()
	self:AddBtnListener(self.maskBtn_, nil, function()
		return
	end)
	self:AddBtnListener(self.okBtn_, nil, function()
		if self.okhandle then
			self.okhandle()
		end
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		JumpTools.OpenPageByJump("autoChessEditDesireDatailPopView", {
			type = self.params_.mode,
			selectList = self.params_.selectCard
		})
	end)
	self:AddBtnListener(self.closeBtn_, nil, function()
		JumpTools.OpenPageByJump("autoChessEditDesireDatailPopView", {
			type = self.params_.mode,
			selectList = self.params_.selectCard
		})
	end)
	self:AddBtnListener(self.uRBtn_, nil, function()
		if self.rareType_ == AutoChessCardConst.CARD_TYPE.UR then
			return
		end

		self:RefreshRareList(AutoChessCardConst.CARD_TYPE.UR)
	end)
	self:AddBtnListener(self.rBtn_, nil, function()
		if self.rareType_ == AutoChessCardConst.CARD_TYPE.R then
			return
		end

		self:RefreshRareList(AutoChessCardConst.CARD_TYPE.R)
	end)
	self:AddBtnListener(self.srBtn_, nil, function()
		if self.rareType_ == AutoChessCardConst.CARD_TYPE.SR then
			return
		end

		self:RefreshRareList(AutoChessCardConst.CARD_TYPE.SR)
	end)
end

function AutoChessDesireSelectPopView:OnEnter()
	self.selectList_ = {}

	for iter_15_0, iter_15_1 in ipairs(self.params_.selectCard) do
		table.insert(self.selectList_, iter_15_1)
	end

	self:RefreshUI()
end

function AutoChessDesireSelectPopView:onChangeMyCard()
	if #self.selectList_ ~= 1 then
		return
	end

	JumpTools.OpenPageByJump("autoChessEditDesireDatailPopView", {
		type = self.params_.mode,
		selectList = self.selectList_
	})
end

function AutoChessDesireSelectPopView:onChangeOtherCard()
	if #self.selectList_ < 1 or #self.selectList_ > 3 then
		return
	end

	JumpTools.OpenPageByJump("autoChessEditDesireDatailPopView", {
		type = self.params_.mode,
		selectList = self.selectList_
	})
end

function AutoChessDesireSelectPopView:RefreshSelectNum()
	if self.params_.mode == 1 then
		if #self.selectList_ == 1 then
			self.btnGreyController_:SetSelectedState("normal")
		else
			self.btnGreyController_:SetSelectedState("grey")
		end

		self.txtWish_.text = #self.selectList_ .. " / " .. 1
	else
		if #self.selectList_ < 1 or #self.selectList_ > 3 then
			self.btnGreyController_:SetSelectedState("grey")
		else
			self.btnGreyController_:SetSelectedState("normal")
		end

		self.txtOffer_.text = #self.selectList_ .. " / " .. 3
	end
end

function AutoChessDesireSelectPopView:RefreshUI()
	self:RefreshSelectNum()

	self.txtUR_.text = GetTips(AutoChessCardConst.CARD_TYPE_TIPS[AutoChessCardConst.CARD_TYPE.UR])
	self.txtSR_.text = GetTips(AutoChessCardConst.CARD_TYPE_TIPS[AutoChessCardConst.CARD_TYPE.SR])
	self.txtR_.text = GetTips(AutoChessCardConst.CARD_TYPE_TIPS[AutoChessCardConst.CARD_TYPE.R])

	if self.params_.mode == 1 then
		self.stateController_:SetSelectedState("setWish")

		self.okhandle = handler(self, self.onChangeMyCard)

		self:RefreshRareList((AutoChessCardCfg[self.selectList_[1]] or nil) and (AutoChessCardCfg[self.selectList_[1]].type or AutoChessCardConst.CARD_TYPE.UR))
	else
		self.stateController_:SetSelectedState("setOffer")

		self.okhandle = handler(self, self.onChangeOtherCard)
		self.canSelectList_ = {}

		local var_19_0 = AutoChessCardData:GetDesireInfo()

		for iter_19_0, iter_19_1 in pairs((AutoChessCardData:GetCardList())) do
			if table.indexof(var_19_0.CardList, iter_19_0) then
				iter_19_1 = iter_19_1 + 1
			end

			if iter_19_1 > 1 and AutoChessCardCfg[iter_19_0].type == AutoChessCardCfg[self.params_.myCardId].type and self.params_.myCardId ~= iter_19_0 then
				table.insert(self.canSelectList_, iter_19_0)
			end
		end

		self.list_:StartScroll(#self.canSelectList_, self.selectList_[1] and table.indexof(self.canSelectList_, self.selectList_[1]) or 1)
	end
end

function AutoChessDesireSelectPopView:RefreshRareList(arg_20_1)
	self.rareType_ = arg_20_1

	self.wishController_:SetSelectedIndex(self.rareType_ - 1)

	self.canSelectList_ = {}

	for iter_20_0, iter_20_1 in ipairs(AutoChessCardCfg.get_id_list_by_type_is_card_pool[self.rareType_][1]) do
		table.insert(self.canSelectList_, iter_20_1)
	end

	table.sort(self.canSelectList_, function(arg_21_0, arg_21_1)
		if AutoChessCardData:GetCardNum(arg_21_0) == AutoChessCardData:GetCardNum(arg_21_1) then
			return arg_21_0 < arg_21_1
		end

		return AutoChessCardData:GetCardNum(arg_21_0) < AutoChessCardData:GetCardNum(arg_21_1)
	end)
	self.list_:StartScroll(#self.canSelectList_, self.selectList_[1] and table.indexof(self.canSelectList_, self.selectList_[1]) or 1)
end

function AutoChessDesireSelectPopView:OnExit()
	return
end

function AutoChessDesireSelectPopView:Dispose()
	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	self.URFactoryItem_:Dispose()
	AutoChessDesireSelectPopView.super.Dispose(self)
end

return AutoChessDesireSelectPopView
