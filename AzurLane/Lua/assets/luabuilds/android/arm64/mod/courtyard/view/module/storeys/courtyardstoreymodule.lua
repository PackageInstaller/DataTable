class = var_0_10000

local var_0_0 = "CourtYardStoreyModule"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..CourtYardBaseModule"))
local var_0_2 = false

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.modules = {}

	local var_1_0 = {}

	CourtYardGridAgent = var_1_10004
	var_1_0[1] = var_1_10004.New(arg_1_0)
	CourtYardWallGridAgent = var_4
	var_1_0[2] = var_4.New(arg_1_0)
	arg_1_0.gridAgents = var_1_0
	CourtYardEffectAgent = var_1_0
	arg_1_0.effectAgent = var_1_0.New(arg_1_0)
	CourtYardSoundAgent = var_3
	arg_1_0.soundAgent = var_3.New(arg_1_0)
	CourtYardBGAgent = var_3
	arg_1_0.bgAgent = var_3.New(arg_1_0)
	CourtYardBGMAgent = var_3
	arg_1_0.bgmAgent = var_3.New(arg_1_0)

	local var_1_1 = {}

	CourtYardConst = var_4

	local var_1_2 = var_4.OBJ_TYPE_SHIP

	CourtYardShipFactory = var_5
	var_1_1[var_1_2] = var_5.New(arg_1_0:GetView().poolMgr)
	CourtYardConst = var_1_2

	local var_1_3 = var_1_2.OBJ_TYPE_COMMOM

	CourtYardFurnitureFactory = var_5
	var_1_1[var_1_3] = var_5.New(arg_1_0:GetView().poolMgr)
	arg_1_0.factorys = var_1_1
	CourtYardFurnitureDescPage = var_1_1
	arg_1_0.descPage = var_1_1.New(arg_1_0)
	CourtyardPlayTheLutePage = var_3
	arg_1_0.playTheLutePage = var_3.New(arg_1_0)

	return
end

function var_0_1.GetDefaultBgm(arg_2_0)
	pg = var_1_10001

	return var_1_10001.voice_bgm.CourtYardScene.default_bgm
end

function var_0_1.OnInit(arg_3_0)
	local var_3_0 = arg_3_0._tf
	local var_3_1 = var_1.Find(var_3_0, "bg")

	arg_3_0.zoomAgent = var_1.GetComponent(var_3_1, "PinchZoom")

	local var_3_2 = arg_3_0._tf

	arg_3_0.scrollrect = var_1.Find(var_3_2, "scroll_view")

	local var_3_3 = arg_3_0._tf

	arg_3_0.bg = var_1.Find(var_3_3, "bg")

	local var_3_4 = arg_3_0._tf

	arg_3_0.rectTF = var_1.Find(var_3_4, "bg/rect")

	local var_3_5 = arg_3_0.rectTF

	arg_3_0.gridsTF = var_1.Find(var_3_5, "grids")

	local var_3_6 = arg_3_0._tf

	arg_3_0.rootTF = var_1.Find(var_3_6, "root")

	local var_3_7 = arg_3_0._tf

	arg_3_0.selectedTF = var_1.Find(var_3_7, "root/drag")

	local var_3_8 = arg_3_0.selectedTF
	local var_3_9 = var_1.GetComponent

	typeof = var_4
	Animation = var_1_10006
	arg_3_0.selectedAnimation = var_3_9(var_3_8, var_4(var_1_10006))

	local var_3_10 = arg_3_0.selectedTF
	local var_3_11 = var_1.GetComponent

	typeof = var_4
	DftAniEvent = var_1_10006
	arg_3_0.dftAniEvent = var_3_11(var_3_10, var_4(var_1_10006))

	local var_3_12 = arg_3_0.selectedTF

	arg_3_0.rotationBtn = var_1.Find(var_3_12, "panel/animroot/rotation")

	local var_3_13 = arg_3_0.selectedTF

	arg_3_0.removeBtn = var_1.Find(var_3_13, "panel/animroot/cancel")

	local var_3_14 = arg_3_0.selectedTF

	arg_3_0.confirmBtn = var_1.Find(var_3_14, "panel/animroot/ok")
	CourtYardStoreyDragBtn = var_1

	local var_3_15 = var_1.New
	local var_3_16 = arg_3_0.selectedTF

	arg_3_0.dragBtn = var_3_15(var_3.Find(var_3_16, "panel/animroot"), arg_3_0.rectTF)

	local var_3_17 = arg_3_0._tf

	arg_3_0.effectContainer = var_1.Find(var_3_17, "effects")

	local var_3_18 = arg_3_0.rectTF

	arg_3_0.floor = var_1.Find(var_3_18, "floor")

	local var_3_19 = arg_3_0.rectTF

	arg_3_0.wall = var_1.Find(var_3_19, "wall")

	local var_3_20 = arg_3_0.rootTF
	local var_3_21 = var_1.Find(var_3_20, "white")
	local var_3_22 = var_1.GetComponent

	typeof = var_4
	Image = var_6

	local var_3_23 = var_3_22(var_3_21, var_4(var_6)).material
	local var_3_24 = arg_3_0.rootTF
	local var_3_25 = var_2.Find(var_3_24, "green")
	local var_3_26 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007

	local var_3_27 = var_3_26(var_3_25, var_5(var_1_10007)).material
	local var_3_28 = arg_3_0.rootTF
	local var_3_29 = var_3.Find(var_3_28, "red")
	local var_3_30 = var_3.GetComponent

	typeof = var_6
	Image = var_1_10008

	local var_3_31 = var_3_30(var_3_29, var_6(var_1_10008)).material
	local var_3_32 = {}

	CourtyardFurnitureState = var_3_29

	local var_3_33 = var_3_29.New
	local var_3_34 = arg_3_0._tf

	var_3_32[1] = var_3_33(var_7.Find(var_3_34, "root/furnitureState"), arg_3_0.rectTF, var_3_23, var_3_27, var_3_31)
	CourtyardSpineFurnitureState = var_5

	local var_3_35 = var_5.New
	local var_3_36 = arg_3_0._tf

	var_3_32[2] = var_3_35(var_7.Find(var_3_36, "root/furnitureSpineState"), arg_3_0.rectTF, var_3_23, var_3_27, var_3_31)
	arg_3_0.furnitureStateMgrs = var_3_32

	arg_3_0:InitPedestalModule()

	local var_3_37 = arg_3_0.bg

	Vector3 = var_5
	var_3_37.localScale = var_5(1.438, 1.438, 1)

	return
end

function var_0_1.GetFurnitureStateMgr(arg_4_0, arg_4_1)
	local var_4_0

	if not arg_4_1:IsSpine() or not arg_4_0.furnitureStateMgrs[2] then
		var_4_0 = arg_4_0.furnitureStateMgrs[1]
	end

	return var_4_0
end

function var_0_1.InitPedestalModule(arg_5_0)
	CourtYardPedestalModule = var_1_10001
	arg_5_0.pedestalModule = var_1_10001.New(arg_5_0.data, arg_5_0.bg)

	return
end

function var_0_1.AddListeners(arg_6_0)
	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.AddListener

	CourtYardEvent = var_1_10004

	var_6_1(var_6_0, var_1_10004.INITED, arg_6_0.OnInited)

	local var_6_2 = arg_6_0
	local var_6_3 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_3(var_6_2, var_4.CREATE_ITEM, arg_6_0.OnCreateItem)

	local var_6_4 = arg_6_0
	local var_6_5 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_5(var_6_4, var_4.REMOVE_ITEM, arg_6_0.OnRemoveItem)

	local var_6_6 = arg_6_0
	local var_6_7 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_7(var_6_6, var_4.ADD_MAT_ITEM, arg_6_0.OnAddMatItem)

	local var_6_8 = arg_6_0
	local var_6_9 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_9(var_6_8, var_4.REMOVE_MAT_ITEM, arg_6_0.OnRemoveMatItem)

	local var_6_10 = arg_6_0
	local var_6_11 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_11(var_6_10, var_4.ADD_ITEM, arg_6_0.OnAddItem)

	local var_6_12 = arg_6_0
	local var_6_13 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_13(var_6_12, var_4.DRAG_ITEM, arg_6_0.OnDragItem)

	local var_6_14 = arg_6_0
	local var_6_15 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_15(var_6_14, var_4.DRAGING_ITEM, arg_6_0.OnDragingItem)

	local var_6_16 = arg_6_0
	local var_6_17 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_17(var_6_16, var_4.DRAG_ITEM_END, arg_6_0.OnDragItemEnd)

	local var_6_18 = arg_6_0
	local var_6_19 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_19(var_6_18, var_4.SELETED_ITEM, arg_6_0.OnSelectedItem)

	local var_6_20 = arg_6_0
	local var_6_21 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_21(var_6_20, var_4.UNSELETED_ITEM, arg_6_0.OnUnSelectedItem)

	local var_6_22 = arg_6_0
	local var_6_23 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_23(var_6_22, var_4.ENTER_EDIT_MODE, arg_6_0.OnEnterEidtMode)

	local var_6_24 = arg_6_0
	local var_6_25 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_25(var_6_24, var_4.EXIT_EDIT_MODE, arg_6_0.OnExitEidtMode)

	local var_6_26 = arg_6_0
	local var_6_27 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_27(var_6_26, var_4.ROTATE_ITEM, arg_6_0.OnItemDirChange)

	local var_6_28 = arg_6_0
	local var_6_29 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_29(var_6_28, var_4.ROTATE_ITEM_FAILED, arg_6_0.OnRotateItemFailed)

	local var_6_30 = arg_6_0
	local var_6_31 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_31(var_6_30, var_4.DETORY_ITEM, arg_6_0.OnDestoryItem)

	local var_6_32 = arg_6_0
	local var_6_33 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_33(var_6_32, var_4.CHILD_ITEM, arg_6_0.OnChildItem)

	local var_6_34 = arg_6_0
	local var_6_35 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_35(var_6_34, var_4.UN_CHILD_ITEM, arg_6_0.OnUnChildItem)

	local var_6_36 = arg_6_0
	local var_6_37 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_37(var_6_36, var_4.REMIND_SAVE, arg_6_0.OnRemindSave)

	local var_6_38 = arg_6_0
	local var_6_39 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_39(var_6_38, var_4.ADD_ITEM_FAILED, arg_6_0.OnAddItemFailed)

	local var_6_40 = arg_6_0
	local var_6_41 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_41(var_6_40, var_4.SHOW_FURNITURE_DESC, arg_6_0.OnShowFurnitureDesc)

	local var_6_42 = arg_6_0
	local var_6_43 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_43(var_6_42, var_4.ITEM_INTERACTION, arg_6_0.OnItemInterAction)

	local var_6_44 = arg_6_0
	local var_6_45 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_45(var_6_44, var_4.CLEAR_ITEM_INTERACTION, arg_6_0.OnClearItemInterAction)

	local var_6_46 = arg_6_0
	local var_6_47 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_47(var_6_46, var_4.ON_TOUCH_ITEM, arg_6_0.OnTouchItem)

	local var_6_48 = arg_6_0
	local var_6_49 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_49(var_6_48, var_4.ON_CANCEL_TOUCH_ITEM, arg_6_0.OnCancelTouchItem)

	local var_6_50 = arg_6_0
	local var_6_51 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_51(var_6_50, var_4.ON_ITEM_PLAY_MUSIC, arg_6_0.OnItemPlayMusic)

	local var_6_52 = arg_6_0
	local var_6_53 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_53(var_6_52, var_4.ON_ITEM_STOP_MUSIC, arg_6_0.OnItemStopMusic)

	local var_6_54 = arg_6_0
	local var_6_55 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_55(var_6_54, var_4.ON_ADD_EFFECT, arg_6_0.OnAddEffect)

	local var_6_56 = arg_6_0
	local var_6_57 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_57(var_6_56, var_4.ON_REMOVE_EFFECT, arg_6_0.OnRemoveEffect)

	local var_6_58 = arg_6_0
	local var_6_59 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_59(var_6_58, var_4.DISABLE_ROTATE_ITEM, arg_6_0.OnDisableRotation)

	local var_6_60 = arg_6_0
	local var_6_61 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_61(var_6_60, var_4.TAKE_PHOTO, arg_6_0.OnTakePhoto)

	local var_6_62 = arg_6_0
	local var_6_63 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_63(var_6_62, var_4.END_TAKE_PHOTO, arg_6_0.OnEndTakePhoto)

	local var_6_64 = arg_6_0
	local var_6_65 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_65(var_6_64, var_4.ENTER_ARCH, arg_6_0.OnEnterArch)

	local var_6_66 = arg_6_0
	local var_6_67 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_67(var_6_66, var_4.EXIT_ARCH, arg_6_0.OnExitArch)

	local var_6_68 = arg_6_0
	local var_6_69 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_69(var_6_68, var_4.REMOVE_ILLEGALITY_ITEM, arg_6_0.OnRemoveIllegalityItem)

	local var_6_70 = arg_6_0
	local var_6_71 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_71(var_6_70, var_4.OPEN_LAYER, arg_6_0.OnOpenLayer)

	local var_6_72 = arg_6_0
	local var_6_73 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_73(var_6_72, var_4.FURNITURE_PLAY_MUSICALINSTRUMENTS, arg_6_0.OnPlayMusicalInstruments)

	local var_6_74 = arg_6_0
	local var_6_75 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_75(var_6_74, var_4.FURNITURE_STOP_PLAY_MUSICALINSTRUMENTS, arg_6_0.OnStopPlayMusicalInstruments)

	local var_6_76 = arg_6_0
	local var_6_77 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_77(var_6_76, var_4.FURNITURE_MUTE_ALL, arg_6_0.OnMuteAll)

	local var_6_78 = arg_6_0
	local var_6_79 = arg_6_0.AddListener

	CourtYardEvent = var_4

	var_6_79(var_6_78, var_4.BACK_PRESSED, arg_6_0.OnBackPressed)

	return
end

function var_0_1.RemoveListeners(arg_7_0)
	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.RemoveListener

	CourtYardEvent = var_1_10004

	var_7_1(var_7_0, var_1_10004.INITED, arg_7_0.OnInited)

	local var_7_2 = arg_7_0
	local var_7_3 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_3(var_7_2, var_4.CREATE_ITEM, arg_7_0.OnCreateItem)

	local var_7_4 = arg_7_0
	local var_7_5 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_5(var_7_4, var_4.REMOVE_ITEM, arg_7_0.OnRemoveItem)

	local var_7_6 = arg_7_0
	local var_7_7 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_7(var_7_6, var_4.ADD_MAT_ITEM, arg_7_0.OnAddMatItem)

	local var_7_8 = arg_7_0
	local var_7_9 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_9(var_7_8, var_4.REMOVE_MAT_ITEM, arg_7_0.OnRemoveMatItem)

	local var_7_10 = arg_7_0
	local var_7_11 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_11(var_7_10, var_4.ADD_ITEM, arg_7_0.OnAddItem)

	local var_7_12 = arg_7_0
	local var_7_13 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_13(var_7_12, var_4.DRAG_ITEM, arg_7_0.OnDragItem)

	local var_7_14 = arg_7_0
	local var_7_15 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_15(var_7_14, var_4.DRAGING_ITEM, arg_7_0.OnDragingItem)

	local var_7_16 = arg_7_0
	local var_7_17 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_17(var_7_16, var_4.DRAG_ITEM_END, arg_7_0.OnDragItemEnd)

	local var_7_18 = arg_7_0
	local var_7_19 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_19(var_7_18, var_4.SELETED_ITEM, arg_7_0.OnSelectedItem)

	local var_7_20 = arg_7_0
	local var_7_21 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_21(var_7_20, var_4.UNSELETED_ITEM, arg_7_0.OnUnSelectedItem)

	local var_7_22 = arg_7_0
	local var_7_23 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_23(var_7_22, var_4.ENTER_EDIT_MODE, arg_7_0.OnEnterEidtMode)

	local var_7_24 = arg_7_0
	local var_7_25 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_25(var_7_24, var_4.EXIT_EDIT_MODE, arg_7_0.OnExitEidtMode)

	local var_7_26 = arg_7_0
	local var_7_27 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_27(var_7_26, var_4.ROTATE_ITEM, arg_7_0.OnItemDirChange)

	local var_7_28 = arg_7_0
	local var_7_29 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_29(var_7_28, var_4.ROTATE_ITEM_FAILED, arg_7_0.OnRotateItemFailed)

	local var_7_30 = arg_7_0
	local var_7_31 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_31(var_7_30, var_4.DETORY_ITEM, arg_7_0.OnDestoryItem)

	local var_7_32 = arg_7_0
	local var_7_33 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_33(var_7_32, var_4.CHILD_ITEM, arg_7_0.OnChildItem)

	local var_7_34 = arg_7_0
	local var_7_35 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_35(var_7_34, var_4.UN_CHILD_ITEM, arg_7_0.OnUnChildItem)

	local var_7_36 = arg_7_0
	local var_7_37 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_37(var_7_36, var_4.REMIND_SAVE, arg_7_0.OnRemindSave)

	local var_7_38 = arg_7_0
	local var_7_39 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_39(var_7_38, var_4.ADD_ITEM_FAILED, arg_7_0.OnAddItemFailed)

	local var_7_40 = arg_7_0
	local var_7_41 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_41(var_7_40, var_4.SHOW_FURNITURE_DESC, arg_7_0.OnShowFurnitureDesc)

	local var_7_42 = arg_7_0
	local var_7_43 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_43(var_7_42, var_4.ITEM_INTERACTION, arg_7_0.OnItemInterAction)

	local var_7_44 = arg_7_0
	local var_7_45 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_45(var_7_44, var_4.CLEAR_ITEM_INTERACTION, arg_7_0.OnClearItemInterAction)

	local var_7_46 = arg_7_0
	local var_7_47 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_47(var_7_46, var_4.ON_TOUCH_ITEM, arg_7_0.OnTouchItem)

	local var_7_48 = arg_7_0
	local var_7_49 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_49(var_7_48, var_4.ON_CANCEL_TOUCH_ITEM, arg_7_0.OnCancelTouchItem)

	local var_7_50 = arg_7_0
	local var_7_51 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_51(var_7_50, var_4.ON_ITEM_PLAY_MUSIC, arg_7_0.OnItemPlayMusic)

	local var_7_52 = arg_7_0
	local var_7_53 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_53(var_7_52, var_4.ON_ITEM_STOP_MUSIC, arg_7_0.OnItemStopMusic)

	local var_7_54 = arg_7_0
	local var_7_55 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_55(var_7_54, var_4.ON_ADD_EFFECT, arg_7_0.OnAddEffect)

	local var_7_56 = arg_7_0
	local var_7_57 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_57(var_7_56, var_4.ON_REMOVE_EFFECT, arg_7_0.OnRemoveEffect)

	local var_7_58 = arg_7_0
	local var_7_59 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_59(var_7_58, var_4.DISABLE_ROTATE_ITEM, arg_7_0.OnDisableRotation)

	local var_7_60 = arg_7_0
	local var_7_61 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_61(var_7_60, var_4.TAKE_PHOTO, arg_7_0.OnTakePhoto)

	local var_7_62 = arg_7_0
	local var_7_63 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_63(var_7_62, var_4.END_TAKE_PHOTO, arg_7_0.OnEndTakePhoto)

	local var_7_64 = arg_7_0
	local var_7_65 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_65(var_7_64, var_4.ENTER_ARCH, arg_7_0.OnEnterArch)

	local var_7_66 = arg_7_0
	local var_7_67 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_67(var_7_66, var_4.EXIT_ARCH, arg_7_0.OnExitArch)

	local var_7_68 = arg_7_0
	local var_7_69 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_69(var_7_68, var_4.REMOVE_ILLEGALITY_ITEM, arg_7_0.OnRemoveIllegalityItem)

	local var_7_70 = arg_7_0
	local var_7_71 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_71(var_7_70, var_4.OPEN_LAYER, arg_7_0.OnOpenLayer)

	local var_7_72 = arg_7_0
	local var_7_73 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_73(var_7_72, var_4.FURNITURE_PLAY_MUSICALINSTRUMENTS, arg_7_0.OnPlayMusicalInstruments)

	local var_7_74 = arg_7_0
	local var_7_75 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_75(var_7_74, var_4.FURNITURE_STOP_PLAY_MUSICALINSTRUMENTS, arg_7_0.OnStopPlayMusicalInstruments)

	local var_7_76 = arg_7_0
	local var_7_77 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_77(var_7_76, var_4.FURNITURE_MUTE_ALL, arg_7_0.OnMuteAll)

	local var_7_78 = arg_7_0
	local var_7_79 = arg_7_0.RemoveListener

	CourtYardEvent = var_4

	var_7_79(var_7_78, var_4.BACK_PRESSED, arg_7_0.OnBackPressed)

	return
end

function var_0_1.OnInited(arg_8_0)
	arg_8_0.isInit = true

	if var_0_2 then
		CourtYardMapDebug = var_1
		arg_8_0.mapDebug = var_1.New(arg_8_0.data)
	end

	arg_8_0:RefreshDepth()
	arg_8_0:RefreshMatDepth()

	return
end

function var_0_1.AllModulesAreCompletion(arg_9_0)
	pairs = var_1_10001

	for iter_9_0, iter_9_1 in var_1_10001(arg_9_0.modules) do
		if not iter_9_1:IsCompletion() then
			return false
		end
	end

	return true
end

function var_0_1.OnRemindSave(arg_10_0)
	_BackyardMsgBoxMgr = var_1_10001

	local var_10_0 = var_1_10001
	local var_10_1 = var_1_10001.Show
	local var_10_2 = {}

	i18n = var_1_10005
	var_10_2.content = var_1_10005("backyard_backyardScene_quest_saveFurniture")

	function var_10_2.onYes()
		local var_11_0 = arg_10_0

		var_0.Emit(var_11_0, "SaveFurnitures")

		return
	end

	SFX_FURNITRUE_SAVE = var_5
	var_10_2.yesSound = var_5

	function var_10_2.onNo()
		local var_12_0 = arg_10_0

		var_0.Emit(var_12_0, "RestoreFurnitures")

		return
	end

	var_10_1(var_10_0, var_10_2)

	return
end

function var_0_1.OnEnterEidtMode(arg_13_0)
	pairs = var_1_10001

	for iter_13_0, iter_13_1 in var_1_10001(arg_13_0.modules) do
		isa = var_1_10006

		local var_13_0 = iter_13_1

		CourtYardShipModule = var_1_10009

		if var_1_10006(var_13_0, var_1_10009) then
			iter_13_1:SetActive(false)
		else
			iter_13_1:BlocksRaycasts(true)
		end
	end

	local var_13_1 = arg_13_0.bg

	Vector3 = var_2
	var_13_1.localScale = var_2(0.95, 0.95, 1)

	return
end

function var_0_1.OnExitEidtMode(arg_14_0)
	pairs = var_1_10001

	for iter_14_0, iter_14_1 in var_1_10001(arg_14_0.modules) do
		isa = var_1_10006

		local var_14_0 = iter_14_1

		CourtYardShipModule = var_1_10009

		if var_1_10006(var_14_0, var_1_10009) then
			iter_14_1:SetActive(true)
		else
			iter_14_1:BlocksRaycasts(false)
		end
	end

	return
end

function var_0_1.OnCreateItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.factorys[arg_15_1:GetObjType()]
	local var_15_1 = var_3.Make(var_15_0, arg_15_1)

	if arg_15_2 then
		var_15_1:CreateWhenStoreyInit()
	end

	arg_15_0.modules[arg_15_1:GetDeathType() .. arg_15_1.id] = var_15_1

	arg_15_0:UpdateAttachment()

	return
end

function var_0_1.OnAddItem(arg_16_0)
	if not arg_16_0.isInit then
		return
	end

	arg_16_0:RefreshDepth()

	if var_0_2 then
		local var_16_0 = arg_16_0.mapDebug

		var_1.Flush(var_16_0)
	end

	return
end

function var_0_1.OnRemoveItem(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:Item2Module(arg_17_1)

	var_2.SetAsLastSibling(var_17_0)

	if var_0_2 then
		local var_17_1 = arg_17_0.mapDebug

		var_3.Flush(var_17_1)
	end

	return
end

function var_0_1.OnSelectedItem(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0.selectedModule = arg_18_0:Item2Module(arg_18_1)
	arg_18_0.gridAgent = arg_18_0:GetGridAgent(arg_18_1, arg_18_2)
	isa = var_3

	local var_18_0 = arg_18_1

	CourtYardFurniture = var_6

	if var_3(var_18_0, var_6) then
		local var_18_1 = arg_18_0.selectedAnimation

		var_3.Play(var_18_1, "anim_courtyard_dragin")

		local var_18_2 = arg_18_0:Item2Module(arg_18_1)

		arg_18_0:InitFurnitureState(var_18_2, arg_18_1)

		setParent = var_4

		var_4(arg_18_0.selectedTF, arg_18_0.rectTF)

		arg_18_0.selectedTF.sizeDelta = var_18_2._tf.sizeDelta

		arg_18_0:UpdateSelectedPosition(arg_18_1)
		arg_18_0:RegisterOp(arg_18_1)
	end

	return
end

function var_0_1.InitFurnitureState(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0:GetFurnitureStateMgr(arg_19_2)

	var_3.OnInit(var_19_0, arg_19_1, arg_19_2)

	return
end

function var_0_1.UpdateFurnitureState(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = arg_20_0:GetFurnitureStateMgr(arg_20_3)

	_ = var_1_10005

	if var_1_10005.any(arg_20_2, function(arg_21_0)
		return arg_21_0.flag == 2
	end) then
		var_20_0:OnCantPlace()
	else
		var_20_0:OnCanPlace()
	end

	var_20_0:OnUpdateScale(arg_20_1)

	return
end

function var_0_1.ResetFurnitureSelectedState(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:GetFurnitureStateMgr(arg_22_1)
	local var_22_1 = arg_22_0:Item2Module(arg_22_1)

	var_22_0:OnReset(var_22_1)

	return
end

function var_0_1.ClearFurnitureSelectedState(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:GetFurnitureStateMgr(arg_23_1)

	var_2.OnClear(var_23_0)

	return
end

function var_0_1.OnDragItem(arg_24_0, arg_24_1)
	arg_24_0:EnableZoom(false)

	return
end

function var_0_1.OnDragingItem(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	local var_25_0 = arg_25_0:Item2Module(arg_25_1)

	var_5.UpdatePosition(var_25_0, arg_25_3, arg_25_4)

	local var_25_1 = arg_25_0.gridAgent

	var_6.Flush(var_25_1, arg_25_2)

	isa = var_6

	local var_25_2 = arg_25_1

	CourtYardFurniture = var_9

	if var_6(var_25_2, var_9) then
		arg_25_0:UpdateSelectedPosition(arg_25_1)
		arg_25_0:UpdateFurnitureState(var_5, arg_25_2, arg_25_1)
	end

	return
end

function var_0_1.OnDragItemEnd(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0:EnableZoom(true)

	isa = var_3

	local var_26_0 = arg_26_1

	CourtYardFurniture = var_6

	if var_3(var_26_0, var_6) then
		local var_26_1 = arg_26_0.gridAgent

		var_3.Flush(var_26_1, arg_26_2)
		arg_26_0:UpdateSelectedPosition(arg_26_1)
		arg_26_0:ResetFurnitureSelectedState(arg_26_1)
	end

	return
end

function var_0_1.OnUnSelectedItem(arg_27_0, arg_27_1)
	arg_27_0.selectedModule = nil

	local var_27_0 = arg_27_0.gridAgent

	var_2.Clear(var_27_0)

	arg_27_0.gridAgent = nil
	isa = var_2

	local var_27_1 = arg_27_1

	CourtYardFurniture = var_1_10005

	if var_2(var_27_1, var_1_10005) then
		local var_27_2 = arg_27_0.dftAniEvent

		var_2.SetEndEvent(var_27_2, function()
			local var_28_0 = arg_27_0.dftAniEvent

			var_0.SetEndEvent(var_28_0, nil)

			setParent = var_0

			var_0(arg_27_0.selectedTF, arg_27_0.rootTF)

			return
		end)
		arg_27_0:ClearFurnitureSelectedState(arg_27_1)

		local var_27_3 = arg_27_0.selectedAnimation

		var_2.Play(var_27_3, "anim_courtyard_dragout")
		arg_27_0:UnRegisterOp()
	end

	return
end

function var_0_1.OnRemoveIllegalityItem(arg_29_0)
	pg = var_1_10001

	local var_29_0 = var_1_10001.TipsMgr.GetInstance()

	var_1.ShowTips(var_29_0, "Remove illegal Item")

	return
end

function var_0_1.OnOpenLayer(arg_30_0, arg_30_1)
	if not arg_30_0._layerCount then
		arg_30_0._layerCount = 0
	end

	arg_30_0._layerCount = arg_30_0._layerCount + (arg_30_1 and 1 or -1)

	arg_30_0:UpdateAttachment()

	return
end

function var_0_1.UpdateAttachment(arg_31_0)
	pairs = var_1_10001

	for iter_31_0, iter_31_1 in var_1_10001(arg_31_0.modules) do
		isa = var_1_10006

		local var_31_0 = iter_31_1

		CourtYardShipModule = var_1_10009

		if var_1_10006(var_31_0, var_1_10009) then
			local var_31_1 = iter_31_1

			var_1_10006 = iter_31_1.HideAttachment
			var_1_10009 = arg_31_0._layerCount ~= 0

			var_1_10006(var_31_1, var_1_10009)
		end
	end

	return
end

function var_0_1.EnableZoom(arg_32_0, arg_32_1)
	arg_32_0.zoomAgent.enabled = arg_32_1

	return
end

function var_0_1.RegisterOp(arg_33_0, arg_33_1)
	setActive = var_1_10002

	local var_33_0 = arg_33_0.rotationBtn
	local var_33_1 = arg_33_1

	var_1_10002(var_33_0, not arg_33_1.DisableRotation(var_33_1))

	onButton = var_1_10002

	local var_33_2 = arg_33_0
	local var_33_3 = arg_33_0.rotationBtn

	local function var_33_4()
		local var_34_0 = arg_33_0

		var_0.Emit(var_34_0, "RotateFurniture", arg_33_1.id)

		return
	end

	SFX_PANEL = var_33_1

	var_1_10002(var_33_2, var_33_3, var_33_4, var_33_1)

	onButton = var_1_10002

	local var_33_5 = arg_33_0
	local var_33_6 = arg_33_0.confirmBtn

	local function var_33_7()
		local var_35_0 = arg_33_0

		var_0.Emit(var_35_0, "UnSelectFurniture", arg_33_1.id)

		return
	end

	SFX_PANEL = var_33_1

	var_1_10002(var_33_5, var_33_6, var_33_7, var_33_1)

	onButton = var_1_10002

	local var_33_8 = arg_33_0
	local var_33_9 = arg_33_0.removeBtn

	local function var_33_10()
		local var_36_0 = arg_33_0

		var_0.Emit(var_36_0, "RemoveFurniture", arg_33_1.id)

		return
	end

	SFX_PANEL = var_33_1

	var_1_10002(var_33_8, var_33_9, var_33_10, var_33_1)

	onButton = var_1_10002

	local var_33_11 = arg_33_0
	local var_33_12 = arg_33_0.scrollrect

	local function var_33_13()
		local var_37_0 = arg_33_0

		var_0.Emit(var_37_0, "UnSelectFurniture", arg_33_1.id)

		return
	end

	SFX_PANEL = var_33_1

	var_1_10002(var_33_11, var_33_12, var_33_13, var_33_1)

	local function var_33_14()
		local var_38_0 = arg_33_0

		var_0.Emit(var_38_0, "BeginDragFurniture", arg_33_1.id)

		return
	end

	local function var_33_15(arg_39_0)
		local var_39_0 = arg_33_0

		var_1.Emit(var_39_0, "DragingFurniture", arg_33_1.id, arg_39_0)

		return
	end

	local function var_33_16(arg_40_0)
		local var_40_0 = arg_33_0

		var_1.Emit(var_40_0, "DragFurnitureEnd", arg_33_1.id, arg_40_0)

		return
	end

	local var_33_17 = arg_33_0.dragBtn

	var_5.Active(var_33_17, var_33_14, var_33_15, var_33_16)

	return
end

function var_0_1.UnRegisterOp(arg_41_0)
	removeOnButton = var_1_10001

	var_1_10001(arg_41_0.rotationBtn)

	removeOnButton = var_1_10001

	var_1_10001(arg_41_0.confirmBtn)

	removeOnButton = var_1_10001

	var_1_10001(arg_41_0.removeBtn)

	removeOnButton = var_1_10001

	var_1_10001(arg_41_0.scrollrect)

	local var_41_0 = arg_41_0.dragBtn

	var_1.DeActive(var_41_0, false)

	return
end

function var_0_1.OnItemDirChange(arg_42_0, arg_42_1, arg_42_2)
	isa = var_1_10003

	local var_42_0 = arg_42_1

	CourtYardFurniture = var_1_10006

	if var_1_10003(var_42_0, var_1_10006) then
		arg_42_0:UpdateSelectedPosition(arg_42_1)

		local var_42_1 = arg_42_0.data

		if var_3.InEidtMode(var_42_1) and arg_42_0.gridAgent then
			local var_42_2 = arg_42_0.gridAgent

			var_3.Flush(var_42_2, arg_42_2)
		end

		local var_42_3 = arg_42_0:GetFurnitureStateMgr(arg_42_1)

		var_3.OnUpdateScale(var_42_3, arg_42_0:Item2Module(arg_42_1))
	else
		local var_42_4 = arg_42_0.gridAgent

		var_3.Flush(var_42_4, arg_42_2)
	end

	return
end

function var_0_1.OnRotateItemFailed(arg_43_0)
	pg = var_1_10001

	local var_43_0 = var_1_10001.TipsMgr.GetInstance()
	local var_43_1 = var_1.ShowTips

	i18n = var_1_10004

	var_43_1(var_43_0, var_1_10004("backyard_backyardScene_error_canNotRotate"))

	return
end

function var_0_1.OnDisableRotation(arg_44_0)
	pg = var_1_10001

	local var_44_0 = var_1_10001.TipsMgr.GetInstance()
	local var_44_1 = var_1.ShowTips

	i18n = var_1_10004

	var_44_1(var_44_0, var_1_10004("backyard_backyardScene_Disable_Rotation"))

	return
end

function var_0_1.OnAddItemFailed(arg_45_0)
	pg = var_1_10001

	local var_45_0 = var_1_10001.TipsMgr.GetInstance()
	local var_45_1 = var_1.ShowTips

	i18n = var_1_10004

	var_45_1(var_45_0, var_1_10004("backyard_backyardScene_error_noPosPutFurniture"))

	return
end

function var_0_1.OnDestoryItem(arg_46_0, arg_46_1)
	local var_46_0 = arg_46_0:Item2Module(arg_46_1)

	var_2.Dispose(var_46_0)

	arg_46_0.modules[arg_46_1:GetDeathType() .. arg_46_1.id] = nil

	return
end

function var_0_1.OnChildItem(arg_47_0, arg_47_1, arg_47_2)
	local var_47_0 = arg_47_0:Item2Module(arg_47_1)
	local var_47_1 = arg_47_0:Item2Module(arg_47_2)

	var_4.AddChild(var_47_1, var_47_0)

	isa = var_5

	local var_47_2 = arg_47_1

	CourtYardShip = var_8

	if var_5(var_47_2, var_8) then
		var_4:BlocksRaycasts(true)
	end

	return
end

function var_0_1.OnUnChildItem(arg_48_0, arg_48_1, arg_48_2)
	local var_48_0 = arg_48_0:Item2Module(arg_48_1)
	local var_48_1 = arg_48_0:Item2Module(arg_48_2)

	var_4.RemoveChild(var_48_1, var_48_0)

	isa = var_5

	local var_48_2 = arg_48_1

	CourtYardShip = var_8

	if var_5(var_48_2, var_8) then
		var_4:BlocksRaycasts(false)
	end

	return
end

function var_0_1.OnEnterArch(arg_49_0, arg_49_1, arg_49_2)
	return
end

function var_0_1.OnExitArch(arg_50_0, arg_50_1, arg_50_2)
	return
end

function var_0_1.OnAddMatItem(arg_51_0)
	if not arg_51_0.isInit then
		return
	end

	arg_51_0:RefreshMatDepth()

	return
end

function var_0_1.OnRemoveMatItem(arg_52_0, arg_52_1)
	local var_52_0 = arg_52_0:Item2Module(arg_52_1)

	var_2.SetAsLastSibling(var_52_0)

	return
end

function var_0_1.OnShowFurnitureDesc(arg_53_0, arg_53_1)
	local var_53_0 = arg_53_0.descPage

	var_2.ExecuteAction(var_53_0, "Show", arg_53_1)

	return
end

function var_0_1.OnItemInterAction(arg_54_0, arg_54_1, arg_54_2, arg_54_3)
	local var_54_0 = arg_54_0:Item2Module(arg_54_1)
	local var_54_1 = arg_54_0:Item2Module(arg_54_2)

	var_5.BlocksRaycasts(var_54_1, true)

	local var_54_2 = {}

	if arg_54_3:GetBodyMask() then
		table = var_7

		var_7.insert(var_54_2, var_5:GetBodyMask(arg_54_3.id))
	end

	if arg_54_3:GetUsingAnimator() then
		table = var_54_1

		var_54_1.insert(var_54_2, var_5:GetAnimator(var_7.key))
	end

	local var_54_3

	if #var_54_2 == 0 then
		local var_54_4 = var_54_0._tf

		var_9.SetParent(var_54_4, var_5.interactionTF)

		var_54_3 = var_54_0._tf
	else
		local var_54_5 = var_54_0._tf

		ipairs = var_1_10010

		for iter_54_0, iter_54_1 in var_1_10010(var_54_2) do
			var_54_5:SetParent(iter_54_1, false)

			var_54_5 = iter_54_1
		end

		var_54_3 = var_54_5
		CourtYardCalcUtil = var_10

		local var_54_6 = var_10.GetSign(var_5._tf.localScale.x)
		local var_54_7 = var_54_0._tf.localScale
		local var_54_8 = var_54_0._tf

		Vector3 = iter_54_0
		var_54_8.localScale = iter_54_0(var_54_6 * var_54_7.x, var_54_7.y, 1)
	end

	var_54_0:SetSiblingIndex(arg_54_3.id - 1)

	local var_54_9 = arg_54_0.bgmAgent

	var_9.Play(var_54_9, arg_54_2:GetInterActionBgm())
	arg_54_0:AddInteractionFollower(arg_54_3, var_54_3, var_5)

	return
end

function var_0_1.OnClearItemInterAction(arg_55_0, arg_55_1, arg_55_2, arg_55_3)
	local var_55_0 = arg_55_0
	local var_55_1 = arg_55_0.Item2Module(var_55_0, arg_55_1)
	local var_55_2 = arg_55_0:Item2Module(arg_55_2)

	isa = var_55_0

	local var_55_3 = var_55_2

	CourtYardFurnitureModule = var_1_10009

	if var_55_0(var_55_3, var_1_10009) and #arg_55_2:GetUsingSlots() == 0 then
		var_55_2:BlocksRaycasts(false)
	end

	local var_55_4 = arg_55_0:Item2Module(arg_55_2)

	if arg_55_3:GetBodyMask() then
		local var_55_5 = var_55_2:GetBodyMask(arg_55_3.id)

		var_7.SetParent(var_55_5, var_55_2.interactionTF)

		var_7.sizeDelta = arg_55_2:GetBodyMasks()[arg_55_3.id].size
		var_7.anchoredPosition = var_9.offset
	end

	local var_55_6 = var_55_1._tf

	var_7.SetParent(var_55_6, var_55_1:GetParentTF())

	local var_55_7 = arg_55_0.bgmAgent

	var_7.Stop(var_55_7, arg_55_2:GetInterActionBgm())
	arg_55_0:ClearInteractionFollower(arg_55_3, var_55_1, var_55_2)

	return
end

function var_0_1.AddInteractionFollower(arg_56_0, arg_56_1, arg_56_2, arg_56_3)
	if not arg_56_1:GetFollower() or not arg_56_2 then
		return
	end

	local var_56_0 = var_4.bone
	local var_56_1 = arg_56_3:FindBoneFollower(var_56_0)

	IsNil = var_1_10007

	if var_1_10007(var_56_1) then
		var_56_1 = arg_56_3:NewBoneFollower(var_56_0)
	else
		setActive = var_7

		var_7(var_56_1, true)
	end

	Vector3 = var_7
	var_56_1.localScale = var_7(1, 1, 1)

	arg_56_2:SetParent(var_56_1, false)

	return
end

function var_0_1.ClearInteractionFollower(arg_57_0, arg_57_1, arg_57_2, arg_57_3)
	if not arg_57_1:GetFollower() then
		return
	end

	local var_57_0 = var_4.bone
	local var_57_1 = arg_57_3:FindBoneFollower(var_57_0)

	IsNil = var_1_10007

	if not var_1_10007(var_57_1) then
		setActive = var_7

		var_7(var_57_1, false)
	end

	return
end

function var_0_1.OnTouchItem(arg_58_0, arg_58_1)
	isa = var_1_10002

	local var_58_0 = arg_58_1

	CourtYardFurniture = var_1_10005

	if var_1_10002(var_58_0, var_1_10005) then
		local var_58_1 = arg_58_0.effectAgent

		var_2.EnableEffect(var_58_1, arg_58_1:GetTouchEffect())

		local var_58_2 = arg_58_0.soundAgent

		var_2.Play(var_58_2, arg_58_1:GetTouchSound())

		local var_58_3 = arg_58_0.bgAgent

		var_2.Switch(var_58_3, true, arg_58_1:GetTouchBg())
	end

	return
end

function var_0_1.OnCancelTouchItem(arg_59_0, arg_59_1)
	isa = var_1_10002

	local var_59_0 = arg_59_1

	CourtYardFurniture = var_1_10005

	if var_1_10002(var_59_0, var_1_10005) then
		local var_59_1 = arg_59_0.effectAgent

		var_2.DisableEffect(var_59_1, arg_59_1:GetTouchEffect())

		local var_59_2 = arg_59_0.bgAgent

		var_2.Switch(var_59_2, false, arg_59_1:GetTouchBg())
	end

	return
end

function var_0_1.OnItemPlayMusic(arg_60_0, arg_60_1, arg_60_2)
	if arg_60_2 == 1 then
		local var_60_0 = arg_60_0.soundAgent

		var_3.Play(var_60_0, arg_60_1)
	elseif arg_60_2 == 2 then
		local var_60_1 = arg_60_0.bgmAgent

		var_3.Play(var_60_1, arg_60_1)
	end

	return
end

function var_0_1.OnItemStopMusic(arg_61_0, arg_61_1, arg_61_2)
	if arg_61_2 == 2 then
		local var_61_0 = arg_61_0.bgmAgent

		var_3.Reset(var_61_0)
	elseif arg_61_2 == 1 then
		local var_61_1 = arg_61_0.soundAgent

		var_3.Stop(var_61_1)
	end

	return
end

function var_0_1.OnMuteAll(arg_62_0)
	local var_62_0 = arg_62_0.bgmAgent

	var_1.Clear(var_62_0)

	local var_62_1 = arg_62_0.soundAgent

	var_1.Clear(var_62_1)

	return
end

function var_0_1.OnPlayMusicalInstruments(arg_63_0, arg_63_1)
	if arg_63_0.descPage then
		local var_63_0 = arg_63_0.descPage

		if var_2.GetLoaded(var_63_0) then
			local var_63_1 = arg_63_0.descPage

			if var_2.isShowing(var_63_1) then
				local var_63_2 = arg_63_0.descPage

				var_2.Close(var_63_2)
			end
		end
	end

	local var_63_3 = arg_63_1:GetType()

	Furniture = var_1_10003

	if var_63_3 == var_1_10003.TYPE_LUTE then
		local var_63_4 = arg_63_0.playTheLutePage

		var_3.ExecuteAction(var_63_4, "Show", arg_63_1)
	end

	return
end

function var_0_1.OnStopPlayMusicalInstruments(arg_64_0, arg_64_1)
	local var_64_0 = arg_64_0.bgmAgent

	var_2.Reset(var_64_0)

	if arg_64_0.descPage then
		local var_64_1 = arg_64_0.descPage

		if var_2.GetLoaded(var_64_1) then
			local var_64_2 = arg_64_0.descPage

			var_2.ExecuteAction(var_64_2, "Show", arg_64_1)
		end
	end

	return
end

function var_0_1.OnAddEffect(arg_65_0, arg_65_1)
	local var_65_0 = arg_65_0.effectAgent

	var_2.EnableEffect(var_65_0, arg_65_1)

	return
end

function var_0_1.OnRemoveEffect(arg_66_0, arg_66_1)
	local var_66_0 = arg_66_0.effectAgent

	var_2.DisableEffect(var_66_0, arg_66_1)

	return
end

function var_0_1.OnBackPressed(arg_67_0)
	if arg_67_0.playTheLutePage then
		local var_67_0 = arg_67_0.playTheLutePage

		if var_1.GetLoaded(var_67_0) then
			local var_67_1 = arg_67_0.playTheLutePage

			if var_1.isShowing(var_67_1) then
				local var_67_2 = arg_67_0.playTheLutePage

				var_1.Hide(var_67_2)

				return
			end
		end
	end

	if arg_67_0.descPage then
		local var_67_3 = arg_67_0.descPage

		if var_1.GetLoaded(var_67_3) then
			local var_67_4 = arg_67_0.descPage

			if var_1.isShowing(var_67_4) then
				local var_67_5 = arg_67_0.descPage

				var_1.Close(var_67_5)

				return
			end
		end
	end

	arg_67_0:Emit("Quit")

	return
end

function var_0_1.UpdateSelectedPosition(arg_68_0, arg_68_1)
	local var_68_0 = arg_68_0:Item2Module(arg_68_1)
	local var_68_1 = var_2.GetCenterPoint(var_68_0)

	arg_68_0.selectedTF.localPosition = var_68_1

	local var_68_2 = arg_68_0:GetFurnitureStateMgr(arg_68_1)

	var_4.OnUpdate(var_68_2, var_2)

	return
end

function var_0_1.GetGridAgent(arg_69_0, arg_69_1, arg_69_2)
	local var_69_0

	isa = var_1_10004

	local var_69_1 = arg_69_1

	CourtYardWallFurniture = var_1_10007

	if var_1_10004(var_69_1, var_1_10007) then
		var_69_0 = arg_69_0.gridAgents[2]
	else
		var_69_0 = arg_69_0.gridAgents[1]
	end

	if arg_69_0.gridAgent and var_69_0 ~= arg_69_0.gridAgent then
		local var_69_2 = arg_69_0.gridAgent

		var_4.Clear(var_69_2)
	end

	var_69_0:Reset(arg_69_2)

	return var_69_0
end

function var_0_1.ItemsIsLoaded(arg_70_0)
	table = var_1_10001

	if var_1_10001.getCount(arg_70_0.modules) == 0 then
		return false
	end

	pairs = var_1

	for iter_70_0, iter_70_1 in var_1(arg_70_0.modules) do
		if not iter_70_1:IsInit() then
			return false
		end
	end

	return true
end

function var_0_1.Item2Module(arg_71_0, arg_71_1)
	return arg_71_0.modules[arg_71_1:GetDeathType() .. arg_71_1.id]
end

function var_0_1.RefreshDepth(arg_72_0)
	eachChild = var_1_10001

	var_1_10001(arg_72_0.wall, function(arg_73_0)
		setParent = var_2_10001

		var_2_10001(arg_73_0, arg_72_0.floor)

		return
	end)

	local var_72_0 = {}

	ipairs = var_1_10002

	local var_72_1 = arg_72_0.data

	for iter_72_0, iter_72_1 in var_1_10002(var_4.GetItems(var_72_1)) do
		var_1_10007 = arg_72_0:Item2Module(iter_72_1)
		isa = var_1_10008

		local var_72_2 = iter_72_1

		CourtYardWallFurniture = var_1_10011

		if var_1_10008(var_72_2, var_1_10011) then
			table = var_1_10008

			var_1_10008.insert(var_72_0, var_1_10007)
		end

		var_1_10007:SetSiblingIndex(iter_72_0 - 1)
	end

	pairs = var_2

	for iter_72_2, iter_72_3 in var_2(var_72_0) do
		setParent = var_1_10007

		var_1_10007(iter_72_3._tf, arg_72_0.wall)
	end

	return
end

function var_0_1.RefreshMatDepth(arg_74_0)
	ipairs = var_1_10001

	local var_74_0 = arg_74_0.data

	for iter_74_0, iter_74_1 in var_1_10001(var_3.GetMatItems(var_74_0)) do
		local var_74_1 = arg_74_0:Item2Module(iter_74_1)

		var_6.SetSiblingIndex(var_74_1, iter_74_0 - 1)
	end

	return
end

function var_0_1.OnTakePhoto(arg_75_0)
	GetOrAddComponent = var_1_10001

	local var_75_0 = arg_75_0.selectedTF

	typeof = var_1_10004
	CanvasGroup = var_1_10006

	local var_75_1 = var_1_10001(var_75_0, var_1_10004(var_1_10006))

	var_75_1.alpha = 0
	Vector3 = var_75_1

	local var_75_2 = var_75_1(0.6, 0.6, 1)

	arg_75_0.bgScale = arg_75_0.bg.localScale
	arg_75_0.bg.localScale = var_75_2

	local var_75_3 = arg_75_0.bg.localPosition

	Vector3 = var_3

	if var_75_3 ~= var_3(0, -100, 0) then
		arg_75_0.bgPos = arg_75_0.bg.localPosition

		local var_75_4 = arg_75_0.bg

		Vector3 = var_3
		var_75_4.localPosition = var_3(0, -100, 0)
	end

	return
end

function var_0_1.OnEndTakePhoto(arg_76_0)
	GetOrAddComponent = var_1_10001

	local var_76_0 = arg_76_0.selectedTF

	typeof = var_1_10004
	CanvasGroup = var_1_10006
	var_1_10001(var_76_0, var_1_10004(var_1_10006)).alpha = 1

	if arg_76_0.bgScale then
		arg_76_0.bg.localScale = arg_76_0.bgScale
	end

	if arg_76_0.bgPos then
		arg_76_0.bg.localPosition = arg_76_0.bgPos
	end

	return
end

function var_0_1.OnDispose(arg_77_0)
	arg_77_0.exited = true

	local var_77_0 = arg_77_0.dftAniEvent

	var_1.SetEndEvent(var_77_0, nil)

	pairs = var_1

	for iter_77_0, iter_77_1 in var_1(arg_77_0.modules) do
		iter_77_1:Dispose()
	end

	arg_77_0.modules = nil
	pairs = var_1

	for iter_77_2, iter_77_3 in var_1(arg_77_0.factorys) do
		iter_77_3:Dispose()
	end

	arg_77_0.factorys = nil

	local var_77_1 = arg_77_0.dragBtn

	var_1.Dispose(var_77_1)

	arg_77_0.dragBtn = nil
	pairs = var_1

	for iter_77_4, iter_77_5 in var_1(arg_77_0.gridAgents) do
		iter_77_5:Dispose()
	end

	arg_77_0.gridAgents = nil

	if var_0_2 then
		local var_77_2 = arg_77_0.mapDebug

		var_1.Dispose(var_77_2)
	end

	if arg_77_0.pedestalModule then
		local var_77_3 = arg_77_0.pedestalModule

		var_1.Dispose(var_77_3)

		arg_77_0.pedestalModule = nil
	end

	local var_77_4 = arg_77_0.effectAgent

	var_1.Dispose(var_77_4)

	arg_77_0.effectAgent = nil

	local var_77_5 = arg_77_0.soundAgent

	var_1.Dispose(var_77_5)

	arg_77_0.soundAgent = nil

	local var_77_6 = arg_77_0.bgAgent

	var_1.Dispose(var_77_6)

	arg_77_0.bgAgent = nil

	local var_77_7 = arg_77_0.bgmAgent

	var_1.Dispose(var_77_7)

	arg_77_0.bgmAgent = nil

	local var_77_8 = arg_77_0.descPage

	var_1.Destroy(var_77_8)

	arg_77_0.descPage = nil

	local var_77_9 = arg_77_0.playTheLutePage

	var_1.Destroy(var_77_9)

	arg_77_0.playTheLutePage = nil
	IsNil = var_1

	if not var_1(arg_77_0._go) then
		Object = var_1

		var_1.Destroy(arg_77_0._go)
	end

	return
end

return var_0_1
