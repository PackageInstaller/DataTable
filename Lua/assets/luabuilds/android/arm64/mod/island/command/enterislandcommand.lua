local var_0_0 = class("EnterIslandCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(PlayerProxy):getRawData()

	if var_1_1 then
		local var_1_2, var_1_3 = pg.SystemOpenMgr.GetInstance():isOpenSystem(var_1_1.level, IslandMediator.__cname)

		if not var_1_2 then
			pg.TipsMgr.GetInstance():ShowTips(var_1_3)

			return
		end
	end

	if var_1_0.code and var_1_0.code ~= "" then
		arg_1_0:Send(0, var_1_0.code, var_1_0.reconnect)
	else
		arg_1_0:Send(var_1_0.id, 0, var_1_0.reconnect)
	end

	return
end

function var_0_0.Send(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	pg.ConnectionMgr.GetInstance():Send(21202, {
		island_id = arg_2_1,
		code = tostring(arg_2_2)
	}, 21203, function(arg_3_0)
		local var_3_9000

		if arg_3_0.result == 0 then
			local var_3_0 = arg_2_0:IsSelf(arg_2_1)

			table.insert({}, function(arg_4_0)
				arg_2_0:sendNotification(GAME.ISLAND_GET_DATA, {
					id = arg_3_0.island_id,
					list = arg_3_0.player_list,
					reconnect = arg_2_3,
					checkCanEnterMap = arg_4_0
				})

				return
			end)

			local var_3_1 = false

			table.insert({}, function(arg_5_0)
				if var_3_0 then
					var_3_1 = getProxy(IslandProxy):GetIsland():GetSeasonAgency():NeedReset()

					if var_3_1 then
						arg_2_0:sendNotification(GAME.ISLAND_RESET_SEASON, {
							callback = arg_5_0
						})
					else
						arg_5_0()
					end
				else
					arg_5_0()
				end

				return
			end)
			table.insert({}, function(arg_6_0)
				if var_3_1 then
					arg_2_0:sendNotification(GAME.ISLAND_GET_DATA, {
						id = arg_3_0.island_id,
						list = arg_3_0.player_list,
						reconnect = arg_2_3,
						checkCanEnterMap = arg_6_0
					})
				else
					arg_6_0()
				end

				return
			end)
			seriesAsync({}, function()
				if var_3_0 then
					local var_7_0 = getProxy(IslandProxy):GetIsland() or getProxy(IslandProxy):GetSharedIsland()

					arg_2_0:sendNotification(GAME.ISLAND_ENTER_MAP, {
						islandId = arg_3_0.island_id,
						mapId = var_7_0:GetMapId(),
						callback = function()
							arg_2_0:GoScene(arg_3_0.island_id)

							return
						end
					})
					getProxy(IslandProxy):EnterIsland(arg_3_0.island_id)

					return
				end
			end)
		elseif arg_3_0.result == 6 then
			arg_2_0:sendNotification(GAME.ISLAND_QUEUE_UP, {
				pos = arg_3_0.pos,
				id = arg_3_0.island_id
			})
		elseif arg_3_0.result == 19 then
			local var_3_2 = pg.TipsMgr.GetInstance()

			var_3_2.ShowTips(arg_3_0.cd - pg.TimeMgr.GetInstance().GetServerTime(var_3_9000), i18n("island_visit_tip5", (pg.TimeMgr.GetInstance():DescCDTime(var_3_2))))
		elseif arg_3_0.result == 1 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_visit_tip1"))
		elseif arg_3_0.result == 20 or arg_3_0.result == 40 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_visit_tip2"))
		elseif arg_3_0.result == 9 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_visit_tip3"))
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_3_0.result] .. arg_3_0.result)
		end

		return
	end)

	return
end

function var_0_0.IsSelf(arg_9_0, arg_9_1)
	local var_9_0 = getProxy(PlayerProxy)

	return var_9_0:getRawData().id == arg_9_1
end

function var_0_0.GoScene(arg_10_0, arg_10_1)
	if arg_10_0:IsSelf(arg_10_1) then
		arg_10_0:sendNotification(GAME.GO_SCENE, SCENE.ISLAND, {
			id = arg_10_1
		})
	else
		arg_10_0:sendNotification(GAME.GO_SCENE, SCENE.SHARED_ISLAND, {
			id = arg_10_1
		})
	end

	return
end

return var_0_0
