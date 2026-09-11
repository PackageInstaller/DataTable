local VolumeMusicSettlementView = class("VolumeMusicSettlementView", ReduxView)

function VolumeMusicSettlementView:UIName()
	return "UI/VolumeIIIDownUI/AthenaMusicGame/VolumeIIIDownMusicSettlementUI"
end

function VolumeMusicSettlementView:UIParent()
	return manager.ui.uiMain.transform
end

function VolumeMusicSettlementView:Init()
	self:InitUI()
	self:AddUIListener()
end

function VolumeMusicSettlementView:InitUI()
	self:BindCfgUI()

	self.difficultController_ = ControllerUtil.GetController(self.transform_, "difficult")
	self.gradeController_ = ControllerUtil.GetController(self.transform_, "grade")
	self.fullComboController_ = ControllerUtil.GetController(self.transform_, "fullCombo")
	self.newController_ = ControllerUtil.GetController(self.transform_, "new")
end

function VolumeMusicSettlementView:AddUIListener()
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
		OpenPageUntilLoaded("/volumeMusicMain", {
			activity_id = ActivityConst.VOLUME_MUSIC
		})
	end)
end

function VolumeMusicSettlementView:OnTop()
	manager.windowBar:SwitchBar({})
end

function VolumeMusicSettlementView:OnEnter()
	self:RefreshUI()
end

function VolumeMusicSettlementView:RefreshUI()
	local var_10_0 = ActivityMusicCfg[MusicData:GetGameId()]

	self.m_name.text = GetI18NText(var_10_0.name)
	self.m_bg.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VolumeIIIDownUI/" .. var_10_0.icon)

	if var_10_0.difficult == 2 then
		self.difficultController_:SetSelectedIndex(1)
	elseif var_10_0.difficult == 9 then
		self.difficultController_:SetSelectedIndex(2)
	else
		self.difficultController_:SetSelectedIndex(0)
	end

	self.m_curScoreLab.text = self.params_.cur
	self.m_maxScoreLab.text = self.params_.max

	local var_10_1 = self.params_.cur / var_10_0.total_score * 100

	self.m_comboLab.text = MusicData:GetMaxComboHit()
	self.m_accuracyLab.text = string.format("%.2f%%", var_10_1)

	local var_10_2 = MusicData:GetGameRecord(-1)

	self.m_perfectLab.text = MusicData:GetGameRecord(1)
	self.m_preciseLab.text = MusicData:GetGameRecord(0)
	self.m_mistakeLab.text = var_10_2

	if var_10_2 == 0 then
		self.fullComboController_:SetSelectedIndex(1)
	else
		self.fullComboController_:SetSelectedIndex(0)
	end

	self.newController_:SetSelectedIndex(self.params_.new and 1 or 0)

	for iter_10_0, iter_10_1 in ipairs(GameSetting.attach_music_grade.value) do
		if iter_10_1 <= var_10_1 then
			self.gradeController_:SetSelectedIndex(iter_10_0 - 1)

			break
		end
	end
end

function VolumeMusicSettlementView:OnExit()
	manager.windowBar:HideBar()
end

function VolumeMusicSettlementView:Dispose()
	VolumeMusicSettlementView.super.Dispose(self)
end

return VolumeMusicSettlementView
