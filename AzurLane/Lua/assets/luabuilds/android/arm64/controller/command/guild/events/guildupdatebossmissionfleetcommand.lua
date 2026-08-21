local var_0_0 = class("GuildUpdateBossMissionFleetCommand", import(".GuildEventBaseCommand"))

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.editFleet
	local var_1_2 = var_1_0.callback

	if not arg_1_0:ExistBoss() then
		return
	end

	for iter_1_0, iter_1_1 in pairs(var_1_0.editFleet) do
		if not var_1_0.force then
			local var_1_4, var_1_5 = iter_1_1:IsLegal()

			if not var_1_4 then
				pg.TipsMgr.GetInstance():ShowTips(var_1_5)

				return
			end
		end

		iter_1_1:ClearInvalidShip()
		iter_1_1:RemoveInvalidCommanders()
		table.insert({}, (arg_1_0:WarpData(iter_1_1)))
	end

	var_1_3({})

	return
end

function var_0_0.WarpData(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs((arg_4_1:GetShipIds())) do
		if arg_4_1:ExistMember(iter_4_1.uid) then
			table.insert({}, {
				user_id = iter_4_1.uid,
				ship_id = iter_4_1.id
			})
		end
	end

	for iter_4_2, iter_4_3 in pairs((arg_4_1:getCommanders())) do
		table.insert({}, {
			pos = iter_4_2,
			id = iter_4_3.id
		})
	end

	return {
		fleet_id = arg_4_1.id,
		ships = {},
		commanders = {}
	}
end

return var_0_0
