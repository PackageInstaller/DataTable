class = var_0_10000

local var_0_0 = "GuildUpdateBossMissionFleetCommand"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".GuildEventBaseCommand"))

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().editFleet
	local var_1_1 = var_2.callback
	local var_1_2 = var_2.force
	local var_1_3 = arg_1_0

	if not arg_1_0.ExistBoss(var_1_3) then
		return
	end

	local function var_1_4(arg_2_0)
		table = var_2_10001

		if var_2_10001.getCount(arg_2_0) == 0 then
			if var_1_1 then
				var_1_1()
			end

			return
		end

		pg = var_1

		local var_2_0 = var_1.ConnectionMgr.GetInstance()

		var_1.Send(var_2_0, 61013, {
			fleet = arg_2_0
		}, 61014, function(arg_3_0)
			if arg_3_0.result == 0 then
				getProxy = var_1
				GuildProxy = var_3_10003
				var_3_10004 = var_1(var_3_10003)

				local var_3_0 = var_1.getData(var_3_10004)
				local var_3_1 = var_2.GetActiveEvent(var_3_0)

				var_3_10004 = var_3.GetBossMission(var_3_1)
				pairs = var_3_0

				for iter_3_0, iter_3_1 in var_3_0(var_1_0) do
					var_3_10004:UpdateFleet(iter_3_1)
				end

				var_1:updateGuild(var_2)

				local var_3_2 = arg_1_0
				local var_3_3 = var_5.sendNotification

				GAME = var_8

				var_3_3(var_3_2, var_8.GUILD_UPDATE_BOSS_FORMATION_DONE)

				pg = var_3_3

				local var_3_4 = var_3_3.ShipFlagMgr.GetInstance()

				var_5.UpdateFlagShips(var_3_4, "inGuildBossEvent")

				if var_1_1 then
					var_1_1()
				end
			else
				pg = var_1

				local var_3_5 = var_1.TipsMgr.GetInstance()
				local var_3_6 = var_1.ShowTips

				ERROR_MESSAGE = var_3_10004

				var_3_6(var_3_5, var_3_10004[arg_3_0.result] .. arg_3_0.result)
			end

			return
		end)

		return
	end

	local var_1_5 = {}

	pairs = var_1_3

	for iter_1_0, iter_1_1 in var_1_3(var_1_0) do
		if not var_1_2 then
			local var_1_6 = iter_1_1
			local var_1_7

			var_1_7, var_1_10014 = iter_1_1.IsLegal(var_1_6)

			if not var_1_7 then
				pg = var_1_6

				local var_1_8 = var_1_6.TipsMgr.GetInstance()

				var_15.ShowTips(var_1_8, var_1_10014)

				return
			end
		end

		iter_1_1:ClearInvalidShip()
		iter_1_1:RemoveInvalidCommanders()

		local var_1_9 = arg_1_0:WarpData(iter_1_1)

		table = var_1_10014

		var_1_10014.insert(var_1_5, var_1_9)
	end

	var_1_4(var_1_5)

	return
end

function var_0_1.WarpData(arg_4_0, arg_4_1)
	local var_4_0 = {}
	local var_4_1 = arg_4_1:GetShipIds()

	ipairs = var_1_10004

	for iter_4_0, iter_4_1 in var_1_10004(var_4_1) do
		var_1_10011 = arg_4_1

		if arg_4_1.ExistMember(var_1_10011, iter_4_1.uid) then
			table = var_9

			var_9.insert(var_4_0, {
				user_id = iter_4_1.uid,
				ship_id = iter_4_1.id
			})
		end
	end

	local var_4_2 = {}
	local var_4_3 = arg_4_1:getCommanders()

	pairs = var_6

	for iter_4_2, iter_4_3 in var_6(var_4_3) do
		table = var_1_10011

		var_1_10011.insert(var_4_2, {
			pos = iter_4_2,
			id = iter_4_3.id
		})
	end

	return {
		fleet_id = arg_4_1.id,
		ships = var_4_0,
		commanders = var_4_2
	}
end

return var_0_1
