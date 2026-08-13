class = var_0_10000

local var_0_0 = var_0_10000("IslandPoolMgr")
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4
local var_0_5 = 5
local var_0_6 = 6
local var_0_7 = 7
local var_0_8 = 8
local var_0_9 = 9
local var_0_10 = 10
local var_0_11 = 11
local var_0_12 = 12
local var_0_13 = 13
local var_0_14 = 14
local var_0_15 = 15
local var_0_16 = 16

function var_0_0.Ctor(arg_1_0, arg_1_1)
	local var_1_0 = {}
	local var_1_1 = var_0_1

	IslandObjectPoolSet = var_1_10004
	var_1_0[var_1_1] = var_1_10004.New(arg_1_1, 3, 2)

	local var_1_2 = var_0_3

	IslandObjectPoolSet = var_4
	var_1_0[var_1_2] = var_4.New(arg_1_1, 8, 2)

	local var_1_3 = var_0_6

	IslandObjectPoolSet = var_4
	var_1_0[var_1_3] = var_4.New(arg_1_1, 3, 5)

	local var_1_4 = var_0_7

	IslandObjectPoolSet = var_4
	var_1_0[var_1_4] = var_4.New(arg_1_1, 3, 5)

	local var_1_5 = var_0_8

	IslandObjectPoolSet = var_4
	var_1_0[var_1_5] = var_4.New(arg_1_1, 10, 3)

	local var_1_6 = var_0_9

	IslandRootTplPool = var_4
	var_1_0[var_1_6] = var_4.New(arg_1_1, "ui/agorafurnituretpl", 1, 20)

	local var_1_7 = var_0_10

	IslandObjectPoolSet = var_4
	var_1_0[var_1_7] = var_4.New(arg_1_1, 2, 6)

	local var_1_8 = var_0_11

	IslandUITplPoolSet = var_4
	var_1_0[var_1_8] = var_4.New(arg_1_1, "ui/IslandOpUI", 1, 1, false)

	local var_1_9 = var_0_12

	IslandObjectPoolSet = var_4
	var_1_0[var_1_9] = var_4.New(arg_1_1, 1, 1)

	local var_1_10 = var_0_13

	IslandObjectPoolSet = var_4
	var_1_0[var_1_10] = var_4.New(arg_1_1, 3, 1)

	local var_1_11 = var_0_14

	IslandObjectPoolSet = var_4
	var_1_0[var_1_11] = var_4.New(arg_1_1, 3, 1)

	local var_1_12 = var_0_15

	IslandObjectPoolSet = var_4
	var_1_0[var_1_12] = var_4.New(arg_1_1, 4, 1)

	local var_1_13 = var_0_16

	IslandObjectPoolSet = var_4
	var_1_0[var_1_13] = var_4.New(arg_1_1, 6, 2)

	local var_1_14 = var_0_2

	IslandPublicAssetPoolSet = var_4
	var_1_0[var_1_14] = var_4.New(arg_1_1, 5, 2)

	local var_1_15 = var_0_4

	IslandPublicAssetPoolSet = var_4
	var_1_0[var_1_15] = var_4.New(arg_1_1, 5, 2)

	local var_1_16 = var_0_5

	IslandBtAssetPoolSet = var_4
	var_1_0[var_1_16] = var_4.New(arg_1_1, 5, 2)
	arg_1_0.pools = var_1_0
	arg_1_0.loadingIdList = {}

	return
end

function var_0_0.Init(arg_2_0, arg_2_1)
	local var_2_0 = {}

	pairs = var_1_10003

	for iter_2_0, iter_2_1 in var_1_10003(arg_2_0.pools) do
		table = var_1_10008

		var_1_10008.insert(var_2_0, function(arg_3_0)
			local var_3_0 = iter_2_1

			var_1.Init(var_3_0, arg_3_0)

			return
		end)
	end

	parallelAsync = var_3

	var_3(var_2_0, arg_2_1)

	return
end

function var_0_0.GetPool(arg_4_0, arg_4_1)
	assert = var_1_10002

	var_1_10002(arg_4_0.pools[arg_4_1], "pool is nil >>>" .. arg_4_1)

	return arg_4_0.pools[arg_4_1]
end

local function var_0_17(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = {}
	local var_5_1
	local var_5_2

	table = var_1_10008

	var_1_10008.insert(var_5_0, function(arg_6_0)
		local var_6_0 = arg_5_0
		local var_6_1 = var_1.GetObject
		local var_6_2 = arg_5_2

		typeof = var_2_10005
		GameObject = var_2_10007

		var_6_1(var_6_0, var_6_2, var_2_10005(var_2_10007), function(arg_7_0)
			var_5_1 = arg_7_0

			arg_6_0()

			return
		end)

		return
	end)

	table = var_8

	var_8.insert(var_5_0, function(arg_8_0)
		local var_8_0 = arg_5_1
		local var_8_1 = var_1.GetObject
		local var_8_2 = arg_5_3

		typeof = var_2_10005
		RuntimeAnimatorController = var_2_10007

		var_8_1(var_8_0, var_8_2, var_2_10005(var_2_10007), function(arg_9_0)
			var_5_2 = arg_9_0

			arg_8_0()

			return
		end)

		return
	end)

	seriesAsync = var_8

	var_8(var_5_0, function()
		GetOrAddComponent = var_2_10000

		local var_10_0 = var_5_1.transform

		typeof = var_2_10003
		Animator = var_2_10005
		var_2_10000(var_10_0, var_2_10003(var_2_10005)).runtimeAnimatorController = var_5_2

		arg_5_4(var_5_1)

		return
	end)

	return
end

local function var_0_18(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	GetOrAddComponent = var_1_10005

	local var_11_0 = arg_11_4

	typeof = var_1_10008
	Animator = var_1_10010

	local var_11_1 = var_1_10005(var_11_0, var_1_10008(var_1_10010)).runtimeAnimatorController

	arg_11_1:ReturnObject(arg_11_3, var_11_1)

	var_5.runtimeAnimatorController = nil

	arg_11_0:ReturnObject(arg_11_2, arg_11_4)

	return
end

local function var_0_19(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = {}

	table = var_1_10006

	var_1_10006.insert(var_12_0, function(arg_13_0)
		var_0_17(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_13_0)

		return
	end)

	seriesAsync = var_6

	var_6(var_12_0, function(arg_14_0)
		GameObject = var_2_10001

		local var_14_0 = var_2_10001.New(arg_14_0.name)

		setParent = var_2_10002

		var_2_10002(arg_14_0, var_14_0.transform, false)
		arg_12_4(var_14_0)

		return
	end)

	return
end

local function var_0_20(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_0 = arg_15_4.transform
	local var_15_1 = var_5.GetChild(var_15_0, 0).gameObject

	var_0_18(arg_15_0, arg_15_1, arg_15_2, arg_15_3, var_15_1)

	Object = var_6

	var_6.Destroy(arg_15_4)

	return
end

function var_0_0.GetCharacter(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_0:GetPool(var_0_1)
	local var_16_1 = arg_16_0:GetPool(var_0_2)

	var_0_19(var_16_0, var_16_1, arg_16_1, arg_16_2, arg_16_3)

	return
end

function var_0_0.ReturnCharacter(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if not arg_17_0.pools then
		return
	end

	local var_17_0 = arg_17_0:GetPool(var_0_1)
	local var_17_1 = arg_17_0:GetPool(var_0_2)

	var_0_20(var_17_0, var_17_1, arg_17_1, arg_17_2, arg_17_3)

	return
end

function var_0_0.GetCharacterModel(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_0:GetPool(var_0_1)
	local var_18_1 = arg_18_0:GetPool(var_0_2)

	var_0_17(var_18_0, var_18_1, arg_18_1, arg_18_2, arg_18_3)

	return
end

function var_0_0.ReturnCharacterModel(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = arg_19_0:GetPool(var_0_1)
	local var_19_1 = arg_19_0:GetPool(var_0_2)

	var_0_18(var_19_0, var_19_1, arg_19_1, arg_19_2, arg_19_3)

	return
end

function var_0_0.GetSceneCharacter(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	local var_20_0 = arg_20_0:GetPool(var_0_5)
	local var_20_1 = {}
	local var_20_2

	table = var_8

	var_8.insert(var_20_1, function(arg_21_0)
		local var_21_0 = arg_20_0

		var_1.GetCharacter(var_21_0, arg_20_1, arg_20_2, function(arg_22_0)
			var_20_2 = arg_22_0

			arg_21_0()

			return
		end)

		return
	end)

	if arg_20_3 and arg_20_3 ~= "" then
		table = var_8

		var_8.insert(var_20_1, function(arg_23_0)
			local var_23_0 = var_20_0
			local var_23_1 = var_1.GetObject
			local var_23_2 = arg_20_3

			typeof = var_2_10005
			NodeCanvas = var_2_10007

			var_23_1(var_23_0, var_23_2, var_2_10005(var_2_10007.BehaviourTrees.BehaviourTree), function(arg_24_0)
				GetOrAddComponent = var_3_10001

				local var_24_0 = var_20_2

				typeof = var_3_10004
				NodeCanvas = var_3_10006
				var_3_10001(var_24_0, var_3_10004(var_3_10006.BehaviourTrees.BehaviourTreeOwner)).graph = arg_24_0

				arg_23_0()

				return
			end)

			return
		end)
	end

	seriesAsync = var_8

	var_8(var_20_1, function()
		arg_20_4(var_20_2)

		return
	end)

	return
end

function var_0_0.ReturnSceneCharacter(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	local var_26_0 = arg_26_0:GetPool(var_0_5)

	if arg_26_3 and arg_26_3 ~= "" then
		GetOrAddComponent = var_1_10006

		local var_26_1 = arg_26_4

		typeof = var_1_10009
		NodeCanvas = var_1_10011

		local var_26_2 = var_1_10006(var_26_1, var_1_10009(var_1_10011.BehaviourTrees.BehaviourTreeOwner)).graph

		var_26_0:ReturnObject(arg_26_3, var_26_2)

		var_6.graph = nil
	end

	arg_26_0:ReturnCharacter(arg_26_1, arg_26_2, arg_26_4)

	return
end

function var_0_0.GetSceneDelegateItem(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	local var_27_0 = arg_27_0:GetPool(var_0_16)
	local var_27_1 = arg_27_0:GetPool(var_0_2)
	local var_27_2 = {}
	local var_27_3

	table = var_9

	var_9.insert(var_27_2, function(arg_28_0)
		local var_28_0 = var_27_0
		local var_28_1 = var_1.GetObject
		local var_28_2 = arg_27_1

		typeof = var_2_10005
		GameObject = var_2_10007

		var_28_1(var_28_0, var_28_2, var_2_10005(var_2_10007), function(arg_29_0)
			var_27_3 = arg_29_0

			arg_28_0()

			return
		end)

		return
	end)

	table = var_9

	var_9.insert(var_27_2, function(arg_30_0)
		local var_30_0 = var_27_1
		local var_30_1 = var_1.GetObject
		local var_30_2 = arg_27_2

		typeof = var_2_10005
		RuntimeAnimatorController = var_2_10007

		var_30_1(var_30_0, var_30_2, var_2_10005(var_2_10007), function(arg_31_0)
			GetOrAddComponent = var_3_10001

			local var_31_0 = var_27_3

			typeof = var_3_10004
			Animator = var_3_10006
			var_3_10001(var_31_0, var_3_10004(var_3_10006)).runtimeAnimatorController = arg_31_0

			arg_30_0()

			return
		end)

		return
	end)

	table = var_9

	var_9.insert(var_27_2, function(arg_32_0)
		local var_32_0 = arg_27_0

		var_27_3 = var_1.NestModel(var_32_0, var_27_3)

		arg_32_0()

		return
	end)

	if arg_27_3 and arg_27_3 ~= "" then
		table = var_9

		var_9.insert(var_27_2, function(arg_33_0)
			local var_33_0 = arg_27_0
			local var_33_1 = var_1.GetPool(var_33_0, var_0_5)
			local var_33_2 = var_1.GetObject
			local var_33_3 = arg_27_3

			typeof = var_2_10006
			NodeCanvas = var_2_10008

			var_33_2(var_33_1, var_33_3, var_2_10006(var_2_10008.BehaviourTrees.BehaviourTree), function(arg_34_0)
				GetOrAddComponent = var_3_10001

				local var_34_0 = var_27_3

				typeof = var_3_10004
				NodeCanvas = var_3_10006
				var_3_10001(var_34_0, var_3_10004(var_3_10006.BehaviourTrees.BehaviourTreeOwner)).graph = arg_34_0

				arg_33_0()

				return
			end)

			return
		end)
	end

	seriesAsync = var_9

	var_9(var_27_2, function()
		arg_27_4(var_27_3)

		return
	end)

	return
end

function var_0_0.ReturnSceneDelegateItem(arg_36_0, arg_36_1, arg_36_2, arg_36_3, arg_36_4)
	local var_36_0 = arg_36_0:GetPool(var_0_16)
	local var_36_1 = arg_36_0
	local var_36_2 = arg_36_0.GetPool(var_36_1, var_0_2)
	local var_36_3 = arg_36_4.transform
	local var_36_4 = var_7.GetChild(var_36_3, 0).gameObject

	GetOrAddComponent = var_36_1

	local var_36_5 = arg_36_4

	typeof = var_1_10011
	Animator = var_1_10013

	local var_36_6 = var_36_1(var_36_5, var_1_10011(var_1_10013)).runtimeAnimatorController

	var_36_2:ReturnObject(arg_36_2, var_36_6)

	var_8.runtimeAnimatorController = nil

	local var_36_7 = var_36_0
	local var_36_8 = var_36_0.ReturnObject

	path = var_13

	var_36_8(var_36_7, var_13, var_36_4)

	Object = var_36_8

	var_36_8.Destroy(arg_36_4)

	return
end

function var_0_0.ClearSceneDelegateItem(arg_37_0, arg_37_1, arg_37_2)
	return
end

function var_0_0.GetSceneProductItem(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = arg_38_0:GetPool(var_0_6)
	local var_38_1 = var_3.GetObject
	local var_38_2 = arg_38_1

	typeof = var_1_10008
	GameObject = var_1_10010

	var_38_1(var_38_0, var_38_2, var_1_10008(var_1_10010), arg_38_2)

	return
end

function var_0_0.ReturnSceneProductItem(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = arg_39_0:GetPool(var_0_6)

	var_3.ReturnObject(var_39_0, arg_39_1, arg_39_2)

	return
end

function var_0_0.ClearSceneProductItem(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = arg_40_0:GetPool(var_0_6)

	var_3.Clear(var_40_0)

	return
end

function var_0_0.GetSceneProductEffect(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = arg_41_0:GetPool(var_0_7)
	local var_41_1 = var_3.GetObject
	local var_41_2 = arg_41_1

	typeof = var_1_10008
	GameObject = var_1_10010

	var_41_1(var_41_0, var_41_2, var_1_10008(var_1_10010), arg_41_2)

	return
end

function var_0_0.ReturnSceneProductEffect(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = arg_42_0:GetPool(var_0_7)

	var_3.ReturnObject(var_42_0, arg_42_1, arg_42_2)

	return
end

function var_0_0.ClearSceneProductEffect(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = arg_43_0:GetPool(var_0_7)

	var_3.Clear(var_43_0)

	return
end

function var_0_0.GetAgoraObj(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = arg_44_0:GetPool(var_0_8)
	local var_44_1 = var_3.GetObject
	local var_44_2 = arg_44_1

	typeof = var_1_10008
	GameObject = var_1_10010

	var_44_1(var_44_0, var_44_2, var_1_10008(var_1_10010), arg_44_2)

	return
end

function var_0_0.ReturnAgoraObj(arg_45_0, arg_45_1, arg_45_2)
	local var_45_0 = arg_45_0:GetPool(var_0_8)

	var_3.ReturnObject(var_45_0, arg_45_1, arg_45_2)

	return
end

function var_0_0.GetAgoraRoot(arg_46_0)
	local var_46_0 = arg_46_0:GetPool(var_0_9)

	return var_1.GetObject(var_46_0)
end

function var_0_0.ReturnAgoraRoot(arg_47_0, arg_47_1)
	local var_47_0 = arg_47_0:GetPool(var_0_9)

	var_2.ReturnObject(var_47_0, arg_47_1)

	return
end

function var_0_0.ClearAograPools(arg_48_0)
	local var_48_0 = arg_48_0:GetPool(var_0_8)

	var_1.Clear(var_48_0)

	local var_48_1 = arg_48_0:GetPool(var_0_9)

	var_2.Clear(var_48_1)

	return
end

function var_0_0.GetOpUI(arg_49_0)
	local var_49_0 = arg_49_0:GetPool(var_0_11)

	return var_1.GetObject(var_49_0)
end

function var_0_0.ReturnOpUI(arg_50_0, arg_50_1)
	local var_50_0 = arg_50_0:GetPool(var_0_11)

	var_2.ReturnObject(var_50_0, arg_50_1)

	return
end

function var_0_0.BuildPreviewPart(arg_51_0, arg_51_1, arg_51_2, arg_51_3, arg_51_4)
	local var_51_0 = {}

	table = var_1_10006

	var_1_10006.insert(var_51_0, function(arg_52_0)
		local function var_52_0(arg_53_0)
			local var_53_0

			if not arg_51_2[arg_53_0] then
				var_53_0 = 0
			end

			return var_53_0
		end

		local function var_52_1(arg_54_0)
			local var_54_0

			if not arg_51_3[arg_54_0] then
				var_54_0 = 0
			end

			return var_54_0
		end

		IslandShipDressHelperNew = var_2_10003

		var_2_10003.BuildCommanderCustomParts(arg_51_1, var_52_0, var_52_1, arg_52_0)

		return
	end)

	seriesAsync = var_6

	var_6(var_51_0, arg_51_4)

	return
end

function var_0_0.BuildCommanderPart(arg_55_0, arg_55_1, arg_55_2)
	local var_55_0 = {}

	table = var_1_10004

	var_1_10004.insert(var_55_0, function(arg_56_0)
		getProxy = var_2_10001
		IslandProxy = var_2_10003

		local var_56_0 = var_2_10001(var_2_10003)
		local var_56_1 = var_1.GetIsland(var_56_0)
		local var_56_2 = var_1.GetDressUpAgency(var_56_1)
		local var_56_3 = var_2.IsNew(var_56_2)

		local function var_56_4(arg_57_0)
			if var_56_3 then
				IslandShipDressHelperNew = var_1

				local var_57_1

				if not var_1.GetInitDressByType(arg_57_0) then
					local var_57_0 = var_0

					var_57_1 = var_1.GetDressByType(var_57_0, arg_57_0)
				end

				return var_57_1
			end
		end

		local function var_56_5(arg_58_0)
			local var_58_0 = var_0

			return var_1.GetCurrentColorByDressId(var_58_0, arg_58_0)
		end

		IslandShipDressHelperNew = var_2_10006

		var_2_10006.BuildCommanderCustomParts(arg_55_1, var_56_4, var_56_5, arg_56_0)

		return
	end)

	seriesAsync = var_4

	var_4(var_55_0, arg_55_2)

	return
end

function var_0_0.BuildVisterPart(arg_59_0, arg_59_1, arg_59_2, arg_59_3, arg_59_4)
	local var_59_0 = {}

	table = var_1_10006

	var_1_10006.insert(var_59_0, function(arg_60_0)
		if arg_59_3 then
			getProxy = var_60_1
			IslandProxy = var_2_10003
			var_2_10003 = var_60_1(var_2_10003)

			local var_60_1

			if not var_60_1.GetIsland(var_2_10003) then
				getProxy = var_60_1
				IslandProxy = var_2_10003

				local var_60_0 = var_60_1(var_2_10003)

				var_60_1 = var_60_1.GetSharedIsland(var_60_0)
			end

			local var_60_2 = var_60_1:GetVisitorAgency()

			if not var_2.GetPlayer(var_60_2, arg_59_2) then
				arg_60_0()

				return
			end

			local function var_60_3(arg_61_0)
				local var_61_0 = var_0

				return var_1.GetDressByType(var_61_0, arg_61_0)
			end

			local function var_60_4(arg_62_0)
				local var_62_0 = var_0

				return var_1.GetCurrentColorByDressId(var_62_0, arg_62_0)
			end

			IslandShipDressHelperNew = var_6

			var_6.BuildCommanderCustomParts(arg_59_1, var_60_3, var_60_4, arg_60_0)

			return
		end
	end)

	seriesAsync = var_6

	var_6(var_59_0, arg_59_4)

	return
end

function var_0_0.LoadAnimator(arg_63_0, arg_63_1, arg_63_2, arg_63_3, arg_63_4, arg_63_5)
	IslandAssetLoadDispatcher = var_1_10006

	local var_63_0 = var_1_10006.Instance
	local var_63_1 = var_6.Enqueue
	local var_63_2 = arg_63_3
	local var_63_3 = ""

	typeof = var_1_10011
	RuntimeAnimatorController = var_1_10013

	local var_63_4 = var_1_10011(var_1_10013)

	UnityEngine = var_1_10012

	local var_63_5 = var_63_1(var_63_0, var_63_2, var_63_3, var_63_4, var_1_10012.Events.UnityAction_UnityEngine_Object(function(arg_64_0)
		GetOrAddComponent = var_2_10001

		local var_64_0 = arg_63_1.transform

		typeof = var_2_10004
		Animator = var_2_10006

		local var_64_1 = var_2_10001(var_64_0, var_2_10004(var_2_10006))

		var_64_1.runtimeAnimatorController = arg_64_0

		local var_64_2

		if not arg_63_2 then
			var_64_2 = "idle"
		end

		arg_63_2 = var_64_2

		local var_64_3 = var_64_1

		var_64_1.Play(var_64_3, arg_63_2, 4)

		if arg_63_5 and arg_63_5 ~= 0 then
			pg = var_2

			local var_64_4

			if not var_2.island_dress_template[arg_63_5] then
				var_64_4 = nil
			end

			local var_64_5

			if not var_64_4 or not var_64_4.special_animator then
				var_64_5 = ""
			end

			if var_64_5 == "" then
				arg_63_4()

				return
			end

			IslandAssetLoadDispatcher = var_64_3

			local var_64_6 = var_64_3.Instance
			local var_64_7 = var_4.Enqueue
			local var_64_8 = var_64_5
			local var_64_9 = ""

			typeof = var_2_10009
			UnityEngine = var_2_10011

			local var_64_10 = var_2_10009(var_2_10011.RuntimeAnimatorController)

			UnityEngine = var_2_10010

			local var_64_11 = var_64_7(var_64_6, var_64_8, var_64_9, var_64_10, var_2_10010.Events.UnityAction_UnityEngine_Object(function(arg_65_0)
				IsNil = var_3_10001

				if not var_3_10001(arg_63_1) then
					var_64_1.runtimeAnimatorController = arg_65_0
				end

				arg_63_4()

				return
			end), true, true)

			table = var_5

			var_5.insert(arg_63_0.loadingIdList, var_64_11)

			return
		end
	end), true, true)

	table = var_1_10007

	var_1_10007.insert(arg_63_0.loadingIdList, var_63_5)

	return
end

function var_0_0.NestModel(arg_66_0, arg_66_1)
	local var_66_0 = arg_66_1.name

	GameObject = var_1_10003

	local var_66_1 = var_1_10003.New(var_66_0)

	setParent = var_1_10004

	var_1_10004(arg_66_1.transform, var_66_1.transform, false)

	return var_66_1
end

function var_0_0.GetPreviewModel(arg_67_0, arg_67_1, arg_67_2, arg_67_3, arg_67_4)
	local var_67_0 = {}
	local var_67_1

	table = var_1_10007

	var_1_10007.insert(var_67_0, function(arg_68_0)
		IslandAssetLoadDispatcher = var_2_10001

		local var_68_0 = var_2_10001.Instance
		local var_68_1 = var_1.Enqueue
		local var_68_2 = arg_67_1.model
		local var_68_3 = ""

		typeof = var_2_10006
		GameObject = var_2_10008

		local var_68_4 = var_2_10006(var_2_10008)

		UnityEngine = var_2_10007

		local var_68_5 = var_68_1(var_68_0, var_68_2, var_68_3, var_68_4, var_2_10007.Events.UnityAction_UnityEngine_Object(function(arg_69_0)
			Object = var_3_10001
			var_67_1 = var_3_10001.Instantiate(arg_69_0)

			arg_68_0()

			return
		end), true, true)

		table = var_2_10002

		var_2_10002.insert(arg_67_0.loadingIdList, var_68_5)

		return
	end)

	table = var_7

	var_7.insert(var_67_0, function(arg_70_0)
		local var_70_0 = arg_67_0
		local var_70_1 = var_1.BuildPreviewPart
		local var_70_2 = var_67_1
		local var_70_3

		if not arg_67_3 then
			var_70_3 = {}
		end

		local var_70_4

		if not arg_67_4 then
			var_70_4 = {}
		end

		var_70_1(var_70_0, var_70_2, var_70_3, var_70_4, arg_70_0)

		return
	end)

	table = var_7

	var_7.insert(var_67_0, function(arg_71_0, arg_71_1, arg_71_2)
		local var_71_0 = arg_67_0

		var_3.LoadAnimator(var_71_0, var_67_1, arg_71_1, arg_67_1.animator, arg_71_0, arg_71_2)

		return
	end)

	table = var_7

	var_7.insert(var_67_0, function(arg_72_0)
		local var_72_0 = arg_67_0

		var_67_1 = var_1.NestModel(var_72_0, var_67_1)

		arg_72_0()

		return
	end)

	seriesAsync = var_7

	var_7(var_67_0, function()
		arg_67_2(var_67_1)

		return
	end)

	return
end

function var_0_0.GetCommanderModel(arg_74_0, arg_74_1, arg_74_2, arg_74_3, arg_74_4, arg_74_5)
	local var_74_0 = {}
	local var_74_1

	table = var_1_10008

	var_1_10008.insert(var_74_0, function(arg_75_0)
		IslandAssetLoadDispatcher = var_2_10001

		local var_75_0 = var_2_10001.Instance
		local var_75_1 = var_1.Enqueue
		local var_75_2 = arg_74_1.model
		local var_75_3 = ""

		typeof = var_2_10006
		GameObject = var_2_10008

		local var_75_4 = var_2_10006(var_2_10008)

		UnityEngine = var_2_10007

		local var_75_5 = var_75_1(var_75_0, var_75_2, var_75_3, var_75_4, var_2_10007.Events.UnityAction_UnityEngine_Object(function(arg_76_0)
			Object = var_3_10001
			var_74_1 = var_3_10001.Instantiate(arg_76_0)

			arg_75_0()

			return
		end), true, true)

		table = var_2_10002

		var_2_10002.insert(arg_74_0.loadingIdList, var_75_5)

		return
	end)

	if arg_74_3 then
		table = var_8

		var_8.insert(var_74_0, function(arg_77_0)
			local var_77_0 = arg_74_0

			var_1.BuildVisterPart(var_77_0, var_74_1, arg_74_3, arg_74_4, arg_77_0)

			return
		end)
	else
		table = var_8

		var_8.insert(var_74_0, function(arg_78_0)
			local var_78_0 = arg_74_0

			var_1.BuildCommanderPart(var_78_0, var_74_1, arg_78_0)

			return
		end)
	end

	table = var_8

	var_8.insert(var_74_0, function(arg_79_0, arg_79_1, arg_79_2)
		local var_79_0 = arg_74_0

		var_3.LoadAnimator(var_79_0, var_74_1, arg_79_1, arg_74_1.animator, arg_79_0, arg_79_2)

		return
	end)

	table = var_8

	var_8.insert(var_74_0, function(arg_80_0)
		local var_80_0 = arg_74_0

		var_74_1 = var_1.NestModel(var_80_0, var_74_1)

		arg_80_0()

		return
	end)

	if arg_74_5 and arg_74_5 ~= "" then
		table = var_8

		var_8.insert(var_74_0, function(arg_81_0)
			local var_81_0 = arg_74_0
			local var_81_1 = var_1.GetPool(var_81_0, var_0_5)
			local var_81_2 = var_1.GetObject
			local var_81_3 = arg_74_5

			typeof = var_2_10006
			NodeCanvas = var_2_10008

			var_81_2(var_81_1, var_81_3, var_2_10006(var_2_10008.BehaviourTrees.BehaviourTree), function(arg_82_0)
				GetOrAddComponent = var_3_10001

				local var_82_0 = var_74_1

				typeof = var_3_10004
				NodeCanvas = var_3_10006
				var_3_10001(var_82_0, var_3_10004(var_3_10006.BehaviourTrees.BehaviourTreeOwner)).graph = arg_82_0

				arg_81_0()

				return
			end)

			return
		end)
	end

	seriesAsync = var_8

	var_8(var_74_0, function()
		arg_74_2(var_74_1)

		return
	end)

	return
end

function var_0_0.ReturnCommanderModel(arg_84_0, arg_84_1, arg_84_2)
	if arg_84_2 and arg_84_2 ~= "" then
		var_1_10003 = arg_84_0:GetPool(var_0_5)
		GetOrAddComponent = var_1_10004

		local var_84_0 = arg_84_1

		typeof = var_1_10007
		NodeCanvas = var_1_10009

		local var_84_1 = var_1_10004(var_84_0, var_1_10007(var_1_10009.BehaviourTrees.BehaviourTreeOwner)).graph

		var_1_10003:ReturnObject(arg_84_2, var_84_1)

		var_4.graph = nil
	end

	Object = var_1_10003

	var_1_10003.Destroy(arg_84_1)

	return
end

function var_0_0.GetDelegateEffect(arg_85_0, arg_85_1, arg_85_2)
	local var_85_0 = arg_85_0:GetPool(var_0_10)
	local var_85_1 = var_3.GetObject
	local var_85_2 = arg_85_1

	typeof = var_1_10008
	GameObject = var_1_10010

	var_85_1(var_85_0, var_85_2, var_1_10008(var_1_10010), arg_85_2)

	return
end

function var_0_0.ReturnDelegateEffect(arg_86_0, arg_86_1, arg_86_2)
	local var_86_0 = arg_86_0:GetPool(var_0_10)

	var_3.ReturnObject(var_86_0, arg_86_1, arg_86_2)

	return
end

function var_0_0.ClearDelegateEffect(arg_87_0)
	local var_87_0 = arg_87_0:GetPool(var_0_10)

	var_1.Clear(var_87_0)

	return
end

function var_0_0.GetFishRod(arg_88_0, arg_88_1, arg_88_2, arg_88_3)
	local var_88_0 = arg_88_0:GetPool(var_0_12)
	local var_88_1 = arg_88_0
	local var_88_2 = arg_88_0.GetPool(var_88_1, var_0_4)
	local var_88_3

	seriesAsync = var_88_1

	var_88_1({
		function(arg_89_0)
			local var_89_0 = var_88_0
			local var_89_1 = var_1.GetObject
			local var_89_2 = arg_88_1

			typeof = var_2_10005
			GameObject = var_2_10007

			var_89_1(var_89_0, var_89_2, var_2_10005(var_2_10007), function(arg_90_0)
				var_88_3 = arg_90_0

				arg_89_0()

				return
			end)

			return
		end,
		function(arg_91_0)
			local var_91_0 = var_88_2
			local var_91_1 = var_1.GetObject
			local var_91_2 = arg_88_2

			typeof = var_2_10005
			RuntimeAnimatorController = var_2_10007

			var_91_1(var_91_0, var_91_2, var_2_10005(var_2_10007), function(arg_92_0)
				GetOrAddComponent = var_3_10001

				local var_92_0 = var_88_3

				typeof = var_3_10004
				Animator = var_3_10006
				var_3_10001(var_92_0, var_3_10004(var_3_10006)).runtimeAnimatorController = arg_92_0

				arg_91_0()

				return
			end)

			return
		end
	}, function()
		arg_88_3(var_88_3)

		return
	end)

	return
end

function var_0_0.ReturnFishRod(arg_94_0, arg_94_1, arg_94_2, arg_94_3)
	local var_94_0 = arg_94_0:GetPool(var_0_4)

	GetOrAddComponent = var_1_10005

	local var_94_1 = arg_94_3

	typeof = var_1_10008
	Animator = var_1_10010

	local var_94_2 = var_1_10005(var_94_1, var_1_10008(var_1_10010)).runtimeAnimatorController

	var_94_0:ReturnObject(arg_94_2, var_94_2)

	local var_94_3 = arg_94_0:GetPool(var_0_12)

	var_7.ReturnObject(var_94_3, arg_94_1, arg_94_3)

	return
end

function var_0_0.GetFish(arg_95_0, arg_95_1, arg_95_2, arg_95_3)
	local var_95_0 = arg_95_0:GetPool(var_0_13)
	local var_95_1 = arg_95_0
	local var_95_2 = arg_95_0.GetPool(var_95_1, var_0_4)
	local var_95_3

	seriesAsync = var_95_1

	var_95_1({
		function(arg_96_0)
			local var_96_0 = var_95_0
			local var_96_1 = var_1.GetObject
			local var_96_2 = arg_95_1

			typeof = var_2_10005
			GameObject = var_2_10007

			var_96_1(var_96_0, var_96_2, var_2_10005(var_2_10007), function(arg_97_0)
				var_95_3 = arg_97_0

				arg_96_0()

				return
			end)

			return
		end,
		function(arg_98_0)
			local var_98_0 = var_95_2
			local var_98_1 = var_1.GetObject
			local var_98_2 = arg_95_2

			typeof = var_2_10005
			RuntimeAnimatorController = var_2_10007

			var_98_1(var_98_0, var_98_2, var_2_10005(var_2_10007), function(arg_99_0)
				GetOrAddComponent = var_3_10001

				local var_99_0 = var_95_3

				typeof = var_3_10004
				Animator = var_3_10006
				var_3_10001(var_99_0, var_3_10004(var_3_10006)).runtimeAnimatorController = arg_99_0

				arg_98_0()

				return
			end)

			return
		end
	}, function()
		arg_95_3(var_95_3)

		return
	end)

	return
end

function var_0_0.ReturnFish(arg_101_0, arg_101_1, arg_101_2, arg_101_3)
	local var_101_0 = arg_101_0:GetPool(var_0_4)

	GetOrAddComponent = var_1_10005

	local var_101_1 = arg_101_3

	typeof = var_1_10008
	Animator = var_1_10010

	local var_101_2 = var_1_10005(var_101_1, var_1_10008(var_1_10010)).runtimeAnimatorController

	var_101_0:ReturnObject(arg_101_2, var_101_2)

	local var_101_3 = arg_101_0:GetPool(var_0_13)

	var_7.ReturnObject(var_101_3, arg_101_1, arg_101_3)

	return
end

function var_0_0.GetUI(arg_102_0, arg_102_1, arg_102_2)
	local var_102_0 = arg_102_0:GetPool(var_0_14)
	local var_102_1 = var_3.GetObject
	local var_102_2 = "ui/" .. arg_102_1

	typeof = var_8
	GameObject = var_1_10010

	var_102_1(var_102_0, var_102_2, var_8(var_1_10010), arg_102_2)

	return
end

function var_0_0.ReturnUI(arg_103_0, arg_103_1, arg_103_2)
	local var_103_0 = arg_103_0:GetPool(var_0_14)

	var_3.ReturnObject(var_103_0, "ui/" .. arg_103_1, arg_103_2)

	return
end

function var_0_0.GetFishingEffect(arg_104_0, arg_104_1, arg_104_2)
	local var_104_0 = arg_104_0:GetPool(var_0_15)
	local var_104_1 = var_3.GetObject
	local var_104_2 = arg_104_1

	typeof = var_1_10008
	GameObject = var_1_10010

	var_104_1(var_104_0, var_104_2, var_1_10008(var_1_10010), arg_104_2)

	return
end

function var_0_0.ReturnFishingEffect(arg_105_0, arg_105_1, arg_105_2)
	local var_105_0 = arg_105_0:GetPool(var_0_15)

	var_3.ReturnObject(var_105_0, arg_105_1, arg_105_2)

	return
end

function var_0_0.ClearFishingEffect(arg_106_0)
	local var_106_0 = arg_106_0:GetPool(var_0_15)

	var_1.Clear(var_106_0)

	return
end

function var_0_0.Dispose(arg_107_0)
	pairs = var_1_10001

	for iter_107_0, iter_107_1 in var_1_10001(arg_107_0.pools) do
		iter_107_1:Dispose()
	end

	arg_107_0.pools = nil
	ipairs = var_1

	local var_107_0

	if not arg_107_0.loadingIdList then
		var_107_0 = {}
	end

	for iter_107_2, iter_107_3 in var_1(var_107_0) do
		IslandAssetLoadDispatcher = var_1_10006

		local var_107_1 = var_1_10006.Instance

		var_1_10006.Cancel(var_107_1, iter_107_3)
	end

	arg_107_0.loadingIdList = nil

	return
end

return var_0_0
