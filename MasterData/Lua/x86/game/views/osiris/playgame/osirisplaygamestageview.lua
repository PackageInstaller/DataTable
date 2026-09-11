local OsirisPlayGameStageView = class("OsirisPlayGameStageView", ReduxView)

function OsirisPlayGameStageView:UIName()
	return "Widget/System/Activity_Osiris/Activity_Osiris_PlayUI"
end

function OsirisPlayGameStageView:UIParent()
	return manager.ui.uiMain.transform
end

function OsirisPlayGameStageView:Init()
	self:InitUI()
	self:AddUIListener()
end

function OsirisPlayGameStageView:InitUI()
	self:BindCfgUI()

	self.items_ = {}

	for iter_4_0 = 1, 3 do
		self.items_[iter_4_0] = OsirisPlayGameStageItem.New(self["stageGo_" .. iter_4_0], iter_4_0)
	end
end

function OsirisPlayGameStageView:OnEnter()
	if self.params_.chapterID then
		self.chapterID = self.params_.chapterID
	end

	self.stage_id = self.params_.stage_id

	if self.params_.isFailed ~= nil then
		self.isFailed = self.params_.isFailed
	end

	if not self.isShowTips and self.params_.isShowTips then
		self.isShowTips = self.params_.isShowTips
	end

	self.stage_id_list = ActivityGeneralityStageCfg.get_id_list_by_chapter_id[self.chapterID]

	self:RefreshStory()
	self:RefreshUI()
	self:RefreshItems()
end

function OsirisPlayGameStageView:ShowTips()
	if OsirisPlayGameData:GetPassStagesNumByChapterId(self.chapterID) == 3 then
		self.tipstimer_ = Timer.New(function()
			self:TipsStopTimer()

			self.isShowTips = nil

			JumpTools.OpenPageByJump("osirisPlayGameTipsView", {
				chapterID = self.chapterID
			})
		end, 1.5, 1)

		self.tipstimer_:Start()
	end
end

function OsirisPlayGameStageView:RefreshStory()
	if OsirisPlayGameData:GetPlayStory(GameSetting.activity_generality_end_story.value[1]) ~= 1 and self.stage_id == 5260163 then
		manager.story:StartStory(GameSetting.activity_generality_end_story.value[1])
		OsirisPlayGameData:SetPlayStory(GameSetting.activity_generality_end_story.value[1])
	end
end

function OsirisPlayGameStageView:AddUIListener()
	return
end

function OsirisPlayGameStageView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function OsirisPlayGameStageView:RefreshUI()
	local var_11_0 = ActivityGeneralityChapterCfg[self.chapterID]

	self.chapterNameTxt_.text = GetI18NText(ActivityGeneralityChapterCfg[self.chapterID].chapter_name)
	self.descTxt_.text = GetI18NText(ActivityGeneralityTagCfg[tonumber(var_11_0.icon)].desc)

	local var_11_1 = OsirisPlayGameData:GetPassStagesNumByChapterId(self.chapterID)

	self.slider_.value = var_11_1 - 1 < 0 and 0 or var_11_1 - 1
	self.logoImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Osiris/" .. var_11_0.icon)

	local var_11_2 = self:GetOpenUnlockPopView()

	if var_11_2 ~= 0 then
		self.isShowTips = 2

		local var_11_3 = ActivityGeneralityStageCfg[ActivityGeneralityStageCfg.get_id_list_by_stage_id[var_11_2][1]].unlock_charactor

		if ActivityGeneralityStageCfg[ActivityGeneralityStageCfg.get_id_list_by_stage_id[var_11_2][1]].unlock_charactor > 0 then
			self.timer_ = Timer.New(function()
				self:StopTimer()
				JumpTools.OpenPageByJump("/osirisPlayGameUnlockPopView", {
					heroId = var_11_3
				})
			end, 1.5, 1)

			self.timer_:Start()
		elseif self.isShowTips and self.isShowTips == 2 then
			self:ShowTips()
		end
	elseif self.isShowTips and self.isShowTips == 2 then
		self:ShowTips()
	end

	self.slider_.value = OsirisPlayGameData:GetPassStagesNumByChapterId(self.chapterID) + 1
end

function OsirisPlayGameStageView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function OsirisPlayGameStageView:TipsStopTimer()
	if self.tipstimer_ then
		self.tipstimer_:Stop()

		self.tipstimer_ = nil
	end
end

function OsirisPlayGameStageView:GetOpenUnlockPopView()
	for iter_15_0, iter_15_1 in pairs((OsirisPlayGameData:GetPassStageClearTimes())) do
		if iter_15_1 == 0 then
			OsirisPlayGameData:SetPassStageClearTimes(iter_15_0)

			return iter_15_0
		end
	end

	return 0
end

function OsirisPlayGameStageView:RefreshItems()
	for iter_16_0 = 1, #self.items_ do
		if self.stage_id_list[iter_16_0] then
			self.items_[iter_16_0]:RefreshView(self.stage_id_list[iter_16_0], self.stage_id, self.isFailed)
		end
	end
end

function OsirisPlayGameStageView:OnExit()
	manager.windowBar:HideBar()
	OsirisPlayGameStageView.super.OnExit(self)
end

function OsirisPlayGameStageView:Dispose()
	for iter_18_0 = 1, #self.items_ do
		self.items_[iter_18_0]:Dispose()
	end

	self:StopTimer()
	self:TipsStopTimer()
	OsirisPlayGameStageView.super.Dispose(self)
end

return OsirisPlayGameStageView
