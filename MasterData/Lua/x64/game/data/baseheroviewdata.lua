local BaseHeroViewData = class("BaseHeroViewData")

function BaseHeroViewData:GetHeroList()
	Debug.LogError("Need to override function GetHeroList()")

	return {}
end

function BaseHeroViewData:GetHeroIDList(arg_2_1)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in pairs((self:GetHeroList(arg_2_1))) do
		table.insert(var_2_0, iter_2_1.id)
	end

	return var_2_0
end

function BaseHeroViewData:GetHeroData(arg_3_1)
	return self:GetHeroList()[arg_3_1]
end

function BaseHeroViewData:GetTempServerHeroDataList(arg_4_1)
	return self:GetTempServerHeroDataList()[arg_4_1]
end

function BaseHeroViewData:GetEquipInfoList(arg_5_1)
	return self:GetHeroData(arg_5_1):GetEquipInfoList()
end

function BaseHeroViewData:GetEquipDataList(arg_6_1)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs((self:GetEquipInfoList(arg_6_1))) do
		if iter_6_1.equip_id ~= 0 then
			table.insert(var_6_0, EquipData:GetEquipData(iter_6_1.equip_id))
		else
			table.insert(var_6_0, (EquipStruct.New(0, iter_6_1.equip_id)))
		end
	end

	return var_6_0
end

function BaseHeroViewData:GetHeroWeaponInfo(arg_7_1)
	return self:GetHeroData(arg_7_1):GetWeaponInfo()
end

function BaseHeroViewData:GetHeroServantInfo(arg_8_1)
	return self:GetHeroData(arg_8_1):GetServantInfo()
end

function BaseHeroViewData:GetHeroSkillInfoList(arg_9_1)
	return self:GetHeroData(arg_9_1):GetSkillInfoList()
end

function BaseHeroViewData:GetHeroTransitionInfoList(arg_10_1)
	return self:GetHeroData(arg_10_1):GetTransitionInfoList()
end

function BaseHeroViewData:GetHeroUsingSkinInfo(arg_11_1)
	local var_11_0 = self:GetHeroData(arg_11_1)
	local var_11_1

	if var_11_0 then
		var_11_1 = var_11_0.using_skin or 0

		if var_11_1 == 0 then
			var_11_1 = arg_11_1
		end
	end

	return SkinCfg[var_11_1]
end

function BaseHeroViewData:GetHeroBattleUsingSkinInfo(arg_12_1)
	local var_12_0 = HeroData:GetHeroData(arg_12_1)
	local var_12_1

	if var_12_0 then
		var_12_1 = var_12_0.battle_using_skin or 0

		if var_12_1 == 0 then
			var_12_1 = arg_12_1
		end
	end

	return SkinCfg[var_12_1]
end

function BaseHeroViewData:GetHeroName(arg_13_1)
	return HeroTools.GetHeroName(arg_13_1)
end

function BaseHeroViewData:HasCustomNickName(arg_14_1)
	return OathCollectionContentData:GetOathCustomNickName(arg_14_1) ~= nil
end

function BaseHeroViewData:IsHeroOath(arg_15_1)
	return OathTools.IsOath(arg_15_1)
end

function BaseHeroViewData:GetExFilterSorterFunc()
	return nil
end

return BaseHeroViewData
