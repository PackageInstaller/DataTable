local var_0_0 = class("HeroTransitionItem", ReduxView)

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
end

function var_0_0.AddUIListener(arg_4_0)
	TerminologyTools.AddTerminologyHandler(arg_4_0, arg_4_0.descText_, nil, nil)
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.data_ = arg_5_1
	arg_5_0.cfg_ = EquipSkillCfg[arg_5_1.skill_id or arg_5_1.skillId]
	arg_5_0.level_ = arg_5_1.skill_level or arg_5_1.level

	arg_5_0:UpdateView()
end

function var_0_0.UpdateView(arg_6_0)
	arg_6_0.nameText_.text = arg_6_0.cfg_.name
	arg_6_0.descText_.text = arg_6_0:GetDesc()
	arg_6_0.iconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Equip/EquipSkillIcon/" .. arg_6_0.cfg_.icon or "")
	arg_6_0.levelText_.text = GetTips("LEVEL") .. arg_6_0.level_
end

function var_0_0.GetDesc(arg_7_0)
	local var_7_0 = arg_7_0.data_.skill_id or arg_7_0.data_.skillId

	return EquipTools.GetSkillDescWithoutHero(var_7_0, arg_7_0.level_, true)
end

function var_0_0.OnExit(arg_8_0)
	return
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
