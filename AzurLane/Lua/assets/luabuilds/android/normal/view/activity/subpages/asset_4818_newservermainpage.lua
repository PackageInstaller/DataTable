class = var_0_10000

local var_0_0 = "NewServerMainPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.time = var_1.Find(var_1_1, "time")

	local var_1_2 = arg_1_0.bg

	arg_1_0.shopBtn = var_1.Find(var_1_2, "btn_list/shop")

	local var_1_3 = arg_1_0.bg

	arg_1_0.fightBtn = var_1.Find(var_1_3, "btn_list/fight")

	local var_1_4 = arg_1_0.bg

	arg_1_0.buildBtn = var_1.Find(var_1_4, "btn_list/build")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	onButton = var_1_10001

	var_1_10001(arg_2_0, arg_2_0.shopBtn, function()
		pg = var_2_10000

		local var_3_0 = var_2_10000.m02
		local var_3_1 = var_0.sendNotification

		GAME = var_2_10002

		local var_3_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		local var_3_3 = var_2_10003.NEW_SERVER_CARNIVAL
		local var_3_4 = {}

		NewServerCarnivalScene = var_2_10005
		var_3_4.page = var_2_10005.SHOP_PAGE

		var_3_1(var_3_0, var_3_2, var_3_3, var_3_4)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_2_0, arg_2_0.buildBtn, function()
		getProxy = var_2_10000
		ActivityProxy = var_2_10001

		local var_4_0 = var_2_10000(var_2_10001)
		local var_4_1 = var_0.getActivityByType

		ActivityConst = var_2_10002

		if var_4_1(var_4_0, var_2_10002.ACTIVITY_TYPE_NEWSERVER_BUILD) and not var_0:isEnd() then
			local var_4_2 = arg_2_0
			local var_4_3 = var_1.emit

			ActivityMediator = var_2_10003
			var_2_10003 = var_2_10003.EVENT_GO_SCENE
			SCENE = var_2_10004
			var_2_10004 = var_2_10004.GETBOAT

			local var_4_4 = {}

			BuildShipScene = var_2_10006
			var_4_4.page = var_2_10006.PAGE_NEWSERVER

			var_4_3(var_4_2, var_2_10003, var_2_10004, var_4_4)
		else
			local var_4_5 = arg_2_0
			local var_4_6 = var_1.emit

			ActivityMediator = var_2_10003

			local var_4_7 = var_2_10003.EVENT_GO_SCENE

			SCENE = var_2_10004

			var_4_6(var_4_5, var_4_7, var_2_10004.GETBOAT)
		end

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_2_0, arg_2_0.fightBtn, function()
		local var_5_0 = arg_2_0
		local var_5_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_5_1(var_5_0, var_2_10002.SPECIAL_BATTLE_OPERA)

		return
	end)
	arg_2_0:updateTime()

	return
end

function var_0_1.updateTime(arg_6_0)
	pg = var_1_10001

	local var_6_0 = var_1_10001.TimeMgr.GetInstance()
	local var_6_1 = var_1.STimeDescS
	local var_6_2 = arg_6_0.activity
	local var_6_3 = var_6_1(var_6_0, var_4.getStartTime(var_6_2), "%m.%d")
	local var_6_4 = var_1
	local var_6_5 = var_1.STimeDescS(var_6_4, arg_6_0.activity.stopTime, "%m.%d %H:%M")

	setText = var_6_4

	var_6_4(arg_6_0.time, var_6_3 .. " - " .. var_6_5)

	return
end

function var_0_1.OnUpdateFlush(arg_7_0)
	return
end

return var_0_1
