class = var_0_10000

local var_0_0 = "GuildUpdateAssaultFleetCommand"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".GuildEventBaseCommand"))

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().fleet
	local var_1_1 = var_2.callBack

	getProxy = var_1_10005
	GuildProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)
	local var_1_3 = var_5.getData(var_1_2)

	if var_6.GetActiveEvent(var_1_3) then
		var_1_10009 = var_7

		if var_7.GetBossMission(var_1_10009) and var_1_3:IsActive() then
			pg = var_1_10009

			local var_1_4 = var_1_10009.TipsMgr.GetInstance()

			var_1_10009 = var_1_10009.ShowTips
			i18n = var_1_10011

			var_1_10009(var_1_4, var_1_10011("guild_formation_erro_in_boss_battle"))

			return
		end
	end

	getProxy = var_1_3
	PlayerProxy = var_1_10009

	local var_1_5 = var_1_3(var_1_10009)
	local var_1_6 = var_8.getRawData(var_1_5).id
	local var_1_7 = var_6:getMemberById(var_1_6)

	if not var_9.GetExternalAssaultFleet(var_1_7) then
		return
	end

	if not var_1_0 then
		return
	end

	if not var_10:AnyShipChanged(var_1_0) then
		pg = var_11

		local var_1_8 = var_11.TipsMgr.GetInstance()
		local var_1_9 = var_11.ShowTips

		i18n = var_13

		var_1_9(var_1_8, var_13("guild_must_edit_fleet"))

		return
	end

	local var_1_10 = {}
	local var_1_11 = var_1_0
	local var_1_12 = var_1_0.GetShipList(var_1_11)

	pairs = var_1_11

	for iter_1_0, iter_1_1 in var_1_11(var_1_12) do
		if var_10:PositionIsChanged(var_1_0, iter_1_0) then
			GuildAssaultFleet = var_18

			local var_1_13 = var_18.GetRealId(iter_1_1.id)

			table = var_19

			var_19.insert(var_1_10, {
				pos = iter_1_0,
				shipId = var_1_13
			})
		end
	end

	pg = var_13

	local var_1_14 = var_13.ConnectionMgr.GetInstance()

	var_13.Send(var_1_14, 61003, {
		shipIds = var_1_10
	}, 61004, function(arg_2_0)
		local var_2_6

		if arg_2_0.result == 0 then
			ipairs = var_2_6

			for iter_2_0, iter_2_1 in var_2_6(var_1_10) do
				pg = var_2_10006

				local var_2_0 = var_2_10006.TimeMgr.GetInstance()

				var_2_10006 = var_2_10006.GetServerTime(var_2_0)

				local var_2_1 = var_0

				var_7.UpdatePosCdTime(var_2_1, iter_2_1.pos, var_2_10006)
			end

			local var_2_2 = var_0

			var_2_6.UpdateAssaultFleet(var_2_2, var_1_0)

			local var_2_3 = var_0

			var_2_6.UpdateExternalAssaultFleet(var_2_3, var_1_0)

			local var_2_4 = var_0

			var_2_6.updateGuild(var_2_4, var_0)

			local var_2_5 = arg_1_0

			var_2_6 = var_2_6.sendNotification
			GAME = var_2_10003

			var_2_6(var_2_5, var_2_10003.GUILD_UPDATE_MY_ASSAULT_FLEET_DONE)

			pg = var_2_6

			local var_2_7 = var_2_6.ShipFlagMgr.GetInstance()

			var_2_6.UpdateFlagShips(var_2_7, "inGuildEvent")
		else
			pg = var_2_6

			local var_2_8 = var_2_6.TipsMgr.GetInstance()
			local var_2_9 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_9(var_2_8, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		if var_1_1 then
			var_1_1()
		end

		return
	end)

	return
end

return var_0_1
