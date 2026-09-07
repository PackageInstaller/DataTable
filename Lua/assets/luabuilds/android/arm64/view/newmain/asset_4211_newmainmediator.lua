local NewMainMediator = class("NewMainMediator", import("..base.ContextMediator"))

NewMainMediator.GO_SCENE = "NewMainMediator.GO_SCENE"
NewMainMediator.OPEN_MAIL = "NewMainMediator.OPEN_MAIL"
NewMainMediator.OPEN_NOTICE = "NewMainMediator.OPEN_NOTICE"
NewMainMediator.GO_SNAPSHOT = "NewMainMediator.GO_SNAPSHOT"
NewMainMediator.OPEN_COMMISION = "NewMainMediator.OPEN_COMMISION"
NewMainMediator.OPEN_CHATVIEW = "NewMainMediator.OPEN_CHATVIEW"
NewMainMediator.SKIP_SCENE = "NewMainMediator.SKIP_SCENE"
NewMainMediator.SKIP_ACTIVITY = "NewMainMediator.SKIP_ACTIVITY"
NewMainMediator.SKIP_CORE_ACTIVITY = "NewMainMediator.SKIP_CORE_ACTIVITY"
NewMainMediator.SKIP_SHOP = "NewMainMediator.SKIP_SHOP"
NewMainMediator.GO_MINI_GAME = "NewMainMediator.GO_MINI_GAME"
NewMainMediator.SKIP_ACTIVITY_MAP = "NewMainMediator.SKIP_ACTIVITY_MAP"
NewMainMediator.SKIP_ESCORT = "NewMainMediator.SKIP_ESCORT"
NewMainMediator.SKIP_INS = "NewMainMediator.SKIP_INS"
NewMainMediator.SKIP_LOTTERY = "NewMainMediator.SKIP_LOTTERY"
NewMainMediator.GO_SINGLE_ACTIVITY = "NewMainMediator.GO_SINGLE_ACTIVITY"
NewMainMediator.REFRESH_VIEW = "NewMainMediator.REFRESH_VIEW"
NewMainMediator.OPEN_KINK_BUTTON_LAYER = "NewMainMediator.OPEN_KINK_BUTTON_LAYER"
NewMainMediator.OPEN_Compensate = "NewMainMediator.OPEN_Compensate"
NewMainMediator.ON_DROP = "NewMainMediator.ON_DROP"
NewMainMediator.ON_AWRADS = "NewMainMediator.ON_AWRADS"
NewMainMediator.CHANGE_SKIN_TOGGLE = "NewMainMediator.CHANGE_SKIN_TOGGLE"
NewMainMediator.FOLD_PANEL = "NewMainMediator.FOLD_PANEL"
NewMainMediator.HIDE_PANEL = "NewMainMediator.HIDE_PANEL"
NewMainMediator.REMOVE_LAYERS = "NewMainMediator.REMOVE_LAYERS"
NewMainMediator.DEBUG_BATTLE_LOOP = "NewMainMediator.DEBUG_BATTLE_LOOP"

function NewMainMediator:register()
	self:bind(NewMainMediator.SKIP_LOTTERY, function(arg_2_0, arg_2_1)
		self:addSubLayers(Context.New({
			viewComponent = LotteryLayer,
			mediator = LotteryMediator,
			data = {
				activityId = arg_2_1
			}
		}))

		return
	end)
	self:bind(NewMainMediator.SKIP_INS, function(arg_3_0)
		self:addSubLayers(Context.New({
			viewComponent = InstagramMainUI,
			mediator = InstagramMainMediator
		}))

		return
	end)
	self:bind(NewMainMediator.SKIP_ESCORT, function(arg_4_0)
		local var_4_0 = getProxy(ChapterProxy)
		local var_4_1 = var_4_0:getMapsByType(Map.ESCORT)[1]
		local var_4_2 = var_4_0:getActiveChapter()
		local var_4_3 = GAME.GO_SCENE
		local var_4_4 = SCENE.LEVEL
		local var_4_5 = {}

		if var_4_2 and var_4_2:getConfig("map") == var_4_1.id then
			var_4_5.chapterId = var_4_2.id or nil
		end

		var_4_5.mapIdx = var_4_1.id

		pg.m02:sendNotification(var_4_3, var_4_4, var_4_5)

		return
	end)
	self:bind(NewMainMediator.SKIP_ACTIVITY_MAP, function(arg_5_0, arg_5_1)
		local var_5_0 = getProxy(ChapterProxy)
		local var_5_1, var_5_2 = var_5_0:getLastMapForActivity(arg_5_1)

		if var_5_1 then
			if not var_5_0:getMapById(var_5_1):isUnlock() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

				goto label_5_0
			end
		end

		self:sendNotification(GAME.GO_SCENE, SCENE.LEVEL, {
			chapterId = var_5_2,
			mapIdx = var_5_1
		})

		::label_5_0::

		return
	end)
	self:bind(NewMainMediator.SKIP_SHOP, function(arg_6_0, arg_6_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.SHOP, {
			warp = arg_6_1 or NewShopsScene.TYPE_ACTIVITY
		})

		return
	end)
	self:bind(NewMainMediator.SKIP_ACTIVITY, function(arg_7_0, arg_7_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY, {
			id = arg_7_1
		})

		return
	end)
	self:bind(NewMainMediator.SKIP_CORE_ACTIVITY, function(arg_8_0, arg_8_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.CORE_ACTIVITY, {
			coreName = arg_8_1
		})

		return
	end)
	self:bind(NewMainMediator.SKIP_SCENE, function(arg_9_0, arg_9_1)
		self:sendNotification(GAME.GO_SCENE, arg_9_1[1], arg_9_1[2])

		return
	end)
	self:bind(NewMainMediator.GO_MINI_GAME, function(arg_10_0, arg_10_1)
		self:sendNotification(GAME.GO_MINI_GAME, arg_10_1)

		return
	end)
	self:bind(NewMainMediator.GO_SCENE, function(arg_11_0, arg_11_1, arg_11_2)
		self:sendNotification(GAME.GO_SCENE, arg_11_1, arg_11_2)

		return
	end)
	self:bind(NewMainMediator.GO_SNAPSHOT, function(arg_12_0)
		local var_12_0 = self.viewComponent.paintingView:IsLive2DState()
		local var_12_1

		if isa(self.viewComponent.bgView.ship, VirtualEducateCharShip) then
			var_12_1 = self.viewComponent.bgView.ship.educateCharId
			var_12_0 = false
		end

		self:sendNotification(GAME.GO_SCENE, SCENE.SNAPSHOT, {
			skinId = self.viewComponent.bgView.ship:getSkinId(),
			live2d = var_12_0,
			tbId = var_12_1,
			propose = self.viewComponent.bgView.ship.propose
		})

		return
	end)
	self:bind(NewMainMediator.OPEN_MAIL, function(arg_13_0)
		if BATTLE_DEBUG then
			self:sendNotification(GAME.BEGIN_STAGE, {
				system = SYSTEM_DEBUG
			})
		else
			self:sendNotification(GAME.GO_SCENE, SCENE.MAIL)
		end

		return
	end)
	self:bind(NewMainMediator.OPEN_Compensate, function(arg_14_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.Compensate)

		return
	end)
	self:bind(NewMainMediator.OPEN_NOTICE, function(arg_15_0)
		self:addSubLayers(Context.New({
			mediator = NewBulletinBoardMediator,
			viewComponent = NewBulletinBoardLayer
		}))

		return
	end)
	self:bind(NewMainMediator.OPEN_COMMISION, function(arg_16_0)
		self:addSubLayers(Context.New({
			viewComponent = CommissionInfoLayer,
			mediator = CommissionInfoMediator
		}))

		return
	end)
	self:bind(NewMainMediator.OPEN_CHATVIEW, function(arg_17_0)
		self:addSubLayers(Context.New({
			viewComponent = NotificationLayer,
			mediator = NotificationMediator,
			data = {
				form = NotificationLayer.FORM_MAIN
			}
		}))

		return
	end)
	self:bind(NewMainMediator.OPEN_KINK_BUTTON_LAYER, function(arg_18_0, arg_18_1)
		self:addSubLayers(arg_18_1)

		return
	end)
	self:bind(NewMainMediator.CHANGE_SKIN_TOGGLE, function(arg_19_0, arg_19_1)
		self:sendNotification(GAME.CHANGE_SKIN_AB, arg_19_1)

		return
	end)
	self:bind(NewMainMediator.DEBUG_BATTLE_LOOP, function(arg_20_0, arg_20_1)
		self:sendNotification(GAME.SEND_CMD, {
			cmd = "into",
			arg1 = arg_20_1
		})

		return
	end)

	return
end

function NewMainMediator:initNotificationHandleDic()
	self.handleDic = {
		[GAME.ON_OPEN_INS_LAYER] = function(arg_22_0, arg_22_1)
			arg_22_0.viewComponent:emit(NewMainMediator.SKIP_INS)

			return
		end,
		[NotificationProxy.FRIEND_REQUEST_ADDED] = function(arg_23_0, arg_23_1)
			arg_23_0.viewComponent:emit(GAME.ANY_CHAT_MSG_UPDATE)

			return
		end,
		[NotificationProxy.FRIEND_REQUEST_REMOVED] = NotificationProxy.FRIEND_REQUEST_ADDED,
		[FriendProxy.FRIEND_NEW_MSG] = NotificationProxy.FRIEND_REQUEST_ADDED,
		[FriendProxy.FRIEND_UPDATED] = NotificationProxy.FRIEND_REQUEST_ADDED,
		[ChatProxy.NEW_MSG] = NotificationProxy.FRIEND_REQUEST_ADDED,
		[GuildProxy.NEW_MSG_ADDED] = NotificationProxy.FRIEND_REQUEST_ADDED,
		[GAME.GET_GUILD_INFO_DONE] = NotificationProxy.FRIEND_REQUEST_ADDED,
		[GAME.GET_GUILD_CHAT_LIST_DONE] = NotificationProxy.FRIEND_REQUEST_ADDED,
		[GAME.BEGIN_STAGE_DONE] = function(arg_24_0, arg_24_1)
			arg_24_0:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, arg_24_1:getBody())

			return
		end,
		[ChapterProxy.CHAPTER_TIMESUP] = function(arg_25_0, arg_25_1)
			MainChapterTimeUpSequence.New():Execute()

			return
		end,
		[TechnologyConst.UPDATE_REDPOINT_ON_TOP] = function(arg_26_0, arg_26_1)
			MainTechnologySequence.New():Execute(function()
				return
			end)

			return
		end,
		[GAME.FETCH_NPC_SHIP_DONE] = function(arg_28_0, arg_28_1)
			local var_28_0 = arg_28_1:getBody()

			arg_28_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_28_0.items, var_28_0.callback)

			return
		end,
		[GAME.FETCH_NPC_SHIP_ACTIVITY_DONE] = GAME.FETCH_NPC_SHIP_DONE,
		[NewMainMediator.REFRESH_VIEW] = function(arg_29_0, arg_29_1)
			arg_29_0.viewComponent:setVisible(false)
			arg_29_0.viewComponent:setVisible(true)

			return
		end,
		[GAME.CONFIRM_GET_SHIP] = function(arg_30_0, arg_30_1)
			local var_30_0 = arg_30_1:getBody()

			arg_30_0:addSubLayers(Context.New({
				mediator = BuildShipRemindMediator,
				viewComponent = BuildShipRemindLayer,
				data = {
					ships = var_30_0.ships
				},
				onRemoved = var_30_0.callback
			}))

			return
		end,
		[GAME.CHANGE_LIVINGAREA_COVER_DONE] = function(arg_31_0, arg_31_1)
			arg_31_0.viewComponent:emit(NewMainScene.UPDATE_COVER)

			return
		end,
		[GAME.ACT_INSTAGRAM_CHAT_DONE] = function(arg_32_0, arg_32_1)
			if arg_32_1:getBody().operation == ActivityConst.INSTAGRAM_CHAT_ACTIVATE_TOPIC then
				if arg_32_0.viewComponent.theme then
					arg_32_0.viewComponent.theme:Refresh((arg_32_0.viewComponent:GetFlagShip()))
				end
			end

			return
		end,
		[NewMainMediator.ON_DROP] = function(arg_33_0, arg_33_1)
			arg_33_0.viewComponent:emit(BaseUI.ON_DROP, arg_33_1:getBody())

			return
		end,
		[NewMainMediator.ON_AWRADS] = function(arg_34_0, arg_34_1)
			local var_34_0 = arg_34_1:getBody()

			arg_34_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_34_0.items, var_34_0.callback)

			return
		end,
		[GAME.PLAY_CHANGE_SKIN_OUT] = function(arg_35_0, arg_35_1)
			arg_35_0.viewComponent:SetEffectPanelVisible(false)
			arg_35_0.viewComponent:HidePanel(true)
			arg_35_0.viewComponent:PlayChangeSkinActionOut(arg_35_1:getBody())

			return
		end,
		[GAME.PLAY_CHANGE_SKIN_IN] = function(arg_36_0, arg_36_1)
			arg_36_0.viewComponent:PlayChangeSkinActionIn(arg_36_1:getBody())

			return
		end,
		[GAME.PLAY_CHANGE_SKIN_FINISH] = function(arg_37_0, arg_37_1)
			arg_37_0.viewComponent:SetEffectPanelVisible(true)
			arg_37_0.viewComponent:HidePanel(false)

			return
		end,
		[GAME.CHANGE_SKIN_EXCHANGE] = function(arg_38_0, arg_38_1)
			local var_38_0 = arg_38_1:getBody()
			local var_38_1 = not not var_38_0.asmr

			if arg_38_0.viewComponent then
				arg_38_0.viewComponent:UpdateFlagShip(arg_38_0.viewComponent:GetFlagShip(), var_38_0)
			end

			arg_38_0.viewComponent:AsmrTurning(var_38_1)

			return
		end,
		[MusicPlayer.NO_PLAY_MUSIC_NOTIFICATION] = function(arg_39_0, arg_39_1)
			arg_39_0.viewComponent:CheckAndReplayBgm()

			return
		end,
		[NewMainMediator.FOLD_PANEL] = function(arg_40_0, arg_40_1)
			arg_40_0.viewComponent:FoldPanels(arg_40_1:getBody())

			return
		end,
		[NewMainMediator.HIDE_PANEL] = function(arg_41_0, arg_41_1)
			arg_41_0.viewComponent:HidePanel(arg_41_1:getBody())

			return
		end,
		[GAME.SERIES_GUIDE_END] = function(arg_42_0, arg_42_1)
			MainAwakeGuideSequence.New():Execute(function()
				return
			end)

			return
		end,
		[NewMainMediator.DEBUG_BATTLE_LOOP] = function(arg_44_0, arg_44_1)
			arg_44_0:BuildDebugBattleLoop((arg_44_1:getBody()))

			return
		end,
		[GAME.REMOVE_LAYERS] = function(arg_45_0, arg_45_1)
			local var_45_0 = arg_45_1:getBody().context

			arg_45_0.viewComponent:emit(NewMainMediator.REMOVE_LAYERS, arg_45_1:getBody())

			return
		end,
		[PlayerProxy.UPDATED] = function(arg_46_0, arg_46_1)
			arg_46_0.viewComponent:OnPlayerUpdated()

			return
		end,
		[ActivityProxy.UPDATED_TIP] = function(arg_47_0, arg_47_1)
			arg_47_0.viewComponent:emit(MainBaseActivityBtn.UPDATED_TIP)

			return
		end,
		[MiniGameProxy.ON_HUB_DATA_UPDATE] = function(arg_48_0, arg_48_1)
			if arg_48_0.viewComponent.theme and arg_48_0.viewComponent.theme:IsLoaded() then
				arg_48_0.viewComponent.theme:Refresh((arg_48_0.viewComponent:GetFlagShip()))
			else
				warning("界面没加载好，不进行刷新")
			end

			return
		end
	}

	return
end

function NewMainMediator:BuildDebugBattleLoop(arg_49_1)
	if not IsUnityEditor then
		return
	end

	local var_49_0 = {}

	for iter_49_0, iter_49_1 in arg_49_1:gmatch("%s+(%S+)") do
		table.insert(var_49_0, iter_49_0)
	end

	_G.InDebugBattleLoop = {
		loopCount = tonumber(var_49_0[2]),
		loopStages = underscore.rest(var_49_0, 3),
		tempList = {}
	}

	self.viewComponent:CheckDebugBattleLoop()

	return
end

return NewMainMediator
