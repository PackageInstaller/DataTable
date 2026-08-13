class = var_0_10000

local var_0_0 = "NewEducateRefreshShopCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id

	getProxy = var_1_10004
	NewEducateProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)
	local var_1_2 = var_4.GetCurChar(var_1_1)
	local var_1_3 = var_4.GetFSM(var_1_2)
	local var_1_4

	if var_4.CheckPriorityStystem(var_1_3) then
		pg = var_1_4
		var_1_3 = var_1_4.TipsMgr.GetInstance()
		var_1_4 = var_1_4.ShowTips
		i18n = var_1_10006

		var_1_4(var_1_3, var_1_10006("child2_priority_tip"))

		return
	end

	getProxy = var_1_4
	NewEducateProxy = var_1_3

	local var_1_5 = var_1_4(var_1_3)
	local var_1_6 = var_4.GetCurChar(var_1_5)
	local var_1_7 = var_4.GetResByType

	NewEducateChar = var_1_10007

	local var_1_8 = var_1_7(var_1_6, var_1_10007.RES_TYPE.REFRESH_SHOP)
	local var_1_9 = var_4
	local var_1_10 = var_4.GetResByType

	NewEducateChar = var_1_10008

	local var_1_11 = var_1_10(var_1_9, var_1_10008.RES_TYPE.MONEY)

	pg = var_1_9

	local var_1_12 = var_1_9.gameset.child2_shop_refresh_price.key_value
	local var_1_14

	if var_1_8 <= 0 and var_1_11 < var_1_12 then
		pg = var_1_14

		local var_1_13 = var_1_14.TipsMgr.GetInstance()

		var_1_14 = var_1_14.ShowTips
		i18n = var_1_10010

		var_1_14(var_1_13, var_1_10010("common_no_resource"))

		return
	end

	pg = var_1_14

	local var_1_15 = var_1_14.ConnectionMgr.GetInstance()

	var_8.Send(var_1_15, 29072, {
		id = var_1_0
	}, 29073, function(arg_2_0)
		if arg_2_0.result == 0 then
			if var_1_8 > 0 then
				local var_2_0 = var_0
				local var_2_1 = var_2_1.GetResIdByType

				NewEducateChar = var_2_10003

				if not var_2_1(var_2_0, var_2_10003.RES_TYPE.REFRESH_SHOP) then
					local var_2_2 = var_0

					var_2_1 = var_2_1.GetResIdByType
					NewEducateChar = var_2_10003
					var_2_1 = var_2_1(var_2_2, var_2_10003.RES_TYPE.MONEY)
				end

				local var_2_3 = var_1_8
				local var_2_4 = 0 < var_2_3 and 1 or var_1_12

				getProxy = var_3
				NewEducateProxy = var_2_10004

				local var_2_5 = var_3(var_2_10004)
				local var_2_6 = var_3.Cost
				local var_2_7 = {}

				NewEducateConst = var_2_10006
				var_2_7.type = var_2_10006.DROP_TYPE.RES
				var_2_7.id = var_2_1
				var_2_7.number = var_2_4

				var_2_6(var_2_5, var_2_7)

				getProxy = var_2_6
				NewEducateProxy = var_2_5

				local var_2_8 = var_2_6(var_2_5)
				local var_2_9 = var_3.GetCurChar(var_2_8)
				local var_2_10 = var_3.GetFSM(var_2_9)
				local var_2_11 = var_3.GetState

				NewEducateFSM = var_6

				local var_2_12 = var_2_11(var_2_10, var_6.SYSTEM.MAP)

				var_4.OnRefreshShopDone(var_2_12, arg_2_0.shops, var_1_8 <= 0)

				local var_2_13 = arg_1_0
				local var_2_14 = var_5.sendNotification

				GAME = var_7

				var_2_14(var_2_13, var_7.NEW_EDUCATE_REFRESH_SHOP_DONE)

				if false then
					pg = var_2_1

					local var_2_15 = var_2_1.TipsMgr.GetInstance()

					var_1.ShowTips(var_2_15, "NewEducate_RefreshShop_Error: " .. arg_2_0.result)
				end

				return
			end
		end
	end)

	return
end

return var_0_1
