local ResidentMusicMainView = class("ResidentMusicMainView", ReduxView)

function ResidentMusicMainView:UIName()
	return "Widget/System/Activity_Resident/Acitvity_MusicUI/Acitvity_MusicMainUI"
end

function ResidentMusicMainView:UIParent()
	return manager.ui.uiMain.transform
end

function ResidentMusicMainView:Init()
	self:BindCfgUI()
	self:InitUI()
	self:AddUIListener()
	self:AddEventListener()
end

function ResidentMusicMainView:InitUI()
	self.musicFilter = ResidentMusicFilter.New(self.filterViewGo_)
	self.musicContent = ResidentMusicContent.New(self.musicContentGo_)
	self.musicTree = ResidentMusicTree.New(self.musicTreeGo_)
	self.emptyController_ = self.controller_:GetController("empty")
end

function ResidentMusicMainView:AddUIListener()
	self:AddBtnListener(self.settingBtn_, nil, function()
		JumpTools.OpenPageByJump("/residentMusicSettingView")
	end)
	self:AddBtnListener(self.playBtn_, nil, function()
		self:OnPlayBtn()
	end)
	self:AddBtnListener(self.filterBtn_, nil, function()
		self:UpdateFilterShow(true)
	end)
	self:AddBtnListener(self.limitRewardBtn_, nil, function()
		JumpTools.OpenPageByJump("residentMusicRewardView", {
			activity_id = MusicData:GetActivityTaskID(MusicData:GetPageActivityID())
		})
	end)
end

function ResidentMusicMainView:OnPlayBtn()
	local var_10_0 = self.musicContent:GetMusicID()

	MusicAction.Play(ActivityMusicCfg.get_id_list_by_activity_id[var_10_0][MusicData:GetDifficultyIndex(var_10_0)])
end

function ResidentMusicMainView:OnTop()
	self:UpdateBar()
end

function ResidentMusicMainView:UpdateBar()
	if GameSetting.v210_music_describe then
		local var_12_0 = GameSetting.v210_music_describe.value or {}
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistInfoCallBack(function()
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = var_12_0
		})
	end)
end

function ResidentMusicMainView:OnEnter()
	local var_14_0 = SettingData:GetSoundSettingData()

	if var_14_0 and var_14_0.music then
		manager.audio:SetVolume("music", var_14_0.music / 100)
	end

	self.selectMainActivityID, self.selectMusicActivityID = MusicData:GetSelectData()
	self.timer = Timer.New(function()
		self:RefrenBGM()
	end, 1, -1)

	self.timer:Start()
	self.musicFilter:OnEnter()

	self.BGMID = 0

	if MusicData:GetCacheMusicTreePos() then
		self.musicTree:SetPos(MusicData:GetCacheMusicTreePos())
	end

	self:UpdateTreeData()
	self:AddLimitRewardTimer()

	if not getData("EnternalMusic", "showHelp") then
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = (GameSetting.v210_music_describe or nil) and (GameSetting.v210_music_describe.value or {})
		})
		saveData("EnternalMusic", "showHelp", 1)
	end

	manager.redPoint:bindUIandKey(self.limitRewardBtn_.transform, string.format("%s_%s", RedPointConst.MUSIC_REWARD, MusicData:GetPageActivityID()))
end

function ResidentMusicMainView:AddLimitRewardTimer()
	if self.limitRewardTimer then
		self.limitRewardTimer:Stop()

		self.limitRewardTimer = nil
	end

	local var_16_0 = ActivityData:GetActivityData(MusicData:GetPageActivityID()).stopTime

	self.timeText_.text = manager.time:GetLostTimeStrWith2Unit(var_16_0, true)

	if var_16_0 < manager.time:GetServerTime() then
		SetActive(self.limitRewardBtn_.gameObject, false)

		return
	end

	SetActive(self.limitRewardBtn_.gameObject, true)

	self.limitRewardTimer = Timer.New(function()
		if manager.time:GetServerTime() > var_16_0 then
			if self.limitRewardTimer then
				self.limitRewardTimer:Stop()

				self.limitRewardTimer = nil
			end

			SetActive(self.limitRewardBtn_.gameObject, false)

			return
		end

		self.timeText_.text = manager.time:GetLostTimeStrWith2Unit(var_16_0, true)
	end, 1, -1)

	self.limitRewardTimer:Start()
end

function ResidentMusicMainView:RefrenBGM()
	local var_18_0 = self.musicContent:GetMusicID()

	if not var_18_0 then
		return
	end

	if self.BGMID == (ActivityMusicCfg.get_id_list_by_activity_id[var_18_0][MusicData:GetDifficultyIndex(var_18_0)] or ActivityMusicCfg.get_id_list_by_activity_id[var_18_0][1]) then
		return
	end

	self:PlayBg()
end

function ResidentMusicMainView:PlayBg()
	manager.audio:ClearBGMFlag()

	local var_19_0 = self.musicContent:GetMusicID()

	if not var_19_0 then
		return
	end

	local var_19_1 = ActivityMusicCfg.get_id_list_by_activity_id[var_19_0][MusicData:GetDifficultyIndex(var_19_0)] or ActivityMusicCfg.get_id_list_by_activity_id[var_19_0][1]
	local var_19_2 = ActivityMusicCfg[var_19_1]

	if ActivityMusicCfg[var_19_1].aisacKey ~= "" then
		AudioManager.Instance:SetAisacControlOfCategory("music", var_19_2.aisacKey, var_19_2.aisacValue)
	end

	self.BGMID = var_19_1

	manager.audio:PlayBGM(var_19_2.cueSheetName, "musicgame_preview", var_19_2.awbFile)
end

function ResidentMusicMainView:UpdateFilterShow(arg_20_1)
	self.musicFilter:ShowView(arg_20_1)

	if arg_20_1 then
		manager.windowBar:HideBar()
	else
		self:UpdateBar()
	end
end

function ResidentMusicMainView:ClearSelectMusic()
	if self.selectMainActivityID and self.selectMusicActivityID then
		self:ChangeTargetSelectInfo(self.selectMainActivityID, self.selectMusicActivityID, false)
	end

	self.selectMainActivityID = nil
	self.selectMusicActivityID = nil
end

function ResidentMusicMainView:ChangeSelectMusicInfo(arg_22_1, arg_22_2)
	self.emptyController_:SetSelectedState("normal")
	self:ClearSelectMusic()
	MusicAction.SetMusicRead(arg_22_2)

	self.selectMainActivityID = arg_22_1
	self.selectMusicActivityID = arg_22_2

	self:ChangeTargetSelectInfo(self.selectMainActivityID, self.selectMusicActivityID, true)
	self.musicContent:SetData(arg_22_2)
	MusicData:SetSelectedData(self.selectMainActivityID, self.selectMusicActivityID)
	self:RefrenBGM()
end

function ResidentMusicMainView:ChangeTargetSelectInfo(arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = self.musicTree:GetTargetGroupItem(arg_23_1)

	if var_23_0 then
		local var_23_1 = var_23_0:GetTargetMusicSelectItem(arg_23_2)

		if var_23_1 then
			var_23_1:ChangeSelectState(arg_23_3)
		end
	end
end

function ResidentMusicMainView:UpdateTreeData()
	local var_24_0 = self.musicFilter:GetSelectMusicList()

	self.musicTree:SetData(var_24_0)

	if not self:CheckTargetIDIsInFilterList(var_24_0, self.selectMainActivityID, self.selectMusicActivityID) then
		local var_24_1, var_24_2 = self:GetDefaultFilterSelect(var_24_0)

		if var_24_1 and var_24_2 then
			self:ChangeSelectMusicInfo(var_24_1, var_24_2)
		else
			self.emptyController_:SetSelectedState("empty")
		end
	else
		self:ChangeSelectMusicInfo(self.selectMainActivityID, self.selectMusicActivityID)
	end
end

function ResidentMusicMainView:CheckTargetIDIsInFilterList(arg_25_1, arg_25_2, arg_25_3)
	for iter_25_0, iter_25_1 in pairs(arg_25_1) do
		for iter_25_2, iter_25_3 in pairs(iter_25_1.musicActList) do
			if iter_25_3 == arg_25_3 then
				return true
			end
		end
	end

	return false
end

function ResidentMusicMainView:GetDefaultFilterSelect(arg_26_1)
	if #arg_26_1 == 0 then
		return nil, nil
	end

	return MusicConst.MusicViewRoutesName[MusicData:GetMusicTypeByTheme(arg_26_1[1].theme)].activityID, arg_26_1[1].musicActList[1]
end

function ResidentMusicMainView:MoveToTargetMusicID(arg_27_1)
	local var_27_0, var_27_1 = self.musicTree:FindScrollIndexMovePos(arg_27_1)

	if not var_27_0 then
		self.musicFilter:ClearFilter()
		self.musicFilter:OnOkBtn()
	end

	self.musicTree:ScrollToPos(-var_27_1 - 132)
	self.musicTree:SelectTargetItem(arg_27_1)
end

function ResidentMusicMainView:AddEventListener()
	self:RegistEventListener(MUSIC_FILTER_COLSE, handler(self, self.OnFilterClose))
	self:RegistEventListener(MUSIC_FILTER_UPDATE, handler(self, self.OnFilterUpdate))
	self:RegistEventListener(MUSIC_TREE_CLICK_ITEM, handler(self, self.OnTreeClickItem))
	self:RegistEventListener(MUSIC_JUMP_SELECT, handler(self, self.OnJumpToTargetSelect))
end

function ResidentMusicMainView:OnFilterClose()
	self:UpdateFilterShow(false)
end

function ResidentMusicMainView:OnFilterUpdate()
	self:UpdateFilterShow(false)
	self:ClearSelectMusic()
	self:UpdateTreeData()
end

function ResidentMusicMainView:OnTreeClickItem(arg_31_1, arg_31_2)
	self:ChangeSelectMusicInfo(arg_31_1, arg_31_2)
end

function ResidentMusicMainView:OnJumpToTargetSelect(arg_32_1)
	self:MoveToTargetMusicID(arg_32_1)
end

function ResidentMusicMainView:OnExit()
	manager.redPoint:unbindUIandKey(self.limitRewardBtn_.transform, string.format("%s_%s", RedPointConst.MUSIC_REWARD, MusicData:GetPageActivityID()))
	MusicData:SetCacheMusicTreePos(self.musicTree:GetPosY())

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self.musicTree:BindRed(false)
	self.musicFilter:OnExit()
	manager.windowBar:HideBar()
end

function ResidentMusicMainView:Dispose()
	self:RemoveAllEventListener()

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	if self.limitRewardTimer then
		self.limitRewardTimer:Stop()

		self.limitRewardTimer = nil
	end

	for iter_34_0, iter_34_1 in pairs(self.musicGroupList or {}) do
		iter_34_1:Dispose()

		iter_34_1 = nil
	end

	self.musicGroupList = nil

	for iter_34_2, iter_34_3 in pairs(self.musicSelectList or {}) do
		iter_34_3:Dispose()

		iter_34_3 = nil
	end

	self.musicSelectList = nil

	self.musicTree:Dispose()
	self.musicFilter:Dispose()
	self.musicContent:Dispose()
	ResidentMusicMainView.super.Dispose(self)
end

return ResidentMusicMainView
