BaseGoto = import("game.qworld.go.BaseGoto")

return {
	Init = function(self)
		self._modules = {}
		self._modules[QWORLD_GOTO_TYPE.TELEPORT] = import("game.qworld.go.goto.GotoTeleport").New()
		self._modules[QWORLD_GOTO_TYPE.JUMP] = import("game.qworld.go.goto.GotoJump").New()
		self._modules[QWORLD_GOTO_TYPE.StopStory] = import("game.qworld.go.goto.GotoStopStory").New()
		self._modules[QWORLD_GOTO_TYPE.Activity] = import("game.qworld.go.goto.GotoActivity").New()
		self._modules[QWORLD_GOTO_TYPE.OpenMiniMap] = import("game.qworld.go.goto.GotoOpenMiniMap").New()
		self._modules[QWORLD_GOTO_TYPE.System] = import("game.qworld.go.goto.GotoSystem").New()
		self._modules[QWORLD_GOTO_TYPE.Battle] = import("game.qworld.go.goto.GotoBattle").New()
	end,
	SetTagId = function(arg_2_0, arg_2_1)
		arg_2_0.tagId = arg_2_1
	end,
	Goto = function(self, arg_3_1, ...)
		if self._modules[arg_3_1] ~= nil then
			self._modules[arg_3_1]:SetTagId(self.tagId)
			self._modules[arg_3_1]:Go(...)
		else
			print((not ("Go type not defined. " .. arg_3_1) or nil) and "null")
		end
	end
}
