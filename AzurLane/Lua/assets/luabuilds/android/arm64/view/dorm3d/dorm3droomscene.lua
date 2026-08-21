local var_0_0 = class("Dorm3dRoomScene", import("view.dorm3d.Dorm3dRoomTemplateScene"))

var_0_0.NOTIFY_UI_STATE = "Dorm3dRoomScene.NOTIFY_UI_STATE"

function var_0_0.getUIName(arg_1_0)
	return "Dorm3dMainUI"
end

function var_0_0.SetRoom(arg_2_0, arg_2_1)
	var_0_0.super.SetRoom(arg_2_0, arg_2_1)
	arg_2_0:UpdateContactState()

	return
end

function var_0_0.SetApartment(arg_3_0, arg_3_1)
	arg_3_0.apartment = arg_3_1

	arg_3_0:UpdateFavorDisplay()

	return
end

function var_0_0.InitSubViews(arg_4_0)
	arg_4_0.videoPlayer = VoiceChatLoader.New(arg_4_0._tf)
	arg_4_0.stockingView = Dorm3dStockingView.New(arg_4_0._tf, arg_4_0.event, setmetatable({}, {
		__index = arg_4_0.contextData
	}))
	arg_4_0.rtRoleTouchSubView = Dorm3dRTRoleTouchSubView.New(arg_4_0.rtRole:Find("Touch"), arg_4_0.event, setmetatable({
		onClick = function(arg_5_0)
			arg_4_0:emit(RoomTouchSystem.ENTER_TOUCH_MODE, arg_5_0)

			return
		end
	}, {
		__index = arg_4_0.contextData
	}))
	arg_4_0.aimIKView = Dorm3dAimIKView.New(arg_4_0._tf:Find("AimIKControl"), arg_4_0.event, setmetatable({}, {
		__index = arg_4_0.contextData
	}))
	arg_4_0.ikView = Dorm3dIKView.New(arg_4_0._tf, arg_4_0.event, {
		GetApartment = function()
			return arg_4_0.apartment
		end,
		GetCurrentLadyEnv = function()
			return arg_4_0:GetCurrentLadyEnv()
		end,
		GetSceneItem = function(arg_8_0)
			return arg_4_0:GetSceneItem(arg_8_0)
		end,
		GetScreenPosition = function(arg_9_0, arg_9_1)
			return arg_4_0:GetScreenPosition(arg_9_0, arg_9_1)
		end,
		GetLocalPosition = function(arg_10_0, arg_10_1)
			return arg_4_0:GetLocalPosition(arg_10_0, arg_10_1)
		end
	})
	arg_4_0.touchView = Dorm3dTouchView.New(arg_4_0._tf, arg_4_0.event, {})

	return
end

function var_0_0.init(arg_11_0)
	var_0_0.super.init(arg_11_0)
	Shader.SetGlobalFloat("_ScreenClipOff", 1)

	arg_11_0.uiContainer = arg_11_0._tf:Find("UI")

	local var_11_0 = arg_11_0.uiContainer:Find("base")

	onButton(arg_11_0, var_11_0:Find("btn_back"), function()
		arg_11_0:emit(BaseUI.ON_BACK)

		return
	end, SFX_DORM_BACK)
	onButton(arg_11_0, var_11_0:Find("btn_back/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_dorm3d_info.tip
		})

		return
	end, SFX_PANEL)

	arg_11_0.rtFavorLevel = var_11_0:Find("top/favor_level")

	setActive(arg_11_0.rtFavorLevel, arg_11_0.room:isPersonalRoom())
	onButton(arg_11_0, arg_11_0.rtFavorLevel, function()
		arg_11_0:emit(Dorm3dRoomMediator.OPEN_LEVEL_LAYER, {
			apartment = arg_11_0.apartment,
			timeIndex = arg_11_0.contextData.timeIndex,
			baseCamera = arg_11_0.mainCameraTF,
			roomId = arg_11_0.room:GetConfigID()
		})

		return
	end, SFX_PANEL)
	onButton(arg_11_0, var_11_0:Find("top/setting"), function()
		arg_11_0:emit(Dorm3dRoomMediator.OPEN_SETTING_LAYER)

		return
	end)
	onButton(arg_11_0, var_11_0:Find("left/btn_photograph"), function()
		if #arg_11_0.contextData.groupIds == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_photo_no_role"))

			return
		end

		local var_16_0, var_16_1 = arg_11_0:CheckSystemOpen("Photo")

		if not var_16_0 then
			pg.TipsMgr.GetInstance():ShowTips(var_16_1)

			return
		end

		if not arg_11_0.apartment then
			local var_16_2 = arg_11_0.contextData.groupIds[1]

			for iter_16_0, iter_16_1 in pairs(arg_11_0.ladyDict) do
				if iter_16_1.ladyBaseZone == arg_11_0:GetAttachedFurnitureName() then
					var_16_2 = iter_16_0

					break
				end
			end

			arg_11_0:SetApartment(getProxy(ApartmentProxy):getApartment(var_16_2))
		end

		getProxy(Dorm3dChatProxy):TriggerEvent({
			{
				value = 1,
				event_type = arg_11_0.contextData.timeIndex == 1 and 114 or 119,
				ship_id = arg_11_0.apartment:GetConfigID()
			}
		})
		arg_11_0:OutOfLazy(arg_11_0.apartment:GetConfigID(), function()
			arg_11_0.emit(arg_11_0, Dorm3dRoomMediator.OPEN_CAMERA_LAYER, arg_11_0, arg_11_0.apartment:GetConfigID())

			return
		end)

		return
	end, SFX_PANEL)
	onButton(arg_11_0, var_11_0:Find("left/btn_collection"), function()
		local var_18_0, var_18_1 = arg_11_0:CheckSystemOpen("Collection")

		if not var_18_0 then
			pg.TipsMgr.GetInstance():ShowTips(var_18_1)

			return
		end

		setActive(var_11_0:Find("left/btn_collection/tip"), false)
		PlayerPrefs.SetInt("apartment_collection_item", 0)
		PlayerPrefs.SetInt("apartment_collection_recall", 0)
		arg_11_0:emit(Dorm3dRoomMediator.OPEN_COLLECTION_LAYER, arg_11_0.room:GetConfigID())

		return
	end, SFX_PANEL)
	onButton(arg_11_0, var_11_0:Find("left/btn_furniture"), function()
		local var_19_0, var_19_1 = arg_11_0:CheckSystemOpen("Furniture")

		if not var_19_0 then
			pg.TipsMgr.GetInstance():ShowTips(var_19_1)

			return
		end

		arg_11_0:RemoveExtraSystem({
			SlideExtraSystem
		})
		arg_11_0:emit(Dorm3dRoomMediator.OPEN_FURNITURE_SELECT, {
			apartment = arg_11_0.apartment
		})

		arg_11_0.isInFurnitureSelect = true

		return
	end, SFX_PANEL)

	if not arg_11_0.room:isPersonalRoom() then
		local var_11_1 = arg_11_0:CheckSystemOpen("Furniture")

		setActive(var_11_0:Find("left/line_furniture"), var_11_1)
		setActive(var_11_0:Find("left/btn_furniture"), var_11_1)
	end

	onButton(arg_11_0, var_11_0:Find("left/btn_accompany"), function()
		local var_20_0, var_20_1 = arg_11_0:CheckSystemOpen("Accompany")
		local var_20_2

		if not var_20_0 then
			pg.TipsMgr.GetInstance():ShowTips(var_20_1)

			do return end

			var_20_2 = nil
		end

		;({}).groupId = arg_11_0.apartment:GetConfigID()
		;({}).confirmFunc = function(arg_21_0)
			var_20_2 = arg_21_0

			return
		end

		arg_11_0:emit(Dorm3dRoomMediator.OPEN_ACCOMPANY_WINDOW, {}, function()
			if var_20_2 then
				arg_11_0:OutOfLazy(var_0, function()
					arg_11_0:EnterAccompanyMode(var_20_2)

					return
				end)
			else
				arg_11_0:CheckQueue()
			end

			return
		end)

		return
	end, SFX_PANEL)

	if not arg_11_0.room:isPersonalRoom() then
		setActive(var_11_0:Find("left/line_accompany"), false)
		setActive(var_11_0:Find("left/btn_accompany"), false)
	end

	onButton(arg_11_0, var_11_0:Find("left/btn_skin"), function()
		arg_11_0:ActiveCamera(arg_11_0.cameras[var_0_0.CAMERA.SKIN])
		arg_11_0:emit(Dorm3dRoomMediator.OPEN_SKIN_SELECT_LAYER, arg_11_0.apartment:GetConfigID(), arg_11_0:GetCurrentLadyEnv(), nil, function()
			arg_11_0:ChangePlayerPosition()
			arg_11_0:ActiveCamera(arg_11_0.cameras[var_0_0.CAMERA.POV])

			return
		end, false)

		return
	end)

	if not arg_11_0.room:isPersonalRoom() then
		setActive(var_11_0:Find("left/line_skin"), false)
		setActive(var_11_0:Find("left/btn_skin"), false)
	end

	onButton(arg_11_0, var_11_0:Find("left/btn_invite"), function()
		arg_11_0:emit(Dorm3dRoomMediator.OPEN_INVITE_WINDOW, arg_11_0.room:GetConfigID(), underscore.rest(arg_11_0.contextData.groupIds, 1))

		return
	end, SFX_PANEL)

	if arg_11_0.room:isPersonalRoom() then
		setActive(var_11_0:Find("left/line_invite"), false)
		setActive(var_11_0:Find("left/btn_invite"), false)
	end

	arg_11_0.btnZone = var_11_0:Find("right/Zone")
	arg_11_0.rtZoneList = var_11_0:Find("right/Zone/List")

	setActive(arg_11_0.rtZoneList, false)
	onButton(arg_11_0, arg_11_0.btnZone, function()
		setActive(arg_11_0.rtZoneList, not isActive(arg_11_0.rtZoneList))

		return
	end, SFX_PANEL)
	UIItemList.StaticAlign(arg_11_0.rtZoneList, arg_11_0.rtZoneList:GetChild(0), #arg_11_0.zoneDatas, function(arg_28_0, arg_28_1, arg_28_2)
		if arg_28_0 ~= UIItemList.EventUpdate then
			return
		end

		arg_28_1 = arg_28_1 + 1
		arg_28_2.name = arg_11_0.zoneDatas[arg_28_1]:GetWatchCameraName()

		setText(arg_28_2:Find("Name"), arg_11_0.zoneDatas[arg_28_1]:GetName())
		setActive(arg_28_2:Find("Line"), arg_28_1 < #arg_11_0.zoneDatas)
		onButton(arg_11_0, arg_28_2, function()
			if arg_11_0.uiState ~= "base" then
				return
			end

			setActive(arg_11_0.rtZoneList, false)
			arg_11_0:ShiftZoneSafe(var_0)

			return
		end, SFX_PANEL)

		return
	end)
	onButton(arg_11_0, arg_11_0.uiContainer:Find("accompany"):Find("btn_back"), function()
		arg_11_0:ExitAccompanyMode()

		return
	end, SFX_DORM_BACK)

	arg_11_0.unlockList = {}
	arg_11_0.rtFavorUp = arg_11_0._tf:Find("Toast/favor_up")

	arg_11_0.rtFavorUp:GetComponent("DftAniEvent"):SetEndEvent(function(arg_31_0)
		setActive(arg_11_0.rtFavorUp, false)

		if #arg_11_0.unlockList > 0 then
			setText(arg_11_0.rtFavorUp:Find("Text"), table.remove(arg_11_0.unlockList, 1))
			setActive(arg_11_0.rtFavorUp, true)
		end

		return
	end)
	setActive(arg_11_0.rtFavorUp, false)

	arg_11_0.rtFavorUpDaily = arg_11_0._tf:Find("Toast/favor_up_daily")

	setActive(arg_11_0.rtFavorUpDaily, false)

	arg_11_0.rtStaminaPop = arg_11_0._tf:Find("Toast/stamina")

	local var_11_2 = arg_11_0.rtStaminaPop:GetComponent("DftAniEvent")

	var_11_2:SetTriggerEvent(function(arg_32_0)
		local var_32_0, var_32_1 = getProxy(ApartmentProxy):getStamina()

		setText(arg_11_0.rtStaminaPop:Find("Text"), string.format("%d/%d", var_32_0, var_32_1))

		return
	end)
	var_11_2:SetEndEvent(function(arg_33_0)
		setActive(arg_11_0.rtStaminaPop, false)

		return
	end)
	setActive(arg_11_0.rtStaminaPop, false)

	arg_11_0.rtLevelUpWindow = arg_11_0._tf:Find("LevelUpWindow")

	setActive(arg_11_0.rtLevelUpWindow, false)
	onButton(arg_11_0, arg_11_0.rtLevelUpWindow:Find("bg"), function()
		if arg_11_0.isLock then
			return
		end

		arg_11_0.isLock = true

		quickPlayAnimation(arg_11_0.rtLevelUpWindow, "anim_dorm3d_levelup_out")
		LeanTween.delayedCall(0.2, System.Action(function()
			arg_11_0.isLock = false

			setActive(arg_11_0.rtLevelUpWindow, false)
			arg_11_0:UnOverlayPanel(arg_11_0.rtLevelUpWindow, arg_11_0._tf)
			existCall(arg_11_0.levelUpCallback)

			return
		end))

		return
	end, SFX_PANEL)

	local var_11_3 = arg_11_0.uiContainer:Find("watch")

	onButton(arg_11_0, var_11_3:Find("btn_back"), function()
		arg_11_0:ExitWatchMode()

		return
	end, SFX_DORM_BACK)
	onButton(arg_11_0, var_11_3:Find("btn_back/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("roll_gametip")
		})

		return
	end, SFX_PANEL)

	arg_11_0.rtStaminaDisplay = var_11_3:Find("stamina")
	arg_11_0.rtRole = arg_11_0.uiContainer:Find("watch/Role")

	onButton(arg_11_0, arg_11_0.rtRole:Find("Talk"), function()
		local var_38_0 = arg_11_0.apartment:getFurnitureTalking(arg_11_0.room:GetConfigID(), arg_11_0:GetCurrentLadyEnv().ladyBaseZone)

		if #var_38_0 == 0 then
			pg.TipsMgr.GetInstance():ShowTips("without topic")

			return
		end

		arg_11_0:DoTalk(var_38_0[math.random(#var_38_0)], function()
			arg_11_0:emit(Dorm3dRoomMediator.TRIGGER_FAVOR, arg_11_0.apartment.configId, getDorm3dGameset("drom3d_favir_trigger_talk")[1])

			return
		end)

		return
	end, SFX_DORM_CLICK)
	setText(arg_11_0.rtRole:Find("Talk/bg/Text"), i18n("dorm3d_talk"))
	onButton(arg_11_0, arg_11_0.rtRole:Find("Gift"), function()
		arg_11_0:emit(arg_11_0.SHOW_BLOCK)
		arg_11_0:ActiveStateCamera("gift", function()
			arg_11_0:emit(arg_11_0.HIDE_BLOCK)

			return
		end)
		arg_11_0:emit(Dorm3dRoomMediator.OPEN_GIFT_LAYER, {
			groupId = arg_11_0.apartment:GetConfigID(),
			baseCamera = arg_11_0.mainCameraTF
		})

		return
	end, SFX_DORM_CLICK)
	setText(arg_11_0.rtRole:Find("Gift/bg/Text"), i18n("dorm3d_gift"))
	onButton(arg_11_0, arg_11_0.rtRole:Find("MiniGame"), function()
		assert(not arg_11_0.nowMiniGameId)

		arg_11_0.nowMiniGameId = arg_11_0.room:getMiniGames()[1]

		local var_42_0 = pg.dorm3d_minigame[arg_11_0.nowMiniGameId]
		local var_42_1 = arg_11_0:GetCurrentLadyEnv()

		getProxy(Dorm3dChatProxy):TriggerEvent({
			{
				value = 1,
				event_type = arg_11_0.contextData.timeIndex == 1 and 112 or 117,
				ship_id = arg_11_0.apartment:GetConfigID()
			},
			{
				value = 1,
				event_type = 158,
				ship_id = arg_11_0.apartment:GetConfigID()
			}
		})
		table.insert({}, function(arg_43_0)
			arg_11_0:SetAllBlackbloardValue("inLockLayer", true)
			arg_11_0:TempHideUI(true, arg_43_0)

			return
		end)

		if var_42_0.area ~= "" and var_42_1.ladyBaseZone ~= var_42_0.area then
			table.insert({}, function(arg_44_0)
				arg_11_0:ShiftZone(var_42_0.area, arg_44_0)

				return
			end)
		end

		local var_42_2
		local var_42_3

		if var_42_0.action ~= "" then
			var_42_2, var_42_3 = unpack(var_42_0.action)
		end

		table.insert({}, function(arg_45_0)
			parallelAsync({
				function(arg_46_0)
					if var_42_2 then
						arg_11_0:PlaySingleAction(var_42_1, var_42_2, arg_46_0)
					else
						arg_46_0()
					end

					return
				end,
				function(arg_47_0)
					arg_11_0:ActiveStateCamera("talk", arg_47_0)

					return
				end
			}, arg_45_0)

			return
		end)
		table.insert({}, function(arg_48_0)
			pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataMiniGame(1))
			arg_11_0:HandleGameNotification(Dorm3dMiniGameMediator.OPERATION, {
				operationCode = "BEFORE_OPEN_GAME",
				miniGameId = arg_11_0.nowMiniGameId
			})
			arg_11_0:EnableMiniGameCutIn()
			arg_11_0:emit(Dorm3dRoomMediator.OPEN_MINIGAME_WINDOW, {
				isDorm3d = true,
				minigameId = arg_11_0.nowMiniGameId
			}, arg_48_0)

			return
		end)
		table.insert({}, function(arg_49_0)
			arg_11_0:DisableMiniGameCutIn()

			if var_42_3 then
				arg_11_0:PlaySingleAction(var_42_1, var_42_3, arg_49_0)
			else
				arg_49_0()
			end

			return
		end)
		seriesAsync({}, function()
			arg_11_0:SetAllBlackbloardValue("inLockLayer", false)
			arg_11_0:TempHideUI(false)

			arg_11_0.nowMiniGameId = nil

			return
		end)

		return
	end, SFX_DORM_CLICK)
	setText(arg_11_0.rtRole:Find("MiniGame/bg/Text"), i18n("dorm3d_minigame_button1"))

	if not arg_11_0.room:isPersonalRoom() then
		onButton(arg_11_0, arg_11_0.rtRole:Find("PublicGame"), switch(arg_11_0.room.id, {
			[4] = function()
				return function()
					arg_11_0:emit(Dorm3dRoomMediator.ENTER_VOLLEYBALL, arg_11_0.apartment:GetConfigID())

					return
				end
			end,
			[16] = function()
				return function()
					arg_11_0:emit(Dorm3dRoomMediator.ENTER_DANCE, arg_11_0.apartment:GetConfigID())

					return
				end
			end,
			[26] = function()
				return function()
					arg_11_0:emit(Dorm3dRoomMediator.ENTER_CARWASH, arg_11_0.apartment:GetConfigID())

					return
				end
			end
		}), SFX_DORM_CLICK)
		setText(arg_11_0.rtRole:Find("PublicGame/bg/Text"), switch(arg_11_0.room.id, {
			[4] = function()
				return i18n("dorm3d_volleyball_button")
			end,
			[16] = function()
				return i18n("dorm3d_dance_button")
			end,
			[26] = function()
				return i18n("dorm3d_carwash_button")
			end
		}))
	end

	onButton(arg_11_0, arg_11_0.rtRole:Find("Performance"), function()
		arg_11_0:DoTalk(20500, function()
			pg.TipsMgr.GetInstance():ShowTips("Success!")

			return
		end)

		return
	end, SFX_DORM_CLICK)

	arg_11_0.rtFloatPage = arg_11_0._tf:Find("FloatPage")
	arg_11_0.tplFloat = arg_11_0.rtFloatPage:Find("tpl")

	setActive(arg_11_0.tplFloat, false)
	eachChild(cloneTplTo(arg_11_0.tplFloat, arg_11_0.rtFloatPage, "lady"), function(arg_62_0)
		setActive(arg_62_0, arg_62_0.name == "walk")

		return
	end)

	arg_11_0._joystick = arg_11_0._tf:Find("Stick")

	setActive(arg_11_0._joystick, false)
	arg_11_0._joystick:GetComponent(typeof(SlideController)):SetStickFunc(function(arg_63_0)
		arg_11_0:emit(arg_11_0.ON_STICK_MOVE, arg_63_0)

		return
	end)

	arg_11_0.povLayer = arg_11_0._tf:Find("POVControl")

	setActive(arg_11_0.povLayer, false)
	;(function()
		local var_64_0 = arg_11_0.povLayer:Find("Move"):GetComponent(typeof(SlideController))

		var_64_0:AddBeginDragFunc(function(arg_65_0, arg_65_1)
			arg_11_0:emit(arg_11_0.ON_POV_STICK_MOVE_BEGIN, arg_65_1)

			return
		end)
		var_64_0:SetStickFunc(function(arg_66_0)
			arg_11_0:emit(arg_11_0.ON_POV_STICK_MOVE, arg_66_0)

			return
		end)
		var_64_0:AddDragEndFunc(function(arg_67_0, arg_67_1)
			arg_11_0:emit(arg_11_0.ON_POV_STICK_MOVE_END, arg_67_1)

			return
		end)
		arg_11_0.povLayer:Find("View"):GetComponent(typeof(SlideController)):SetStickFunc(function(arg_68_0)
			arg_11_0:emit(arg_11_0.ON_POV_STICK_VIEW, arg_68_0)

			return
		end)

		return
	end)()

	arg_11_0.rtExtraScreen = arg_11_0._tf:Find("ExtraScreen")
	arg_11_0.rtTimelineScreen = arg_11_0.rtExtraScreen:Find("TimelineScreen")

	onButton(arg_11_0, arg_11_0.rtTimelineScreen:Find("btn_skip"), function()
		existCall(arg_11_0.timelineFinishCall)

		return
	end, SFX_CANCEL)
	arg_11_0:InitSubViews()

	arg_11_0.uiStack = {}
	arg_11_0.uiStore = {}

	return
end

function var_0_0.BindEvent(arg_70_0)
	var_0_0.super.BindEvent(arg_70_0)
	arg_70_0:bind(arg_70_0.CLICK_CHARACTER, function(arg_71_0, arg_71_1)
		if arg_70_0.uiState ~= "base" or not arg_70_0.ladyDict[arg_71_1].nowCanWatchState then
			return
		end

		local var_71_0 = {}

		if arg_70_0:GetBlackboardValue(arg_70_0.ladyDict[arg_71_1], "inPending") then
			table.insert(var_71_0, function(arg_72_0)
				arg_70_0:OutOfPending(arg_71_1, arg_72_0)

				return
			end)
		else
			table.insert(var_71_0, function(arg_73_0)
				arg_70_0:OutOfLazy(arg_71_1, arg_73_0)

				return
			end)
		end

		seriesAsync(var_71_0, function()
			if not arg_70_0.room:isPersonalRoom() then
				arg_70_0:SetApartment(getProxy(ApartmentProxy):getApartment(arg_71_1))
			end

			arg_70_0:EnterWatchMode()

			return
		end)
		pg.CriMgr.GetInstance():PlaySE_V3("ui-dorm_touch_v1")

		return
	end)
	arg_70_0:bind(arg_70_0.CLICK_CONTACT, function(arg_75_0, arg_75_1)
		arg_70_0:TriggerContact(arg_75_1)

		return
	end)
	arg_70_0:bind(arg_70_0.DISTANCE_TRIGGER, function(arg_76_0, arg_76_1, arg_76_2)
		if arg_70_0.uiState == "base" then
			arg_70_0:CheckDistanceTalk(arg_76_1, arg_76_2)
		end

		return
	end)
	arg_70_0:bind(arg_70_0.WALK_DISTANCE_TRIGGER, function(arg_77_0, arg_77_1, arg_77_2)
		if arg_70_0.apartment and arg_70_0.apartment:GetConfigID() == arg_77_1 then
			existCall(arg_70_0.walkNearCallback, arg_77_2)
		end

		return
	end)
	arg_70_0:bind(arg_70_0.CHANGE_WATCH, function(arg_78_0, arg_78_1)
		arg_70_0:ChangeCanWatchState(arg_70_0.ladyDict[arg_78_1])

		return
	end)
	arg_70_0:bind(arg_70_0.ON_ENTER_SECTOR, function(arg_79_0, arg_79_1)
		arg_70_0:ChangeCanWatchState(arg_70_0.ladyDict[arg_79_1])

		return
	end)
	arg_70_0:bind(arg_70_0.ON_CHANGE_DISTANCE, function(arg_80_0, arg_80_1, arg_80_2)
		arg_70_0:ChangeCanWatchState(arg_70_0.ladyDict[arg_80_1])

		return
	end)

	return
end

function var_0_0.didEnter(arg_81_0)
	arg_81_0.resumeCallback = arg_81_0.contextData.resumeCallback
	arg_81_0.contextData.resumeCallback = nil

	var_0_0.super.didEnter(arg_81_0)
	arg_81_0:UpdateZoneList()
	arg_81_0:SetUI(function()
		arg_81_0:didEnterCheck()

		return
	end, "base")

	return
end

function var_0_0.FinishEnterResume(arg_83_0)
	if not arg_83_0.resumeCallback then
		return
	end

	arg_83_0.resumeCallback = nil

	return var_83_0()
end

function var_0_0.EnableJoystick(arg_84_0, arg_84_1)
	setActive(arg_84_0._joystick, arg_84_1)

	return
end

function var_0_0.EnablePOVLayer(arg_85_0, arg_85_1)
	setActive(arg_85_0.povLayer, arg_85_1)

	if not arg_85_1 then
		arg_85_0:emit(arg_85_0.ON_POV_STICK_MOVE_END)
	end

	return
end

function var_0_0.SetUIStore(arg_86_0, arg_86_1, ...)
	table.insertto(arg_86_0.uiStore, {
		...
	})
	existCall(arg_86_1)

	return
end

function var_0_0.SetUI(arg_87_0, arg_87_1, ...)
	warning("SetUI", ...)

	while rawget(arg_87_0, "class") ~= var_0_0 do
		arg_87_0 = getmetatable(arg_87_0).__index
	end

	table.insertto(arg_87_0.uiStore, {
		...
	})

	for iter_87_0, iter_87_1 in ipairs(arg_87_0.uiStore) do
		if iter_87_1 == "back" then
			assert(#arg_87_0.uiStack > 0)

			arg_87_0.uiState = table.remove(arg_87_0.uiStack)
		elseif iter_87_1 == arg_87_0.uiState and iter_87_1 == "ik" then
			-- block empty
		else
			table.insert(arg_87_0.uiStack, arg_87_0.uiState)

			arg_87_0.uiState = iter_87_1
		end
	end

	pg.m02:sendNotification(var_0_0.NOTIFY_UI_STATE, arg_87_0.uiState)

	arg_87_0.uiStore = {}

	eachChild(arg_87_0.uiContainer, function(arg_88_0)
		setActive(arg_88_0, arg_88_0.name == arg_87_0.uiState)

		return
	end)
	arg_87_0:EnablePOVLayer(arg_87_0.uiState == "base" or arg_87_0.uiState == "walk")
	arg_87_0:TempHideContact(arg_87_0.uiState ~= "base")
	arg_87_0:SetFloatEnable(arg_87_0.uiState == "walk")
	setActive(arg_87_0.rtFloatPage, arg_87_0.uiState == "walk")

	if arg_87_0.uiState ~= "stocking" then
		arg_87_0.stockingView:Hide()
	end

	warning("SetUI to ", arg_87_0.uiState)
	switch(arg_87_0.uiState, {
		base = function()
			if not arg_87_0.room:isPersonalRoom() then
				arg_87_0:SetApartment(nil)
			end

			arg_87_0:UpdateBtnState()

			return
		end,
		watch = function()
			eachChild(arg_87_0.rtRole, function(arg_91_0)
				setActive(arg_91_0, false)

				return
			end)

			for iter_90_0, iter_90_1 in ipairs((underscore.filter({
				"Talk",
				"Touch",
				"Gift",
				"MiniGame",
				"PublicGame",
				"Performance"
			}, function(arg_92_0)
				return arg_87_0:CheckSystemOpen(arg_92_0)
			end))) do
				LeanTween.delayedCall(0.05, System.Action(function()
					setActive(arg_87_0.rtRole:Find(iter_90_1), true)

					if iter_90_1 == "Touch" then
						local var_93_0 = arg_87_0.apartment:GetConfigID()

						arg_87_0.rtRoleTouchSubView:Flush(arg_87_0.room, var_93_0, arg_87_0.ladyDict[var_93_0].ladyBaseZone)
					end

					return
				end))
			end

			local var_90_1 = arg_87_0.apartment:GetConfigID()
			local var_90_2 = Dorm3dGift.NeedViewTip(var_90_1)

			var_90_2 = var_90_2 or getProxy(ApartmentProxy):HasShipGroupGiftExpireSoon(var_90_1)

			setActive(arg_87_0.rtRole:Find("Gift/bg/Tip"), var_90_2)

			return
		end,
		ik = function()
			local var_94_0 = arg_87_0.room:isPersonalRoom() and not arg_87_0.performanceInfo

			arg_87_0:emit(Dorm3dIKView.RESET_ENTRY_MENU, var_94_0)

			return
		end,
		walk = function()
			setText(arg_87_0.uiContainer:Find("walk/dialogue/content"), i18n("dorm3d_removable", arg_87_0.apartment:getConfig("name")))

			return
		end,
		stocking = function()
			arg_87_0.stockingView:Show()

			return
		end
	})
	arg_87_0:ActiveStateCamera(arg_87_0.uiState, function()
		if arg_87_1 then
			arg_87_1()
		elseif arg_87_0.uiState == "base" then
			arg_87_0:CheckQueue()
		end

		return
	end)

	return
end

function var_0_0.EnterWatchMode(arg_98_0)
	local var_98_0 = arg_98_0.apartment:GetConfigID()

	seriesAsync({
		function(arg_99_0)
			arg_98_0:emit(arg_98_0.SHOW_BLOCK)
			arg_98_0:SetBlackboardValue(arg_98_0.ladyDict[var_98_0], "inWatchMode", true)
			arg_98_0:SetUI(arg_99_0, "watch")

			return
		end,
		function(arg_100_0)
			arg_98_0:emit(arg_98_0.HIDE_BLOCK)

			return
		end
	})

	return
end

function var_0_0.ExitWatchMode(arg_101_0)
	local var_101_0 = arg_101_0.apartment:GetConfigID()

	seriesAsync({
		function(arg_102_0)
			arg_101_0:emit(arg_101_0.SHOW_BLOCK)
			arg_101_0:SetUI(arg_102_0, "back")

			return
		end,
		function(arg_103_0)
			arg_101_0:SetBlackboardValue(arg_101_0.ladyDict[var_101_0], "inWatchMode", false)
			arg_101_0:emit(arg_101_0.HIDE_BLOCK)
			arg_101_0:CheckQueue()

			return
		end
	})

	return
end

function var_0_0.SetInPending(arg_104_0, arg_104_1, arg_104_2)
	local var_104_0 = arg_104_0:GetBlackboardValue(arg_104_1, "groupId")
	local var_104_1 = pg.dorm3d_welcome[arg_104_2]

	arg_104_0:SetBlackboardValue(arg_104_1, "inPending", true)
	arg_104_0:ChangeCanWatchState(arg_104_1)
	arg_104_0:EnableHeadIK(arg_104_1, false)

	arg_104_0.contextData.ladyZone[var_104_0] = pg.dorm3d_welcome[arg_104_2].area

	arg_104_1:SetZone(arg_104_0.contextData.ladyZone[var_104_0], pg.dorm3d_welcome[arg_104_2].welcome_staypoint)
	arg_104_0:ChangeCharacterPosition(arg_104_1)

	if pg.dorm3d_welcome[arg_104_2].item_shield ~= "" then
		arg_104_0.hideItemDic = {}

		for iter_104_0, iter_104_1 in ipairs(pg.dorm3d_welcome[arg_104_2].item_shield) do
			local var_104_2 = arg_104_0.modelRoot:Find(iter_104_1)

			if not var_104_2 then
				warning(string.format("welcome:%d without hide item:%s", arg_104_2, iter_104_1))
			else
				arg_104_0.hideItemDic[iter_104_1] = isActive(var_104_2)

				setActive(var_104_2, false)
			end
		end
	end

	onNextTick(function()
		if arg_104_1.tfPendintItem then
			setActive(arg_104_1.tfPendintItem, true)
		end

		arg_104_0:SwitchAnim(arg_104_1, var_104_1.welcome_idle)

		return
	end)

	arg_104_0.wakeUpTalkId = pg.dorm3d_welcome[arg_104_2].welcome_talk

	return
end

function var_0_0.SetOutPending(arg_106_0, arg_106_1)
	arg_106_0:SetBlackboardValue(arg_106_1, "inPending", false)
	arg_106_0:ChangeCanWatchState(arg_106_1)
	arg_106_0:EnableHeadIK(arg_106_1, true)

	arg_106_0.wakeUpTalkId = nil

	if arg_106_1.tfPendintItem then
		setActive(arg_106_1.tfPendintItem, false)
	end

	if arg_106_0.hideItemDic then
		for iter_106_0, iter_106_1 in pairs(arg_106_0.hideItemDic) do
			setActive(arg_106_0.modelRoot:Find(iter_106_0), iter_106_1)
		end

		arg_106_0.hideItemDic = nil
	end

	return
end

function var_0_0.IsModeInHidePending(arg_107_0, arg_107_1)
	for iter_107_0, iter_107_1 in pairs(arg_107_0.ladyDict) do
		if iter_107_1.hideItemDic and iter_107_1.hideItemDic[arg_107_1] ~= nil then
			return true
		end
	end

	return false
end

function var_0_0.EnterAccompanyMode(arg_108_0, arg_108_1)
	local var_108_0 = pg.dorm3d_accompany[arg_108_1]
	local var_108_1
	local var_108_2

	if pg.dorm3d_accompany[arg_108_1].sceneInfo ~= "" then
		var_108_1, var_108_2 = unpack(string.split(pg.dorm3d_accompany[arg_108_1].sceneInfo, "|"))
	end

	local var_108_3 = {
		type = "timeline",
		name = pg.dorm3d_accompany[arg_108_1].timeline,
		scene = var_108_1,
		sceneRoot = var_108_2,
		accompanys = {}
	}

	for iter_108_0, iter_108_1 in ipairs(pg.dorm3d_accompany[arg_108_1].jump_trigger) do
		local var_108_4, var_108_5 = unpack(iter_108_1)

		var_108_3.accompanys[var_108_4] = var_108_5
	end

	local var_108_6, var_108_7 = unpack(pg.dorm3d_accompany[arg_108_1].favor)

	getProxy(Dorm3dChatProxy):TriggerEvent({
		{
			value = 1,
			event_type = 161,
			ship_id = arg_108_0.apartment:GetConfigID()
		}
	})
	getProxy(ApartmentProxy):RecordAccompanyTime()
	pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataAccompany(1, pg.dorm3d_accompany[arg_108_1].ship_id, pg.dorm3d_accompany[arg_108_1].performance_time, 0, var_108_1 or arg_108_0.dormSceneMgr.artSceneInfo))
	table.insert({}, function(arg_109_0)
		arg_108_0:SetUI(arg_109_0, "blank", "accompany")

		return
	end)
	table.insert({}, function(arg_110_0)
		arg_108_0.accompanyFavorCount = 0
		arg_108_0.accompanyFavorTimer = Timer.New(function()
			arg_108_0.accompanyFavorCount = arg_108_0.accompanyFavorCount + 1

			return
		end, var_108_6, -1)

		arg_108_0.accompanyFavorTimer:Start()

		arg_108_0.accompanyPerformanceTimer = Timer.New(function()
			arg_108_0.canTriggerAccompanyPerformance = true

			return
		end, var_108_0.performance_time, -1)

		arg_108_0.accompanyPerformanceTimer:Start()
		arg_108_0:PlayTimeline(var_108_3, function(arg_113_0, arg_113_1)
			arg_113_1()
			arg_110_0()

			return
		end)

		return
	end)
	seriesAsync({}, function()
		assert(arg_108_0.accompanyFavorTimer)
		arg_108_0.accompanyFavorTimer:Stop()

		arg_108_0.accompanyFavorTimer = nil

		assert(arg_108_0.accompanyPerformanceTimer)
		arg_108_0.accompanyPerformanceTimer:Stop()

		arg_108_0.accompanyPerformanceTimer = nil
		arg_108_0.canTriggerAccompanyPerformance = nil

		local var_114_0 = math.min(arg_108_0.accompanyFavorCount, getProxy(ApartmentProxy):getStamina())

		if var_114_0 > 0 then
			warning(var_108_7[var_114_0])
			arg_108_0:emit(Dorm3dRoomMediator.TRIGGER_FAVOR, arg_108_0.apartment.configId, var_108_7[var_114_0])
		end

		local var_114_1 = 0
		local var_114_2 = getProxy(ApartmentProxy):GetAccompanyTime()

		if var_114_2 then
			var_114_1 = pg.TimeMgr.GetInstance():GetServerTime() - var_114_2
		end

		var_114_3(pg.m02, GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataAccompany(2, var_108_0.ship_id, var_108_0.performance_time, var_114_1, var_114_4))
		arg_108_0:SetUI(nil, "back", "back")

		return
	end)

	return
end

function var_0_0.ExitAccompanyMode(arg_115_0)
	existCall(arg_115_0.timelineFinishCall)

	return
end

function var_0_0.EnterTouchPerformance(arg_116_0)
	local var_116_0 = arg_116_0.room:getApartmentZoneConfig(arg_116_0:GetCurrentLadyEnv().ladyBaseZone, "touch_performance", arg_116_0.apartment:GetConfigID())

	if not var_116_0 or var_116_0 == 0 then
		arg_116_0:emit(RoomTouchSystem.ENTER_TOUCH_MODE)
	else
		arg_116_0:DoTalk(var_116_0)
	end

	return
end

function var_0_0.ChangeWalkScene(arg_117_0, arg_117_1, arg_117_2, arg_117_3)
	local var_117_0 = arg_117_0:GetCurrentLadyEnv()

	seriesAsync({
		function(arg_118_0)
			arg_117_0:ChangeArtScene(arg_117_2, arg_118_0)

			return
		end,
		function(arg_119_0)
			arg_117_0:ChangeSubScene(arg_117_2, arg_119_0)

			return
		end,
		function(arg_120_0)
			arg_117_0:emit(arg_117_0.SHOW_BLOCK)

			if arg_117_1 == "back" then
				arg_117_0:SetUI(arg_120_0, "back")
			elseif arg_117_1 == "change" and arg_117_0.uiState ~= "walk" then
				arg_117_0:SetUI(arg_120_0, "walk")
			else
				arg_120_0()
			end

			return
		end
	}, function()
		arg_117_0:emit(arg_117_0.HIDE_BLOCK)
		arg_117_0:SetBlackboardValue(var_117_0, "inWalk", arg_117_1 == "change")
		existCall(arg_117_3)

		return
	end)

	return
end

function var_0_0.EnterWalkMode(arg_122_0)
	local var_122_0 = arg_122_0.ladyDict[arg_122_0.apartment:GetConfigID()]

	seriesAsync({
		function(arg_123_0)
			arg_122_0:emit(arg_122_0.SHOW_BLOCK)
			arg_122_0:HideCharacter(var_0)
			arg_122_0:SetBlackboardValue(var_122_0, "inWalk", true)
			arg_122_0:SetUI(arg_123_0, "walk")

			return
		end,
		function(arg_124_0)
			arg_122_0:emit(arg_122_0.HIDE_BLOCK)
			arg_122_0:ChangeArtScene(arg_122_0.walkInfo.scene .. "|" .. arg_122_0.walkInfo.sceneRoot, arg_124_0)

			return
		end,
		function(arg_125_0)
			arg_122_0:LoadSubScene(arg_122_0.walkInfo, arg_125_0)

			return
		end
	}, function()
		return
	end)

	return
end

function var_0_0.ExitWalkMode(arg_127_0)
	local var_127_0 = arg_127_0.ladyDict[arg_127_0.apartment:GetConfigID()]

	seriesAsync({
		function(arg_128_0)
			arg_127_0:RevertArtScene(arg_127_0.walkLastSceneInfo, arg_128_0)

			return
		end,
		function(arg_129_0)
			arg_127_0:UnloadSubScene(arg_127_0.walkInfo, arg_129_0)

			return
		end,
		function(arg_130_0)
			arg_127_0:emit(arg_127_0.SHOW_BLOCK)
			arg_127_0:SetUI(arg_130_0, "back")

			return
		end
	}, function()
		arg_127_0:emit(arg_127_0.HIDE_BLOCK)
		arg_127_0:RevertCharacter(var_0)
		arg_127_0:SetBlackboardValue(var_127_0, "inWalk", false)

		arg_127_0.walkExitCall = nil
		arg_127_0.walkLastSceneInfo = nil
		arg_127_0.walkInfo = nil

		existCall(arg_127_0.walkExitCall)

		return
	end)

	return
end

function var_0_0.EnableMiniGameCutIn(arg_132_0)
	if not arg_132_0.tfCutIn then
		return
	end

	local var_132_0 = arg_132_0.rtExtraScreen:Find("MiniGameCutIn")

	setActive(var_132_0, true)

	local var_132_1 = GetOrAddComponent(var_132_0:Find("bg/mask/cut_in"), "CameraRTUI")

	setActive(var_132_1, true)
	pg.CameraRTMgr.GetInstance():Bind(var_132_1, arg_132_0.tfCutIn:Find("TestCamera"):GetComponent(typeof(Camera)))
	quickPlayAnimator(arg_132_0.modelCutIn.lady, "Idle")
	quickPlayAnimator(arg_132_0.modelCutIn.player, "Idle")
	setActive(arg_132_0.tfCutIn, true)

	return
end

function var_0_0.DisableMiniGameCutIn(arg_133_0)
	if not arg_133_0.tfCutIn then
		return
	end

	local var_133_0 = arg_133_0.rtExtraScreen:Find("MiniGameCutIn")

	pg.CameraRTMgr.GetInstance():Clean((GetOrAddComponent(var_133_0:Find("bg/mask/cut_in"), "CameraRTUI")))
	setActive(var_133_0, false)
	setActive(arg_133_0.tfCutIn, false)

	return
end

function var_0_0.DoTalk(arg_134_0, arg_134_1, arg_134_2)
	while rawget(arg_134_0, "class") ~= var_0_0 do
		arg_134_0 = getmetatable(arg_134_0).__index
	end

	if arg_134_0.apartment and arg_134_0:GetBlackboardValue(arg_134_0:GetCurrentLadyEnv(), "inTalking") then
		errorMsg("Talking block:" .. arg_134_1)

		return
	end

	if not arg_134_0.room:isPersonalRoom() then
		local var_134_0 = pg.dorm3d_dialogue_group[arg_134_1].char_id

		if arg_134_0.apartment then
			assert(arg_134_0.apartment:GetConfigID() == var_134_0)
		else
			arg_134_0:SetApartment(getProxy(ApartmentProxy):getApartment(var_134_0))
		end
	end

	local var_134_1 = arg_134_0:GetCurrentLadyEnv()

	if arg_134_1 == 26 and not arg_134_0.apartment.talkDic[arg_134_1] then
		arg_134_0.firstTimelineTouch = true
		arg_134_0.firstMoveGuide = true
	end

	getProxy(Dorm3dChatProxy):TriggerEvent({
		{
			value = 1,
			event_type = arg_134_0.contextData.timeIndex == 1 and 110 or 115,
			ship_id = arg_134_0.apartment:GetConfigID()
		},
		{
			value = 1,
			event_type = 155,
			ship_id = arg_134_0.apartment:GetConfigID()
		}
	})

	local var_134_2 = {}

	if arg_134_0:GetBlackboardValue(var_134_1, "inPending") then
		table.insert(var_134_2, function(arg_135_0)
			arg_134_0:OutOfLazy(arg_134_0.apartment:GetConfigID(), arg_135_0)

			return
		end)
	end

	local var_134_3 = pg.dorm3d_dialogue_group[arg_134_1]
	local var_134_4 = pg.dorm3d_dialogue_group[arg_134_1].performance_type == 1
	local var_134_5

	table.insert(var_134_2, function(arg_136_0)
		arg_134_0:emit(arg_134_0.SHOW_BLOCK)
		arg_134_0:SetBlackboardValue(var_134_1, var_134_4 and "inPerformance" or "inTalking", true)
		arg_134_0:emit(Dorm3dRoomMediator.DO_TALK, arg_134_1, function(arg_137_0)
			var_134_5 = arg_137_0

			arg_136_0()

			return
		end)

		return
	end)
	table.insert(var_134_2, function(arg_138_0)
		pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataDialog(arg_134_0.apartment.configId, arg_134_0.apartment.level, arg_134_1, var_134_3.type, arg_134_0.room:getZoneConfig(arg_134_0:GetCurrentLadyEnv().ladyBaseZone, "id"), var_134_3.action_type, table.CastToString(var_134_3.trigger_config), arg_134_0.room:GetConfigID()))

		if pg.NewGuideMgr.GetInstance():IsBusy() then
			pg.NewGuideMgr.GetInstance():Pause()
		end

		arg_134_0:SetUI(arg_138_0, "blank")

		return
	end)

	if var_134_3.trigger_area and var_134_3.trigger_area ~= "" then
		table.insert(var_134_2, function(arg_139_0)
			arg_134_0:ShiftZone(var_134_3.trigger_area, arg_139_0)

			return
		end)
	end

	if var_134_3.performance_type == 0 then
		table.insert(var_134_2, function(arg_140_0)
			arg_134_0:emit(arg_134_0.HIDE_BLOCK)

			if arg_134_0.contextData.isVideoTalk then
				arg_134_0.videoPlayer:ExecuteAction("Play", var_134_3.story, function()
					onDelayTick(arg_140_0, 0.001)

					return
				end)
			else
				pg.NewStoryMgr.GetInstance():ForceManualPlay(var_134_3.story, function()
					onDelayTick(arg_140_0, 0.001)

					return
				end, true)
			end

			return
		end)
	elseif var_134_3.performance_type == 1 then
		table.insert(var_134_2, function(arg_143_0)
			arg_134_0:emit(arg_134_0.HIDE_BLOCK)
			arg_134_0:PerformanceQueue(var_134_3.story, arg_143_0)

			return
		end)
	else
		assert(false)
	end

	table.insert(var_134_2, function(arg_144_0)
		arg_134_0:emit(arg_134_0.SHOW_BLOCK)
		arg_144_0()

		return
	end)
	table.insert(var_134_2, function(arg_145_0)
		local var_145_0 = pg.NewStoryMgr.GetInstance():StoryName2StoryId(var_134_3.story)

		if var_145_0 then
			pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataStory(var_145_0, "1"))
		end

		if var_134_5 and #var_134_5 > 0 then
			arg_134_0:emit(Dorm3dRoomMediator.OPEN_DROP_LAYER, var_134_5, arg_145_0)
		else
			arg_145_0()
		end

		return
	end)
	table.insert(var_134_2, function(arg_146_0)
		if pg.NewGuideMgr.GetInstance():IsPause() then
			pg.NewGuideMgr.GetInstance():Resume()
		end

		arg_134_0:emit(arg_134_0.HIDE_BLOCK)

		if arg_134_0.contextData.isVideoTalk then
			existCall(arg_146_0)
		else
			arg_134_0:SetBlackboardValue(var_134_1, var_134_4 and "inPerformance" or "inTalking", false)
			arg_134_0:SetUI(arg_146_0, "back")
		end

		return
	end)
	seriesAsync(var_134_2, function()
		if arg_134_2 then
			return arg_134_2()
		else
			arg_134_0:CheckQueue()
		end

		return
	end)

	return
end

function var_0_0.DoTalkTouchOption(arg_148_0, arg_148_1, arg_148_2, arg_148_3)
	local var_148_0 = arg_148_0.rtExtraScreen:Find("TalkTouchOption")
	local var_148_1
	local var_148_2 = var_148_0:Find("content")

	UIItemList.StaticAlign(var_148_2, var_148_2:Find("clickTpl"), #arg_148_1.options, function(arg_149_0, arg_149_1, arg_149_2)
		arg_149_1 = arg_149_1 + 1

		if arg_149_0 == UIItemList.EventUpdate then
			local var_149_0 = arg_148_1.options[arg_149_1]

			setAnchoredPosition(arg_149_2, NewPos(unpack(arg_148_1.options[arg_149_1].pos)))
			onButton(arg_148_0, arg_149_2, function()
				var_148_1(var_149_0.flag)

				return
			end, SFX_CONFIRM)
			setActive(arg_149_2, not table.contains(arg_148_2, arg_148_1.options[arg_149_1].flag))
		end

		return
	end)
	setActive(var_148_0, true)

	function var_148_1(arg_151_0)
		setActive(var_148_0, false)
		arg_148_3(arg_151_0)

		return
	end

	return
end

function var_0_0.DoTimelineOption(arg_152_0, arg_152_1, arg_152_2)
	local var_152_0 = arg_152_0.rtTimelineScreen:Find("TimelineOption")
	local var_152_1
	local var_152_2 = var_152_0:Find("content")

	UIItemList.StaticAlign(var_152_2, var_152_2:Find("clickTpl"), #arg_152_1, function(arg_153_0, arg_153_1, arg_153_2)
		arg_153_1 = arg_153_1 + 1

		if arg_153_0 == UIItemList.EventUpdate then
			setText(arg_153_2:Find("Text"), HXSet.hxLan(arg_152_1[arg_153_1].content))
			onButton(arg_152_0, arg_153_2, function()
				var_152_1(arg_153_1)

				return
			end, SFX_CONFIRM)
		end

		return
	end)
	setActive(var_152_0, true)

	function var_152_1(arg_155_0)
		setActive(var_152_0, false)
		arg_152_2(arg_155_0)

		return
	end

	return
end

function var_0_0.DoTimelineTouch(arg_156_0, arg_156_1, arg_156_2)
	local var_156_0 = arg_156_0.rtTimelineScreen:Find("TimelineTouch")
	local var_156_1
	local var_156_2 = var_156_0:Find("content")

	UIItemList.StaticAlign(var_156_2, var_156_2:Find("clickTpl"), #arg_156_1, function(arg_157_0, arg_157_1, arg_157_2)
		arg_157_1 = arg_157_1 + 1

		if arg_157_0 == UIItemList.EventUpdate then
			setAnchoredPosition(arg_157_2, NewPos(unpack(arg_156_1[arg_157_1].pos)))
			onButton(arg_156_0, arg_157_2, function()
				var_156_1(arg_157_1)

				return
			end, SFX_CONFIRM)

			if arg_156_0.firstTimelineTouch then
				arg_156_0.firstTimelineTouch = nil

				setActive(arg_157_2:Find("finger"), true)
			end
		end

		return
	end)
	setActive(var_156_0, true)

	function var_156_1(arg_159_0)
		setActive(var_156_0, false)
		arg_156_2(arg_159_0)

		return
	end

	return
end

function var_0_0.DoShortWait(arg_160_0, arg_160_1)
	local var_160_9000
	local var_160_0 = arg_160_0.ladyDict[arg_160_1]
	local var_160_1 = getProxy(ApartmentProxy)
	local var_160_2 = var_160_1.getApartment(var_160_9000, arg_160_1)
	local var_160_3 = arg_160_0.room:getApartmentZoneConfig(arg_160_0.ladyDict[arg_160_1].ladyBaseZone, "special_action", arg_160_1)
	local var_160_4 = var_160_3 and var_160_3[math.random(#var_160_3)] or nil

	if not var_160_1 then
		return
	end

	arg_160_0:PlaySingleAction(var_160_0, var_160_4)

	return
end

function var_0_0.OutOfLazy(arg_161_0, arg_161_1, arg_161_2)
	if arg_161_0:GetBlackboardValue(arg_161_0.ladyDict[arg_161_1], "inPending") then
		table.insert({}, function(arg_162_0)
			arg_161_0.shiftLady = arg_161_1

			arg_161_0:ShiftZone(var_0.ladyBaseZone, arg_162_0)

			return
		end)
	end

	seriesAsync({}, arg_161_2)

	return
end

function var_0_0.OutOfPending(arg_163_0, arg_163_1, arg_163_2)
	assert(arg_163_0.wakeUpTalkId)

	local var_163_0 = arg_163_0.wakeUpTalkId

	seriesAsync({
		function(arg_164_0)
			arg_163_0:SetUI(arg_164_0, "blank")

			return
		end,
		function(arg_165_0)
			arg_163_0.shiftLady = arg_163_1

			arg_163_0:ShiftZone(arg_163_0.ladyDict[arg_163_1].ladyBaseZone, arg_165_0)

			return
		end,
		function(arg_166_0)
			arg_163_0:DoTalk(var_163_0, arg_166_0)

			return
		end
	}, function()
		arg_163_0:SetUIStore(arg_163_2, "back")

		return
	end)

	return
end

function var_0_0.ChangeCanWatchState(arg_168_0, arg_168_1)
	local var_168_0

	if arg_168_0:GetBlackboardValue(arg_168_1, "inPending") then
		var_168_0 = tobool(arg_168_0:GetBlackboardValue(arg_168_1, "inDistance"))
	else
		local var_168_1 = arg_168_0.activeLady[arg_168_0:GetBlackboardValue(arg_168_1, "groupId")]

		var_168_1 = var_168_1 and pg.NodeCanvasMgr.GetInstance():GetBlackboradValue("canWatch", arg_168_1.ladyBlackboard)
		var_168_0 = tobool(var_168_1)
	end

	if arg_168_1.blockCanWatch then
		var_168_0 = false
	end

	if (not arg_168_1.nowCanWatchState or arg_168_1.nowCanWatchState ~= var_168_0) and arg_168_1.ladyWatchFloat then
		arg_168_1.nowCanWatchState = var_168_0

		arg_168_0:ShowOrHideCanWatchMark(arg_168_1, arg_168_1.nowCanWatchState)
	end

	return
end

function var_0_0.HandleGameNotification(arg_169_0, arg_169_1, arg_169_2)
	local var_169_0 = arg_169_0:GetCurrentLadyEnv()

	switch(arg_169_1, {
		[Dorm3dMiniGameMediator.OPERATION] = function()
			switch(arg_169_2.miniGameId, {
				[67] = function()
					if arg_169_2.operationCode == "GAME_HIT_AREA" then
						local var_171_0, var_171_1 = unpack(({
							{
								"Face_XYX_1",
								"zhongji"
							},
							{
								"Face_XYX_2",
								"qingji"
							},
							{
								"Face_XYX_3",
								"miss"
							}
						})[arg_169_2.index])

						arg_169_0:PlayFaceAnim(var_169_0, var_171_0)

						if arg_169_0.tfCutIn then
							quickPlayAnimator(arg_169_0.modelCutIn.lady, var_171_1)
							quickPlayAnimator(arg_169_0.modelCutIn.player, var_171_1)
						end
					elseif arg_169_2.operationCode == "GAME_RESULT" then
						if arg_169_2.win then
							arg_169_0:PlayFaceAnim(var_169_0, "Face_XYX_victory")
							arg_169_0:PlaySingleAction(var_169_0, "minigame_win")
						else
							arg_169_0:PlayFaceAnim(var_169_0, "Face_XYX_lose")
							arg_169_0:PlaySingleAction(var_169_0, "minigame_lose")
						end

						setActive(arg_169_0.rtExtraScreen:Find("MiniGameCutIn"), false)
					end

					return
				end,
				[70] = function()
					if arg_169_2.operationCode == "GAME_READY" then
						arg_169_0.cameras[var_0_0.CAMERA.TALK].Follow = nil
						arg_169_0.cameras[var_0_0.CAMERA.TALK].LookAt = nil

						arg_169_0:PlaySingleAction(var_169_0, "shuohua_sikao")
					elseif arg_169_2.operationCode == "ROUND_RESULT" then
						local var_172_0 = arg_169_2.success and {
							"shuohua_wenhou",
							"shuohua_sikao"
						} or {
							"shuohua_yaotou",
							"shuohua_sikao"
						}

						seriesAsync(underscore.map(var_172_0, function(arg_173_0)
							return function(arg_174_0)
								arg_169_0:PlaySingleAction(var_169_0, arg_173_0, arg_174_0)

								return
							end
						end), function()
							return
						end)
					elseif arg_169_2.operationCode == "GAME_RESULT" then
						arg_169_0.cameras[var_0_0.CAMERA.TALK].transform.position = arg_169_0.cameras[var_0_0.CAMERA.TALK].transform.position + arg_169_0.cameras[var_0_0.CAMERA.TALK].transform.right * 0.11

						seriesAsync(underscore.map({
							"shuohua_gandong"
						}, function(arg_176_0)
							return function(arg_177_0)
								arg_169_0:PlaySingleAction(var_169_0, arg_176_0, arg_177_0)

								return
							end
						end), function()
							return
						end)
					end

					return
				end,
				[75] = function()
					if arg_169_2.operationCode == "BEFORE_OPEN_GAME" then
						arg_169_0.cameras[var_0_0.CAMERA.TALK].Follow = nil
						arg_169_0.cameras[var_0_0.CAMERA.TALK].LookAt = nil
					elseif arg_169_2.operationCode == "GAME_RPS_RESULT" then
						if arg_169_2.index == 1 then
							arg_169_0:PlaySingleAction(var_169_0, "ab_shuohua_lianxuyaotou_01")
							arg_169_0:PlayFaceAnim(var_169_0, "Face_weixiao")
						elseif arg_169_2.index == 2 then
							arg_169_0:PlaySingleAction(var_169_0, "ab_shuohua_lianxudiantou_01")
							arg_169_0:PlayFaceAnim(var_169_0, "Face_kaixin")
						end
					elseif arg_169_2.operationCode == "GAME_RESULT" then
						if not arg_169_2.win then
							arg_169_0:PlaySingleAction(var_169_0, "ab_shuohua_taibangle_01")
						end

						arg_169_0:PlayFaceAnim(var_169_0, "Face_kaixin")
					end

					return
				end
			}, function()
				warning("without miniGameId:" .. arg_169_2.miniGameId)

				return
			end)

			if arg_169_2.operationCode == "BEFORE_OPEN_GAME" then
				local var_170_0 = getProxy(PlayerProxy):getPlayerId()

				arg_169_0.highScore = (arg_169_2.miniGameId == 67 or arg_169_2.miniGameId == 70) and PlayerPrefs.GetInt("mg_new_score_" .. tostring(var_170_0) .. "_" .. arg_169_2.miniGameId, 0) or PlayerPrefs.GetInt("mg_score_" .. tostring(var_170_0) .. "_" .. arg_169_2.miniGameId, 0)
			elseif arg_169_2.operationCode == "GAME_RESULT" then
				local var_170_2 = arg_169_2.score

				if arg_169_2.score > arg_169_0.highScore then
					if arg_169_2.miniGameId == 67 or arg_169_2.miniGameId == 70 then
						PlayerPrefs.SetInt("mg_new_score_" .. tostring((getProxy(PlayerProxy):getPlayerId())) .. "_" .. arg_169_2.miniGameId, var_170_2)
					end

					getProxy(Dorm3dChatProxy):TriggerEvent({
						{
							event_type = 159,
							value = var_170_2,
							ship_id = arg_169_0.apartment:GetConfigID()
						}
					})
				end

				pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataMiniGame(2, arg_169_2.score))
			elseif arg_169_2.operationCode == "GAME_CLOSE" and arg_169_2.doTrack == false then
				pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataMiniGame(3))
			end

			return
		end
	})

	return
end

function var_0_0.PerformanceQueue(arg_181_0, arg_181_1, arg_181_2)
	local var_181_0, var_181_1 = pcall(function()
		return require("GameCfg.dorm." .. arg_181_1)
	end)

	if not var_181_0 then
		errorMsg("不存在表演ID对应的Lua:" .. arg_181_1)
		existCall(arg_181_2)

		return
	end

	warning(arg_181_1)

	arg_181_0.performanceInfo = {
		name = arg_181_1
	}

	table.insert({}, function(arg_183_0)
		arg_181_0:SetUI(arg_183_0, "blank")

		return
	end)
	table.insertto({}, underscore.map(var_181_1, function(arg_184_0)
		return switch(arg_184_0.type, {
			function()
				return function(arg_186_0)
					arg_181_0:DoTalk(unpack(arg_184_0.params), arg_186_0, true)

					return
				end
			end,
			function()
				return function(arg_188_0)
					arg_181_0:emit(RoomTouchSystem.SET_TOUCH_EXIT_CALL, arg_188_0)
					arg_181_0:emit(RoomTouchSystem.ENTER_TOUCH_MODE)

					return
				end
			end,
			function()
				return function(arg_190_0)
					arg_181_0:PlaySingleAction(arg_181_0:GetCurrentLadyEnv(), arg_184_0.name, arg_190_0)

					return
				end
			end,
			function()
				return function(arg_192_0)
					arg_181_0:emit(arg_181_0.PLAY_EXPRESSION, arg_184_0)
					arg_192_0()

					return
				end
			end,
			function()
				return function(arg_194_0)
					arg_181_0:ShiftZone(arg_184_0.name, arg_194_0)

					return
				end
			end,
			function()
				return function(arg_196_0)
					arg_181_0.contextData.timeIndex = arg_184_0.params[1]

					local var_196_0 = arg_184_0.params[2] or false

					if Dorm3dSceneMgr.IsSameSceneInfo(arg_181_0.dormSceneMgr.artSceneInfo, arg_181_0.dormSceneMgr.sceneInfo) then
						arg_181_0:SwitchDayNight(arg_181_0.contextData.timeIndex)

						if var_196_0 then
							onNextTick(function()
								arg_181_0:RefreshSlots()

								return
							end)
						end
					end

					arg_181_0:UpdateContactState()
					onNextTick(arg_196_0)

					return
				end
			end,
			function()
				return function(arg_199_0)
					if arg_184_0.name then
						arg_181_0:ActiveCameraByName(arg_184_0.name)
						existCall(arg_199_0)
					else
						arg_181_0:ActiveStateCamera(arg_184_0.params[1], arg_199_0)
					end

					return
				end
			end,
			function()
				return function(arg_201_0)
					if arg_184_0.name == "base" then
						arg_181_0:RevertArtScene(arg_181_0.dormSceneMgr.sceneInfo, arg_201_0)
					else
						arg_181_0:ChangeArtScene(arg_184_0.params.scene .. "|" .. arg_184_0.params.sceneRoot, arg_201_0)
					end

					return
				end
			end,
			function()
				return function(arg_203_0)
					if arg_184_0.name == "load" then
						local var_203_0 = tobool(arg_184_0.params.wait_timeline) and function(arg_204_0)
							arg_181_0.waitForTimeline = arg_204_0

							return
						end

						arg_181_0:LoadTimelineScene(arg_184_0.params.name, true, var_203_0, arg_203_0)
					elseif arg_184_0.name == "unload" then
						arg_181_0:UnloadTimelineScene(arg_184_0.params.name, true, arg_203_0)
					else
						assert(false)
					end

					return
				end
			end,
			function()
				return function(arg_206_0)
					setActive(arg_181_0.uiContainer:Find("walk/btn_back"), false)

					local var_206_0 = arg_181_0:GetCurrentLadyEnv()

					if arg_184_0.name == "change" then
						var_206_0.walkBornPoint = arg_184_0.params.point or "Default"

						arg_181_0:ChangeWalkScene(arg_184_0.name, arg_184_0.params.scene .. "|" .. arg_184_0.params.sceneRoot, arg_206_0)
					elseif arg_184_0.name == "back" then
						var_206_0.walkBornPoint = nil

						arg_181_0:ChangeWalkScene(arg_184_0.name, arg_181_0.dormSceneMgr.sceneInfo, arg_206_0)
					elseif arg_184_0.name == "set" then
						local function var_206_1()
							arg_206_0 = nil

							return existCall(arg_206_0)
						end

						for iter_206_0, iter_206_1 in pairs(arg_184_0.params) do
							switch(iter_206_0, {
								back_button_trigger = function(arg_208_0)
									onButton(arg_181_0, arg_181_0.uiContainer:Find("walk/btn_back"), var_206_1, SFX_DORM_BACK)

									local var_208_0 = IsUnityEditor and arg_208_0

									setActive(arg_181_0.uiContainer:Find("walk/btn_back"), var_208_0)

									return
								end,
								near_trigger = function(arg_209_0)
									if arg_209_0 == true then
										arg_209_0 = 1.5
									end

									arg_181_0.walkNearCallback = arg_209_0 and function(arg_210_0)
										if arg_210_0 < arg_209_0 then
											arg_181_0.walkNearCallback = nil

											var_206_1()
										end

										return
									end or nil

									return
								end
							}, nil, iter_206_1)
						end

						if arg_181_0.firstMoveGuide then
							setActive(arg_181_0.povLayer:Find("Guide"), arg_181_0.firstMoveGuide)

							arg_181_0.firstMoveGuide = nil
						end
					else
						assert(false)
					end

					return
				end
			end,
			function()
				return function(arg_212_0)
					if arg_184_0.name == "set" then
						arg_181_0:emit(RoomIKSystem.SET_IK_CONFIG, arg_181_0:GetCurrentLadyEnv(), arg_184_0.params.state)
						arg_181_0:emit(Dorm3dIKView.SET_BACK_BUTTON_ACTIVE, not arg_184_0.params.hide_back)
						arg_181_0:emit(RoomIKSystem.SET_IK_SPECIAL_CALL, arg_212_0)
						arg_181_0:emit(RoomIKSystem.SET_IK_STATE, true)
					elseif arg_184_0.name == "back" then
						local var_212_0 = arg_181_0:GetCurrentLadyEnv()

						arg_181_0:GetCurrentLadyEnv().ikConfig = arg_184_0.params

						arg_181_0:emit(RoomIKSystem.SET_IK_STATE, false, function()
							var_212_0.ikConfig = nil

							existCall(arg_212_0)

							return
						end)
					else
						assert(false)
					end

					return
				end
			end,
			function()
				return function(arg_215_0)
					local var_215_1 = arg_184_0.params or {}

					arg_181_0.blackSceneInfo = var_215_0(var_215_1, {
						__index = {
							color = "#000000",
							time = 0.3,
							delay = arg_184_0.name == "show" and 0 or 0.5
						}
					})

					if arg_184_0.name == "show" then
						arg_181_0:ShowBlackScreen(true, arg_215_0)
					elseif arg_184_0.name == "hide" then
						arg_181_0:ShowBlackScreen(false, arg_215_0)
					else
						assert(false)
					end

					arg_181_0.blackSceneInfo = nil

					return
				end
			end,
			function()
				return function(arg_217_0)
					local var_217_0 = arg_181_0:GetCurrentLadyEnv()

					if arg_184_0.name == "set" then
						arg_181_0:emit(Dorm3dStockingMgr.SET_STOCKING_STATUS, arg_184_0.params)
					elseif arg_184_0.name == "exit" then
						arg_181_0:emit(Dorm3dStockingMgr.EXIT_STOCKING_STATUS)
					end

					return
				end
			end
		})
	end))
	table.insert({}, function(arg_218_0)
		arg_181_0:SetUI(arg_218_0, "back")

		arg_181_0.performanceInfo = nil

		return
	end)
	seriesAsync({}, arg_181_2)

	return
end

function var_0_0.TriggerContact(arg_219_0, arg_219_1)
	local var_219_1 = Dorm3dRoomMediator.COLLECTION_ITEM
	local var_219_2 = {
		itemId = arg_219_1,
		roomId = arg_219_0.room:GetConfigID()
	}

	var_219_2.groupId = arg_219_0.room:isPersonalRoom() and arg_219_0.apartment:GetConfigID() or 0

	var_219_0(arg_219_0, var_219_1, var_219_2)

	return
end

function var_0_0.UpdateContactState(arg_220_0)
	arg_220_0:SetContactStateDic(arg_220_0.room:getTriggerableCollectItemDic(arg_220_0.contextData.timeIndex))

	return
end

function var_0_0.UpdateFavorDisplay(arg_221_0)
	local var_221_0, var_221_1 = getProxy(ApartmentProxy):getStamina()

	setText(arg_221_0.rtStaminaDisplay:Find("Text"), string.format("%d/%d", var_221_0, var_221_1))
	setActive(arg_221_0.rtStaminaDisplay, false)

	if arg_221_0.apartment then
		setText(arg_221_0.rtFavorLevel:Find("rank/Text"), arg_221_0.apartment.level)

		local var_221_2, var_221_3 = arg_221_0.apartment:getFavor()
		local var_221_4 = arg_221_0.apartment:isMaxFavor()

		setActive(arg_221_0.rtFavorLevel:Find("Max"), var_221_4)
		setActive(arg_221_0.rtFavorLevel:Find("Text"), not var_221_4)
		setText(arg_221_0.rtFavorLevel:Find("Text"), string.format("<color=#ff6698>%d</color>/%d", var_221_2, var_221_3))
	end

	setActive(arg_221_0.rtFavorLevel:Find("red"), Dorm3dLevelLayer.IsShowRed())

	return
end

function var_0_0.UpdateBtnState(arg_222_0)
	local var_222_0 = not arg_222_0.room:isPersonalRoom() or arg_222_0:CheckSystemOpen("Furniture")
	local var_222_1 = Dorm3dFurniture.IsTimelimitShopTip(arg_222_0.room:GetConfigID())

	setActive(arg_222_0.uiContainer:Find("base/left/btn_furniture/tipTimelimit"), var_222_0 and var_222_1)
	setActive(arg_222_0.uiContainer:Find("base/left/btn_furniture/tip"), var_222_0 and not var_222_1 and Dorm3dFurniture.NeedViewTip(arg_222_0.room:GetConfigID()))
	setActive(arg_222_0.uiContainer:Find("base/btn_back/main"), underscore(getProxy(ApartmentProxy):getRawData()):chain():values():filter(function(arg_223_0)
		return tobool(arg_223_0)
	end):any(function(arg_224_0)
		return #arg_224_0:getSpecialTalking() > 0 or arg_224_0:getIconTip() == "main"
	end):value())
	setActive(arg_222_0.uiContainer:Find("base/left/btn_collection/tip"), PlayerPrefs.GetInt("apartment_collection_item", 0) > 0 or PlayerPrefs.GetInt("apartment_collection_recall", 0) > 0)

	return
end

function var_0_0.AddUnlockDisplay(arg_225_0, arg_225_1)
	table.insert(arg_225_0.unlockList, arg_225_1)

	if not isActive(arg_225_0.rtFavorUp) then
		setText(arg_225_0.rtFavorUp:Find("Text"), table.remove(arg_225_0.unlockList, 1))
		setActive(arg_225_0.rtFavorUp, true)
	end

	return
end

function var_0_0.PopFavorTrigger(arg_226_0, arg_226_1)
	local var_226_0 = arg_226_1.cost
	local var_226_1 = arg_226_1.apartment
	local var_226_2 = pg.dorm3d_favor_trigger[arg_226_1.triggerId]

	if pg.dorm3d_favor_trigger[arg_226_1.triggerId].is_repeat == 0 then
		if arg_226_1.triggerId == getDorm3dGameset("drom3d_favir_trigger_onwer")[1] then
			arg_226_0:AddUnlockDisplay(i18n("dorm3d_own_favor"))
		elseif arg_226_1.triggerId == getDorm3dGameset("drom3d_favir_trigger_propose")[1] then
			arg_226_0:AddUnlockDisplay(i18n("dorm3d_pledge_favor"))
		else
			arg_226_0:AddUnlockDisplay(string.format("unknow favor trigger:%d unlock", arg_226_1.triggerId))
		end
	elseif arg_226_1.delta > 0 then
		local var_226_3, var_226_4 = arg_226_1.apartment:getFavor()
		local var_226_5 = var_226_3 + arg_226_1.delta

		setText(arg_226_0.rtFavorUpDaily:Find("bg/Text"), string.format("<size=48>+%d</size>", math.min(9999, arg_226_1.delta)))
		setSlider(arg_226_0.rtFavorUpDaily:Find("bg/slider"), 0, var_226_4, var_226_3)

		local var_226_6 = arg_226_1.isGift and NewPos(-354, 223) or NewPos(-208, 105)

		setAnchoredPosition(arg_226_0.rtFavorUpDaily:Find("bg"), var_226_6)

		local var_226_7 = arg_226_0.rtFavorUpDaily:Find("bg/effect")

		eachChild(var_226_7, function(arg_227_0)
			setActive(arg_227_0, false)

			return
		end)

		local var_226_8

		if var_226_2.effect and var_226_2.effect ~= "" then
			var_226_8 = var_226_7:Find(var_226_2.effect .. "(Clone)")

			if not var_226_8 then
				table.insert({}, function(arg_228_0)
					LoadAndInstantiateAsync("Dorm3D/Effect/Prefab/ExpressionUI", "uifx_dorm3d_yinfu01", function(arg_229_0)
						setParent(arg_229_0, var_226_7)

						var_226_8 = tf(arg_229_0)

						arg_228_0()

						return
					end)

					return
				end)
			else
				setActive(var_226_8, true)
			end
		end

		local var_226_9 = arg_226_0.rtFavorUpDaily:GetComponent("DftAniEvent")

		var_226_9:SetTriggerEvent(function(arg_230_0)
			local var_230_0 = GetComponent(arg_226_0.rtFavorUpDaily:Find("bg/slider"), typeof(Slider))

			LeanTween.value(var_226_3, var_226_5, 0.5):setOnUpdate(System.Action_float(function(arg_231_0)
				var_230_0.value = arg_231_0

				return
			end)):setEase(LeanTweenType.easeInOutQuad):setDelay(0.165):setOnComplete(System.Action(function()
				LeanTween.delayedCall(0.165, System.Action(function()
					if arg_226_0.exited then
						return
					end

					quickPlayAnimator(arg_226_0.rtFavorUpDaily, "favor_out")

					return
				end))

				return
			end))
			pg.CriMgr.GetInstance():PlaySE_V3("ui-dorm_progaress_bar")

			return
		end)
		var_226_9:SetEndEvent(function(arg_234_0)
			setActive(arg_226_0.rtFavorUpDaily, false)

			return
		end)
		seriesAsync({}, function()
			setLocalPosition(arg_226_0.rtFavorUpDaily, arg_226_0:GetLocalPosition(arg_226_0:GetScreenPosition(arg_226_0.ladyDict[var_226_1:GetConfigID()].ladyHeadCenter.position), arg_226_0.rtFavorUpDaily.parent))
			setActive(arg_226_0.rtFavorUpDaily, true)
			SetCompomentEnabled(arg_226_0.rtFavorUpDaily, typeof(Animator), true)
			quickPlayAnimator(arg_226_0.rtFavorUpDaily, "favor_open")

			if var_226_0 > 0 then
				local var_235_0, var_235_1 = getProxy(ApartmentProxy):getStamina()

				setText(arg_226_0.rtStaminaPop:Find("Text/Text (1)"), "-" .. var_226_0)
				setText(arg_226_0.rtStaminaPop:Find("Text"), string.format("%d/%d", var_235_0 + var_226_0, var_235_1))
				setActive(arg_226_0.rtStaminaPop, true)
			end

			return
		end)
	end

	return
end

function var_0_0.PopFavorLevelUp(arg_236_0, arg_236_1, arg_236_2, arg_236_3)
	arg_236_0.isLock = true

	LeanTween.delayedCall(0.33, System.Action(function()
		arg_236_0.isLock = false

		return
	end))

	local var_236_0 = math.floor(arg_236_1.level / 10)

	GetImageSpriteFromAtlasAsync("ui/favor_atlas", math.fmod(arg_236_1.level, 10), arg_236_0.rtLevelUpWindow:Find("panel/bg/item1/mark/level/digit2"))
	GetImageSpriteFromAtlasAsync("ui/favor_atlas", var_236_0, arg_236_0.rtLevelUpWindow:Find("panel/bg/item1/mark/level/digit1"))
	setActive(arg_236_0.rtLevelUpWindow:Find("panel/bg/item1/mark/level/digit1"), var_236_0 > 0)

	local var_236_2

	arg_236_0.clientAward, var_236_2 = Dorm3dIconHelper.SplitStory(arg_236_1:getFavorConfig("levelup_client_item", arg_236_1.level))
	arg_236_0.serverAward = arg_236_2

	local var_236_3 = arg_236_0.rtLevelUpWindow:Find("panel/info/content/itemContent")

	if not arg_236_0.levelItemList then
		arg_236_0.levelItemList = UIItemList.New(var_236_3, var_236_3:Find("tpl"))

		arg_236_0.levelItemList:make(function(arg_238_0, arg_238_1, arg_238_2)
			local var_238_0 = arg_238_1 + 1

			if arg_238_0 == UIItemList.EventUpdate then
				if arg_238_1 < #arg_236_0.serverAward then
					updateDorm3dIcon(arg_238_2, arg_236_0.serverAward[arg_238_1 + 1])
					onButton(arg_236_0, arg_238_2, function()
						arg_236_0:emit(BaseUI.ON_NEW_DROP, {
							style = "dorm",
							drop = arg_236_0.serverAward[var_238_0]
						})

						return
					end, SFX_PANEL)
				else
					Dorm3dIconHelper.UpdateDorm3dIcon(arg_238_2, arg_236_0.clientAward[arg_238_1 + 1 - #arg_236_0.serverAward])
					onButton(arg_236_0, arg_238_2, function()
						arg_236_0:emit(Dorm3dRoomMediator.ON_DROP_CLIENT, {
							data = arg_236_0.clientAward[var_238_0 - #arg_236_0.serverAward]
						})

						return
					end, SFX_PANEL)
				end
			end

			return
		end)
	end

	arg_236_0.levelItemList:align(#arg_236_0.serverAward + #arg_236_0.clientAward)
	setActive(arg_236_0.rtLevelUpWindow, true)
	pg.CriMgr.GetInstance():PlaySE_V3("ui-dorm_upgrade")
	arg_236_0:OverlayPanel(arg_236_0.rtLevelUpWindow)

	function arg_236_0.levelUpCallback()
		arg_236_0.levelUpCallback = nil

		if var_236_2 then
			arg_236_0:PopNewStoryTip(var_236_2)
		end

		existCall(arg_236_3)

		return
	end

	return
end

function var_0_0.PopNewStoryTip(arg_242_0, arg_242_1, arg_242_2)
	local var_242_0 = arg_242_0.uiContainer:Find("base/top/story_tip")

	setActive(var_242_0, true)
	LeanTween.delayedCall(1, System.Action(function()
		setActive(var_242_0, false)

		return
	end))
	setText(var_242_0:Find("Text"), i18n("dorm3d_story_unlock_tip", pg.dorm3d_recall[arg_242_1[2]].name))
	existCall(arg_242_2)

	return
end

function var_0_0.UpdateZoneList(arg_244_0)
	local var_244_0 = arg_244_0.room:isPersonalRoom() and arg_244_0:GetCurrentLadyEnv().ladyBaseZone or arg_244_0:GetAttachedFurnitureName()

	for iter_244_0, iter_244_1 in ipairs(arg_244_0.zoneDatas) do
		local var_244_2

		if iter_244_1:GetWatchCameraName() == var_244_0 then
			setText(arg_244_0.btnZone:Find("Text"), iter_244_1:GetName())

			local var_244_1 = arg_244_0.rtZoneList:GetChild(iter_244_0 - 1)

			setTextColor(var_244_1:Find("Name"), Color.NewHex("5CCAFF"))

			goto label_244_0

			var_244_2 = arg_244_0.rtZoneList:GetChild(iter_244_0 - 1)
		end

		setTextColor(var_244_2:Find("Name"), Color.NewHex("FFFFFF99"))

		::label_244_0::
	end

	return
end

function var_0_0.TalkingEventHandle(arg_245_0, arg_245_1)
	local var_245_0 = {}

	if arg_245_1.data.op_list then
		for iter_245_0, iter_245_1 in ipairs(arg_245_1.data.op_list) do
			table.insert({}, function(arg_246_0)
				local function var_246_0()
					arg_246_0 = nil

					return existCall(arg_246_0)
				end

				switch(iter_245_1.type, {
					action = function()
						arg_245_0:PlaySingleAction(arg_245_0:GetCurrentLadyEnv(), iter_245_1.name, var_246_0)

						return
					end,
					item_action = function()
						arg_245_0:PlaySceneItemAnim(iter_245_1.id, iter_245_1.name)
						var_246_0()

						return
					end,
					extra_item_action = function()
						local var_250_0 = arg_245_0:GetCurrentLadyEnv().extraItems[iter_245_1.name]

						warning(iter_245_1.name)
						warning(var_250_0.trans)

						if var_250_0 then
							var_250_0.trans:GetComponent(typeof(Animator)):PlayInFixedTime(iter_245_1.param)
						end

						var_246_0()

						return
					end,
					timeline = function()
						local var_251_0 = {}

						arg_245_0:emit(RoomTouchSystem.GET_TOUCH_GAME_STATE, {})

						if ({}).inTouchGame then
							arg_245_0:emit(RoomTouchSystem.UPDATE_TOUCH_PANEL, false)
						end

						arg_245_0:PlayTimeline(iter_245_1, function(arg_252_0, arg_252_1)
							arg_245_0:emit(RoomTouchSystem.GET_TOUCH_GAME_STATE, var_251_0)
							arg_245_0:emit(RoomTouchSystem.UPDATE_TOUCH_PANEL, var_251_0.inTouchGame)

							var_245_0.notifiCallback = arg_252_1

							var_246_0()

							return
						end)

						return
					end,
					clickOption = function()
						arg_245_0:DoTalkTouchOption(iter_245_1, arg_245_1.flags, function(arg_254_0)
							var_245_0.optionIndex = arg_254_0

							var_246_0()

							return
						end)

						return
					end,
					wait = function()
						arg_245_0.LTs = arg_245_0.LTs or {}

						table.insert(arg_245_0.LTs, LeanTween.delayedCall(iter_245_1.time, System.Action(var_246_0)).uniqueId)

						return
					end,
					expression = function()
						arg_245_0:emit(arg_245_0.PLAY_EXPRESSION, iter_245_1)
						var_246_0()

						return
					end,
					blackscreen = function()
						arg_245_0.LTs = arg_245_0.LTs or {}

						arg_245_0:ShowBlackScreen(true, function()
							table.insert(arg_245_0.LTs, LeanTween.delayedCall(iter_245_1.time, System.Action(function()
								arg_245_0:ShowBlackScreen(false)
								var_246_0()

								return
							end)).uniqueId)

							return
						end)

						return
					end
				}, function()
					assert(false, "op type error:", iter_245_1.type)

					return
				end)

				if iter_245_1.skip then
					(function()
						arg_246_0 = nil

						return existCall(arg_246_0)
					end)()
				end

				return
			end)
		end
	end

	seriesAsync({}, function()
		if arg_245_1.callbackData then
			arg_245_0:emit(Dorm3dRoomMediator.TALKING_EVENT_FINISH, arg_245_1.callbackData.name, var_245_0)
		end

		return
	end)

	return
end

function var_0_0.CheckQueue(arg_262_0)
	if arg_262_0.inGuide or arg_262_0.uiState ~= "base" then
		return
	end

	if arg_262_0.room:GetConfigID() == 1 and arg_262_0:CheckGuide() then
		-- block empty
	elseif arg_262_0.room:isPersonalRoom() and arg_262_0:CheckLevelUp() then
		-- block empty
	elseif arg_262_0.apartment and arg_262_0:CheckEnterDeal() then
		-- block empty
	elseif arg_262_0.apartment and arg_262_0:CheckGiftExpireSoon() then
		-- block empty
	elseif arg_262_0.apartment and arg_262_0:CheckActiveTalk() then
		-- block empty
	elseif arg_262_0.apartment then
		arg_262_0:CheckFavorTrigger()
	end

	arg_262_0.contextData.hasEnterCheck = true

	return
end

function var_0_0.didEnterCheck(arg_263_0)
	local var_263_0

	if arg_263_0.contextData.specialId then
		var_263_0 = arg_263_0.contextData.specialId
		arg_263_0.contextData.specialId = nil

		arg_263_0:DoTalk(var_263_0, function()
			arg_263_0:closeView()

			return
		end)

		if arg_263_0.contextData.isVideoTalk then
			arg_263_0.contextData.hasEnterCheck = true
		end
	elseif not arg_263_0.contextData.hasEnterCheck and arg_263_0.apartment then
		for iter_263_0, iter_263_1 in ipairs(arg_263_0.apartment:getForceEnterTalking(arg_263_0.room:GetConfigID())) do
			var_263_0 = iter_263_1

			arg_263_0:DoTalk(iter_263_1)

			break
		end
	end

	if var_263_0 and pg.dorm3d_dialogue_group[var_263_0].extend_loading > 0 then
		arg_263_0.contextData.hasEnterCheck = true

		pg.SceneAnimMgr.GetInstance():RegisterDormNextCall(function()
			arg_263_0:FinishEnterResume()

			return
		end)
	else
		if arg_263_0.apartment and arg_263_0.contextData.pendingDic[arg_263_0.apartment:GetConfigID()] then
			arg_263_0.contextData.hasEnterCheck = true
		end

		for iter_263_2, iter_263_3 in pairs(arg_263_0.contextData.pendingDic) do
			arg_263_0:SetInPending(arg_263_0.ladyDict[iter_263_2], iter_263_3)
		end

		arg_263_0.contextData.pendingDic = {}

		arg_263_0:FinishEnterResume()
		arg_263_0:CheckQueue()
	end

	return
end

function var_0_0.CheckGuide(arg_266_0)
	if arg_266_0:GetBlackboardValue(arg_266_0:GetCurrentLadyEnv(), "inPending") then
		return
	end

	if DORM_LOCK_GUIDE then
		return false
	end

	for iter_266_0, iter_266_1 in ipairs({
		{
			name = "DORM3D_GUIDE_03",
			active = function()
				return true
			end
		},
		{
			name = "DORM3D_GUIDE_04",
			active = function()
				return true
			end
		},
		{
			name = "DORM3D_GUIDE_05",
			active = function()
				return arg_266_0:CheckSystemOpen("Furniture")
			end
		},
		{
			name = "DORM3D_GUIDE_07",
			active = function()
				return arg_266_0:CheckSystemOpen("DayNight")
			end
		}
	}) do
		local var_266_0 = pg.NewStoryMgr.GetInstance()

		if not var_266_0:IsPlayed(iter_266_1.name) and iter_266_1.active() then
			arg_266_0:SetAllBlackbloardValue("inGuide", true)
			pg.m02:sendNotification(GAME.STORY_UPDATE, {
				storyId = iter_266_1.name
			})

			local var_266_1 = pg.NewStoryMgr.GetInstance()

			pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataGuide(1, var_266_1:StoryName2StoryId(iter_266_1.name)))
			pg.NewGuideMgr.GetInstance():Play(iter_266_1.name, nil, function()
				pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataGuide(2, pg.NewStoryMgr.GetInstance():StoryName2StoryId(iter_266_1.name)))
				arg_266_0:SetAllBlackbloardValue("inGuide", false)

				return
			end, function()
				pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataGuide(2, pg.NewStoryMgr.GetInstance():StoryName2StoryId(iter_266_1.name)))
				arg_266_0:SetAllBlackbloardValue("inGuide", false)

				return
			end)

			return true
		end
	end

	return false
end

function var_0_0.CheckGiftExpireSoon(arg_272_0)
	if not arg_272_0.room:isPersonalRoom() then
		return false
	end

	local var_272_0 = getProxy(ApartmentProxy):GetShipGroupGiftExpireSoonTipIds(arg_272_0.apartment:GetConfigID())

	if #var_272_0 <= 0 then
		return false
	end

	_.each(var_272_0, function(arg_273_0)
		Dorm3dGift.SetExpireSoonTipFlag(arg_273_0)

		return
	end)
	pg.NewStyleMsgboxMgr.GetInstance():Show(pg.NewStyleMsgboxMgr.TYPE_MSGBOX, {
		title = i18n("dorm3d_gift_overtime_title"),
		contentText = i18n("dorm3d_gift_overtime"),
		btnList = {
			{
				type = pg.NewStyleMsgboxMgr.BUTTON_TYPE.confirm,
				name = i18n("msgbox_text_confirm"),
				func = function()
					arg_272_0:CheckQueue()

					return
				end,
				sound = SFX_CONFIRM
			}
		},
		onClose = function()
			arg_272_0:CheckQueue()

			return
		end
	})

	return true
end

function var_0_0.CheckFavorTrigger(arg_275_0)
	for iter_275_0, iter_275_1 in ipairs({
		{
			triggerId = getDorm3dGameset("drom3d_favir_trigger_onwer")[1],
			active = function()
				return tobool((getProxy(CollectionProxy):getShipGroup(arg_275_0.apartment.configId)))
			end
		},
		{
			triggerId = getDorm3dGameset("drom3d_favir_trigger_propose")[1],
			active = function()
				local var_277_0 = getProxy(CollectionProxy):getShipGroup(arg_275_0.apartment.configId)

				return var_277_0 and var_277_0.married > 0
			end
		}
	}) do
		if arg_275_0.apartment.triggerCountDic[iter_275_1.triggerId] == 0 and iter_275_1.active() then
			arg_275_0:emit(Dorm3dRoomMediator.TRIGGER_FAVOR, arg_275_0.apartment.configId, iter_275_1.triggerId)
		end
	end

	return
end

function var_0_0.CheckEnterDeal(arg_278_0)
	if arg_278_0.contextData.hasEnterCheck then
		return false
	end

	local var_278_0 = "dorm3d_enter_count_" .. arg_278_0.apartment:GetConfigID()
	local var_278_1 = pg.TimeMgr.GetInstance():CurrentSTimeDesc("%Y/%m/%d")

	if PlayerPrefs.GetString("dorm3d_enter_count_day") ~= var_278_1 then
		PlayerPrefs.SetString("dorm3d_enter_count_day", var_278_1)
		PlayerPrefs.SetInt(var_278_0, 1)
	else
		PlayerPrefs.SetInt(var_278_0, PlayerPrefs.GetInt(var_278_0, 0) + 1)
	end

	local var_278_2 = arg_278_0.apartment:getEnterTalking(arg_278_0.room:GetConfigID())

	PlayerPrefs.SetString("DORM3D_DAILY_ENTER", pg.TimeMgr.GetInstance():CurrentSTimeDesc("%Y/%m/%d"))

	if #var_278_2 > 0 then
		arg_278_0:DoTalk(var_278_2[math.random(#var_278_2)])

		return true
	end

	return
end

function var_0_0.CheckActiveTalk(arg_279_0)
	local var_279_0 = arg_279_0:GetCurrentLadyEnv()

	if arg_279_0:GetBlackboardValue(var_279_0, "inPending") then
		return false
	end

	local var_279_1 = arg_279_0.apartment:getZoneTalking(arg_279_0.room:GetConfigID(), var_279_0.ladyBaseZone)

	if #var_279_1 > 0 then
		arg_279_0:DoTalk(var_279_1[1])

		return true
	else
		return false
	end

	return
end

function var_0_0.CheckDistanceTalk(arg_280_0, arg_280_1, arg_280_2)
	for iter_280_0, iter_280_1 in ipairs(getProxy(ApartmentProxy):getApartment(arg_280_1):getDistanceTalking(arg_280_0.room:GetConfigID(), arg_280_0.ladyDict[arg_280_1].ladyBaseZone)) do
		arg_280_0:DoTalk(iter_280_1)

		return
	end

	return
end

function var_0_0.CheckSystemOpen(arg_281_0, arg_281_1)
	if arg_281_0.room:isPersonalRoom() then
		return switch(arg_281_1, {
			Talk = function()
				local var_282_1 = i18n("apartment_level_unenough", 1)
			end,
			Touch = function()
				local var_283_0 = getDorm3dGameset("drom3d_touch_dialogue")[1]
				local var_283_2 = i18n("apartment_level_unenough", var_283_0)
			end,
			Gift = function()
				local var_284_0 = getDorm3dGameset("drom3d_gift_dialogue")[1]
				local var_284_2 = i18n("apartment_level_unenough", var_284_0)
			end,
			PublicGame = function()
				return false
			end,
			Photo = function()
				local var_286_0 = getDorm3dGameset("drom3d_photograph_unlock")[1]
				local var_286_2 = i18n("apartment_level_unenough", var_286_0)
			end,
			Collection = function()
				local var_287_0 = getDorm3dGameset("drom3d_recall_unlock")[1]
				local var_287_2 = i18n("apartment_level_unenough", var_287_0)
			end,
			Furniture = function()
				local var_288_0 = getDorm3dGameset("drom3d_furniture_unlock")[1]
				local var_288_2 = i18n("apartment_level_unenough", var_288_0)
			end,
			DayNight = function()
				local var_289_0 = getDorm3dGameset("drom3d_time_unlock")[1]
				local var_289_2 = i18n("apartment_level_unenough", var_289_0)
			end,
			Accompany = function()
				local var_290_1 = i18n("apartment_level_unenough", 1)
			end,
			MiniGame = function()
				if 1 > arg_281_0.apartment.level then
					local var_291_1 = i18n("apartment_level_unenough", 1)

					return
				elseif #arg_281_0.room:getMiniGames() <= 0 then
					return false, "without minigame config in room:" .. arg_281_0.room.configId
				else
					return true
				end

				return
			end,
			Invite = function()
				return false
			end,
			Performance = function()
				return IsUnityEditor
			end
		}, function()
			return true
		end)
	else
		return switch(arg_281_1, {
			Gift = function()
				return false
			end,
			PublicGame = function()
				return true
			end,
			Furniture = function()
				local var_297_0 = arg_281_0.room:GetFurnitureIDList() or {}
				local var_297_1 = #_.filter(var_297_0, function(arg_298_0)
					return Dorm3dFurniture.New({
						configId = arg_298_0
					}):InShopTime()
				end) > 0

				return #arg_281_0.room:GetFurnitures() > 0 or var_297_1
			end,
			DayNight = function()
				return false
			end,
			Accompany = function()
				return false
			end,
			MiniGame = function()
				return false
			end,
			Performance = function()
				return IsUnityEditor
			end
		}, function()
			return true
		end)
	end

	return
end

function var_0_0.CheckLevelUp(arg_304_0)
	if arg_304_0.apartment:canLevelUp() then
		arg_304_0:emit(Dorm3dRoomMediator.FAVOR_LEVEL_UP, arg_304_0.apartment.configId)

		return true
	end

	return false
end

function var_0_0.EnterTouchMode(arg_305_0, arg_305_1)
	arg_305_0:emit(RoomTouchSystem.ENTER_TOUCH_MODE, arg_305_1)

	return
end

function var_0_0.ExitTouchMode(arg_306_0)
	arg_306_0:emit(RoomTouchSystem.EXIT_TOUCH_MODE)

	return
end

function var_0_0.ExitHeartbeatMode(arg_307_0)
	arg_307_0:emit(RoomTouchSystem.EXIT_HEARTBEAT_MODE)

	return
end

function var_0_0.SwitchIKConfig(arg_308_0, arg_308_1, arg_308_2)
	arg_308_0:emit(RoomIKSystem.SET_IK_CONFIG, arg_308_1, arg_308_2)

	return
end

function var_0_0.SetIKState(arg_309_0, arg_309_1, arg_309_2, arg_309_3)
	arg_309_0:emit(RoomIKSystem.SET_IK_STATE, arg_309_1, arg_309_2, arg_309_3)

	return
end

function var_0_0.TouchModeAction(arg_310_0, arg_310_1, arg_310_2, arg_310_3, ...)
	local var_310_0 = arg_310_0:GetExtraSystem(RoomTouchSystem)

	assert(var_310_0, "RoomTouchSystem not found")

	return var_310_0:TouchModeAction(arg_310_1, arg_310_2, arg_310_3, ...)
end

function var_0_0.OnTriggerIK(arg_311_0, arg_311_1)
	local var_311_0 = arg_311_0:GetExtraSystem(RoomIKSystem)

	assert(var_311_0, "RoomIKSystem not found")

	return var_311_0:OnTriggerIK(arg_311_1)
end

function var_0_0.UpdateTouchGameDisplay(arg_312_0)
	local var_312_0 = arg_312_0:GetExtraSystem(RoomTouchSystem)

	if not var_312_0 then
		return
	end

	arg_312_0:emit(RoomTouchSystem.UPDATE_TOUCH_LEVEL, var_312_0.touchLevel)

	return
end

function var_0_0.UpdateTouchCount(arg_313_0, arg_313_1)
	local var_313_0 = arg_313_0:GetExtraSystem(RoomTouchSystem)

	assert(var_313_0, "RoomTouchSystem not found")

	return var_313_0:UpdateTouchCount(arg_313_1)
end

function var_0_0.DoTouch(arg_314_0, arg_314_1, arg_314_2)
	local var_314_0 = arg_314_0:GetExtraSystem(RoomTouchSystem)

	assert(var_314_0, "RoomTouchSystem not found")

	return var_314_0:DoTouch(arg_314_1, arg_314_2)
end

function var_0_0.CycleIKCameraGroup(arg_315_0)
	arg_315_0:emit(RoomIKSystem.CYCLE_IK_CAMERA_GROUP)

	return
end

function var_0_0.TempHideUI(arg_316_0, arg_316_1, arg_316_2)
	local var_316_0 = defaultValue(arg_316_0.hideCount, 0)

	arg_316_0.hideCount = var_316_0 + (arg_316_1 and 1 or -1)

	assert(arg_316_0.hideCount >= 0)

	if arg_316_0.hideCount * var_316_0 > 0 then
		return existCall(arg_316_2)
	elseif arg_316_0.hideCount > 0 then
		arg_316_0:SetUI(arg_316_2, "blank")
	else
		arg_316_0:SetUI(arg_316_2, "back")
	end

	return
end

function var_0_0.onBackPressed(arg_317_0)
	if arg_317_0.exited or arg_317_0.retainCount > 0 then
		-- block empty
	elseif isActive(arg_317_0.rtLevelUpWindow) then
		triggerButton(arg_317_0.rtLevelUpWindow:Find("bg"))
	elseif arg_317_0.uiState ~= "base" then
		-- block empty
	else
		arg_317_0:closeView()
	end

	return
end

function var_0_0.willExit(arg_318_0)
	if arg_318_0.LTs then
		underscore.map(arg_318_0.LTs, function(arg_319_0)
			LeanTween.cancel(arg_319_0)

			return
		end)

		arg_318_0.LTs = nil
	end

	for iter_318_0, iter_318_1 in pairs(arg_318_0.ladyDict) do
		iter_318_1.wakeUpTalkId = nil
	end

	if arg_318_0.accompanyFavorTimer then
		arg_318_0.accompanyFavorTimer:Stop()

		arg_318_0.accompanyFavorTimer = nil
	end

	if arg_318_0.accompanyPerformanceTimer then
		arg_318_0.accompanyPerformanceTimer:Stop()

		arg_318_0.accompanyPerformanceTimer = nil
	end

	arg_318_0.canTriggerAccompanyPerformance = nil

	arg_318_0.videoPlayer:Destroy()

	if arg_318_0.ikView then
		arg_318_0.ikView:Dispose()

		arg_318_0.ikView = nil
	end

	if arg_318_0.touchView then
		arg_318_0.touchView:Dispose()

		arg_318_0.touchView = nil
	end

	var_0_0.super.willExit(arg_318_0)

	return
end

return var_0_0
