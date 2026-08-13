class = var_0_10000

local var_0_0 = "EquipCodeRequestCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().shipGroupId

	pg = var_1_10004

	local var_1_1 = var_1_10004.ConnectionMgr.GetInstance()

	var_4.Send(var_1_1, 17601, {
		shipgroup = var_1_0
	}, 17602, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			CollectionProxy = var_2_10002

			local var_2_0 = var_1(var_2_10002)
			local var_2_1 = var_1.getShipGroup(var_2_0, var_1_0)
			local var_2_2 = {}

			ipairs = var_4

			for iter_2_0, iter_2_1 in var_4({
				arg_2_0.infos,
				arg_2_0.recent_infos
			}) do
				ipairs = var_2_10009

				for iter_2_2, iter_2_3 in var_2_10009(iter_2_1) do
					EquipCode = var_2_10014
					var_2_10014 = var_2_10014.New
					setmetatable = var_2_10015

					local var_2_3 = var_2_10014(var_2_10015({
						new = iter_2_0 - 1,
						shipGroupId = var_1_0
					}, {
						__index = iter_2_3
					}))

					if var_2_10014.IsValid(var_2_3) then
						table = var_2_10015

						var_2_10015.insert(var_2_2, var_2_10014)
					end
				end
			end

			var_2_1:setEquipCodes(var_2_2)
			var_1:updateShipGroup(var_2_1)

			existCall = var_4

			var_4(var_0.callback)

			pg = var_4

			local var_2_4 = var_4.m02
			local var_2_5 = var_4.sendNotification

			GAME = var_6

			var_2_5(var_2_4, var_6.EQUIP_CODE_REQUEST_DONE)
		else
			pg = var_1

			local var_2_6 = var_1.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_6, "Request equip code data failed:" .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
