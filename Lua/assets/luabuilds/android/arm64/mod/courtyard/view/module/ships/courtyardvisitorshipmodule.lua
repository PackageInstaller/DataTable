local var_0_0 = class("CourtYardVisitorShipModule", import(".CourtYardShipModule"))

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0.nameTF = arg_1_0._tf:Find("name")

	setText(arg_1_0.nameTF, arg_1_0.data:GetName())

	return
end

function var_0_0.InitAttachment(arg_2_0)
	return
end

function var_0_0.OnBeginDrag(arg_3_0)
	return
end

function var_0_0.OnDragging(arg_4_0, arg_4_1)
	return
end

function var_0_0.OnDragEnd(arg_5_0, arg_5_1)
	return
end

function var_0_0.OnInimacyChange(arg_6_0, arg_6_1)
	return
end

function var_0_0.OnCoinChange(arg_7_0, arg_7_1)
	return
end

return var_0_0
