local var_0_0 = {}

manager.net:Bind(14201, function(arg_1_0)
	AdminSystemData:InitData(arg_1_0)
end)

function var_0_0.SelectSkin(arg_2_0, arg_2_1)
	if arg_2_0 == arg_2_1 then
		arg_2_1 = 0
	end

	return manager.net:SendWithLoadingNew(14202, {
		player_id = arg_2_0,
		skin_id = arg_2_1
	}, 14203, var_0_0.OnSelectSkin)
end

function var_0_0.OnSelectSkin(arg_3_0, arg_3_1)
	if isSuccess(arg_3_0.result) then
		AdminSystemData:SelectSkin(arg_3_1.player_id, arg_3_1.skin_id)
	else
		ShowTips(arg_3_0.result)
	end

	manager.notify:CallUpdateFunc(HERO_SKIN_SELECT, arg_3_0, arg_3_1)
end

return var_0_0
