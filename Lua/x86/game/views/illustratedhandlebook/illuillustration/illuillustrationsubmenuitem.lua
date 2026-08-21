local var_0_0 = class("illuillustrationSubMenuItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.selectController = ControllerUtil.GetController(arg_1_0.transform_, "toggle")
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.btn_, nil, function()
		if arg_2_0.clickFunc_ then
			arg_2_0.clickFunc_(arg_2_0.chapterID_)
		end
	end)
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	arg_4_0:Show(true)

	arg_4_0.chapterID_ = arg_4_1
	arg_4_0.titleText_.text = ChapterClientCfg[arg_4_0.chapterID_].name
end

function var_0_0.Show(arg_5_0, arg_5_1)
	SetActive(arg_5_0.gameObject_, arg_5_1)
end

function var_0_0.SetClickFunc(arg_6_0, arg_6_1)
	arg_6_0.clickFunc_ = arg_6_1
end

function var_0_0.SetSelect(arg_7_0, arg_7_1)
	arg_7_0.selectController:SetSelectedState(arg_7_1 and "on" or "off")
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
	Object.Destroy(arg_8_0.gameObject_)

	arg_8_0.gameObject_ = nil
	arg_8_0.transform_ = nil
end

return var_0_0
