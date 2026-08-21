local var_0_0 = class("MainActBossSingleBtn", import(".MainBaseActivityBtn"))

function var_0_0.GetEventName(arg_1_0)
	return "event_boss_single"
end

function var_0_0.GetActivity(arg_2_0)
	return (_.detect(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_BOSSSINGLE), function(arg_3_0)
		return not arg_3_0:isEnd()
	end))
end

function var_0_0.GetActivityID(arg_4_0)
	local var_4_0 = arg_4_0:GetActivity()

	return var_4_0 and var_4_0.id
end

function var_0_0.OnInit(arg_5_0)
	setActive(arg_5_0.tipTr.gameObject, arg_5_0:IsShowTip())

	return
end

function var_0_0.CustomOnClick(arg_6_0)
	pg.m02:sendNotification(GAME.GO_SCENE, SCENE.OTHERWORLD_MAP)

	return
end

function var_0_0.IsShowTip(arg_7_0)
	if arg_7_0:GetActivityID() == ActivityConst.OTHER_WORLD_TERMINAL_BATTLE_ID then
		return OtherworldMapScene.IsShowTip()
	end

	return false
end

return var_0_0
