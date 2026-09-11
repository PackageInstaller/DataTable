local DemonChallengeSelectView = class("DemonChallengeSelectView", ReduxView)

function DemonChallengeSelectView:UIName()
	return "UI/VersionUI/OsirisUI/OsirisUIselectDifficultyUI"
end

function DemonChallengeSelectView:UIParent()
	return manager.ui.uiMain.transform
end

function DemonChallengeSelectView:Init()
	self.levelIndex_ = self.params_.levelIndex
	self.selectController_ = ControllerUtil.GetController(self.transform_, "selectDifficulty")

	self:InitUI()
	self:AddUIListener()
end

function DemonChallengeSelectView:InitUI()
	self:BindCfgUI()

	self.completedUIController_1 = ControllerUtil.GetController(self.Level1Btn_.transform, "completed")
	self.completedUIController_2 = ControllerUtil.GetController(self.Level2Btn_.transform, "completed")
	self.completedUIController_3 = ControllerUtil.GetController(self.Level3Btn_.transform, "completed")
	self.completedUIController_ = {
		self.completedUIController_1,
		self.completedUIController_2,
		self.completedUIController_3
	}
end

function DemonChallengeSelectView:AddUIListener()
	self:AddBtnListener(self.startBtn_, nil, function()
		if not ActivityData:GetActivityData(ActivityConst.OSIRIS_DEMON):IsActivitying() then
			ShowTips("TIME_OVER")

			return
		end

		DemonChallengeData:SetSelectDifficultyIndex(self.levelIndex_, self.difficultyIndex_)
		self:GetStageId()
		self:Go("/sectionSelectHero", {
			section = self.curStageId_,
			sectionType = BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON
		})
	end)
	self:AddBtnListener(self.Level1Btn_, nil, function()
		self:RefreshDifficult(1)
	end)
	self:AddBtnListener(self.Level2Btn_, nil, function()
		self:RefreshDifficult(2)
	end)
	self:AddBtnListener(self.Level3Btn_, nil, function()
		self:RefreshDifficult(3)
	end)
end

function DemonChallengeSelectView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	self:UpdateData()
	self:RefreshUI()
end

function DemonChallengeSelectView:UpdateData()
	self.levelIndex_ = DemonChallengeData:GetCacheSelectLevelIndex()
	self.difficultyIndex_ = DemonChallengeData:GetSelectDifficultyIndex(self.levelIndex_)

	self:RefreshUI()
end

function DemonChallengeSelectView:RefreshUI()
	self:RefreshCompletedUI()
	self:RefreshSelectedUI()
	self:RefreshDesc()
end

function DemonChallengeSelectView:RefreshCompletedUI()
	local var_13_0 = DemonChallengeData:GetCompletedList(self.levelIndex_)

	for iter_13_0, iter_13_1 in ipairs(self.completedUIController_) do
		if table.keyof(var_13_0, iter_13_0) ~= nil then
			iter_13_1:SetSelectedState("true")
		else
			iter_13_1:SetSelectedState("false")
		end
	end
end

function DemonChallengeSelectView:RefreshDesc()
	self.descText_.text = GetI18NText((self.difficultyIndex_ ~= nil or nil) and DemonChallengeData:GetDifficultyDes(self.levelIndex_, self.difficultyIndex_))
end

function DemonChallengeSelectView:RefreshSelectedUI()
	if self.difficultyIndex_ == nil then
		self.selectController_:SetSelectedState("4")

		self.startBtn_.interactable = false
	else
		self.selectController_:SetSelectedState(tostring(self.difficultyIndex_))

		self.startBtn_.interactable = true
	end
end

function DemonChallengeSelectView:RefreshDifficult(arg_16_1)
	self.difficultyIndex_ = arg_16_1

	DemonChallengeData:SetSelectDifficultyIndex(self.levelIndex_, self.difficultyIndex_)
	self:RefreshUI()
	self:GetStageId()
end

function DemonChallengeSelectView:GetStageId()
	self.curStageId_ = DemonChallengeData:GetStageId(self.levelIndex_, self.difficultyIndex_)
end

return DemonChallengeSelectView
