local AutoChessActionDeadDataTemplate = class("AutoChessActionDeadDataTemplate", (import("game.views.autoChess.dataTemplate.actionData.AutoChessActionBaseDataTemplate")))

function AutoChessActionDeadDataTemplate:Init(arg_1_1)
	AutoChessActionDeadDataTemplate.super.Init(self, arg_1_1)
	self:InitDeadList(arg_1_1)
end

function AutoChessActionDeadDataTemplate:InitDeadList(arg_2_1)
	self.deadChessList = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.action_dead_info.uid_list) do
		self.deadChessList[#self.deadChessList + 1] = iter_2_1
	end
end

return AutoChessActionDeadDataTemplate
