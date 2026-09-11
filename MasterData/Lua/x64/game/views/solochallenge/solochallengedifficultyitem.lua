local SoloChallengeDifficultyItem = class("SoloChallengeDifficultyItem", ReduxView)

function SoloChallengeDifficultyItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1.gameObject
	self.transform_ = arg_1_1

	SetActive(self.gameObject_, true)
	self:Init()
end

function SoloChallengeDifficultyItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function SoloChallengeDifficultyItem:InitUI()
	self:BindCfgUI()

	self.selectController_ = ControllerUtil.GetController(self.transform_, "select")
	self.completeController_ = ControllerUtil.GetController(self.transform_, "complete")
end

function SoloChallengeDifficultyItem:AddUIListener()
	self:AddBtnListener(self.Btn_, nil, function()
		if self.selectCallBack_ then
			self.selectCallBack_(self.difficultyIndex_)
		end
	end)
end

function SoloChallengeDifficultyItem:SetSelectCallBack(arg_6_1)
	self.selectCallBack_ = arg_6_1
end

function SoloChallengeDifficultyItem:SetData(arg_7_1, arg_7_2)
	self.difficultyIndex_ = arg_7_2

	if self.completeController_ ~= nil then
		if table.keyof(SoloChallengeData:GetCompletedActivityList()[arg_7_1], self.difficultyIndex_) ~= nil then
			self.completeController_:SetSelectedState("true")
		else
			self.completeController_:SetSelectedState("false")
		end
	end
end

function SoloChallengeDifficultyItem:SetSelectCallBack(arg_8_1)
	self.selectCallBack_ = arg_8_1
end

function SoloChallengeDifficultyItem:SetSelect(arg_9_1)
	if self.selectController_ ~= nil then
		if self.difficultyIndex_ == arg_9_1 then
			self.selectController_:SetSelectedState("true")
		else
			self.selectController_:SetSelectedState("false")
		end
	end
end

function SoloChallengeDifficultyItem:Dispose()
	self.gameObject_ = nil
	self.transform_ = nil
	self.selectCallBack_ = nil

	SoloChallengeDifficultyItem.super.Dispose(self)
end

return SoloChallengeDifficultyItem
