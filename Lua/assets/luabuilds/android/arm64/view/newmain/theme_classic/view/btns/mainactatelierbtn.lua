local var_0_0 = class("MainActAtelierBtn", import(".MainBaseActivityBtn"))

function var_0_0.GetEventName(arg_1_0)
	return "event_Atelier"
end

function var_0_0.OnInit(arg_2_0)
	setActive(arg_2_0.tipTr.gameObject, false)

	return
end

return var_0_0
