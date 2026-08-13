class = var_0_10000

local var_0_0 = "CollectionGetAwardCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.index
	local var_1_2 = false
	local var_1_3 = 0

	getProxy = var_1_10007
	PlayerProxy = var_1_10009

	local var_1_4 = var_1_10007(var_1_10009)
	local var_1_5 = var_7.getData(var_1_4)

	pg = var_1_10008

	if var_1_10008.storeup_data_template[var_1_0].award_display[var_1_1] then
		var_1_4 = var_8[1]
		DROP_TYPE_RESOURCE = var_1_10010

		if var_1_4 == var_1_10010 then
			var_1_3 = var_8[2]
			var_1_2 = true
		end
	end

	if var_1_2 and var_1_3 == 1 and var_1_5:GoldMax(1) then
		pg = var_1_4

		local var_1_6 = var_1_4.TipsMgr.GetInstance()

		var_1_4 = var_1_4.ShowTips
		i18n = var_12

		local var_1_7 = var_12("gold_max_tip_title")

		i18n = var_1_10013

		var_1_4(var_1_6, var_1_7 .. var_1_10013("resource_max_tip_collect"))

		return
	end

	if var_1_2 and var_1_3 == 2 and var_1_5:OilMax(1) then
		pg = var_1_4

		local var_1_8 = var_1_4.TipsMgr.GetInstance()

		var_1_4 = var_1_4.ShowTips
		i18n = var_12

		local var_1_9 = var_12("oil_max_tip_title")

		i18n = var_1_10013

		var_1_4(var_1_8, var_1_9 .. var_1_10013("resource_max_tip_collect"))

		return
	end

	pg = var_1_4

	local var_1_10 = var_1_4.ConnectionMgr.GetInstance()

	var_9.Send(var_1_10, 17005, {
		id = var_1_0,
		award_index = var_1_1
	}, 17006, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			CollectionProxy = var_2_10003
			var_2_10004 = var_1(var_2_10003)

			var_1.updateAward(var_2_10004, var_1_0, var_1_1)

			pg = var_2
			var_2_10004 = var_2.storeup_data_template[var_1_0].award_display[var_1_1][1]
			DROP_TYPE_RESOURCE = var_2_3

			local var_2_0, var_2_3

			if var_2_10004 == var_2_3 then
				getProxy = var_2_10004
				PlayerProxy = var_2_0
				var_2_10007 = var_2_10004(var_2_0)
				var_2_10008 = var_2_10004.getData(var_2_10007)
				var_2_0 = var_2_3.addResources

				local var_2_1 = {}

				id2res = var_2_10010
				var_2_1[var_2_10010(var_3[2])] = var_3[3]

				var_2_0(var_2_10008, var_2_1)

				var_2_10008 = var_2_10004

				var_2_10004.updatePlayer(var_2_10008, var_2_3)
			else
				var_2_10004 = var_3[1]
				DROP_TYPE_ITEM = var_2_3

				if var_2_10004 == var_2_3 then
					getProxy = var_2_10004
					BagProxy = var_2_0
					var_2_10007 = var_2_10004(var_2_0)

					var_2_10004.addItemById(var_2_10007, var_3[2], var_3[3])
				else
					var_2_10004 = var_3[1]
					DROP_TYPE_EQUIP = var_2_3

					if var_2_10004 == var_2_3 then
						getProxy = var_2_10004
						EquipmentProxy = var_2_0
						var_2_10007 = var_2_10004(var_2_0)

						var_2_10004.addEquipmentById(var_2_10007, var_3[2], var_3[3])
					else
						var_2_10004 = var_3[1]
						DROP_TYPE_SHIP = var_2_3

						if var_2_10004 == var_2_3 then
							pg = var_2_10004
							var_2_0 = var_2_10004.TipsMgr.GetInstance()
							var_2_10004 = var_2_10004.ShowTips
							i18n = var_2_10007

							local var_2_2 = "collection_award_ship"

							pg = var_2_10010

							var_2_10004(var_2_0, var_2_10007(var_2_2, var_2_10010.ship_data_statistics[var_3[2]].name))
						else
							var_2_10004 = var_3[1]
							DROP_TYPE_FURNITURE = var_2_3

							if var_2_10004 == var_2_3 then
								getProxy = var_2_10004
								DormProxy = var_2_0
								var_2_10004 = var_2_10004(var_2_0)
								Furniture = var_2_3
								var_2_3 = var_2_3.New({
									count = 1,
									id = var_3[2]
								})
								var_2_10008 = var_2_10004

								local var_2_4 = var_2_10004.getRawData(var_2_10008)

								var_6.AddFurniture(var_2_4, var_2_3)

								local var_2_5 = var_2_10004
								local var_2_6 = var_2_10004.updateDrom
								local var_2_7 = var_6

								BackYardConst = var_2_10011

								var_2_6(var_2_5, var_2_7, var_2_10011.DORM_UPDATE_TYPE_FURNITURE)
							end
						end
					end
				end
			end

			var_2_10004 = {}
			table = var_2_3

			local var_2_8 = var_2_3.insert
			local var_2_9 = var_2_10004

			Drop = var_2_10008

			var_2_8(var_2_9, var_2_10008.Create(var_3))

			local var_2_10 = arg_1_0
			local var_2_11 = var_5.sendNotification

			GAME = var_8

			var_2_11(var_2_10, var_8.COLLECT_GET_AWARD_DONE, {
				id = var_1_0,
				items = var_2_10004
			})

			pg = var_2_11

			local var_2_12 = var_2_11.TipsMgr.GetInstance()
			local var_2_13 = var_5.ShowTips

			i18n = var_8

			var_2_13(var_2_12, var_8("word_takeOk"))
		else
			pg = var_1

			local var_2_14 = var_1.TipsMgr.GetInstance()
			local var_2_15 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_15(var_2_14, var_2_10004("collection_getResource_error", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
