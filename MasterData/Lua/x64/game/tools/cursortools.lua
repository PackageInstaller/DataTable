return {
	LuaSwitchCursor = function(arg_1_0)
		local var_1_0 = LuaForGamepad.GetGamepadType()

		if var_1_0 == 2 or var_1_0 == 3 or var_1_0 == 5 then
			LuaForCursor.SwitchCursor(arg_1_0)
		end
	end
}
