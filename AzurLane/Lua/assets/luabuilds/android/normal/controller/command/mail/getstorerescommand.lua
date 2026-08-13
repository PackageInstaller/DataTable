class = var_0_10000

local var_0_0 = "GetStoreResCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().oil
	local var_1_1 = var_2.gold

	if var_1_0 == 0 and var_1_1 == 0 then
		return
	end

	GetItemsOverflowDic = var_1_10005

	local var_1_2 = {}

	Drop = var_1_10007

	local var_1_3 = var_1_10007.New
	local var_1_4 = {}

	DROP_TYPE_RESOURCE = var_1_10009
	var_1_4.type = var_1_10009
	PlayerConst = var_1_10009
	var_1_4.id = var_1_10009.ResOil
	var_1_4.count = var_1_0
	var_1_2[1] = var_1_3(var_1_4)
	Drop = var_7

	local var_1_5 = var_7.New
	local var_1_6 = {}

	DROP_TYPE_RESOURCE = var_9
	var_1_6.type = var_9
	PlayerConst = var_9
	var_1_6.id = var_9.ResGold
	var_1_6.count = var_1_1
	var_1_2[2] = var_1_5(var_1_6)

	local var_1_7 = var_1_10005(var_1_2)

	CheckOverflow = var_1_2

	local var_1_8, var_1_9 = var_1_2(var_1_7)

	if not var_1_8 then
		switch = var_1_6

		var_1_6(var_1_9, {
			gold = function()
				pg = var_2_10000

				local var_2_0 = var_2_10000.TipsMgr.GetInstance()
				local var_2_1 = var_0.ShowTips

				i18n = var_2_10002

				local var_2_2 = var_2_10002("gold_max_tip_title")

				i18n = var_3

				var_2_1(var_2_0, var_2_2 .. var_3("resource_max_tip_mail"))

				return
			end,
			oil = function()
				pg = var_2_10000

				local var_3_0 = var_2_10000.TipsMgr.GetInstance()
				local var_3_1 = var_0.ShowTips

				i18n = var_2_10002

				local var_3_2 = var_2_10002("oil_max_tip_title")

				i18n = var_3

				var_3_1(var_3_0, var_3_2 .. var_3("resource_max_tip_mail"))

				return
			end,
			equip = function()
				pg = var_2_10000

				local var_4_0 = var_2_10000.TipsMgr.GetInstance()
				local var_4_1 = var_0.ShowTips

				i18n = var_2_10002

				var_4_1(var_4_0, var_2_10002("mail_takeAttachment_error_magazine_full"))

				return
			end,
			ship = function()
				pg = var_2_10000

				local var_5_0 = var_2_10000.TipsMgr.GetInstance()
				local var_5_1 = var_0.ShowTips

				i18n = var_2_10002

				var_5_1(var_5_0, var_2_10002("mail_takeAttachment_error_dockYrad_full"))

				return
			end
		})

		return
	end

	pg = var_1_6

	local var_1_10 = var_1_6.ConnectionMgr.GetInstance()

	var_8.Send(var_1_10, 30012, {
		oil = var_1_0,
		gold = var_1_1
	}, 30013, function(arg_6_0)
		local var_6_1

		if arg_6_0.result == 0 then
			getProxy = var_6_1
			PlayerProxy = var_2_10002

			local var_6_0 = var_6_1(var_2_10002)

			var_6_1 = var_6_1.UpdatePlayerRes
			var_2_10003 = {}

			local var_6_2 = {}

			PlayerConst = var_2_10005
			var_6_2.id = var_2_10005.ResOil
			var_6_2.count = var_1_0
			var_2_10003[1] = var_6_2

			local var_6_3 = {}

			PlayerConst = var_5
			var_6_3.id = var_5.ResStoreOil
			var_6_3.count = -var_1_0
			var_2_10003[2] = var_6_3

			local var_6_4 = {}

			PlayerConst = var_5
			var_6_4.id = var_5.ResGold
			var_6_4.count = var_1_1
			var_2_10003[3] = var_6_4

			local var_6_5 = {}

			PlayerConst = var_5
			var_6_5.id = var_5.ResStoreGold
			var_6_5.count = -var_1_1
			var_2_10003[4] = var_6_5

			var_6_1(var_6_0, var_2_10003)

			local var_6_6 = arg_1_0

			var_6_1 = var_6_1.sendNotification
			GAME = var_2_10003

			var_6_1(var_6_6, var_2_10003.GET_STORE_RES_DONE)
		else
			pg = var_6_1

			local var_6_7 = var_6_1.TipsMgr.GetInstance()
			local var_6_8 = var_1.ShowTips

			errorTip = var_2_10003

			var_6_8(var_6_7, var_2_10003("", arg_6_0.result))
		end

		return
	end)

	return
end

return var_0_1
