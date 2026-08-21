local var_0_0 = class("IslandShipDressHelperNew")

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

		local var_1_0 = getProxy(PlayerProxy)

		arg_1_0.isOtherIsland = var_1_0:getRawData().id ~= arg_1_0.curIsland.id
	end

	arg_1_0.gcCnt = 0

	return
end

function var_0_0.GetInitDressByType(arg_2_0)
	if arg_2_0 == var_0_0.DressType.Hat then
		return pg.island_dress_template.get_id_list_by_related_dress[(function(arg_3_0)
			for iter_3_0, iter_3_1 in ipairs(pg.island_set.default_dress.key_value_varchar) do
				if pg.island_dress_template[iter_3_1].type == arg_3_0 then
					return iter_3_1
				end
			end

			return 0
		end)(var_0_0.DressType.Body)][1]
	end

	return (function(arg_3_0)
		for iter_3_0, iter_3_1 in ipairs(pg.island_set.default_dress.key_value_varchar) do
			if pg.island_dress_template[iter_3_1].type == arg_3_0 then
				return iter_3_1
			end
		end

		return 0
	end)(arg_2_0)
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
		local var_4_1 = getProxy(IslandProxy):GetIsland() or getProxy(IslandProxy):GetSharedIsland()
		local var_4_2 = var_4_1:GetVisitorAgency():GetPlayer(arg_4_0.playerId)
		local var_4_3 = 0

		for iter_4_0, iter_4_1 in ipairs(var_4_0) do
			local var_4_4 = var_4_2:GetDressByType(iter_4_1)

			if var_4_4 and var_4_4 ~= 0 then
				({
					id = var_4_4
				}).colorId = 0
				arg_4_0.currentDressDataDic[iter_4_1] = {
					id = var_4_4
				}
				var_4_3 = var_4_3 + 1
			end
		end

		arg_4_0:InitVisterCustomDressData(arg_4_2, var_4_1)

		if var_4_3 == 0 then
			arg_4_4()

			return
		end

		local var_4_5 = 0

		for iter_4_2, iter_4_3 in pairs(arg_4_0.currentDressDataDic) do
			arg_4_0:LoadDressObjectItem(iter_4_2, iter_4_3.id, function()
				var_4_5 = var_4_5 + 1

				if var_4_5 == var_4_3 then
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

	local var_6_0 = arg_6_2:GetVisitorAgency():GetPlayer(arg_6_0.playerId)

	for iter_6_0, iter_6_1 in pairs(var_0_0.CommanderCustom) do
		local var_6_1 = var_6_0:GetDressByType(iter_6_1)

		if var_6_1 then
			arg_6_0.commanderDressDic[iter_6_1] = var_6_1
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

	local var_7_0 = getProxy(IslandProxy):GetIsland()

	if arg_7_0.shipId == 0 then
		local var_7_1 = var_7_0:GetDressUpAgency()
		local var_7_2 = 0

		for iter_7_0, iter_7_1 in ipairs({
			var_0_0.DressType.BackDecorate,
			var_0_0.DressType.Flotage,
			var_0_0.DressType.Footprint
		}) do
			local var_7_3 = var_7_1:GetDressByType(iter_7_1)

			if var_7_3 and var_7_3 ~= 0 then
				({
					id = var_7_3
				}).colorId = 0
				arg_7_0.currentDressDataDic[iter_7_1] = {
					id = var_7_3
				}
				var_7_2 = var_7_2 + 1
			end
		end

		arg_7_0:InitCommanderCustomDressData()

		if var_7_2 == 0 then
			arg_7_3()

			return
		end

		local var_7_4 = 0

		for iter_7_2, iter_7_3 in pairs(arg_7_0.currentDressDataDic) do
			arg_7_0:LoadDressObjectItem(iter_7_2, iter_7_3.id, function()
				var_7_4 = var_7_4 + 1

				if var_7_4 == var_7_2 then
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

		local var_7_5 = var_7_0:GetCharacterAgency()

		arg_7_0.modelData = var_7_5:GetShipById(arg_7_0.shipId):GetModel()

		local var_7_6 = 0

		for iter_7_4, iter_7_5 in pairs({
			var_0_0.DressType.BackDecorate,
			var_0_0.DressType.Flotage,
			var_0_0.DressType.Footprint
		}) do
			local var_7_7 = var_7_5:GetCurDressIdByShipId(arg_7_0.shipId, iter_7_5)

			if var_7_7 then
				({
					id = var_7_7.dress_id
				}).colorId = 0
				arg_7_0.currentDressDataDic[iter_7_5] = {
					id = var_7_7.dress_id
				}
				var_7_6 = var_7_6 + 1
			end
		end

		if var_7_6 == 0 then
			arg_7_3()

			return
		end

		local var_7_8 = 0

		for iter_7_6, iter_7_7 in pairs(arg_7_0.currentDressDataDic) do
			arg_7_0:LoadDressObjectItem(iter_7_6, iter_7_7.id, function()
				var_7_8 = var_7_8 + 1

				if var_7_8 == var_7_6 then
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

	local var_11_0 = getProxy(IslandProxy):GetIsland():GetDressUpAgency()

	for iter_11_0, iter_11_1 in pairs(var_0_0.CommanderCustom) do
		local var_11_1 = var_11_0:GetDressByType(iter_11_1)

		if var_11_1 then
			arg_11_0.commanderDressDic[iter_11_1] = var_11_1
		end
	end

	return
end

function var_0_0.InitDressData(arg_12_0)
	local var_12_0 = getProxy(IslandProxy):GetIsland()

	if arg_12_0.shipId == 0 then
		local var_12_1 = var_12_0:GetDressUpAgency()

		for iter_12_0, iter_12_1 in pairs({
			var_0_0.DressType.BackDecorate,
			var_0_0.DressType.Flotage,
			var_0_0.DressType.Footprint
		}) do
			local var_12_2 = var_12_1:GetDressByType(iter_12_1)

			if var_12_2 then
				({
					id = var_12_2
				}).colorId = 0
				arg_12_0.dataAfterRoleInit[iter_12_1] = {
					id = var_12_2
				}
			end
		end

		arg_12_0:InitCommanderCustomDressData()
	else
		local var_12_3 = var_12_0:GetCharacterAgency()

		for iter_12_2, iter_12_3 in pairs({
			var_0_0.DressType.BackDecorate,
			var_0_0.DressType.Flotage,
			var_0_0.DressType.Footprint
		}) do
			local var_12_4 = var_12_3:GetCurDressIdByShipId(arg_12_0.shipId, iter_12_3)

			if var_12_4 then
				({
					id = var_12_4.dress_id
				}).colorId = 0
				arg_12_0.dataAfterRoleInit[iter_12_3] = {
					id = var_12_4.dress_id
				}
			end
		end
	end

	return
end

function var_0_0.InitDressTF(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.dataAfterRoleInit) do
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

	if not arg_15_0.roleTF or IsNil(arg_15_0.roleTF) or arg_15_0.roleTF.childCount <= 0 then
		return false
	end

	if arg_15_1 and IsNil(arg_15_1) then
		return false
	end

	return true
end

function var_0_0.ResetFootprint(arg_16_0)
	if not arg_16_0.roleTF or IsNil(arg_16_0.roleTF) then
		return
	end

	local var_16_0 = arg_16_0.roleTF:GetComponent(typeof(CharacterFootprintMgr))

	if var_16_0 then
		var_16_0:ResetFootprint()
	end

	return
end

function var_0_0.RemoveDressTF(arg_17_0)
	local var_17_0 = arg_17_0.pageDressTFDic or {}

	for iter_17_0, iter_17_1 in pairs(var_17_0) do
		Object.Destroy(iter_17_1.gameObject)
	end

	arg_17_0.pageDressTFDic = {}

	arg_17_0:ResetFootprint()

	return
end

function var_0_0.ChangeCommanderPartColor(arg_18_0, arg_18_1, arg_18_2)
	if not var_0_0.DressType2ComponentType[arg_18_1] then
		return
	end

	if not arg_18_0:IsRoleValid() then
		return
	end

	if arg_18_2 == 0 then
		GraphicsInterface.Instance:ResetCharacterComponentMaterialData(arg_18_0.roleTF:GetChild(0).gameObject, var_0_0.DressType2ComponentType[arg_18_1])
	else
		GraphicsInterface.Instance:SetCharacterComponentMaterialData(arg_18_0.roleTF:GetChild(0).gameObject, pg.island_dress_colordiff_template[arg_18_2].model)
	end

	return
end

function var_0_0.SetCommanderHairBlendShape(arg_19_0, arg_19_1)
	if not arg_19_1 or arg_19_1 == 0 then
		GraphicsInterface.Instance:SetCharacterBlendShape(arg_19_0, var_0_0.ComponentType.Hair, 0, 0)
		GraphicsInterface.Instance:SetCharacterBlendShape(arg_19_0, var_0_0.ComponentType.Hair, 1, 0)

		return
	end

	local var_19_0 = pg.island_dress_template[arg_19_1]

	if not pg.island_dress_template[arg_19_1] then
		return
	end

	local var_19_1 = var_19_0.sub_type - 1

	GraphicsInterface.Instance:SetCharacterBlendShape(arg_19_0, var_0_0.ComponentType.Hair, var_19_0.sub_type - 1, 100)
	GraphicsInterface.Instance:SetCharacterBlendShape(arg_19_0, var_0_0.ComponentType.Hair, 1 - var_19_1, 0)

	return
end

function var_0_0.SetCommanderHairAndFaceShow(arg_20_0, arg_20_1)
	GraphicsInterface.Instance:SetCharacterComponentShow(arg_20_0, var_0_0.ComponentType.Hair, arg_20_1)
	GraphicsInterface.Instance:SetCharacterComponentShow(arg_20_0, var_0_0.ComponentType.Face, arg_20_1)

	return
end

function var_0_0.RefreshCommanderHatState(arg_21_0, arg_21_1)
	var_0_0.SetCommanderHairBlendShape(arg_21_0, arg_21_1)

	local var_21_0 = true

	if arg_21_1 and arg_21_1 ~= 0 then
		var_21_0 = not pg.island_dress_template[arg_21_1] or pg.island_dress_template[arg_21_1].head_hide ~= 1
	end

	var_0_0.SetCommanderHairAndFaceShow(arg_21_0, var_21_0)

	return
end

function var_0_0.LoadCommanderComponent(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	if not pg.island_dress_template[arg_22_1] then
		existCall(arg_22_3)

		return
	end

	local var_22_0 = pg.island_dress_template[arg_22_1].model

	if arg_22_2 == 0 or arg_22_2 == nil then
		GraphicsInterface.Instance:LoadCharacterComponent(arg_22_0, var_22_0, arg_22_3)
	else
		GraphicsInterface.Instance:LoadCharacterComponentAndMaterial(arg_22_0, var_22_0, pg.island_dress_colordiff_template[arg_22_2].model, arg_22_3)
	end

	return
end

function var_0_0.LoadCommanderBaseAnimator(arg_23_0)
	if var_0_0.CommanderBaseRuntimeController then
		existCall(arg_23_0, var_0_0.CommanderBaseRuntimeController)

		return
	end

	local var_23_0 = pg.island_unit_character[0]

	if pg.island_unit_character[0] then
		local var_23_1 = var_23_0.animator or ""

		if var_23_1 == "" then
			existCall(arg_23_0)

			return
		end

		IslandAssetLoadDispatcher.Instance:Enqueue(var_23_1, "", typeof(RuntimeAnimatorController), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_24_0)
			var_0_0.CommanderBaseRuntimeController = arg_24_0

			existCall(arg_23_0, arg_24_0)

			return
		end), true, true)

		return
	end
end

function var_0_0.BuildCommanderCustomParts(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0
	local var_25_1 = 0

	local function var_25_2()
		var_25_1 = var_25_1 + 1

		if var_25_1 == #var_0_0.CommanderCustom then
			local var_26_0 = arg_25_1(var_0_0.DressType.Hat) or 0
			local var_26_1 = arg_25_1(var_0_0.DressType.Body) or 0

			var_0_0.RefreshCommanderHatState(arg_25_0, var_26_0)
			existCall(arg_25_3, var_25_0, var_26_1)
		end

		return
	end

	for iter_25_0, iter_25_1 in ipairs(var_0_0.CommanderCustom) do
		local var_25_3 = arg_25_1(iter_25_1) or 0

		if var_25_3 == 0 then
			if iter_25_1 == var_0_0.DressType.Hat then
				GraphicsInterface.Instance:SetCharacterComponentShow(arg_25_0, var_0_0.ComponentType.Headware, false, var_25_2)
			else
				var_25_2()
			end
		else
			local var_25_4 = pg.island_dress_template[var_25_3]

			if pg.island_dress_template[var_25_3] and var_25_4.face_clip ~= "" then
				var_25_0 = var_25_4.face_clip
			end

			local var_25_5 = arg_25_2 and arg_25_2(var_25_3) or 0

			var_0_0.LoadCommanderComponent(arg_25_0, var_25_3, var_25_5, var_25_2)
		end
	end

	return
end

function var_0_0.ChangeCommanderPart(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	if not arg_27_0:IsRoleValid() then
		existCall(arg_27_3)

		return
	end

	local var_27_0 = arg_27_2.id
	local var_27_1 = arg_27_0.roleTF:GetChild(0).gameObject

	arg_27_0.commanderPartTokens = arg_27_0.commanderPartTokens or {}

	local var_27_2 = arg_27_0.commanderPartTokens[arg_27_1] or 0

	arg_27_0.commanderPartTokens[arg_27_1] = var_27_2 + 1

	local var_27_3 = arg_27_0.commanderPartTokens[arg_27_1]

	arg_27_0.commanderDressDic[arg_27_1] = var_27_0

	if var_27_0 ~= 0 then
		var_0_0.LoadCommanderComponent(var_27_1, var_27_0, arg_27_2.colorId, function()
			if arg_27_0.commanderPartTokens then
				local var_28_0 = arg_27_0.commanderPartTokens[arg_27_1] or 0

				if var_27_3 ~= var_28_0 or not arg_27_0:IsRoleValid(var_27_1) then
					existCall(arg_27_3)

					return
				end

				if arg_27_1 == var_0_0.DressType.Hat then
					arg_27_0:ChangeCommanderPartShow(arg_27_1, true)
					var_0_0.RefreshCommanderHatState(var_27_1, var_27_0)
				elseif arg_27_1 == var_0_0.DressType.Hair then
					local var_28_1 = arg_27_0.commanderDressDic[var_0_0.DressType.Hat] or 0

					var_0_0.RefreshCommanderHatState(var_27_1, var_28_1)
				elseif arg_27_1 == var_0_0.DressType.Face then
					local var_28_2 = pg.island_dress_template[var_27_0].face_clip == "" and "idle" or pg.island_dress_template[var_27_0].face_clip
					local var_28_3 = var_27_1:GetComponent(typeof(Animator))

					if var_28_3 and not IsNil(var_28_3) then
						var_28_3:Play(var_28_2, 4)
					end
				elseif arg_27_1 == var_0_0.DressType.Body then
					arg_27_0:ApplyAnimatorOverride(var_27_0, arg_27_3)
				end

				return
			end
		end)
	end

	if arg_27_1 == var_0_0.DressType.Hat then
		if var_27_0 == 0 then
			arg_27_0:ChangeCommanderPartShow(arg_27_1, false)
			var_0_0.RefreshCommanderHatState(var_27_1, 0)
			existCall(arg_27_3)
		end
	elseif arg_27_1 == var_0_0.DressType.Body and var_27_0 == 0 then
		arg_27_0:ApplyAnimatorOverride(0, arg_27_3)
	end

	return
end

function var_0_0.LoadDressObjectItem(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = arg_29_0.shipId
	local var_29_1 = arg_29_0.loadingIdList or {}

	table.insert(var_29_1, (IslandAssetLoadDispatcher.Instance:Enqueue(pg.island_dress_template[arg_29_2].model, "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_30_0)
		if IsNil(arg_29_0.roleTF) then
			return
		end

		if arg_29_0.hasTF == false then
			return
		end

		local var_30_0 = arg_29_0.currentDressDataDic[arg_29_1]

		if not arg_29_0.currentDressDataDic[arg_29_1] then
			return
		end

		if var_29_0 ~= arg_29_0.shipId then
			return
		end

		if var_30_0.id ~= arg_29_2 then
			return
		end

		if arg_29_1 == var_0_0.DressType.Footprint then
			local var_30_1 = Vector3(0, 0, 0)

			if var_0.offset ~= "" then
				var_30_1 = Vector3(var_0.offset[1], var_0.offset[2], var_0.offset[3])
			end

			GetOrAddComponent(arg_29_0.roleTF, typeof(CharacterFootprintMgr)):SetFootprintPrefab(var_0.footprint_type, arg_30_0, var_30_1)
			existCall(arg_29_3)

			return
		end

		local var_30_2 = Object.Instantiate(arg_30_0)

		if arg_29_0.isScene then
			local var_30_3 = Layer.Default or Layer.Character3D

			pg.ViewUtils.SetLayer(var_30_2.transform, var_30_3)
			switch(arg_29_1, {
				[var_0_0.DressType.BackDecorate] = function()
					local var_31_0 = arg_29_0.roleTF.transform

					if var_0.attachmentPoint ~= "" then
						local var_31_1 = var_0.attachmentPoint

						var_31_0 = (function(arg_32_0)
							for iter_32_0 = 0, arg_32_0.childCount - 1 do
								local var_32_0 = arg_32_0:GetChild(iter_32_0)

								if var_32_0.name == var_31_1 then
									return var_32_0
								end

								local var_32_1 = var_0(var_32_0, var_31_1)

								if var_32_1 then
									return var_32_1
								end
							end

							return nil
						end)(var_31_0)
					end

					if var_0.offset ~= "" then
						var_30_2.transform.localPosition = Vector3(var_0.offset[1], var_0.offset[2], var_0.offset[3])
					end

					if var_0.rotation ~= "" then
						var_30_2.transform.rotation = Quaternion.Euler(var_0.rotation[1], var_0.rotation[2], var_0.rotation[3])
					end

					if var_0.scale ~= "" then
						var_30_2.transform.localScale = Vector3(var_0.scale[1], var_0.scale[1], var_0.scale[1])
					end

					setParent(var_30_2, var_31_0)

					return
				end,
				[var_0_0.DressType.Flotage] = function()
					local var_33_0

					if var_0.offset ~= "" then
						var_33_0 = Vector3(var_0.offset[1], var_0.offset[2], var_0.offset[3])

						local var_33_1 = GameObject.New(var_30_2.name)

						setParent(var_30_2.transform, var_33_1.transform, false)

						var_30_2 = var_33_1
						var_30_2.transform.position = arg_29_0.roleTF:GetChild(0).transform:TransformPoint(var_33_0)
					end

					if var_0.scale ~= "" then
						var_30_2.transform.localScale = Vector3(var_0.scale[1], var_0.scale[1], var_0.scale[1])
					end

					local var_33_2 = Vector3(0, 0, 0)

					if var_0.rotation ~= "" then
						var_33_2 = Vector3(var_0.rotation[1], var_0.rotation[2], var_0.rotation[3])
					end

					var_30_2.transform.rotation = var_33_2

					local var_33_3 = GetOrAddComponent(var_30_2, typeof(DressFlow))

					var_33_3.target = arg_29_0.roleTF
					var_33_3.delayTime = pg.island_set.island_dress_follow_param.key_value_varchar[1]
					var_33_3.lerpSpeed = pg.island_set.island_dress_follow_param.key_value_varchar[2]
					var_33_3.recordInterval = pg.island_set.island_dress_follow_param.key_value_varchar[3]

					if not not var_33_0 then
						var_33_3.offset = var_33_0
					end

					if not not var_33_2 then
						var_33_3.rotationOffest = var_33_2
					end

					return
				end
			})

			arg_29_0.pageDressTFDic[arg_29_2] = var_30_2

			existCall(arg_29_3, var_30_2)

			return
		end
	end), true, true)))

	return
end

function var_0_0.ChangeDressObject(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	if arg_34_0.currentDressDataDic[arg_34_1] then
		local var_34_0 = arg_34_0.currentDressDataDic[arg_34_1].id or 0

		if var_34_0 then
			if var_34_0 == arg_34_2.id then
				return
			end

			if var_34_0 ~= 0 then
				if arg_34_1 == var_0_0.DressType.Footprint then
					arg_34_0:ResetFootprint()
				else
					local var_34_1 = arg_34_0.pageDressTFDic[var_34_0]

					if arg_34_0.pageDressTFDic[var_34_0] then
						Object.Destroy(var_34_1)

						arg_34_0.pageDressTFDic[var_34_0] = nil
					end
				end

				arg_34_0.currentDressDataDic[arg_34_1] = nil
			end
		end

		if arg_34_2.id == 0 then
			return
		end

		arg_34_0.currentDressDataDic[arg_34_1] = arg_34_2

		arg_34_0:LoadDressObjectItem(arg_34_1, arg_34_2.id, arg_34_3)

		return
	end
end

function var_0_0.ChangeDressByType(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	if not arg_35_0.hasTF then
		arg_35_0.dataAfterRoleInit[arg_35_1] = arg_35_2

		return
	end

	if table.contains(var_0_0.CommanderCustom, arg_35_1) then
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

	GraphicsInterface.Instance:SetCharacterComponentShow(arg_36_0.roleTF:GetChild(0).gameObject, var_0_0.ComponentType.Headware, arg_36_2)

	return
end

function var_0_0.ChangeModelTransfromByUnitId(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	arg_37_0.gcCnt = arg_37_0.gcCnt + 1
	arg_37_0.hasTF = false
	arg_37_0.commanderPartTokens = {}

	local var_37_0 = arg_37_0.animatorOverrideToken or 0

	arg_37_0.animatorOverrideToken = var_37_0 + 1

	arg_37_0:StopMorphSwitch()
	arg_37_0:RemoveDressTF()

	arg_37_0.dataAfterRoleInit = arg_37_0.currentDressDataDic
	arg_37_0.currentDressDataDic = {}

	pg.UIMgr.GetInstance():LoadingOn()
	_IslandCore:GetPoolMgr():ReturnCharacterModel(arg_37_0.modelData.model, arg_37_0.modelData.animator, arg_37_0.roleTF:GetChild(0).gameObject, true)

	arg_37_0.modelData = {
		model = pg.island_unit_character[arg_37_1].model,
		animator = pg.island_unit_character[arg_37_1].animator,
		personal_ani = pg.island_unit_character[arg_37_1].personal_ani
	}

	_IslandCore:GetPoolMgr():GetCharacterModel(arg_37_0.modelData.model, arg_37_0.modelData.animator, function(arg_38_0)
		pg.UIMgr.GetInstance():LoadingOff()

		arg_37_0.hasTF = true

		if arg_37_0.isScene then
			local var_38_0 = Layer.Default or Layer.Character3D

			pg.ViewUtils.SetLayer(arg_38_0.transform, var_38_0)
			setParent(arg_38_0.transform, arg_37_0.roleTF, false)
			arg_37_0:InitDressTF()

			if arg_37_3 then
				if arg_37_0.modelData.personal_ani and arg_37_0.modelData.personal_ani ~= "" then
					local var_38_1 = GetOrAddComponent(arg_37_0.roleTF.transform:GetChild(0), typeof(Animator))

					for iter_38_0 = 1, var_38_1.layerCount do
						var_38_1:CrossFadeInFixedTime(arg_37_0.modelData.personal_ani, 0, iter_38_0 - 1)
					end
				end
			end

			existCall(arg_37_2, arg_37_0.roleTF)

			return
		end
	end, true)

	if arg_37_0.gcCnt >= 5 then
		arg_37_0.gcCnt = 0

		IslandHelper.RunGC(true)
	end

	return
end

function var_0_0.ChangeModelTransfromByUnitIdAndChangeDress(arg_39_0, arg_39_1, arg_39_2, arg_39_3, arg_39_4, arg_39_5)
	arg_39_0.hasTF = false
	arg_39_0.commanderPartTokens = {}

	local var_39_0 = arg_39_0.animatorOverrideToken or 0

	arg_39_0.animatorOverrideToken = var_39_0 + 1

	arg_39_0:StopMorphSwitch()
	arg_39_0:RemoveDressTF()

	arg_39_0.dataAfterRoleInit = arg_39_0.currentDressDataDic

	for iter_39_0, iter_39_1 in ipairs(arg_39_2 or {}) do
		if arg_39_0.dataAfterRoleInit[pg.island_dress_template[iter_39_1].type].id == iter_39_1 then
			arg_39_0.dataAfterRoleInit[pg.island_dress_template[iter_39_1].type] = nil
		end
	end

	for iter_39_2, iter_39_3 in ipairs(arg_39_3 or {}) do
		arg_39_0.dataAfterRoleInit[pg.island_dress_template[iter_39_3].type] = {
			colorId = 0,
			id = iter_39_3
		}
	end

	arg_39_0.currentDressDataDic = {}

	_IslandCore:GetPoolMgr():ReturnCharacterModel(arg_39_0.modelData.model, arg_39_0.modelData.animator, arg_39_0.roleTF:GetChild(0).gameObject, true)

	arg_39_0.modelData = {
		model = pg.island_unit_character[arg_39_1].model,
		animator = pg.island_unit_character[arg_39_1].animator,
		personal_ani = pg.island_unit_character[arg_39_1].personal_ani
	}

	_IslandCore:GetPoolMgr():GetCharacterModel(arg_39_0.modelData.model, arg_39_0.modelData.animator, function(arg_40_0)
		arg_39_0.hasTF = true

		if arg_39_0.isScene then
			local var_40_0 = Layer.Default or Layer.Character3D

			pg.ViewUtils.SetLayer(arg_40_0.transform, var_40_0)
			setParent(arg_40_0.transform, arg_39_0.roleTF, false)
			arg_39_0:InitDressTF()

			if arg_39_5 then
				if arg_39_0.modelData.personal_ani and arg_39_0.modelData.personal_ani ~= "" then
					local var_40_1 = GetOrAddComponent(arg_39_0.roleTF.transform:GetChild(0), typeof(Animator))

					for iter_40_0 = 1, var_40_1.layerCount do
						var_40_1:CrossFadeInFixedTime(arg_39_0.modelData.personal_ani, 0, iter_40_0 - 1)
					end
				end
			end

			existCall(arg_39_4, arg_39_0.roleTF)

			return
		end
	end, true)

	return
end

function var_0_0.ApplyAnimatorOverride(arg_41_0, arg_41_1, arg_41_2)
	if not arg_41_0.hasTF then
		existCall(arg_41_2)

		return
	end

	if IsNil(arg_41_0.roleTF) then
		existCall(arg_41_2)

		return
	end

	local var_41_0 = arg_41_0.roleTF:GetChild(0).gameObject

	if not var_41_0:GetComponent(typeof(Animator)) then
		existCall(arg_41_2)

		return
	end

	local var_41_1 = arg_41_0.animatorOverrideToken or 0

	arg_41_0.animatorOverrideToken = var_41_1 + 1

	local var_41_2 = arg_41_0.animatorOverrideToken

	if arg_41_1 ~= 0 then
		local var_41_3 = pg.island_dress_template[arg_41_1] or nil

		if var_41_3 then
			local var_41_4 = var_41_3.special_animator or ""

			if var_41_4 == "" then
				var_0_0.LoadCommanderBaseAnimator(function(arg_42_0)
					if IsNil(arg_41_0.roleTF) then
						existCall(arg_41_2)

						return
					end

					if not arg_41_0.hasTF then
						existCall(arg_41_2)

						return
					end

					if var_41_2 ~= arg_41_0.animatorOverrideToken then
						existCall(arg_41_2)

						return
					end

					local var_42_0 = arg_41_0.roleTF:GetChild(0).gameObject:GetComponent(typeof(Animator))

					if var_42_0 and not IsNil(var_42_0) and arg_42_0 then
						var_42_0.runtimeAnimatorController = arg_42_0

						var_42_0:Rebind()
						var_42_0:Update(0)
						var_42_0:Play("idle", 4)
					end

					existCall(arg_41_2)

					return
				end)

				return
			end

			IslandAssetLoadDispatcher.Instance:Enqueue(var_41_4, "", typeof(UnityEngine.RuntimeAnimatorController), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_43_0)
				if IsNil(arg_41_0.roleTF) then
					existCall(arg_41_2)

					return
				end

				if not arg_41_0.hasTF then
					existCall(arg_41_2)

					return
				end

				if var_41_2 ~= arg_41_0.animatorOverrideToken then
					existCall(arg_41_2)

					return
				end

				local var_43_0 = arg_41_0.roleTF:GetChild(0).gameObject:GetComponent(typeof(Animator))

				if var_43_0 and not IsNil(var_43_0) then
					var_43_0.runtimeAnimatorController = arg_43_0
				end

				existCall(arg_41_2)

				return
			end), true, true)

			return
		end
	end
end

function var_0_0.Destroy(arg_44_0)
	arg_44_0.curIsland = nil
	arg_44_0.hasTF = false
	arg_44_0.commanderPartTokens = {}

	local var_44_0 = arg_44_0.animatorOverrideToken or 0

	arg_44_0.animatorOverrideToken = var_44_0 + 1

	arg_44_0:StopMorphSwitch()
	arg_44_0:RemoveDressTF()

	local var_44_1 = arg_44_0.loadingIdList or {}

	for iter_44_0, iter_44_1 in ipairs(var_44_1) do
		IslandAssetLoadDispatcher.Instance:Cancel(iter_44_1)
	end

	arg_44_0.loadingIdList = nil
	arg_44_0.roleTF = nil

	return
end

function var_0_0.InvalidateRole(arg_45_0)
	arg_45_0.hasTF = false
	arg_45_0.commanderPartTokens = {}

	local var_45_0 = arg_45_0.animatorOverrideToken or 0

	arg_45_0.animatorOverrideToken = var_45_0 + 1

	arg_45_0:StopMorphSwitch()

	arg_45_0.roleTF = nil

	return
end

function var_0_0.ResetDressUp(arg_46_0)
	local var_46_0 = getProxy(IslandProxy):GetIsland()

	if arg_46_0.shipId == 0 then
		local var_46_1 = var_46_0:GetDressUpAgency()

		for iter_46_0, iter_46_1 in ipairs({
			var_0_0.DressType.BackDecorate,
			var_0_0.DressType.Flotage,
			var_0_0.DressType.Footprint
		}) do
			local var_46_2 = var_46_1:GetDressByType(iter_46_1) or 0

			;({
				id = var_46_2
			}).colorId = 0

			arg_46_0:ChangeDressByType(iter_46_1, {
				id = var_46_2
			})
		end
	else
		local var_46_5 = var_46_0:GetCharacterAgency()

		for iter_46_2, iter_46_3 in ipairs({
			var_0_0.DressType.BackDecorate,
			var_0_0.DressType.Flotage,
			var_0_0.DressType.Footprint
		}) do
			local var_46_6 = var_46_5:GetCurDressIdByShipId(arg_46_0.shipId, iter_46_3) or {}

			;({
				colorId = 0
			}).id = var_46_6.dress_id or 0

			arg_46_0:ChangeDressByType(iter_46_3, {
				colorId = 0
			})
		end
	end

	return
end

function var_0_0.DoMorphSwitch(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	local var_47_0 = arg_47_0.roleTF
	local var_47_1 = arg_47_0.roleTF and var_47_0.childCount > 0 and var_47_0:GetChild(0)
	local var_47_2 = var_47_1 and var_47_1.gameObject:GetComponent(typeof(Animator))

	if not var_47_2 then
		existCall(arg_47_3)

		return
	end

	arg_47_0:StopMorphSwitch()

	arg_47_0.morphTimer = var_0_0.PlayMorphAndWait(var_47_2, pg.island_dress_template[arg_47_1].cut_out_state, arg_47_1, function()
		arg_47_0.morphTimer = nil

		existCall(arg_47_3, arg_47_2)

		return
	end)

	return
end

function var_0_0.StopMorphSwitch(arg_49_0)
	if arg_49_0.morphTimer then
		arg_49_0.morphTimer:Stop()

		arg_49_0.morphTimer = nil
	end

	return
end

function var_0_0.PlayMorphAndWait(arg_50_0, arg_50_1, arg_50_2, arg_50_3)
	for iter_50_0 = 1, arg_50_0.layerCount do
		arg_50_0:CrossFadeInFixedTime(arg_50_1, 0, iter_50_0 - 1)
	end

	if pg.island_dress_template[arg_50_2] then
		local var_50_0 = pg.island_dress_template[arg_50_2].morph_wait_frames or 30
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
				var_50_5:Stop()

				var_50_5 = nil
			end

			if var_50_6 then
				var_50_6:Stop()

				var_50_6 = nil
			end

			existCall(arg_50_3)

			return
		end

		FrameTimer.New(function()
			if IsNil(arg_50_0) then
				var_50_7()

				return
			end

			if arg_50_0:IsInTransition(0) then
				return
			end

			local var_53_0 = arg_50_0:GetCurrentAnimatorStateInfo(0)

			if var_53_0:IsName(arg_50_1) then
				var_50_4 = true
			end

			if var_50_4 and var_53_0.normalizedTime >= 1 then
				var_50_7()
			end

			return
		end, 1, -1).Start(nil)

		var_50_6 = Timer.New(function()
			if var_50_3 then
				return
			end

			if var_50_2 then
				return
			end

			var_50_2 = true

			if var_50_5 then
				var_50_5:Stop()

				var_50_5 = nil
			end

			if var_50_6 then
				var_50_6:Stop()

				var_50_6 = nil
			end

			existCall(arg_50_3)

			return
		end, var_50_1, 1)

		var_50_6:Start()

		return {
			Stop = function()
				if var_50_2 then
					return
				end

				var_50_3 = true
				var_50_2 = true

				if var_50_5 then
					var_50_5:Stop()

					var_50_5 = nil
				end

				if var_50_6 then
					var_50_6:Stop()

					var_50_6 = nil
				end

				return
			end
		}
	end
end

return var_0_0
