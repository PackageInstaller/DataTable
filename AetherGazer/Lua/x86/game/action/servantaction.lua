local var_0_0 = {}

manager.net:Bind(46011, function(arg_1_0)
	WeaponServantData:InitServant(arg_1_0)
	var_0_0.CheckRedPoint()
end)
manager.notify:RegistListener(MATERIAL_MODIFY, function()
	var_0_0.CheckRedPoint()
end)
manager.notify:RegistListener(MATERIAL_LIST_UPDATE, function()
	var_0_0.CheckRedPoint()
end)
manager.notify:RegistListener(WEAPON_SERVANT_LIST_UPDATE, function()
	var_0_0.CheckRedPoint()
end)

function var_0_0.TouchRedPoint()
	var_0_0.touched = true

	var_0_0.CheckRedPoint()
end

function var_0_0.CheckRedPoint()
	do return end

	if var_0_0.touched == true then
		manager.redPoint:setTip(RedPointConst.WEAPON_SERVANT_MERGE, 0)

		return
	end

	local var_6_0 = GameSetting.exclusive_weapon_servant_cost.value
	local var_6_1 = false

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		local var_6_2 = iter_6_1[2]
		local var_6_3 = WeaponServantData:GetWeaponServantById(var_6_2[1][1])
		local var_6_4 = 0

		if var_6_3 then
			var_6_4 = #var_6_3
		end

		if ItemTools.getItemNum(var_6_2[2][1]) >= var_6_2[2][2] and var_6_4 >= var_6_2[1][2] then
			var_6_1 = true

			break
		end
	end

	manager.redPoint:setTip(RedPointConst.WEAPON_SERVANT_MERGE, var_6_1 and 1 or 0)
end

function var_0_0.ServantPromote(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	var_0_0.costMoney = arg_7_3

	manager.net:SendWithLoadingNew(46012, {
		refined_type = arg_7_0,
		uid = arg_7_1,
		cost_uid = arg_7_2
	}, 46013, var_0_0.OnServantPromote)
end

function var_0_0.OnServantPromote(arg_8_0, arg_8_1)
	if isSuccess(arg_8_0.result) then
		WeaponServantData:ServantPromote(arg_8_1.uid, arg_8_1.cost_uid)
		manager.notify:Invoke(SERVANT_PROMOTE, arg_8_0, arg_8_1)
	else
		ShowTips(arg_8_0.result)
	end
end

function var_0_0.ServantReplace(arg_9_0, arg_9_1)
	manager.net:SendWithLoadingNew(46020, {
		hero_id = arg_9_0,
		servant_id = arg_9_1
	}, 46021, var_0_0.OnServantReplace)
end

function var_0_0.OnServantReplace(arg_10_0, arg_10_1)
	if isSuccess(arg_10_0.result) then
		local var_10_0 = ServantTools.GetServantMap()[arg_10_1.servant_id]
		local var_10_1 = HeroData:GetHeroData(arg_10_1.hero_id).servant_uid

		if var_10_0 then
			HeroAction.ServantReplace(var_10_0, 0)
		end

		HeroAction.ServantReplace(arg_10_1.hero_id, arg_10_1.servant_id)
		manager.notify:CallUpdateFunc(SERVANT_REPLACE, arg_10_0, arg_10_1)
		manager.notify:Invoke(SERVANT_REPLACE, arg_10_0, arg_10_1, var_10_1)
	else
		ShowTips(arg_10_0.result)
	end
end

function var_0_0.ServantLock(arg_11_0)
	local var_11_0 = WeaponServantData:GetServantDataByUID(arg_11_0).locked == 1 and 0 or 1

	manager.net:SendWithLoadingNew(46014, {
		uid = arg_11_0,
		is_lock = var_11_0
	}, 46015, var_0_0.OnServantLock)
end

function var_0_0.OnServantLock(arg_12_0, arg_12_1)
	if isSuccess(arg_12_0.result) then
		WeaponServantData:ServantLock(arg_12_1.uid, arg_12_1.is_lock)
		manager.notify:CallUpdateFunc(SERVANT_LOCK, arg_12_0, arg_12_1)
	else
		ShowTips(arg_12_0.result)
	end
end

function var_0_0.ServantMerge(arg_13_0, arg_13_1)
	local var_13_0 = {
		servant_id = arg_13_0,
		cost_uid_list = arg_13_1
	}
	local var_13_1 = WeaponServantData:GetServantDataByUID(var_13_0.cost_uid_list[1])
	local var_13_2 = var_13_0.cost_uid_list[1]
	local var_13_3 = var_13_1.locked
	local var_13_4
	local var_13_5 = ServantTools.GetServantMap()

	for iter_13_0, iter_13_1 in ipairs(var_13_0.cost_uid_list) do
		local var_13_6 = var_13_5[iter_13_1]

		if var_13_6 then
			var_13_4 = var_13_6

			break
		end
	end

	manager.net:SendWithLoadingNew(46030, var_13_0, 46031, function(arg_14_0)
		ServantAction.OnServantMerge(arg_14_0, var_13_0, var_13_2, var_13_3, var_13_4)
	end)
end

function var_0_0.OnServantMerge(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_0 = tonumber(arg_15_0.servant_uid)

	if isSuccess(arg_15_0.result) then
		local var_15_1 = WeaponServantCfg[arg_15_1.servant_id]
		local var_15_2 = {}

		for iter_15_0, iter_15_1 in ipairs(GameSetting.exclusive_weapon_servant_cost.value) do
			if iter_15_1[1] == var_15_1.race then
				local var_15_3 = iter_15_1[2]
			end
		end

		WeaponServantData:ServantLock(var_15_0, arg_15_3)
		WeaponServantData:SetServantMergeMap(arg_15_2, var_15_0)

		if arg_15_4 then
			HeroData:ServantReplace(arg_15_4, var_15_0)
		end

		IllustratedAction.ModifyServantInfo(arg_15_1.servant_id)
		manager.notify:CallUpdateFunc(SERVANT_MERGE_RESULT, arg_15_0, arg_15_1)
	elseif TipsCfg[arg_15_0.result] then
		ShowTips(TipsCfg[arg_15_0.result].desc)
	else
		ShowTips(arg_15_0.result)
	end
end

function var_0_0.ServantDecompose(arg_16_0)
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in pairs(arg_16_0) do
		table.insert(var_16_0, iter_16_0)
	end

	manager.net:SendWithLoadingNew(46032, {
		servant_list = var_16_0
	}, 46033, var_0_0.OnServantDecompose)
end

function var_0_0.OnServantDecompose(arg_17_0, arg_17_1)
	if isSuccess(arg_17_0.result) then
		manager.notify:CallUpdateFunc(SERVANT_DECOMPOSE_RESULT, arg_17_0, arg_17_1)
	else
		ShowTips(arg_17_0.result)
	end
end

function var_0_0.ModifyServantList(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0) do
		if iter_18_1.item.num == 0 then
			WeaponServantData:RemoveServant(iter_18_1)
		else
			var_0_0.AddNewServant(iter_18_1)
		end
	end

	if #arg_18_0 > 0 then
		manager.notify:Invoke(WEAPON_SERVANT_LIST_UPDATE)
	end
end

function var_0_0.AddNewServant(arg_19_0)
	local var_19_0 = {
		uid = arg_19_0.uid,
		id = arg_19_0.item.id
	}

	WeaponServantData:AddServant(var_19_0)
	IllustratedAction.ModifyServantInfo(arg_19_0.item.id)
end

return var_0_0
