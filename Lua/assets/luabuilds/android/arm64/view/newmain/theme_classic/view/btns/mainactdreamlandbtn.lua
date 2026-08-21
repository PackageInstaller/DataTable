local var_0_0 = class("MainActDreamlandBtn", import(".MainBaseActivityBtn"))

function var_0_0.InShowTime(arg_1_0)
	local var_1_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING_2)

	return var_0_0.super.InShowTime(arg_1_0) and var_1_0 and not var_1_0:isEnd()
end

function var_0_0.GetEventName(arg_2_0)
	return "event_dreamland"
end

function var_0_0.OnInit(arg_3_0)
	local var_3_9000
	local var_3_0 = getProxy(ActivityProxy)

	setActive(arg_3_0.tipTr.gameObject, (DreamlandData.New(var_3_0.getActivityByType(var_3_9000, ActivityConst.ACTIVITY_TYPE_DREAMLAND), (getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING_2))).ExistAnyMapOrExploreAward(var_3_0)))

	return
end

return var_0_0
