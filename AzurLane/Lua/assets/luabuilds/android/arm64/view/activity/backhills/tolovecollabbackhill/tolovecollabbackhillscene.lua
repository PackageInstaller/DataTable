local var_0_0 = class("ToLoveCollabBackHillScene", import("..TemplateMV.BackHillTemplate"))

function var_0_0.getUIName(arg_1_0)
	return "ToLoveCollabBackHillUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.top = arg_2_0._tf:Find("top")
	arg_2_0._map = arg_2_0._tf:Find("map")
	arg_2_0._upper = arg_2_0._tf:Find("upper")

	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf:Find("upper/task"), function()
		arg_3_0:emit(ToLoveCollabBackHillMediator.TASK)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("upper/jinianzhang"), function()
		arg_3_0:emit(ToLoveCollabBackHillMediator.TROPHY)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("upper/help"), function()
		arg_3_0:emit(ToLoveCollabBackHillMediator.PUZZLE)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("top/return_btn"), function()
		arg_3_0:emit(var_0_0.ON_BACK)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("top/return_main_btn"), function()
		arg_3_0:emit(var_0_0.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("top/help_btn"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.tolove_main_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("upper/xiaoyouxi"), function()
		arg_3_0:emit(ToLoveCollabBackHillMediator.MINI_GAME)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("upper/tebiezuozhan"), function()
		local var_11_0 = getProxy(ChapterProxy)
		local var_11_1, var_11_2 = var_11_0:getLastMapForActivity()

		if var_11_1 then
			if not var_11_0:getMapById(var_11_1):isUnlock() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))
			else
				arg_3_0:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.LEVEL, {
					chapterId = var_11_2,
					mapIdx = var_11_1
				})
			end

			return
		end
	end, SFX_PANEL)
	arg_3_0:UpdateView()

	return
end

function var_0_0.UpdateView(arg_12_0)
	local var_12_0 = getProxy(ActivityProxy)

	setActive(arg_12_0._tf:Find("upper/task/tips"), ToLoveCollabTaskMediator.GetTaskRedTip())

	local var_12_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLA)
	local var_12_2 = false

	for iter_12_0, iter_12_1 in ipairs(var_12_1.data1_list) do
		if not table.contains(var_12_1.data2_list, iter_12_1) then
			var_12_2 = true

			break
		end
	end

	if #var_12_1:GetPicturePuzzleIds() == #var_12_1.data2_list and var_12_1.data1 ~= 1 then
		var_12_2 = true
	end

	setActive(arg_12_0._tf:Find("upper/jinianzhang/tips"), var_12_2)
	setActive(arg_12_0._tf:Find("upper/help/tips"), PuzzleConnectMediator.GetRedTip())
	setActive(arg_12_0._tf:Find("upper/xiaoyouxi/tips"), ToLoveGameVo.ShouldShowTip())

	return
end

function var_0_0.willExit(arg_13_0)
	return
end

function var_0_0.IsShowMainTip()
	local var_14_0 = getProxy(ActivityProxy)

	return (function()
		return ToLoveCollabTaskMediator.GetTaskRedTip()
	end)() or (function()
		local var_16_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLA)
		local var_16_1 = false

		for iter_16_0, iter_16_1 in ipairs(var_16_0.data1_list) do
			if not table.contains(var_16_0.data2_list, iter_16_1) then
				var_16_1 = true

				break
			end
		end

		if #var_16_0:GetPicturePuzzleIds() == #var_16_0.data2_list and var_16_0.data1 ~= 1 then
			var_16_1 = true
		end

		return var_16_1
	end)() or (function()
		return PuzzleConnectMediator.GetRedTip()
	end)() or (function()
		return ToLoveGameVo.ShouldShowTip()
	end)()
end

return var_0_0
