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

	local var_6_0
	local var_6_1

	if var_0_0.touched == true then
		manager.redPoint:setTip(RedPointConst.WEAPON_SERVANT_MERGE, 0)

		do return end

		var_6_0 = false
		var_6_1 = pairs
	end

	for iter_6_0, iter_6_1 in var_6_1(GameSetting.exclusive_weapon_servant_cost.value) do
		local var_6_2 = iter_6_1[2]
		local var_6_3 = WeaponServantData:GetWeaponServantById(iter_6_1[2][1][1])

		if ItemTools.getItemNum(var_6_2[2][1]) >= var_6_2[2][2] and ((var_6_3 or nil) and #var_6_3) >= var_6_2[1][2] then
			var_6_0 = true

			break
		end
	end

	manager.redPoint:setTip(RedPointConst.WEAPON_SERVANT_MERGE, var_6_0 and 1 or 0)
end

function var_0_0.ServantPromote(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	var_0_0.costMoney = arg_7_3

	manager.net:SendWithLoadingNew(46012, {
		refined_type = arg_7_0,
		uid = arg_7_1,
		cost_uid = arg_7_2
	}, 46013, var_0_0.OnServantPromote)
end

function var_0_0:OnServantPromote(arg_8_1)
	if isSuccess(self.result) then
		WeaponServantData:ServantPromote(arg_8_1.uid, arg_8_1.cost_uid)
		manager.notify:Invoke(SERVANT_PROMOTE, self, arg_8_1)
	else
		ShowTips(self.result)
	end
end

function var_0_0.ServantReplace(arg_9_0, arg_9_1)
	manager.net:SendWithLoadingNew(46020, {
		hero_id = arg_9_0,
		servant_id = arg_9_1
	}, 46021, var_0_0.OnServantReplace)
end

function var_0_0:OnServantReplace(arg_10_1)
	if isSuccess(self.result) then
		local var_10_0 = ServantTools.GetServantMap()[arg_10_1.servant_id]

		if var_10_0 then
			HeroAction.ServantReplace(var_10_0, 0)
		end

		HeroAction.ServantReplace(arg_10_1.hero_id, arg_10_1.servant_id)
		manager.notify:CallUpdateFunc(SERVANT_REPLACE, self, arg_10_1)
		manager.notify:Invoke(SERVANT_REPLACE, self, arg_10_1, HeroData:GetHeroData(arg_10_1.hero_id).servant_uid)
	else
		ShowTips(self.result)
	end
end

function var_0_0.ServantLock(arg_11_0)
	manager.net:SendWithLoadingNew(46014, {
		uid = arg_11_0,
		is_lock = WeaponServantData:GetServantDataByUID(arg_11_0).locked == 1 and 0 or 1
	}, 46015, var_0_0.OnServantLock)
end

function var_0_0:OnServantLock(arg_12_1)
	if isSuccess(self.result) then
		WeaponServantData:ServantLock(arg_12_1.uid, arg_12_1.is_lock)
		manager.notify:CallUpdateFunc(SERVANT_LOCK, self, arg_12_1)
	else
		ShowTips(self.result)
	end
end

function var_0_0.ServantMerge(arg_13_0, arg_13_1)
	local var_13_0 = {
		servant_id = arg_13_0,
		cost_uid_list = arg_13_1
	}
	local var_13_1 = var_13_0.cost_uid_list[1]
	local var_13_2 = WeaponServantData:GetServantDataByUID(var_13_0.cost_uid_list[1]).locked
	local var_13_3
	local var_13_4 = ServantTools.GetServantMap()

	for iter_13_0, iter_13_1 in ipairs(var_13_0.cost_uid_list) do
		if var_13_4[iter_13_1] then
			var_13_3 = var_13_4[iter_13_1]

			break
		end
	end

	manager.net:SendWithLoadingNew(46030, var_13_0, 46031, function(arg_14_0)
		ServantAction.OnServantMerge(arg_14_0, var_13_0, var_13_1, var_13_2, var_13_3)
	end)
end

function var_0_0:OnServantMerge(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_0 = tonumber(self.servant_uid)

	if isSuccess(self.result) then
		for iter_15_0, iter_15_1 in ipairs(GameSetting.exclusive_weapon_servant_cost.value) do
			if iter_15_1[1] == WeaponServantCfg[arg_15_1.servant_id].race then
				-- block empty
			end
		end

		WeaponServantData:ServantLock(var_15_0, arg_15_3)
		WeaponServantData:SetServantMergeMap(arg_15_2, var_15_0)

		if arg_15_4 then
			HeroData:ServantReplace(arg_15_4, var_15_0)
		end

		IllustratedAction.ModifyServantInfo(arg_15_1.servant_id)
		manager.notify:CallUpdateFunc(SERVANT_MERGE_RESULT, self, arg_15_1)
	elseif TipsCfg[self.result] then
		ShowTips(TipsCfg[self.result].desc)
	else
		ShowTips(self.result)
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

function var_0_0:OnServantDecompose(arg_17_1)
	if isSuccess(self.result) then
		manager.notify:CallUpdateFunc(SERVANT_DECOMPOSE_RESULT, self, arg_17_1)
	else
		ShowTips(self.result)
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

function var_0_0:AddNewServant()
	WeaponServantData:AddServant({
		uid = self.uid,
		id = self.item.id
	})
	IllustratedAction.ModifyServantInfo(self.item.id)
end

return var_0_0
