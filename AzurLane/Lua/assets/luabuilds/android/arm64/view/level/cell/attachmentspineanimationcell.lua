class = var_0_10000

local var_0_0 = "AttachmentSpineAnimationCell"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".StaticCellView"))

Vector2 = var_0_10001
var_0_1.SDPosition = var_0_10001(0, -15)
Vector3 = var_1
var_0_1.SDScale = var_1(0.4, 0.4, 0.4)

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.name = nil
	arg_1_0.model = nil
	arg_1_0.AnimIndex = nil
	arg_1_0.group = {}
	arg_1_0.timer = nil

	return
end

function var_0_1.GetOrder(arg_2_0)
	ChapterConst = var_1_10001

	return var_1_10001.CellPriorityAttachment
end

function var_0_1.Set(arg_3_0, arg_3_1)
	if arg_3_0.name == arg_3_1 then
		return
	end

	arg_3_0:ClearLoader()

	table = var_2

	var_2.clear(arg_3_0.group)

	arg_3_0.name = arg_3_1
	IsNil = var_2

	if var_2(arg_3_0.go) then
		arg_3_0:PrepareBase("SD")
		arg_3_0:OverrideCanvas()
		arg_3_0:ResetCanvasOrder()
	end

	local var_3_0 = arg_3_0:GetLoader()

	var_2.GetSpine(var_3_0, arg_3_1, function(arg_4_0)
		arg_3_0.spineChar = arg_4_0
		arg_3_0.model = arg_4_0:GetModel()

		arg_4_0:SetParent(arg_3_0.go)
		arg_4_0:SetAnchoredPosition(arg_3_0.SDPosition)
		arg_4_0:SetLocalScale(arg_3_0.SDScale)

		local var_4_0 = arg_3_0

		var_1.PlayAction(var_4_0, arg_3_0.AnimIndex)

		return
	end, "SD")

	return
end

function var_0_1.SetRoutine(arg_5_0, arg_5_1)
	table = var_1_10002

	var_1_10002.clear(arg_5_0.group)

	arg_5_0.AnimIndex = nil
	ipairs = var_2

	for iter_5_0, iter_5_1 in var_2(arg_5_1 or {}) do
		arg_5_0.group[iter_5_0] = iter_5_1
	end

	if #arg_5_0.group < 1 then
		table = var_2

		var_2.insert(arg_5_0.group, {
			action = "default",
			duration = 9999
		})
	end

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.PlayAction

	math = iter_5_0

	var_5_1(var_5_0, iter_5_0.min(#arg_5_0.group, 1))

	return
end

function var_0_1.PlayAction(arg_6_0, arg_6_1)
	if not arg_6_1 or arg_6_1 <= 0 or arg_6_1 > #arg_6_0.group or arg_6_0.AnimIndexPlaying == arg_6_1 then
		return
	end

	arg_6_0.AnimIndex = arg_6_1

	if arg_6_0.loader then
		local var_6_0 = arg_6_0.loader

		if var_2.GetLoadingRP(var_6_0, "SD") or not arg_6_0.spineChar then
			return
		end

		local var_6_1 = arg_6_0.group[arg_6_1]

		arg_6_0:ClearTimer()

		Timer = var_3
		arg_6_0.timer = var_3.New(function()
			arg_6_1 = arg_6_1 + 1

			if arg_6_1 > #arg_6_0.group then
				math = var_0
				arg_6_1 = var_0.min(#arg_6_0.group, 1)
			end

			local var_7_0 = arg_6_0

			var_0.PlayAction(var_7_0, arg_6_1)

			return
		end, var_6_1.duration)

		local var_6_2 = arg_6_0.spineChar

		var_3.SetAction(var_6_2, var_6_1.action, 0)

		local var_6_3 = arg_6_0.timer

		var_3.Start(var_6_3)

		arg_6_0.AnimIndexPlaying = arg_6_1

		return
	end
end

function var_0_1.ClearTimer(arg_8_0)
	if arg_8_0.timer then
		local var_8_0 = arg_8_0.timer

		var_1.Stop(var_8_0)

		arg_8_0.timer = nil
	end

	return
end

function var_0_1.Clear(arg_9_0)
	arg_9_0:ClearTimer()

	arg_9_0.name = nil

	var_0_1.super.Clear(arg_9_0)

	return
end

return var_0_1
