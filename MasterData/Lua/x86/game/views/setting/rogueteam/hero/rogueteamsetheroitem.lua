local RogueTeamSetHeroItem = class("RogueTeamSetHeroItem", ReduxView)

function RogueTeamSetHeroItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function RogueTeamSetHeroItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function RogueTeamSetHeroItem:InitUI()
	self:BindCfgUI()

	self.leaderController = ControllerUtil.GetController(self.transform_, "leader")
end

function RogueTeamSetHeroItem:AddUIListener()
	self:AddBtnListener(self.m_btn, nil, function()
		if self.clickFunc then
			self.clickFunc(self.index_)
		end
	end)
end

function RogueTeamSetHeroItem:SetData(arg_6_1, arg_6_2, arg_6_3)
	self.index_ = arg_6_3
	self.id = arg_6_1

	local var_6_0 = HeroCfg[arg_6_1]

	self.n_name.text = HeroCfg[arg_6_1].name
	self.m_suffix.text = var_6_0.suffix

	local var_6_1 = arg_6_1

	var_6_1 = arg_6_2 ~= 0 and HeroStandardSystemCfg[arg_6_2].skin_id or ChallengeRogueTeamData:GetHeroUsingSkinInfo(arg_6_1).id

	if arg_6_3 == 1 then
		self.leaderController:SetSelectedIndex(1)
	else
		self.leaderController:SetSelectedIndex(0)
	end

	self.m_icon.sprite = HeroTools.GetHeadSprite(var_6_1)
	self.m_campImg.sprite = getSprite("Atlas/CampItemAtlas", RaceEffectCfg[var_6_0.race].icon)
end

function RogueTeamSetHeroItem:RegistCallBack(arg_7_1)
	self.clickFunc = arg_7_1
end

function RogueTeamSetHeroItem:Dispose()
	RogueTeamSetHeroItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

return RogueTeamSetHeroItem
