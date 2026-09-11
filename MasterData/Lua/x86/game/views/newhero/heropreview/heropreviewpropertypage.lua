local HeroPreviewPropertyPage = class("HeroPreviewPropertyPage", HeroPageBase)

function HeroPreviewPropertyPage:OnCtor(arg_1_1, arg_1_2)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform

	self:Init()
end

function HeroPreviewPropertyPage:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroPreviewPropertyPage:InitUI()
	self:BindCfgUI()

	self.campController_ = ControllerUtil.GetController(self.infoViewGo_.transform, "camp")
	self.attackTypeController_ = ControllerUtil.GetController(self.gameObject_.transform, "attackType")
end

function HeroPreviewPropertyPage:AddUIListener()
	self:AddBtnListener(self.campBgBtn_, nil, function()
		JumpTools.OpenPageByJump("sectionSelectRaceDescription")
	end)
end

function HeroPreviewPropertyPage:SetHeroInfo(arg_6_1)
	self.heroInfo_ = HeroData:GetHeroData(arg_6_1.id)

	self:UpdateView()
end

function HeroPreviewPropertyPage:UpdateView()
	self.heroCfg_ = HeroCfg[self.heroInfo_.id]
	self.nameText_.text = GetI18NText(self.heroCfg_.name)
	self.subNameText_.text = GetI18NText(self.heroCfg_.suffix)
	self.friendlyDescText_.text = GetI18NText(self.heroCfg_.hero_desc)
	self.starImg_.sprite = getSprite("Atlas/Common", "star_" .. HeroStarCfg[self.heroCfg_.unlock_star].star)
	self.rangeTypeText_.text = CharactorParamCfg[self.heroInfo_.id].RangeType == 0 and GetTips("RANGETYPE_CLOSE") or GetTips("RANGETYPE_LONG")
	self.compatTypeText_.text = HeroTools.GetChargeTextByType(self.heroCfg_.mechanism_type[1])

	if #self.heroCfg_.ATK_attribute > 1 then
		self.attackTypeController_:SetSelectedState(-1)
	else
		self.attackTypeController_:SetSelectedState(self.heroCfg_.ATK_attribute[1])
	end

	self.campController_:SetSelectedState(tostring(self.heroCfg_.race))
end

function HeroPreviewPropertyPage:PlayEnterAni()
	self.playableDirector_ = self.playableDirector_ or self:FindCom(typeof(PlayableDirector), "panel")

	if self.playableDirector_ then
		self.playableDirector_.time = 0

		self.playableDirector_:Play()
	end
end

function HeroPreviewPropertyPage:OnEnter()
	return
end

function HeroPreviewPropertyPage:OnExit()
	return
end

function HeroPreviewPropertyPage:OnHeroModify(arg_11_1)
	if arg_11_1 == self.heroInfo_.id then
		self:UpdateView()
	end
end

function HeroPreviewPropertyPage:Dispose()
	self:RemoveAllListeners()

	if self.heroInfoView_ then
		self.heroInfoView_:Dispose()

		self.heroInfoView_ = nil
	end

	HeroPreviewPropertyPage.super.Dispose(self)
end

return HeroPreviewPropertyPage
