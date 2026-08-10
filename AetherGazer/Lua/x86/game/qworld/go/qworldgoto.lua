BaseGoto = import("game.qworld.go.BaseGoto")

return {
	Init = function(arg_1_0)
		arg_1_0._modules = {}
		arg_1_0._modules[QWORLD_GOTO_TYPE.TELEPORT] = import("game.qworld.go.goto.GotoTeleport").New()
		arg_1_0._modules[QWORLD_GOTO_TYPE.JUMP] = import("game.qworld.go.goto.GotoJump").New()
		arg_1_0._modules[QWORLD_GOTO_TYPE.StopStory] = import("game.qworld.go.goto.GotoStopStory").New()
		arg_1_0._modules[QWORLD_GOTO_TYPE.Activity] = import("game.qworld.go.goto.GotoActivity").New()
		arg_1_0._modules[QWORLD_GOTO_TYPE.OpenMiniMap] = import("game.qworld.go.goto.GotoOpenMiniMap").New()
		arg_1_0._modules[QWORLD_GOTO_TYPE.System] = import("game.qworld.go.goto.GotoSystem").New()
		arg_1_0._modules[QWORLD_GOTO_TYPE.Battle] = import("game.qworld.go.goto.GotoBattle").New()
	end,
	SetTagId = function(arg_2_0, arg_2_1)
		arg_2_0.tagId = arg_2_1
	end,
	Goto = function(arg_3_0, arg_3_1, ...)
		local var_3_0 = arg_3_0._modules[arg_3_1]

		if var_3_0 ~= nil then
			var_3_0:SetTagId(arg_3_0.tagId)
			var_3_0:Go(...)
		else
			print("Go type not defined. " .. arg_3_1 or "null")
		end
	end
}
