class = var_0_10000

local var_0_0 = "IslandView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandBaseView"))

function var_0_1.Init(arg_1_0)
	arg_1_0._unitList = {}
	arg_1_0.isInit = false

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.RegisterUnitList

	IslandConst = var_1_10004

	var_1_1(var_1_0, var_1_10004.UNIT_LIST_PLAYER)

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0.RegisterUnitList

	IslandConst = var_4

	var_1_3(var_1_2, var_4.UNIT_LIST_OBJ)

	local var_1_4 = arg_1_0
	local var_1_5 = arg_1_0.RegisterUnitList

	IslandConst = var_4

	var_1_5(var_1_4, var_4.UNIT_LIST_SYSTEM)

	local var_1_6 = arg_1_0
	local var_1_7 = arg_1_0.RegisterUnitList

	IslandConst = var_4

	var_1_7(var_1_6, var_4.UNIT_LIST_DELEGATION)

	local var_1_8 = arg_1_0
	local var_1_9 = arg_1_0.RegisterUnitList

	IslandConst = var_4

	var_1_9(var_1_8, var_4.UNIT_LIST_STROLL)

	local var_1_10 = arg_1_0
	local var_1_11 = arg_1_0.RegisterUnitList

	IslandConst = var_4

	var_1_11(var_1_10, var_4.UNIT_LIST_MANAGE_SYSTEM)

	local var_1_12 = arg_1_0
	local var_1_13 = arg_1_0.RegisterUnitList

	IslandConst = var_4

	var_1_13(var_1_12, var_4.UNIT_LIST_MANAGE)

	local var_1_14 = arg_1_0
	local var_1_15 = arg_1_0.RegisterUnitList

	IslandConst = var_4

	var_1_15(var_1_14, var_4.UNIT_LIST_DELEGATION_ANIMATION)

	local var_1_16 = arg_1_0
	local var_1_17 = arg_1_0.RegisterUnitList

	IslandConst = var_4

	var_1_17(var_1_16, var_4.UNIT_LIST_FOLLOW)

	local var_1_18 = arg_1_0
	local var_1_19 = arg_1_0.RegisterUnitList

	IslandConst = var_4

	var_1_19(var_1_18, var_4.UNIT_LIST_DELAY)

	local var_1_20 = arg_1_0
	local var_1_21 = arg_1_0.RegisterUnitList

	IslandConst = var_4

	var_1_21(var_1_20, var_4.UNIT_LIST_PHOTO)

	local var_1_22 = arg_1_0
	local var_1_23 = arg_1_0.RegisterUnitList

	IslandConst = var_4

	var_1_23(var_1_22, var_4.UNIT_LIST_FISH_POINT)

	local var_1_24 = arg_1_0
	local var_1_25 = arg_1_0.RegisterUnitList

	IslandConst = var_4

	var_1_25(var_1_24, var_4.UNIT_LIST_DELEGATE_UNIT)

	local var_1_26 = arg_1_0
	local var_1_27 = arg_1_0.RegisterUnitList

	IslandConst = var_4

	var_1_27(var_1_26, var_4.UNIT_LIST_PRODUCT_SYSTEM)

	local var_1_28 = arg_1_0
	local var_1_29 = arg_1_0.RegisterUnitList

	IslandConst = var_4

	var_1_29(var_1_28, var_4.UNIT_LIST_CHEATER_ITEM)

	local var_1_30 = {}

	IslandConst = var_1_10002

	local var_1_31 = var_1_10002.UNIT_TYPE_ITEM

	IslandStaticUnitBuilder = var_1_28

	local var_1_32 = var_1_28.New
	local var_1_33 = arg_1_0

	IslandConst = var_1_10006
	var_1_30[var_1_31] = var_1_32(var_1_33, var_1_10006.UNIT_LIST_OBJ)
	IslandConst = var_1_31

	local var_1_34 = var_1_31.UNIT_TYPE_CHAR

	IslandNpcBuilder = var_3

	local var_1_35 = var_3.New
	local var_1_36 = arg_1_0

	IslandConst = var_6
	var_1_30[var_1_34] = var_1_35(var_1_36, var_6.UNIT_LIST_OBJ)
	IslandConst = var_1_34

	local var_1_37 = var_1_34.UNIT_TYPE_VISITOR

	IslandVisitorBuilder = var_3

	local var_1_38 = var_3.New
	local var_1_39 = arg_1_0

	IslandConst = var_6
	var_1_30[var_1_37] = var_1_38(var_1_39, var_6.UNIT_LIST_PLAYER)
	IslandConst = var_1_37

	local var_1_40 = var_1_37.UNIT_TYPE_PLAYER

	IslandPlayerBuilder = var_3

	local var_1_41 = var_3.New
	local var_1_42 = arg_1_0

	IslandConst = var_6
	var_1_30[var_1_40] = var_1_41(var_1_42, var_6.UNIT_LIST_PLAYER)
	IslandConst = var_1_40

	local var_1_43 = var_1_40.UNIT_TYPE_VIRTUAL_INTERACT

	IslandVirtualInteractBuilder = var_3

	local var_1_44 = var_3.New
	local var_1_45 = arg_1_0

	IslandConst = var_6
	var_1_30[var_1_43] = var_1_44(var_1_45, var_6.UNIT_LIST_OBJ)
	IslandConst = var_1_43

	local var_1_46 = var_1_43.UNIT_TYPE_ITEM_INTERACT

	IslandItemInteractBuilder = var_3

	local var_1_47 = var_3.New
	local var_1_48 = arg_1_0

	IslandConst = var_6
	var_1_30[var_1_46] = var_1_47(var_1_48, var_6.UNIT_LIST_OBJ)
	IslandConst = var_1_46

	local var_1_49 = var_1_46.UNIT_TYPE_ITEM_HANDLE_COLLECT

	IslandItemHandCollectBuilder = var_3

	local var_1_50 = var_3.New
	local var_1_51 = arg_1_0

	IslandConst = var_6
	var_1_30[var_1_49] = var_1_50(var_1_51, var_6.UNIT_LIST_OBJ)
	IslandConst = var_1_49

	local var_1_52 = var_1_49.UNIT_TYPE_ITEM_HANDLE_PLANTING

	IslandItemHandPlantBuilder = var_3

	local var_1_53 = var_3.New
	local var_1_54 = arg_1_0

	IslandConst = var_6
	var_1_30[var_1_52] = var_1_53(var_1_54, var_6.UNIT_LIST_OBJ)
	IslandConst = var_1_52

	local var_1_55 = var_1_52.UNIT_TYPE_STROLL

	IslandStrollNpcBuilder = var_3

	local var_1_56 = var_3.New
	local var_1_57 = arg_1_0

	IslandConst = var_6
	var_1_30[var_1_55] = var_1_56(var_1_57, var_6.UNIT_LIST_STROLL)
	IslandConst = var_1_55

	local var_1_58 = var_1_55.UNIT_TYPE_SYSTEM

	IslandSystemNpcBuilder = var_3

	local var_1_59 = var_3.New
	local var_1_60 = arg_1_0

	IslandConst = var_6
	var_1_30[var_1_58] = var_1_59(var_1_60, var_6.UNIT_LIST_DELEGATION)
	IslandConst = var_1_58

	local var_1_61 = var_1_58.UNIT_TYPE_ITEM_GATHER_ITEM

	IslandItemWildGahterBuilder = var_3

	local var_1_62 = var_3.New
	local var_1_63 = arg_1_0

	IslandConst = var_6
	var_1_30[var_1_61] = var_1_62(var_1_63, var_6.UNIT_LIST_OBJ)
	IslandConst = var_1_61

	local var_1_64 = var_1_61.UNIT_TYPE_ITEM_WILD_COLLECT_ITEM

	IslandItemWildGahterBuilder = var_3

	local var_1_65 = var_3.New
	local var_1_66 = arg_1_0

	IslandConst = var_6
	var_1_30[var_1_64] = var_1_65(var_1_66, var_6.UNIT_LIST_OBJ)
	IslandConst = var_1_64

	local var_1_67 = var_1_64.UNIT_TYPE_MANAGE_CHARA

	IslandSystemDelegationUnitBuilder = var_3

	local var_1_68 = var_3.New
	local var_1_69 = arg_1_0

	IslandConst = var_6
	var_1_30[var_1_67] = var_1_68(var_1_69, var_6.UNIT_LIST_MANAGE)
	IslandConst = var_1_67

	local var_1_70 = var_1_67.UNIT_TYPE_MANAGE_ITEM

	IslandStaticUnitBuilder = var_3

	local var_1_71 = var_3.New
	local var_1_72 = arg_1_0

	IslandConst = var_6
	var_1_30[var_1_70] = var_1_71(var_1_72, var_6.UNIT_LIST_MANAGE)
	IslandConst = var_1_70

	local var_1_73 = var_1_70.UNIT_TYPE_MANAGE_CUSTOMER

	IslandStaticCharaBuilder = var_3

	local var_1_74 = var_3.New
	local var_1_75 = arg_1_0

	IslandConst = var_6
	var_1_30[var_1_73] = var_1_74(var_1_75, var_6.UNIT_LIST_MANAGE)
	IslandConst = var_1_73

	local var_1_76 = var_1_73.UNIT_TYPE_SYSTEM_DELEAGTION

	IslandSystemDelegationUnitBuilder = var_3

	local var_1_77 = var_3.New
	local var_1_78 = arg_1_0

	IslandConst = var_6
	var_1_30[var_1_76] = var_1_77(var_1_78, var_6.UNIT_LIST_DELEGATION)
	IslandConst = var_1_76

	local var_1_79 = var_1_76.UNIT_TYPE_SYSTEM_DELEAGTION_ANIMATION

	IslandSystemDelegationUnitBuilder = var_3

	local var_1_80 = var_3.New
	local var_1_81 = arg_1_0

	IslandConst = var_6
	var_1_30[var_1_79] = var_1_80(var_1_81, var_6.UNIT_LIST_DELEGATION_ANIMATION)
	IslandConst = var_1_79

	local var_1_82 = var_1_79.UNIT_TYPE_FOLLOWER

	IslandFollowNpcBuilder = var_3

	local var_1_83 = var_3.New
	local var_1_84 = arg_1_0

	IslandConst = var_6
	var_1_30[var_1_82] = var_1_83(var_1_84, var_6.UNIT_LIST_FOLLOW)
	IslandConst = var_1_82

	local var_1_85 = var_1_82.UNIT_TYPE_ITEM_DELAY_RECYCLE

	IslandDelayRecycleUnitBuilder = var_3

	local var_1_86 = var_3.New
	local var_1_87 = arg_1_0

	IslandConst = var_6
	var_1_30[var_1_85] = var_1_86(var_1_87, var_6.UNIT_LIST_DELAY)
	IslandConst = var_1_85

	local var_1_88 = var_1_85.UNIT_TYPE_FIRST_TAKE_PHOTO_ITEM

	IslandTakePhotoBuilder = var_3

	local var_1_89 = var_3.New
	local var_1_90 = arg_1_0

	IslandConst = var_6
	var_1_30[var_1_88] = var_1_89(var_1_90, var_6.UNIT_LIST_PHOTO)
	IslandConst = var_1_88

	local var_1_91 = var_1_88.UNIT_TYPE_FISH_POINT

	IslandStaticUnitBuilder = var_3

	local var_1_92 = var_3.New
	local var_1_93 = arg_1_0

	IslandConst = var_6
	var_1_30[var_1_91] = var_1_92(var_1_93, var_6.UNIT_LIST_FISH_POINT)
	IslandConst = var_1_91

	local var_1_94 = var_1_91.UNIT_TYPE_DELEGATE_FISH

	IslandDelegationFishBuilder = var_3

	local var_1_95 = var_3.New
	local var_1_96 = arg_1_0

	IslandConst = var_6
	var_1_30[var_1_94] = var_1_95(var_1_96, var_6.UNIT_LIST_DELEGATE_UNIT)
	IslandConst = var_1_94

	local var_1_97 = var_1_94.UNIT_TYPE_CHEATERTAVERN_PLAYER

	IslandCheaterTavernPlayerBuilder = var_3

	local var_1_98 = var_3.New
	local var_1_99 = arg_1_0

	IslandConst = var_6
	var_1_30[var_1_97] = var_1_98(var_1_99, var_6.UNIT_LIST_PLAYER)
	IslandConst = var_1_97

	local var_1_100 = var_1_97.UNIT_TYPE_CHEATERTAVERN_TABLE

	IslandCheaterTavernTableBuilder = var_3

	local var_1_101 = var_3.New
	local var_1_102 = arg_1_0

	IslandConst = var_6
	var_1_30[var_1_100] = var_1_101(var_1_102, var_6.UNIT_LIST_CHEATER_ITEM)
	IslandConst = var_1_100

	local var_1_103 = var_1_100.UNIT_TYPE_CHEATERTAVERN_CHAIR

	IslandCheaterTavernChairBuilder = var_3

	local var_1_104 = var_3.New
	local var_1_105 = arg_1_0

	IslandConst = var_6
	var_1_30[var_1_103] = var_1_104(var_1_105, var_6.UNIT_LIST_CHEATER_ITEM)
	arg_1_0.unitBuilders = var_1_30

	local var_1_106 = {}

	IslandConst = var_1_103

	local var_1_107 = var_1_103.SYSTEM_TYPE_CHARACTER

	IslandSystemBuilder = var_3

	local var_1_108 = var_3.New
	local var_1_109 = arg_1_0

	IslandCharacterSystem = var_6
	var_1_106[var_1_107] = var_1_108(var_1_109, var_6)
	IslandConst = var_1_107

	local var_1_110 = var_1_107.SYSTEM_TYPE_PRODUCT

	IslandSystemBuilder = var_3

	local var_1_111 = var_3.New
	local var_1_112 = arg_1_0

	IslandProductSystem = var_6
	IslandConst = var_1_10007
	var_1_106[var_1_110] = var_1_111(var_1_112, var_6, var_1_10007.UNIT_LIST_PRODUCT_SYSTEM)
	IslandConst = var_1_110

	local var_1_113 = var_1_110.SYSTEM_TYPE_SEEKGAME

	IslandSystemBuilder = var_3

	local var_1_114 = var_3.New
	local var_1_115 = arg_1_0

	IslandSeekGameSystem = var_6
	var_1_106[var_1_113] = var_1_114(var_1_115, var_6)
	IslandConst = var_1_113

	local var_1_116 = var_1_113.SYSTEM_TYPE_GROUND

	IslandGroundSystemBuilder = var_3

	local var_1_117 = var_3.New
	local var_1_118 = arg_1_0

	IslandGoundLayerSystem = var_6
	var_1_106[var_1_116] = var_1_117(var_1_118, var_6)
	IslandConst = var_1_116

	local var_1_119 = var_1_116.SYSTEM_TYPE_GRASSLAND

	IslandSystemBuilder = var_3

	local var_1_120 = var_3.New
	local var_1_121 = arg_1_0

	IslandGrassLandSystem = var_6
	var_1_106[var_1_119] = var_1_120(var_1_121, var_6)
	IslandConst = var_1_119

	local var_1_122 = var_1_119.SYSTEM_TYPE_MANAGE

	IslandManageSystemBuilder = var_3

	local var_1_123 = var_3.New
	local var_1_124 = arg_1_0

	IslandManageSystem = var_6
	var_1_106[var_1_122] = var_1_123(var_1_124, var_6)
	arg_1_0.systemBuilders = var_1_106
	IslandDetectionSystem = var_1_106
	arg_1_0.detectionSystem = var_1_106.New(arg_1_0)
	IslandDelegateEffectMgr = var_1
	arg_1_0.effectMgr = var_1.New(arg_1_0)
	IslandCoupleActionPlayer = var_1
	arg_1_0.coupleActionPlayer = var_1.New(arg_1_0)
	IslandCoupleAction4FollowerPlayer = var_1
	arg_1_0.coupleAction4FollowerPlayer = var_1.New(arg_1_0)
	IslandNpcActionPlayer = var_1
	arg_1_0.npcActionPlayer = var_1.New(arg_1_0)
	IslandWeatherSystem = var_1
	arg_1_0.weatherSystem = var_1.New(arg_1_0)
	IslandCoupleNpcWordPlayer = var_1
	arg_1_0.coupleNpcWordPlayer = var_1.New(arg_1_0)
	arg_1_0.pathfinders = {}
	arg_1_0.fishingSynPlayers = {}

	arg_1_0:CreateViews()

	return
end

function var_0_1.CreateViews(arg_2_0)
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

function var_0_1.DoEnter(arg_3_0)
	local var_3_0 = {}

	ipairs = var_1_10002

	for iter_3_0, iter_3_1 in var_1_10002(arg_3_0:GetAllUnits()) do
		table = var_1_10007

		var_1_10007.insert(var_3_0, function(arg_4_0)
			local var_4_0 = iter_3_1

			var_1.Start(var_4_0)

			if iter_3_0 % 3 == 0 then
				arg_4_0()
			else
				onNextTick = var_1

				var_1(arg_4_0)
			end

			return
		end)
	end

	seriesAsync = var_2

	var_2(var_3_0, function()
		arg_3_0.isInit = true

		return
	end)

	return
end

function var_0_1.GetSubView(arg_6_0, arg_6_1)
	ipairs = var_1_10002

	local var_6_0

	if not arg_6_0.views then
		var_6_0 = {}
	end

	for iter_6_0, iter_6_1 in var_1_10002(var_6_0) do
		isa = var_1_10007

		if var_1_10007(iter_6_1, arg_6_1) then
			return iter_6_1
		end
	end

	return nil
end

function var_0_1.CreateEffectView(arg_7_0)
	IslandEffectView = var_1_10001

	return var_1_10001.New(arg_7_0)
end

function var_0_1.CreateOpView(arg_8_0)
	IslandOpView = var_1_10001

	return var_1_10001.New(arg_8_0)
end

function var_0_1.CreateSlotHudView(arg_9_0)
	IslandSlotHudView = var_1_10001

	return var_1_10001.New(arg_9_0)
end

function var_0_1.CreateCancelAnimationOpView(arg_10_0)
	IslandCancelAnimationOpView = var_1_10001

	return var_1_10001.New(arg_10_0)
end

function var_0_1.CreateTopHeadHudView(arg_11_0)
	IslandTopHeadHudView = var_1_10001

	return var_1_10001.New(arg_11_0)
end

function var_0_1.CreateBottomHeadHudeView(arg_12_0)
	IslandBottomHeadHudView = var_1_10001

	return var_1_10001.New(arg_12_0)
end

function var_0_1.CreateAnimationOpView(arg_13_0)
	IslandAniamtionOpView = var_1_10001

	return var_1_10001.New(arg_13_0)
end

function var_0_1.CreateInteractionView(arg_14_0)
	IslandInteractionView = var_1_10001

	return var_1_10001.New(arg_14_0)
end

function var_0_1.CreateDistanceView(arg_15_0)
	IslandDistanceView = var_1_10001

	return var_1_10001.New(arg_15_0)
end

function var_0_1.CreateSeedOpView(arg_16_0)
	IslandSeedOpView = var_1_10001

	return var_1_10001.New(arg_16_0)
end

function var_0_1.IsLoaded(arg_17_0)
	local var_17_0 = arg_17_0:GetAllUnits()

	_ = var_1_10002

	if var_1_10002.all(arg_17_0.views, function(arg_18_0)
		return arg_18_0:IsLoaded()
	end) then
		local var_17_1

		if #var_17_0 > 0 then
			_ = var_17_1
			var_17_1 = var_17_1.all(var_17_0, function(arg_19_0)
				return arg_19_0:IsLoaded()
			end)
		else
			var_17_1 = false
		end
	end

	if false then
		var_17_1 = true
	end

	return var_17_1
end

function var_0_1.IsInit(arg_20_0)
	return arg_20_0.isInit
end

function var_0_1.Update(arg_21_0)
	if not arg_21_0.isInit then
		return
	end

	ipairs = var_1

	for iter_21_0, iter_21_1 in var_1(arg_21_0:GetAllUnits()) do
		iter_21_1:Update()
	end

	ipairs = var_1

	for iter_21_2, iter_21_3 in var_1(arg_21_0.views) do
		iter_21_3:Update()
	end

	ipairs = var_1

	for iter_21_4, iter_21_5 in var_1(arg_21_0.pathfinders) do
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

function var_0_1.LateUpdate(arg_22_0)
	if not arg_22_0.isInit then
		return
	end

	ipairs = var_1

	for iter_22_0, iter_22_1 in var_1(arg_22_0:GetAllUnits()) do
		iter_22_1:LateUpdate()
	end

	ipairs = var_1

	for iter_22_2, iter_22_3 in var_1(arg_22_0.views) do
		iter_22_3:LateUpdate()
	end

	ipairs = var_1

	for iter_22_4, iter_22_5 in var_1(arg_22_0.pathfinders) do
		iter_22_5:LateUpdate()
	end

	return
end

function var_0_1.AddListeners(arg_23_0)
	local var_23_0 = arg_23_0
	local var_23_1 = arg_23_0.AddListener

	ISLAND_EVT = var_1_10004

	var_23_1(var_23_0, var_1_10004.GEN_UNIT, arg_23_0.OnGenUnit)

	local var_23_2 = arg_23_0
	local var_23_3 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_3(var_23_2, var_4.RMOVE_UNIT, arg_23_0.OnRemoveUnit)

	local var_23_4 = arg_23_0
	local var_23_5 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_5(var_23_4, var_4.INTERACTION_UNIT_BEGIN, arg_23_0.OnInterActionBegin)

	local var_23_6 = arg_23_0
	local var_23_7 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_7(var_23_6, var_4.INTERACTION_UNIT_END, arg_23_0.OnInterActionEnd)

	local var_23_8 = arg_23_0
	local var_23_9 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_9(var_23_8, var_4.STOP_MOVE_UNIT, arg_23_0.OnStopUnit)

	local var_23_10 = arg_23_0
	local var_23_11 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_11(var_23_10, var_4.MOVE_UNIT, arg_23_0.OnMoveUnit)

	local var_23_12 = arg_23_0
	local var_23_13 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_13(var_23_12, var_4.INIT_FINISH, arg_23_0.OnSceneInited)

	local var_23_14 = arg_23_0
	local var_23_15 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_15(var_23_14, var_4.MOVE_PLAYER, arg_23_0.OnPlayerMove)

	local var_23_16 = arg_23_0
	local var_23_17 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_17(var_23_16, var_4.STOP_MOVE_PLAYER, arg_23_0.OnPlayerStopMoveHandle)

	local var_23_18 = arg_23_0
	local var_23_19 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_19(var_23_18, var_4.JUMP_PLAYER, arg_23_0.OnPlayerJump)

	local var_23_20 = arg_23_0
	local var_23_21 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_21(var_23_20, var_4.APPROACH_UNIT, arg_23_0.OnShowInterActionPanel)

	local var_23_22 = arg_23_0
	local var_23_23 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_23(var_23_22, var_4.LEAVE_UNIT, arg_23_0.OnHideInterActionPanel)

	local var_23_24 = arg_23_0
	local var_23_25 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_25(var_23_24, var_4.TRACKING, arg_23_0.OnTracking)

	local var_23_26 = arg_23_0
	local var_23_27 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_27(var_23_26, var_4.UNTRACKING, arg_23_0.OnUnTracking)

	local var_23_28 = arg_23_0
	local var_23_29 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_29(var_23_28, var_4.AREACHANGE, arg_23_0.OnPlayerAreaChange)

	local var_23_30 = arg_23_0
	local var_23_31 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_31(var_23_30, var_4.PLAYERRUN, arg_23_0.OnPlayerPlayerRun)

	local var_23_32 = arg_23_0
	local var_23_33 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_33(var_23_32, var_4.SPRINT_PLAYER, arg_23_0.OnPlayerPlayerSprint)

	local var_23_34 = arg_23_0
	local var_23_35 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_35(var_23_34, var_4.STOP_SPRINT_PLAYER, arg_23_0.OnStopPlayerSprint)

	local var_23_36 = arg_23_0
	local var_23_37 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_37(var_23_36, var_4.CHANGE_DRESS, arg_23_0.OnChangeDress)

	local var_23_38 = arg_23_0
	local var_23_39 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_39(var_23_38, var_4.CHANGE_CHARACTER_DRESS, arg_23_0.OnCharacterChangeDress)

	local var_23_40 = arg_23_0
	local var_23_41 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_41(var_23_40, var_4.MORPH_FORM_CHANGE, arg_23_0.OnMorphFormChange)

	local var_23_42 = arg_23_0
	local var_23_43 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_43(var_23_42, var_4.RESET_UNIT_POS, arg_23_0.OnResetUnitPos)

	local var_23_44 = arg_23_0
	local var_23_45 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_45(var_23_44, var_4.RESET_UNIT_ROT, arg_23_0.OnResetUnitRotation)

	local var_23_46 = arg_23_0
	local var_23_47 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_47(var_23_46, var_4.ANY_PAGE_OPENED, arg_23_0.OnAnyPageOpen)

	local var_23_48 = arg_23_0
	local var_23_49 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_49(var_23_48, var_4.ALL_PAGE_CLOSED, arg_23_0.OnAllPageClose)

	local var_23_50 = arg_23_0
	local var_23_51 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_51(var_23_50, var_4.Change_TakePhoto_Model, arg_23_0.OnChangeTakePhotoModel)

	local var_23_52 = arg_23_0
	local var_23_53 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_53(var_23_52, var_4.Change_Photo_Height, arg_23_0.OnChange_Photo_Height)

	local var_23_54 = arg_23_0
	local var_23_55 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_55(var_23_54, var_4.SetOpMoveBtnActve, arg_23_0.OnSetOpMoveBtnActve)

	local var_23_56 = arg_23_0
	local var_23_57 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_57(var_23_56, var_4.PLAY_BUBBLE, arg_23_0.OnPlayChatBubble)

	local var_23_58 = arg_23_0
	local var_23_59 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_59(var_23_58, var_4.RAW_PLAY_BUBBLE, arg_23_0.OnRawPlayChatBubble)

	local var_23_60 = arg_23_0
	local var_23_61 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_61(var_23_60, var_4.RAW_STOP_BUBBLE, arg_23_0.OnRawStopChatBubble)

	local var_23_62 = arg_23_0
	local var_23_63 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_63(var_23_62, var_4.START_STORY, arg_23_0.OnStartStory)

	local var_23_64 = arg_23_0
	local var_23_65 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_65(var_23_64, var_4.END_STORY, arg_23_0.OnEndStory)

	local var_23_66 = arg_23_0
	local var_23_67 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_67(var_23_66, var_4.START_DEGATION, arg_23_0.OnStartDelegation)

	local var_23_68 = arg_23_0
	local var_23_69 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_69(var_23_68, var_4.END_DEGATION, arg_23_0.OnEndDelegation)

	local var_23_70 = arg_23_0
	local var_23_71 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_71(var_23_70, var_4.GEN_SYSTEM, arg_23_0.OnGenSystem)

	local var_23_72 = arg_23_0
	local var_23_73 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_73(var_23_72, var_4.WORLD_OBJECT_START_INTERACTION, arg_23_0.OnWorldObjectStartInteraction)

	local var_23_74 = arg_23_0
	local var_23_75 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_75(var_23_74, var_4.WORLD_OBJECT_END_INTERACTION, arg_23_0.OnWorldObjectEndInteraction)

	local var_23_76 = arg_23_0
	local var_23_77 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_77(var_23_76, var_4.WORLD_OBJECT_INIT_STATUS, arg_23_0.OnWorldObjectInitStatus)

	local var_23_78 = arg_23_0
	local var_23_79 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_79(var_23_78, var_4.INIT_INTERACTION_OP_VIEW, arg_23_0.InitInteractionOpView)

	local var_23_80 = arg_23_0
	local var_23_81 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_81(var_23_80, var_4.REFRESH_INTERACTION, arg_23_0.OnRefreshInteractionBtn)

	local var_23_82 = arg_23_0
	local var_23_83 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_83(var_23_82, var_4.SHOW_UNIT_HUD_OP, arg_23_0.OnShowUnitHudAndOpBtn)

	local var_23_84 = arg_23_0
	local var_23_85 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_85(var_23_84, var_4.HIDE_UNIT_HUD_OP, arg_23_0.OnHideUnitHudAndOpBtn)

	local var_23_86 = arg_23_0
	local var_23_87 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_87(var_23_86, var_4.DETECTOR_CHANGED, arg_23_0.OnDetectorChanged)

	local var_23_88 = arg_23_0
	local var_23_89 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_89(var_23_88, var_4.SELECTED_DETECTOR, arg_23_0.OnDetectorSelected)

	local var_23_90 = arg_23_0
	local var_23_91 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_91(var_23_90, var_4.FISHPOINT_DETECTOR, arg_23_0.OnFishPointSelected)

	local var_23_92 = arg_23_0
	local var_23_93 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_93(var_23_92, var_4.NPC_DETECTED, arg_23_0.OnNpcDetectorSelected)

	local var_23_94 = arg_23_0
	local var_23_95 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_95(var_23_94, var_4.NO_NPC_DETECTED, arg_23_0.OnNpcDetectorUnSelected)

	local var_23_96 = arg_23_0
	local var_23_97 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_97(var_23_96, var_4.SET_PLAYER_WORK, arg_23_0.OnPlayerWork)

	local var_23_98 = arg_23_0
	local var_23_99 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_99(var_23_98, var_4.DEVIEE_STATE_CHANGE, arg_23_0.OnPlayerDeviceStateChange)

	local var_23_100 = arg_23_0
	local var_23_101 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_101(var_23_100, var_4.UPDATE_HUD, arg_23_0.OnUpdateHud)

	local var_23_102 = arg_23_0
	local var_23_103 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_103(var_23_102, var_4.PLAY_EFFECT, arg_23_0.OnPlayEffect)

	local var_23_104 = arg_23_0
	local var_23_105 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_105(var_23_104, var_4.UPDATE_UNIT_HAND_COLLECT, arg_23_0.OnUpdateHandCollectUnit)

	local var_23_106 = arg_23_0
	local var_23_107 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_107(var_23_106, var_4.START_DELEGATE_SLOT_PERFORM, arg_23_0.OnDelegateSlotStartPerform)

	local var_23_108 = arg_23_0
	local var_23_109 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_109(var_23_108, var_4.RECYCLE_ALL_SLOTDELEEFFECT, arg_23_0.OnRecycleAllSlotEffct)

	local var_23_110 = arg_23_0
	local var_23_111 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_111(var_23_110, var_4.SELECTDELEEFFECT_SHOW, arg_23_0.OnSelectSlotEffectShow)

	local var_23_112 = arg_23_0
	local var_23_113 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_113(var_23_112, var_4.LOAD_DELEGATE_PREVIEW_ROLE, arg_23_0.OnLoadDelegatePreviewRole)

	local var_23_114 = arg_23_0
	local var_23_115 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_115(var_23_114, var_4.UN_LOAD_DELEGATE_PREVIEW_ROLE, arg_23_0.OnUnLoadDelegatePreviewRole)

	local var_23_116 = arg_23_0
	local var_23_117 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_117(var_23_116, var_4.Take_Plant_Attact, arg_23_0.OnTakePlantAttack)

	local var_23_118 = arg_23_0
	local var_23_119 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_119(var_23_118, var_4.START_MANAGE, arg_23_0.OnStartManage)

	local var_23_120 = arg_23_0
	local var_23_121 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_121(var_23_120, var_4.END_MANAGE, arg_23_0.OnEndManage)

	local var_23_122 = arg_23_0
	local var_23_123 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_123(var_23_122, var_4.SHOW_HUD, arg_23_0.OnShowHud)

	local var_23_124 = arg_23_0
	local var_23_125 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_125(var_23_124, var_4.HIDE_HUD, arg_23_0.OnHideHud)

	local var_23_126 = arg_23_0
	local var_23_127 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_127(var_23_126, var_4.REFRESH_HUD, arg_23_0.OnRefreshHud)

	local var_23_128 = arg_23_0
	local var_23_129 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_129(var_23_128, var_4.START_GUIDE, arg_23_0.OnStartGuide)

	local var_23_130 = arg_23_0
	local var_23_131 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_131(var_23_130, var_4.END_GUIDE, arg_23_0.OnEndGuide)

	local var_23_132 = arg_23_0
	local var_23_133 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_133(var_23_132, var_4.START_PERFORMANCE, arg_23_0.OnStartPerformance)

	local var_23_134 = arg_23_0
	local var_23_135 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_135(var_23_134, var_4.END_PERFORMANCE, arg_23_0.OnEndPerformance)

	local var_23_136 = arg_23_0
	local var_23_137 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_137(var_23_136, var_4.DISABLE_INPUT, arg_23_0.DisableInput)

	local var_23_138 = arg_23_0
	local var_23_139 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_139(var_23_138, var_4.ENABLE_INPUT, arg_23_0.EnableInput)

	local var_23_140 = arg_23_0
	local var_23_141 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_141(var_23_140, var_4.GEN_PATH_FINDER, arg_23_0.OnGenPathFinder)

	local var_23_142 = arg_23_0
	local var_23_143 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_143(var_23_142, var_4.REMOVE_PATH_FINDER, arg_23_0.OnRemovePathFinder)

	local var_23_144 = arg_23_0
	local var_23_145 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_145(var_23_144, var_4.ACTIVE_OR_DISACTIVE_UNIT, arg_23_0.OnActiveOrDisactiveUnit)

	local var_23_146 = arg_23_0
	local var_23_147 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_147(var_23_146, var_4.OPEN_ANIMATION_OP, arg_23_0.OnOpenAniamtionOpPage)

	local var_23_148 = arg_23_0
	local var_23_149 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_149(var_23_148, var_4.CLOSE_ANIMATION_OP, arg_23_0.OnCloseAniamtionOpPage)

	local var_23_150 = arg_23_0
	local var_23_151 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_151(var_23_150, var_4.MOVE_PLAYER_BEFORE, arg_23_0.OnMovePlayerBefore)

	local var_23_152 = arg_23_0
	local var_23_153 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_153(var_23_152, var_4.REFRESH_TASK_HUD_INFO, arg_23_0.OnRefreshTaskInfoHud)

	local var_23_154 = arg_23_0
	local var_23_155 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_155(var_23_154, var_4.RESPON_ANIMATION_OP, arg_23_0.OnResponAniamtionOp)

	local var_23_156 = arg_23_0
	local var_23_157 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_157(var_23_156, var_4.CHANGE_VISTER_DRESS, arg_23_0.OnChangeVisterDress)

	local var_23_158 = arg_23_0
	local var_23_159 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_159(var_23_158, var_4.SET_VISITOR_SYNC_DATA, arg_23_0.OnSetVisitorSyncData)

	local var_23_160 = arg_23_0
	local var_23_161 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_161(var_23_160, var_4.SHOW_NPC_ANIMATION_BUBBLE, arg_23_0.OnShowNpcAniamtionBubble)

	local var_23_162 = arg_23_0
	local var_23_163 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_163(var_23_162, var_4.HIDE_NPC_ANIMATION_BUBBLE, arg_23_0.OnHideNpcAniamtionBubble)

	local var_23_164 = arg_23_0
	local var_23_165 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_165(var_23_164, var_4.PLAY_SIGNLE_ANIMATION_END, arg_23_0.OnPlaySingleAnimationEnd)

	local var_23_166 = arg_23_0
	local var_23_167 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_167(var_23_166, var_4.UPDATE_CUSTOM_OP_POSITON, arg_23_0.OnUpdateCustomOpPositon)

	local var_23_168 = arg_23_0
	local var_23_169 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_169(var_23_168, var_4.CHAT_MSG_UPDATE, arg_23_0.OnChatMsgUpdate)

	local var_23_170 = arg_23_0
	local var_23_171 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_171(var_23_170, var_4.CHAT_ROOM_UPDATE, arg_23_0.OnChatRoomChange)

	local var_23_172 = arg_23_0
	local var_23_173 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_173(var_23_172, var_4.SHOW_CHAT_MSG, arg_23_0.OnShowChatMsg)

	local var_23_174 = arg_23_0
	local var_23_175 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_175(var_23_174, var_4.RESET_FOLLOW_RANDOMIZER, arg_23_0.OnResetFollowRandomizer)

	local var_23_176 = arg_23_0
	local var_23_177 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_177(var_23_176, var_4.ADD_FOLLOWER, arg_23_0.OnFollowerAdd)

	local var_23_178 = arg_23_0
	local var_23_179 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_179(var_23_178, var_4.WILL_DEL_FOLLOWER, arg_23_0.OnFollowerWillDelStep1)

	local var_23_180 = arg_23_0
	local var_23_181 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_181(var_23_180, var_4.DO_DEL_FOLLOWER, arg_23_0.OnFollowerWillDelStep2)

	local var_23_182 = arg_23_0
	local var_23_183 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_183(var_23_182, var_4.DEL_FOLLOWER, arg_23_0.OnFollowerDel)

	local var_23_184 = arg_23_0
	local var_23_185 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_185(var_23_184, var_4.COUPLE_ACTION_WITH_FOLLOWER, arg_23_0.OnCoupleActionWithFollower)

	local var_23_186 = arg_23_0
	local var_23_187 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_187(var_23_186, var_4.LOCK_PLAYER_INPUT, arg_23_0.OnLockPlayerInput)

	local var_23_188 = arg_23_0
	local var_23_189 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_189(var_23_188, var_4.START_COUPLE_ACTION, arg_23_0.OnStartCoupleAction)

	local var_23_190 = arg_23_0
	local var_23_191 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_191(var_23_190, var_4.END_COUPLE_ACTION, arg_23_0.OnEndCoupleAction)

	local var_23_192 = arg_23_0
	local var_23_193 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_193(var_23_192, var_4.REFRESH_WEATHER_SYSTEM, arg_23_0.OnRefreshWeatherSystem)

	local var_23_194 = arg_23_0
	local var_23_195 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_195(var_23_194, var_4.SYSTEM_UNLOCK, arg_23_0.OnSystemUnlock)

	local var_23_196 = arg_23_0
	local var_23_197 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_197(var_23_196, var_4.START_DO_COUPLE_ACTION, arg_23_0.OnStartDoCoupleAction)

	local var_23_198 = arg_23_0
	local var_23_199 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_199(var_23_198, var_4.END_DO_COUPLE_ACTION, arg_23_0.OnEndDoCoupleAction)

	local var_23_200 = arg_23_0
	local var_23_201 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_201(var_23_200, var_4.CANCEL_COUPLE_ACTION, arg_23_0.OnCancelCoupleAction)

	local var_23_202 = arg_23_0
	local var_23_203 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_203(var_23_202, var_4.BAIT_UPDATE, arg_23_0.OnBaitUpdate)

	local var_23_204 = arg_23_0
	local var_23_205 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_205(var_23_204, var_4.START_FISHING, arg_23_0.OnStartFishing)

	local var_23_206 = arg_23_0
	local var_23_207 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_207(var_23_206, var_4.FISHING_STATE_CHANGE, arg_23_0.OnFishingStateChange)

	local var_23_208 = arg_23_0
	local var_23_209 = arg_23_0.AddListener

	ISLAND_EVT = var_4

	var_23_209(var_23_208, var_4.ALL_DAILY_OR_WEEKLY_FINISH, arg_23_0.OnAllDailyOrWeeklyFinish)

	return
end

function var_0_1.RemoveListeners(arg_24_0)
	local var_24_0 = arg_24_0
	local var_24_1 = arg_24_0.RemoveListener

	ISLAND_EVT = var_1_10004

	var_24_1(var_24_0, var_1_10004.GEN_UNIT, arg_24_0.OnGenUnit)

	local var_24_2 = arg_24_0
	local var_24_3 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_3(var_24_2, var_4.RMOVE_UNIT, arg_24_0.OnRemoveUnit)

	local var_24_4 = arg_24_0
	local var_24_5 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_5(var_24_4, var_4.INTERACTION_UNIT_BEGIN, arg_24_0.OnInterActionBegin)

	local var_24_6 = arg_24_0
	local var_24_7 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_7(var_24_6, var_4.INTERACTION_UNIT_END, arg_24_0.OnInterActionEnd)

	local var_24_8 = arg_24_0
	local var_24_9 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_9(var_24_8, var_4.STOP_MOVE_UNIT, arg_24_0.OnStopUnit)

	local var_24_10 = arg_24_0
	local var_24_11 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_11(var_24_10, var_4.MOVE_UNIT, arg_24_0.OnMoveUnit)

	local var_24_12 = arg_24_0
	local var_24_13 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_13(var_24_12, var_4.INIT_FINISH, arg_24_0.OnSceneInited)

	local var_24_14 = arg_24_0
	local var_24_15 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_15(var_24_14, var_4.MOVE_PLAYER, arg_24_0.OnPlayerMove)

	local var_24_16 = arg_24_0
	local var_24_17 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_17(var_24_16, var_4.STOP_MOVE_PLAYER, arg_24_0.OnPlayerStopMoveHandle)

	local var_24_18 = arg_24_0
	local var_24_19 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_19(var_24_18, var_4.JUMP_PLAYER, arg_24_0.OnPlayerJump)

	local var_24_20 = arg_24_0
	local var_24_21 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_21(var_24_20, var_4.APPROACH_UNIT, arg_24_0.OnShowInterActionPanel)

	local var_24_22 = arg_24_0
	local var_24_23 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_23(var_24_22, var_4.LEAVE_UNIT, arg_24_0.OnHideInterActionPanel)

	local var_24_24 = arg_24_0
	local var_24_25 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_25(var_24_24, var_4.TRACKING, arg_24_0.OnTracking)

	local var_24_26 = arg_24_0
	local var_24_27 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_27(var_24_26, var_4.UNTRACKING, arg_24_0.OnUnTracking)

	local var_24_28 = arg_24_0
	local var_24_29 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_29(var_24_28, var_4.AREACHANGE, arg_24_0.OnPlayerAreaChange)

	local var_24_30 = arg_24_0
	local var_24_31 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_31(var_24_30, var_4.PLAYERRUN, arg_24_0.OnPlayerPlayerRun)

	local var_24_32 = arg_24_0
	local var_24_33 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_33(var_24_32, var_4.SPRINT_PLAYER, arg_24_0.OnPlayerPlayerSprint)

	local var_24_34 = arg_24_0
	local var_24_35 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_35(var_24_34, var_4.STOP_SPRINT_PLAYER, arg_24_0.OnStopPlayerSprint)

	local var_24_36 = arg_24_0
	local var_24_37 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_37(var_24_36, var_4.CHANGE_DRESS, arg_24_0.OnChangeDress)

	local var_24_38 = arg_24_0
	local var_24_39 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_39(var_24_38, var_4.CHANGE_CHARACTER_DRESS, arg_24_0.OnCharacterChangeDress)

	local var_24_40 = arg_24_0
	local var_24_41 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_41(var_24_40, var_4.MORPH_FORM_CHANGE, arg_24_0.OnMorphFormChange)

	local var_24_42 = arg_24_0
	local var_24_43 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_43(var_24_42, var_4.RESET_UNIT_POS, arg_24_0.OnResetUnitPos)

	local var_24_44 = arg_24_0
	local var_24_45 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_45(var_24_44, var_4.RESET_UNIT_ROT, arg_24_0.OnResetUnitRotation)

	local var_24_46 = arg_24_0
	local var_24_47 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_47(var_24_46, var_4.ANY_PAGE_OPENED, arg_24_0.OnAnyPageOpen)

	local var_24_48 = arg_24_0
	local var_24_49 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_49(var_24_48, var_4.Change_TakePhoto_Model, arg_24_0.OnChangeTakePhotoModel)

	local var_24_50 = arg_24_0
	local var_24_51 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_51(var_24_50, var_4.Change_Photo_Height, arg_24_0.OnChange_Photo_Height)

	local var_24_52 = arg_24_0
	local var_24_53 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_53(var_24_52, var_4.SetOpMoveBtnActve, arg_24_0.OnSetOpMoveBtnActve)

	local var_24_54 = arg_24_0
	local var_24_55 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_55(var_24_54, var_4.ALL_PAGE_CLOSED, arg_24_0.OnAllPageClose)

	local var_24_56 = arg_24_0
	local var_24_57 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_57(var_24_56, var_4.PLAY_BUBBLE, arg_24_0.OnPlayChatBubble)

	local var_24_58 = arg_24_0
	local var_24_59 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_59(var_24_58, var_4.RAW_PLAY_BUBBLE, arg_24_0.OnRawPlayChatBubble)

	local var_24_60 = arg_24_0
	local var_24_61 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_61(var_24_60, var_4.RAW_STOP_BUBBLE, arg_24_0.OnRawStopChatBubble)

	local var_24_62 = arg_24_0
	local var_24_63 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_63(var_24_62, var_4.START_STORY, arg_24_0.OnStartStory)

	local var_24_64 = arg_24_0
	local var_24_65 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_65(var_24_64, var_4.END_STORY, arg_24_0.OnEndStory)

	local var_24_66 = arg_24_0
	local var_24_67 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_67(var_24_66, var_4.START_DEGATION, arg_24_0.OnStartDelegation)

	local var_24_68 = arg_24_0
	local var_24_69 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_69(var_24_68, var_4.END_DEGATION, arg_24_0.OnEndDelegation)

	local var_24_70 = arg_24_0
	local var_24_71 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_71(var_24_70, var_4.GEN_SYSTEM, arg_24_0.OnGenSystem)

	local var_24_72 = arg_24_0
	local var_24_73 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_73(var_24_72, var_4.WORLD_OBJECT_START_INTERACTION, arg_24_0.OnWorldObjectStartInteraction)

	local var_24_74 = arg_24_0
	local var_24_75 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_75(var_24_74, var_4.WORLD_OBJECT_END_INTERACTION, arg_24_0.OnWorldObjectEndInteraction)

	local var_24_76 = arg_24_0
	local var_24_77 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_77(var_24_76, var_4.WORLD_OBJECT_INIT_STATUS, arg_24_0.OnWorldObjectInitStatus)

	local var_24_78 = arg_24_0
	local var_24_79 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_79(var_24_78, var_4.INIT_INTERACTION_OP_VIEW, arg_24_0.InitInteractionOpView)

	local var_24_80 = arg_24_0
	local var_24_81 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_81(var_24_80, var_4.REFRESH_INTERACTION, arg_24_0.OnRefreshInteractionBtn)

	local var_24_82 = arg_24_0
	local var_24_83 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_83(var_24_82, var_4.SHOW_UNIT_HUD_OP, arg_24_0.OnShowUnitHudAndOpBtn)

	local var_24_84 = arg_24_0
	local var_24_85 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_85(var_24_84, var_4.HIDE_UNIT_HUD_OP, arg_24_0.OnHideUnitHudAndOpBtn)

	local var_24_86 = arg_24_0
	local var_24_87 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_87(var_24_86, var_4.DETECTOR_CHANGED, arg_24_0.OnDetectorChanged)

	local var_24_88 = arg_24_0
	local var_24_89 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_89(var_24_88, var_4.SELECTED_DETECTOR, arg_24_0.OnDetectorSelected)

	local var_24_90 = arg_24_0
	local var_24_91 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_91(var_24_90, var_4.FISHPOINT_DETECTOR, arg_24_0.OnFishPointSelected)

	local var_24_92 = arg_24_0
	local var_24_93 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_93(var_24_92, var_4.NPC_DETECTED, arg_24_0.OnNpcDetectorSelected)

	local var_24_94 = arg_24_0
	local var_24_95 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_95(var_24_94, var_4.NO_NPC_DETECTED, arg_24_0.OnNpcDetectorUnSelected)

	local var_24_96 = arg_24_0
	local var_24_97 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_97(var_24_96, var_4.SET_PLAYER_WORK, arg_24_0.OnPlayerWork)

	local var_24_98 = arg_24_0
	local var_24_99 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_99(var_24_98, var_4.DEVIEE_STATE_CHANGE, arg_24_0.OnPlayerDeviceStateChange)

	local var_24_100 = arg_24_0
	local var_24_101 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_101(var_24_100, var_4.UPDATE_HUD, arg_24_0.OnUpdateHud)

	local var_24_102 = arg_24_0
	local var_24_103 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_103(var_24_102, var_4.PLAY_EFFECT, arg_24_0.OnPlayEffect)

	local var_24_104 = arg_24_0
	local var_24_105 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_105(var_24_104, var_4.UPDATE_UNIT_HAND_COLLECT, arg_24_0.OnUpdateHandCollectUnit)

	local var_24_106 = arg_24_0
	local var_24_107 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_107(var_24_106, var_4.RECYCLE_ALL_SLOTDELEEFFECT, arg_24_0.OnRecycleAllSlotEffct)

	local var_24_108 = arg_24_0
	local var_24_109 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_109(var_24_108, var_4.SELECTDELEEFFECT_SHOW, arg_24_0.OnSelectSlotEffectShow)

	local var_24_110 = arg_24_0
	local var_24_111 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_111(var_24_110, var_4.LOAD_DELEGATE_PREVIEW_ROLE, arg_24_0.OnLoadDelegatePreviewRole)

	local var_24_112 = arg_24_0
	local var_24_113 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_113(var_24_112, var_4.UN_LOAD_DELEGATE_PREVIEW_ROLE, arg_24_0.OnUnLoadDelegatePreviewRole)

	local var_24_114 = arg_24_0
	local var_24_115 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_115(var_24_114, var_4.Take_Plant_Attact, arg_24_0.OnTakePlantAttack)

	local var_24_116 = arg_24_0
	local var_24_117 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_117(var_24_116, var_4.START_MANAGE, arg_24_0.OnStartManage)

	local var_24_118 = arg_24_0
	local var_24_119 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_119(var_24_118, var_4.END_MANAGE, arg_24_0.OnEndManage)

	local var_24_120 = arg_24_0
	local var_24_121 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_121(var_24_120, var_4.SHOW_HUD, arg_24_0.OnShowHud)

	local var_24_122 = arg_24_0
	local var_24_123 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_123(var_24_122, var_4.HIDE_HUD, arg_24_0.OnHideHud)

	local var_24_124 = arg_24_0
	local var_24_125 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_125(var_24_124, var_4.REFRESH_HUD, arg_24_0.OnRefreshHud)

	local var_24_126 = arg_24_0
	local var_24_127 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_127(var_24_126, var_4.START_GUIDE, arg_24_0.OnStartGuide)

	local var_24_128 = arg_24_0
	local var_24_129 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_129(var_24_128, var_4.END_GUIDE, arg_24_0.OnEndGuide)

	local var_24_130 = arg_24_0
	local var_24_131 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_131(var_24_130, var_4.START_PERFORMANCE, arg_24_0.OnStartPerformance)

	local var_24_132 = arg_24_0
	local var_24_133 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_133(var_24_132, var_4.END_PERFORMANCE, arg_24_0.OnEndPerformance)

	local var_24_134 = arg_24_0
	local var_24_135 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_135(var_24_134, var_4.DISABLE_INPUT, arg_24_0.DisableInput)

	local var_24_136 = arg_24_0
	local var_24_137 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_137(var_24_136, var_4.ENABLE_INPUT, arg_24_0.EnableInput)

	local var_24_138 = arg_24_0
	local var_24_139 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_139(var_24_138, var_4.GEN_PATH_FINDER, arg_24_0.OnGenPathFinder)

	local var_24_140 = arg_24_0
	local var_24_141 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_141(var_24_140, var_4.REMOVE_PATH_FINDER, arg_24_0.OnRemovePathFinder)

	local var_24_142 = arg_24_0
	local var_24_143 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_143(var_24_142, var_4.ACTIVE_OR_DISACTIVE_UNIT, arg_24_0.OnActiveOrDisactiveUnit)

	local var_24_144 = arg_24_0
	local var_24_145 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_145(var_24_144, var_4.OPEN_ANIMATION_OP, arg_24_0.OnOpenAniamtionOpPage)

	local var_24_146 = arg_24_0
	local var_24_147 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_147(var_24_146, var_4.CLOSE_ANIMATION_OP, arg_24_0.OnCloseAniamtionOpPage)

	local var_24_148 = arg_24_0
	local var_24_149 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_149(var_24_148, var_4.MOVE_PLAYER_BEFORE, arg_24_0.OnMovePlayerBefore)

	local var_24_150 = arg_24_0
	local var_24_151 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_151(var_24_150, var_4.REFRESH_TASK_HUD_INFO, arg_24_0.OnRefreshTaskInfoHud)

	local var_24_152 = arg_24_0
	local var_24_153 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_153(var_24_152, var_4.RESPON_ANIMATION_OP, arg_24_0.OnResponAniamtionOp)

	local var_24_154 = arg_24_0
	local var_24_155 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_155(var_24_154, var_4.CHANGE_VISTER_DRESS, arg_24_0.OnChangeVisterDress)

	local var_24_156 = arg_24_0
	local var_24_157 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_157(var_24_156, var_4.SET_VISITOR_SYNC_DATA, arg_24_0.OnSetVisitorSyncData)

	local var_24_158 = arg_24_0
	local var_24_159 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_159(var_24_158, var_4.SHOW_NPC_ANIMATION_BUBBLE, arg_24_0.OnShowNpcAniamtionBubble)

	local var_24_160 = arg_24_0
	local var_24_161 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_161(var_24_160, var_4.HIDE_NPC_ANIMATION_BUBBLE, arg_24_0.OnHideNpcAniamtionBubble)

	local var_24_162 = arg_24_0
	local var_24_163 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_163(var_24_162, var_4.PLAY_SIGNLE_ANIMATION_END, arg_24_0.OnPlaySingleAnimationEnd)

	local var_24_164 = arg_24_0
	local var_24_165 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_165(var_24_164, var_4.UPDATE_CUSTOM_OP_POSITON, arg_24_0.OnUpdateCustomOpPositon)

	local var_24_166 = arg_24_0
	local var_24_167 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_167(var_24_166, var_4.CHAT_MSG_UPDATE, arg_24_0.OnChatMsgUpdate)

	local var_24_168 = arg_24_0
	local var_24_169 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_169(var_24_168, var_4.CHAT_ROOM_UPDATE, arg_24_0.OnChatRoomChange)

	local var_24_170 = arg_24_0
	local var_24_171 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_171(var_24_170, var_4.SHOW_CHAT_MSG, arg_24_0.OnShowChatMsg)

	local var_24_172 = arg_24_0
	local var_24_173 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_173(var_24_172, var_4.RESET_FOLLOW_RANDOMIZER, arg_24_0.OnResetFollowRandomizer)

	local var_24_174 = arg_24_0
	local var_24_175 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_175(var_24_174, var_4.ADD_FOLLOWER, arg_24_0.OnFollowerAdd)

	local var_24_176 = arg_24_0
	local var_24_177 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_177(var_24_176, var_4.WILL_DEL_FOLLOWER, arg_24_0.OnFollowerWillDelStep1)

	local var_24_178 = arg_24_0
	local var_24_179 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_179(var_24_178, var_4.DO_DEL_FOLLOWER, arg_24_0.OnFollowerWillDelStep2)

	local var_24_180 = arg_24_0
	local var_24_181 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_181(var_24_180, var_4.DEL_FOLLOWER, arg_24_0.OnFollowerDel)

	local var_24_182 = arg_24_0
	local var_24_183 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_183(var_24_182, var_4.COUPLE_ACTION_WITH_FOLLOWER, arg_24_0.OnCoupleActionWithFollower)

	local var_24_184 = arg_24_0
	local var_24_185 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_185(var_24_184, var_4.LOCK_PLAYER_INPUT, arg_24_0.OnLockPlayerInput)

	local var_24_186 = arg_24_0
	local var_24_187 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_187(var_24_186, var_4.START_COUPLE_ACTION, arg_24_0.OnStartCoupleAction)

	local var_24_188 = arg_24_0
	local var_24_189 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_189(var_24_188, var_4.END_COUPLE_ACTION, arg_24_0.OnEndCoupleAction)

	local var_24_190 = arg_24_0
	local var_24_191 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_191(var_24_190, var_4.REFRESH_WEATHER_SYSTEM, arg_24_0.OnRefreshWeatherSystem)

	local var_24_192 = arg_24_0
	local var_24_193 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_193(var_24_192, var_4.SYSTEM_UNLOCK, arg_24_0.OnSystemUnlock)

	local var_24_194 = arg_24_0
	local var_24_195 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_195(var_24_194, var_4.START_DO_COUPLE_ACTION, arg_24_0.OnStartDoCoupleAction)

	local var_24_196 = arg_24_0
	local var_24_197 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_197(var_24_196, var_4.END_DO_COUPLE_ACTION, arg_24_0.OnEndDoCoupleAction)

	local var_24_198 = arg_24_0
	local var_24_199 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_199(var_24_198, var_4.CANCEL_COUPLE_ACTION, arg_24_0.OnCancelCoupleAction)

	local var_24_200 = arg_24_0
	local var_24_201 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_201(var_24_200, var_4.BAIT_UPDATE, arg_24_0.OnBaitUpdate)

	local var_24_202 = arg_24_0
	local var_24_203 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_203(var_24_202, var_4.START_FISHING, arg_24_0.OnStartFishing)

	local var_24_204 = arg_24_0
	local var_24_205 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_205(var_24_204, var_4.FISHING_STATE_CHANGE, arg_24_0.OnFishingStateChange)

	local var_24_206 = arg_24_0
	local var_24_207 = arg_24_0.RemoveListener

	ISLAND_EVT = var_4

	var_24_207(var_24_206, var_4.ALL_DAILY_OR_WEEKLY_FINISH, arg_24_0.OnAllDailyOrWeeklyFinish)

	return
end

function var_0_1.OnBaitUpdate(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0
	local var_25_1 = arg_25_0.GetSubView

	IslandOpView = var_1_10005

	local var_25_2 = var_25_1(var_25_0, var_1_10005)

	var_2.UpdateLureBtn(var_25_2)

	return
end

function var_0_1.OnFishPointSelected(arg_26_0, arg_26_1)
	if not arg_26_1.node then
		return
	end

	if not var_2:GetBlackboardVariable("FishPoint") or var_3 == "" then
		arg_26_0:UnSelectedFishPoint()
	else
		IslandCalcUtil = var_1_10004

		local var_26_0, var_26_1 = var_1_10004.GetTypeAndIdByUniqueId(var_3)

		if arg_26_0:GetUnitModuleWithType(var_26_0, var_26_1) then
			arg_26_0:SelectedFishPoint(var_6)
		end
	end

	return
end

function var_0_1.OnAllDailyOrWeeklyFinish(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0
	local var_27_1 = arg_27_0.GetUnitListByKey

	IslandConst = var_1_10005

	local var_27_2 = var_27_1(var_27_0, var_1_10005.UNIT_LIST_FOLLOW)
	local var_27_3 = {}

	ipairs = var_27_0

	for iter_27_0, iter_27_1 in var_27_0(var_27_2) do
		if not iter_27_1:IsExitState() then
			table = var_9

			var_9.insert(var_27_3, iter_27_1)
		end
	end

	if #var_27_3 <= 0 then
		return
	end

	ipairs = var_4

	for iter_27_2, iter_27_3 in var_4(var_27_3) do
		iter_27_3:StopMove()
		iter_27_3:PlayAnimation(arg_27_1)
	end

	return
end

function var_0_1.OnSystemUnlock(arg_28_0, arg_28_1)
	IslandAblityAgency = var_1_10002

	if arg_28_1 == var_1_10002.ANIMATION_OP_ID then
		local var_28_0 = arg_28_0
		local var_28_1 = arg_28_0.GetSubView

		IslandOpView = var_1_10005

		local var_28_2 = var_28_1(var_28_0, var_1_10005)

		var_2.UpdateAnimationOpBtn(var_28_2)
	end

	return
end

function var_0_1.SelectedFishPoint(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0:GetSelfIsland()
	local var_29_1 = var_2.GetAblityAgency(var_29_0)

	if var_2.IsUnlockFishing(var_29_1) then
		local var_29_2 = arg_29_1:GetUnitType()

		IslandConst = var_1_10003

		if var_29_2 == var_1_10003.UNIT_LIST_FISH_POINT then
			local var_29_3 = arg_29_0.player

			if not var_2.StandOnWorldObject(var_29_3) then
				local var_29_4 = arg_29_0.player

				if not var_2.OnGrouded(var_29_4) then
					return
				end

				arg_29_0:UnSelectedFishPoint()

				arg_29_0.selectedFishPointId = arg_29_1.id

				local var_29_5 = arg_29_0
				local var_29_6 = arg_29_0.GetSubView

				IslandOpView = var_1_10005

				local var_29_7 = var_29_6(var_29_5, var_1_10005)
				local var_29_8 = var_2.UpdateOperationButton

				IslandOpView = var_1_10005

				var_29_8(var_29_7, var_1_10005.OperationType.Fishing, arg_29_1.id)

				return
			end
		end
	end
end

function var_0_1.UnSelectedFishPoint(arg_30_0)
	if arg_30_0.selectedFishPointId then
		local var_30_0 = arg_30_0.selectedFishPointId

		arg_30_0.selectedFishPointId = nil

		local var_30_1 = arg_30_0
		local var_30_2 = arg_30_0.GetSubView

		IslandOpView = var_1_10005

		local var_30_3 = var_30_2(var_30_1, var_1_10005)
		local var_30_4 = var_2.UpdateOperationButton

		IslandOpView = var_1_10005

		var_30_4(var_30_3, var_1_10005.OperationType.None, var_30_0)
	end

	return
end

function var_0_1.OnStartFishing(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_1.unitId

	if not arg_31_0:GetPlayerUnitModule(var_31_0) then
		return
	end

	isa = var_1_10004

	local var_31_1 = var_3

	IslandVisitorUnit = var_1_10007

	if not var_1_10004(var_31_1, var_1_10007) then
		return
	end

	var_3:Sleep()

	local var_31_2 = arg_31_1.fishPointId
	local var_31_3 = arg_31_1.rodId
	local var_31_4 = arg_31_1.fishId

	pg = var_1_10007

	local var_31_5 = var_1_10007.island_fish_rod[var_31_3].attachment_id

	IslandVistorFishingPlayer = var_1_10008

	local var_31_6 = var_1_10008.New(arg_31_0, var_3, var_31_2, var_31_5, var_31_4)

	var_8.Play(var_31_6)

	arg_31_0.fishingSynPlayers[var_31_0] = var_8

	return
end

function var_0_1.OnFishingStateChange(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_1.op
	local var_32_1 = arg_32_1.unitId
	local var_32_2 = arg_32_0
	local var_32_3 = arg_32_0.GetPlayerUnitModule(var_32_2, var_32_1)
	local var_32_4 = arg_32_0.fishingSynPlayers[var_32_1]

	isa = var_32_2

	local var_32_5 = var_32_3

	IslandVisitorUnit = var_1_10009

	if not var_32_2(var_32_5, var_1_10009) then
		return
	end

	if not var_32_4 or not var_32_4:IsSameFishPoint(arg_32_1.fishPointId) then
		return
	end

	local function var_32_6()
		local var_33_0 = var_32_3

		var_0.WakeUp(var_33_0)

		local var_33_1 = arg_32_0.fishingSynPlayers[var_32_1]

		var_0.Dispose(var_33_1)

		arg_32_0.fishingSynPlayers[var_32_1] = nil

		return
	end

	IslandConst = var_7

	if var_32_0 == var_7.FISHING_OP_CANCEL then
		var_32_4:OnCancel(var_32_6)
	else
		IslandConst = var_7

		if var_32_0 == var_7.FISHING_OP_FAILD then
			var_32_4:OnFailed(var_32_6)
		else
			IslandConst = var_7

			if var_32_0 == var_7.FISHING_OP_SUCCESS then
				var_32_4:OnSuccess(var_32_6)
			end
		end
	end

	return
end

function var_0_1.OnStartCoupleAction(arg_34_0)
	arg_34_0:UnBlockLayer1Event(false)

	local var_34_0 = arg_34_0
	local var_34_1 = arg_34_0.GetSubView

	IslandAniamtionOpView = var_4

	local var_34_2 = var_34_1(var_34_0, var_4)

	var_1.OnStartCoupleAction(var_34_2)

	return
end

function var_0_1.OnEndCoupleAction(arg_35_0)
	arg_35_0:UnBlockLayer1Event(true)

	local var_35_0 = arg_35_0
	local var_35_1 = arg_35_0.GetSubView

	IslandAniamtionOpView = var_4

	local var_35_2 = var_35_1(var_35_0, var_4)

	var_1.OnEndCoupleAction(var_35_2)

	return
end

function var_0_1.OnCancelCoupleAction(arg_36_0)
	if arg_36_0.coupleActionPlayer then
		local var_36_0 = arg_36_0.coupleActionPlayer

		if var_1.IsPlaying(var_36_0) then
			local var_36_1 = arg_36_0.coupleActionPlayer

			var_1.Stop(var_36_1)
		end
	end

	if arg_36_0.coupleAction4FollowerPlayer then
		local var_36_2 = arg_36_0.coupleAction4FollowerPlayer

		if var_1.IsPlaying(var_36_2) then
			local var_36_3 = arg_36_0.coupleAction4FollowerPlayer

			var_1.Stop(var_36_3)
		end
	end

	arg_36_0:OnEndCoupleAction()

	return
end

function var_0_1.OnCoupleActionWithFollower(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0
	local var_37_1 = arg_37_0.GetUnitListByKey

	IslandConst = var_1_10005

	local var_37_2 = var_37_1(var_37_0, var_1_10005.UNIT_LIST_FOLLOW)
	local var_37_3 = arg_37_0
	local var_37_4 = arg_37_0.GetPlayerPosition(var_37_3)

	pg = var_37_0

	local var_37_5 = var_37_0.island_set.action_bubble_range.key_value_int

	_ = var_37_3

	if #var_37_3.select(var_37_2, function(arg_38_0)
		if not arg_38_0:IsExitState() then
			Vector3 = var_1

			local var_38_0

			if not (var_1.Distance(arg_38_0:GetPosition(), var_37_4) <= var_37_5) then
				var_38_0 = false
			else
				var_38_0 = true
			end

			return var_38_0
		end
	end) <= 0 then
		return
	end

	math = var_6

	local var_37_6 = var_5[var_6.random(1, #var_5)]

	pg = var_8

	local var_37_7 = var_8.island_action[arg_37_1]
	local var_37_8 = arg_37_0.coupleAction4FollowerPlayer

	var_9.Play(var_37_8, var_37_6, arg_37_0.player, var_37_7)

	local var_37_9 = arg_37_0
	local var_37_10 = arg_37_0.GetSubView

	IslandAniamtionOpView = var_12

	local var_37_11 = var_37_10(var_37_9, var_12)

	var_9.RemoveWaitTimer(var_37_11, false)

	return
end

function var_0_1.OnFollowerAdd(arg_39_0, arg_39_1)
	if arg_39_0:GetSelectedNpcId() then
		IslandCalcUtil = var_2

		local var_39_0, var_39_1 = var_2.GetTypeAndIdByUniqueId(arg_39_0:GetSelectedNpcId())

		if var_39_1 == arg_39_1 then
			arg_39_0.selectedNpcId = nil
		end
	end

	local var_39_2 = arg_39_0
	local var_39_3 = arg_39_0.GetSubView

	IslandOpView = var_1_10005

	local var_39_4 = var_39_3(var_39_2, var_1_10005)

	var_2.FlushFollowerList(var_39_4)

	local var_39_5 = arg_39_0.coupleNpcWordPlayer

	var_2.Play(var_39_5, arg_39_1)

	return
end

function var_0_1.OnFollowerWillDelStep1(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_0
	local var_40_1 = arg_40_0.GetUnitListByKey

	IslandConst = var_1_10005

	local var_40_2 = var_40_1(var_40_0, var_1_10005.UNIT_LIST_FOLLOW)
	local var_40_3

	ipairs = var_40_0

	for iter_40_0, iter_40_1 in var_40_0(var_40_2) do
		local var_40_4 = iter_40_1:GetDataVO()

		if var_9.IsSameShip(var_40_4, arg_40_1) then
			var_40_3 = iter_40_1

			break
		end
	end

	if not var_40_3 or var_40_3:IsExitState() then
		pg = var_4

		local var_40_5 = var_4.TipsMgr.GetInstance()
		local var_40_6 = var_4.ShowTips

		i18n = iter_40_0

		var_40_6(var_40_5, iter_40_0("island_follower_exiting_tip"))

		return
	end

	var_40_3:DoExitHandle()

	return
end

function var_0_1.OnFollowerWillDelStep2(arg_41_0, arg_41_1)
	if not arg_41_1.node then
		return
	end

	local var_41_0 = var_2
	local var_41_1 = var_2.GetComponent

	typeof = var_1_10006
	WorldObjectItem = var_1_10008

	local var_41_2 = var_41_1(var_41_0, var_1_10006(var_1_10008)).uniqueId

	IslandCalcUtil = var_41_0

	local var_41_3, var_41_4 = var_41_0.GetTypeAndIdByUniqueId(var_41_2)

	if not arg_41_0:GetUnitModuleWithType(var_41_3, var_41_4) then
		return
	end

	local var_41_5 = arg_41_0
	local var_41_6 = arg_41_0.NotifiyMeditor

	IslandMediator = var_11

	local var_41_7 = var_11.DEL_FOLLOWER
	local var_41_8 = var_7:GetDataVO()

	var_41_6(var_41_5, var_41_7, var_12.GetShipId(var_41_8))

	return
end

function var_0_1.OnFollowerDel(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_0
	local var_42_1 = arg_42_0.GetSubView

	IslandOpView = var_1_10005

	local var_42_2 = var_42_1(var_42_0, var_1_10005)

	var_2.FlushFollowerList(var_42_2)

	local var_42_3 = arg_42_0.coupleNpcWordPlayer

	var_2.Stop(var_42_3, arg_42_1)

	return
end

function var_0_1.OnResetFollowRandomizer(arg_43_0, arg_43_1)
	if not arg_43_0:GetFollowerModule(arg_43_1) then
		return
	end

	var_2:SetBtRandomizer()

	return
end

function var_0_1.OnShowChatMsg(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_1.player.id

	if not arg_44_0:GetPlayerUnitModule(var_44_0) then
		return
	end

	local var_44_1 = arg_44_0
	local var_44_2 = arg_44_0.GetSubView

	IslandTopHeadHudView = var_1_10007

	local var_44_3 = var_44_2(var_44_1, var_1_10007)

	var_4.PlayChat(var_44_3, var_3, arg_44_1.emojiId, arg_44_1.content, nil)

	return
end

function var_0_1.OnChatRoomChange(arg_45_0)
	local var_45_0 = arg_45_0
	local var_45_1 = arg_45_0.GetSubView

	IslandAniamtionOpView = var_1_10004

	local var_45_2 = var_45_1(var_45_0, var_1_10004)

	var_1.UpdateChatRoom(var_45_2)

	return
end

function var_0_1.OnChatMsgUpdate(arg_46_0)
	local var_46_0 = arg_46_0
	local var_46_1 = arg_46_0.GetSubView

	IslandAniamtionOpView = var_1_10004

	local var_46_2 = var_46_1(var_46_0, var_1_10004)

	var_1.UpdateMsgList(var_46_2)

	return
end

function var_0_1.OnPlaySingleAnimationEnd(arg_47_0, arg_47_1)
	if not arg_47_0:GetSelectedNpcId() then
		local var_47_0 = arg_47_0.npcActionPlayer

		var_2.ResoponByRandom(var_47_0, arg_47_0.player, arg_47_1)

		pg = var_2

		local var_47_1 = var_2.GameTrackerMgr.GetInstance()
		local var_47_2 = var_2.Record

		GameTrackerBuilder = var_5

		var_47_2(var_47_1, var_5.BuildActionOp(1, arg_47_1, 0, 0, 0, 0))

		return
	end

	local var_47_3 = arg_47_0:GetSelectedNpcId()

	IslandCalcUtil = var_1_10003

	local var_47_4, var_47_5 = var_1_10003.GetTypeAndIdByUniqueId(var_47_3)
	local var_47_6 = arg_47_0:GetUnitModuleWithType(var_47_4, var_47_5)

	isa = var_1_10006

	local var_47_7 = var_47_6

	IslandStrollNpcUnit = var_9

	if var_1_10006(var_47_7, var_9) then
		local var_47_8 = var_47_6:GetDataVO()

		if var_6.ExistGreetingActionFeedback(var_47_8) then
			local var_47_9 = arg_47_0.npcActionPlayer

			var_6.Resopon(var_47_9, var_47_6, arg_47_0.player, arg_47_1)

			goto label_47_0
		end
	end

	do
		local var_47_10 = arg_47_0.npcActionPlayer

		var_6.ResoponByRandom(var_47_10, arg_47_0.player, arg_47_1)
	end

	::label_47_0::

	return
end

function var_0_1.OnShowNpcAniamtionBubble(arg_48_0, arg_48_1)
	if not arg_48_0:GetStrollUnitModule(arg_48_1.id) then
		return
	end

	local var_48_0 = arg_48_1:GetGreetingFeedback()
	local var_48_1 = arg_48_0
	local var_48_2 = arg_48_0.GetSubView

	IslandBottomHeadHudView = var_1_10007

	local var_48_3 = var_48_2(var_48_1, var_1_10007)

	var_4.ShowAnimationOp(var_48_3, var_2, var_48_0)

	return
end

function var_0_1.OnHideNpcAniamtionBubble(arg_49_0, arg_49_1)
	local var_49_0 = arg_49_0:GetStrollUnitModule(arg_49_1.id)
	local var_49_1 = arg_49_0
	local var_49_2 = arg_49_0.GetSubView

	IslandBottomHeadHudView = var_1_10006

	local var_49_3 = var_49_2(var_49_1, var_1_10006)

	var_3.HideAnimationOp(var_49_3, var_49_0)

	return
end

function var_0_1.OnStartDoCoupleAction(arg_50_0)
	local var_50_0 = arg_50_0
	local var_50_1 = arg_50_0.GetSubView

	IslandCancelAnimationOpView = var_1_10004

	local var_50_2 = var_50_1(var_50_0, var_1_10004)

	var_1.ShowCancelableAnimationOp(var_50_2, arg_50_0.player)

	return
end

function var_0_1.OnEndDoCoupleAction(arg_51_0)
	local var_51_0 = arg_51_0
	local var_51_1 = arg_51_0.GetSubView

	IslandCancelAnimationOpView = var_1_10004

	local var_51_2 = var_51_1(var_51_0, var_1_10004)

	var_1.HideCancelableAnimationOp(var_51_2, arg_51_0.player)

	return
end

function var_0_1.OnResponAniamtionOp(arg_52_0, arg_52_1)
	local var_52_0 = arg_52_1.id
	local var_52_1 = arg_52_1.targetId
	local var_52_2 = arg_52_1.actionId

	if not arg_52_0:GetPlayerUnitModule(var_52_0) then
		return
	end

	local var_52_3

	if var_52_2 == 0 then
		var_52_3 = arg_52_0

		if not arg_52_0.IsPlayer(var_52_3, var_52_0) then
			var_52_3 = arg_52_0
			var_1_10006 = arg_52_0.GetSubView
			IslandTopHeadHudView = var_9
			var_52_3 = var_1_10006(var_52_3, var_9)

			var_1_10006.HideAnimationOp(var_52_3, var_5)
		else
			pg = var_1_10006
			var_52_3 = var_1_10006.GameTrackerMgr.GetInstance()
			var_1_10006 = var_1_10006.Record
			GameTrackerBuilder = var_9

			var_1_10006(var_52_3, var_9.BuildActionOp(2, var_52_2, 1, 0, 0, 0))
		end

		return
	end

	pg = var_1_10006

	local var_52_4 = var_1_10006.island_action[var_52_2]

	if var_52_1 == 0 then
		local var_52_5 = var_52_4.type

		IslandConst = var_52_3

		if var_52_5 == var_52_3.ANIMATION_OP_DOUBLE and not arg_52_0:IsPlayer(var_52_0) then
			local var_52_6 = arg_52_0
			local var_52_7 = arg_52_0.GetSubView

			IslandTopHeadHudView = var_10

			local var_52_8 = var_52_7(var_52_6, var_10)

			var_7.ShowAnimationOp(var_52_8, var_5, var_52_2)

			goto label_52_0
		end
	end

	if var_52_1 > 0 then
		local var_52_9 = var_52_4.type

		IslandConst = var_52_3

		if var_52_9 == var_52_3.ANIMATION_OP_DOUBLE and not arg_52_0:IsPlayer(var_52_1) then
			local var_52_10 = arg_52_0:GetPlayerUnitModule(var_52_1)
			local var_52_11 = arg_52_0.coupleActionPlayer

			var_52_3.Play(var_52_11, var_5, var_52_10, var_52_4)

			local var_52_12 = arg_52_0

			var_52_3 = arg_52_0.GetSubView
			IslandTopHeadHudView = var_11

			local var_52_13 = var_52_3(var_52_12, var_11)

			var_52_3.HideAnimationOp(var_52_13, var_52_10)

			goto label_52_0
		end
	end

	if var_52_1 > 0 then
		local var_52_14 = var_52_4.type

		IslandConst = var_52_3

		if var_52_14 == var_52_3.ANIMATION_OP_DOUBLE and arg_52_0:IsPlayer(var_52_1) then
			local var_52_15 = arg_52_0:GetPlayerUnitModule(var_52_1)
			local var_52_16 = arg_52_0.coupleActionPlayer

			var_8.Play(var_52_16, var_5, var_52_15, var_52_4)

			local var_52_17 = arg_52_0
			local var_52_18 = arg_52_0.GetSubView

			IslandAniamtionOpView = var_11

			local var_52_19 = var_52_18(var_52_17, var_11)

			var_8.RemoveWaitTimer(var_52_19, false)

			pg = var_8

			local var_52_20 = var_8.GameTrackerMgr.GetInstance()
			local var_52_21 = var_8.Record

			GameTrackerBuilder = var_11

			var_52_21(var_52_20, var_11.BuildActionOp(2, var_52_2, 1, var_52_1, 0, 1))
		end
	end

	::label_52_0::

	return
end

function var_0_1.OnShowChatMsg(arg_53_0, arg_53_1)
	local var_53_0 = arg_53_1.player.id

	if not arg_53_0:GetPlayerUnitModule(var_53_0) then
		return
	end

	local var_53_1 = arg_53_0
	local var_53_2 = arg_53_0.GetSubView

	IslandTopHeadHudView = var_1_10007

	local var_53_3 = var_53_2(var_53_1, var_1_10007)

	var_4.PlayChat(var_53_3, var_3, arg_53_1.emojiId, arg_53_1.content, nil)

	return
end

function var_0_1.OnChatRoomChange(arg_54_0)
	local var_54_0 = arg_54_0
	local var_54_1 = arg_54_0.GetSubView

	IslandAniamtionOpView = var_1_10004

	local var_54_2 = var_54_1(var_54_0, var_1_10004)

	var_1.UpdateChatRoom(var_54_2)

	return
end

function var_0_1.OnChatMsgUpdate(arg_55_0)
	local var_55_0 = arg_55_0
	local var_55_1 = arg_55_0.GetSubView

	IslandAniamtionOpView = var_1_10004

	local var_55_2 = var_55_1(var_55_0, var_1_10004)

	var_1.UpdateMsgList(var_55_2)

	return
end

function var_0_1.OnFollowerAdd(arg_56_0, arg_56_1)
	local var_56_0 = arg_56_0
	local var_56_1 = arg_56_0.GetSubView

	IslandOpView = var_1_10005

	local var_56_2 = var_56_1(var_56_0, var_1_10005)

	var_2.FlushFollowerList(var_56_2)

	local var_56_3 = arg_56_0.coupleNpcWordPlayer

	var_2.Play(var_56_3, arg_56_1)

	return
end

function var_0_1.OnFollowerDel(arg_57_0, arg_57_1)
	local var_57_0 = arg_57_0
	local var_57_1 = arg_57_0.GetSubView

	IslandOpView = var_1_10005

	local var_57_2 = var_57_1(var_57_0, var_1_10005)

	var_2.FlushFollowerList(var_57_2)

	local var_57_3 = arg_57_0.coupleNpcWordPlayer

	var_2.Stop(var_57_3, arg_57_1)

	return
end

function var_0_1.OnResetFollowRandomizer(arg_58_0, arg_58_1)
	if not arg_58_0:GetFollowerModule(arg_58_1) then
		return
	end

	var_2:SetBtRandomizer()

	return
end

function var_0_1.OnGenPathFinder(arg_59_0, arg_59_1)
	IslandPathFinder = var_1_10002

	local var_59_0 = var_1_10002.New(arg_59_0)

	defaultValue = var_1_10003

	local var_59_1 = var_1_10003(arg_59_1.navData.waitUntilDone, false)

	var_59_0:Start(arg_59_1.navData, function()
		table = var_2_10000

		var_2_10000.removebyvalue(arg_59_0.pathfinders, var_59_0)

		local var_60_0 = var_59_0

		var_0.Dispose(var_60_0)

		if arg_59_1.onEndAction then
			arg_59_1.onEndAction()
		end

		local var_60_1 = arg_59_0
		local var_60_2 = var_0.NotifiyIsland

		ISLAND_EX_EVT = var_3

		var_60_2(var_60_1, var_3.NAV_PATH_DONE, arg_59_1.navData.index)

		if var_59_1 and arg_59_1.callback then
			arg_59_1.callback()
		end

		return
	end)

	local var_59_2 = arg_59_0
	local var_59_3 = arg_59_0.NotifiyIsland

	ISLAND_EX_EVT = var_7

	var_59_3(var_59_2, var_7.NAV_PATH, arg_59_1.navData.index)

	if not var_59_1 and arg_59_1.callback then
		arg_59_1.callback()
	end

	table = var_59_3

	var_59_3.insert(arg_59_0.pathfinders, var_59_0)

	return
end

function var_0_1.OnRemovePathFinder(arg_61_0, arg_61_1)
	local var_61_0 = arg_61_0:GetUnitModuleWithType(arg_61_1.unitType, arg_61_1.unitId)

	_ = var_1_10003

	if not var_1_10003.detect(arg_61_0.pathfinders, function(arg_62_0)
		return arg_62_0:IsSameUnit(var_61_0)
	end) then
		return
	end

	var_3:Stop()
	var_3:Dispose()

	table = var_4

	var_4.removebyvalue(arg_61_0.pathfinders, var_3)

	return
end

function var_0_1.OnTracking(arg_63_0, arg_63_1)
	local var_63_0 = arg_63_1.trackType

	IslandTaskTrackCard = var_1_10003

	if var_63_0 == var_1_10003.TYPES.MAIN then
		tonumber = var_3
		arg_63_0.mainTrackId = var_3(arg_63_1.id)
		arg_63_0.needTryMainTrack = true
	else
		IslandTaskTrackCard = var_3

		if var_63_0 == var_3.TYPES.OTHER then
			tonumber = var_3
			arg_63_0.trackId = var_3(arg_63_1.id)

			local var_63_1

			if not arg_63_1.typ then
				IslandTaskType = var_63_1
				var_63_1 = var_63_1.MAIN
			end

			arg_63_0.trackType = var_63_1
			arg_63_0.needTryTrack = true
		end
	end

	return
end

function var_0_1.TryTrack(arg_64_0)
	arg_64_0:TrySetTrack(arg_64_0.trackId)

	return
end

function var_0_1.TrySetTrack(arg_65_0, arg_65_1)
	if not arg_65_0:GetOptTrackingTarget(arg_65_1) or not var_2._go then
		return
	end

	local var_65_0 = arg_65_0
	local var_65_1 = arg_65_0.GetSubView

	IslandDistanceView = var_1_10006

	local var_65_2 = var_65_1(var_65_0, var_1_10006)
	local var_65_3 = var_3.SetTrackingTarget
	local var_65_4 = arg_65_0.player
	local var_65_5 = var_2
	local var_65_6 = arg_65_1
	local var_65_7 = arg_65_0.trackType

	IslandTaskTrackCard = var_1_10010

	var_65_3(var_65_2, var_65_4, var_65_5, var_65_6, var_65_7, var_1_10010.TYPES.OTHER)

	arg_65_0.needTryTrack = false

	return
end

function var_0_1.TryMainTrack(arg_66_0)
	arg_66_0:TrySetMainTrack(arg_66_0.mainTrackId)

	return
end

function var_0_1.TrySetMainTrack(arg_67_0, arg_67_1)
	if not arg_67_0:GetOptTrackingTarget(arg_67_1) or not var_2._go then
		return
	end

	local var_67_0 = arg_67_0
	local var_67_1 = arg_67_0.GetSubView

	IslandDistanceView = var_1_10006

	local var_67_2 = var_67_1(var_67_0, var_1_10006)
	local var_67_3 = var_3.SetTrackingTarget
	local var_67_4 = arg_67_0.player
	local var_67_5 = var_2
	local var_67_6 = arg_67_1

	IslandTaskType = var_1_10009

	local var_67_7 = var_1_10009.MAIN

	IslandTaskTrackCard = var_1_10010

	var_67_3(var_67_2, var_67_4, var_67_5, var_67_6, var_67_7, var_1_10010.TYPES.MAIN)

	arg_67_0.needTryMainTrack = false

	return
end

function var_0_1.OnUnTracking(arg_68_0, arg_68_1)
	IslandTaskTrackCard = var_1_10002

	if arg_68_1 == var_1_10002.TYPES.MAIN then
		arg_68_0.mainTrackId = nil
	else
		IslandTaskTrackCard = var_2

		if arg_68_1 == var_2.TYPES.OTHER then
			arg_68_0.trackId = nil
		end
	end

	local var_68_0 = arg_68_0
	local var_68_1 = arg_68_0.GetSubView

	IslandDistanceView = var_1_10005

	local var_68_2 = var_68_1(var_68_0, var_1_10005)

	var_2.CancelTracking(var_68_2, arg_68_1)

	return
end

local function var_0_2(arg_69_0, arg_69_1)
	pg = var_1_10002

	if not var_1_10002.island_world_objects[arg_69_0] then
		return
	end

	return var_2.mapId == arg_69_1
end

local function var_0_3(arg_70_0, arg_70_1, arg_70_2)
	ipairs = var_1_10003

	for iter_70_0, iter_70_1 in var_1_10003(arg_70_0) do
		ipairs = var_1_10008

		for iter_70_2, iter_70_3 in var_1_10008(iter_70_1[2]) do
			pg = var_1_10013

			if var_1_10013.island_interaction[iter_70_3].type == arg_70_2 then
				local var_70_0 = var_0_2

				tonumber = var_1_10016

				if var_70_0(var_1_10016(var_1_10013.param), arg_70_1) then
					return iter_70_1[1]
				end
			end
		end
	end

	return nil
end

local function var_0_4(arg_71_0)
	local var_71_0 = {}
	local var_71_1 = {}

	ipairs = var_1_10003

	for iter_71_0, iter_71_1 in var_1_10003(arg_71_0) do
		ipairs = var_1_10008

		for iter_71_2, iter_71_3 in var_1_10008(iter_71_1[2]) do
			pg = var_1_10013

			local var_71_2 = var_1_10013.island_interaction[iter_71_3].type

			IslandInteractionUntil = var_1_10015

			if var_71_2 == var_1_10015.TYPE_TRANSFER then
				table = var_71_2

				var_71_2.insert(var_71_0, iter_71_1[1])
			else
				local var_71_3 = var_1_10013.type

				IslandInteractionUntil = var_1_10015

				if var_71_3 == var_1_10015.TYPE_SP_TRANSFER then
					table = var_71_3

					var_71_3.insert(var_71_1, iter_71_1[1])
				end
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

function var_0_1.GetOptTrackingTarget(arg_72_0, arg_72_1)
	if arg_72_0:GetUnitModule(arg_72_1) then
		return var_2
	end

	pg = var_1_10003

	if not var_1_10003.island_world_objects[arg_72_1] then
		return nil
	end

	local var_72_0 = {}

	ipairs = var_5

	local var_72_1 = arg_72_0
	local var_72_2 = arg_72_0.GetUnitListByKey

	IslandConst = var_1_10010

	for iter_72_0, iter_72_1 in var_5(var_72_2(var_72_1, var_1_10010.UNIT_LIST_OBJ)) do
		local var_72_3 = iter_72_1
		local var_72_4, var_72_5 = iter_72_1.IsMapTransfer(var_72_3)

		if var_72_4 then
			table = var_72_3

			var_72_3.insert(var_72_0, {
				iter_72_1,
				var_72_5
			})
		end
	end

	local var_72_6
	local var_72_7 = var_0_3
	local var_72_8 = var_72_0
	local var_72_9 = var_3.mapId

	IslandInteractionUntil = var_72_4

	local var_72_13

	if not var_72_7(var_72_8, var_72_9, var_72_4.TYPE_TRANSFER) then
		local var_72_10 = var_0_3
		local var_72_11 = var_72_0
		local var_72_12 = var_3.mapId

		IslandInteractionUntil = var_10
		var_72_13 = var_72_10(var_72_11, var_72_12, var_10.TYPE_SP_TRANSFER)
	end

	var_72_13 = var_72_13 or var_0_4(var_72_0)

	return var_72_13
end

function var_0_1.OnOpenAniamtionOpPage(arg_73_0)
	local var_73_0 = arg_73_0
	local var_73_1 = arg_73_0.GetSubView

	IslandAniamtionOpView = var_1_10004

	local var_73_2 = var_73_1(var_73_0, var_1_10004)

	var_1.TryEnable(var_73_2)

	local var_73_3 = arg_73_0
	local var_73_4 = arg_73_0.GetSubView

	IslandOpView = var_1_10004

	local var_73_5 = var_73_4(var_73_3, var_1_10004)

	var_1.TryDisable(var_73_5)

	local var_73_6 = arg_73_0
	local var_73_7 = arg_73_0.NotifiyIsland

	ISLAND_EX_EVT = var_1_10004

	var_73_7(var_73_6, var_1_10004.OPEN_ANIMATION_OP)

	return
end

function var_0_1.OnCloseAniamtionOpPage(arg_74_0)
	local var_74_0 = arg_74_0
	local var_74_1 = arg_74_0.GetSubView

	IslandOpView = var_1_10004

	local var_74_2 = var_74_1(var_74_0, var_1_10004)

	var_1.TryEnable(var_74_2)

	local var_74_3 = arg_74_0
	local var_74_4 = arg_74_0.NotifiyIsland

	ISLAND_EX_EVT = var_1_10004

	var_74_4(var_74_3, var_1_10004.CLOSE_ANIMATION_OP)

	return
end

function var_0_1.OnAnyPageOpen(arg_75_0, arg_75_1)
	arg_75_0.anyPageOpen = true

	local var_75_0 = arg_75_0.player

	var_2.StopMoveHandle(var_75_0)

	local var_75_1 = arg_75_0
	local var_75_2 = arg_75_0.GetSubView

	IslandTopHeadHudView = var_1_10005

	local var_75_3 = var_75_2(var_75_1, var_1_10005)

	var_2.TryDisable(var_75_3)

	local var_75_4 = arg_75_0
	local var_75_5 = arg_75_0.GetSubView

	IslandSlotHudView = var_1_10005

	local var_75_6 = var_75_5(var_75_4, var_1_10005)

	var_2.TryDisable(var_75_6)

	local var_75_7 = arg_75_0
	local var_75_8 = arg_75_0.GetSubView

	IslandBottomHeadHudView = var_1_10005

	local var_75_9 = var_75_8(var_75_7, var_1_10005)

	var_2.TryDisable(var_75_9)

	local var_75_10 = arg_75_0
	local var_75_11 = arg_75_0.GetSubView

	IslandOpView = var_1_10005

	local var_75_12 = var_75_11(var_75_10, var_1_10005)

	var_2.TryDisablePlayerOp(var_75_12)

	local var_75_13 = arg_75_0
	local var_75_14 = arg_75_0.GetSubView

	IslandAniamtionOpView = var_1_10005

	local var_75_15 = var_75_14(var_75_13, var_1_10005)

	var_2.CloseAndReset(var_75_15)

	return
end

function var_0_1.OnAllPageClose(arg_76_0)
	arg_76_0.anyPageOpen = false

	local var_76_0 = arg_76_0
	local var_76_1 = arg_76_0.GetSubView

	IslandTopHeadHudView = var_1_10004

	local var_76_2 = var_76_1(var_76_0, var_1_10004)

	var_1.TryEnable(var_76_2)

	local var_76_3 = arg_76_0
	local var_76_4 = arg_76_0.GetSubView

	IslandSlotHudView = var_1_10004

	local var_76_5 = var_76_4(var_76_3, var_1_10004)

	var_1.TryEnable(var_76_5)

	local var_76_6 = arg_76_0
	local var_76_7 = arg_76_0.GetSubView

	IslandBottomHeadHudView = var_1_10004

	local var_76_8 = var_76_7(var_76_6, var_1_10004)

	var_1.TryEnable(var_76_8)

	local var_76_9 = arg_76_0
	local var_76_10 = arg_76_0.GetSubView

	IslandOpView = var_1_10004

	local var_76_11 = var_76_10(var_76_9, var_1_10004)

	var_1.TryEnablePlayerOp(var_76_11)

	return
end

function var_0_1.OnStartStory(arg_77_0)
	arg_77_0.playingStory = true

	arg_77_0:DisablePlayerOp()

	return
end

function var_0_1.OnEndStory(arg_78_0)
	arg_78_0.playingStory = false

	arg_78_0:EnablePlayerOp()

	return
end

function var_0_1.OnStartPerformance(arg_79_0)
	return
end

function var_0_1.OnEndPerformance(arg_80_0)
	if not arg_80_0.anyPageOpen then
		local var_80_0 = arg_80_0
		local var_80_1 = arg_80_0.GetSubView

		IslandOpView = var_1_10004

		local var_80_2 = var_80_1(var_80_0, var_1_10004)

		var_1.ResetShowBalance(var_80_2)
	end

	return
end

function var_0_1.OnStartGuide(arg_81_0)
	local var_81_0 = arg_81_0.player

	var_1.StopMoveHandle(var_81_0)

	local var_81_1 = arg_81_0
	local var_81_2 = arg_81_0.GetSubView

	IslandOpView = var_1_10004

	local var_81_3 = var_81_2(var_81_1, var_1_10004)

	var_1.DisableInput(var_81_3)

	return
end

function var_0_1.OnEndGuide(arg_82_0)
	if arg_82_0.playingStory then
		return
	end

	local var_82_0 = arg_82_0
	local var_82_1 = arg_82_0.GetSubView

	IslandOpView = var_1_10004

	local var_82_2 = var_82_1(var_82_0, var_1_10004)

	var_1.EnableInput(var_82_2)

	return
end

function var_0_1.InitFocusCamera(arg_83_0)
	IslandCameraMgr = var_1_10001

	local var_83_0 = var_1_10001.instance
	local var_83_1 = var_1.GetVirtualCamera

	IslandConst = var_1_10004

	local var_83_2 = var_83_1(var_83_0, var_1_10004.FOCUS_CAMERA_NAME)

	var_83_2.Follow = arg_83_0.player._tf
	var_83_2.LookAt = arg_83_0.player._tf

	return
end

function var_0_1.InitTakePhotoCamera(arg_84_0)
	IslandCameraMgr = var_1_10001

	local var_84_0 = var_1_10001.instance
	local var_84_1 = var_1.GetVirtualCamera

	IslandConst = var_1_10004
	var_84_1(var_84_0, var_1_10004.FIRST_PERSON_TAKE_PHOTO_CAMERA_NAME).Follow = arg_84_0.firstTakePhotoItem._tf
	IslandCameraMgr = var_2

	local var_84_2 = var_2.instance
	local var_84_3 = var_2.GetVirtualCamera

	IslandConst = var_1_10005

	local var_84_4 = var_84_3(var_84_2, var_1_10005.Third_PERSON_TAKE_PHOTO_CAMERA_NAME)

	var_84_4.Follow = arg_84_0.thirdTakePhotoItem._tf
	var_84_4.LookAt = arg_84_0.thirdTakePhotoItem._tf

	return
end

function var_0_1.DisablePlayerOp(arg_85_0)
	local var_85_0 = arg_85_0.player

	var_1.StopMoveHandle(var_85_0)

	local var_85_1 = arg_85_0
	local var_85_2 = arg_85_0.GetSubView

	IslandTopHeadHudView = var_1_10004

	local var_85_3 = var_85_2(var_85_1, var_1_10004)

	var_1.TryDisable(var_85_3)

	local var_85_4 = arg_85_0
	local var_85_5 = arg_85_0.GetSubView

	IslandBottomHeadHudView = var_1_10004

	local var_85_6 = var_85_5(var_85_4, var_1_10004)

	var_1.TryDisable(var_85_6)

	local var_85_7 = arg_85_0
	local var_85_8 = arg_85_0.GetSubView

	IslandOpView = var_1_10004

	local var_85_9 = var_85_8(var_85_7, var_1_10004)

	var_1.TryDisablePlayerOp(var_85_9)

	local var_85_10 = arg_85_0
	local var_85_11 = arg_85_0.GetSubView

	IslandOpView = var_1_10004

	local var_85_12 = var_85_11(var_85_10, var_1_10004)

	var_1.TryDisable(var_85_12)

	return
end

function var_0_1.EnablePlayerOp(arg_86_0)
	local var_86_0 = arg_86_0
	local var_86_1 = arg_86_0.GetSubView

	IslandOpView = var_1_10004

	local var_86_2 = var_86_1(var_86_0, var_1_10004)

	var_1.TryEnablePlayerOp(var_86_2)

	local var_86_3 = arg_86_0
	local var_86_4 = arg_86_0.GetSubView

	IslandTopHeadHudView = var_1_10004

	local var_86_5 = var_86_4(var_86_3, var_1_10004)

	var_1.TryEnable(var_86_5)

	local var_86_6 = arg_86_0
	local var_86_7 = arg_86_0.GetSubView

	IslandBottomHeadHudView = var_1_10004

	local var_86_8 = var_86_7(var_86_6, var_1_10004)

	var_1.TryEnable(var_86_8)

	local var_86_9 = arg_86_0
	local var_86_10 = arg_86_0.GetSubView

	IslandOpView = var_1_10004

	local var_86_11 = var_86_10(var_86_9, var_1_10004)

	var_1.TryEnable(var_86_11)

	return
end

function var_0_1.OnInterActionBegin(arg_87_0)
	local var_87_0 = arg_87_0.player

	var_1.StopMoveHandle(var_87_0)

	local var_87_1 = arg_87_0
	local var_87_2 = arg_87_0.GetSubView

	IslandOpView = var_1_10004

	local var_87_3 = var_87_2(var_87_1, var_1_10004)

	var_1.TryDisablePlayerOp(var_87_3)

	return
end

function var_0_1.OnInterActionEnd(arg_88_0)
	local var_88_0 = arg_88_0
	local var_88_1 = arg_88_0.GetSubView

	IslandOpView = var_1_10004

	local var_88_2 = var_88_1(var_88_0, var_1_10004)

	var_1.TryEnablePlayerOp(var_88_2)

	return
end

function var_0_1.OnShowInterActionPanel(arg_89_0, arg_89_1)
	arg_89_0.showInterObjId = arg_89_1.id

	local var_89_0 = arg_89_0
	local var_89_1 = arg_89_0.GetSubView

	IslandInteractionView = var_1_10005

	local var_89_2 = var_89_1(var_89_0, var_1_10005)

	var_2.ShowInterActionPanel(var_89_2, arg_89_1)

	local var_89_3 = arg_89_0
	local var_89_4 = arg_89_0.Op
	local var_89_5 = "NotifiyIsland"

	ISLAND_EX_EVT = var_1_10006

	var_89_4(var_89_3, var_89_5, var_1_10006.SHOW_INTERACTION, arg_89_0.showInterObjId)

	return
end

function var_0_1.OnHideInterActionPanel(arg_90_0, arg_90_1)
	if arg_90_0.showInterObjId ~= arg_90_1.id then
		return
	end

	arg_90_0.showInterObjId = nil

	local var_90_0 = arg_90_0
	local var_90_1 = arg_90_0.GetSubView

	IslandInteractionView = var_1_10005

	local var_90_2 = var_90_1(var_90_0, var_1_10005)

	var_2.HideInterActionPanel(var_90_2)

	return
end

function var_0_1.OnRefreshInteractionBtn(arg_91_0)
	local var_91_0 = arg_91_0
	local var_91_1 = arg_91_0.GetSubView

	IslandInteractionView = var_1_10004

	local var_91_2 = var_91_1(var_91_0, var_1_10004)

	var_1.RefreshInteractionBtns(var_91_2)

	return
end

function var_0_1.OnSetOpMoveBtnActve(arg_92_0, arg_92_1, arg_92_2)
	local var_92_0 = arg_92_0
	local var_92_1 = arg_92_0.GetSubView

	IslandOpView = var_1_10006

	local var_92_2 = var_92_1(var_92_0, var_1_10006)

	var_3.ShowOrHideMoveBtn(var_92_2, arg_92_1, arg_92_2)

	return
end

function var_0_1.DisableInput(arg_93_0)
	local var_93_0 = arg_93_0.player

	var_1.StopMoveHandle(var_93_0)

	local var_93_1 = arg_93_0
	local var_93_2 = arg_93_0.GetSubView

	IslandOpView = var_1_10004

	local var_93_3 = var_93_2(var_93_1, var_1_10004)

	var_1.DisableInput(var_93_3)

	return
end

function var_0_1.EnableInput(arg_94_0)
	local var_94_0 = arg_94_0
	local var_94_1 = arg_94_0.GetSubView

	IslandOpView = var_1_10004

	local var_94_2 = var_94_1(var_94_0, var_1_10004)

	var_1.EnableInput(var_94_2)

	return
end

function var_0_1.OnUpdateCustomOpPositon(arg_95_0)
	local var_95_0 = arg_95_0
	local var_95_1 = arg_95_0.GetSubView

	IslandOpView = var_1_10004

	local var_95_2 = var_95_1(var_95_0, var_1_10004)

	var_1.InitOpCustumPositon(var_95_2)

	return
end

function var_0_1.OnChange_Photo_Height(arg_96_0, arg_96_1, arg_96_2)
	arg_96_0.takePhotoModel = arg_96_1

	local var_96_0 = arg_96_0.takePhotoModel

	IslandConst = var_1_10004

	if var_96_0 == var_1_10004.TakePhotoModel.First then
		-- block empty
	else
		local var_96_1 = arg_96_0.takePhotoModel

		IslandConst = var_4

		if var_96_1 == var_4.TakePhotoModel.Third then
			local var_96_2 = arg_96_0.thirdTakePhotoItem

			var_3.ChangeHeight(var_96_2, arg_96_2)
		end
	end

	return
end

function var_0_1.OnChangeTakePhotoModel(arg_97_0, arg_97_1, arg_97_2)
	arg_97_0.takePhotoModel = arg_97_1

	local var_97_0 = arg_97_0.takePhotoModel

	IslandConst = var_1_10004

	local var_97_8

	if var_97_0 == var_1_10004.TakePhotoModel.First then
		local var_97_1 = arg_97_0.firstTakePhotoItem

		var_3.Enable(var_97_1)

		arg_97_0.firstTakePhotoItem._tf.position = arg_97_0.player._tf.position
		arg_97_0.firstTakePhotoItem._tf.rotation = arg_97_0.player._tf.rotation

		local var_97_2 = arg_97_0.firstTakePhotoItem

		var_3.SetTargetRotation(var_97_2, arg_97_0.player._tf.rotation)

		local var_97_3 = arg_97_0.player

		var_3.SetActiveByLayer(var_97_3, false)

		IslandCameraMgr = var_3

		local var_97_4 = var_3.instance
		local var_97_5 = var_3.ActiveVirtualCamera

		IslandConst = var_1_10006

		var_97_5(var_97_4, var_1_10006.FIRST_PERSON_TAKE_PHOTO_CAMERA_NAME)

		IslandCameraMgr = var_97_5

		local var_97_6 = var_97_5.instance
		local var_97_7 = var_3.GetVirtualCamera

		IslandConst = var_1_10006
		var_1_10006 = var_97_7(var_97_6, var_1_10006.FIRST_PERSON_TAKE_PHOTO_CAMERA_NAME).gameObject
		var_97_8 = var_97_8.GetComponent
		typeof = var_1_10007
		CameraPovLook = var_1_10009
		var_1_10007 = var_97_8(var_1_10006, var_1_10007(var_1_10009))

		var_97_8.SetPosAndRotationByTargetDir(var_1_10007, arg_97_0.player._tf.forward)
	else
		local var_97_9 = arg_97_0.takePhotoModel

		IslandConst = var_97_8

		if var_97_9 == var_97_8.TakePhotoModel.Third then
			local var_97_10 = arg_97_0.thirdTakePhotoItem

			var_3.Enable(var_97_10)

			arg_97_0.player._tf.position = arg_97_0.firstTakePhotoItem._tf.position
			arg_97_0.player._tf.rotation = arg_97_0.firstTakePhotoItem._tf.rotation

			local var_97_11 = arg_97_0.player

			var_3.SetTargetRotation(var_97_11, arg_97_0.firstTakePhotoItem._tf.rotation)

			local var_97_12 = arg_97_0.player

			var_3.SetActiveByLayer(var_97_12, true)

			local var_97_13 = arg_97_0.thirdTakePhotoItem._tf

			var_1_10006 = arg_97_0.firstTakePhotoItem._tf

			local var_97_14 = var_4.TransformPoint

			Vector3 = var_1_10007
			var_97_13.position = var_97_14(var_1_10006, var_1_10007(0, 0, -5))
			arg_97_0.thirdTakePhotoItem._tf.rotation = arg_97_0.firstTakePhotoItem._tf.rotation

			local var_97_15 = arg_97_0.thirdTakePhotoItem

			var_3.SetTargetRotation(var_97_15, arg_97_0.firstTakePhotoItem._tf.rotation)

			IslandCameraMgr = var_3

			local var_97_16 = var_3.instance
			local var_97_17 = var_3.GetVirtualCamera

			IslandConst = var_1_10006
			var_1_10006 = var_97_17(var_97_16, var_1_10006.Third_PERSON_TAKE_PHOTO_CAMERA_NAME).gameObject

			local var_97_18 = var_4.GetComponent

			typeof = var_1_10007
			CameraPovLook = var_1_10009

			local var_97_19 = var_97_18(var_1_10006, var_1_10007(var_1_10009))
			local var_97_20 = arg_97_0.player._tf.position

			Vector3 = var_1_10006

			local var_97_21 = var_97_20 + var_1_10006(0, 0.5, 0)

			var_1_10006 = arg_97_0.thirdTakePhotoItem._tf.position
			Vector3 = var_1_10007
			var_1_10006 = var_1_10006 + var_1_10007(0, 1, 0)
			var_1_10009 = var_97_19

			var_97_19.SetPosAndRotationByTargetDir(var_1_10009, (var_97_21 - var_1_10006).normalized)

			IslandCameraMgr = var_1_10007
			var_1_10009 = var_1_10007.instance
			var_1_10007 = var_1_10007.ActiveVirtualCamera
			IslandConst = var_10

			var_1_10007(var_1_10009, var_10.Third_PERSON_TAKE_PHOTO_CAMERA_NAME)
		else
			local var_97_22 = arg_97_0.firstTakePhotoItem

			var_3.Disable(var_97_22)

			local var_97_23 = arg_97_0.thirdTakePhotoItem

			var_3.Disable(var_97_23)

			arg_97_0.player._tf.position = arg_97_0.firstTakePhotoItem._tf.position
			arg_97_0.player._tf.rotation = arg_97_0.firstTakePhotoItem._tf.rotation

			local var_97_24 = arg_97_0.player

			var_3.SetTargetRotation(var_97_24, arg_97_0.firstTakePhotoItem._tf.rotation)

			local var_97_25 = arg_97_0.player

			var_3.SetActiveByLayer(var_97_25, true)

			IslandCameraMgr = var_3

			local var_97_26 = var_3.instance
			local var_97_27 = var_3.ActiveVirtualCamera

			IslandConst = var_1_10006

			var_97_27(var_97_26, var_1_10006.FOLLOW_CAMERA_NAME)

			IslandCameraMgr = var_97_27

			local var_97_28 = var_97_27.instance
			local var_97_29 = var_3.GetVirtualCamera

			IslandConst = var_1_10006
			var_1_10006 = var_97_29(var_97_28, var_1_10006.FOLLOW_CAMERA_NAME).gameObject

			local var_97_30 = var_4.GetComponent

			typeof = var_1_10007
			CameraLook = var_1_10009

			local var_97_31 = var_97_30(var_1_10006, var_1_10007(var_1_10009))

			var_4.ResetCameraPos(var_97_31)
		end
	end

	local var_97_32 = arg_97_0
	local var_97_33 = arg_97_0.GetSubView

	IslandOpView = var_1_10006

	local var_97_34 = var_97_33(var_97_32, var_1_10006)

	var_3.ChangeTakePhotoModel(var_97_34, arg_97_1, arg_97_2)

	return
end

function var_0_1.OnNpcDetectorSelected(arg_98_0, arg_98_1)
	if arg_98_0.selectedNpcId then
		return
	end

	if not arg_98_1.node then
		return
	end

	local var_98_0 = var_2
	local var_98_1 = var_2.GetComponent

	typeof = var_1_10006
	WorldObjectItem = var_1_10008
	arg_98_0.selectedNpcId = var_98_1(var_98_0, var_1_10006(var_1_10008)).uniqueId

	local var_98_2 = arg_98_0
	local var_98_3 = arg_98_0.GetSubView

	IslandOpView = var_1_10008

	local var_98_4 = var_98_3(var_98_2, var_1_10008)

	var_5.UpdateAnimationOpEffect(var_98_4, var_4, true)

	local var_98_5 = arg_98_0
	local var_98_6 = arg_98_0.GetSubView

	IslandBottomHeadHudView = var_8

	local var_98_7 = var_98_6(var_98_5, var_8)

	var_5.UpdateAnimationOpEffect(var_98_7, var_4, true)

	local var_98_8 = arg_98_0
	local var_98_9 = arg_98_0.GetSubView

	IslandAniamtionOpView = var_8

	local var_98_10 = var_98_9(var_98_8, var_8)

	var_5.SortForNpcAction(var_98_10, var_4)

	return
end

function var_0_1.GetSelectedNpcId(arg_99_0)
	return arg_99_0.selectedNpcId
end

function var_0_1.OnNpcDetectorUnSelected(arg_100_0, arg_100_1)
	if not arg_100_1.node then
		return
	end

	local var_100_0 = var_2
	local var_100_1 = var_2.GetComponent

	typeof = var_1_10006
	WorldObjectItem = var_1_10008

	local var_100_2 = var_100_1(var_100_0, var_1_10006(var_1_10008)).uniqueId
	local var_100_3 = arg_100_0
	local var_100_4 = arg_100_0.GetSubView

	IslandOpView = var_1_10008

	local var_100_5 = var_100_4(var_100_3, var_1_10008)

	var_5.UpdateAnimationOpEffect(var_100_5, var_100_2)

	local var_100_6 = arg_100_0
	local var_100_7 = arg_100_0.GetSubView

	IslandBottomHeadHudView = var_8

	local var_100_8 = var_100_7(var_100_6, var_8)

	var_5.UpdateAnimationOpEffect(var_100_8, var_100_2)

	local var_100_9 = arg_100_0
	local var_100_10 = arg_100_0.GetSubView

	IslandAniamtionOpView = var_8

	local var_100_11 = var_100_10(var_100_9, var_8)

	var_5.SortForNpcAction(var_100_11, nil)

	if arg_100_0.selectedNpcId ~= var_100_2 then
		return
	end

	arg_100_0.selectedNpcId = nil

	return
end

function var_0_1.OnDetectorChanged(arg_101_0, arg_101_1)
	if not arg_101_1.node then
		return
	end

	local var_101_0 = var_2:GetBlackboardVariable("DetectorList")

	for iter_101_0 = 1, var_101_0.Count do
		local var_101_1 = var_101_0[iter_101_0 - 1]

		IslandCalcUtil = var_1_10009

		local var_101_2

		var_1_10009, var_101_2 = var_1_10009.GetTypeAndIdByUniqueId(var_101_1)
		IslandConst = var_11

		if var_1_10009 == var_11.UNIT_LIST_OBJ and arg_101_0:GetUnitModuleWithType(var_1_10009, var_101_2) then
			local var_101_3 = arg_101_0
			local var_101_4 = arg_101_0.Op
			local var_101_5 = "NotifiyIsland"

			ISLAND_EX_EVT = var_1_10016

			var_101_4(var_101_3, var_101_5, var_1_10016.APPROACH_OBJECT, var_11.id)
		end
	end

	return
end

function var_0_1.OnDetectorSelected(arg_102_0, arg_102_1)
	if not arg_102_1.node then
		return
	end

	if not var_2:GetBlackboardVariable("AnyOne") or var_3 == "" then
		arg_102_0:OnClearSelectedUnit()
	else
		IslandCalcUtil = var_1_10004

		local var_102_0, var_102_1 = var_1_10004.GetTypeAndIdByUniqueId(var_3)

		if arg_102_0:GetUnitModuleWithType(var_102_0, var_102_1) then
			arg_102_0:OnSelectedUnit(var_6)
		end
	end

	return
end

function var_0_1.OnClearSelectedUnit(arg_103_0)
	return
end

function var_0_1.OnSelectedUnit(arg_104_0, arg_104_1)
	return
end

function var_0_1.OnPlayChatBubble(arg_105_0, arg_105_1)
	local var_105_0 = arg_105_0:GetAllUnits()
	local var_105_1 = arg_105_0
	local var_105_2 = arg_105_0.GetSubView

	IslandTopHeadHudView = var_1_10006

	local var_105_3 = var_105_2(var_105_1, var_1_10006)

	var_3.PlayBubble(var_105_3, arg_105_1.name, var_105_0, arg_105_1.callback)

	return
end

function var_0_1.OnRawPlayChatBubble(arg_106_0, arg_106_1)
	local var_106_0 = arg_106_0:GetAllUnits()
	local var_106_1 = arg_106_0
	local var_106_2 = arg_106_0.GetSubView

	IslandTopHeadHudView = var_1_10006

	local var_106_3 = var_106_2(var_106_1, var_1_10006)

	var_3.RawPlayBubble(var_106_3, arg_106_1.info, var_106_0, arg_106_1.callback)

	return
end

function var_0_1.OnRawStopChatBubble(arg_107_0, arg_107_1)
	local var_107_0 = arg_107_0
	local var_107_1 = arg_107_0.GetSubView

	IslandTopHeadHudView = var_1_10005

	local var_107_2 = var_107_1(var_107_0, var_1_10005)

	var_2.RawStopBubble(var_107_2, arg_107_1.info)

	return
end

function var_0_1.OnChangeVisterDress(arg_108_0, arg_108_1)
	local var_108_0 = arg_108_1.id

	if arg_108_0:IsPlayer(var_108_0) then
		return
	end

	if arg_108_0:GetPlayerUnitModule(var_108_0) then
		var_3:OnChangeDress(arg_108_1.changeDressData)
	end

	return
end

function var_0_1.OnSystemUnlock(arg_109_0, arg_109_1)
	IslandAblityAgency = var_1_10002

	if arg_109_1 == var_1_10002.ANIMATION_OP_ID then
		local var_109_0 = arg_109_0
		local var_109_1 = arg_109_0.GetSubView

		IslandOpView = var_1_10005

		local var_109_2 = var_109_1(var_109_0, var_1_10005)

		var_2.UpdateAnimationOpBtn(var_109_2)
	end

	return
end

function var_0_1.OnSceneInited(arg_110_0, arg_110_1)
	IslandCameraMgr = var_1_10002

	local var_110_0 = var_1_10002.instance

	var_2.LookAt(var_110_0, arg_110_0.player._tf)

	IslandCameraMgr = var_2

	local var_110_1 = var_2.instance
	local var_110_2 = var_2.GetVirtualCamera

	IslandConst = var_5

	local var_110_3 = var_110_2(var_110_1, var_5.FOLLOW_CAMERA_NAME).gameObject
	local var_110_4 = var_3.GetComponent

	typeof = var_1_10006
	CameraZoom = var_1_10008

	local var_110_5 = var_110_4(var_110_3, var_1_10006(var_1_10008))

	var_3.SetMaxMinZoom(var_110_5, arg_110_1.min, arg_110_1.max, arg_110_1.value)
	arg_110_0:InitFocusCamera()
	arg_110_0:InitTakePhotoCamera()

	local var_110_6 = arg_110_0
	local var_110_7 = arg_110_0.GetSubView

	IslandOpView = var_7

	local var_110_8 = var_110_7(var_110_6, var_7)

	var_4.LaterInit(var_110_8)

	return
end

function var_0_1.OnGenUnit(arg_111_0, arg_111_1, arg_111_2)
	local var_111_0 = arg_111_0.unitBuilders[arg_111_1:GetType()]
	local var_111_1 = var_3.Build(var_111_0, arg_111_1, arg_111_2)

	arg_111_0:AddUnit(var_111_1)

	if arg_111_1:IsPlayer() then
		arg_111_0.player = var_111_1
	end

	if arg_111_1:IsFirstTakePhoto() then
		arg_111_0.firstTakePhotoItem = var_111_1
	end

	if arg_111_1:IsThirdTakePhoto() then
		arg_111_0.thirdTakePhotoItem = var_111_1
	end

	return
end

function var_0_1.OnGenSystem(arg_112_0, arg_112_1)
	local var_112_0 = arg_112_0.systemBuilders[arg_112_1:GetType()]
	local var_112_1 = var_2.Build(var_112_0, arg_112_1)

	arg_112_0:AddUnit(var_112_1)

	return
end

function var_0_1.IsPlayer(arg_113_0, arg_113_1)
	return arg_113_0.player.id == arg_113_1
end

function var_0_1.OnActiveOrDisactiveUnit(arg_114_0, arg_114_1, arg_114_2, arg_114_3)
	local var_114_0

	if arg_114_1 == 0 then
		var_114_0 = arg_114_0.player
	else
		var_114_0 = arg_114_0:GetUnitModuleWithType(arg_114_2, arg_114_1)
	end

	if var_114_0 and arg_114_3 then
		var_114_0:Enable()
	end

	if var_114_0 and not arg_114_3 then
		var_114_0:Disable()
	end

	return
end

function var_0_1.OnResetUnitPos(arg_115_0, arg_115_1, arg_115_2, arg_115_3)
	if arg_115_0:GetUnitModuleWithType(arg_115_2, arg_115_1) then
		var_4._go.transform.position = arg_115_3
	end

	return
end

function var_0_1.OnResetUnitRotation(arg_116_0, arg_116_1, arg_116_2, arg_116_3)
	if arg_116_0:GetUnitModuleWithType(arg_116_2, arg_116_1) then
		var_4._go.transform.eulerAngles = arg_116_3
	end

	return
end

function var_0_1.OnMoveUnit(arg_117_0, arg_117_1)
	assert = var_1_10002

	var_1_10002(arg_117_1.type, "type should be exist")

	if arg_117_0:GetUnitModuleWithType(arg_117_1.type, arg_117_1.id) then
		var_2:SetDestination(arg_117_1.position, arg_117_1.speed, nil, arg_117_1.charaRadius)
	end

	return
end

function var_0_1.OnStopUnit(arg_118_0, arg_118_1)
	assert = var_1_10002

	var_1_10002(arg_118_1.type, "type should be exist")

	if arg_118_0:GetUnitModuleWithType(arg_118_1.type, arg_118_1.id) then
		var_2:StopMove()
	end

	return
end

function var_0_1.OnRemoveUnit(arg_119_0, arg_119_1, arg_119_2)
	local var_119_0 = arg_119_0
	local var_119_1 = arg_119_0.GetUnitListByKey(var_119_0, arg_119_1)
	local var_119_2 = 0

	ipairs = var_119_0

	for iter_119_0, iter_119_1 in var_119_0(var_119_1 or {}) do
		if iter_119_1.id == arg_119_2 then
			var_119_2 = iter_119_0

			break
		end
	end

	if var_119_2 > 0 then
		local var_119_3 = var_119_1[var_119_2]

		for iter_119_2 = #arg_119_0.pathfinders, 1, -1 do
			local var_119_4 = arg_119_0.pathfinders[iter_119_2]

			if var_10.IsSameUnit(var_119_4, var_119_3) then
				var_10:Dispose()

				table = var_11

				var_11.remove(arg_119_0.pathfinders, iter_119_2)
			end
		end

		arg_119_0:RemoveUnit(var_119_3)
		var_119_3:Dispose()
		arg_119_0:OnHideUnitHudAndOpBtn({
			type = arg_119_1,
			id = var_119_3.id
		}, true)

		local var_119_5 = arg_119_0
		local var_119_6 = arg_119_0.GetSubView

		IslandTopHeadHudView = var_9

		local var_119_7 = var_119_6(var_119_5, var_9)

		var_6.HideHud(var_119_7, {
			type = arg_119_1,
			id = arg_119_2
		})

		local var_119_8 = arg_119_0
		local var_119_9 = arg_119_0.GetSubView

		IslandBottomHeadHudView = var_9

		local var_119_10 = var_119_9(var_119_8, var_9)

		var_6.HideAnimationOp(var_119_10, var_119_3)

		local var_119_11 = arg_119_0
		local var_119_12 = arg_119_0.GetSubView

		IslandInteractionView = var_9

		local var_119_13 = var_119_12(var_119_11, var_9)

		var_6.CloseInterActionPanelByUnitIdRemove(var_119_13, arg_119_2)
	end

	return
end

function var_0_1.GetAllUnits(arg_120_0)
	table = var_1_10001

	var_1_10001.clear(arg_120_0._unitList)

	pairs = var_1

	for iter_120_0, iter_120_1 in var_1(arg_120_0:GetUnitListRegitser()) do
		pairs = var_1_10006

		for iter_120_2, iter_120_3 in var_1_10006(iter_120_1) do
			table = var_1_10011

			var_1_10011.insert(arg_120_0._unitList, iter_120_3)
		end
	end

	return arg_120_0._unitList
end

function var_0_1.GetUnitModuleWithType(arg_121_0, arg_121_1, arg_121_2)
	IslandConst = var_1_10003

	if arg_121_1 == var_1_10003.UNIT_LIST_PLAYER and arg_121_2 == 0 then
		return arg_121_0.player
	end

	local var_121_0 = arg_121_0:GetUnitListByKey(arg_121_1)

	ipairs = var_1_10004

	for iter_121_0, iter_121_1 in var_1_10004(var_121_0) do
		if iter_121_1.id == arg_121_2 then
			return iter_121_1
		end
	end

	return nil
end

function var_0_1.GetPlayerUnitModule(arg_122_0, arg_122_1)
	local var_122_0 = arg_122_0
	local var_122_1 = arg_122_0.GetUnitModuleWithType

	IslandConst = var_1_10005

	return var_122_1(var_122_0, var_1_10005.UNIT_LIST_PLAYER, arg_122_1)
end

function var_0_1.GetUnitModule(arg_123_0, arg_123_1)
	local var_123_0 = arg_123_0
	local var_123_1 = arg_123_0.GetUnitModuleWithType

	IslandConst = var_1_10005

	return var_123_1(var_123_0, var_1_10005.UNIT_LIST_OBJ, arg_123_1)
end

function var_0_1.GetSystemModule(arg_124_0, arg_124_1)
	local var_124_0 = arg_124_0
	local var_124_1 = arg_124_0.GetUnitModuleWithType

	IslandConst = var_1_10005

	return var_124_1(var_124_0, var_1_10005.UNIT_LIST_SYSTEM, arg_124_1)
end

function var_0_1.GetProductSystemModule(arg_125_0, arg_125_1)
	local var_125_0 = arg_125_0
	local var_125_1 = arg_125_0.GetUnitModuleWithType

	IslandConst = var_1_10005

	return var_125_1(var_125_0, var_1_10005.UNIT_LIST_PRODUCT_SYSTEM, arg_125_1)
end

function var_0_1.GetSystemUnitModule(arg_126_0, arg_126_1)
	local var_126_0 = arg_126_0
	local var_126_1 = arg_126_0.GetUnitModuleWithType

	IslandConst = var_1_10005

	return var_126_1(var_126_0, var_1_10005.UNIT_LIST_DELEGATION, arg_126_1)
end

function var_0_1.GetStrollUnitModule(arg_127_0, arg_127_1)
	local var_127_0 = arg_127_0
	local var_127_1 = arg_127_0.GetUnitModuleWithType

	IslandConst = var_1_10005

	return var_127_1(var_127_0, var_1_10005.UNIT_LIST_STROLL, arg_127_1)
end

function var_0_1.GetManageSystemModule(arg_128_0, arg_128_1)
	local var_128_0 = arg_128_0
	local var_128_1 = arg_128_0.GetUnitModuleWithType

	IslandConst = var_1_10005

	return var_128_1(var_128_0, var_1_10005.UNIT_LIST_MANAGE_SYSTEM, arg_128_1)
end

function var_0_1.GetFollowerModule(arg_129_0, arg_129_1)
	local var_129_0 = arg_129_0
	local var_129_1 = arg_129_0.GetUnitModuleWithType

	IslandConst = var_1_10005

	return var_129_1(var_129_0, var_1_10005.UNIT_LIST_FOLLOW, arg_129_1)
end

function var_0_1.OnMovePlayerBefore(arg_130_0)
	local var_130_0 = arg_130_0.player

	if var_1.CheckMovement(var_130_0) and arg_130_0.isLockPlayInput then
		arg_130_0.isLockPlayInput = false
	end

	local var_130_1 = arg_130_0
	local var_130_2 = arg_130_0.GetSubView

	IslandAniamtionOpView = var_1_10005

	local var_130_3 = var_130_2(var_130_1, var_1_10005)

	var_2.OnMovePlayerBefore(var_130_3)

	return
end

function var_0_1.OnLockPlayerInput(arg_131_0)
	if arg_131_0.playerInputing then
		arg_131_0.isLockPlayInput = true

		local var_131_0 = arg_131_0.player

		var_1.StopMoveHandle(var_131_0)
	end

	return
end

function var_0_1.OnPlayerMove(arg_132_0, arg_132_1)
	if arg_132_0.isLockPlayInput then
		return
	end

	arg_132_0.playerInputing = true

	local var_132_0 = arg_132_0.takePhotoModel

	IslandConst = var_1_10003

	if var_132_0 == var_1_10003.TakePhotoModel.First then
		local var_132_1 = arg_132_0.firstTakePhotoItem

		var_2.MoveHandle(var_132_1, arg_132_1.targetDir, arg_132_1.force)
	else
		local var_132_2 = arg_132_0.takePhotoModel

		IslandConst = var_3

		if var_132_2 == var_3.TakePhotoModel.Third then
			local var_132_3 = arg_132_0.thirdTakePhotoItem

			var_2.MoveHandle(var_132_3, arg_132_1.targetDir, arg_132_1.force)
		else
			local var_132_4 = arg_132_0.player

			var_2.MoveHandle(var_132_4, arg_132_1.targetDir, arg_132_1.force)
		end
	end

	return
end

function var_0_1.OnPlayerStopMove(arg_133_0)
	if arg_133_0.isLockPlayInput then
		arg_133_0.isLockPlayInput = false
	end

	arg_133_0.playerInputing = true

	local var_133_0 = arg_133_0.takePhotoModel

	IslandConst = var_1_10002

	if var_133_0 == var_1_10002.TakePhotoModel.First then
		local var_133_1 = arg_133_0.firstTakePhotoItem

		var_1.StopMoveHandle(var_133_1)
	else
		local var_133_2 = arg_133_0.takePhotoModel

		IslandConst = var_2

		if var_133_2 == var_2.TakePhotoModel.Third then
			local var_133_3 = arg_133_0.thirdTakePhotoItem

			var_1.StopMoveHandle(var_133_3)
		else
			local var_133_4 = arg_133_0.player

			var_1.StopMoveHandle(var_133_4)
		end
	end

	return
end

function var_0_1.OnPlayerStopMoveHandle(arg_134_0)
	if arg_134_0.isLockPlayInput then
		arg_134_0.isLockPlayInput = false
	end

	arg_134_0.playerInputing = true

	local var_134_0 = arg_134_0.takePhotoModel

	IslandConst = var_1_10002

	if var_134_0 == var_1_10002.TakePhotoModel.First then
		local var_134_1 = arg_134_0.firstTakePhotoItem

		var_1.StopMoveHandle(var_134_1)
	else
		local var_134_2 = arg_134_0.takePhotoModel

		IslandConst = var_2

		if var_134_2 == var_2.TakePhotoModel.Third then
			local var_134_3 = arg_134_0.thirdTakePhotoItem

			var_1.StopMoveHandle(var_134_3)
		else
			local var_134_4 = arg_134_0.player

			var_1.StopMoveHandleByInput(var_134_4)
		end
	end

	return
end

function var_0_1.OnPlayerJump(arg_135_0)
	local var_135_0 = arg_135_0.takePhotoModel

	IslandConst = var_1_10002

	if var_135_0 ~= var_1_10002.TakePhotoModel.First then
		local var_135_1 = arg_135_0.takePhotoModel

		IslandConst = var_2

		if var_135_1 == var_2.TakePhotoModel.Third then
			return
		end

		local var_135_2 = arg_135_0.player

		var_1.JumpHandle(var_135_2)

		return
	end
end

function var_0_1.OnPlayerPlayerRun(arg_136_0)
	local var_136_0 = arg_136_0.player

	var_1.PlayerRunHandle(var_136_0)

	return
end

function var_0_1.OnPlayerPlayerSprint(arg_137_0)
	local var_137_0 = arg_137_0.takePhotoModel

	IslandConst = var_1_10002

	if var_137_0 == var_1_10002.TakePhotoModel.First then
		local var_137_1 = arg_137_0.firstTakePhotoItem

		var_1.OnPlayerPlayerSprint(var_137_1)
	else
		local var_137_2 = arg_137_0.takePhotoModel

		IslandConst = var_2

		if var_137_2 == var_2.TakePhotoModel.Third then
			-- block empty
		else
			local var_137_3 = arg_137_0.player

			var_1.OnPlayerPlayerSprint(var_137_3)
		end
	end

	return
end

function var_0_1.OnStopPlayerSprint(arg_138_0)
	local var_138_0 = arg_138_0.takePhotoModel

	IslandConst = var_1_10002

	if var_138_0 == var_1_10002.TakePhotoModel.First then
		local var_138_1 = arg_138_0.firstTakePhotoItem

		var_1.OnStopPlayerSprint(var_138_1)
	else
		local var_138_2 = arg_138_0.takePhotoModel

		IslandConst = var_2

		if var_138_2 == var_2.TakePhotoModel.Third then
			local var_138_3 = arg_138_0.thirdTakePhotoItem

			var_1.OnStopPlayerSprint(var_138_3)
		else
			local var_138_4 = arg_138_0.player

			var_1.OnStopPlayerSprint(var_138_4)
		end
	end

	return
end

function var_0_1.OnPlayerWork(arg_139_0, arg_139_1, arg_139_2)
	local var_139_0 = arg_139_0.player

	var_3.WorkHandle(var_139_0, arg_139_1, arg_139_2)

	return
end

function var_0_1.OnPlayerDeviceStateChange(arg_140_0, arg_140_1)
	local var_140_0 = arg_140_0.player

	var_2.DeviceStateHandle(var_140_0, arg_140_1)

	return
end

function var_0_1.OnSetVisitorSyncData(arg_141_0, arg_141_1, arg_141_2)
	if arg_141_0:GetPlayerUnitModule(arg_141_1) then
		var_3:UpdateSyncData(arg_141_2)
	end

	return
end

function var_0_1.OnWorldObjectStartInteraction(arg_142_0, arg_142_1, arg_142_2, arg_142_3)
	local var_142_0 = arg_142_2:GetHostId()
	local var_142_1 = arg_142_2:GetUserId()
	local var_142_2 = arg_142_0:GetUnitModule(var_142_0)
	local var_142_3 = arg_142_0:GetPlayerUnitModule(var_142_1)

	if arg_142_0.player == var_142_3 then
		local var_142_4 = arg_142_0
		local var_142_5 = arg_142_0.GetSubView

		IslandOpView = var_1_10012

		local var_142_6 = var_142_5(var_142_4, var_1_10012)

		var_9.StartInteraction(var_142_6)
	end

	local var_142_7 = arg_142_1:GetTimeline()[arg_142_3]
	local var_142_8 = arg_142_1:GetBlackboardParam()[arg_142_3]

	var_142_2:StartInteract(var_142_3, arg_142_2.id, arg_142_3, var_142_7, var_142_8, arg_142_1:AnySlotUsing(), var_8)

	return
end

function var_0_1.OnWorldObjectEndInteraction(arg_143_0, arg_143_1, arg_143_2)
	local var_143_0 = arg_143_2:GetHostId()
	local var_143_1 = arg_143_2:GetUserId()
	local var_143_2 = arg_143_0:GetUnitModule(var_143_0)
	local var_143_3 = arg_143_0:GetPlayerUnitModule(var_143_1)

	if arg_143_0.player == var_143_3 then
		local var_143_4 = arg_143_0
		local var_143_5 = arg_143_0.GetSubView

		IslandOpView = var_1_10011

		local var_143_6 = var_143_5(var_143_4, var_1_10011)

		var_8.EndInteraction(var_143_6)
	end

	var_143_2:EndInteract(var_143_3, arg_143_2.id, not arg_143_1:AnySlotUsing(), var_7)

	return
end

function var_0_1.OnWorldObjectInitStatus(arg_144_0, arg_144_1, arg_144_2)
	local var_144_0 = arg_144_0:GetUnitModule(arg_144_1.id)
	local var_144_1 = arg_144_1:GetTimeline()[arg_144_2]
	local var_144_2 = arg_144_1:GetBlackboardParam()[arg_144_2]

	var_144_0:InitStatus(arg_144_2, var_144_1, var_144_2)

	return
end

function var_0_1.InitInteractionOpView(arg_145_0)
	local var_145_0 = arg_145_0
	local var_145_1 = arg_145_0.GetSubView

	IslandOpView = var_1_10004

	local var_145_2 = var_145_1(var_145_0, var_1_10004)

	var_1.EndInteraction(var_145_2)

	return
end

function var_0_1.OnPlayerAreaChange(arg_146_0)
	local var_146_0 = arg_146_0.detectionSystem

	var_1.SetAreaDetection(var_146_0)

	return
end

function var_0_1.OnChangeDress(arg_147_0, arg_147_1, arg_147_2)
	local var_147_0 = arg_147_0.player

	var_3.OnChangeDress(var_147_0, arg_147_1, arg_147_2)

	return
end

function var_0_1.OnCharacterChangeDress(arg_148_0, arg_148_1, arg_148_2, arg_148_3, arg_148_4)
	local var_148_0 = arg_148_0
	local var_148_1 = arg_148_0.GetUnitModuleWithType

	IslandConst = var_1_10008

	if var_148_1(var_148_0, var_1_10008.UNIT_LIST_DELEGATION, arg_148_1) then
		var_5:OnCharacterChangeDress(arg_148_2, arg_148_3, arg_148_4)
	end

	local var_148_2 = arg_148_0
	local var_148_3 = arg_148_0.GetUnitListByKey

	IslandConst = var_9

	local var_148_4 = var_148_3(var_148_2, var_9.UNIT_LIST_FOLLOW)

	ipairs = var_148_0

	for iter_148_0, iter_148_1 in var_148_0(var_148_4) do
		local var_148_5 = iter_148_1:GetDataVO()

		if var_12.IsSameShip(var_148_5, arg_148_1) then
			iter_148_1:OnCharacterChangeDress(arg_148_2, arg_148_3, arg_148_4)
		end
	end

	local var_148_6 = arg_148_0
	local var_148_7 = arg_148_0.GetUnitListByKey

	IslandConst = iter_148_0

	local var_148_8 = var_148_7(var_148_6, iter_148_0.UNIT_LIST_STROLL)

	ipairs = var_8

	for iter_148_2, iter_148_3 in var_8(var_148_8) do
		local var_148_9 = iter_148_3:GetDataVO()

		if var_13.IsSameShip(var_148_9, arg_148_1) then
			iter_148_3:OnCharacterChangeDress(arg_148_2, arg_148_3, arg_148_4)
		end
	end

	return
end

function var_0_1.OnMorphFormChange(arg_149_0, arg_149_1, arg_149_2, arg_149_3, arg_149_4, arg_149_5)
	local var_149_0 = arg_149_0

	if not arg_149_0.GetPlayerUnitModule(var_149_0, arg_149_0.player.id) then
		existCall = var_1_10007

		var_1_10007(arg_149_5)

		return
	end

	if not var_6.shipDressHelper then
		existCall = var_149_0

		var_149_0(arg_149_5)

		return
	end

	var_6:PlayAnimation(arg_149_4, 0.25, function()
		local var_150_0 = var_0
		local var_150_1 = var_0.ChangeDressByType

		IslandShipDressHelperNew = var_2_10003

		var_150_1(var_150_0, var_2_10003.DressType.Body, {
			colorId = 0,
			id = arg_149_2
		})

		local var_150_2 = var_0
		local var_150_3 = var_0.ChangeDressByType

		IslandShipDressHelperNew = var_3

		var_150_3(var_150_2, var_3.DressType.Hat, {
			colorId = 0,
			id = arg_149_3
		})

		existCall = var_150_3

		var_150_3(arg_149_5)

		return
	end)

	return
end

function var_0_1.OnStartDelegation(arg_151_0, arg_151_1, arg_151_2)
	if arg_151_0:GetSystemModule(arg_151_1.build_id) then
		var_3:StartDelegation(arg_151_1)
	end

	if arg_151_0:GetProductSystemModule(arg_151_1.build_id) then
		var_4:StartDelegation(arg_151_2)
	end

	return
end

function var_0_1.OnEndDelegation(arg_152_0, arg_152_1, arg_152_2)
	if arg_152_0:GetSystemModule(arg_152_1.build_id) then
		var_3:EndDelegation(arg_152_1)
	end

	return
end

function var_0_1.GetPlayerPosition(arg_153_0)
	local var_153_0 = arg_153_0.player

	return var_1.GetCurrentPosition(var_153_0)
end

function var_0_1.GetPlayerLastGroundedPosition(arg_154_0)
	local var_154_0 = arg_154_0.player

	return var_1.LastGroundedPosition(var_154_0)
end

function var_0_1.GetUnitPosition(arg_155_0, arg_155_1)
	return arg_155_0:GetUnitModule(arg_155_1) and var_2._go.transform.position
end

function var_0_1.OnShowUnitHudAndOpBtn(arg_156_0, arg_156_1)
	arg_156_0.currentHudUnitData = arg_156_1

	local var_156_0 = arg_156_0
	local var_156_1 = arg_156_0.GetSubView

	IslandSlotHudView = var_1_10005

	local var_156_2 = var_156_1(var_156_0, var_1_10005)

	var_2.ShowHud(var_156_2, arg_156_1.id, arg_156_1.height)

	local var_156_3 = arg_156_0
	local var_156_4 = arg_156_0.GetSubView

	IslandOpView = var_5

	local var_156_5 = var_156_4(var_156_3, var_5)

	var_2.UpdateOperationButton(var_156_5, arg_156_1.operationType, arg_156_1.id)

	if arg_156_1.isHighLightControl then
		local var_156_6 = arg_156_0.detectionSystem

		var_2.HighLightUnitHandle(var_156_6, arg_156_1.id, true)
	end

	return
end

function var_0_1.OnHideUnitHudAndOpBtn(arg_157_0, arg_157_1, arg_157_2)
	if not arg_157_0.currentHudUnitData then
		return
	end

	if arg_157_0.currentHudUnitData.id ~= arg_157_1.id or arg_157_0.currentHudUnitData.type ~= arg_157_1.type then
		return
	end

	if not arg_157_2 then
		arg_157_0.currentHudUnitData = nil
	end

	local var_157_0 = arg_157_0
	local var_157_1 = arg_157_0.GetSubView

	IslandSlotHudView = var_1_10006

	local var_157_2 = var_157_1(var_157_0, var_1_10006)

	var_3.HideUnitHud(var_157_2, arg_157_1.id)

	local var_157_3 = arg_157_0
	local var_157_4 = arg_157_0.GetSubView

	IslandOpView = var_6

	local var_157_5 = var_157_4(var_157_3, var_6)
	local var_157_6 = var_3.UpdateOperationButton

	IslandOpView = var_6

	var_157_6(var_157_5, var_6.OperationType.None, arg_157_1.id)

	if arg_157_1.isHighLightControl then
		local var_157_7 = arg_157_0.detectionSystem

		var_3.HighLightUnitHandle(var_157_7, arg_157_1.id, false)
	end

	return
end

function var_0_1.OnUpdateHud(arg_158_0, arg_158_1)
	if not arg_158_0.currentHudUnitData then
		return
	end

	if arg_158_1 ~= arg_158_0.currentHudUnitData.id then
		return
	end

	local var_158_0 = arg_158_0
	local var_158_1 = arg_158_0.GetSubView

	IslandSlotHudView = var_1_10005

	local var_158_2 = var_158_1(var_158_0, var_1_10005)

	var_2.UpdateHud(var_158_2, arg_158_0.currentHudUnitData.id, arg_158_0.currentHudUnitData.height)

	local var_158_3 = arg_158_0
	local var_158_4 = arg_158_0.GetSubView

	IslandOpView = var_5

	local var_158_5 = var_158_4(var_158_3, var_5)

	var_2.UpdateOperationButton(var_158_5, arg_158_0.currentHudUnitData.operationType, arg_158_0.currentHudUnitData.id)

	return
end

function var_0_1.OnUpdateHandCollectUnit(arg_159_0, arg_159_1)
	local var_159_0 = arg_159_0
	local var_159_1 = arg_159_0.GetUnitModuleWithType

	IslandConst = var_1_10005

	if var_159_1(var_159_0, var_1_10005.UNIT_LIST_OBJ, arg_159_1) then
		var_2:UpdateHandCollet()
		var_2:ResetHp()
	end

	return
end

function var_0_1.OnShowHud(arg_160_0, arg_160_1)
	local var_160_0 = arg_160_0
	local var_160_1 = arg_160_0.GetSubView

	IslandTopHeadHudView = var_1_10005

	local var_160_2 = var_160_1(var_160_0, var_1_10005)

	var_2.ShowHud(var_160_2, arg_160_1)

	local var_160_3 = arg_160_0
	local var_160_4 = arg_160_0.GetSubView

	IslandDistanceView = var_5

	local var_160_5 = var_160_4(var_160_3, var_5)

	var_2.ShowHud(var_160_5, arg_160_1.id)

	return
end

function var_0_1.OnRefreshHud(arg_161_0, arg_161_1)
	local var_161_0 = arg_161_0
	local var_161_1 = arg_161_0.GetSubView

	IslandTopHeadHudView = var_1_10005

	local var_161_2 = var_161_1(var_161_0, var_1_10005)

	var_2.RefreshHud(var_161_2, arg_161_1)

	return
end

function var_0_1.OnHideHud(arg_162_0, arg_162_1)
	local var_162_0 = arg_162_0
	local var_162_1 = arg_162_0.GetSubView

	IslandTopHeadHudView = var_1_10005

	local var_162_2 = var_162_1(var_162_0, var_1_10005)

	var_2.HideHud(var_162_2, arg_162_1)

	local var_162_3 = arg_162_0
	local var_162_4 = arg_162_0.GetSubView

	IslandDistanceView = var_5

	local var_162_5 = var_162_4(var_162_3, var_5)

	var_2.HideHud(var_162_5, arg_162_1.id)

	return
end

function var_0_1.OnDelegateSlotStartPerform(arg_163_0, arg_163_1)
	if arg_163_0:GetUnitModuleWithType(arg_163_1.type, arg_163_1.id) then
		var_2:DelegateSlotStartPerform()
	end

	return
end

function var_0_1.OnPlayEffect(arg_164_0, arg_164_1, arg_164_2, arg_164_3)
	local var_164_0
	local var_164_1 = arg_164_0
	local var_164_2 = arg_164_0.GetUnitListByKey

	IslandConst = var_1_10008

	local var_164_3 = var_164_2(var_164_1, var_1_10008.UNIT_LIST_STROLL)

	ipairs = var_1_10006

	for iter_164_0, iter_164_1 in var_1_10006(var_164_3) do
		local var_164_4 = iter_164_1:GetDataVO()

		if var_11.IsSameShip(var_164_4, arg_164_1) then
			var_164_0 = iter_164_1

			break
		end
	end

	local var_164_5 = arg_164_0
	local var_164_6 = arg_164_0.GetSubView

	IslandEffectView = iter_164_0

	if var_164_6(var_164_5, iter_164_0) and var_164_0 then
		var_6:Play(var_164_0, arg_164_2, arg_164_3)
	end

	return
end

function var_0_1.OnRecycleAllSlotEffct(arg_165_0)
	local var_165_0 = arg_165_0.effectMgr

	var_1.RecycleAllSlotEffct(var_165_0)

	return
end

function var_0_1.OnLoadDelegatePreviewRole(arg_166_0, arg_166_1, arg_166_2)
	local var_166_0 = arg_166_0.effectMgr

	var_3.LoadDelegatePreviewRole(var_166_0, arg_166_1, arg_166_2)

	return
end

function var_0_1.OnUnLoadDelegatePreviewRole(arg_167_0)
	local var_167_0 = arg_167_0.effectMgr

	var_1.UnLoadDelegatePreviewRole(var_167_0)

	return
end

function var_0_1.OnSelectSlotEffectShow(arg_168_0, arg_168_1, arg_168_2, arg_168_3, arg_168_4)
	local var_168_0 = arg_168_0.effectMgr

	var_5.SelectSlotEffectShow(var_168_0, arg_168_1, arg_168_2, arg_168_3, arg_168_4)

	return
end

function var_0_1.OnTakePlantAttack(arg_169_0, arg_169_1)
	if arg_169_0:GetUnitModuleWithType(arg_169_1.type, arg_169_1.id) then
		var_2:TakeAttack()
	end

	return
end

function var_0_1.OnStartManage(arg_170_0, arg_170_1)
	if arg_170_0:GetManageSystemModule(arg_170_1.id) then
		var_2:StartManage(arg_170_1)
	end

	return
end

function var_0_1.OnEndManage(arg_171_0, arg_171_1)
	if arg_171_0:GetManageSystemModule(arg_171_1.id) then
		var_2:EndManage(arg_171_1)
	end

	return
end

function var_0_1.OnRefreshTaskInfoHud(arg_172_0)
	local var_172_0 = arg_172_0
	local var_172_1 = arg_172_0.GetSubView

	IslandTopHeadHudView = var_1_10004

	local var_172_2 = var_172_1(var_172_0, var_1_10004)

	var_1.UpdateAllHud(var_172_2)

	return
end

function var_0_1.OnRefreshWeatherSystem(arg_173_0)
	local var_173_0 = arg_173_0.weatherSystem

	var_1.Play(var_173_0)

	return
end

function var_0_1.OnDispose(arg_174_0)
	local var_174_0 = arg_174_0.detectionSystem

	var_1.Dispose(var_174_0)

	local var_174_1 = arg_174_0.effectMgr

	var_1.Dispose(var_174_1)

	local var_174_2 = arg_174_0.coupleActionPlayer

	var_1.Dispose(var_174_2)

	local var_174_3 = arg_174_0.coupleAction4FollowerPlayer

	var_1.Dispose(var_174_3)

	local var_174_4 = arg_174_0.npcActionPlayer

	var_1.Dispose(var_174_4)

	local var_174_5 = arg_174_0.weatherSystem

	var_1.Dispose(var_174_5)

	local var_174_6 = arg_174_0.coupleNpcWordPlayer

	var_1.Dispose(var_174_6)

	local var_174_7 = arg_174_0:GetPoolMgr()

	var_1.ClearFishingEffect(var_174_7)

	ipairs = var_1

	for iter_174_0, iter_174_1 in var_1(arg_174_0.views) do
		iter_174_1:Dispose()
	end

	ipairs = var_1

	for iter_174_2, iter_174_3 in var_1(arg_174_0.pathfinders) do
		iter_174_3:Dispose()
	end

	ipairs = var_1

	for iter_174_4, iter_174_5 in var_1(arg_174_0:GetAllUnits()) do
		iter_174_5:Dispose()
	end

	pairs = var_1

	for iter_174_6, iter_174_7 in var_1(arg_174_0.unitBuilders) do
		iter_174_7:Dispose()
	end

	pairs = var_1

	for iter_174_8, iter_174_9 in var_1(arg_174_0.systemBuilders) do
		iter_174_9:Dispose()
	end

	pairs = var_1

	for iter_174_10, iter_174_11 in var_1(arg_174_0.fishingSynPlayers) do
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

return var_0_1
