local var_0_0 = import("game.views.autoChess.battle.logic.actionLink.actionNode.AutoChessActionBaseNode")
local var_0_1 = class("AutoChessRoundNode", var_0_0)

function var_0_1.OnCtor(arg_1_0)
	arg_1_0.actionLink = nil
	arg_1_0.roundData = nil
end

function var_0_1.InitRoundData(arg_2_0, arg_2_1)
	arg_2_0.roundData = arg_2_1

	arg_2_0:InitActionLink()
end

function var_0_1.InitActionLink(arg_3_0)
	arg_3_0.actionLink = AutoChessActionLink.New()

	local var_3_0 = arg_3_0.roundData.actionList

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		local var_3_1 = AutoChessTools.GetActionLogicNodeClassName(iter_3_1)

		if var_3_1 then
			local var_3_2 = _G[var_3_1].New()

			var_3_2:Init(arg_3_0.actionLink, arg_3_0.blackboard, iter_3_1)
			arg_3_0.actionLink:AddNode(var_3_2)
		end
	end
end

function var_0_1.OnEnter(arg_4_0)
	arg_4_0.actionLink:Start()
end

function var_0_1.OnExecute(arg_5_0)
	arg_5_0.status = arg_5_0.actionLink:Execute()
end

function var_0_1.OnDispose(arg_6_0)
	arg_6_0.actionLink:Dispose()

	arg_6_0.actionLink = nil
	arg_6_0.roundData = nil
end

return var_0_1
