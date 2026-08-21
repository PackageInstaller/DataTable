local var_0_0 = class("MainActMedalCollectionBtn", import(".MainBaseActivityBtn"))

function var_0_0.GetEventName(arg_1_0)
	return "event_medal"
end

function var_0_0.GetActivityID(arg_2_0)
	local var_2_0 = checkExist(arg_2_0.config, {
		"time"
	})

	if not var_2_0 then
		return nil
	end

	if var_2_0[1] == "default" then
		return var_2_0[2] or nil
	end
end

function var_0_0.OnInit(arg_3_0)
	setActive(arg_3_0.tipTr.gameObject, (Activity.IsActivityReady((getProxy(ActivityProxy):getActivityById((arg_3_0:GetActivityID()))))))

	return
end

function var_0_0.CustomOnClick(arg_4_0)
	errorMsg("Set activity_link_button param using View's name")

	return
end

return var_0_0
