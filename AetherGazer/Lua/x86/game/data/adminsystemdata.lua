local var_0_0 = singletonClass("AdminSystemData")
local var_0_1 = 0
local var_0_2 = 0
local var_0_3 = {}
local var_0_4 = {}

function var_0_0.InitData(arg_1_0, arg_1_1)
	var_0_4 = cleanProtoTable(arg_1_1.player_info_list)
end

function var_0_0.GetAdminId(arg_2_0)
	return
end

function var_0_0.GetAdminUsingSkin(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(var_0_4) do
		if iter_3_1.id == arg_3_1 then
			return iter_3_1.using_skin
		end
	end

	return 0
end

function var_0_0.GetUnlockSkinList(arg_4_0)
	local var_4_0 = 0

	for iter_4_0, iter_4_1 in ipairs(var_0_4) do
		var_4_0 = var_4_0 + #iter_4_1.unlocked_skin
	end

	return var_4_0
end

function var_0_0.SelectSkin(arg_5_0, arg_5_1, arg_5_2)
	for iter_5_0, iter_5_1 in ipairs(var_0_4) do
		if arg_5_1 == iter_5_1.id then
			iter_5_1.using_skin = arg_5_2

			break
		end
	end
end

function var_0_0.GetIsUnlockSkin(arg_6_0, arg_6_1)
	return
end

function var_0_0.GetPlayerSkinProp(arg_7_0)
	local var_7_0 = 2
	local var_7_1 = HeroCfg.get_id_list_by_role_type[1]
	local var_7_2 = 0

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		var_7_2 = var_7_2 + #SkinCfg.get_id_list_by_hero[iter_7_1]
	end

	return var_7_0 / var_7_2
end

return var_0_0
