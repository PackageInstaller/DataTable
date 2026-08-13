class = var_0_10000

local var_0_0 = "NewEducateGetMapCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id

	pg = var_1_10004

	local var_1_1 = var_1_10004.ConnectionMgr.GetInstance()

	var_4.Send(var_1_1, 29060, {
		id = var_1_0
	}, 29061, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			getProxy = var_2_1
			NewEducateProxy = var_2_10002

			local var_2_0 = var_2_1(var_2_10002)

			var_2_1 = var_2_1.GetCurChar(var_2_0)
			NewEducateMapState = var_2_0

			local var_2_2 = var_2_0.New(var_1_0, arg_2_0.fsm_site)
			local var_2_3 = var_2_1:GetFSM()
			local var_2_4 = var_3.SetState

			NewEducateFSM = var_2_10005

			var_2_4(var_2_3, var_2_10005.SYSTEM.MAP, var_2_2)

			local var_2_5 = var_2_1
			local var_2_6 = var_2_1.SetShipIds
			local var_2_7

			if not arg_2_0.characters then
				var_2_7 = {}
			end

			var_2_6(var_2_5, var_2_7)

			NewEducateDropHelper = var_2_6

			local var_2_8 = var_2_6.HandleDrops(arg_2_0.drop)
			local var_2_9 = arg_1_0
			local var_2_10 = var_4.sendNotification

			GAME = var_6

			var_2_10(var_2_9, var_6.NEW_EDUCATE_GET_MAP_DONE, {
				drops = var_2_8
			})
		else
			pg = var_2_1

			local var_2_11 = var_2_1.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_11, "NewEducate_GetMap: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
