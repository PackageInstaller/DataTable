local HeroFileInformationPage = class("HeroFileInformationPage", ReduxView)

function HeroFileInformationPage:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function HeroFileInformationPage:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroFileInformationPage:InitUI()
	self:BindCfgUI()

	self.curHeroID_ = 0
	self.curRecordID_ = 0
	self.relationNetController_ = self.rightControllerEx_:GetController("relationNet")
end

function HeroFileInformationPage:AddUIListener()
	self:AddBtnListener(self.relationBtn_, nil, function()
		if ArchiveData:GetTrustLevel(self.curHeroID_) == 0 then
			ShowTips("HERO_RELATION_UNLOCK_TRUST")

			return
		end

		JumpTools.OpenPageByJump("/heroTrammels", {
			heroId = self.curHeroID_
		})
	end)
end

function HeroFileInformationPage:Show(arg_6_1, arg_6_2)
	self:UpdateView(arg_6_1, arg_6_2)
	SetActive(self.gameObject_, true)
end

function HeroFileInformationPage:UpdateView(arg_7_1, arg_7_2)
	if arg_7_2 ~= self.curHeroID_ then
		self.lableText_.text = GetI18NText(HeroCfg[arg_7_2].name)
		self.summaryText_.text = GetI18NText(HeroCfg[arg_7_2].hero_desc)

		if HeroRelationNetCfg.get_id_list_by_hero_id[arg_7_2] then
			self.relationNetController_:SetSelectedState("unlock")
		else
			self.relationNetController_:SetSelectedState("lock")
		end

		self.curHeroID_ = arg_7_2
	end

	if arg_7_1 ~= self.curRecordID_ then
		self.nameText_.text = GetI18NText(HeroRecordCfg[arg_7_1].name)
		self.heightText_.text = GetI18NText(HeroRecordCfg[arg_7_1].height)
		self.weightText_.text = GetI18NText(HeroRecordCfg[arg_7_1].weight)
		self.birthdayText_.text = GetI18NText(HeroRecordCfg[arg_7_1].birthday)
		self.organizationText_.text = GetI18NText(HeroRecordCfg[arg_7_1].organization)
		self.hobbyText_.text = GetI18NText(HeroRecordCfg[arg_7_1].like)
		self.curRecordID_ = arg_7_1
	end

	self:UpdateAdult()
	manager.redPoint:bindUIandKey(self.relationBtn_.transform, string.format("%s_%s", RedPointConst.HERO_REALTION, self.curHeroID_))
end

function HeroFileInformationPage:UpdateAdult()
	SetActive(self.adultMarkGo_, HeroTools.IsNeedDisplayAdult(self.curHeroID_))
end

function HeroFileInformationPage:Hide()
	manager.redPoint:unbindUIandKey(self.relationBtn_.transform)
	SetActive(self.gameObject_, false)
end

function HeroFileInformationPage:Dispose()
	HeroFileInformationPage.super.Dispose(self)
end

return HeroFileInformationPage
