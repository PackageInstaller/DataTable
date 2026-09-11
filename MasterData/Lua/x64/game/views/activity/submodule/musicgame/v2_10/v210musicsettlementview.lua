local EnternalMusicSettlementView = class("EnternalMusicSettlementView", ReduxView)

function EnternalMusicSettlementView:UIName()
	local var_1_0 = MusicData:GetNowMusicUINameList()

	if var_1_0 and var_1_0.scoreView then
		return var_1_0.scoreView
	else
		return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionMusicUI/MusicScoreUI"
	end
end

function EnternalMusicSettlementView:UIParent()
	return manager.ui.uiMain.transform
end

function EnternalMusicSettlementView:Cacheable()
	return false
end

function EnternalMusicSettlementView:Init()
	self:InitUI()
	self:AddUIListener()
end

function EnternalMusicSettlementView:InitUI()
	self:BindCfgUI()

	self.difficultController_ = ControllerUtil.GetController(self.transform_, "difficult")
	self.gradeController_ = ControllerUtil.GetController(self.transform_, "grade")
	self.newController_ = ControllerUtil.GetController(self.transform_, "new")
	self.evaluateController_ = ControllerUtil.GetController(self.transform_, "evaluate")
	self.linkTagController_ = self.controller_:GetController("linkTag")
	self.specialController_ = self.controller_:GetController("specialMode")
	self.ratingTipsList = {}

	for iter_5_0 = 0, self.ratingTrs_.childCount - 1 do
		table.insert(self.ratingTipsList, self.ratingTrs_:GetChild(iter_5_0):GetComponent("TipsAudio"))
	end
end

function EnternalMusicSettlementView:AddUIListener()
	self:AddBtnListener(self.m_restartBtn, nil, function()
		local var_7_0 = ActivityMusicCfg[MusicData:GetGameId()]

		if var_7_0 then
			SDKTools.SendMessageToSDK("activity_music_start", {
				is_restart = false,
				activity_id = var_7_0.activity_id,
				difficulty_id = var_7_0.difficult,
				other_data = MusicData:GetSpectralAndVercialSDKKey()
			})
		end

		MusicLuaBridge.ReStartMusicGame()
		self:Back()
	end)
	self:AddBtnListener(self.m_backBtn, nil, function()
		local var_8_0 = MusicData:GetMusicViewPathList(ActivityMusicCfg[MusicData:GetGameId()].activity_id)

		DestroyLua()

		if ActivityTools.GetActivityTheme((MusicData:GetPageActivityID())) == ActivityConst.THEME.ACTIVITY_3_11 then
			LaunchQWorld(true)
		else
			LuaExchangeHelper.GoToMain()
			OpenPageUntilLoaded(var_8_0.musicMain, {
				activity_id = var_8_0.activityID
			})
		end
	end)
end

function EnternalMusicSettlementView:OnTop()
	return
end

function EnternalMusicSettlementView:AddSpecialTimer()
	if self.specialTimer_ then
		self.specialTimer_:Stop()

		self.specialTimer_ = nil
	end

	self.specialController_:SetSelectedState("black")

	self.specialTimer_ = Timer.New(function()
		self.specialController_:SetSelectedState("normal")
		self.specialAni_:Play("UI_Acitvity_MusicGameUI_special_xs", 0, 0)
		self.specialAni_:Update(0)
	end, 0.85)

	self.specialTimer_:Start()
end

function EnternalMusicSettlementView:OnEnter()
	if self.params_.isSpecialPerformance or false then
		SetActive(self.specialObj_, true)
		self.ani_:Play("XH1stMusicScoreUI", 0, 1)
		self.ani_:Update(0)
		self.specialAni_:Play("UI_Acitvity_MusicGameUI_special", 0, 1)
		self.specialAni_:Update(0)
		self.specialTxt1Ani_:Play("UI_text_xs", 0, 0)
		self.specialTxt2Ani_:Play("UI_text_xs", 0, 0)
		self:AddSpecialTimer()
	else
		SetActive(self.specialObj_, false)
		self.specialController_:SetSelectedState("normal")
		manager.audio:Play("effect", "minigame_activity_2_0", "minigame_activity_2_0_musicgame_icon")
	end

	self:RefreshUI()

	self.params_.isSpecialPerformance = nil
end

function EnternalMusicSettlementView:RefreshUI()
	local var_13_0 = ActivityMusicCfg[MusicData:GetGameId()]

	self.m_name.text = GetI18NText(var_13_0.name)
	self.m_bg.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Music/Music_icon/" .. var_13_0.icon)
	self.bgImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Music/Music1_icon/" .. var_13_0.icon)

	if var_13_0.difficult == 1 then
		self.difficultController_:SetSelectedIndex(0)
	elseif var_13_0.difficult == 2 then
		self.difficultController_:SetSelectedIndex(1)
	elseif var_13_0.difficult == 9 then
		self.difficultController_:SetSelectedIndex(2)

		self.keyText_.text = string.format(GetTips("ACTIVITY_MUSIC_SETTING_KEY"), var_13_0.track)
	else
		self.difficultController_:SetSelectedIndex(3)
	end

	self.linkTagController_:SetSelectedIndex(var_13_0.tagType)

	local var_13_1 = MusicData:GetTagImagePath(var_13_0.id)

	if var_13_1 then
		self.linkImg_.sprite = getSpriteWithoutAtlas(var_13_1)
	end

	self.m_curScoreLab.text = self.params_.cur
	self.m_maxScoreLab.text = self.params_.max

	local var_13_2 = self.params_.cur / var_13_0.total_score * 100

	self.m_comboLab.text = MusicData:GetMaxComboHit()
	self.m_accuracyLab.text = string.format("%.2f%%", (self:KeepDecimalPlace(self.params_.cur / var_13_0.total_score * 100, 2)))

	local var_13_3 = MusicData:GetGameRecord(MusicConst.MusicNodeHitRating.Miss)
	local var_13_4 = MusicData:GetGameRecord(MusicConst.MusicNodeHitRating.Good)

	self.m_mistakeLab.text = var_13_3
	self.m_preciseLab.text = var_13_4
	self.m_perfectLab.text = MusicData:GetGameRecord(MusicConst.MusicNodeHitRating.Perfect)
	self.m_perfectPluasLab.text = MusicData:GetGameRecord(MusicConst.MusicNodeHitRating.PerfectPlus)

	if var_13_4 == 0 and var_13_3 == 0 then
		self.evaluateController_:SetSelectedIndex(2)
	elseif var_13_3 == 0 then
		self.evaluateController_:SetSelectedIndex(1)
	else
		self.evaluateController_:SetSelectedIndex(0)
	end

	self.newController_:SetSelectedIndex(self.params_.new and 1 or 0)

	local var_13_5 = self.params_.isSpecialPerformance or false

	for iter_13_0, iter_13_1 in pairs(self.ratingTipsList) do
		iter_13_1.enabled = false
	end

	for iter_13_2, iter_13_3 in ipairs(GameSetting.attach_music_grade.value) do
		if iter_13_3 <= var_13_2 then
			self.gradeController_:SetSelectedIndex(iter_13_2 - 1)

			if not var_13_5 then
				self.ratingTipsList[iter_13_2].enabled = true
			end

			break
		end
	end
end

function EnternalMusicSettlementView:KeepDecimalPlace(arg_14_1, arg_14_2)
	return math.floor(arg_14_1 * 10^arg_14_2) / 10^arg_14_2
end

function EnternalMusicSettlementView:OnExit()
	manager.windowBar:HideBar()
end

function EnternalMusicSettlementView:Dispose()
	if self.specialTimer_ then
		self.specialTimer_:Stop()

		self.specialTimer_ = nil
	end

	EnternalMusicSettlementView.super.Dispose(self)
end

return EnternalMusicSettlementView
