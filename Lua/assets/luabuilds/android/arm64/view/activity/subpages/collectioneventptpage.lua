local var_0_0 = class("CollectionEventPtPage", import("view.base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.helpBtn = arg_1_0.bg:Find("help")
	arg_1_0.shopBtn = arg_1_0.bg:Find("shop")
	arg_1_0.eventBtn = arg_1_0.bg:Find("event")
	arg_1_0.resTF = arg_1_0.bg:Find("res")
	arg_1_0.resIcon = arg_1_0.resTF:Find("icon"):GetComponent(typeof(Image))
	arg_1_0.resNum = arg_1_0.resTF:Find("num"):GetComponent(typeof(Text))

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	arg_2_0.shopId = arg_2_0.activity:getConfig("config_client").shopActID

	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	onButton(arg_3_0, arg_3_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.commission_event_tip.tip
		})

		return
	end)
	onButton(arg_3_0, arg_3_0.shopBtn, function()
		arg_3_0:emit(ActivityMediator.GO_SHOPS_LAYER, {
			warp = NewShopsScene.TYPE_ACTIVITY,
			actId = arg_3_0.shopId
		})

		return
	end)
	onButton(arg_3_0, arg_3_0.eventBtn, function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.EVENT)

		return
	end)

	local var_3_0 = getProxy(PlayerProxy):getData().id

	if PlayerPrefs.GetInt("ACTIVITY_TYPE_EVENT_" .. arg_3_0.activity.id .. "_" .. var_3_0) == 0 then
		PlayerPrefs.SetInt("ACTIVITY_TYPE_EVENT_" .. arg_3_0.activity.id .. "_" .. var_3_0, 1)
		getProxy(ActivityProxy):updateActivity(arg_3_0.activity)
	end

	return
end

function var_0_0.OnUpdateFlush(arg_7_0)
	arg_7_0.resNum.text = getProxy(PlayerProxy):getData():getResource(pg.activity_template[arg_7_0.shopId].config_client.pt_id)

	return
end

return var_0_0
