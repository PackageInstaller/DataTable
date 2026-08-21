local var_0_0 = 0

function HUT_Var1()
	var_0_0 = var_0_0 + 2

	print("x = ", var_0_0)

	return
end

function HUT_Var3()
	var_0_0 = var_0_0 + 10

	print("x = ", var_0_0)

	return
end

local var_0_1 = HUT_Var1

function HUT_Func()
	var_0_1()

	return
end

function HUT_FUNC2()
	print("y = 4")

	return
end

return
