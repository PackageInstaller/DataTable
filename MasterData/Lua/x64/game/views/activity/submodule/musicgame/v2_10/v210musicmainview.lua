local V210MusicMainView = class("V210MusicMainView", ReduxView)

function V210MusicMainView:UIName()
	local var_1_0 = MusicData:GetNowMusicUINameList()

	if var_1_0 and var_1_0.mainView then
		return var_1_0.mainView
	else
		return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionMusicUI/MusicMainUI"
	end
end

function V210MusicMainView:UIParent()
	return manager.ui.uiMain.transform
end

function V210MusicMainView:Init()
	self:InitUI()
	self:AddUIListener()

	self.pageIndex = 1
end

function V210MusicMainView:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.m_list, V210MusicMainItem)
	self.lockController = ControllerUtil.GetController(self.transform_, "lock")
	self.openToggleController = ControllerUtil.GetController(self.toggleTrs_, "open")
	self.useShowToggleController = ControllerUtil.GetController(self.toggleTrs_, "useShow")
end

function V210MusicMainView:AddUIListener()
	self:AddBtnListener(self.m_rewardBtn, nil, function()
		JumpTools.OpenPageByJump("V210MusicReward")
	end)
	self:AddBtnListener(self.m_settingBtn, nil, function()
		JumpTools.OpenPageByJump("/V210MusicSetting")
	end)
	self:AddBtnListener(self.m_palyBtn, nil, function()
		MusicAction.Play(ActivityMusicCfg.get_id_list_by_activity_id[self.musics[self.pageIndex]][MusicData:GetDifficultyIndex(self.musics[self.pageIndex]) + 1])
	end)
	self:AddBtnListener(self.nowmusicBtn_, nil, function()
		self:UpdateMusicListShow(0)
	end)
	self:AddBtnListener(self.backmusic1Btn_, nil, function()
		self:UpdateMusicListShow(1)
	end)
	self:AddBtnListener(self.backmusic2Btn_, nil, function()
		self:UpdateMusicListShow(2)
	end)
	self:AddBtnListener(self.backmusic3Btn_, nil, function()
		self:UpdateMusicListShow(3)
	end)
	self:AddBtnListener(self.togglebtnBtn_, nil, function()
		self.openToggleController:SetSelectedIndex(self.openToggleController:GetSelectedState() == "true" and 0 or 1)
	end)
	self:AddBtnListener(self.togglerootclosebtnBtn_, nil, function()
		self.openToggleController:SetSelectedIndex(0)
	end)
	self.list_:SetPageChangeHandler(handler(self, self.OnPageChange))
	self.m_scroller.onValueChanged:AddListener(function()
		self:OnScrollerMove()
	end)
end

function V210MusicMainView:GetScrollContentValue()
	return -self.contentTrs_.anchoredPosition.x / 1182 + 1
end

function V210MusicMainView:OnScrollerMove()
	local var_17_0 = self:GetScrollContentValue()

	for iter_17_0, iter_17_1 in pairs((self.list_:GetItemList())) do
		iter_17_1:MoveAniEffect(var_17_0)
	end
end

function V210MusicMainView:OnTop()
	if GameSetting.v210_music_describe then
		local var_18_0 = GameSetting.v210_music_describe.value or {}
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistInfoCallBack(function()
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = var_18_0
		})
	end)
	manager.windowBar:RegistBackCallBack(function()
		self:Back()

		if manager.windowBar:GetWhereTag() == "qworld" then
			PlayQWorldBgm()
		end
	end)
end

function V210MusicMainView:UpdateMusicListShow(arg_21_1)
	if self.useShowToggleController:GetStateIndex((self.useShowToggleController:GetSelectedState())) == arg_21_1 then
		return
	end

	self.openToggleController:SetSelectedIndex(0)
	self:UpdateMusicDataByActId(MusicConst.MusicLookBackID[arg_21_1] or nil)
end

function V210MusicMainView:UpdateMusicDataByActId(arg_22_1)
	if arg_22_1 then
		self.useShowToggleController:SetSelectedIndex(table.indexof(MusicConst.MusicLookBackID, arg_22_1))
	else
		self.useShowToggleController:SetSelectedIndex(0)
	end

	self.musics = {}

	local var_22_0 = {}

	for iter_22_0, iter_22_1 in ipairs(ActivityCfg[self.activity_id].sub_activity_list) do
		if ActivityCfg[iter_22_1] and ActivityTemplateConst.ACTIVITY_MUSIC_GAME then
			table.insert(var_22_0, iter_22_1)
		end
	end

	if arg_22_1 then
		local var_22_1 = {}

		for iter_22_2, iter_22_3 in pairs(var_22_0) do
			var_22_1[iter_22_3] = true
		end

		for iter_22_4, iter_22_5 in pairs(ActivityMusicCfg.get_id_list_by_activity_id) do
			if MusicData:GetMusicViewPathList(iter_22_4, true).activityID == arg_22_1 then
				table.insert(self.musics, iter_22_4)
			end
		end

		table.sort(self.musics, function(arg_23_0, arg_23_1)
			return arg_23_0 < arg_23_1
		end)
	else
		self.musics = var_22_0
	end

	self.lookBackActID = arg_22_1

	self.list_:StartScroll(#self.musics, self.pageIndex, true, false)
	self.list_:SwitchToPage(self.pageIndex)
	self.musicmainuiAni_:Play("MusicGameUI 1", 0, 0)
end

function V210MusicMainView:OnEnter()
	local var_24_0 = SettingData:GetSoundSettingData()

	if var_24_0 and var_24_0.music then
		manager.audio:SetVolume("music", var_24_0.music / 100)
	end

	self.activity_id = self.params_.activity_id
	self.titleTxt_.text = GetI18NText(ActivityCfg[self.activity_id].remark)
	self.lookBackActID = self.lookBackActID or MusicData:GetLookBackState()
	self.pageIndex = MusicData:GetSelectIndex(self.activity_id)

	self:UpdateMusicDataByActId(self.lookBackActID)

	self.BGMID = 0

	MusicData:SetDifficultIndex(self.musics[self.pageIndex], (MusicData:GetDifficultyIndex(self.musics[self.pageIndex])))
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
			isPrefab = true,
			pages = (GameSetting.v210_music_describe or nil) and (GameSetting.v210_music_describe.value or {})
		})
		saveData("EnternalMusic", "showHelp", 1)
	end
end

function V210MusicMainView:OnExit()
	MusicData:SetLookBackState(self.lookBackActID)
	manager.windowBar:HideBar()

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	manager.redPoint:unbindUIandKey(self.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_REWARD, self.activity_id))
end

function V210MusicMainView:RefrenTime()
	local var_27_0 = ActivityData:GetActivityData(self.activity_id)

	if var_27_0 and var_27_0:IsActivitying() then
		self.m_timeLab.text = manager.time:GetLostTimeStrWith2Unit(var_27_0.stopTime)
	else
		self.m_timeLab.text = GetTips("TIME_OVER")

		JumpTools.Back()

		return
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_timeLab.transform)

	for iter_27_0, iter_27_1 in pairs((self.list_:GetItemList())) do
		iter_27_1:RefrenTime()
	end

	if ActivityData:GetActivityIsOpen(self.musics[self.pageIndex]) or self.lookBackActID then
		self.lockController:SetSelectedIndex(1)
	else
		self.lockController:SetSelectedIndex(0)
	end
end

function V210MusicMainView:IndexItem(arg_28_1, arg_28_2)
	arg_28_2:SetData(arg_28_1, self.musics[arg_28_1], self.lookBackActID)
	arg_28_2:MoveAniEffect(self:GetScrollContentValue())
end

function V210MusicMainView:OnPageChange(arg_29_1)
	if arg_29_1 > #self.musics then
		arg_29_1 = #self.musics
	end

	self.pageIndex = arg_29_1

	MusicData:SetSelectIndex(self.pageIndex)

	if ActivityData:GetActivityIsOpen(self.musics[arg_29_1]) or self.lookBackActID then
		self.lockController:SetSelectedIndex(1)
	else
		self.lockController:SetSelectedIndex(0)
	end

	self:PlayBg()
end

function V210MusicMainView:PlayBg()
	manager.audio:ClearBGMFlag()

	local var_30_0 = self.musics[self.pageIndex]

	if not self.musics[self.pageIndex] then
		return
	end

	local var_30_1 = ActivityData:GetActivityData(var_30_0)

	if (not var_30_1 or not var_30_1:IsActivitying()) and not self.lookBackActID then
		manager.audio:StopBgmImmediate()

		return
	end

	local var_30_2 = ActivityMusicCfg.get_id_list_by_activity_id[var_30_0][MusicData:GetDifficultyIndex(var_30_0) + 1] or ActivityMusicCfg.get_id_list_by_activity_id[var_30_0][1]
	local var_30_3 = ActivityMusicCfg[var_30_2]

	if ActivityMusicCfg[var_30_2].aisacKey ~= "" then
		AudioManager.Instance:SetAisacControlOfCategory("music", var_30_3.aisacKey, var_30_3.aisacValue)
	end

	self.BGMID = var_30_2

	manager.audio:PlayBGM(var_30_3.cueSheetName, var_30_3.cueName, var_30_3.awbFile)
end

function V210MusicMainView:RefrenBGM()
	if not self.musics[self.pageIndex] then
		return
	end

	if self.BGMID == (ActivityMusicCfg.get_id_list_by_activity_id[self.musics[self.pageIndex]][MusicData:GetDifficultyIndex(self.musics[self.pageIndex]) + 1] or ActivityMusicCfg.get_id_list_by_activity_id[self.musics[self.pageIndex]][1]) then
		return
	end

	self:PlayBg()
end

function V210MusicMainView:Dispose()
	self.list_:Dispose()
	V210MusicMainView.super.Dispose(self)
end

return V210MusicMainView
