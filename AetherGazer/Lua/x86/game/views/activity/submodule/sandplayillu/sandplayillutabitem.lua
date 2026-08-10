local var_0_0 = class("SandPlayIlluTabItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	arg_2_0.selectController_ = arg_2_0.mainControllerEx_:GetController("select")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.selectBtn_, nil, function()
		arg_4_0:OnSelectBtnClick()
	end)
end

function var_0_0.OnSelectBtnClick(arg_6_0)
	arg_6_0.onClick_(arg_6_0.index_)
end

function var_0_0.SetSelectedState(arg_7_0, arg_7_1)
	local var_7_0 = false

	if arg_7_0.index_ == arg_7_1 then
		var_7_0 = true
	end

	arg_7_0.selectController_:SetSelectedState(var_7_0 and "true" or "false")
end

function var_0_0.SetData(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0.index_ = arg_8_1
	arg_8_0.groupID_ = arg_8_2
	arg_8_0.onClick_ = arg_8_3

	manager.redPoint:bindUIandKey(arg_8_0.transform_, string.format("%s_%s", RedPointConst.ACTIVITY_SANDPLAY_ILLU_GROUP, arg_8_2))
	arg_8_0:UpdateView()
end

function var_0_0.UpdateView(arg_9_0)
	local var_9_0 = SandplayIlluGroupCfg[arg_9_0.groupID_]

	if not var_9_0 then
		return
	end

	arg_9_0.iconImg_.sprite = getSpriteViaConfig("SandplayIllu", var_9_0.icon)
end

function var_0_0.Show(arg_10_0, arg_10_1)
	SetActive(arg_10_0.gameObject_, arg_10_1)
end

function var_0_0.Dispose(arg_11_0)
	manager.redPoint:unbindUIandKey(arg_11_0.transform_, string.format("%s_%s", RedPointConst.ACTIVITY_SANDPLAY_ILLU_GROUP, arg_11_0.groupID_))
	arg_11_0:RemoveAllListeners()
	Object.Destroy(arg_11_0.gameObject_)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
