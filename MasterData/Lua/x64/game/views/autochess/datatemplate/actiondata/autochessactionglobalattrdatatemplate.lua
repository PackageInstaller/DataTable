local AutoChessActionGlobalAttrDataTemplate = class("AutoChessActionGlobalAttrDataTemplate", (import("game.views.autoChess.dataTemplate.actionData.AutoChessActionBaseDataTemplate")))

function AutoChessActionGlobalAttrDataTemplate:Init(arg_1_1)
	AutoChessActionGlobalAttrDataTemplate.super.Init(self, arg_1_1)

	self.attrList_ = {}

	self:InitGlobalAttrData(arg_1_1.attr_list)
end

function AutoChessActionGlobalAttrDataTemplate:InitGlobalAttrData(arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		table.insert(self.attrList_, {
			key = iter_2_1.key,
			value = iter_2_1.value
		})
	end
end

return AutoChessActionGlobalAttrDataTemplate
