local var_0_0 = class("WSInventoryItem")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.bg = findTF(arg_1_1, "bg")
	arg_1_0.countTF = findTF(arg_1_1, "bg/icon_bg/count")
	arg_1_0.nameTF = findTF(arg_1_1, "bg/name")

	return
end

function var_0_0.update(arg_2_0, arg_2_1)
	arg_2_0.itemVO = arg_2_1

	updateWorldItem(rtf(arg_2_0.bg), arg_2_1)

	arg_2_0.go.name = tostring(arg_2_1.id)

	local var_2_1 = arg_2_0.countTF

	if arg_2_1.count > 0 then
		local var_2_2 = arg_2_1.count or ""

		var_2_0(var_2_1, var_2_2)
		setText(arg_2_0.nameTF, shortenString(getText(findTF(arg_2_0.bg, "name")), 7))

		return
	end
end

function var_0_0.clear(arg_3_0)
	return
end

function var_0_0.dispose(arg_4_0)
	return
end

return var_0_0
