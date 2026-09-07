local GuildUpdateBossMissionFleetCommand = class("GuildUpdateBossMissionFleetCommand", import(".GuildEventBaseCommand"))

function GuildUpdateBossMissionFleetCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.editFleet
	local var_1_2 = var_1_0.callback

	if not self:ExistBoss() then
		return
	end

	local function var_1_3(arg_2_0)
		if table.getCount(arg_2_0) == 0 then
			if var_1_2 then
				var_1_2()
			end

			return
		end

		pg.ConnectionMgr.GetInstance():Send(61013, {
			fleet = arg_2_0
		}, 61014, function(arg_3_0)
			if arg_3_0.result == 0 then
				local var_3_0 = getProxy(GuildProxy)
				local var_3_1 = var_3_0:getData()
				local var_3_2 = var_3_1:GetActiveEvent():GetBossMission()

				for iter_3_0, iter_3_1 in pairs(var_1_1) do
					var_3_2:UpdateFleet(iter_3_1)
				end

				var_3_0:updateGuild(var_3_1)
				self:sendNotification(GAME.GUILD_UPDATE_BOSS_FORMATION_DONE)
				pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inGuildBossEvent")

				if var_1_2 then
					var_1_2()
				end
			else
				pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_3_0.result] .. arg_3_0.result)
			end

			return
		end)

		return
	end

	local var_1_4 = {}

	for iter_1_0, iter_1_1 in pairs(var_1_0.editFleet) do
		if not var_1_0.force then
			local var_1_5, var_1_6 = iter_1_1:IsLegal()

			if not var_1_5 then
				pg.TipsMgr.GetInstance():ShowTips(var_1_6)

				return
			end
		end

		iter_1_1:ClearInvalidShip()
		iter_1_1:RemoveInvalidCommanders()
		table.insert(var_1_4, (self:WarpData(iter_1_1)))
	end

	var_1_3(var_1_4)

	return
end

function GuildUpdateBossMissionFleetCommand:WarpData(arg_4_1)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs((arg_4_1:GetShipIds())) do
		if arg_4_1:ExistMember(iter_4_1.uid) then
			table.insert(var_4_0, {
				user_id = iter_4_1.uid,
				ship_id = iter_4_1.id
			})
		end
	end

	local var_4_1 = {}

	for iter_4_2, iter_4_3 in pairs((arg_4_1:getCommanders())) do
		table.insert(var_4_1, {
			pos = iter_4_2,
			id = iter_4_3.id
		})
	end

	return {
		fleet_id = arg_4_1.id,
		ships = var_4_0,
		commanders = var_4_1
	}
end

return GuildUpdateBossMissionFleetCommand
