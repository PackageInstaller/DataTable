local EnternalMusicMainView = class("EnternalMusicMainView", ReduxView)

function EnternalMusicMainView:UIName()
	return "UI/VersionUI/XuHeng1stUI/Music/XH1stMusicMainUI"
end

function EnternalMusicMainView:UIParent()
	return manager.ui.uiMain.transform
end

function EnternalMusicMainView:Init()
	self:InitUI()
	self:AddUIListener()

	self.pageIndex = 1
end

function EnternalMusicMainView:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.m_list, EnternalMusicMainItem)
	self.lockController = ControllerUtil.GetController(self.transform_, "lock")
end

function EnternalMusicMainView:AddUIListener()
	self:AddBtnListener(self.m_rewardBtn, nil, function()
		JumpTools.OpenPageByJump("enternalMusicReward")
	end)
	self:AddBtnListener(self.m_settingBtn, nil, function()
		JumpTools.OpenPageByJump("/enternalMusicSetting")
	end)
	self:AddBtnListener(self.m_palyBtn, nil, function()
		MusicAction.Play(ActivityMusicCfg.get_id_list_by_activity_id[self.musics[self.pageIndex]][MusicData:GetDifficultyIndex(self.musics[self.pageIndex]) + 1])
	end)
	self.list_:SetPageChangeHandler(handler(self, self.OnPageChange))
end

function EnternalMusicMainView:OnTop()
	local var_9_0

	if GameSetting.enternal_music_describe then
		var_9_0 = GameSetting.enternal_music_describe.value or {}
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			pages = var_9_0
		}
	})
end

function EnternalMusicMainView:OnEnter()
	local var_10_0 = SettingData:GetSoundSettingData()

	if var_10_0 and var_10_0.music then
		manager.audio:SetVolume("music", var_10_0.music / 100)
	end

	self.activity_id = self.params_.activity_id
	self.musics = {}

	for iter_10_0, iter_10_1 in ipairs(ActivityCfg[self.activity_id].sub_activity_list) do
		if ActivityCfg[iter_10_1] and ActivityTemplateConst.ACTIVITY_MUSIC_GAME then
			table.insert(self.musics, iter_10_1)
		end
	end

	self.pageIndex = MusicData:GetSelectIndex(self.activity_id)

	self.list_:StartScroll(#self.musics, self.pageIndex, true, false)
	self.list_:SwitchToPage(self.pageIndex)

	self.BGMID = 0

	MusicData:SetDifficultIndex(self.musics[self.pageIndex], (math.min(MusicData:GetDifficultyIndex(self.musics[self.pageIndex]), 1)))
	self:OnPageChange(self.pageIndex)
	self:RefrenTime()

	self.timer = Timer.New(function()
		self:RefrenTime()
		self:RefrenBGM()
	end, 1, -1)

	self.timer:Start()
	MusicAction.SetMusicRead(self.activity_id)
	manager.redPoint:bindUIandKey(self.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_REWARD, self.activity_id))

	if not getData("EnternalMusic", "showHelp") then
		JumpTools.OpenPageByJump("gameHelpPro", {
			pages = (GameSetting.enternal_music_describe or nil) and (GameSetting.enternal_music_describe.value or {})
		})
		saveData("EnternalMusic", "showHelp", 1)
	end
end

function EnternalMusicMainView:OnExit()
	manager.windowBar:HideBar()

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	manager.redPoint:unbindUIandKey(self.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_REWARD, self.activity_id))
end

function EnternalMusicMainView:RefrenTime()
	local var_13_0 = ActivityData:GetActivityData(self.activity_id)

	self.m_timeLab.text = var_13_0 and var_13_0:IsActivitying() and manager.time:GetLostTimeStr(var_13_0.stopTime) or GetTips("TIME_OVER")

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_timeLab.transform)

	for iter_13_0, iter_13_1 in pairs((self.list_:GetItemList())) do
		iter_13_1:RefrenTime()
	end

	if ActivityData:GetActivityIsOpen(self.musics[self.pageIndex]) then
		self.lockController:SetSelectedIndex(1)
	else
		self.lockController:SetSelectedIndex(0)
	end
end

function EnternalMusicMainView:IndexItem(arg_14_1, arg_14_2)
	arg_14_2:SetData(self.musics[arg_14_1])
end

function EnternalMusicMainView:OnPageChange(arg_15_1)
	if arg_15_1 > #self.musics then
		arg_15_1 = #self.musics
	end

	self.pageIndex = arg_15_1

	MusicData:SetSelectIndex(self.pageIndex)

	if ActivityData:GetActivityIsOpen(self.musics[arg_15_1]) then
		self.lockController:SetSelectedIndex(1)
	else
		self.lockController:SetSelectedIndex(0)
	end

	self:PlayBg()
end

function EnternalMusicMainView:PlayBg()
	manager.audio:ClearBGMFlag()

	if not self.musics[self.pageIndex] then
		return
	end

	local var_16_0 = ActivityMusicCfg.get_id_list_by_activity_id[self.musics[self.pageIndex]][MusicData:GetDifficultyIndex(self.musics[self.pageIndex]) + 1] or ActivityMusicCfg.get_id_list_by_activity_id[self.musics[self.pageIndex]][1]
	local var_16_1 = ActivityMusicCfg[var_16_0]

	if ActivityMusicCfg[var_16_0].aisacKey ~= "" then
		manager.audio:SetBgmAisacControl(var_16_1.aisacKey, var_16_1.aisacValue)
	end

	self.BGMID = var_16_0

	manager.audio:PlayBGM(var_16_1.cueSheetName, var_16_1.cueName, var_16_1.awbFile)
end

function EnternalMusicMainView:RefrenBGM()
	if not self.musics[self.pageIndex] then
		return
	end

	if self.BGMID == (ActivityMusicCfg.get_id_list_by_activity_id[self.musics[self.pageIndex]][MusicData:GetDifficultyIndex(self.musics[self.pageIndex]) + 1] or ActivityMusicCfg.get_id_list_by_activity_id[self.musics[self.pageIndex]][1]) then
		return
	end

	self:PlayBg()
end

function EnternalMusicMainView:Dispose()
	self.list_:Dispose()
	EnternalMusicMainView.super.Dispose(self)
end

return EnternalMusicMainView
