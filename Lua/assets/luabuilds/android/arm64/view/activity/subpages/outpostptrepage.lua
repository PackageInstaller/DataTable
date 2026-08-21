local var_0_0 = class("OutPostPtRePage", import(".TemplatePage.NewFrameTemplatePage"))
local var_0_1 = {
	16851,
	16852,
	16853,
	16854
}

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.switchBtn = arg_1_0._tf:Find("AD/switcher/switch_btn")
	arg_1_0.bar = arg_1_0._tf:Find("AD/switcher/phase2/Image/bar")
	arg_1_0.displayBtn = arg_1_0._tf:Find("AD/display_btn")
	arg_1_0.gotTag = arg_1_0._tf:Find("AD/switcher/phase2/Image/got")

	local var_1_0, var_1_1 = arg_1_0:GetActTask()
	local var_1_2 = var_1_0 and var_1_0:isReceive() and var_1_1

	setActive(arg_1_0.displayBtn:Find("Image1"), not var_1_2)
	setActive(arg_1_0.displayBtn:Find("Image2"), var_1_2)

	local var_1_3

	onButton(arg_1_0, arg_1_0.displayBtn, function()
		arg_1_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
			page = "activity",
			targetId = var_1_3
		})

		return
	end)

	return
end

function var_0_0.GetActTask(arg_3_0)
	local var_3_0 = getProxy(TaskProxy)
	local var_3_1
	local var_3_2 = false

	for iter_3_0 = #var_0_1, 1, -1 do
		local var_3_3 = var_3_0:getTaskById(var_0_1[iter_3_0]) or var_3_0:getFinishTaskById(var_0_1[iter_3_0])

		if var_3_3 then
			var_3_1 = var_3_3

			if iter_3_0 == #var_0_1 then
				var_3_2 = true
			end

			break
		end
	end

	return var_3_1, var_3_2
end

return var_0_0
