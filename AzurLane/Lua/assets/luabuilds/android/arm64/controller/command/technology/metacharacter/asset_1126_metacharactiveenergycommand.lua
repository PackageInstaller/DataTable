class = var_0_10000

local var_0_0 = "MetaCharActiveEnergyCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).shipId

	getProxy = var_1_0
	BayProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)

	if not var_4.getShipById(var_1_2, var_1_1) then
		return
	end

	local var_1_3 = var_5:getMetaCharacter()
	local var_1_4 = var_6.getBreakOutInfo(var_1_3)

	if not var_7.getNextInfo(var_1_4) then
		return
	end

	local var_1_5, var_1_6 = var_7:getLimited()

	if var_5.level < var_1_5 or var_6:getCurRepairExp() < var_1_6 then
		pg = var_11

		local var_1_7 = var_11.TipsMgr.GetInstance()

		var_11.ShowTips(var_1_7, "level or repair progress is not enough")

		return
	end

	local var_1_8 = var_7
	local var_1_9, var_1_10 = var_7.getConsume(var_1_8)

	getProxy = var_1_8
	PlayerProxy = var_1_10015

	local var_1_11 = var_1_8(var_1_10015)

	if var_13.getData(var_1_11).gold < var_1_9 then
		pg = var_14
		var_1_10016 = var_14.TipsMgr.GetInstance()

		var_14.ShowTips(var_1_10016, "gold not enough")

		return
	end

	getProxy = var_14
	BagProxy = var_1_10016

	local var_1_12 = var_14(var_1_10016)

	_ = var_1_11

	if var_1_11.any(var_1_10, function(arg_2_0)
		local var_2_0 = var_1_12

		return var_1.getItemCountById(var_2_0, arg_2_0.itemId) < arg_2_0.count
	end) then
		pg = var_15

		local var_1_13 = var_15.TipsMgr.GetInstance()

		var_15.ShowTips(var_1_13, "item not enough")

		return
	end

	print = var_15

	var_15("63303 meta energy", var_5.id)

	pg = var_15

	local var_1_14 = var_15.ConnectionMgr.GetInstance()

	var_15.Send(var_1_14, 63303, {
		ship_id = var_5.id
	}, 63304, function(arg_3_0)
		local var_3_0

		if arg_3_0.result == 0 then
			print = var_3_0

			var_3_0("63304 meta energy success", var_0.id)

			Clone = var_3_0
			var_3_0 = var_3_0(var_0)
			var_2_10004 = arg_1_0

			var_2.updateStar(var_2_10004, var_0, var_3_0.configId, var_0.id)

			var_2_10004 = var_0

			var_2.updateShip(var_2_10004, var_0)

			getProxy = var_2
			CollectionProxy = var_2_10004

			local var_3_1 = var_2(var_2_10004)

			if var_2.getShipGroup(var_3_1, var_3_0.groupId) then
				local var_3_2 = var_0

				var_3.star = var_2_10004.getStar(var_3_2)

				var_2:updateShipGroup(var_3)
			end

			local var_3_3 = var_0

			var_2_10004.consume(var_3_3, {
				gold = var_1_9
			})

			getProxy = var_2_10004
			PlayerProxy = var_3_3

			local var_3_4 = var_2_10004(var_3_3)

			var_2_10004.updatePlayer(var_3_4, var_0)

			pairs = var_2_10004

			for iter_3_0, iter_3_1 in var_2_10004(var_1_10) do
				local var_3_5 = arg_1_0
				local var_3_6 = var_9.sendNotification

				GAME = var_2_10012
				var_2_10012 = var_2_10012.CONSUME_ITEM
				Drop = var_2_10013
				var_2_10013 = var_2_10013.New

				local var_3_7 = {}

				DROP_TYPE_ITEM = var_2_10016
				var_3_7.type = var_2_10016
				var_3_7.id = iter_3_1.itemId
				var_3_7.count = iter_3_1.count

				var_3_6(var_3_5, var_2_10012, var_2_10013(var_3_7))
			end

			getProxy = var_2_10004
			MetaCharacterProxy = var_6

			local var_3_8 = var_2_10004(var_6)
			local var_3_9 = var_2_10004.getMetaProgressVOByID(var_3_8, var_0.id)

			var_5.updateShip(var_3_9, var_0)

			local var_3_10 = arg_1_0
			local var_3_11 = var_6.sendNotification

			GAME = var_9

			var_3_11(var_3_10, var_9.ENERGY_META_ACTIVATION_DONE, {
				newShip = var_0,
				oldShip = var_3_0
			})
		else
			pg = var_3_0

			local var_3_12 = var_3_0.TipsMgr.GetInstance()
			local var_3_13 = var_1.ShowTips

			errorTip = var_2_10004

			var_3_13(var_3_12, var_2_10004("", arg_3_0.result))
		end

		return
	end)

	return
end

function var_0_1.updateStar(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_1.configId = arg_4_3
	pg = var_1_10004

	local var_4_0 = var_1_10004.ship_data_template[arg_4_1.configId]

	ipairs = var_5

	for iter_4_0, iter_4_1 in var_5(var_4_0.buff_list) do
		if not arg_4_1.skills[iter_4_1] then
			arg_4_1.skills[iter_4_1] = {
				exp = 0,
				level = 1,
				id = iter_4_1
			}
		end
	end

	arg_4_1:updateMaxLevel(var_4_0.max_level)

	pg = var_5

	local var_4_1 = var_5.ship_data_template[arg_4_2].buff_list

	ipairs = var_6

	for iter_4_2, iter_4_3 in var_6(var_4_1) do
		table = var_1_10011

		if not var_1_10011.contains(var_4_0.buff_list, iter_4_3) then
			var_1_10011 = arg_4_1.skills
			var_1_10011[iter_4_3] = nil
		end
	end

	return
end

return var_0_1
