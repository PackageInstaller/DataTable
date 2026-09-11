local RogueTeamSetAstrolabeItem = class("RogueTeamSetAstrolabeItem", ReduxView)

function RogueTeamSetAstrolabeItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function RogueTeamSetAstrolabeItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function RogueTeamSetAstrolabeItem:InitUI()
	self:BindCfgUI()
end

function RogueTeamSetAstrolabeItem:AddUIListener()
	return
end

function RogueTeamSetAstrolabeItem:SetData(arg_5_1, arg_5_2, arg_5_3)
	if arg_5_3 == 0 then
		self.heroViewProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.CHALLENGEROUGETEAM)
	else
		self.heroViewProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.TRIAL)

		self.heroViewProxy_:SetTempHeroList({
			arg_5_3
		})
	end

	local var_5_0 = HeroAstrolabeCfg[arg_5_1]

	self.m_astrolabeIcon.sprite = HeroAstrolabeCfg[arg_5_1].hero_astrolabe_suit_id % 10 == 1 and getSprite("Atlas/Polyhedron_BattleAtlas", "PolyhedronBattle_00097") or HeroAstrolabeCfg[arg_5_1].hero_astrolabe_suit_id % 10 == 2 and getSprite("Atlas/Polyhedron_BattleAtlas", "PolyhedronBattle_00098") or getSprite("Atlas/Polyhedron_BattleAtlas", "PolyhedronBattle_00096")
	self.m_name.text = var_5_0.name
	self.m_des.text = self.heroViewProxy_:GetAstrolabeDesc(arg_5_1, arg_5_2)

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_des.transform)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
end

function RogueTeamSetAstrolabeItem:SetActive(arg_6_1)
	SetActive(self.gameObject_, arg_6_1)
end

function RogueTeamSetAstrolabeItem:Dispose()
	RogueTeamSetAstrolabeItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

return RogueTeamSetAstrolabeItem
