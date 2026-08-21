local var_0_0 = class("HeroTrammelsComboItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.combRoleNumController = ControllerUtil.GetController(arg_3_0.transform_, "combRoleNum")
	arg_3_0.stateController = ControllerUtil.GetController(arg_3_0.transform_, "state")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(nil, arg_4_0.m_btn, function()
		if arg_4_0.callback_ then
			arg_4_0.callback_(arg_4_0.comboId)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.comboId = arg_6_1

	arg_6_0:Refresh()
	arg_6_0:RefreshRedPoint()
end

function var_0_0.Refresh(arg_7_0)
	local var_7_0 = ComboSkillData:GetCurComboSkillLevel(arg_7_0.comboId)
	local var_7_1 = ComboSkillCfg[arg_7_0.comboId]
	local var_7_2 = HeroSkillCfg[var_7_1.skill_id]

	arg_7_0.m_skillLevel.text = GetTips("LEVEL") .. var_7_0
	arg_7_0.m_comboName.text = var_7_2.name
	arg_7_0.m_icon.sprite = getSpriteViaConfig("ComboSkill", var_7_1.skill_id)

	local var_7_3 = deepClone(var_7_1.cooperate_role_ids)

	CommonTools.UniversalSortEx(var_7_3, {
		ascend = true,
		map = function(arg_8_0)
			return arg_8_0
		end
	})

	for iter_7_0, iter_7_1 in ipairs(var_7_3) do
		arg_7_0["m_comboHead" .. iter_7_0].sprite = getSpriteViaConfig("HeroLittleIcon", iter_7_1)
	end

	arg_7_0.combRoleNumController:SetSelectedIndex(#var_7_1.cooperate_role_ids)
end

function var_0_0.RefreshRedPoint(arg_9_0)
	local var_9_0 = ComboSkillTools.GetMaxComboSkillLevel(arg_9_0.comboId)
	local var_9_1 = ComboSkillData:GetCurComboSkillLevel(arg_9_0.comboId)

	if var_9_1 < var_9_0 then
		local var_9_2 = ComboSkillLevelCfg.get_id_list_by_level[var_9_1]
		local var_9_3 = true

		for iter_9_0, iter_9_1 in ipairs(var_9_2) do
			if not ComboSkillTools.CheckComboSkillUpContion(iter_9_1, arg_9_0.comboId) then
				var_9_3 = false

				break
			end
		end

		if var_9_3 then
			manager.redPoint:SetRedPointIndependent(arg_9_0.transform_, true)
		else
			manager.redPoint:SetRedPointIndependent(arg_9_0.transform_, false)
		end
	else
		manager.redPoint:SetRedPointIndependent(arg_9_0.transform_, false)
	end
end

function var_0_0.RefreshState(arg_10_0, arg_10_1)
	arg_10_0.stateController:SetSelectedIndex(arg_10_1 == arg_10_0.comboId and 1 or 0)
end

function var_0_0.SetActive(arg_11_0, arg_11_1)
	SetActive(arg_11_0.gameObject_, arg_11_1)

	if not arg_11_1 then
		arg_11_0.comboId = 0
	end
end

function var_0_0.RegistCallBack(arg_12_0, arg_12_1)
	arg_12_0.callback_ = arg_12_1
end

function var_0_0.GetComboId(arg_13_0)
	return arg_13_0.comboId
end

function var_0_0.Dispose(arg_14_0)
	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
