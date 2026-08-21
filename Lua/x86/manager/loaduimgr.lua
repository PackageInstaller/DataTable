local var_0_0 = class("LoadUIMgr")

function var_0_0.Ctor(arg_1_0)
	arg_1_0._waittingDlg = nil

	arg_1_0:OnCtor()
end

function var_0_0.OnCtor(arg_2_0)
	print("Initialize Load UI Mgr")

	arg_2_0._waittingDlg = Object.Instantiate(Asset.Load("UI/Loading"), manager.ui.uiLoad.transform)

	SetActive(arg_2_0._waittingDlg, false)

	arg_2_0._uiImage = arg_2_0._waittingDlg.transform:Find("content").gameObject

	SetActive(arg_2_0._uiImage, false)

	arg_2_0._isLoad = false
	arg_2_0.isForceShow_ = false
end

function var_0_0.ShowLoad(arg_3_0, arg_3_1)
	if arg_3_0._waittingDlg == nil then
		return
	end

	arg_3_1 = arg_3_0.isForceShow_ and true or arg_3_1

	if arg_3_0._isLoad == arg_3_1 then
		return
	end

	if arg_3_0.loadingTimer_ then
		arg_3_0.loadingTimer_:Stop()

		arg_3_0.loadingTimer_ = nil
	end

	if arg_3_1 then
		arg_3_0._isLoad = true
		arg_3_0.loadingTimer_ = Timer.New(function()
			SetActive(arg_3_0._uiImage, true)

			arg_3_0.loadingTimer_ = nil
		end, 1.5, 1)

		arg_3_0.loadingTimer_:Start()
		SetActive(arg_3_0._waittingDlg, true)
	else
		arg_3_0._isLoad = false

		SetActive(arg_3_0._waittingDlg, false)
		SetActive(arg_3_0._uiImage, false)
	end
end

function var_0_0.ForceShowLoad(arg_5_0, arg_5_1)
	arg_5_0.isForceShow_ = arg_5_1
end

function var_0_0.Dispose(arg_6_0)
	if arg_6_0.loadingTimer_ then
		arg_6_0.loadingTimer_:Stop()

		arg_6_0.loadingTimer_ = nil
	end

	Object.Destroy(arg_6_0._waittingDlg)

	arg_6_0._waittingDlg = nil
end

return var_0_0
