local var_0_0 = class("SummerRacePopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_SummerRace/com/Activity_SummerRace_PopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_4_0)
	if arg_4_0.cancelBtn_ then
		arg_4_0:AddBtnListener(arg_4_0.cancelBtn_, nil, function()
			arg_4_0:CloseWithCancel()
		end)
	end

	if arg_4_0.okBtn_ then
		arg_4_0:AddBtnListener(arg_4_0.okBtn_, nil, function()
			if arg_4_0.okCb_ then
				arg_4_0.okCb_()
			end
		end)
	end
end

function var_0_0.CloseWithCancel(arg_7_0)
	if arg_7_0.isClosing_ then
		return
	end

	arg_7_0.isClosing_ = true

	if arg_7_0.cancelCb_ then
		arg_7_0.cancelCb_()
	end

	arg_7_0:Back()
end

function var_0_0.EnsureWindowBar(arg_8_0)
	arg_8_0.windowBarBackHandler_ = arg_8_0.windowBarBackHandler_ or function()
		arg_8_0:CloseWithCancel()
	end

	if manager ~= nil and manager.windowBar ~= nil then
		manager.windowBar:PushWindowBar({
			BACK_BAR
		})
		manager.windowBar:RegistBackCallBack(arg_8_0.windowBarBackHandler_)

		arg_8_0.windowBarPushed_ = true
	end
end

function var_0_0.CleanupWindowBar(arg_10_0)
	if manager == nil or manager.windowBar == nil then
		arg_10_0.windowBarPushed_ = false

		return
	end

	if arg_10_0.windowBarPushed_ then
		arg_10_0.windowBarPushed_ = false

		manager.windowBar:PopWindowBar()
	elseif arg_10_0.windowBarBackHandler_ ~= nil and manager.windowBar:GetLastBackFunc() == arg_10_0.windowBarBackHandler_ then
		manager.windowBar:HideBar()
	end
end

function var_0_0.OnEnter(arg_11_0)
	local var_11_0 = arg_11_0.params_

	arg_11_0.okCb_ = nil
	arg_11_0.cancelCb_ = nil
	arg_11_0.closeCb_ = nil
	arg_11_0.isClosing_ = false

	if var_11_0 ~= nil then
		arg_11_0.okCb_ = var_11_0.okCb
		arg_11_0.cancelCb_ = var_11_0.cancelCb
		arg_11_0.closeCb_ = var_11_0.closeCb
	end

	if arg_11_0.titleText_ then
		local var_11_1 = GetTips("PROMPT")

		if var_11_0 ~= nil and var_11_0.title ~= nil then
			var_11_1 = var_11_0.title
		end

		arg_11_0.titleText_.text = var_11_1
	end

	if arg_11_0.tipContent_ then
		local var_11_2 = ""

		if var_11_0 ~= nil and var_11_0.content ~= nil then
			var_11_2 = var_11_0.content
		end

		arg_11_0.tipContent_.text = var_11_2
	end

	if arg_11_0.confirmText_ then
		local var_11_3 = GetTips("CONFIRM")

		if var_11_0 ~= nil and var_11_0.confirmText ~= nil then
			var_11_3 = var_11_0.confirmText
		end

		arg_11_0.confirmText_.text = var_11_3
	end

	if arg_11_0.cancelText_ then
		local var_11_4 = GetTips("CANCEL")

		if var_11_0 ~= nil and var_11_0.cancelText ~= nil then
			var_11_4 = var_11_0.cancelText
		end

		arg_11_0.cancelText_.text = var_11_4
	end

	arg_11_0:EnsureWindowBar()
end

function var_0_0.OnExit(arg_12_0)
	arg_12_0:CleanupWindowBar()

	if arg_12_0.closeCb_ then
		arg_12_0.closeCb_()
	end

	arg_12_0.okCb_ = nil
	arg_12_0.cancelCb_ = nil
	arg_12_0.closeCb_ = nil
	arg_12_0.isClosing_ = false
end

return var_0_0
