local SectionInfoMultipleBaseView = class("SectionInfoMultipleBaseView", import(".SectionInfoBaseView"))
local var_0_1 = #GameSetting.challenge_multiple_count_unlock_level.value

function SectionInfoMultipleBaseView:Init()
	SectionInfoMultipleBaseView.super.Init(self)
	self.hideMultiplePanelController_:SetSelectedState("false")
end

function SectionInfoMultipleBaseView:AddListeners()
	SectionInfoMultipleBaseView.super.AddListeners(self)
	self:AddBtnListener(self.minMultipleBtn_, nil, function()
		OperationRecorder.Record(self.class.__cname, "challenge_multiple")

		self.multiple_ = 1

		self:ChangeMultiple()
	end)
	self:AddBtnListener(self.subBtn_, nil, function()
		OperationRecorder.Record(self.class.__cname, "single")

		self.multiple_ = self.multiple_ - 1

		self:ChangeMultiple()
	end)
	self:AddBtnListener(self.addBtn_, nil, function()
		OperationRecorder.Record(self.class.__cname, "single")

		if self.multiple_ >= self.challengeCnt_ then
			ShowTips((self:GetChallengeCntMaxTip()))

			return
		end

		self.multiple_ = self.multiple_ + 1

		self:ChangeMultiple()
	end)
	self:AddBtnListener(self.maxMultipleBtn_, nil, function()
		OperationRecorder.Record(self.class.__cname, "challenge_multiple")

		if self.challengeCnt_ < self.maxMultiple_ then
			self.multiple_ = self.challengeCnt_
		end

		self:ChangeMultiple()
	end)
end

function SectionInfoMultipleBaseView:RemoveListeners()
	SectionInfoMultipleBaseView.super.RemoveListeners(self)
	self.minMultipleBtn_.onClick:RemoveAllListeners()
	self.subBtn_.onClick:RemoveAllListeners()
	self.addBtn_.onClick:RemoveAllListeners()
	self.maxMultipleBtn_.onClick:RemoveAllListeners()
end

function SectionInfoMultipleBaseView:OnCurrencyChange()
	SectionInfoMultipleBaseView.super.OnCurrencyChange(self)
	self:RefreshMultiple()
end

function SectionInfoMultipleBaseView:RefreshData()
	local var_9_0 = 1

	for iter_9_0 = var_0_1, 1, -1 do
		if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) >= self.cost_ * iter_9_0 then
			var_9_0 = iter_9_0

			break
		end
	end

	self.maxMultiple_ = var_9_0
	self.multiple_ = self.multiple_ or 1
	self.challengeCnt_ = self:GetUnlockChallengeCnt()
end

function SectionInfoMultipleBaseView:RefreshUI()
	SectionInfoMultipleBaseView.super.RefreshUI(self)
	self:RefreshMultiple()
end

function SectionInfoMultipleBaseView:OnClickBtn()
	return
end

function SectionInfoMultipleBaseView:ChangeMultiple()
	self:RefreshMultiple()
	self:RefreshCost()
	self:RefreshBtn()
end

function SectionInfoMultipleBaseView:RefreshMultiple()
	self.multipleText_.text = "x" .. self.multiple_

	if self.multiple_ >= self.maxMultiple_ or self.multiple_ >= self.challengeCnt_ then
		self.maxMultipleBtn_.interactable = false
		self.maxMultipleBtnCanvas_.alpha = 0.5
		self.minMultipleBtn_.interactable = true
		self.minMultipleCanvas_.alpha = 1
		self.subBtn_.interactable = true
		self.subBtnCanvas_.alpha = 1
	elseif self.multiple_ <= 1 then
		self.maxMultipleBtn_.interactable = true
		self.maxMultipleBtnCanvas_.alpha = 1
		self.minMultipleBtn_.interactable = false
		self.minMultipleCanvas_.alpha = 0.5
		self.subBtn_.interactable = false
		self.subBtnCanvas_.alpha = 0.5
	else
		self.maxMultipleBtn_.interactable = true
		self.maxMultipleBtnCanvas_.alpha = 1
		self.minMultipleBtn_.interactable = true
		self.minMultipleCanvas_.alpha = 1
		self.subBtn_.interactable = true
		self.subBtnCanvas_.alpha = 1
	end

	if self.multiple_ == var_0_1 then
		self.addBtn_.interactable = false
		self.addBtnCanvas_.alpha = 0.5
	else
		self.addBtn_.interactable = true
		self.addBtnCanvas_.alpha = 1
	end

	if self.multiple_ <= 1 then
		self.minMultipleBtn_.interactable = false
		self.minMultipleCanvas_.alpha = 0.5
		self.subBtn_.interactable = false
		self.subBtnCanvas_.alpha = 0.5
	end
end

function SectionInfoMultipleBaseView:GetUnlockChallengeCnt()
	local var_14_0 = PlayerData:GetPlayerInfo().userLevel

	for iter_14_0, iter_14_1 in ipairs(GameSetting.challenge_multiple_count_unlock_level.value) do
		if var_14_0 < iter_14_1 then
			return iter_14_0 - 1
		end
	end

	return #GameSetting.challenge_multiple_count_unlock_level.value
end

function SectionInfoMultipleBaseView:GetChallengeCntMaxTip()
	return string.format(GetTips("PLAYER_LEVEL_UNLOCK"), GameSetting.challenge_multiple_count_unlock_level.value[self.multiple_ + 1])
end

return SectionInfoMultipleBaseView
