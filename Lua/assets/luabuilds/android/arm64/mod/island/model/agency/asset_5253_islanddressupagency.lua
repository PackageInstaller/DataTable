local IslandDressUpAgency = class("IslandDressUpAgency", import(".IslandBaseAgency"))

IslandDressUpAgency.CHANGE_PLAYER_DRESS = "IslandDressUpAgency:CHANGE_DRESS"
IslandDressUpAgency.MORPH_PLAYER_DRESS = "IslandDressUpAgency:MORPH_PLAYER_DRESS"

function IslandDressUpAgency:OnInit(arg_1_1)
	self.currentDressTypeDic = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.user_dress.cur_dress or {}) do
		self.currentDressTypeDic[iter_1_1.type] = iter_1_1.id
	end

	self.hasDressList = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.user_dress.had_dress or {}) do
		table.insert(self.hasDressList, IslandCommanderDressItem.New(iter_1_3))
	end

	self.cap_Dic = {}

	for iter_1_4, iter_1_5 in ipairs(arg_1_1.user_dress.cap_list) do
		self.cap_Dic[iter_1_5.dress_id] = iter_1_5.cap_id
	end

	self.twinCurDic = {}

	for iter_1_6, iter_1_7 in ipairs(arg_1_1.user_dress.twin_cur_list or {}) do
		self.twinCurDic[iter_1_7] = true
	end

	return
end

function IslandDressUpAgency:SetDressHasRead(arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(self.hasDressList) do
		if iter_2_1.id == arg_2_1 then
			iter_2_1:SetReadState(true)
		end
	end

	return
end

function IslandDressUpAgency:CheckRedDotByDressType(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(self.hasDressList) do
		if iter_3_1:getConfigTable().type == arg_3_1 and iter_3_1.state == 0 then
			return true
		end
	end

	return false
end

function IslandDressUpAgency:GetBodyHatIsOn(arg_4_1)
	return self.cap_Dic[arg_4_1] ~= 0
end

function IslandDressUpAgency:GetBodyHatDressId(arg_5_1)
	return self.cap_Dic[arg_5_1] or 0
end

function IslandDressUpAgency:SetBodyHatIsOn(arg_6_1, arg_6_2)
	self.cap_Dic[arg_6_1] = arg_6_2

	return
end

function IslandDressUpAgency:GetDressByType(arg_7_1)
	return self.currentDressTypeDic[arg_7_1]
end

function IslandDressUpAgency:GetDressUpData()
	return self.currentDressTypeDic
end

function IslandDressUpAgency:SetDressByTpye(arg_9_1, arg_9_2)
	self.currentDressTypeDic[arg_9_1] = arg_9_2

	return
end

function IslandDressUpAgency:GetAllHasDress()
	return self.hasDressList
end

function IslandDressUpAgency:GetHasDressByType(arg_11_1)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs(self.hasDressList) do
		if iter_11_1:getConfig("type") == arg_11_1 then
			table.insert(var_11_0, iter_11_1)
		end
	end

	return var_11_0
end

function IslandDressUpAgency:CheckOwnDress(arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(self.hasDressList) do
		if iter_12_1.id == arg_12_1 then
			return true
		end
	end

	return false
end

function IslandDressUpAgency:AddDressByDressId(arg_13_1)
	table.insert(self.hasDressList, IslandCommanderDressItem.New({
		color = 0,
		state = 0,
		id = arg_13_1,
		color_list = {}
	}))

	if pg.island_dress_template[arg_13_1].type == IslandShipDressHelperNew.DressType.Body then
		if (pg.island_dress_template.get_id_list_by_related_dress[arg_13_1] or {})[1] then
			self:SetBodyHatIsOn(arg_13_1, (pg.island_dress_template.get_id_list_by_related_dress[arg_13_1] or {})[1])
		end
	end

	if pg.island_dress_template[arg_13_1] and pg.island_dress_template[arg_13_1].cloth_related and pg.island_dress_template[arg_13_1].cloth_related ~= 0 then
		self.twinCurDic[pg.island_dress_template[arg_13_1].defalut_cloth == 1 and arg_13_1 or pg.island_dress_template[pg.island_dress_template[arg_13_1].cloth_related] and pg.island_dress_template[pg.island_dress_template[arg_13_1].cloth_related].defalut_cloth == 1 and pg.island_dress_template[arg_13_1].cloth_related or arg_13_1] = true
	end

	return
end

function IslandDressUpAgency:IsNew()
	return self.currentDressTypeDic[IslandShipDressHelperNew.DressType.Hair] == nil and self.currentDressTypeDic[IslandShipDressHelperNew.DressType.Face] == nil and self.currentDressTypeDic[IslandShipDressHelperNew.DressType.Body] == nil
end

function IslandDressUpAgency:GetHairFaceBodyDress()
	return self:GetDressByType(IslandShipDressHelperNew.DressType.Hair), self:GetDressByType(IslandShipDressHelperNew.DressType.Face), (self:GetDressByType(IslandShipDressHelperNew.DressType.Body))
end

function IslandDressUpAgency:ChangeDress(arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		self:SetDressByTpye(iter_16_1.type, iter_16_1.id)

		if iter_16_1.type == IslandShipDressHelperNew.DressType.Body then
			local var_16_0 = self:GetMorphTargetId(iter_16_1.id)

			if var_16_0 and var_16_0 ~= 0 then
				self:SetTwinCurId(var_16_0, iter_16_1.id)
			end
		end
	end

	return
end

function IslandDressUpAgency:ChangeDressColor(arg_17_1)
	for iter_17_0, iter_17_1 in ipairs(self.hasDressList) do
		if iter_17_1.id == arg_17_1.id then
			iter_17_1:ChangeColor(arg_17_1.color)
		end
	end

	return
end

function IslandDressUpAgency:GetCurrentColorByDressId(arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(self.hasDressList) do
		if iter_18_1.id == arg_18_1 then
			return iter_18_1.color
		end
	end

	return 0
end

function IslandDressUpAgency:CheckDressColorIsOwned(arg_19_1, arg_19_2)
	for iter_19_0, iter_19_1 in ipairs(self.hasDressList) do
		if iter_19_1.id == arg_19_1 then
			return iter_19_1:CheckColorIsOwned(arg_19_2)
		end
	end

	return false
end

function IslandDressUpAgency:AddDressColor(arg_20_1, arg_20_2)
	for iter_20_0, iter_20_1 in ipairs(self.hasDressList) do
		if iter_20_1.id == arg_20_1 then
			return iter_20_1:AddDressColor(arg_20_2)
		end
	end

	return false
end

function IslandDressUpAgency:ChangeCapState(arg_21_1)
	for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
		self:SetBodyHatIsOn(iter_21_1.dress_id, iter_21_1.cap_id)
	end

	return
end

function IslandDressUpAgency:GetTwinCurId(arg_22_1)
	if self.twinCurDic[arg_22_1] then
		return arg_22_1
	end

	local var_22_0 = pg.island_dress_template[arg_22_1]

	if pg.island_dress_template[arg_22_1] and var_22_0.cloth_related and var_22_0.cloth_related ~= 0 and self.twinCurDic[var_22_0.cloth_related] then
		return var_22_0.cloth_related
	end

	return 0
end

function IslandDressUpAgency:SetTwinCurId(arg_23_1, arg_23_2)
	if pg.island_dress_template[arg_23_1] and pg.island_dress_template[arg_23_1].cloth_related and pg.island_dress_template[arg_23_1].cloth_related ~= 0 then
		self.twinCurDic[pg.island_dress_template[arg_23_1].cloth_related] = nil
	end

	self.twinCurDic[arg_23_1] = nil
	self.twinCurDic[arg_23_2] = true

	return
end

function IslandDressUpAgency:GetMorphTargetId(arg_24_1)
	if not arg_24_1 or arg_24_1 == 0 then
		return 0
	end

	local var_24_0 = pg.island_dress_template[arg_24_1]

	if not pg.island_dress_template[arg_24_1] then
		return 0
	end

	return var_24_0.cloth_related or 0
end

return IslandDressUpAgency
