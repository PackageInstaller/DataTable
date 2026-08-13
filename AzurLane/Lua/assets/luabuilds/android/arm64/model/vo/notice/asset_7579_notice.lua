class = var_0_10000

local var_0_0 = "Notice"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.title = arg_1_1.title
	arg_1_0.content = arg_1_1.content
	PlayerPrefs = var_2
	arg_1_0.isRead = var_2.GetInt(arg_1_0:prefKey()) == 1

	return
end

function var_0_1.prefKey(arg_2_0)
	return "notice" .. arg_2_0.id
end

function var_0_1.markAsRead(arg_3_0)
	if not arg_3_0.isRead then
		arg_3_0.isRead = true
		PlayerPrefs = var_1

		var_1.SetInt(arg_3_0:prefKey(), 1)

		PlayerPrefs = var_1

		var_1.Save()
	end

	return
end

function var_0_1.getUniqueCode(arg_4_0)
	local var_4_0

	if not arg_4_0.title then
		var_4_0 = "*"
	end

	local var_4_1 = arg_4_0.id
	local var_4_2

	if not arg_4_0.content then
		var_4_2 = "*"
	end

	local var_4_3 = var_4_0 .. var_4_1 .. var_4_2

	string = var_4_1

	local var_4_4 = var_4_1.len(var_4_3)

	math = var_4_2

	local var_4_5 = var_4_2.min(10, var_4_4)

	math = var_4

	local var_4_6 = var_4.floor(var_4_4 / var_4_5)
	local var_4_7 = var_4_4

	for iter_4_0 = 1, var_4_4, var_4_6 do
		string = var_1_10010
		var_4_7 = var_4_7 + var_1_10010.byte(var_4_3, iter_4_0)
	end

	return var_4_7
end

return var_0_1
