local PolyhedronLeaderView = class("PolyhedronLeaderView", ReduxView)

function PolyhedronLeaderView:UIName()
	return "Widget/System/Polyhedron/PolyhedronLeaderUI"
end

function PolyhedronLeaderView:UIParent()
	return manager.ui.uiMain.transform
end

function PolyhedronLeaderView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PolyhedronLeaderView:InitUI()
	self:BindCfgUI()

	self.leaderController = ControllerUtil.GetController(self.transform_, "leader")
	self.nextController = ControllerUtil.GetController(self.transform_, "next")
end

function PolyhedronLeaderView:AddUIListener()
	self:AddBtnListener(self.m_btn, nil, function()
		local var_6_0 = self.leader ~= 0 and {
			self.leader
		} or {}

		gameContext:Go("/heroTeamInfoPolyhedron", {
			selectHeroPos = 1,
			heroTeam = var_6_0,
			type = HeroConst.HERO_DATA_TYPE.POLYHEDRON
		})
	end)
	self:AddBtnListener(self.m_nextBtn, nil, function()
		if self.leader == 0 then
			return
		end

		JumpTools.OpenPageByJump("/polyhedronBeacon", {})
	end)
	self:AddBtnListener(self.m_backBtn, nil, function()
		self:Back()
	end)
end

function PolyhedronLeaderView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function PolyhedronLeaderView:OnEnter()
	self.leader = PolyhedronData:GetCacheSelectHero()

	if self.leader == 0 then
		self.leaderController:SetSelectedIndex(0)
		self.nextController:SetSelectedIndex(0)
	else
		self.leaderController:SetSelectedIndex(1)
		self.nextController:SetSelectedIndex(1)

		self.m_icon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. PolyhedronData:GetHeroUsingSkinInfo(self.leader).id)
		self.m_name.text = GetI18NText(HeroCfg[self.leader].name)
	end
end

function PolyhedronLeaderView:OnExit()
	manager.windowBar:HideBar()
end

function PolyhedronLeaderView:Dispose()
	PolyhedronLeaderView.super.Dispose(self)
end

return PolyhedronLeaderView
