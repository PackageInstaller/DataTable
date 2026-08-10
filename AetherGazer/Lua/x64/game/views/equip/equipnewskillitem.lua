local var_0_0 = class("EquipNewSkillItem", ReduxView)
local var_0_1 = import("game.tools.EquipTools")

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
	arg_1_0:Init()
end

function var_0_0.SetIsEnchant(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.isEnchant_ = true
	arg_2_0.index_ = arg_2_1
end

function var_0_0.SetLockStatus(arg_3_0, arg_3_1)
	return
end

function var_0_0.RefreshData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.info_ = arg_4_1
	arg_4_0.isShowMax_ = arg_4_2

	arg_4_0:Render()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
	arg_5_0:AddBtnListener(nil, nil, "OnClick")

	arg_5_0.selectController_ = arg_5_0.skillCon_:GetController("select")
	arg_5_0.lockController_ = arg_5_0.skillCon_:GetController("lock")
end

function var_0_0.Render(arg_6_0)
	arg_6_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_7_0)
	if arg_7_0.info_ then
		local var_7_0 = EquipSkillCfg[arg_7_0.info_.id]

		arg_7_0.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Equip/EquipSkillIcon/" .. var_7_0.icon)
		arg_7_0.name_.text = GetI18NText(var_7_0.name)

		local var_7_1 = arg_7_0.info_.num > var_7_0.lvmax and var_7_0.lvmax or arg_7_0.info_.num
		local var_7_2 = arg_7_0.info_.num > var_7_0.lvmax and string.format("<color=#FF000B>%s</color>", arg_7_0.info_.num) or arg_7_0.info_.num

		arg_7_0.lv_.text = arg_7_0.isShowMax_ and string.format("%s/%s", var_7_2, var_7_0.lvmax) or GetTips("LEVEL") .. var_7_1

		local var_7_3 = arg_7_0.info_.unlockLevel or 0

		if arg_7_0.info_.level and var_7_3 > arg_7_0.info_.level then
			arg_7_0.unlockLv_.text = string.format(GetTips("EQUIP_SKILL_LOCK_LEVEL"), arg_7_0.info_.unlockLevel)

			arg_7_0.lockController_:SetSelectedState("lock")
		else
			arg_7_0.lockController_:SetSelectedState("unlock")
		end
	end
end

function var_0_0.ShowSelect(arg_8_0, arg_8_1)
	arg_8_0.selectController_:SetSelectedState(arg_8_1 and "select" or "unSelect")
end

function var_0_0.OnClick(arg_9_0)
	if arg_9_0.clickFunc then
		arg_9_0.clickFunc(arg_9_0.info_)
	end
end

function var_0_0.RegistCallBack(arg_10_0, arg_10_1)
	arg_10_0.clickFunc = arg_10_1
end

function var_0_0.GetItemInfo(arg_11_0)
	return arg_11_0.info_
end

function var_0_0.Show(arg_12_0, arg_12_1)
	SetActive(arg_12_0.gameObject_, arg_12_1)
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.clickFunc = nil

	arg_13_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
