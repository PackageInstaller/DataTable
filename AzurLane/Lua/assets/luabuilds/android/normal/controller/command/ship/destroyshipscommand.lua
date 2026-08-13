class = var_0_10000

local var_0_0 = "DestroyShipsCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().shipIds

	if not var_2.destroyEquipment then
		local var_1_1 = false
	end

	getProxy = var_1_10005
	BayProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)
	local var_1_3 = {}

	ipairs = var_1_10007

	for iter_1_0, iter_1_1 in var_1_10007(var_1_0) do
		local var_1_4 = var_1_2

		if var_1_2.getShipById(var_1_4, iter_1_1) == nil then
			pg = var_1_4

			local var_1_5 = var_1_4.TipsMgr.GetInstance()

			var_1_4 = var_1_4.ShowTips
			i18n = var_1_10015

			var_1_4(var_1_5, var_1_10015("ship_error_noShip", iter_1_1))

			return
		end

		table = var_1_4

		var_1_4.insert(var_1_3, var_12)
	end

	pg = var_7

	local var_1_6 = var_7.ConnectionMgr.GetInstance()

	var_7.Send(var_1_6, 12004, {
		ship_id_list = var_1_0
	}, 12005, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			getProxy = var_2_0
			EquipmentProxy = var_2_10002
			var_2_0 = var_2_0(var_2_10002)

			local var_2_1 = {}

			var_2_10003 = {}
			ipairs = var_2_10004

			for iter_2_0, iter_2_1 in var_2_10004(var_1_3) do
				var_2_10010 = var_1_2

				var_9.removeShip(var_2_10010, iter_2_1)

				ipairs = var_9

				for iter_2_2, iter_2_3 in var_9(iter_2_1.equipments) do
					if iter_2_3 then
						var_2_10015 = var_2_0

						var_2_0.addEquipment(var_2_10015, iter_2_3)

						if not var_2_1[iter_2_3.id] then
							var_2_1[iter_2_3.id] = iter_2_3:clone()
						else
							var_2_1[iter_2_3.id].count = var_2_1[iter_2_3.id].count + 1
						end
					end

					var_2_10015 = iter_2_1

					if iter_2_1.getEquipSkin(var_2_10015, iter_2_2) ~= 0 then
						var_2_10015 = var_2_0

						var_2_0.addEquipmentSkin(var_2_10015, iter_2_1:getEquipSkin(iter_2_2), 1)

						var_2_10015 = iter_2_1

						iter_2_1.updateEquipmentSkin(var_2_10015, iter_2_2, 0)

						pg = var_14
						var_2_10015 = var_14.TipsMgr.GetInstance()

						local var_2_2 = var_14.ShowTips

						i18n = var_16

						var_2_2(var_2_10015, var_16("equipment_skin_unload"))
					end
				end

				var_2_10010 = iter_2_1

				if iter_2_1.GetSpWeapon(var_2_10010) then
					iter_2_1:UpdateSpWeapon(nil)
					var_2_0:AddSpWeapon(var_9)

					pg = var_2_10010

					local var_2_3 = var_2_10010.TipsMgr.GetInstance()

					var_2_10010 = var_2_10010.ShowTips
					i18n = iter_2_2

					var_2_10010(var_2_3, iter_2_2("spweapon_tip_unload"))
				end

				table = var_2_10010

				var_2_10010.insert(var_2_10003, iter_2_1.id)
			end

			ShipCalcHelper = var_4

			local var_2_4, var_2_5, var_2_6 = var_4.CalcDestoryRes(var_1_3)
			local var_2_7 = {}

			if 0 < var_2_4 then
				table = var_8

				local var_2_8 = var_8.insert
				local var_2_9 = var_2_7

				Drop = var_2_10010
				var_2_10010 = var_2_10010.New

				local var_2_10 = {}

				DROP_TYPE_RESOURCE = iter_2_2
				var_2_10.type = iter_2_2
				PlayerConst = iter_2_2
				var_2_10.id = iter_2_2.ResGold
				var_2_10.count = var_2_4

				var_2_8(var_2_9, var_2_10010(var_2_10))
			end

			local var_2_11

			if 0 < var_2_5 then
				table = var_2_11
				var_2_11 = var_2_11.insert

				local var_2_12 = var_2_7

				Drop = var_2_10010

				local var_2_13 = var_2_10010.New
				local var_2_14 = {}

				DROP_TYPE_RESOURCE = iter_2_2
				var_2_14.type = iter_2_2
				PlayerConst = iter_2_2
				var_2_14.id = iter_2_2.ResOil
				var_2_14.count = var_2_5

				var_2_11(var_2_12, var_2_13(var_2_14))
			end

			table = var_2_11

			local var_2_15 = var_2_11.mergeArray(var_2_7, var_2_6)

			ipairs = var_8

			for iter_2_4, iter_2_5 in var_8(var_2_15) do
				local var_2_16 = arg_1_0
				local var_2_17 = var_13.sendNotification

				GAME = var_2_10015

				var_2_17(var_2_16, var_2_10015.ADD_ITEM, iter_2_5)
			end

			local var_2_18 = arg_1_0
			local var_2_19 = var_8.sendNotification

			GAME = var_10

			var_2_19(var_2_18, var_10.DESTROY_SHIP_DONE, {
				destroiedShipIds = var_2_10003,
				bonus = var_2_15,
				equipments = var_2_1
			})
		else
			pg = var_2_0

			local var_2_20 = var_2_0.TipsMgr.GetInstance()
			local var_2_21 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_21(var_2_20, var_2_10003("ship_destoryShips", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
