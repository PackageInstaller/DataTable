class = var_0_10000

local var_0_0 = var_0_10000("CatteryStyleCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_2.Find(var_1_0, "mask/icon")
	local var_1_2 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_1_0.styleIcon = var_1_2(var_1_1, var_4(var_1_10005))
	findTF = var_2
	arg_1_0.lockTF = var_2(arg_1_0._tf, "lock")
	findTF = var_2
	arg_1_0.mark = var_2(arg_1_0._tf, "mark")

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.style = arg_2_1

	local var_2_0 = arg_2_0.styleIcon

	GetSpriteFromAtlas = var_1_10004
	var_2_0.sprite = var_1_10004("CatteryStyle/" .. arg_2_1:getConfig("name"), "")

	local var_2_1 = arg_2_1
	local var_2_2 = arg_2_1.IsOwn(var_2_1)

	setActive = var_2_1

	var_2_1(arg_2_0.lockTF, not var_2_2)

	setActive = var_2_1

	var_2_1(arg_2_0.mark, arg_2_2)

	return
end

function var_0_0.Dispose(arg_3_0)
	return
end

return var_0_0
