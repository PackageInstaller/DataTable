class = var_0_10000

local var_0_0 = "DestroyEquipmentsCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)
	local var_1_2 = {}

	getProxy = var_1_0
	EquipmentProxy = var_1_10006

	local var_1_3 = var_1_0(var_1_10006)
	local var_1_4

	ipairs = var_1_10006

	for iter_1_0, iter_1_1 in var_1_10006(var_1_1.equipments) do
		local var_1_5 = iter_1_1[1]
		local var_1_6 = iter_1_1[2]

		if not var_1_3:getEquipmentById(var_1_5) then
			pg = var_1_10014

			local var_1_7 = var_1_10014.TipsMgr.GetInstance()

			var_1_10014 = var_1_10014.ShowTips
			i18n = var_1_10017

			var_1_10014(var_1_7, var_1_10017("equipment_destroyEquipments_error_noEquip"))

			return
		end

		if var_13.count < var_1_6 then
			pg = var_1_10014

			local var_1_8 = var_1_10014.TipsMgr.GetInstance()

			var_1_10014 = var_1_10014.ShowTips
			i18n = var_1_10017

			var_1_10014(var_1_8, var_1_10017("equipment_destroyEquipments_error_notEnoughEquip"))

			return
		end

		table = var_1_10014

		var_1_10014.insert(var_1_2, {
			id = var_1_5,
			count = var_1_6
		})

		if not var_1_4 then
			var_1_10014 = false
			var_1_10017 = var_13

			if var_13.isImportance(var_1_10017) then
				var_1_10014 = true
			end

			var_1_10017 = var_13

			local var_1_9 = var_13.getConfig(var_1_10017, "rarity")

			EquipmentRarity = var_16

			if var_1_9 >= var_16.Gold then
				var_1_10014 = true
			end

			local var_1_10 = var_13:getConfig("id") % 20

			if 10 <= var_1_10 then
				var_1_10014 = true
			end

			var_1_4 = var_1_10014 and var_1_5
		end
	end

	local var_1_11 = {}

	if var_1_4 then
		table = var_7

		var_7.insert(var_1_11, function(arg_2_0)
			pg = var_2_10001

			local var_2_0 = var_2_10001.SecondaryPWDMgr

			var_1.LimitedOperation(var_2_0, var_1.RESOLVE_EQUIPMENT, var_1_4, arg_2_0)

			return
		end)
	end

	seriesAsync = var_7

	var_7(var_1_11, function()
		pg = var_2_10000

		local var_3_0 = var_2_10000.ConnectionMgr.GetInstance()

		var_0.Send(var_3_0, 14008, {
			equip_list = var_1_2
		}, 14009, function(arg_4_0)
			if arg_4_0.result == 0 then
				getProxy = var_1
				PlayerProxy = var_3_10003
				var_3_10004 = var_1(var_3_10003)

				local var_4_0 = var_1.getData(var_3_10004)
				local var_4_1 = {}

				var_3_10004 = 0

				local function var_4_2(arg_5_0, arg_5_1)
					print = var_4_10002

					var_4_10002("remove: " .. arg_5_0 .. " " .. arg_5_1)

					local var_5_0 = var_1_3
					local var_5_1 = var_2.getEquipmentById(var_5_0, arg_5_0)
					local var_5_2 = var_1_3

					var_3.removeEquipmentById(var_5_2, arg_5_0, arg_5_1)

					local var_5_3

					if not var_5_1:getConfig("destory_item") then
						var_5_3 = {}
					end

					local var_5_4

					if not var_5_1:getConfig("destory_gold") then
						var_5_4 = 0
					end

					var_3_10004 = var_3_10004 + var_5_4 * arg_5_1
					ipairs = var_5

					for iter_5_0, iter_5_1 in var_5(var_5_3) do
						local var_5_5 = false

						ipairs = var_4_10011

						for iter_5_2, iter_5_3 in var_4_10011(var_4_1) do
							if iter_5_1[1] == var_4_1[iter_5_2].id then
								var_4_1[iter_5_2].count = var_4_1[iter_5_2].count + iter_5_1[2] * arg_5_1
								var_5_5 = true

								break
							end
						end

						if not var_5_5 then
							table = var_4_10011
							var_4_10011 = var_4_10011.insert

							local var_5_6 = var_4_1

							Drop = iter_5_2

							local var_5_7 = iter_5_2.New
							local var_5_8 = {}

							DROP_TYPE_ITEM = var_4_10017
							var_5_8.type = var_4_10017
							var_5_8.id = iter_5_1[1]
							var_5_8.count = iter_5_1[2] * arg_5_1

							var_4_10011(var_5_6, var_5_7(var_5_8))
						end
					end

					return
				end

				local var_4_3 = arg_1_0
				local var_4_4 = var_6.sendNotification

				EquipmentMediator = var_3_10009

				var_4_4(var_4_3, var_3_10009.NO_UPDATE)

				ipairs = var_4_4

				for iter_4_0, iter_4_1 in var_4_4(var_1_2) do
					var_4_2(iter_4_1.id, iter_4_1.count)
				end

				table = var_6

				local var_4_5 = var_6.insert
				local var_4_6 = var_4_1

				Drop = iter_4_0

				local var_4_7 = iter_4_0.New
				local var_4_8 = {
					id = 1
				}

				DROP_TYPE_RESOURCE = var_3_10012
				var_4_8.type = var_3_10012
				var_4_8.count = var_3_10004

				var_4_5(var_4_6, var_4_7(var_4_8))

				ipairs = var_4_5

				for iter_4_2, iter_4_3 in var_4_5(var_4_1) do
					local var_4_9 = arg_1_0
					local var_4_10 = var_11.sendNotification

					GAME = var_3_10014

					var_4_10(var_4_9, var_3_10014.ADD_ITEM, iter_4_3)
				end

				LOCK_QUOTA_SHOP = var_6

				if not var_6 then
					QuotaShop = var_6

					local var_4_11 = var_6.New()

					getProxy = var_7
					ShopsProxy = iter_4_2
					iter_4_2 = var_7(iter_4_2)

					var_7.updateQuotaShop(iter_4_2, var_4_11)
				end

				local var_4_12 = arg_1_0
				local var_4_13 = var_6.sendNotification

				GAME = iter_4_2

				var_4_13(var_4_12, iter_4_2.DESTROY_EQUIPMENTS_DONE, var_4_1)
			else
				pg = var_1

				local var_4_14 = var_1.TipsMgr.GetInstance()
				local var_4_15 = var_1.ShowTips

				errorTip = var_3_10004

				var_4_15(var_4_14, var_3_10004("equipment_destroyEquipments", arg_4_0.result))
			end

			return
		end)

		return
	end)

	return
end

return var_0_1
