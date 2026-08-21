local var_0_0 = class("MonsterCosplaySkillUpItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	arg_3_0.affixCfg = TalentTreeCfg[arg_3_1]
	arg_3_0.cfg = ActivityMonsterCosplaySkillCfg[arg_3_0.affixCfg.stage]
	arg_3_0.index = arg_3_3
	arg_3_0.callBack = arg_3_2
	arg_3_0.monsterData = arg_3_4
	arg_3_0.monsterID = arg_3_5

	arg_3_0:UpdateView()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.stateController = arg_4_0.controller_:GetController("state")
	arg_4_0.placeController = arg_4_0.controller_:GetController("place")
	arg_4_0.colorController = arg_4_0.controller_:GetController("state2")
	arg_4_0.color2Controller = arg_4_0.controller_:GetController("state3")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.selectBtn_, nil, function()
		if arg_5_0.callBack then
			arg_5_0.callBack(arg_5_0.index, arg_5_0.stateController)
		end
	end)
end

function var_0_0.UpdateView(arg_7_0)
	arg_7_0.nameTxt_.text = GetI18NText(arg_7_0.affixCfg.name)
	arg_7_0.skillIcon_.sprite = MonsterCosplayData.GetAffixSprite(arg_7_0.affixCfg.id)
	arg_7_0.descTxt_.text = GetI18NText(arg_7_0.affixCfg.desc)
	arg_7_0.skillIndexTxt_.text = GetI18NText(arg_7_0.cfg.skill_index)
	arg_7_0.skillIndexTxt2_.text = GetI18NText(arg_7_0.cfg.skill_index)

	arg_7_0.placeController:SetSelectedState(tostring(table.indexof(ActivityMonsterCosplayCfg[arg_7_0.monsterID].skill_list, arg_7_0.cfg.id)))
	arg_7_0.stateController:SetSelectedState(arg_7_0.monsterData.enhancedSkill[arg_7_0.affixCfg.id] and "get" or "normal")
	arg_7_0.colorController:SetSelectedState(arg_7_0.monsterID == ActivityMonsterCosplayCfg.all[1] and "1" or "2")
	arg_7_0.color2Controller:SetSelectedState(arg_7_0.monsterID == ActivityMonsterCosplayCfg.all[1] and "1" or "2")
end

function var_0_0.OnExit(arg_8_0)
	return
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
