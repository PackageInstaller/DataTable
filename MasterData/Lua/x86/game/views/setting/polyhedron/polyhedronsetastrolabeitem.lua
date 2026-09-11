local PolyhedronSetAstrolabeItem = class("PolyhedronSetAstrolabeItem", ReduxView)

function PolyhedronSetAstrolabeItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function PolyhedronSetAstrolabeItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function PolyhedronSetAstrolabeItem:InitUI()
	self:BindCfgUI()
end

function PolyhedronSetAstrolabeItem:AddUIListener()
	return
end

function PolyhedronSetAstrolabeItem:SetData(arg_5_1)
	local var_5_0 = HeroAstrolabeCfg[arg_5_1]

	self.m_astrolabeIcon.sprite = HeroAstrolabeCfg[arg_5_1].hero_astrolabe_suit_id % 10 == 1 and getSprite("Atlas/Polyhedron_BattleAtlas", "PolyhedronBattle_00097") or HeroAstrolabeCfg[arg_5_1].hero_astrolabe_suit_id % 10 == 2 and getSprite("Atlas/Polyhedron_BattleAtlas", "PolyhedronBattle_00098") or getSprite("Atlas/Polyhedron_BattleAtlas", "PolyhedronBattle_00096")
	self.m_name.text = var_5_0.name
	self.m_des.text = GetCfgDescription(AstrolabeEffectCfg[arg_5_1].desc[1], 1)

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_des.transform)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
end

function PolyhedronSetAstrolabeItem:SetActive(arg_6_1)
	SetActive(self.gameObject_, arg_6_1)
end

function PolyhedronSetAstrolabeItem:Dispose()
	PolyhedronSetAstrolabeItem.super.Dispose(self)
end

return PolyhedronSetAstrolabeItem
