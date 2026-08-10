local var_0_0 = class("NewComboSkillItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUi()
end

function var_0_0.InitUi(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.jumpController = arg_2_0.controllerexcollection_:GetController("jump")

	arg_2_0:AddBtnListener(nil, arg_2_0.m_jumpBtn, function()
		JumpTools.OpenPageByJump("/heroTrammels", {
			page = 1,
			heroId = arg_2_0.heroId,
			comboId = arg_2_0.comboId
		})
	end)
	TerminologyTools.AddTerminologyHandler(arg_2_0, arg_2_0.textDesc_, nil, nil)
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.heroId = arg_4_2
	arg_4_0.comboId = arg_4_1

	local var_4_0 = ComboSkillCfg[arg_4_1]
	local var_4_1 = HeroSkillCfg[var_4_0.skill_id]
	local var_4_2 = ComboSkillData:GetCurComboSkillLevel(arg_4_1)

	arg_4_0.textLv_.text = GetTips("LEVEL") .. string.format("%s", var_4_2)
	arg_4_0.textTitle_.text = GetI18NText(var_4_1.name)
	arg_4_0.textDesc_.text = GetI18NText(GetCfgDescription(var_4_1.desc[1], var_4_2, 2, var_4_0.maxLevel))
	arg_4_0.imageIcon_.sprite = getSpriteViaConfig("ComboSkill", var_4_0.skill_id)

	local var_4_3 = deepClone(var_4_0.cooperate_role_ids)

	CommonTools.UniversalSortEx(var_4_3, {
		map = function(arg_5_0)
			return arg_5_0
		end
	})

	for iter_4_0, iter_4_1 in ipairs(var_4_3) do
		SetActive(arg_4_0[string.format("roleitem%sGo_", iter_4_0)], true)

		arg_4_0[string.format("iconImg%s_", iter_4_0)].sprite = getSpriteViaConfig("HeroItemshead", iter_4_1)
	end

	for iter_4_2 = #var_4_0.cooperate_role_ids + 1, 3 do
		SetActive(arg_4_0[string.format("roleitem%sGo_", iter_4_2)], false)
	end

	if ArchiveData:GetTrustLevel(arg_4_0.heroId) == 0 then
		arg_4_0.jumpController:SetSelectedIndex(0)
	else
		arg_4_0.jumpController:SetSelectedIndex(1)
	end
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
