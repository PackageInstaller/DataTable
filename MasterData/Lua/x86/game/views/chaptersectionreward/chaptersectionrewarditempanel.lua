local ChapterSectionRewardItemPanel = class("ChapterSectionRewardItemPanel", ReduxView)
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2

function ChapterSectionRewardItemPanel:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.rewardIndex_ = arg_1_2

	self:Init()
end

function ChapterSectionRewardItemPanel:Init()
	self:InitUI()
	self:AddListeners()

	self.btnController_ = self.controllerEx_:GetController("default0")
	self.rewardItemList_ = {}

	for iter_2_0 = 1, 3 do
		self.rewardItemList_[iter_2_0] = CommonItemView.New(self[string.format("rewardItem%s_", iter_2_0)])
	end
end

function ChapterSectionRewardItemPanel:SetData(arg_3_1)
	self.chapterID_ = arg_3_1

	self:RefreshData()
	self:RefreshUI()
	self:RefreshState()
	self:RefreshItem()
end

function ChapterSectionRewardItemPanel:Dispose()
	self:RemoveListeners()

	for iter_4_0, iter_4_1 in ipairs(self.rewardItemList_) do
		iter_4_1:Dispose()
	end

	self.rewardItemList_ = nil
	self.rewardPanel_ = nil

	ChapterSectionRewardItemPanel.super.Dispose(self)
end

function ChapterSectionRewardItemPanel:InitUI()
	self:BindCfgUI()

	self.rewardPanel_ = {}

	for iter_5_0 = 1, 3 do
		self.rewardPanel_[iter_5_0] = self[string.format("rewardItem%s_", iter_5_0)]
	end
end

function ChapterSectionRewardItemPanel:AddListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if self.rewardState_ == var_0_2 then
			OperationRecorder.Record(self.class.__cname, "collect_get_reward")

			local var_7_0 = self.chapterID_
			local var_7_1 = self.rewardIndex_
			local var_7_2 = self.rewardState_

			BattleStageAction.GetChapterStarReward(self.chapterID_, self.rewardIndex_, function(arg_8_0)
				if isSuccess(arg_8_0.result) then
					getReward(arg_8_0.reward_list)
					BattleStageData:SetChapterStarReward(var_7_0, var_7_1)
					self:GetRewardState()

					if var_7_2 == var_0_2 and self.rewardState_ == var_0_3 then
						self:RefreshState()
						self:RefreshItem()
					end
				else
					ShowTips(arg_8_0.result)
				end
			end)
		end
	end)
end

function ChapterSectionRewardItemPanel:RemoveListeners()
	return
end

function ChapterSectionRewardItemPanel:RefreshData()
	local var_10_0 = self.chapterID_

	self.rewradCfg_ = self.rewardIndex_ == 1 and ChapterCfg[var_10_0].first_reward or self.rewardIndex_ == 2 and ChapterCfg[var_10_0].second_reward or ChapterCfg[var_10_0].third_reward

	local var_10_1 = 0
	local var_10_2 = BattleStageData:GetStageData()

	for iter_10_0, iter_10_1 in ipairs(ChapterCfg[var_10_0].section_id_list) do
		if var_10_2[iter_10_1] then
			for iter_10_2, iter_10_3 in ipairs(var_10_2[iter_10_1].stars) do
				if iter_10_3 == 1 then
					var_10_1 = var_10_1 + 1
				end
			end
		end
	end

	self.curStarCnt_ = var_10_1
	self.totalStarCnt_ = ChapterCfg[var_10_0].star_need[self.rewardIndex_]

	self:GetRewardState()
end

function ChapterSectionRewardItemPanel:GetRewardState()
	local var_11_0

	if self.curStarCnt_ < self.totalStarCnt_ then
		var_11_0 = var_0_1
	else
		local var_11_1 = BattleStageData:GetChapterStarRewardState()

		var_11_0 = var_11_1[self.chapterID_] and var_11_1[self.chapterID_][self.rewardIndex_] and var_11_1[self.chapterID_][self.rewardIndex_] >= 1 and var_0_3 or var_0_2
	end

	self.rewardState_ = var_11_0
end

function ChapterSectionRewardItemPanel:RefreshUI()
	self.progressCntText_.text = string.format(GetTips("COMPLETE_TARGET"), self.totalStarCnt_)

	local var_12_1

	if self.curStarCnt_ > self.totalStarCnt_ then
		var_12_1 = self.totalStarCnt_ or self.curStarCnt_
	end

	self.progressText_.text = string.format("%s/%s", var_12_1, self.totalStarCnt_)
	self.progressBar_.value = var_12_1 / self.totalStarCnt_
end

function ChapterSectionRewardItemPanel:RefreshState()
	if self.rewardState_ == var_0_2 then
		self.btnController_:SetSelectedState("clear")
	elseif self.rewardState_ == var_0_1 then
		self.btnController_:SetSelectedState("notclear")
	else
		self.btnController_:SetSelectedState("received")
	end
end

function ChapterSectionRewardItemPanel:RefreshItem()
	for iter_14_0, iter_14_1 in pairs(self.rewradCfg_) do
		local var_14_0 = clone(ItemTemplateData)

		var_14_0.id = iter_14_1[1]
		var_14_0.number = iter_14_1[2]
		var_14_0.grayFlag = self.rewardState_ == var_0_3

		function var_14_0:clickFun()
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number
			})
		end

		self.rewardItemList_[iter_14_0]:SetData(var_14_0)
	end

	for iter_14_2 = #self.rewradCfg_ + 1, #self.rewardItemList_ do
		self.rewardItemList_[iter_14_2]:SetData(nil)
	end
end

return ChapterSectionRewardItemPanel
