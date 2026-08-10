local var_0_0 = class("IlluMusicView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/IllustratedHandbook/IlluMusicAlbumUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.common_list = LuaList.New(handler(arg_4_0, arg_4_0.IndexCommonItem), arg_4_0.m_common_list, IlluMusicAlbumItem)
	arg_4_0.detail_list = LuaList.New(handler(arg_4_0, arg_4_0.IndexDetailItem), arg_4_0.m_detail_list, IlluMusicInfoItem)
	arg_4_0.isInDertails = false
	arg_4_0.pauseController = ControllerUtil.GetController(arg_4_0.transform_, "pause")
	arg_4_0.bgmController = ControllerUtil.GetController(arg_4_0.transform_, "bgm")
	arg_4_0.statusController = ControllerUtil.GetController(arg_4_0.transform_, "status")

	SetActive(arg_4_0.m_musicName.gameObject, false)
	SetActive(arg_4_0.m_author.gameObject, false)
	TimeTools.StartAfterSeconds(0.1, function()
		arg_4_0.m_musicName.alignment = UnityEngine.TextAnchor.MiddleLeft
		arg_4_0.m_author.alignment = UnityEngine.TextAnchor.MiddleLeft

		SetActive(arg_4_0.m_musicName.gameObject, true)
		SetActive(arg_4_0.m_author.gameObject, true)
	end, {})
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0.m_scroller.onValueChanged:AddListener(function()
		return
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_nextBtn, nil, function()
		arg_6_0:ChangeMusic(1)
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_lastBtn, nil, function()
		arg_6_0:ChangeMusic(-1)
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_randomBtn, nil, function()
		arg_6_0:RandomChangeMusic()
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_musicBtn, nil, function()
		arg_6_0:AnchorCurrentMusic(false)
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_playBtn, nil, function()
		if arg_6_0.player then
			arg_6_0.player:Pause(false)
		end

		arg_6_0:RefreshState()
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_pauseBtn, nil, function()
		if arg_6_0.player then
			arg_6_0.player:Pause(true)
		end

		arg_6_0:RefreshState()
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_setBgmBtn, nil, function()
		IllustratedAction.QuerySetBgm(arg_6_0.music_id)
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_detailMask, nil, function()
		arg_6_0:SwitchToCommon()
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_mask, nil, function()
		arg_6_0:SwitchToCommon()
	end)
	arg_6_0.detail_list:SetPageChangeHandler(handler(arg_6_0, arg_6_0.OnDetailPageChange))
end

function var_0_0.OnTop(arg_17_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.SwitchToCommon(arg_18_0)
	if arg_18_0.isInDertails then
		arg_18_0.common_list:ScrollToIndex(arg_18_0.pageIndex, true, false)
		SetActive(arg_18_0.detailViewPort_, false)
		SetActive(arg_18_0.commonViewPort_, true)

		local var_18_0 = arg_18_0.common_list:GetItemList()

		for iter_18_0, iter_18_1 in pairs(var_18_0) do
			iter_18_1:UpdateAnima(arg_18_0.pageIndex)
		end

		arg_18_0.isInDertails = false
	end
end

function var_0_0.OnDetailPageChange(arg_19_0, arg_19_1)
	if arg_19_1 <= #arg_19_0.albums then
		arg_19_0.pageIndex = arg_19_1

		local var_19_0 = arg_19_0.detail_list:GetItemList()

		for iter_19_0, iter_19_1 in pairs(var_19_0) do
			iter_19_1:UpdateState(arg_19_0.pageIndex)
		end
	end
end

function var_0_0.OnCommonPageChange(arg_20_0, arg_20_1)
	return
end

function var_0_0.OnEnter(arg_21_0)
	arg_21_0.player = manager.audio:GetBgmPlayer()
	arg_21_0.music_id = arg_21_0:GetMusicId()

	arg_21_0:RefreshState()

	arg_21_0.albums = MusicAlbumRecordCfg.all

	SetActive(arg_21_0.detailViewPort_, false)
	SetActive(arg_21_0.commonViewPort_, true)

	arg_21_0.isInDertails = false

	local var_21_0 = MusicRecordCfg[arg_21_0.music_id].album

	arg_21_0.pageIndex = table.indexof(arg_21_0.albums, var_21_0) or 1

	arg_21_0.common_list:StartScroll(#arg_21_0.albums, arg_21_0.pageIndex, true, false)
	arg_21_0.detail_list:StartScroll(#arg_21_0.albums, arg_21_0.pageIndex, true, false)
end

function var_0_0.OnExit(arg_22_0)
	manager.windowBar:HideBar()

	if arg_22_0.player then
		arg_22_0.player:Pause(false)
	end
end

function var_0_0.Dispose(arg_23_0)
	arg_23_0.common_list:Dispose()
	arg_23_0.detail_list:Dispose()
	var_0_0.super.Dispose(arg_23_0)
end

function var_0_0.IndexCommonItem(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_0.albums[arg_24_1]

	arg_24_2:SetData(var_24_0, arg_24_0.music_id, arg_24_1)
	arg_24_2:RegistCallBack(handler(arg_24_0, arg_24_0.OnAlbumClick))
end

function var_0_0.IndexDetailItem(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_0.albums[arg_25_1]

	arg_25_2:SetData(var_25_0, arg_25_0.music_id, arg_25_1)
	arg_25_2:UpdateState(arg_25_0.pageIndex)
	arg_25_2:RegistCallBack(handler(arg_25_0, arg_25_0.PlayMusic))
	arg_25_2:RegistMaskCallBack(handler(arg_25_0, arg_25_0.ChangePageIndex))
	arg_25_2:RegistCdCallBack(handler(arg_25_0, arg_25_0.SwitchToCommon))
end

function var_0_0.ChangePageIndex(arg_26_0, arg_26_1)
	arg_26_0.detail_list:SwitchToPage(arg_26_1)
end

function var_0_0.OnAlbumClick(arg_27_0, arg_27_1)
	if arg_27_1 == arg_27_0.pageIndex and arg_27_0.isInDertails then
		return
	end

	SetActive(arg_27_0.detailViewPort_, true)
	SetActive(arg_27_0.commonViewPort_, false)

	arg_27_0.isInDertails = true
	arg_27_0.pageIndex = arg_27_1

	arg_27_0.detail_list:ScrollToIndex(arg_27_0.pageIndex, true, false)

	local var_27_0 = arg_27_0.detail_list:GetItemList()

	for iter_27_0, iter_27_1 in pairs(var_27_0) do
		iter_27_1:UpdateAnima(arg_27_0.pageIndex)
	end

	arg_27_0:OnDetailPageChange(arg_27_0.pageIndex)
end

function var_0_0.GetMusicId(arg_28_0)
	local var_28_0 = GetHomeMusicID()

	if var_28_0 ~= 0 and MusicRecordCfg[var_28_0] then
		return var_28_0
	else
		if arg_28_0.player then
			local var_28_1 = arg_28_0.player.cueName or ""
			local var_28_2 = arg_28_0.player.cueSheet or ""

			if var_28_1 ~= "" and var_28_2 ~= "" then
				local var_28_3 = MusicRecordCfg.all

				for iter_28_0, iter_28_1 in ipairs(var_28_3) do
					local var_28_4 = MusicRecordCfg[iter_28_1]

					if var_28_4.cueName == var_28_1 and var_28_4.cuesheet == var_28_2 then
						return iter_28_1
					end
				end
			end
		end

		return MusicRecordCfg.all[1]
	end
end

function var_0_0.ChangeMusic(arg_29_0, arg_29_1)
	local var_29_0 = MusicRecordCfg[arg_29_0.music_id]
	local var_29_1 = MusicRecordCfg.get_id_list_by_album[var_29_0.album]
	local var_29_2 = #var_29_1
	local var_29_3 = (table.indexof(var_29_1, arg_29_0.music_id) + var_29_2 + arg_29_1) % var_29_2

	if var_29_3 == 0 then
		var_29_3 = var_29_2
	end

	arg_29_0:PlayMusic(var_29_1[var_29_3])
end

function var_0_0.RandomChangeMusic(arg_30_0)
	local var_30_0 = MusicRecordCfg.all
	local var_30_1 = #var_30_0

	arg_30_0:PlayMusic(var_30_0[math.random(var_30_1)])
	arg_30_0:AnchorCurrentMusic(false)
end

function var_0_0.AnchorCurrentMusic(arg_31_0, arg_31_1)
	local var_31_0 = MusicRecordCfg[arg_31_0.music_id].album

	arg_31_0.pageIndex = table.indexof(arg_31_0.albums, var_31_0) or 1

	arg_31_0.common_list:ScrollToIndex(arg_31_0.pageIndex, true, arg_31_1)
	arg_31_0.detail_list:ScrollToIndex(arg_31_0.pageIndex, true, arg_31_1)
	arg_31_0:OnAlbumClick(arg_31_0.pageIndex, true)
	arg_31_0.detail_list:GetItemList()[arg_31_0.pageIndex]:JumpToSong(arg_31_0.music_id)
end

function var_0_0.PlayMusic(arg_32_0, arg_32_1)
	if arg_32_1 == arg_32_0.music_id then
		return
	end

	manager.audio:StopBgmImmediate()

	arg_32_0.music_id = arg_32_1

	local var_32_0 = MusicRecordCfg[arg_32_0.music_id]

	if arg_32_0.player then
		arg_32_0.player:Pause(false)

		local var_32_1 = MusicData:GetAisacSet(arg_32_0.music_id)

		for iter_32_0, iter_32_1 in pairs(var_32_1) do
			AudioManager.Instance:SetAisacControlOfCategory("music", iter_32_0, iter_32_1)
		end
	end

	manager.audio:PlayBGM(var_32_0.cuesheet, var_32_0.cueName, var_32_0.awbName)
	arg_32_0:RefreshState()
end

function var_0_0.RefreshState(arg_33_0)
	if arg_33_0.player and not arg_33_0.player:IsPaused() then
		arg_33_0.pauseController:SetSelectedIndex(0)
	else
		arg_33_0.pauseController:SetSelectedIndex(1)
	end

	local var_33_0 = MusicRecordCfg[arg_33_0.music_id]

	arg_33_0.m_musicName.text = GetI18NText(var_33_0.musicName)
	arg_33_0.m_author.text = GetI18NText(var_33_0.authorName)

	local var_33_1 = arg_33_0.detail_list:GetItemList()

	for iter_33_0, iter_33_1 in pairs(var_33_1) do
		iter_33_1:RefreshSongsState(arg_33_0.music_id)
	end

	local var_33_2 = GetHomeMusicID()

	if arg_33_0.music_id == var_33_2 then
		arg_33_0.bgmController:SetSelectedIndex(0)
	elseif var_33_0.ableBGM == 1 then
		arg_33_0.bgmController:SetSelectedIndex(1)
	else
		arg_33_0.bgmController:SetSelectedIndex(2)
	end
end

function var_0_0.OnSetBgmSuccess(arg_34_0)
	arg_34_0:RefreshState()
end

return var_0_0
