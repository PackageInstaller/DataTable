local var_0_0 = import("game.views.task.common.CommonActivityTaskItem")
local var_0_1 = class("RogueCardGameCommonActivityTaskItem", var_0_0)

function var_0_1.AddListeners(arg_1_0)
	arg_1_0:AddBtnListener(arg_1_0.receiveBtn_, nil, function()
		TaskAction:SubmitTask(arg_1_0.taskID_)
		manager.notify:Invoke(ROGUE_CARD_GAME_DLC_STATE)
	end)
end

return var_0_1
