local ActivityRhythmGameCommandItem = class("ActivityRhythmGameCommandItem", ReduxView)

function ActivityRhythmGameCommandItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivityRhythmGameCommandItem:Init()
	self:BindCfgUI()

	self.iconController_ = self.controllerEx_:GetController("icon")

	self:AddUIListener()
end

function ActivityRhythmGameCommandItem:InitOwnData()
	self.index_ = -1
	self.cfgID_ = -1
	self.activityID_ = -1
	self.cfg_ = {}
end

function ActivityRhythmGameCommandItem:OnExit()
	AtlasManager.UnloadSprite("Atlas/Summer2024Atlas", self.cfg_.pitcture_path)
end

function ActivityRhythmGameCommandItem:Dispose()
	ActivityRhythmGameCommandItem.super.Dispose(self)
end

function ActivityRhythmGameCommandItem:AddUIListener()
	self:AddBtnListener(self.battleBtn_, nil, function()
		self:StartBattle()
	end)
end

function ActivityRhythmGameCommandItem:SetData(arg_8_1, arg_8_2, arg_8_3)
	self.index_ = arg_8_1
	self.cfgID_ = arg_8_2
	self.cfg_ = ActivityRhythmGameCommandCfg[self.cfgID_]
	self.activityID_ = arg_8_3

	self:RefreshUI()
end

function ActivityRhythmGameCommandItem:RefreshUI()
	SetActive(self.battleGo_, self.cfg_.stage_id ~= 0)

	if self.index_ == 1 or self.index_ == 5 then
		self.iconController_:SetSelectedIndex(3)
		SetActive(self.messageTextGo_, false)
	else
		self.iconController_:SetSelectedIndex(self.index_ - 2)
		SetActive(self.messageTextGo_, true)
	end

	self.typeImg_.sprite = getSprite("Atlas/Summer2024Atlas", self.cfg_.pitcture_path)
	self.nameText_.text = self.cfg_.name
	self.descText_.text = self.cfg_.desc
end

function ActivityRhythmGameCommandItem:StartBattle()
	ActivityRhythmGameTools.StartBattle(self.cfg_.stage_id, self.cfg_.stage_id, self.activityID_)
end

return ActivityRhythmGameCommandItem
