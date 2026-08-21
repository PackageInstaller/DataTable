local var_0_0 = class("BaseHeroViewData")

function var_0_0.GetHeroList(arg_1_0)
	Debug.LogError("Need to override function GetHeroList()")

	return {}
end

function var_0_0.GetHeroIDList(arg_2_0, arg_2_1)
	local var_2_0 = {}
	local var_2_1 = arg_2_0:GetHeroList(arg_2_1)

	for iter_2_0, iter_2_1 in pairs(var_2_1) do
		table.insert(var_2_0, iter_2_1.id)
	end

	return var_2_0
end

function var_0_0.GetHeroData(arg_3_0, arg_3_1)
	return arg_3_0:GetHeroList()[arg_3_1]
end

function var_0_0.GetTempServerHeroDataList(arg_4_0, arg_4_1)
	return arg_4_0:GetTempServerHeroDataList()[arg_4_1]
end

function var_0_0.GetEquipInfoList(arg_5_0, arg_5_1)
	return arg_5_0:GetHeroData(arg_5_1):GetEquipInfoList()
end

function var_0_0.GetEquipDataList(arg_6_0, arg_6_1)
	local var_6_0 = {}
	local var_6_1 = arg_6_0:GetEquipInfoList(arg_6_1)

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		if iter_6_1.equip_id ~= 0 then
			table.insert(var_6_0, EquipData:GetEquipData(iter_6_1.equip_id))
		else
			local var_6_2 = EquipStruct.New(0, iter_6_1.equip_id)

			table.insert(var_6_0, var_6_2)
		end
	end

	return var_6_0
end

function var_0_0.GetHeroWeaponInfo(arg_7_0, arg_7_1)
	return arg_7_0:GetHeroData(arg_7_1):GetWeaponInfo()
end

function var_0_0.GetHeroServantInfo(arg_8_0, arg_8_1)
	return arg_8_0:GetHeroData(arg_8_1):GetServantInfo()
end

function var_0_0.GetHeroSkillInfoList(arg_9_0, arg_9_1)
	return arg_9_0:GetHeroData(arg_9_1):GetSkillInfoList()
end

function var_0_0.GetHeroTransitionInfoList(arg_10_0, arg_10_1)
	return arg_10_0:GetHeroData(arg_10_1):GetTransitionInfoList()
end

function var_0_0.GetHeroUsingSkinInfo(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:GetHeroData(arg_11_1)
	local var_11_1 = var_11_0 and var_11_0.using_skin or 0

	if var_11_1 == 0 then
		var_11_1 = arg_11_1
	end

	return SkinCfg[var_11_1]
end

function var_0_0.GetHeroBattleUsingSkinInfo(arg_12_0, arg_12_1)
	local var_12_0 = HeroData:GetHeroData(arg_12_1)
	local var_12_1 = var_12_0 and var_12_0.battle_using_skin or 0

	if var_12_1 == 0 then
		var_12_1 = arg_12_1
	end

	return SkinCfg[var_12_1]
end

function var_0_0.GetHeroName(arg_13_0, arg_13_1)
	return HeroTools.GetHeroName(arg_13_1)
end

function var_0_0.HasCustomNickName(arg_14_0, arg_14_1)
	return OathCollectionContentData:GetOathCustomNickName(arg_14_1) ~= nil
end

function var_0_0.IsHeroOath(arg_15_0, arg_15_1)
	return OathTools.IsOath(arg_15_1)
end

function var_0_0.GetExFilterSorterFunc(arg_16_0)
	return nil
end

return var_0_0
