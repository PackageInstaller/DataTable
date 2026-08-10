local var_0_0 = class("PolyhedronSetAstrolabeItem", ReduxView)

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
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	local var_5_0 = HeroAstrolabeCfg[arg_5_1]
	local var_5_1 = var_5_0.hero_astrolabe_suit_id % 10

	if var_5_1 == 1 then
		arg_5_0.m_astrolabeIcon.sprite = getSprite("Atlas/Polyhedron_BattleAtlas", "PolyhedronBattle_00097")
	elseif var_5_1 == 2 then
		arg_5_0.m_astrolabeIcon.sprite = getSprite("Atlas/Polyhedron_BattleAtlas", "PolyhedronBattle_00098")
	else
		arg_5_0.m_astrolabeIcon.sprite = getSprite("Atlas/Polyhedron_BattleAtlas", "PolyhedronBattle_00096")
	end

	local var_5_2 = AstrolabeEffectCfg[arg_5_1].desc[1]
	local var_5_3 = GetCfgDescription(var_5_2, 1)

	arg_5_0.m_name.text = var_5_0.name
	arg_5_0.m_des.text = var_5_3

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_5_0.m_des.transform)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_5_0.transform_)
end

function var_0_0.SetActive(arg_6_0, arg_6_1)
	SetActive(arg_6_0.gameObject_, arg_6_1)
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
