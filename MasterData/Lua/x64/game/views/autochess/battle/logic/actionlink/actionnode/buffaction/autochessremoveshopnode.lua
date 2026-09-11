local AutoChessGlobalAttrNode = class("AutoChessGlobalAttrNode", (import("game.views.autoChess.battle.logic.actionLink.actionNode.AutoChessActionBaseNode")))

function AutoChessGlobalAttrNode:OnEnter()
	AutoChessData:RemoveShopItemByUniqueId(self.blackboard:GetGameType(), self.actionData.removeShopIdList_)
end

function AutoChessGlobalAttrNode:OnExecute()
	self.status = AutoChessConst.ACTION_NODE_STATUS.FINISH
end

return AutoChessGlobalAttrNode
