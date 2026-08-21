local var_0_0 = class("IslandPoolMgr")
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
	arg_1_0.pools = {
		[var_0_1] = IslandObjectPoolSet.New(arg_1_1, 3, 2),
		[var_0_3] = IslandObjectPoolSet.New(arg_1_1, 8, 2),
		[var_0_6] = IslandObjectPoolSet.New(arg_1_1, 3, 5),
		[var_0_7] = IslandObjectPoolSet.New(arg_1_1, 3, 5),
		[var_0_8] = IslandObjectPoolSet.New(arg_1_1, 10, 3),
		[var_0_9] = IslandRootTplPool.New(arg_1_1, "ui/agorafurnituretpl", 1, 20),
		[var_0_10] = IslandObjectPoolSet.New(arg_1_1, 2, 6),
		[var_0_11] = IslandUITplPoolSet.New(arg_1_1, "ui/IslandOpUI", 1, 1, false),
		[var_0_12] = IslandObjectPoolSet.New(arg_1_1, 1, 1),
		[var_0_13] = IslandObjectPoolSet.New(arg_1_1, 3, 1),
		[var_0_14] = IslandObjectPoolSet.New(arg_1_1, 3, 1),
		[var_0_15] = IslandObjectPoolSet.New(arg_1_1, 4, 1),
		[var_0_16] = IslandObjectPoolSet.New(arg_1_1, 6, 2),
		[var_0_2] = IslandPublicAssetPoolSet.New(arg_1_1, 5, 2),
		[var_0_4] = IslandPublicAssetPoolSet.New(arg_1_1, 5, 2),
		[var_0_5] = IslandBtAssetPoolSet.New(arg_1_1, 5, 2)
	}
	arg_1_0.loadingIdList = {}

	return
end

function var_0_0.Init(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in pairs(arg_2_0.pools) do
		table.insert({}, function(arg_3_0)
			iter_2_1:Init(arg_3_0)

			return
		end)
	end

	parallelAsync({}, arg_2_1)

	return
end

function var_0_0.GetPool(arg_4_0, arg_4_1)
	assert(arg_4_0.pools[arg_4_1], "pool is nil >>>" .. arg_4_1)

	return arg_4_0.pools[arg_4_1]
end

local function var_0_17(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0
	local var_5_1

	table.insert({}, function(arg_6_0)
		arg_5_0:GetObject(arg_5_2, typeof(GameObject), function(arg_7_0)
			var_5_0 = arg_7_0

			arg_6_0()

			return
		end)

		return
	end)
	table.insert({}, function(arg_8_0)
		arg_5_1:GetObject(arg_5_3, typeof(RuntimeAnimatorController), function(arg_9_0)
			var_5_1 = arg_9_0

			arg_8_0()

			return
		end)

		return
	end)
	seriesAsync({}, function()
		GetOrAddComponent(var_5_0.transform, typeof(Animator)).runtimeAnimatorController = var_5_1

		arg_5_4(var_5_0)

		return
	end)

	return
end

local function var_0_18(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0 = GetOrAddComponent(arg_11_4, typeof(Animator))

	arg_11_1:ReturnObject(arg_11_3, var_11_0.runtimeAnimatorController)

	var_11_0.runtimeAnimatorController = nil

	arg_11_0:ReturnObject(arg_11_2, arg_11_4)

	return
end

local function var_0_19(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	table.insert({}, function(arg_13_0)
		var_0_17(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_13_0)

		return
	end)
	seriesAsync({}, function(arg_14_0)
		local var_14_0 = GameObject.New(arg_14_0.name)

		setParent(arg_14_0, var_14_0.transform, false)
		arg_12_4(var_14_0)

		return
	end)

	return
end

local function var_0_20(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	var_0_18(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4.transform:GetChild(0).gameObject)
	Object.Destroy(arg_15_4)

	return
end

function var_0_0.GetCharacter(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	var_0_19(arg_16_0:GetPool(var_0_1), arg_16_0:GetPool(var_0_2), arg_16_1, arg_16_2, arg_16_3)

	return
end

function var_0_0.ReturnCharacter(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if not arg_17_0.pools then
		return
	end

	var_0_20(arg_17_0:GetPool(var_0_1), arg_17_0:GetPool(var_0_2), arg_17_1, arg_17_2, arg_17_3)

	return
end

function var_0_0.GetCharacterModel(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	var_0_17(arg_18_0:GetPool(var_0_1), arg_18_0:GetPool(var_0_2), arg_18_1, arg_18_2, arg_18_3)

	return
end

function var_0_0.ReturnCharacterModel(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	var_0_18(arg_19_0:GetPool(var_0_1), arg_19_0:GetPool(var_0_2), arg_19_1, arg_19_2, arg_19_3)

	return
end

function var_0_0.GetSceneCharacter(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	local var_20_0 = arg_20_0:GetPool(var_0_5)
	local var_20_1

	table.insert({}, function(arg_21_0)
		arg_20_0:GetCharacter(arg_20_1, arg_20_2, function(arg_22_0)
			var_20_1 = arg_22_0

			arg_21_0()

			return
		end)

		return
	end)

	if arg_20_3 and arg_20_3 ~= "" then
		table.insert({}, function(arg_23_0)
			var_20_0:GetObject(arg_20_3, typeof(NodeCanvas.BehaviourTrees.BehaviourTree), function(arg_24_0)
				GetOrAddComponent(var_20_1, typeof(NodeCanvas.BehaviourTrees.BehaviourTreeOwner)).graph = arg_24_0

				arg_23_0()

				return
			end)

			return
		end)
	end

	seriesAsync({}, function()
		arg_20_4(var_20_1)

		return
	end)

	return
end

function var_0_0.ReturnSceneCharacter(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	if arg_26_3 and arg_26_3 ~= "" then
		local var_26_0 = GetOrAddComponent(arg_26_4, typeof(NodeCanvas.BehaviourTrees.BehaviourTreeOwner))

		arg_26_0:GetPool(var_0_5):ReturnObject(arg_26_3, var_26_0.graph)

		var_26_0.graph = nil
	end

	arg_26_0:ReturnCharacter(arg_26_1, arg_26_2, arg_26_4)

	return
end

function var_0_0.GetSceneDelegateItem(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	local var_27_0 = arg_27_0:GetPool(var_0_16)
	local var_27_1 = arg_27_0:GetPool(var_0_2)
	local var_27_2

	table.insert({}, function(arg_28_0)
		var_27_0:GetObject(arg_27_1, typeof(GameObject), function(arg_29_0)
			var_27_2 = arg_29_0

			arg_28_0()

			return
		end)

		return
	end)
	table.insert({}, function(arg_30_0)
		var_27_1:GetObject(arg_27_2, typeof(RuntimeAnimatorController), function(arg_31_0)
			GetOrAddComponent(var_27_2, typeof(Animator)).runtimeAnimatorController = arg_31_0

			arg_30_0()

			return
		end)

		return
	end)
	table.insert({}, function(arg_32_0)
		var_27_2 = arg_27_0:NestModel(var_27_2)

		arg_32_0()

		return
	end)

	if arg_27_3 and arg_27_3 ~= "" then
		table.insert({}, function(arg_33_0)
			arg_27_0:GetPool(var_0_5):GetObject(arg_27_3, typeof(NodeCanvas.BehaviourTrees.BehaviourTree), function(arg_34_0)
				GetOrAddComponent(var_27_2, typeof(NodeCanvas.BehaviourTrees.BehaviourTreeOwner)).graph = arg_34_0

				arg_33_0()

				return
			end)

			return
		end)
	end

	seriesAsync({}, function()
		arg_27_4(var_27_2)

		return
	end)

	return
end

function var_0_0.ReturnSceneDelegateItem(arg_36_0, arg_36_1, arg_36_2, arg_36_3, arg_36_4)
	local var_36_0 = GetOrAddComponent(arg_36_4, typeof(Animator))

	arg_36_0:GetPool(var_0_2):ReturnObject(arg_36_2, var_36_0.runtimeAnimatorController)

	var_36_0.runtimeAnimatorController = nil

	arg_36_0:GetPool(var_0_16):ReturnObject(path, arg_36_4.transform:GetChild(0).gameObject)
	Object.Destroy(arg_36_4)

	return
end

function var_0_0.ClearSceneDelegateItem(arg_37_0, arg_37_1, arg_37_2)
	return
end

function var_0_0.GetSceneProductItem(arg_38_0, arg_38_1, arg_38_2)
	arg_38_0:GetPool(var_0_6):GetObject(arg_38_1, typeof(GameObject), arg_38_2)

	return
end

function var_0_0.ReturnSceneProductItem(arg_39_0, arg_39_1, arg_39_2)
	arg_39_0:GetPool(var_0_6):ReturnObject(arg_39_1, arg_39_2)

	return
end

function var_0_0.ClearSceneProductItem(arg_40_0, arg_40_1, arg_40_2)
	arg_40_0:GetPool(var_0_6):Clear()

	return
end

function var_0_0.GetSceneProductEffect(arg_41_0, arg_41_1, arg_41_2)
	arg_41_0:GetPool(var_0_7):GetObject(arg_41_1, typeof(GameObject), arg_41_2)

	return
end

function var_0_0.ReturnSceneProductEffect(arg_42_0, arg_42_1, arg_42_2)
	arg_42_0:GetPool(var_0_7):ReturnObject(arg_42_1, arg_42_2)

	return
end

function var_0_0.ClearSceneProductEffect(arg_43_0, arg_43_1, arg_43_2)
	arg_43_0:GetPool(var_0_7):Clear()

	return
end

function var_0_0.GetAgoraObj(arg_44_0, arg_44_1, arg_44_2)
	arg_44_0:GetPool(var_0_8):GetObject(arg_44_1, typeof(GameObject), arg_44_2)

	return
end

function var_0_0.ReturnAgoraObj(arg_45_0, arg_45_1, arg_45_2)
	arg_45_0:GetPool(var_0_8):ReturnObject(arg_45_1, arg_45_2)

	return
end

function var_0_0.GetAgoraRoot(arg_46_0)
	return arg_46_0:GetPool(var_0_9):GetObject()
end

function var_0_0.ReturnAgoraRoot(arg_47_0, arg_47_1)
	arg_47_0:GetPool(var_0_9):ReturnObject(arg_47_1)

	return
end

function var_0_0.ClearAograPools(arg_48_0)
	arg_48_0:GetPool(var_0_8):Clear()
	arg_48_0:GetPool(var_0_9):Clear()

	return
end

function var_0_0.GetOpUI(arg_49_0)
	return arg_49_0:GetPool(var_0_11):GetObject()
end

function var_0_0.ReturnOpUI(arg_50_0, arg_50_1)
	arg_50_0:GetPool(var_0_11):ReturnObject(arg_50_1)

	return
end

function var_0_0.BuildPreviewPart(arg_51_0, arg_51_1, arg_51_2, arg_51_3, arg_51_4)
	table.insert({}, function(arg_52_0)
		IslandShipDressHelperNew.BuildCommanderCustomParts(arg_51_1, function(arg_53_0)
			return arg_51_2[arg_53_0] or 0
		end, function(arg_54_0)
			return arg_51_3[arg_54_0] or 0
		end, arg_52_0)

		return
	end)
	seriesAsync({}, arg_51_4)

	return
end

function var_0_0.BuildCommanderPart(arg_55_0, arg_55_1, arg_55_2)
	table.insert({}, function(arg_56_0)
		local var_56_0 = getProxy(IslandProxy):GetIsland():GetDressUpAgency()
		local var_56_1 = getProxy(IslandProxy):GetIsland():GetDressUpAgency():IsNew()

		IslandShipDressHelperNew.BuildCommanderCustomParts(arg_55_1, function(arg_57_0)
			if var_56_1 then
				return IslandShipDressHelperNew.GetInitDressByType(arg_57_0) or var_56_0:GetDressByType(arg_57_0)
			end
		end, function(arg_58_0)
			return var_56_0:GetCurrentColorByDressId(arg_58_0)
		end, arg_56_0)

		return
	end)
	seriesAsync({}, arg_55_2)

	return
end

function var_0_0.BuildVisterPart(arg_59_0, arg_59_1, arg_59_2, arg_59_3, arg_59_4)
	table.insert({}, function(arg_60_0)
		if arg_59_3 then
			local var_60_0 = getProxy(IslandProxy):GetIsland() or getProxy(IslandProxy):GetSharedIsland()
			local var_60_1 = var_60_0:GetVisitorAgency()

			if not var_60_1:GetPlayer(arg_59_2) then
				arg_60_0()

				return
			end

			IslandShipDressHelperNew.BuildCommanderCustomParts(arg_59_1, function(arg_61_0)
				return var_0:GetDressByType(arg_61_0)
			end, function(arg_62_0)
				return var_0:GetCurrentColorByDressId(arg_62_0)
			end, arg_60_0)

			return
		end
	end)
	seriesAsync({}, arg_59_4)

	return
end

function var_0_0.LoadAnimator(arg_63_0, arg_63_1, arg_63_2, arg_63_3, arg_63_4, arg_63_5)
	table.insert(arg_63_0.loadingIdList, (IslandAssetLoadDispatcher.Instance:Enqueue(arg_63_3, "", typeof(RuntimeAnimatorController), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_64_0)
		local var_64_0 = GetOrAddComponent(arg_63_1.transform, typeof(Animator))

		var_64_0.runtimeAnimatorController = arg_64_0
		arg_63_2 = arg_63_2 or "idle"

		var_64_0:Play(arg_63_2, 4)

		if arg_63_5 and arg_63_5 ~= 0 then
			local var_64_1 = pg.island_dress_template[arg_63_5] or nil

			if var_64_1 then
				local var_64_2 = var_64_1.special_animator or ""

				if var_64_2 == "" then
					arg_63_4()

					return
				end

				table.insert(arg_63_0.loadingIdList, (IslandAssetLoadDispatcher.Instance:Enqueue(var_64_2, "", typeof(UnityEngine.RuntimeAnimatorController), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_65_0)
					if not IsNil(arg_63_1) then
						var_64_0.runtimeAnimatorController = arg_65_0
					end

					arg_63_4()

					return
				end), true, true)))

				return
			end
		end
	end), true, true)))

	return
end

function var_0_0.NestModel(arg_66_0, arg_66_1)
	local var_66_0 = GameObject.New(arg_66_1.name)

	setParent(arg_66_1.transform, var_66_0.transform, false)

	arg_66_1 = var_66_0

	return var_66_0
end

function var_0_0.GetPreviewModel(arg_67_0, arg_67_1, arg_67_2, arg_67_3, arg_67_4)
	local var_67_0

	table.insert({}, function(arg_68_0)
		table.insert(arg_67_0.loadingIdList, (IslandAssetLoadDispatcher.Instance:Enqueue(arg_67_1.model, "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_69_0)
			var_67_0 = Object.Instantiate(arg_69_0)

			arg_68_0()

			return
		end), true, true)))

		return
	end)
	table.insert({}, function(arg_70_0)
		local var_70_0 = arg_67_3 or {}
		local var_70_1 = arg_67_4 or {}

		arg_67_0:BuildPreviewPart(var_67_0, var_70_0, var_70_1, arg_70_0)

		return
	end)
	table.insert({}, function(arg_71_0, arg_71_1, arg_71_2)
		arg_67_0:LoadAnimator(var_67_0, arg_71_1, arg_67_1.animator, arg_71_0, arg_71_2)

		return
	end)
	table.insert({}, function(arg_72_0)
		var_67_0 = arg_67_0:NestModel(var_67_0)

		arg_72_0()

		return
	end)
	seriesAsync({}, function()
		arg_67_2(var_67_0)

		return
	end)

	return
end

function var_0_0.GetCommanderModel(arg_74_0, arg_74_1, arg_74_2, arg_74_3, arg_74_4, arg_74_5)
	local var_74_0

	table.insert({}, function(arg_75_0)
		table.insert(arg_74_0.loadingIdList, (IslandAssetLoadDispatcher.Instance:Enqueue(arg_74_1.model, "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_76_0)
			var_74_0 = Object.Instantiate(arg_76_0)

			arg_75_0()

			return
		end), true, true)))

		return
	end)

	if arg_74_3 then
		table.insert({}, function(arg_77_0)
			arg_74_0:BuildVisterPart(var_74_0, arg_74_3, arg_74_4, arg_77_0)

			return
		end)
	else
		table.insert({}, function(arg_78_0)
			arg_74_0:BuildCommanderPart(var_74_0, arg_78_0)

			return
		end)
	end

	table.insert({}, function(arg_79_0, arg_79_1, arg_79_2)
		arg_74_0:LoadAnimator(var_74_0, arg_79_1, arg_74_1.animator, arg_79_0, arg_79_2)

		return
	end)
	table.insert({}, function(arg_80_0)
		var_74_0 = arg_74_0:NestModel(var_74_0)

		arg_80_0()

		return
	end)

	if arg_74_5 and arg_74_5 ~= "" then
		table.insert({}, function(arg_81_0)
			arg_74_0:GetPool(var_0_5):GetObject(arg_74_5, typeof(NodeCanvas.BehaviourTrees.BehaviourTree), function(arg_82_0)
				GetOrAddComponent(var_74_0, typeof(NodeCanvas.BehaviourTrees.BehaviourTreeOwner)).graph = arg_82_0

				arg_81_0()

				return
			end)

			return
		end)
	end

	seriesAsync({}, function()
		arg_74_2(var_74_0)

		return
	end)

	return
end

function var_0_0.ReturnCommanderModel(arg_84_0, arg_84_1, arg_84_2)
	if arg_84_2 and arg_84_2 ~= "" then
		local var_84_0 = GetOrAddComponent(arg_84_1, typeof(NodeCanvas.BehaviourTrees.BehaviourTreeOwner))

		arg_84_0:GetPool(var_0_5):ReturnObject(arg_84_2, var_84_0.graph)

		var_84_0.graph = nil
	end

	Object.Destroy(arg_84_1)

	return
end

function var_0_0.GetDelegateEffect(arg_85_0, arg_85_1, arg_85_2)
	arg_85_0:GetPool(var_0_10):GetObject(arg_85_1, typeof(GameObject), arg_85_2)

	return
end

function var_0_0.ReturnDelegateEffect(arg_86_0, arg_86_1, arg_86_2)
	arg_86_0:GetPool(var_0_10):ReturnObject(arg_86_1, arg_86_2)

	return
end

function var_0_0.ClearDelegateEffect(arg_87_0)
	arg_87_0:GetPool(var_0_10):Clear()

	return
end

function var_0_0.GetFishRod(arg_88_0, arg_88_1, arg_88_2, arg_88_3)
	local var_88_0 = arg_88_0:GetPool(var_0_12)
	local var_88_1 = arg_88_0:GetPool(var_0_4)
	local var_88_2

	seriesAsync({
		function(arg_89_0)
			var_88_0:GetObject(arg_88_1, typeof(GameObject), function(arg_90_0)
				var_88_2 = arg_90_0

				arg_89_0()

				return
			end)

			return
		end,
		function(arg_91_0)
			var_88_1:GetObject(arg_88_2, typeof(RuntimeAnimatorController), function(arg_92_0)
				GetOrAddComponent(var_88_2, typeof(Animator)).runtimeAnimatorController = arg_92_0

				arg_91_0()

				return
			end)

			return
		end
	}, function()
		arg_88_3(var_88_2)

		return
	end)

	return
end

function var_0_0.ReturnFishRod(arg_94_0, arg_94_1, arg_94_2, arg_94_3)
	arg_94_0:GetPool(var_0_4):ReturnObject(arg_94_2, GetOrAddComponent(arg_94_3, typeof(Animator)).runtimeAnimatorController)
	arg_94_0:GetPool(var_0_12):ReturnObject(arg_94_1, arg_94_3)

	return
end

function var_0_0.GetFish(arg_95_0, arg_95_1, arg_95_2, arg_95_3)
	local var_95_0 = arg_95_0:GetPool(var_0_13)
	local var_95_1 = arg_95_0:GetPool(var_0_4)
	local var_95_2

	seriesAsync({
		function(arg_96_0)
			var_95_0:GetObject(arg_95_1, typeof(GameObject), function(arg_97_0)
				var_95_2 = arg_97_0

				arg_96_0()

				return
			end)

			return
		end,
		function(arg_98_0)
			var_95_1:GetObject(arg_95_2, typeof(RuntimeAnimatorController), function(arg_99_0)
				GetOrAddComponent(var_95_2, typeof(Animator)).runtimeAnimatorController = arg_99_0

				arg_98_0()

				return
			end)

			return
		end
	}, function()
		arg_95_3(var_95_2)

		return
	end)

	return
end

function var_0_0.ReturnFish(arg_101_0, arg_101_1, arg_101_2, arg_101_3)
	arg_101_0:GetPool(var_0_4):ReturnObject(arg_101_2, GetOrAddComponent(arg_101_3, typeof(Animator)).runtimeAnimatorController)
	arg_101_0:GetPool(var_0_13):ReturnObject(arg_101_1, arg_101_3)

	return
end

function var_0_0.GetUI(arg_102_0, arg_102_1, arg_102_2)
	arg_102_0:GetPool(var_0_14):GetObject("ui/" .. arg_102_1, typeof(GameObject), arg_102_2)

	return
end

function var_0_0.ReturnUI(arg_103_0, arg_103_1, arg_103_2)
	arg_103_0:GetPool(var_0_14):ReturnObject("ui/" .. arg_103_1, arg_103_2)

	return
end

function var_0_0.GetFishingEffect(arg_104_0, arg_104_1, arg_104_2)
	arg_104_0:GetPool(var_0_15):GetObject(arg_104_1, typeof(GameObject), arg_104_2)

	return
end

function var_0_0.ReturnFishingEffect(arg_105_0, arg_105_1, arg_105_2)
	arg_105_0:GetPool(var_0_15):ReturnObject(arg_105_1, arg_105_2)

	return
end

function var_0_0.ClearFishingEffect(arg_106_0)
	arg_106_0:GetPool(var_0_15):Clear()

	return
end

function var_0_0.Dispose(arg_107_0)
	for iter_107_0, iter_107_1 in pairs(arg_107_0.pools) do
		iter_107_1:Dispose()
	end

	arg_107_0.pools = nil

	local var_107_0 = arg_107_0.loadingIdList or {}

	for iter_107_2, iter_107_3 in ipairs(var_107_0) do
		IslandAssetLoadDispatcher.Instance:Cancel(iter_107_3)
	end

	arg_107_0.loadingIdList = nil

	return
end

return var_0_0
