local ActivityRhythmGameStageItem = class("ActivityRhythmGameStageItem", ReduxView)

function ActivityRhythmGameStageItem:IsOpenSectionInfo()
	return self:IsOpenRoute("activityHeroEnhanceSectionInfo")
end

function ActivityRhythmGameStageItem:OnCtor(arg_2_1, arg_2_2)
	self.gameObject_ = Object.Instantiate(arg_2_1, arg_2_2.transform)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivityRhythmGameStageItem:Show(arg_3_1)
	SetActive(self.gameObject_, arg_3_1)
end

function ActivityRhythmGameStageItem:Init()
	self:InitLocalData()
	self:InitUI()
	self:AddListeners()
end

function ActivityRhythmGameStageItem:AddListeners()
	self:AddBtnListener(nil, self.stageBtn_, function()
		self:OnClick()
	end)
	self:AddBtnListener(nil, self.stageBtn2_, function()
		self:OnClick()
	end)
end

function ActivityRhythmGameStageItem:InitUI()
	self:BindCfgUI()
	SetActive(self.gameObject_, true)
	self:BindController()
end

function ActivityRhythmGameStageItem:InitLocalData()
	self.cfgID_ = 0
	self.stageID_ = 0
	self.activityID_ = 0
end

function ActivityRhythmGameStageItem:Dispose()
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil

	ActivityRhythmGameStageItem.super.Dispose(self)
end

function ActivityRhythmGameStageItem:BindController()
	self.starController_ = self.controllerEx_:GetController("stars")
	self.lockController_ = self.controllerEx_:GetController("lock")
	self.lineController_ = self.controllerEx_:GetController("lineState")
	self.selectController_ = self.controllerEx_:GetController("select")
	self.showStarsController_ = self.controllerEx_:GetController("showStars")
	self.stageController_ = self.controllerEx_:GetController("stageState")
end

function ActivityRhythmGameStageItem:ChangeStarController(arg_12_1)
	self.starController_:SetSelectedIndex(arg_12_1)
end

function ActivityRhythmGameStageItem:ChangeLockController(arg_13_1)
	self.lockController_:SetSelectedIndex(arg_13_1)
end

function ActivityRhythmGameStageItem:ChangeLineController(arg_14_1)
	self.lineController_:SetSelectedIndex(arg_14_1)
end

function ActivityRhythmGameStageItem:ChangeSelectController(arg_15_1)
	self.selectController_:SetSelectedIndex(arg_15_1)
end

function ActivityRhythmGameStageItem:ChangeShowStarsController(arg_16_1)
	self.showStarsController_:SetSelectedIndex(arg_16_1)
end

function ActivityRhythmGameStageItem:ChangeStageController(arg_17_1)
	self.stageController_:SetSelectedIndex(arg_17_1)
end

function ActivityRhythmGameStageItem:RefreshUI()
	self:RefreshStar()
	self:RefreshLock()
	self:RefreshText()
end

function ActivityRhythmGameStageItem:RefreshStar()
	if ActivityRhythmGameCfg[self.cfgID_].three_star_need == "" then
		self:ChangeShowStarsController(1)

		return
	end

	self:ChangeShowStarsController(0)
	self:ChangeStarController(#ActivityRhythmGameData:GetStarsByCfgID(self.cfgID_))
end

function ActivityRhythmGameStageItem:RefreshLock()
	if ActivityRhythmGameData:IsUnlock(self.cfgID_) then
		self:ChangeLockController(0)
	else
		self:ChangeLockController(1)
	end
end

function ActivityRhythmGameStageItem:RefreshText()
	if BattleRhythmGameStageCfg[self.stageID_] then
		self.stageText_.text = BattleRhythmGameStageCfg[self.stageID_].name
	end
end

function ActivityRhythmGameStageItem:SetData(arg_22_1)
	self.cfgID_ = arg_22_1
	self.activityID_ = ActivityRhythmGameCfg[arg_22_1].activity_id
	self.stageID_ = ActivityRhythmGameCfg[arg_22_1].stage_id
	self.stageType_ = BattleConst.STAGE_TYPE_NEW.ACTIVITY_RHYTHM_GAME

	self:RefreshUI()
end

function ActivityRhythmGameStageItem:SetAddPos(arg_23_1, arg_23_2)
	self.transform_.localPosition = Vector3(self.transform_.localPosition.x + arg_23_1, self.transform_.localPosition.y + arg_23_2, self.transform_.localPosition.z)
end

function ActivityRhythmGameStageItem:SetLine(arg_24_1)
	self:ChangeLineController(arg_24_1)
end

function ActivityRhythmGameStageItem:SetClickHandler(arg_25_1)
	self.onClickCallback_ = arg_25_1
end

function ActivityRhythmGameStageItem:OnClick()
	if self.onClickCallback_ then
		self.onClickCallback_(self.cfgID_, self.stageID_, self.transform_.position)
	end
end

function ActivityRhythmGameStageItem:GetPosition()
	return self.transform_.position
end

function ActivityRhythmGameStageItem:RefreshSelect(arg_28_1)
	if self.cfgID_ == arg_28_1 then
		self:ChangeSelectController(1)
	else
		self:ChangeSelectController(0)
	end
end

return ActivityRhythmGameStageItem
