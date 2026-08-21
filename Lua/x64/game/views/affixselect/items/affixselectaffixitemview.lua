local var_0_0 = class("AffixSelectAffixItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.onItemSelect_ = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.btn_ = arg_3_0.gameObject_:GetComponent(typeof(Button))
	arg_3_0.selectController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "select1")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		arg_4_0:SetSelect(not arg_4_0.isSelect_)

		if arg_4_0.onItemSelect_ ~= nil then
			arg_4_0.onItemSelect_(arg_4_0.affixPoolId_, arg_4_0.isSelect_)
		end
	end)
end

function var_0_0.AddEventListeners(arg_6_0)
	return
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.index_ = arg_7_1
	arg_7_0.affixPoolId_ = arg_7_2
	arg_7_0.isSelect_ = arg_7_3
	arg_7_0.cfg_ = ActivityAffixPoolCfg[arg_7_2]

	arg_7_0:UpdateView()
	arg_7_0:SetSelect(arg_7_0.isSelect_)
end

function var_0_0.SetSelect(arg_8_0, arg_8_1)
	arg_8_0.isSelect_ = arg_8_1

	arg_8_0.selectController_:SetSelectedState(arg_8_1 and "select" or "normal")
end

function var_0_0.UpdateView(arg_9_0)
	arg_9_0.numLabel_.text = arg_9_0.cfg_.point
	arg_9_0.descLabel_.text = GetI18NText(getAffixDesc(arg_9_0.cfg_.affix))
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0:AddEventListeners()
end

function var_0_0.OnExit(arg_11_0)
	arg_11_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_12_0)
	return
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.data_ = nil
	arg_13_0.onItemSelect_ = nil

	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
