local GuildBossChallengeRewardItemView = class("GuildBossChallengeRewardItemView", ReduxView)

function GuildBossChallengeRewardItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function GuildBossChallengeRewardItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildBossChallengeRewardItemView:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "status")
end

function GuildBossChallengeRewardItemView:AddUIListener()
	self:AddBtnListener(self.gameObject_:GetComponent(typeof(Button)), nil, function()
		if not GuildData:HaveGetGuildBossPersonalReward(self.needScore_) and self.score_ >= self.needScore_ then
			GuildAction.GetGuildBossReward(GuildData:GetGuildInfo().id, 1, self.needScore_)
		else
			JumpTools.OpenPageByJump("rewardPreview", {
				rewardList = self.bonusDataList_
			}, ViewConst.SYSTEM_ID.REWARD_PREVIEW)
		end
	end)
end

function GuildBossChallengeRewardItemView:AddEventListeners()
	return
end

function GuildBossChallengeRewardItemView:SetData(arg_7_1, arg_7_2)
	self.data_ = arg_7_1
	self.score_ = arg_7_2
	self.needScore_ = self.data_[1]
	self.bonusDataList_ = self.data_[2]

	self:UpdateView()
end

function GuildBossChallengeRewardItemView:UpdateView()
	self.scoreLabel_.text = self.needScore_

	if GuildData:HaveGetGuildBossPersonalReward(self.needScore_) then
		self.statusController_:SetSelectedState("haveGet")
	elseif self.score_ >= self.needScore_ then
		self.statusController_:SetSelectedState("canGet")
	else
		self.statusController_:SetSelectedState("cannotGet")
	end
end

function GuildBossChallengeRewardItemView:OnEnter()
	self:AddEventListeners()
end

function GuildBossChallengeRewardItemView:OnExit()
	self:RemoveAllEventListener()
end

function GuildBossChallengeRewardItemView:OnMainHomeViewTop()
	return
end

function GuildBossChallengeRewardItemView:Dispose()
	self.data_ = nil

	GuildBossChallengeRewardItemView.super.Dispose(self)
end

return GuildBossChallengeRewardItemView
