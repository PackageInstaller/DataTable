local VolumeMusicMainView = class("VolumeMusicMainView", ReduxView)

function VolumeMusicMainView:UIName()
	return "UI/VolumeIIIDownUI/AthenaMusicGame/VolumeIIIDownMusicMainUI"
end

function VolumeMusicMainView:UIParent()
	return manager.ui.uiMain.transform
end

function VolumeMusicMainView:Init()
	self:InitUI()
	self:AddUIListener()

	self.pageIndex = 1
end

function VolumeMusicMainView:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.m_list, VolumeMusicMainItem)
	self.lockController = ControllerUtil.GetController(self.transform_, "lock")
end

function VolumeMusicMainView:AddUIListener()
	self:AddBtnListener(self.m_rewardBtn, nil, function()
		JumpTools.OpenPageByJump("VolumeMusicReward")
	end)
	self:AddBtnListener(self.m_settingBtn, nil, function()
		JumpTools.OpenPageByJump("voumeMusicSetting")
	end)
	self:AddBtnListener(self.m_palyBtn, nil, function()
		MusicAction.Play(ActivityMusicCfg.get_id_list_by_activity_id[self.musics[self.pageIndex]][MusicData:GetDifficultyIndex(self.musics[self.pageIndex]) + 1])
	end)
	self.m_scroller.onValueChanged:AddListener(function()
		for iter_9_0, iter_9_1 in pairs((self.list_:GetItemList())) do
			iter_9_1:UpdateScale(self.m_viewport)
		end
	end)
	self.list_:SetPageChangeHandler(handler(self, self.OnPageChange))
end

function VolumeMusicMainView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_MUSIC_DESCRIBE")
end

function VolumeMusicMainView:OnEnter()
	local var_11_0 = SettingData:GetSoundSettingData()

	if var_11_0 and var_11_0.music then
		manager.audio:SetVolume("music", var_11_0.music / 100)
	end

	self.activity_id = self.params_.activity_id
	self.musics = {}

	for iter_11_0, iter_11_1 in ipairs(ActivityCfg[self.activity_id].sub_activity_list) do
		if ActivityCfg[iter_11_1] and ActivityTemplateConst.ACTIVITY_MUSIC_GAME then
			table.insert(self.musics, iter_11_1)
		end
	end

	self.pageIndex = MusicData:GetSelectIndex(self.activity_id)

	self.list_:StartScroll(#self.musics, self.pageIndex, true, false)
	self.list_:SwitchToPage(self.pageIndex)
	self:OnPageChange(self.pageIndex)
	self:RefrenTime()

	self.timer = Timer.New(function()
		self:RefrenTime()
	end, 1, -1)

	self.timer:Start()
	MusicAction.SetMusicRead(self.activity_id)
	manager.redPoint:bindUIandKey(self.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_REWARD, self.activity_id))
end

function VolumeMusicMainView:OnExit()
	manager.windowBar:HideBar()

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	manager.redPoint:unbindUIandKey(self.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_REWARD, self.activity_id))
end

function VolumeMusicMainView:RefrenTime()
	local var_14_0 = ActivityData:GetActivityData(self.activity_id)

	self.m_timeLab.text = var_14_0 and var_14_0:IsActivitying() and manager.time:GetLostTimeStr(var_14_0.stopTime) or GetTips("TIME_OVER")

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_timeLab.transform)

	for iter_14_0, iter_14_1 in pairs((self.list_:GetItemList())) do
		iter_14_1:RefrenTime()
	end

	if ActivityData:GetActivityIsOpen(self.musics[self.pageIndex]) then
		self.lockController:SetSelectedIndex(1)
	else
		self.lockController:SetSelectedIndex(0)
	end
end

function VolumeMusicMainView:IndexItem(arg_15_1, arg_15_2)
	arg_15_2:SetData(self.musics[arg_15_1])
end

function VolumeMusicMainView:OnPageChange(arg_16_1)
	if arg_16_1 > #self.musics then
		arg_16_1 = #self.musics
	end

	self.pageIndex = arg_16_1

	MusicData:SetSelectIndex(self.pageIndex)

	if ActivityData:GetActivityIsOpen(self.musics[arg_16_1]) then
		self.lockController:SetSelectedIndex(1)
	else
		self.lockController:SetSelectedIndex(0)
	end

	self:PlayBg()
end

function VolumeMusicMainView:PlayBg()
	manager.audio:PlayBGM(ActivityMusicCfg[ActivityMusicCfg.get_id_list_by_activity_id[self.musics[self.pageIndex]][MusicData:GetDifficultyIndex(self.musics[self.pageIndex]) + 1] or ActivityMusicCfg.get_id_list_by_activity_id[self.musics[self.pageIndex]][1]].cueSheetName, ActivityMusicCfg[ActivityMusicCfg.get_id_list_by_activity_id[self.musics[self.pageIndex]][MusicData:GetDifficultyIndex(self.musics[self.pageIndex]) + 1] or ActivityMusicCfg.get_id_list_by_activity_id[self.musics[self.pageIndex]][1]].cueName, ActivityMusicCfg[ActivityMusicCfg.get_id_list_by_activity_id[self.musics[self.pageIndex]][MusicData:GetDifficultyIndex(self.musics[self.pageIndex]) + 1] or ActivityMusicCfg.get_id_list_by_activity_id[self.musics[self.pageIndex]][1]].awbFile)
end

function VolumeMusicMainView:Dispose()
	self.list_:Dispose()
	VolumeMusicMainView.super.Dispose(self)
end

return VolumeMusicMainView
