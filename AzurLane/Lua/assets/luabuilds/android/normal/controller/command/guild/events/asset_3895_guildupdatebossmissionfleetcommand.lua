class = var_0_10000

local var_0_0 = "GuildUpdateBossMissionFleetCommand"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".GuildEventBaseCommand"))

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().editFleet
	local var_1_1 = var_2.callback
	local var_1_2 = var_2.force

	if not arg_1_0:ExistBoss() then
		return
	end

	local function var_1_3(arg_2_0)
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
				GuildProxy = var_3_10002
				var_3_10003 = var_1(var_3_10002)

				local var_3_0 = var_1.getData(var_3_10003)
				local var_3_1 = var_2.GetActiveEvent(var_3_0)
				local var_3_2 = var_3_10003.GetBossMission(var_3_1)

				pairs = var_3_1

				for iter_3_0, iter_3_1 in var_3_1(var_1_0) do
					var_3_2:UpdateFleet(iter_3_1)
				end

				var_1:updateGuild(var_2)

				local var_3_3 = arg_1_0
				local var_3_4 = var_5.sendNotification

				GAME = var_7

				var_3_4(var_3_3, var_7.GUILD_UPDATE_BOSS_FORMATION_DONE)

				pg = var_3_4

				local var_3_5 = var_3_4.ShipFlagMgr.GetInstance()

				var_5.UpdateFlagShips(var_3_5, "inGuildBossEvent")

				if var_1_1 then
					var_1_1()
				end
			else
				pg = var_1

				local var_3_6 = var_1.TipsMgr.GetInstance()
				local var_3_7 = var_1.ShowTips

				ERROR_MESSAGE = var_3_10003

				var_3_7(var_3_6, var_3_10003[arg_3_0.result] .. arg_3_0.result)
			end

			return
		end)

		return
	end

	local var_1_4 = {}

	pairs = var_1_10008

	for iter_1_0, iter_1_1 in var_1_10008(var_1_0) do
		if not var_1_2 then
			local var_1_5, var_1_6 = iter_1_1:IsLegal()

			if not var_1_5 then
				pg = var_1_10015

				local var_1_7 = var_1_10015.TipsMgr.GetInstance()

				var_1_10015.ShowTips(var_1_7, var_1_6)

				return
			end
		end

		iter_1_1:ClearInvalidShip()
		iter_1_1:RemoveInvalidCommanders()

		local var_1_8 = arg_1_0
		local var_1_9 = arg_1_0.WarpData(var_1_8, iter_1_1)

		table = var_1_8

		var_1_8.insert(var_1_4, var_1_9)
	end

	var_1_3(var_1_4)

	return
end

function var_0_1.WarpData(arg_4_0, arg_4_1)
	local var_4_0 = {}
	local var_4_1 = arg_4_1
	local var_4_2 = arg_4_1.GetShipIds(var_4_1)

	ipairs = var_4_1

	for iter_4_0, iter_4_1 in var_4_1(var_4_2) do
		if arg_4_1:ExistMember(iter_4_1.uid) then
			table = var_9

			var_9.insert(var_4_0, {
				user_id = iter_4_1.uid,
				ship_id = iter_4_1.id
			})
		end
	end

	local var_4_3 = {}
	local var_4_4 = arg_4_1
	local var_4_5 = arg_4_1.getCommanders(var_4_4)

	pairs = var_4_4

	for iter_4_2, iter_4_3 in var_4_4(var_4_5) do
		table = var_1_10011

		var_1_10011.insert(var_4_3, {
			pos = iter_4_2,
			id = iter_4_3.id
		})
	end

	return {
		fleet_id = arg_4_1.id,
		ships = var_4_0,
		commanders = var_4_3
	}
end

return var_0_1
