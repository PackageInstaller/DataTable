local SkinTrialSelectView_3_0 = class("SkinTrialSelectView_3_0", SkinTrialSelectView_2_0)

function SkinTrialSelectView_3_0:Init()
	SkinTrialSelectView_3_0.super.Init(self)
end

function SkinTrialSelectView_3_0:AddListeners()
	SkinTrialSelectView_3_0.super.AddListeners(self)

	if self.getBtn_ then
		self:AddBtnListener(self.getBtn_, nil, function()
			SkinTrialAction.RequestSkinTrialReward(self.skinTrialID_)
		end)
	end

	self:RegistEventListener(SKIN_TRIAL_UPDATE, handler(self, self.OnSkinTrialUpdate))
end

function SkinTrialSelectView_3_0:RefreshUI()
	SkinTrialSelectView_3_0.super.RefreshUI(self)
	self:RefreshReceive()
end

function SkinTrialSelectView_3_0:RefreshReceive()
	if not self.receiveController_ then
		return
	end

	self.receiveController = self.receiveController or self.receiveController_:GetController("default0")

	local var_5_0 = SkinTrialData:GetSkinTrialStatus(self.skinTrialID_)

	if var_5_0 == 0 then
		self.receiveController:SetSelectedState("state0")
	elseif var_5_0 == 1 then
		self.receiveController:SetSelectedState("state2")
	elseif var_5_0 == 2 then
		self.receiveController:SetSelectedState("state1")
	end
end

function SkinTrialSelectView_3_0:GetRewardItem()
	return CommonItemView
end

function SkinTrialSelectView_3_0:OnSkinTrialUpdate(arg_7_1)
	self:RefreshReceive()
end

function SkinTrialSelectView_3_0:IndexItem(arg_8_1, arg_8_2)
	local var_8_0 = clone(ItemTemplateData)

	var_8_0.index = arg_8_1
	var_8_0.id = self.rewardCfg_[arg_8_1][1]
	var_8_0.number = self.rewardCfg_[arg_8_1][2]
	var_8_0.completedFlag = false

	function var_8_0.clickFun(arg_9_0)
		if self.clickCallback_ then
			if self.clickCallback_() then
				ShowPopItem(self.popType_, arg_9_0)
			end
		else
			ShowPopItem(self.popType_, arg_9_0)
		end
	end

	arg_8_2:SetData(var_8_0)
end

function SkinTrialSelectView_3_0:SaveRoute()
	SkinTrialData:SaveRoute({
		name = "skinTrialSelectView_3_0",
		activityID = self.activityID_,
		skinTrialID = self.skinTrialID_
	})
end

return SkinTrialSelectView_3_0
