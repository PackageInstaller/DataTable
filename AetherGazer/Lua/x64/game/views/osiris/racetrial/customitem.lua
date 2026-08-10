local var_0_0 = class("CustomItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.selectCon_ = ControllerUtil.GetController(arg_3_0.transform_, "select")
	arg_3_0.lvCon_ = ControllerUtil.GetController(arg_3_0.transform_, "lv")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.clickFunc_ then
			arg_4_0.clickFunc_(arg_4_0.customID_)
		end
	end)
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.customID_ = arg_7_1
	arg_7_0.isSelect_ = arg_7_2
	arg_7_0.cfg_ = ActivityAffixPoolCfg[arg_7_0.customID_]
	arg_7_0.pointText_.text = arg_7_0.cfg_.point
	arg_7_0.icon_.sprite = getAffixSprite(ActivityAffixPoolCfg[arg_7_0.customID_].affix)

	arg_7_0.selectCon_:SetSelectedState(arg_7_2 and "true" or "false")
	arg_7_0.lvCon_:SetSelectedState(arg_7_0.cfg_.affix[2])
end

function var_0_0.RegisterClickListener(arg_8_0, arg_8_1)
	arg_8_0.clickFunc_ = arg_8_1
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
