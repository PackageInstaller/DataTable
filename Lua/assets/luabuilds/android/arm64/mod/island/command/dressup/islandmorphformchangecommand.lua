local var_0_0 = class("IslandMorphFormChangeCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.fromBodyDressId
	local var_1_2 = var_1_0.toBodyDressId
	local var_1_3 = var_1_0.callback

	if not var_1_0.fromBodyDressId or not var_1_2 then
		existCall(var_1_0.callback)

		return
	end

	local var_1_4 = getProxy(IslandProxy):GetIsland()

	if not var_1_4 then
		existCall(var_1_0.callback)

		return
	end

	local var_1_5 = var_1_4:GetDressUpAgency()

	if not var_1_5 then
		existCall(var_1_0.callback)

		return
	end

	if not pg.island_dress_template[var_1_2] then
		existCall(var_1_0.callback)

		return
	end

	local var_1_6 = pg.island_dress_template[var_1_1].cut_out_state
	local var_1_7 = pg.island_dress_template.get_id_list_by_related_dress[var_1_2] or {}
	local var_1_8 = var_1_5:GetBodyHatIsOn(var_1_2) and (var_1_7[1] or 0) or 0

	var_1_4:DispatchEvent(IslandDressUpAgency.MORPH_PLAYER_DRESS, var_1_1, var_1_2, var_1_8, var_1_6, function()
		arg_1_0:sendNotification(GAME.ISLAND_CHANGE_COMMANDER_DRESS, {
			hideTip = true,
			dress_List = {
				{
					type = IslandShipDressHelperNew.DressType.Body,
					id = var_1_2
				},
				{
					type = IslandShipDressHelperNew.DressType.Hat,
					id = var_1_8
				}
			},
			color_list = {},
			island_id = var_1_4.id,
			callback = var_1_3
		})

		return
	end)

	return
end

return var_0_0
