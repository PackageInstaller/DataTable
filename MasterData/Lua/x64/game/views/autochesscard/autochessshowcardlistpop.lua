local AutoChessShowCardListPop = class("AutoChessShowCardListPop", ReduxView)

function AutoChessShowCardListPop:UIName()
	return "Widget/System/Activity_AutoChess_Main/Unpack/Activity_Unpack_ObtainPopUI"
end

function AutoChessShowCardListPop:UIParent()
	return manager.ui.uiPop.transform
end

function AutoChessShowCardListPop:Init()
	self:InitUI()
	self:AddListeners()
end

function AutoChessShowCardListPop:InitUI()
	self:BindCfgUI()

	self.onelist_ = LuaList.New(handler(self, self.IndexItem), self.oneUIList_, AutoChessCardItem)
	self.moreList_ = LuaList.New(handler(self, self.IndexItem), self.moreUIList_, AutoChessCardItem)
	self.URFactoryItem_ = AutoChessURFactoryItem.New(self.URItemGo_)
	self.switchController_ = self.controller_:GetController("switch")
end

function AutoChessShowCardListPop:IndexItem(arg_5_1, arg_5_2)
	local var_5_0 = 0

	if self.mode_ == AutoChessCardConst.OPEN_CARD_MODE_MULTI then
		var_5_0 = self.mergeCardList_[arg_5_1]

		arg_5_2:SetData(self.mergeCardList_[arg_5_1], self.URFactoryItem_:GetItem(self.mergeCardList_[arg_5_1]))

		if self.mergeCardNumList_[self.mergeCardList_[arg_5_1]] > 1 then
			arg_5_2:SetCollapseState(true, self.mergeCardNumList_[self.mergeCardList_[arg_5_1]])
		else
			arg_5_2:SetCollapseState(false)
		end
	else
		var_5_0 = self.cardList[arg_5_1]

		arg_5_2:SetData(self.cardList[arg_5_1], self.URFactoryItem_:GetItem(self.cardList[arg_5_1]))
		arg_5_2:SetCollapseState(false)
	end

	if AutoChessCardData:GetCardNum(var_5_0) - self.mergeCardNumList_[var_5_0] > 0 then
		arg_5_2:SetNewTagState(false)
	else
		arg_5_2:SetNewTagState(true)
	end
end

function AutoChessShowCardListPop:AddListeners()
	self:AddBtnListener(self.maskBtn_, nil, function()
		if self.mode_ == AutoChessCardConst.MIX_CARD_TYPE then
			self:Back()
		else
			JumpTools.OpenPageByJump("/autoChessOpenCardMainView")
		end
	end)
	self:AddBtnListener(self.shareBtn_, nil, function()
		manager.share:Share(function()
			SetActive(self.shareBtn_, false)
			SetActive(self.tipsGo_, false)
		end, function()
			SetActive(self.shareBtn_, true)
			SetActive(self.tipsGo_, true)
		end)
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_gacha_share",
			activity_id = AutoChessData:GetActivityID(),
			item_list = string.format("[%s]", table.concat(self.cardList, ","))
		})
	end)
	self:AddBtnListener(self.closeBtn_, nil, function()
		if self.mode_ == AutoChessCardConst.MIX_CARD_TYPE then
			self:Back()
		else
			JumpTools.OpenPageByJump("/autoChessOpenCardMainView")
		end
	end)
end

function AutoChessShowCardListPop:OnEnter()
	self.cardList = self.params_.cardList
	self.mode_ = self.params_.mode

	table.sort(self.cardList, function(arg_13_0, arg_13_1)
		local var_13_0 = AutoChessCardCfg[arg_13_0]
		local var_13_1 = AutoChessCardCfg[arg_13_1]

		if AutoChessCardCfg[arg_13_0].type == AutoChessCardCfg[arg_13_1].type then
			return arg_13_1 < arg_13_0
		end

		return var_13_0.type > var_13_1.type
	end)

	if self.mode_ == AutoChessCardConst.OPEN_CARD_MODE_SINGLE then
		self.switchController_:SetSelectedIndex(0)
		self:MergeCard()
		self.onelist_:StartScroll(#self.cardList)
	elseif self.mode_ == AutoChessCardConst.MIX_CARD_TYPE then
		self.switchController_:SetSelectedIndex(0)
		self:MergeCard()
		self.onelist_:StartScroll(#self.cardList)
	else
		self.switchController_:SetSelectedIndex(1)
		self:MergeCard()
		self.moreList_:StartScroll(#self.mergeCardList_)
	end
end

function AutoChessShowCardListPop:MergeCard()
	self.mergeCardList_ = {}
	self.mergeCardNumList_ = {}

	for iter_14_0, iter_14_1 in ipairs(self.cardList) do
		if table.indexof(self.mergeCardList_, iter_14_1) then
			self.mergeCardNumList_[iter_14_1] = self.mergeCardNumList_[iter_14_1] + 1
		else
			table.insert(self.mergeCardList_, iter_14_1)

			self.mergeCardNumList_[iter_14_1] = 1
		end
	end
end

function AutoChessShowCardListPop:Dispose()
	if self.onelist_ then
		self.onelist_:Dispose()

		self.onelist_ = nil
	end

	if self.moreList_ then
		self.moreList_:Dispose()

		self.moreList_ = nil
	end

	self.URFactoryItem_:Dispose()
	AutoChessShowCardListPop.super.Dispose(self)
end

return AutoChessShowCardListPop
