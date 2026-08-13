class = var_0_10000

local var_0_0 = var_0_10000("SpinePaintingDrag")
local var_0_1 = "spine_painting_idle_init_"
local var_0_2 = "spine_painting_skin_init_"

function var_0_0.SetPaintingInitIdle(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_1

	tostring = var_1_10004

	local var_1_1 = var_1_10004(arg_1_0)

	tostring = var_1_10005

	local var_1_2 = var_1_0 .. var_1_1 .. var_1_10005(arg_1_1)

	PlayerPrefs = var_1_1

	var_1_1.SetString(var_1_2, arg_1_2)

	return
end

function var_0_0.GetPaintingInitIdle(arg_2_0, arg_2_1)
	local var_2_0 = var_0_1

	tostring = var_1_10003

	local var_2_1 = var_1_10003(arg_2_0)

	tostring = var_1_10004

	local var_2_2 = var_2_0 .. var_2_1 .. var_1_10004(arg_2_1)

	PlayerPrefs = var_2_1

	if var_2_1.GetString(var_2_2) and #var_3 > 0 then
		return var_3
	end

	return nil
end

function var_0_0.SetPaintingInitSkin(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = var_0_2

	tostring = var_1_10004

	local var_3_1 = var_1_10004(arg_3_0)

	tostring = var_1_10005

	local var_3_2 = var_3_0 .. var_3_1 .. var_1_10005(arg_3_1)

	PlayerPrefs = var_3_1

	var_3_1.SetString(var_3_2, arg_3_2)

	return
end

function var_0_0.GetPaintingInitSkin(arg_4_0, arg_4_1)
	local var_4_0 = var_0_2

	tostring = var_1_10003

	local var_4_1 = var_1_10003(arg_4_0)

	tostring = var_1_10004

	local var_4_2 = var_4_0 .. var_4_1 .. var_1_10004(arg_4_1)

	PlayerPrefs = var_4_1

	if var_4_1.GetString(var_4_2) and #var_3 > 0 then
		return var_3
	end

	return nil
end

return var_0_0
