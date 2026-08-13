class = var_0_10000

local var_0_0 = var_0_10000("BoatAdCharControl")
local var_0_1
local var_0_2

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	BoatAdGameVo = var_1_10003
	var_0_1 = var_1_10003
	BoatAdGameConst = var_1_10003
	var_0_2 = var_1_10003
	arg_1_0._bgContent = arg_1_1
	arg_1_0._eventCall = arg_1_2
	findTF = var_1_10003
	arg_1_0._charContent = var_1_10003(arg_1_0._bgContent, "scene/content")

	local var_1_0 = var_0_2.game_char[var_0_1.char_id]
	local var_1_1 = var_0_1.GetGameTplTf(var_1_0.tpl)

	BoatAdChar = var_5
	arg_1_0._char = var_5.New(var_1_1, arg_1_0._eventCall)

	local var_1_2 = arg_1_0._char

	var_5.setData(var_1_2, var_1_0)

	local var_1_3 = arg_1_0._char

	var_5.setContent(var_1_3, arg_1_0._charContent)

	return
end

function var_0_0.start(arg_2_0)
	var_0_1.SetGameChar(arg_2_0._char)

	local var_2_0 = arg_2_0._char

	var_1.start(var_2_0)

	return
end

function var_0_0.step(arg_3_0, arg_3_1)
	local var_3_0 = var_0_1.joyStickData
	local var_3_1 = 0
	local var_3_2 = 0
	local var_3_3 = 0
	local var_3_4 = 0

	if var_3_0 and var_3_0.active then
		local var_3_5, var_3_6 = var_3_0.x, var_3_0.y
		local var_3_7 = var_3_0.directX
		local var_3_8 = var_3_0.directY

		var_3_3 = var_3_7
		math = var_3_7

		if var_3_7.abs(var_3_5) < 0.2 then
			var_3_3 = 0
		end

		math = var_7

		if var_7.abs(var_3_6) < 0.2 then
			local var_3_9 = 0
		end
	end

	local var_3_10 = arg_3_0._char

	var_7.changeDirect(var_3_10, var_3_3, 0)

	local var_3_11 = arg_3_0._char

	var_7.step(var_3_11, arg_3_1)

	local var_3_12 = arg_3_0._char

	if not var_7.getLife(var_3_12) then
		local var_3_13 = arg_3_0._eventCall

		BoatAdGameEvent = var_3_12

		var_3_13(var_3_12.PLAYER_DEAD, true)
	end

	return
end

function var_0_0.stop(arg_4_0)
	local var_4_0 = arg_4_0._char

	var_1.stop(var_4_0)

	return
end

function var_0_0.resume(arg_5_0)
	local var_5_0 = arg_5_0._char

	var_1.resume(var_5_0)

	return
end

function var_0_0.clear(arg_6_0)
	local var_6_0 = arg_6_0._char

	var_1.clear(var_6_0)

	return
end

function var_0_0.dispose(arg_7_0)
	return
end

function var_0_0.onEventCall(arg_8_0, arg_8_1, arg_8_2)
	BoatAdGameEvent = var_1_10003

	if arg_8_1 == var_1_10003.PLAYER_EVENT_DAMAGE then
		local var_8_0 = arg_8_0._char

		var_3.damage(var_8_0, arg_8_2)
	end

	return
end

return var_0_0
