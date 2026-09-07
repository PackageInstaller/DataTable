local IslandStoryRecorder = class("IslandStoryRecorder", import("Mgr.Story.model.Record.StoryRecorder"))
local var_0_2 = "#39BFFF"
local var_0_4 = "#BCBCBC"
local var_0_5 = "#FFFFFF"

function IslandStoryRecorder:Convert()
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(self.recordList) do
		self:Collect3DDialogueContent(var_1_0, iter_1_1)
	end

	self.recordList = {}

	return var_1_0
end

function IslandStoryRecorder:Collect3DDialogueContent(arg_2_1, arg_2_2)
	local var_2_0 = arg_2_2:GetSay()
	local var_2_1 = arg_2_2:IsPlayer()
	local var_2_2 = arg_2_2:GetActorName()
	local var_2_3 = arg_2_2:GetActorIcon()
	local var_2_4

	if var_2_1 then
		var_2_4 = var_0_2 or var_0_4
	end

	local var_2_5 = arg_2_1
	local var_2_6 = {
		icon = var_2_3,
		name = var_2_2,
		nameColor = var_2_4
	}
	local var_2_7 = {}

	var_2_7[1] = setColorStr(self:FormatContent(var_2_0), (var_2_1 or nil) and (var_0_2 or var_0_5))
	var_2_6.list = var_2_7
	var_2_6.isPlayer = var_2_1

	table.insert(var_2_5, var_2_6)

	return
end

return IslandStoryRecorder
