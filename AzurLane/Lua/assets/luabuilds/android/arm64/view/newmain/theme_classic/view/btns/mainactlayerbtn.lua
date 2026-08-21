local var_0_0 = class("MainActLayerBtn", import(".MainBaseActivityBtn"))

function var_0_0.GetEventName(arg_1_0)
	return "event_layer"
end

function var_0_0.OnInit(arg_2_0)
	setActive(arg_2_0.tipTr.gameObject, (Activity.IsActivityReady((getProxy(ActivityProxy):getActivityById((arg_2_0:GetActivityID()))))))

	return
end

function var_0_0.GetActivityID(arg_3_0)
	local var_3_0 = checkExist(arg_3_0.config, {
		"time"
	})

	if not var_3_0 then
		return nil
	end

	if var_3_0[1] == "default" then
		return var_3_0[2] or nil
	end
end

return var_0_0
