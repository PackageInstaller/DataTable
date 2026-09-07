local SubmitActiveTaskV2Command = class("SubmitActiveTaskV2Command", SubmitActiveTaskCommand)

function SubmitActiveTaskV2Command:GetSubmitActivityTaskDone()
	return GAME.SUBMIT_ACTIVITY_TASK_V2_DONE
end

function SubmitActiveTaskV2Command:GetSubMitActivityAwardDown()
	return GAME.SUBMIT_TASK_AWARD_V2_DOWN
end

return SubmitActiveTaskV2Command
