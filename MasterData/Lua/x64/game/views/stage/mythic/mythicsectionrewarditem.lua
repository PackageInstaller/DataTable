local MythicSectionRewardItem = class("MythicSectionRewardItem", ReduxView)
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2

function MythicSectionRewardItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.rewardIndex_ = arg_1_2

	self:Init()
end

function MythicSectionRewardItem:Init()
	self:InitUI()
	self:AddListeners()
end

function MythicSectionRewardItem:InitUI()
	self:BindCfgUI()

	self.rewardItemList_ = {}

	for iter_3_0 = 1, 3 do
		self.rewardItemList_[iter_3_0] = CommonItemView.New(self["rewardItem" .. iter_3_0 .. "_"])
	end
end

function MythicSectionRewardItem:AddListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if self.rewardState_ == var_0_2 then
			if MythicData:GetStarRewardCount() == 0 then
				ShowMessageBox({
					content = GetTips("MYTHIC_REWARD_LOACK_DIFFICULTY"),
					OkCallback = function()
						MythicAction.QueryMythicStar(self.rewardIndex_)
					end
				})
			else
				MythicAction.QueryMythicStar(self.rewardIndex_)
			end
		end
	end)
end

function MythicSectionRewardItem:SetData(arg_7_1)
	self:RefreshData(arg_7_1)
	self:RefreshUI()
	self:RefreshState()
	self:RefreshItem()
end

function MythicSectionRewardItem:RefreshData(arg_8_1)
	self.difficulty_ = arg_8_1
	self.rewradCfg_ = getRewardFromDropCfg(MythicNormalCfg[self.difficulty_].star_reward_list[self.rewardIndex_] or 0, true)
	self.curStarCnt_ = MythicData:GetStarCount()
	self.totalStarCnt_ = self.rewardIndex_

	self:GetRewardState()
end

function MythicSectionRewardItem:GetRewardState()
	self.rewardState_ = self.curStarCnt_ < self.totalStarCnt_ and var_0_1 or MythicData:GetStarRewardState(self.rewardIndex_) and var_0_3 or var_0_2
end

function MythicSectionRewardItem:RefreshUI()
	self.progressCntText_.text = self.totalStarCnt_

	local var_10_1

	if self.curStarCnt_ > self.totalStarCnt_ then
		var_10_1 = self.totalStarCnt_ or self.curStarCnt_
	end

	self.progressText_.text = string.format("%s/%s", var_10_1, self.totalStarCnt_)
	self.progressBar_.normalizedValue = var_10_1 / self.totalStarCnt_
end

function MythicSectionRewardItem:RefreshState()
	SetActive(self.mask_, self.rewardState_ == var_0_3)
	SetActive(self.unlockGo_, self.rewardState_ == var_0_1)
	SetActive(self.receiveBtnGo_, self.rewardState_ == var_0_2)
end

function MythicSectionRewardItem:RefreshItem()
	for iter_12_0, iter_12_1 in pairs(self.rewradCfg_) do
		if iter_12_0 > 3 then
			return
		end

		local var_12_0 = rewardToItemTemplate(iter_12_1)

		if self.rewardState_ == var_0_3 then
			var_12_0.grayFlag = true
		end

		function var_12_0.clickFun(arg_13_0)
			ShowPopItem(POP_ITEM, arg_13_0)
		end

		self.rewardItemList_[iter_12_0]:SetData(var_12_0)
	end

	for iter_12_2 = #self.rewradCfg_ + 1, 3 do
		self.rewardItemList_[iter_12_2]:SetData(nil)
	end
end

function MythicSectionRewardItem:Dispose()
	for iter_14_0, iter_14_1 in ipairs(self.rewardItemList_) do
		iter_14_1:Dispose()
	end

	self.rewardItemList_ = nil

	MythicSectionRewardItem.super.Dispose(self)
end

return MythicSectionRewardItem
