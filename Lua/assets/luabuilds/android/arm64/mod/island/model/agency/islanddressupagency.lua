local var_0_0 = class("IslandDressUpAgency", import(".IslandBaseAgency"))

var_0_0.CHANGE_PLAYER_DRESS = "IslandDressUpAgency:CHANGE_DRESS"
var_0_0.MORPH_PLAYER_DRESS = "IslandDressUpAgency:MORPH_PLAYER_DRESS"

function var_0_0.OnInit(arg_1_0, arg_1_1)
	arg_1_0.currentDressTypeDic = {}

	local var_1_0 = arg_1_1.user_dress.cur_dress or {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		arg_1_0.currentDressTypeDic[iter_1_1.type] = iter_1_1.id
	end

	arg_1_0.hasDressList = {}

	local var_1_1 = arg_1_1.user_dress.had_dress or {}

	for iter_1_2, iter_1_3 in ipairs(var_1_1) do
		table.insert(arg_1_0.hasDressList, IslandCommanderDressItem.New(iter_1_3))
	end

	arg_1_0.cap_Dic = {}

	for iter_1_4, iter_1_5 in ipairs(arg_1_1.user_dress.cap_list) do
		arg_1_0.cap_Dic[iter_1_5.dress_id] = iter_1_5.cap_id
	end

	arg_1_0.twinCurDic = {}

	local var_1_2 = arg_1_1.user_dress.twin_cur_list or {}

	for iter_1_6, iter_1_7 in ipairs(var_1_2) do
		arg_1_0.twinCurDic[iter_1_7] = true
	end

	return
end

function var_0_0.SetDressHasRead(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0.hasDressList) do
		if iter_2_1.id == arg_2_1 then
			iter_2_1:SetReadState(true)
		end
	end

	return
end

function var_0_0.CheckRedDotByDressType(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0.hasDressList) do
		if iter_3_1:getConfigTable().type == arg_3_1 and iter_3_1.state == 0 then
			return true
		end
	end

	return false
end

function var_0_0.GetBodyHatIsOn(arg_4_0, arg_4_1)
	return arg_4_0.cap_Dic[arg_4_1] ~= 0
end

function var_0_0.GetBodyHatDressId(arg_5_0, arg_5_1)
	return arg_5_0.cap_Dic[arg_5_1] or 0
end

function var_0_0.SetBodyHatIsOn(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.cap_Dic[arg_6_1] = arg_6_2

	return
end

function var_0_0.GetDressByType(arg_7_0, arg_7_1)
	return arg_7_0.currentDressTypeDic[arg_7_1]
end

function var_0_0.GetDressUpData(arg_8_0)
	return arg_8_0.currentDressTypeDic
end

function var_0_0.SetDressByTpye(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.currentDressTypeDic[arg_9_1] = arg_9_2

	return
end

function var_0_0.GetAllHasDress(arg_10_0)
	return arg_10_0.hasDressList
end

function var_0_0.GetHasDressByType(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.hasDressList) do
		if iter_11_1:getConfig("type") == arg_11_1 then
			table.insert({}, iter_11_1)
		end
	end

	return {}
end

function var_0_0.CheckOwnDress(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.hasDressList) do
		if iter_12_1.id == arg_12_1 then
			return true
		end
	end

	return false
end

function var_0_0.AddDressByDressId(arg_13_0, arg_13_1)
	table.insert(arg_13_0.hasDressList, IslandCommanderDressItem.New({
		color = 0,
		state = 0,
		id = arg_13_1,
		color_list = {}
	}))

	if pg.island_dress_template[arg_13_1].type == IslandShipDressHelperNew.DressType.Body then
		local var_13_0 = pg.island_dress_template.get_id_list_by_related_dress[arg_13_1] or {}
		local var_13_1 = var_13_0[1]

		if var_13_0[1] then
			arg_13_0:SetBodyHatIsOn(arg_13_1, var_13_1)
		end
	end

	if pg.island_dress_template[arg_13_1] and pg.island_dress_template[arg_13_1].cloth_related and pg.island_dress_template[arg_13_1].cloth_related ~= 0 then
		local var_13_2

		if pg.island_dress_template[arg_13_1].defalut_cloth == 1 then
			var_13_2 = arg_13_1
		else
			local var_13_3 = pg.island_dress_template[pg.island_dress_template[arg_13_1].cloth_related]

			var_13_2 = pg.island_dress_template[pg.island_dress_template[arg_13_1].cloth_related] and var_13_3.defalut_cloth == 1 and pg.island_dress_template[arg_13_1].cloth_related or arg_13_1
		end

		arg_13_0.twinCurDic[var_13_2] = true
	end

	return
end

function var_0_0.IsNew(arg_14_0)
	local var_14_0 = arg_14_0.currentDressTypeDic[IslandShipDressHelperNew.DressType.Face]
	local var_14_1 = arg_14_0.currentDressTypeDic[IslandShipDressHelperNew.DressType.Body]

	return arg_14_0.currentDressTypeDic[IslandShipDressHelperNew.DressType.Hair] == nil and var_14_0 == nil and var_14_1 == nil
end

function var_0_0.GetHairFaceBodyDress(arg_15_0)
	return arg_15_0:GetDressByType(IslandShipDressHelperNew.DressType.Hair), arg_15_0:GetDressByType(IslandShipDressHelperNew.DressType.Face), (arg_15_0:GetDressByType(IslandShipDressHelperNew.DressType.Body))
end

function var_0_0.ChangeDress(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		arg_16_0:SetDressByTpye(iter_16_1.type, iter_16_1.id)

		if iter_16_1.type == IslandShipDressHelperNew.DressType.Body then
			local var_16_0 = arg_16_0:GetMorphTargetId(iter_16_1.id)

			if var_16_0 and var_16_0 ~= 0 then
				arg_16_0:SetTwinCurId(var_16_0, iter_16_1.id)
			end
		end
	end

	return
end

function var_0_0.ChangeDressColor(arg_17_0, arg_17_1)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0.hasDressList) do
		if iter_17_1.id == arg_17_1.id then
			iter_17_1:ChangeColor(arg_17_1.color)
		end
	end

	return
end

function var_0_0.GetCurrentColorByDressId(arg_18_0, arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0.hasDressList) do
		if iter_18_1.id == arg_18_1 then
			return iter_18_1.color
		end
	end

	return 0
end

function var_0_0.CheckDressColorIsOwned(arg_19_0, arg_19_1, arg_19_2)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0.hasDressList) do
		if iter_19_1.id == arg_19_1 then
			return iter_19_1:CheckColorIsOwned(arg_19_2)
		end
	end

	return false
end

function var_0_0.AddDressColor(arg_20_0, arg_20_1, arg_20_2)
	for iter_20_0, iter_20_1 in ipairs(arg_20_0.hasDressList) do
		if iter_20_1.id == arg_20_1 then
			return iter_20_1:AddDressColor(arg_20_2)
		end
	end

	return false
end

function var_0_0.ChangeCapState(arg_21_0, arg_21_1)
	for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
		arg_21_0:SetBodyHatIsOn(iter_21_1.dress_id, iter_21_1.cap_id)
	end

	return
end

function var_0_0.GetTwinCurId(arg_22_0, arg_22_1)
	if arg_22_0.twinCurDic[arg_22_1] then
		return arg_22_1
	end

	local var_22_0 = pg.island_dress_template[arg_22_1]

	if pg.island_dress_template[arg_22_1] and var_22_0.cloth_related and var_22_0.cloth_related ~= 0 and arg_22_0.twinCurDic[var_22_0.cloth_related] then
		return var_22_0.cloth_related
	end

	return 0
end

function var_0_0.SetTwinCurId(arg_23_0, arg_23_1, arg_23_2)
	if pg.island_dress_template[arg_23_1] and pg.island_dress_template[arg_23_1].cloth_related and pg.island_dress_template[arg_23_1].cloth_related ~= 0 then
		arg_23_0.twinCurDic[pg.island_dress_template[arg_23_1].cloth_related] = nil
	end

	arg_23_0.twinCurDic[arg_23_1] = nil
	arg_23_0.twinCurDic[arg_23_2] = true

	return
end

function var_0_0.GetMorphTargetId(arg_24_0, arg_24_1)
	if not arg_24_1 or arg_24_1 == 0 then
		return 0
	end

	local var_24_0 = pg.island_dress_template[arg_24_1]

	if not pg.island_dress_template[arg_24_1] then
		return 0
	end

	return var_24_0.cloth_related or 0
end

return var_0_0
