local NiewWorldBossRewardItem = class("NiewWorldBossRewardItem", ReduxView)

function NiewWorldBossRewardItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.width = arg_1_2

	self:Init()
end

function NiewWorldBossRewardItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function NiewWorldBossRewardItem:InitUI()
	self:BindCfgUI()

	self.stateController = ControllerUtil.GetController(self.transform_, "state")
end

function NiewWorldBossRewardItem:AddUIListener()
	self:AddBtnListener(self.m_btn, nil, function()
		if self.state == 1 then
			ActivityWorldBossAction.QueryHealthRward(self.activity_id, {
				self.index
			})
		elseif self.state == 2 then
			JumpTools.OpenPageByJump("rewardPreview", {
				is_receive = true,
				rewardList = self.rewardList
			}, ViewConst.SYSTEM_ID.REWARD_PREVIEW)
		else
			JumpTools.OpenPageByJump("rewardPreview", {
				is_receive = false,
				rewardList = self.rewardList
			}, ViewConst.SYSTEM_ID.REWARD_PREVIEW)
		end
	end)
end

function NiewWorldBossRewardItem:SetData(arg_6_1, arg_6_2)
	self.activity_id = arg_6_1
	self.index = arg_6_2
	self.rewardList = getRewardFromDropCfg(ActivityWorldBossCfg[arg_6_1].health_reward_list[arg_6_2][2], true)
	self.m_lab.text = ActivityWorldBossCfg[arg_6_1].health_reward_list[arg_6_2][1] / 10 .. "%"
	self.transform_.localPosition = Vector3.New(self.width - self.width * (ActivityWorldBossCfg[arg_6_1].health_reward_list[arg_6_2][1] / 10) / 100, 0, 0)
	self.state = ActivityWorldBossData:GetHealthRewardState(arg_6_1, arg_6_2)

	self.stateController:SetSelectedIndex(self.state)
end

function NiewWorldBossRewardItem:SetActive(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

function NiewWorldBossRewardItem:Dispose()
	NiewWorldBossRewardItem.super.Dispose(self)
end

return NiewWorldBossRewardItem
