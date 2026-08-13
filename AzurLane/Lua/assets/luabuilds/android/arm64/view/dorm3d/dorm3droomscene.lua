class = var_0_10000

local var_0_0 = "Dorm3dRoomScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.dorm3d.Dorm3dRoomTemplateScene"))

var_0_1.NOTIFY_UI_STATE = "Dorm3dRoomScene.NOTIFY_UI_STATE"

function var_0_1.getUIName(arg_1_0)
	return "Dorm3dMainUI"
end

function var_0_1.SetRoom(arg_2_0, arg_2_1)
	var_0_1.super.SetRoom(arg_2_0, arg_2_1)
	arg_2_0:UpdateContactState()

	return
end

function var_0_1.SetApartment(arg_3_0, arg_3_1)
	arg_3_0.apartment = arg_3_1

	arg_3_0:UpdateFavorDisplay()

	return
end

function var_0_1.InitSubViews(arg_4_0)
	VoiceChatLoader = var_1_10001
	arg_4_0.videoPlayer = var_1_10001.New(arg_4_0._tf)
	Dorm3dStockingView = var_1

	local var_4_0 = var_1.New
	local var_4_1 = arg_4_0._tf
	local var_4_2 = arg_4_0.event

	setmetatable = var_1_10005
	arg_4_0.stockingView = var_4_0(var_4_1, var_4_2, var_1_10005({}, {
		__index = arg_4_0.contextData
	}))
	Dorm3dRTRoleTouchSubView = var_1

	local var_4_3 = var_1.New
	local var_4_4 = arg_4_0.rtRole
	local var_4_5 = var_3.Find(var_4_4, "Touch")
	local var_4_6 = arg_4_0.event

	setmetatable = var_4_4
	arg_4_0.rtRoleTouchSubView = var_4_3(var_4_5, var_4_6, var_4_4({
		onClick = function(arg_5_0)
			local var_5_0 = arg_4_0
			local var_5_1 = var_1.emit

			RoomTouchSystem = var_2_10004

			var_5_1(var_5_0, var_2_10004.ENTER_TOUCH_MODE, arg_5_0)

			return
		end
	}, {
		__index = arg_4_0.contextData
	}))
	Dorm3dAimIKView = var_1

	local var_4_7 = var_1.New
	local var_4_8 = arg_4_0._tf
	local var_4_9 = var_3.Find(var_4_8, "AimIKControl")
	local var_4_10 = arg_4_0.event

	setmetatable = var_4_8
	arg_4_0.aimIKView = var_4_7(var_4_9, var_4_10, var_4_8({}, {
		__index = arg_4_0.contextData
	}))
	Dorm3dIKView = var_1
	arg_4_0.ikView = var_1.New(arg_4_0._tf, arg_4_0.event, {
		GetApartment = function()
			return arg_4_0.apartment
		end,
		GetCurrentLadyEnv = function()
			local var_7_0 = arg_4_0

			return var_0.GetCurrentLadyEnv(var_7_0)
		end,
		GetSceneItem = function(arg_8_0)
			local var_8_0 = arg_4_0

			return var_1.GetSceneItem(var_8_0, arg_8_0)
		end,
		GetScreenPosition = function(arg_9_0, arg_9_1)
			local var_9_0 = arg_4_0

			return var_2.GetScreenPosition(var_9_0, arg_9_0, arg_9_1)
		end,
		GetLocalPosition = function(arg_10_0, arg_10_1)
			local var_10_0 = arg_4_0

			return var_2.GetLocalPosition(var_10_0, arg_10_0, arg_10_1)
		end
	})
	Dorm3dTouchView = var_1
	arg_4_0.touchView = var_1.New(arg_4_0._tf, arg_4_0.event, {})

	return
end

function var_0_1.init(arg_11_0)
	var_0_1.super.init(arg_11_0)

	Shader = var_1

	var_1.SetGlobalFloat("_ScreenClipOff", 1)

	local var_11_0 = arg_11_0._tf

	arg_11_0.uiContainer = var_1.Find(var_11_0, "UI")

	local var_11_1 = arg_11_0.uiContainer
	local var_11_2 = var_1.Find(var_11_1, "base")

	onButton = var_1_10002

	local var_11_3 = arg_11_0
	local var_11_4 = var_11_2
	local var_11_5 = var_11_2.Find(var_11_4, "btn_back")

	local function var_11_6()
		local var_12_0 = arg_11_0
		local var_12_1 = var_0.emit

		BaseUI = var_2_10003

		var_12_1(var_12_0, var_2_10003.ON_BACK)

		return
	end

	SFX_DORM_BACK = var_11_4

	var_1_10002(var_11_3, var_11_5, var_11_6, var_11_4)

	onButton = var_1_10002

	local var_11_7 = arg_11_0
	local var_11_8 = var_11_2
	local var_11_9 = var_11_2.Find(var_11_8, "btn_back/help")

	local function var_11_10()
		pg = var_2_10000

		local var_13_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_13_1 = var_0.ShowMsgBox
		local var_13_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_13_2.type = var_2_10004
		pg = var_2_10004
		var_13_2.helps = var_2_10004.gametip.help_dorm3d_info.tip

		var_13_1(var_13_0, var_13_2)

		return
	end

	SFX_PANEL = var_11_8

	var_1_10002(var_11_7, var_11_9, var_11_10, var_11_8)

	arg_11_0.rtFavorLevel = var_11_2:Find("top/favor_level")
	setActive = var_2

	local var_11_11 = arg_11_0.rtFavorLevel
	local var_11_12 = arg_11_0.room

	var_2(var_11_11, var_5.isPersonalRoom(var_11_12))

	onButton = var_2

	local var_11_13 = arg_11_0
	local var_11_14 = arg_11_0.rtFavorLevel

	local function var_11_15()
		local var_14_0 = {}
		local var_14_1 = arg_11_0
		local var_14_2 = var_1.emit

		Dorm3dRoomMediator = var_2_10004

		local var_14_3 = var_2_10004.OPEN_LEVEL_LAYER
		local var_14_4 = {
			apartment = arg_11_0.apartment,
			timeIndex = arg_11_0.contextData.timeIndex,
			baseCamera = arg_11_0.mainCameraTF
		}
		local var_14_5 = arg_11_0.room

		var_14_4.roomId = var_6.GetConfigID(var_14_5)

		var_14_2(var_14_1, var_14_3, var_14_4)

		return
	end

	SFX_PANEL = var_11_12

	var_2(var_11_13, var_11_14, var_11_15, var_11_12)

	onButton = var_2

	var_2(arg_11_0, var_11_2:Find("top/setting"), function()
		local var_15_0 = arg_11_0
		local var_15_1 = var_0.emit

		Dorm3dRoomMediator = var_2_10003

		var_15_1(var_15_0, var_2_10003.OPEN_SETTING_LAYER)

		return
	end)

	onButton = var_2

	local var_11_16 = arg_11_0
	local var_11_17 = var_11_2
	local var_11_18 = var_11_2.Find(var_11_17, "left/btn_photograph")

	local function var_11_19()
		if #arg_11_0.contextData.groupIds == 0 then
			pg = var_0

			local var_16_0 = var_0.TipsMgr.GetInstance()
			local var_16_1 = var_0.ShowTips

			i18n = var_2_10003

			var_16_1(var_16_0, var_2_10003("dorm3d_photo_no_role"))

			return
		end

		local var_16_2 = arg_11_0
		local var_16_3, var_16_4 = var_0.CheckSystemOpen(var_16_2, "Photo")

		if not var_16_3 then
			pg = var_16_2
			var_2_10004 = var_16_2.TipsMgr.GetInstance()

			var_2.ShowTips(var_2_10004, var_16_4)

			return
		end

		local var_16_5

		if not arg_11_0.apartment then
			var_16_5 = arg_11_0.contextData.groupIds[1]
			pairs = var_3

			for iter_16_0, iter_16_1 in var_3(arg_11_0.ladyDict) do
				var_2_10008 = iter_16_1.ladyBaseZone

				local var_16_6 = arg_11_0

				if var_2_10008 == var_9.GetAttachedFurnitureName(var_16_6) then
					var_16_5 = iter_16_0

					break
				end
			end

			local var_16_7 = arg_11_0
			local var_16_8 = var_3.SetApartment

			getProxy = iter_16_0
			ApartmentProxy = var_2_10008

			local var_16_9 = iter_16_0(var_2_10008)

			var_16_8(var_16_7, var_6.getApartment(var_16_9, var_16_5))
		end

		getProxy = var_16_5
		Dorm3dChatProxy = var_2_10004

		local var_16_10 = var_16_5(var_2_10004)
		local var_16_11 = var_2.TriggerEvent
		local var_16_12 = {}
		local var_16_13 = {
			value = 1,
			event_type = arg_11_0.contextData.timeIndex == 1 and 114 or 119
		}
		local var_16_14 = arg_11_0.apartment

		var_16_13.ship_id = var_7.GetConfigID(var_16_14)
		var_16_12[1] = var_16_13

		var_16_11(var_16_10, var_16_12)

		local var_16_15 = arg_11_0
		local var_16_16 = var_2.OutOfLazy
		local var_16_17 = arg_11_0.apartment

		var_16_16(var_16_15, var_5.GetConfigID(var_16_17), function()
			local var_17_0 = arg_11_0
			local var_17_1 = var_0.emit

			Dorm3dRoomMediator = var_3_10003

			local var_17_2 = var_3_10003.OPEN_CAMERA_LAYER
			local var_17_3 = arg_11_0
			local var_17_4 = arg_11_0.apartment

			var_17_1(var_17_0, var_17_2, var_17_3, var_5.GetConfigID(var_17_4))

			return
		end)

		return
	end

	SFX_PANEL = var_11_17

	var_2(var_11_16, var_11_18, var_11_19, var_11_17)

	onButton = var_2

	local var_11_20 = arg_11_0
	local var_11_21 = var_11_2
	local var_11_22 = var_11_2.Find(var_11_21, "left/btn_collection")

	local function var_11_23()
		local var_18_0 = arg_11_0
		local var_18_1, var_18_2 = var_0.CheckSystemOpen(var_18_0, "Collection")

		if not var_18_1 then
			pg = var_18_0

			local var_18_3 = var_18_0.TipsMgr.GetInstance()

			var_18_0.ShowTips(var_18_3, var_18_2)

			return
		end

		setActive = var_18_0

		local var_18_4 = var_11_2

		var_18_0(var_4.Find(var_18_4, "left/btn_collection/tip"), false)

		PlayerPrefs = var_18_0

		var_18_0.SetInt("apartment_collection_item", 0)

		PlayerPrefs = var_2

		var_2.SetInt("apartment_collection_recall", 0)

		local var_18_5 = arg_11_0
		local var_18_6 = var_2.emit

		Dorm3dRoomMediator = var_5

		local var_18_7 = var_5.OPEN_COLLECTION_LAYER
		local var_18_8 = arg_11_0.room

		var_18_6(var_18_5, var_18_7, var_6.GetConfigID(var_18_8))

		return
	end

	SFX_PANEL = var_11_21

	var_2(var_11_20, var_11_22, var_11_23, var_11_21)

	onButton = var_2

	local var_11_24 = arg_11_0
	local var_11_25 = var_11_2
	local var_11_26 = var_11_2.Find(var_11_25, "left/btn_furniture")

	local function var_11_27()
		local var_19_0 = arg_11_0
		local var_19_1, var_19_2 = var_0.CheckSystemOpen(var_19_0, "Furniture")

		if not var_19_1 then
			pg = var_19_0

			local var_19_3 = var_19_0.TipsMgr.GetInstance()

			var_2.ShowTips(var_19_3, var_19_2)

			return
		end

		local var_19_4 = arg_11_0
		local var_19_5 = var_2.RemoveExtraSystem
		local var_19_6 = {}

		SlideExtraSystem = var_2_10006
		var_19_6[1] = var_2_10006

		var_19_5(var_19_4, var_19_6)

		local var_19_7 = arg_11_0
		local var_19_8 = var_2.emit

		Dorm3dRoomMediator = var_19_6

		var_19_8(var_19_7, var_19_6.OPEN_FURNITURE_SELECT, {
			apartment = arg_11_0.apartment
		})

		arg_11_0.isInFurnitureSelect = true

		return
	end

	SFX_PANEL = var_11_25

	var_2(var_11_24, var_11_26, var_11_27, var_11_25)

	local var_11_28 = arg_11_0.room
	local var_11_29

	if not var_2.isPersonalRoom(var_11_28) then
		var_11_29 = arg_11_0:CheckSystemOpen("Furniture")
		setActive = var_11_1

		var_11_1(var_11_2:Find("left/line_furniture"), var_11_29)

		setActive = var_11_1

		var_11_1(var_11_2:Find("left/btn_furniture"), var_11_29)
	end

	onButton = var_11_29

	local var_11_30 = arg_11_0
	local var_11_31 = var_11_2
	local var_11_32 = var_11_2.Find(var_11_31, "left/btn_accompany")

	local function var_11_33()
		local var_20_0 = arg_11_0
		local var_20_1, var_20_2 = var_0.CheckSystemOpen(var_20_0, "Accompany")

		if not var_20_1 then
			pg = var_20_0

			local var_20_3 = var_20_0.TipsMgr.GetInstance()

			var_2.ShowTips(var_20_3, var_20_2)

			return
		end

		local var_20_4 = arg_11_0.apartment
		local var_20_5 = var_2.GetConfigID(var_20_4)
		local var_20_6
		local var_20_7 = arg_11_0
		local var_20_8 = var_4.emit

		Dorm3dRoomMediator = var_2_10007

		var_20_8(var_20_7, var_2_10007.OPEN_ACCOMPANY_WINDOW, {
			groupId = var_20_5,
			confirmFunc = function(arg_21_0)
				var_20_6 = arg_21_0

				return
			end
		}, function()
			if var_20_6 then
				local var_22_0 = arg_11_0

				var_0.OutOfLazy(var_22_0, var_20_5, function()
					local var_23_0 = arg_11_0

					var_0.EnterAccompanyMode(var_23_0, var_20_6)

					return
				end)
			else
				local var_22_1 = arg_11_0

				var_0.CheckQueue(var_22_1)
			end

			return
		end)

		return
	end

	SFX_PANEL = var_11_31

	var_11_29(var_11_30, var_11_32, var_11_33, var_11_31)

	local var_11_34 = arg_11_0.room

	if not var_2.isPersonalRoom(var_11_34) then
		setActive = var_2

		var_2(var_11_2:Find("left/line_accompany"), false)

		setActive = var_2

		var_2(var_11_2:Find("left/btn_accompany"), false)
	end

	onButton = var_2

	var_2(arg_11_0, var_11_2:Find("left/btn_skin"), function()
		local var_24_0 = arg_11_0

		var_0.ActiveCamera(var_24_0, arg_11_0.cameras[var_0_1.CAMERA.SKIN])

		local var_24_1 = arg_11_0
		local var_24_2 = var_0.emit

		Dorm3dRoomMediator = var_3

		local var_24_3 = var_3.OPEN_SKIN_SELECT_LAYER
		local var_24_4 = arg_11_0.apartment
		local var_24_5 = var_4.GetConfigID(var_24_4)
		local var_24_6 = arg_11_0

		var_24_2(var_24_1, var_24_3, var_24_5, var_5.GetCurrentLadyEnv(var_24_6), nil, function()
			local var_25_0 = arg_11_0

			var_0.ChangePlayerPosition(var_25_0)

			local var_25_1 = arg_11_0

			var_0.ActiveCamera(var_25_1, arg_11_0.cameras[var_0_1.CAMERA.POV])

			return
		end, false)

		return
	end)

	local var_11_35 = arg_11_0.room

	if not var_2.isPersonalRoom(var_11_35) then
		setActive = var_2

		var_2(var_11_2:Find("left/line_skin"), false)

		setActive = var_2

		var_2(var_11_2:Find("left/btn_skin"), false)
	end

	onButton = var_2

	local var_11_36 = arg_11_0
	local var_11_37 = var_11_2
	local var_11_38 = var_11_2.Find(var_11_37, "left/btn_invite")

	local function var_11_39()
		local var_26_0 = arg_11_0
		local var_26_1 = var_0.emit

		Dorm3dRoomMediator = var_2_10003

		local var_26_2 = var_2_10003.OPEN_INVITE_WINDOW
		local var_26_3 = arg_11_0.room
		local var_26_4 = var_4.GetConfigID(var_26_3)

		underscore = var_2_10005

		var_26_1(var_26_0, var_26_2, var_26_4, var_2_10005.rest(arg_11_0.contextData.groupIds, 1))

		return
	end

	SFX_PANEL = var_11_37

	var_2(var_11_36, var_11_38, var_11_39, var_11_37)

	local var_11_40 = arg_11_0.room

	if var_2.isPersonalRoom(var_11_40) then
		setActive = var_2

		var_2(var_11_2:Find("left/line_invite"), false)

		setActive = var_2

		var_2(var_11_2:Find("left/btn_invite"), false)
	end

	arg_11_0.btnZone = var_11_2:Find("right/Zone")
	arg_11_0.rtZoneList = var_11_2:Find("right/Zone/List")
	setActive = var_2

	var_2(arg_11_0.rtZoneList, false)

	onButton = var_2

	local var_11_41 = arg_11_0
	local var_11_42 = arg_11_0.btnZone

	local function var_11_43()
		setActive = var_2_10000

		local var_27_0 = arg_11_0.rtZoneList

		isActive = var_2_10003

		var_2_10000(var_27_0, not var_2_10003(arg_11_0.rtZoneList))

		return
	end

	SFX_PANEL = var_11_37

	var_2(var_11_41, var_11_42, var_11_43, var_11_37)

	UIItemList = var_2

	local var_11_44 = var_2.StaticAlign
	local var_11_45 = arg_11_0.rtZoneList
	local var_11_46 = arg_11_0.rtZoneList

	var_11_44(var_11_45, var_5.GetChild(var_11_46, 0), #arg_11_0.zoneDatas, function(arg_28_0, arg_28_1, arg_28_2)
		UIItemList = var_2_10003

		if arg_28_0 ~= var_2_10003.EventUpdate then
			return
		end

		arg_28_1 = arg_28_1 + 1

		local var_28_0 = arg_11_0.zoneDatas[arg_28_1]

		arg_28_2.name = var_3.GetWatchCameraName(var_28_0)
		setText = var_2_10005

		var_2_10005(arg_28_2:Find("Name"), var_3:GetName())

		setActive = var_2_10005

		var_2_10005(arg_28_2:Find("Line"), arg_28_1 < #arg_11_0.zoneDatas)

		onButton = var_2_10005

		local var_28_1 = arg_11_0
		local var_28_2 = arg_28_2

		local function var_28_3()
			if arg_11_0.uiState ~= "base" then
				return
			end

			setActive = var_0

			var_0(arg_11_0.rtZoneList, false)

			local var_29_0 = arg_11_0

			var_0.ShiftZoneSafe(var_29_0, var_0)

			return
		end

		SFX_PANEL = var_10

		var_2_10005(var_28_1, var_28_2, var_28_3, var_10)

		return
	end)

	local var_11_47 = arg_11_0.uiContainer
	local var_11_48 = var_2.Find(var_11_47, "accompany")

	onButton = var_11_1

	local var_11_49 = arg_11_0
	local var_11_50 = var_11_48
	local var_11_51 = var_11_48.Find(var_11_50, "btn_back")

	local function var_11_52()
		local var_30_0 = arg_11_0

		var_0.ExitAccompanyMode(var_30_0)

		return
	end

	SFX_DORM_BACK = var_11_50

	var_11_1(var_11_49, var_11_51, var_11_52, var_11_50)

	arg_11_0.unlockList = {}

	local var_11_53 = arg_11_0._tf

	arg_11_0.rtFavorUp = var_3.Find(var_11_53, "Toast/favor_up")

	local var_11_54 = arg_11_0.rtFavorUp
	local var_11_55 = var_3.GetComponent(var_11_54, "DftAniEvent")

	var_3.SetEndEvent(var_11_55, function(arg_31_0)
		setActive = var_2_10001

		var_2_10001(arg_11_0.rtFavorUp, false)

		if #arg_11_0.unlockList > 0 then
			setText = var_1

			local var_31_0 = arg_11_0.rtFavorUp
			local var_31_1 = var_3.Find(var_31_0, "Text")

			table = var_4

			var_1(var_31_1, var_4.remove(arg_11_0.unlockList, 1))

			setActive = var_1

			var_1(arg_11_0.rtFavorUp, true)
		end

		return
	end)

	setActive = var_3

	var_3(arg_11_0.rtFavorUp, false)

	local var_11_56 = arg_11_0._tf

	arg_11_0.rtFavorUpDaily = var_3.Find(var_11_56, "Toast/favor_up_daily")
	setActive = var_3

	var_3(arg_11_0.rtFavorUpDaily, false)

	local var_11_57 = arg_11_0._tf

	arg_11_0.rtStaminaPop = var_3.Find(var_11_57, "Toast/stamina")

	local var_11_58 = arg_11_0.rtStaminaPop
	local var_11_59 = var_3.GetComponent(var_11_58, "DftAniEvent")

	var_3.SetTriggerEvent(var_11_59, function(arg_32_0)
		getProxy = var_2_10001
		ApartmentProxy = var_2_10003

		local var_32_0 = var_2_10001(var_2_10003)
		local var_32_1, var_32_2 = var_1.getStamina(var_32_0)

		setText = var_32_0

		local var_32_3 = arg_11_0.rtStaminaPop
		local var_32_4 = var_5.Find(var_32_3, "Text")

		string = var_2_10006

		var_32_0(var_32_4, var_2_10006.format("%d/%d", var_32_1, var_32_2))

		return
	end)
	var_3:SetEndEvent(function(arg_33_0)
		setActive = var_2_10001

		var_2_10001(arg_11_0.rtStaminaPop, false)

		return
	end)

	setActive = var_4

	var_4(arg_11_0.rtStaminaPop, false)

	local var_11_60 = arg_11_0._tf

	arg_11_0.rtLevelUpWindow = var_4.Find(var_11_60, "LevelUpWindow")
	setActive = var_4

	var_4(arg_11_0.rtLevelUpWindow, false)

	onButton = var_4

	local var_11_61 = arg_11_0
	local var_11_62 = arg_11_0.rtLevelUpWindow
	local var_11_63 = var_7.Find(var_11_62, "bg")

	local function var_11_64()
		if arg_11_0.isLock then
			return
		end

		local var_34_0 = arg_11_0

		var_34_0.isLock = true
		quickPlayAnimation = var_34_0

		var_34_0(arg_11_0.rtLevelUpWindow, "anim_dorm3d_levelup_out")

		LeanTween = var_34_0

		local var_34_1 = var_34_0.delayedCall
		local var_34_2 = 0.2

		System = var_3

		var_34_1(var_34_2, var_3.Action(function()
			local var_35_0 = arg_11_0

			var_35_0.isLock = false
			setActive = var_35_0

			var_35_0(arg_11_0.rtLevelUpWindow, false)

			local var_35_1 = arg_11_0

			var_0.UnOverlayPanel(var_35_1, arg_11_0.rtLevelUpWindow, arg_11_0._tf)

			existCall = var_0

			var_0(arg_11_0.levelUpCallback)

			return
		end))

		return
	end

	SFX_PANEL = var_11_62

	var_4(var_11_61, var_11_63, var_11_64, var_11_62)

	local var_11_65 = arg_11_0.uiContainer
	local var_11_66 = var_4.Find(var_11_65, "watch")

	onButton = var_11_58

	local var_11_67 = arg_11_0
	local var_11_68 = var_11_66
	local var_11_69 = var_11_66.Find(var_11_68, "btn_back")

	local function var_11_70()
		local var_36_0 = arg_11_0

		var_0.ExitWatchMode(var_36_0)

		return
	end

	SFX_DORM_BACK = var_11_68

	var_11_58(var_11_67, var_11_69, var_11_70, var_11_68)

	onButton = var_11_58

	local var_11_71 = arg_11_0
	local var_11_72 = var_11_66
	local var_11_73 = var_11_66.Find(var_11_72, "btn_back/help")

	local function var_11_74()
		pg = var_2_10000

		local var_37_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_37_1 = var_0.ShowMsgBox
		local var_37_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_37_2.type = var_2_10004
		i18n = var_2_10004
		var_37_2.helps = var_2_10004("roll_gametip")

		var_37_1(var_37_0, var_37_2)

		return
	end

	SFX_PANEL = var_11_72

	var_11_58(var_11_71, var_11_73, var_11_74, var_11_72)

	arg_11_0.rtStaminaDisplay = var_11_66:Find("stamina")

	local var_11_75 = arg_11_0.uiContainer

	arg_11_0.rtRole = var_5.Find(var_11_75, "watch/Role")
	onButton = var_5

	local var_11_76 = arg_11_0
	local var_11_77 = arg_11_0.rtRole
	local var_11_78 = var_8.Find(var_11_77, "Talk")

	local function var_11_79()
		local var_38_0 = arg_11_0
		local var_38_1 = var_0.GetCurrentLadyEnv(var_38_0).ladyBaseZone
		local var_38_2 = arg_11_0.apartment
		local var_38_3 = var_1.getFurnitureTalking
		local var_38_4 = arg_11_0.room

		if #var_38_3(var_38_2, var_4.GetConfigID(var_38_4), var_38_1) == 0 then
			pg = var_2

			local var_38_5 = var_2.TipsMgr.GetInstance()

			var_2.ShowTips(var_38_5, "without topic")

			return
		end

		local var_38_6 = arg_11_0
		local var_38_7 = var_2.DoTalk

		math = var_5

		var_38_7(var_38_6, var_1[var_5.random(#var_1)], function()
			getDorm3dGameset = var_3_10000

			local var_39_0 = var_3_10000("drom3d_favir_trigger_talk")[1]
			local var_39_1 = arg_11_0
			local var_39_2 = var_1.emit

			Dorm3dRoomMediator = var_3_10004

			var_39_2(var_39_1, var_3_10004.TRIGGER_FAVOR, arg_11_0.apartment.configId, var_39_0)

			return
		end)

		return
	end

	SFX_DORM_CLICK = var_11_77

	var_5(var_11_76, var_11_78, var_11_79, var_11_77)

	setText = var_5

	local var_11_80 = arg_11_0.rtRole
	local var_11_81 = var_7.Find(var_11_80, "Talk/bg/Text")

	i18n = var_11_78

	var_5(var_11_81, var_11_78("dorm3d_talk"))

	onButton = var_5

	local var_11_82 = arg_11_0
	local var_11_83 = arg_11_0.rtRole
	local var_11_84 = var_8.Find(var_11_83, "Gift")

	local function var_11_85()
		local var_40_0 = arg_11_0

		var_0.emit(var_40_0, arg_11_0.SHOW_BLOCK)

		local var_40_1 = arg_11_0

		var_0.ActiveStateCamera(var_40_1, "gift", function()
			local var_41_0 = arg_11_0

			var_0.emit(var_41_0, arg_11_0.HIDE_BLOCK)

			return
		end)

		local var_40_2 = arg_11_0
		local var_40_3 = var_0.emit

		Dorm3dRoomMediator = var_3

		local var_40_4 = var_3.OPEN_GIFT_LAYER
		local var_40_5 = {}
		local var_40_6 = arg_11_0.apartment

		var_40_5.groupId = var_5.GetConfigID(var_40_6)
		var_40_5.baseCamera = arg_11_0.mainCameraTF

		var_40_3(var_40_2, var_40_4, var_40_5)

		return
	end

	SFX_DORM_CLICK = var_11_83

	var_5(var_11_82, var_11_84, var_11_85, var_11_83)

	setText = var_5

	local var_11_86 = arg_11_0.rtRole
	local var_11_87 = var_7.Find(var_11_86, "Gift/bg/Text")

	i18n = var_11_84

	var_5(var_11_87, var_11_84("dorm3d_gift"))

	onButton = var_5

	local var_11_88 = arg_11_0
	local var_11_89 = arg_11_0.rtRole
	local var_11_90 = var_8.Find(var_11_89, "MiniGame")

	local function var_11_91()
		assert = var_2_10000

		var_2_10000(not arg_11_0.nowMiniGameId)

		local var_42_0 = arg_11_0
		local var_42_1 = arg_11_0.room

		var_42_0.nowMiniGameId = var_1.getMiniGames(var_42_1)[1]
		pg = var_42_0

		local var_42_2 = var_42_0.dorm3d_minigame[arg_11_0.nowMiniGameId]
		local var_42_3 = arg_11_0
		local var_42_4 = var_1.GetCurrentLadyEnv(var_42_3)

		getProxy = var_2
		Dorm3dChatProxy = var_2_10004

		local var_42_5 = var_2(var_2_10004)
		local var_42_6 = var_2.TriggerEvent
		local var_42_7 = {}
		local var_42_8 = {
			value = 1,
			event_type = arg_11_0.contextData.timeIndex == 1 and 112 or 117
		}
		local var_42_9 = arg_11_0.apartment

		var_42_8.ship_id = var_7.GetConfigID(var_42_9)
		var_42_7[1] = var_42_8

		local var_42_10 = {
			value = 1,
			event_type = 158
		}
		local var_42_11 = arg_11_0.apartment

		var_42_10.ship_id = var_7.GetConfigID(var_42_11)
		var_42_7[2] = var_42_10

		var_42_6(var_42_5, var_42_7)

		local var_42_12 = {}

		table = var_42_3

		var_42_3.insert(var_42_12, function(arg_43_0)
			local var_43_0 = arg_11_0

			var_1.SetAllBlackbloardValue(var_43_0, "inLockLayer", true)

			local var_43_1 = arg_11_0

			var_1.TempHideUI(var_43_1, true, arg_43_0)

			return
		end)

		if var_42_2.area ~= "" and var_42_4.ladyBaseZone ~= var_42_2.area then
			table = var_3

			var_3.insert(var_42_12, function(arg_44_0)
				local var_44_0 = arg_11_0

				var_1.ShiftZone(var_44_0, var_42_2.area, arg_44_0)

				return
			end)
		end

		local var_42_13
		local var_42_14
		local var_42_15

		if var_42_2.action ~= "" then
			unpack = var_42_15

			local var_42_16

			var_42_15, var_42_16 = var_42_15(var_42_2.action)
			var_42_14 = var_42_16
			var_42_13 = var_42_15
		end

		table = var_42_15

		var_42_15.insert(var_42_12, function(arg_45_0)
			parallelAsync = var_3_10001

			var_3_10001({
				function(arg_46_0)
					if var_42_13 then
						local var_46_0 = arg_11_0

						var_1.PlaySingleAction(var_46_0, var_42_4, var_42_13, arg_46_0)
					else
						arg_46_0()
					end

					return
				end,
				function(arg_47_0)
					local var_47_0 = arg_11_0

					var_1.ActiveStateCamera(var_47_0, "talk", arg_47_0)

					return
				end
			}, arg_45_0)

			return
		end)

		table = var_5

		var_5.insert(var_42_12, function(arg_48_0)
			pg = var_3_10001

			local var_48_0 = var_3_10001.m02
			local var_48_1 = var_1.sendNotification

			GAME = var_3_10004

			local var_48_2 = var_3_10004.APARTMENT_TRACK

			Dorm3dTrackCommand = var_3_10005

			var_48_1(var_48_0, var_48_2, var_3_10005.BuildDataMiniGame(1))

			local var_48_3 = arg_11_0
			local var_48_4 = var_1.HandleGameNotification

			Dorm3dMiniGameMediator = var_48_2

			var_48_4(var_48_3, var_48_2.OPERATION, {
				operationCode = "BEFORE_OPEN_GAME",
				miniGameId = arg_11_0.nowMiniGameId
			})

			local var_48_5 = arg_11_0

			var_1.EnableMiniGameCutIn(var_48_5)

			local var_48_6 = arg_11_0
			local var_48_7 = var_1.emit

			Dorm3dRoomMediator = var_4

			var_48_7(var_48_6, var_4.OPEN_MINIGAME_WINDOW, {
				isDorm3d = true,
				minigameId = arg_11_0.nowMiniGameId
			}, arg_48_0)

			return
		end)

		table = var_5

		var_5.insert(var_42_12, function(arg_49_0)
			local var_49_0 = arg_11_0

			var_1.DisableMiniGameCutIn(var_49_0)

			if var_42_14 then
				local var_49_1 = arg_11_0

				var_1.PlaySingleAction(var_49_1, var_42_4, var_42_14, arg_49_0)
			else
				arg_49_0()
			end

			return
		end)

		seriesAsync = var_5

		var_5(var_42_12, function()
			local var_50_0 = arg_11_0

			var_0.SetAllBlackbloardValue(var_50_0, "inLockLayer", false)

			local var_50_1 = arg_11_0

			var_0.TempHideUI(var_50_1, false)

			arg_11_0.nowMiniGameId = nil

			return
		end)

		return
	end

	SFX_DORM_CLICK = var_11_89

	var_5(var_11_88, var_11_90, var_11_91, var_11_89)

	setText = var_5

	local var_11_92 = arg_11_0.rtRole
	local var_11_93 = var_7.Find(var_11_92, "MiniGame/bg/Text")

	i18n = var_11_90

	var_5(var_11_93, var_11_90("dorm3d_minigame_button1"))

	local var_11_94 = arg_11_0.room

	if not var_5.isPersonalRoom(var_11_94) then
		onButton = var_5

		local var_11_95 = arg_11_0
		local var_11_96 = arg_11_0.rtRole
		local var_11_97 = var_8.Find(var_11_96, "PublicGame")

		switch = var_11_92

		local var_11_98 = var_11_92(arg_11_0.room.id, {
			[4] = function()
				return function()
					local var_52_0 = arg_11_0
					local var_52_1 = var_0.emit

					Dorm3dRoomMediator = var_3_10003

					local var_52_2 = var_3_10003.ENTER_VOLLEYBALL
					local var_52_3 = arg_11_0.apartment

					var_52_1(var_52_0, var_52_2, var_4.GetConfigID(var_52_3))

					return
				end
			end,
			[16] = function()
				return function()
					local var_54_0 = arg_11_0
					local var_54_1 = var_0.emit

					Dorm3dRoomMediator = var_3_10003

					local var_54_2 = var_3_10003.ENTER_DANCE
					local var_54_3 = arg_11_0.apartment

					var_54_1(var_54_0, var_54_2, var_4.GetConfigID(var_54_3))

					return
				end
			end,
			[26] = function()
				return function()
					local var_56_0 = arg_11_0
					local var_56_1 = var_0.emit

					Dorm3dRoomMediator = var_3_10003

					local var_56_2 = var_3_10003.ENTER_CARWASH
					local var_56_3 = arg_11_0.apartment

					var_56_1(var_56_0, var_56_2, var_4.GetConfigID(var_56_3))

					return
				end
			end
		})

		SFX_DORM_CLICK = var_11_96

		var_5(var_11_95, var_11_97, var_11_98, var_11_96)

		setText = var_5

		local var_11_99 = arg_11_0.rtRole
		local var_11_100 = var_7.Find(var_11_99, "PublicGame/bg/Text")

		switch = var_11_97

		var_5(var_11_100, var_11_97(arg_11_0.room.id, {
			[4] = function()
				i18n = var_2_10000

				return var_2_10000("dorm3d_volleyball_button")
			end,
			[16] = function()
				i18n = var_2_10000

				return var_2_10000("dorm3d_dance_button")
			end,
			[26] = function()
				i18n = var_2_10000

				return var_2_10000("dorm3d_carwash_button")
			end
		}))
	end

	onButton = var_5

	local var_11_101 = arg_11_0
	local var_11_102 = arg_11_0.rtRole
	local var_11_103 = var_8.Find(var_11_102, "Performance")

	local function var_11_104()
		local var_60_0 = arg_11_0

		var_0.DoTalk(var_60_0, 20500, function()
			pg = var_3_10000

			local var_61_0 = var_3_10000.TipsMgr.GetInstance()

			var_0.ShowTips(var_61_0, "Success!")

			return
		end)

		return
	end

	SFX_DORM_CLICK = var_11_102

	var_5(var_11_101, var_11_103, var_11_104, var_11_102)

	local var_11_105 = arg_11_0._tf

	arg_11_0.rtFloatPage = var_5.Find(var_11_105, "FloatPage")

	local var_11_106 = arg_11_0.rtFloatPage

	arg_11_0.tplFloat = var_5.Find(var_11_106, "tpl")
	setActive = var_5

	var_5(arg_11_0.tplFloat, false)

	cloneTplTo = var_5

	local var_11_107 = var_5(arg_11_0.tplFloat, arg_11_0.rtFloatPage, "lady")

	eachChild = var_11_65

	var_11_65(var_11_107, function(arg_62_0)
		setActive = var_2_10001

		var_2_10001(arg_62_0, arg_62_0.name == "walk")

		return
	end)

	local var_11_108 = arg_11_0._tf

	arg_11_0._joystick = var_6.Find(var_11_108, "Stick")
	setActive = var_6

	var_6(arg_11_0._joystick, false)

	local var_11_109 = arg_11_0._joystick
	local var_11_110 = var_6.GetComponent

	typeof = var_9
	SlideController = var_11

	local var_11_111 = var_11_110(var_11_109, var_9(var_11))

	var_6.SetStickFunc(var_11_111, function(arg_63_0)
		local var_63_0 = arg_11_0

		var_1.emit(var_63_0, arg_11_0.ON_STICK_MOVE, arg_63_0)

		return
	end)

	local var_11_112 = arg_11_0._tf

	arg_11_0.povLayer = var_7.Find(var_11_112, "POVControl")
	setActive = var_7

	var_7(arg_11_0.povLayer, false)
	;(function()
		local var_64_0 = arg_11_0.povLayer
		local var_64_1 = var_0.Find(var_64_0, "Move")
		local var_64_2 = var_0.GetComponent

		typeof = var_3
		SlideController = var_2_10005

		local var_64_3 = var_64_2(var_64_1, var_3(var_2_10005))

		var_0.AddBeginDragFunc(var_64_3, function(arg_65_0, arg_65_1)
			local var_65_0 = arg_11_0

			var_2.emit(var_65_0, arg_11_0.ON_POV_STICK_MOVE_BEGIN, arg_65_1)

			return
		end)
		var_0:SetStickFunc(function(arg_66_0)
			local var_66_0 = arg_11_0

			var_1.emit(var_66_0, arg_11_0.ON_POV_STICK_MOVE, arg_66_0)

			return
		end)
		var_0:AddDragEndFunc(function(arg_67_0, arg_67_1)
			local var_67_0 = arg_11_0

			var_2.emit(var_67_0, arg_11_0.ON_POV_STICK_MOVE_END, arg_67_1)

			return
		end)

		local var_64_4 = arg_11_0.povLayer
		local var_64_5 = var_1.Find(var_64_4, "View")
		local var_64_6 = var_1.GetComponent

		typeof = var_4
		SlideController = var_2_10006

		local var_64_7 = var_64_6(var_64_5, var_4(var_2_10006))

		var_1.SetStickFunc(var_64_7, function(arg_68_0)
			local var_68_0 = arg_11_0

			var_1.emit(var_68_0, arg_11_0.ON_POV_STICK_VIEW, arg_68_0)

			return
		end)

		return
	end)()

	local var_11_113 = arg_11_0._tf

	arg_11_0.rtExtraScreen = var_8.Find(var_11_113, "ExtraScreen")

	local var_11_114 = arg_11_0.rtExtraScreen

	arg_11_0.rtTimelineScreen = var_8.Find(var_11_114, "TimelineScreen")
	onButton = var_8

	local var_11_115 = arg_11_0
	local var_11_116 = arg_11_0.rtTimelineScreen
	local var_11_117 = var_11.Find(var_11_116, "btn_skip")

	local function var_11_118()
		existCall = var_2_10000

		var_2_10000(arg_11_0.timelineFinishCall)

		return
	end

	SFX_CANCEL = var_11_116

	var_8(var_11_115, var_11_117, var_11_118, var_11_116)
	arg_11_0:InitSubViews()

	arg_11_0.uiStack = {}
	arg_11_0.uiStore = {}

	return
end

function var_0_1.BindEvent(arg_70_0)
	var_0_1.super.BindEvent(arg_70_0)
	arg_70_0:bind(arg_70_0.CLICK_CHARACTER, function(arg_71_0, arg_71_1)
		if arg_70_0.uiState ~= "base" or not arg_70_0.ladyDict[arg_71_1].nowCanWatchState then
			return
		end

		local var_71_0 = {}
		local var_71_1 = arg_70_0.ladyDict[arg_71_1]
		local var_71_2 = arg_70_0

		if var_4.GetBlackboardValue(var_71_2, var_71_1, "inPending") then
			table = var_4

			var_4.insert(var_71_0, function(arg_72_0)
				local var_72_0 = arg_70_0

				var_1.OutOfPending(var_72_0, arg_71_1, arg_72_0)

				return
			end)
		else
			table = var_4

			var_4.insert(var_71_0, function(arg_73_0)
				local var_73_0 = arg_70_0

				var_1.OutOfLazy(var_73_0, arg_71_1, arg_73_0)

				return
			end)
		end

		seriesAsync = var_4

		var_4(var_71_0, function()
			local var_74_0 = arg_70_0.room

			if not var_0.isPersonalRoom(var_74_0) then
				local var_74_1 = arg_70_0
				local var_74_2 = var_0.SetApartment

				getProxy = var_3_10003
				ApartmentProxy = var_3_10005

				local var_74_3 = var_3_10003(var_3_10005)

				var_74_2(var_74_1, var_3.getApartment(var_74_3, arg_71_1))
			end

			local var_74_4 = arg_70_0

			var_0.EnterWatchMode(var_74_4)

			return
		end)

		pg = var_4

		local var_71_3 = var_4.CriMgr.GetInstance()

		var_4.PlaySE_V3(var_71_3, "ui-dorm_touch_v1")

		return
	end)
	arg_70_0:bind(arg_70_0.CLICK_CONTACT, function(arg_75_0, arg_75_1)
		local var_75_0 = arg_70_0

		var_2.TriggerContact(var_75_0, arg_75_1)

		return
	end)
	arg_70_0:bind(arg_70_0.DISTANCE_TRIGGER, function(arg_76_0, arg_76_1, arg_76_2)
		if arg_70_0.uiState == "base" then
			local var_76_0 = arg_70_0

			var_3.CheckDistanceTalk(var_76_0, arg_76_1, arg_76_2)
		end

		return
	end)
	arg_70_0:bind(arg_70_0.WALK_DISTANCE_TRIGGER, function(arg_77_0, arg_77_1, arg_77_2)
		if arg_70_0.apartment then
			local var_77_0 = arg_70_0.apartment

			if var_3.GetConfigID(var_77_0) == arg_77_1 then
				existCall = var_3

				var_3(arg_70_0.walkNearCallback, arg_77_2)
			end
		end

		return
	end)
	arg_70_0:bind(arg_70_0.CHANGE_WATCH, function(arg_78_0, arg_78_1)
		local var_78_0 = arg_70_0

		var_2.ChangeCanWatchState(var_78_0, arg_70_0.ladyDict[arg_78_1])

		return
	end)
	arg_70_0:bind(arg_70_0.ON_ENTER_SECTOR, function(arg_79_0, arg_79_1)
		local var_79_0 = arg_70_0

		var_2.ChangeCanWatchState(var_79_0, arg_70_0.ladyDict[arg_79_1])

		return
	end)
	arg_70_0:bind(arg_70_0.ON_CHANGE_DISTANCE, function(arg_80_0, arg_80_1, arg_80_2)
		local var_80_0 = arg_70_0

		var_3.ChangeCanWatchState(var_80_0, arg_70_0.ladyDict[arg_80_1])

		return
	end)

	return
end

function var_0_1.didEnter(arg_81_0)
	arg_81_0.resumeCallback = arg_81_0.contextData.resumeCallback
	arg_81_0.contextData.resumeCallback = nil

	var_0_1.super.didEnter(arg_81_0)
	arg_81_0:UpdateZoneList()
	arg_81_0:SetUI(function()
		local var_82_0 = arg_81_0

		var_0.didEnterCheck(var_82_0)

		return
	end, "base")

	return
end

function var_0_1.FinishEnterResume(arg_83_0)
	if not arg_83_0.resumeCallback then
		return
	end

	local var_83_0 = arg_83_0.resumeCallback

	arg_83_0.resumeCallback = nil

	return var_83_0()
end

function var_0_1.EnableJoystick(arg_84_0, arg_84_1)
	setActive = var_1_10002

	var_1_10002(arg_84_0._joystick, arg_84_1)

	return
end

function var_0_1.EnablePOVLayer(arg_85_0, arg_85_1)
	setActive = var_1_10002

	var_1_10002(arg_85_0.povLayer, arg_85_1)

	if not arg_85_1 then
		arg_85_0:emit(arg_85_0.ON_POV_STICK_MOVE_END)
	end

	return
end

function var_0_1.SetUIStore(arg_86_0, arg_86_1, ...)
	table = var_1_10002

	var_1_10002.insertto(arg_86_0.uiStore, {
		...
	})

	existCall = var_2

	var_2(arg_86_1)

	return
end

function var_0_1.SetUI(arg_87_0, arg_87_1, ...)
	warning = var_1_10002

	var_1_10002("SetUI", ...)

	::label_87_0::

	rawget = var_1_10002

	if var_1_10002(arg_87_0, "class") ~= var_0_1 then
		repeat
			getmetatable = var_1_10002
			arg_87_0 = var_1_10002(arg_87_0).__index

			goto label_87_0
		until true
	end

	table = var_1_10002

	var_1_10002.insertto(arg_87_0.uiStore, {
		...
	})

	ipairs = var_2

	for iter_87_0, iter_87_1 in var_2(arg_87_0.uiStore) do
		if iter_87_1 == "back" then
			assert = var_1_10007

			var_1_10007(#arg_87_0.uiStack > 0)

			table = var_1_10007
			arg_87_0.uiState = var_1_10007.remove(arg_87_0.uiStack)
		elseif iter_87_1 == arg_87_0.uiState and iter_87_1 == "ik" then
			-- block empty
		else
			table = var_1_10007

			var_1_10007.insert(arg_87_0.uiStack, arg_87_0.uiState)

			arg_87_0.uiState = iter_87_1
		end
	end

	pg = var_2

	local var_87_0 = var_2.m02

	var_2.sendNotification(var_87_0, var_0_1.NOTIFY_UI_STATE, arg_87_0.uiState)

	arg_87_0.uiStore = {}
	eachChild = var_2

	var_2(arg_87_0.uiContainer, function(arg_88_0)
		setActive = var_2_10001

		var_2_10001(arg_88_0, arg_88_0.name == arg_87_0.uiState)

		return
	end)
	arg_87_0:EnablePOVLayer(arg_87_0.uiState == "base" or arg_87_0.uiState == "walk")
	arg_87_0:TempHideContact(arg_87_0.uiState ~= "base")
	arg_87_0:SetFloatEnable(arg_87_0.uiState == "walk")

	setActive = var_2

	var_2(arg_87_0.rtFloatPage, arg_87_0.uiState == "walk")

	if arg_87_0.uiState ~= "stocking" then
		local var_87_1 = arg_87_0.stockingView

		var_2.Hide(var_87_1)
	end

	warning = var_2

	var_2("SetUI to ", arg_87_0.uiState)

	switch = var_2

	var_2(arg_87_0.uiState, {
		base = function()
			local var_89_0 = arg_87_0.room

			if not var_0.isPersonalRoom(var_89_0) then
				local var_89_1 = arg_87_0

				var_0.SetApartment(var_89_1, nil)
			end

			local var_89_2 = arg_87_0

			var_0.UpdateBtnState(var_89_2)

			return
		end,
		watch = function()
			eachChild = var_2_10000

			var_2_10000(arg_87_0.rtRole, function(arg_91_0)
				setActive = var_3_10001

				var_3_10001(arg_91_0, false)

				return
			end)

			underscore = var_2_10000

			local var_90_0 = var_2_10000.filter({
				"Talk",
				"Touch",
				"Gift",
				"MiniGame",
				"PublicGame",
				"Performance"
			}, function(arg_92_0)
				local var_92_0 = arg_87_0

				return var_1.CheckSystemOpen(var_92_0, arg_92_0)
			end)
			local var_90_1 = 0.05

			ipairs = var_2

			for iter_90_0, iter_90_1 in var_2(var_90_0) do
				LeanTween = var_2_10007
				var_2_10007 = var_2_10007.delayedCall

				local var_90_2 = var_90_1

				System = var_2_10010

				var_2_10007(var_90_2, var_2_10010.Action(function()
					setActive = var_3_10000

					local var_93_0 = arg_87_0.rtRole

					var_3_10000(var_2.Find(var_93_0, iter_90_1), true)

					if iter_90_1 == "Touch" then
						local var_93_1 = arg_87_0.apartment
						local var_93_2 = var_0.GetConfigID(var_93_1)
						local var_93_3 = arg_87_0.rtRoleTouchSubView

						var_1.Flush(var_93_3, arg_87_0.room, var_93_2, arg_87_0.ladyDict[var_93_2].ladyBaseZone)
					end

					return
				end))

				var_90_1 = var_90_1 + 0.066
			end

			local var_90_3 = arg_87_0.apartment
			local var_90_4 = var_2.GetConfigID(var_90_3)

			setActive = var_3

			local var_90_5 = arg_87_0.rtRole
			local var_90_6 = var_5.Find(var_90_5, "Gift/bg/Tip")

			Dorm3dGift = iter_90_1

			local var_90_8

			if not iter_90_1.NeedViewTip(var_90_4) then
				getProxy = var_90_8
				ApartmentProxy = var_8

				local var_90_7 = var_90_8(var_8)

				var_90_8 = var_90_8.HasShipGroupGiftExpireSoon(var_90_7, var_90_4)
			end

			var_3(var_90_6, var_90_8)

			return
		end,
		ik = function()
			local var_94_0 = arg_87_0
			local var_94_1 = var_0.emit

			Dorm3dIKView = var_2_10003

			local var_94_2 = var_2_10003.RESET_ENTRY_MENU
			local var_94_3 = arg_87_0.room
			local var_94_4

			if var_4.isPersonalRoom(var_94_3) then
				var_94_4 = not arg_87_0.performanceInfo
			end

			var_94_1(var_94_0, var_94_2, var_94_4)

			return
		end,
		walk = function()
			setText = var_2_10000

			local var_95_0 = arg_87_0.uiContainer
			local var_95_1 = var_2.Find(var_95_0, "walk/dialogue/content")

			i18n = var_2_10003

			local var_95_2 = "dorm3d_removable"
			local var_95_3 = arg_87_0.apartment

			var_2_10000(var_95_1, var_2_10003(var_95_2, var_6.getConfig(var_95_3, "name")))

			return
		end,
		stocking = function()
			local var_96_0 = arg_87_0.stockingView

			var_0.Show(var_96_0)

			return
		end
	})
	arg_87_0:ActiveStateCamera(arg_87_0.uiState, function()
		if arg_87_1 then
			arg_87_1()
		elseif arg_87_0.uiState == "base" then
			local var_97_0 = arg_87_0

			var_0.CheckQueue(var_97_0)
		end

		return
	end)

	return
end

function var_0_1.EnterWatchMode(arg_98_0)
	local var_98_0 = arg_98_0.apartment
	local var_98_1 = var_1.GetConfigID(var_98_0)

	seriesAsync = var_1_10002

	var_1_10002({
		function(arg_99_0)
			local var_99_0 = arg_98_0

			var_1.emit(var_99_0, arg_98_0.SHOW_BLOCK)

			local var_99_1 = arg_98_0

			var_1.SetBlackboardValue(var_99_1, arg_98_0.ladyDict[var_98_1], "inWatchMode", true)

			local var_99_2 = arg_98_0

			var_1.SetUI(var_99_2, arg_99_0, "watch")

			return
		end,
		function(arg_100_0)
			local var_100_0 = arg_98_0

			var_1.emit(var_100_0, arg_98_0.HIDE_BLOCK)

			return
		end
	})

	return
end

function var_0_1.ExitWatchMode(arg_101_0)
	local var_101_0 = arg_101_0.apartment
	local var_101_1 = var_1.GetConfigID(var_101_0)

	seriesAsync = var_1_10002

	var_1_10002({
		function(arg_102_0)
			local var_102_0 = arg_101_0

			var_1.emit(var_102_0, arg_101_0.SHOW_BLOCK)

			local var_102_1 = arg_101_0

			var_1.SetUI(var_102_1, arg_102_0, "back")

			return
		end,
		function(arg_103_0)
			local var_103_0 = arg_101_0

			var_1.SetBlackboardValue(var_103_0, arg_101_0.ladyDict[var_101_1], "inWatchMode", false)

			local var_103_1 = arg_101_0

			var_1.emit(var_103_1, arg_101_0.HIDE_BLOCK)

			local var_103_2 = arg_101_0

			var_1.CheckQueue(var_103_2)

			return
		end
	})

	return
end

function var_0_1.SetInPending(arg_104_0, arg_104_1, arg_104_2)
	local var_104_0 = arg_104_0:GetBlackboardValue(arg_104_1, "groupId")

	pg = var_1_10004

	local var_104_1 = var_1_10004.dorm3d_welcome[arg_104_2]

	arg_104_0:SetBlackboardValue(arg_104_1, "inPending", true)
	arg_104_0:ChangeCanWatchState(arg_104_1)
	arg_104_0:EnableHeadIK(arg_104_1, false)

	arg_104_0.contextData.ladyZone[var_104_0] = var_104_1.area

	arg_104_1:SetZone(arg_104_0.contextData.ladyZone[var_104_0], var_104_1.welcome_staypoint)
	arg_104_0:ChangeCharacterPosition(arg_104_1)

	if var_104_1.item_shield ~= "" then
		arg_104_0.hideItemDic = {}
		ipairs = var_5

		for iter_104_0, iter_104_1 in var_5(var_104_1.item_shield) do
			local var_104_2 = arg_104_0.modelRoot

			if not var_10.Find(var_104_2, iter_104_1) then
				warning = var_1_10011
				string = var_13

				var_1_10011(var_13.format("welcome:%d without hide item:%s", arg_104_2, iter_104_1))
			else
				var_1_10011 = arg_104_0.hideItemDic
				isActive = var_104_2
				var_1_10011[iter_104_1] = var_104_2(var_10)
				setActive = var_1_10011

				var_1_10011(var_10, false)
			end
		end
	end

	onNextTick = var_5

	var_5(function()
		if arg_104_1.tfPendintItem then
			setActive = var_0

			var_0(arg_104_1.tfPendintItem, true)
		end

		local var_105_0 = arg_104_0

		var_0.SwitchAnim(var_105_0, arg_104_1, var_104_1.welcome_idle)

		return
	end)

	arg_104_0.wakeUpTalkId = var_104_1.welcome_talk

	return
end

function var_0_1.SetOutPending(arg_106_0, arg_106_1)
	arg_106_0:SetBlackboardValue(arg_106_1, "inPending", false)
	arg_106_0:ChangeCanWatchState(arg_106_1)
	arg_106_0:EnableHeadIK(arg_106_1, true)

	arg_106_0.wakeUpTalkId = nil

	if arg_106_1.tfPendintItem then
		setActive = var_2

		var_2(arg_106_1.tfPendintItem, false)
	end

	if arg_106_0.hideItemDic then
		pairs = var_2

		for iter_106_0, iter_106_1 in var_2(arg_106_0.hideItemDic) do
			setActive = var_7

			local var_106_0 = arg_106_0.modelRoot

			var_7(var_9.Find(var_106_0, iter_106_0), iter_106_1)
		end

		arg_106_0.hideItemDic = nil
	end

	return
end

function var_0_1.IsModeInHidePending(arg_107_0, arg_107_1)
	pairs = var_1_10002

	for iter_107_0, iter_107_1 in var_1_10002(arg_107_0.ladyDict) do
		if iter_107_1.hideItemDic and iter_107_1.hideItemDic[arg_107_1] ~= nil then
			return true
		end
	end

	return false
end

function var_0_1.EnterAccompanyMode(arg_108_0, arg_108_1)
	pg = var_1_10002

	local var_108_0 = var_1_10002.dorm3d_accompany[arg_108_1]
	local var_108_1
	local var_108_2

	if var_108_0.sceneInfo ~= "" then
		unpack = var_5
		string = var_1_10007
		var_108_1, var_108_2 = var_5(var_1_10007.split(var_108_0.sceneInfo, "|"))
	end

	local var_108_3 = {
		type = "timeline",
		name = var_108_0.timeline,
		scene = var_108_1,
		sceneRoot = var_108_2,
		accompanys = {}
	}

	ipairs = var_6

	for iter_108_0, iter_108_1 in var_6(var_108_0.jump_trigger) do
		unpack = var_1_10011

		local var_108_4

		var_1_10011, var_108_4 = var_1_10011(iter_108_1)
		var_108_3.accompanys[var_1_10011] = var_108_4
	end

	unpack = var_6

	local var_108_5, var_108_6 = var_6(var_108_0.favor)

	getProxy = var_8
	Dorm3dChatProxy = iter_108_1

	local var_108_7 = var_8(iter_108_1)
	local var_108_8 = var_8.TriggerEvent
	local var_108_9 = {}
	local var_108_10 = {
		value = 1,
		event_type = 161
	}
	local var_108_11 = arg_108_0.apartment

	var_108_10.ship_id = var_13.GetConfigID(var_108_11)
	var_108_9[1] = var_108_10

	var_108_8(var_108_7, var_108_9)

	getProxy = var_108_8
	ApartmentProxy = var_108_7

	local var_108_12 = var_108_8(var_108_7)

	var_8.RecordAccompanyTime(var_108_12)

	pg = var_8

	local var_108_13 = var_8.m02
	local var_108_14 = var_8.sendNotification

	GAME = var_108_9

	local var_108_15 = var_108_9.APARTMENT_TRACK

	Dorm3dTrackCommand = var_108_10

	var_108_14(var_108_13, var_108_15, var_108_10.BuildDataAccompany(1, var_108_0.ship_id, var_108_0.performance_time, 0, var_108_1 or arg_108_0.dormSceneMgr.artSceneInfo))

	local var_108_16 = {}

	table = iter_108_0

	iter_108_0.insert(var_108_16, function(arg_109_0)
		local var_109_0 = arg_108_0

		var_1.SetUI(var_109_0, arg_109_0, "blank", "accompany")

		return
	end)

	table = var_9

	var_9.insert(var_108_16, function(arg_110_0)
		arg_108_0.accompanyFavorCount = 0

		local var_110_0 = arg_108_0

		Timer = var_2
		var_110_0.accompanyFavorTimer = var_2.New(function()
			arg_108_0.accompanyFavorCount = arg_108_0.accompanyFavorCount + 1

			return
		end, var_108_5, -1)

		local var_110_1 = arg_108_0.accompanyFavorTimer

		var_1.Start(var_110_1)

		local var_110_2 = arg_108_0

		Timer = var_2
		var_110_2.accompanyPerformanceTimer = var_2.New(function()
			arg_108_0.canTriggerAccompanyPerformance = true

			return
		end, var_108_0.performance_time, -1)

		local var_110_3 = arg_108_0.accompanyPerformanceTimer

		var_1.Start(var_110_3)

		local var_110_4 = arg_108_0

		var_1.PlayTimeline(var_110_4, var_108_3, function(arg_113_0, arg_113_1)
			arg_113_1()
			arg_110_0()

			return
		end)

		return
	end)

	seriesAsync = var_9

	var_9(var_108_16, function()
		assert = var_2_10000

		var_2_10000(arg_108_0.accompanyFavorTimer)

		local var_114_0 = arg_108_0.accompanyFavorTimer

		var_0.Stop(var_114_0)

		local var_114_1 = arg_108_0

		var_114_1.accompanyFavorTimer = nil
		assert = var_114_1

		var_114_1(arg_108_0.accompanyPerformanceTimer)

		local var_114_2 = arg_108_0.accompanyPerformanceTimer

		var_0.Stop(var_114_2)

		arg_108_0.accompanyPerformanceTimer = nil

		local var_114_3 = arg_108_0

		var_114_3.canTriggerAccompanyPerformance = nil
		math = var_114_3

		local var_114_4 = var_114_3.min
		local var_114_5 = arg_108_0.accompanyFavorCount

		getProxy = var_2_10003
		ApartmentProxy = var_2_10005

		local var_114_6 = var_2_10003(var_2_10005)

		if var_114_4(var_114_5, var_3.getStamina(var_114_6)) > 0 then
			local var_114_7 = var_108_6[var_0]

			warning = var_114_5

			var_114_5(var_114_7)

			var_2_10004 = arg_108_0
			var_114_5 = var_114_5.emit
			Dorm3dRoomMediator = var_114_6

			var_114_5(var_2_10004, var_114_6.TRIGGER_FAVOR, arg_108_0.apartment.configId, var_114_7)
		end

		local var_114_8 = 0

		getProxy = var_114_5
		ApartmentProxy = var_2_10004

		local var_114_9 = var_114_5(var_2_10004)

		if var_2.GetAccompanyTime(var_114_9) then
			pg = var_3

			local var_114_10 = var_3.TimeMgr.GetInstance()

			var_114_8 = var_3.GetServerTime(var_114_10) - var_2
		end

		pg = var_3

		local var_114_11 = var_3.m02
		local var_114_12 = var_3.sendNotification

		GAME = var_2_10006

		local var_114_13 = var_2_10006.APARTMENT_TRACK

		Dorm3dTrackCommand = var_2_10007

		local var_114_14 = var_2_10007.BuildDataAccompany
		local var_114_15 = 2
		local var_114_16 = var_108_0.ship_id
		local var_114_17 = var_108_0.performance_time
		local var_114_18 = var_114_8
		local var_114_19

		if not var_108_1 then
			var_114_19 = arg_108_0.dormSceneMgr.artSceneInfo
		end

		var_114_12(var_114_11, var_114_13, var_114_14(var_114_15, var_114_16, var_114_17, var_114_18, var_114_19))

		local var_114_20 = arg_108_0

		var_3.SetUI(var_114_20, nil, "back", "back")

		return
	end)

	return
end

function var_0_1.ExitAccompanyMode(arg_115_0)
	existCall = var_1_10001

	var_1_10001(arg_115_0.timelineFinishCall)

	return
end

function var_0_1.EnterTouchPerformance(arg_116_0)
	local var_116_0 = arg_116_0:GetCurrentLadyEnv()
	local var_116_1 = arg_116_0.room
	local var_116_2 = var_2.getApartmentZoneConfig
	local var_116_3 = var_116_0.ladyBaseZone
	local var_116_4 = "touch_performance"
	local var_116_5 = arg_116_0.apartment

	if not var_116_2(var_116_1, var_116_3, var_116_4, var_7.GetConfigID(var_116_5)) or var_2 == 0 then
		local var_116_6 = arg_116_0
		local var_116_7 = arg_116_0.emit

		RoomTouchSystem = var_116_4

		var_116_7(var_116_6, var_116_4.ENTER_TOUCH_MODE)
	else
		arg_116_0:DoTalk(var_2)
	end

	return
end

function var_0_1.ChangeWalkScene(arg_117_0, arg_117_1, arg_117_2, arg_117_3)
	local var_117_0 = arg_117_0:GetCurrentLadyEnv()

	seriesAsync = var_1_10005

	var_1_10005({
		function(arg_118_0)
			local var_118_0 = arg_117_0

			var_1.ChangeArtScene(var_118_0, arg_117_2, arg_118_0)

			return
		end,
		function(arg_119_0)
			local var_119_0 = arg_117_0

			var_1.ChangeSubScene(var_119_0, arg_117_2, arg_119_0)

			return
		end,
		function(arg_120_0)
			local var_120_0 = arg_117_0

			var_1.emit(var_120_0, arg_117_0.SHOW_BLOCK)

			if arg_117_1 == "back" then
				local var_120_1 = arg_117_0

				var_1.SetUI(var_120_1, arg_120_0, "back")
			elseif arg_117_1 == "change" and arg_117_0.uiState ~= "walk" then
				local var_120_2 = arg_117_0

				var_1.SetUI(var_120_2, arg_120_0, "walk")
			else
				arg_120_0()
			end

			return
		end
	}, function()
		local var_121_0 = arg_117_0

		var_0.emit(var_121_0, arg_117_0.HIDE_BLOCK)

		local var_121_1 = arg_117_0

		var_0.SetBlackboardValue(var_121_1, var_117_0, "inWalk", arg_117_1 == "change")

		existCall = var_0

		var_0(arg_117_3)

		return
	end)

	return
end

function var_0_1.EnterWalkMode(arg_122_0)
	local var_122_0 = arg_122_0.apartment
	local var_122_1 = var_1.GetConfigID(var_122_0)
	local var_122_2 = arg_122_0.ladyDict[var_122_1]

	seriesAsync = var_122_0

	var_122_0({
		function(arg_123_0)
			local var_123_0 = arg_122_0

			var_1.emit(var_123_0, arg_122_0.SHOW_BLOCK)

			local var_123_1 = arg_122_0

			var_1.HideCharacter(var_123_1, var_122_1)

			local var_123_2 = arg_122_0

			var_1.SetBlackboardValue(var_123_2, var_122_2, "inWalk", true)

			local var_123_3 = arg_122_0

			var_1.SetUI(var_123_3, arg_123_0, "walk")

			return
		end,
		function(arg_124_0)
			local var_124_0 = arg_122_0

			var_1.emit(var_124_0, arg_122_0.HIDE_BLOCK)

			local var_124_1 = arg_122_0

			var_1.ChangeArtScene(var_124_1, arg_122_0.walkInfo.scene .. "|" .. arg_122_0.walkInfo.sceneRoot, arg_124_0)

			return
		end,
		function(arg_125_0)
			local var_125_0 = arg_122_0

			var_1.LoadSubScene(var_125_0, arg_122_0.walkInfo, arg_125_0)

			return
		end
	}, function()
		return
	end)

	return
end

function var_0_1.ExitWalkMode(arg_127_0)
	local var_127_0 = arg_127_0.apartment
	local var_127_1 = var_1.GetConfigID(var_127_0)
	local var_127_2 = arg_127_0.ladyDict[var_127_1]

	seriesAsync = var_127_0

	var_127_0({
		function(arg_128_0)
			local var_128_0 = arg_127_0

			var_1.RevertArtScene(var_128_0, arg_127_0.walkLastSceneInfo, arg_128_0)

			return
		end,
		function(arg_129_0)
			local var_129_0 = arg_127_0

			var_1.UnloadSubScene(var_129_0, arg_127_0.walkInfo, arg_129_0)

			return
		end,
		function(arg_130_0)
			local var_130_0 = arg_127_0

			var_1.emit(var_130_0, arg_127_0.SHOW_BLOCK)

			local var_130_1 = arg_127_0

			var_1.SetUI(var_130_1, arg_130_0, "back")

			return
		end
	}, function()
		local var_131_0 = arg_127_0

		var_0.emit(var_131_0, arg_127_0.HIDE_BLOCK)

		local var_131_1 = arg_127_0

		var_0.RevertCharacter(var_131_1, var_127_1)

		local var_131_2 = arg_127_0

		var_0.SetBlackboardValue(var_131_2, var_127_2, "inWalk", false)

		local var_131_3 = arg_127_0.walkExitCall

		arg_127_0.walkExitCall = nil
		arg_127_0.walkLastSceneInfo = nil

		local var_131_4 = arg_127_0

		var_131_4.walkInfo = nil
		existCall = var_131_4

		var_131_4(var_131_3)

		return
	end)

	return
end

function var_0_1.EnableMiniGameCutIn(arg_132_0)
	if not arg_132_0.tfCutIn then
		return
	end

	local var_132_0 = arg_132_0.rtExtraScreen
	local var_132_1 = var_1.Find(var_132_0, "MiniGameCutIn")

	setActive = var_1_10002

	var_1_10002(var_132_1, true)

	GetOrAddComponent = var_1_10002

	local var_132_2 = var_1_10002(var_132_1:Find("bg/mask/cut_in"), "CameraRTUI")

	setActive = var_132_0

	var_132_0(var_132_2, true)

	pg = var_132_0

	local var_132_3 = var_132_0.CameraRTMgr.GetInstance()
	local var_132_4 = var_3.Bind
	local var_132_5 = var_132_2
	local var_132_6 = arg_132_0.tfCutIn
	local var_132_7 = var_7.Find(var_132_6, "TestCamera")
	local var_132_8 = var_7.GetComponent

	typeof = var_10
	Camera = var_1_10012

	var_132_4(var_132_3, var_132_5, var_132_8(var_132_7, var_10(var_1_10012)))

	quickPlayAnimator = var_132_4

	var_132_4(arg_132_0.modelCutIn.lady, "Idle")

	quickPlayAnimator = var_132_4

	var_132_4(arg_132_0.modelCutIn.player, "Idle")

	setActive = var_132_4

	var_132_4(arg_132_0.tfCutIn, true)

	return
end

function var_0_1.DisableMiniGameCutIn(arg_133_0)
	if not arg_133_0.tfCutIn then
		return
	end

	local var_133_0 = arg_133_0.rtExtraScreen
	local var_133_1 = var_1.Find(var_133_0, "MiniGameCutIn")

	GetOrAddComponent = var_1_10002

	local var_133_2 = var_1_10002(var_133_1:Find("bg/mask/cut_in"), "CameraRTUI")

	pg = var_133_0

	local var_133_3 = var_133_0.CameraRTMgr.GetInstance()

	var_3.Clean(var_133_3, var_133_2)

	setActive = var_3

	var_3(var_133_1, false)

	setActive = var_3

	var_3(arg_133_0.tfCutIn, false)

	return
end

function var_0_1.DoTalk(arg_134_0, arg_134_1, arg_134_2)
	::label_134_0::

	rawget = var_1_10003

	if var_1_10003(arg_134_0, "class") ~= var_0_1 then
		repeat
			getmetatable = var_1_10003
			arg_134_0 = var_1_10003(arg_134_0).__index

			goto label_134_0
		until true
	end

	if arg_134_0.apartment and arg_134_0:GetBlackboardValue(arg_134_0:GetCurrentLadyEnv(), "inTalking") then
		errorMsg = var_3

		var_3("Talking block:" .. arg_134_1)

		return
	end

	local var_134_0 = arg_134_0.room
	local var_134_3, var_134_4

	if not var_3.isPersonalRoom(var_134_0) then
		pg = var_3

		local var_134_1 = var_3.dorm3d_dialogue_group[arg_134_1].char_id

		if arg_134_0.apartment then
			assert = var_134_4

			local var_134_2 = arg_134_0.apartment

			var_134_3 = var_134_3.GetConfigID(var_134_2) == var_134_1

			var_134_4(var_134_3)
		else
			var_134_3 = arg_134_0
			var_134_4 = arg_134_0.SetApartment
			getProxy = var_1_10007
			ApartmentProxy = var_1_10009

			local var_134_5 = var_1_10007(var_1_10009)

			var_134_4(var_134_3, var_7.getApartment(var_134_5, var_134_1))
		end
	end

	local var_134_6 = arg_134_0:GetCurrentLadyEnv()

	if arg_134_1 == 26 and not arg_134_0.apartment.talkDic[arg_134_1] then
		arg_134_0.firstTimelineTouch = true
		arg_134_0.firstMoveGuide = true
	end

	getProxy = var_134_4
	Dorm3dChatProxy = var_134_3

	local var_134_7 = var_134_4(var_134_3)
	local var_134_8 = var_4.TriggerEvent
	local var_134_9 = {}
	local var_134_10 = {
		value = 1,
		event_type = arg_134_0.contextData.timeIndex == 1 and 110 or 115
	}
	local var_134_11 = arg_134_0.apartment

	var_134_10.ship_id = var_9.GetConfigID(var_134_11)
	var_134_9[1] = var_134_10

	local var_134_12 = {
		value = 1,
		event_type = 155
	}
	local var_134_13 = arg_134_0.apartment

	var_134_12.ship_id = var_9.GetConfigID(var_134_13)
	var_134_9[2] = var_134_12

	var_134_8(var_134_7, var_134_9)

	local var_134_14 = {}

	if arg_134_0:GetBlackboardValue(var_134_6, "inPending") then
		table = var_5

		var_5.insert(var_134_14, function(arg_135_0)
			local var_135_0 = arg_134_0
			local var_135_1 = var_1.OutOfLazy
			local var_135_2 = arg_134_0.apartment

			var_135_1(var_135_0, var_4.GetConfigID(var_135_2), arg_135_0)

			return
		end)
	end

	pg = var_5

	local var_134_15 = var_5.dorm3d_dialogue_group[arg_134_1].performance_type == 1
	local var_134_16

	table = var_8

	var_8.insert(var_134_14, function(arg_136_0)
		local var_136_0 = arg_134_0

		var_1.emit(var_136_0, arg_134_0.SHOW_BLOCK)

		local var_136_1 = arg_134_0

		var_1.SetBlackboardValue(var_136_1, var_134_6, var_134_15 and "inPerformance" or "inTalking", true)

		local var_136_2 = arg_134_0
		local var_136_3 = var_1.emit

		Dorm3dRoomMediator = var_4

		var_136_3(var_136_2, var_4.DO_TALK, arg_134_1, function(arg_137_0)
			var_134_16 = arg_137_0

			arg_136_0()

			return
		end)

		return
	end)

	table = var_8

	var_8.insert(var_134_14, function(arg_138_0)
		pg = var_2_10001

		local var_138_0 = var_2_10001.m02
		local var_138_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_138_2 = var_2_10004.APARTMENT_TRACK

		Dorm3dTrackCommand = var_2_10005

		local var_138_3 = var_2_10005.BuildDataDialog
		local var_138_4 = arg_134_0.apartment.configId
		local var_138_5 = arg_134_0.apartment.level
		local var_138_6 = arg_134_1
		local var_138_7 = var_0.type
		local var_138_8 = arg_134_0.room
		local var_138_9 = var_11.getZoneConfig
		local var_138_10 = arg_134_0
		local var_138_11 = var_138_9(var_138_8, var_14.GetCurrentLadyEnv(var_138_10).ladyBaseZone, "id")
		local var_138_12 = var_0.action_type

		table = var_138_8

		local var_138_13 = var_138_8.CastToString(var_0.trigger_config)
		local var_138_14 = arg_134_0.room

		var_138_1(var_138_0, var_138_2, var_138_3(var_138_4, var_138_5, var_138_6, var_138_7, var_138_11, var_138_12, var_138_13, var_14.GetConfigID(var_138_14)))

		pg = var_138_1

		local var_138_15 = var_138_1.NewGuideMgr.GetInstance()

		if var_1.IsBusy(var_138_15) then
			pg = var_1

			local var_138_16 = var_1.NewGuideMgr.GetInstance()

			var_1.Pause(var_138_16)
		end

		local var_138_17 = arg_134_0

		var_1.SetUI(var_138_17, arg_138_0, "blank")

		return
	end)

	if var_5.trigger_area and var_5.trigger_area ~= "" then
		table = var_8

		var_8.insert(var_134_14, function(arg_139_0)
			local var_139_0 = arg_134_0

			var_1.ShiftZone(var_139_0, var_0.trigger_area, arg_139_0)

			return
		end)
	end

	if var_5.performance_type == 0 then
		table = var_8

		var_8.insert(var_134_14, function(arg_140_0)
			local var_140_0 = arg_134_0

			var_1.emit(var_140_0, arg_134_0.HIDE_BLOCK)

			if arg_134_0.contextData.isVideoTalk then
				local var_140_1 = arg_134_0.videoPlayer

				var_1.ExecuteAction(var_140_1, "Play", var_0.story, function()
					onDelayTick = var_3_10000

					var_3_10000(arg_140_0, 0.001)

					return
				end)
			else
				pg = var_1

				local var_140_2 = var_1.NewStoryMgr.GetInstance()

				var_1.ForceManualPlay(var_140_2, var_0.story, function()
					onDelayTick = var_3_10000

					var_3_10000(arg_140_0, 0.001)

					return
				end, true)
			end

			return
		end)
	elseif var_5.performance_type == 1 then
		table = var_8

		var_8.insert(var_134_14, function(arg_143_0)
			local var_143_0 = arg_134_0

			var_1.emit(var_143_0, arg_134_0.HIDE_BLOCK)

			local var_143_1 = arg_134_0

			var_1.PerformanceQueue(var_143_1, var_0.story, arg_143_0)

			return
		end)
	else
		assert = var_8

		var_8(false)
	end

	table = var_8

	var_8.insert(var_134_14, function(arg_144_0)
		local var_144_0 = arg_134_0

		var_1.emit(var_144_0, arg_134_0.SHOW_BLOCK)
		arg_144_0()

		return
	end)

	table = var_8

	var_8.insert(var_134_14, function(arg_145_0)
		pg = var_2_10001

		local var_145_0 = var_2_10001.NewStoryMgr.GetInstance()

		if var_1.StoryName2StoryId(var_145_0, var_0.story) then
			local var_145_1 = "1"

			pg = var_145_0
			var_2_10005 = var_145_0.m02

			local var_145_2 = var_3.sendNotification

			GAME = var_2_10006

			local var_145_3 = var_2_10006.APARTMENT_TRACK

			Dorm3dTrackCommand = var_2_10007

			var_145_2(var_2_10005, var_145_3, var_2_10007.BuildDataStory(var_1, var_145_1))
		end

		if var_134_16 and #var_134_16 > 0 then
			local var_145_4 = arg_134_0
			local var_145_5 = var_2.emit

			Dorm3dRoomMediator = var_2_10005

			var_145_5(var_145_4, var_2_10005.OPEN_DROP_LAYER, var_134_16, arg_145_0)
		else
			arg_145_0()
		end

		return
	end)

	table = var_8

	var_8.insert(var_134_14, function(arg_146_0)
		pg = var_2_10001

		local var_146_0 = var_2_10001.NewGuideMgr.GetInstance()

		if var_1.IsPause(var_146_0) then
			pg = var_1

			local var_146_1 = var_1.NewGuideMgr.GetInstance()

			var_1.Resume(var_146_1)
		end

		local var_146_2 = arg_134_0

		var_1.emit(var_146_2, arg_134_0.HIDE_BLOCK)

		if arg_134_0.contextData.isVideoTalk then
			existCall = var_1

			var_1(arg_146_0)
		else
			local var_146_3 = arg_134_0

			var_1.SetBlackboardValue(var_146_3, var_134_6, var_134_15 and "inPerformance" or "inTalking", false)

			local var_146_4 = arg_134_0

			var_1.SetUI(var_146_4, arg_146_0, "back")
		end

		return
	end)

	seriesAsync = var_8

	var_8(var_134_14, function()
		if arg_134_2 then
			return arg_134_2()
		else
			local var_147_0 = arg_134_0

			var_0.CheckQueue(var_147_0)
		end

		return
	end)

	return
end

function var_0_1.DoTalkTouchOption(arg_148_0, arg_148_1, arg_148_2, arg_148_3)
	local var_148_0 = arg_148_0.rtExtraScreen
	local var_148_1 = var_4.Find(var_148_0, "TalkTouchOption")
	local var_148_2
	local var_148_3 = var_148_1:Find("content")

	UIItemList = var_7

	var_7.StaticAlign(var_148_3, var_148_3:Find("clickTpl"), #arg_148_1.options, function(arg_149_0, arg_149_1, arg_149_2)
		arg_149_1 = arg_149_1 + 1
		UIItemList = var_2_10003

		if arg_149_0 == var_2_10003.EventUpdate then
			local var_149_0 = arg_148_1.options[arg_149_1]

			setAnchoredPosition = var_2_10004

			local var_149_1 = arg_149_2

			NewPos = var_2_10007
			unpack = var_2_10009

			var_2_10004(var_149_1, var_2_10007(var_2_10009(var_149_0.pos)))

			onButton = var_2_10004

			local var_149_2 = arg_148_0
			local var_149_3 = arg_149_2

			local function var_149_4()
				var_148_2(var_149_0.flag)

				return
			end

			SFX_CONFIRM = var_9

			var_2_10004(var_149_2, var_149_3, var_149_4, var_9)

			setActive = var_2_10004

			local var_149_5 = arg_149_2

			table = var_149_3

			var_2_10004(var_149_5, not var_149_3.contains(arg_148_2, var_149_0.flag))
		end

		return
	end)

	setActive = var_7

	var_7(var_148_1, true)

	function var_148_2(arg_151_0)
		setActive = var_2_10001

		var_2_10001(var_148_1, false)
		arg_148_3(arg_151_0)

		return
	end

	return
end

function var_0_1.DoTimelineOption(arg_152_0, arg_152_1, arg_152_2)
	local var_152_0 = arg_152_0.rtTimelineScreen
	local var_152_1 = var_3.Find(var_152_0, "TimelineOption")
	local var_152_2
	local var_152_3 = var_152_1:Find("content")

	UIItemList = var_6

	var_6.StaticAlign(var_152_3, var_152_3:Find("clickTpl"), #arg_152_1, function(arg_153_0, arg_153_1, arg_153_2)
		arg_153_1 = arg_153_1 + 1
		UIItemList = var_2_10003

		if arg_153_0 == var_2_10003.EventUpdate then
			local var_153_0 = arg_152_1[arg_153_1]

			setText = var_2_10004

			local var_153_1 = arg_153_2:Find("Text")

			HXSet = var_2_10007

			var_2_10004(var_153_1, var_2_10007.hxLan(var_153_0.content))

			onButton = var_2_10004

			local var_153_2 = arg_152_0
			local var_153_3 = arg_153_2

			local function var_153_4()
				var_152_2(arg_153_1)

				return
			end

			SFX_CONFIRM = var_9

			var_2_10004(var_153_2, var_153_3, var_153_4, var_9)
		end

		return
	end)

	setActive = var_6

	var_6(var_152_1, true)

	function var_152_2(arg_155_0)
		setActive = var_2_10001

		var_2_10001(var_152_1, false)
		arg_152_2(arg_155_0)

		return
	end

	return
end

function var_0_1.DoTimelineTouch(arg_156_0, arg_156_1, arg_156_2)
	local var_156_0 = arg_156_0.rtTimelineScreen
	local var_156_1 = var_3.Find(var_156_0, "TimelineTouch")
	local var_156_2
	local var_156_3 = var_156_1:Find("content")

	UIItemList = var_6

	var_6.StaticAlign(var_156_3, var_156_3:Find("clickTpl"), #arg_156_1, function(arg_157_0, arg_157_1, arg_157_2)
		arg_157_1 = arg_157_1 + 1
		UIItemList = var_2_10003

		if arg_157_0 == var_2_10003.EventUpdate then
			local var_157_0 = arg_156_1[arg_157_1]

			setAnchoredPosition = var_2_10004

			local var_157_1 = arg_157_2

			NewPos = var_2_10007
			unpack = var_2_10009

			var_2_10004(var_157_1, var_2_10007(var_2_10009(var_157_0.pos)))

			onButton = var_2_10004

			local var_157_2 = arg_156_0
			local var_157_3 = arg_157_2

			local function var_157_4()
				var_156_2(arg_157_1)

				return
			end

			SFX_CONFIRM = var_9

			var_2_10004(var_157_2, var_157_3, var_157_4, var_9)

			if arg_156_0.firstTimelineTouch then
				local var_157_5 = arg_156_0

				var_157_5.firstTimelineTouch = nil
				setActive = var_157_5

				var_157_5(arg_157_2:Find("finger"), true)
			end
		end

		return
	end)

	setActive = var_6

	var_6(var_156_1, true)

	function var_156_2(arg_159_0)
		setActive = var_2_10001

		var_2_10001(var_156_1, false)
		arg_156_2(arg_159_0)

		return
	end

	return
end

function var_0_1.DoShortWait(arg_160_0, arg_160_1)
	local var_160_0 = arg_160_0.ladyDict[arg_160_1]

	getProxy = var_1_10003
	ApartmentProxy = var_1_10005

	local var_160_1 = var_1_10003(var_1_10005)
	local var_160_2 = var_3.getApartment(var_160_1, arg_160_1)
	local var_160_3 = arg_160_0.room

	if var_4.getApartmentZoneConfig(var_160_3, var_160_0.ladyBaseZone, "special_action", arg_160_1) then
		math = var_160_1

		local var_160_4

		if not var_4[var_160_1.random(#var_4)] then
			var_160_4 = nil
		end

		if not var_160_4 then
			return
		end

		arg_160_0:PlaySingleAction(var_160_0, var_160_4)

		return
	end
end

function var_0_1.OutOfLazy(arg_161_0, arg_161_1, arg_161_2)
	local var_161_0 = arg_161_0.ladyDict[arg_161_1]
	local var_161_1 = {}

	if arg_161_0:GetBlackboardValue(var_161_0, "inPending") then
		table = var_5

		var_5.insert(var_161_1, function(arg_162_0)
			arg_161_0.shiftLady = arg_161_1

			local var_162_0 = arg_161_0

			var_1.ShiftZone(var_162_0, var_161_0.ladyBaseZone, arg_162_0)

			return
		end)
	end

	seriesAsync = var_5

	var_5(var_161_1, arg_161_2)

	return
end

function var_0_1.OutOfPending(arg_163_0, arg_163_1, arg_163_2)
	assert = var_1_10003

	var_1_10003(arg_163_0.wakeUpTalkId)

	local var_163_0 = arg_163_0.wakeUpTalkId

	seriesAsync = var_1_10004

	var_1_10004({
		function(arg_164_0)
			local var_164_0 = arg_163_0

			var_1.SetUI(var_164_0, arg_164_0, "blank")

			return
		end,
		function(arg_165_0)
			arg_163_0.shiftLady = arg_163_1

			local var_165_0 = arg_163_0.ladyDict[arg_163_1]
			local var_165_1 = arg_163_0

			var_2.ShiftZone(var_165_1, var_165_0.ladyBaseZone, arg_165_0)

			return
		end,
		function(arg_166_0)
			local var_166_0 = arg_163_0

			var_1.DoTalk(var_166_0, var_163_0, arg_166_0)

			return
		end
	}, function()
		local var_167_0 = arg_163_0

		var_0.SetUIStore(var_167_0, arg_163_2, "back")

		return
	end)

	return
end

function var_0_1.ChangeCanWatchState(arg_168_0, arg_168_1)
	local var_168_0

	if arg_168_0:GetBlackboardValue(arg_168_1, "inPending") then
		tobool = var_3
		var_168_0 = var_3(arg_168_0:GetBlackboardValue(arg_168_1, "inDistance"))
	else
		local var_168_1 = arg_168_0:GetBlackboardValue(arg_168_1, "groupId")

		tobool = var_1_10004

		local var_168_3

		if arg_168_0.activeLady[var_168_1] then
			pg = var_168_3

			local var_168_2 = var_168_3.NodeCanvasMgr.GetInstance()

			var_168_3 = var_168_3.GetBlackboradValue(var_168_2, "canWatch", arg_168_1.ladyBlackboard)
		end

		var_168_0 = var_1_10004(var_168_3)
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

function var_0_1.HandleGameNotification(arg_169_0, arg_169_1, arg_169_2)
	local var_169_0 = arg_169_0:GetCurrentLadyEnv()

	switch = var_1_10004

	local var_169_1 = arg_169_1
	local var_169_2 = {}

	Dorm3dMiniGameMediator = var_1_10008
	var_169_2[var_1_10008.OPERATION] = function()
		local var_170_0 = arg_169_2.miniGameId

		switch = var_2_10001

		var_2_10001(arg_169_2.miniGameId, {
			[67] = function()
				if arg_169_2.operationCode == "GAME_HIT_AREA" then
					local var_171_0 = {
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
					}

					unpack = var_1

					local var_171_1, var_171_2 = var_1(var_171_0[arg_169_2.index])
					local var_171_3 = arg_169_0

					var_3.PlayFaceAnim(var_171_3, var_169_0, var_171_1)

					if arg_169_0.tfCutIn then
						quickPlayAnimator = var_3

						var_3(arg_169_0.modelCutIn.lady, var_171_2)

						quickPlayAnimator = var_3

						var_3(arg_169_0.modelCutIn.player, var_171_2)
					end
				elseif arg_169_2.operationCode == "GAME_RESULT" then
					if arg_169_2.win then
						local var_171_4 = arg_169_0

						var_0.PlayFaceAnim(var_171_4, var_169_0, "Face_XYX_victory")

						local var_171_5 = arg_169_0

						var_0.PlaySingleAction(var_171_5, var_169_0, "minigame_win")
					else
						local var_171_6 = arg_169_0

						var_0.PlayFaceAnim(var_171_6, var_169_0, "Face_XYX_lose")

						local var_171_7 = arg_169_0

						var_0.PlaySingleAction(var_171_7, var_169_0, "minigame_lose")
					end

					setActive = var_0

					local var_171_8 = arg_169_0.rtExtraScreen

					var_0(var_2.Find(var_171_8, "MiniGameCutIn"), false)
				end

				return
			end,
			[70] = function()
				if arg_169_2.operationCode == "GAME_READY" then
					arg_169_0.cameras[var_0_1.CAMERA.TALK].Follow = nil
					arg_169_0.cameras[var_0_1.CAMERA.TALK].LookAt = nil

					local var_172_0 = arg_169_0

					var_0.PlaySingleAction(var_172_0, var_169_0, "shuohua_sikao")
				elseif arg_169_2.operationCode == "ROUND_RESULT" then
					local var_172_1

					if arg_169_2.success then
						var_172_1 = {
							"shuohua_wenhou",
							"shuohua_sikao"
						}
					else
						var_172_1 = {
							"shuohua_yaotou",
							"shuohua_sikao"
						}
					end

					seriesAsync = var_1
					underscore = var_3_10003

					var_1(var_3_10003.map(var_172_1, function(arg_173_0)
						return function(arg_174_0)
							local var_174_0 = arg_169_0

							var_1.PlaySingleAction(var_174_0, var_169_0, arg_173_0, arg_174_0)

							return
						end
					end), function()
						return
					end)
				elseif arg_169_2.operationCode == "GAME_RESULT" then
					var_0.position = arg_169_0.cameras[var_0_1.CAMERA.TALK].transform.position + var_0.right * 0.11

					local var_172_2 = {
						"shuohua_gandong"
					}

					seriesAsync = var_2
					underscore = var_3_10004

					var_2(var_3_10004.map(var_172_2, function(arg_176_0)
						return function(arg_177_0)
							local var_177_0 = arg_169_0

							var_1.PlaySingleAction(var_177_0, var_169_0, arg_176_0, arg_177_0)

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
					arg_169_0.cameras[var_0_1.CAMERA.TALK].Follow = nil
					arg_169_0.cameras[var_0_1.CAMERA.TALK].LookAt = nil
				elseif arg_169_2.operationCode == "GAME_RPS_RESULT" then
					if arg_169_2.index == 1 then
						local var_179_0 = arg_169_0

						var_0.PlaySingleAction(var_179_0, var_169_0, "ab_shuohua_lianxuyaotou_01")

						local var_179_1 = arg_169_0

						var_0.PlayFaceAnim(var_179_1, var_169_0, "Face_weixiao")
					elseif arg_169_2.index == 2 then
						local var_179_2 = arg_169_0

						var_0.PlaySingleAction(var_179_2, var_169_0, "ab_shuohua_lianxudiantou_01")

						local var_179_3 = arg_169_0

						var_0.PlayFaceAnim(var_179_3, var_169_0, "Face_kaixin")
					end
				elseif arg_169_2.operationCode == "GAME_RESULT" then
					if not arg_169_2.win then
						local var_179_4 = arg_169_0

						var_0.PlaySingleAction(var_179_4, var_169_0, "ab_shuohua_taibangle_01")
					end

					local var_179_5 = arg_169_0

					var_0.PlayFaceAnim(var_179_5, var_169_0, "Face_kaixin")
				end

				return
			end
		}, function()
			warning = var_3_10000

			var_3_10000("without miniGameId:" .. arg_169_2.miniGameId)

			return
		end)

		local var_170_3

		if arg_169_2.operationCode == "BEFORE_OPEN_GAME" then
			getProxy = var_1
			PlayerProxy = var_3

			local var_170_1 = var_1(var_3)
			local var_170_2 = var_1.getPlayerId(var_170_1)

			var_2_10002 = 0

			if var_170_0 == 67 or var_170_0 == 70 then
				PlayerPrefs = var_170_1
				var_170_1 = var_170_1.GetInt
				var_170_3 = "mg_new_score_"
				tostring = var_2_10006
				var_2_10002 = var_170_1(var_170_3 .. var_2_10006(var_170_2) .. "_" .. arg_169_2.miniGameId, 0)
			else
				PlayerPrefs = var_170_1

				local var_170_4 = var_170_1.GetInt

				var_170_3 = "mg_score_"
				tostring = var_2_10006
				var_2_10002 = var_170_4(var_170_3 .. var_2_10006(var_170_2) .. "_" .. arg_169_2.miniGameId, 0)
			end

			arg_169_0.highScore = var_2_10002
		else
			local var_170_6

			if arg_169_2.operationCode == "GAME_RESULT" then
				local var_170_5 = arg_169_2.score

				getProxy = var_2_10002
				PlayerProxy = var_170_6
				var_170_6 = var_2_10002(var_170_6)

				local var_170_7 = var_2.getPlayerId(var_170_6)

				if var_170_5 > arg_169_0.highScore then
					if var_170_0 == 67 or var_170_0 == 70 then
						PlayerPrefs = var_170_6
						var_170_6 = var_170_6.SetInt
						var_2_10006 = "mg_new_score_"
						tostring = var_2_10007

						var_170_6(var_2_10006 .. var_2_10007(var_170_7) .. "_" .. arg_169_2.miniGameId, var_170_5)
					end

					getProxy = var_170_6
					Dorm3dChatProxy = var_2_10006

					local var_170_8 = var_170_6(var_2_10006)

					var_170_6 = var_170_6.TriggerEvent
					var_2_10007 = {}
					var_2_10008 = {
						event_type = 159,
						value = var_170_5
					}

					local var_170_9 = arg_169_0.apartment

					var_2_10008.ship_id = var_9.GetConfigID(var_170_9)
					var_2_10007[1] = var_2_10008

					var_170_6(var_170_8, var_2_10007)
				end

				pg = var_170_6

				local var_170_10 = var_170_6.m02

				var_170_6 = var_170_6.sendNotification
				GAME = var_2_10007

				local var_170_11 = var_2_10007.APARTMENT_TRACK

				Dorm3dTrackCommand = var_2_10008

				var_170_6(var_170_10, var_170_11, var_2_10008.BuildDataMiniGame(2, arg_169_2.score))
			elseif arg_169_2.operationCode == "GAME_CLOSE" and arg_169_2.doTrack == false then
				pg = var_1

				local var_170_12 = var_1.m02
				local var_170_13 = var_1.sendNotification

				GAME = var_170_6

				local var_170_14 = var_170_6.APARTMENT_TRACK

				Dorm3dTrackCommand = var_170_3

				var_170_13(var_170_12, var_170_14, var_170_3.BuildDataMiniGame(3))
			end
		end

		return
	end

	var_1_10004(var_169_1, var_169_2)

	return
end

function var_0_1.PerformanceQueue(arg_181_0, arg_181_1, arg_181_2)
	pcall = var_1_10003

	local var_181_0, var_181_1 = var_1_10003(function()
		require = var_2_10000

		return var_2_10000("GameCfg.dorm." .. arg_181_1)
	end)

	if not var_181_0 then
		errorMsg = var_5

		var_5("不存在表演ID对应的Lua:" .. arg_181_1)

		existCall = var_5

		var_5(arg_181_2)

		return
	end

	warning = var_5

	var_5(arg_181_1)

	arg_181_0.performanceInfo = {
		name = arg_181_1
	}

	local var_181_2 = {}

	table = var_1_10006

	var_1_10006.insert(var_181_2, function(arg_183_0)
		local var_183_0 = arg_181_0

		var_1.SetUI(var_183_0, arg_183_0, "blank")

		return
	end)

	table = var_6

	local var_181_3 = var_6.insertto
	local var_181_4 = var_181_2

	underscore = var_9

	var_181_3(var_181_4, var_9.map(var_181_1, function(arg_184_0)
		switch = var_2_10001

		return var_2_10001(arg_184_0.type, {
			function()
				return function(arg_186_0)
					unpack = var_4_10001

					local var_186_0 = var_4_10001(arg_184_0.params)
					local var_186_1 = arg_181_0

					var_2.DoTalk(var_186_1, var_186_0, arg_186_0, true)

					return
				end
			end,
			function()
				return function(arg_188_0)
					local var_188_0 = arg_181_0
					local var_188_1 = var_1.emit

					RoomTouchSystem = var_4_10004

					var_188_1(var_188_0, var_4_10004.SET_TOUCH_EXIT_CALL, arg_188_0)

					local var_188_2 = arg_181_0
					local var_188_3 = var_1.emit

					RoomTouchSystem = var_4

					var_188_3(var_188_2, var_4.ENTER_TOUCH_MODE)

					return
				end
			end,
			function()
				return function(arg_190_0)
					local var_190_0 = arg_181_0
					local var_190_1 = var_1.GetCurrentLadyEnv(var_190_0)
					local var_190_2 = arg_181_0

					var_2.PlaySingleAction(var_190_2, var_190_1, arg_184_0.name, arg_190_0)

					return
				end
			end,
			function()
				return function(arg_192_0)
					local var_192_0 = arg_181_0

					var_1.emit(var_192_0, arg_181_0.PLAY_EXPRESSION, arg_184_0)
					arg_192_0()

					return
				end
			end,
			function()
				return function(arg_194_0)
					local var_194_0 = arg_181_0

					var_1.ShiftZone(var_194_0, arg_184_0.name, arg_194_0)

					return
				end
			end,
			function()
				return function(arg_196_0)
					arg_181_0.contextData.timeIndex = arg_184_0.params[1]

					local var_196_0

					if not arg_184_0.params[2] then
						var_196_0 = false
					end

					Dorm3dSceneMgr = var_2

					if var_2.IsSameSceneInfo(arg_181_0.dormSceneMgr.artSceneInfo, arg_181_0.dormSceneMgr.sceneInfo) then
						local var_196_1 = arg_181_0

						var_2.SwitchDayNight(var_196_1, arg_181_0.contextData.timeIndex)

						if var_196_0 then
							onNextTick = var_2

							var_2(function()
								local var_197_0 = arg_181_0

								var_0.RefreshSlots(var_197_0)

								return
							end)
						end
					end

					local var_196_2 = arg_181_0

					var_2.UpdateContactState(var_196_2)

					onNextTick = var_2

					var_2(arg_196_0)

					return
				end
			end,
			function()
				return function(arg_199_0)
					if arg_184_0.name then
						local var_199_0 = arg_181_0

						var_1.ActiveCameraByName(var_199_0, arg_184_0.name)

						existCall = var_1

						var_1(arg_199_0)
					else
						local var_199_1 = arg_181_0

						var_1.ActiveStateCamera(var_199_1, arg_184_0.params[1], arg_199_0)
					end

					return
				end
			end,
			function()
				return function(arg_201_0)
					if arg_184_0.name == "base" then
						local var_201_0 = arg_181_0

						var_1.RevertArtScene(var_201_0, arg_181_0.dormSceneMgr.sceneInfo, arg_201_0)
					else
						local var_201_1 = arg_184_0.params.scene
						local var_201_2 = arg_184_0.params.sceneRoot
						local var_201_3 = arg_181_0

						var_3.ChangeArtScene(var_201_3, var_201_1 .. "|" .. var_201_2, arg_201_0)
					end

					return
				end
			end,
			function()
				return function(arg_203_0)
					local var_203_0 = arg_184_0.params.name

					if arg_184_0.name == "load" then
						tobool = var_2

						local var_203_1

						if var_2(arg_184_0.params.wait_timeline) then
							function var_203_1(arg_204_0)
								arg_181_0.waitForTimeline = arg_204_0

								return
							end
						end

						local var_203_2 = arg_181_0

						var_3.LoadTimelineScene(var_203_2, var_203_0, true, var_203_1, arg_203_0)
					elseif arg_184_0.name == "unload" then
						local var_203_3 = arg_181_0

						var_2.UnloadTimelineScene(var_203_3, var_203_0, true, arg_203_0)
					else
						assert = var_2

						var_2(false)
					end

					return
				end
			end,
			function()
				return function(arg_206_0)
					setActive = var_4_10001

					local var_206_0 = arg_181_0.uiContainer

					var_4_10001(var_3.Find(var_206_0, "walk/btn_back"), false)

					local var_206_1 = arg_181_0
					local var_206_2 = var_1.GetCurrentLadyEnv(var_206_1)

					if arg_184_0.name == "change" then
						local var_206_3 = arg_184_0.params.scene

						var_206_1 = arg_184_0.params.sceneRoot

						local var_206_4

						if not arg_184_0.params.point then
							var_206_4 = "Default"
						end

						var_206_2.walkBornPoint = var_206_4

						local var_206_5 = arg_181_0

						var_4.ChangeWalkScene(var_206_5, arg_184_0.name, var_206_3 .. "|" .. var_206_1, arg_206_0)
					elseif arg_184_0.name == "back" then
						var_206_2.walkBornPoint = nil

						local var_206_6 = arg_181_0

						var_2.ChangeWalkScene(var_206_6, arg_184_0.name, arg_181_0.dormSceneMgr.sceneInfo, arg_206_0)
					else
						local var_206_7

						if arg_184_0.name == "set" then
							function var_206_7()
								local var_207_0 = arg_206_0

								arg_206_0 = nil
								existCall = var_5_10001

								return var_5_10001(var_207_0)
							end

							pairs = var_206_1

							for iter_206_0, iter_206_1 in var_206_1(arg_184_0.params) do
								switch = var_4_10008

								var_4_10008(iter_206_0, {
									back_button_trigger = function(arg_208_0)
										onButton = var_5_10001

										local var_208_0 = arg_181_0
										local var_208_1 = arg_181_0.uiContainer
										local var_208_2 = var_4.Find(var_208_1, "walk/btn_back")
										local var_208_3 = var_206_7

										SFX_DORM_BACK = var_208_1

										var_5_10001(var_208_0, var_208_2, var_208_3, var_208_1)

										setActive = var_5_10001

										local var_208_4 = arg_181_0.uiContainer
										local var_208_5 = var_3.Find(var_208_4, "walk/btn_back")

										IsUnityEditor = var_208_2
										var_208_2 = var_208_2 and arg_208_0

										var_5_10001(var_208_5, var_208_2)

										return
									end,
									near_trigger = function(arg_209_0)
										if arg_209_0 == true then
											arg_209_0 = 1.5
										end

										if arg_209_0 then
											function arg_181_0.walkNearCallback(arg_210_0)
												if arg_210_0 < arg_209_0 then
													arg_181_0.walkNearCallback = nil

													var_206_7()
												end

												return
											end
										else
											arg_181_0.walkNearCallback = nil
										end

										return
									end
								}, nil, iter_206_1)
							end

							if arg_181_0.firstMoveGuide then
								setActive = var_3

								local var_206_8 = arg_181_0.povLayer

								var_3(var_5.Find(var_206_8, "Guide"), arg_181_0.firstMoveGuide)

								arg_181_0.firstMoveGuide = nil
							end
						else
							assert = var_206_7

							var_206_7(false)
						end
					end

					return
				end
			end,
			function()
				return function(arg_212_0)
					if arg_184_0.name == "set" then
						local var_212_0 = arg_181_0
						local var_212_1 = var_1.GetCurrentLadyEnv(var_212_0)
						local var_212_2 = arg_181_0
						local var_212_3 = var_2.emit

						RoomIKSystem = var_4_10005

						var_212_3(var_212_2, var_4_10005.SET_IK_CONFIG, var_212_1, arg_184_0.params.state)

						local var_212_4 = arg_181_0
						local var_212_5 = var_2.emit

						Dorm3dIKView = var_4_10005

						var_212_5(var_212_4, var_4_10005.SET_BACK_BUTTON_ACTIVE, not arg_184_0.params.hide_back)

						local var_212_6 = arg_181_0
						local var_212_7 = var_2.emit

						RoomIKSystem = var_4_10005

						var_212_7(var_212_6, var_4_10005.SET_IK_SPECIAL_CALL, arg_212_0)

						local var_212_8 = arg_181_0
						local var_212_9 = var_2.emit

						RoomIKSystem = var_4_10005

						var_212_9(var_212_8, var_4_10005.SET_IK_STATE, true)
					else
						local var_212_11

						if arg_184_0.name == "back" then
							local var_212_10 = arg_181_0

							var_212_11 = var_212_11.GetCurrentLadyEnv(var_212_10)
							var_212_11.ikConfig = arg_184_0.params

							local var_212_12 = arg_181_0
							local var_212_13 = var_2.emit

							RoomIKSystem = var_4_10005

							var_212_13(var_212_12, var_4_10005.SET_IK_STATE, false, function()
								local var_213_0 = var_212_11

								var_213_0.ikConfig = nil
								existCall = var_213_0

								var_213_0(arg_212_0)

								return
							end)
						else
							assert = var_212_11

							var_212_11(false)
						end
					end

					return
				end
			end,
			function()
				return function(arg_215_0)
					local var_215_0 = arg_181_0

					setmetatable = var_4_10002

					local var_215_1

					if not arg_184_0.params then
						var_215_1 = {}
					end

					var_215_0.blackSceneInfo = var_4_10002(var_215_1, {
						__index = {
							color = "#000000",
							time = 0.3,
							delay = arg_184_0.name == "show" and 0 or 0.5
						}
					})

					if arg_184_0.name == "show" then
						local var_215_2 = arg_181_0

						var_1.ShowBlackScreen(var_215_2, true, arg_215_0)
					elseif arg_184_0.name == "hide" then
						local var_215_3 = arg_181_0

						var_1.ShowBlackScreen(var_215_3, false, arg_215_0)
					else
						assert = var_1

						var_1(false)
					end

					arg_181_0.blackSceneInfo = nil

					return
				end
			end,
			function()
				return function(arg_217_0)
					local var_217_0 = arg_181_0
					local var_217_1 = var_1.GetCurrentLadyEnv(var_217_0)

					if arg_184_0.name == "set" then
						local var_217_2 = arg_181_0
						local var_217_3 = var_2.emit

						Dorm3dStockingMgr = var_4_10005

						var_217_3(var_217_2, var_4_10005.SET_STOCKING_STATUS, arg_184_0.params)
					elseif arg_184_0.name == "exit" then
						local var_217_4 = arg_181_0
						local var_217_5 = var_2.emit

						Dorm3dStockingMgr = var_4_10005

						var_217_5(var_217_4, var_4_10005.EXIT_STOCKING_STATUS)
					end

					return
				end
			end
		})
	end))

	table = var_181_3

	var_181_3.insert(var_181_2, function(arg_218_0)
		local var_218_0 = arg_181_0

		var_1.SetUI(var_218_0, arg_218_0, "back")

		arg_181_0.performanceInfo = nil

		return
	end)

	seriesAsync = var_6

	var_6(var_181_2, arg_181_2)

	return
end

function var_0_1.TriggerContact(arg_219_0, arg_219_1)
	local var_219_0 = arg_219_0
	local var_219_1 = arg_219_0.emit

	Dorm3dRoomMediator = var_1_10005

	local var_219_2 = var_1_10005.COLLECTION_ITEM
	local var_219_3 = {
		itemId = arg_219_1
	}
	local var_219_4 = arg_219_0.room

	var_219_3.roomId = var_7.GetConfigID(var_219_4)

	local var_219_5 = arg_219_0.room

	if var_7.isPersonalRoom(var_219_5) then
		local var_219_6 = arg_219_0.apartment
		local var_219_7

		if not var_7.GetConfigID(var_219_6) then
			var_219_7 = 0
		end

		var_219_3.groupId = var_219_7

		var_219_1(var_219_0, var_219_2, var_219_3)

		return
	end
end

function var_0_1.UpdateContactState(arg_220_0)
	local var_220_0 = arg_220_0
	local var_220_1 = arg_220_0.SetContactStateDic
	local var_220_2 = arg_220_0.room

	var_220_1(var_220_0, var_4.getTriggerableCollectItemDic(var_220_2, arg_220_0.contextData.timeIndex))

	return
end

function var_0_1.UpdateFavorDisplay(arg_221_0)
	getProxy = var_1_10001
	ApartmentProxy = var_1_10003

	local var_221_0 = var_1_10001(var_1_10003)
	local var_221_1, var_221_2 = var_1.getStamina(var_221_0)

	setText = var_221_0

	local var_221_3 = arg_221_0.rtStaminaDisplay
	local var_221_4 = var_5.Find(var_221_3, "Text")

	string = var_1_10006

	var_221_0(var_221_4, var_1_10006.format("%d/%d", var_221_1, var_221_2))

	setActive = var_221_0

	var_221_0(arg_221_0.rtStaminaDisplay, false)

	local var_221_7

	if arg_221_0.apartment then
		setText = var_221_7

		local var_221_5 = arg_221_0.rtFavorLevel

		var_221_7(var_5.Find(var_221_5, "rank/Text"), arg_221_0.apartment.level)

		local var_221_6 = arg_221_0.apartment
		local var_221_8

		var_221_7, var_221_8 = var_221_7.getFavor(var_221_6)

		local var_221_9 = arg_221_0.apartment
		local var_221_10 = var_5.isMaxFavor(var_221_9)

		setActive = var_6

		local var_221_11 = arg_221_0.rtFavorLevel

		var_6(var_8.Find(var_221_11, "Max"), var_221_10)

		setActive = var_6

		local var_221_12 = arg_221_0.rtFavorLevel

		var_6(var_8.Find(var_221_12, "Text"), not var_221_10)

		setText = var_6

		local var_221_13 = arg_221_0.rtFavorLevel
		local var_221_14 = var_8.Find(var_221_13, "Text")

		string = var_9

		var_6(var_221_14, var_9.format("<color=#ff6698>%d</color>/%d", var_221_7, var_221_8))
	end

	setActive = var_221_7

	local var_221_15 = arg_221_0.rtFavorLevel
	local var_221_16 = var_5.Find(var_221_15, "red")

	Dorm3dLevelLayer = var_6

	var_221_7(var_221_16, var_6.IsShowRed())

	return
end

function var_0_1.UpdateBtnState(arg_222_0)
	local var_222_0 = arg_222_0.room
	local var_222_1

	if var_1.isPersonalRoom(var_222_0) then
		var_222_0 = arg_222_0
		var_222_1 = arg_222_0.CheckSystemOpen(var_222_0, "Furniture")

		if false then
			var_222_1 = false
		end
	else
		var_222_1 = true
	end

	Dorm3dFurniture = var_1_10002

	local var_222_2 = var_1_10002.IsTimelimitShopTip
	local var_222_3 = arg_222_0.room
	local var_222_4 = var_222_2(var_4.GetConfigID(var_222_3))

	setActive = var_222_0

	local var_222_5 = arg_222_0.uiContainer

	var_222_0(var_5.Find(var_222_5, "base/left/btn_furniture/tipTimelimit"), var_222_1 and var_222_4)

	Dorm3dFurniture = var_222_0

	local var_222_6 = var_222_0.NeedViewTip
	local var_222_7 = arg_222_0.room
	local var_222_8 = var_222_6(var_5.GetConfigID(var_222_7))

	setActive = var_4

	local var_222_9 = arg_222_0.uiContainer

	var_4(var_6.Find(var_222_9, "base/left/btn_furniture/tip"), var_222_1 and not var_222_4 and var_222_8)

	setActive = var_4

	local var_222_10 = arg_222_0.uiContainer
	local var_222_11 = var_6.Find(var_222_10, "base/btn_back/main")

	underscore = var_7
	getProxy = var_9
	ApartmentProxy = var_1_10011

	local var_222_12 = var_9(var_1_10011)
	local var_222_13 = var_7(var_9.getRawData(var_222_12))
	local var_222_14 = var_7.chain(var_222_13)
	local var_222_15 = var_7.values(var_222_14)
	local var_222_16 = var_7.filter(var_222_15, function(arg_223_0)
		tobool = var_2_10001

		return var_2_10001(arg_223_0)
	end)
	local var_222_17 = var_7.any(var_222_16, function(arg_224_0)
		return #arg_224_0:getSpecialTalking() > 0 or arg_224_0:getIconTip() == "main"
	end)

	var_4(var_222_11, var_7.value(var_222_17))

	setActive = var_4

	local var_222_18 = arg_222_0.uiContainer
	local var_222_19 = var_6.Find(var_222_18, "base/left/btn_collection/tip")

	PlayerPrefs = var_7

	local var_222_20

	if not (var_7.GetInt("apartment_collection_item", 0) > 0) then
		PlayerPrefs = var_7

		if not (var_7.GetInt("apartment_collection_recall", 0) > 0) then
			var_222_20 = false

			goto label_222_0
		end
	end

	var_222_20 = true

	::label_222_0::

	var_4(var_222_19, var_222_20)

	return
end

function var_0_1.AddUnlockDisplay(arg_225_0, arg_225_1)
	table = var_1_10002

	var_1_10002.insert(arg_225_0.unlockList, arg_225_1)

	isActive = var_2

	if not var_2(arg_225_0.rtFavorUp) then
		setText = var_2

		local var_225_0 = arg_225_0.rtFavorUp
		local var_225_1 = var_4.Find(var_225_0, "Text")

		table = var_5

		var_2(var_225_1, var_5.remove(arg_225_0.unlockList, 1))

		setActive = var_2

		var_2(arg_225_0.rtFavorUp, true)
	end

	return
end

function var_0_1.PopFavorTrigger(arg_226_0, arg_226_1)
	local var_226_0 = arg_226_1.triggerId
	local var_226_1 = arg_226_1.delta
	local var_226_2 = arg_226_1.cost
	local var_226_3 = arg_226_1.apartment

	pg = var_1_10006

	if var_1_10006.dorm3d_favor_trigger[var_226_0].is_repeat == 0 then
		getDorm3dGameset = var_7

		local var_226_5

		if var_226_0 == var_7("drom3d_favir_trigger_onwer")[1] then
			local var_226_4 = arg_226_0

			var_226_5 = arg_226_0.AddUnlockDisplay
			i18n = var_1_10010

			var_226_5(var_226_4, var_1_10010("dorm3d_own_favor"))
		else
			getDorm3dGameset = var_226_5

			if var_226_0 == var_226_5("drom3d_favir_trigger_propose")[1] then
				local var_226_6 = arg_226_0
				local var_226_7 = arg_226_0.AddUnlockDisplay

				i18n = var_1_10010

				var_226_7(var_226_6, var_1_10010("dorm3d_pledge_favor"))
			else
				local var_226_8 = arg_226_0
				local var_226_9 = arg_226_0.AddUnlockDisplay

				string = var_1_10010

				var_226_9(var_226_8, var_1_10010.format("unknow favor trigger:%d unlock", var_226_0))
			end
		end

		goto label_226_0
	end

	if arg_226_1.delta > 0 then
		local var_226_10, var_226_11 = var_226_3:getFavor()
		local var_226_12 = var_226_10 + var_226_1

		setText = var_1_10010

		local var_226_13 = arg_226_0.rtFavorUpDaily
		local var_226_14 = var_12.Find(var_226_13, "bg/Text")

		string = var_1_10013

		local var_226_15 = var_1_10013.format
		local var_226_16 = "<size=48>+%d</size>"

		math = var_1_10016

		var_1_10010(var_226_14, var_226_15(var_226_16, var_1_10016.min(9999, var_226_1)))

		setSlider = var_1_10010

		local var_226_17 = arg_226_0.rtFavorUpDaily

		var_1_10010(var_12.Find(var_226_17, "bg/slider"), 0, var_226_11, var_226_10)

		setAnchoredPosition = var_1_10010

		local var_226_18 = arg_226_0.rtFavorUpDaily
		local var_226_19 = var_12.Find(var_226_18, "bg")

		if arg_226_1.isGift then
			NewPos = var_226_20

			do
				local var_226_20

				if not var_226_20(-354, 223) then
					NewPos = var_226_20
					var_226_20 = var_226_20(-208, 105)
				end

				var_1_10010(var_226_19, var_226_20)

				local var_226_21 = {}
				local var_226_22 = arg_226_0.rtFavorUpDaily
				local var_226_23 = var_11.Find(var_226_22, "bg/effect")

				eachChild = var_226_19

				var_226_19(var_226_23, function(arg_227_0)
					setActive = var_2_10001

					var_2_10001(arg_227_0, false)

					return
				end)

				local var_226_24

				if var_6.effect and var_6.effect ~= "" then
					if not var_226_23:Find(var_6.effect .. "(Clone)") then
						table = var_13

						var_13.insert(var_226_21, function(arg_228_0)
							LoadAndInstantiateAsync = var_2_10001

							var_2_10001("Dorm3D/Effect/Prefab/ExpressionUI", "uifx_dorm3d_yinfu01", function(arg_229_0)
								setParent = var_3_10001

								var_3_10001(arg_229_0, var_226_23)

								tf = var_3_10001
								var_226_24 = var_3_10001(arg_229_0)

								arg_228_0()

								return
							end)

							return
						end)
					else
						setActive = var_13

						var_13(var_226_24, true)
					end
				end

				local var_226_25 = arg_226_0.rtFavorUpDaily
				local var_226_26 = var_13.GetComponent(var_226_25, "DftAniEvent")

				var_13.SetTriggerEvent(var_226_26, function(arg_230_0)
					GetComponent = var_2_10001

					local var_230_0 = arg_226_0.rtFavorUpDaily
					local var_230_1 = var_3.Find(var_230_0, "bg/slider")

					typeof = var_2_10004
					Slider = var_6

					local var_230_2 = var_2_10001(var_230_1, var_2_10004(var_6))

					LeanTween = var_2_10002

					local var_230_3 = var_2_10002.value(var_226_10, var_226_12, 0.5)
					local var_230_4 = var_2.setOnUpdate

					System = var_5

					local var_230_5 = var_230_4(var_230_3, var_5.Action_float(function(arg_231_0)
						var_230_2.value = arg_231_0

						return
					end))
					local var_230_6 = var_2.setEase

					LeanTweenType = var_5

					local var_230_7 = var_230_6(var_230_5, var_5.easeInOutQuad)
					local var_230_8 = var_2.setDelay(var_230_7, 0.165)
					local var_230_9 = var_2.setOnComplete

					System = var_5

					var_230_9(var_230_8, var_5.Action(function()
						LeanTween = var_3_10000

						local var_232_0 = var_3_10000.delayedCall
						local var_232_1 = 0.165

						System = var_3_10003

						var_232_0(var_232_1, var_3_10003.Action(function()
							if arg_226_0.exited then
								return
							end

							quickPlayAnimator = var_0

							var_0(arg_226_0.rtFavorUpDaily, "favor_out")

							return
						end))

						return
					end))

					pg = var_230_9

					local var_230_10 = var_230_9.CriMgr.GetInstance()

					var_2.PlaySE_V3(var_230_10, "ui-dorm_progaress_bar")

					return
				end)
				var_13:SetEndEvent(function(arg_234_0)
					setActive = var_2_10001

					var_2_10001(arg_226_0.rtFavorUpDaily, false)

					return
				end)

				seriesAsync = var_14

				var_14(var_226_21, function()
					local var_235_0 = arg_226_0.ladyDict
					local var_235_1 = var_226_3
					local var_235_2 = var_235_0[var_1.GetConfigID(var_235_1)]

					setLocalPosition = var_1

					local var_235_3 = arg_226_0.rtFavorUpDaily
					local var_235_4 = arg_226_0
					local var_235_5 = var_4.GetLocalPosition
					local var_235_6 = arg_226_0

					var_1(var_235_3, var_235_5(var_235_4, var_7.GetScreenPosition(var_235_6, var_235_2.ladyHeadCenter.position), arg_226_0.rtFavorUpDaily.parent))

					setActive = var_1

					var_1(arg_226_0.rtFavorUpDaily, true)

					SetCompomentEnabled = var_1

					local var_235_7 = arg_226_0.rtFavorUpDaily

					typeof = var_4
					Animator = var_235_4

					var_1(var_235_7, var_4(var_235_4), true)

					quickPlayAnimator = var_1

					var_1(arg_226_0.rtFavorUpDaily, "favor_open")

					if var_226_2 > 0 then
						getProxy = var_1
						ApartmentProxy = var_3

						local var_235_8 = var_1(var_3)
						local var_235_9, var_235_10 = var_1.getStamina(var_235_8)

						setText = var_235_8

						local var_235_11 = arg_226_0.rtStaminaPop

						var_235_8(var_5.Find(var_235_11, "Text/Text (1)"), "-" .. var_226_2)

						setText = var_235_8

						local var_235_12 = arg_226_0.rtStaminaPop
						local var_235_13 = var_5.Find(var_235_12, "Text")

						string = var_6

						var_235_8(var_235_13, var_6.format("%d/%d", var_235_9 + var_226_2, var_235_10))

						setActive = var_235_8

						var_235_8(arg_226_0.rtStaminaPop, true)
					end

					return
				end)
			end

			::label_226_0::

			return
		end
	end
end

function var_0_1.PopFavorLevelUp(arg_236_0, arg_236_1, arg_236_2, arg_236_3)
	arg_236_0.isLock = true
	LeanTween = var_4

	local var_236_0 = var_4.delayedCall
	local var_236_1 = 0.33

	System = var_1_10007

	var_236_0(var_236_1, var_1_10007.Action(function()
		arg_236_0.isLock = false

		return
	end))

	math = var_236_0

	local var_236_2 = var_236_0.floor(arg_236_1.level / 10)

	math = var_1_10005

	local var_236_3 = var_1_10005.fmod(arg_236_1.level, 10)

	GetImageSpriteFromAtlasAsync = var_6

	local var_236_4 = "ui/favor_atlas"
	local var_236_5 = var_236_3
	local var_236_6 = arg_236_0.rtLevelUpWindow

	var_6(var_236_4, var_236_5, var_10.Find(var_236_6, "panel/bg/item1/mark/level/digit2"))

	GetImageSpriteFromAtlasAsync = var_6

	local var_236_7 = "ui/favor_atlas"
	local var_236_8 = var_236_2
	local var_236_9 = arg_236_0.rtLevelUpWindow

	var_6(var_236_7, var_236_8, var_10.Find(var_236_9, "panel/bg/item1/mark/level/digit1"))

	setActive = var_6

	local var_236_10 = arg_236_0.rtLevelUpWindow

	var_6(var_8.Find(var_236_10, "panel/bg/item1/mark/level/digit1"), var_236_2 > 0)

	local var_236_11

	Dorm3dIconHelper = var_7

	local var_236_12

	arg_236_0.clientAward, var_236_12 = var_7.SplitStory(arg_236_1:getFavorConfig("levelup_client_item", arg_236_1.level))
	arg_236_0.serverAward = arg_236_2

	local var_236_13 = arg_236_0.rtLevelUpWindow
	local var_236_14 = var_7.Find(var_236_13, "panel/info/content/itemContent")

	if not arg_236_0.levelItemList then
		UIItemList = var_8
		arg_236_0.levelItemList = var_8.New(var_236_14, var_236_14:Find("tpl"))

		local var_236_15 = arg_236_0.levelItemList

		var_8.make(var_236_15, function(arg_238_0, arg_238_1, arg_238_2)
			local var_238_0 = arg_238_1 + 1

			UIItemList = var_2_10004

			if arg_238_0 == var_2_10004.EventUpdate then
				if arg_238_1 < #arg_236_0.serverAward then
					updateDorm3dIcon = var_4

					var_4(arg_238_2, arg_236_0.serverAward[var_238_0])

					onButton = var_4

					local var_238_1 = arg_236_0
					local var_238_2 = arg_238_2

					local function var_238_3()
						local var_239_0 = arg_236_0
						local var_239_1 = var_0.emit

						BaseUI = var_3_10003

						var_239_1(var_239_0, var_3_10003.ON_NEW_DROP, {
							style = "dorm",
							drop = arg_236_0.serverAward[var_238_0]
						})

						return
					end

					SFX_PANEL = var_2_10009

					var_4(var_238_1, var_238_2, var_238_3, var_2_10009)
				else
					Dorm3dIconHelper = var_4

					var_4.UpdateDorm3dIcon(arg_238_2, arg_236_0.clientAward[var_238_0 - #arg_236_0.serverAward])

					onButton = var_4

					local var_238_4 = arg_236_0
					local var_238_5 = arg_238_2

					local function var_238_6()
						local var_240_0 = arg_236_0
						local var_240_1 = var_0.emit

						Dorm3dRoomMediator = var_3_10003

						var_240_1(var_240_0, var_3_10003.ON_DROP_CLIENT, {
							data = arg_236_0.clientAward[var_238_0 - #arg_236_0.serverAward]
						})

						return
					end

					SFX_PANEL = var_2_10009

					var_4(var_238_4, var_238_5, var_238_6, var_2_10009)
				end
			end

			return
		end)
	end

	local var_236_16 = arg_236_0.levelItemList

	var_8.align(var_236_16, #arg_236_0.serverAward + #arg_236_0.clientAward)

	setActive = var_8

	var_8(arg_236_0.rtLevelUpWindow, true)

	pg = var_8

	local var_236_17 = var_8.CriMgr.GetInstance()

	var_8.PlaySE_V3(var_236_17, "ui-dorm_upgrade")
	arg_236_0:OverlayPanel(arg_236_0.rtLevelUpWindow)

	function arg_236_0.levelUpCallback()
		arg_236_0.levelUpCallback = nil

		if var_236_12 then
			local var_241_0 = arg_236_0

			var_0.PopNewStoryTip(var_241_0, var_236_12)
		end

		existCall = var_0

		var_0(arg_236_3)

		return
	end

	return
end

function var_0_1.PopNewStoryTip(arg_242_0, arg_242_1, arg_242_2)
	local var_242_0 = arg_242_0.uiContainer
	local var_242_1 = var_3.Find(var_242_0, "base/top/story_tip")

	setActive = var_1_10004

	var_1_10004(var_242_1, true)

	LeanTween = var_1_10004

	local var_242_2 = var_1_10004.delayedCall
	local var_242_3 = 1

	System = var_7

	var_242_2(var_242_3, var_7.Action(function()
		setActive = var_2_10000

		var_2_10000(var_242_1, false)

		return
	end))

	setText = var_242_2

	local var_242_4 = var_242_1:Find("Text")

	i18n = var_7

	local var_242_5 = "dorm3d_story_unlock_tip"

	pg = var_1_10010

	var_242_2(var_242_4, var_7(var_242_5, var_1_10010.dorm3d_recall[arg_242_1[2]].name))

	existCall = var_242_2

	var_242_2(arg_242_2)

	return
end

function var_0_1.UpdateZoneList(arg_244_0)
	local var_244_0
	local var_244_1 = arg_244_0.room

	if var_2.isPersonalRoom(var_244_1) then
		var_244_0 = arg_244_0:GetCurrentLadyEnv().ladyBaseZone
	else
		var_244_0 = arg_244_0:GetAttachedFurnitureName()
	end

	ipairs = var_2

	for iter_244_0, iter_244_1 in var_2(arg_244_0.zoneDatas) do
		if iter_244_1:GetWatchCameraName() == var_244_0 then
			setText = var_7

			local var_244_2 = arg_244_0.btnZone

			var_7(var_9.Find(var_244_2, "Text"), iter_244_1:GetName())

			setTextColor = var_7

			local var_244_3 = arg_244_0.rtZoneList
			local var_244_4 = var_9.GetChild(var_244_3, iter_244_0 - 1)
			local var_244_5 = var_9.Find(var_244_4, "Name")

			Color = var_1_10010

			var_7(var_244_5, var_1_10010.NewHex("5CCAFF"))
		else
			setTextColor = var_7

			local var_244_6 = arg_244_0.rtZoneList
			local var_244_7 = var_9.GetChild(var_244_6, iter_244_0 - 1)
			local var_244_8 = var_9.Find(var_244_7, "Name")

			Color = var_1_10010

			var_7(var_244_8, var_1_10010.NewHex("FFFFFF99"))
		end
	end

	return
end

function var_0_1.TalkingEventHandle(arg_245_0, arg_245_1)
	local var_245_0 = {}
	local var_245_1 = {}

	if arg_245_1.data.op_list then
		ipairs = var_5

		for iter_245_0, iter_245_1 in var_5(var_4.op_list) do
			table = var_1_10010

			var_1_10010.insert(var_245_0, function(arg_246_0)
				local function var_246_0()
					local var_247_0 = arg_246_0

					arg_246_0 = nil
					existCall = var_3_10001

					return var_3_10001(var_247_0)
				end

				switch = var_2_10002

				var_2_10002(iter_245_1.type, {
					action = function()
						local var_248_0 = arg_245_0
						local var_248_1 = var_0.GetCurrentLadyEnv(var_248_0)
						local var_248_2 = arg_245_0

						var_1.PlaySingleAction(var_248_2, var_248_1, iter_245_1.name, var_246_0)

						return
					end,
					item_action = function()
						local var_249_0 = arg_245_0

						var_0.PlaySceneItemAnim(var_249_0, iter_245_1.id, iter_245_1.name)
						var_246_0()

						return
					end,
					extra_item_action = function()
						local var_250_0 = arg_245_0
						local var_250_1 = var_0.GetCurrentLadyEnv(var_250_0).extraItems[iter_245_1.name]

						warning = var_2

						var_2(iter_245_1.name)

						warning = var_2

						var_2(var_250_1.trans)

						if var_250_1 then
							local var_250_2 = var_250_1.trans
							local var_250_3 = var_2.GetComponent

							typeof = var_3_10005
							Animator = var_3_10007

							local var_250_4 = var_250_3(var_250_2, var_3_10005(var_3_10007))

							var_2.PlayInFixedTime(var_250_4, iter_245_1.param)
						end

						var_246_0()

						return
					end,
					timeline = function()
						local var_251_0 = {}
						local var_251_1 = arg_245_0
						local var_251_2 = var_1.emit

						RoomTouchSystem = var_3_10004

						var_251_2(var_251_1, var_3_10004.GET_TOUCH_GAME_STATE, var_251_0)

						if var_251_0.inTouchGame then
							local var_251_3 = arg_245_0
							local var_251_4 = var_1.emit

							RoomTouchSystem = var_4

							var_251_4(var_251_3, var_4.UPDATE_TOUCH_PANEL, false)
						end

						local var_251_5 = arg_245_0

						var_1.PlayTimeline(var_251_5, iter_245_1, function(arg_252_0, arg_252_1)
							local var_252_0 = arg_245_0
							local var_252_1 = var_2.emit

							RoomTouchSystem = var_4_10005

							var_252_1(var_252_0, var_4_10005.GET_TOUCH_GAME_STATE, var_251_0)

							local var_252_2 = arg_245_0
							local var_252_3 = var_2.emit

							RoomTouchSystem = var_5

							var_252_3(var_252_2, var_5.UPDATE_TOUCH_PANEL, var_251_0.inTouchGame)

							var_245_1.notifiCallback = arg_252_1

							var_246_0()

							return
						end)

						return
					end,
					clickOption = function()
						local var_253_0 = arg_245_0

						var_0.DoTalkTouchOption(var_253_0, iter_245_1, arg_245_1.flags, function(arg_254_0)
							var_245_1.optionIndex = arg_254_0

							var_246_0()

							return
						end)

						return
					end,
					wait = function()
						local var_255_0 = arg_245_0
						local var_255_1

						if not arg_245_0.LTs then
							var_255_1 = {}
						end

						var_255_0.LTs = var_255_1
						table = var_255_0

						local var_255_2 = var_255_0.insert
						local var_255_3 = arg_245_0.LTs

						LeanTween = var_3_10003

						local var_255_4 = var_3_10003.delayedCall
						local var_255_5 = iter_245_1.time

						System = var_3_10006

						var_255_2(var_255_3, var_255_4(var_255_5, var_3_10006.Action(var_246_0)).uniqueId)

						return
					end,
					expression = function()
						local var_256_0 = arg_245_0

						var_0.emit(var_256_0, arg_245_0.PLAY_EXPRESSION, iter_245_1)
						var_246_0()

						return
					end,
					blackscreen = function()
						local var_257_0 = arg_245_0
						local var_257_1

						if not arg_245_0.LTs then
							var_257_1 = {}
						end

						var_257_0.LTs = var_257_1

						local var_257_2 = arg_245_0

						var_0.ShowBlackScreen(var_257_2, true, function()
							table = var_4_10000

							local var_258_0 = var_4_10000.insert
							local var_258_1 = arg_245_0.LTs

							LeanTween = var_4_10003

							local var_258_2 = var_4_10003.delayedCall
							local var_258_3 = iter_245_1.time

							System = var_4_10006

							var_258_0(var_258_1, var_258_2(var_258_3, var_4_10006.Action(function()
								local var_259_0 = arg_245_0

								var_0.ShowBlackScreen(var_259_0, false)
								var_246_0()

								return
							end)).uniqueId)

							return
						end)

						return
					end
				}, function()
					assert = var_3_10000

					var_3_10000(false, "op type error:", iter_245_1.type)

					return
				end)

				if iter_245_1.skip then
					var_246_0()
				end

				return
			end)
		end
	end

	seriesAsync = var_5

	var_5(var_245_0, function()
		if arg_245_1.callbackData then
			local var_261_0 = arg_245_0
			local var_261_1 = var_0.emit

			Dorm3dRoomMediator = var_2_10003

			var_261_1(var_261_0, var_2_10003.TALKING_EVENT_FINISH, arg_245_1.callbackData.name, var_245_1)
		end

		return
	end)

	return
end

function var_0_1.CheckQueue(arg_262_0)
	if arg_262_0.inGuide or arg_262_0.uiState ~= "base" then
		return
	end

	local var_262_0 = arg_262_0.room

	if var_1.GetConfigID(var_262_0) == 1 and arg_262_0:CheckGuide() then
		-- block empty
	else
		local var_262_1 = arg_262_0.room

		if var_1.isPersonalRoom(var_262_1) and arg_262_0:CheckLevelUp() then
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
	end

	arg_262_0.contextData.hasEnterCheck = true

	return
end

function var_0_1.didEnterCheck(arg_263_0)
	local var_263_0
	local var_263_1

	if arg_263_0.contextData.specialId then
		var_263_0 = arg_263_0.contextData.specialId
		var_263_1 = arg_263_0.contextData
		var_263_1.specialId = nil

		arg_263_0:DoTalk(var_263_0, function()
			local var_264_0 = arg_263_0

			var_0.closeView(var_264_0)

			return
		end)

		if arg_263_0.contextData.isVideoTalk then
			var_263_1 = arg_263_0.contextData
			var_263_1.hasEnterCheck = true
		end
	elseif not arg_263_0.contextData.hasEnterCheck and arg_263_0.apartment then
		ipairs = var_263_1

		local var_263_2 = arg_263_0.apartment
		local var_263_3 = var_4.getForceEnterTalking
		local var_263_4 = arg_263_0.room

		for iter_263_0, iter_263_1 in var_263_1(var_263_3(var_263_2, var_7.GetConfigID(var_263_4))) do
			var_263_0 = iter_263_1

			arg_263_0:DoTalk(iter_263_1)

			break
		end
	end

	if var_263_0 then
		pg = var_263_1

		if var_263_1.dorm3d_dialogue_group[var_263_0].extend_loading > 0 then
			local var_263_5 = arg_263_0.contextData

			var_263_5.hasEnterCheck = true
			pg = var_263_5

			local var_263_6 = var_263_5.SceneAnimMgr.GetInstance()

			var_2.RegisterDormNextCall(var_263_6, function()
				local var_265_0 = arg_263_0

				var_0.FinishEnterResume(var_265_0)

				return
			end)

			goto label_263_0
		end
	end

	do
		local var_263_7

		if arg_263_0.apartment then
			var_263_7 = arg_263_0.contextData.pendingDic

			local var_263_8 = arg_263_0.apartment

			if var_263_7[var_3.GetConfigID(var_263_8)] then
				var_263_7 = arg_263_0.contextData
				var_263_7.hasEnterCheck = true
			end
		end

		pairs = var_263_7

		for iter_263_2, iter_263_3 in var_263_7(arg_263_0.contextData.pendingDic) do
			arg_263_0:SetInPending(arg_263_0.ladyDict[iter_263_2], iter_263_3)
		end

		arg_263_0.contextData.pendingDic = {}

		arg_263_0:FinishEnterResume()
		arg_263_0:CheckQueue()
	end

	::label_263_0::

	return
end

function var_0_1.CheckGuide(arg_266_0)
	local var_266_0 = arg_266_0
	local var_266_1 = arg_266_0.GetBlackboardValue
	local var_266_2 = arg_266_0

	if var_266_1(var_266_0, arg_266_0.GetCurrentLadyEnv(var_266_2), "inPending") then
		return
	end

	DORM_LOCK_GUIDE = var_1

	if var_1 then
		return false
	end

	ipairs = var_1

	for iter_266_0, iter_266_1 in var_1({
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
				local var_269_0 = arg_266_0

				return var_0.CheckSystemOpen(var_269_0, "Furniture")
			end
		},
		{
			name = "DORM3D_GUIDE_07",
			active = function()
				local var_270_0 = arg_266_0

				return var_0.CheckSystemOpen(var_270_0, "DayNight")
			end
		}
	}) do
		pg = var_266_2

		local var_266_3 = var_266_2.NewStoryMgr.GetInstance()

		if not var_266_2.IsPlayed(var_266_3, iter_266_1.name) and iter_266_1.active() then
			arg_266_0:SetAllBlackbloardValue("inGuide", true)

			function var_266_2()
				pg = var_2_10000

				local var_271_0 = var_2_10000.m02
				local var_271_1 = var_0.sendNotification

				GAME = var_2_10003

				local var_271_2 = var_2_10003.APARTMENT_TRACK

				Dorm3dTrackCommand = var_2_10004

				local var_271_3 = var_2_10004.BuildDataGuide
				local var_271_4 = 2

				pg = var_2_10007

				local var_271_5 = var_2_10007.NewStoryMgr.GetInstance()

				var_271_1(var_271_0, var_271_2, var_271_3(var_271_4, var_7.StoryName2StoryId(var_271_5, iter_266_1.name)))

				local var_271_6 = arg_266_0

				var_0.SetAllBlackbloardValue(var_271_6, "inGuide", false)

				return
			end

			pg = var_1_10007

			local var_266_4 = var_1_10007.m02

			var_1_10007 = var_1_10007.sendNotification
			GAME = var_10

			var_1_10007(var_266_4, var_10.STORY_UPDATE, {
				storyId = iter_266_1.name
			})

			pg = var_1_10007

			local var_266_5 = var_1_10007.m02

			var_1_10007 = var_1_10007.sendNotification
			GAME = var_10

			local var_266_6 = var_10.APARTMENT_TRACK

			Dorm3dTrackCommand = var_11

			local var_266_7 = var_11.BuildDataGuide
			local var_266_8 = 1

			pg = var_1_10014

			local var_266_9 = var_1_10014.NewStoryMgr.GetInstance()

			var_1_10007(var_266_5, var_266_6, var_266_7(var_266_8, var_1_10014.StoryName2StoryId(var_266_9, iter_266_1.name)))

			pg = var_1_10007

			local var_266_10 = var_1_10007.NewGuideMgr.GetInstance()

			var_1_10007.Play(var_266_10, iter_266_1.name, nil, var_266_2, var_266_2)

			return true
		end
	end

	return false
end

function var_0_1.CheckGiftExpireSoon(arg_272_0)
	local var_272_0 = arg_272_0.room

	if not var_1.isPersonalRoom(var_272_0) then
		return false
	end

	getProxy = var_1
	ApartmentProxy = var_272_0

	local var_272_1 = var_1(var_272_0)
	local var_272_2 = var_1.GetShipGroupGiftExpireSoonTipIds
	local var_272_3 = arg_272_0.apartment

	if #var_272_2(var_272_1, var_4.GetConfigID(var_272_3)) <= 0 then
		return false
	end

	_ = var_2

	var_2.each(var_1, function(arg_273_0)
		Dorm3dGift = var_2_10001

		var_2_10001.SetExpireSoonTipFlag(arg_273_0)

		return
	end)

	local function var_272_4()
		local var_274_0 = arg_272_0

		var_0.CheckQueue(var_274_0)

		return
	end

	pg = var_3

	local var_272_5 = var_3.NewStyleMsgboxMgr.GetInstance()
	local var_272_6 = var_3.Show

	pg = var_272_3

	local var_272_7 = var_272_3.NewStyleMsgboxMgr.TYPE_MSGBOX
	local var_272_8 = {}

	i18n = var_1_10008
	var_272_8.title = var_1_10008("dorm3d_gift_overtime_title")
	i18n = var_8
	var_272_8.contentText = var_8("dorm3d_gift_overtime")

	local var_272_9 = {}
	local var_272_10 = {}

	pg = var_10
	var_272_10.type = var_10.NewStyleMsgboxMgr.BUTTON_TYPE.confirm
	i18n = var_10
	var_272_10.name = var_10("msgbox_text_confirm")
	var_272_10.func = var_272_4
	SFX_CONFIRM = var_10
	var_272_10.sound = var_10
	var_272_9[1] = var_272_10
	var_272_8.btnList = var_272_9
	var_272_8.onClose = var_272_4

	var_272_6(var_272_5, var_272_7, var_272_8)

	return true
end

function var_0_1.CheckFavorTrigger(arg_275_0)
	ipairs = var_1_10001

	local var_275_0 = {}
	local var_275_1 = {}

	getDorm3dGameset = var_1_10005
	var_275_1.triggerId = var_1_10005("drom3d_favir_trigger_onwer")[1]

	function var_275_1.active()
		getProxy = var_2_10000
		CollectionProxy = var_2_10002

		local var_276_0 = var_2_10000(var_2_10002)
		local var_276_1 = var_0.getShipGroup(var_276_0, arg_275_0.apartment.configId)

		tobool = var_2_10001

		return var_2_10001(var_276_1)
	end

	var_275_0[1] = var_275_1

	local var_275_2 = {}

	getDorm3dGameset = var_5
	var_275_2.triggerId = var_5("drom3d_favir_trigger_propose")[1]

	function var_275_2.active()
		getProxy = var_2_10000
		CollectionProxy = var_2_10002

		local var_277_0 = var_2_10000(var_2_10002)

		return var_0.getShipGroup(var_277_0, arg_275_0.apartment.configId) and var_0.married > 0
	end

	var_275_0[2] = var_275_2

	for iter_275_0, iter_275_1 in var_1_10001(var_275_0) do
		if arg_275_0.apartment.triggerCountDic[iter_275_1.triggerId] == 0 and iter_275_1.active() then
			local var_275_3 = arg_275_0
			local var_275_4 = arg_275_0.emit

			Dorm3dRoomMediator = var_1_10009

			var_275_4(var_275_3, var_1_10009.TRIGGER_FAVOR, arg_275_0.apartment.configId, iter_275_1.triggerId)
		end
	end

	return
end

function var_0_1.CheckEnterDeal(arg_278_0)
	if arg_278_0.contextData.hasEnterCheck then
		return false
	end

	local var_278_0 = arg_278_0.apartment
	local var_278_1 = var_1.GetConfigID(var_278_0)
	local var_278_2 = "dorm3d_enter_count_" .. var_278_1

	pg = var_3

	local var_278_3 = var_3.TimeMgr.GetInstance()
	local var_278_4 = var_3.CurrentSTimeDesc(var_278_3, "%Y/%m/%d")

	PlayerPrefs = var_1_10004

	if var_1_10004.GetString("dorm3d_enter_count_day") ~= var_278_4 then
		PlayerPrefs = var_4

		var_4.SetString("dorm3d_enter_count_day", var_278_4)

		PlayerPrefs = var_4

		var_4.SetInt(var_278_2, 1)
	else
		PlayerPrefs = var_4

		local var_278_5 = var_4.SetInt
		local var_278_6 = var_278_2

		PlayerPrefs = var_1_10007

		var_278_5(var_278_6, var_1_10007.GetInt(var_278_2, 0) + 1)
	end

	local var_278_7 = arg_278_0.apartment
	local var_278_8 = var_4.getEnterTalking
	local var_278_9 = arg_278_0.room
	local var_278_10 = var_278_8(var_278_7, var_7.GetConfigID(var_278_9))

	PlayerPrefs = var_278_3

	local var_278_11 = var_278_3.SetString
	local var_278_12 = "DORM3D_DAILY_ENTER"

	pg = var_1_10008

	local var_278_13 = var_1_10008.TimeMgr.GetInstance()

	var_278_11(var_278_12, var_8.CurrentSTimeDesc(var_278_13, "%Y/%m/%d"))

	if #var_278_10 > 0 then
		local var_278_14 = arg_278_0
		local var_278_15 = arg_278_0.DoTalk

		math = var_8

		var_278_15(var_278_14, var_278_10[var_8.random(#var_278_10)])

		return true
	end

	return
end

function var_0_1.CheckActiveTalk(arg_279_0)
	local var_279_0 = arg_279_0:GetCurrentLadyEnv()

	if arg_279_0:GetBlackboardValue(var_279_0, "inPending") then
		return false
	end

	local var_279_1 = arg_279_0.apartment
	local var_279_2 = var_2.getZoneTalking
	local var_279_3 = arg_279_0.room

	if #var_279_2(var_279_1, var_5.GetConfigID(var_279_3), var_279_0.ladyBaseZone) > 0 then
		arg_279_0:DoTalk(var_2[1])

		return true
	else
		return false
	end

	return
end

function var_0_1.CheckDistanceTalk(arg_280_0, arg_280_1, arg_280_2)
	local var_280_0 = arg_280_0.ladyDict[arg_280_1].ladyBaseZone

	getProxy = var_1_10004
	ApartmentProxy = var_1_10006

	local var_280_1 = var_1_10004(var_1_10006)
	local var_280_2 = var_4.getApartment(var_280_1, arg_280_1)

	ipairs = var_1_10005

	local var_280_3 = var_280_2
	local var_280_4 = var_280_2.getDistanceTalking
	local var_280_5 = arg_280_0.room

	for iter_280_0, iter_280_1 in var_1_10005(var_280_4(var_280_3, var_10.GetConfigID(var_280_5), var_280_0)) do
		arg_280_0:DoTalk(iter_280_1)

		return
	end

	return
end

function var_0_1.CheckSystemOpen(arg_281_0, arg_281_1)
	local var_281_0 = arg_281_0.room

	if var_2.isPersonalRoom(var_281_0) then
		switch = var_2

		return var_2(arg_281_1, {
			Talk = function()
				local var_282_0

				var_282_0 = 1 <= arg_281_0.apartment.level
				i18n = var_2_10002

				local var_282_1 = var_2_10002("apartment_level_unenough", var_0)
			end,
			Touch = function()
				getDorm3dGameset = var_2_10000

				local var_283_0

				var_283_0 = var_2_10000("drom3d_touch_dialogue")[1] <= arg_281_0.apartment.level
				i18n = var_2

				local var_283_1 = var_2("apartment_level_unenough", var_0)
			end,
			Gift = function()
				getDorm3dGameset = var_2_10000

				local var_284_0

				var_284_0 = var_2_10000("drom3d_gift_dialogue")[1] <= arg_281_0.apartment.level
				i18n = var_2

				local var_284_1 = var_2("apartment_level_unenough", var_0)
			end,
			PublicGame = function()
				return false
			end,
			Photo = function()
				getDorm3dGameset = var_2_10000

				local var_286_0

				var_286_0 = var_2_10000("drom3d_photograph_unlock")[1] <= arg_281_0.apartment.level
				i18n = var_2

				local var_286_1 = var_2("apartment_level_unenough", var_0)
			end,
			Collection = function()
				getDorm3dGameset = var_2_10000

				local var_287_0

				var_287_0 = var_2_10000("drom3d_recall_unlock")[1] <= arg_281_0.apartment.level
				i18n = var_2

				local var_287_1 = var_2("apartment_level_unenough", var_0)
			end,
			Furniture = function()
				getDorm3dGameset = var_2_10000

				local var_288_0

				var_288_0 = var_2_10000("drom3d_furniture_unlock")[1] <= arg_281_0.apartment.level
				i18n = var_2

				local var_288_1 = var_2("apartment_level_unenough", var_0)
			end,
			DayNight = function()
				getDorm3dGameset = var_2_10000

				local var_289_0

				var_289_0 = var_2_10000("drom3d_time_unlock")[1] <= arg_281_0.apartment.level
				i18n = var_2

				local var_289_1 = var_2("apartment_level_unenough", var_0)
			end,
			Accompany = function()
				local var_290_0

				var_290_0 = 1 <= arg_281_0.apartment.level
				i18n = var_2_10002

				local var_290_1 = var_2_10002("apartment_level_unenough", var_0)
			end,
			MiniGame = function()
				if 1 > arg_281_0.apartment.level then
					local var_291_0 = false

					i18n = var_2_10002

					local var_291_1 = var_2_10002("apartment_level_unenough", var_0)

					return
				else
					local var_291_2 = arg_281_0.room

					if #var_1.getMiniGames(var_291_2) <= 0 then
						return false, "without minigame config in room:" .. arg_281_0.room.configId
					else
						return true
					end
				end

				return
			end,
			Invite = function()
				return false
			end,
			Performance = function()
				IsUnityEditor = var_2_10000

				return var_2_10000
			end
		}, function()
			return true
		end)
	else
		switch = var_2

		return var_2(arg_281_1, {
			Gift = function()
				return false
			end,
			PublicGame = function()
				return true
			end,
			Furniture = function()
				local var_297_0 = arg_281_0.room
				local var_297_1 = #var_0.GetFurnitures(var_297_0)
				local var_297_2 = 0 < var_297_1

				_ = var_1

				local var_297_3 = var_1.filter
				local var_297_4 = arg_281_0.room
				local var_297_5

				if not var_3.GetFurnitureIDList(var_297_4) then
					var_297_5 = {}
				end

				local var_297_6 = #var_297_3(var_297_5, function(arg_298_0)
					Dorm3dFurniture = var_3_10001

					local var_298_0 = var_3_10001.New({
						configId = arg_298_0
					})

					return var_1.InShopTime(var_298_0)
				end) > 0

				return var_297_2 or var_297_6
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
				IsUnityEditor = var_2_10000

				return var_2_10000
			end
		}, function()
			return true
		end)
	end

	return
end

function var_0_1.CheckLevelUp(arg_304_0)
	local var_304_0 = arg_304_0.apartment

	if var_1.canLevelUp(var_304_0) then
		local var_304_1 = arg_304_0
		local var_304_2 = arg_304_0.emit

		Dorm3dRoomMediator = var_1_10004

		var_304_2(var_304_1, var_1_10004.FAVOR_LEVEL_UP, arg_304_0.apartment.configId)

		return true
	end

	return false
end

function var_0_1.EnterTouchMode(arg_305_0, arg_305_1)
	local var_305_0 = arg_305_0
	local var_305_1 = arg_305_0.emit

	RoomTouchSystem = var_1_10005

	var_305_1(var_305_0, var_1_10005.ENTER_TOUCH_MODE, arg_305_1)

	return
end

function var_0_1.ExitTouchMode(arg_306_0)
	local var_306_0 = arg_306_0
	local var_306_1 = arg_306_0.emit

	RoomTouchSystem = var_1_10004

	var_306_1(var_306_0, var_1_10004.EXIT_TOUCH_MODE)

	return
end

function var_0_1.ExitHeartbeatMode(arg_307_0)
	local var_307_0 = arg_307_0
	local var_307_1 = arg_307_0.emit

	RoomTouchSystem = var_1_10004

	var_307_1(var_307_0, var_1_10004.EXIT_HEARTBEAT_MODE)

	return
end

function var_0_1.SwitchIKConfig(arg_308_0, arg_308_1, arg_308_2)
	local var_308_0 = arg_308_0
	local var_308_1 = arg_308_0.emit

	RoomIKSystem = var_1_10006

	var_308_1(var_308_0, var_1_10006.SET_IK_CONFIG, arg_308_1, arg_308_2)

	return
end

function var_0_1.SetIKState(arg_309_0, arg_309_1, arg_309_2, arg_309_3)
	local var_309_0 = arg_309_0
	local var_309_1 = arg_309_0.emit

	RoomIKSystem = var_1_10007

	var_309_1(var_309_0, var_1_10007.SET_IK_STATE, arg_309_1, arg_309_2, arg_309_3)

	return
end

function var_0_1.TouchModeAction(arg_310_0, arg_310_1, arg_310_2, arg_310_3, ...)
	local var_310_0 = arg_310_0
	local var_310_1 = arg_310_0.GetExtraSystem

	RoomTouchSystem = var_1_10007

	local var_310_2 = var_310_1(var_310_0, var_1_10007)

	assert = var_1_10005

	var_1_10005(var_310_2, "RoomTouchSystem not found")

	return var_310_2:TouchModeAction(arg_310_1, arg_310_2, arg_310_3, ...)
end

function var_0_1.OnTriggerIK(arg_311_0, arg_311_1)
	local var_311_0 = arg_311_0
	local var_311_1 = arg_311_0.GetExtraSystem

	RoomIKSystem = var_1_10005

	local var_311_2 = var_311_1(var_311_0, var_1_10005)

	assert = var_1_10003

	var_1_10003(var_311_2, "RoomIKSystem not found")

	return var_311_2:OnTriggerIK(arg_311_1)
end

function var_0_1.UpdateTouchGameDisplay(arg_312_0)
	local var_312_0 = arg_312_0
	local var_312_1 = arg_312_0.GetExtraSystem

	RoomTouchSystem = var_1_10004

	if not var_312_1(var_312_0, var_1_10004) then
		return
	end

	local var_312_2 = arg_312_0
	local var_312_3 = arg_312_0.emit

	RoomTouchSystem = var_1_10005

	var_312_3(var_312_2, var_1_10005.UPDATE_TOUCH_LEVEL, var_1.touchLevel)

	return
end

function var_0_1.UpdateTouchCount(arg_313_0, arg_313_1)
	local var_313_0 = arg_313_0
	local var_313_1 = arg_313_0.GetExtraSystem

	RoomTouchSystem = var_1_10005

	local var_313_2 = var_313_1(var_313_0, var_1_10005)

	assert = var_1_10003

	var_1_10003(var_313_2, "RoomTouchSystem not found")

	return var_313_2:UpdateTouchCount(arg_313_1)
end

function var_0_1.DoTouch(arg_314_0, arg_314_1, arg_314_2)
	local var_314_0 = arg_314_0
	local var_314_1 = arg_314_0.GetExtraSystem

	RoomTouchSystem = var_1_10006

	local var_314_2 = var_314_1(var_314_0, var_1_10006)

	assert = var_1_10004

	var_1_10004(var_314_2, "RoomTouchSystem not found")

	return var_314_2:DoTouch(arg_314_1, arg_314_2)
end

function var_0_1.CycleIKCameraGroup(arg_315_0)
	local var_315_0 = arg_315_0
	local var_315_1 = arg_315_0.emit

	RoomIKSystem = var_1_10004

	var_315_1(var_315_0, var_1_10004.CYCLE_IK_CAMERA_GROUP)

	return
end

function var_0_1.TempHideUI(arg_316_0, arg_316_1, arg_316_2)
	defaultValue = var_1_10003
	arg_316_0.hideCount = var_1_10003(arg_316_0.hideCount, 0) + (arg_316_1 and 1 or -1)
	assert = var_4

	var_4(arg_316_0.hideCount >= 0)

	if arg_316_0.hideCount * var_3 > 0 then
		existCall = var_4

		return var_4(arg_316_2)
	elseif arg_316_0.hideCount > 0 then
		arg_316_0:SetUI(arg_316_2, "blank")
	else
		arg_316_0:SetUI(arg_316_2, "back")
	end

	return
end

function var_0_1.onBackPressed(arg_317_0)
	if arg_317_0.exited or arg_317_0.retainCount > 0 then
		-- block empty
	else
		isActive = var_1

		if var_1(arg_317_0.rtLevelUpWindow) then
			triggerButton = var_1

			local var_317_0 = arg_317_0.rtLevelUpWindow

			var_1(var_3.Find(var_317_0, "bg"))
		elseif arg_317_0.uiState ~= "base" then
			-- block empty
		else
			arg_317_0:closeView()
		end
	end

	return
end

function var_0_1.willExit(arg_318_0)
	if arg_318_0.LTs then
		underscore = var_1

		var_1.map(arg_318_0.LTs, function(arg_319_0)
			LeanTween = var_2_10001

			var_2_10001.cancel(arg_319_0)

			return
		end)

		arg_318_0.LTs = nil
	end

	pairs = var_1

	for iter_318_0, iter_318_1 in var_1(arg_318_0.ladyDict) do
		iter_318_1.wakeUpTalkId = nil
	end

	if arg_318_0.accompanyFavorTimer then
		local var_318_0 = arg_318_0.accompanyFavorTimer

		var_1.Stop(var_318_0)

		arg_318_0.accompanyFavorTimer = nil
	end

	if arg_318_0.accompanyPerformanceTimer then
		local var_318_1 = arg_318_0.accompanyPerformanceTimer

		var_1.Stop(var_318_1)

		arg_318_0.accompanyPerformanceTimer = nil
	end

	arg_318_0.canTriggerAccompanyPerformance = nil

	local var_318_2 = arg_318_0.videoPlayer

	var_1.Destroy(var_318_2)

	if arg_318_0.ikView then
		local var_318_3 = arg_318_0.ikView

		var_1.Dispose(var_318_3)

		arg_318_0.ikView = nil
	end

	if arg_318_0.touchView then
		local var_318_4 = arg_318_0.touchView

		var_1.Dispose(var_318_4)

		arg_318_0.touchView = nil
	end

	var_0_1.super.willExit(arg_318_0)

	return
end

return var_0_1
