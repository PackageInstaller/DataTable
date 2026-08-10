local var_0_0 = class("DormInfomationTabModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_1:SetActive(true)
	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0.callback = nil
	arg_2_0.txt1 = arg_2_0.transform_:Find("upselect/Textupselect01").gameObject:GetComponent(typeof(Text))
	arg_2_0.txt2 = arg_2_0.transform_:Find("select_on/Textselect01").gameObject:GetComponent(typeof(Text))

	arg_2_0:AddListener()
end

function var_0_0.AddListener(arg_3_0)
	arg_3_0:AddToggleListener(arg_3_0.gameObject_:GetComponent(typeof(Toggle)), function(arg_4_0)
		if arg_4_0 and arg_3_0.callback then
			arg_3_0.callback(arg_3_0.id)
		end
	end)
end

function var_0_0.BindId(arg_5_0, arg_5_1)
	arg_5_0.id = arg_5_1
	arg_5_0.txt1.text = BackhomeContentNoticeCfg[arg_5_1].title
	arg_5_0.txt2.text = BackhomeContentNoticeCfg[arg_5_1].title
end

function var_0_0.RegisterClickCallback(arg_6_0, arg_6_1)
	arg_6_0.callback = arg_6_1
end

function var_0_0.Dispose(arg_7_0)
	if not isNil(arg_7_0.gameObject_) then
		GameObject.Destroy(arg_7_0.gameObject_)
	end

	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
