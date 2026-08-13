class = var_0_10000

local var_0_0 = "CollectionGetAwardCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.index
	local var_1_2 = false
	local var_1_3 = 0

	getProxy = var_1_10007
	PlayerProxy = var_1_10008

	local var_1_4 = var_1_10007(var_1_10008)
	local var_1_5 = var_7.getData(var_1_4)

	pg = var_1_4

	if var_1_4.storeup_data_template[var_1_0].award_display[var_1_1] then
		var_1_10009 = var_8[1]
		DROP_TYPE_RESOURCE = var_1_10010

		if var_1_10009 == var_1_10010 then
			var_1_3 = var_8[2]
			var_1_2 = true
		end
	end

	if var_1_2 and var_1_3 == 1 and var_1_5:GoldMax(1) then
		pg = var_1_10009

		local var_1_6 = var_1_10009.TipsMgr.GetInstance()

		var_1_10009 = var_1_10009.ShowTips
		i18n = var_11

		local var_1_7 = var_11("gold_max_tip_title")

		i18n = var_12

		var_1_10009(var_1_6, var_1_7 .. var_12("resource_max_tip_collect"))

		return
	end

	if var_1_2 and var_1_3 == 2 and var_1_5:OilMax(1) then
		pg = var_1_10009

		local var_1_8 = var_1_10009.TipsMgr.GetInstance()

		var_1_10009 = var_1_10009.ShowTips
		i18n = var_11

		local var_1_9 = var_11("oil_max_tip_title")

		i18n = var_12

		var_1_10009(var_1_8, var_1_9 .. var_12("resource_max_tip_collect"))

		return
	end

	pg = var_1_10009

	local var_1_10 = var_1_10009.ConnectionMgr.GetInstance()

	var_9.Send(var_1_10, 17005, {
		id = var_1_0,
		award_index = var_1_1
	}, 17006, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			CollectionProxy = var_2_10002
			var_2_10003 = var_1(var_2_10002)

			var_1.updateAward(var_2_10003, var_1_0, var_1_1)

			pg = var_2

			local var_2_0 = var_2.storeup_data_template[var_1_0].award_display[var_1_1][1]

			DROP_TYPE_RESOURCE = var_2_4

			local var_2_4

			if var_2_0 == var_2_4 then
				getProxy = var_2_0
				PlayerProxy = var_2_4
				var_2_10006 = var_2_0(var_2_4)
				var_2_10007 = var_4.getData(var_2_10006)
				var_2_10006 = var_2_4.addResources
				var_2_10008 = {}
				id2res = var_2_10009
				var_2_10008[var_2_10009(var_2_10003[2])] = var_2_10003[3]

				var_2_10006(var_2_10007, var_2_10008)

				var_2_10007 = var_4

				var_4.updatePlayer(var_2_10007, var_2_4)
			else
				local var_2_1 = var_2_10003[1]

				DROP_TYPE_ITEM = var_2_4

				if var_2_1 == var_2_4 then
					getProxy = var_2_1
					BagProxy = var_2_4
					var_2_10006 = var_2_1(var_2_4)

					var_4.addItemById(var_2_10006, var_2_10003[2], var_2_10003[3])
				else
					local var_2_2 = var_2_10003[1]

					DROP_TYPE_EQUIP = var_2_4

					if var_2_2 == var_2_4 then
						getProxy = var_2_2
						EquipmentProxy = var_2_4
						var_2_10006 = var_2_2(var_2_4)

						var_4.addEquipmentById(var_2_10006, var_2_10003[2], var_2_10003[3])
					else
						local var_2_3 = var_2_10003[1]

						DROP_TYPE_SHIP = var_2_4

						if var_2_3 == var_2_4 then
							pg = var_2_3
							var_2_4 = var_2_3.TipsMgr.GetInstance()

							local var_2_5 = var_4.ShowTips

							i18n = var_2_10006
							var_2_10007 = "collection_award_ship"
							pg = var_2_10008

							var_2_5(var_2_4, var_2_10006(var_2_10007, var_2_10008.ship_data_statistics[var_2_10003[2]].name))
						else
							local var_2_6 = var_2_10003[1]

							DROP_TYPE_FURNITURE = var_2_4

							if var_2_6 == var_2_4 then
								getProxy = var_2_6
								DormProxy = var_2_4

								local var_2_7 = var_2_6(var_2_4)

								Furniture = var_2_4
								var_2_4 = var_2_4.New({
									count = 1,
									id = var_2_10003[2]
								})
								var_2_10007 = var_2_7

								local var_2_8 = var_2_7.getRawData(var_2_10007)

								var_6.AddFurniture(var_2_8, var_2_4)

								local var_2_9 = var_2_7

								var_2_10007 = var_2_7.updateDrom

								local var_2_10 = var_6

								BackYardConst = var_2_10010

								var_2_10007(var_2_9, var_2_10, var_2_10010.DORM_UPDATE_TYPE_FURNITURE)
							end
						end
					end
				end
			end

			local var_2_11 = {}

			table = var_2_4

			local var_2_12 = var_2_4.insert
			local var_2_13 = var_2_11

			Drop = var_2_10007

			var_2_12(var_2_13, var_2_10007.Create(var_2_10003))

			local var_2_14 = arg_1_0
			local var_2_15 = var_5.sendNotification

			GAME = var_7

			var_2_15(var_2_14, var_7.COLLECT_GET_AWARD_DONE, {
				id = var_1_0,
				items = var_2_11
			})

			pg = var_2_15

			local var_2_16 = var_2_15.TipsMgr.GetInstance()
			local var_2_17 = var_5.ShowTips

			i18n = var_7

			var_2_17(var_2_16, var_7("word_takeOk"))
		else
			pg = var_1

			local var_2_18 = var_1.TipsMgr.GetInstance()
			local var_2_19 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_19(var_2_18, var_2_10003("collection_getResource_error", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
