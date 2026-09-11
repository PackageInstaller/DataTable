local OsirisPlayGameSectionInfoView = class("OsirisPlayGameSectionInfoView", (import("game.views.sectionInfo.SectionInfoBaseView")))

function OsirisPlayGameSectionInfoView:UIName()
	return "Widget/System/Activity_Osiris/Activity_Osiris_ChapterSectionInfoUI"
end

function OsirisPlayGameSectionInfoView:Init()
	OsirisPlayGameSectionInfoView.super.Init(self)
end

function OsirisPlayGameSectionInfoView:OnEnter()
	self.stageID_ = self.params_.section
	self.stageType_ = self.params_.sectionType or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED

	manager.notify:RegistListener(CURRENCY_UPDATE, self.currencyUpdateHandle_)
	self:RefreshData()
	self:RefreshUI()
	self:RefreshTitleDesc()
	self:UpdateBar()

	self.backCall = self.params_.backCall
end

function OsirisPlayGameSectionInfoView:OnClickBtn()
	JumpTools.OpenPageByJump("/osirisPlayGameSectionSelectHeroView", {
		section = ActivityGeneralityStageCfg[self.stageID_].stage_id,
		sectionType = BattleConst.STAGE_TYPE_NEW.OSIRIS_PLAY_GAME,
		activityID = self.params_.activityID_,
		heroDataType = HeroConst.HERO_DATA_TYPE.OSIRISPLAYGAME
	})
end

function OsirisPlayGameSectionInfoView:RefreshStageInfo()
	self.hideFatigueController_:SetSelectedState("close")

	local var_5_0 = BattleStageTools.GetStageCfg(self.stageType_, ActivityGeneralityStageCfg[self.stageID_].stage_id)

	if self.oldCfgID_ ~= var_5_0.id then
		local var_5_1, var_5_2 = BattleStageTools.GetChapterSectionIndex(self.stageType_, self.stageID_)

		self.sectionText_.text = string.format("%s-%s", GetI18NText(var_5_1), GetI18NText(var_5_2))
		self.sectionName_.text = GetI18NText(var_5_0.name)
		self.oldCfgID_ = var_5_0.id

		local var_5_3 = ActivityGeneralityStageCfg[self.stageID_].generality

		self.titleText_.text = GetI18NText(ActivityGeneralityTagCfg[ActivityGeneralityStageCfg[self.stageID_].generality].name)
		self.descText_.text = GetI18NText(ActivityGeneralityTagCfg[ActivityGeneralityStageCfg[self.stageID_].generality].desc)

		local var_5_4 = OsirisPlayGameData:GetStageInfoById(ActivityGeneralityStageCfg[self.stageID_].stage_id)

		if var_5_4.point then
			self.maxScoreText_.text = var_5_4.point or 0
		end

		self.typeTagIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Osiris/" .. var_5_3)
	end
end

function OsirisPlayGameSectionInfoView:UpdateBar()
	local var_6_0 = BattleStageTools.GetStageCfg(self.stageType_, self.stageID_)

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		self.backCall()
		JumpTools.Back()
	end)
	manager.windowBar:RegistHomeCallBack(function()
		self.backCall()
		gameContext:Go("/home", nil, nil, true)
	end)
end

function OsirisPlayGameSectionInfoView:OnExit()
	self.super.OnExit(self)
	manager.windowBar:HideBar()
end

return OsirisPlayGameSectionInfoView
