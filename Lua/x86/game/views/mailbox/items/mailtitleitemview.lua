local var_0_0 = class("MailTitleItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.onResize_ = arg_1_2

	arg_1_0:InitUI()
	arg_1_0:AddListeners()
end

function var_0_0.Dispose(arg_2_0)
	if arg_2_0.time_ then
		arg_2_0.timt_:Stop()

		arg_2_0.time_ = nil
	end

	arg_2_0:RemoveListeners()
	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.gameObject_ = nil
	arg_2_0.transform_ = nil

	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0.titleText_ = arg_3_0:FindCom(typeof(Text), "titleText")
	arg_3_0.timeText_ = arg_3_0:FindCom(typeof(Text), "time/text")
	arg_3_0.blueImg_ = arg_3_0:FindCom(typeof(RectTransform), "blueImg")
	arg_3_0.titleTrs_ = arg_3_0:FindCom(typeof(RectTransform), "titleText")
end

function var_0_0.AddListeners(arg_4_0)
	return
end

function var_0_0.RemoveListeners(arg_5_0)
	return
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.data_ = arg_6_1

	arg_6_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_7_0)
	arg_7_0.titleText_.text = arg_7_0.data_.text

	arg_7_0.titleText_:GetComponent(typeof(ContentSizeFitter)):Validate()
	SetActive(arg_7_0.gameObject_, true)

	if arg_7_0.onResize_ ~= nil then
		arg_7_0.onResize_()
	end
end

function var_0_0.GetHeight(arg_8_0)
	return 1
end

return var_0_0
