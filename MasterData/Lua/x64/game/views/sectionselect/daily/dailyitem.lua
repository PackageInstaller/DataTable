local DailyItem = class("DailyItem", (import("game.views.sectionSelect.SectionBaseItem")))

function DailyItem:IsOpenSectionInfo()
	return self:IsOpenRoute("dailySectionInfo")
end

function DailyItem:InitCustom()
	SetActive(self.collectGo_, false)
	self.showStarController_:SetSelectedState("false")
end

function DailyItem:ShowRedPoint()
	SetActive(self.noticeContainer_.gameObject, true)
	manager.redPoint:unbindUIandKey(self.noticeContainer_)
	manager.redPoint:bindUIandKey(self.noticeContainer_, DailyNewRedPoint:GetNewRedKey(self.stageID_))
end

function DailyItem:GetPosition()
	return (BattleDailyStageCfg[self.stageID_] or nil) and (BattleDailyStageCfg[self.stageID_].position or {
		0,
		0
	})
end

function DailyItem:RefreshData()
	local var_5_0 = BattleStageData:GetStageData()[self.stageID_]

	if var_5_0 then
		self.isLock_ = false
		self.clearTimes_ = var_5_0.clear_times
		self.starCnt_ = 3
	else
		self.isLock_ = true
		self.clearTimes_ = 0
		self.starCnt_ = 0
	end

	self.enoughLevel_ = PlayerData:GetPlayerInfo().userLevel >= BattleDailyStageCfg[self.stageID_].level
end

function DailyItem:OnClick()
	if self.isLock_ then
		-- block empty
	else
		DailyNewRedPoint:CancelNewTag(self.stageID_)
		BattleFieldData:SetStageByClientID(self.chapterID_, self.stageID_)
		self:Go("dailySectionInfo", {
			chapterID = self.chapterID_,
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY,
			section = self.stageID_
		})
	end
end

function DailyItem:RefreshText()
	local var_7_0, var_7_1 = BattleStageTools.GetChapterSectionIndex(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY, self.stageID_)

	self.text_.text = string.format("%s-%s", GetI18NText(var_7_0), GetI18NText(var_7_1))
end

function DailyItem:Dispose()
	DailyItem.super.Dispose(self)
	manager.redPoint:unbindUIandKey(self.noticeContainer_, DailyNewRedPoint:GetNewRedKey(self.stageID_))
end

return DailyItem
