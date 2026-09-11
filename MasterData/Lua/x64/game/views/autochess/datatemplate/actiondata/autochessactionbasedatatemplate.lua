local AutoChessActionBaseDataTemplate = class("AutoChessActionBaseDataTemplate")

function AutoChessActionBaseDataTemplate:Ctor()
	self.round = 0
	self.actionId = 0
	self.actionType = AutoChessConst.ACTION_TYPE.MOVE
end

function AutoChessActionBaseDataTemplate:Init(arg_2_1)
	self.actionId = arg_2_1.action_id
	self.actionType = arg_2_1.action_type
end

function AutoChessActionBaseDataTemplate:SetRound(arg_3_1)
	self.round = arg_3_1
end

return AutoChessActionBaseDataTemplate
