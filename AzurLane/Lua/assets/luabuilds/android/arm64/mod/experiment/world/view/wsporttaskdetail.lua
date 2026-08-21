local var_0_0 = class("WSPortTaskDetail", import("...BaseEntity"))

var_0_0.Fields = {
	onCancel = "function",
	task = "table",
	transform = "userdata"
}

function var_0_0.Setup(arg_1_0)
	pg.DelegateInfo.New(arg_1_0)
	arg_1_0:Init()

	return
end

function var_0_0.Dispose(arg_2_0)
	pg.DelegateInfo.Dispose(arg_2_0)
	arg_2_0:Clear()

	return
end

function var_0_0.Init(arg_3_0)
	onButton(arg_3_0, arg_3_0.transform, function()
		arg_3_0.onCancel()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.transform:Find("top/btnBack"), function()
		arg_3_0.onCancel()

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.UpdateTask(arg_6_0, arg_6_1)
	arg_6_0.task = arg_6_1

	setText(arg_6_0.transform:Find("window/desc"), arg_6_1.config.description)

	local var_6_0 = arg_6_1:GetDisplayDrops()
	local var_6_1 = UIItemList.New(arg_6_0.transform:Find("window/scrollview/list"), (arg_6_0.transform:Find("window/scrollview/item")))

	var_6_1:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			updateDrop(arg_7_2, var_6_0[arg_7_1 + 1])
			setScrollText(arg_7_2:Find("name_mask/name"), var_6_0[arg_7_1 + 1]:getConfig("name"))
		end

		return
	end)
	var_6_1:align(#arg_6_1:GetDisplayDrops())

	return
end

return var_0_0
