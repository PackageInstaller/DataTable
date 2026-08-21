local var_0_0 = class("GloryAwardWindow", import(".PtAwardWindow"))

local function var_0_1(arg_1_0)
	local var_1_0 = arg_1_0.taskList
	local var_1_1 = getProxy(TaskProxy)

	arg_1_0.UIlist:make(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0 == UIItemList.EventUpdate then
			local var_2_0 = var_1_1:getTaskVO(var_1_0[arg_2_1 + 1])

			setText(arg_2_2:Find("title/Text"), "PHASE " .. arg_2_1 + 1)
			setText(arg_2_2:Find("target/title"), var_2_0:getConfig("desc"))
			setText(arg_2_2:Find("target/Text"), "")

			local var_2_1 = var_2_0:getConfig("award_display")[1]

			updateDrop(arg_2_2:Find("award"), {
				type = var_2_1[1],
				id = var_2_1[2],
				count = var_2_1[3]
			})
			onButton(arg_1_0.binder, arg_2_2:Find("award"), function()
				arg_1_0.binder:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)
			setActive(arg_2_2:Find("award/mask"), var_2_0:isReceive())
		end

		return
	end)
	arg_1_0.UIlist:align(#arg_1_0.taskList)

	return
end

function var_0_0.Show(arg_4_0, arg_4_1)
	arg_4_0.taskList = arg_4_1.taskList
	arg_4_0.taskVO = arg_4_1.taskVO

	var_0_1(arg_4_0)

	arg_4_0.totalTxt.text = arg_4_0.taskVO:getProgress()
	arg_4_0.totalTitleTxt.text = i18n("pt_total_count", i18n("pass_times"))

	setActive(arg_4_0._tf, true)

	return
end

return var_0_0
