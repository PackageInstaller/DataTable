class = var_0_10000

local var_0_0 = var_0_10000("Notification")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.name = arg_1_1
	arg_1_0.body = arg_1_2
	arg_1_0.type = arg_1_3

	return
end

function var_0_0.getName(arg_2_0)
	return arg_2_0.name
end

function var_0_0.setBody(arg_3_0, arg_3_1)
	arg_3_0.body = arg_3_1

	return
end

function var_0_0.getBody(arg_4_0)
	return arg_4_0.body
end

function var_0_0.setType(arg_5_0, arg_5_1)
	arg_5_0.type = arg_5_1

	return
end

function var_0_0.getType(arg_6_0)
	return arg_6_0.type
end

function var_0_0.toString(arg_7_0)
	local var_7_0 = "Notification Name: "
	local var_7_1 = arg_7_0
	local var_7_2 = var_7_0 .. arg_7_0.getName(var_7_1)
	local var_7_3 = "\nBody: "

	tostring = var_7_1

	return (var_7_2 .. var_7_3 .. var_7_1(arg_7_0:getBody())) .. "\nType: " .. arg_7_0:getType()
end

return var_0_0
