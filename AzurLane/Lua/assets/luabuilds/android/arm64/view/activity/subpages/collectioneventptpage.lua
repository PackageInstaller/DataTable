class = var_0_10000

local var_0_0 = "CollectionEventPtPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.helpBtn = var_1.Find(var_1_1, "help")

	local var_1_2 = arg_1_0.bg

	arg_1_0.shopBtn = var_1.Find(var_1_2, "shop")

	local var_1_3 = arg_1_0.bg

	arg_1_0.eventBtn = var_1.Find(var_1_3, "event")

	local var_1_4 = arg_1_0.bg

	arg_1_0.resTF = var_1.Find(var_1_4, "res")

	local var_1_5 = arg_1_0.resTF
	local var_1_6 = var_1.Find(var_1_5, "icon")
	local var_1_7 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_1_0.resIcon = var_1_7(var_1_6, var_4(var_1_10006))

	local var_1_8 = arg_1_0.resTF
	local var_1_9 = var_1.Find(var_1_8, "num")
	local var_1_10 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_1_0.resNum = var_1_10(var_1_9, var_4(var_1_10006))

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	local var_2_0 = arg_2_0.activity

	arg_2_0.shopId = var_1.getConfig(var_2_0, "config_client").shopActID

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	onButton = var_1_10001

	var_1_10001(arg_3_0, arg_3_0.helpBtn, function()
		pg = var_2_10000

		local var_4_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_4_1 = var_0.ShowMsgBox
		local var_4_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_4_2.type = var_2_10004
		pg = var_2_10004
		var_4_2.helps = var_2_10004.gametip.commission_event_tip.tip

		var_4_1(var_4_0, var_4_2)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_3_0, arg_3_0.shopBtn, function()
		local var_5_0 = arg_3_0
		local var_5_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_5_2 = var_2_10003.GO_SHOPS_LAYER
		local var_5_3 = {}

		NewShopsScene = var_2_10005
		var_5_3.warp = var_2_10005.TYPE_ACTIVITY
		var_5_3.actId = arg_3_0.shopId

		var_5_1(var_5_0, var_5_2, var_5_3)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_3_0, arg_3_0.eventBtn, function()
		pg = var_2_10000

		local var_6_0 = var_2_10000.m02
		local var_6_1 = var_0.sendNotification

		GAME = var_2_10003

		local var_6_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_6_1(var_6_0, var_6_2, var_2_10004.EVENT)

		return
	end)

	getProxy = var_1_10001
	PlayerProxy = var_3

	local var_3_0 = var_1_10001(var_3)
	local var_3_1 = var_1.getData(var_3_0).id

	PlayerPrefs = var_1_10002

	if var_1_10002.GetInt("ACTIVITY_TYPE_EVENT_" .. arg_3_0.activity.id .. "_" .. var_3_1) == 0 then
		PlayerPrefs = var_2

		var_2.SetInt("ACTIVITY_TYPE_EVENT_" .. arg_3_0.activity.id .. "_" .. var_3_1, 1)

		getProxy = var_2
		ActivityProxy = var_4

		local var_3_2 = var_2(var_4)

		var_2.updateActivity(var_3_2, arg_3_0.activity)
	end

	return
end

function var_0_1.OnUpdateFlush(arg_7_0)
	pg = var_1_10001

	local var_7_0 = var_1_10001.activity_template[arg_7_0.shopId].config_client.pt_id

	getProxy = var_2
	PlayerProxy = var_1_10004

	local var_7_1 = var_2(var_1_10004)
	local var_7_2 = var_2.getData(var_7_1)

	arg_7_0.resNum.text = var_7_2:getResource(var_7_0)

	return
end

return var_0_1
