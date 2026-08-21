local var_0_0 = class("IslandView", import(".IslandBaseView"))

function var_0_0.Init(arg_1_0)
	arg_1_0._unitList = {}
	arg_1_0.isInit = false

	arg_1_0:RegisterUnitList(IslandConst.UNIT_LIST_PLAYER)
	arg_1_0:RegisterUnitList(IslandConst.UNIT_LIST_OBJ)
	arg_1_0:RegisterUnitList(IslandConst.UNIT_LIST_SYSTEM)
	arg_1_0:RegisterUnitList(IslandConst.UNIT_LIST_DELEGATION)
	arg_1_0:RegisterUnitList(IslandConst.UNIT_LIST_STROLL)
	arg_1_0:RegisterUnitList(IslandConst.UNIT_LIST_MANAGE_SYSTEM)
	arg_1_0:RegisterUnitList(IslandConst.UNIT_LIST_MANAGE)
	arg_1_0:RegisterUnitList(IslandConst.UNIT_LIST_DELEGATION_ANIMATION)
	arg_1_0:RegisterUnitList(IslandConst.UNIT_LIST_FOLLOW)
	arg_1_0:RegisterUnitList(IslandConst.UNIT_LIST_DELAY)
	arg_1_0:RegisterUnitList(IslandConst.UNIT_LIST_PHOTO)
	arg_1_0:RegisterUnitList(IslandConst.UNIT_LIST_FISH_POINT)
	arg_1_0:RegisterUnitList(IslandConst.UNIT_LIST_DELEGATE_UNIT)
	arg_1_0:RegisterUnitList(IslandConst.UNIT_LIST_PRODUCT_SYSTEM)
	arg_1_0:RegisterUnitList(IslandConst.UNIT_LIST_CHEATER_ITEM)

	arg_1_0.unitBuilders = {
		[IslandConst.UNIT_TYPE_ITEM] = IslandStaticUnitBuilder.New(arg_1_0, IslandConst.UNIT_LIST_OBJ),
		[IslandConst.UNIT_TYPE_CHAR] = IslandNpcBuilder.New(arg_1_0, IslandConst.UNIT_LIST_OBJ),
		[IslandConst.UNIT_TYPE_VISITOR] = IslandVisitorBuilder.New(arg_1_0, IslandConst.UNIT_LIST_PLAYER),
		[IslandConst.UNIT_TYPE_PLAYER] = IslandPlayerBuilder.New(arg_1_0, IslandConst.UNIT_LIST_PLAYER),
		[IslandConst.UNIT_TYPE_VIRTUAL_INTERACT] = IslandVirtualInteractBuilder.New(arg_1_0, IslandConst.UNIT_LIST_OBJ),
		[IslandConst.UNIT_TYPE_ITEM_INTERACT] = IslandItemInteractBuilder.New(arg_1_0, IslandConst.UNIT_LIST_OBJ),
		[IslandConst.UNIT_TYPE_ITEM_HANDLE_COLLECT] = IslandItemHandCollectBuilder.New(arg_1_0, IslandConst.UNIT_LIST_OBJ),
		[IslandConst.UNIT_TYPE_ITEM_HANDLE_PLANTING] = IslandItemHandPlantBuilder.New(arg_1_0, IslandConst.UNIT_LIST_OBJ),
		[IslandConst.UNIT_TYPE_STROLL] = IslandStrollNpcBuilder.New(arg_1_0, IslandConst.UNIT_LIST_STROLL),
		[IslandConst.UNIT_TYPE_SYSTEM] = IslandSystemNpcBuilder.New(arg_1_0, IslandConst.UNIT_LIST_DELEGATION),
		[IslandConst.UNIT_TYPE_ITEM_GATHER_ITEM] = IslandItemWildGahterBuilder.New(arg_1_0, IslandConst.UNIT_LIST_OBJ),
		[IslandConst.UNIT_TYPE_ITEM_WILD_COLLECT_ITEM] = IslandItemWildGahterBuilder.New(arg_1_0, IslandConst.UNIT_LIST_OBJ),
		[IslandConst.UNIT_TYPE_MANAGE_CHARA] = IslandSystemDelegationUnitBuilder.New(arg_1_0, IslandConst.UNIT_LIST_MANAGE),
		[IslandConst.UNIT_TYPE_MANAGE_ITEM] = IslandStaticUnitBuilder.New(arg_1_0, IslandConst.UNIT_LIST_MANAGE),
		[IslandConst.UNIT_TYPE_MANAGE_CUSTOMER] = IslandStaticCharaBuilder.New(arg_1_0, IslandConst.UNIT_LIST_MANAGE),
		[IslandConst.UNIT_TYPE_SYSTEM_DELEAGTION] = IslandSystemDelegationUnitBuilder.New(arg_1_0, IslandConst.UNIT_LIST_DELEGATION),
		[IslandConst.UNIT_TYPE_SYSTEM_DELEAGTION_ANIMATION] = IslandSystemDelegationUnitBuilder.New(arg_1_0, IslandConst.UNIT_LIST_DELEGATION_ANIMATION),
		[IslandConst.UNIT_TYPE_FOLLOWER] = IslandFollowNpcBuilder.New(arg_1_0, IslandConst.UNIT_LIST_FOLLOW),
		[IslandConst.UNIT_TYPE_ITEM_DELAY_RECYCLE] = IslandDelayRecycleUnitBuilder.New(arg_1_0, IslandConst.UNIT_LIST_DELAY),
		[IslandConst.UNIT_TYPE_FIRST_TAKE_PHOTO_ITEM] = IslandTakePhotoBuilder.New(arg_1_0, IslandConst.UNIT_LIST_PHOTO),
		[IslandConst.UNIT_TYPE_FISH_POINT] = IslandStaticUnitBuilder.New(arg_1_0, IslandConst.UNIT_LIST_FISH_POINT),
		[IslandConst.UNIT_TYPE_DELEGATE_FISH] = IslandDelegationFishBuilder.New(arg_1_0, IslandConst.UNIT_LIST_DELEGATE_UNIT),
		[IslandConst.UNIT_TYPE_CHEATERTAVERN_PLAYER] = IslandCheaterTavernPlayerBuilder.New(arg_1_0, IslandConst.UNIT_LIST_PLAYER),
		[IslandConst.UNIT_TYPE_CHEATERTAVERN_TABLE] = IslandCheaterTavernTableBuilder.New(arg_1_0, IslandConst.UNIT_LIST_CHEATER_ITEM),
		[IslandConst.UNIT_TYPE_CHEATERTAVERN_CHAIR] = IslandCheaterTavernChairBuilder.New(arg_1_0, IslandConst.UNIT_LIST_CHEATER_ITEM)
	}
	arg_1_0.systemBuilders = {
		[IslandConst.SYSTEM_TYPE_CHARACTER] = IslandSystemBuilder.New(arg_1_0, IslandCharacterSystem),
		[IslandConst.SYSTEM_TYPE_PRODUCT] = IslandSystemBuilder.New(arg_1_0, IslandProductSystem, IslandConst.UNIT_LIST_PRODUCT_SYSTEM),
		[IslandConst.SYSTEM_TYPE_SEEKGAME] = IslandSystemBuilder.New(arg_1_0, IslandSeekGameSystem),
		[IslandConst.SYSTEM_TYPE_GROUND] = IslandGroundSystemBuilder.New(arg_1_0, IslandGoundLayerSystem),
		[IslandConst.SYSTEM_TYPE_GRASSLAND] = IslandSystemBuilder.New(arg_1_0, IslandGrassLandSystem),
		[IslandConst.SYSTEM_TYPE_MANAGE] = IslandManageSystemBuilder.New(arg_1_0, IslandManageSystem)
	}
	arg_1_0.detectionSystem = IslandDetectionSystem.New(arg_1_0)
	arg_1_0.effectMgr = IslandDelegateEffectMgr.New(arg_1_0)
	arg_1_0.coupleActionPlayer = IslandCoupleActionPlayer.New(arg_1_0)
	arg_1_0.coupleAction4FollowerPlayer = IslandCoupleAction4FollowerPlayer.New(arg_1_0)
	arg_1_0.npcActionPlayer = IslandNpcActionPlayer.New(arg_1_0)
	arg_1_0.weatherSystem = IslandWeatherSystem.New(arg_1_0)
	arg_1_0.coupleNpcWordPlayer = IslandCoupleNpcWordPlayer.New(arg_1_0)
	arg_1_0.pathfinders = {}
	arg_1_0.fishingSynPlayers = {}

	arg_1_0:CreateViews()

	return
end

function var_0_0.CreateViews(arg_2_0)
	arg_2_0.views = {
		arg_2_0:CreateInteractionView(),
		arg_2_0:CreateDistanceView(),
		arg_2_0:CreateSeedOpView(),
		arg_2_0:CreateOpView(),
		arg_2_0:CreateSlotHudView(),
		arg_2_0:CreateTopHeadHudView(),
		arg_2_0:CreateBottomHeadHudeView(),
		arg_2_0:CreateCancelAnimationOpView(),
		arg_2_0:CreateEffectView(),
		arg_2_0:CreateAnimationOpView()
	}

	return
end

function var_0_0.DoEnter(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0:GetAllUnits()) do
		table.insert({}, function(arg_4_0)
			iter_3_1:Start()

			if iter_3_0 % 3 == 0 then
				arg_4_0()
			else
				onNextTick(arg_4_0)
			end

			return
		end)
	end

	seriesAsync({}, function()
		arg_3_0.isInit = true

		return
	end)

	return
end

function var_0_0.GetSubView(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.views or {}

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		if isa(iter_6_1, arg_6_1) then
			return iter_6_1
		end
	end

	return nil
end

function var_0_0.CreateEffectView(arg_7_0)
	return IslandEffectView.New(arg_7_0)
end

function var_0_0.CreateOpView(arg_8_0)
	return IslandOpView.New(arg_8_0)
end

function var_0_0.CreateSlotHudView(arg_9_0)
	return IslandSlotHudView.New(arg_9_0)
end

function var_0_0.CreateCancelAnimationOpView(arg_10_0)
	return IslandCancelAnimationOpView.New(arg_10_0)
end

function var_0_0.CreateTopHeadHudView(arg_11_0)
	return IslandTopHeadHudView.New(arg_11_0)
end

function var_0_0.CreateBottomHeadHudeView(arg_12_0)
	return IslandBottomHeadHudView.New(arg_12_0)
end

function var_0_0.CreateAnimationOpView(arg_13_0)
	return IslandAniamtionOpView.New(arg_13_0)
end

function var_0_0.CreateInteractionView(arg_14_0)
	return IslandInteractionView.New(arg_14_0)
end

function var_0_0.CreateDistanceView(arg_15_0)
	return IslandDistanceView.New(arg_15_0)
end

function var_0_0.CreateSeedOpView(arg_16_0)
	return IslandSeedOpView.New(arg_16_0)
end

function var_0_0.IsLoaded(arg_17_0)
	local var_17_0 = arg_17_0:GetAllUnits()

	return _.all(arg_17_0.views, function(arg_18_0)
		return arg_18_0:IsLoaded()
	end) and #var_17_0 > 0 and _.all(var_17_0, function(arg_19_0)
		return arg_19_0:IsLoaded()
	end)
end

function var_0_0.IsInit(arg_20_0)
	return arg_20_0.isInit
end

function var_0_0.Update(arg_21_0)
	if not arg_21_0.isInit then
		return
	end

	for iter_21_0, iter_21_1 in ipairs(arg_21_0:GetAllUnits()) do
		iter_21_1:Update()
	end

	for iter_21_2, iter_21_3 in ipairs(arg_21_0.views) do
		iter_21_3:Update()
	end

	for iter_21_4, iter_21_5 in ipairs(arg_21_0.pathfinders) do
		iter_21_5:Update()
	end

	if arg_21_0.needTryTrack then
		arg_21_0:TryTrack()
	end

	if arg_21_0.needTryMainTrack then
		arg_21_0:TryMainTrack()
	end

	return
end

function var_0_0.LateUpdate(arg_22_0)
	if not arg_22_0.isInit then
		return
	end

	for iter_22_0, iter_22_1 in ipairs(arg_22_0:GetAllUnits()) do
		iter_22_1:LateUpdate()
	end

	for iter_22_2, iter_22_3 in ipairs(arg_22_0.views) do
		iter_22_3:LateUpdate()
	end

	for iter_22_4, iter_22_5 in ipairs(arg_22_0.pathfinders) do
		iter_22_5:LateUpdate()
	end

	return
end

function var_0_0.AddListeners(arg_23_0)
	arg_23_0:AddListener(ISLAND_EVT.GEN_UNIT, arg_23_0.OnGenUnit)
	arg_23_0:AddListener(ISLAND_EVT.RMOVE_UNIT, arg_23_0.OnRemoveUnit)
	arg_23_0:AddListener(ISLAND_EVT.INTERACTION_UNIT_BEGIN, arg_23_0.OnInterActionBegin)
	arg_23_0:AddListener(ISLAND_EVT.INTERACTION_UNIT_END, arg_23_0.OnInterActionEnd)
	arg_23_0:AddListener(ISLAND_EVT.STOP_MOVE_UNIT, arg_23_0.OnStopUnit)
	arg_23_0:AddListener(ISLAND_EVT.MOVE_UNIT, arg_23_0.OnMoveUnit)
	arg_23_0:AddListener(ISLAND_EVT.INIT_FINISH, arg_23_0.OnSceneInited)
	arg_23_0:AddListener(ISLAND_EVT.MOVE_PLAYER, arg_23_0.OnPlayerMove)
	arg_23_0:AddListener(ISLAND_EVT.STOP_MOVE_PLAYER, arg_23_0.OnPlayerStopMoveHandle)
	arg_23_0:AddListener(ISLAND_EVT.JUMP_PLAYER, arg_23_0.OnPlayerJump)
	arg_23_0:AddListener(ISLAND_EVT.APPROACH_UNIT, arg_23_0.OnShowInterActionPanel)
	arg_23_0:AddListener(ISLAND_EVT.LEAVE_UNIT, arg_23_0.OnHideInterActionPanel)
	arg_23_0:AddListener(ISLAND_EVT.TRACKING, arg_23_0.OnTracking)
	arg_23_0:AddListener(ISLAND_EVT.UNTRACKING, arg_23_0.OnUnTracking)
	arg_23_0:AddListener(ISLAND_EVT.AREACHANGE, arg_23_0.OnPlayerAreaChange)
	arg_23_0:AddListener(ISLAND_EVT.PLAYERRUN, arg_23_0.OnPlayerPlayerRun)
	arg_23_0:AddListener(ISLAND_EVT.SPRINT_PLAYER, arg_23_0.OnPlayerPlayerSprint)
	arg_23_0:AddListener(ISLAND_EVT.STOP_SPRINT_PLAYER, arg_23_0.OnStopPlayerSprint)
	arg_23_0:AddListener(ISLAND_EVT.CHANGE_DRESS, arg_23_0.OnChangeDress)
	arg_23_0:AddListener(ISLAND_EVT.CHANGE_CHARACTER_DRESS, arg_23_0.OnCharacterChangeDress)
	arg_23_0:AddListener(ISLAND_EVT.MORPH_FORM_CHANGE, arg_23_0.OnMorphFormChange)
	arg_23_0:AddListener(ISLAND_EVT.RESET_UNIT_POS, arg_23_0.OnResetUnitPos)
	arg_23_0:AddListener(ISLAND_EVT.RESET_UNIT_ROT, arg_23_0.OnResetUnitRotation)
	arg_23_0:AddListener(ISLAND_EVT.ANY_PAGE_OPENED, arg_23_0.OnAnyPageOpen)
	arg_23_0:AddListener(ISLAND_EVT.ALL_PAGE_CLOSED, arg_23_0.OnAllPageClose)
	arg_23_0:AddListener(ISLAND_EVT.Change_TakePhoto_Model, arg_23_0.OnChangeTakePhotoModel)
	arg_23_0:AddListener(ISLAND_EVT.Change_Photo_Height, arg_23_0.OnChange_Photo_Height)
	arg_23_0:AddListener(ISLAND_EVT.SetOpMoveBtnActve, arg_23_0.OnSetOpMoveBtnActve)
	arg_23_0:AddListener(ISLAND_EVT.PLAY_BUBBLE, arg_23_0.OnPlayChatBubble)
	arg_23_0:AddListener(ISLAND_EVT.RAW_PLAY_BUBBLE, arg_23_0.OnRawPlayChatBubble)
	arg_23_0:AddListener(ISLAND_EVT.RAW_STOP_BUBBLE, arg_23_0.OnRawStopChatBubble)
	arg_23_0:AddListener(ISLAND_EVT.START_STORY, arg_23_0.OnStartStory)
	arg_23_0:AddListener(ISLAND_EVT.END_STORY, arg_23_0.OnEndStory)
	arg_23_0:AddListener(ISLAND_EVT.START_DEGATION, arg_23_0.OnStartDelegation)
	arg_23_0:AddListener(ISLAND_EVT.END_DEGATION, arg_23_0.OnEndDelegation)
	arg_23_0:AddListener(ISLAND_EVT.GEN_SYSTEM, arg_23_0.OnGenSystem)
	arg_23_0:AddListener(ISLAND_EVT.WORLD_OBJECT_START_INTERACTION, arg_23_0.OnWorldObjectStartInteraction)
	arg_23_0:AddListener(ISLAND_EVT.WORLD_OBJECT_END_INTERACTION, arg_23_0.OnWorldObjectEndInteraction)
	arg_23_0:AddListener(ISLAND_EVT.WORLD_OBJECT_INIT_STATUS, arg_23_0.OnWorldObjectInitStatus)
	arg_23_0:AddListener(ISLAND_EVT.INIT_INTERACTION_OP_VIEW, arg_23_0.InitInteractionOpView)
	arg_23_0:AddListener(ISLAND_EVT.REFRESH_INTERACTION, arg_23_0.OnRefreshInteractionBtn)
	arg_23_0:AddListener(ISLAND_EVT.SHOW_UNIT_HUD_OP, arg_23_0.OnShowUnitHudAndOpBtn)
	arg_23_0:AddListener(ISLAND_EVT.HIDE_UNIT_HUD_OP, arg_23_0.OnHideUnitHudAndOpBtn)
	arg_23_0:AddListener(ISLAND_EVT.DETECTOR_CHANGED, arg_23_0.OnDetectorChanged)
	arg_23_0:AddListener(ISLAND_EVT.SELECTED_DETECTOR, arg_23_0.OnDetectorSelected)
	arg_23_0:AddListener(ISLAND_EVT.FISHPOINT_DETECTOR, arg_23_0.OnFishPointSelected)
	arg_23_0:AddListener(ISLAND_EVT.NPC_DETECTED, arg_23_0.OnNpcDetectorSelected)
	arg_23_0:AddListener(ISLAND_EVT.NO_NPC_DETECTED, arg_23_0.OnNpcDetectorUnSelected)
	arg_23_0:AddListener(ISLAND_EVT.SET_PLAYER_WORK, arg_23_0.OnPlayerWork)
	arg_23_0:AddListener(ISLAND_EVT.DEVIEE_STATE_CHANGE, arg_23_0.OnPlayerDeviceStateChange)
	arg_23_0:AddListener(ISLAND_EVT.UPDATE_HUD, arg_23_0.OnUpdateHud)
	arg_23_0:AddListener(ISLAND_EVT.PLAY_EFFECT, arg_23_0.OnPlayEffect)
	arg_23_0:AddListener(ISLAND_EVT.UPDATE_UNIT_HAND_COLLECT, arg_23_0.OnUpdateHandCollectUnit)
	arg_23_0:AddListener(ISLAND_EVT.START_DELEGATE_SLOT_PERFORM, arg_23_0.OnDelegateSlotStartPerform)
	arg_23_0:AddListener(ISLAND_EVT.RECYCLE_ALL_SLOTDELEEFFECT, arg_23_0.OnRecycleAllSlotEffct)
	arg_23_0:AddListener(ISLAND_EVT.SELECTDELEEFFECT_SHOW, arg_23_0.OnSelectSlotEffectShow)
	arg_23_0:AddListener(ISLAND_EVT.LOAD_DELEGATE_PREVIEW_ROLE, arg_23_0.OnLoadDelegatePreviewRole)
	arg_23_0:AddListener(ISLAND_EVT.UN_LOAD_DELEGATE_PREVIEW_ROLE, arg_23_0.OnUnLoadDelegatePreviewRole)
	arg_23_0:AddListener(ISLAND_EVT.Take_Plant_Attact, arg_23_0.OnTakePlantAttack)
	arg_23_0:AddListener(ISLAND_EVT.START_MANAGE, arg_23_0.OnStartManage)
	arg_23_0:AddListener(ISLAND_EVT.END_MANAGE, arg_23_0.OnEndManage)
	arg_23_0:AddListener(ISLAND_EVT.SHOW_HUD, arg_23_0.OnShowHud)
	arg_23_0:AddListener(ISLAND_EVT.HIDE_HUD, arg_23_0.OnHideHud)
	arg_23_0:AddListener(ISLAND_EVT.REFRESH_HUD, arg_23_0.OnRefreshHud)
	arg_23_0:AddListener(ISLAND_EVT.START_GUIDE, arg_23_0.OnStartGuide)
	arg_23_0:AddListener(ISLAND_EVT.END_GUIDE, arg_23_0.OnEndGuide)
	arg_23_0:AddListener(ISLAND_EVT.START_PERFORMANCE, arg_23_0.OnStartPerformance)
	arg_23_0:AddListener(ISLAND_EVT.END_PERFORMANCE, arg_23_0.OnEndPerformance)
	arg_23_0:AddListener(ISLAND_EVT.DISABLE_INPUT, arg_23_0.DisableInput)
	arg_23_0:AddListener(ISLAND_EVT.ENABLE_INPUT, arg_23_0.EnableInput)
	arg_23_0:AddListener(ISLAND_EVT.GEN_PATH_FINDER, arg_23_0.OnGenPathFinder)
	arg_23_0:AddListener(ISLAND_EVT.REMOVE_PATH_FINDER, arg_23_0.OnRemovePathFinder)
	arg_23_0:AddListener(ISLAND_EVT.ACTIVE_OR_DISACTIVE_UNIT, arg_23_0.OnActiveOrDisactiveUnit)
	arg_23_0:AddListener(ISLAND_EVT.OPEN_ANIMATION_OP, arg_23_0.OnOpenAniamtionOpPage)
	arg_23_0:AddListener(ISLAND_EVT.CLOSE_ANIMATION_OP, arg_23_0.OnCloseAniamtionOpPage)
	arg_23_0:AddListener(ISLAND_EVT.MOVE_PLAYER_BEFORE, arg_23_0.OnMovePlayerBefore)
	arg_23_0:AddListener(ISLAND_EVT.REFRESH_TASK_HUD_INFO, arg_23_0.OnRefreshTaskInfoHud)
	arg_23_0:AddListener(ISLAND_EVT.RESPON_ANIMATION_OP, arg_23_0.OnResponAniamtionOp)
	arg_23_0:AddListener(ISLAND_EVT.CHANGE_VISTER_DRESS, arg_23_0.OnChangeVisterDress)
	arg_23_0:AddListener(ISLAND_EVT.SET_VISITOR_SYNC_DATA, arg_23_0.OnSetVisitorSyncData)
	arg_23_0:AddListener(ISLAND_EVT.SHOW_NPC_ANIMATION_BUBBLE, arg_23_0.OnShowNpcAniamtionBubble)
	arg_23_0:AddListener(ISLAND_EVT.HIDE_NPC_ANIMATION_BUBBLE, arg_23_0.OnHideNpcAniamtionBubble)
	arg_23_0:AddListener(ISLAND_EVT.PLAY_SIGNLE_ANIMATION_END, arg_23_0.OnPlaySingleAnimationEnd)
	arg_23_0:AddListener(ISLAND_EVT.UPDATE_CUSTOM_OP_POSITON, arg_23_0.OnUpdateCustomOpPositon)
	arg_23_0:AddListener(ISLAND_EVT.CHAT_MSG_UPDATE, arg_23_0.OnChatMsgUpdate)
	arg_23_0:AddListener(ISLAND_EVT.CHAT_ROOM_UPDATE, arg_23_0.OnChatRoomChange)
	arg_23_0:AddListener(ISLAND_EVT.SHOW_CHAT_MSG, arg_23_0.OnShowChatMsg)
	arg_23_0:AddListener(ISLAND_EVT.RESET_FOLLOW_RANDOMIZER, arg_23_0.OnResetFollowRandomizer)
	arg_23_0:AddListener(ISLAND_EVT.ADD_FOLLOWER, arg_23_0.OnFollowerAdd)
	arg_23_0:AddListener(ISLAND_EVT.WILL_DEL_FOLLOWER, arg_23_0.OnFollowerWillDelStep1)
	arg_23_0:AddListener(ISLAND_EVT.DO_DEL_FOLLOWER, arg_23_0.OnFollowerWillDelStep2)
	arg_23_0:AddListener(ISLAND_EVT.DEL_FOLLOWER, arg_23_0.OnFollowerDel)
	arg_23_0:AddListener(ISLAND_EVT.COUPLE_ACTION_WITH_FOLLOWER, arg_23_0.OnCoupleActionWithFollower)
	arg_23_0:AddListener(ISLAND_EVT.LOCK_PLAYER_INPUT, arg_23_0.OnLockPlayerInput)
	arg_23_0:AddListener(ISLAND_EVT.START_COUPLE_ACTION, arg_23_0.OnStartCoupleAction)
	arg_23_0:AddListener(ISLAND_EVT.END_COUPLE_ACTION, arg_23_0.OnEndCoupleAction)
	arg_23_0:AddListener(ISLAND_EVT.REFRESH_WEATHER_SYSTEM, arg_23_0.OnRefreshWeatherSystem)
	arg_23_0:AddListener(ISLAND_EVT.SYSTEM_UNLOCK, arg_23_0.OnSystemUnlock)
	arg_23_0:AddListener(ISLAND_EVT.START_DO_COUPLE_ACTION, arg_23_0.OnStartDoCoupleAction)
	arg_23_0:AddListener(ISLAND_EVT.END_DO_COUPLE_ACTION, arg_23_0.OnEndDoCoupleAction)
	arg_23_0:AddListener(ISLAND_EVT.CANCEL_COUPLE_ACTION, arg_23_0.OnCancelCoupleAction)
	arg_23_0:AddListener(ISLAND_EVT.BAIT_UPDATE, arg_23_0.OnBaitUpdate)
	arg_23_0:AddListener(ISLAND_EVT.START_FISHING, arg_23_0.OnStartFishing)
	arg_23_0:AddListener(ISLAND_EVT.FISHING_STATE_CHANGE, arg_23_0.OnFishingStateChange)
	arg_23_0:AddListener(ISLAND_EVT.ALL_DAILY_OR_WEEKLY_FINISH, arg_23_0.OnAllDailyOrWeeklyFinish)

	return
end

function var_0_0.RemoveListeners(arg_24_0)
	arg_24_0:RemoveListener(ISLAND_EVT.GEN_UNIT, arg_24_0.OnGenUnit)
	arg_24_0:RemoveListener(ISLAND_EVT.RMOVE_UNIT, arg_24_0.OnRemoveUnit)
	arg_24_0:RemoveListener(ISLAND_EVT.INTERACTION_UNIT_BEGIN, arg_24_0.OnInterActionBegin)
	arg_24_0:RemoveListener(ISLAND_EVT.INTERACTION_UNIT_END, arg_24_0.OnInterActionEnd)
	arg_24_0:RemoveListener(ISLAND_EVT.STOP_MOVE_UNIT, arg_24_0.OnStopUnit)
	arg_24_0:RemoveListener(ISLAND_EVT.MOVE_UNIT, arg_24_0.OnMoveUnit)
	arg_24_0:RemoveListener(ISLAND_EVT.INIT_FINISH, arg_24_0.OnSceneInited)
	arg_24_0:RemoveListener(ISLAND_EVT.MOVE_PLAYER, arg_24_0.OnPlayerMove)
	arg_24_0:RemoveListener(ISLAND_EVT.STOP_MOVE_PLAYER, arg_24_0.OnPlayerStopMoveHandle)
	arg_24_0:RemoveListener(ISLAND_EVT.JUMP_PLAYER, arg_24_0.OnPlayerJump)
	arg_24_0:RemoveListener(ISLAND_EVT.APPROACH_UNIT, arg_24_0.OnShowInterActionPanel)
	arg_24_0:RemoveListener(ISLAND_EVT.LEAVE_UNIT, arg_24_0.OnHideInterActionPanel)
	arg_24_0:RemoveListener(ISLAND_EVT.TRACKING, arg_24_0.OnTracking)
	arg_24_0:RemoveListener(ISLAND_EVT.UNTRACKING, arg_24_0.OnUnTracking)
	arg_24_0:RemoveListener(ISLAND_EVT.AREACHANGE, arg_24_0.OnPlayerAreaChange)
	arg_24_0:RemoveListener(ISLAND_EVT.PLAYERRUN, arg_24_0.OnPlayerPlayerRun)
	arg_24_0:RemoveListener(ISLAND_EVT.SPRINT_PLAYER, arg_24_0.OnPlayerPlayerSprint)
	arg_24_0:RemoveListener(ISLAND_EVT.STOP_SPRINT_PLAYER, arg_24_0.OnStopPlayerSprint)
	arg_24_0:RemoveListener(ISLAND_EVT.CHANGE_DRESS, arg_24_0.OnChangeDress)
	arg_24_0:RemoveListener(ISLAND_EVT.CHANGE_CHARACTER_DRESS, arg_24_0.OnCharacterChangeDress)
	arg_24_0:RemoveListener(ISLAND_EVT.MORPH_FORM_CHANGE, arg_24_0.OnMorphFormChange)
	arg_24_0:RemoveListener(ISLAND_EVT.RESET_UNIT_POS, arg_24_0.OnResetUnitPos)
	arg_24_0:RemoveListener(ISLAND_EVT.RESET_UNIT_ROT, arg_24_0.OnResetUnitRotation)
	arg_24_0:RemoveListener(ISLAND_EVT.ANY_PAGE_OPENED, arg_24_0.OnAnyPageOpen)
	arg_24_0:RemoveListener(ISLAND_EVT.Change_TakePhoto_Model, arg_24_0.OnChangeTakePhotoModel)
	arg_24_0:RemoveListener(ISLAND_EVT.Change_Photo_Height, arg_24_0.OnChange_Photo_Height)
	arg_24_0:RemoveListener(ISLAND_EVT.SetOpMoveBtnActve, arg_24_0.OnSetOpMoveBtnActve)
	arg_24_0:RemoveListener(ISLAND_EVT.ALL_PAGE_CLOSED, arg_24_0.OnAllPageClose)
	arg_24_0:RemoveListener(ISLAND_EVT.PLAY_BUBBLE, arg_24_0.OnPlayChatBubble)
	arg_24_0:RemoveListener(ISLAND_EVT.RAW_PLAY_BUBBLE, arg_24_0.OnRawPlayChatBubble)
	arg_24_0:RemoveListener(ISLAND_EVT.RAW_STOP_BUBBLE, arg_24_0.OnRawStopChatBubble)
	arg_24_0:RemoveListener(ISLAND_EVT.START_STORY, arg_24_0.OnStartStory)
	arg_24_0:RemoveListener(ISLAND_EVT.END_STORY, arg_24_0.OnEndStory)
	arg_24_0:RemoveListener(ISLAND_EVT.START_DEGATION, arg_24_0.OnStartDelegation)
	arg_24_0:RemoveListener(ISLAND_EVT.END_DEGATION, arg_24_0.OnEndDelegation)
	arg_24_0:RemoveListener(ISLAND_EVT.GEN_SYSTEM, arg_24_0.OnGenSystem)
	arg_24_0:RemoveListener(ISLAND_EVT.WORLD_OBJECT_START_INTERACTION, arg_24_0.OnWorldObjectStartInteraction)
	arg_24_0:RemoveListener(ISLAND_EVT.WORLD_OBJECT_END_INTERACTION, arg_24_0.OnWorldObjectEndInteraction)
	arg_24_0:RemoveListener(ISLAND_EVT.WORLD_OBJECT_INIT_STATUS, arg_24_0.OnWorldObjectInitStatus)
	arg_24_0:RemoveListener(ISLAND_EVT.INIT_INTERACTION_OP_VIEW, arg_24_0.InitInteractionOpView)
	arg_24_0:RemoveListener(ISLAND_EVT.REFRESH_INTERACTION, arg_24_0.OnRefreshInteractionBtn)
	arg_24_0:RemoveListener(ISLAND_EVT.SHOW_UNIT_HUD_OP, arg_24_0.OnShowUnitHudAndOpBtn)
	arg_24_0:RemoveListener(ISLAND_EVT.HIDE_UNIT_HUD_OP, arg_24_0.OnHideUnitHudAndOpBtn)
	arg_24_0:RemoveListener(ISLAND_EVT.DETECTOR_CHANGED, arg_24_0.OnDetectorChanged)
	arg_24_0:RemoveListener(ISLAND_EVT.SELECTED_DETECTOR, arg_24_0.OnDetectorSelected)
	arg_24_0:RemoveListener(ISLAND_EVT.FISHPOINT_DETECTOR, arg_24_0.OnFishPointSelected)
	arg_24_0:RemoveListener(ISLAND_EVT.NPC_DETECTED, arg_24_0.OnNpcDetectorSelected)
	arg_24_0:RemoveListener(ISLAND_EVT.NO_NPC_DETECTED, arg_24_0.OnNpcDetectorUnSelected)
	arg_24_0:RemoveListener(ISLAND_EVT.SET_PLAYER_WORK, arg_24_0.OnPlayerWork)
	arg_24_0:RemoveListener(ISLAND_EVT.DEVIEE_STATE_CHANGE, arg_24_0.OnPlayerDeviceStateChange)
	arg_24_0:RemoveListener(ISLAND_EVT.UPDATE_HUD, arg_24_0.OnUpdateHud)
	arg_24_0:RemoveListener(ISLAND_EVT.PLAY_EFFECT, arg_24_0.OnPlayEffect)
	arg_24_0:RemoveListener(ISLAND_EVT.UPDATE_UNIT_HAND_COLLECT, arg_24_0.OnUpdateHandCollectUnit)
	arg_24_0:RemoveListener(ISLAND_EVT.RECYCLE_ALL_SLOTDELEEFFECT, arg_24_0.OnRecycleAllSlotEffct)
	arg_24_0:RemoveListener(ISLAND_EVT.SELECTDELEEFFECT_SHOW, arg_24_0.OnSelectSlotEffectShow)
	arg_24_0:RemoveListener(ISLAND_EVT.LOAD_DELEGATE_PREVIEW_ROLE, arg_24_0.OnLoadDelegatePreviewRole)
	arg_24_0:RemoveListener(ISLAND_EVT.UN_LOAD_DELEGATE_PREVIEW_ROLE, arg_24_0.OnUnLoadDelegatePreviewRole)
	arg_24_0:RemoveListener(ISLAND_EVT.Take_Plant_Attact, arg_24_0.OnTakePlantAttack)
	arg_24_0:RemoveListener(ISLAND_EVT.START_MANAGE, arg_24_0.OnStartManage)
	arg_24_0:RemoveListener(ISLAND_EVT.END_MANAGE, arg_24_0.OnEndManage)
	arg_24_0:RemoveListener(ISLAND_EVT.SHOW_HUD, arg_24_0.OnShowHud)
	arg_24_0:RemoveListener(ISLAND_EVT.HIDE_HUD, arg_24_0.OnHideHud)
	arg_24_0:RemoveListener(ISLAND_EVT.REFRESH_HUD, arg_24_0.OnRefreshHud)
	arg_24_0:RemoveListener(ISLAND_EVT.START_GUIDE, arg_24_0.OnStartGuide)
	arg_24_0:RemoveListener(ISLAND_EVT.END_GUIDE, arg_24_0.OnEndGuide)
	arg_24_0:RemoveListener(ISLAND_EVT.START_PERFORMANCE, arg_24_0.OnStartPerformance)
	arg_24_0:RemoveListener(ISLAND_EVT.END_PERFORMANCE, arg_24_0.OnEndPerformance)
	arg_24_0:RemoveListener(ISLAND_EVT.DISABLE_INPUT, arg_24_0.DisableInput)
	arg_24_0:RemoveListener(ISLAND_EVT.ENABLE_INPUT, arg_24_0.EnableInput)
	arg_24_0:RemoveListener(ISLAND_EVT.GEN_PATH_FINDER, arg_24_0.OnGenPathFinder)
	arg_24_0:RemoveListener(ISLAND_EVT.REMOVE_PATH_FINDER, arg_24_0.OnRemovePathFinder)
	arg_24_0:RemoveListener(ISLAND_EVT.ACTIVE_OR_DISACTIVE_UNIT, arg_24_0.OnActiveOrDisactiveUnit)
	arg_24_0:RemoveListener(ISLAND_EVT.OPEN_ANIMATION_OP, arg_24_0.OnOpenAniamtionOpPage)
	arg_24_0:RemoveListener(ISLAND_EVT.CLOSE_ANIMATION_OP, arg_24_0.OnCloseAniamtionOpPage)
	arg_24_0:RemoveListener(ISLAND_EVT.MOVE_PLAYER_BEFORE, arg_24_0.OnMovePlayerBefore)
	arg_24_0:RemoveListener(ISLAND_EVT.REFRESH_TASK_HUD_INFO, arg_24_0.OnRefreshTaskInfoHud)
	arg_24_0:RemoveListener(ISLAND_EVT.RESPON_ANIMATION_OP, arg_24_0.OnResponAniamtionOp)
	arg_24_0:RemoveListener(ISLAND_EVT.CHANGE_VISTER_DRESS, arg_24_0.OnChangeVisterDress)
	arg_24_0:RemoveListener(ISLAND_EVT.SET_VISITOR_SYNC_DATA, arg_24_0.OnSetVisitorSyncData)
	arg_24_0:RemoveListener(ISLAND_EVT.SHOW_NPC_ANIMATION_BUBBLE, arg_24_0.OnShowNpcAniamtionBubble)
	arg_24_0:RemoveListener(ISLAND_EVT.HIDE_NPC_ANIMATION_BUBBLE, arg_24_0.OnHideNpcAniamtionBubble)
	arg_24_0:RemoveListener(ISLAND_EVT.PLAY_SIGNLE_ANIMATION_END, arg_24_0.OnPlaySingleAnimationEnd)
	arg_24_0:RemoveListener(ISLAND_EVT.UPDATE_CUSTOM_OP_POSITON, arg_24_0.OnUpdateCustomOpPositon)
	arg_24_0:RemoveListener(ISLAND_EVT.CHAT_MSG_UPDATE, arg_24_0.OnChatMsgUpdate)
	arg_24_0:RemoveListener(ISLAND_EVT.CHAT_ROOM_UPDATE, arg_24_0.OnChatRoomChange)
	arg_24_0:RemoveListener(ISLAND_EVT.SHOW_CHAT_MSG, arg_24_0.OnShowChatMsg)
	arg_24_0:RemoveListener(ISLAND_EVT.RESET_FOLLOW_RANDOMIZER, arg_24_0.OnResetFollowRandomizer)
	arg_24_0:RemoveListener(ISLAND_EVT.ADD_FOLLOWER, arg_24_0.OnFollowerAdd)
	arg_24_0:RemoveListener(ISLAND_EVT.WILL_DEL_FOLLOWER, arg_24_0.OnFollowerWillDelStep1)
	arg_24_0:RemoveListener(ISLAND_EVT.DO_DEL_FOLLOWER, arg_24_0.OnFollowerWillDelStep2)
	arg_24_0:RemoveListener(ISLAND_EVT.DEL_FOLLOWER, arg_24_0.OnFollowerDel)
	arg_24_0:RemoveListener(ISLAND_EVT.COUPLE_ACTION_WITH_FOLLOWER, arg_24_0.OnCoupleActionWithFollower)
	arg_24_0:RemoveListener(ISLAND_EVT.LOCK_PLAYER_INPUT, arg_24_0.OnLockPlayerInput)
	arg_24_0:RemoveListener(ISLAND_EVT.START_COUPLE_ACTION, arg_24_0.OnStartCoupleAction)
	arg_24_0:RemoveListener(ISLAND_EVT.END_COUPLE_ACTION, arg_24_0.OnEndCoupleAction)
	arg_24_0:RemoveListener(ISLAND_EVT.REFRESH_WEATHER_SYSTEM, arg_24_0.OnRefreshWeatherSystem)
	arg_24_0:RemoveListener(ISLAND_EVT.SYSTEM_UNLOCK, arg_24_0.OnSystemUnlock)
	arg_24_0:RemoveListener(ISLAND_EVT.START_DO_COUPLE_ACTION, arg_24_0.OnStartDoCoupleAction)
	arg_24_0:RemoveListener(ISLAND_EVT.END_DO_COUPLE_ACTION, arg_24_0.OnEndDoCoupleAction)
	arg_24_0:RemoveListener(ISLAND_EVT.CANCEL_COUPLE_ACTION, arg_24_0.OnCancelCoupleAction)
	arg_24_0:RemoveListener(ISLAND_EVT.BAIT_UPDATE, arg_24_0.OnBaitUpdate)
	arg_24_0:RemoveListener(ISLAND_EVT.START_FISHING, arg_24_0.OnStartFishing)
	arg_24_0:RemoveListener(ISLAND_EVT.FISHING_STATE_CHANGE, arg_24_0.OnFishingStateChange)
	arg_24_0:RemoveListener(ISLAND_EVT.ALL_DAILY_OR_WEEKLY_FINISH, arg_24_0.OnAllDailyOrWeeklyFinish)

	return
end

function var_0_0.OnBaitUpdate(arg_25_0, arg_25_1)
	arg_25_0:GetSubView(IslandOpView):UpdateLureBtn()

	return
end

function var_0_0.OnFishPointSelected(arg_26_0, arg_26_1)
	if not arg_26_1.node then
		return
	end

	local var_26_0 = arg_26_1.node:GetBlackboardVariable("FishPoint")

	if not var_26_0 or var_26_0 == "" then
		arg_26_0:UnSelectedFishPoint()
	else
		local var_26_1, var_26_2 = IslandCalcUtil.GetTypeAndIdByUniqueId(var_26_0)
		local var_26_3 = arg_26_0:GetUnitModuleWithType(var_26_1, var_26_2)

		if var_26_3 then
			arg_26_0:SelectedFishPoint(var_26_3)
		end
	end

	return
end

function var_0_0.OnAllDailyOrWeeklyFinish(arg_27_0, arg_27_1)
	for iter_27_0, iter_27_1 in ipairs((arg_27_0:GetUnitListByKey(IslandConst.UNIT_LIST_FOLLOW))) do
		if not iter_27_1:IsExitState() then
			table.insert({}, iter_27_1)
		end
	end

	if #{} <= 0 then
		return
	end

	for iter_27_2, iter_27_3 in ipairs({}) do
		iter_27_3:StopMove()
		iter_27_3:PlayAnimation(arg_27_1)
	end

	return
end

function var_0_0.OnSystemUnlock(arg_28_0, arg_28_1)
	if arg_28_1 == IslandAblityAgency.ANIMATION_OP_ID then
		arg_28_0:GetSubView(IslandOpView):UpdateAnimationOpBtn()
	end

	return
end

function var_0_0.SelectedFishPoint(arg_29_0, arg_29_1)
	if not arg_29_0:GetSelfIsland():GetAblityAgency():IsUnlockFishing() or arg_29_1:GetUnitType() ~= IslandConst.UNIT_LIST_FISH_POINT or arg_29_0.player:StandOnWorldObject() or not arg_29_0.player:OnGrouded() then
		return
	end

	arg_29_0:UnSelectedFishPoint()

	arg_29_0.selectedFishPointId = arg_29_1.id

	arg_29_0:GetSubView(IslandOpView):UpdateOperationButton(IslandOpView.OperationType.Fishing, arg_29_1.id)

	return
end

function var_0_0.UnSelectedFishPoint(arg_30_0)
	if arg_30_0.selectedFishPointId then
		arg_30_0.selectedFishPointId = nil

		arg_30_0:GetSubView(IslandOpView):UpdateOperationButton(IslandOpView.OperationType.None, arg_30_0.selectedFishPointId)
	end

	return
end

function var_0_0.OnStartFishing(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0:GetPlayerUnitModule(arg_31_1.unitId)

	if not var_31_0 then
		return
	end

	if not isa(var_31_0, IslandVisitorUnit) then
		return
	end

	var_31_0:Sleep()

	local var_31_1 = IslandVistorFishingPlayer.New(arg_31_0, var_31_0, arg_31_1.fishPointId, pg.island_fish_rod[arg_31_1.rodId].attachment_id, arg_31_1.fishId)

	var_31_1:Play()

	arg_31_0.fishingSynPlayers[arg_31_1.unitId] = var_31_1

	return
end

function var_0_0.OnFishingStateChange(arg_32_0, arg_32_1)
	if not isa(arg_32_0:GetPlayerUnitModule(arg_32_1.unitId), IslandVisitorUnit) then
		return
	end

	if not arg_32_0.fishingSynPlayers[arg_32_1.unitId] or not arg_32_0.fishingSynPlayers[arg_32_1.unitId]:IsSameFishPoint(arg_32_1.fishPointId) then
		return
	end

	local function var_32_0()
		var_0:WakeUp()
		arg_32_0.fishingSynPlayers[var_0]:Dispose()

		arg_32_0.fishingSynPlayers[var_0] = nil

		return
	end

	if arg_32_1.op == IslandConst.FISHING_OP_CANCEL then
		arg_32_0.fishingSynPlayers[arg_32_1.unitId]:OnCancel(var_32_0)
	elseif arg_32_1.op == IslandConst.FISHING_OP_FAILD then
		arg_32_0.fishingSynPlayers[arg_32_1.unitId]:OnFailed(var_32_0)
	elseif arg_32_1.op == IslandConst.FISHING_OP_SUCCESS then
		arg_32_0.fishingSynPlayers[arg_32_1.unitId]:OnSuccess(var_32_0)
	end

	return
end

function var_0_0.OnStartCoupleAction(arg_34_0)
	arg_34_0:UnBlockLayer1Event(false)
	arg_34_0:GetSubView(IslandAniamtionOpView):OnStartCoupleAction()

	return
end

function var_0_0.OnEndCoupleAction(arg_35_0)
	arg_35_0:UnBlockLayer1Event(true)
	arg_35_0:GetSubView(IslandAniamtionOpView):OnEndCoupleAction()

	return
end

function var_0_0.OnCancelCoupleAction(arg_36_0)
	if arg_36_0.coupleActionPlayer and arg_36_0.coupleActionPlayer:IsPlaying() then
		arg_36_0.coupleActionPlayer:Stop()
	end

	if arg_36_0.coupleAction4FollowerPlayer and arg_36_0.coupleAction4FollowerPlayer:IsPlaying() then
		arg_36_0.coupleAction4FollowerPlayer:Stop()
	end

	arg_36_0:OnEndCoupleAction()

	return
end

function var_0_0.OnCoupleActionWithFollower(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0:GetPlayerPosition()
	local var_37_1 = pg.island_set.action_bubble_range.key_value_int
	local var_37_2 = _.select(arg_37_0:GetUnitListByKey(IslandConst.UNIT_LIST_FOLLOW), function(arg_38_0)
		return not arg_38_0:IsExitState() and Vector3.Distance(arg_38_0:GetPosition(), var_37_0) <= var_37_1
	end)

	if #var_37_2 <= 0 then
		return
	end

	arg_37_0.coupleAction4FollowerPlayer:Play(var_37_2[math.random(1, #var_37_2)], arg_37_0.player, pg.island_action[arg_37_1])
	arg_37_0:GetSubView(IslandAniamtionOpView):RemoveWaitTimer(false)

	return
end

function var_0_0.OnFollowerAdd(arg_39_0, arg_39_1)
	if arg_39_0:GetSelectedNpcId() then
		local var_39_0, var_39_1 = IslandCalcUtil.GetTypeAndIdByUniqueId(arg_39_0:GetSelectedNpcId())

		if var_39_1 == arg_39_1 then
			arg_39_0.selectedNpcId = nil
		end
	end

	arg_39_0:GetSubView(IslandOpView):FlushFollowerList()
	arg_39_0.coupleNpcWordPlayer:Play(arg_39_1)

	return
end

function var_0_0.OnFollowerWillDelStep1(arg_40_0, arg_40_1)
	local var_40_0

	for iter_40_0, iter_40_1 in ipairs((arg_40_0:GetUnitListByKey(IslandConst.UNIT_LIST_FOLLOW))) do
		local var_40_1 = iter_40_1:GetDataVO()

		if var_40_1:IsSameShip(arg_40_1) then
			var_40_0 = iter_40_1

			break
		end
	end

	if not var_40_0 or var_40_0:IsExitState() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_follower_exiting_tip"))

		return
	end

	var_40_0:DoExitHandle()

	return
end

function var_0_0.OnFollowerWillDelStep2(arg_41_0, arg_41_1)
	if not arg_41_1.node then
		return
	end

	local var_41_0, var_41_1 = IslandCalcUtil.GetTypeAndIdByUniqueId(arg_41_1.node:GetComponent(typeof(WorldObjectItem)).uniqueId)
	local var_41_2 = arg_41_0:GetUnitModuleWithType(var_41_0, var_41_1)

	if not var_41_2 then
		return
	end

	arg_41_0:NotifiyMeditor(IslandMediator.DEL_FOLLOWER, var_41_2:GetDataVO():GetShipId())

	return
end

function var_0_0.OnFollowerDel(arg_42_0, arg_42_1)
	arg_42_0:GetSubView(IslandOpView):FlushFollowerList()
	arg_42_0.coupleNpcWordPlayer:Stop(arg_42_1)

	return
end

function var_0_0.OnResetFollowRandomizer(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_0:GetFollowerModule(arg_43_1)

	if not var_43_0 then
		return
	end

	var_43_0:SetBtRandomizer()

	return
end

function var_0_0.OnShowChatMsg(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_0:GetPlayerUnitModule(arg_44_1.player.id)

	if not var_44_0 then
		return
	end

	arg_44_0:GetSubView(IslandTopHeadHudView):PlayChat(var_44_0, arg_44_1.emojiId, arg_44_1.content, nil)

	return
end

function var_0_0.OnChatRoomChange(arg_45_0)
	arg_45_0:GetSubView(IslandAniamtionOpView):UpdateChatRoom()

	return
end

function var_0_0.OnChatMsgUpdate(arg_46_0)
	arg_46_0:GetSubView(IslandAniamtionOpView):UpdateMsgList()

	return
end

function var_0_0.OnPlaySingleAnimationEnd(arg_47_0, arg_47_1)
	if not arg_47_0:GetSelectedNpcId() then
		arg_47_0.npcActionPlayer:ResoponByRandom(arg_47_0.player, arg_47_1)
		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildActionOp(1, arg_47_1, 0, 0, 0, 0))

		return
	end

	local var_47_0, var_47_1 = IslandCalcUtil.GetTypeAndIdByUniqueId((arg_47_0:GetSelectedNpcId()))
	local var_47_2 = arg_47_0:GetUnitModuleWithType(var_47_0, var_47_1)

	if isa(var_47_2, IslandStrollNpcUnit) then
		if var_47_2:GetDataVO():ExistGreetingActionFeedback() then
			arg_47_0.npcActionPlayer:Resopon(var_47_2, arg_47_0.player, arg_47_1)

			goto label_47_0
		end
	end

	arg_47_0.npcActionPlayer:ResoponByRandom(arg_47_0.player, arg_47_1)

	::label_47_0::

	return
end

function var_0_0.OnShowNpcAniamtionBubble(arg_48_0, arg_48_1)
	local var_48_0 = arg_48_0:GetStrollUnitModule(arg_48_1.id)

	if not var_48_0 then
		return
	end

	arg_48_0:GetSubView(IslandBottomHeadHudView):ShowAnimationOp(var_48_0, (arg_48_1:GetGreetingFeedback()))

	return
end

function var_0_0.OnHideNpcAniamtionBubble(arg_49_0, arg_49_1)
	arg_49_0:GetSubView(IslandBottomHeadHudView):HideAnimationOp((arg_49_0:GetStrollUnitModule(arg_49_1.id)))

	return
end

function var_0_0.OnStartDoCoupleAction(arg_50_0)
	arg_50_0:GetSubView(IslandCancelAnimationOpView):ShowCancelableAnimationOp(arg_50_0.player)

	return
end

function var_0_0.OnEndDoCoupleAction(arg_51_0)
	arg_51_0:GetSubView(IslandCancelAnimationOpView):HideCancelableAnimationOp(arg_51_0.player)

	return
end

function var_0_0.OnResponAniamtionOp(arg_52_0, arg_52_1)
	local var_52_0 = arg_52_0:GetPlayerUnitModule(arg_52_1.id)

	if not var_52_0 then
		return
	end

	if arg_52_1.actionId == 0 then
		if not arg_52_0:IsPlayer(arg_52_1.id) then
			arg_52_0:GetSubView(IslandTopHeadHudView):HideAnimationOp(var_52_0)
		else
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildActionOp(2, arg_52_1.actionId, 1, 0, 0, 0))
		end

		return
	end

	local var_52_1 = pg.island_action[arg_52_1.actionId]

	if arg_52_1.targetId == 0 and var_52_1.type == IslandConst.ANIMATION_OP_DOUBLE and not arg_52_0:IsPlayer(arg_52_1.id) then
		arg_52_0:GetSubView(IslandTopHeadHudView):ShowAnimationOp(var_52_0, arg_52_1.actionId)
	elseif arg_52_1.targetId > 0 and var_52_1.type == IslandConst.ANIMATION_OP_DOUBLE and not arg_52_0:IsPlayer(arg_52_1.targetId) then
		local var_52_2 = arg_52_0:GetPlayerUnitModule(arg_52_1.targetId)

		arg_52_0.coupleActionPlayer:Play(var_52_0, var_52_2, var_52_1)
		arg_52_0:GetSubView(IslandTopHeadHudView):HideAnimationOp(var_52_2)
	elseif arg_52_1.targetId > 0 and var_52_1.type == IslandConst.ANIMATION_OP_DOUBLE and arg_52_0:IsPlayer(arg_52_1.targetId) then
		arg_52_0.coupleActionPlayer:Play(var_52_0, arg_52_0:GetPlayerUnitModule(arg_52_1.targetId), var_52_1)
		arg_52_0:GetSubView(IslandAniamtionOpView):RemoveWaitTimer(false)
		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildActionOp(2, arg_52_1.actionId, 1, arg_52_1.targetId, 0, 1))
	end

	return
end

function var_0_0.OnShowChatMsg(arg_53_0, arg_53_1)
	local var_53_0 = arg_53_0:GetPlayerUnitModule(arg_53_1.player.id)

	if not var_53_0 then
		return
	end

	arg_53_0:GetSubView(IslandTopHeadHudView):PlayChat(var_53_0, arg_53_1.emojiId, arg_53_1.content, nil)

	return
end

function var_0_0.OnChatRoomChange(arg_54_0)
	arg_54_0:GetSubView(IslandAniamtionOpView):UpdateChatRoom()

	return
end

function var_0_0.OnChatMsgUpdate(arg_55_0)
	arg_55_0:GetSubView(IslandAniamtionOpView):UpdateMsgList()

	return
end

function var_0_0.OnFollowerAdd(arg_56_0, arg_56_1)
	arg_56_0:GetSubView(IslandOpView):FlushFollowerList()
	arg_56_0.coupleNpcWordPlayer:Play(arg_56_1)

	return
end

function var_0_0.OnFollowerDel(arg_57_0, arg_57_1)
	arg_57_0:GetSubView(IslandOpView):FlushFollowerList()
	arg_57_0.coupleNpcWordPlayer:Stop(arg_57_1)

	return
end

function var_0_0.OnResetFollowRandomizer(arg_58_0, arg_58_1)
	local var_58_0 = arg_58_0:GetFollowerModule(arg_58_1)

	if not var_58_0 then
		return
	end

	var_58_0:SetBtRandomizer()

	return
end

function var_0_0.OnGenPathFinder(arg_59_0, arg_59_1)
	local var_59_0 = IslandPathFinder.New(arg_59_0)
	local var_59_1 = defaultValue(arg_59_1.navData.waitUntilDone, false)

	var_59_0:Start(arg_59_1.navData, function()
		table.removebyvalue(arg_59_0.pathfinders, var_59_0)
		var_59_0:Dispose()

		if arg_59_1.onEndAction then
			arg_59_1.onEndAction()
		end

		arg_59_0:NotifiyIsland(ISLAND_EX_EVT.NAV_PATH_DONE, arg_59_1.navData.index)

		if var_59_1 and arg_59_1.callback then
			arg_59_1.callback()
		end

		return
	end)
	arg_59_0:NotifiyIsland(ISLAND_EX_EVT.NAV_PATH, arg_59_1.navData.index)

	if not defaultValue(arg_59_1.navData.waitUntilDone, false) and arg_59_1.callback then
		arg_59_1.callback()
	end

	table.insert(arg_59_0.pathfinders, var_59_0)

	return
end

function var_0_0.OnRemovePathFinder(arg_61_0, arg_61_1)
	local var_61_0 = arg_61_0:GetUnitModuleWithType(arg_61_1.unitType, arg_61_1.unitId)
	local var_61_1 = _.detect(arg_61_0.pathfinders, function(arg_62_0)
		return arg_62_0:IsSameUnit(var_61_0)
	end)

	if not var_61_1 then
		return
	end

	var_61_1:Stop()
	var_61_1:Dispose()
	table.removebyvalue(arg_61_0.pathfinders, var_61_1)

	return
end

function var_0_0.OnTracking(arg_63_0, arg_63_1)
	if arg_63_1.trackType == IslandTaskTrackCard.TYPES.MAIN then
		arg_63_0.mainTrackId = tonumber(arg_63_1.id)
		arg_63_0.needTryMainTrack = true
	elseif arg_63_1.trackType == IslandTaskTrackCard.TYPES.OTHER then
		arg_63_0.trackId = tonumber(arg_63_1.id)
		arg_63_0.trackType = arg_63_1.typ or IslandTaskType.MAIN
		arg_63_0.needTryTrack = true
	end

	return
end

function var_0_0.TryTrack(arg_64_0)
	arg_64_0:TrySetTrack(arg_64_0.trackId)

	return
end

function var_0_0.TrySetTrack(arg_65_0, arg_65_1)
	local var_65_0 = arg_65_0:GetOptTrackingTarget(arg_65_1)

	if not var_65_0 or not var_65_0._go then
		return
	end

	arg_65_0:GetSubView(IslandDistanceView):SetTrackingTarget(arg_65_0.player, var_65_0, arg_65_1, arg_65_0.trackType, IslandTaskTrackCard.TYPES.OTHER)

	arg_65_0.needTryTrack = false

	return
end

function var_0_0.TryMainTrack(arg_66_0)
	arg_66_0:TrySetMainTrack(arg_66_0.mainTrackId)

	return
end

function var_0_0.TrySetMainTrack(arg_67_0, arg_67_1)
	local var_67_0 = arg_67_0:GetOptTrackingTarget(arg_67_1)

	if not var_67_0 or not var_67_0._go then
		return
	end

	arg_67_0:GetSubView(IslandDistanceView):SetTrackingTarget(arg_67_0.player, var_67_0, arg_67_1, IslandTaskType.MAIN, IslandTaskTrackCard.TYPES.MAIN)

	arg_67_0.needTryMainTrack = false

	return
end

function var_0_0.OnUnTracking(arg_68_0, arg_68_1)
	if arg_68_1 == IslandTaskTrackCard.TYPES.MAIN then
		arg_68_0.mainTrackId = nil
	elseif arg_68_1 == IslandTaskTrackCard.TYPES.OTHER then
		arg_68_0.trackId = nil
	end

	arg_68_0:GetSubView(IslandDistanceView):CancelTracking(arg_68_1)

	return
end

local function var_0_1(arg_69_0, arg_69_1)
	local var_69_0 = pg.island_world_objects[arg_69_0]

	if not pg.island_world_objects[arg_69_0] then
		return
	end

	return var_69_0.mapId == arg_69_1
end

local function var_0_2(arg_70_0, arg_70_1, arg_70_2)
	for iter_70_0, iter_70_1 in ipairs(arg_70_0) do
		for iter_70_2, iter_70_3 in ipairs(iter_70_1[2]) do
			if pg.island_interaction[iter_70_3].type == arg_70_2 and var_0_1(tonumber(pg.island_interaction[iter_70_3].param), arg_70_1) then
				return iter_70_1[1]
			end
		end
	end

	return nil
end

local function var_0_3(arg_71_0)
	for iter_71_0, iter_71_1 in ipairs(arg_71_0) do
		for iter_71_2, iter_71_3 in ipairs(iter_71_1[2]) do
			if pg.island_interaction[iter_71_3].type == IslandInteractionUntil.TYPE_TRANSFER then
				table.insert({}, iter_71_1[1])
			elseif pg.island_interaction[iter_71_3].type == IslandInteractionUntil.TYPE_SP_TRANSFER then
				table.insert({}, iter_71_1[1])
			end
		end
	end

	if #{} > 0 then
		return ({})[1]
	end

	if #{} > 0 then
		return ({})[1]
	end

	return nil
end

function var_0_0.GetOptTrackingTarget(arg_72_0, arg_72_1)
	local var_72_0 = arg_72_0:GetUnitModule(arg_72_1)

	if var_72_0 then
		return var_72_0
	end

	local var_72_1 = pg.island_world_objects[arg_72_1]

	if not pg.island_world_objects[arg_72_1] then
		return nil
	end

	local var_72_2 = {}

	for iter_72_0, iter_72_1 in ipairs(arg_72_0:GetUnitListByKey(IslandConst.UNIT_LIST_OBJ)) do
		local var_72_3, var_72_4 = iter_72_1:IsMapTransfer()

		if var_72_3 then
			table.insert(var_72_2, {
				iter_72_1,
				var_72_4
			})
		end
	end

	local var_72_5 = var_0_2(var_72_2, var_72_1.mapId, IslandInteractionUntil.TYPE_TRANSFER) or var_0_2(var_72_2, var_72_1.mapId, IslandInteractionUntil.TYPE_SP_TRANSFER) or var_0_3(var_72_2)

	return nil
end

function var_0_0.OnOpenAniamtionOpPage(arg_73_0)
	arg_73_0:GetSubView(IslandAniamtionOpView):TryEnable()
	arg_73_0:GetSubView(IslandOpView):TryDisable()
	arg_73_0:NotifiyIsland(ISLAND_EX_EVT.OPEN_ANIMATION_OP)

	return
end

function var_0_0.OnCloseAniamtionOpPage(arg_74_0)
	arg_74_0:GetSubView(IslandOpView):TryEnable()
	arg_74_0:NotifiyIsland(ISLAND_EX_EVT.CLOSE_ANIMATION_OP)

	return
end

function var_0_0.OnAnyPageOpen(arg_75_0, arg_75_1)
	arg_75_0.anyPageOpen = true

	arg_75_0.player:StopMoveHandle()
	arg_75_0:GetSubView(IslandTopHeadHudView):TryDisable()
	arg_75_0:GetSubView(IslandSlotHudView):TryDisable()
	arg_75_0:GetSubView(IslandBottomHeadHudView):TryDisable()
	arg_75_0:GetSubView(IslandOpView):TryDisablePlayerOp()
	arg_75_0:GetSubView(IslandAniamtionOpView):CloseAndReset()

	return
end

function var_0_0.OnAllPageClose(arg_76_0)
	arg_76_0.anyPageOpen = false

	arg_76_0:GetSubView(IslandTopHeadHudView):TryEnable()
	arg_76_0:GetSubView(IslandSlotHudView):TryEnable()
	arg_76_0:GetSubView(IslandBottomHeadHudView):TryEnable()
	arg_76_0:GetSubView(IslandOpView):TryEnablePlayerOp()

	return
end

function var_0_0.OnStartStory(arg_77_0)
	arg_77_0.playingStory = true

	arg_77_0:DisablePlayerOp()

	return
end

function var_0_0.OnEndStory(arg_78_0)
	arg_78_0.playingStory = false

	arg_78_0:EnablePlayerOp()

	return
end

function var_0_0.OnStartPerformance(arg_79_0)
	return
end

function var_0_0.OnEndPerformance(arg_80_0)
	if not arg_80_0.anyPageOpen then
		arg_80_0:GetSubView(IslandOpView):ResetShowBalance()
	end

	return
end

function var_0_0.OnStartGuide(arg_81_0)
	arg_81_0.player:StopMoveHandle()
	arg_81_0:GetSubView(IslandOpView):DisableInput()

	return
end

function var_0_0.OnEndGuide(arg_82_0)
	if arg_82_0.playingStory then
		return
	end

	arg_82_0:GetSubView(IslandOpView):EnableInput()

	return
end

function var_0_0.InitFocusCamera(arg_83_0)
	local var_83_0 = IslandCameraMgr.instance:GetVirtualCamera(IslandConst.FOCUS_CAMERA_NAME)

	var_83_0.Follow = arg_83_0.player._tf
	var_83_0.LookAt = arg_83_0.player._tf

	return
end

function var_0_0.InitTakePhotoCamera(arg_84_0)
	IslandCameraMgr.instance:GetVirtualCamera(IslandConst.FIRST_PERSON_TAKE_PHOTO_CAMERA_NAME).Follow = arg_84_0.firstTakePhotoItem._tf

	local var_84_0 = IslandCameraMgr.instance:GetVirtualCamera(IslandConst.Third_PERSON_TAKE_PHOTO_CAMERA_NAME)

	var_84_0.Follow = arg_84_0.thirdTakePhotoItem._tf
	var_84_0.LookAt = arg_84_0.thirdTakePhotoItem._tf

	return
end

function var_0_0.DisablePlayerOp(arg_85_0)
	arg_85_0.player:StopMoveHandle()
	arg_85_0:GetSubView(IslandTopHeadHudView):TryDisable()
	arg_85_0:GetSubView(IslandBottomHeadHudView):TryDisable()
	arg_85_0:GetSubView(IslandOpView):TryDisablePlayerOp()
	arg_85_0:GetSubView(IslandOpView):TryDisable()

	return
end

function var_0_0.EnablePlayerOp(arg_86_0)
	arg_86_0:GetSubView(IslandOpView):TryEnablePlayerOp()
	arg_86_0:GetSubView(IslandTopHeadHudView):TryEnable()
	arg_86_0:GetSubView(IslandBottomHeadHudView):TryEnable()
	arg_86_0:GetSubView(IslandOpView):TryEnable()

	return
end

function var_0_0.OnInterActionBegin(arg_87_0)
	arg_87_0.player:StopMoveHandle()
	arg_87_0:GetSubView(IslandOpView):TryDisablePlayerOp()

	return
end

function var_0_0.OnInterActionEnd(arg_88_0)
	arg_88_0:GetSubView(IslandOpView):TryEnablePlayerOp()

	return
end

function var_0_0.OnShowInterActionPanel(arg_89_0, arg_89_1)
	arg_89_0.showInterObjId = arg_89_1.id

	arg_89_0:GetSubView(IslandInteractionView):ShowInterActionPanel(arg_89_1)
	arg_89_0:Op("NotifiyIsland", ISLAND_EX_EVT.SHOW_INTERACTION, arg_89_0.showInterObjId)

	return
end

function var_0_0.OnHideInterActionPanel(arg_90_0, arg_90_1)
	if arg_90_0.showInterObjId ~= arg_90_1.id then
		return
	end

	arg_90_0.showInterObjId = nil

	arg_90_0:GetSubView(IslandInteractionView):HideInterActionPanel()

	return
end

function var_0_0.OnRefreshInteractionBtn(arg_91_0)
	arg_91_0:GetSubView(IslandInteractionView):RefreshInteractionBtns()

	return
end

function var_0_0.OnSetOpMoveBtnActve(arg_92_0, arg_92_1, arg_92_2)
	arg_92_0:GetSubView(IslandOpView):ShowOrHideMoveBtn(arg_92_1, arg_92_2)

	return
end

function var_0_0.DisableInput(arg_93_0)
	arg_93_0.player:StopMoveHandle()
	arg_93_0:GetSubView(IslandOpView):DisableInput()

	return
end

function var_0_0.EnableInput(arg_94_0)
	arg_94_0:GetSubView(IslandOpView):EnableInput()

	return
end

function var_0_0.OnUpdateCustomOpPositon(arg_95_0)
	arg_95_0:GetSubView(IslandOpView):InitOpCustumPositon()

	return
end

function var_0_0.OnChange_Photo_Height(arg_96_0, arg_96_1, arg_96_2)
	arg_96_0.takePhotoModel = arg_96_1

	if arg_96_0.takePhotoModel == IslandConst.TakePhotoModel.First then
		-- block empty
	elseif arg_96_0.takePhotoModel == IslandConst.TakePhotoModel.Third then
		arg_96_0.thirdTakePhotoItem:ChangeHeight(arg_96_2)
	end

	return
end

function var_0_0.OnChangeTakePhotoModel(arg_97_0, arg_97_1, arg_97_2)
	arg_97_0.takePhotoModel = arg_97_1

	if arg_97_0.takePhotoModel == IslandConst.TakePhotoModel.First then
		arg_97_0.firstTakePhotoItem:Enable()

		arg_97_0.firstTakePhotoItem._tf.position = arg_97_0.player._tf.position
		arg_97_0.firstTakePhotoItem._tf.rotation = arg_97_0.player._tf.rotation

		arg_97_0.firstTakePhotoItem:SetTargetRotation(arg_97_0.player._tf.rotation)
		arg_97_0.player:SetActiveByLayer(false)
		IslandCameraMgr.instance:ActiveVirtualCamera(IslandConst.FIRST_PERSON_TAKE_PHOTO_CAMERA_NAME)
		IslandCameraMgr.instance:GetVirtualCamera(IslandConst.FIRST_PERSON_TAKE_PHOTO_CAMERA_NAME).gameObject:GetComponent(typeof(CameraPovLook)):SetPosAndRotationByTargetDir(arg_97_0.player._tf.forward)
	elseif arg_97_0.takePhotoModel == IslandConst.TakePhotoModel.Third then
		arg_97_0.thirdTakePhotoItem:Enable()

		arg_97_0.player._tf.position = arg_97_0.firstTakePhotoItem._tf.position
		arg_97_0.player._tf.rotation = arg_97_0.firstTakePhotoItem._tf.rotation

		arg_97_0.player:SetTargetRotation(arg_97_0.firstTakePhotoItem._tf.rotation)
		arg_97_0.player:SetActiveByLayer(true)

		arg_97_0.thirdTakePhotoItem._tf.position = arg_97_0.firstTakePhotoItem._tf:TransformPoint(Vector3(0, 0, -5))
		arg_97_0.thirdTakePhotoItem._tf.rotation = arg_97_0.firstTakePhotoItem._tf.rotation

		arg_97_0.thirdTakePhotoItem:SetTargetRotation(arg_97_0.firstTakePhotoItem._tf.rotation)
		IslandCameraMgr.instance:GetVirtualCamera(IslandConst.Third_PERSON_TAKE_PHOTO_CAMERA_NAME).gameObject:GetComponent(typeof(CameraPovLook)):SetPosAndRotationByTargetDir((arg_97_0.player._tf.position + Vector3(0, 0.5, 0) - (arg_97_0.thirdTakePhotoItem._tf.position + Vector3(0, 1, 0))).normalized)
		IslandCameraMgr.instance:ActiveVirtualCamera(IslandConst.Third_PERSON_TAKE_PHOTO_CAMERA_NAME)
	else
		arg_97_0.firstTakePhotoItem:Disable()
		arg_97_0.thirdTakePhotoItem:Disable()

		arg_97_0.player._tf.position = arg_97_0.firstTakePhotoItem._tf.position
		arg_97_0.player._tf.rotation = arg_97_0.firstTakePhotoItem._tf.rotation

		arg_97_0.player:SetTargetRotation(arg_97_0.firstTakePhotoItem._tf.rotation)
		arg_97_0.player:SetActiveByLayer(true)
		IslandCameraMgr.instance:ActiveVirtualCamera(IslandConst.FOLLOW_CAMERA_NAME)
		IslandCameraMgr.instance:GetVirtualCamera(IslandConst.FOLLOW_CAMERA_NAME).gameObject:GetComponent(typeof(CameraLook)):ResetCameraPos()
	end

	arg_97_0:GetSubView(IslandOpView):ChangeTakePhotoModel(arg_97_1, arg_97_2)

	return
end

function var_0_0.OnNpcDetectorSelected(arg_98_0, arg_98_1)
	if arg_98_0.selectedNpcId then
		return
	end

	if not arg_98_1.node then
		return
	end

	local var_98_1 = var_98_0:GetComponent(typeof(WorldObjectItem)).uniqueId

	arg_98_0.selectedNpcId = var_98_1

	arg_98_0:GetSubView(IslandOpView):UpdateAnimationOpEffect(var_98_1, true)
	arg_98_0:GetSubView(IslandBottomHeadHudView):UpdateAnimationOpEffect(var_98_1, true)
	arg_98_0:GetSubView(IslandAniamtionOpView):SortForNpcAction(var_98_1)

	return
end

function var_0_0.GetSelectedNpcId(arg_99_0)
	return arg_99_0.selectedNpcId
end

function var_0_0.OnNpcDetectorUnSelected(arg_100_0, arg_100_1)
	if not arg_100_1.node then
		return
	end

	local var_100_0 = arg_100_1.node:GetComponent(typeof(WorldObjectItem)).uniqueId

	arg_100_0:GetSubView(IslandOpView):UpdateAnimationOpEffect(var_100_0)
	arg_100_0:GetSubView(IslandBottomHeadHudView):UpdateAnimationOpEffect(var_100_0)
	arg_100_0:GetSubView(IslandAniamtionOpView):SortForNpcAction(nil)

	if arg_100_0.selectedNpcId ~= var_100_0 then
		return
	end

	arg_100_0.selectedNpcId = nil

	return
end

function var_0_0.OnDetectorChanged(arg_101_0, arg_101_1)
	if not arg_101_1.node then
		return
	end

	local var_101_0 = arg_101_1.node:GetBlackboardVariable("DetectorList")

	for iter_101_0 = 1, var_101_0.Count do
		local var_101_1, var_101_2 = IslandCalcUtil.GetTypeAndIdByUniqueId(var_101_0[iter_101_0 - 1])

		if var_101_1 == IslandConst.UNIT_LIST_OBJ then
			local var_101_3 = arg_101_0:GetUnitModuleWithType(var_101_1, var_101_2)

			if var_101_3 then
				arg_101_0:Op("NotifiyIsland", ISLAND_EX_EVT.APPROACH_OBJECT, var_101_3.id)
			end
		end
	end

	return
end

function var_0_0.OnDetectorSelected(arg_102_0, arg_102_1)
	if not arg_102_1.node then
		return
	end

	local var_102_0 = arg_102_1.node:GetBlackboardVariable("AnyOne")

	if not var_102_0 or var_102_0 == "" then
		arg_102_0:OnClearSelectedUnit()
	else
		local var_102_1, var_102_2 = IslandCalcUtil.GetTypeAndIdByUniqueId(var_102_0)
		local var_102_3 = arg_102_0:GetUnitModuleWithType(var_102_1, var_102_2)

		if var_102_3 then
			arg_102_0:OnSelectedUnit(var_102_3)
		end
	end

	return
end

function var_0_0.OnClearSelectedUnit(arg_103_0)
	return
end

function var_0_0.OnSelectedUnit(arg_104_0, arg_104_1)
	return
end

function var_0_0.OnPlayChatBubble(arg_105_0, arg_105_1)
	arg_105_0:GetSubView(IslandTopHeadHudView):PlayBubble(arg_105_1.name, arg_105_0:GetAllUnits(), arg_105_1.callback)

	return
end

function var_0_0.OnRawPlayChatBubble(arg_106_0, arg_106_1)
	arg_106_0:GetSubView(IslandTopHeadHudView):RawPlayBubble(arg_106_1.info, arg_106_0:GetAllUnits(), arg_106_1.callback)

	return
end

function var_0_0.OnRawStopChatBubble(arg_107_0, arg_107_1)
	arg_107_0:GetSubView(IslandTopHeadHudView):RawStopBubble(arg_107_1.info)

	return
end

function var_0_0.OnChangeVisterDress(arg_108_0, arg_108_1)
	if arg_108_0:IsPlayer(arg_108_1.id) then
		return
	end

	local var_108_0 = arg_108_0:GetPlayerUnitModule(arg_108_1.id)

	if var_108_0 then
		var_108_0:OnChangeDress(arg_108_1.changeDressData)
	end

	return
end

function var_0_0.OnSystemUnlock(arg_109_0, arg_109_1)
	if arg_109_1 == IslandAblityAgency.ANIMATION_OP_ID then
		arg_109_0:GetSubView(IslandOpView):UpdateAnimationOpBtn()
	end

	return
end

function var_0_0.OnSceneInited(arg_110_0, arg_110_1)
	IslandCameraMgr.instance:LookAt(arg_110_0.player._tf)
	IslandCameraMgr.instance:GetVirtualCamera(IslandConst.FOLLOW_CAMERA_NAME).gameObject:GetComponent(typeof(CameraZoom)):SetMaxMinZoom(arg_110_1.min, arg_110_1.max, arg_110_1.value)
	arg_110_0:InitFocusCamera()
	arg_110_0:InitTakePhotoCamera()
	arg_110_0:GetSubView(IslandOpView):LaterInit()

	return
end

function var_0_0.OnGenUnit(arg_111_0, arg_111_1, arg_111_2)
	local var_111_0 = arg_111_0.unitBuilders[arg_111_1:GetType()]:Build(arg_111_1, arg_111_2)

	arg_111_0:AddUnit(var_111_0)

	if arg_111_1:IsPlayer() then
		arg_111_0.player = var_111_0
	end

	if arg_111_1:IsFirstTakePhoto() then
		arg_111_0.firstTakePhotoItem = var_111_0
	end

	if arg_111_1:IsThirdTakePhoto() then
		arg_111_0.thirdTakePhotoItem = var_111_0
	end

	return
end

function var_0_0.OnGenSystem(arg_112_0, arg_112_1)
	arg_112_0:AddUnit((arg_112_0.systemBuilders[arg_112_1:GetType()]:Build(arg_112_1)))

	return
end

function var_0_0.IsPlayer(arg_113_0, arg_113_1)
	return arg_113_0.player.id == arg_113_1
end

function var_0_0.OnActiveOrDisactiveUnit(arg_114_0, arg_114_1, arg_114_2, arg_114_3)
	local var_114_0 = arg_114_1 == 0 and arg_114_0.player or arg_114_0:GetUnitModuleWithType(arg_114_2, arg_114_1)

	if var_114_0 and arg_114_3 then
		var_114_0:Enable()
	end

	if var_114_0 and not arg_114_3 then
		var_114_0:Disable()
	end

	return
end

function var_0_0.OnResetUnitPos(arg_115_0, arg_115_1, arg_115_2, arg_115_3)
	local var_115_0 = arg_115_0:GetUnitModuleWithType(arg_115_2, arg_115_1)

	if var_115_0 then
		var_115_0._go.transform.position = arg_115_3
	end

	return
end

function var_0_0.OnResetUnitRotation(arg_116_0, arg_116_1, arg_116_2, arg_116_3)
	local var_116_0 = arg_116_0:GetUnitModuleWithType(arg_116_2, arg_116_1)

	if var_116_0 then
		var_116_0._go.transform.eulerAngles = arg_116_3
	end

	return
end

function var_0_0.OnMoveUnit(arg_117_0, arg_117_1)
	assert(arg_117_1.type, "type should be exist")

	local var_117_0 = arg_117_0:GetUnitModuleWithType(arg_117_1.type, arg_117_1.id)

	if var_117_0 then
		var_117_0:SetDestination(arg_117_1.position, arg_117_1.speed, nil, arg_117_1.charaRadius)
	end

	return
end

function var_0_0.OnStopUnit(arg_118_0, arg_118_1)
	assert(arg_118_1.type, "type should be exist")

	local var_118_0 = arg_118_0:GetUnitModuleWithType(arg_118_1.type, arg_118_1.id)

	if var_118_0 then
		var_118_0:StopMove()
	end

	return
end

function var_0_0.OnRemoveUnit(arg_119_0, arg_119_1, arg_119_2)
	local var_119_0 = arg_119_0:GetUnitListByKey(arg_119_1)
	local var_119_1 = 0

	for iter_119_0, iter_119_1 in ipairs(var_119_0 or {}) do
		if iter_119_1.id == arg_119_2 then
			var_119_1 = iter_119_0

			break
		end
	end

	if var_119_1 > 0 then
		for iter_119_2 = #arg_119_0.pathfinders, 1, -1 do
			if arg_119_0.pathfinders[iter_119_2]:IsSameUnit(var_119_0[var_119_1]) then
				arg_119_0.pathfinders[iter_119_2]:Dispose()
				table.remove(arg_119_0.pathfinders, iter_119_2)
			end
		end

		arg_119_0:RemoveUnit(var_119_0[var_119_1])
		var_119_0[var_119_1]:Dispose()
		arg_119_0:OnHideUnitHudAndOpBtn({
			type = arg_119_1,
			id = var_119_0[var_119_1].id
		}, true)
		arg_119_0:GetSubView(IslandTopHeadHudView):HideHud({
			type = arg_119_1,
			id = arg_119_2
		})
		arg_119_0:GetSubView(IslandBottomHeadHudView):HideAnimationOp(var_119_0[var_119_1])
		arg_119_0:GetSubView(IslandInteractionView):CloseInterActionPanelByUnitIdRemove(arg_119_2)
	end

	return
end

function var_0_0.GetAllUnits(arg_120_0)
	table.clear(arg_120_0._unitList)

	for iter_120_0, iter_120_1 in pairs(arg_120_0:GetUnitListRegitser()) do
		for iter_120_2, iter_120_3 in pairs(iter_120_1) do
			table.insert(arg_120_0._unitList, iter_120_3)
		end
	end

	return arg_120_0._unitList
end

function var_0_0.GetUnitModuleWithType(arg_121_0, arg_121_1, arg_121_2)
	if arg_121_1 == IslandConst.UNIT_LIST_PLAYER and arg_121_2 == 0 then
		return arg_121_0.player
	end

	for iter_121_0, iter_121_1 in ipairs((arg_121_0:GetUnitListByKey(arg_121_1))) do
		if iter_121_1.id == arg_121_2 then
			return iter_121_1
		end
	end

	return nil
end

function var_0_0.GetPlayerUnitModule(arg_122_0, arg_122_1)
	return arg_122_0:GetUnitModuleWithType(IslandConst.UNIT_LIST_PLAYER, arg_122_1)
end

function var_0_0.GetUnitModule(arg_123_0, arg_123_1)
	return arg_123_0:GetUnitModuleWithType(IslandConst.UNIT_LIST_OBJ, arg_123_1)
end

function var_0_0.GetSystemModule(arg_124_0, arg_124_1)
	return arg_124_0:GetUnitModuleWithType(IslandConst.UNIT_LIST_SYSTEM, arg_124_1)
end

function var_0_0.GetProductSystemModule(arg_125_0, arg_125_1)
	return arg_125_0:GetUnitModuleWithType(IslandConst.UNIT_LIST_PRODUCT_SYSTEM, arg_125_1)
end

function var_0_0.GetSystemUnitModule(arg_126_0, arg_126_1)
	return arg_126_0:GetUnitModuleWithType(IslandConst.UNIT_LIST_DELEGATION, arg_126_1)
end

function var_0_0.GetStrollUnitModule(arg_127_0, arg_127_1)
	return arg_127_0:GetUnitModuleWithType(IslandConst.UNIT_LIST_STROLL, arg_127_1)
end

function var_0_0.GetManageSystemModule(arg_128_0, arg_128_1)
	return arg_128_0:GetUnitModuleWithType(IslandConst.UNIT_LIST_MANAGE_SYSTEM, arg_128_1)
end

function var_0_0.GetFollowerModule(arg_129_0, arg_129_1)
	return arg_129_0:GetUnitModuleWithType(IslandConst.UNIT_LIST_FOLLOW, arg_129_1)
end

function var_0_0.OnMovePlayerBefore(arg_130_0)
	if arg_130_0.player:CheckMovement() and arg_130_0.isLockPlayInput then
		arg_130_0.isLockPlayInput = false
	end

	arg_130_0:GetSubView(IslandAniamtionOpView):OnMovePlayerBefore()

	return
end

function var_0_0.OnLockPlayerInput(arg_131_0)
	if arg_131_0.playerInputing then
		arg_131_0.isLockPlayInput = true

		arg_131_0.player:StopMoveHandle()
	end

	return
end

function var_0_0.OnPlayerMove(arg_132_0, arg_132_1)
	if arg_132_0.isLockPlayInput then
		return
	end

	arg_132_0.playerInputing = true

	if arg_132_0.takePhotoModel == IslandConst.TakePhotoModel.First then
		arg_132_0.firstTakePhotoItem:MoveHandle(arg_132_1.targetDir, arg_132_1.force)
	elseif arg_132_0.takePhotoModel == IslandConst.TakePhotoModel.Third then
		arg_132_0.thirdTakePhotoItem:MoveHandle(arg_132_1.targetDir, arg_132_1.force)
	else
		arg_132_0.player:MoveHandle(arg_132_1.targetDir, arg_132_1.force)
	end

	return
end

function var_0_0.OnPlayerStopMove(arg_133_0)
	if arg_133_0.isLockPlayInput then
		arg_133_0.isLockPlayInput = false
	end

	arg_133_0.playerInputing = true

	if arg_133_0.takePhotoModel == IslandConst.TakePhotoModel.First then
		arg_133_0.firstTakePhotoItem:StopMoveHandle()
	elseif arg_133_0.takePhotoModel == IslandConst.TakePhotoModel.Third then
		arg_133_0.thirdTakePhotoItem:StopMoveHandle()
	else
		arg_133_0.player:StopMoveHandle()
	end

	return
end

function var_0_0.OnPlayerStopMoveHandle(arg_134_0)
	if arg_134_0.isLockPlayInput then
		arg_134_0.isLockPlayInput = false
	end

	arg_134_0.playerInputing = true

	if arg_134_0.takePhotoModel == IslandConst.TakePhotoModel.First then
		arg_134_0.firstTakePhotoItem:StopMoveHandle()
	elseif arg_134_0.takePhotoModel == IslandConst.TakePhotoModel.Third then
		arg_134_0.thirdTakePhotoItem:StopMoveHandle()
	else
		arg_134_0.player:StopMoveHandleByInput()
	end

	return
end

function var_0_0.OnPlayerJump(arg_135_0)
	if arg_135_0.takePhotoModel == IslandConst.TakePhotoModel.First or arg_135_0.takePhotoModel == IslandConst.TakePhotoModel.Third then
		return
	end

	arg_135_0.player:JumpHandle()

	return
end

function var_0_0.OnPlayerPlayerRun(arg_136_0)
	arg_136_0.player:PlayerRunHandle()

	return
end

function var_0_0.OnPlayerPlayerSprint(arg_137_0)
	if arg_137_0.takePhotoModel == IslandConst.TakePhotoModel.First then
		arg_137_0.firstTakePhotoItem:OnPlayerPlayerSprint()
	elseif arg_137_0.takePhotoModel == IslandConst.TakePhotoModel.Third then
		-- block empty
	else
		arg_137_0.player:OnPlayerPlayerSprint()
	end

	return
end

function var_0_0.OnStopPlayerSprint(arg_138_0)
	if arg_138_0.takePhotoModel == IslandConst.TakePhotoModel.First then
		arg_138_0.firstTakePhotoItem:OnStopPlayerSprint()
	elseif arg_138_0.takePhotoModel == IslandConst.TakePhotoModel.Third then
		arg_138_0.thirdTakePhotoItem:OnStopPlayerSprint()
	else
		arg_138_0.player:OnStopPlayerSprint()
	end

	return
end

function var_0_0.OnPlayerWork(arg_139_0, arg_139_1, arg_139_2)
	arg_139_0.player:WorkHandle(arg_139_1, arg_139_2)

	return
end

function var_0_0.OnPlayerDeviceStateChange(arg_140_0, arg_140_1)
	arg_140_0.player:DeviceStateHandle(arg_140_1)

	return
end

function var_0_0.OnSetVisitorSyncData(arg_141_0, arg_141_1, arg_141_2)
	local var_141_0 = arg_141_0:GetPlayerUnitModule(arg_141_1)

	if var_141_0 then
		var_141_0:UpdateSyncData(arg_141_2)
	end

	return
end

function var_0_0.OnWorldObjectStartInteraction(arg_142_0, arg_142_1, arg_142_2, arg_142_3)
	local var_142_0 = arg_142_0:GetUnitModule((arg_142_2:GetHostId()))
	local var_142_1 = arg_142_0:GetPlayerUnitModule((arg_142_2:GetUserId()))
	local var_142_2 = arg_142_0.player == var_142_1

	if arg_142_0.player == var_142_1 then
		arg_142_0:GetSubView(IslandOpView):StartInteraction()
	end

	var_142_0:StartInteract(var_142_1, arg_142_2.id, arg_142_3, arg_142_1:GetTimeline()[arg_142_3], arg_142_1:GetBlackboardParam()[arg_142_3], arg_142_1:AnySlotUsing(), var_142_2)

	return
end

function var_0_0.OnWorldObjectEndInteraction(arg_143_0, arg_143_1, arg_143_2)
	local var_143_0 = arg_143_0:GetUnitModule((arg_143_2:GetHostId()))
	local var_143_1 = arg_143_0:GetPlayerUnitModule((arg_143_2:GetUserId()))
	local var_143_2 = arg_143_0.player == var_143_1

	if arg_143_0.player == var_143_1 then
		arg_143_0:GetSubView(IslandOpView):EndInteraction()
	end

	var_143_0:EndInteract(var_143_1, arg_143_2.id, not arg_143_1:AnySlotUsing(), var_143_2)

	return
end

function var_0_0.OnWorldObjectInitStatus(arg_144_0, arg_144_1, arg_144_2)
	arg_144_0:GetUnitModule(arg_144_1.id):InitStatus(arg_144_2, arg_144_1:GetTimeline()[arg_144_2], arg_144_1:GetBlackboardParam()[arg_144_2])

	return
end

function var_0_0.InitInteractionOpView(arg_145_0)
	arg_145_0:GetSubView(IslandOpView):EndInteraction()

	return
end

function var_0_0.OnPlayerAreaChange(arg_146_0)
	arg_146_0.detectionSystem:SetAreaDetection()

	return
end

function var_0_0.OnChangeDress(arg_147_0, arg_147_1, arg_147_2)
	arg_147_0.player:OnChangeDress(arg_147_1, arg_147_2)

	return
end

function var_0_0.OnCharacterChangeDress(arg_148_0, arg_148_1, arg_148_2, arg_148_3, arg_148_4)
	local var_148_0 = arg_148_0:GetUnitModuleWithType(IslandConst.UNIT_LIST_DELEGATION, arg_148_1)

	if var_148_0 then
		var_148_0:OnCharacterChangeDress(arg_148_2, arg_148_3, arg_148_4)
	end

	for iter_148_0, iter_148_1 in ipairs((arg_148_0:GetUnitListByKey(IslandConst.UNIT_LIST_FOLLOW))) do
		local var_148_1 = iter_148_1:GetDataVO()

		if var_148_1:IsSameShip(arg_148_1) then
			iter_148_1:OnCharacterChangeDress(arg_148_2, arg_148_3, arg_148_4)
		end
	end

	for iter_148_2, iter_148_3 in ipairs((arg_148_0:GetUnitListByKey(IslandConst.UNIT_LIST_STROLL))) do
		local var_148_2 = iter_148_3:GetDataVO()

		if var_148_2:IsSameShip(arg_148_1) then
			iter_148_3:OnCharacterChangeDress(arg_148_2, arg_148_3, arg_148_4)
		end
	end

	return
end

function var_0_0.OnMorphFormChange(arg_149_0, arg_149_1, arg_149_2, arg_149_3, arg_149_4, arg_149_5)
	local var_149_0 = arg_149_0:GetPlayerUnitModule(arg_149_0.player.id)

	if not var_149_0 then
		existCall(arg_149_5)

		return
	end

	if not var_149_0.shipDressHelper then
		existCall(arg_149_5)

		return
	end

	var_149_0:PlayAnimation(arg_149_4, 0.25, function()
		var_0:ChangeDressByType(IslandShipDressHelperNew.DressType.Body, {
			colorId = 0,
			id = arg_149_2
		})
		var_0:ChangeDressByType(IslandShipDressHelperNew.DressType.Hat, {
			colorId = 0,
			id = arg_149_3
		})
		existCall(arg_149_5)

		return
	end)

	return
end

function var_0_0.OnStartDelegation(arg_151_0, arg_151_1, arg_151_2)
	local var_151_0 = arg_151_0:GetSystemModule(arg_151_1.build_id)

	if var_151_0 then
		var_151_0:StartDelegation(arg_151_1)
	end

	local var_151_1 = arg_151_0:GetProductSystemModule(arg_151_1.build_id)

	if var_151_1 then
		var_151_1:StartDelegation(arg_151_2)
	end

	return
end

function var_0_0.OnEndDelegation(arg_152_0, arg_152_1, arg_152_2)
	local var_152_0 = arg_152_0:GetSystemModule(arg_152_1.build_id)

	if var_152_0 then
		var_152_0:EndDelegation(arg_152_1)
	end

	return
end

function var_0_0.GetPlayerPosition(arg_153_0)
	return arg_153_0.player:GetCurrentPosition()
end

function var_0_0.GetPlayerLastGroundedPosition(arg_154_0)
	return arg_154_0.player:LastGroundedPosition()
end

function var_0_0.GetUnitPosition(arg_155_0, arg_155_1)
	local var_155_0 = arg_155_0:GetUnitModule(arg_155_1)

	return var_155_0 and var_155_0._go.transform.position
end

function var_0_0.OnShowUnitHudAndOpBtn(arg_156_0, arg_156_1)
	arg_156_0.currentHudUnitData = arg_156_1

	arg_156_0:GetSubView(IslandSlotHudView):ShowHud(arg_156_1.id, arg_156_1.height)
	arg_156_0:GetSubView(IslandOpView):UpdateOperationButton(arg_156_1.operationType, arg_156_1.id)

	if arg_156_1.isHighLightControl then
		arg_156_0.detectionSystem:HighLightUnitHandle(arg_156_1.id, true)
	end

	return
end

function var_0_0.OnHideUnitHudAndOpBtn(arg_157_0, arg_157_1, arg_157_2)
	if not arg_157_0.currentHudUnitData then
		return
	end

	if arg_157_0.currentHudUnitData.id ~= arg_157_1.id or arg_157_0.currentHudUnitData.type ~= arg_157_1.type then
		return
	end

	if not arg_157_2 then
		arg_157_0.currentHudUnitData = nil
	end

	arg_157_0:GetSubView(IslandSlotHudView):HideUnitHud(arg_157_1.id)
	arg_157_0:GetSubView(IslandOpView):UpdateOperationButton(IslandOpView.OperationType.None, arg_157_1.id)

	if arg_157_1.isHighLightControl then
		arg_157_0.detectionSystem:HighLightUnitHandle(arg_157_1.id, false)
	end

	return
end

function var_0_0.OnUpdateHud(arg_158_0, arg_158_1)
	if not arg_158_0.currentHudUnitData then
		return
	end

	if arg_158_1 ~= arg_158_0.currentHudUnitData.id then
		return
	end

	arg_158_0:GetSubView(IslandSlotHudView):UpdateHud(arg_158_0.currentHudUnitData.id, arg_158_0.currentHudUnitData.height)
	arg_158_0:GetSubView(IslandOpView):UpdateOperationButton(arg_158_0.currentHudUnitData.operationType, arg_158_0.currentHudUnitData.id)

	return
end

function var_0_0.OnUpdateHandCollectUnit(arg_159_0, arg_159_1)
	local var_159_0 = arg_159_0:GetUnitModuleWithType(IslandConst.UNIT_LIST_OBJ, arg_159_1)

	if var_159_0 then
		var_159_0:UpdateHandCollet()
		var_159_0:ResetHp()
	end

	return
end

function var_0_0.OnShowHud(arg_160_0, arg_160_1)
	arg_160_0:GetSubView(IslandTopHeadHudView):ShowHud(arg_160_1)
	arg_160_0:GetSubView(IslandDistanceView):ShowHud(arg_160_1.id)

	return
end

function var_0_0.OnRefreshHud(arg_161_0, arg_161_1)
	arg_161_0:GetSubView(IslandTopHeadHudView):RefreshHud(arg_161_1)

	return
end

function var_0_0.OnHideHud(arg_162_0, arg_162_1)
	arg_162_0:GetSubView(IslandTopHeadHudView):HideHud(arg_162_1)
	arg_162_0:GetSubView(IslandDistanceView):HideHud(arg_162_1.id)

	return
end

function var_0_0.OnDelegateSlotStartPerform(arg_163_0, arg_163_1)
	local var_163_0 = arg_163_0:GetUnitModuleWithType(arg_163_1.type, arg_163_1.id)

	if var_163_0 then
		var_163_0:DelegateSlotStartPerform()
	end

	return
end

function var_0_0.OnPlayEffect(arg_164_0, arg_164_1, arg_164_2, arg_164_3)
	local var_164_0

	for iter_164_0, iter_164_1 in ipairs((arg_164_0:GetUnitListByKey(IslandConst.UNIT_LIST_STROLL))) do
		local var_164_1 = iter_164_1:GetDataVO()

		if var_164_1:IsSameShip(arg_164_1) then
			var_164_0 = iter_164_1

			break
		end
	end

	local var_164_2 = arg_164_0:GetSubView(IslandEffectView)

	if var_164_2 and var_164_0 then
		var_164_2:Play(var_164_0, arg_164_2, arg_164_3)
	end

	return
end

function var_0_0.OnRecycleAllSlotEffct(arg_165_0)
	arg_165_0.effectMgr:RecycleAllSlotEffct()

	return
end

function var_0_0.OnLoadDelegatePreviewRole(arg_166_0, arg_166_1, arg_166_2)
	arg_166_0.effectMgr:LoadDelegatePreviewRole(arg_166_1, arg_166_2)

	return
end

function var_0_0.OnUnLoadDelegatePreviewRole(arg_167_0)
	arg_167_0.effectMgr:UnLoadDelegatePreviewRole()

	return
end

function var_0_0.OnSelectSlotEffectShow(arg_168_0, arg_168_1, arg_168_2, arg_168_3, arg_168_4)
	arg_168_0.effectMgr:SelectSlotEffectShow(arg_168_1, arg_168_2, arg_168_3, arg_168_4)

	return
end

function var_0_0.OnTakePlantAttack(arg_169_0, arg_169_1)
	local var_169_0 = arg_169_0:GetUnitModuleWithType(arg_169_1.type, arg_169_1.id)

	if var_169_0 then
		var_169_0:TakeAttack()
	end

	return
end

function var_0_0.OnStartManage(arg_170_0, arg_170_1)
	local var_170_0 = arg_170_0:GetManageSystemModule(arg_170_1.id)

	if var_170_0 then
		var_170_0:StartManage(arg_170_1)
	end

	return
end

function var_0_0.OnEndManage(arg_171_0, arg_171_1)
	local var_171_0 = arg_171_0:GetManageSystemModule(arg_171_1.id)

	if var_171_0 then
		var_171_0:EndManage(arg_171_1)
	end

	return
end

function var_0_0.OnRefreshTaskInfoHud(arg_172_0)
	arg_172_0:GetSubView(IslandTopHeadHudView):UpdateAllHud()

	return
end

function var_0_0.OnRefreshWeatherSystem(arg_173_0)
	arg_173_0.weatherSystem:Play()

	return
end

function var_0_0.OnDispose(arg_174_0)
	arg_174_0.detectionSystem:Dispose()
	arg_174_0.effectMgr:Dispose()
	arg_174_0.coupleActionPlayer:Dispose()
	arg_174_0.coupleAction4FollowerPlayer:Dispose()
	arg_174_0.npcActionPlayer:Dispose()
	arg_174_0.weatherSystem:Dispose()
	arg_174_0.coupleNpcWordPlayer:Dispose()
	arg_174_0:GetPoolMgr():ClearFishingEffect()

	for iter_174_0, iter_174_1 in ipairs(arg_174_0.views) do
		iter_174_1:Dispose()
	end

	for iter_174_2, iter_174_3 in ipairs(arg_174_0.pathfinders) do
		iter_174_3:Dispose()
	end

	for iter_174_4, iter_174_5 in ipairs(arg_174_0:GetAllUnits()) do
		iter_174_5:Dispose()
	end

	for iter_174_6, iter_174_7 in pairs(arg_174_0.unitBuilders) do
		iter_174_7:Dispose()
	end

	for iter_174_8, iter_174_9 in pairs(arg_174_0.systemBuilders) do
		iter_174_9:Dispose()
	end

	for iter_174_10, iter_174_11 in pairs(arg_174_0.fishingSynPlayers) do
		iter_174_11:Dispose()
	end

	arg_174_0.fishingSynPlayers = nil
	arg_174_0.npcActionPlayer = nil
	arg_174_0.coupleActionPlayer = nil
	arg_174_0.coupleAction4FollowerPlayer = nil
	arg_174_0.pathfinders = nil
	arg_174_0.unitBuilders = nil
	arg_174_0.systemBuilders = nil
	arg_174_0.views = nil
	arg_174_0.player = nil
	arg_174_0.isInit = false
	arg_174_0._unitList = nil
	arg_174_0.detectionSystem = nil
	arg_174_0.effectMgr = nil
	arg_174_0.coupleNpcWordPlayer = nil
	arg_174_0.weatherSystem = nil

	return
end

return var_0_0
