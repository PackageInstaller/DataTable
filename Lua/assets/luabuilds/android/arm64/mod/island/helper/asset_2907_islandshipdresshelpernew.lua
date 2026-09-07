local IslandShipDressHelperNew = class("IslandShipDressHelperNew")

IslandShipDressHelperNew.DressType = {
	Flotage = 2,
	Face = 5,
	Hat = 7,
	Body = 6,
	Footprint = 3,
	BackDecorate = 1,
	Hair = 4
}
IslandShipDressHelperNew.CommanderCustom = {
	IslandShipDressHelperNew.DressType.Hair,
	IslandShipDressHelperNew.DressType.Face,
	IslandShipDressHelperNew.DressType.Body,
	IslandShipDressHelperNew.DressType.Hat
}
IslandShipDressHelperNew.ExtraDressType = {
	IslandShipDressHelperNew.DressType.BackDecorate,
	IslandShipDressHelperNew.DressType.Flotage,
	IslandShipDressHelperNew.DressType.Footprint
}
IslandShipDressHelperNew.ComponentType = {
	Face = 2,
	Body = 1,
	Headware = 4,
	Hair = 3
}
IslandShipDressHelperNew.DressType2ComponentType = {
	[IslandShipDressHelperNew.DressType.Body] = IslandShipDressHelperNew.ComponentType.Body,
	[IslandShipDressHelperNew.DressType.Face] = IslandShipDressHelperNew.ComponentType.Face,
	[IslandShipDressHelperNew.DressType.Hair] = IslandShipDressHelperNew.ComponentType.Hair,
	[IslandShipDressHelperNew.DressType.Hat] = IslandShipDressHelperNew.ComponentType.Headware
}

function IslandShipDressHelperNew:Ctor(arg_1_1)
	if arg_1_1 then
		self.curIsland = arg_1_1
		self.isOtherIsland = getProxy(PlayerProxy):getRawData().id ~= self.curIsland.id
	end

	self.gcCnt = 0

	return
end

function IslandShipDressHelperNew:GetInitDressByType()
	local function var_2_0(arg_3_0)
		for iter_3_0, iter_3_1 in ipairs(pg.island_set.default_dress.key_value_varchar) do
			if pg.island_dress_template[iter_3_1].type == arg_3_0 then
				return iter_3_1
			end
		end

		return 0
	end

	if self == IslandShipDressHelperNew.DressType.Hat then
		return pg.island_dress_template.get_id_list_by_related_dress[var_2_0(IslandShipDressHelperNew.DressType.Body)][1]
	end

	return var_2_0(self)
end

function IslandShipDressHelperNew:PreLoadVisterDressupItem(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	self.roleTF = arg_4_1.transform
	self.isScene = true
	self.shipId = 0
	self.playerId = arg_4_2
	self.hasTF = true
	self.currentDressDataDic = {}
	self.pageDressTFDic = {}

	local var_4_0 = {
		IslandShipDressHelperNew.DressType.BackDecorate,
		IslandShipDressHelperNew.DressType.Flotage,
		IslandShipDressHelperNew.DressType.Footprint
	}
	local var_4_1

	if arg_4_3 then
		var_4_1 = getProxy(IslandProxy):GetIsland() or getProxy(IslandProxy):GetSharedIsland()
	end

	local var_4_2 = var_4_1:GetVisitorAgency():GetPlayer(self.playerId)
	local var_4_3 = 0

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		local var_4_4 = var_4_2:GetDressByType(iter_4_1)

		if var_4_4 and var_4_4 ~= 0 then
			local var_4_5 = {
				id = var_4_4
			}

			var_4_5.colorId = 0
			self.currentDressDataDic[iter_4_1] = var_4_5
			var_4_3 = var_4_3 + 1
		end
	end

	self:InitVisterCustomDressData(arg_4_2, var_4_1)

	if var_4_3 == 0 then
		arg_4_4()

		return
	end

	local var_4_6 = 0

	for iter_4_2, iter_4_3 in pairs(self.currentDressDataDic) do
		self:LoadDressObjectItem(iter_4_2, iter_4_3.id, function()
			var_4_6 = var_4_6 + 1

			if var_4_6 == var_4_3 then
				arg_4_4()
			end

			return
		end)
	end

	return
end

function IslandShipDressHelperNew:InitVisterCustomDressData(arg_6_1, arg_6_2)
	self.commanderDressDic = {}

	local var_6_0 = arg_6_2:GetVisitorAgency():GetPlayer(self.playerId)

	for iter_6_0, iter_6_1 in pairs(IslandShipDressHelperNew.CommanderCustom) do
		local var_6_1 = var_6_0:GetDressByType(iter_6_1)

		if var_6_1 then
			self.commanderDressDic[iter_6_1] = var_6_1
		end
	end

	return
end

function IslandShipDressHelperNew:PreLoadShipDressupItem(arg_7_1, arg_7_2, arg_7_3)
	self.roleTF = arg_7_1.transform
	self.isScene = true
	self.shipId = arg_7_2
	self.hasTF = true
	self.currentDressDataDic = {}
	self.pageDressTFDic = {}

	local var_7_0 = {
		IslandShipDressHelperNew.DressType.BackDecorate,
		IslandShipDressHelperNew.DressType.Flotage,
		IslandShipDressHelperNew.DressType.Footprint
	}
	local var_7_1 = getProxy(IslandProxy):GetIsland()

	if self.shipId == 0 then
		local var_7_2 = var_7_1:GetDressUpAgency()
		local var_7_3 = 0

		for iter_7_0, iter_7_1 in ipairs(var_7_0) do
			local var_7_4 = var_7_2:GetDressByType(iter_7_1)

			if var_7_4 and var_7_4 ~= 0 then
				local var_7_5 = {
					id = var_7_4
				}

				var_7_5.colorId = 0
				self.currentDressDataDic[iter_7_1] = var_7_5
				var_7_3 = var_7_3 + 1
			end
		end

		self:InitCommanderCustomDressData()

		if var_7_3 == 0 then
			arg_7_3()

			return
		end

		local var_7_6 = 0

		for iter_7_2, iter_7_3 in pairs(self.currentDressDataDic) do
			self:LoadDressObjectItem(iter_7_2, iter_7_3.id, function()
				var_7_6 = var_7_6 + 1

				if var_7_6 == var_7_3 then
					arg_7_3()
				end

				return
			end)
		end
	else
		if self.isOtherIsland then
			arg_7_3()

			return
		end

		local var_7_7 = var_7_1:GetCharacterAgency()

		self.modelData = var_7_7:GetShipById(self.shipId):GetModel()

		local var_7_8 = 0

		for iter_7_4, iter_7_5 in pairs(var_7_0) do
			local var_7_9 = var_7_7:GetCurDressIdByShipId(self.shipId, iter_7_5)

			if var_7_9 then
				local var_7_10 = {
					id = var_7_9.dress_id
				}

				var_7_10.colorId = 0
				self.currentDressDataDic[iter_7_5] = var_7_10
				var_7_8 = var_7_8 + 1
			end
		end

		if var_7_8 == 0 then
			arg_7_3()

			return
		end

		local var_7_11 = 0

		for iter_7_6, iter_7_7 in pairs(self.currentDressDataDic) do
			self:LoadDressObjectItem(iter_7_6, iter_7_7.id, function()
				var_7_11 = var_7_11 + 1

				if var_7_11 == var_7_8 then
					arg_7_3()
				end

				return
			end)
		end
	end

	return
end

function IslandShipDressHelperNew:SetShipId(arg_10_1)
	self.shipId = arg_10_1
	self.hasTF = false
	self.currentDressDataDic = {}
	self.dataAfterRoleInit = {}

	self:RemoveDressTF()
	self:InitDressData()

	return
end

function IslandShipDressHelperNew:InitCommanderCustomDressData()
	self.commanderDressDic = {}

	local var_11_0 = getProxy(IslandProxy):GetIsland():GetDressUpAgency()

	for iter_11_0, iter_11_1 in pairs(IslandShipDressHelperNew.CommanderCustom) do
		local var_11_1 = var_11_0:GetDressByType(iter_11_1)

		if var_11_1 then
			self.commanderDressDic[iter_11_1] = var_11_1
		end
	end

	return
end

function IslandShipDressHelperNew:InitDressData()
	local var_12_0 = {
		IslandShipDressHelperNew.DressType.BackDecorate,
		IslandShipDressHelperNew.DressType.Flotage,
		IslandShipDressHelperNew.DressType.Footprint
	}
	local var_12_1 = getProxy(IslandProxy):GetIsland()

	if self.shipId == 0 then
		local var_12_2 = var_12_1:GetDressUpAgency()

		for iter_12_0, iter_12_1 in pairs(var_12_0) do
			local var_12_3 = var_12_2:GetDressByType(iter_12_1)

			if var_12_3 then
				local var_12_4 = {
					id = var_12_3
				}

				var_12_4.colorId = 0
				self.dataAfterRoleInit[iter_12_1] = var_12_4
			end
		end

		self:InitCommanderCustomDressData()
	else
		local var_12_5 = var_12_1:GetCharacterAgency()

		for iter_12_2, iter_12_3 in pairs(var_12_0) do
			local var_12_6 = var_12_5:GetCurDressIdByShipId(self.shipId, iter_12_3)

			if var_12_6 then
				local var_12_7 = {
					id = var_12_6.dress_id
				}

				var_12_7.colorId = 0
				self.dataAfterRoleInit[iter_12_3] = var_12_7
			end
		end
	end

	return
end

function IslandShipDressHelperNew:InitDressTF(arg_13_1)
	for iter_13_0, iter_13_1 in pairs(self.dataAfterRoleInit) do
		self:ChangeDressByType(iter_13_0, iter_13_1, arg_13_1)
	end

	self.dataAfterRoleInit = {}

	return
end

function IslandShipDressHelperNew:OnRoleLoaded(arg_14_1, arg_14_2, arg_14_3)
	self.modelData = arg_14_2
	self.roleTF = arg_14_1
	self.hasTF = true
	self.commanderPartTokens = {}

	self:InitDressTF(arg_14_3)

	return
end

function IslandShipDressHelperNew:IsRoleValid(arg_15_1)
	if not self.hasTF then
		return false
	end

	if not self.roleTF or IsNil(self.roleTF) or self.roleTF.childCount <= 0 then
		return false
	end

	if arg_15_1 and IsNil(arg_15_1) then
		return false
	end

	return true
end

function IslandShipDressHelperNew:ResetFootprint()
	if not self.roleTF or IsNil(self.roleTF) then
		return
	end

	local var_16_0 = self.roleTF:GetComponent(typeof(CharacterFootprintMgr))

	if var_16_0 then
		var_16_0:ResetFootprint()
	end

	return
end

function IslandShipDressHelperNew:RemoveDressTF()
	for iter_17_0, iter_17_1 in pairs(self.pageDressTFDic or {}) do
		Object.Destroy(iter_17_1.gameObject)
	end

	self.pageDressTFDic = {}

	self:ResetFootprint()

	return
end

function IslandShipDressHelperNew:ChangeCommanderPartColor(arg_18_1, arg_18_2)
	if not IslandShipDressHelperNew.DressType2ComponentType[arg_18_1] then
		return
	end

	if not self:IsRoleValid() then
		return
	end

	if arg_18_2 == 0 then
		GraphicsInterface.Instance:ResetCharacterComponentMaterialData(self.roleTF:GetChild(0).gameObject, IslandShipDressHelperNew.DressType2ComponentType[arg_18_1])
	else
		GraphicsInterface.Instance:SetCharacterComponentMaterialData(self.roleTF:GetChild(0).gameObject, pg.island_dress_colordiff_template[arg_18_2].model)
	end

	return
end

function IslandShipDressHelperNew:SetCommanderHairBlendShape(arg_19_1)
	if not arg_19_1 or arg_19_1 == 0 then
		GraphicsInterface.Instance:SetCharacterBlendShape(self, IslandShipDressHelperNew.ComponentType.Hair, 0, 0)
		GraphicsInterface.Instance:SetCharacterBlendShape(self, IslandShipDressHelperNew.ComponentType.Hair, 1, 0)

		return
	end

	local var_19_0 = pg.island_dress_template[arg_19_1]

	if not pg.island_dress_template[arg_19_1] then
		return
	end

	local var_19_1 = var_19_0.sub_type - 1

	GraphicsInterface.Instance:SetCharacterBlendShape(self, IslandShipDressHelperNew.ComponentType.Hair, var_19_0.sub_type - 1, 100)
	GraphicsInterface.Instance:SetCharacterBlendShape(self, IslandShipDressHelperNew.ComponentType.Hair, 1 - var_19_1, 0)

	return
end

function IslandShipDressHelperNew:SetCommanderHairAndFaceShow(arg_20_1)
	GraphicsInterface.Instance:SetCharacterComponentShow(self, IslandShipDressHelperNew.ComponentType.Hair, arg_20_1)
	GraphicsInterface.Instance:SetCharacterComponentShow(self, IslandShipDressHelperNew.ComponentType.Face, arg_20_1)

	return
end

function IslandShipDressHelperNew:RefreshCommanderHatState(arg_21_1)
	IslandShipDressHelperNew.SetCommanderHairBlendShape(self, arg_21_1)
	IslandShipDressHelperNew.SetCommanderHairAndFaceShow(self, (arg_21_1 and arg_21_1 ~= 0 or nil) and (not pg.island_dress_template[arg_21_1] or pg.island_dress_template[arg_21_1].head_hide ~= 1))

	return
end

function IslandShipDressHelperNew:LoadCommanderComponent(arg_22_1, arg_22_2, arg_22_3)
	if not pg.island_dress_template[arg_22_1] then
		existCall(arg_22_3)

		return
	end

	local var_22_0 = pg.island_dress_template[arg_22_1].model

	if arg_22_2 == 0 or arg_22_2 == nil then
		GraphicsInterface.Instance:LoadCharacterComponent(self, var_22_0, arg_22_3)
	else
		GraphicsInterface.Instance:LoadCharacterComponentAndMaterial(self, var_22_0, pg.island_dress_colordiff_template[arg_22_2].model, arg_22_3)
	end

	return
end

function IslandShipDressHelperNew:LoadCommanderBaseAnimator()
	if IslandShipDressHelperNew.CommanderBaseRuntimeController then
		existCall(self, IslandShipDressHelperNew.CommanderBaseRuntimeController)

		return
	end

	local var_23_0

	if pg.island_unit_character[0] then
		var_23_0 = pg.island_unit_character[0].animator or ""

		if var_23_0 == "" then
			existCall(self)

			return
		end
	end

	IslandAssetLoadDispatcher.Instance:Enqueue(var_23_0, "", typeof(RuntimeAnimatorController), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_24_0)
		IslandShipDressHelperNew.CommanderBaseRuntimeController = arg_24_0

		existCall(self, arg_24_0)

		return
	end), true, true)

	return
end

function IslandShipDressHelperNew:BuildCommanderCustomParts(arg_25_1, arg_25_2, arg_25_3)
	local var_25_0
	local var_25_1 = 0

	local function var_25_2()
		var_25_1 = var_25_1 + 1

		if var_25_1 == #IslandShipDressHelperNew.CommanderCustom then
			local var_26_0 = arg_25_1(IslandShipDressHelperNew.DressType.Hat) or 0
			local var_26_1 = arg_25_1(IslandShipDressHelperNew.DressType.Body) or 0

			IslandShipDressHelperNew.RefreshCommanderHatState(self, var_26_0)
			existCall(arg_25_3, var_25_0, var_26_1)
		end

		return
	end

	for iter_25_0, iter_25_1 in ipairs(IslandShipDressHelperNew.CommanderCustom) do
		local var_25_3 = arg_25_1(iter_25_1) or 0

		if var_25_3 == 0 then
			if iter_25_1 == IslandShipDressHelperNew.DressType.Hat then
				GraphicsInterface.Instance:SetCharacterComponentShow(self, IslandShipDressHelperNew.ComponentType.Headware, false, var_25_2)
			else
				var_25_2()
			end
		else
			local var_25_4 = pg.island_dress_template[var_25_3]

			if pg.island_dress_template[var_25_3] and var_25_4.face_clip ~= "" then
				var_25_0 = var_25_4.face_clip
			end

			IslandShipDressHelperNew.LoadCommanderComponent(self, var_25_3, arg_25_2 and arg_25_2(var_25_3) or 0, var_25_2)
		end
	end

	return
end

function IslandShipDressHelperNew:ChangeCommanderPart(arg_27_1, arg_27_2, arg_27_3)
	if not self:IsRoleValid() then
		existCall(arg_27_3)

		return
	end

	local var_27_0 = arg_27_2.id
	local var_27_1 = self.roleTF:GetChild(0).gameObject

	self.commanderPartTokens = self.commanderPartTokens or {}
	self.commanderPartTokens[arg_27_1] = (self.commanderPartTokens[arg_27_1] or 0) + 1

	local var_27_2 = self.commanderPartTokens[arg_27_1]

	self.commanderDressDic[arg_27_1] = var_27_0

	if var_27_0 ~= 0 then
		IslandShipDressHelperNew.LoadCommanderComponent(var_27_1, var_27_0, arg_27_2.colorId, function()
			if self.commanderPartTokens then
				if var_27_2 ~= (self.commanderPartTokens[arg_27_1] or 0) or not self:IsRoleValid(var_27_1) then
					existCall(arg_27_3)

					return
				end

				if arg_27_1 == IslandShipDressHelperNew.DressType.Hat then
					self:ChangeCommanderPartShow(arg_27_1, true)
					IslandShipDressHelperNew.RefreshCommanderHatState(var_27_1, var_27_0)
				elseif arg_27_1 == IslandShipDressHelperNew.DressType.Hair then
					IslandShipDressHelperNew.RefreshCommanderHatState(var_27_1, self.commanderDressDic[IslandShipDressHelperNew.DressType.Hat] or 0)
				elseif arg_27_1 == IslandShipDressHelperNew.DressType.Face then
					local var_28_2 = pg.island_dress_template[var_27_0].face_clip == "" and "idle" or pg.island_dress_template[var_27_0].face_clip
					local var_28_3 = var_27_1:GetComponent(typeof(Animator))

					if var_28_3 and not IsNil(var_28_3) then
						var_28_3:Play(var_28_2, 4)
					end
				elseif arg_27_1 == IslandShipDressHelperNew.DressType.Body then
					self:ApplyAnimatorOverride(var_27_0, arg_27_3)
				end
			end

			return
		end)
	end

	if arg_27_1 == IslandShipDressHelperNew.DressType.Hat then
		if var_27_0 == 0 then
			self:ChangeCommanderPartShow(arg_27_1, false)
			IslandShipDressHelperNew.RefreshCommanderHatState(var_27_1, 0)
			existCall(arg_27_3)
		end
	elseif arg_27_1 == IslandShipDressHelperNew.DressType.Body and var_27_0 == 0 then
		self:ApplyAnimatorOverride(0, arg_27_3)
	end

	return
end

function IslandShipDressHelperNew:LoadDressObjectItem(arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = pg.island_dress_template[arg_29_2]
	local var_29_1 = self.shipId

	table.insert(self.loadingIdList or {}, (IslandAssetLoadDispatcher.Instance:Enqueue(pg.island_dress_template[arg_29_2].model, "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_30_0)
		if IsNil(self.roleTF) then
			return
		end

		if self.hasTF == false then
			return
		end

		local var_30_0 = self.currentDressDataDic[arg_29_1]

		if not self.currentDressDataDic[arg_29_1] then
			return
		end

		if var_29_1 ~= self.shipId then
			return
		end

		if var_30_0.id ~= arg_29_2 then
			return
		end

		if arg_29_1 == IslandShipDressHelperNew.DressType.Footprint then
			local var_30_1 = Vector3(0, 0, 0)

			GetOrAddComponent(self.roleTF, typeof(CharacterFootprintMgr)):SetFootprintPrefab(var_29_0.footprint_type, arg_30_0, (var_29_0.offset ~= "" or nil) and Vector3(var_29_0.offset[1], var_29_0.offset[2], var_29_0.offset[3]))
			existCall(arg_29_3)

			return
		end

		local var_30_2 = Object.Instantiate(arg_30_0)

		pg.ViewUtils.SetLayer(var_30_2.transform, (self.isScene or nil) and (Layer.Default or Layer.Character3D))
		switch(arg_29_1, {
			[IslandShipDressHelperNew.DressType.BackDecorate] = function()
				local var_31_0 = self.roleTF.transform

				if var_29_0.attachmentPoint ~= "" then
					local var_31_1 = var_29_0.attachmentPoint

					local function var_31_2(arg_32_0)
						for iter_32_0 = 0, arg_32_0.childCount - 1 do
							local var_32_0 = arg_32_0:GetChild(iter_32_0)

							if var_32_0.name == var_31_1 then
								return var_32_0
							end

							local var_32_1 = var_31_2(var_32_0, var_31_1)

							if var_32_1 then
								return var_32_1
							end
						end

						return nil
					end

					var_31_0 = var_31_2(var_31_0)
				end

				if var_29_0.offset ~= "" then
					var_30_2.transform.localPosition = Vector3(var_29_0.offset[1], var_29_0.offset[2], var_29_0.offset[3])
				end

				if var_29_0.rotation ~= "" then
					var_30_2.transform.rotation = Quaternion.Euler(var_29_0.rotation[1], var_29_0.rotation[2], var_29_0.rotation[3])
				end

				if var_29_0.scale ~= "" then
					var_30_2.transform.localScale = Vector3(var_29_0.scale[1], var_29_0.scale[1], var_29_0.scale[1])
				end

				setParent(var_30_2, var_31_0)

				return
			end,
			[IslandShipDressHelperNew.DressType.Flotage] = function()
				local var_33_0

				if var_29_0.offset ~= "" then
					var_33_0 = Vector3(var_29_0.offset[1], var_29_0.offset[2], var_29_0.offset[3])

					local var_33_1 = GameObject.New(var_30_2.name)

					setParent(var_30_2.transform, var_33_1.transform, false)

					var_30_2 = var_33_1
					var_30_2.transform.position = self.roleTF:GetChild(0).transform:TransformPoint(var_33_0)
				end

				if var_29_0.scale ~= "" then
					var_30_2.transform.localScale = Vector3(var_29_0.scale[1], var_29_0.scale[1], var_29_0.scale[1])
				end

				local var_33_2 = Vector3(0, 0, 0)

				if var_29_0.rotation ~= "" then
					var_33_2 = Vector3(var_29_0.rotation[1], var_29_0.rotation[2], var_29_0.rotation[3])
				end

				var_30_2.transform.rotation = var_33_2

				local var_33_3 = GetOrAddComponent(var_30_2, typeof(DressFlow))

				var_33_3.target = self.roleTF
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

		self.pageDressTFDic[arg_29_2] = var_30_2

		existCall(arg_29_3, var_30_2)

		return
	end), true, true)))

	return
end

function IslandShipDressHelperNew:ChangeDressObject(arg_34_1, arg_34_2, arg_34_3)
	if self.currentDressDataDic[arg_34_1] then
		local var_34_0 = self.currentDressDataDic[arg_34_1].id or 0

		if var_34_0 then
			if var_34_0 == arg_34_2.id then
				return
			end

			if var_34_0 ~= 0 then
				if arg_34_1 == IslandShipDressHelperNew.DressType.Footprint then
					self:ResetFootprint()
				elseif self.pageDressTFDic[var_34_0] then
					Object.Destroy(self.pageDressTFDic[var_34_0])

					self.pageDressTFDic[var_34_0] = nil
				end

				self.currentDressDataDic[arg_34_1] = nil
			end
		end

		if arg_34_2.id == 0 then
			return
		end
	end

	self.currentDressDataDic[arg_34_1] = arg_34_2

	self:LoadDressObjectItem(arg_34_1, arg_34_2.id, arg_34_3)

	return
end

function IslandShipDressHelperNew:ChangeDressByType(arg_35_1, arg_35_2, arg_35_3)
	if not self.hasTF then
		self.dataAfterRoleInit[arg_35_1] = arg_35_2

		return
	end

	if table.contains(IslandShipDressHelperNew.CommanderCustom, arg_35_1) then
		self:ChangeCommanderPart(arg_35_1, arg_35_2, arg_35_3)
	else
		self:ChangeDressObject(arg_35_1, arg_35_2, arg_35_3)
	end

	return
end

function IslandShipDressHelperNew:ChangeCommanderPartShow(arg_36_1, arg_36_2)
	if not self.hasTF then
		return
	end

	if not self:IsRoleValid() then
		return
	end

	GraphicsInterface.Instance:SetCharacterComponentShow(self.roleTF:GetChild(0).gameObject, IslandShipDressHelperNew.ComponentType.Headware, arg_36_2)

	return
end

function IslandShipDressHelperNew:ChangeModelTransfromByUnitId(arg_37_1, arg_37_2, arg_37_3)
	self.gcCnt = self.gcCnt + 1
	self.hasTF = false
	self.commanderPartTokens = {}
	self.animatorOverrideToken = (self.animatorOverrideToken or 0) + 1

	self:StopMorphSwitch()
	self:RemoveDressTF()

	self.dataAfterRoleInit = self.currentDressDataDic
	self.currentDressDataDic = {}

	pg.UIMgr.GetInstance():LoadingOn()
	_IslandCore:GetPoolMgr():ReturnCharacterModel(self.modelData.model, self.modelData.animator, self.roleTF:GetChild(0).gameObject, true)

	self.modelData = {
		model = pg.island_unit_character[arg_37_1].model,
		animator = pg.island_unit_character[arg_37_1].animator,
		personal_ani = pg.island_unit_character[arg_37_1].personal_ani
	}

	_IslandCore:GetPoolMgr():GetCharacterModel(self.modelData.model, self.modelData.animator, function(arg_38_0)
		pg.UIMgr.GetInstance():LoadingOff()

		self.hasTF = true

		pg.ViewUtils.SetLayer(arg_38_0.transform, (self.isScene or nil) and (Layer.Default or Layer.Character3D))
		setParent(arg_38_0.transform, self.roleTF, false)
		self:InitDressTF()

		if arg_37_3 then
			if self.modelData.personal_ani and self.modelData.personal_ani ~= "" then
				local var_38_0 = GetOrAddComponent(self.roleTF.transform:GetChild(0), typeof(Animator))

				for iter_38_0 = 1, var_38_0.layerCount do
					var_38_0:CrossFadeInFixedTime(self.modelData.personal_ani, 0, iter_38_0 - 1)
				end
			end
		end

		existCall(arg_37_2, self.roleTF)

		return
	end, true)

	if self.gcCnt >= 5 then
		self.gcCnt = 0

		IslandHelper.RunGC(true)
	end

	return
end

function IslandShipDressHelperNew:ChangeModelTransfromByUnitIdAndChangeDress(arg_39_1, arg_39_2, arg_39_3, arg_39_4, arg_39_5)
	self.hasTF = false
	self.commanderPartTokens = {}
	self.animatorOverrideToken = (self.animatorOverrideToken or 0) + 1

	self:StopMorphSwitch()
	self:RemoveDressTF()

	self.dataAfterRoleInit = self.currentDressDataDic

	for iter_39_0, iter_39_1 in ipairs(arg_39_2 or {}) do
		if self.dataAfterRoleInit[pg.island_dress_template[iter_39_1].type].id == iter_39_1 then
			self.dataAfterRoleInit[pg.island_dress_template[iter_39_1].type] = nil
		end
	end

	for iter_39_2, iter_39_3 in ipairs(arg_39_3 or {}) do
		self.dataAfterRoleInit[pg.island_dress_template[iter_39_3].type] = {
			colorId = 0,
			id = iter_39_3
		}
	end

	self.currentDressDataDic = {}

	_IslandCore:GetPoolMgr():ReturnCharacterModel(self.modelData.model, self.modelData.animator, self.roleTF:GetChild(0).gameObject, true)

	self.modelData = {
		model = pg.island_unit_character[arg_39_1].model,
		animator = pg.island_unit_character[arg_39_1].animator,
		personal_ani = pg.island_unit_character[arg_39_1].personal_ani
	}

	_IslandCore:GetPoolMgr():GetCharacterModel(self.modelData.model, self.modelData.animator, function(arg_40_0)
		self.hasTF = true

		pg.ViewUtils.SetLayer(arg_40_0.transform, (self.isScene or nil) and (Layer.Default or Layer.Character3D))
		setParent(arg_40_0.transform, self.roleTF, false)
		self:InitDressTF()

		if arg_39_5 then
			if self.modelData.personal_ani and self.modelData.personal_ani ~= "" then
				local var_40_0 = GetOrAddComponent(self.roleTF.transform:GetChild(0), typeof(Animator))

				for iter_40_0 = 1, var_40_0.layerCount do
					var_40_0:CrossFadeInFixedTime(self.modelData.personal_ani, 0, iter_40_0 - 1)
				end
			end
		end

		existCall(arg_39_4, self.roleTF)

		return
	end, true)

	return
end

function IslandShipDressHelperNew:ApplyAnimatorOverride(arg_41_1, arg_41_2)
	if not self.hasTF then
		existCall(arg_41_2)

		return
	end

	if IsNil(self.roleTF) then
		existCall(arg_41_2)

		return
	end

	if not self.roleTF:GetChild(0).gameObject:GetComponent(typeof(Animator)) then
		existCall(arg_41_2)

		return
	end

	self.animatorOverrideToken = (self.animatorOverrideToken or 0) + 1

	local var_41_0 = self.animatorOverrideToken

	if arg_41_1 ~= 0 then
		local var_41_1 = pg.island_dress_template[arg_41_1] or nil
		local var_41_2

		if var_41_1 then
			var_41_2 = var_41_1.special_animator or ""

			if var_41_2 == "" then
				IslandShipDressHelperNew.LoadCommanderBaseAnimator(function(arg_42_0)
					if IsNil(self.roleTF) then
						existCall(arg_41_2)

						return
					end

					if not self.hasTF then
						existCall(arg_41_2)

						return
					end

					if var_41_0 ~= self.animatorOverrideToken then
						existCall(arg_41_2)

						return
					end

					local var_42_0 = self.roleTF:GetChild(0).gameObject:GetComponent(typeof(Animator))

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
		end
	end

	IslandAssetLoadDispatcher.Instance:Enqueue(var_41_2, "", typeof(UnityEngine.RuntimeAnimatorController), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_43_0)
		if IsNil(self.roleTF) then
			existCall(arg_41_2)

			return
		end

		if not self.hasTF then
			existCall(arg_41_2)

			return
		end

		if var_41_0 ~= self.animatorOverrideToken then
			existCall(arg_41_2)

			return
		end

		local var_43_0 = self.roleTF:GetChild(0).gameObject:GetComponent(typeof(Animator))

		if var_43_0 and not IsNil(var_43_0) then
			var_43_0.runtimeAnimatorController = arg_43_0
		end

		existCall(arg_41_2)

		return
	end), true, true)

	return
end

function IslandShipDressHelperNew:Destroy()
	self.curIsland = nil
	self.hasTF = false
	self.commanderPartTokens = {}
	self.animatorOverrideToken = (self.animatorOverrideToken or 0) + 1

	self:StopMorphSwitch()
	self:RemoveDressTF()

	for iter_44_0, iter_44_1 in ipairs(self.loadingIdList or {}) do
		IslandAssetLoadDispatcher.Instance:Cancel(iter_44_1)
	end

	self.loadingIdList = nil
	self.roleTF = nil

	return
end

function IslandShipDressHelperNew:InvalidateRole()
	self.hasTF = false
	self.commanderPartTokens = {}
	self.animatorOverrideToken = (self.animatorOverrideToken or 0) + 1

	self:StopMorphSwitch()

	self.roleTF = nil

	return
end

function IslandShipDressHelperNew:ResetDressUp()
	local var_46_0 = getProxy(IslandProxy):GetIsland()

	if self.shipId == 0 then
		local var_46_1 = var_46_0:GetDressUpAgency()

		for iter_46_0, iter_46_1 in ipairs({
			IslandShipDressHelperNew.DressType.BackDecorate,
			IslandShipDressHelperNew.DressType.Flotage,
			IslandShipDressHelperNew.DressType.Footprint
		}) do
			local var_46_2 = var_46_1:GetDressByType(iter_46_1) or 0
			local var_46_4 = {
				id = var_46_2
			}

			var_46_4.colorId = 0

			self:ChangeDressByType(iter_46_1, var_46_4)
		end
	else
		local var_46_5 = var_46_0:GetCharacterAgency()

		for iter_46_2, iter_46_3 in ipairs({
			IslandShipDressHelperNew.DressType.BackDecorate,
			IslandShipDressHelperNew.DressType.Flotage,
			IslandShipDressHelperNew.DressType.Footprint
		}) do
			local var_46_7 = {
				colorId = 0
			}
			local var_46_8 = (var_46_5:GetCurDressIdByShipId(self.shipId, iter_46_3) or {}).dress_id

			if not (var_46_5:GetCurDressIdByShipId(self.shipId, iter_46_3) or {}).dress_id then
				var_46_7.id = 0
			end

			self:ChangeDressByType(iter_46_3, var_46_7)
		end
	end

	return
end

function IslandShipDressHelperNew:DoMorphSwitch(arg_47_1, arg_47_2, arg_47_3)
	local var_47_0 = self.roleTF
	local var_47_1 = self.roleTF and var_47_0.childCount > 0 and var_47_0:GetChild(0)
	local var_47_2 = var_47_1 and var_47_1.gameObject:GetComponent(typeof(Animator))

	if not var_47_2 then
		existCall(arg_47_3)

		return
	end

	self:StopMorphSwitch()

	self.morphTimer = IslandShipDressHelperNew.PlayMorphAndWait(var_47_2, pg.island_dress_template[arg_47_1].cut_out_state, arg_47_1, function()
		self.morphTimer = nil

		existCall(arg_47_3, arg_47_2)

		return
	end)

	return
end

function IslandShipDressHelperNew:StopMorphSwitch()
	if self.morphTimer then
		self.morphTimer:Stop()

		self.morphTimer = nil
	end

	return
end

function IslandShipDressHelperNew:PlayMorphAndWait(arg_50_1, arg_50_2, arg_50_3)
	for iter_50_0 = 1, self.layerCount do
		self:CrossFadeInFixedTime(arg_50_1, 0, iter_50_0 - 1)
	end

	local var_50_0 = ((pg.island_dress_template[arg_50_2] or nil) and (pg.island_dress_template[arg_50_2].morph_wait_frames or 30)) / 30 + 0.2
	local var_50_1 = false
	local var_50_2 = false
	local var_50_3 = false
	local var_50_4
	local var_50_5

	local function var_50_6()
		if var_50_2 then
			return
		end

		if var_50_1 then
			return
		end

		var_50_1 = true

		if var_50_4 then
			var_50_4:Stop()

			var_50_4 = nil
		end

		if var_50_5 then
			var_50_5:Stop()

			var_50_5 = nil
		end

		existCall(arg_50_3)

		return
	end

	var_50_4 = FrameTimer.New(function()
		if IsNil(self) then
			var_50_6()

			return
		end

		if self:IsInTransition(0) then
			return
		end

		local var_53_0 = self:GetCurrentAnimatorStateInfo(0)

		if var_53_0:IsName(arg_50_1) then
			var_50_3 = true
		end

		if var_50_3 and var_53_0.normalizedTime >= 1 then
			var_50_6()
		end

		return
	end, 1, -1)

	;(nil):Start()

	var_50_5 = Timer.New(var_50_6, var_50_0, 1)

	var_50_5:Start()

	return {
		Stop = function()
			if var_50_1 then
				return
			end

			var_50_2 = true
			var_50_1 = true

			if var_50_4 then
				var_50_4:Stop()

				var_50_4 = nil
			end

			if var_50_5 then
				var_50_5:Stop()

				var_50_5 = nil
			end

			return
		end
	}
end

return IslandShipDressHelperNew
