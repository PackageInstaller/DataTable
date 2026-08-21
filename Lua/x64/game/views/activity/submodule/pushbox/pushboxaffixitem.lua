local var_0_0 = class("PushBoxAffixItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0.icon_ = arg_2_0:FindCom(typeof(Image), "icon")
	arg_2_0.text_ = arg_2_0:FindCom(typeof(Text), "text")
end

function var_0_0.Dispose(arg_3_0)
	Object.Destroy(arg_3_0.gameObject_)

	arg_3_0.gameObject_ = nil

	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	arg_4_0.icon_.sprite = getAffixSprite(arg_4_1)
	arg_4_0.text_.text = GetI18NText(getAffixName(arg_4_1))

	arg_4_0:SetActive(true)
end

function var_0_0.SetActive(arg_5_0, arg_5_1)
	SetActive(arg_5_0.gameObject_, arg_5_1)
end

return var_0_0
