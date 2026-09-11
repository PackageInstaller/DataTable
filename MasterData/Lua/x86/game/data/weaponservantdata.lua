local var_0_0 = singletonClass("WeaponServantData")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}
local var_0_4

function var_0_0.Init(arg_2_0)
	var_0_1 = {}
	var_0_2 = {}
	var_0_3 = {}
end

function var_0_0:InitServant(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs((cleanProtoTable(arg_3_1.servant_list))) do
		self:AddServant(iter_3_1)
	end

	manager.notify:Invoke(WEAPON_SERVANT_LIST_UPDATE)
end

function var_0_0.AddServant(arg_4_0, arg_4_1)
	local var_4_0 = tonumber(arg_4_1.uid)
	local var_4_1 = {
		uid = var_4_0,
		id = arg_4_1.id
	}

	var_4_1.stage = arg_4_1.stage or 1
	var_4_1.locked = arg_4_1.is_locked or 0
	var_0_1[var_4_0] = var_4_1
	var_0_2[arg_4_1.id] = var_0_2[arg_4_1.id] or {}
	var_0_2[arg_4_1.id][var_4_0] = true
end

function var_0_0.RemoveServant(arg_5_0, arg_5_1)
	local var_5_0 = tonumber(arg_5_1.uid)

	var_0_2[arg_5_1.item.id][var_5_0] = nil
	var_0_1[var_5_0] = nil
end

function var_0_0.GetServantNum(arg_6_0)
	return table.length(var_0_1)
end

function var_0_0.GetWeaponServantList(arg_7_0)
	return var_0_1
end

function var_0_0.ServantPromote(arg_8_0, arg_8_1)
	var_0_1[arg_8_1].stage = var_0_1[arg_8_1].stage + 1

	manager.notify:Invoke(WEAPON_SERVANT_LIST_UPDATE)
end

function var_0_0.ServantLock(arg_9_0, arg_9_1, arg_9_2)
	var_0_1[arg_9_1].locked = arg_9_2

	manager.notify:Invoke(SERVANT_LOCK, arg_9_1, arg_9_2)
end

function var_0_0.GetServantDataByUID(arg_10_0, arg_10_1)
	return var_0_1[arg_10_1]
end

function var_0_0.GetWeaponServantById(arg_11_0, arg_11_1)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs(var_0_1) do
		if iter_11_1.id == arg_11_1 then
			table.insert(var_11_0, iter_11_1)
		end
	end

	return var_11_0
end

function var_0_0.GetServantSByID(arg_12_0, arg_12_1)
	return var_0_2[arg_12_1]
end

function var_0_0.SetServantMergeMap(arg_13_0, arg_13_1, arg_13_2)
	var_0_3[arg_13_1] = arg_13_2
end

function var_0_0.GetServantMergeMap(arg_14_0, arg_14_1)
	return var_0_3[arg_14_1]
end

function var_0_0.GetAllPrivateWeaponServantIdList(arg_15_0)
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs(WeaponServantCfg.all) do
		if WeaponServantCfg[iter_15_1].effect ~= nil or #WeaponServantCfg[iter_15_1].effect > 0 then
			if WeaponServantCfg[iter_15_1].effect[1] ~= 0 then
				if WeaponEffectCfg[WeaponServantCfg[iter_15_1].effect[1]].spec_char[1] ~= nil and WeaponEffectCfg[WeaponServantCfg[iter_15_1].effect[1]].spec_char[1] > 0 then
					table.insert(var_15_0, iter_15_1)
				end
			end
		end
	end

	return var_15_0
end

function var_0_0.GetPrivateWeaponServantIdByHeroID(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(WeaponServantCfg.all) do
		if WeaponServantCfg[iter_16_1].effect ~= nil or #WeaponServantCfg[iter_16_1].effect > 0 then
			if WeaponServantCfg[iter_16_1].effect[1] ~= 0 and WeaponEffectCfg[WeaponServantCfg[iter_16_1].effect[1]].spec_char[1] == arg_16_1 then
				return iter_16_1
			end
		end
	end

	return 0
end

function var_0_0.GetPublicWeaponServantIdByRace(arg_17_0, arg_17_1)
	local var_17_0 = 0

	for iter_17_0, iter_17_1 in pairs(WeaponServantCfg.get_id_list_by_race[arg_17_1]) do
		if WeaponServantCfg[iter_17_1].effect ~= nil or #WeaponServantCfg[iter_17_1].effect > 0 then
			if WeaponServantCfg[iter_17_1].effect[1] ~= 0 and WeaponEffectCfg[WeaponServantCfg[iter_17_1].effect[1]].spec_char[1] == nil and WeaponServantCfg[iter_17_1].starlevel == 5 then
				var_17_0 = iter_17_1
			end
		end
	end

	return var_17_0
end

function var_0_0.GetSortConfig(arg_18_0)
	var_0_4 = var_0_4 or {
		0,
		0
	}

	return var_0_4
end

function var_0_0.SetSortConfig(arg_19_0, arg_19_1, arg_19_2)
	var_0_4[1] = arg_19_1 or var_0_4[1]
	var_0_4[2] = arg_19_2 or var_0_4[2]
end

function var_0_0.GetDefaultData(arg_20_0, arg_20_1)
	return {
		locked = 0,
		stage = 1,
		uid = 0,
		id = arg_20_1
	}
end

return var_0_0
