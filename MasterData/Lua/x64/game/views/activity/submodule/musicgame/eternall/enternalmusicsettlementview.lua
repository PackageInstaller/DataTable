local EnternalMusicSettlementView = class("EnternalMusicSettlementView", ReduxView)

function EnternalMusicSettlementView:UIName()
	return "UI/VersionUI/XuHeng1stUI/Music/XH1stMusicScoreUI"
end

function EnternalMusicSettlementView:UIParent()
	return manager.ui.uiMain.transform
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
end

function EnternalMusicSettlementView:AddUIListener()
	self:AddBtnListener(self.m_restartBtn, nil, function()
		local var_6_0 = ActivityMusicCfg[MusicData:GetGameId()]

		if var_6_0 then
			SDKTools.SendMessageToSDK("activity_music_start", {
				is_restart = false,
				activity_id = var_6_0.activity_id,
				difficulty_id = var_6_0.difficult
			})
		end

		MusicLuaBridge.ReStartMusicGame()
		self:Back()
	end)
	self:AddBtnListener(self.m_backBtn, nil, function()
		DestroyLua()
		LuaExchangeHelper.GoToMain()
		OpenPageUntilLoaded("/enternalMusicMain", {
			activity_id = ActivityConst.ENTERNAL_MUSIC
		})
	end)
	self:AddBtnListener(self.m_backBtn, nil, function()
		DestroyLua()
		LuaExchangeHelper.GoToMain()
		OpenPageUntilLoaded("/enternalMusicMain", {
			activity_id = ActivityConst.ENTERNAL_MUSIC
		})
	end)
end

function EnternalMusicSettlementView:OnTop()
	manager.windowBar:SwitchBar({})
end

function EnternalMusicSettlementView:OnEnter()
	self:RefreshUI()
end

function EnternalMusicSettlementView:RefreshUI()
	local var_11_0 = ActivityMusicCfg[MusicData:GetGameId()]

	self.m_name.text = GetI18NText(var_11_0.name)
	self.m_bg.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng1stUI/" .. var_11_0.icon)

	if var_11_0.difficult == 2 then
		self.difficultController_:SetSelectedIndex(1)
	elseif var_11_0.difficult == 9 then
		self.difficultController_:SetSelectedIndex(2)
	else
		self.difficultController_:SetSelectedIndex(0)
	end

	self.m_curScoreLab.text = self.params_.cur
	self.m_maxScoreLab.text = self.params_.max

	local var_11_1 = self.params_.cur / var_11_0.total_score * 100

	self.m_comboLab.text = MusicData:GetMaxComboHit()
	self.m_accuracyLab.text = string.format("%.2f%%", var_11_1)

	local var_11_2 = MusicData:GetGameRecord(MusicConst.MusicNodeHitRating.Miss)
	local var_11_3 = MusicData:GetGameRecord(MusicConst.MusicNodeHitRating.Good)

	self.m_mistakeLab.text = var_11_2
	self.m_preciseLab.text = var_11_3
	self.m_perfectLab.text = MusicData:GetGameRecord(MusicConst.MusicNodeHitRating.Perfect)
	self.m_perfectPluasLab.text = MusicData:GetGameRecord(MusicConst.MusicNodeHitRating.PerfectPlus)

	if var_11_3 == 0 and var_11_2 == 0 then
		self.evaluateController_:SetSelectedIndex(2)
	elseif var_11_2 == 0 then
		self.evaluateController_:SetSelectedIndex(1)
	else
		self.evaluateController_:SetSelectedIndex(0)
	end

	self.newController_:SetSelectedIndex(self.params_.new and 1 or 0)

	for iter_11_0, iter_11_1 in ipairs(GameSetting.attach_music_grade.value) do
		if iter_11_1 <= var_11_1 then
			self.gradeController_:SetSelectedIndex(iter_11_0 - 1)

			break
		end
	end
end

function EnternalMusicSettlementView:OnExit()
	manager.windowBar:HideBar()
end

function EnternalMusicSettlementView:Dispose()
	EnternalMusicSettlementView.super.Dispose(self)
end

return EnternalMusicSettlementView
