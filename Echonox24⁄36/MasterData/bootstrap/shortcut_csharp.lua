module("bootstrap.shortcut_csharp", package.seeall)

local var_0_0 = Astral.LuaResourceCache.Instance

function getres(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	if arg_1_0 == nil then
		printError("=====error -> getres param resPath is nil=====")

		return
	end

	if enableDebug then
		local var_1_0 = string.match(arg_1_0, "[A-Z]+")

		if var_1_0 ~= nil then
			printError(string.format("=====error -> [%s] has upper [%s], not allow", arg_1_0, var_1_0))
		end
	end

	arg_1_3 = arg_1_3 or 0

	if arg_1_4 == nil then
		arg_1_4 = false
	end

	var_0_0:GetResource(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
end

function removeresl(arg_2_0, arg_2_1, arg_2_2)
	var_0_0:RemoveListener(arg_2_0, arg_2_1, arg_2_2)
end

function parsecolor(arg_3_0)
	return (Astral.ColorUtil.ParseColor(arg_3_0))
end

setglobal("kScrollDirH", 0)
setglobal("kScrollDirV", 1)
setglobal("kScrollDirCircleH", 2)
setglobal("kScrollDirCircleV", 3)
setglobal("CircleLoopCW", 0)
setglobal("CircleLoopCCW", 1)
setglobal("rescache", var_0_0)
setglobal("getres", getres)
setglobal("removeresl", removeresl)
setglobal("parsecolor", parsecolor)
