local BoatAdCharControl = class("BoatAdCharControl")
local var_0_1
local var_0_2

function BoatAdCharControl:Ctor(arg_1_1, arg_1_2)
	var_0_1 = BoatAdGameVo
	var_0_2 = BoatAdGameConst
	self._bgContent = arg_1_1
	self._eventCall = arg_1_2
	self._charContent = findTF(self._bgContent, "scene/content")
	self._char = BoatAdChar.New(var_0_1.GetGameTplTf(var_0_2.game_char[var_0_1.char_id].tpl), self._eventCall)

	self._char:setData(var_0_2.game_char[var_0_1.char_id])
	self._char:setContent(self._charContent)

	return
end

function BoatAdCharControl:start()
	var_0_1.SetGameChar(self._char)
	self._char:start()

	return
end

function BoatAdCharControl:step(arg_3_1)
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

	self._char:changeDirect(var_3_2, 0)
	self._char:step(arg_3_1)

	if not self._char:getLife() then
		self._eventCall(BoatAdGameEvent.PLAYER_DEAD, true)
	end

	return
end

function BoatAdCharControl:stop()
	self._char:stop()

	return
end

function BoatAdCharControl:resume()
	self._char:resume()

	return
end

function BoatAdCharControl:clear()
	self._char:clear()

	return
end

function BoatAdCharControl:dispose()
	return
end

function BoatAdCharControl:onEventCall(arg_8_1, arg_8_2)
	if arg_8_1 == BoatAdGameEvent.PLAYER_EVENT_DAMAGE then
		self._char:damage(arg_8_2)
	end

	return
end

return BoatAdCharControl
