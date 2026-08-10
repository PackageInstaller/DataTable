local var_0_0 = class("HellaPinballSkillItem", BaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.levelController_ = arg_2_0.controllerEx_:GetController("level")
	arg_2_0.lockController_ = arg_2_0.controllerEx_:GetController("lock")
	arg_2_0.tipsController_ = arg_2_0.controllerEx_:GetController("tips")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		arg_3_0.tipsController_:SetSelectedState("on")

		if arg_3_0.clickCallBack_ then
			arg_3_0.clickCallBack_(arg_3_0.index_)
		end
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.index_ = arg_5_1
	arg_5_0.id_ = arg_5_2
	arg_5_0.isEquiped_ = PinballData:IsSkillEquiped(arg_5_0.id_)
	arg_5_0.isLock_ = PinballData:IsSkillLocked(arg_5_0.id_)
	arg_5_0.isNew_ = PinballData:IsSkillNew(arg_5_0.id_)

	arg_5_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_6_0)
	local var_6_0 = PinballSkillCfg[arg_6_0.id_]

	if var_6_0 then
		arg_6_0.descText_.text = string.format(GetI18NText(var_6_0.description), unpack(var_6_0.effect))
		arg_6_0.icon_.sprite = pureGetSpriteWithoutAtlas(var_6_0.icon)
		arg_6_0.nameText_.text = var_6_0.name
		arg_6_0.levelText_.text = string.format(GetTips("PINBALLGAME_GAME_SKILL_LEVEL"), table.indexof(PinballSkillCfg.get_id_list_by_skill_group[var_6_0.skill_group], arg_6_0.id_))

		arg_6_0.levelController_:SetSelectedState("lv" .. table.indexof(PinballSkillCfg.get_id_list_by_skill_group[var_6_0.skill_group], arg_6_0.id_))
		arg_6_0.lockController_:SetSelectedState(arg_6_0.isLock_ and "on" or "off")

		arg_6_0.lockText_.text = string.format(GetTips("HELLA_PINBALL_SKILL_LOCK_LEVEL"), PinballData:GetSkillUnlockLevel(arg_6_0.id_))
	end
end

function var_0_0.SetSelectedState(arg_7_0, arg_7_1)
	arg_7_0.tipsController_:SetSelectedState(arg_7_1)
end

function var_0_0.SetClickCallBack(arg_8_0, arg_8_1)
	arg_8_0.clickCallBack_ = arg_8_1
end

return var_0_0
