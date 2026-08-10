local var_0_0 = class("TipsLongItemView")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.data_ = arg_1_1
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_2, arg_1_3.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()

	arg_1_0.isFree_ = false
end

function var_0_0.InitUI(arg_2_0)
	ComponentBinder.GetInstance():BindCfgUI(arg_2_0, arg_2_0.gameObject_)
end

function var_0_0.IsFree(arg_3_0)
	return arg_3_0.isFree_
end

function var_0_0.SetFree(arg_4_0, arg_4_1)
	arg_4_0.isFree_ = arg_4_1
end

function var_0_0.RefreshUI(arg_5_0, arg_5_1)
	arg_5_0:SetFree(false)

	arg_5_0.text_.text = arg_5_1

	arg_5_0.transform_:SetAsLastSibling()
	arg_5_0.ani_:Play("UItips", -1, 0)
	SetActive(arg_5_0.gameObject_, true)
	arg_5_0:EndDisplay()
end

function var_0_0.EndDisplay(arg_6_0)
	local var_6_0

	var_6_0 = LeanTween.scale(arg_6_0.gameObject_, Vector3.one, 0.1):setDelay(1.1):setOnComplete(System.Action(function()
		arg_6_0:FinishAction()
		var_6_0:setOnComplete(nil)
	end))
end

function var_0_0.FinishAction(arg_8_0)
	arg_8_0.data_:Finish()
	SetActive(arg_8_0.gameObject_, false)
end

function var_0_0.FastFinish(arg_9_0)
	LeanTween.cancel(arg_9_0.gameObject_)
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:FastFinish()
	Object.Destroy(arg_10_0.gameObject_)

	arg_10_0.transform_ = nil
	arg_10_0.gameObject_ = nil
end

return var_0_0
