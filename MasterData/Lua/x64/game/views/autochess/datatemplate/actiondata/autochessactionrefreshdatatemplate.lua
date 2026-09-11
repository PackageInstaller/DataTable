local AutoChessActionRefreshDataTemplate = class("AutoChessActionRefreshDataTemplate", (import("game.views.autoChess.dataTemplate.actionData.AutoChessActionBaseDataTemplate")))

function AutoChessActionRefreshDataTemplate:Init(arg_1_1)
	AutoChessActionRefreshDataTemplate.super.Init(self, arg_1_1)
	self:InitChessList(arg_1_1)
end

function AutoChessActionRefreshDataTemplate:InitChessList(arg_2_1)
	self.refreshChessList = {}
	self.oldChessList = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.chess_list) do
		local var_2_0 = AutoChessItemDataTemplate.New()

		var_2_0:Init(iter_2_1)
		table.insert(self.refreshChessList, var_2_0)

		local var_2_1 = AutoChessData:GetChessData(var_2_0.uniqueId)

		if var_2_1 then
			self.oldChessList[var_2_0.uniqueId] = var_2_1
		end
	end
end

return AutoChessActionRefreshDataTemplate
