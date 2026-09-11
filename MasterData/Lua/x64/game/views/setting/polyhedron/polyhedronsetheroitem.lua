local PolyhedronSetHeroItem = class("PolyhedronSetHeroItem", ReduxView)

function PolyhedronSetHeroItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function PolyhedronSetHeroItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function PolyhedronSetHeroItem:InitUI()
	self:BindCfgUI()

	self.leaderController = ControllerUtil.GetController(self.transform_, "leader")
end

function PolyhedronSetHeroItem:AddUIListener()
	self:AddBtnListener(self.m_btn, nil, function()
		if self.clickFunc then
			self.clickFunc(self.id)
		end
	end)
end

function PolyhedronSetHeroItem:SetData(arg_6_1, arg_6_2)
	self.id = arg_6_2

	local var_6_0 = HeroCfg[arg_6_2]

	self.n_name.text = HeroCfg[arg_6_2].name
	self.m_suffix.text = var_6_0.suffix

	local var_6_1 = PolyhedronData:GetHeroUsingSkinInfo(arg_6_2).id

	if arg_6_2 == arg_6_1:GetLeaderHeroId() then
		self.leaderController:SetSelectedIndex(1)
	else
		self.leaderController:SetSelectedIndex(0)
	end

	self.m_icon.sprite = HeroTools.GetHeadSprite(var_6_1)
	self.m_campImg.sprite = getSprite("Atlas/CampItemAtlas", RaceEffectCfg[var_6_0.race].icon)
end

function PolyhedronSetHeroItem:RegistCallBack(arg_7_1)
	self.clickFunc = arg_7_1
end

function PolyhedronSetHeroItem:Dispose()
	PolyhedronSetHeroItem.super.Dispose(self)
end

return PolyhedronSetHeroItem
