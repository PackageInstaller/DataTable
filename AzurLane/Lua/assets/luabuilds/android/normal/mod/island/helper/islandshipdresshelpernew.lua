class = var_0_10000

local var_0_0 = var_0_10000("IslandShipDressHelperNew")

var_0_0.DressType = {
	Flotage = 2,
	Face = 5,
	Hat = 7,
	Body = 6,
	Footprint = 3,
	BackDecorate = 1,
	Hair = 4
}
var_0_0.CommanderCustom = {
	var_0_0.DressType.Hair,
	var_0_0.DressType.Face,
	var_0_0.DressType.Body,
	var_0_0.DressType.Hat
}
var_0_0.ExtraDressType = {
	var_0_0.DressType.BackDecorate,
	var_0_0.DressType.Flotage,
	var_0_0.DressType.Footprint
}
var_0_0.ComponentType = {
	Face = 2,
	Body = 1,
	Headware = 4,
	Hair = 3
}
var_0_0.DressType2ComponentType = {
	[var_0_0.DressType.Body] = var_0_0.ComponentType.Body,
	[var_0_0.DressType.Face] = var_0_0.ComponentType.Face,
	[var_0_0.DressType.Hair] = var_0_0.ComponentType.Hair,
	[var_0_0.DressType.Hat] = var_0_0.ComponentType.Headware
}

function var_0_0.Ctor(arg_1_0, arg_1_1)
	if arg_1_1 then
		arg_1_0.curIsland = arg_1_1
		getProxy = var_1_10002
		PlayerProxy = var_1_10003

		local var_1_0 = var_1_10002(var_1_10003)

		arg_1_0.isOtherIsland = var_2.getRawData(var_1_0).id ~= arg_1_0.curIsland.id
	end

	arg_1_0.gcCnt = 0

	return
end

function var_0_0.GetInitDressByType(arg_2_0)
	local function var_2_0(arg_3_0)
		pg = var_2_10001

		local var_3_0 = var_2_10001.island_set.default_dress.key_value_varchar

		ipairs = var_2_10002

		for iter_3_0, iter_3_1 in var_2_10002(var_3_0) do
			pg = var_2_10007

			if var_2_10007.island_dress_template[iter_3_1].type == arg_3_0 then
				return iter_3_1
			end
		end

		return 0
	end

	if arg_2_0 == var_0_0.DressType.Hat then
		local var_2_1 = var_2_0(var_0_0.DressType.Body)

		pg = var_3

		return var_3.island_dress_template.get_id_list_by_related_dress[var_2_1][1]
	end

	return var_2_0(arg_2_0)
end

function var_0_0.PreLoadVisterDressupItem(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_0.roleTF = arg_4_1.transform
	arg_4_0.isScene = true
	arg_4_0.shipId = 0
	arg_4_0.playerId = arg_4_2
	arg_4_0.hasTF = true
	arg_4_0.currentDressDataDic = {}
	arg_4_0.pageDressTFDic = {}

	local var_4_0 = {
		var_0_0.DressType.BackDecorate,
		var_0_0.DressType.Flotage,
		var_0_0.DressType.Footprint
	}

	if arg_4_3 then
		getProxy = var_4_2
		IslandProxy = var_1_10007
		var_1_10007 = var_4_2(var_1_10007)

		local var_4_2

		if not var_4_2.GetIsland(var_1_10007) then
			getProxy = var_4_2
			IslandProxy = var_1_10007

			local var_4_1 = var_4_2(var_1_10007)

			var_4_2 = var_4_2.GetSharedIsland(var_4_1)
		end

		local var_4_3 = var_4_2:GetVisitorAgency()
		local var_4_4 = var_7.GetPlayer(var_4_3, arg_4_0.playerId)
		local var_4_5 = 0

		ipairs = var_10

		for iter_4_0, iter_4_1 in var_10(var_4_0) do
			if var_4_4:GetDressByType(iter_4_1) and var_15 ~= 0 then
				local var_4_6 = {
					id = var_15
				}

				var_4_6.colorId = 0
				arg_4_0.currentDressDataDic[iter_4_1] = var_4_6
				var_4_5 = var_4_5 + 1
			end
		end

		local var_4_7 = arg_4_0

		arg_4_0.InitVisterCustomDressData(var_4_7, arg_4_2, var_4_2)

		if var_4_5 == 0 then
			arg_4_4()

			return
		end

		local var_4_8 = 0

		pairs = var_4_7

		for iter_4_2, iter_4_3 in var_4_7(arg_4_0.currentDressDataDic) do
			arg_4_0:LoadDressObjectItem(iter_4_2, iter_4_3.id, function()
				var_4_8 = var_4_8 + 1

				if var_4_8 == var_4_5 then
					arg_4_4()
				end

				return
			end)
		end

		return
	end
end

function var_0_0.InitVisterCustomDressData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.commanderDressDic = {}

	local var_6_0 = arg_6_2:GetVisitorAgency()
	local var_6_1 = var_3.GetPlayer(var_6_0, arg_6_0.playerId)

	pairs = var_6_0

	for iter_6_0, iter_6_1 in var_6_0(var_0_0.CommanderCustom) do
		if var_6_1:GetDressByType(iter_6_1) then
			arg_6_0.commanderDressDic[iter_6_1] = var_10
		end
	end

	return
end

function var_0_0.PreLoadShipDressupItem(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.roleTF = arg_7_1.transform
	arg_7_0.isScene = true
	arg_7_0.shipId = arg_7_2
	arg_7_0.hasTF = true
	arg_7_0.currentDressDataDic = {}
	arg_7_0.pageDressTFDic = {}

	local var_7_0 = {
		var_0_0.DressType.BackDecorate,
		var_0_0.DressType.Flotage,
		var_0_0.DressType.Footprint
	}

	getProxy = var_5
	IslandProxy = var_1_10006

	local var_7_1 = var_5(var_1_10006)
	local var_7_2 = var_5.GetIsland(var_7_1)

	if arg_7_0.shipId == 0 then
		local var_7_3 = var_7_2:GetDressUpAgency()
		local var_7_4 = 0

		ipairs = var_1_10008

		for iter_7_0, iter_7_1 in var_1_10008(var_7_0) do
			if var_7_3:GetDressByType(iter_7_1) and var_13 ~= 0 then
				local var_7_5 = {
					id = var_13
				}

				var_7_5.colorId = 0
				arg_7_0.currentDressDataDic[iter_7_1] = var_7_5
				var_7_4 = var_7_4 + 1
			end
		end

		local var_7_6 = arg_7_0

		arg_7_0.InitCommanderCustomDressData(var_7_6)

		if var_7_4 == 0 then
			arg_7_3()

			return
		end

		local var_7_7 = 0

		pairs = var_7_6

		for iter_7_2, iter_7_3 in var_7_6(arg_7_0.currentDressDataDic) do
			arg_7_0:LoadDressObjectItem(iter_7_2, iter_7_3.id, function()
				var_7_7 = var_7_7 + 1

				if var_7_7 == var_7_4 then
					arg_7_3()
				end

				return
			end)
		end
	else
		if arg_7_0.isOtherIsland then
			arg_7_3()

			return
		end

		local var_7_8 = var_7_2:GetCharacterAgency()
		local var_7_9 = var_6.GetShipById(var_7_8, arg_7_0.shipId)

		arg_7_0.modelData = var_7.GetModel(var_7_9)

		local var_7_10 = 0

		pairs = var_7_9

		for iter_7_4, iter_7_5 in var_7_9(var_7_0) do
			if var_6:GetCurDressIdByShipId(arg_7_0.shipId, iter_7_5) then
				local var_7_11 = {
					id = var_14.dress_id
				}

				var_7_11.colorId = 0
				arg_7_0.currentDressDataDic[iter_7_5] = var_7_11
				var_7_10 = var_7_10 + 1
			end
		end

		if var_7_10 == 0 then
			arg_7_3()

			return
		end

		local var_7_12 = 0

		pairs = var_10

		for iter_7_6, iter_7_7 in var_10(arg_7_0.currentDressDataDic) do
			arg_7_0:LoadDressObjectItem(iter_7_6, iter_7_7.id, function()
				var_7_12 = var_7_12 + 1

				if var_7_12 == var_7_10 then
					arg_7_3()
				end

				return
			end)
		end
	end

	return
end

function var_0_0.SetShipId(arg_10_0, arg_10_1)
	arg_10_0.shipId = arg_10_1
	arg_10_0.hasTF = false
	arg_10_0.currentDressDataDic = {}
	arg_10_0.dataAfterRoleInit = {}

	arg_10_0:RemoveDressTF()
	arg_10_0:InitDressData()

	return
end

function var_0_0.InitCommanderCustomDressData(arg_11_0)
	arg_11_0.commanderDressDic = {}
	getProxy = var_1
	IslandProxy = var_1_10002

	local var_11_0 = var_1(var_1_10002)
	local var_11_1 = var_1.GetIsland(var_11_0)
	local var_11_2 = var_1.GetDressUpAgency(var_11_1)

	pairs = var_11_1

	for iter_11_0, iter_11_1 in var_11_1(var_0_0.CommanderCustom) do
		if var_11_2:GetDressByType(iter_11_1) then
			arg_11_0.commanderDressDic[iter_11_1] = var_8
		end
	end

	return
end

function var_0_0.InitDressData(arg_12_0)
	local var_12_0 = {
		var_0_0.DressType.BackDecorate,
		var_0_0.DressType.Flotage,
		var_0_0.DressType.Footprint
	}

	getProxy = var_2
	IslandProxy = var_1_10003

	local var_12_1 = var_2(var_1_10003)
	local var_12_2 = var_2.GetIsland(var_12_1)

	if arg_12_0.shipId == 0 then
		local var_12_3 = var_12_2
		local var_12_4 = var_12_2.GetDressUpAgency(var_12_3)

		pairs = var_12_3

		for iter_12_0, iter_12_1 in var_12_3(var_12_0) do
			if var_12_4:GetDressByType(iter_12_1) then
				local var_12_5 = {
					id = var_9
				}

				var_12_5.colorId = 0
				arg_12_0.dataAfterRoleInit[iter_12_1] = var_12_5
			end
		end

		arg_12_0:InitCommanderCustomDressData()
	else
		local var_12_6 = var_12_2
		local var_12_7 = var_12_2.GetCharacterAgency(var_12_6)

		pairs = var_12_6

		for iter_12_2, iter_12_3 in var_12_6(var_12_0) do
			if var_12_7:GetCurDressIdByShipId(arg_12_0.shipId, iter_12_3) then
				local var_12_8 = {
					id = var_9.dress_id
				}

				var_12_8.colorId = 0
				arg_12_0.dataAfterRoleInit[iter_12_3] = var_12_8
			end
		end
	end

	return
end

function var_0_0.InitDressTF(arg_13_0, arg_13_1)
	pairs = var_1_10002

	for iter_13_0, iter_13_1 in var_1_10002(arg_13_0.dataAfterRoleInit) do
		arg_13_0:ChangeDressByType(iter_13_0, iter_13_1, arg_13_1)
	end

	arg_13_0.dataAfterRoleInit = {}

	return
end

function var_0_0.OnRoleLoaded(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_0.modelData = arg_14_2
	arg_14_0.roleTF = arg_14_1
	arg_14_0.hasTF = true
	arg_14_0.commanderPartTokens = {}

	arg_14_0:InitDressTF(arg_14_3)

	return
end

function var_0_0.IsRoleValid(arg_15_0, arg_15_1)
	if not arg_15_0.hasTF then
		return false
	end

	if arg_15_0.roleTF then
		IsNil = var_2

		if var_2(arg_15_0.roleTF) or arg_15_0.roleTF.childCount <= 0 then
			return false
		end

		if arg_15_1 then
			IsNil = var_2

			if var_2(arg_15_1) then
				return false
			end
		end

		return true
	end
end

function var_0_0.ResetFootprint(arg_16_0)
	if arg_16_0.roleTF then
		IsNil = var_1

		if var_1(arg_16_0.roleTF) then
			return
		end

		local var_16_0 = arg_16_0.roleTF
		local var_16_1 = var_1.GetComponent

		typeof = var_1_10003
		CharacterFootprintMgr = var_1_10004

		if var_16_1(var_16_0, var_1_10003(var_1_10004)) then
			var_1:ResetFootprint()
		end

		return
	end
end

function var_0_0.RemoveDressTF(arg_17_0)
	pairs = var_1_10001

	local var_17_0

	if not arg_17_0.pageDressTFDic then
		var_17_0 = {}
	end

	for iter_17_0, iter_17_1 in var_1_10001(var_17_0) do
		Object = var_1_10006

		var_1_10006.Destroy(iter_17_1.gameObject)
	end

	arg_17_0.pageDressTFDic = {}

	arg_17_0:ResetFootprint()

	return
end

function var_0_0.ChangeCommanderPartColor(arg_18_0, arg_18_1, arg_18_2)
	if not var_0_0.DressType2ComponentType[arg_18_1] then
		return
	end

	local var_18_0 = arg_18_0

	if not arg_18_0.IsRoleValid(var_18_0) then
		return
	end

	local var_18_1

	if arg_18_2 == 0 then
		GraphicsInterface = var_18_1
		var_18_0 = var_18_1.Instance
		var_18_1 = var_18_1.ResetCharacterComponentMaterialData

		local var_18_2 = arg_18_0.roleTF

		var_18_1(var_18_0, var_6.GetChild(var_18_2, 0).gameObject, var_3)
	else
		pg = var_18_1

		local var_18_3 = var_18_1.island_dress_colordiff_template[arg_18_2].model

		GraphicsInterface = var_18_0

		local var_18_4 = var_18_0.Instance
		local var_18_5 = var_5.SetCharacterComponentMaterialData
		local var_18_6 = arg_18_0.roleTF

		var_18_5(var_18_4, var_7.GetChild(var_18_6, 0).gameObject, var_18_3)
	end

	return
end

function var_0_0.SetCommanderHairBlendShape(arg_19_0, arg_19_1)
	if not arg_19_1 or arg_19_1 == 0 then
		GraphicsInterface = var_1_10002

		local var_19_0 = var_1_10002.Instance

		var_1_10002.SetCharacterBlendShape(var_19_0, arg_19_0, var_0_0.ComponentType.Hair, 0, 0)

		GraphicsInterface = var_1_10002

		local var_19_1 = var_1_10002.Instance

		var_1_10002.SetCharacterBlendShape(var_19_1, arg_19_0, var_0_0.ComponentType.Hair, 1, 0)

		return
	end

	pg = var_1_10002

	if not var_1_10002.island_dress_template[arg_19_1] then
		return
	end

	local var_19_2 = var_2.sub_type - 1

	GraphicsInterface = var_1_10004

	local var_19_3 = var_1_10004.Instance

	var_4.SetCharacterBlendShape(var_19_3, arg_19_0, var_0_0.ComponentType.Hair, var_19_2, 100)

	GraphicsInterface = var_4

	local var_19_4 = var_4.Instance

	var_4.SetCharacterBlendShape(var_19_4, arg_19_0, var_0_0.ComponentType.Hair, 1 - var_19_2, 0)

	return
end

function var_0_0.SetCommanderHairAndFaceShow(arg_20_0, arg_20_1)
	GraphicsInterface = var_1_10002

	local var_20_0 = var_1_10002.Instance

	var_2.SetCharacterComponentShow(var_20_0, arg_20_0, var_0_0.ComponentType.Hair, arg_20_1)

	GraphicsInterface = var_2

	local var_20_1 = var_2.Instance

	var_2.SetCharacterComponentShow(var_20_1, arg_20_0, var_0_0.ComponentType.Face, arg_20_1)

	return
end

function var_0_0.RefreshCommanderHatState(arg_21_0, arg_21_1)
	var_0_0.SetCommanderHairBlendShape(arg_21_0, arg_21_1)

	local var_21_0 = true

	if arg_21_1 and arg_21_1 ~= 0 then
		pg = var_3
		var_21_0 = not var_3.island_dress_template[arg_21_1] or var_3.head_hide ~= 1
	end

	var_0_0.SetCommanderHairAndFaceShow(arg_21_0, var_21_0)

	return
end

function var_0_0.LoadCommanderComponent(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	pg = var_1_10004

	if not var_1_10004.island_dress_template[arg_22_1] then
		existCall = var_1_10005

		var_1_10005(arg_22_3)

		return
	end

	local var_22_0 = var_4.model

	if arg_22_2 == 0 or arg_22_2 == nil then
		GraphicsInterface = var_1_10006
		var_1_10007 = var_1_10006.Instance

		var_1_10006.LoadCharacterComponent(var_1_10007, arg_22_0, var_22_0, arg_22_3)
	else
		pg = var_1_10006

		local var_22_1 = var_1_10006.island_dress_colordiff_template[arg_22_2].model

		GraphicsInterface = var_1_10007

		local var_22_2 = var_1_10007.Instance

		var_7.LoadCharacterComponentAndMaterial(var_22_2, arg_22_0, var_22_0, var_22_1, arg_22_3)
	end

	return
end

function var_0_0.LoadCommanderBaseAnimator(arg_23_0)
	if var_0_0.CommanderBaseRuntimeController then
		existCall = var_1

		var_1(arg_23_0, var_0_0.CommanderBaseRuntimeController)

		return
	end

	pg = var_1

	local var_23_0

	if not var_1.island_unit_character[0] or not var_1.animator then
		var_23_0 = ""
	end

	if var_23_0 == "" then
		existCall = var_1_10003

		var_1_10003(arg_23_0)

		return
	end

	IslandAssetLoadDispatcher = var_1_10003

	local var_23_1 = var_1_10003.Instance
	local var_23_2 = var_3.Enqueue
	local var_23_3 = var_23_0
	local var_23_4 = ""

	typeof = var_1_10007
	RuntimeAnimatorController = var_1_10008

	local var_23_5 = var_1_10007(var_1_10008)

	UnityEngine = var_1_10008

	var_23_2(var_23_1, var_23_3, var_23_4, var_23_5, var_1_10008.Events.UnityAction_UnityEngine_Object(function(arg_24_0)
		local var_24_0 = var_0_0

		var_24_0.CommanderBaseRuntimeController = arg_24_0
		existCall = var_24_0

		var_24_0(arg_23_0, arg_24_0)

		return
	end), true, true)

	return
end

function var_0_0.BuildCommanderCustomParts(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0
	local var_25_1 = 0

	local function var_25_2()
		var_25_1 = var_25_1 + 1

		if var_25_1 == #var_0_0.CommanderCustom then
			local var_26_0

			if not arg_25_1(var_0_0.DressType.Hat) then
				var_26_0 = 0
			end

			local var_26_1

			if not arg_25_1(var_0_0.DressType.Body) then
				var_26_1 = 0
			end

			var_0_0.RefreshCommanderHatState(arg_25_0, var_26_0)

			existCall = var_2

			var_2(arg_25_3, var_25_0, var_26_1)
		end

		return
	end

	ipairs = var_1_10007

	for iter_25_0, iter_25_1 in var_1_10007(var_0_0.CommanderCustom) do
		local var_25_3

		if not arg_25_1(iter_25_1) then
			var_25_3 = 0
		end

		if var_25_3 == 0 then
			if iter_25_1 == var_0_0.DressType.Hat then
				GraphicsInterface = var_13

				local var_25_4 = var_13.Instance

				var_13.SetCharacterComponentShow(var_25_4, arg_25_0, var_0_0.ComponentType.Headware, false, var_25_2)
			else
				var_25_2()
			end
		else
			pg = var_13

			if var_13.island_dress_template[var_25_3] and var_13.face_clip ~= "" then
				var_25_0 = var_13.face_clip
			end

			local var_25_5

			if not arg_25_2 or not arg_25_2(var_25_3) then
				var_25_5 = 0
			end

			var_0_0.LoadCommanderComponent(arg_25_0, var_25_3, var_25_5, var_25_2)
		end
	end

	return
end

function var_0_0.ChangeCommanderPart(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	if not arg_27_0:IsRoleValid() then
		existCall = var_4

		var_4(arg_27_3)

		return
	end

	local var_27_0 = arg_27_2.id
	local var_27_1 = arg_27_2.colorId
	local var_27_2 = arg_27_0.roleTF
	local var_27_3 = var_6.GetChild(var_27_2, 0).gameObject
	local var_27_4

	if not arg_27_0.commanderPartTokens then
		var_27_4 = {}
	end

	arg_27_0.commanderPartTokens = var_27_4

	local var_27_5 = arg_27_0.commanderPartTokens
	local var_27_6

	if not arg_27_0.commanderPartTokens[arg_27_1] then
		var_27_6 = 0
	end

	var_27_5[arg_27_1] = var_27_6 + 1

	local var_27_7 = arg_27_0.commanderPartTokens[arg_27_1]

	arg_27_0.commanderDressDic[arg_27_1] = var_27_0

	local function var_27_8()
		local var_28_0 = var_27_7
		local var_28_1

		if not arg_27_0.commanderPartTokens or not arg_27_0.commanderPartTokens[arg_27_1] then
			var_28_1 = 0
		end

		if var_28_0 == var_28_1 then
			local var_28_2 = arg_27_0

			if not var_28_0.IsRoleValid(var_28_2, var_27_3) then
				existCall = var_28_0

				var_28_0(arg_27_3)

				return
			end

			if arg_27_1 == var_0_0.DressType.Hat then
				local var_28_3 = arg_27_0

				var_0.ChangeCommanderPartShow(var_28_3, arg_27_1, true)
				var_0_0.RefreshCommanderHatState(var_27_3, var_27_0)
			elseif arg_27_1 == var_0_0.DressType.Hair then
				local var_28_4 = var_0_0.RefreshCommanderHatState
				local var_28_5 = var_27_3
				local var_28_6

				if not arg_27_0.commanderDressDic[var_0_0.DressType.Hat] then
					var_28_6 = 0
				end

				var_28_4(var_28_5, var_28_6)
			elseif arg_27_1 == var_0_0.DressType.Face then
				pg = var_0

				local var_28_7 = var_0.island_dress_template[var_27_0].face_clip == "" and "idle" or var_0.face_clip
				local var_28_8 = var_27_3
				local var_28_9 = var_2.GetComponent

				typeof = var_2_10004
				Animator = var_2_10005

				if var_28_9(var_28_8, var_2_10004(var_2_10005)) then
					IsNil = var_28_8

					if not var_28_8(var_2) then
						var_2:Play(var_28_7, 4)
					end
				end
			elseif arg_27_1 == var_0_0.DressType.Body then
				local var_28_10 = arg_27_0

				var_0.ApplyAnimatorOverride(var_28_10, var_27_0, arg_27_3)
			end

			return
		end
	end

	if var_27_0 ~= 0 then
		var_0_0.LoadCommanderComponent(var_27_3, var_27_0, var_27_1, var_27_8)
	end

	if arg_27_1 == var_0_0.DressType.Hat then
		if var_27_0 == 0 then
			arg_27_0:ChangeCommanderPartShow(arg_27_1, false)
			var_0_0.RefreshCommanderHatState(var_27_3, 0)

			existCall = var_9

			var_9(arg_27_3)
		end
	elseif arg_27_1 == var_0_0.DressType.Body and var_27_0 == 0 then
		arg_27_0:ApplyAnimatorOverride(0, arg_27_3)
	end

	return
end

function var_0_0.LoadDressObjectItem(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	pg = var_1_10004

	local var_29_0 = var_1_10004.island_dress_template[arg_29_2].model
	local var_29_1 = arg_29_0.shipId

	IslandAssetLoadDispatcher = var_1_10007

	local var_29_2 = var_1_10007.Instance
	local var_29_3 = var_7.Enqueue
	local var_29_4 = var_29_0
	local var_29_5 = ""

	typeof = var_1_10011
	GameObject = var_1_10012

	local var_29_6 = var_1_10011(var_1_10012)

	UnityEngine = var_1_10012

	local var_29_7 = var_29_3(var_29_2, var_29_4, var_29_5, var_29_6, var_1_10012.Events.UnityAction_UnityEngine_Object(function(arg_30_0)
		IsNil = var_2_10001

		if var_2_10001(arg_29_0.roleTF) then
			return
		end

		if arg_29_0.hasTF == false then
			return
		end

		if not arg_29_0.currentDressDataDic[arg_29_1] then
			return
		end

		if var_29_1 ~= arg_29_0.shipId then
			return
		end

		if var_1.id ~= arg_29_2 then
			return
		end

		local var_30_1

		if arg_29_1 == var_0_0.DressType.Footprint then
			GetOrAddComponent = var_30_1

			local var_30_0 = arg_29_0.roleTF

			typeof = var_2_10004
			CharacterFootprintMgr = var_2_10005
			var_30_1 = var_30_1(var_30_0, var_2_10004(var_2_10005))
			Vector3 = var_30_0

			local var_30_2 = var_30_0(0, 0, 0)

			if var_0.offset ~= "" then
				Vector3 = var_2_10004
				var_30_2 = var_2_10004(var_0.offset[1], var_0.offset[2], var_0.offset[3])
			end

			var_30_1:SetFootprintPrefab(var_0.footprint_type, arg_30_0, var_30_2)

			existCall = var_2_10004

			var_2_10004(arg_29_3)

			return
		end

		Object = var_30_1

		local var_30_3 = var_30_1.Instantiate(arg_30_0)

		if arg_29_0.isScene then
			Layer = var_30_4

			local var_30_4

			if not var_30_4.Default then
				Layer = var_30_4
				var_30_4 = var_30_4.Character3D
			end

			pg = var_2_10004

			var_2_10004.ViewUtils.SetLayer(var_30_3.transform, var_30_4)

			switch = var_4

			var_4(arg_29_1, {
				[var_0_0.DressType.BackDecorate] = function()
					local var_31_0 = arg_29_0.roleTF.transform

					if var_0.attachmentPoint ~= "" then
						local var_31_1 = var_0.attachmentPoint

						var_31_0 = (function(arg_32_0)
							for iter_32_0 = 0, arg_32_0.childCount - 1 do
								if arg_32_0:GetChild(iter_32_0).name == var_31_1 then
									return var_5
								end

								if var_0(var_5, var_31_1) then
									return var_6
								end
							end

							return nil
						end)(var_31_0)
					end

					if var_0.offset ~= "" then
						Vector3 = var_1

						local var_31_2 = var_1(var_0.offset[1], var_0.offset[2], var_0.offset[3])

						var_30_3.transform.localPosition = var_31_2
					end

					if var_0.rotation ~= "" then
						Quaternion = var_1

						local var_31_3 = var_1.Euler(var_0.rotation[1], var_0.rotation[2], var_0.rotation[3])

						var_30_3.transform.rotation = var_31_3
					end

					local var_31_4

					if var_0.scale ~= "" then
						Vector3 = var_31_4
						var_31_4 = var_31_4(var_0.scale[1], var_0.scale[1], var_0.scale[1])
						var_30_3.transform.localScale = var_31_4
					end

					setParent = var_31_4

					var_31_4(var_30_3, var_31_0)

					return
				end,
				[var_0_0.DressType.Flotage] = function()
					local var_33_0

					if var_0.offset ~= "" then
						Vector3 = var_1
						var_33_0 = var_1(var_0.offset[1], var_0.offset[2], var_0.offset[3])

						local var_33_1 = var_30_3.name

						GameObject = var_2

						local var_33_2 = var_2.New(var_33_1)

						setParent = var_3

						var_3(var_30_3.transform, var_33_2.transform, false)

						var_30_3 = var_33_2

						local var_33_3 = var_30_3.transform

						var_3_10005 = arg_29_0.roleTF
						var_3_10005 = var_4.GetChild(var_3_10005, 0).transform
						var_33_3.position = var_4.TransformPoint(var_3_10005, var_33_0)
					end

					local var_33_4

					if var_0.scale ~= "" then
						Vector3 = var_33_4
						var_33_4 = var_33_4(var_0.scale[1], var_0.scale[1], var_0.scale[1])
						var_30_3.transform.localScale = var_33_4
					end

					Vector3 = var_33_4

					local var_33_5 = var_33_4(0, 0, 0)

					if var_0.rotation ~= "" then
						Vector3 = var_2
						var_33_5 = var_2(var_0.rotation[1], var_0.rotation[2], var_0.rotation[3])
					end

					local var_33_6 = var_30_3.transform

					var_33_6.rotation = var_33_5
					GetOrAddComponent = var_33_6

					local var_33_7 = var_30_3

					typeof = var_4
					DressFlow = var_3_10005

					local var_33_8 = var_33_6(var_33_7, var_4(var_3_10005))

					pg = var_33_7

					local var_33_9 = var_33_7.island_set.island_dress_follow_param.key_value_varchar

					var_33_8.target = arg_29_0.roleTF
					var_33_8.delayTime = var_33_9[1]
					var_33_8.lerpSpeed = var_33_9[2]
					var_33_8.recordInterval = var_33_9[3]

					if not not var_33_0 then
						var_33_8.offset = var_33_0
					end

					if not not var_33_5 then
						var_33_8.rotationOffest = var_33_5
					end

					return
				end
			})

			local var_30_5 = arg_29_0.pageDressTFDic

			var_30_5[arg_29_2] = var_30_3
			existCall = var_30_5

			var_30_5(arg_29_3, var_30_3)

			return
		end
	end), true, true)

	table = var_29_2

	local var_29_8 = var_29_2.insert
	local var_29_9

	if not arg_29_0.loadingIdList then
		var_29_9 = {}
	end

	var_29_8(var_29_9, var_29_7)

	return
end

function var_0_0.ChangeDressObject(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	local var_34_0 = arg_34_2.id
	local var_34_1

	if not arg_34_0.currentDressDataDic[arg_34_1] or not arg_34_0.currentDressDataDic[arg_34_1].id then
		var_34_1 = 0
	end

	if var_34_1 then
		if var_34_1 == var_34_0 then
			return
		end

		if var_34_1 ~= 0 then
			if arg_34_1 == var_0_0.DressType.Footprint then
				var_1_10007 = arg_34_0

				arg_34_0.ResetFootprint(var_1_10007)
			elseif arg_34_0.pageDressTFDic[var_34_1] then
				Object = var_1_10007

				var_1_10007.Destroy(var_6)

				arg_34_0.pageDressTFDic[var_34_1] = nil
			end

			arg_34_0.currentDressDataDic[arg_34_1] = nil
		end
	end

	if var_34_0 == 0 then
		return
	end

	arg_34_0.currentDressDataDic[arg_34_1] = arg_34_2

	arg_34_0:LoadDressObjectItem(arg_34_1, var_34_0, arg_34_3)

	return
end

function var_0_0.ChangeDressByType(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	local var_35_0

	if not arg_35_0.hasTF then
		var_35_0 = arg_35_0.dataAfterRoleInit
		var_35_0[arg_35_1] = arg_35_2

		return
	end

	table = var_35_0

	if var_35_0.contains(var_0_0.CommanderCustom, arg_35_1) then
		arg_35_0:ChangeCommanderPart(arg_35_1, arg_35_2, arg_35_3)
	else
		arg_35_0:ChangeDressObject(arg_35_1, arg_35_2, arg_35_3)
	end

	return
end

function var_0_0.ChangeCommanderPartShow(arg_36_0, arg_36_1, arg_36_2)
	if not arg_36_0.hasTF then
		return
	end

	if not arg_36_0:IsRoleValid() then
		return
	end

	GraphicsInterface = var_3

	local var_36_0 = var_3.Instance
	local var_36_1 = var_3.SetCharacterComponentShow
	local var_36_2 = arg_36_0.roleTF

	var_36_1(var_36_0, var_5.GetChild(var_36_2, 0).gameObject, var_0_0.ComponentType.Headware, arg_36_2)

	return
end

function var_0_0.ChangeModelTransfromByUnitId(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	arg_37_0.gcCnt = arg_37_0.gcCnt + 1
	pg = var_4

	local var_37_0 = var_4.island_unit_character[arg_37_1]

	arg_37_0.hasTF = false
	arg_37_0.commanderPartTokens = {}

	local var_37_1

	if not arg_37_0.animatorOverrideToken then
		var_37_1 = 0
	end

	arg_37_0.animatorOverrideToken = var_37_1 + 1

	arg_37_0:StopMorphSwitch()
	arg_37_0:RemoveDressTF()

	arg_37_0.dataAfterRoleInit = arg_37_0.currentDressDataDic
	arg_37_0.currentDressDataDic = {}

	local var_37_2 = arg_37_0.roleTF
	local var_37_3 = var_5.GetChild(var_37_2, 0).gameObject

	pg = var_37_2

	local var_37_4 = var_37_2.UIMgr.GetInstance()

	var_6.LoadingOn(var_37_4)

	_IslandCore = var_6

	local var_37_5 = var_6:GetPoolMgr()

	var_6.ReturnCharacterModel(var_37_5, arg_37_0.modelData.model, arg_37_0.modelData.animator, var_37_3, true)

	arg_37_0.modelData = {
		model = var_37_0.model,
		animator = var_37_0.animator,
		personal_ani = var_37_0.personal_ani
	}
	_IslandCore = var_6

	local var_37_6 = var_6:GetPoolMgr()

	var_6.GetCharacterModel(var_37_6, arg_37_0.modelData.model, arg_37_0.modelData.animator, function(arg_38_0)
		pg = var_2_10001

		local var_38_0 = var_2_10001.UIMgr.GetInstance()

		var_1.LoadingOff(var_38_0)

		arg_37_0.hasTF = true

		if arg_37_0.isScene then
			Layer = var_38_1

			local var_38_1

			if not var_38_1.Default then
				Layer = var_38_1
				var_38_1 = var_38_1.Character3D
			end

			pg = var_2

			var_2.ViewUtils.SetLayer(arg_38_0.transform, var_38_1)

			setParent = var_2

			var_2(arg_38_0.transform, arg_37_0.roleTF, false)

			local var_38_2 = arg_37_0

			var_2.InitDressTF(var_38_2)

			if arg_37_3 and arg_37_0.modelData.personal_ani and var_2 ~= "" then
				GetOrAddComponent = var_38_2

				local var_38_3 = arg_37_0.roleTF.transform
				local var_38_4 = var_4.GetChild(var_38_3, 0)

				typeof = var_38_3
				Animator = var_6

				local var_38_5 = var_38_2(var_38_4, var_38_3(var_6))

				for iter_38_0 = 1, var_38_5.layerCount do
					var_38_5:CrossFadeInFixedTime(var_2, 0, iter_38_0 - 1)
				end
			end

			existCall = var_2

			var_2(arg_37_2, arg_37_0.roleTF)

			return
		end
	end, true)

	if arg_37_0.gcCnt >= 5 then
		arg_37_0.gcCnt = 0
		IslandHelper = var_6

		var_6.RunGC(true)
	end

	return
end

function var_0_0.ChangeModelTransfromByUnitIdAndChangeDress(arg_39_0, arg_39_1, arg_39_2, arg_39_3, arg_39_4, arg_39_5)
	pg = var_1_10006

	local var_39_0 = var_1_10006.island_unit_character[arg_39_1]

	arg_39_0.hasTF = false
	arg_39_0.commanderPartTokens = {}

	local var_39_1

	if not arg_39_0.animatorOverrideToken then
		var_39_1 = 0
	end

	arg_39_0.animatorOverrideToken = var_39_1 + 1

	arg_39_0:StopMorphSwitch()
	arg_39_0:RemoveDressTF()

	arg_39_0.dataAfterRoleInit = arg_39_0.currentDressDataDic
	ipairs = var_7

	for iter_39_0, iter_39_1 in var_7(arg_39_2 or {}) do
		pg = var_1_10012
		var_1_10012 = var_1_10012.island_dress_template[iter_39_1].type

		if arg_39_0.dataAfterRoleInit[var_1_10012].id == iter_39_1 then
			arg_39_0.dataAfterRoleInit[var_1_10012] = nil
		end
	end

	ipairs = var_7

	for iter_39_2, iter_39_3 in var_7(arg_39_3 or {}) do
		pg = var_1_10012
		var_1_10012 = var_1_10012.island_dress_template[iter_39_3].type
		arg_39_0.dataAfterRoleInit[var_1_10012] = {
			colorId = 0,
			id = iter_39_3
		}
	end

	arg_39_0.currentDressDataDic = {}

	local var_39_2 = arg_39_0.roleTF
	local var_39_3 = var_7.GetChild(var_39_2, 0).gameObject

	_IslandCore = var_39_2

	local var_39_4 = var_39_2:GetPoolMgr()

	var_8.ReturnCharacterModel(var_39_4, arg_39_0.modelData.model, arg_39_0.modelData.animator, var_39_3, true)

	arg_39_0.modelData = {
		model = var_39_0.model,
		animator = var_39_0.animator,
		personal_ani = var_39_0.personal_ani
	}
	_IslandCore = var_8

	local var_39_5 = var_8:GetPoolMgr()

	var_8.GetCharacterModel(var_39_5, arg_39_0.modelData.model, arg_39_0.modelData.animator, function(arg_40_0)
		arg_39_0.hasTF = true

		if arg_39_0.isScene then
			Layer = var_40_0

			local var_40_0

			if not var_40_0.Default then
				Layer = var_40_0
				var_40_0 = var_40_0.Character3D
			end

			pg = var_2

			var_2.ViewUtils.SetLayer(arg_40_0.transform, var_40_0)

			setParent = var_2

			var_2(arg_40_0.transform, arg_39_0.roleTF, false)

			local var_40_1 = arg_39_0

			var_2.InitDressTF(var_40_1)

			if arg_39_5 and arg_39_0.modelData.personal_ani and var_2 ~= "" then
				GetOrAddComponent = var_40_1

				local var_40_2 = arg_39_0.roleTF.transform
				local var_40_3 = var_4.GetChild(var_40_2, 0)

				typeof = var_40_2
				Animator = var_6

				local var_40_4 = var_40_1(var_40_3, var_40_2(var_6))

				for iter_40_0 = 1, var_40_4.layerCount do
					var_40_4:CrossFadeInFixedTime(var_2, 0, iter_40_0 - 1)
				end
			end

			existCall = var_2

			var_2(arg_39_4, arg_39_0.roleTF)

			return
		end
	end, true)

	return
end

function var_0_0.ApplyAnimatorOverride(arg_41_0, arg_41_1, arg_41_2)
	if not arg_41_0.hasTF then
		existCall = var_3

		var_3(arg_41_2)

		return
	end

	IsNil = var_3

	if var_3(arg_41_0.roleTF) then
		existCall = var_3

		var_3(arg_41_2)

		return
	end

	local var_41_0 = arg_41_0.roleTF
	local var_41_1 = var_3.GetChild(var_41_0, 0).gameObject
	local var_41_2 = var_3.GetComponent

	typeof = var_1_10006
	Animator = var_1_10007

	if not var_41_2(var_41_1, var_1_10006(var_1_10007)) then
		existCall = var_41_1

		var_41_1(arg_41_2)

		return
	end

	local var_41_3

	if not arg_41_0.animatorOverrideToken then
		var_41_3 = 0
	end

	arg_41_0.animatorOverrideToken = var_41_3 + 1

	local var_41_4 = arg_41_0.animatorOverrideToken

	if arg_41_1 ~= 0 then
		pg = var_6

		local var_41_5

		if not var_6.island_dress_template[arg_41_1] then
			var_41_5 = nil
		end

		local var_41_6

		if not var_41_5 or not var_41_5.special_animator then
			var_41_6 = ""
		end

		if var_41_6 == "" then
			var_0_0.LoadCommanderBaseAnimator(function(arg_42_0)
				IsNil = var_2_10001

				if var_2_10001(arg_41_0.roleTF) then
					existCall = var_1

					var_1(arg_41_2)

					return
				end

				if not arg_41_0.hasTF then
					existCall = var_1

					var_1(arg_41_2)

					return
				end

				if var_41_4 ~= arg_41_0.animatorOverrideToken then
					existCall = var_1

					var_1(arg_41_2)

					return
				end

				local var_42_0 = arg_41_0.roleTF
				local var_42_1 = var_1.GetChild(var_42_0, 0).gameObject
				local var_42_2 = var_1.GetComponent

				typeof = var_3
				Animator = var_2_10004

				if var_42_2(var_42_1, var_3(var_2_10004)) then
					IsNil = var_42_1

					if not var_42_1(var_1) and arg_42_0 then
						var_1.runtimeAnimatorController = arg_42_0

						var_1:Rebind()
						var_1:Update(0)
						var_1:Play("idle", 4)
					end
				end

				existCall = var_42_1

				var_42_1(arg_41_2)

				return
			end)

			return
		end

		IslandAssetLoadDispatcher = var_1_10008

		local var_41_7 = var_1_10008.Instance
		local var_41_8 = var_8.Enqueue
		local var_41_9 = var_41_6
		local var_41_10 = ""

		typeof = var_1_10012
		UnityEngine = var_1_10013

		local var_41_11 = var_1_10012(var_1_10013.RuntimeAnimatorController)

		UnityEngine = var_13

		var_41_8(var_41_7, var_41_9, var_41_10, var_41_11, var_13.Events.UnityAction_UnityEngine_Object(function(arg_43_0)
			IsNil = var_2_10001

			if var_2_10001(arg_41_0.roleTF) then
				existCall = var_1

				var_1(arg_41_2)

				return
			end

			if not arg_41_0.hasTF then
				existCall = var_1

				var_1(arg_41_2)

				return
			end

			if var_41_4 ~= arg_41_0.animatorOverrideToken then
				existCall = var_1

				var_1(arg_41_2)

				return
			end

			local var_43_0 = arg_41_0.roleTF
			local var_43_1 = var_1.GetChild(var_43_0, 0).gameObject
			local var_43_2 = var_1.GetComponent

			typeof = var_3
			Animator = var_2_10004

			if var_43_2(var_43_1, var_3(var_2_10004)) then
				IsNil = var_43_1

				if not var_43_1(var_1) then
					var_1.runtimeAnimatorController = arg_43_0
				end
			end

			existCall = var_43_1

			var_43_1(arg_41_2)

			return
		end), true, true)

		return
	end
end

function var_0_0.Destroy(arg_44_0)
	arg_44_0.curIsland = nil
	arg_44_0.hasTF = false
	arg_44_0.commanderPartTokens = {}

	local var_44_0

	if not arg_44_0.animatorOverrideToken then
		var_44_0 = 0
	end

	arg_44_0.animatorOverrideToken = var_44_0 + 1

	arg_44_0:StopMorphSwitch()
	arg_44_0:RemoveDressTF()

	ipairs = var_1

	local var_44_1

	if not arg_44_0.loadingIdList then
		var_44_1 = {}
	end

	for iter_44_0, iter_44_1 in var_1(var_44_1) do
		IslandAssetLoadDispatcher = var_1_10006

		local var_44_2 = var_1_10006.Instance

		var_1_10006.Cancel(var_44_2, iter_44_1)
	end

	arg_44_0.loadingIdList = nil
	arg_44_0.roleTF = nil

	return
end

function var_0_0.InvalidateRole(arg_45_0)
	arg_45_0.hasTF = false
	arg_45_0.commanderPartTokens = {}

	local var_45_0

	if not arg_45_0.animatorOverrideToken then
		var_45_0 = 0
	end

	arg_45_0.animatorOverrideToken = var_45_0 + 1

	arg_45_0:StopMorphSwitch()

	arg_45_0.roleTF = nil

	return
end

function var_0_0.ResetDressUp(arg_46_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_46_0 = var_1_10001(var_1_10002)
	local var_46_1 = var_1.GetIsland(var_46_0)

	if arg_46_0.shipId == 0 then
		local var_46_2 = {
			var_0_0.DressType.BackDecorate,
			var_0_0.DressType.Flotage,
			var_0_0.DressType.Footprint
		}
		local var_46_3 = var_46_1
		local var_46_4 = var_46_1.GetDressUpAgency(var_46_3)

		ipairs = var_46_3

		for iter_46_0, iter_46_1 in var_46_3(var_46_2) do
			local var_46_5

			if not var_46_4:GetDressByType(iter_46_1) then
				var_46_5 = 0
			end

			local var_46_6 = 0

			arg_46_0:ChangeDressByType(iter_46_1, {
				id = var_46_5,
				colorId = var_46_6
			})
		end
	else
		local var_46_7 = var_46_1:GetCharacterAgency()
		local var_46_8 = {
			var_0_0.DressType.BackDecorate,
			var_0_0.DressType.Flotage,
			var_0_0.DressType.Footprint
		}

		ipairs = var_4

		for iter_46_2, iter_46_3 in var_4(var_46_8) do
			local var_46_9

			if not var_46_7:GetCurDressIdByShipId(arg_46_0.shipId, iter_46_3) then
				var_46_9 = {}
			end

			local var_46_10 = arg_46_0
			local var_46_11 = arg_46_0.ChangeDressByType
			local var_46_12 = iter_46_3
			local var_46_13 = {
				colorId = 0
			}
			local var_46_14

			if not var_46_9.dress_id then
				var_46_14 = 0
			end

			var_46_13.id = var_46_14

			var_46_11(var_46_10, var_46_12, var_46_13)
		end
	end

	return
end

function var_0_0.DoMorphSwitch(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	local var_47_1

	if arg_47_0.roleTF then
		::label_47_0::

		local var_47_0 = var_4.childCount

		if 0 < var_47_0 then
			var_1_10006 = var_4
			var_47_1 = var_4.GetChild(var_1_10006, 0)
		else
			var_47_1 = false
		end

		if false then
			var_47_1 = true
		end
	end

	if var_47_1 then
		::label_47_1::

		var_1_10007 = var_47_1.gameObject
		var_1_10006 = var_1_10006.GetComponent
		typeof = var_1_10008
		Animator = var_1_10009
		var_1_10006 = var_1_10006(var_1_10007, var_1_10008(var_1_10009))
	end

	if not var_1_10006 then
		existCall = var_1_10007

		var_1_10007(arg_47_3)

		return
	end

	arg_47_0:StopMorphSwitch()

	pg = var_7

	local var_47_2 = var_7.island_dress_template[arg_47_1].cut_out_state

	arg_47_0.morphTimer = var_0_0.PlayMorphAndWait(var_1_10006, var_47_2, arg_47_1, function()
		local var_48_0 = arg_47_0

		var_48_0.morphTimer = nil
		existCall = var_48_0

		var_48_0(arg_47_3, arg_47_2)

		return
	end)

	return
end

function var_0_0.StopMorphSwitch(arg_49_0)
	if arg_49_0.morphTimer then
		local var_49_0 = arg_49_0.morphTimer

		var_1.Stop(var_49_0)

		arg_49_0.morphTimer = nil
	end

	return
end

function var_0_0.PlayMorphAndWait(arg_50_0, arg_50_1, arg_50_2, arg_50_3)
	for iter_50_0 = 1, arg_50_0.layerCount do
		arg_50_0:CrossFadeInFixedTime(arg_50_1, 0, iter_50_0 - 1)
	end

	pg = var_4

	local var_50_0

	if not var_4.island_dress_template[arg_50_2] or not var_4.morph_wait_frames then
		var_50_0 = 30
	end

	local var_50_1 = var_50_0 / 30 + 0.2
	local var_50_2 = false
	local var_50_3 = false
	local var_50_4 = false
	local var_50_5
	local var_50_6

	local function var_50_7()
		if var_50_3 then
			return
		end

		if var_50_2 then
			return
		end

		var_50_2 = true

		if var_50_5 then
			local var_51_0 = var_50_5

			var_0.Stop(var_51_0)

			var_50_5 = nil
		end

		if var_50_6 then
			local var_51_1 = var_50_6

			var_0.Stop(var_51_1)

			var_50_6 = nil
		end

		existCall = var_0

		var_0(arg_50_3)

		return
	end

	local function var_50_8()
		if var_50_2 then
			return
		end

		var_50_3 = true
		var_50_2 = true

		if var_50_5 then
			local var_52_0 = var_50_5

			var_0.Stop(var_52_0)

			var_50_5 = nil
		end

		if var_50_6 then
			local var_52_1 = var_50_6

			var_0.Stop(var_52_1)

			var_50_6 = nil
		end

		return
	end

	FrameTimer = var_1_10014

	local var_50_9 = var_1_10014.New(function()
		IsNil = var_2_10000

		if var_2_10000(arg_50_0) then
			var_50_7()

			return
		end

		local var_53_0 = arg_50_0

		if var_0.IsInTransition(var_53_0, 0) then
			return
		end

		local var_53_1 = arg_50_0
		local var_53_2 = var_0.GetCurrentAnimatorStateInfo(var_53_1, 0)

		if var_0.IsName(var_53_2, arg_50_1) then
			var_50_4 = true
		end

		if var_50_4 and var_0.normalizedTime >= 1 then
			var_50_7()
		end

		return
	end, 1, -1)

	var_50_5.Start(var_50_9)

	Timer = var_14

	local var_50_10 = var_14.New(var_50_7, var_50_1, 1)

	var_50_6.Start(var_50_10)

	return {
		Stop = var_50_8
	}
end

return var_0_0
