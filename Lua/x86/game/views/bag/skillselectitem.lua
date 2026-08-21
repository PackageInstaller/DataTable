local var_0_0 = class("SkillSelectItem", ReduxView)
local var_0_1 = import("game.const.EquipConst")
local var_0_2 = import("game.tools.EquipTools")

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.RefreshData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.data_ = arg_2_1
	arg_2_0.info_ = arg_2_2

	arg_2_0:Render()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddBtnListener(arg_3_0.clickBtn_, nil, "OnClick")

	arg_3_0.selectController_ = arg_3_0.transform_:GetComponent("ControllerExCollection"):GetController("state")
end

function var_0_0.Init(arg_4_0)
	arg_4_0:RefreshUI(arg_4_0.info_)
end

function var_0_0.Render(arg_5_0)
	arg_5_0:RefreshUI(arg_5_0.info_)
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1)
	if arg_6_1 and arg_6_1.id ~= 0 then
		local var_6_0 = EquipSkillCfg[arg_6_1.id]

		arg_6_0.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Equip/EquipSkillIcon/" .. var_6_0.icon)
		arg_6_0.name_.text = GetI18NText(var_6_0.name)
	end
end

function var_0_0.SetIndex(arg_7_0, arg_7_1)
	arg_7_0.transform_:SetSiblingIndex(arg_7_1)
end

function var_0_0.SetBottomText(arg_8_0, arg_8_1)
	if arg_8_0.num_ then
		arg_8_0.numText_.text = arg_8_1
	end
end

function var_0_0.RefreshPos(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.num_ = var_0_2.GetEquipSkillNum(arg_9_0.info_.id, nil, arg_9_1, arg_9_2)

	arg_9_0:SetBottomText(arg_9_0.num_)
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()

	arg_10_0.info_ = nil
	arg_10_0.clickFunc = nil

	var_0_0.super.Dispose(arg_10_0)
end

function var_0_0.OnClick(arg_11_0)
	if arg_11_0.clickFunc and arg_11_0.num_ ~= 0 then
		arg_11_0.clickFunc(arg_11_0.info_.id)
	end
end

function var_0_0.SetSelect(arg_12_0, arg_12_1)
	if arg_12_0.num_ == 0 then
		arg_12_0.selectController_:SetSelectedIndex(2)
	elseif arg_12_1 then
		arg_12_0.selectController_:SetSelectedIndex(1)
	else
		arg_12_0.selectController_:SetSelectedIndex(0)
	end
end

function var_0_0.RegistCallBack(arg_13_0, arg_13_1)
	arg_13_0.clickFunc = arg_13_1
end

function var_0_0.GetItemInfo(arg_14_0)
	return arg_14_0.info_
end

function var_0_0.Show(arg_15_0, arg_15_1)
	SetActive(arg_15_0.gameObject_, arg_15_1)
end

return var_0_0
