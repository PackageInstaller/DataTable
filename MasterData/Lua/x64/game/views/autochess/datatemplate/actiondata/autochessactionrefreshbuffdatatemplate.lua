local AutoChessActionRefreshBuffDataTemplate = class("AutoChessActionRefreshBuffDataTemplate", (import("game.views.autoChess.dataTemplate.actionData.AutoChessActionBaseDataTemplate")))

function AutoChessActionRefreshBuffDataTemplate:Init(arg_1_1)
	AutoChessActionRefreshBuffDataTemplate.super.Init(self, arg_1_1)
	self:RefreshBuffData(arg_1_1.buff_info)
end

function AutoChessActionRefreshBuffDataTemplate:RefreshBuffData(arg_2_1)
	self.refreshBuffDataList = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_0 = AutoChessBuffDataTemplate.New()

		var_2_0:Init(iter_2_1)
		table.insert(self.refreshBuffDataList, var_2_0)
	end
end

return AutoChessActionRefreshBuffDataTemplate
