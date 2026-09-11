local PassportShowRewardView = class("PassportShowRewardView", ReduxView)

function PassportShowRewardView:UIName()
	return "Widget/System/Passport/PassportRewardUI"
end

function PassportShowRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function PassportShowRewardView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PassportShowRewardView:InitUI()
	self:BindCfgUI()

	self.itemViewList = {}
	self.normalController = ControllerUtil.GetController(self.gameObject_.transform, "contract")
	self.lockController = ControllerUtil.GetController(self.gameObject_.transform, "lock")
	self.normalList = LuaList.New(handler(self, self.NormalIndexItem), self.list1Go_, CommonItemView)
	self.payList = LuaList.New(handler(self, self.PayIndexItem), self.list2Go_, CommonItemView)
end

function PassportShowRewardView:NormalIndexItem(arg_5_1, arg_5_2)
	CommonTools.SetCommonData(arg_5_2, {
		id = self.normalRewardList[arg_5_1].id,
		number = self.normalRewardList[arg_5_1].number,
		clickFun = function(self)
			ShowPopItem(POP_OTHER_ITEM, {
				self.id
			})
		end
	})
end

function PassportShowRewardView:PayIndexItem(arg_7_1, arg_7_2)
	CommonTools.SetCommonData(arg_7_2, {
		id = self.payRewardList[arg_7_1].id,
		number = self.payRewardList[arg_7_1].number,
		clickFun = function(self)
			ShowPopItem(POP_OTHER_ITEM, {
				self.id
			})
		end
	})
end

function PassportShowRewardView:AddUIListener()
	self:AddBtnListener(self.unlockBtn_, nil, function()
		self:Back()
		JumpTools.OpenPageByJump("/passportBuy")
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function PassportShowRewardView:UpdateView()
	self.rewardIdList_ = BattlePassCfg.get_id_list_by_type[BattlePassListCfg[PassportData:GetId()].battlepass_type]

	self.normalController:SetSelectedState(self.type == 2 and "expand2" or "base")

	self.nameTxt_.text = GetTips(self.type == 1 and "BATTLEPASS_FREE" or "BATTLEPASS_CHARGE")

	if self.type == 2 and PassportData:GetLevel() > 0 and PassportData:GetPayLevel() <= 0 and not self.isPassPortBuy then
		self.normalController:SetSelectedState("expand")

		self.nameTxt_.text = GetTips("BATTLEPASS_CHARGE")
	end

	self.lockController:SetSelectedState((PassportData:GetPayLevel() > 0 or self.type == 1 or self.isPassPortBuy) and "unlock" or "lock")

	if self.type == 2 then
		self.payRewardList = self:GetPayList()

		self.payList:StartScroll(#self.payRewardList)
	end

	self.normalRewardList = self:GetNormalList()

	self.normalList:StartScroll(#self.normalRewardList)
end

function PassportShowRewardView:GetNormalList()
	local var_13_0 = {}
	local var_13_1 = {}

	for iter_13_0 = 1, PassportData:GetMaxLevel() do
		var_13_0[BattlePassCfg[self.rewardIdList_[iter_13_0]]["reward_" .. (self.type == 1 and "free" or "pay")][1][1]] = (var_13_0[BattlePassCfg[self.rewardIdList_[iter_13_0]]["reward_" .. (self.type == 1 and "free" or "pay")][1][1]] or 0) + BattlePassCfg[self.rewardIdList_[iter_13_0]]["reward_" .. (self.type == 1 and "free" or "pay")][1][2]
	end

	for iter_13_1, iter_13_2 in pairs(var_13_0) do
		table.insert(var_13_1, {
			id = iter_13_1,
			number = iter_13_2
		})
	end

	table.sort(var_13_1, function(arg_14_0, arg_14_1)
		if ItemCfg[arg_14_0.id].rare ~= ItemCfg[arg_14_1.id].rare then
			return ItemCfg[arg_14_0.id].rare > ItemCfg[arg_14_1.id].rare
		end

		return arg_14_0.id > arg_14_1.id
	end)

	return var_13_1
end

function PassportShowRewardView:GetPayList()
	local var_15_0 = PassportData:GetLevel()

	if var_15_0 == 0 then
		return {}
	end

	local var_15_1 = {}
	local var_15_2 = {}

	for iter_15_0 = 1, var_15_0 do
		var_15_1[BattlePassCfg[self.rewardIdList_[iter_15_0]].reward_pay[1][1]] = (var_15_1[BattlePassCfg[self.rewardIdList_[iter_15_0]].reward_pay[1][1]] or 0) + BattlePassCfg[self.rewardIdList_[iter_15_0]].reward_pay[1][2]
	end

	for iter_15_1, iter_15_2 in pairs(var_15_1) do
		table.insert(var_15_2, {
			id = iter_15_1,
			number = iter_15_2
		})
	end

	table.sort(var_15_2, function(arg_16_0, arg_16_1)
		if ItemCfg[arg_16_0.id].rare ~= ItemCfg[arg_16_1.id].rare then
			return ItemCfg[arg_16_0.id].rare > ItemCfg[arg_16_1.id].rare
		end

		return arg_16_0.id > arg_16_1.id
	end)

	return var_15_2
end

function PassportShowRewardView:OnEnter()
	self.type = self.params_.type
	self.isPassPortBuy = self.params_.isPassPortBuy
	self.params_.isPassPortBuy = nil

	self:UpdateView()
end

function PassportShowRewardView:OnExploreUpdate()
	self:UpdateView()
end

function PassportShowRewardView:Dispose()
	PassportShowRewardView.super.Dispose(self)

	if self.normalList then
		self.normalList:Dispose()

		self.normalList = nil
	end

	if self.payList then
		self.payList:Dispose()

		self.payList = nil
	end

	Object.Destroy(self.gameObject_)
end

return PassportShowRewardView
