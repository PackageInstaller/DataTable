class = var_0_10000

local var_0_0 = "IslandStoryRecorder"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("Mgr.Story.model.Record.StoryRecorder"))
local var_0_2 = "#5ce6ff"
local var_0_3 = "#39BFFF"
local var_0_4 = "#70747F"
local var_0_5 = "#BCBCBC"
local var_0_6 = "#FFFFFF"

function var_0_1.Convert(arg_1_0)
	local var_1_0 = {}

	ipairs = var_1_10002

	for iter_1_0, iter_1_1 in var_1_10002(arg_1_0.recordList) do
		arg_1_0:Collect3DDialogueContent(var_1_0, iter_1_1)
	end

	arg_1_0.recordList = {}

	return var_1_0
end

function var_0_1.Collect3DDialogueContent(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_2:GetSay()
	local var_2_1 = arg_2_2:IsPlayer()
	local var_2_2 = arg_2_2:GetActorName()
	local var_2_3 = arg_2_2
	local var_2_4 = arg_2_2.GetActorIcon(var_2_3)
	local var_2_5

	if not var_2_1 or not var_0_3 then
		var_2_5 = var_0_5
	end

	table = var_2_3

	local var_2_6 = var_2_3.insert
	local var_2_7 = arg_2_1
	local var_2_8 = {
		icon = var_2_4,
		name = var_2_2,
		nameColor = var_2_5
	}
	local var_2_9 = {}

	setColorStr = var_1_10013

	local var_2_10 = arg_2_0:FormatContent(var_2_0)
	local var_2_11

	if not var_2_1 or not var_0_3 then
		var_2_11 = var_0_6
	end

	var_2_9[1] = var_1_10013(var_2_10, var_2_11)
	var_2_8.list = var_2_9
	var_2_8.isPlayer = var_2_1

	var_2_6(var_2_7, var_2_8)

	return
end

return var_0_1
