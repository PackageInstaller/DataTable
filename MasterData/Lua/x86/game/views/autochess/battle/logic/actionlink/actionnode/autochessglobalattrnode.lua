local AutoChessGlobalAttrNode = class("AutoChessGlobalAttrNode", (import("game.views.autoChess.battle.logic.actionLink.actionNode.AutoChessActionBaseNode")))

function AutoChessGlobalAttrNode:OnEnter()
	AutoChessData:UpdateAttrData(self.blackboard:GetGameType(), self.actionData.attrList_)
end

function AutoChessGlobalAttrNode:OnExecute()
	self.status = AutoChessConst.ACTION_NODE_STATUS.FINISH
end

return AutoChessGlobalAttrNode
