local var_0_0 = singletonClass("HideInfoData")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = {}
local var_0_5 = {}
local var_0_6 = {
	EQUIP = 3,
	HERO = 1,
	WEAPON_SERVANT = 2,
	SKIN = 4
}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
	var_0_2 = {}
	var_0_3 = {}
	var_0_4 = {}
	var_0_5 = {}
end

function var_0_0.InitHideData(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1.hide_list) do
		if iter_2_1.type == var_0_6.HERO then
			for iter_2_2, iter_2_3 in ipairs(iter_2_1.id_list) do
				var_0_1[iter_2_3] = true

				if HeroCfg[iter_2_3] then
					local var_2_0 = HeroTools.GetHeroSpecServant(iter_2_3)

					if var_2_0 then
						var_0_4[var_2_0] = true
					end

					local var_2_1 = SkinCfg.get_id_list_by_hero[iter_2_3]

					for iter_2_4, iter_2_5 in ipairs(var_2_1) do
						var_0_3[iter_2_5] = true
						var_0_2[SkinCfg[iter_2_5].portrait] = true
					end
				end
			end
		elseif iter_2_1.type == var_0_6.WEAPON_SERVANT then
			for iter_2_6, iter_2_7 in ipairs(iter_2_1.id_list) do
				var_0_4[iter_2_7] = true
			end
		elseif iter_2_1.type == var_0_6.EQUIP then
			for iter_2_8, iter_2_9 in ipairs(iter_2_1.id_list) do
				var_0_5[iter_2_9] = true
			end
		elseif iter_2_1.type == var_0_6.SKIN then
			for iter_2_10, iter_2_11 in ipairs(iter_2_1.id_list) do
				var_0_3[iter_2_11] = true
				var_0_2[SkinCfg[iter_2_11].portrait] = true
			end
		end
	end
end

function var_0_0.GetHeroHideList(arg_3_0)
	return var_0_1
end

function var_0_0.GetWeaponServantHideList(arg_4_0)
	return var_0_4
end

function var_0_0.GetEquipSuitHideList(arg_5_0)
	return var_0_5
end

function var_0_0.GetSkinHideList(arg_6_0)
	return var_0_3
end

function var_0_0.GetHeadIconHideList(arg_7_0)
	return var_0_2
end

return var_0_0
