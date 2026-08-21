local var_0_0 = class("AttachmentSpineAnimationCell", import(".StaticCellView"))

var_0_0.SDPosition = Vector2(0, -15)
var_0_0.SDScale = Vector3(0.4, 0.4, 0.4)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.name = nil
	arg_1_0.model = nil
	arg_1_0.AnimIndex = nil
	arg_1_0.group = {}
	arg_1_0.timer = nil

	return
end

function var_0_0.GetOrder(arg_2_0)
	return ChapterConst.CellPriorityAttachment
end

function var_0_0.Set(arg_3_0, arg_3_1)
	if arg_3_0.name == arg_3_1 then
		return
	end

	arg_3_0:ClearLoader()
	table.clear(arg_3_0.group)

	arg_3_0.name = arg_3_1

	if IsNil(arg_3_0.go) then
		arg_3_0:PrepareBase("SD")
		arg_3_0:OverrideCanvas()
		arg_3_0:ResetCanvasOrder()
	end

	arg_3_0:GetLoader():GetSpine(arg_3_1, function(arg_4_0)
		arg_3_0.spineChar = arg_4_0
		arg_3_0.model = arg_4_0:GetModel()

		arg_4_0:SetParent(arg_3_0.go)
		arg_4_0:SetAnchoredPosition(arg_3_0.SDPosition)
		arg_4_0:SetLocalScale(arg_3_0.SDScale)
		arg_3_0:PlayAction(arg_3_0.AnimIndex)

		return
	end, "SD")

	return
end

function var_0_0.SetRoutine(arg_5_0, arg_5_1)
	table.clear(arg_5_0.group)

	arg_5_0.AnimIndex = nil

	for iter_5_0, iter_5_1 in ipairs(arg_5_1 or {}) do
		arg_5_0.group[iter_5_0] = iter_5_1
	end

	if #arg_5_0.group < 1 then
		table.insert(arg_5_0.group, {
			action = "default",
			duration = 9999
		})
	end

	arg_5_0:PlayAction(math.min(#arg_5_0.group, 1))

	return
end

function var_0_0.PlayAction(arg_6_0, arg_6_1)
	if not arg_6_1 or arg_6_1 <= 0 or arg_6_1 > #arg_6_0.group or arg_6_0.AnimIndexPlaying == arg_6_1 then
		return
	end

	arg_6_0.AnimIndex = arg_6_1

	if not arg_6_0.loader or arg_6_0.loader:GetLoadingRP("SD") or not arg_6_0.spineChar then
		return
	end

	local var_6_0 = arg_6_0.group[arg_6_1]

	arg_6_0:ClearTimer()

	arg_6_0.timer = Timer.New(function()
		arg_6_1 = arg_6_1 + 1

		if arg_6_1 > #arg_6_0.group then
			arg_6_1 = math.min(#arg_6_0.group, 1)
		end

		arg_6_0:PlayAction(arg_6_1)

		return
	end, var_6_0.duration)

	arg_6_0.spineChar:SetAction(var_6_0.action, 0)
	arg_6_0.timer:Start()

	arg_6_0.AnimIndexPlaying = arg_6_1

	return
end

function var_0_0.ClearTimer(arg_8_0)
	if arg_8_0.timer then
		arg_8_0.timer:Stop()

		arg_8_0.timer = nil
	end

	return
end

function var_0_0.Clear(arg_9_0)
	arg_9_0:ClearTimer()

	arg_9_0.name = nil

	var_0_0.super.Clear(arg_9_0)

	return
end

return var_0_0
