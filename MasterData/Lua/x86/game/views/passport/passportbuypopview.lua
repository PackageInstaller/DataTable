local PassportBuyPopView = class("PassportBuyPopView", ReduxView)

function PassportBuyPopView:UIName()
	return "Widget/System/Passport/PassportBuyPopUI"
end

function PassportBuyPopView:UIParent()
	return manager.ui.uiPop.transform
end

function PassportBuyPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PassportBuyPopView:InitUI()
	self:BindCfgUI()

	self.freelist_ = LuaList.New(handler(self, self.indexItem), self.freeListGo_, CommonItemView)
	self.paylist_ = LuaList.New(handler(self, self.indexItem2), self.payListGo_, CommonItemView)
end

function PassportBuyPopView:indexItem(arg_5_1, arg_5_2)
	local var_5_0 = clone(ItemTemplateData)

	arg_5_2:SetData({
		id = self.curfreeList_[arg_5_1].id,
		number = self.curfreeList_[arg_5_1].num,
		clickFun = function(self)
			self:OnItemClick(self.id, self.number, 1)
		end
	})
end

function PassportBuyPopView:indexItem2(arg_7_1, arg_7_2)
	local var_7_0 = clone(ItemTemplateData)

	arg_7_2:SetData({
		id = self.curList_[arg_7_1].id,
		number = self.curList_[arg_7_1].num,
		clickFun = function(self)
			self:OnItemClick(self.id, self.number, 1)
		end
	})
end

function PassportBuyPopView:OnItemClick(arg_9_1, arg_9_2, arg_9_3)
	ShowPopItem(POP_ITEM, {
		arg_9_1,
		arg_9_2
	})
end

function PassportBuyPopView:AddUIListener()
	self:AddBtnListener(self.cancelBtn_, nil, function()
		PassportAction.OneKeyGet()
		self:Back()
	end)
	self:AddBtnListener(self.okBtn_, nil, function()
		JumpTools.OpenPageByJump("/passportBuy")
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function PassportBuyPopView:UpdateBar()
	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
end

function PassportBuyPopView:OnEnter()
	self.level = PassportData:GetLevel()
	self.rewardIdList_ = BattlePassCfg.get_id_list_by_type[BattlePassListCfg[PassportData:GetId()].battlepass_type]
	self.curList_ = {}
	self.curfreeList_ = {}

	for iter_15_0 = 1, self.level do
		self.curList_[#self.curList_ + 1] = {
			id = BattlePassCfg[self.rewardIdList_[iter_15_0]].reward_pay[1][1],
			num = BattlePassCfg[self.rewardIdList_[iter_15_0]].reward_pay[1][2]
		}

		if not PassportData:GetReceiveInfo(self.rewardIdList_[iter_15_0]) then
			self.curfreeList_[#self.curfreeList_ + 1] = {
				id = BattlePassCfg[self.rewardIdList_[iter_15_0]].reward_free[1][1],
				num = BattlePassCfg[self.rewardIdList_[iter_15_0]].reward_free[1][2]
			}
		end
	end

	self.curfreeList_ = mergeReward(self.curfreeList_)
	self.curfreeList_ = sortReward(self.curfreeList_, true)

	self.freelist_:StartScroll(#self.curfreeList_)

	self.curList_ = mergeReward(self.curList_)
	self.curList_ = sortReward(self.curList_, true)

	self.paylist_:StartScroll(#self.curList_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
end

function PassportBuyPopView:OnTop()
	self:UpdateBar()
end

function PassportBuyPopView:Dispose()
	if self.freelist_ then
		self.freelist_:Dispose()

		self.freelist_ = nil
	end

	if self.paylist_ then
		self.paylist_:Dispose()

		self.paylist_ = nil
	end

	PassportBuyPopView.super.Dispose(self)
end

return PassportBuyPopView
