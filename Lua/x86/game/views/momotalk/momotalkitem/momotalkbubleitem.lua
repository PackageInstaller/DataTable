local var_0_0 = class("MomoTalkBubleItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.itemBtn_, nil, function()
		if arg_2_0.onClick_ then
			arg_2_0.onClick_(arg_2_0.id_)
		end
	end)
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.id_ = arg_4_1.id
	arg_4_0.onClick_ = arg_4_3

	local var_4_0 = arg_4_1.state == 1

	if arg_4_0.previewImg_ then
		arg_4_0.previewImg_.sprite = getSpriteViaConfig("ChatBubble", arg_4_1.id)
	end

	if arg_4_0.lockGo_ then
		SetActive(arg_4_0.lockGo_, not var_4_0)
	end

	if arg_4_0.selectGo_ then
		SetActive(arg_4_0.selectGo_, arg_4_2)
	end

	if arg_4_0.itemBtn_ then
		arg_4_0.itemBtn_.interactable = var_4_0
	end
end

function var_0_0.SetSelected(arg_5_0, arg_5_1)
	if arg_5_0.selectGo_ then
		SetActive(arg_5_0.selectGo_, arg_5_1)
	end
end

function var_0_0.Show(arg_6_0, arg_6_1)
	SetActive(arg_6_0.gameObject_, arg_6_1)
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0:RemoveAllListeners()
	Object.Destroy(arg_7_0.gameObject_)

	arg_7_0.gameObject_ = nil

	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
