local HeroSkillPage = class("HeroSkillPage", (import("game.views.newHero.HeroPageBase")))

function HeroSkillPage:OnCtor(arg_1_1, arg_1_2)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform

	self:Init()
end

function HeroSkillPage:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroSkillPage:InitUI()
	self:BindCfgUI()

	self.skillItemGo_ = {}
	self.skillItem_ = {}

	for iter_3_0 = 1, 6 do
		self.skillItemGo_[iter_3_0] = self["skillItem" .. iter_3_0 .. "Go_"]
		self.skillItem_[iter_3_0] = HeroSkillViewItem.New(self, self.skillItemGo_[iter_3_0])

		if iter_3_0 == 6 then
			self.skillItem_[iter_3_0]:SetAniState(false)
			self.skillItem_[iter_3_0]:SetShowAdd(false)
		end
	end

	self.skillitem6Ani_.enabled = false
	self.comboskillAni_.enabled = false
end

function HeroSkillPage:AddUIListener()
	for iter_4_0 = 1, 6 do
		self.skillItem_[iter_4_0]:RegistCallBack(function(arg_5_0)
			self:Go("/skillView", {
				skillId = arg_5_0.id,
				heroInfo = self.heroInfo_,
				proxy = self.heroViewProxy_,
				aniEndPos = self.skillTrs_.position
			})
		end)
	end

	self:AddBtnListener(self.buttonComboSkill_, nil, function()
		JumpTools.OpenPageByJump("comboSkillInfo", {
			heroID = self.heroInfo_.id
		})
	end)
	self:AddBtnListener(self.teachingBtn_, nil, function()
		BattleTeachData:SetCacheTeachHeroID(self.heroInfo_.id)

		if HeroCfg[self.heroInfo_.id] and HeroCfg[self.heroInfo_.id].study_stage and HeroCfg[self.heroInfo_.id].study_stage[1] then
			JumpTools.OpenPageByJump("/teachStage", {
				switchType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING,
				heroID = self.heroInfo_.id
			})
			JumpTools.OpenPageByJump("teachSectionInfo", {
				sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING,
				section = HeroCfg[self.heroInfo_.id].study_stage[1]
			})
		end
	end)
end

function HeroSkillPage:SetHeroInfo(arg_8_1)
	self.heroInfo_ = arg_8_1
end

function HeroSkillPage:UpdateView()
	self:RefreshSkillItemS()
	self:RefreshTeachRedPoint()
	self:RefreshComboSkillBtn()
end

function HeroSkillPage:RefreshSkillItemS()
	if not self.heroInfo_ then
		return
	end

	self.skillList_ = self.heroViewProxy_:GetHeroSkillInfo(self.heroInfo_.id)

	for iter_10_0 = 1, 6 do
		self.skillItem_[iter_10_0]:RefreshData(self.skillList_[iter_10_0])
	end
end

function HeroSkillPage:RefreshTeachRedPoint()
	manager.redPoint:setTip(RedPointConst.HERO_TEACH_ID, BattleTeachData:GetHeroTeachInfo(self.heroInfo_.id, HeroCfg[self.heroInfo_.id].study_stage[1]) <= 0 and not self.extra_ and 1 or 0)
end

function HeroSkillPage:RefreshComboSkillBtn()
	local var_12_0 = ComboSkillTools.GetHeroComboSkill(self.heroInfo_.id)

	if var_12_0 and #var_12_0 > 0 then
		SetActive(self.buttonComboSkill_.gameObject, true)
	else
		SetActive(self.buttonComboSkill_.gameObject, false)
	end
end

function HeroSkillPage:OnHeroSkillUpgrade(arg_13_1, arg_13_2)
	self:RefreshSkillItemS()
end

function HeroSkillPage:CameraEnter()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		2,
		0
	})
end

function HeroSkillPage:OnEnter(arg_15_1, arg_15_2)
	self.heroViewProxy_ = arg_15_1

	for iter_15_0 = 1, 6 do
		self.skillItem_[iter_15_0]:SetProxy(arg_15_1)
	end

	self.isSkillReturn = arg_15_2.isSkillReturn or false

	self:BindRedPointUI()
	self:AniUpdate()
end

function HeroSkillPage:AniUpdate()
	if self.isSkillReturn then
		self.skillAni_.enabled = false

		for iter_16_0 = 1, 5 do
			self.skillItem_[iter_16_0]:SetAniState(false)
		end

		self.handler_.params_.isSkillReturn = false
		self.isSkillReturn = false
	else
		if self.skillCxTimer then
			self.skillCxTimer:Stop()

			self.skillCxTimer = nil
		end

		self.skillAni_:Update(0.5)
		self.skillAni_:Play("Fx_skill_cx", 0, 0)
	end
end

function HeroSkillPage:Show()
	SetActive(self.gameObject_, true)

	self.skillitem6Ani_.enabled = false
	self.comboskillAni_.enabled = false

	if not self.isSkillReturn then
		self:AniUpdate()
	end

	self:RefreshSkillItemS()
	self:RefreshComboSkillBtn()
end

function HeroSkillPage:HideAni()
	self.skillAni_:Play("Fx_HeroSkillUI_change")

	self.skillAni_.enabled = true

	for iter_18_0 = 1, 5 do
		self.skillItem_[iter_18_0]:SetAniState(true)
	end
end

function HeroSkillPage:Hide()
	self:HideAni()
	SetActive(self.gameObject_, false)
end

function HeroSkillPage:BindRedPointUI()
	manager.redPoint:bindUIandKey(self.teachingBtn_.transform, RedPointConst.HERO_TEACH_ID)
end

function HeroSkillPage:OnExit()
	manager.redPoint:unbindUIandKey(self.teachingBtn_.transform, RedPointConst.HERO_TEACH_ID)
end

function HeroSkillPage:Dispose()
	for iter_22_0 = 1, 6 do
		self.skillItem_[iter_22_0]:Dispose()
	end

	self.skillItem_ = nil

	if self.skillCxTimer then
		self.skillCxTimer:Stop()

		self.skillCxTimer = nil
	end

	HeroSkillPage.super.Dispose(self)
end

return HeroSkillPage
