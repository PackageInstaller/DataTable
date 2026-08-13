class = var_0_10000

local var_0_0 = "UpgradeStarCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().shipId
	local var_1_1 = var_2.shipIds

	getProxy = var_1_10005
	BayProxy = var_1_10007

	local var_1_2 = var_1_10005(var_1_10007)
	local var_1_3 = var_5.getShipById(var_1_2, var_1_0)

	pg = var_1_10007

	if var_1_10007.ship_data_breakout[var_1_3.configId].breakout_id == 0 then
		return
	end

	Clone = var_9

	local var_1_4 = var_9(var_1_3)

	var_1_4.configId = var_8
	pairs = var_1_10010

	for iter_1_0, iter_1_1 in var_1_10010(var_1_3.equipments) do
		if iter_1_1 and var_1_4:isForbiddenAtPos(iter_1_1, iter_1_0) then
			pg = var_15

			local var_1_5 = var_15.MsgboxMgr.GetInstance()
			local var_1_6 = var_15.ShowMsgBox

			var_1_10018 = {}
			i18n = var_19
			var_1_10018.content = var_19("ship_upgrade_unequip_tip", var_1_4:getConfig("name"), "#fad545")

			function var_1_10018.onYes()
				local var_2_0 = arg_1_0
				local var_2_1 = var_0.sendNotification

				GAME = var_2_10003

				var_2_1(var_2_0, var_2_10003.UNEQUIP_FROM_SHIP, {
					shipId = var_1_3.id,
					pos = iter_1_0
				})

				return
			end

			var_1_6(var_1_5, var_1_10018)

			return
		end
	end

	Clone = var_10

	local var_1_7 = var_10(var_1_3)
	local var_1_8 = {}

	ipairs = var_12

	for iter_1_2, iter_1_3 in var_12(var_1_1) do
		if not var_5:getShipById(iter_1_3) then
			pg = var_1_10018

			local var_1_9 = var_1_10018.TipsMgr.GetInstance()

			var_1_10018 = var_1_10018.ShowTips
			i18n = var_1_10021

			var_1_10018(var_1_9, var_1_10021("ship_error_noShip", iter_1_3))

			return
		end

		table = var_1_10018

		var_1_10018.insert(var_1_8, var_17)
	end

	getProxy = var_12
	CollectionProxy = var_14

	local var_1_10 = var_12(var_14)
	local var_1_11 = var_12.getShipGroup(var_1_10, var_1_7.groupId)

	pg = var_14

	local var_1_12 = var_14.ConnectionMgr.GetInstance()

	var_14.Send(var_1_12, 12027, {
		ship_id = var_1_0,
		material_id_list = var_1_1
	}, 12028, function(arg_3_0)
		local var_3_0

		if arg_3_0.result == 0 then
			getProxy = var_3_0
			EquipmentProxy = var_2_10003
			var_3_0 = var_3_0(var_2_10003)
			ipairs = var_2_10002

			for iter_3_0, iter_3_1 in var_2_10002(var_1_8) do
				ipairs = var_2_10007

				for iter_3_2, iter_3_3 in var_2_10007(iter_3_1.equipments) do
					if iter_3_3 then
						var_3_0:addEquipment(iter_3_3)
					end

					if iter_3_1:getEquipSkin(iter_3_2) ~= 0 then
						var_3_0:addEquipmentSkin(iter_3_1:getEquipSkin(iter_3_2), 1)
						iter_3_1:updateEquipmentSkin(iter_3_2, 0)

						pg = var_12

						local var_3_1 = var_12.TipsMgr.GetInstance()
						local var_3_2 = var_12.ShowTips

						i18n = var_15

						var_3_2(var_3_1, var_15("equipment_skin_unload"))
					end
				end

				if iter_3_1:GetSpWeapon() then
					iter_3_2 = iter_3_1

					iter_3_1.UpdateSpWeapon(iter_3_2, nil)

					iter_3_2 = var_3_0

					var_3_0.AddSpWeapon(iter_3_2, var_2_10007)
				end

				iter_3_2 = var_0

				var_8.removeShip(iter_3_2, iter_3_1)
			end

			pg = var_2

			local var_3_3

			if var_2.ship_data_breakout[var_1_3.configId].breakout_id ~= 0 then
				var_3_3 = var_1_3
				var_3_3.configId = var_2.breakout_id
				pg = var_3_3
				var_3_3 = var_3_3.ship_data_template[var_1_3.configId]
				ipairs = var_2_10004

				for iter_3_4, iter_3_5 in var_2_10004(var_3_3.buff_list) do
					if not var_1_3.skills[iter_3_5] then
						var_1_3.skills[iter_3_5] = {
							exp = 0,
							level = 1,
							id = iter_3_5
						}
					end
				end

				local var_3_4 = var_1_3

				var_2_10004.updateMaxLevel(var_3_4, var_3_3.max_level)

				pg = var_2_10004
				var_2_10004 = var_2_10004.ship_data_template[var_1_7.configId].buff_list
				ipairs = iter_3_0

				for iter_3_6, iter_3_7 in iter_3_0(var_2_10004) do
					table = iter_3_2

					if not iter_3_2.contains(var_3_3.buff_list, iter_3_7) then
						iter_3_2 = var_1_3.skills
						iter_3_2[iter_3_7] = nil
					end
				end

				local var_3_5 = var_0

				iter_3_0.updateShip(var_3_5, var_1_3)
			end

			getProxy = var_3_3
			BagProxy = iter_3_0

			local var_3_6 = var_3_3(iter_3_0)

			ipairs = var_2_10004

			for iter_3_8, iter_3_9 in var_2_10004(var_2.use_item) do
				var_3_6:removeItemById(iter_3_9[1], iter_3_9[2])
			end

			getProxy = var_2_10004
			PlayerProxy = var_6

			local var_3_7 = var_2_10004(var_6)
			local var_3_8 = var_2_10004.getData(var_3_7)

			var_5.consume(var_3_8, {
				gold = var_2.use_gold
			})
			var_2_10004:updatePlayer(var_5)

			local var_3_9 = arg_1_0
			local var_3_10 = var_6.sendNotification

			GAME = var_9

			var_3_10(var_3_9, var_9.UPGRADE_STAR_DONE, {
				newShip = var_1_3,
				oldShip = var_1_7
			})
		else
			pg = var_3_0

			local var_3_11 = var_3_0.TipsMgr.GetInstance()
			local var_3_12 = var_1.ShowTips

			errorTip = var_2_10004

			var_3_12(var_3_11, var_2_10004("ship_upgradeStar_error", arg_3_0.result))
		end

		return
	end)

	return
end

return var_0_1
