local ActivityNoobUpgradeView = class("ActivityNoobUpgradeView", ReduxView)

function ActivityNoobUpgradeView:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.index_ = arg_1_2

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "stage")
end

function ActivityNoobUpgradeView:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		local var_3_0 = GameSetting.levelup_reward.value[self.index_][1]

		if self.isFinish_ and not table.keyof(ActivityNoobData:GetUpgradeFinishList(), GameSetting.levelup_reward.value[self.index_][1]) then
			ActivityNoobAction.ReceiveUpgradeReward(GameSetting.levelup_reward.value[self.index_][1], function(arg_4_0)
				if isSuccess(arg_4_0.result) then
					getReward2(arg_4_0.reward_list)
					ActivityNoobData:SetUpgradeFinish(var_3_0)
					ActivityNoobAction.PlayerUpgradeRedPoint()
					self:ReceiveReward()
				else
					ShowTips(arg_4_0.result)
				end
			end)
		else
			JumpTools.OpenPageByJump("rewardPreview", {
				rewardList = {
					GameSetting.levelup_reward.value[self.index_][2]
				}
			}, ViewConst.SYSTEM_ID.REWARD_PREVIEW)
		end
	end)
end

function ActivityNoobUpgradeView:Dispose()
	self.disposed_ = true

	ActivityNoobUpgradeView.super.Dispose(self)
end

function ActivityNoobUpgradeView:RefreshUI()
	local var_6_0 = GameSetting.levelup_reward.value[self.index_][1]

	self.isFinish_ = GameSetting.levelup_reward.value[self.index_][1] <= PlayerData:GetPlayerInfo().userLevel

	if self.isFinish_ then
		if table.keyof(ActivityNoobData:GetUpgradeFinishList(), var_6_0) then
			self:ReceiveReward()
		else
			self.controller_:SetSelectedState("1")
		end
	else
		self.controller_:SetSelectedState("0")
	end

	local var_6_1 = GameSetting.levelup_reward.value[self.index_]

	ItemTools.GetItemSpriteAsync(GameSetting.levelup_reward.value[self.index_][2][1], function(arg_7_0, arg_7_1)
		if self.disposed_ then
			return
		end

		if arg_7_0 == var_6_1[2][1] then
			self.imageImg_.sprite = arg_7_1
		end
	end)
end

function ActivityNoobUpgradeView:ReceiveReward()
	self.controller_:SetSelectedState("2")
end

return ActivityNoobUpgradeView
