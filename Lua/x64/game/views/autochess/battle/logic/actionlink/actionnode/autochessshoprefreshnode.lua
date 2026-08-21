local var_0_0 = import("game.views.autoChess.battle.logic.actionLink.actionNode.AutoChessActionBaseNode")
local var_0_1 = class("AutoChessShopRefreshNode", var_0_0)

function var_0_1.OnEnter(arg_1_0)
	AutoChessData:UpdateShopItemData(arg_1_0.blackboard:GetGameType(), arg_1_0.actionData.shopItems_)

	arg_1_0.rendererId = AutoChessBattleRenderer.GetInstance():RenderAction(arg_1_0.actionData)
end

function var_0_1.OnExecute(arg_2_0)
	if arg_2_0:IsRenderEnd() then
		arg_2_0.status = AutoChessConst.ACTION_NODE_STATUS.FINISH
	end
end

function var_0_1.IsRenderEnd(arg_3_0)
	return AutoChessBattleRenderer.GetInstance():IsRendererFinish(arg_3_0.rendererId)
end

return var_0_1
