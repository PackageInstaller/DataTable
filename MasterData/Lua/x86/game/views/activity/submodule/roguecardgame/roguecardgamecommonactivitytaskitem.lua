local RogueCardGameCommonActivityTaskItem = class("RogueCardGameCommonActivityTaskItem", (import("game.views.task.common.CommonActivityTaskItem")))

function RogueCardGameCommonActivityTaskItem:AddListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		TaskAction:SubmitTask(self.taskID_)
		manager.notify:Invoke(ROGUE_CARD_GAME_DLC_STATE)
	end)
end

return RogueCardGameCommonActivityTaskItem
