local var_0_0 = class("HalloweenSkinPage", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.stage = arg_1_0._tf:Find("AD/Text"):GetComponent(typeof(Text))
	arg_1_0.goBtn = arg_1_0._tf:Find("AD/go_btn")
	arg_1_0.gotBtn = arg_1_0._tf:Find("AD/got_btn")

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	arg_2_0.tasks = _.flatten(arg_2_0.activity:getConfig("config_data"))

	onButton(arg_2_0, arg_2_0.goBtn, function()
		if arg_2_0:LastTaskBeFinished() then
			return
		end

		arg_2_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.NAVALACADEMYSCENE)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.LastTaskBeFinished(arg_4_0)
	local var_4_0 = getProxy(TaskProxy):getTaskVO(arg_4_0.tasks[#arg_4_0.tasks])

	if var_4_0 and var_4_0:isReceive() then
		return true
	end

	return false
end

function var_0_0.OnUpdateFlush(arg_5_0)
	local var_5_1 = 0
	local var_5_2 = getProxy(TaskProxy)

	for iter_5_0 = #arg_5_0.tasks, 1, -1 do
		local var_5_3 = var_5_2:getTaskVO(arg_5_0.tasks[iter_5_0])

		if var_5_3 and var_5_3:isReceive() then
			var_5_1 = iter_5_0
		elseif var_5_3 and not var_5_3:isReceive() then
			var_5_1 = iter_5_0 - 1
		end
	end

	arg_5_0.stage.text = var_5_1 .. "/" .. #arg_5_0.tasks

	setActive(arg_5_0.gotBtn, (arg_5_0:LastTaskBeFinished()))

	return
end

function var_0_0.OnDestroy(arg_6_0)
	return
end

return var_0_0
