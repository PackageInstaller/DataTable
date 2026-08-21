module("framework.shortcut_framework", package.seeall)

local var_0_0 = 0
local var_0_1 = 0
local var_0_2 = 0
local var_0_3 = {}
local var_0_4 = Vector3.New()
local var_0_5 = Vector2.New()
local var_0_6 = Vector4.New()
local var_0_7 = Scheduler

function settimer(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if arg_1_3 == nil then
		arg_1_3 = true
	end

	var_0_7.addListener(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
end

function removetimer(arg_2_0, arg_2_1)
	var_0_7.removeListener(arg_2_0, arg_2_1)
end

setglobal("gcount", var_0_0)
setglobal("gindex", var_0_1)
setglobal("glen", var_0_2)
setglobal("glist", var_0_3)
setglobal("gvec3", var_0_4)
setglobal("gvec2", var_0_5)
setglobal("gvec4", var_0_6)
setglobal("settimer", settimer)
setglobal("removetimer", removetimer)
