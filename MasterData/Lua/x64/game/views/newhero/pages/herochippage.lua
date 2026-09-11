local HeroChipPage = class("HeroChipPage", (import("game.views.newHero.HeroPageBase")))

function HeroChipPage:OnCtor(arg_1_1, arg_1_2)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform
	self.chipCout_ = 4

	self:Init()
end

function HeroChipPage:Init()
	self:InitUI()
	self:AddUIListener()

	self.isSelfController_ = self.controller_:GetController("isSelf")
end

function HeroChipPage:InitUI()
	self:BindCfgUI()

	self.chipItem_ = {}

	for iter_3_0 = 1, self.chipCout_ do
		self.chipItem_[iter_3_0] = NewHeroChipPageItem.New((Object.Instantiate(self.chipItemGo_, self.chipContent_, false)))
	end
end

function HeroChipPage:AddUIListener()
	return
end

function HeroChipPage:OnEnter(arg_5_1)
	self.heroViewProxy_ = arg_5_1
end

function HeroChipPage:CameraEnter()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		6,
		0
	})
end

function HeroChipPage:UpdateView()
	if ChipTools.GetHeroChipIDList(self.heroInfo_.id) then
		local var_7_0 = self:GetChipIDList()

		if not var_7_0 then
			return
		end

		local var_7_2 = {}

		for iter_7_0, iter_7_1 in pairs(ChipTools.GetHeroChipIDList(self.heroInfo_.id)) do
			var_7_2[ChipCfg[iter_7_1].role_type_id] = true
		end

		for iter_7_2 = 1, 4 do
			self.chipItem_[iter_7_2]:SetData(var_7_0[iter_7_2], self.heroInfo_.id, iter_7_2, self.extra_)
			self.chipItem_[iter_7_2]:BindRedPoint()

			if var_7_2[iter_7_2] then
				self.chipItem_[iter_7_2]:SetIsShow(true)
			else
				self.chipItem_[iter_7_2]:SetIsShow(false)
			end
		end

		LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrans_)
		self:CheckLocked()
	end
end

function HeroChipPage:GetChipIDList()
	return ChipData:GetEnableHeroChipIdByHeroId(self.heroInfo_.id)
end

function HeroChipPage:CheckLocked()
	self.isSelfController_:SetSelectedState(self.heroViewProxy_.isSelf and "true" or "false")
end

function HeroChipPage:OnExit()
	for iter_10_0 = 1, 4 do
		self.chipItem_[iter_10_0]:UnBindRedPoint()
	end
end

function HeroChipPage:SetHeroInfo(arg_11_1)
	self.heroInfo_ = arg_11_1
end

function HeroChipPage:Show()
	HeroChipPage.super.Show(self)
	self:UpdateView()
end

function HeroChipPage:Dispose()
	HeroChipPage.super.Dispose(self)

	for iter_13_0, iter_13_1 in pairs(self.chipItem_) do
		iter_13_1:UnBindRedPoint()
		iter_13_1:Dispose()
	end

	self.chipItem_ = nil
end

return HeroChipPage
