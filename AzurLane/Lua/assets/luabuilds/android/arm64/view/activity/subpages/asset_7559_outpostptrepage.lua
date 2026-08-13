class = var_0_10000

local var_0_0 = "OutPostPtRePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.NewFrameTemplatePage"))
local var_0_2 = {
	16851,
	16852,
	16853,
	16854
}

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0._tf

	arg_1_0.switchBtn = var_1.Find(var_1_1, "AD/switcher/switch_btn")

	local var_1_2 = arg_1_0._tf

	arg_1_0.bar = var_1.Find(var_1_2, "AD/switcher/phase2/Image/bar")

	local var_1_3 = arg_1_0._tf

	arg_1_0.displayBtn = var_1.Find(var_1_3, "AD/display_btn")

	local var_1_4 = arg_1_0._tf

	arg_1_0.gotTag = var_1.Find(var_1_4, "AD/switcher/phase2/Image/got")

	local var_1_5 = arg_1_0.displayBtn
	local var_1_6 = var_1.Find(var_1_5, "Image1")
	local var_1_7 = arg_1_0.displayBtn
	local var_1_8 = var_2.Find(var_1_7, "Image2")
	local var_1_9, var_1_10 = arg_1_0:GetActTask()
	local var_1_11

	if var_1_9 then
		::label_1_0::

		var_1_10007 = var_1_9

		if var_1_9.isReceive(var_1_10007) then
			var_1_11 = var_1_10
		end
	end

	setActive = var_1_10006

	var_1_10006(var_1_6, not var_1_11)

	setActive = var_1_10006

	var_1_10006(var_1_8, var_1_11)

	local var_1_12

	onButton = var_1_10007

	var_1_10007(arg_1_0, arg_1_0.displayBtn, function()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_2_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		var_2_1(var_2_0, var_2_2, var_2_10004.TASK, {
			page = "activity",
			targetId = var_1_12
		})

		return
	end)

	return
end

function var_0_1.GetActTask(arg_3_0)
	local var_3_0 = var_0_2

	getProxy = var_1_10002
	TaskProxy = var_1_10004

	local var_3_1 = var_1_10002(var_1_10004)
	local var_3_2
	local var_3_3 = false

	for iter_3_0 = #var_3_0, 1, -1 do
		local var_3_4 = var_3_0[iter_3_0]
		local var_3_5

		if not var_3_1:getTaskById(var_3_4) then
			var_3_5 = var_3_1:getFinishTaskById(var_3_4)
		end

		if var_3_5 then
			var_3_2 = var_3_5

			if iter_3_0 == #var_3_0 then
				var_3_3 = true
			end

			break
		end
	end

	return var_3_2, var_3_3
end

return var_0_1
