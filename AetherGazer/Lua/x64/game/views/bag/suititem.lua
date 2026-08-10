local var_0_0 = class("SuitItem", ReduxView)
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
	arg_3_0.bg_ = arg_3_0:FindGo("bg")
	arg_3_0.icon_ = arg_3_0:FindCom(typeof(Image), "icon")
	arg_3_0.name_ = arg_3_0:FindCom(typeof(Text), "name")
	arg_3_0.num_ = arg_3_0:FindCom(typeof(Text), "num")
	arg_3_0.select_ = arg_3_0:FindGo("select")
	arg_3_0.maskGo_ = arg_3_0:FindGo("mask")

	arg_3_0:AddBtnListener(nil, nil, "OnClick")
end

function var_0_0.Init(arg_4_0)
	arg_4_0:RefreshUI(arg_4_0.info_)
end

function var_0_0.Render(arg_5_0)
	arg_5_0:RefreshUI(arg_5_0.info_)
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1)
	if arg_6_1 and arg_6_1.id ~= 0 then
		local var_6_0 = EquipSuitCfg[arg_6_1.id]

		SetSpriteWithoutAtlasAsync(arg_6_0.icon_, SpritePathCfg.EquipIcon_s.path .. var_6_0.equip_skill_icon)

		arg_6_0.name_.text = GetI18NText(var_6_0.name)
	end
end

function var_0_0.RefreshPos(arg_7_0, arg_7_1)
	arg_7_0:SetBottomText(var_0_2.GetSuitEquipNum(arg_7_0.info_.id, nil, arg_7_1))
end

function var_0_0.UpdateNum(arg_8_0)
	arg_8_0:SetBottomText(var_0_2.GetSuitEquipNum(arg_8_0.info_.id))
end

function var_0_0.SetBottomText(arg_9_0, arg_9_1)
	arg_9_0.num_.text = arg_9_1

	if arg_9_0.maskGo_ then
		SetActive(arg_9_0.maskGo_, arg_9_1 == 0)
	end
end

function var_0_0.SetIndex(arg_10_0, arg_10_1)
	arg_10_0.transform_:SetSiblingIndex(arg_10_1)
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:RemoveAllListeners()

	arg_11_0.info_ = nil
	arg_11_0.clickFunc = nil

	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.OnClick(arg_12_0)
	if arg_12_0.clickFunc then
		arg_12_0.clickFunc(arg_12_0.info_)
	end
end

function var_0_0.ShowSelect(arg_13_0, arg_13_1)
	if arg_13_0.select_ then
		SetActive(arg_13_0.select_, arg_13_1)
	end
end

function var_0_0.RegistCallBack(arg_14_0, arg_14_1)
	arg_14_0.clickFunc = arg_14_1
end

function var_0_0.GetItemInfo(arg_15_0)
	return arg_15_0.info_
end

function var_0_0.Show(arg_16_0, arg_16_1)
	SetActive(arg_16_0.gameObject_, arg_16_1)
end

return var_0_0
