local var_0_0 = class("StoryRecorder")
local var_0_1 = "#5ce6ff"
local var_0_3 = "#70747F"
local var_0_4 = "#BCBCBC"
local var_0_5 = "#FFFFFF"

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.recordList = {}
	arg_1_0.displays = {}

	return
end

function var_0_0.Add(arg_2_0, arg_2_1)
	table.insert(arg_2_0.recordList, arg_2_1)

	return
end

function var_0_0.GetContentList(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs((arg_3_0:Convert())) do
		table.insert(arg_3_0.displays, iter_3_1)
	end

	return arg_3_0.displays
end

function var_0_0.Convert(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.recordList) do
		local var_4_0 = iter_4_1:GetMode()

		if var_4_0 == Story.MODE_ASIDE then
			arg_4_0:CollectAsideContent({}, iter_4_1)
		elseif var_4_0 == Story.MODE_DIALOGUE or var_4_0 == Story.MODE_BG then
			arg_4_0:CollectDialogueContent({}, iter_4_1)
		end
	end

	arg_4_0.recordList = {}

	return {}
end

function var_0_0.FormatContent(arg_5_0, arg_5_1)
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

function var_0_0.CollectAsideContent(arg_6_0, arg_6_1, arg_6_2)
	for iter_6_0, iter_6_1 in ipairs((arg_6_2:GetSequence())) do
		table.insert({}, arg_6_0:FormatContent(iter_6_1[1]))
	end

	table.insert(arg_6_1, {
		isPlayer = false,
		list = {}
	})

	return
end

function var_0_0.CollectDialogueContent(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_2:GetPaintingIcon()
	local var_7_1 = arg_7_2:GetName()
	local var_7_2 = ""

	if getProxy(PlayerProxy) then
		var_7_2 = getProxy(PlayerProxy):getRawData().name
	end

	local var_7_3 = var_7_1 == var_7_2
	local var_7_5 = arg_7_1
	local var_7_6 = {
		icon = var_7_0,
		name = var_7_1,
		nameColor = (function()
			if var_7_3 then
				return var_0_1 or arg_7_2:GetNameColor() or var_0_4
			end
		end)()
	}
	local var_7_7 = {}
	local var_7_9 = arg_7_0:FormatContent((arg_7_2:GetContent()))

	if var_7_1 == var_7_2 then
		local var_7_10 = var_0_1 or var_0_5

		var_7_7[1] = var_7_8(var_7_9, var_7_10)
		var_7_6.list = var_7_7
		var_7_6.isPlayer = var_7_3

		var_7_4(var_7_5, var_7_6)

		if arg_7_2:ExistOption() then
			local var_7_11 = arg_7_2:GetSelectedBranchCode()
			local var_7_12 = {}

			for iter_7_0, iter_7_1 in ipairs(arg_7_2:GetOptions()) do
				local var_7_14 = "[ " .. arg_7_0:FormatContent(iter_7_1[1]) .. " ]"

				if iter_7_1[2] == var_7_11 then
					local var_7_15 = var_0_1
					local var_7_16

					if not var_0_1 then
						var_7_15 = var_0_3
						var_7_16 = var_7_12
					end

					table.insert(var_7_12, (var_7_13(var_7_14, var_7_12)))
				end
			end

			table.insert(arg_7_1, {
				isPlayer = true,
				name = var_7_2,
				nameColor = var_0_1,
				list = var_7_12
			})
		end

		return
	end
end

function var_0_0.Clear(arg_9_0)
	arg_9_0.recordList = {}
	arg_9_0.displays = {}

	return
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:Clear()

	return
end

return var_0_0
