local var_0_0 = class("HellaPinballSkillItem", BaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.iconController_ = arg_2_0.controllerEx_:GetController("icon")
	arg_2_0.btnController_ = arg_2_0.controllerEx_:GetController("btn")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.equipBtn_, nil, function()
		PinballAction.EquipSkill(arg_3_0.id_)
		saveData("PinballGame", "newSkillClicked" .. arg_3_0.id_, true)
		PinballAction.UpdateStageRedPoint()
	end)
	arg_3_0:AddBtnListener(arg_3_0.removeBtn_, nil, function()
		PinballAction.UnEquipSkill(arg_3_0.id_)
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.index_ = arg_6_1
	arg_6_0.id_ = arg_6_2

	arg_6_0:UpdateData()
	arg_6_0:RefreshUI()
end

function var_0_0.UpdateData(arg_7_0)
	arg_7_0.isEquiped_ = PinballData:IsSkillEquiped(arg_7_0.id_)
	arg_7_0.isLock_ = PinballData:IsSkillLocked(arg_7_0.id_)
	arg_7_0.isNew_ = PinballData:IsSkillNew(arg_7_0.id_)
	arg_7_0.equipNum_ = #PinballData:GetEquipedActiveSkill(arg_7_0.id_)
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = PinballSkillCfg[arg_8_0.id_]

	if var_8_0 then
		arg_8_0.desc_.text = string.format(GetI18NText(var_8_0.description), unpack(var_8_0.effect))
		arg_8_0.name_.text = GetI18NText(var_8_0.name) or ""
		arg_8_0.icon_.sprite = pureGetSpriteWithoutAtlas(var_8_0.icon)
	end

	if arg_8_0.isEquiped_ then
		arg_8_0.iconController_:SetSelectedState("equiped")
		arg_8_0.btnController_:SetSelectedState("remove")
	elseif arg_8_0.isLock_ then
		arg_8_0.iconController_:SetSelectedState("lock")
		arg_8_0.btnController_:SetSelectedState("lock")

		arg_8_0.lockText_.text = string.format(GetTips("HELLA_PINBALL_SKILL_LOCK_LEVEL"), PinballData:GetSkillUnlockLevel(arg_8_0.id_))
	elseif arg_8_0.isNew_ then
		arg_8_0.iconController_:SetSelectedState("new")

		if arg_8_0.equipNum_ >= 2 then
			arg_8_0.btnController_:SetSelectedState("grey")
		else
			arg_8_0.btnController_:SetSelectedState("equip")
		end
	else
		arg_8_0.iconController_:SetSelectedState("normal")

		if arg_8_0.equipNum_ >= 2 then
			arg_8_0.btnController_:SetSelectedState("grey")
		else
			arg_8_0.btnController_:SetSelectedState("equip")
		end
	end
end

return var_0_0
