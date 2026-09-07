local IslandPoolMgr = class("IslandPoolMgr")
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

function IslandPoolMgr:Ctor(arg_1_1)
	self.pools = {
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
	self.loadingIdList = {}

	return
end

function IslandPoolMgr:Init(arg_2_1)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in pairs(self.pools) do
		table.insert(var_2_0, function(arg_3_0)
			iter_2_1:Init(arg_3_0)

			return
		end)
	end

	parallelAsync(var_2_0, arg_2_1)

	return
end

function IslandPoolMgr:GetPool(arg_4_1)
	assert(self.pools[arg_4_1], "pool is nil >>>" .. arg_4_1)

	return self.pools[arg_4_1]
end

local function var_0_17(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = {}
	local var_5_1
	local var_5_2

	table.insert(var_5_0, function(arg_6_0)
		arg_5_0:GetObject(arg_5_2, typeof(GameObject), function(arg_7_0)
			var_5_1 = arg_7_0

			arg_6_0()

			return
		end)

		return
	end)
	table.insert(var_5_0, function(arg_8_0)
		arg_5_1:GetObject(arg_5_3, typeof(RuntimeAnimatorController), function(arg_9_0)
			var_5_2 = arg_9_0

			arg_8_0()

			return
		end)

		return
	end)
	seriesAsync(var_5_0, function()
		GetOrAddComponent(var_5_1.transform, typeof(Animator)).runtimeAnimatorController = var_5_2

		arg_5_4(var_5_1)

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
	local var_12_0 = {}

	table.insert(var_12_0, function(arg_13_0)
		var_0_17(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_13_0)

		return
	end)
	seriesAsync(var_12_0, function(arg_14_0)
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

function IslandPoolMgr:GetCharacter(arg_16_1, arg_16_2, arg_16_3)
	var_0_19(self:GetPool(var_0_1), self:GetPool(var_0_2), arg_16_1, arg_16_2, arg_16_3)

	return
end

function IslandPoolMgr:ReturnCharacter(arg_17_1, arg_17_2, arg_17_3)
	if not self.pools then
		return
	end

	var_0_20(self:GetPool(var_0_1), self:GetPool(var_0_2), arg_17_1, arg_17_2, arg_17_3)

	return
end

function IslandPoolMgr:GetCharacterModel(arg_18_1, arg_18_2, arg_18_3)
	var_0_17(self:GetPool(var_0_1), self:GetPool(var_0_2), arg_18_1, arg_18_2, arg_18_3)

	return
end

function IslandPoolMgr:ReturnCharacterModel(arg_19_1, arg_19_2, arg_19_3)
	var_0_18(self:GetPool(var_0_1), self:GetPool(var_0_2), arg_19_1, arg_19_2, arg_19_3)

	return
end

function IslandPoolMgr:GetSceneCharacter(arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	local var_20_0 = self:GetPool(var_0_5)
	local var_20_1 = {}
	local var_20_2

	table.insert(var_20_1, function(arg_21_0)
		self:GetCharacter(arg_20_1, arg_20_2, function(arg_22_0)
			var_20_2 = arg_22_0

			arg_21_0()

			return
		end)

		return
	end)

	if arg_20_3 and arg_20_3 ~= "" then
		table.insert(var_20_1, function(arg_23_0)
			var_20_0:GetObject(arg_20_3, typeof(NodeCanvas.BehaviourTrees.BehaviourTree), function(arg_24_0)
				GetOrAddComponent(var_20_2, typeof(NodeCanvas.BehaviourTrees.BehaviourTreeOwner)).graph = arg_24_0

				arg_23_0()

				return
			end)

			return
		end)
	end

	seriesAsync(var_20_1, function()
		arg_20_4(var_20_2)

		return
	end)

	return
end

function IslandPoolMgr:ReturnSceneCharacter(arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	if arg_26_3 and arg_26_3 ~= "" then
		local var_26_0 = GetOrAddComponent(arg_26_4, typeof(NodeCanvas.BehaviourTrees.BehaviourTreeOwner))

		self:GetPool(var_0_5):ReturnObject(arg_26_3, var_26_0.graph)

		var_26_0.graph = nil
	end

	self:ReturnCharacter(arg_26_1, arg_26_2, arg_26_4)

	return
end

function IslandPoolMgr:GetSceneDelegateItem(arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	local var_27_0 = self:GetPool(var_0_16)
	local var_27_1 = self:GetPool(var_0_2)
	local var_27_2 = {}
	local var_27_3

	table.insert(var_27_2, function(arg_28_0)
		var_27_0:GetObject(arg_27_1, typeof(GameObject), function(arg_29_0)
			var_27_3 = arg_29_0

			arg_28_0()

			return
		end)

		return
	end)
	table.insert(var_27_2, function(arg_30_0)
		var_27_1:GetObject(arg_27_2, typeof(RuntimeAnimatorController), function(arg_31_0)
			GetOrAddComponent(var_27_3, typeof(Animator)).runtimeAnimatorController = arg_31_0

			arg_30_0()

			return
		end)

		return
	end)
	table.insert(var_27_2, function(arg_32_0)
		var_27_3 = self:NestModel(var_27_3)

		arg_32_0()

		return
	end)

	if arg_27_3 and arg_27_3 ~= "" then
		table.insert(var_27_2, function(arg_33_0)
			self:GetPool(var_0_5):GetObject(arg_27_3, typeof(NodeCanvas.BehaviourTrees.BehaviourTree), function(arg_34_0)
				GetOrAddComponent(var_27_3, typeof(NodeCanvas.BehaviourTrees.BehaviourTreeOwner)).graph = arg_34_0

				arg_33_0()

				return
			end)

			return
		end)
	end

	seriesAsync(var_27_2, function()
		arg_27_4(var_27_3)

		return
	end)

	return
end

function IslandPoolMgr:ReturnSceneDelegateItem(arg_36_1, arg_36_2, arg_36_3, arg_36_4)
	local var_36_0 = GetOrAddComponent(arg_36_4, typeof(Animator))

	self:GetPool(var_0_2):ReturnObject(arg_36_2, var_36_0.runtimeAnimatorController)

	var_36_0.runtimeAnimatorController = nil

	self:GetPool(var_0_16):ReturnObject(path, arg_36_4.transform:GetChild(0).gameObject)
	Object.Destroy(arg_36_4)

	return
end

function IslandPoolMgr:ClearSceneDelegateItem(arg_37_1, arg_37_2)
	return
end

function IslandPoolMgr:GetSceneProductItem(arg_38_1, arg_38_2)
	self:GetPool(var_0_6):GetObject(arg_38_1, typeof(GameObject), arg_38_2)

	return
end

function IslandPoolMgr:ReturnSceneProductItem(arg_39_1, arg_39_2)
	self:GetPool(var_0_6):ReturnObject(arg_39_1, arg_39_2)

	return
end

function IslandPoolMgr:ClearSceneProductItem(arg_40_1, arg_40_2)
	self:GetPool(var_0_6):Clear()

	return
end

function IslandPoolMgr:GetSceneProductEffect(arg_41_1, arg_41_2)
	self:GetPool(var_0_7):GetObject(arg_41_1, typeof(GameObject), arg_41_2)

	return
end

function IslandPoolMgr:ReturnSceneProductEffect(arg_42_1, arg_42_2)
	self:GetPool(var_0_7):ReturnObject(arg_42_1, arg_42_2)

	return
end

function IslandPoolMgr:ClearSceneProductEffect(arg_43_1, arg_43_2)
	self:GetPool(var_0_7):Clear()

	return
end

function IslandPoolMgr:GetAgoraObj(arg_44_1, arg_44_2)
	self:GetPool(var_0_8):GetObject(arg_44_1, typeof(GameObject), arg_44_2)

	return
end

function IslandPoolMgr:ReturnAgoraObj(arg_45_1, arg_45_2)
	self:GetPool(var_0_8):ReturnObject(arg_45_1, arg_45_2)

	return
end

function IslandPoolMgr:GetAgoraRoot()
	return self:GetPool(var_0_9):GetObject()
end

function IslandPoolMgr:ReturnAgoraRoot(arg_47_1)
	self:GetPool(var_0_9):ReturnObject(arg_47_1)

	return
end

function IslandPoolMgr:ClearAograPools()
	self:GetPool(var_0_8):Clear()
	self:GetPool(var_0_9):Clear()

	return
end

function IslandPoolMgr:GetOpUI()
	return self:GetPool(var_0_11):GetObject()
end

function IslandPoolMgr:ReturnOpUI(arg_50_1)
	self:GetPool(var_0_11):ReturnObject(arg_50_1)

	return
end

function IslandPoolMgr:BuildPreviewPart(arg_51_1, arg_51_2, arg_51_3, arg_51_4)
	local var_51_0 = {}

	table.insert(var_51_0, function(arg_52_0)
		IslandShipDressHelperNew.BuildCommanderCustomParts(arg_51_1, function(arg_53_0)
			return arg_51_2[arg_53_0] or 0
		end, function(arg_54_0)
			return arg_51_3[arg_54_0] or 0
		end, arg_52_0)

		return
	end)
	seriesAsync(var_51_0, arg_51_4)

	return
end

function IslandPoolMgr:BuildCommanderPart(arg_55_1, arg_55_2)
	local var_55_0 = {}

	table.insert(var_55_0, function(arg_56_0)
		local var_56_0 = getProxy(IslandProxy):GetIsland():GetDressUpAgency()
		local var_56_1 = var_56_0:IsNew()

		IslandShipDressHelperNew.BuildCommanderCustomParts(arg_55_1, function(arg_57_0)
			return (var_56_1 or nil) and (IslandShipDressHelperNew.GetInitDressByType(arg_57_0) or var_56_0:GetDressByType(arg_57_0))
		end, function(arg_58_0)
			return var_56_0:GetCurrentColorByDressId(arg_58_0)
		end, arg_56_0)

		return
	end)
	seriesAsync(var_55_0, arg_55_2)

	return
end

function IslandPoolMgr:BuildVisterPart(arg_59_1, arg_59_2, arg_59_3, arg_59_4)
	local var_59_0 = {}

	table.insert(var_59_0, function(arg_60_0)
		local var_60_0 = ((arg_59_3 or nil) and (getProxy(IslandProxy):GetIsland() or getProxy(IslandProxy):GetSharedIsland())):GetVisitorAgency():GetPlayer(arg_59_2)

		if not var_60_0 then
			arg_60_0()

			return
		end

		IslandShipDressHelperNew.BuildCommanderCustomParts(arg_59_1, function(arg_61_0)
			return var_60_0:GetDressByType(arg_61_0)
		end, function(arg_62_0)
			return var_60_0:GetCurrentColorByDressId(arg_62_0)
		end, arg_60_0)

		return
	end)
	seriesAsync(var_59_0, arg_59_4)

	return
end

function IslandPoolMgr:LoadAnimator(arg_63_1, arg_63_2, arg_63_3, arg_63_4, arg_63_5)
	table.insert(self.loadingIdList, (IslandAssetLoadDispatcher.Instance:Enqueue(arg_63_3, "", typeof(RuntimeAnimatorController), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_64_0)
		local var_64_0 = GetOrAddComponent(arg_63_1.transform, typeof(Animator))

		var_64_0.runtimeAnimatorController = arg_64_0
		arg_63_2 = arg_63_2 or "idle"

		var_64_0:Play(arg_63_2, 4)

		if arg_63_5 and arg_63_5 ~= 0 then
			local var_64_1 = pg.island_dress_template[arg_63_5] or nil
			local var_64_2

			if var_64_1 then
				var_64_2 = var_64_1.special_animator or ""

				if var_64_2 == "" then
					arg_63_4()

					return
				end
			end
		end

		table.insert(self.loadingIdList, (IslandAssetLoadDispatcher.Instance:Enqueue(var_64_2, "", typeof(UnityEngine.RuntimeAnimatorController), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_65_0)
			if not IsNil(arg_63_1) then
				var_64_0.runtimeAnimatorController = arg_65_0
			end

			arg_63_4()

			return
		end), true, true)))

		return
	end), true, true)))

	return
end

function IslandPoolMgr:NestModel(arg_66_1)
	local var_66_0 = GameObject.New(arg_66_1.name)

	setParent(arg_66_1.transform, var_66_0.transform, false)

	arg_66_1 = var_66_0

	return var_66_0
end

function IslandPoolMgr:GetPreviewModel(arg_67_1, arg_67_2, arg_67_3, arg_67_4)
	local var_67_0 = {}
	local var_67_1

	table.insert(var_67_0, function(arg_68_0)
		table.insert(self.loadingIdList, (IslandAssetLoadDispatcher.Instance:Enqueue(arg_67_1.model, "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_69_0)
			var_67_1 = Object.Instantiate(arg_69_0)

			arg_68_0()

			return
		end), true, true)))

		return
	end)
	table.insert(var_67_0, function(arg_70_0)
		self:BuildPreviewPart(var_67_1, arg_67_3 or {}, arg_67_4 or {}, arg_70_0)

		return
	end)
	table.insert(var_67_0, function(arg_71_0, arg_71_1, arg_71_2)
		self:LoadAnimator(var_67_1, arg_71_1, arg_67_1.animator, arg_71_0, arg_71_2)

		return
	end)
	table.insert(var_67_0, function(arg_72_0)
		var_67_1 = self:NestModel(var_67_1)

		arg_72_0()

		return
	end)
	seriesAsync(var_67_0, function()
		arg_67_2(var_67_1)

		return
	end)

	return
end

function IslandPoolMgr:GetCommanderModel(arg_74_1, arg_74_2, arg_74_3, arg_74_4, arg_74_5)
	local var_74_0 = {}
	local var_74_1

	table.insert(var_74_0, function(arg_75_0)
		table.insert(self.loadingIdList, (IslandAssetLoadDispatcher.Instance:Enqueue(arg_74_1.model, "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_76_0)
			var_74_1 = Object.Instantiate(arg_76_0)

			arg_75_0()

			return
		end), true, true)))

		return
	end)

	if arg_74_3 then
		table.insert(var_74_0, function(arg_77_0)
			self:BuildVisterPart(var_74_1, arg_74_3, arg_74_4, arg_77_0)

			return
		end)
	else
		table.insert(var_74_0, function(arg_78_0)
			self:BuildCommanderPart(var_74_1, arg_78_0)

			return
		end)
	end

	table.insert(var_74_0, function(arg_79_0, arg_79_1, arg_79_2)
		self:LoadAnimator(var_74_1, arg_79_1, arg_74_1.animator, arg_79_0, arg_79_2)

		return
	end)
	table.insert(var_74_0, function(arg_80_0)
		var_74_1 = self:NestModel(var_74_1)

		arg_80_0()

		return
	end)

	if arg_74_5 and arg_74_5 ~= "" then
		table.insert(var_74_0, function(arg_81_0)
			self:GetPool(var_0_5):GetObject(arg_74_5, typeof(NodeCanvas.BehaviourTrees.BehaviourTree), function(arg_82_0)
				GetOrAddComponent(var_74_1, typeof(NodeCanvas.BehaviourTrees.BehaviourTreeOwner)).graph = arg_82_0

				arg_81_0()

				return
			end)

			return
		end)
	end

	seriesAsync(var_74_0, function()
		arg_74_2(var_74_1)

		return
	end)

	return
end

function IslandPoolMgr:ReturnCommanderModel(arg_84_1, arg_84_2)
	if arg_84_2 and arg_84_2 ~= "" then
		local var_84_0 = GetOrAddComponent(arg_84_1, typeof(NodeCanvas.BehaviourTrees.BehaviourTreeOwner))

		self:GetPool(var_0_5):ReturnObject(arg_84_2, var_84_0.graph)

		var_84_0.graph = nil
	end

	Object.Destroy(arg_84_1)

	return
end

function IslandPoolMgr:GetDelegateEffect(arg_85_1, arg_85_2)
	self:GetPool(var_0_10):GetObject(arg_85_1, typeof(GameObject), arg_85_2)

	return
end

function IslandPoolMgr:ReturnDelegateEffect(arg_86_1, arg_86_2)
	self:GetPool(var_0_10):ReturnObject(arg_86_1, arg_86_2)

	return
end

function IslandPoolMgr:ClearDelegateEffect()
	self:GetPool(var_0_10):Clear()

	return
end

function IslandPoolMgr:GetFishRod(arg_88_1, arg_88_2, arg_88_3)
	local var_88_0 = self:GetPool(var_0_12)
	local var_88_1 = self:GetPool(var_0_4)
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

function IslandPoolMgr:ReturnFishRod(arg_94_1, arg_94_2, arg_94_3)
	self:GetPool(var_0_4):ReturnObject(arg_94_2, GetOrAddComponent(arg_94_3, typeof(Animator)).runtimeAnimatorController)
	self:GetPool(var_0_12):ReturnObject(arg_94_1, arg_94_3)

	return
end

function IslandPoolMgr:GetFish(arg_95_1, arg_95_2, arg_95_3)
	local var_95_0 = self:GetPool(var_0_13)
	local var_95_1 = self:GetPool(var_0_4)
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

function IslandPoolMgr:ReturnFish(arg_101_1, arg_101_2, arg_101_3)
	self:GetPool(var_0_4):ReturnObject(arg_101_2, GetOrAddComponent(arg_101_3, typeof(Animator)).runtimeAnimatorController)
	self:GetPool(var_0_13):ReturnObject(arg_101_1, arg_101_3)

	return
end

function IslandPoolMgr:GetUI(arg_102_1, arg_102_2)
	self:GetPool(var_0_14):GetObject("ui/" .. arg_102_1, typeof(GameObject), arg_102_2)

	return
end

function IslandPoolMgr:ReturnUI(arg_103_1, arg_103_2)
	self:GetPool(var_0_14):ReturnObject("ui/" .. arg_103_1, arg_103_2)

	return
end

function IslandPoolMgr:GetFishingEffect(arg_104_1, arg_104_2)
	self:GetPool(var_0_15):GetObject(arg_104_1, typeof(GameObject), arg_104_2)

	return
end

function IslandPoolMgr:ReturnFishingEffect(arg_105_1, arg_105_2)
	self:GetPool(var_0_15):ReturnObject(arg_105_1, arg_105_2)

	return
end

function IslandPoolMgr:ClearFishingEffect()
	self:GetPool(var_0_15):Clear()

	return
end

function IslandPoolMgr:Dispose()
	for iter_107_0, iter_107_1 in pairs(self.pools) do
		iter_107_1:Dispose()
	end

	self.pools = nil

	for iter_107_2, iter_107_3 in ipairs(self.loadingIdList or {}) do
		IslandAssetLoadDispatcher.Instance:Cancel(iter_107_3)
	end

	self.loadingIdList = nil

	return
end

return IslandPoolMgr
