local BossStarExchangeItem = class("BossStarExchangeItem", ReduxView)
local var_0_1 = "notclear"
local var_0_2 = "clear"
local var_0_3 = "received"

function BossStarExchangeItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function BossStarExchangeItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function BossStarExchangeItem:InitUI()
	self:BindCfgUI()

	self.rewardPanel_ = {}
	self.rewardItemList_ = {}

	for iter_3_0 = 1, 3 do
		self.rewardPanel_[iter_3_0] = self[string.format("rewardItem%s_", iter_3_0)]
		self.rewardItemList_[iter_3_0] = CommonItemView.New(self.rewardPanel_[iter_3_0])
	end

	self.controller_ = self.transform_:GetComponent("ControllerExCollection"):GetController("default0")
end

function BossStarExchangeItem:AddUIListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if self.rewardState_ == var_0_2 then
			if table.length(BattleBossChallengeNormalData:GetReceiveStarList()) <= 0 then
				ShowMessageBox({
					title = GetTips("PROMPT"),
					content = GetTips("BOSS_CHALLENGE_REWARD_TIPS"),
					OkCallback = function()
						self:ClickItem()
					end
				})
			else
				self:ClickItem()
			end
		end
	end)
end

function BossStarExchangeItem:SetData(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	self.rewardIndex_ = arg_7_3
	self.rewardCfg_ = getRewardFromDropCfg(arg_7_1[2], true)
	self.totalStarCnt_ = arg_7_1[1]

	if arg_7_2 > arg_7_1[1] then
		self.curStarCnt_ = arg_7_1[1] or arg_7_2
	end

	self:GetRewardState()
	self:RefreshUI(arg_7_2)
	self:RefreshState()
	self:RefreshItem()
end

function BossStarExchangeItem:RefreshUI(arg_8_1)
	self.progressCntText_.text = string.format(GetTips("COMPLETE_TARGET"), self.totalStarCnt_)
	self.progressText_.text = string.format("%s/%s", arg_8_1, self.totalStarCnt_)
	self.progressBar_.value = arg_8_1 / self.totalStarCnt_
	self.textPhase_.text = self.rewardIndex_ < 10 and 0 .. tostring(self.rewardIndex_) or self.rewardIndex_
end

function BossStarExchangeItem:RefreshState()
	self.controller_:SetSelectedState(tostring(self.rewardState_))
end

function BossStarExchangeItem:RefreshItem()
	for iter_10_0, iter_10_1 in pairs(self.rewardCfg_) do
		local var_10_0 = rewardToItemTemplate(iter_10_1)

		function var_10_0:clickFun()
			ShowPopItem(POP_ITEM, {
				self.id
			})
		end

		CommonTools.SetCommonData(self.rewardItemList_[iter_10_0], var_10_0)
		self.rewardItemList_[iter_10_0]:RefreshGray(self.rewardState_ == var_0_3)
	end

	for iter_10_2 = #self.rewardCfg_ + 1, #self.rewardItemList_ do
		self.rewardItemList_[iter_10_2]:SetData()
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.rewardContent_)
end

function BossStarExchangeItem:ClickItem()
	local var_12_0 = self.rewardState_

	BattleBossChallengeAction.RequireBossExchange(self.curStarCnt_, function(arg_13_0)
		if isSuccess(arg_13_0.result) then
			BattleBossChallengeNormalData:SetReceiveStarList(self.totalStarCnt_)
			self:GetRewardState()
			getReward2(arg_13_0.item_list)

			if var_12_0 == var_0_2 and self.rewardState_ == var_0_3 then
				self:RefreshState()
				manager.notify:Invoke(BOSS_CHALLENGE_RECEIVE_STAR_REWARD)
			end
		else
			ShowTips(arg_13_0.result)
		end
	end)
end

function BossStarExchangeItem:GetRewardState()
	self.rewardState_ = self.curStarCnt_ < self.totalStarCnt_ and var_0_1 or table.keyof(BattleBossChallengeNormalData:GetReceiveStarList(), self.totalStarCnt_) and var_0_3 or var_0_2
end

function BossStarExchangeItem:Dispose()
	self:RemoveAllListeners()

	for iter_15_0, iter_15_1 in ipairs(self.rewardItemList_) do
		iter_15_1:Dispose()
	end

	self.rewardItemList_ = nil
	self.rewardPanel_ = nil

	BossStarExchangeItem.super.Dispose(self)
end

return BossStarExchangeItem
