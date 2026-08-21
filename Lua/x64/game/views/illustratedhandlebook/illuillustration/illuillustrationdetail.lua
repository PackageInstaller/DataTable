local var_0_0 = class("IlluIllustrationDetail", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/IllustratedHandbook/IlluIllustrationDetail"
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

	arg_4_0.imageImg_.cacheLimit = 3
	arg_4_0.loadCon_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "loading")
	arg_4_0.mutiTouchHelper_ = arg_4_0.swipeBtn_.gameObject:GetComponent("MutiTouchHelper")
	arg_4_0.downloadCon_ = arg_4_0.conEx_:GetController("download")
	arg_4_0.toggleController = arg_4_0.toggleController_:GetController("default0")
	arg_4_0.movieController_ = arg_4_0.conEx_:GetController("movie")
	arg_4_0.criMovie_ = arg_4_0.movieGo_:GetComponent("CriManaMovieControllerForUI")
	arg_4_0.criplayer_ = arg_4_0.criMovie_.player

	arg_4_0.criplayer_:SetMaxPictureDataSize(300000)
	arg_4_0.criMovie_:Stop()

	function arg_4_0.criplayer_.statusChangeCallback(arg_5_0)
		arg_4_0:CirMovieStatusChange(arg_5_0)
	end

	arg_4_0.criLoopMovie_ = arg_4_0.movieLoopGo_:GetComponent("CriManaMovieControllerForUI")
	arg_4_0.criLoopPlayer_ = arg_4_0.criLoopMovie_.player

	arg_4_0.criLoopPlayer_:SetMaxPictureDataSize(300000)
	arg_4_0.criLoopMovie_:Stop()

	function arg_4_0.criLoopPlayer_.statusChangeCallback(arg_6_0)
		arg_4_0:CirMovieStatusChange(arg_6_0)
	end

	arg_4_0.moviePlaying = false
	arg_4_0.isPlayMovie = false
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.backBtn_, nil, function()
		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.shareBtn_, nil, function()
		manager.share:Share(function()
			SetActive(arg_7_0.shareGo_, false)
			SetActive(arg_7_0.backGo_, false)
			SetActive(arg_7_0.descGo_, false)
			SetActive(arg_7_0.addBtn_.gameObject, false)
			SetActive(arg_7_0.content_, false)
		end, function()
			SetActive(arg_7_0.shareGo_, true)
			SetActive(arg_7_0.backGo_, true)
			SetActive(arg_7_0.descGo_, true)
			SetActive(arg_7_0.addBtn_.gameObject, true)

			if #arg_7_0.list_ > 1 then
				SetActive(arg_7_0.content_, true)
			end
		end)
	end)
	arg_7_0:AddBtnListener(arg_7_0.addBtn_, nil, function()
		local var_12_0 = getData("illustrated", "loading")

		if not var_12_0 or var_12_0 == 0 then
			JumpTools.OpenPageByJump("illustratedPop", {
				ID = arg_7_0.ID_,
				type_ = arg_7_0.type_
			})
			saveData("illustrated", "loading", 1)
		elseif IllustratedData:IsInLoadingSet(arg_7_0.ID_) then
			IllustratedAction.ChangeLoadingSet(false, arg_7_0.ID_)
		else
			if #IllustratedData:GetAllLoadingSet() >= GameSetting.loading_pic_max.value[1] then
				ShowTips("SET_FAILED")

				return
			end

			IllustratedAction.ChangeLoadingSet(true, arg_7_0.ID_)
			ShowTips("SET_CONFIRMED")
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.leftBtn_, nil, function()
		arg_7_0.ticker_ = 0

		if arg_7_0.index_ > 1 then
			arg_7_0:OnPageChange(arg_7_0.index_ - 1)
		else
			return
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.rightBtn_, nil, function()
		arg_7_0.ticker_ = 0

		if arg_7_0.index_ < #arg_7_0.chapterList_ then
			arg_7_0:OnPageChange(arg_7_0.index_ + 1)
		else
			return
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.bgBtn_, nil, function()
		arg_7_0.ticker_ = 0

		if #arg_7_0.list_ > 1 then
			local var_15_0 = table.indexof(arg_7_0.list_, arg_7_0.ID_)

			if var_15_0 ~= #arg_7_0.list_ then
				arg_7_0.ID_ = arg_7_0.list_[var_15_0 + 1]
			else
				arg_7_0.ID_ = arg_7_0.list_[1]
			end

			arg_7_0:RefreshUI()
		end
	end)

	function arg_7_0.mutiTouchHelper_.OnClick(arg_16_0, arg_16_1)
		arg_7_0.ticker_ = 0

		if #arg_7_0.list_ > 1 then
			local var_16_0 = table.indexof(arg_7_0.list_, arg_7_0.ID_)

			if var_16_0 ~= #arg_7_0.list_ then
				arg_7_0.ID_ = arg_7_0.list_[var_16_0 + 1]
			else
				arg_7_0.ID_ = arg_7_0.list_[1]
			end

			arg_7_0:RefreshUI()
		end
	end

	function arg_7_0.mutiTouchHelper_.OnSingleDrag(arg_17_0, arg_17_1)
		arg_7_0:TouchHelpSingleDrag(arg_17_0, arg_17_1)
	end

	function arg_7_0.mutiTouchHelper_.OnMutiDrag(arg_18_0)
		arg_7_0:TouchHelpMutiDrag(arg_18_0)
	end

	function arg_7_0.mutiTouchHelper_.EndDrag()
		arg_7_0.hasChangePaged = false
	end

	arg_7_0:AddBtnListener(arg_7_0.dynamicBtn_, nil, function()
		if arg_7_0.toggleController:GetSelectedIndex() == 0 then
			arg_7_0.toggleController:SetSelectedIndex(1)
			arg_7_0.movieController_:SetSelectedIndex(0)

			arg_7_0.movieGo_.transform.localPosition = Vector2(9999, 9999)
			arg_7_0.movieLoopGo_.transform.localPosition = Vector2(9999, 9999)

			SetActive(arg_7_0.addBtn_.gameObject, true)
			arg_7_0:StopMovie()
		else
			arg_7_0.toggleController:SetSelectedIndex(0)
			arg_7_0.movieController_:SetSelectedIndex(1)

			arg_7_0.movieGo_.transform.localPosition = Vector2(0, 0)
			arg_7_0.movieLoopGo_.transform.localPosition = Vector2(0, 0)

			SetActive(arg_7_0.addBtn_.gameObject, false)
			arg_7_0:StopMovie()
			arg_7_0:PlayEnterAni()
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.staticBtn_, nil, function()
		if arg_7_0.toggleController:GetSelectedIndex() == 0 then
			arg_7_0.toggleController:SetSelectedIndex(1)
			arg_7_0.movieController_:SetSelectedIndex(0)

			arg_7_0.movieGo_.transform.localPosition = Vector2(9999, 9999)
			arg_7_0.movieLoopGo_.transform.localPosition = Vector2(9999, 9999)

			SetActive(arg_7_0.addBtn_.gameObject, true)
			arg_7_0:StopMovie()
		else
			arg_7_0.toggleController:SetSelectedIndex(0)
			arg_7_0.movieController_:SetSelectedIndex(1)

			arg_7_0.movieGo_.transform.localPosition = Vector2(0, 0)
			arg_7_0.movieLoopGo_.transform.localPosition = Vector2(0, 0)

			SetActive(arg_7_0.addBtn_.gameObject, false)
			arg_7_0:StopMovie()
			arg_7_0:PlayEnterAni()
		end
	end)
end

function var_0_0.PlayEnterAni(arg_22_0)
	arg_22_0.isPlayMovie = true

	if arg_22_0.selectHeroID == 0 then
		return
	end

	local var_22_0 = WeddingCfg[arg_22_0.selectHeroID]
	local var_22_1 = table.indexof(arg_22_0.list_, arg_22_0.ID_)
	local var_22_2 = 2

	if arg_22_0.selectHeroID == 1095 then
		var_22_2 = var_22_1 + 1
	end

	local var_22_3 = var_22_0.wedding_plot[2] .. "_" .. var_22_2

	SetFile(arg_22_0.criLoopPlayer_, nil, "SofdecAsset/story/story_" .. var_22_3 .. ".usm", CriMana.Player.SetMode.New)
	arg_22_0.criLoopPlayer_:Prepare()
	arg_22_0:PlayMovie(arg_22_0.criLoopPlayer_, arg_22_0.criLoopMovie_)
end

function var_0_0.PlayMovie(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = manager.audio:GetMusicVolume()

	arg_23_1:SetVolume(var_23_0)
	arg_23_2:Play()

	arg_23_0.moviePlaying = true
end

function var_0_0.CirMovieStatusChange(arg_24_0, arg_24_1)
	local var_24_0 = tostring(arg_24_1)

	if var_24_0 == "PlayEnd" then
		arg_24_0.hasViewStart_ = true
		arg_24_0.movieLoopGo_.transform.localPosition = Vector2(0, 0)

		arg_24_0:PlayMovie(arg_24_0.criLoopPlayer_, arg_24_0.criLoopMovie_)

		arg_24_0.movieGo_.transform.localPosition = Vector2(9999, 9999)
	elseif var_24_0 == "Stop" then
		arg_24_0:PlayEnterAni()
	elseif var_24_0 == "Error" then
		arg_24_0.criLoopPlayer_:Stop()
	end
end

function var_0_0.StopMovie(arg_25_0)
	if arg_25_0.criMovie_ then
		arg_25_0.criMovie_:Stop()
	end

	if arg_25_0.criLoopMovie_ then
		arg_25_0.criLoopMovie_:Stop()
	end

	arg_25_0.moviePlaying = false
end

function var_0_0.DisPoseMovie(arg_26_0)
	if arg_26_0.criMovie_ or arg_26_0.criLoopMovie_ then
		arg_26_0:StopMovie()

		if arg_26_0.criPlayer_ then
			arg_26_0.criPlayer_:Dispose()

			arg_26_0.criplayer_.statusChangeCallback = nil
			arg_26_0.criPlayer_ = nil
		end

		if arg_26_0.criLoopPlayer_ then
			arg_26_0.criLoopPlayer_:Dispose()

			arg_26_0.criplayer_.statusChangeCallback = nil
			arg_26_0.criLoopPlayer_ = nil
		end
	end
end

function var_0_0.TouchHelpSingleDrag(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = 3

	if arg_27_0.hasChangePaged then
		return
	end

	arg_27_0.ticker_ = 0

	if arg_27_1 < -1 * var_27_0 then
		if arg_27_0.index_ >= #arg_27_0.chapterList_ then
			return
		end

		arg_27_0.hasChangePaged = true

		arg_27_0:OnPageChange(arg_27_0.index_ + 1)
	elseif var_27_0 < arg_27_1 then
		if arg_27_0.index_ <= 1 then
			return
		end

		arg_27_0.hasChangePaged = true

		arg_27_0:OnPageChange(arg_27_0.index_ - 1)
	end
end

function var_0_0.TouchHelpMutiDrag(arg_28_0, arg_28_1)
	if arg_28_0.hasChangePaged then
		return
	end

	arg_28_0.ticker_ = 0

	local var_28_0 = GameSetting.delta_to_zoom and GameSetting.delta_to_zoom.value[1] or 10

	if var_28_0 < arg_28_1 then
		if arg_28_0.index_ == arg_28_0.maxDishIndex_ then
			return
		end

		arg_28_0.hasChangePaged = true

		arg_28_0:OnPageChange(arg_28_0.index_ + 1)
	elseif arg_28_1 < -1 * var_28_0 then
		if arg_28_0.index_ == 1 then
			return
		end

		arg_28_0.hasChangePaged = true

		arg_28_0:OnPageChange(arg_28_0.index_ - 1)
	end
end

function var_0_0.OnPageChange(arg_29_0, arg_29_1)
	arg_29_0.index_ = arg_29_1
	arg_29_0.ID_ = arg_29_0.chapterList_[arg_29_0.index_]
	arg_29_0.selectHeroID = CollectPictureCfg[arg_29_0.ID_].wedding_role_id

	arg_29_0:RefreshData()
	arg_29_0:RefreshLiner()
	arg_29_0:RefreshUI()
	SetActive(arg_29_0.leftBtn_.gameObject, arg_29_0.index_ > 1 and arg_29_0.toggleController:GetSelectedIndex() == 1)
	SetActive(arg_29_0.rightBtn_.gameObject, arg_29_0.index_ < #arg_29_0.chapterList_ and arg_29_0.toggleController:GetSelectedIndex() == 1)
end

function var_0_0.OnEnter(arg_30_0)
	arg_30_0.ID_ = arg_30_0.params_.ID
	arg_30_0.chapterList_ = arg_30_0.params_.chapterList
	arg_30_0.index_ = arg_30_0.params_.index or 1
	arg_30_0.selectHeroID = arg_30_0.params_.heroID or 0

	if arg_30_0.selectHeroID == 0 then
		arg_30_0.toggleController:SetSelectedIndex(1)
		arg_30_0.movieController_:SetSelectedIndex(0)

		arg_30_0.movieGo_.transform.localPosition = Vector2(9999, 9999)
		arg_30_0.movieLoopGo_.transform.localPosition = Vector2(9999, 9999)

		arg_30_0:StopMovie()
	end

	SetActive(arg_30_0.toggleGo_, arg_30_0.selectHeroID ~= 0)
	arg_30_0:RefreshData()
	arg_30_0:RefreshLiner()
	arg_30_0:RefreshUI()
	SetActive(arg_30_0.leftBtn_.gameObject, arg_30_0.index_ > 1 and arg_30_0.toggleController:GetSelectedIndex() == 1)
	SetActive(arg_30_0.rightBtn_.gameObject, arg_30_0.index_ < #arg_30_0.chapterList_ and arg_30_0.toggleController:GetSelectedIndex() == 1)

	arg_30_0.ticker_ = 0
	arg_30_0.btnTimer_ = Timer.New(function()
		arg_30_0.ticker_ = arg_30_0.ticker_ + 1

		if arg_30_0.ticker_ >= 5 then
			SetActive(arg_30_0.leftBtn_.gameObject, false)
			SetActive(arg_30_0.rightBtn_.gameObject, false)
		else
			SetActive(arg_30_0.leftBtn_.gameObject, arg_30_0.index_ > 1 and arg_30_0.toggleController:GetSelectedIndex() == 1)
			SetActive(arg_30_0.rightBtn_.gameObject, arg_30_0.index_ < #arg_30_0.chapterList_ and arg_30_0.toggleController:GetSelectedIndex() == 1)
		end
	end, 1, -1)

	arg_30_0.btnTimer_:Start()
end

function var_0_0.RefreshData(arg_32_0)
	arg_32_0.type_ = CollectPictureCfg[arg_32_0.ID_].type

	local var_32_0 = CollectPictureCfg.get_id_list_by_group_id[CollectPictureCfg[arg_32_0.ID_].group_id] or {}

	arg_32_0.list_ = {}

	for iter_32_0, iter_32_1 in pairs(var_32_0) do
		local var_32_1 = IllustratedData:GetIllustrationInfo()[iter_32_1]

		if var_32_1 ~= nil and var_32_1.is_receive == 1 then
			table.insert(arg_32_0.list_, iter_32_1)
		end
	end

	table.sort(arg_32_0.list_, function(arg_33_0, arg_33_1)
		local var_33_0 = CollectPictureCfg[arg_33_0]
		local var_33_1 = CollectPictureCfg[arg_33_1]

		return var_33_0.group_display_order < var_33_1.group_display_order
	end)
	SetActive(arg_32_0.content_, #arg_32_0.list_ > 1)

	arg_32_0.bgBtn_.interactable = #arg_32_0.list_ > 1
end

function var_0_0.RefreshLiner(arg_34_0)
	arg_34_0:SetBarPosition(0)

	local var_34_0 = arg_34_0.sliderBg_.transform.childCount
	local var_34_1 = #arg_34_0.list_
	local var_34_2 = var_34_1 < var_34_0 and var_34_0 or var_34_1

	for iter_34_0 = 1, var_34_2 do
		if iter_34_0 <= var_34_0 then
			local var_34_3 = arg_34_0.sliderBg_.transform:GetChild(iter_34_0 - 1)

			if iter_34_0 <= var_34_1 then
				SetActive(var_34_3.gameObject, true)
			else
				SetActive(var_34_3.gameObject, false)
			end
		else
			local var_34_4 = Object.Instantiate(arg_34_0.barTemp_, arg_34_0.sliderBg_.transform)

			SetActive(var_34_4, true)
		end
	end
end

function var_0_0.SetBarPosition(arg_35_0, arg_35_1)
	arg_35_0.selectItem_.transform:SetSiblingIndex(arg_35_1)
end

function var_0_0.RefreshUI(arg_36_0)
	SetActive(arg_36_0.shareBtn_.gameObject, OperationData:IsOperationOpen(OperationConst.SHARE_FLAG))
	SetActive(arg_36_0.toggleGo_, arg_36_0.selectHeroID ~= 0)

	function _RefreshUI()
		arg_36_0.downloadCon_:SetSelectedState("downloaded")

		if arg_36_0.type_ == 5 then
			arg_36_0.imageImg_.spriteSync = "TextureConfig/Loading/" .. CollectPictureCfg[arg_36_0.ID_].picture
		else
			arg_36_0.imageImg_.spriteSync = "TextureConfig/Background/" .. CollectPictureCfg[arg_36_0.ID_].picture
		end

		arg_36_0.titleText_.text = GetI18NText(CollectPictureCfg[arg_36_0.ID_].name)
		arg_36_0.descText_.text = GetI18NText(CollectPictureCfg[arg_36_0.ID_].desc)

		arg_36_0:RefreshLoading()

		local var_37_0 = table.indexof(arg_36_0.list_, arg_36_0.ID_) or 1

		arg_36_0:SetBarPosition(var_37_0 - 1)
	end

	arg_36_0:CheckNeedDownloadAssets(_RefreshUI)

	if arg_36_0.toggleController:GetSelectedIndex() == 0 then
		SetActive(arg_36_0.addBtn_.gameObject, false)

		if arg_36_0.selectHeroID == 1095 then
			arg_36_0:StopMovie()
		else
			arg_36_0:PlayEnterAni()
		end
	else
		SetActive(arg_36_0.addBtn_.gameObject, true)
	end
end

function var_0_0.CheckNeedDownloadAssets(arg_38_0, arg_38_1)
	local var_38_0

	if arg_38_0.type_ == 5 then
		var_38_0 = "TextureConfig/Loading/" .. CollectPictureCfg[arg_38_0.ID_].picture
	else
		var_38_0 = "TextureConfig/Background/" .. CollectPictureCfg[arg_38_0.ID_].picture
	end

	local var_38_1 = {
		var_38_0
	}

	if AssetDownloadManager.CheckResourcesNeedDownload(var_38_1) then
		arg_38_0.downloadCon_:SetSelectedState("downloading")

		arg_38_0.imageImg_.spriteSync = SpritePathCfg.CollectPictureSmall.path .. CollectPictureCfg[arg_38_0.ID_].picture

		SetForceShowQuanquan(true)
		manager.assetPend:StartDownloadAsset(var_38_0, function()
			arg_38_1()
			SetForceShowQuanquan(false)
		end, function()
			SetForceShowQuanquan(false)
		end)
	else
		arg_38_1()
	end
end

function var_0_0.RefreshLoading(arg_41_0)
	arg_41_0.loadCon_:SetSelectedState(IllustratedData:IsInLoadingSet(arg_41_0.ID_) and "true" or "false")
end

function var_0_0.OnSaveLoadingSet(arg_42_0)
	arg_42_0:RefreshLoading()
end

function var_0_0.OnExitInput(arg_43_0)
	JumpTools.Back()

	return true
end

function var_0_0.OnExit(arg_44_0)
	if arg_44_0.btnTimer_ then
		arg_44_0.btnTimer_:Stop()

		arg_44_0.btnTimer_ = nil
	end

	if arg_44_0.isPlayMovie then
		arg_44_0:StopMovie()

		arg_44_0.isPlayMovie = false
	end
end

function var_0_0.Dispose(arg_45_0)
	arg_45_0:DisPoseMovie()
	var_0_0.super.Dispose(arg_45_0)
end

return var_0_0
