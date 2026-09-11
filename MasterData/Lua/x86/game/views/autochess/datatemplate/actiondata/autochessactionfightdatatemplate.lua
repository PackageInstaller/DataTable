local AutoChessActionFightDataTemplate = class("AutoChessActionFightDataTemplate", (import("game.views.autoChess.dataTemplate.actionData.AutoChessActionBaseDataTemplate")))

function AutoChessActionFightDataTemplate:Init(arg_1_1)
	AutoChessActionFightDataTemplate.super.Init(self, arg_1_1)
	self:InitFightDataList(arg_1_1)
end

function AutoChessActionFightDataTemplate:InitFightDataList(arg_2_1)
	self.fightDataList = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.action_battle_info.action_list) do
		table.insert(self.fightDataList, {
			chessUniquiId = iter_2_1.key,
			hpChange = iter_2_1.value
		})
	end
end

return AutoChessActionFightDataTemplate
