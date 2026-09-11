local IdolTraineeQuestRankSelectView = class("IdolTraineeQuestRankSelectView", ReduxView)

function IdolTraineeQuestRankSelectView:UIName()
	return "Widget/BackHouseUI/IdolTrainee/IdolTraineeQuestRankSelect"
end

function IdolTraineeQuestRankSelectView:UIParent()
	return manager.ui.uiPop.transform
end

function IdolTraineeQuestRankSelectView:Init()
	self:InitUI()
	self:AddUIListener()
end

function IdolTraineeQuestRankSelectView:InitUI()
	self:BindCfgUI()

	self.okBtnController_ = self.controllerEx_:GetController("btn")
	self.noneController_ = self.controllerEx_:GetController("none")
	self.ItemUIList_ = LuaList.New(handler(self, self.RefreshItem), self.uiList_, CommonItemView)
end

function IdolTraineeQuestRankSelectView:AddUIListener()
	self:AddBtnListener(self.okBtn_, nil, function()
		local var_6_0 = {}

		for iter_6_0, iter_6_1 in pairs(self.selectDic_) do
			if iter_6_1 ~= 0 then
				table.insert(var_6_0, {
					id = iter_6_0,
					num = iter_6_1
				})
			end
		end

		IdolTraineeAction.GetQuestRankReward(self.rank_, var_6_0, function()
			self:Back()
		end)
	end)
	self:AddBtnListener(self.retBtn_, nil, function()
		JumpTools.OpenPageByJump("/dormChooseRoomView")
	end)
end

function IdolTraineeQuestRankSelectView:OnEnter()
	self.rank_ = self.params_.rank
	self.dataList_ = IdolTraineeRewardRankCfg[self.rank_].reward

	table.sort(self.dataList_, function(arg_10_0, arg_10_1)
		local var_10_0 = self:GetHeroLock(arg_10_1)

		if self:GetHeroLock(arg_10_0) == var_10_0 then
			return arg_10_0 < arg_10_1
		else
			return var_10_0
		end
	end)

	self.maxNum_ = IdolTraineeRewardRankCfg[self.rank_].num
	self.selectDic_ = {}
	self.selectNum_ = 0

	self.ItemUIList_:StartScroll(#self.dataList_)
	self.noneController_:SetSelectedState("true")
	self.okBtnController_:SetSelectedState("state1")

	for iter_9_0, iter_9_1 in ipairs(self.dataList_) do
		if not self:GetHeroLock(iter_9_1) then
			self.noneController_:SetSelectedState("false")
			self.okBtnController_:SetSelectedState("state0")

			break
		end
	end

	self:UpdatePreview()
end

function IdolTraineeQuestRankSelectView:RefreshItem(arg_11_1, arg_11_2)
	local var_11_0 = self.dataList_[arg_11_1]
	local var_11_1 = self:GetHeroLock(self.dataList_[arg_11_1])
	local var_11_2 = clone(ItemTemplateData)

	var_11_2.id = self.dataList_[arg_11_1]
	var_11_2.locked = var_11_1
	var_11_2.topAmountValue = self.selectDic_[self.dataList_[arg_11_1]] or 0

	function var_11_2.clickFun(arg_12_0)
		if var_11_1 then
			return false
		end

		self:AddSelect(var_11_0)
		arg_11_2:RefreshTopAmount(self.selectDic_[var_11_0])
		self:UpdatePreview()

		return true
	end

	function var_11_2.clickAmountFun(arg_13_0)
		if var_11_1 then
			return false
		end

		self:DeleteSelect(var_11_0)
		arg_11_2:RefreshTopAmount(self.selectDic_[var_11_0])
		self:UpdatePreview()

		return true
	end

	arg_11_2:SetData(var_11_2)
end

function IdolTraineeQuestRankSelectView:AddSelect(arg_14_1)
	if self.selectNum_ >= self.maxNum_ then
		return
	end

	self.selectDic_[arg_14_1] = self.selectDic_[arg_14_1] or 0
	self.selectDic_[arg_14_1] = self.selectDic_[arg_14_1] + 1
	self.selectNum_ = self.selectNum_ + 1
end

function IdolTraineeQuestRankSelectView:DeleteSelect(arg_15_1)
	if self.selectNum_ <= 0 or not self.selectDic_[arg_15_1] or self.selectDic_[arg_15_1] <= 0 then
		return
	end

	self.selectDic_[arg_15_1] = self.selectDic_[arg_15_1] - 1
	self.selectNum_ = self.selectNum_ - 1
end

function IdolTraineeQuestRankSelectView:UpdatePreview()
	self.numText_.text = self.selectNum_ .. "/" .. self.maxNum_

	self.okBtnController_:SetSelectedState(self.selectNum_ == self.maxNum_ and "state1" or "state0")
end

function IdolTraineeQuestRankSelectView:GetHeroLock(arg_17_1)
	return not HeroTools.GetHeroIsUnlock(arg_17_1 - 10000)
end

function IdolTraineeQuestRankSelectView:OnExit()
	self.selectInex_ = 0
	self.selectNum_ = 0
	self.lastSelectItem_ = nil
end

function IdolTraineeQuestRankSelectView:Dispose()
	self.ItemUIList_:Dispose()
	IdolTraineeQuestRankSelectView.super.Dispose(self)
end

return IdolTraineeQuestRankSelectView
