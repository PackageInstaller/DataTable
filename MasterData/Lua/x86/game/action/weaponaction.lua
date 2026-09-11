local var_0_0 = {
	WeaponStr = function(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
		manager.net:SendWithLoadingNew(46016, {
			hero_id = arg_1_0,
			material_list = arg_1_1,
			servant_list = arg_1_2
		}, 46017, function(arg_2_0, arg_2_1)
			WeaponAction.OnWeaponStr(arg_2_0, arg_2_1, arg_1_3)
		end)
	end,
	OnWeaponStr = function(self, arg_3_1, arg_3_2)
		if isSuccess(self.result) then
			WeaponAction.OnWeaponStrResponse(self, arg_3_1, arg_3_2)
			manager.notify:Invoke(WEAPON_STR, self, arg_3_1)
			manager.notify:Invoke(WEAPON_DATA_MODIFY, arg_3_1.hero_id)
		else
			ShowTips(self.result)
		end
	end,
	OnWeaponStrResponse = function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = HeroData:GetHeroList()[arg_4_1.hero_id].weapon_info
		local var_4_1, var_4_2, var_4_3 = WeaponTools.AddWeaponExp(var_4_0.exp, var_4_0.breakthrough, arg_4_2)

		HeroAction.WeaponStr(arg_4_1.hero_id, var_4_2, var_4_0.exp + (arg_4_2 - var_4_3))
	end,
	WeaponBreak = function(arg_5_0)
		manager.net:SendWithLoadingNew(46018, {
			hero_id = arg_5_0
		}, 46019, function(arg_6_0, arg_6_1)
			WeaponAction.OnWeaponBreak(arg_6_0, arg_6_1)
		end)
	end,
	OnWeaponBreak = function(self, arg_7_1)
		if isSuccess(self.result) then
			WeaponAction.OnWeaponBreakResponse(self, arg_7_1)
			manager.notify:Invoke(WEAPON_BREAK, self, arg_7_1)
			manager.notify:Invoke(WEAPON_DATA_MODIFY, arg_7_1.hero_id)
		else
			ShowTips(self.result)
		end
	end,
	OnWeaponBreakResponse = function(arg_8_0, arg_8_1)
		HeroAction.WeaponBreak(arg_8_1.hero_id, HeroData:GetHeroList()[arg_8_1.hero_id].weapon_info.breakthrough + 1)
	end,
	WeaponLvUp = function(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6, arg_9_7)
		manager.net:SendWithLoadingNew(46034, {
			hero_id = arg_9_0,
			material_list = arg_9_1,
			servant_list = arg_9_2,
			target_level = arg_9_3,
			breakthrough_times = arg_9_4
		}, 46035, function(arg_10_0, arg_10_1)
			WeaponAction.OnWeaponLvUp(arg_10_0, arg_10_1, arg_9_5, arg_9_6, arg_9_7)
		end)
	end,
	OnWeaponLvUp = function(self, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
		if isSuccess(self.result) then
			WeaponAction.OnWeaponLvUpResponse(self, arg_11_1, arg_11_2)
			manager.notify:Invoke(WEAPON_QUICK, self, arg_11_1, arg_11_3, arg_11_4)
			manager.notify:Invoke(WEAPON_DATA_MODIFY, arg_11_1.hero_id)
		else
			ShowTips(self.result)
		end
	end,
	OnWeaponLvUpResponse = function(arg_12_0, arg_12_1, arg_12_2)
		local var_12_0 = HeroData:GetHeroList()[arg_12_1.hero_id].weapon_info

		HeroAction.WeaponStr(arg_12_1.hero_id, arg_12_1.target_level, var_12_0.exp + arg_12_2)
		HeroAction.WeaponBreak(arg_12_1.hero_id, var_12_0.breakthrough + arg_12_1.breakthrough_times)
	end,
	CheckLvUp = function(arg_13_0)
		local var_13_0 = {}
		local var_13_1 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD)
		local var_13_2 = deepClone(HeroData:GetHeroList()[arg_13_0].weapon_info)

		if GameSetting.weapon_exp_limit.value[var_13_2.breakthrough + 1] <= var_13_2.level then
			return false
		end

		for iter_13_0, iter_13_1 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.MATERIAL]) do
			local var_13_3 = ItemTools.getItemNum(iter_13_1)

			if ItemCfg[iter_13_1].sub_type == MaterialConst.MATERIAL_TYPE.WEAPON_LEVEL_UP and var_13_3 > 0 then
				table.insert(var_13_0, {
					index = 0,
					select = 0,
					type = ItemConst.ITEM_TYPE.MATERIAL,
					id = iter_13_1,
					number = var_13_3
				})
			end
		end

		table.sort(var_13_0, function(arg_14_0, arg_14_1)
			return ItemCfg[arg_14_0.id].rare < ItemCfg[arg_14_1.id].rare
		end)

		local var_13_4 = GameLevelSetting[var_13_2.level + 1].weapon_lv_exp_sum - var_13_2.exp

		for iter_13_2 = #var_13_0, 1, -1 do
			local var_13_5 = 0

			while var_13_4 > 0 and var_13_5 < var_13_0[iter_13_2].number do
				var_13_4 = var_13_4 - ItemCfg[var_13_0[iter_13_2].id].param[1]
				var_13_5 = var_13_5 + 1
			end

			if var_13_4 < 0 and iter_13_2 > 1 then
				var_13_4 = var_13_4 + ItemCfg[var_13_0[iter_13_2].id].param[1]
			end
		end

		if var_13_4 > 0 then
			return false
		end

		if var_13_1 < (var_13_2.level + 1 == GameSetting.weapon_exp_limit.value[var_13_2.breakthrough + 1] and (GameLevelSetting[var_13_2.level + 1].weapon_lv_exp_sum - var_13_2.exp) * GameSetting.weapon_strengthen_gold_cost.value[1] or (GameLevelSetting[var_13_2.level + 1].weapon_lv_exp_sum - var_13_2.exp - var_13_4) * GameSetting.weapon_strengthen_gold_cost.value[1]) then
			return false
		end

		return true
	end,
	CheckBreak = function(arg_15_0, arg_15_1)
		local var_15_0 = deepClone(HeroData:GetHeroList()[arg_15_0].weapon_info)

		if GameSetting.weapon_exp_limit.value[var_15_0.breakthrough + 1] > var_15_0.level or GameSetting.weapon_exp_limit.value[var_15_0.breakthrough + 1] == HeroConst.WEAPON_LV_MAX then
			if arg_15_1 then
				ShowTips("ERROR_HERO_WEAPON_LEVEL_LIMIT")
			end

			return false
		end

		if PlayerData:GetPlayerInfo().userLevel < GameSetting.weapon_user_limit.value[var_15_0.breakthrough + 1] then
			if arg_15_1 then
				ShowTips("ERROR_USER_LEVEL_LIMIT")
			end

			return false
		end

		local var_15_1, var_15_2 = WeaponTools.BreakMaterial(var_15_0.breakthrough)

		for iter_15_0, iter_15_1 in pairs(var_15_2) do
			if ItemTools.getItemNum(iter_15_1[1]) < iter_15_1[2] then
				if arg_15_1 then
					ShowTips("ERROR_ITEM_NOT_ENOUGH_MATERIAL")
				end

				return false
			end
		end

		if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD) < var_15_1 then
			if arg_15_1 then
				checkGold(var_15_1)
			end

			return false
		end

		return true
	end
}

manager.notify:RegistListener(MATERIAL_INIT, function()
	var_0_0.UpdateWeaponBreakRedPoint()
end)
manager.notify:RegistListener(HERO_DATA_INIT, function()
	var_0_0.UpdateWeaponBreakRedPoint()
end)
manager.notify:RegistListener(PLAYER_LEVEL_UP, function()
	var_0_0.UpdateWeaponBreakRedPoint()
end)
manager.notify:RegistListener(CURRENCY_UPDATE, function()
	var_0_0.UpdateWeaponBreakRedPoint()
end)
manager.notify:RegistListener(MATERIAL_MODIFY, function()
	var_0_0.UpdateWeaponBreakRedPoint()
end)
manager.notify:RegistListener(PLAYER_MODIFIED, function()
	var_0_0.UpdateWeaponBreakRedPoint()
end)
manager.notify:RegistListener(WEAPON_DATA_MODIFY, function()
	var_0_0.UpdateWeaponBreakRedPoint()
end)

function var_0_0.UpdateWeaponBreakRedPoint()
	local var_23_0 = HeroData:GetHeroList()

	if not var_23_0 then
		return
	end

	for iter_23_0, iter_23_1 in pairs(var_23_0) do
		if var_0_0.CheckBreak(iter_23_0, false) or var_0_0.CheckLvUp(iter_23_0) then
			manager.redPoint:setTip(RedPointConst.HERO_WEAPON_BREAK_ID .. iter_23_0, 1)
		else
			manager.redPoint:setTip(RedPointConst.HERO_WEAPON_BREAK_ID .. iter_23_0, 0)
		end
	end
end

return var_0_0
