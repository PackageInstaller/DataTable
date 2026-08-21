local var_0_0 = class("EquipCodeRequestCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(17601, {
		shipgroup = arg_1_1:getBody().shipGroupId
	}, 17602, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(CollectionProxy)
			local var_2_1 = var_2_0:getShipGroup(var_0)

			for iter_2_0, iter_2_1 in ipairs({
				arg_2_0.infos,
				arg_2_0.recent_infos
			}) do
				for iter_2_2, iter_2_3 in ipairs(iter_2_1) do
					local var_2_2 = EquipCode.New(setmetatable({
						new = iter_2_0 - 1,
						shipGroupId = var_0
					}, {
						__index = iter_2_3
					}))

					if var_2_2:IsValid() then
						table.insert({}, var_2_2)
					end
				end
			end

			var_2_1:setEquipCodes({})
			var_2_0:updateShipGroup(var_2_1)
			existCall(var_0.callback)
			pg.m02:sendNotification(GAME.EQUIP_CODE_REQUEST_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips("Request equip code data failed:" .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
