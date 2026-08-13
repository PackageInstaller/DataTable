class = var_0_10000

local var_0_0 = "DestroyShipsCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().shipIds

	if not var_2.destroyEquipment then
		local var_1_1 = false
	end

	getProxy = var_1_10005
	BayProxy = var_1_10007

	local var_1_2 = var_1_10005(var_1_10007)
	local var_1_3 = {}

	ipairs = var_1_10007

	for iter_1_0, iter_1_1 in var_1_10007(var_1_0) do
		if var_1_2:getShipById(iter_1_1) == nil then
			pg = var_1_10013

			local var_1_4 = var_1_10013.TipsMgr.GetInstance()

			var_1_10013 = var_1_10013.ShowTips
			i18n = var_1_10016

			var_1_10013(var_1_4, var_1_10016("ship_error_noShip", iter_1_1))

			return
		end

		table = var_1_10013

		var_1_10013.insert(var_1_3, var_12)
	end

	pg = var_7

	local var_1_5 = var_7.ConnectionMgr.GetInstance()

	var_7.Send(var_1_5, 12004, {
		ship_id_list = var_1_0
	}, 12005, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			getProxy = var_2_0
			EquipmentProxy = var_2_10003
			var_2_0 = var_2_0(var_2_10003)

			local var_2_1 = {}
			local var_2_2 = {}

			ipairs = var_2_10004

			for iter_2_0, iter_2_1 in var_2_10004(var_1_3) do
				var_2_10011 = var_1_2

				var_9.removeShip(var_2_10011, iter_2_1)

				ipairs = var_9

				for iter_2_2, iter_2_3 in var_9(iter_2_1.equipments) do
					if iter_2_3 then
						var_2_10016 = var_2_0

						var_2_0.addEquipment(var_2_10016, iter_2_3)

						if not var_2_1[iter_2_3.id] then
							var_2_1[iter_2_3.id] = iter_2_3:clone()
						else
							var_2_10014 = var_2_1[iter_2_3.id]
							var_2_10014.count = var_2_1[iter_2_3.id].count + 1
						end
					end

					var_2_10016 = iter_2_1

					if iter_2_1.getEquipSkin(var_2_10016, iter_2_2) ~= 0 then
						var_2_10016 = var_2_0

						var_2_0.addEquipmentSkin(var_2_10016, iter_2_1:getEquipSkin(iter_2_2), 1)

						var_2_10016 = iter_2_1

						iter_2_1.updateEquipmentSkin(var_2_10016, iter_2_2, 0)

						pg = var_2_10014
						var_2_10016 = var_2_10014.TipsMgr.GetInstance()
						var_2_10014 = var_2_10014.ShowTips
						i18n = var_17

						var_2_10014(var_2_10016, var_17("equipment_skin_unload"))
					end
				end

				var_2_10011 = iter_2_1

				local var_2_4

				if iter_2_1.GetSpWeapon(var_2_10011) then
					iter_2_1:UpdateSpWeapon(nil)
					var_2_0:AddSpWeapon(var_9)

					pg = var_2_4

					local var_2_3 = var_2_4.TipsMgr.GetInstance()

					var_2_4 = var_2_4.ShowTips
					i18n = var_13

					var_2_4(var_2_3, var_13("spweapon_tip_unload"))
				end

				table = var_2_4

				var_2_4.insert(var_2_2, iter_2_1.id)
			end

			ShipCalcHelper = var_2_10004

			local var_2_5, var_2_6

			var_2_10004, var_2_5, var_2_6 = var_2_10004.CalcDestoryRes(var_1_3)

			local var_2_7 = {}

			if 0 < var_2_10004 then
				table = var_8

				local var_2_8 = var_8.insert
				local var_2_9 = var_2_7

				Drop = var_2_10011
				var_2_10011 = var_2_10011.New

				local var_2_10 = {}

				DROP_TYPE_RESOURCE = var_2_10014
				var_2_10.type = var_2_10014
				PlayerConst = var_2_10014
				var_2_10.id = var_2_10014.ResGold
				var_2_10.count = var_2_10004

				var_2_8(var_2_9, var_2_10011(var_2_10))
			end

			local var_2_11

			if 0 < var_2_5 then
				table = var_2_11
				var_2_11 = var_2_11.insert

				local var_2_12 = var_2_7

				Drop = var_2_10011

				local var_2_13 = var_2_10011.New
				local var_2_14 = {}

				DROP_TYPE_RESOURCE = var_2_10014
				var_2_14.type = var_2_10014
				PlayerConst = var_2_10014
				var_2_14.id = var_2_10014.ResOil
				var_2_14.count = var_2_5

				var_2_11(var_2_12, var_2_13(var_2_14))
			end

			table = var_2_11

			local var_2_15 = var_2_11.mergeArray(var_2_7, var_2_6)

			ipairs = var_8

			for iter_2_4, iter_2_5 in var_8(var_2_15) do
				local var_2_16 = arg_1_0
				local var_2_17 = var_13.sendNotification

				GAME = var_2_10016

				var_2_17(var_2_16, var_2_10016.ADD_ITEM, iter_2_5)
			end

			local var_2_18 = arg_1_0
			local var_2_19 = var_8.sendNotification

			GAME = iter_2_4

			var_2_19(var_2_18, iter_2_4.DESTROY_SHIP_DONE, {
				destroiedShipIds = var_2_2,
				bonus = var_2_15,
				equipments = var_2_1
			})
		else
			pg = var_2_0

			local var_2_20 = var_2_0.TipsMgr.GetInstance()
			local var_2_21 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_21(var_2_20, var_2_10004("ship_destoryShips", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
