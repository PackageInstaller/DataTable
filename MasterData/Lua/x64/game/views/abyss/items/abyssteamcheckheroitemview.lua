local AbyssTeamCheckHeroItemView = class("AbyssTeamCheckHeroItemView", ReduxView)

function AbyssTeamCheckHeroItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function AbyssTeamCheckHeroItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AbyssTeamCheckHeroItemView:InitUI()
	self:BindCfgUI()
end

function AbyssTeamCheckHeroItemView:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		return
	end)
end

function AbyssTeamCheckHeroItemView:AddEventListeners()
	return
end

function AbyssTeamCheckHeroItemView:SetData(arg_7_1, arg_7_2, arg_7_3)
	self.index_ = arg_7_1
	self.userId_ = arg_7_2
	self.heroInfo_ = arg_7_3

	self:UpdateView()
end

function AbyssTeamCheckHeroItemView:UpdateView()
	self.icon_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroLittleIcon.path .. ((self.heroInfo_.skin_id == 0 or nil) and self.heroInfo_.hero_id))
end

function AbyssTeamCheckHeroItemView:OnEnter()
	self:AddEventListeners()
end

function AbyssTeamCheckHeroItemView:OnExit()
	self:RemoveAllEventListener()
end

function AbyssTeamCheckHeroItemView:OnMainHomeViewTop()
	return
end

function AbyssTeamCheckHeroItemView:Dispose()
	self.data_ = nil

	AbyssTeamCheckHeroItemView.super.Dispose(self)
end

return AbyssTeamCheckHeroItemView
