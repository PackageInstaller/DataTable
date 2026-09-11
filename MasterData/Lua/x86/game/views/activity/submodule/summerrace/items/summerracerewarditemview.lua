local SummerRaceRewardItemView = class("SummerRaceRewardItemView", ReduxView)

function SummerRaceRewardItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SummerRaceRewardItemView:Init()
	self:BindCfgUI()
	self:BindItemRuntime_()
	self:AddUIListener()
end

function SummerRaceRewardItemView:BindItemRuntime_()
	self.stateController_ = self.controllerEx_:GetController("state")
	self.highlightController_ = self.controllerEx_:GetController("highlight")
end

function SummerRaceRewardItemView:AddUIListener()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if self.clickHandler_ then
			self.clickHandler_(self.index_, self.rewardData_, "receive")
		end
	end)
end

function SummerRaceRewardItemView:SetData(arg_6_1, arg_6_2, arg_6_3)
	self.rewardData_ = arg_6_1
	self.index_ = arg_6_2
	self.clickHandler_ = arg_6_3

	self:RefreshView()
end

function SummerRaceRewardItemView:RefreshView()
	if self.rewardData_ == nil then
		return
	end

	self.rewardNameText_.text = tostring(self.rewardData_.rewardName or "")
	self.rewardCountText_.text = "x" .. tostring(self.rewardData_.rewardCount or 0)
	self.progressText_.text = tostring(self.rewardData_.progressText or "")

	SetActive(self.receivedGo_, self.rewardData_.state == "received")
	self.stateController_:SetSelectedState(self.rewardData_.state or "locked")
	self.highlightController_:SetSelectedState(self.rewardData_.state == "canReceive" and "on" or "off")

	self.receiveBtn_.interactable = self.rewardData_.state == "canReceive"
end

function SummerRaceRewardItemView:Dispose()
	self.rewardData_ = nil
	self.clickHandler_ = nil

	self:RemoveAllListeners()
	SummerRaceRewardItemView.super.Dispose(self)
end

return SummerRaceRewardItemView
