local var_0_0 = {}

System = var_0_10001

local var_0_1 = var_0_10001.Reflection.BindingFlags

bit = var_0_10002

local var_0_2 = var_0_10002.bor(var_0_1.Instance, var_0_1.Public, var_0_1.NonPublic, var_0_1.FlattenHierarchy, var_0_1.Static)

function var_0_0.RefCallStaticMethod(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0
	local var_1_1

	if arg_1_2 then
		tolua = var_1_10006
		var_1_10006 = var_1_10006.gettypemethod

		local var_1_2 = arg_1_0
		local var_1_3 = arg_1_1
		local var_1_4 = var_0_2

		Type = var_1_10011

		local var_1_5 = var_1_10006(var_1_2, var_1_3, var_1_4, var_1_10011.DefaultBinder, arg_1_2, {})

		var_1_10006 = var_1_0.Call
		unpack = var_1_3
		var_1_1 = var_1_10006(var_1_5, var_1_3(arg_1_3))
	else
		tolua = var_1_10006

		local var_1_6 = var_1_10006.gettypemethod(arg_1_0, arg_1_1, var_0_2)

		var_1_1 = var_1_0.Call(var_1_6)
	end

	var_1_0:Destroy()

	return var_1_1
end

function var_0_0.RefCallStaticMethodEx(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0
	local var_2_1

	tolua = var_1_10006

	local var_2_2 = var_1_10006.gettypemethod(arg_2_0, arg_2_1, arg_2_2)
	local var_2_3 = var_4.Call

	unpack = var_9

	local var_2_4 = var_2_3(var_2_2, var_9(arg_2_3))

	var_4:Destroy()

	return var_2_4
end

function var_0_0.RefCallMethod(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0
	local var_3_1

	if arg_3_3 then
		tolua = var_1_10007
		var_1_10007 = var_1_10007.gettypemethod

		local var_3_2 = arg_3_0
		local var_3_3 = arg_3_1
		local var_3_4 = var_0_2

		Type = var_1_10012

		local var_3_5 = var_1_10007(var_3_2, var_3_3, var_3_4, var_1_10012.DefaultBinder, arg_3_3, {})

		var_1_10007 = var_3_0.Call

		local var_3_6 = arg_3_2

		unpack = var_3_4
		var_3_1 = var_1_10007(var_3_5, var_3_6, var_3_4(arg_3_4))
	else
		tolua = var_1_10007

		local var_3_7 = var_1_10007.gettypemethod(arg_3_0, arg_3_1, var_0_2)

		var_3_1 = var_3_0.Call(var_3_7, arg_3_2)
	end

	var_3_0:Destroy()

	return var_3_1
end

function var_0_0.RefCallMethodEx(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0
	local var_4_1

	tolua = var_1_10007

	local var_4_2 = var_1_10007.gettypemethod(arg_4_0, arg_4_1, arg_4_3)
	local var_4_3 = var_5.Call
	local var_4_4 = arg_4_2

	unpack = var_11

	local var_4_5 = var_4_3(var_4_2, var_4_4, var_11(arg_4_4))

	var_5:Destroy()

	return var_4_5
end

function var_0_0.RefGetField(arg_5_0, arg_5_1, arg_5_2)
	tolua = var_1_10003

	local var_5_0 = var_1_10003.getfield(arg_5_0, arg_5_1, var_0_2)
	local var_5_1 = var_3.Get(var_5_0, arg_5_2)

	var_3:Destroy()

	return var_5_1
end

function var_0_0.RefSetField(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	tolua = var_1_10004

	local var_6_0 = var_1_10004.getfield(arg_6_0, arg_6_1, var_0_2)

	var_4.Set(var_6_0, arg_6_2, arg_6_3)
	var_4:Destroy()

	return
end

function var_0_0.RefGetProperty(arg_7_0, arg_7_1, arg_7_2)
	tolua = var_1_10003

	local var_7_0 = var_1_10003.getproperty(arg_7_0, arg_7_1, var_0_2)
	local var_7_1 = var_3.Get
	local var_7_2 = arg_7_2

	null = var_1_10008

	local var_7_3 = var_7_1(var_7_0, var_7_2, var_1_10008)

	var_3:Destroy()

	return var_7_3
end

function var_0_0.RefSetProperty(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	tolua = var_1_10004

	local var_8_0 = var_1_10004.getproperty(arg_8_0, arg_8_1, var_0_2)
	local var_8_1 = var_4.Set
	local var_8_2 = arg_8_2
	local var_8_3 = arg_8_3

	null = var_1_10010

	var_8_1(var_8_0, var_8_2, var_8_3, var_1_10010)
	var_4:Destroy()

	return
end

return var_0_0
