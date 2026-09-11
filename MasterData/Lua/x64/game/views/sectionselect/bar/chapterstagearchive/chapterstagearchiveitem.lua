local ChapterStageArchiveItem = class("ChapterStageArchiveItem", ReduxView)

function ChapterStageArchiveItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.lockController_ = ControllerUtil.GetController(self.transform_, "lock")
end

function ChapterStageArchiveItem:OnEnter()
	return
end

function ChapterStageArchiveItem:OnExit()
	self:UnBindRedPoint(self.archiveID_)
end

function ChapterStageArchiveItem:Dispose()
	ChapterStageArchiveItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function ChapterStageArchiveItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if self.isLock_ then
			ShowTips(string.format(GetTips("ACTIVITY_RACE_UNLOCK"), BattleStageTools.GetStageCfg(ChapterCfg[self.chapterID_].type, self.stageID_).name))

			return
		end

		manager.notify:Invoke(CHAPTER_SCROLL_STOP)
		BattleStageAction.ClickChapterArchive(self.archiveID_)
		JumpTools.OpenPageByJump("chapterStageArchiveInfo", {
			archiveID = self.archiveID_
		})

		self.isLock_ = false

		self:RefreshLockState()
	end)
end

function ChapterStageArchiveItem:Show(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

function ChapterStageArchiveItem:SetData(arg_8_1, arg_8_2, arg_8_3)
	self:UnBindRedPoint(self.archiveID_)
	self:BindRedPoint(arg_8_3)

	self.archiveID_ = arg_8_3
	self.chapterID_ = arg_8_1
	self.stageID_ = arg_8_2
	self.isLock_ = BattleStageData:GetStageData()[arg_8_2].clear_times <= 0

	self:RefreshLockState()

	self.transform_.localPosition = Vector3(StageArchiveCfg[arg_8_3].position[1], StageArchiveCfg[arg_8_3].position[2], 0)
	self.titleText_.text = GetI18NText(StageArchiveCfg[arg_8_3].name)

	self:Show(true)
end

function ChapterStageArchiveItem:RefreshLockState()
	self.lockController_:SetSelectedState(tostring(self.isLock_))
end

function ChapterStageArchiveItem:BindRedPoint(arg_10_1)
	manager.redPoint:bindUIandKey(self.redPointTf_, string.format("%s_%s", RedPointConst.COMBAT_CHAPTER_ARCHIVE, arg_10_1))
end

function ChapterStageArchiveItem:UnBindRedPoint(arg_11_1)
	if arg_11_1 then
		manager.redPoint:unbindUIandKey(self.redPointTf_, string.format("%s_%s", RedPointConst.COMBAT_CHAPTER_ARCHIVE, arg_11_1))
	end
end

return ChapterStageArchiveItem
