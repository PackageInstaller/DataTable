local var_0_0 = class("BoatAdCharControl")
local var_0_1
local var_0_2

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1 = BoatAdGameVo
	var_0_2 = BoatAdGameConst
	arg_1_0._bgContent = arg_1_1
	arg_1_0._eventCall = arg_1_2
	arg_1_0._charContent = findTF(arg_1_0._bgContent, "scene/content")
	arg_1_0._char = BoatAdChar.New(var_0_1.GetGameTplTf(var_0_2.game_char[var_0_1.char_id].tpl), arg_1_0._eventCall)

	arg_1_0._char:setData(var_0_2.game_char[var_0_1.char_id])
	arg_1_0._char:setContent(arg_1_0._charContent)

	return
end

function var_0_0.start(arg_2_0)
	var_0_1.SetGameChar(arg_2_0._char)
	arg_2_0._char:start()

	return
end

function var_0_0.step(arg_3_0, arg_3_1)
	local var_3_2 = 0

	if var_0_1.joyStickData and var_0_1.joyStickData.active then
		var_3_2 = var_0_1.joyStickData.directX

		if math.abs(var_0_1.joyStickData.x) < 0.2 then
			var_3_2 = 0
		end

		if math.abs(var_0_1.joyStickData.y) < 0.2 then
			-- block empty
		end
	end

	arg_3_0._char:changeDirect(var_3_2, 0)
	arg_3_0._char:step(arg_3_1)

	if not arg_3_0._char:getLife() then
		arg_3_0._eventCall(BoatAdGameEvent.PLAYER_DEAD, true)
	end

	return
end

function var_0_0.stop(arg_4_0)
	arg_4_0._char:stop()

	return
end

function var_0_0.resume(arg_5_0)
	arg_5_0._char:resume()

	return
end

function var_0_0.clear(arg_6_0)
	arg_6_0._char:clear()

	return
end

function var_0_0.dispose(arg_7_0)
	return
end

function var_0_0.onEventCall(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == BoatAdGameEvent.PLAYER_EVENT_DAMAGE then
		arg_8_0._char:damage(arg_8_2)
	end

	return
end

return var_0_0
