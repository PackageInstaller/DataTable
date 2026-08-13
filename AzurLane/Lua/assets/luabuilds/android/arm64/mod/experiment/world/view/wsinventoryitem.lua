class = var_0_10000

local var_0_0 = var_0_10000("WSInventoryItem")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	findTF = var_1_10002
	arg_1_0.bg = var_1_10002(arg_1_1, "bg")
	findTF = var_2
	arg_1_0.countTF = var_2(arg_1_1, "bg/icon_bg/count")
	findTF = var_2
	arg_1_0.nameTF = var_2(arg_1_1, "bg/name")

	return
end

function var_0_0.update(arg_2_0, arg_2_1)
	arg_2_0.itemVO = arg_2_1
	updateWorldItem = var_1_10002
	rtf = var_1_10004

	var_1_10002(var_1_10004(arg_2_0.bg), arg_2_1)

	local var_2_0 = arg_2_0.go

	tostring = var_1_10003
	var_2_0.name = var_1_10003(arg_2_1.id)
	setText = var_2_0

	local var_2_1 = arg_2_0.countTF
	local var_2_2

	if not (arg_2_1.count > 0) or not arg_2_1.count then
		var_2_2 = ""
	end

	var_2_0(var_2_1, var_2_2)

	setText = var_2_0

	local var_2_3 = arg_2_0.nameTF

	shortenString = var_2_2
	getText = var_1_10007
	findTF = var_1_10009

	var_2_0(var_2_3, var_2_2(var_1_10007(var_1_10009(arg_2_0.bg, "name")), 7))

	return
end

function var_0_0.clear(arg_3_0)
	return
end

function var_0_0.dispose(arg_4_0)
	return
end

return var_0_0
