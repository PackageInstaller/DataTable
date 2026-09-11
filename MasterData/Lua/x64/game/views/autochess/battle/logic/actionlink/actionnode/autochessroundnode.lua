local AutoChessRoundNode = class("AutoChessRoundNode", (import("game.views.autoChess.battle.logic.actionLink.actionNode.AutoChessActionBaseNode")))

function AutoChessRoundNode:OnCtor()
	self.actionLink = nil
	self.roundData = nil
end

function AutoChessRoundNode:InitRoundData(arg_2_1)
	self.roundData = arg_2_1

	self:InitActionLink()
end

function AutoChessRoundNode:InitActionLink()
	self.actionLink = AutoChessActionLink.New()

	for iter_3_0, iter_3_1 in ipairs(self.roundData.actionList) do
		local var_3_0 = AutoChessTools.GetActionLogicNodeClassName(iter_3_1)

		if var_3_0 then
			local var_3_1 = _G[var_3_0].New()

			var_3_1:Init(self.actionLink, self.blackboard, iter_3_1)
			self.actionLink:AddNode(var_3_1)
		end
	end
end

function AutoChessRoundNode:OnEnter()
	self.actionLink:Start()
end

function AutoChessRoundNode:OnExecute()
	self.status = self.actionLink:Execute()
end

function AutoChessRoundNode:OnDispose()
	self.actionLink:Dispose()

	self.actionLink = nil
	self.roundData = nil
end

return AutoChessRoundNode
