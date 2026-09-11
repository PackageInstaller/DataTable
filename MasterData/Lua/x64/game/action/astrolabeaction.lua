local var_0_0 = {}

function var_0_0.AstrolabeUnlock(arg_1_0, arg_1_1)
	manager.net:SendWithLoadingNew(14026, {
		id = arg_1_0,
		astrolabe_id = arg_1_1
	}, 14027, var_0_0.OnAstrolabeUnlock)
end

manager.net:Bind(14027, function(arg_2_0)
	if HeroTools.IsSpHero(arg_2_0.hero_id) and arg_2_0.hero_id and arg_2_0.unlock_id then
		HeroData:AstrolabeUnlock(arg_2_0.hero_id, arg_2_0.unlock_id)
	end

	manager.notify:CallUpdateFunc(ASTROLABE_UNLOCK, arg_2_0, sendData)
end)

function var_0_0:OnAstrolabeUnlock(arg_3_1)
	if isSuccess(self.result) and not HeroTools.IsSpHero(arg_3_1.id) then
		HeroData:AstrolabeUnlock(arg_3_1.id, arg_3_1.astrolabe_id)
		ShowTips("ASTROLABE_UNLOCK")
	end

	manager.notify:CallUpdateFunc(ASTROLABE_UNLOCK, self, arg_3_1)
end

function var_0_0.AstrolabeEquip(arg_4_0, arg_4_1)
	manager.net:SendWithLoadingNew(14028, {
		operation = 1,
		id = arg_4_0,
		astrolabe_id = arg_4_1
	}, 14029, var_0_0.OnAstrolabeEquip)
end

function var_0_0:OnAstrolabeEquip(arg_5_1)
	if isSuccess(self.result) then
		HeroData:AstrolabeEquip(arg_5_1.id, arg_5_1.astrolabe_id)
	end

	manager.notify:CallUpdateFunc(ASTROLABE_EQUIP, self, arg_5_1)
end

function var_0_0.AstrolabeEquipAll(arg_6_0, arg_6_1)
	manager.net:SendWithLoadingNew(14038, {
		hero_id = arg_6_0,
		astrolabe_suit_id = arg_6_1
	}, 14039, var_0_0.OnAstrolabeEquipAll)
end

function var_0_0:OnAstrolabeEquipAll(arg_7_1)
	if isSuccess(self.result) then
		HeroData:AstrolabeEquipAll(arg_7_1.hero_id, arg_7_1.astrolabe_suit_id)
	end

	manager.notify:CallUpdateFunc(ASTROLABE_EQUIP, self, arg_7_1)
end

function var_0_0.AstrolabeEquipByList(arg_8_0, arg_8_1)
	manager.net:SendWithLoadingNew(71116, {
		hero_id = arg_8_0,
		astrolabe_id_list = arg_8_1
	}, 71117, function(arg_9_0, arg_9_1)
		if isSuccess(arg_9_0.result) then
			HeroData:AstrolabeEquipByList(arg_8_0, arg_8_1)
		end

		manager.notify:CallUpdateFunc(ASTROLABE_EQUIP, arg_9_0, arg_9_1)
	end)
end

function var_0_0.AstrolabeUnload(arg_10_0, arg_10_1)
	manager.net:SendWithLoadingNew(14028, {
		operation = 2,
		id = arg_10_0,
		astrolabe_id = arg_10_1
	}, 14029, var_0_0.OnAstrolabeUnload)
end

function var_0_0:OnAstrolabeUnload(arg_11_1)
	if isSuccess(self.result) then
		HeroData:AstrolabeUnload(arg_11_1.id, arg_11_1.astrolabe_id)
	end

	manager.notify:CallUpdateFunc(ASTROLABE_UNLOAD, self, arg_11_1)
end

function var_0_0.AstrolabeUnloadAll(arg_12_0)
	manager.net:SendWithLoadingNew(14040, {
		hero_id = arg_12_0
	}, 14041, var_0_0.OnAstrolabeUnloadAll)
end

function var_0_0:OnAstrolabeUnloadAll(arg_13_1)
	if isSuccess(self.result) then
		HeroData:AstrolabeUnloadAll(arg_13_1.hero_id)
	end

	manager.notify:CallUpdateFunc(ASTROLABE_UNLOAD, self, arg_13_1)
end

function var_0_0.UpdateHeroAstrolabeCanUnLockRed(arg_14_0)
	if AstrolabeTools.GetIsHaveCanUnlock(arg_14_0) then
		manager.redPoint:setTip(RedPointConst.ASTROLABE_UNLOCK, 1)
	else
		manager.redPoint:setTip(RedPointConst.ASTROLABE_UNLOCK, 0)
	end
end

return var_0_0
