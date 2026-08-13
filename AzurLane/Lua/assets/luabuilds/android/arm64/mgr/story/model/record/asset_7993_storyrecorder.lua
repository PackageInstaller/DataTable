class = var_0_10000

local var_0_0 = var_0_10000("StoryRecorder")
local var_0_1 = "#5ce6ff"
local var_0_2 = "#39BFFF"
local var_0_3 = "#70747F"
local var_0_4 = "#BCBCBC"
local var_0_5 = "#FFFFFF"

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.recordList = {}
	arg_1_0.displays = {}

	return
end

function var_0_0.Add(arg_2_0, arg_2_1)
	table = var_1_10002

	var_1_10002.insert(arg_2_0.recordList, arg_2_1)

	return
end

function var_0_0.GetContentList(arg_3_0)
	local var_3_0 = arg_3_0:Convert()

	ipairs = var_1_10002

	for iter_3_0, iter_3_1 in var_1_10002(var_3_0) do
		table = var_1_10007

		var_1_10007.insert(arg_3_0.displays, iter_3_1)
	end

	return arg_3_0.displays
end

function var_0_0.Convert(arg_4_0)
	local var_4_0 = {}

	ipairs = var_1_10002

	for iter_4_0, iter_4_1 in var_1_10002(arg_4_0.recordList) do
		local var_4_1 = iter_4_1:GetMode()

		Story = var_1_10008

		if var_4_1 == var_1_10008.MODE_ASIDE then
			arg_4_0:CollectAsideContent(var_4_0, iter_4_1)

			goto label_4_0
		end

		Story = var_1_10008

		if var_4_1 ~= var_1_10008.MODE_DIALOGUE then
			Story = var_1_10008

			if var_4_1 == var_1_10008.MODE_BG then
				arg_4_0:CollectDialogueContent(var_4_0, iter_4_1)
			end

			::label_4_0::
		end
	end

	arg_4_0.recordList = {}

	return var_4_0
end

function var_0_0.FormatContent(arg_5_0, arg_5_1)
	local var_5_0 = {
		"<size=%d+>",
		"</size>",
		"<color=#%w+>",
		"</color>"
	}
	local var_5_1 = arg_5_1

	ipairs = var_1_10004

	for iter_5_0, iter_5_1 in var_1_10004(var_5_0) do
		string = var_1_10009
		var_5_1 = var_1_10009.gsub(var_5_1, iter_5_1, "")
	end

	return var_5_1
end

function var_0_0.CollectAsideContent(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_2
	local var_6_1 = arg_6_2.GetSequence(var_6_0)
	local var_6_2 = {}

	ipairs = var_6_0

	for iter_6_0, iter_6_1 in var_6_0(var_6_1) do
		table = var_1_10010

		var_1_10010.insert(var_6_2, arg_6_0:FormatContent(iter_6_1[1]))
	end

	table = var_5

	var_5.insert(arg_6_1, {
		isPlayer = false,
		list = var_6_2
	})

	return
end

function var_0_0.CollectDialogueContent(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_2:GetPaintingIcon()
	local var_7_1 = arg_7_2
	local var_7_2 = arg_7_2.GetName(var_7_1)
	local var_7_3 = ""

	getProxy = var_7_1
	PlayerProxy = var_1_10008

	if var_7_1(var_1_10008) then
		getProxy = var_6
		PlayerProxy = var_1_10008

		local var_7_4 = var_6(var_1_10008)

		var_7_3 = var_6.getRawData(var_7_4).name
	end

	local var_7_5 = var_7_2 == var_7_3

	local function var_7_6()
		local var_8_0 = arg_7_2
		local var_8_1 = var_0.GetNameColor(var_8_0)
		local var_8_2

		if not var_7_5 or not var_0_1 then
			var_8_2 = var_8_1 or var_0_4
		end

		return var_8_2
	end

	local var_7_7 = arg_7_2:GetContent()

	table = var_1_10009

	local var_7_8 = var_1_10009.insert
	local var_7_9 = arg_7_1
	local var_7_10 = {
		icon = var_7_0,
		name = var_7_2,
		nameColor = var_7_6()
	}
	local var_7_11 = {}

	setColorStr = var_1_10014

	local var_7_12 = arg_7_0
	local var_7_13 = arg_7_0.FormatContent(var_7_12, var_7_7)
	local var_7_14

	if not var_7_5 or not var_0_1 then
		var_7_14 = var_0_5
	end

	var_7_11[1] = var_1_10014(var_7_13, var_7_14)
	var_7_10.list = var_7_11
	var_7_10.isPlayer = var_7_5

	var_7_8(var_7_9, var_7_10)

	if arg_7_2:ExistOption() then
		local var_7_15 = arg_7_2
		local var_7_16 = arg_7_2.GetSelectedBranchCode(var_7_15)
		local var_7_17 = {}

		ipairs = var_7_15

		for iter_7_0, iter_7_1 in var_7_15(arg_7_2:GetOptions()) do
			local var_7_18 = iter_7_1[2] == var_7_16

			setColorStr = var_7_14

			local var_7_19 = "[ " .. arg_7_0:FormatContent(iter_7_1[1]) .. " ]"
			local var_7_20

			if not var_7_18 or not var_0_1 then
				var_7_20 = var_0_3
			end

			var_7_14 = var_7_14(var_7_19, var_7_20)
			table = var_7_12

			var_7_12.insert(var_7_17, var_7_14)
		end

		table = var_11

		var_11.insert(arg_7_1, {
			isPlayer = true,
			name = var_7_3,
			nameColor = var_0_1,
			list = var_7_17
		})
	end

	return
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
