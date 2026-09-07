local IslandChangeDressupCommand = class("IslandChangeDressupCommand", pm.SimpleCommand)

function IslandChangeDressupCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.ship_id
	local var_1_2 = var_1_0.unload_dress
	local var_1_3 = var_1_0.dress_List
	local var_1_4 = var_1_0.skin_id
	local var_1_5 = var_1_0.color_id

	pg.ConnectionMgr.GetInstance():Send(21617, {
		ship_id = var_1_0.ship_id,
		dress_List = var_1_0.dress_List,
		unload_dress = var_1_0.unload_dress,
		skin_id = var_1_0.skin_id,
		color_id = var_1_0.color_id
	}, 21618, function(arg_2_0)
		if arg_2_0.result == 0 then
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandWearDress(var_1_1, var_1_3))

			local var_2_0 = getProxy(IslandProxy)
			local var_2_1 = var_2_0:GetIsland()
			local var_2_2 = var_2_1:GetCharacterAgency()
			local var_2_3 = var_2_2:GetShipById(var_1_1)
			local var_2_4

			if var_1_4 ~= var_2_3.GetCurSkinId(var_2_0) then
				var_2_4 = var_1_4
			end

			var_2_3:ChangeSkinId(var_1_4)

			local var_2_5

			if var_1_5 ~= var_2_2:GetSkinCurrentColor(var_2_3:GetCurSkinId()) then
				var_2_5 = var_1_5
			end

			var_2_2:SetSkinCurrentColor(var_1_4, var_1_5)

			local var_2_6 = {}

			for iter_2_0, iter_2_1 in ipairs(var_1_2) do
				var_2_2:AddDressItem(iter_2_1, 1)
				var_2_2:DischargeDressOnShip(var_1_1, iter_2_1)
				table.insert(var_2_6, iter_2_1)
			end

			local var_2_7 = {}
			local var_2_8 = {}

			for iter_2_2, iter_2_3 in ipairs(var_1_3) do
				local var_2_9 = iter_2_3.dress_id

				if iter_2_3.ship_id == 0 then
					var_2_2:ReduceDressItem(var_2_9, 1)
				else
					var_2_2:DischargeDressOnShip(iter_2_3.ship_id, var_2_9)

					var_2_8[iter_2_3.ship_id] = var_2_8[iter_2_3.ship_id] or {}

					table.insert(var_2_8[iter_2_3.ship_id], var_2_9)
				end

				var_2_2:ChargeDressOnShip(var_1_1, var_2_9)
				table.insert(var_2_7, var_2_9)
			end

			pg.TipsMgr.GetInstance():ShowTips(i18n("island_dress_save1"))

			local var_2_10

			if var_2_5 then
				if var_2_5 ~= 0 then
					var_2_10 = pg.island_skin_colordiff_template[var_2_5].model
				elseif var_2_4 then
					var_2_10 = var_2_4 ~= 0 and pg.island_skin_template[var_2_4].model or var_2_3:GetModelBySkinAndColorId(0, 0)
				end
			elseif var_2_4 then
				var_2_10 = var_2_4 ~= 0 and pg.island_skin_template[var_2_4].model or var_2_3:GetModelBySkinAndColorId(0, 0)
			end

			var_2_1:DispatchEvent(IslandCharacterAgency.CHANGE_CHARACTER_DRESS, var_1_1, var_2_10, var_2_6, var_2_7)

			for iter_2_4, iter_2_5 in pairs(var_2_8) do
				var_2_1:DispatchEvent(IslandCharacterAgency.CHANGE_CHARACTER_DRESS, iter_2_4, nil, iter_2_5, {})
			end

			self:sendNotification(GAME.ISLAND_CHANGE_ROLE_DRESS_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return IslandChangeDressupCommand
