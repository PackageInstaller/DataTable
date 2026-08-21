local var_0_0 = class("IslandStoryRecorder", import("Mgr.Story.model.Record.StoryRecorder"))
local var_0_2 = "#39BFFF"
local var_0_4 = "#BCBCBC"
local var_0_5 = "#FFFFFF"

function var_0_0.Convert(arg_1_0)
	for iter_1_0, iter_1_1 in ipairs(arg_1_0.recordList) do
		arg_1_0:Collect3DDialogueContent({}, iter_1_1)
	end

	arg_1_0.recordList = {}

	return {}
end

function var_0_0.Collect3DDialogueContent(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_2:GetSay()
	local var_2_1 = arg_2_2:IsPlayer()
	local var_2_2 = arg_2_2:GetActorName()
	local var_2_3 = arg_2_2:GetActorIcon()

	if var_2_1 then
		local var_2_4 = var_0_2 or var_0_4
		local var_2_6 = arg_2_1
		local var_2_7 = {
			icon = var_2_3,
			name = var_2_2,
			nameColor = var_2_4
		}
		local var_2_8 = {}
		local var_2_10 = arg_2_0:FormatContent(var_2_0)

		if var_2_1 then
			local var_2_11 = var_0_2 or var_0_5

			var_2_8[1] = var_2_9(var_2_10, var_2_11)
			var_2_7.list = var_2_8
			var_2_7.isPlayer = var_2_1

			var_2_5(var_2_6, var_2_7)

			return
		end
	end
end

return var_0_0
