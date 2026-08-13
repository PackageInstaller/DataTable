class = var_0_10000

local var_0_0 = "ModShipCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().shipId
	local var_1_1

	if not var_2.shipIds then
		var_1_1 = {}
	end

	getProxy = var_1_10005
	BayProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)
	local var_1_3 = var_5.getShipById(var_1_2, var_1_0)

	Clone = var_1_2

	local var_1_4 = var_1_2(var_1_3)
	local var_1_6

	if not var_1_3 then
		pg = var_1_6

		local var_1_5 = var_1_6.TipsMgr.GetInstance()

		var_1_6 = var_1_6.ShowTips
		i18n = var_1_10010

		var_1_6(var_1_5, var_1_10010("ship_error_noShip", var_1_0))

		return
	end

	table = var_1_6

	local var_1_7

	if var_1_6.getCount(var_1_1) == 0 then
		pg = var_8
		var_1_7 = var_8.TipsMgr.GetInstance()

		local var_1_8 = var_8.ShowTips

		i18n = var_1_10010

		var_1_8(var_1_7, var_1_10010("word_materal_no_enough"))

		return
	end

	local var_1_9 = {}

	ipairs = var_1_7

	for iter_1_0, iter_1_1 in var_1_7(var_1_1) do
		local var_1_10 = var_5

		if not var_5.getShipById(var_1_10, iter_1_1) then
			pg = var_1_10

			local var_1_11 = var_1_10.TipsMgr.GetInstance()

			var_1_10 = var_1_10.ShowTips
			i18n = var_1_10017

			var_1_10(var_1_11, var_1_10017("ship_error_noShip", iter_1_1))

			return
		end

		table = var_1_10

		var_1_10.insert(var_1_9, var_14)
	end

	pg = var_9

	local var_1_12 = var_9.ConnectionMgr.GetInstance()

	var_9.Send(var_1_12, 12017, {
		ship_id = var_1_0,
		material_id_list = var_1_1
	}, 12018, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			pg = var_2_1

			local var_2_0 = var_2_1.TrackerMgr.GetInstance()

			var_2_1 = var_2_1.Tracking
			TRACKING_SHIP_INTENSIFY = var_2_10003

			var_2_1(var_2_0, var_2_10003, #var_1_1)

			var_2_1 = {}
			getProxy = var_2_0
			EquipmentProxy = var_2_10003

			local var_2_2 = var_2_0(var_2_10003)

			ipairs = var_2_10003

			for iter_2_0, iter_2_1 in var_2_10003(var_1_9) do
				ipairs = var_2_10008

				for iter_2_2, iter_2_3 in var_2_10008(iter_2_1.equipments) do
					if iter_2_3 then
						var_2_2:addEquipment(iter_2_3)

						if not var_2_1[iter_2_3.id] then
							var_2_1[iter_2_3.id] = iter_2_3:clone()
						else
							var_2_1[iter_2_3.id].count = var_2_1[iter_2_3.id].count + 1
						end
					end

					if iter_2_1:getEquipSkin(iter_2_2) ~= 0 then
						var_2_2:addEquipmentSkin(iter_2_1:getEquipSkin(iter_2_2), 1)
						iter_2_1:updateEquipmentSkin(iter_2_2, 0)

						pg = var_13

						local var_2_3 = var_13.TipsMgr.GetInstance()
						local var_2_4 = var_13.ShowTips

						i18n = var_15

						var_2_4(var_2_3, var_15("equipment_skin_unload"))
					end
				end

				if iter_2_1:GetSpWeapon() then
					iter_2_1:UpdateSpWeapon(nil)
					var_2_2:AddSpWeapon(var_2_10008)
				end

				local var_2_5 = var_0

				var_9.removeShip(var_2_5, iter_2_1)
			end

			ShipModLayer = var_2_10003
			var_2_10003 = var_2_10003.getModExpAdditions(var_1_3, var_1_9)
			pairs = var_4

			for iter_2_4, iter_2_5 in var_4(var_2_10003) do
				local var_2_6 = var_1_3

				var_9.addModAttrExp(var_2_6, iter_2_4, iter_2_5)
			end

			local var_2_7 = var_0

			var_4.updateShip(var_2_7, var_1_3)

			local var_2_8 = arg_1_0
			local var_2_9 = var_4.sendNotification

			GAME = var_6

			var_2_9(var_2_8, var_6.MOD_SHIP_DONE, {
				oldShip = var_1_4,
				newShip = var_1_3,
				equipments = var_2_1
			})
		else
			pg = var_2_1

			local var_2_10 = var_2_1.TipsMgr.GetInstance()
			local var_2_11 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_11(var_2_10, var_2_10003("ship_modShip_error", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
