local var_0_0 = class("SpinePaintingDrag")
local var_0_1 = "spine_painting_idle_init_"
local var_0_2 = "spine_painting_skin_init_"

function var_0_0.SetPaintingInitIdle(arg_1_0, arg_1_1, arg_1_2)
	PlayerPrefs.SetString(var_0_1 .. tostring(arg_1_0) .. tostring(arg_1_1), arg_1_2)

	return
end

function var_0_0.GetPaintingInitIdle(arg_2_0, arg_2_1)
	local var_2_0 = PlayerPrefs.GetString(var_0_1 .. tostring(arg_2_0) .. tostring(arg_2_1))

	if var_2_0 and #var_2_0 > 0 then
		return var_2_0
	end

	return nil
end

function var_0_0.SetPaintingInitSkin(arg_3_0, arg_3_1, arg_3_2)
	PlayerPrefs.SetString(var_0_2 .. tostring(arg_3_0) .. tostring(arg_3_1), arg_3_2)

	return
end

function var_0_0.GetPaintingInitSkin(arg_4_0, arg_4_1)
	local var_4_0 = PlayerPrefs.GetString(var_0_2 .. tostring(arg_4_0) .. tostring(arg_4_1))

	if var_4_0 and #var_4_0 > 0 then
		return var_4_0
	end

	return nil
end

return var_0_0
