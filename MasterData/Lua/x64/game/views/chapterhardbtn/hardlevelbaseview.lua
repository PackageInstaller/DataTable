local HardLevelBaseView = class("HardLevelBaseView", ReduxView)

function HardLevelBaseView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.hardLevelItems_ = {}

	self:InitUI()
	self:AddListeners()
end

function HardLevelBaseView:OnEnter()
	for iter_2_0, iter_2_1 in ipairs(self.hardLevelItems_) do
		iter_2_1:OnEnter()
	end

	self:ShowDifficultPanel(false)
end

function HardLevelBaseView:OnExit()
	self:StopTimer()

	for iter_3_0, iter_3_1 in ipairs(self.hardLevelItems_) do
		iter_3_1:OnExit()
	end

	self:ShowDifficultPanel(false)
end

function HardLevelBaseView:Dispose()
	if self.hardLevelItems_ then
		for iter_4_0, iter_4_1 in ipairs(self.hardLevelItems_) do
			iter_4_1:Dispose()
		end

		self.hardLevelItems_ = nil
	end

	HardLevelBaseView.super.Dispose(self)
end

function HardLevelBaseView:InitUI()
	self:BindCfgUI()

	for iter_5_0 = 1, BattleConst.HARD_CNT do
		self.hardLevelItems_[iter_5_0] = self:GetHardLevelItem().New(self["hardLevelGo" .. iter_5_0 .. "_"], iter_5_0)
	end

	self.hardController_ = self.btnControllerEx_:GetController("hard")
	self.hideController_ = self.controllerEx_:GetController("hide")
end

function HardLevelBaseView:GetHardLevelItem()
	return HardLevelBaseItem
end

function HardLevelBaseView:AddListeners()
	self:AddBtnListener(self.selectDifficultBtn_, nil, function()
		self:ShowDifficultPanel(true)
		self:ClickListener()
	end)
end

function HardLevelBaseView:RefreshSelectDifficult()
	if self.hardLevel_ == 1 then
		self.hardController_:SetSelectedState("hard1")
	elseif self.hardLevel_ == 2 then
		self.hardController_:SetSelectedState("hard2")
	end

	self.difficultText_.text = GetTips(BattleConst.HARD_LANGUAGE[self.hardLevel_])
end

function HardLevelBaseView:ShowDifficultPanel(arg_10_1)
	self.hideController_:SetSelectedState(tostring(not arg_10_1))
end

function HardLevelBaseView:ClickListener()
	if not self.clickTimer_ then
		self.buttonUp_ = 0
		self.clickTimer_ = FuncTimerManager.inst:CreateFuncFrameTimer(function()
			if Input.GetMouseButtonUp(0) then
				self.buttonUp_ = self.buttonUp_ + 1

				if self.buttonUp_ >= 2 then
					self:ShowDifficultPanel(false)
					FuncTimerManager.inst:RemoveFuncTimer(self.clickTimer_)

					self.clickTimer_ = nil
				end
			end
		end, -1, true)
	end
end

function HardLevelBaseView:StopTimer()
	if self.clickTimer_ then
		FuncTimerManager.inst:RemoveFuncTimer(self.clickTimer_)

		self.clickTimer_ = nil
	end
end

function HardLevelBaseView:SetData(arg_14_1)
	self.hardLevel_ = arg_14_1

	self:RefreshSelectDifficult()
end

return HardLevelBaseView
