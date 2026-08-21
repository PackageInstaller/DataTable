local var_0_0 = class("TempestaMedalCollectionScene", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "TempestaMedalCollectionUI"
end

function var_0_0.setActivity(arg_2_0, arg_2_1)
	arg_2_0.activity = arg_2_1

	return
end

function var_0_0.onBackPressed(arg_3_0)
	if isActive(arg_3_0.rtHelpPanel) then
		setActive(arg_3_0.rtHelpPanel)
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_3_0.rtHelpPanel, arg_3_0._tf)

		return
	end

	arg_3_0:closeView()

	return
end

function var_0_0.init(arg_4_0)
	onButton(arg_4_0, arg_4_0._tf:Find("top/btn_back"), function()
		arg_4_0:onBackPressed()

		return
	end, SFX_CANCEL)

	arg_4_0.rtMainPanel = arg_4_0._tf:Find("main")

	onButton(arg_4_0, arg_4_0.rtMainPanel:Find("btn_help"), function()
		pg.UIMgr.GetInstance():BlurPanel(arg_4_0.rtHelpPanel)
		setActive(arg_4_0.rtHelpPanel, true)

		return
	end, SFX_PANEL)

	arg_4_0.rtHelpPanel = arg_4_0._tf:Find("help_panel")

	setText(arg_4_0.rtHelpPanel:Find("window/Text"), i18n("pirate_wanted_help"))
	onButton(arg_4_0, arg_4_0.rtHelpPanel:Find("bg"), function()
		arg_4_0:onBackPressed()

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.didEnter(arg_8_0)
	arg_8_0:updateTaskLayers()

	return
end

function var_0_0.updateTaskLayers(arg_9_0)
	local var_9_0 = getProxy(TaskProxy)
	local var_9_1 = underscore.map(arg_9_0.activity:getConfig("config_data"), function(arg_10_0)
		local var_10_0 = var_9_0:getTaskVO(arg_10_0)

		if not var_10_0 then
			var_10_0 = Task.New({
				submit_time = 1,
				id = arg_10_0
			})

			var_10_0:updateProgress(var_10_0:getConfig("target_num"))
		end

		return var_10_0
	end)

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		local var_9_2 = arg_9_0.rtMainPanel:Find("tasks"):GetChild(iter_9_0 - 1)

		if iter_9_0 == #var_9_1 then
			setActive(var_9_2:Find("got"), iter_9_1:isReceive())

			local var_9_3 = Drop.Create(iter_9_1:getConfig("award_display")[1])

			onButton(arg_9_0, var_9_2, function()
				arg_9_0:emit(BaseUI.ON_DROP, var_9_3)

				return
			end, SFX_PANEL)
		else
			local var_9_4 = {}

			var_9_4.type, var_9_4.id, var_9_4.count = unpack(iter_9_1:getConfig("award_display")[1])

			updateDrop(var_9_2:Find("IconTpl"), var_9_4)
			onButton(arg_9_0, var_9_2:Find("IconTpl"), function()
				arg_9_0:emit(BaseUI.ON_DROP, var_9_4)

				return
			end, SFX_PANEL)
			setText(var_9_2:Find("Text"), iter_9_1:getConfig("desc"))

			local var_9_5 = iter_9_1:getTaskStatus()

			setActive(var_9_2:Find("btn_go"), var_9_5 == 0)
			setActive(var_9_2:Find("btn_get"), var_9_5 == 1)
			setActive(var_9_2:Find("btn_got"), var_9_5 == 2)
			onButton(arg_9_0, var_9_2:Find("btn_go"), function()
				arg_9_0:emit(TempestaMedalCollectionMediator.ON_TASK_GO, iter_9_1)

				return
			end, SFX_PANEL)
			onButton(arg_9_0, var_9_2:Find("btn_get"), function()
				arg_9_0:emit(TempestaMedalCollectionMediator.ON_TASK_SUBMIT, iter_9_1)

				return
			end, SFX_PANEL)
		end
	end

	local var_9_6 = underscore.reduce(var_9_1, 0, function(arg_15_0, arg_15_1)
		return arg_15_0 + (arg_15_1:isReceive() and 1 or 0)
	end)

	setText(arg_9_0.rtMainPanel:Find("progress/Text"), math.min(var_9_6, #var_9_1 - 1) .. "/" .. #var_9_1 - 1)

	if #var_9_1 - 1 <= var_9_6 and not var_9_1[#var_9_1]:isReceive() then
		arg_9_0:emit(TempestaMedalCollectionMediator.ON_TASK_SUBMIT, var_9_1[#var_9_1])
	end

	return
end

function var_0_0.willExit(arg_16_0)
	if isActive(arg_16_0.rtHelpPanel) then
		arg_16_0:onBackPressed()
	end

	return
end

return var_0_0
