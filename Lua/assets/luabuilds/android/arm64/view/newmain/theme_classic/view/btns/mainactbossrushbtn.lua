local var_0_0 = class("MainActBossRushBtn", import(".MainBaseActivityBtn"))

function var_0_0.GetEventName(arg_1_0)
	return "event_series"
end

function var_0_0.GetActivity(arg_2_0)
	return (_.detect(getProxy(ActivityProxy):GetBossRushActivities(false), function(arg_3_0)
		return not arg_3_0:isEnd()
	end))
end

function var_0_0.GetActivityID(arg_4_0)
	local var_4_0 = arg_4_0:GetActivity()

	return var_4_0 and var_4_0.id
end

function var_0_0.OnInit(arg_5_0)
	setActive(arg_5_0.tipTr.gameObject, false)

	if not arg_5_0.config.text_pic or arg_5_0.config.text_pic == "" then
		arg_5_0.hideSubImg = false
		arg_5_0._tf:Find("Image").anchoredPosition = Vector2(120, -405)
	end

	return
end

function var_0_0.CustomOnClick(arg_6_0)
	pg.m02:sendNotification(GAME.GO_SCENE, SCENE.BOSSRUSH_MAIN)

	return
end

return var_0_0
