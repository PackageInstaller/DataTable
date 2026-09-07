local SubmitTaskV2Command = class("SubmitTaskV2Command", SubmitTaskCommand)

function SubmitTaskV2Command:GetSubmitActivityTask()
	return GAME.SUBMIT_ACTIVITY_TASK_V2
end

function SubmitTaskV2Command:GetSubmitTaskDone()
	return GAME.SUBMIT_TASK_V2_DONE
end

function SubmitTaskV2Command:GetSubmitTaskAwardDone()
	return GAME.SUBMIT_TASK_AWARD_V2_DOWN
end

return SubmitTaskV2Command
