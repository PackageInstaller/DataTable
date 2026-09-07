local EnterIslandCommand = class("EnterIslandCommand", pm.SimpleCommand)

function EnterIslandCommand:execute(arg_1_1)
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
		self:Send(0, var_1_0.code, var_1_0.reconnect)
	else
		self:Send(var_1_0.id, 0, var_1_0.reconnect)
	end

	return
end

function EnterIslandCommand:Send(arg_2_1, arg_2_2, arg_2_3)
	pg.ConnectionMgr.GetInstance():Send(21202, {
		island_id = arg_2_1,
		code = tostring(arg_2_2)
	}, 21203, function(arg_3_0)
		local var_3_9000

		if arg_3_0.result == 0 then
			local var_3_0 = {}
			local var_3_1 = self:IsSelf(arg_2_1)

			table.insert(var_3_0, function(arg_4_0)
				self:sendNotification(GAME.ISLAND_GET_DATA, {
					id = arg_3_0.island_id,
					list = arg_3_0.player_list,
					reconnect = arg_2_3,
					checkCanEnterMap = arg_4_0
				})

				return
			end)

			local var_3_2 = false

			table.insert(var_3_0, function(arg_5_0)
				if var_3_1 then
					var_3_2 = getProxy(IslandProxy):GetIsland():GetSeasonAgency():NeedReset()

					if var_3_2 then
						self:sendNotification(GAME.ISLAND_RESET_SEASON, {
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
			table.insert(var_3_0, function(arg_6_0)
				if var_3_2 then
					self:sendNotification(GAME.ISLAND_GET_DATA, {
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
			seriesAsync(var_3_0, function()
				self:sendNotification(GAME.ISLAND_ENTER_MAP, {
					islandId = arg_3_0.island_id,
					mapId = ((var_3_1 or nil) and (getProxy(IslandProxy):GetIsland() or getProxy(IslandProxy):GetSharedIsland())):GetMapId(),
					callback = function()
						self:GoScene(arg_3_0.island_id)

						return
					end
				})
				getProxy(IslandProxy):EnterIsland(arg_3_0.island_id)

				return
			end)
		elseif arg_3_0.result == 6 then
			self:sendNotification(GAME.ISLAND_QUEUE_UP, {
				pos = arg_3_0.pos,
				id = arg_3_0.island_id
			})
		elseif arg_3_0.result == 19 then
			pg.TipsMgr.GetInstance().ShowTips(arg_3_0.cd - pg.TimeMgr.GetInstance():GetServerTime(), i18n("island_visit_tip5", (pg.TimeMgr.GetInstance():DescCDTime(var_3_9000))))
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

function EnterIslandCommand:IsSelf(arg_9_1)
	return getProxy(PlayerProxy):getRawData().id == arg_9_1
end

function EnterIslandCommand:GoScene(arg_10_1)
	if self:IsSelf(arg_10_1) then
		self:sendNotification(GAME.GO_SCENE, SCENE.ISLAND, {
			id = arg_10_1
		})
	else
		self:sendNotification(GAME.GO_SCENE, SCENE.SHARED_ISLAND, {
			id = arg_10_1
		})
	end

	return
end

return EnterIslandCommand
