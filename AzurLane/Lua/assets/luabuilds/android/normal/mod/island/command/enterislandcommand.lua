class = var_0_10000

local var_0_0 = "EnterIslandCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.code
	local var_1_2 = var_2.reconnect

	getProxy = var_1_10006
	PlayerProxy = var_1_10007

	local var_1_3 = var_1_10006(var_1_10007)

	if var_6.getRawData(var_1_3) then
		pg = var_1_3

		local var_1_4 = var_1_3.SystemOpenMgr.GetInstance()
		local var_1_5 = var_8.isOpenSystem
		local var_1_6 = var_7.level

		IslandMediator = var_1_10011

		local var_1_7, var_1_8 = var_1_5(var_1_4, var_1_6, var_1_10011.__cname)

		if not var_1_7 then
			pg = var_1_6

			local var_1_9 = var_1_6.TipsMgr.GetInstance()

			var_10.ShowTips(var_1_9, var_1_8)

			return
		end
	end

	if var_1_1 and var_1_1 ~= "" then
		arg_1_0:Send(0, var_1_1, var_1_2)
	else
		arg_1_0:Send(var_1_0, 0, var_1_2)
	end

	return
end

function var_0_1.Send(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	pg = var_1_10004

	local var_2_0 = var_1_10004.ConnectionMgr.GetInstance()
	local var_2_1 = var_4.Send
	local var_2_2 = 21202
	local var_2_3 = {
		island_id = arg_2_1
	}

	tostring = var_1_10008
	var_2_3.code = var_1_10008(arg_2_2)

	var_2_1(var_2_0, var_2_2, var_2_3, 21203, function(arg_3_0)
		if arg_3_0.result == 0 then
			local var_3_0 = {}

			var_2_10003 = arg_2_0

			local var_3_1 = var_2.IsSelf(var_2_10003, arg_2_1)

			table = var_2_10003

			var_2_10003.insert(var_3_0, function(arg_4_0)
				local var_4_0 = arg_2_0
				local var_4_1 = var_1.sendNotification

				GAME = var_3_10003

				var_4_1(var_4_0, var_3_10003.ISLAND_GET_DATA, {
					id = arg_3_0.island_id,
					list = arg_3_0.player_list,
					reconnect = arg_2_3,
					checkCanEnterMap = arg_4_0
				})

				return
			end)

			var_2_10003 = false
			table = var_4

			var_4.insert(var_3_0, function(arg_5_0)
				if var_3_1 then
					getProxy = var_1
					IslandProxy = var_3_10002

					local var_5_0 = var_1(var_3_10002)
					local var_5_1 = var_1.GetIsland(var_5_0)
					local var_5_2 = var_1.GetSeasonAgency(var_5_1)

					var_2_10003 = var_2.NeedReset(var_5_2)

					if var_2_10003 then
						local var_5_3 = arg_2_0
						local var_5_4 = var_2.sendNotification

						GAME = var_3_10004

						var_5_4(var_5_3, var_3_10004.ISLAND_RESET_SEASON, {
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

			table = var_4

			var_4.insert(var_3_0, function(arg_6_0)
				if var_2_10003 then
					local var_6_0 = arg_2_0
					local var_6_1 = var_1.sendNotification

					GAME = var_3_10003

					var_6_1(var_6_0, var_3_10003.ISLAND_GET_DATA, {
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

			seriesAsync = var_4

			var_4(var_3_0, function()
				if var_3_1 then
					getProxy = var_7_1
					IslandProxy = var_3_10001
					var_3_10001 = var_7_1(var_3_10001)

					local var_7_1

					if not var_7_1.GetIsland(var_3_10001) then
						getProxy = var_7_1
						IslandProxy = var_3_10001

						local var_7_0 = var_7_1(var_3_10001)

						var_7_1 = var_7_1.GetSharedIsland(var_7_0)
					end

					local var_7_2 = arg_2_0
					local var_7_3 = var_1.sendNotification

					GAME = var_3_10003

					var_7_3(var_7_2, var_3_10003.ISLAND_ENTER_MAP, {
						islandId = arg_3_0.island_id,
						mapId = var_7_1:GetMapId(),
						callback = function()
							local var_8_0 = arg_2_0

							var_0.GoScene(var_8_0, arg_3_0.island_id)

							return
						end
					})

					getProxy = var_7_3
					IslandProxy = var_7_2

					local var_7_4 = var_7_3(var_7_2)

					var_1.EnterIsland(var_7_4, arg_3_0.island_id)

					return
				end
			end)
		elseif arg_3_0.result == 6 then
			local var_3_2 = arg_2_0
			local var_3_3 = var_1.sendNotification

			GAME = var_2_10003

			var_3_3(var_3_2, var_2_10003.ISLAND_QUEUE_UP, {
				pos = arg_3_0.pos,
				id = arg_3_0.island_id
			})
		elseif arg_3_0.result == 19 then
			pg = var_1

			local var_3_4 = var_1.TimeMgr.GetInstance()
			local var_3_5 = var_1.GetServerTime(var_3_4)
			local var_3_6 = arg_3_0.cd - var_3_5

			pg = var_2_10003

			local var_3_7 = var_2_10003.TimeMgr.GetInstance()

			var_2_10003 = var_2_10003.DescCDTime(var_3_7, var_3_6)
			pg = var_3_7

			local var_3_8 = var_3_7.TipsMgr.GetInstance()
			local var_3_9 = var_4.ShowTips

			i18n = var_2_10006

			var_3_9(var_3_8, var_2_10006("island_visit_tip5", var_2_10003))
		elseif arg_3_0.result == 1 then
			pg = var_1

			local var_3_10 = var_1.TipsMgr.GetInstance()
			local var_3_11 = var_1.ShowTips

			i18n = var_2_10003

			var_3_11(var_3_10, var_2_10003("island_visit_tip1"))
		elseif arg_3_0.result == 20 or arg_3_0.result == 40 then
			pg = var_1

			local var_3_12 = var_1.TipsMgr.GetInstance()
			local var_3_13 = var_1.ShowTips

			i18n = var_2_10003

			var_3_13(var_3_12, var_2_10003("island_visit_tip2"))
		else
			local var_3_15

			if arg_3_0.result == 9 then
				pg = var_3_15

				local var_3_14 = var_3_15.TipsMgr.GetInstance()

				var_3_15 = var_3_15.ShowTips
				i18n = var_2_10003

				var_3_15(var_3_14, var_2_10003("island_visit_tip3"))
			else
				pg = var_3_15

				local var_3_16 = var_3_15.TipsMgr.GetInstance()
				local var_3_17 = var_1.ShowTips

				ERROR_MESSAGE = var_2_10003

				var_3_17(var_3_16, var_2_10003[arg_3_0.result] .. arg_3_0.result)
			end
		end

		return
	end)

	return
end

function var_0_1.IsSelf(arg_9_0, arg_9_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_9_0 = var_1_10002(var_1_10003)

	return var_2.getRawData(var_9_0).id == arg_9_1
end

function var_0_1.GoScene(arg_10_0, arg_10_1)
	local var_10_2

	if arg_10_0:IsSelf(arg_10_1) then
		local var_10_0 = arg_10_0
		local var_10_1 = arg_10_0.sendNotification

		GAME = var_10_2
		var_10_2 = var_10_2.GO_SCENE
		SCENE = var_1_10005

		var_10_1(var_10_0, var_10_2, var_1_10005.ISLAND, {
			id = arg_10_1
		})
	else
		local var_10_3 = arg_10_0
		local var_10_4 = arg_10_0.sendNotification

		GAME = var_10_2

		local var_10_5 = var_10_2.GO_SCENE

		SCENE = var_1_10005

		var_10_4(var_10_3, var_10_5, var_1_10005.SHARED_ISLAND, {
			id = arg_10_1
		})
	end

	return
end

return var_0_1
