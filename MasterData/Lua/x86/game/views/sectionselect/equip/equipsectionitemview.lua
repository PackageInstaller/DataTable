local EquipSectionItemView = class("EquipSectionItemView", import("game.views.sectionSelect.SectionBaseItem"))

function EquipSectionItemView:IsOpenSectionInfo()
	return self:IsOpenRoute("equipSectionInfo")
end

function EquipSectionItemView:InitCustom()
	SetActive(self.collectGo_, false)
	SetActive(self.storyIconGo_, false)
	self.showStarController_:SetSelectedState("false")
	manager.redPoint:bindUIandKey(self.noticeContainer_, BattleEquipData:GetNewRedPrefix() .. self.level_)
end

function EquipSectionItemView:AddListeners()
	self:AddBtnListener(self.itemBtn_, nil, function()
		BattleEquipData:CancelNewTag(self.level_)
		self:Go("equipSectionInfo", {
			chapterID = self.chapterID_,
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP,
			section = self.stageID_
		})
	end)
end

function EquipSectionItemView:RefreshData()
	self.level_ = BattleInstance.GetHardLevel(self.stageID_)
end

function EquipSectionItemView:RefreshUI()
	local var_6_0 = self:GetPosition()

	self.transform_.localPosition = Vector3(var_6_0[1], var_6_0[2], 0)
	self.isLock_ = JumpTools.IsConditionLocked({
		ViewConst.SYSTEM_LOCK_TYPE.LEVEL,
		GameSetting.equip_stage_unlock.value[self.level_]
	})

	self.isBossController_:SetSelectedState("false")
	self:RefreshText()
	self:ShowRedPoint()
end

function EquipSectionItemView:ShowRedPoint()
	return
end

function EquipSectionItemView:GetPosition()
	return (BattleEquipStageCfg[self.stageID_] or nil) and (BattleEquipStageCfg[self.stageID_].position or {
		0,
		0
	})
end

function EquipSectionItemView:RefreshText()
	local var_9_0, var_9_1 = BattleStageTools.GetChapterSectionIndex(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP, self.stageID_)

	self.text_.text = string.format("%s%s", GetI18NText(var_9_0), GetI18NText(var_9_1))
end

function EquipSectionItemView:Dispose()
	EquipSectionItemView.super.Dispose(self)
	manager.redPoint:unbindUIandKey(self.noticeContainer_, BattleEquipData:GetNewRedPrefix() .. self.level_)
end

return EquipSectionItemView
