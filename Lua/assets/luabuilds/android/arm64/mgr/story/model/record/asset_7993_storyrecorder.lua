local StoryRecorder = class("StoryRecorder")
local var_0_1 = "#5ce6ff"
local var_0_3 = "#70747F"
local var_0_4 = "#BCBCBC"
local var_0_5 = "#FFFFFF"

function StoryRecorder:Ctor(arg_1_1)
	self.recordList = {}
	self.displays = {}

	return
end

function StoryRecorder:Add(arg_2_1)
	table.insert(self.recordList, arg_2_1)

	return
end

function StoryRecorder:GetContentList()
	for iter_3_0, iter_3_1 in ipairs((self:Convert())) do
		table.insert(self.displays, iter_3_1)
	end

	return self.displays
end

function StoryRecorder:Convert()
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(self.recordList) do
		local var_4_1 = iter_4_1:GetMode()

		if var_4_1 == Story.MODE_ASIDE then
			self:CollectAsideContent(var_4_0, iter_4_1)
		elseif var_4_1 == Story.MODE_DIALOGUE or var_4_1 == Story.MODE_BG then
			self:CollectDialogueContent(var_4_0, iter_4_1)
		end
	end

	self.recordList = {}

	return var_4_0
end

function StoryRecorder:FormatContent(arg_5_1)
	local var_5_0 = arg_5_1

	for iter_5_0, iter_5_1 in ipairs({
		"<size=%d+>",
		"</size>",
		"<color=#%w+>",
		"</color>"
	}) do
		var_5_0 = string.gsub(var_5_0, iter_5_1, "")
	end

	return var_5_0
end

function StoryRecorder:CollectAsideContent(arg_6_1, arg_6_2)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs((arg_6_2:GetSequence())) do
		table.insert(var_6_0, self:FormatContent(iter_6_1[1]))
	end

	table.insert(arg_6_1, {
		isPlayer = false,
		list = var_6_0
	})

	return
end

function StoryRecorder:CollectDialogueContent(arg_7_1, arg_7_2)
	local var_7_0 = arg_7_2:GetPaintingIcon()
	local var_7_1 = arg_7_2:GetName()
	local var_7_2 = ""

	if getProxy(PlayerProxy) then
		var_7_2 = getProxy(PlayerProxy):getRawData().name
	end

	local var_7_3 = var_7_1 == var_7_2
	local var_7_4 = arg_7_1
	local var_7_5 = {
		icon = var_7_0,
		name = var_7_1,
		nameColor = (function()
			return (var_7_3 or nil) and (var_0_1 or arg_7_2:GetNameColor() or var_0_4)
		end)()
	}
	local var_7_6 = {}

	var_7_6[1] = setColorStr(self:FormatContent((arg_7_2:GetContent())), (var_7_1 == var_7_2 or nil) and (var_0_1 or var_0_5))
	var_7_5.list = var_7_6
	var_7_5.isPlayer = var_7_3

	table.insert(var_7_4, var_7_5)

	if arg_7_2:ExistOption() then
		local var_7_8 = arg_7_2:GetSelectedBranchCode()
		local var_7_9 = {}

		for iter_7_0, iter_7_1 in ipairs(arg_7_2:GetOptions()) do
			if iter_7_1[2] == var_7_8 then
				-- block empty
			end

			table.insert(var_7_9, (setColorStr("[ " .. self:FormatContent(iter_7_1[1]) .. " ]", var_7_9)))
		end

		table.insert(arg_7_1, {
			isPlayer = true,
			name = var_7_2,
			nameColor = var_0_1,
			list = var_7_9
		})
	end

	return
end

function StoryRecorder:Clear()
	self.recordList = {}
	self.displays = {}

	return
end

function StoryRecorder:Dispose()
	self:Clear()

	return
end

return StoryRecorder
