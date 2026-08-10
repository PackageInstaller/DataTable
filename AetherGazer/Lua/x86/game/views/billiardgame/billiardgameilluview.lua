local var_0_0 = class("BilliardGameIlluView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_SummerPub/BilliardGame/BilliardGame_IllustratedPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.itemScroll_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.uiListGo_, BilliardGameIlluItemView)
	arg_4_0.tabController_ = arg_4_0.exController_:GetController("tab")
	arg_4_0.lockController_ = arg_4_0.exController_:GetController("lock")
	arg_4_0.movie_ = arg_4_0.movieGo_:GetComponent("CriManaMovieControllerForUI")
	arg_4_0.moviePlayer_ = arg_4_0.movie_.player
	arg_4_0.moviePlayer_.uiRenderMode = true
	arg_4_0.playingItemId_ = nil
	arg_4_0.startTimer_ = nil
	arg_4_0.stopTimer_ = nil
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btnMon_, arg_5_0, function()
		arg_5_0:EnterTag(1, true)
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnBorgan_, nil, function()
		arg_5_0:EnterTag(2, true)
	end)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Clear()
		arg_5_0:Back()
	end)
end

function var_0_0.EnterTag(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0.tagType == arg_9_1 then
		return
	end

	arg_9_0.tagType = arg_9_1

	if arg_9_1 == 1 then
		arg_9_0.tabController_:SetSelectedIndex(0)
	else
		arg_9_0.tabController_:SetSelectedIndex(1)
	end

	arg_9_0:UpdateItemData(arg_9_1, 1)
	arg_9_0.itemScroll_:StartScroll(#arg_9_0.itemList_)
	arg_9_0:SetSelectItem(1, true)

	if arg_9_2 then
		arg_9_0.ani_:Play("UI_base", -1, 0)
	end
end

function var_0_0.OnEnter(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_10_0.stageId = arg_10_0.params_.stageId

	local var_10_0 = false

	if arg_10_0.stageId then
		if #arg_10_0:GetListByTypeFromStage(2) > 0 then
			var_10_0 = true
		end
	else
		var_10_0 = true

		manager.redPoint:bindUIandKey(arg_10_0.btnMon_.transform, RedPointConst.SUMMER_PUB_ILLUSTRATION_MON)
		manager.redPoint:bindUIandKey(arg_10_0.btnBorgan_.transform, RedPointConst.SUMMER_PUB_ILLUSTRATION_BORGAN)
	end

	SetActive(arg_10_0.btnBorgan_.gameObject, var_10_0)

	arg_10_0.activity_ = ActivityConst.ACTIVITY_NYA_SUMMER_PUB
	arg_10_0.tagType = -1

	arg_10_0:EnterTag(1)
end

function var_0_0.OnExit(arg_11_0)
	manager.redPoint:unbindUIandKey(arg_11_0.btnMon_.transform, RedPointConst.SUMMER_PUB_ILLUSTRATION_MON)
	manager.redPoint:unbindUIandKey(arg_11_0.btnBorgan_.transform, RedPointConst.SUMMER_PUB_ILLUSTRATION_BORGAN)
	arg_11_0:Clear()
	var_0_0.super.OnExit(arg_11_0)
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.itemScroll_:Dispose()
	var_0_0.super.Dispose(arg_12_0)
end

function var_0_0.IndexItem(arg_13_0, arg_13_1, arg_13_2)
	arg_13_2:RegisterBtnListener(handler(arg_13_0, arg_13_0.SetSelectItem))
	arg_13_2:RefreshUI(arg_13_1, arg_13_0.itemList_[arg_13_1])
end

function var_0_0.UpdateItemData(arg_14_0, arg_14_1, arg_14_2)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.itemList_ or {}) do
		arg_14_0.itemList_[iter_14_0] = nil
	end

	arg_14_0.itemList_ = {}

	local var_14_0 = SummerPubData:GetIlluInfo()
	local var_14_1 = {}

	if arg_14_0.stageId then
		var_14_1 = arg_14_0:GetListByTypeFromStage(arg_14_1)
	else
		var_14_1 = BilliardIllustrationsCfg.get_id_list_by_activity_id_type[arg_14_0.activity_][arg_14_1] or {}
	end

	for iter_14_2, iter_14_3 in ipairs(var_14_1) do
		local var_14_2 = {
			id = iter_14_3
		}

		if var_14_0[iter_14_3] then
			var_14_2.active = true
			var_14_2.viewState = var_14_0[iter_14_3]
		elseif arg_14_0.stageId then
			var_14_2.active = true
		else
			var_14_2.active = false
		end

		var_14_2.select = iter_14_2 == arg_14_2

		table.insert(arg_14_0.itemList_, var_14_2)
	end

	table.sort(arg_14_0.itemList_, function(arg_15_0, arg_15_1)
		return arg_15_0.id < arg_15_1.id
	end)
end

function var_0_0.GetListByTypeFromStage(arg_16_0, arg_16_1)
	local var_16_0 = BilliardStageCfg[arg_16_0.stageId].stage_illustration

	if var_16_0 == "" then
		var_16_0 = {}
	end

	local var_16_1 = {}

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		if BilliardIllustrationsCfg[iter_16_1].type == arg_16_1 then
			table.insert(var_16_1, iter_16_1)
		end
	end

	return var_16_1
end

function var_0_0.SetSelectItem(arg_17_0, arg_17_1, arg_17_2)
	if not arg_17_2 and arg_17_0.selectItem_ == arg_17_1 then
		return
	end

	if arg_17_0.itemList_[arg_17_0.selectItem_] then
		arg_17_0.itemList_[arg_17_0.selectItem_].select = false
	end

	arg_17_0.selectItem_ = arg_17_1

	if arg_17_0.itemList_[arg_17_0.selectItem_] then
		arg_17_0.itemList_[arg_17_0.selectItem_].select = true
		arg_17_0.itemList_[arg_17_0.selectItem_].viewState = 2
	end

	local var_17_0 = arg_17_0.itemScroll_:GetItemList()

	for iter_17_0, iter_17_1 in pairs(var_17_0) do
		iter_17_1:ShowSelect(arg_17_1 == iter_17_0)
	end

	if arg_17_0.itemList_[arg_17_0.selectItem_] then
		arg_17_0:RefreshPanelDesc(arg_17_0.itemList_[arg_17_0.selectItem_])
		arg_17_0:StopDelayTimer()

		arg_17_0.delayTimer = FrameTimer.New(function()
			arg_17_0:RefreshPanelMovie(arg_17_0.itemList_[arg_17_0.selectItem_].id)
		end, 1, 2)

		arg_17_0.delayTimer:Start()
	else
		arg_17_0:RefreshPanelDesc(nil)
	end

	SummerPubAction.ViewIllustration(arg_17_0.itemList_[arg_17_0.selectItem_].id)
end

function var_0_0.StopDelayTimer(arg_19_0)
	if arg_19_0.delayTimer then
		arg_19_0.delayTimer:Stop()

		arg_19_0.delayTimer = nil
	end
end

function var_0_0.RefreshPanelDesc(arg_20_0, arg_20_1)
	if arg_20_1 then
		if arg_20_1.active then
			arg_20_0.lockController_:SetSelectedIndex(1)

			local var_20_0 = BilliardIllustrationsCfg[arg_20_1.id]

			arg_20_0.nameText_.text = GetI18NText(var_20_0.name)
			arg_20_0.descText_.text = GetI18NText(var_20_0.desc)
			arg_20_0.skillDescText_.text = GetI18NText(var_20_0.skill_desc)
			arg_20_0.unlockMonImage_.sprite = pureGetSpriteWithoutAtlas(var_20_0.icon)

			arg_20_0.monUnlockAni_:Play("UI_Monstericon", -1, 0)
			arg_20_0.monUnlockAni_:Update(0)
		else
			arg_20_0.monLockAni_:Play("UI_Monstericon", -1, 0)
			arg_20_0.monLockAni_:Update(0)
			arg_20_0.lockController_:SetSelectedIndex(0)
		end
	else
		arg_20_0.monLockAni_:Play("UI_Monstericon", -1, 0)
		arg_20_0.monLockAni_:Update(0)
		arg_20_0.lockController_:SetSelectedState(0)
	end
end

function var_0_0.RefreshPanelMovie(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0:HasMovie(arg_21_1)

	if arg_21_0.moviePlayer_ and tostring(arg_21_0.moviePlayer_.status) == "Playing" and arg_21_1 == arg_21_0.playingItemId_ then
		return
	end

	if arg_21_0.playingItemId_ ~= nil and arg_21_1 ~= arg_21_0.playingItemId_ then
		arg_21_0.movie_:Stop()
		var_0_0:StopMovieStopTimer()

		arg_21_0.movieRaw_.material = nil
		arg_21_0.stopTimer_ = FrameTimer.New(function(...)
			if arg_21_0.moviePlayer_ and tostring(arg_21_0.moviePlayer_.status) == "Stop" then
				arg_21_0.playingItemId_ = nil

				arg_21_0:StopMovieStopTimer()

				if var_21_0 then
					arg_21_0:StartMovie(arg_21_1)
				end
			end
		end, 1, -1)

		arg_21_0.stopTimer_:Start()
	end

	if arg_21_0.playingItemId_ == nil and var_21_0 then
		arg_21_0:StartMovie(arg_21_1)
	end
end

function var_0_0.StartMovie(arg_23_0, arg_23_1)
	arg_23_0.start_path = BilliardIllustrationsCfg[arg_23_1].video

	arg_23_0:Play()

	arg_23_0.playingItemId_ = arg_23_1

	arg_23_0:StopStartMovieTimer()

	arg_23_0.startTimer_ = FrameTimer.New(function()
		if arg_23_0.movie_ and arg_23_0.movie_.isMaterialAvailable then
			arg_23_0:StopStartMovieTimer()
		end
	end, 1, -1)

	arg_23_0.startTimer_:Start()
end

function var_0_0.HasMovie(arg_25_0, arg_25_1)
	local var_25_0 = false

	if arg_25_0.itemList_[arg_25_0.selectItem_] and arg_25_0.itemList_[arg_25_0.selectItem_].active then
		var_25_0 = true
	end

	return var_25_0
end

function var_0_0.Play(arg_26_0)
	SetFile(arg_26_0.moviePlayer_, nil, arg_26_0.start_path, CriMana.Player.SetMode.New)
	arg_26_0.moviePlayer_:Prepare()

	local var_26_0 = manager.audio:GetMusicVolume()

	arg_26_0.moviePlayer_:SetVolume(var_26_0)
	arg_26_0:SetVideoTrack(arg_26_0.moviePlayer_, arg_26_0.start_path)
	arg_26_0.movie_:Play()
end

function var_0_0.SetVideoTrack(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = manager.video:GetVedioTrackIndex(arg_27_2)

	arg_27_1:SetAudioTrack(var_27_0)
	arg_27_1:SetSubtitleChannel(var_27_0)
end

function var_0_0.StopMovieStopTimer(arg_28_0)
	if arg_28_0.stopTimer_ then
		arg_28_0.stopTimer_:Stop()

		arg_28_0.stopTimer_ = nil
	end
end

function var_0_0.StopStartMovieTimer(arg_29_0)
	if arg_29_0.startTimer_ then
		arg_29_0.startTimer_:Stop()

		arg_29_0.startTimer_ = nil
	end
end

function var_0_0.Clear(arg_30_0)
	if arg_30_0.movie_ then
		arg_30_0.movie_:Stop()
	end

	arg_30_0:StopDelayTimer()
	arg_30_0:StopStartMovieTimer()
	arg_30_0:StopMovieStopTimer()

	arg_30_0.playingItemId_ = nil
end

return var_0_0
