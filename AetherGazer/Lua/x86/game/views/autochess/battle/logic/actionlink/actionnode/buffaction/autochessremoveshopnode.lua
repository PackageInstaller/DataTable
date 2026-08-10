local var_0_0 = import("game.views.autoChess.battle.logic.actionLink.actionNode.AutoChessActionBaseNode")
local var_0_1 = class("AutoChessGlobalAttrNode", var_0_0)

function var_0_1.OnEnter(arg_1_0)
	AutoChessData:RemoveShopItemByUniqueId(arg_1_0.blackboard:GetGameType(), arg_1_0.actionData.removeShopIdList_)
end

function var_0_1.OnExecute(arg_2_0)
	arg_2_0.status = AutoChessConst.ACTION_NODE_STATUS.FINISH
end

return var_0_1
