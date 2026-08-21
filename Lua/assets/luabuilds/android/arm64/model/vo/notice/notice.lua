local var_0_0 = class("Notice", import("..BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.title = arg_1_1.title
	arg_1_0.content = arg_1_1.content
	arg_1_0.isRead = PlayerPrefs.GetInt(arg_1_0:prefKey()) == 1

	return
end

function var_0_0.prefKey(arg_2_0)
	return "notice" .. arg_2_0.id
end

function var_0_0.markAsRead(arg_3_0)
	if not arg_3_0.isRead then
		arg_3_0.isRead = true

		PlayerPrefs.SetInt(arg_3_0:prefKey(), 1)
		PlayerPrefs.Save()
	end

	return
end

function var_0_0.getUniqueCode(arg_4_0)
	local var_4_0 = arg_4_0.title or "*"
	local var_4_1 = arg_4_0.id
	local var_4_2 = arg_4_0.content or "*"
	local var_4_3 = var_4_0 .. var_4_1 .. var_4_2
	local var_4_4 = string.len(var_4_0 .. var_4_1 .. var_4_2)
	local var_4_5 = var_4_4

	for iter_4_0 = 1, var_4_4, math.floor(var_4_4 / math.min(10, var_4_4)) do
		var_4_5 = var_4_5 + string.byte(var_4_3, iter_4_0)
	end

	return var_4_5
end

return var_0_0
