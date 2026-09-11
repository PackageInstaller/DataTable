local AutoChessActionMoveDataTemplate = class("AutoChessActionMoveDataTemplate", (import("game.views.autoChess.dataTemplate.actionData.AutoChessActionBaseDataTemplate")))

function AutoChessActionMoveDataTemplate:Init(arg_1_1)
	AutoChessActionMoveDataTemplate.super.Init(self, arg_1_1)
	self:InitMoveData(arg_1_1)
end

function AutoChessActionMoveDataTemplate:InitMoveData(arg_2_1)
	self.moveDataList = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.action_move_info.action_list) do
		table.insert(self.moveDataList, {
			chessUniquiId = iter_2_1.key,
			newPos = iter_2_1.value
		})
	end
end

return AutoChessActionMoveDataTemplate
