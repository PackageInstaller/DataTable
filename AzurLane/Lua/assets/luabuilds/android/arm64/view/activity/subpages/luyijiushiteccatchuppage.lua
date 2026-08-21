local var_0_0 = class("LuyijiushiTecCatchupPage", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.itemTF = arg_1_0.bg:Find("Award")
	arg_1_0.sliderTF = arg_1_0.bg:Find("Slider")
	arg_1_0.progressText = arg_1_0.bg:Find("Progress")
	arg_1_0.goBtn = arg_1_0.bg:Find("GoBtn")
	arg_1_0.finishBtn = arg_1_0.bg:Find("FinishBtn")

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	arg_2_0.curCount = arg_2_0.activity.data1
	arg_2_0.maxCount = pg.activity_event_blueprint_catchup[arg_2_0.activity:getConfig("config_id")].obtain_max
	arg_2_0.itemID = arg_2_0.activity:getConfig("config_client").itemid

	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	updateDrop(arg_3_0.itemTF, {
		count = 1,
		type = DROP_TYPE_ITEM,
		id = arg_3_0.itemID
	})
	onButton(arg_3_0, arg_3_0.itemTF, function()
		arg_3_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)
	setSlider(arg_3_0.sliderTF, 0, arg_3_0.maxCount, arg_3_0.curCount)
	setText(arg_3_0.progressText, arg_3_0.curCount .. "/" .. arg_3_0.maxCount)
	onButton(arg_3_0, arg_3_0.goBtn, function()
		arg_3_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TECHNOLOGY)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateFlush(arg_6_0)
	local var_6_0 = arg_6_0.curCount >= arg_6_0.maxCount

	setActive(arg_6_0.goBtn, not (arg_6_0.curCount >= arg_6_0.maxCount))
	setActive(arg_6_0.finishBtn, var_6_0)

	return
end

function var_0_0.OnDestroy(arg_7_0)
	return
end

return var_0_0
