local IslandView = class("IslandView", import(".IslandBaseView"))

function IslandView:Init()
	self._unitList = {}
	self.isInit = false

	self:RegisterUnitList(IslandConst.UNIT_LIST_PLAYER)
	self:RegisterUnitList(IslandConst.UNIT_LIST_OBJ)
	self:RegisterUnitList(IslandConst.UNIT_LIST_SYSTEM)
	self:RegisterUnitList(IslandConst.UNIT_LIST_DELEGATION)
	self:RegisterUnitList(IslandConst.UNIT_LIST_STROLL)
	self:RegisterUnitList(IslandConst.UNIT_LIST_MANAGE_SYSTEM)
	self:RegisterUnitList(IslandConst.UNIT_LIST_MANAGE)
	self:RegisterUnitList(IslandConst.UNIT_LIST_DELEGATION_ANIMATION)
	self:RegisterUnitList(IslandConst.UNIT_LIST_FOLLOW)
	self:RegisterUnitList(IslandConst.UNIT_LIST_DELAY)
	self:RegisterUnitList(IslandConst.UNIT_LIST_PHOTO)
	self:RegisterUnitList(IslandConst.UNIT_LIST_FISH_POINT)
	self:RegisterUnitList(IslandConst.UNIT_LIST_DELEGATE_UNIT)
	self:RegisterUnitList(IslandConst.UNIT_LIST_PRODUCT_SYSTEM)
	self:RegisterUnitList(IslandConst.UNIT_LIST_CHEATER_ITEM)

	self.unitBuilders = {
		[IslandConst.UNIT_TYPE_ITEM] = IslandStaticUnitBuilder.New(self, IslandConst.UNIT_LIST_OBJ),
		[IslandConst.UNIT_TYPE_CHAR] = IslandNpcBuilder.New(self, IslandConst.UNIT_LIST_OBJ),
		[IslandConst.UNIT_TYPE_VISITOR] = IslandVisitorBuilder.New(self, IslandConst.UNIT_LIST_PLAYER),
		[IslandConst.UNIT_TYPE_PLAYER] = IslandPlayerBuilder.New(self, IslandConst.UNIT_LIST_PLAYER),
		[IslandConst.UNIT_TYPE_VIRTUAL_INTERACT] = IslandVirtualInteractBuilder.New(self, IslandConst.UNIT_LIST_OBJ),
		[IslandConst.UNIT_TYPE_ITEM_INTERACT] = IslandItemInteractBuilder.New(self, IslandConst.UNIT_LIST_OBJ),
		[IslandConst.UNIT_TYPE_ITEM_HANDLE_COLLECT] = IslandItemHandCollectBuilder.New(self, IslandConst.UNIT_LIST_OBJ),
		[IslandConst.UNIT_TYPE_ITEM_HANDLE_PLANTING] = IslandItemHandPlantBuilder.New(self, IslandConst.UNIT_LIST_OBJ),
		[IslandConst.UNIT_TYPE_STROLL] = IslandStrollNpcBuilder.New(self, IslandConst.UNIT_LIST_STROLL),
		[IslandConst.UNIT_TYPE_SYSTEM] = IslandSystemNpcBuilder.New(self, IslandConst.UNIT_LIST_DELEGATION),
		[IslandConst.UNIT_TYPE_ITEM_GATHER_ITEM] = IslandItemWildGahterBuilder.New(self, IslandConst.UNIT_LIST_OBJ),
		[IslandConst.UNIT_TYPE_ITEM_WILD_COLLECT_ITEM] = IslandItemWildGahterBuilder.New(self, IslandConst.UNIT_LIST_OBJ),
		[IslandConst.UNIT_TYPE_MANAGE_CHARA] = IslandSystemDelegationUnitBuilder.New(self, IslandConst.UNIT_LIST_MANAGE),
		[IslandConst.UNIT_TYPE_MANAGE_ITEM] = IslandStaticUnitBuilder.New(self, IslandConst.UNIT_LIST_MANAGE),
		[IslandConst.UNIT_TYPE_MANAGE_CUSTOMER] = IslandStaticCharaBuilder.New(self, IslandConst.UNIT_LIST_MANAGE),
		[IslandConst.UNIT_TYPE_SYSTEM_DELEAGTION] = IslandSystemDelegationUnitBuilder.New(self, IslandConst.UNIT_LIST_DELEGATION),
		[IslandConst.UNIT_TYPE_SYSTEM_DELEAGTION_ANIMATION] = IslandSystemDelegationUnitBuilder.New(self, IslandConst.UNIT_LIST_DELEGATION_ANIMATION),
		[IslandConst.UNIT_TYPE_FOLLOWER] = IslandFollowNpcBuilder.New(self, IslandConst.UNIT_LIST_FOLLOW),
		[IslandConst.UNIT_TYPE_ITEM_DELAY_RECYCLE] = IslandDelayRecycleUnitBuilder.New(self, IslandConst.UNIT_LIST_DELAY),
		[IslandConst.UNIT_TYPE_FIRST_TAKE_PHOTO_ITEM] = IslandTakePhotoBuilder.New(self, IslandConst.UNIT_LIST_PHOTO),
		[IslandConst.UNIT_TYPE_FISH_POINT] = IslandStaticUnitBuilder.New(self, IslandConst.UNIT_LIST_FISH_POINT),
		[IslandConst.UNIT_TYPE_DELEGATE_FISH] = IslandDelegationFishBuilder.New(self, IslandConst.UNIT_LIST_DELEGATE_UNIT),
		[IslandConst.UNIT_TYPE_CHEATERTAVERN_PLAYER] = IslandCheaterTavernPlayerBuilder.New(self, IslandConst.UNIT_LIST_PLAYER),
		[IslandConst.UNIT_TYPE_CHEATERTAVERN_TABLE] = IslandCheaterTavernTableBuilder.New(self, IslandConst.UNIT_LIST_CHEATER_ITEM),
		[IslandConst.UNIT_TYPE_CHEATERTAVERN_CHAIR] = IslandCheaterTavernChairBuilder.New(self, IslandConst.UNIT_LIST_CHEATER_ITEM)
	}
	self.systemBuilders = {
		[IslandConst.SYSTEM_TYPE_CHARACTER] = IslandSystemBuilder.New(self, IslandCharacterSystem),
		[IslandConst.SYSTEM_TYPE_PRODUCT] = IslandSystemBuilder.New(self, IslandProductSystem, IslandConst.UNIT_LIST_PRODUCT_SYSTEM),
		[IslandConst.SYSTEM_TYPE_SEEKGAME] = IslandSystemBuilder.New(self, IslandSeekGameSystem),
		[IslandConst.SYSTEM_TYPE_GROUND] = IslandGroundSystemBuilder.New(self, IslandGoundLayerSystem),
		[IslandConst.SYSTEM_TYPE_GRASSLAND] = IslandSystemBuilder.New(self, IslandGrassLandSystem),
		[IslandConst.SYSTEM_TYPE_MANAGE] = IslandManageSystemBuilder.New(self, IslandManageSystem)
	}
	self.detectionSystem = IslandDetectionSystem.New(self)
	self.effectMgr = IslandDelegateEffectMgr.New(self)
	self.coupleActionPlayer = IslandCoupleActionPlayer.New(self)
	self.coupleAction4FollowerPlayer = IslandCoupleAction4FollowerPlayer.New(self)
	self.npcActionPlayer = IslandNpcActionPlayer.New(self)
	self.weatherSystem = IslandWeatherSystem.New(self)
	self.coupleNpcWordPlayer = IslandCoupleNpcWordPlayer.New(self)
	self.pathfinders = {}
	self.fishingSynPlayers = {}

	self:CreateViews()

	return
end

function IslandView:CreateViews()
	self.views = {
		self:CreateInteractionView(),
		self:CreateDistanceView(),
		self:CreateSeedOpView(),
		self:CreateOpView(),
		self:CreateSlotHudView(),
		self:CreateTopHeadHudView(),
		self:CreateBottomHeadHudeView(),
		self:CreateCancelAnimationOpView(),
		self:CreateEffectView(),
		self:CreateAnimationOpView()
	}

	return
end

function IslandView:DoEnter()
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(self:GetAllUnits()) do
		table.insert(var_3_0, function(arg_4_0)
			iter_3_1:Start()

			if iter_3_0 % 3 == 0 then
				arg_4_0()
			else
				onNextTick(arg_4_0)
			end

			return
		end)
	end

	seriesAsync(var_3_0, function()
		self.isInit = true

		return
	end)

	return
end

function IslandView:GetSubView(arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(self.views or {}) do
		if isa(iter_6_1, arg_6_1) then
			return iter_6_1
		end
	end

	return nil
end

function IslandView:CreateEffectView()
	return IslandEffectView.New(self)
end

function IslandView:CreateOpView()
	return IslandOpView.New(self)
end

function IslandView:CreateSlotHudView()
	return IslandSlotHudView.New(self)
end

function IslandView:CreateCancelAnimationOpView()
	return IslandCancelAnimationOpView.New(self)
end

function IslandView:CreateTopHeadHudView()
	return IslandTopHeadHudView.New(self)
end

function IslandView:CreateBottomHeadHudeView()
	return IslandBottomHeadHudView.New(self)
end

function IslandView:CreateAnimationOpView()
	return IslandAniamtionOpView.New(self)
end

function IslandView:CreateInteractionView()
	return IslandInteractionView.New(self)
end

function IslandView:CreateDistanceView()
	return IslandDistanceView.New(self)
end

function IslandView:CreateSeedOpView()
	return IslandSeedOpView.New(self)
end

function IslandView:IsLoaded()
	local var_17_0 = self:GetAllUnits()

	return _.all(self.views, function(arg_18_0)
		return arg_18_0:IsLoaded()
	end) and #var_17_0 > 0 and _.all(var_17_0, function(arg_19_0)
		return arg_19_0:IsLoaded()
	end)
end

function IslandView:IsInit()
	return self.isInit
end

function IslandView:Update()
	if not self.isInit then
		return
	end

	for iter_21_0, iter_21_1 in ipairs(self:GetAllUnits()) do
		iter_21_1:Update()
	end

	for iter_21_2, iter_21_3 in ipairs(self.views) do
		iter_21_3:Update()
	end

	for iter_21_4, iter_21_5 in ipairs(self.pathfinders) do
		iter_21_5:Update()
	end

	if self.needTryTrack then
		self:TryTrack()
	end

	if self.needTryMainTrack then
		self:TryMainTrack()
	end

	return
end

function IslandView:LateUpdate()
	if not self.isInit then
		return
	end

	for iter_22_0, iter_22_1 in ipairs(self:GetAllUnits()) do
		iter_22_1:LateUpdate()
	end

	for iter_22_2, iter_22_3 in ipairs(self.views) do
		iter_22_3:LateUpdate()
	end

	for iter_22_4, iter_22_5 in ipairs(self.pathfinders) do
		iter_22_5:LateUpdate()
	end

	return
end

function IslandView:AddListeners()
	self:AddListener(ISLAND_EVT.GEN_UNIT, self.OnGenUnit)
	self:AddListener(ISLAND_EVT.RMOVE_UNIT, self.OnRemoveUnit)
	self:AddListener(ISLAND_EVT.INTERACTION_UNIT_BEGIN, self.OnInterActionBegin)
	self:AddListener(ISLAND_EVT.INTERACTION_UNIT_END, self.OnInterActionEnd)
	self:AddListener(ISLAND_EVT.STOP_MOVE_UNIT, self.OnStopUnit)
	self:AddListener(ISLAND_EVT.MOVE_UNIT, self.OnMoveUnit)
	self:AddListener(ISLAND_EVT.INIT_FINISH, self.OnSceneInited)
	self:AddListener(ISLAND_EVT.MOVE_PLAYER, self.OnPlayerMove)
	self:AddListener(ISLAND_EVT.STOP_MOVE_PLAYER, self.OnPlayerStopMoveHandle)
	self:AddListener(ISLAND_EVT.JUMP_PLAYER, self.OnPlayerJump)
	self:AddListener(ISLAND_EVT.APPROACH_UNIT, self.OnShowInterActionPanel)
	self:AddListener(ISLAND_EVT.LEAVE_UNIT, self.OnHideInterActionPanel)
	self:AddListener(ISLAND_EVT.TRACKING, self.OnTracking)
	self:AddListener(ISLAND_EVT.UNTRACKING, self.OnUnTracking)
	self:AddListener(ISLAND_EVT.AREACHANGE, self.OnPlayerAreaChange)
	self:AddListener(ISLAND_EVT.PLAYERRUN, self.OnPlayerPlayerRun)
	self:AddListener(ISLAND_EVT.SPRINT_PLAYER, self.OnPlayerPlayerSprint)
	self:AddListener(ISLAND_EVT.STOP_SPRINT_PLAYER, self.OnStopPlayerSprint)
	self:AddListener(ISLAND_EVT.CHANGE_DRESS, self.OnChangeDress)
	self:AddListener(ISLAND_EVT.CHANGE_CHARACTER_DRESS, self.OnCharacterChangeDress)
	self:AddListener(ISLAND_EVT.MORPH_FORM_CHANGE, self.OnMorphFormChange)
	self:AddListener(ISLAND_EVT.RESET_UNIT_POS, self.OnResetUnitPos)
	self:AddListener(ISLAND_EVT.RESET_UNIT_ROT, self.OnResetUnitRotation)
	self:AddListener(ISLAND_EVT.ANY_PAGE_OPENED, self.OnAnyPageOpen)
	self:AddListener(ISLAND_EVT.ALL_PAGE_CLOSED, self.OnAllPageClose)
	self:AddListener(ISLAND_EVT.Change_TakePhoto_Model, self.OnChangeTakePhotoModel)
	self:AddListener(ISLAND_EVT.Change_Photo_Height, self.OnChange_Photo_Height)
	self:AddListener(ISLAND_EVT.SetOpMoveBtnActve, self.OnSetOpMoveBtnActve)
	self:AddListener(ISLAND_EVT.PLAY_BUBBLE, self.OnPlayChatBubble)
	self:AddListener(ISLAND_EVT.RAW_PLAY_BUBBLE, self.OnRawPlayChatBubble)
	self:AddListener(ISLAND_EVT.RAW_STOP_BUBBLE, self.OnRawStopChatBubble)
	self:AddListener(ISLAND_EVT.START_STORY, self.OnStartStory)
	self:AddListener(ISLAND_EVT.END_STORY, self.OnEndStory)
	self:AddListener(ISLAND_EVT.START_DEGATION, self.OnStartDelegation)
	self:AddListener(ISLAND_EVT.END_DEGATION, self.OnEndDelegation)
	self:AddListener(ISLAND_EVT.GEN_SYSTEM, self.OnGenSystem)
	self:AddListener(ISLAND_EVT.WORLD_OBJECT_START_INTERACTION, self.OnWorldObjectStartInteraction)
	self:AddListener(ISLAND_EVT.WORLD_OBJECT_END_INTERACTION, self.OnWorldObjectEndInteraction)
	self:AddListener(ISLAND_EVT.WORLD_OBJECT_INIT_STATUS, self.OnWorldObjectInitStatus)
	self:AddListener(ISLAND_EVT.INIT_INTERACTION_OP_VIEW, self.InitInteractionOpView)
	self:AddListener(ISLAND_EVT.REFRESH_INTERACTION, self.OnRefreshInteractionBtn)
	self:AddListener(ISLAND_EVT.SHOW_UNIT_HUD_OP, self.OnShowUnitHudAndOpBtn)
	self:AddListener(ISLAND_EVT.HIDE_UNIT_HUD_OP, self.OnHideUnitHudAndOpBtn)
	self:AddListener(ISLAND_EVT.DETECTOR_CHANGED, self.OnDetectorChanged)
	self:AddListener(ISLAND_EVT.SELECTED_DETECTOR, self.OnDetectorSelected)
	self:AddListener(ISLAND_EVT.FISHPOINT_DETECTOR, self.OnFishPointSelected)
	self:AddListener(ISLAND_EVT.NPC_DETECTED, self.OnNpcDetectorSelected)
	self:AddListener(ISLAND_EVT.NO_NPC_DETECTED, self.OnNpcDetectorUnSelected)
	self:AddListener(ISLAND_EVT.SET_PLAYER_WORK, self.OnPlayerWork)
	self:AddListener(ISLAND_EVT.DEVIEE_STATE_CHANGE, self.OnPlayerDeviceStateChange)
	self:AddListener(ISLAND_EVT.UPDATE_HUD, self.OnUpdateHud)
	self:AddListener(ISLAND_EVT.PLAY_EFFECT, self.OnPlayEffect)
	self:AddListener(ISLAND_EVT.UPDATE_UNIT_HAND_COLLECT, self.OnUpdateHandCollectUnit)
	self:AddListener(ISLAND_EVT.START_DELEGATE_SLOT_PERFORM, self.OnDelegateSlotStartPerform)
	self:AddListener(ISLAND_EVT.RECYCLE_ALL_SLOTDELEEFFECT, self.OnRecycleAllSlotEffct)
	self:AddListener(ISLAND_EVT.SELECTDELEEFFECT_SHOW, self.OnSelectSlotEffectShow)
	self:AddListener(ISLAND_EVT.LOAD_DELEGATE_PREVIEW_ROLE, self.OnLoadDelegatePreviewRole)
	self:AddListener(ISLAND_EVT.UN_LOAD_DELEGATE_PREVIEW_ROLE, self.OnUnLoadDelegatePreviewRole)
	self:AddListener(ISLAND_EVT.Take_Plant_Attact, self.OnTakePlantAttack)
	self:AddListener(ISLAND_EVT.START_MANAGE, self.OnStartManage)
	self:AddListener(ISLAND_EVT.END_MANAGE, self.OnEndManage)
	self:AddListener(ISLAND_EVT.SHOW_HUD, self.OnShowHud)
	self:AddListener(ISLAND_EVT.HIDE_HUD, self.OnHideHud)
	self:AddListener(ISLAND_EVT.REFRESH_HUD, self.OnRefreshHud)
	self:AddListener(ISLAND_EVT.START_GUIDE, self.OnStartGuide)
	self:AddListener(ISLAND_EVT.END_GUIDE, self.OnEndGuide)
	self:AddListener(ISLAND_EVT.START_PERFORMANCE, self.OnStartPerformance)
	self:AddListener(ISLAND_EVT.END_PERFORMANCE, self.OnEndPerformance)
	self:AddListener(ISLAND_EVT.DISABLE_INPUT, self.DisableInput)
	self:AddListener(ISLAND_EVT.ENABLE_INPUT, self.EnableInput)
	self:AddListener(ISLAND_EVT.GEN_PATH_FINDER, self.OnGenPathFinder)
	self:AddListener(ISLAND_EVT.REMOVE_PATH_FINDER, self.OnRemovePathFinder)
	self:AddListener(ISLAND_EVT.ACTIVE_OR_DISACTIVE_UNIT, self.OnActiveOrDisactiveUnit)
	self:AddListener(ISLAND_EVT.OPEN_ANIMATION_OP, self.OnOpenAniamtionOpPage)
	self:AddListener(ISLAND_EVT.CLOSE_ANIMATION_OP, self.OnCloseAniamtionOpPage)
	self:AddListener(ISLAND_EVT.MOVE_PLAYER_BEFORE, self.OnMovePlayerBefore)
	self:AddListener(ISLAND_EVT.REFRESH_TASK_HUD_INFO, self.OnRefreshTaskInfoHud)
	self:AddListener(ISLAND_EVT.RESPON_ANIMATION_OP, self.OnResponAniamtionOp)
	self:AddListener(ISLAND_EVT.CHANGE_VISTER_DRESS, self.OnChangeVisterDress)
	self:AddListener(ISLAND_EVT.SET_VISITOR_SYNC_DATA, self.OnSetVisitorSyncData)
	self:AddListener(ISLAND_EVT.SHOW_NPC_ANIMATION_BUBBLE, self.OnShowNpcAniamtionBubble)
	self:AddListener(ISLAND_EVT.HIDE_NPC_ANIMATION_BUBBLE, self.OnHideNpcAniamtionBubble)
	self:AddListener(ISLAND_EVT.PLAY_SIGNLE_ANIMATION_END, self.OnPlaySingleAnimationEnd)
	self:AddListener(ISLAND_EVT.UPDATE_CUSTOM_OP_POSITON, self.OnUpdateCustomOpPositon)
	self:AddListener(ISLAND_EVT.CHAT_MSG_UPDATE, self.OnChatMsgUpdate)
	self:AddListener(ISLAND_EVT.CHAT_ROOM_UPDATE, self.OnChatRoomChange)
	self:AddListener(ISLAND_EVT.SHOW_CHAT_MSG, self.OnShowChatMsg)
	self:AddListener(ISLAND_EVT.RESET_FOLLOW_RANDOMIZER, self.OnResetFollowRandomizer)
	self:AddListener(ISLAND_EVT.ADD_FOLLOWER, self.OnFollowerAdd)
	self:AddListener(ISLAND_EVT.WILL_DEL_FOLLOWER, self.OnFollowerWillDelStep1)
	self:AddListener(ISLAND_EVT.DO_DEL_FOLLOWER, self.OnFollowerWillDelStep2)
	self:AddListener(ISLAND_EVT.DEL_FOLLOWER, self.OnFollowerDel)
	self:AddListener(ISLAND_EVT.COUPLE_ACTION_WITH_FOLLOWER, self.OnCoupleActionWithFollower)
	self:AddListener(ISLAND_EVT.LOCK_PLAYER_INPUT, self.OnLockPlayerInput)
	self:AddListener(ISLAND_EVT.START_COUPLE_ACTION, self.OnStartCoupleAction)
	self:AddListener(ISLAND_EVT.END_COUPLE_ACTION, self.OnEndCoupleAction)
	self:AddListener(ISLAND_EVT.REFRESH_WEATHER_SYSTEM, self.OnRefreshWeatherSystem)
	self:AddListener(ISLAND_EVT.SYSTEM_UNLOCK, self.OnSystemUnlock)
	self:AddListener(ISLAND_EVT.START_DO_COUPLE_ACTION, self.OnStartDoCoupleAction)
	self:AddListener(ISLAND_EVT.END_DO_COUPLE_ACTION, self.OnEndDoCoupleAction)
	self:AddListener(ISLAND_EVT.CANCEL_COUPLE_ACTION, self.OnCancelCoupleAction)
	self:AddListener(ISLAND_EVT.BAIT_UPDATE, self.OnBaitUpdate)
	self:AddListener(ISLAND_EVT.START_FISHING, self.OnStartFishing)
	self:AddListener(ISLAND_EVT.FISHING_STATE_CHANGE, self.OnFishingStateChange)
	self:AddListener(ISLAND_EVT.ALL_DAILY_OR_WEEKLY_FINISH, self.OnAllDailyOrWeeklyFinish)

	return
end

function IslandView:RemoveListeners()
	self:RemoveListener(ISLAND_EVT.GEN_UNIT, self.OnGenUnit)
	self:RemoveListener(ISLAND_EVT.RMOVE_UNIT, self.OnRemoveUnit)
	self:RemoveListener(ISLAND_EVT.INTERACTION_UNIT_BEGIN, self.OnInterActionBegin)
	self:RemoveListener(ISLAND_EVT.INTERACTION_UNIT_END, self.OnInterActionEnd)
	self:RemoveListener(ISLAND_EVT.STOP_MOVE_UNIT, self.OnStopUnit)
	self:RemoveListener(ISLAND_EVT.MOVE_UNIT, self.OnMoveUnit)
	self:RemoveListener(ISLAND_EVT.INIT_FINISH, self.OnSceneInited)
	self:RemoveListener(ISLAND_EVT.MOVE_PLAYER, self.OnPlayerMove)
	self:RemoveListener(ISLAND_EVT.STOP_MOVE_PLAYER, self.OnPlayerStopMoveHandle)
	self:RemoveListener(ISLAND_EVT.JUMP_PLAYER, self.OnPlayerJump)
	self:RemoveListener(ISLAND_EVT.APPROACH_UNIT, self.OnShowInterActionPanel)
	self:RemoveListener(ISLAND_EVT.LEAVE_UNIT, self.OnHideInterActionPanel)
	self:RemoveListener(ISLAND_EVT.TRACKING, self.OnTracking)
	self:RemoveListener(ISLAND_EVT.UNTRACKING, self.OnUnTracking)
	self:RemoveListener(ISLAND_EVT.AREACHANGE, self.OnPlayerAreaChange)
	self:RemoveListener(ISLAND_EVT.PLAYERRUN, self.OnPlayerPlayerRun)
	self:RemoveListener(ISLAND_EVT.SPRINT_PLAYER, self.OnPlayerPlayerSprint)
	self:RemoveListener(ISLAND_EVT.STOP_SPRINT_PLAYER, self.OnStopPlayerSprint)
	self:RemoveListener(ISLAND_EVT.CHANGE_DRESS, self.OnChangeDress)
	self:RemoveListener(ISLAND_EVT.CHANGE_CHARACTER_DRESS, self.OnCharacterChangeDress)
	self:RemoveListener(ISLAND_EVT.MORPH_FORM_CHANGE, self.OnMorphFormChange)
	self:RemoveListener(ISLAND_EVT.RESET_UNIT_POS, self.OnResetUnitPos)
	self:RemoveListener(ISLAND_EVT.RESET_UNIT_ROT, self.OnResetUnitRotation)
	self:RemoveListener(ISLAND_EVT.ANY_PAGE_OPENED, self.OnAnyPageOpen)
	self:RemoveListener(ISLAND_EVT.Change_TakePhoto_Model, self.OnChangeTakePhotoModel)
	self:RemoveListener(ISLAND_EVT.Change_Photo_Height, self.OnChange_Photo_Height)
	self:RemoveListener(ISLAND_EVT.SetOpMoveBtnActve, self.OnSetOpMoveBtnActve)
	self:RemoveListener(ISLAND_EVT.ALL_PAGE_CLOSED, self.OnAllPageClose)
	self:RemoveListener(ISLAND_EVT.PLAY_BUBBLE, self.OnPlayChatBubble)
	self:RemoveListener(ISLAND_EVT.RAW_PLAY_BUBBLE, self.OnRawPlayChatBubble)
	self:RemoveListener(ISLAND_EVT.RAW_STOP_BUBBLE, self.OnRawStopChatBubble)
	self:RemoveListener(ISLAND_EVT.START_STORY, self.OnStartStory)
	self:RemoveListener(ISLAND_EVT.END_STORY, self.OnEndStory)
	self:RemoveListener(ISLAND_EVT.START_DEGATION, self.OnStartDelegation)
	self:RemoveListener(ISLAND_EVT.END_DEGATION, self.OnEndDelegation)
	self:RemoveListener(ISLAND_EVT.GEN_SYSTEM, self.OnGenSystem)
	self:RemoveListener(ISLAND_EVT.WORLD_OBJECT_START_INTERACTION, self.OnWorldObjectStartInteraction)
	self:RemoveListener(ISLAND_EVT.WORLD_OBJECT_END_INTERACTION, self.OnWorldObjectEndInteraction)
	self:RemoveListener(ISLAND_EVT.WORLD_OBJECT_INIT_STATUS, self.OnWorldObjectInitStatus)
	self:RemoveListener(ISLAND_EVT.INIT_INTERACTION_OP_VIEW, self.InitInteractionOpView)
	self:RemoveListener(ISLAND_EVT.REFRESH_INTERACTION, self.OnRefreshInteractionBtn)
	self:RemoveListener(ISLAND_EVT.SHOW_UNIT_HUD_OP, self.OnShowUnitHudAndOpBtn)
	self:RemoveListener(ISLAND_EVT.HIDE_UNIT_HUD_OP, self.OnHideUnitHudAndOpBtn)
	self:RemoveListener(ISLAND_EVT.DETECTOR_CHANGED, self.OnDetectorChanged)
	self:RemoveListener(ISLAND_EVT.SELECTED_DETECTOR, self.OnDetectorSelected)
	self:RemoveListener(ISLAND_EVT.FISHPOINT_DETECTOR, self.OnFishPointSelected)
	self:RemoveListener(ISLAND_EVT.NPC_DETECTED, self.OnNpcDetectorSelected)
	self:RemoveListener(ISLAND_EVT.NO_NPC_DETECTED, self.OnNpcDetectorUnSelected)
	self:RemoveListener(ISLAND_EVT.SET_PLAYER_WORK, self.OnPlayerWork)
	self:RemoveListener(ISLAND_EVT.DEVIEE_STATE_CHANGE, self.OnPlayerDeviceStateChange)
	self:RemoveListener(ISLAND_EVT.UPDATE_HUD, self.OnUpdateHud)
	self:RemoveListener(ISLAND_EVT.PLAY_EFFECT, self.OnPlayEffect)
	self:RemoveListener(ISLAND_EVT.UPDATE_UNIT_HAND_COLLECT, self.OnUpdateHandCollectUnit)
	self:RemoveListener(ISLAND_EVT.RECYCLE_ALL_SLOTDELEEFFECT, self.OnRecycleAllSlotEffct)
	self:RemoveListener(ISLAND_EVT.SELECTDELEEFFECT_SHOW, self.OnSelectSlotEffectShow)
	self:RemoveListener(ISLAND_EVT.LOAD_DELEGATE_PREVIEW_ROLE, self.OnLoadDelegatePreviewRole)
	self:RemoveListener(ISLAND_EVT.UN_LOAD_DELEGATE_PREVIEW_ROLE, self.OnUnLoadDelegatePreviewRole)
	self:RemoveListener(ISLAND_EVT.Take_Plant_Attact, self.OnTakePlantAttack)
	self:RemoveListener(ISLAND_EVT.START_MANAGE, self.OnStartManage)
	self:RemoveListener(ISLAND_EVT.END_MANAGE, self.OnEndManage)
	self:RemoveListener(ISLAND_EVT.SHOW_HUD, self.OnShowHud)
	self:RemoveListener(ISLAND_EVT.HIDE_HUD, self.OnHideHud)
	self:RemoveListener(ISLAND_EVT.REFRESH_HUD, self.OnRefreshHud)
	self:RemoveListener(ISLAND_EVT.START_GUIDE, self.OnStartGuide)
	self:RemoveListener(ISLAND_EVT.END_GUIDE, self.OnEndGuide)
	self:RemoveListener(ISLAND_EVT.START_PERFORMANCE, self.OnStartPerformance)
	self:RemoveListener(ISLAND_EVT.END_PERFORMANCE, self.OnEndPerformance)
	self:RemoveListener(ISLAND_EVT.DISABLE_INPUT, self.DisableInput)
	self:RemoveListener(ISLAND_EVT.ENABLE_INPUT, self.EnableInput)
	self:RemoveListener(ISLAND_EVT.GEN_PATH_FINDER, self.OnGenPathFinder)
	self:RemoveListener(ISLAND_EVT.REMOVE_PATH_FINDER, self.OnRemovePathFinder)
	self:RemoveListener(ISLAND_EVT.ACTIVE_OR_DISACTIVE_UNIT, self.OnActiveOrDisactiveUnit)
	self:RemoveListener(ISLAND_EVT.OPEN_ANIMATION_OP, self.OnOpenAniamtionOpPage)
	self:RemoveListener(ISLAND_EVT.CLOSE_ANIMATION_OP, self.OnCloseAniamtionOpPage)
	self:RemoveListener(ISLAND_EVT.MOVE_PLAYER_BEFORE, self.OnMovePlayerBefore)
	self:RemoveListener(ISLAND_EVT.REFRESH_TASK_HUD_INFO, self.OnRefreshTaskInfoHud)
	self:RemoveListener(ISLAND_EVT.RESPON_ANIMATION_OP, self.OnResponAniamtionOp)
	self:RemoveListener(ISLAND_EVT.CHANGE_VISTER_DRESS, self.OnChangeVisterDress)
	self:RemoveListener(ISLAND_EVT.SET_VISITOR_SYNC_DATA, self.OnSetVisitorSyncData)
	self:RemoveListener(ISLAND_EVT.SHOW_NPC_ANIMATION_BUBBLE, self.OnShowNpcAniamtionBubble)
	self:RemoveListener(ISLAND_EVT.HIDE_NPC_ANIMATION_BUBBLE, self.OnHideNpcAniamtionBubble)
	self:RemoveListener(ISLAND_EVT.PLAY_SIGNLE_ANIMATION_END, self.OnPlaySingleAnimationEnd)
	self:RemoveListener(ISLAND_EVT.UPDATE_CUSTOM_OP_POSITON, self.OnUpdateCustomOpPositon)
	self:RemoveListener(ISLAND_EVT.CHAT_MSG_UPDATE, self.OnChatMsgUpdate)
	self:RemoveListener(ISLAND_EVT.CHAT_ROOM_UPDATE, self.OnChatRoomChange)
	self:RemoveListener(ISLAND_EVT.SHOW_CHAT_MSG, self.OnShowChatMsg)
	self:RemoveListener(ISLAND_EVT.RESET_FOLLOW_RANDOMIZER, self.OnResetFollowRandomizer)
	self:RemoveListener(ISLAND_EVT.ADD_FOLLOWER, self.OnFollowerAdd)
	self:RemoveListener(ISLAND_EVT.WILL_DEL_FOLLOWER, self.OnFollowerWillDelStep1)
	self:RemoveListener(ISLAND_EVT.DO_DEL_FOLLOWER, self.OnFollowerWillDelStep2)
	self:RemoveListener(ISLAND_EVT.DEL_FOLLOWER, self.OnFollowerDel)
	self:RemoveListener(ISLAND_EVT.COUPLE_ACTION_WITH_FOLLOWER, self.OnCoupleActionWithFollower)
	self:RemoveListener(ISLAND_EVT.LOCK_PLAYER_INPUT, self.OnLockPlayerInput)
	self:RemoveListener(ISLAND_EVT.START_COUPLE_ACTION, self.OnStartCoupleAction)
	self:RemoveListener(ISLAND_EVT.END_COUPLE_ACTION, self.OnEndCoupleAction)
	self:RemoveListener(ISLAND_EVT.REFRESH_WEATHER_SYSTEM, self.OnRefreshWeatherSystem)
	self:RemoveListener(ISLAND_EVT.SYSTEM_UNLOCK, self.OnSystemUnlock)
	self:RemoveListener(ISLAND_EVT.START_DO_COUPLE_ACTION, self.OnStartDoCoupleAction)
	self:RemoveListener(ISLAND_EVT.END_DO_COUPLE_ACTION, self.OnEndDoCoupleAction)
	self:RemoveListener(ISLAND_EVT.CANCEL_COUPLE_ACTION, self.OnCancelCoupleAction)
	self:RemoveListener(ISLAND_EVT.BAIT_UPDATE, self.OnBaitUpdate)
	self:RemoveListener(ISLAND_EVT.START_FISHING, self.OnStartFishing)
	self:RemoveListener(ISLAND_EVT.FISHING_STATE_CHANGE, self.OnFishingStateChange)
	self:RemoveListener(ISLAND_EVT.ALL_DAILY_OR_WEEKLY_FINISH, self.OnAllDailyOrWeeklyFinish)

	return
end

function IslandView:OnBaitUpdate(arg_25_1)
	self:GetSubView(IslandOpView):UpdateLureBtn()

	return
end

function IslandView:OnFishPointSelected(arg_26_1)
	if not arg_26_1.node then
		return
	end

	local var_26_0 = arg_26_1.node:GetBlackboardVariable("FishPoint")

	if not var_26_0 or var_26_0 == "" then
		self:UnSelectedFishPoint()
	else
		local var_26_1, var_26_2 = IslandCalcUtil.GetTypeAndIdByUniqueId(var_26_0)
		local var_26_3 = self:GetUnitModuleWithType(var_26_1, var_26_2)

		if var_26_3 then
			self:SelectedFishPoint(var_26_3)
		end
	end

	return
end

function IslandView:OnAllDailyOrWeeklyFinish(arg_27_1)
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in ipairs((self:GetUnitListByKey(IslandConst.UNIT_LIST_FOLLOW))) do
		if not iter_27_1:IsExitState() then
			table.insert(var_27_0, iter_27_1)
		end
	end

	if #var_27_0 <= 0 then
		return
	end

	for iter_27_2, iter_27_3 in ipairs(var_27_0) do
		iter_27_3:StopMove()
		iter_27_3:PlayAnimation(arg_27_1)
	end

	return
end

function IslandView:OnSystemUnlock(arg_28_1)
	if arg_28_1 == IslandAblityAgency.ANIMATION_OP_ID then
		self:GetSubView(IslandOpView):UpdateAnimationOpBtn()
	end

	return
end

function IslandView:SelectedFishPoint(arg_29_1)
	if not self:GetSelfIsland():GetAblityAgency():IsUnlockFishing() or arg_29_1:GetUnitType() ~= IslandConst.UNIT_LIST_FISH_POINT or self.player:StandOnWorldObject() or not self.player:OnGrouded() then
		return
	end

	self:UnSelectedFishPoint()

	self.selectedFishPointId = arg_29_1.id

	self:GetSubView(IslandOpView):UpdateOperationButton(IslandOpView.OperationType.Fishing, arg_29_1.id)

	return
end

function IslandView:UnSelectedFishPoint()
	if self.selectedFishPointId then
		self.selectedFishPointId = nil

		self:GetSubView(IslandOpView):UpdateOperationButton(IslandOpView.OperationType.None, self.selectedFishPointId)
	end

	return
end

function IslandView:OnStartFishing(arg_31_1)
	local var_31_0 = self:GetPlayerUnitModule(arg_31_1.unitId)

	if not var_31_0 then
		return
	end

	if not isa(var_31_0, IslandVisitorUnit) then
		return
	end

	var_31_0:Sleep()

	local var_31_1 = IslandVistorFishingPlayer.New(self, var_31_0, arg_31_1.fishPointId, pg.island_fish_rod[arg_31_1.rodId].attachment_id, arg_31_1.fishId)

	var_31_1:Play()

	self.fishingSynPlayers[arg_31_1.unitId] = var_31_1

	return
end

function IslandView:OnFishingStateChange(arg_32_1)
	local var_32_0 = arg_32_1.unitId
	local var_32_1 = self:GetPlayerUnitModule(arg_32_1.unitId)

	if not isa(var_32_1, IslandVisitorUnit) then
		return
	end

	if not self.fishingSynPlayers[arg_32_1.unitId] or not self.fishingSynPlayers[arg_32_1.unitId]:IsSameFishPoint(arg_32_1.fishPointId) then
		return
	end

	local function var_32_2()
		var_32_1:WakeUp()
		self.fishingSynPlayers[var_32_0]:Dispose()

		self.fishingSynPlayers[var_32_0] = nil

		return
	end

	if arg_32_1.op == IslandConst.FISHING_OP_CANCEL then
		self.fishingSynPlayers[arg_32_1.unitId]:OnCancel(var_32_2)
	elseif arg_32_1.op == IslandConst.FISHING_OP_FAILD then
		self.fishingSynPlayers[arg_32_1.unitId]:OnFailed(var_32_2)
	elseif arg_32_1.op == IslandConst.FISHING_OP_SUCCESS then
		self.fishingSynPlayers[arg_32_1.unitId]:OnSuccess(var_32_2)
	end

	return
end

function IslandView:OnStartCoupleAction()
	self:UnBlockLayer1Event(false)
	self:GetSubView(IslandAniamtionOpView):OnStartCoupleAction()

	return
end

function IslandView:OnEndCoupleAction()
	self:UnBlockLayer1Event(true)
	self:GetSubView(IslandAniamtionOpView):OnEndCoupleAction()

	return
end

function IslandView:OnCancelCoupleAction()
	if self.coupleActionPlayer and self.coupleActionPlayer:IsPlaying() then
		self.coupleActionPlayer:Stop()
	end

	if self.coupleAction4FollowerPlayer and self.coupleAction4FollowerPlayer:IsPlaying() then
		self.coupleAction4FollowerPlayer:Stop()
	end

	self:OnEndCoupleAction()

	return
end

function IslandView:OnCoupleActionWithFollower(arg_37_1)
	local var_37_0 = self:GetPlayerPosition()
	local var_37_1 = pg.island_set.action_bubble_range.key_value_int
	local var_37_2 = _.select(self:GetUnitListByKey(IslandConst.UNIT_LIST_FOLLOW), function(arg_38_0)
		return not arg_38_0:IsExitState() and Vector3.Distance(arg_38_0:GetPosition(), var_37_0) <= var_37_1
	end)

	if #var_37_2 <= 0 then
		return
	end

	self.coupleAction4FollowerPlayer:Play(var_37_2[math.random(1, #var_37_2)], self.player, pg.island_action[arg_37_1])
	self:GetSubView(IslandAniamtionOpView):RemoveWaitTimer(false)

	return
end

function IslandView:OnFollowerAdd(arg_39_1)
	if self:GetSelectedNpcId() then
		local var_39_0, var_39_1 = IslandCalcUtil.GetTypeAndIdByUniqueId(self:GetSelectedNpcId())

		if var_39_1 == arg_39_1 then
			self.selectedNpcId = nil
		end
	end

	self:GetSubView(IslandOpView):FlushFollowerList()
	self.coupleNpcWordPlayer:Play(arg_39_1)

	return
end

function IslandView:OnFollowerWillDelStep1(arg_40_1)
	local var_40_0

	for iter_40_0, iter_40_1 in ipairs((self:GetUnitListByKey(IslandConst.UNIT_LIST_FOLLOW))) do
		if iter_40_1:GetDataVO():IsSameShip(arg_40_1) then
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

function IslandView:OnFollowerWillDelStep2(arg_41_1)
	if not arg_41_1.node then
		return
	end

	local var_41_0, var_41_1 = IslandCalcUtil.GetTypeAndIdByUniqueId(arg_41_1.node:GetComponent(typeof(WorldObjectItem)).uniqueId)
	local var_41_2 = self:GetUnitModuleWithType(var_41_0, var_41_1)

	if not var_41_2 then
		return
	end

	self:NotifiyMeditor(IslandMediator.DEL_FOLLOWER, var_41_2:GetDataVO():GetShipId())

	return
end

function IslandView:OnFollowerDel(arg_42_1)
	self:GetSubView(IslandOpView):FlushFollowerList()
	self.coupleNpcWordPlayer:Stop(arg_42_1)

	return
end

function IslandView:OnResetFollowRandomizer(arg_43_1)
	local var_43_0 = self:GetFollowerModule(arg_43_1)

	if not var_43_0 then
		return
	end

	var_43_0:SetBtRandomizer()

	return
end

function IslandView:OnShowChatMsg(arg_44_1)
	local var_44_0 = self:GetPlayerUnitModule(arg_44_1.player.id)

	if not var_44_0 then
		return
	end

	self:GetSubView(IslandTopHeadHudView):PlayChat(var_44_0, arg_44_1.emojiId, arg_44_1.content, nil)

	return
end

function IslandView:OnChatRoomChange()
	self:GetSubView(IslandAniamtionOpView):UpdateChatRoom()

	return
end

function IslandView:OnChatMsgUpdate()
	self:GetSubView(IslandAniamtionOpView):UpdateMsgList()

	return
end

function IslandView:OnPlaySingleAnimationEnd(arg_47_1)
	if not self:GetSelectedNpcId() then
		self.npcActionPlayer:ResoponByRandom(self.player, arg_47_1)
		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildActionOp(1, arg_47_1, 0, 0, 0, 0))

		return
	end

	local var_47_0, var_47_1 = IslandCalcUtil.GetTypeAndIdByUniqueId((self:GetSelectedNpcId()))
	local var_47_2 = self:GetUnitModuleWithType(var_47_0, var_47_1)

	if isa(var_47_2, IslandStrollNpcUnit) then
		if var_47_2:GetDataVO():ExistGreetingActionFeedback() then
			self.npcActionPlayer:Resopon(var_47_2, self.player, arg_47_1)

			goto label_47_0
		end
	end

	self.npcActionPlayer:ResoponByRandom(self.player, arg_47_1)

	::label_47_0::

	return
end

function IslandView:OnShowNpcAniamtionBubble(arg_48_1)
	local var_48_0 = self:GetStrollUnitModule(arg_48_1.id)

	if not var_48_0 then
		return
	end

	self:GetSubView(IslandBottomHeadHudView):ShowAnimationOp(var_48_0, (arg_48_1:GetGreetingFeedback()))

	return
end

function IslandView:OnHideNpcAniamtionBubble(arg_49_1)
	self:GetSubView(IslandBottomHeadHudView):HideAnimationOp((self:GetStrollUnitModule(arg_49_1.id)))

	return
end

function IslandView:OnStartDoCoupleAction()
	self:GetSubView(IslandCancelAnimationOpView):ShowCancelableAnimationOp(self.player)

	return
end

function IslandView:OnEndDoCoupleAction()
	self:GetSubView(IslandCancelAnimationOpView):HideCancelableAnimationOp(self.player)

	return
end

function IslandView:OnResponAniamtionOp(arg_52_1)
	local var_52_0 = self:GetPlayerUnitModule(arg_52_1.id)

	if not var_52_0 then
		return
	end

	if arg_52_1.actionId == 0 then
		if not self:IsPlayer(arg_52_1.id) then
			self:GetSubView(IslandTopHeadHudView):HideAnimationOp(var_52_0)
		else
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildActionOp(2, arg_52_1.actionId, 1, 0, 0, 0))
		end

		return
	end

	local var_52_1 = pg.island_action[arg_52_1.actionId]

	if arg_52_1.targetId == 0 and var_52_1.type == IslandConst.ANIMATION_OP_DOUBLE and not self:IsPlayer(arg_52_1.id) then
		self:GetSubView(IslandTopHeadHudView):ShowAnimationOp(var_52_0, arg_52_1.actionId)
	elseif arg_52_1.targetId > 0 and var_52_1.type == IslandConst.ANIMATION_OP_DOUBLE and not self:IsPlayer(arg_52_1.targetId) then
		local var_52_2 = self:GetPlayerUnitModule(arg_52_1.targetId)

		self.coupleActionPlayer:Play(var_52_0, var_52_2, var_52_1)
		self:GetSubView(IslandTopHeadHudView):HideAnimationOp(var_52_2)
	elseif arg_52_1.targetId > 0 and var_52_1.type == IslandConst.ANIMATION_OP_DOUBLE and self:IsPlayer(arg_52_1.targetId) then
		self.coupleActionPlayer:Play(var_52_0, self:GetPlayerUnitModule(arg_52_1.targetId), var_52_1)
		self:GetSubView(IslandAniamtionOpView):RemoveWaitTimer(false)
		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildActionOp(2, arg_52_1.actionId, 1, arg_52_1.targetId, 0, 1))
	end

	return
end

function IslandView:OnShowChatMsg(arg_53_1)
	local var_53_0 = self:GetPlayerUnitModule(arg_53_1.player.id)

	if not var_53_0 then
		return
	end

	self:GetSubView(IslandTopHeadHudView):PlayChat(var_53_0, arg_53_1.emojiId, arg_53_1.content, nil)

	return
end

function IslandView:OnChatRoomChange()
	self:GetSubView(IslandAniamtionOpView):UpdateChatRoom()

	return
end

function IslandView:OnChatMsgUpdate()
	self:GetSubView(IslandAniamtionOpView):UpdateMsgList()

	return
end

function IslandView:OnFollowerAdd(arg_56_1)
	self:GetSubView(IslandOpView):FlushFollowerList()
	self.coupleNpcWordPlayer:Play(arg_56_1)

	return
end

function IslandView:OnFollowerDel(arg_57_1)
	self:GetSubView(IslandOpView):FlushFollowerList()
	self.coupleNpcWordPlayer:Stop(arg_57_1)

	return
end

function IslandView:OnResetFollowRandomizer(arg_58_1)
	local var_58_0 = self:GetFollowerModule(arg_58_1)

	if not var_58_0 then
		return
	end

	var_58_0:SetBtRandomizer()

	return
end

function IslandView:OnGenPathFinder(arg_59_1)
	local var_59_0 = IslandPathFinder.New(self)
	local var_59_1 = defaultValue(arg_59_1.navData.waitUntilDone, false)

	var_59_0:Start(arg_59_1.navData, function()
		table.removebyvalue(self.pathfinders, var_59_0)
		var_59_0:Dispose()

		if arg_59_1.onEndAction then
			arg_59_1.onEndAction()
		end

		self:NotifiyIsland(ISLAND_EX_EVT.NAV_PATH_DONE, arg_59_1.navData.index)

		if var_59_1 and arg_59_1.callback then
			arg_59_1.callback()
		end

		return
	end)
	self:NotifiyIsland(ISLAND_EX_EVT.NAV_PATH, arg_59_1.navData.index)

	if not var_59_1 and arg_59_1.callback then
		arg_59_1.callback()
	end

	table.insert(self.pathfinders, var_59_0)

	return
end

function IslandView:OnRemovePathFinder(arg_61_1)
	local var_61_0 = self:GetUnitModuleWithType(arg_61_1.unitType, arg_61_1.unitId)
	local var_61_1 = _.detect(self.pathfinders, function(arg_62_0)
		return arg_62_0:IsSameUnit(var_61_0)
	end)

	if not var_61_1 then
		return
	end

	var_61_1:Stop()
	var_61_1:Dispose()
	table.removebyvalue(self.pathfinders, var_61_1)

	return
end

function IslandView:OnTracking(arg_63_1)
	if arg_63_1.trackType == IslandTaskTrackCard.TYPES.MAIN then
		self.mainTrackId = tonumber(arg_63_1.id)
		self.needTryMainTrack = true
	elseif arg_63_1.trackType == IslandTaskTrackCard.TYPES.OTHER then
		self.trackId = tonumber(arg_63_1.id)
		self.trackType = arg_63_1.typ or IslandTaskType.MAIN
		self.needTryTrack = true
	end

	return
end

function IslandView:TryTrack()
	self:TrySetTrack(self.trackId)

	return
end

function IslandView:TrySetTrack(arg_65_1)
	local var_65_0 = self:GetOptTrackingTarget(arg_65_1)

	if not var_65_0 or not var_65_0._go then
		return
	end

	self:GetSubView(IslandDistanceView):SetTrackingTarget(self.player, var_65_0, arg_65_1, self.trackType, IslandTaskTrackCard.TYPES.OTHER)

	self.needTryTrack = false

	return
end

function IslandView:TryMainTrack()
	self:TrySetMainTrack(self.mainTrackId)

	return
end

function IslandView:TrySetMainTrack(arg_67_1)
	local var_67_0 = self:GetOptTrackingTarget(arg_67_1)

	if not var_67_0 or not var_67_0._go then
		return
	end

	self:GetSubView(IslandDistanceView):SetTrackingTarget(self.player, var_67_0, arg_67_1, IslandTaskType.MAIN, IslandTaskTrackCard.TYPES.MAIN)

	self.needTryMainTrack = false

	return
end

function IslandView:OnUnTracking(arg_68_1)
	if arg_68_1 == IslandTaskTrackCard.TYPES.MAIN then
		self.mainTrackId = nil
	elseif arg_68_1 == IslandTaskTrackCard.TYPES.OTHER then
		self.trackId = nil
	end

	self:GetSubView(IslandDistanceView):CancelTracking(arg_68_1)

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
	local var_71_0 = {}
	local var_71_1 = {}

	for iter_71_0, iter_71_1 in ipairs(arg_71_0) do
		for iter_71_2, iter_71_3 in ipairs(iter_71_1[2]) do
			if pg.island_interaction[iter_71_3].type == IslandInteractionUntil.TYPE_TRANSFER then
				table.insert(var_71_0, iter_71_1[1])
			elseif pg.island_interaction[iter_71_3].type == IslandInteractionUntil.TYPE_SP_TRANSFER then
				table.insert(var_71_1, iter_71_1[1])
			end
		end
	end

	if #var_71_1 > 0 then
		return var_71_1[1]
	end

	if #var_71_0 > 0 then
		return var_71_0[1]
	end

	return nil
end

function IslandView:GetOptTrackingTarget(arg_72_1)
	local var_72_0 = self:GetUnitModule(arg_72_1)

	if var_72_0 then
		return var_72_0
	end

	local var_72_1 = pg.island_world_objects[arg_72_1]

	if not pg.island_world_objects[arg_72_1] then
		return nil
	end

	local var_72_2 = {}

	for iter_72_0, iter_72_1 in ipairs(self:GetUnitListByKey(IslandConst.UNIT_LIST_OBJ)) do
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

function IslandView:OnOpenAniamtionOpPage()
	self:GetSubView(IslandAniamtionOpView):TryEnable()
	self:GetSubView(IslandOpView):TryDisable()
	self:NotifiyIsland(ISLAND_EX_EVT.OPEN_ANIMATION_OP)

	return
end

function IslandView:OnCloseAniamtionOpPage()
	self:GetSubView(IslandOpView):TryEnable()
	self:NotifiyIsland(ISLAND_EX_EVT.CLOSE_ANIMATION_OP)

	return
end

function IslandView:OnAnyPageOpen(arg_75_1)
	self.anyPageOpen = true

	self.player:StopMoveHandle()
	self:GetSubView(IslandTopHeadHudView):TryDisable()
	self:GetSubView(IslandSlotHudView):TryDisable()
	self:GetSubView(IslandBottomHeadHudView):TryDisable()
	self:GetSubView(IslandOpView):TryDisablePlayerOp()
	self:GetSubView(IslandAniamtionOpView):CloseAndReset()

	return
end

function IslandView:OnAllPageClose()
	self.anyPageOpen = false

	self:GetSubView(IslandTopHeadHudView):TryEnable()
	self:GetSubView(IslandSlotHudView):TryEnable()
	self:GetSubView(IslandBottomHeadHudView):TryEnable()
	self:GetSubView(IslandOpView):TryEnablePlayerOp()

	return
end

function IslandView:OnStartStory()
	self.playingStory = true

	self:DisablePlayerOp()

	return
end

function IslandView:OnEndStory()
	self.playingStory = false

	self:EnablePlayerOp()

	return
end

function IslandView:OnStartPerformance()
	return
end

function IslandView:OnEndPerformance()
	if not self.anyPageOpen then
		self:GetSubView(IslandOpView):ResetShowBalance()
	end

	return
end

function IslandView:OnStartGuide()
	self.player:StopMoveHandle()
	self:GetSubView(IslandOpView):DisableInput()

	return
end

function IslandView:OnEndGuide()
	if self.playingStory then
		return
	end

	self:GetSubView(IslandOpView):EnableInput()

	return
end

function IslandView:InitFocusCamera()
	local var_83_0 = IslandCameraMgr.instance:GetVirtualCamera(IslandConst.FOCUS_CAMERA_NAME)

	var_83_0.Follow = self.player._tf
	var_83_0.LookAt = self.player._tf

	return
end

function IslandView:InitTakePhotoCamera()
	IslandCameraMgr.instance:GetVirtualCamera(IslandConst.FIRST_PERSON_TAKE_PHOTO_CAMERA_NAME).Follow = self.firstTakePhotoItem._tf

	local var_84_0 = IslandCameraMgr.instance:GetVirtualCamera(IslandConst.Third_PERSON_TAKE_PHOTO_CAMERA_NAME)

	var_84_0.Follow = self.thirdTakePhotoItem._tf
	var_84_0.LookAt = self.thirdTakePhotoItem._tf

	return
end

function IslandView:DisablePlayerOp()
	self.player:StopMoveHandle()
	self:GetSubView(IslandTopHeadHudView):TryDisable()
	self:GetSubView(IslandBottomHeadHudView):TryDisable()
	self:GetSubView(IslandOpView):TryDisablePlayerOp()
	self:GetSubView(IslandOpView):TryDisable()

	return
end

function IslandView:EnablePlayerOp()
	self:GetSubView(IslandOpView):TryEnablePlayerOp()
	self:GetSubView(IslandTopHeadHudView):TryEnable()
	self:GetSubView(IslandBottomHeadHudView):TryEnable()
	self:GetSubView(IslandOpView):TryEnable()

	return
end

function IslandView:OnInterActionBegin()
	self.player:StopMoveHandle()
	self:GetSubView(IslandOpView):TryDisablePlayerOp()

	return
end

function IslandView:OnInterActionEnd()
	self:GetSubView(IslandOpView):TryEnablePlayerOp()

	return
end

function IslandView:OnShowInterActionPanel(arg_89_1)
	self.showInterObjId = arg_89_1.id

	self:GetSubView(IslandInteractionView):ShowInterActionPanel(arg_89_1)
	self:Op("NotifiyIsland", ISLAND_EX_EVT.SHOW_INTERACTION, self.showInterObjId)

	return
end

function IslandView:OnHideInterActionPanel(arg_90_1)
	if self.showInterObjId ~= arg_90_1.id then
		return
	end

	self.showInterObjId = nil

	self:GetSubView(IslandInteractionView):HideInterActionPanel()

	return
end

function IslandView:OnRefreshInteractionBtn()
	self:GetSubView(IslandInteractionView):RefreshInteractionBtns()

	return
end

function IslandView:OnSetOpMoveBtnActve(arg_92_1, arg_92_2)
	self:GetSubView(IslandOpView):ShowOrHideMoveBtn(arg_92_1, arg_92_2)

	return
end

function IslandView:DisableInput()
	self.player:StopMoveHandle()
	self:GetSubView(IslandOpView):DisableInput()

	return
end

function IslandView:EnableInput()
	self:GetSubView(IslandOpView):EnableInput()

	return
end

function IslandView:OnUpdateCustomOpPositon()
	self:GetSubView(IslandOpView):InitOpCustumPositon()

	return
end

function IslandView:OnChange_Photo_Height(arg_96_1, arg_96_2)
	self.takePhotoModel = arg_96_1

	if self.takePhotoModel == IslandConst.TakePhotoModel.First then
		-- block empty
	elseif self.takePhotoModel == IslandConst.TakePhotoModel.Third then
		self.thirdTakePhotoItem:ChangeHeight(arg_96_2)
	end

	return
end

function IslandView:OnChangeTakePhotoModel(arg_97_1, arg_97_2)
	self.takePhotoModel = arg_97_1

	if self.takePhotoModel == IslandConst.TakePhotoModel.First then
		self.firstTakePhotoItem:Enable()

		self.firstTakePhotoItem._tf.position = self.player._tf.position
		self.firstTakePhotoItem._tf.rotation = self.player._tf.rotation

		self.firstTakePhotoItem:SetTargetRotation(self.player._tf.rotation)
		self.player:SetActiveByLayer(false)
		IslandCameraMgr.instance:ActiveVirtualCamera(IslandConst.FIRST_PERSON_TAKE_PHOTO_CAMERA_NAME)
		IslandCameraMgr.instance:GetVirtualCamera(IslandConst.FIRST_PERSON_TAKE_PHOTO_CAMERA_NAME).gameObject:GetComponent(typeof(CameraPovLook)):SetPosAndRotationByTargetDir(self.player._tf.forward)
	elseif self.takePhotoModel == IslandConst.TakePhotoModel.Third then
		self.thirdTakePhotoItem:Enable()

		self.player._tf.position = self.firstTakePhotoItem._tf.position
		self.player._tf.rotation = self.firstTakePhotoItem._tf.rotation

		self.player:SetTargetRotation(self.firstTakePhotoItem._tf.rotation)
		self.player:SetActiveByLayer(true)

		self.thirdTakePhotoItem._tf.position = self.firstTakePhotoItem._tf:TransformPoint(Vector3(0, 0, -5))
		self.thirdTakePhotoItem._tf.rotation = self.firstTakePhotoItem._tf.rotation

		self.thirdTakePhotoItem:SetTargetRotation(self.firstTakePhotoItem._tf.rotation)
		IslandCameraMgr.instance:GetVirtualCamera(IslandConst.Third_PERSON_TAKE_PHOTO_CAMERA_NAME).gameObject:GetComponent(typeof(CameraPovLook)):SetPosAndRotationByTargetDir((self.player._tf.position + Vector3(0, 0.5, 0) - (self.thirdTakePhotoItem._tf.position + Vector3(0, 1, 0))).normalized)
		IslandCameraMgr.instance:ActiveVirtualCamera(IslandConst.Third_PERSON_TAKE_PHOTO_CAMERA_NAME)
	else
		self.firstTakePhotoItem:Disable()
		self.thirdTakePhotoItem:Disable()

		self.player._tf.position = self.firstTakePhotoItem._tf.position
		self.player._tf.rotation = self.firstTakePhotoItem._tf.rotation

		self.player:SetTargetRotation(self.firstTakePhotoItem._tf.rotation)
		self.player:SetActiveByLayer(true)
		IslandCameraMgr.instance:ActiveVirtualCamera(IslandConst.FOLLOW_CAMERA_NAME)
		IslandCameraMgr.instance:GetVirtualCamera(IslandConst.FOLLOW_CAMERA_NAME).gameObject:GetComponent(typeof(CameraLook)):ResetCameraPos()
	end

	self:GetSubView(IslandOpView):ChangeTakePhotoModel(arg_97_1, arg_97_2)

	return
end

function IslandView:OnNpcDetectorSelected(arg_98_1)
	if self.selectedNpcId then
		return
	end

	local var_98_0 = arg_98_1.node

	if not arg_98_1.node then
		return
	end

	local var_98_1 = var_98_0:GetComponent(typeof(WorldObjectItem)).uniqueId

	self.selectedNpcId = var_98_1

	self:GetSubView(IslandOpView):UpdateAnimationOpEffect(var_98_1, true)
	self:GetSubView(IslandBottomHeadHudView):UpdateAnimationOpEffect(var_98_1, true)
	self:GetSubView(IslandAniamtionOpView):SortForNpcAction(var_98_1)

	return
end

function IslandView:GetSelectedNpcId()
	return self.selectedNpcId
end

function IslandView:OnNpcDetectorUnSelected(arg_100_1)
	if not arg_100_1.node then
		return
	end

	local var_100_0 = arg_100_1.node:GetComponent(typeof(WorldObjectItem)).uniqueId

	self:GetSubView(IslandOpView):UpdateAnimationOpEffect(var_100_0)
	self:GetSubView(IslandBottomHeadHudView):UpdateAnimationOpEffect(var_100_0)
	self:GetSubView(IslandAniamtionOpView):SortForNpcAction(nil)

	if self.selectedNpcId ~= var_100_0 then
		return
	end

	self.selectedNpcId = nil

	return
end

function IslandView:OnDetectorChanged(arg_101_1)
	if not arg_101_1.node then
		return
	end

	local var_101_0 = arg_101_1.node:GetBlackboardVariable("DetectorList")

	for iter_101_0 = 1, var_101_0.Count do
		local var_101_1, var_101_2 = IslandCalcUtil.GetTypeAndIdByUniqueId(var_101_0[iter_101_0 - 1])

		if var_101_1 == IslandConst.UNIT_LIST_OBJ then
			local var_101_3 = self:GetUnitModuleWithType(var_101_1, var_101_2)

			if var_101_3 then
				self:Op("NotifiyIsland", ISLAND_EX_EVT.APPROACH_OBJECT, var_101_3.id)
			end
		end
	end

	return
end

function IslandView:OnDetectorSelected(arg_102_1)
	if not arg_102_1.node then
		return
	end

	local var_102_0 = arg_102_1.node:GetBlackboardVariable("AnyOne")

	if not var_102_0 or var_102_0 == "" then
		self:OnClearSelectedUnit()
	else
		local var_102_1, var_102_2 = IslandCalcUtil.GetTypeAndIdByUniqueId(var_102_0)
		local var_102_3 = self:GetUnitModuleWithType(var_102_1, var_102_2)

		if var_102_3 then
			self:OnSelectedUnit(var_102_3)
		end
	end

	return
end

function IslandView:OnClearSelectedUnit()
	return
end

function IslandView:OnSelectedUnit(arg_104_1)
	return
end

function IslandView:OnPlayChatBubble(arg_105_1)
	self:GetSubView(IslandTopHeadHudView):PlayBubble(arg_105_1.name, self:GetAllUnits(), arg_105_1.callback)

	return
end

function IslandView:OnRawPlayChatBubble(arg_106_1)
	self:GetSubView(IslandTopHeadHudView):RawPlayBubble(arg_106_1.info, self:GetAllUnits(), arg_106_1.callback)

	return
end

function IslandView:OnRawStopChatBubble(arg_107_1)
	self:GetSubView(IslandTopHeadHudView):RawStopBubble(arg_107_1.info)

	return
end

function IslandView:OnChangeVisterDress(arg_108_1)
	if self:IsPlayer(arg_108_1.id) then
		return
	end

	local var_108_0 = self:GetPlayerUnitModule(arg_108_1.id)

	if var_108_0 then
		var_108_0:OnChangeDress(arg_108_1.changeDressData)
	end

	return
end

function IslandView:OnSystemUnlock(arg_109_1)
	if arg_109_1 == IslandAblityAgency.ANIMATION_OP_ID then
		self:GetSubView(IslandOpView):UpdateAnimationOpBtn()
	end

	return
end

function IslandView:OnSceneInited(arg_110_1)
	IslandCameraMgr.instance:LookAt(self.player._tf)
	IslandCameraMgr.instance:GetVirtualCamera(IslandConst.FOLLOW_CAMERA_NAME).gameObject:GetComponent(typeof(CameraZoom)):SetMaxMinZoom(arg_110_1.min, arg_110_1.max, arg_110_1.value)
	self:InitFocusCamera()
	self:InitTakePhotoCamera()
	self:GetSubView(IslandOpView):LaterInit()

	return
end

function IslandView:OnGenUnit(arg_111_1, arg_111_2)
	local var_111_0 = self.unitBuilders[arg_111_1:GetType()]:Build(arg_111_1, arg_111_2)

	self:AddUnit(var_111_0)

	if arg_111_1:IsPlayer() then
		self.player = var_111_0
	end

	if arg_111_1:IsFirstTakePhoto() then
		self.firstTakePhotoItem = var_111_0
	end

	if arg_111_1:IsThirdTakePhoto() then
		self.thirdTakePhotoItem = var_111_0
	end

	return
end

function IslandView:OnGenSystem(arg_112_1)
	self:AddUnit((self.systemBuilders[arg_112_1:GetType()]:Build(arg_112_1)))

	return
end

function IslandView:IsPlayer(arg_113_1)
	return self.player.id == arg_113_1
end

function IslandView:OnActiveOrDisactiveUnit(arg_114_1, arg_114_2, arg_114_3)
	local var_114_0 = arg_114_1 == 0 and self.player or self:GetUnitModuleWithType(arg_114_2, arg_114_1)

	if var_114_0 and arg_114_3 then
		var_114_0:Enable()
	end

	if var_114_0 and not arg_114_3 then
		var_114_0:Disable()
	end

	return
end

function IslandView:OnResetUnitPos(arg_115_1, arg_115_2, arg_115_3)
	local var_115_0 = self:GetUnitModuleWithType(arg_115_2, arg_115_1)

	if var_115_0 then
		var_115_0._go.transform.position = arg_115_3
	end

	return
end

function IslandView:OnResetUnitRotation(arg_116_1, arg_116_2, arg_116_3)
	local var_116_0 = self:GetUnitModuleWithType(arg_116_2, arg_116_1)

	if var_116_0 then
		var_116_0._go.transform.eulerAngles = arg_116_3
	end

	return
end

function IslandView:OnMoveUnit(arg_117_1)
	assert(arg_117_1.type, "type should be exist")

	local var_117_0 = self:GetUnitModuleWithType(arg_117_1.type, arg_117_1.id)

	if var_117_0 then
		var_117_0:SetDestination(arg_117_1.position, arg_117_1.speed, nil, arg_117_1.charaRadius)
	end

	return
end

function IslandView:OnStopUnit(arg_118_1)
	assert(arg_118_1.type, "type should be exist")

	local var_118_0 = self:GetUnitModuleWithType(arg_118_1.type, arg_118_1.id)

	if var_118_0 then
		var_118_0:StopMove()
	end

	return
end

function IslandView:OnRemoveUnit(arg_119_1, arg_119_2)
	local var_119_0 = self:GetUnitListByKey(arg_119_1)
	local var_119_1 = 0

	for iter_119_0, iter_119_1 in ipairs(var_119_0 or {}) do
		if iter_119_1.id == arg_119_2 then
			var_119_1 = iter_119_0

			break
		end
	end

	if var_119_1 > 0 then
		for iter_119_2 = #self.pathfinders, 1, -1 do
			if self.pathfinders[iter_119_2]:IsSameUnit(var_119_0[var_119_1]) then
				self.pathfinders[iter_119_2]:Dispose()
				table.remove(self.pathfinders, iter_119_2)
			end
		end

		self:RemoveUnit(var_119_0[var_119_1])
		var_119_0[var_119_1]:Dispose()
		self:OnHideUnitHudAndOpBtn({
			type = arg_119_1,
			id = var_119_0[var_119_1].id
		}, true)
		self:GetSubView(IslandTopHeadHudView):HideHud({
			type = arg_119_1,
			id = arg_119_2
		})
		self:GetSubView(IslandBottomHeadHudView):HideAnimationOp(var_119_0[var_119_1])
		self:GetSubView(IslandInteractionView):CloseInterActionPanelByUnitIdRemove(arg_119_2)
	end

	return
end

function IslandView:GetAllUnits()
	table.clear(self._unitList)

	for iter_120_0, iter_120_1 in pairs(self:GetUnitListRegitser()) do
		for iter_120_2, iter_120_3 in pairs(iter_120_1) do
			table.insert(self._unitList, iter_120_3)
		end
	end

	return self._unitList
end

function IslandView:GetUnitModuleWithType(arg_121_1, arg_121_2)
	if arg_121_1 == IslandConst.UNIT_LIST_PLAYER and arg_121_2 == 0 then
		return self.player
	end

	for iter_121_0, iter_121_1 in ipairs((self:GetUnitListByKey(arg_121_1))) do
		if iter_121_1.id == arg_121_2 then
			return iter_121_1
		end
	end

	return nil
end

function IslandView:GetPlayerUnitModule(arg_122_1)
	return self:GetUnitModuleWithType(IslandConst.UNIT_LIST_PLAYER, arg_122_1)
end

function IslandView:GetUnitModule(arg_123_1)
	return self:GetUnitModuleWithType(IslandConst.UNIT_LIST_OBJ, arg_123_1)
end

function IslandView:GetSystemModule(arg_124_1)
	return self:GetUnitModuleWithType(IslandConst.UNIT_LIST_SYSTEM, arg_124_1)
end

function IslandView:GetProductSystemModule(arg_125_1)
	return self:GetUnitModuleWithType(IslandConst.UNIT_LIST_PRODUCT_SYSTEM, arg_125_1)
end

function IslandView:GetSystemUnitModule(arg_126_1)
	return self:GetUnitModuleWithType(IslandConst.UNIT_LIST_DELEGATION, arg_126_1)
end

function IslandView:GetStrollUnitModule(arg_127_1)
	return self:GetUnitModuleWithType(IslandConst.UNIT_LIST_STROLL, arg_127_1)
end

function IslandView:GetManageSystemModule(arg_128_1)
	return self:GetUnitModuleWithType(IslandConst.UNIT_LIST_MANAGE_SYSTEM, arg_128_1)
end

function IslandView:GetFollowerModule(arg_129_1)
	return self:GetUnitModuleWithType(IslandConst.UNIT_LIST_FOLLOW, arg_129_1)
end

function IslandView:OnMovePlayerBefore()
	if self.player:CheckMovement() and self.isLockPlayInput then
		self.isLockPlayInput = false
	end

	self:GetSubView(IslandAniamtionOpView):OnMovePlayerBefore()

	return
end

function IslandView:OnLockPlayerInput()
	if self.playerInputing then
		self.isLockPlayInput = true

		self.player:StopMoveHandle()
	end

	return
end

function IslandView:OnPlayerMove(arg_132_1)
	if self.isLockPlayInput then
		return
	end

	self.playerInputing = true

	if self.takePhotoModel == IslandConst.TakePhotoModel.First then
		self.firstTakePhotoItem:MoveHandle(arg_132_1.targetDir, arg_132_1.force)
	elseif self.takePhotoModel == IslandConst.TakePhotoModel.Third then
		self.thirdTakePhotoItem:MoveHandle(arg_132_1.targetDir, arg_132_1.force)
	else
		self.player:MoveHandle(arg_132_1.targetDir, arg_132_1.force)
	end

	return
end

function IslandView:OnPlayerStopMove()
	if self.isLockPlayInput then
		self.isLockPlayInput = false
	end

	self.playerInputing = true

	if self.takePhotoModel == IslandConst.TakePhotoModel.First then
		self.firstTakePhotoItem:StopMoveHandle()
	elseif self.takePhotoModel == IslandConst.TakePhotoModel.Third then
		self.thirdTakePhotoItem:StopMoveHandle()
	else
		self.player:StopMoveHandle()
	end

	return
end

function IslandView:OnPlayerStopMoveHandle()
	if self.isLockPlayInput then
		self.isLockPlayInput = false
	end

	self.playerInputing = true

	if self.takePhotoModel == IslandConst.TakePhotoModel.First then
		self.firstTakePhotoItem:StopMoveHandle()
	elseif self.takePhotoModel == IslandConst.TakePhotoModel.Third then
		self.thirdTakePhotoItem:StopMoveHandle()
	else
		self.player:StopMoveHandleByInput()
	end

	return
end

function IslandView:OnPlayerJump()
	if self.takePhotoModel == IslandConst.TakePhotoModel.First or self.takePhotoModel == IslandConst.TakePhotoModel.Third then
		return
	end

	self.player:JumpHandle()

	return
end

function IslandView:OnPlayerPlayerRun()
	self.player:PlayerRunHandle()

	return
end

function IslandView:OnPlayerPlayerSprint()
	if self.takePhotoModel == IslandConst.TakePhotoModel.First then
		self.firstTakePhotoItem:OnPlayerPlayerSprint()
	elseif self.takePhotoModel == IslandConst.TakePhotoModel.Third then
		-- block empty
	else
		self.player:OnPlayerPlayerSprint()
	end

	return
end

function IslandView:OnStopPlayerSprint()
	if self.takePhotoModel == IslandConst.TakePhotoModel.First then
		self.firstTakePhotoItem:OnStopPlayerSprint()
	elseif self.takePhotoModel == IslandConst.TakePhotoModel.Third then
		self.thirdTakePhotoItem:OnStopPlayerSprint()
	else
		self.player:OnStopPlayerSprint()
	end

	return
end

function IslandView:OnPlayerWork(arg_139_1, arg_139_2)
	self.player:WorkHandle(arg_139_1, arg_139_2)

	return
end

function IslandView:OnPlayerDeviceStateChange(arg_140_1)
	self.player:DeviceStateHandle(arg_140_1)

	return
end

function IslandView:OnSetVisitorSyncData(arg_141_1, arg_141_2)
	local var_141_0 = self:GetPlayerUnitModule(arg_141_1)

	if var_141_0 then
		var_141_0:UpdateSyncData(arg_141_2)
	end

	return
end

function IslandView:OnWorldObjectStartInteraction(arg_142_1, arg_142_2, arg_142_3)
	local var_142_0 = self:GetUnitModule((arg_142_2:GetHostId()))
	local var_142_1 = self:GetPlayerUnitModule((arg_142_2:GetUserId()))
	local var_142_2 = self.player == var_142_1

	if self.player == var_142_1 then
		self:GetSubView(IslandOpView):StartInteraction()
	end

	var_142_0:StartInteract(var_142_1, arg_142_2.id, arg_142_3, arg_142_1:GetTimeline()[arg_142_3], arg_142_1:GetBlackboardParam()[arg_142_3], arg_142_1:AnySlotUsing(), var_142_2)

	return
end

function IslandView:OnWorldObjectEndInteraction(arg_143_1, arg_143_2)
	local var_143_0 = self:GetUnitModule((arg_143_2:GetHostId()))
	local var_143_1 = self:GetPlayerUnitModule((arg_143_2:GetUserId()))
	local var_143_2 = self.player == var_143_1

	if self.player == var_143_1 then
		self:GetSubView(IslandOpView):EndInteraction()
	end

	var_143_0:EndInteract(var_143_1, arg_143_2.id, not arg_143_1:AnySlotUsing(), var_143_2)

	return
end

function IslandView:OnWorldObjectInitStatus(arg_144_1, arg_144_2)
	self:GetUnitModule(arg_144_1.id):InitStatus(arg_144_2, arg_144_1:GetTimeline()[arg_144_2], arg_144_1:GetBlackboardParam()[arg_144_2])

	return
end

function IslandView:InitInteractionOpView()
	self:GetSubView(IslandOpView):EndInteraction()

	return
end

function IslandView:OnPlayerAreaChange()
	self.detectionSystem:SetAreaDetection()

	return
end

function IslandView:OnChangeDress(arg_147_1, arg_147_2)
	self.player:OnChangeDress(arg_147_1, arg_147_2)

	return
end

function IslandView:OnCharacterChangeDress(arg_148_1, arg_148_2, arg_148_3, arg_148_4)
	local var_148_0 = self:GetUnitModuleWithType(IslandConst.UNIT_LIST_DELEGATION, arg_148_1)

	if var_148_0 then
		var_148_0:OnCharacterChangeDress(arg_148_2, arg_148_3, arg_148_4)
	end

	for iter_148_0, iter_148_1 in ipairs((self:GetUnitListByKey(IslandConst.UNIT_LIST_FOLLOW))) do
		if iter_148_1:GetDataVO():IsSameShip(arg_148_1) then
			iter_148_1:OnCharacterChangeDress(arg_148_2, arg_148_3, arg_148_4)
		end
	end

	for iter_148_2, iter_148_3 in ipairs((self:GetUnitListByKey(IslandConst.UNIT_LIST_STROLL))) do
		if iter_148_3:GetDataVO():IsSameShip(arg_148_1) then
			iter_148_3:OnCharacterChangeDress(arg_148_2, arg_148_3, arg_148_4)
		end
	end

	return
end

function IslandView:OnMorphFormChange(arg_149_1, arg_149_2, arg_149_3, arg_149_4, arg_149_5)
	local var_149_0 = self:GetPlayerUnitModule(self.player.id)

	if not var_149_0 then
		existCall(arg_149_5)

		return
	end

	local var_149_1 = var_149_0.shipDressHelper

	if not var_149_0.shipDressHelper then
		existCall(arg_149_5)

		return
	end

	var_149_0:PlayAnimation(arg_149_4, 0.25, function()
		var_149_1:ChangeDressByType(IslandShipDressHelperNew.DressType.Body, {
			colorId = 0,
			id = arg_149_2
		})
		var_149_1:ChangeDressByType(IslandShipDressHelperNew.DressType.Hat, {
			colorId = 0,
			id = arg_149_3
		})
		existCall(arg_149_5)

		return
	end)

	return
end

function IslandView:OnStartDelegation(arg_151_1, arg_151_2)
	local var_151_0 = self:GetSystemModule(arg_151_1.build_id)

	if var_151_0 then
		var_151_0:StartDelegation(arg_151_1)
	end

	local var_151_1 = self:GetProductSystemModule(arg_151_1.build_id)

	if var_151_1 then
		var_151_1:StartDelegation(arg_151_2)
	end

	return
end

function IslandView:OnEndDelegation(arg_152_1, arg_152_2)
	local var_152_0 = self:GetSystemModule(arg_152_1.build_id)

	if var_152_0 then
		var_152_0:EndDelegation(arg_152_1)
	end

	return
end

function IslandView:GetPlayerPosition()
	return self.player:GetCurrentPosition()
end

function IslandView:GetPlayerLastGroundedPosition()
	return self.player:LastGroundedPosition()
end

function IslandView:GetUnitPosition(arg_155_1)
	local var_155_0 = self:GetUnitModule(arg_155_1)

	return var_155_0 and var_155_0._go.transform.position
end

function IslandView:OnShowUnitHudAndOpBtn(arg_156_1)
	self.currentHudUnitData = arg_156_1

	self:GetSubView(IslandSlotHudView):ShowHud(arg_156_1.id, arg_156_1.height)
	self:GetSubView(IslandOpView):UpdateOperationButton(arg_156_1.operationType, arg_156_1.id)

	if arg_156_1.isHighLightControl then
		self.detectionSystem:HighLightUnitHandle(arg_156_1.id, true)
	end

	return
end

function IslandView:OnHideUnitHudAndOpBtn(arg_157_1, arg_157_2)
	if not self.currentHudUnitData then
		return
	end

	if self.currentHudUnitData.id ~= arg_157_1.id or self.currentHudUnitData.type ~= arg_157_1.type then
		return
	end

	if not arg_157_2 then
		self.currentHudUnitData = nil
	end

	self:GetSubView(IslandSlotHudView):HideUnitHud(arg_157_1.id)
	self:GetSubView(IslandOpView):UpdateOperationButton(IslandOpView.OperationType.None, arg_157_1.id)

	if arg_157_1.isHighLightControl then
		self.detectionSystem:HighLightUnitHandle(arg_157_1.id, false)
	end

	return
end

function IslandView:OnUpdateHud(arg_158_1)
	if not self.currentHudUnitData then
		return
	end

	if arg_158_1 ~= self.currentHudUnitData.id then
		return
	end

	self:GetSubView(IslandSlotHudView):UpdateHud(self.currentHudUnitData.id, self.currentHudUnitData.height)
	self:GetSubView(IslandOpView):UpdateOperationButton(self.currentHudUnitData.operationType, self.currentHudUnitData.id)

	return
end

function IslandView:OnUpdateHandCollectUnit(arg_159_1)
	local var_159_0 = self:GetUnitModuleWithType(IslandConst.UNIT_LIST_OBJ, arg_159_1)

	if var_159_0 then
		var_159_0:UpdateHandCollet()
		var_159_0:ResetHp()
	end

	return
end

function IslandView:OnShowHud(arg_160_1)
	self:GetSubView(IslandTopHeadHudView):ShowHud(arg_160_1)
	self:GetSubView(IslandDistanceView):ShowHud(arg_160_1.id)

	return
end

function IslandView:OnRefreshHud(arg_161_1)
	self:GetSubView(IslandTopHeadHudView):RefreshHud(arg_161_1)

	return
end

function IslandView:OnHideHud(arg_162_1)
	self:GetSubView(IslandTopHeadHudView):HideHud(arg_162_1)
	self:GetSubView(IslandDistanceView):HideHud(arg_162_1.id)

	return
end

function IslandView:OnDelegateSlotStartPerform(arg_163_1)
	local var_163_0 = self:GetUnitModuleWithType(arg_163_1.type, arg_163_1.id)

	if var_163_0 then
		var_163_0:DelegateSlotStartPerform()
	end

	return
end

function IslandView:OnPlayEffect(arg_164_1, arg_164_2, arg_164_3)
	local var_164_0

	for iter_164_0, iter_164_1 in ipairs((self:GetUnitListByKey(IslandConst.UNIT_LIST_STROLL))) do
		if iter_164_1:GetDataVO():IsSameShip(arg_164_1) then
			var_164_0 = iter_164_1

			break
		end
	end

	local var_164_1 = self:GetSubView(IslandEffectView)

	if var_164_1 and var_164_0 then
		var_164_1:Play(var_164_0, arg_164_2, arg_164_3)
	end

	return
end

function IslandView:OnRecycleAllSlotEffct()
	self.effectMgr:RecycleAllSlotEffct()

	return
end

function IslandView:OnLoadDelegatePreviewRole(arg_166_1, arg_166_2)
	self.effectMgr:LoadDelegatePreviewRole(arg_166_1, arg_166_2)

	return
end

function IslandView:OnUnLoadDelegatePreviewRole()
	self.effectMgr:UnLoadDelegatePreviewRole()

	return
end

function IslandView:OnSelectSlotEffectShow(arg_168_1, arg_168_2, arg_168_3, arg_168_4)
	self.effectMgr:SelectSlotEffectShow(arg_168_1, arg_168_2, arg_168_3, arg_168_4)

	return
end

function IslandView:OnTakePlantAttack(arg_169_1)
	local var_169_0 = self:GetUnitModuleWithType(arg_169_1.type, arg_169_1.id)

	if var_169_0 then
		var_169_0:TakeAttack()
	end

	return
end

function IslandView:OnStartManage(arg_170_1)
	local var_170_0 = self:GetManageSystemModule(arg_170_1.id)

	if var_170_0 then
		var_170_0:StartManage(arg_170_1)
	end

	return
end

function IslandView:OnEndManage(arg_171_1)
	local var_171_0 = self:GetManageSystemModule(arg_171_1.id)

	if var_171_0 then
		var_171_0:EndManage(arg_171_1)
	end

	return
end

function IslandView:OnRefreshTaskInfoHud()
	self:GetSubView(IslandTopHeadHudView):UpdateAllHud()

	return
end

function IslandView:OnRefreshWeatherSystem()
	self.weatherSystem:Play()

	return
end

function IslandView:OnDispose()
	self.detectionSystem:Dispose()
	self.effectMgr:Dispose()
	self.coupleActionPlayer:Dispose()
	self.coupleAction4FollowerPlayer:Dispose()
	self.npcActionPlayer:Dispose()
	self.weatherSystem:Dispose()
	self.coupleNpcWordPlayer:Dispose()
	self:GetPoolMgr():ClearFishingEffect()

	for iter_174_0, iter_174_1 in ipairs(self.views) do
		iter_174_1:Dispose()
	end

	for iter_174_2, iter_174_3 in ipairs(self.pathfinders) do
		iter_174_3:Dispose()
	end

	for iter_174_4, iter_174_5 in ipairs(self:GetAllUnits()) do
		iter_174_5:Dispose()
	end

	for iter_174_6, iter_174_7 in pairs(self.unitBuilders) do
		iter_174_7:Dispose()
	end

	for iter_174_8, iter_174_9 in pairs(self.systemBuilders) do
		iter_174_9:Dispose()
	end

	for iter_174_10, iter_174_11 in pairs(self.fishingSynPlayers) do
		iter_174_11:Dispose()
	end

	self.fishingSynPlayers = nil
	self.npcActionPlayer = nil
	self.coupleActionPlayer = nil
	self.coupleAction4FollowerPlayer = nil
	self.pathfinders = nil
	self.unitBuilders = nil
	self.systemBuilders = nil
	self.views = nil
	self.player = nil
	self.isInit = false
	self._unitList = nil
	self.detectionSystem = nil
	self.effectMgr = nil
	self.coupleNpcWordPlayer = nil
	self.weatherSystem = nil

	return
end

return IslandView
