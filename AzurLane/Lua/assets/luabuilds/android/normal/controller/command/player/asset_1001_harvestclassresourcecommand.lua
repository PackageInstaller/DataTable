class = var_0_10000

local var_0_0 = "HarvestClassResourceCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	NavalAcademyProxy = var_1_10004

	local var_1_2 = var_1_0(var_1_10004)
	local var_1_3 = var_3.GetClassVO(var_1_2)
	local var_1_5

	if var_4.GetCanGetResCnt(var_1_3) <= 0 then
		pg = var_1_5

		local var_1_4 = var_1_5.TipsMgr.GetInstance()

		var_1_5 = var_1_5.ShowTips
		i18n = var_1_10008

		var_1_5(var_1_4, var_1_10008("player_harvestResource_error_fullBag"))

		return
	end

	pg = var_1_5

	local var_1_6 = var_1_5.ConnectionMgr.GetInstance()

	var_6.Send(var_1_6, 22009, {
		type = 0
	}, 22010, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_1 = var_2_1.GetTarget(var_2_0)
			var_2_10003 = var_0

			local var_2_2 = var_2.GetResourceType(var_2_10003)

			Drop = var_2_10003
			var_2_10003 = var_2_10003.New

			local var_2_3 = {}

			DROP_TYPE_ITEM = var_2_10005
			var_2_3.type = var_2_10005
			var_2_3.id = var_2_2
			var_2_3.count = var_0
			var_2_10003 = var_2_10003(var_2_3)

			local var_2_4 = arg_1_0
			local var_2_5 = var_4.sendNotification

			GAME = var_2_10006

			var_2_5(var_2_4, var_2_10006.ADD_ITEM, var_2_10003)

			local var_2_6 = var_0 * var_2_1

			getProxy = var_2_4
			PlayerProxy = var_6

			local var_2_7 = var_2_4(var_6)
			local var_2_8 = var_5.getData(var_2_7)
			local var_2_9 = var_5.consume
			local var_2_10 = {}

			id2res = var_2_10009
			PlayerConst = var_2_10010
			var_2_10[var_2_10009(var_2_10010.ResClassField)] = var_2_6

			var_2_9(var_2_8, var_2_10)

			getProxy = var_2_9
			PlayerProxy = var_2_8

			local var_2_11 = var_2_9(var_2_8)

			var_6.updatePlayer(var_2_11, var_5)

			local var_2_12 = var_2_10003
			local var_2_13 = var_2_10003.getConfig(var_2_12, "name")

			pg = var_2_12

			local var_2_14 = var_2_12.TipsMgr.GetInstance()
			local var_2_15 = var_7.ShowTips

			i18n = var_9

			var_2_15(var_2_14, var_9("commission_get_award", var_2_13, var_0))

			getProxy = var_2_15
			NavalAcademyProxy = var_2_14

			local var_2_16 = var_2_15(var_2_14)
			local var_2_17 = var_7.getCourse(var_2_16)

			var_7.SetProficiency(var_2_17, arg_2_0.exp_in_well)

			local var_2_18 = arg_1_0
			local var_2_19 = var_8.sendNotification

			GAME = var_10

			var_2_19(var_2_18, var_10.HARVEST_CLASS_RES_DONE, {
				award = var_2_10003,
				value = var_0
			})
		else
			pg = var_2_1

			local var_2_20 = var_2_1.TipsMgr.GetInstance()
			local var_2_21 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_21(var_2_20, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
