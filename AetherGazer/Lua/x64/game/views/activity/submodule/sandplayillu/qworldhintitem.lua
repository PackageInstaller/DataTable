local var_0_0 = class("QWorldHintItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		arg_4_0:OnSelectBtnClick()
	end)
end

function var_0_0.OnSelectBtnClick(arg_6_0)
	SandPlayIlluTool.EnterSandPlayIllu(arg_6_0.itemID_)
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	arg_7_0.itemID_ = arg_7_1

	arg_7_0:UpdateView()
end

function var_0_0.UpdateView(arg_8_0)
	local var_8_0 = SandplayIlluCfg[arg_8_0.itemID_]

	if not var_8_0 then
		return
	end

	arg_8_0.image_.sprite = getSpriteViaConfig("SandplayIllu", var_8_0.icon)
	arg_8_0.nameText_.text = GetI18NText(var_8_0.name)
end

function var_0_0.Show(arg_9_0, arg_9_1)
	SetActive(arg_9_0.gameObject_, arg_9_1)
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()
	Object.Destroy(arg_10_0.gameObject_)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
