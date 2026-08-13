class = var_0_10000

local var_0_0 = "IslandDressUpAgency"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandBaseAgency"))

var_0_1.CHANGE_PLAYER_DRESS = "IslandDressUpAgency:CHANGE_DRESS"
var_0_1.MORPH_PLAYER_DRESS = "IslandDressUpAgency:MORPH_PLAYER_DRESS"

function var_0_1.OnInit(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.user_dress

	arg_1_0.currentDressTypeDic = {}
	ipairs = var_3

	local var_1_1

	if not var_1_0.cur_dress then
		var_1_1 = {}
	end

	for iter_1_0, iter_1_1 in var_3(var_1_1) do
		var_1_10008 = arg_1_0.currentDressTypeDic
		var_1_10008[iter_1_1.type] = iter_1_1.id
	end

	arg_1_0.hasDressList = {}
	ipairs = var_3

	local var_1_2

	if not var_1_0.had_dress then
		var_1_2 = {}
	end

	for iter_1_2, iter_1_3 in var_3(var_1_2) do
		table = var_1_10008
		var_1_10008 = var_1_10008.insert

		local var_1_3 = arg_1_0.hasDressList

		IslandCommanderDressItem = var_1_10011

		var_1_10008(var_1_3, var_1_10011.New(iter_1_3))
	end

	arg_1_0.cap_Dic = {}
	ipairs = var_3

	for iter_1_4, iter_1_5 in var_3(var_1_0.cap_list) do
		arg_1_0.cap_Dic[iter_1_5.dress_id] = iter_1_5.cap_id
	end

	arg_1_0.twinCurDic = {}
	ipairs = var_3

	local var_1_4

	if not var_1_0.twin_cur_list then
		var_1_4 = {}
	end

	for iter_1_6, iter_1_7 in var_3(var_1_4) do
		arg_1_0.twinCurDic[iter_1_7] = true
	end

	return
end

function var_0_1.SetDressHasRead(arg_2_0, arg_2_1)
	ipairs = var_1_10002

	for iter_2_0, iter_2_1 in var_1_10002(arg_2_0.hasDressList) do
		if iter_2_1.id == arg_2_1 then
			iter_2_1:SetReadState(true)
		end
	end

	return
end

function var_0_1.CheckRedDotByDressType(arg_3_0, arg_3_1)
	ipairs = var_1_10002

	for iter_3_0, iter_3_1 in var_1_10002(arg_3_0.hasDressList) do
		if iter_3_1:getConfigTable().type == arg_3_1 and iter_3_1.state == 0 then
			return true
		end
	end

	return false
end

function var_0_1.GetBodyHatIsOn(arg_4_0, arg_4_1)
	return arg_4_0.cap_Dic[arg_4_1] ~= 0
end

function var_0_1.GetBodyHatDressId(arg_5_0, arg_5_1)
	local var_5_0

	if not arg_5_0.cap_Dic[arg_5_1] then
		var_5_0 = 0
	end

	return var_5_0
end

function var_0_1.SetBodyHatIsOn(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.cap_Dic[arg_6_1] = arg_6_2

	return
end

function var_0_1.GetDressByType(arg_7_0, arg_7_1)
	return arg_7_0.currentDressTypeDic[arg_7_1]
end

function var_0_1.GetDressUpData(arg_8_0)
	return arg_8_0.currentDressTypeDic
end

function var_0_1.SetDressByTpye(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.currentDressTypeDic[arg_9_1] = arg_9_2

	return
end

function var_0_1.GetAllHasDress(arg_10_0)
	return arg_10_0.hasDressList
end

function var_0_1.GetHasDressByType(arg_11_0, arg_11_1)
	local var_11_0 = {}

	pairs = var_1_10003

	for iter_11_0, iter_11_1 in var_1_10003(arg_11_0.hasDressList) do
		if iter_11_1:getConfig("type") == arg_11_1 then
			table = var_8

			var_8.insert(var_11_0, iter_11_1)
		end
	end

	return var_11_0
end

function var_0_1.CheckOwnDress(arg_12_0, arg_12_1)
	ipairs = var_1_10002

	for iter_12_0, iter_12_1 in var_1_10002(arg_12_0.hasDressList) do
		if iter_12_1.id == arg_12_1 then
			return true
		end
	end

	return false
end

function var_0_1.AddDressByDressId(arg_13_0, arg_13_1)
	table = var_1_10002

	local var_13_0 = var_1_10002.insert
	local var_13_1 = arg_13_0.hasDressList

	IslandCommanderDressItem = var_1_10005

	var_13_0(var_13_1, var_1_10005.New({
		color = 0,
		state = 0,
		id = arg_13_1,
		color_list = {}
	}))

	pg = var_13_0

	local var_13_2 = var_13_0.island_dress_template[arg_13_1].type

	IslandShipDressHelperNew = var_13_1

	if var_13_2 == var_13_1.DressType.Body then
		pg = var_13_2

		local var_13_3

		if not var_13_2.island_dress_template.get_id_list_by_related_dress[arg_13_1] then
			var_13_3 = {}
		end

		if var_13_3[1] then
			arg_13_0:SetBodyHatIsOn(arg_13_1, var_4)
		end
	end

	if var_2 and var_2.cloth_related and var_2.cloth_related ~= 0 then
		local var_13_4

		if var_2.defalut_cloth == 1 then
			var_13_4 = arg_13_1
		else
			pg = var_4
			var_13_4 = var_4.island_dress_template[var_2.cloth_related] and var_4.defalut_cloth == 1 and var_2.cloth_related or arg_13_1
		end

		arg_13_0.twinCurDic[var_13_4] = true
	end

	return
end

function var_0_1.IsNew(arg_14_0)
	local var_14_0 = arg_14_0.currentDressTypeDic

	IslandShipDressHelperNew = var_1_10002

	local var_14_1 = var_14_0[var_1_10002.DressType.Hair]
	local var_14_2 = arg_14_0.currentDressTypeDic

	IslandShipDressHelperNew = var_1_10003

	local var_14_3 = var_14_2[var_1_10003.DressType.Face]
	local var_14_4 = arg_14_0.currentDressTypeDic

	IslandShipDressHelperNew = var_1_10004

	local var_14_5 = var_14_4[var_1_10004.DressType.Body]

	return var_14_1 == nil and var_14_3 == nil and var_14_5 == nil
end

function var_0_1.GetHairFaceBodyDress(arg_15_0)
	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.GetDressByType

	IslandShipDressHelperNew = var_1_10004

	local var_15_2 = var_15_1(var_15_0, var_1_10004.DressType.Hair)
	local var_15_3 = arg_15_0
	local var_15_4 = arg_15_0.GetDressByType

	IslandShipDressHelperNew = var_1_10005

	local var_15_5 = var_15_4(var_15_3, var_1_10005.DressType.Face)
	local var_15_6 = arg_15_0
	local var_15_7 = arg_15_0.GetDressByType

	IslandShipDressHelperNew = var_1_10006

	local var_15_8 = var_15_7(var_15_6, var_1_10006.DressType.Body)

	return var_15_2, var_15_5, var_15_8
end

function var_0_1.ChangeDress(arg_16_0, arg_16_1)
	ipairs = var_1_10002

	for iter_16_0, iter_16_1 in var_1_10002(arg_16_1) do
		arg_16_0:SetDressByTpye(iter_16_1.type, iter_16_1.id)

		local var_16_0 = iter_16_1.type

		IslandShipDressHelperNew = var_1_10008

		if var_16_0 == var_1_10008.DressType.Body and arg_16_0:GetMorphTargetId(iter_16_1.id) and var_7 ~= 0 then
			arg_16_0:SetTwinCurId(var_7, iter_16_1.id)
		end
	end

	return
end

function var_0_1.ChangeDressColor(arg_17_0, arg_17_1)
	ipairs = var_1_10002

	for iter_17_0, iter_17_1 in var_1_10002(arg_17_0.hasDressList) do
		if iter_17_1.id == arg_17_1.id then
			iter_17_1:ChangeColor(arg_17_1.color)
		end
	end

	return
end

function var_0_1.GetCurrentColorByDressId(arg_18_0, arg_18_1)
	ipairs = var_1_10002

	for iter_18_0, iter_18_1 in var_1_10002(arg_18_0.hasDressList) do
		if iter_18_1.id == arg_18_1 then
			return iter_18_1.color
		end
	end

	return 0
end

function var_0_1.CheckDressColorIsOwned(arg_19_0, arg_19_1, arg_19_2)
	ipairs = var_1_10003

	for iter_19_0, iter_19_1 in var_1_10003(arg_19_0.hasDressList) do
		if iter_19_1.id == arg_19_1 then
			return iter_19_1:CheckColorIsOwned(arg_19_2)
		end
	end

	return false
end

function var_0_1.AddDressColor(arg_20_0, arg_20_1, arg_20_2)
	ipairs = var_1_10003

	for iter_20_0, iter_20_1 in var_1_10003(arg_20_0.hasDressList) do
		if iter_20_1.id == arg_20_1 then
			return iter_20_1:AddDressColor(arg_20_2)
		end
	end

	return false
end

function var_0_1.ChangeCapState(arg_21_0, arg_21_1)
	ipairs = var_1_10002

	for iter_21_0, iter_21_1 in var_1_10002(arg_21_1) do
		arg_21_0:SetBodyHatIsOn(iter_21_1.dress_id, iter_21_1.cap_id)
	end

	return
end

function var_0_1.GetTwinCurId(arg_22_0, arg_22_1)
	if arg_22_0.twinCurDic[arg_22_1] then
		return arg_22_1
	end

	pg = var_2

	if var_2.island_dress_template[arg_22_1] and var_2.cloth_related and var_2.cloth_related ~= 0 and arg_22_0.twinCurDic[var_2.cloth_related] then
		return var_2.cloth_related
	end

	return 0
end

function var_0_1.SetTwinCurId(arg_23_0, arg_23_1, arg_23_2)
	pg = var_1_10003

	if var_1_10003.island_dress_template[arg_23_1] and var_3.cloth_related and var_3.cloth_related ~= 0 then
		arg_23_0.twinCurDic[var_3.cloth_related] = nil
	end

	arg_23_0.twinCurDic[arg_23_1] = nil
	arg_23_0.twinCurDic[arg_23_2] = true

	return
end

function var_0_1.GetMorphTargetId(arg_24_0, arg_24_1)
	if not arg_24_1 or arg_24_1 == 0 then
		return 0
	end

	pg = var_1_10002

	if not var_1_10002.island_dress_template[arg_24_1] then
		return 0
	end

	local var_24_0

	if not var_2.cloth_related then
		var_24_0 = 0
	end

	return var_24_0
end

return var_0_1
