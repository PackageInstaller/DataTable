local var_0_0 = class("EquipNewSuitItem", ReduxView)
local var_0_1 = import("game.tools.EquipTools")

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
	arg_1_0:Init()
end

function var_0_0.RefreshData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.heroData_ = arg_2_1
	arg_2_0.info_ = arg_2_2

	arg_2_0:Render()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.activeController_ = arg_3_0.activeCon_:GetController("active")

	TerminologyTools.AddTerminologyHandler(arg_3_0, arg_3_0.desc_, nil, nil)
end

function var_0_0.Render(arg_4_0)
	arg_4_0:RefreshUI()
end

function var_0_0.Init(arg_5_0)
	return
end

function var_0_0.RefreshUI(arg_6_0)
	if arg_6_0.info_ then
		local var_6_0 = HeroTools.GetIsSuitNumCut(arg_6_0.heroData_)
		local var_6_1 = arg_6_0.info_.num >= var_0_1.GetSuitNeedNum(arg_6_0.info_.id, var_6_0)
		local var_6_2 = arg_6_0.info_.equipId == nil and true or HeroData:GetEquipMap()[arg_6_0.info_.equipId] ~= nil
		local var_6_3 = EquipSuitCfg[arg_6_0.info_.id]
		local var_6_4 = var_6_3.need

		arg_6_0.name_.text = GetI18NText(var_6_3.name)

		if var_6_2 then
			arg_6_0.activeController_:SetSelectedState(var_6_1 and "active" or "inactive")
		else
			arg_6_0.activeController_:SetSelectedState("normal")
		end

		arg_6_0.num_.text = string.format(GetTips("EQUIP_SUIT_NUM"), var_6_4)
		arg_6_0.desc_.text = GetI18NText(var_0_1.GetEffectDesc(var_6_3.suit_effect[1]))
	end
end

function var_0_0.ShowSelect(arg_7_0, arg_7_1)
	SetActive(arg_7_0.select_, arg_7_1)
end

function var_0_0.OnClick(arg_8_0)
	if arg_8_0.clickFunc then
		arg_8_0.clickFunc(arg_8_0.info_)
	end
end

function var_0_0.RegistCallBack(arg_9_0, arg_9_1)
	arg_9_0.clickFunc = arg_9_1
end

function var_0_0.GetItemInfo(arg_10_0)
	return arg_10_0.info_
end

function var_0_0.Show(arg_11_0, arg_11_1)
	SetActive(arg_11_0.gameObject_, arg_11_1)
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.clickFunc = nil

	arg_12_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
