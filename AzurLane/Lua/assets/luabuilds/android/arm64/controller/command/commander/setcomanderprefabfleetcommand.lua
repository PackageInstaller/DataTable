class = var_0_10000

local var_0_0 = "SetComanderPrefabFleetCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.commanders

	getProxy = var_1_10005
	CommanderProxy = var_1_10007

	local var_1_2 = var_1_10005(var_1_10007)
	local var_1_3 = {}

	pairs = var_1_10007

	for iter_1_0, iter_1_1 in var_1_10007(var_1_1) do
		table = var_1_10012

		var_1_10012.insert(var_1_3, {
			id = iter_1_1.id,
			pos = iter_1_0
		})
	end

	if #var_1_3 ~= 0 then
		_ = var_7

		if var_7.all(var_1_3, function(arg_2_0)
			return arg_2_0.id == 0
		end) then
			return
		end

		pg = var_7

		local var_1_4 = var_7.ConnectionMgr.GetInstance()

		var_7.Send(var_1_4, 25022, {
			id = var_1_0,
			commandersid = var_1_3
		}, 25023, function(arg_3_0)
			if arg_3_0.result == 0 then
				local var_3_0 = var_1_2

				var_2_10004 = var_1.getPrefabFleetById(var_3_0, var_1_0)

				var_1.updateCommanders(var_2_10004, var_1_1)

				var_2_10004 = var_1_2

				var_2.updatePrefabFleet(var_2_10004, var_1)

				var_2_10004 = arg_1_0

				local var_3_1 = var_2.sendNotification

				GAME = var_5

				var_3_1(var_2_10004, var_5.SET_COMMANDER_PREFAB_DONE)
			else
				pg = var_1

				local var_3_2 = var_1.TipsMgr.GetInstance()
				local var_3_3 = var_1.ShowTips

				ERROR_MESSAGE = var_2_10004

				var_3_3(var_3_2, var_2_10004[arg_3_0.result])
			end

			return
		end)

		return
	end
end

return var_0_1
