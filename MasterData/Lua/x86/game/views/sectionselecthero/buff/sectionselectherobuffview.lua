local SectionSelectHeroBuffView = class("SectionSelectHeroBuffView", ReduxView)

function SectionSelectHeroBuffView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.emptyController_ = self.controllerEx_:GetController("state01")
	self.buffItemList_ = {}

	SetActive(self.gameObject_, true)
end

function SectionSelectHeroBuffView:OnEnter()
	return
end

function SectionSelectHeroBuffView:OnExit()
	return
end

function SectionSelectHeroBuffView:Dispose()
	for iter_4_0, iter_4_1 in ipairs(self.buffItemList_) do
		iter_4_1:Dispose()
	end

	self.buffItemList_ = nil

	SectionSelectHeroBuffView.super.Dispose(self)
end

function SectionSelectHeroBuffView:AddListeners()
	self:AddBtnListener(self.infoBtn_, nil, function()
		JumpTools.OpenPageByJump("sequentialBattleBuffInfo", {
			buffInfoActivityID = self.activityID_,
			stageID = self.stageID_
		})
	end)
end

function SectionSelectHeroBuffView:SetProxy(arg_7_1)
	self.sectionProxy_ = arg_7_1
	self.activityID_ = self.sectionProxy_.activityID
	self.stageID_ = self.sectionProxy_.stageID
end

function SectionSelectHeroBuffView:Refresh()
	self.enabledBuff_ = SequentialBattleTools.GetEnabledBuff(self.activityID_, (table.keyof(SequentialBattleChapterCfg[self.activityID_].stage_id, self.stageID_)))

	for iter_8_0 = 1, #self.enabledBuff_ do
		self.buffItemList_[iter_8_0] = self.buffItemList_[iter_8_0] or SectionSelectHeroBuffItem.New(self.buffItem_, self.buffParent_)

		self.buffItemList_[iter_8_0]:SetData(self.enabledBuff_[iter_8_0])
	end

	for iter_8_1 = #self.enabledBuff_ + 1, #self.buffItemList_ do
		self.buffItemList_[iter_8_1]:Show(false)
	end
end

return SectionSelectHeroBuffView
