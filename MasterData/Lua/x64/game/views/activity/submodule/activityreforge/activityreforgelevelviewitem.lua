local ActivityReforgeLevelViewItem = class("ActivityReforgeLevelViewItem", ReduxView)

function ActivityReforgeLevelViewItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.clickHandler_ = arg_1_2

	self:Init()
end

function ActivityReforgeLevelViewItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityReforgeLevelViewItem:InitUI()
	self:BindCfgUI()

	self.levelController_ = self.controllerEx_:GetController("Level")
	self.isPassController_ = self.controllerEx_:GetController("ispass")
	self.isBattlingController_ = self.controllerEx_:GetController("isbattling")
	self.isSelectController_ = self.controllerEx_:GetController("isselect")
	self.isLast_ = false
end

function ActivityReforgeLevelViewItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickHandler_ then
			self.clickHandler_(self.index_)
		end
	end)
end

function ActivityReforgeLevelViewItem:SetData(arg_6_1, arg_6_2, arg_6_3)
	self.index_ = arg_6_1
	self.chapterActivityID_ = arg_6_2
	self.levelID_ = arg_6_3

	self:RefreshUI()
end

function ActivityReforgeLevelViewItem:RefreshUI()
	self.cfg_ = ActivityReforgeLevelCfg[self.levelID_]

	self.levelController_:SetSelectedState(self.index_)

	if self.levelID_ == ActivityReforgeData:GetCurLevel() then
		self.isLast_ = ActivityReforgeLevelCfg[self.levelID_].wave_list[#ActivityReforgeLevelCfg[self.levelID_].wave_list] == ActivityReforgeData:GetCurLastWinWaveID()
		self.curWaveNum_.text = self.isLast_ and string.format(GetTips("ACTIVITY_REFORGE_WAVE"), ActivityReforgeData:GetCurLevelFinishWave()) or string.format(GetTips("ACTIVITY_REFORGE_WAVE"), ActivityReforgeData:GetCurLevelFinishWave() + 1)

		self.isBattlingController_:SetSelectedState("true")
	else
		self.isBattlingController_:SetSelectedState("false")
	end

	if ActivityReforgeData:GetLevelIsFinish(self.chapterActivityID_, self.levelID_) then
		self.isPassController_:SetSelectedState("true")
	else
		self.isPassController_:SetSelectedState("false")
	end
end

function ActivityReforgeLevelViewItem:RefreshSelect(arg_8_1)
	if self.index_ == arg_8_1 then
		self.isSelectController_:SetSelectedState("true")
	else
		self.isSelectController_:SetSelectedState("false")
	end
end

function ActivityReforgeLevelViewItem:SetActive(arg_9_1)
	SetActive(self.gameObject_, arg_9_1)
end

function ActivityReforgeLevelViewItem:Dispose()
	self.super.Dispose(self)
end

return ActivityReforgeLevelViewItem
