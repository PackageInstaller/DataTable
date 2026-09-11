local HeroLongHead = class("HeroLongHead", ReduxView)

function HeroLongHead:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function HeroLongHead:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroLongHead:InitUI()
	self:BindCfgUI()

	self.lockedController_ = self.controller_:GetController("lock")
	self.selectedController_ = self.controller_:GetController("selected")
	self.favorController_ = self.controller_:GetController("favor")
	self.favorabilityController_ = self.controller_:GetController("favorability")
	self.trialController_ = self.controller_:GetController("trial")
	self.hpController_ = self.controller_:GetController("hp")
	self.lableController_ = self.controller_:GetController("label")
	self.isHeroOathController_ = self.controller_:GetController("isOath")
end

function HeroLongHead:SetRedPointEnable(arg_4_1)
	SetActive(self.noticePos_.gameObject, arg_4_1)
end

function HeroLongHead:SetProxy(arg_5_1)
	self.heroViewProxy_ = arg_5_1 or HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
end

function HeroLongHead:SetHeroId(arg_6_1, arg_6_2, arg_6_3)
	self.heroDataType = arg_6_2

	if arg_6_2 == HeroConst.HERO_DATA_TYPE.TRIAL or heroDataType == HeroConst.HERO_DATA_TYPE.CUSTOM then
		arg_6_1 = TempHeroData:GetHeroData(arg_6_1, arg_6_3).tempID
	end

	self:SetHeroData(arg_6_1, arg_6_2)
end

function HeroLongHead:SetHeroData(arg_7_1, arg_7_2)
	if arg_7_2 == HeroConst.HERO_DATA_TYPE.TRIAL or arg_7_2 == HeroConst.HERO_DATA_TYPE.CUSTOM then
		self.trialID_ = arg_7_1
		self.heroId_ = HeroStandardSystemCfg[arg_7_1].hero_id
		arg_7_1 = self.heroId_
	else
		self.heroId_ = arg_7_1
		self.trialID_ = 0
	end

	self.heroDataType_ = arg_7_2
	self.heroCfg_ = HeroCfg[arg_7_1]
	self.heroInfo_ = self.heroViewProxy_:GetHeroData(arg_7_1)

	self:UpdateView()
end

function HeroLongHead:UpdateView()
	local var_8_0 = self.heroViewProxy_:GetHeroUsingSkinInfo(self.heroId_).id

	self.headIcon_.sprite = HeroTools.GetHeadSprite((self.isBattlePanel_ or nil) and self.heroViewProxy_:GetHeroBattleUsingSkinInfo(self.heroId_).id)

	self.headIcon_:SetNativeSize()

	self.campLogo_.sprite = HeroTools.GetRaceIcon(HeroCfg[self.heroId_].race)
	self.attackType_.sprite = HeroTools.GetHeroSkillAttributeIcon(self.heroId_)

	self:SetLevel(self.heroInfo_.level or 1)
	self:SetRareIcon()

	if self:GetHeroUnLock() then
		self.lockedController_:SetSelectedState("false")

		if self.heroDataType_ == HeroConst.HERO_DATA_TYPE.PREVIEW or self.heroDataType_ == HeroConst.HERO_DATA_TYPE.DRAW then
			SetActive(self.lvGo_, false)
		end

		self.trialController_:SetSelectedState(self.heroDataType_ == HeroConst.HERO_DATA_TYPE.TRIAL and "true" or "false")
	else
		self.lockedController_:SetSelectedState("true")
	end

	if self.heroViewProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.DEFAULT then
		manager.redPoint:bindUIandKey(self.noticePos_, RedPointConst.HERO_ID .. self.heroId_, {
			x = 0,
			y = 0
		})
	end

	if self.favorController_ then
		if self.heroViewProxy_.showfavorBtn then
			self.favorController_:SetSelectedState(not HeroData:IsFavorite(self.heroId_) and "false" or "true")
		else
			self.favorController_:SetSelectedState("false")
		end
	end

	self.isHeroOathController_:SetSelectedState(self.heroViewProxy_:IsHeroOath(self.heroId_) and "true" or "false")
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.levelContent_)
end

function HeroLongHead:SetRareIcon(arg_9_1)
	self.rareImg_.sprite = arg_9_1 and HeroTools.GetRareSprite(arg_9_1) or HeroTools.GetRareSprite(math.floor(self.heroInfo_.star / 100))
end

function HeroLongHead:ShowFavorability(arg_10_1)
	if self.heroDataType_ == HeroConst.HERO_DATA_TYPE.DEFAULT then
		if ArchiveData:GetArchive(HeroRecordCfg[HeroRecordCfg.get_id_list_by_hero_id[self.heroInfo_.id][1]].id).lv > 1 then
			self.favorabilityText_.text = string.format(GetTips("HERO_HEART_CHAIN_LOVE_TIP"), ArchiveData:GetArchive(HeroRecordCfg[HeroRecordCfg.get_id_list_by_hero_id[self.heroInfo_.id][1]].id).lv)
		end

		self.favorabilityController_:SetSelectedState(tostring(arg_10_1 and ArchiveData:GetArchive(HeroRecordCfg[HeroRecordCfg.get_id_list_by_hero_id[self.heroInfo_.id][1]].id).lv > 1))
	end
end

function HeroLongHead:GetHeroUnLock()
	return self.heroInfo_.unlock == 1
end

function HeroLongHead:SetUnlockDisplay(arg_12_1)
	self.lockedController_:SetSelectedState(arg_12_1 and "true" or "false")
end

function HeroLongHead:SetSelected(arg_13_1)
	self.selectedController_:SetSelectedState(arg_13_1 and "true" or "false")
end

function HeroLongHead:SetFavor(arg_14_1)
	self.favorController_:SetSelectedState(arg_14_1 and "true" or "false")
end

function HeroLongHead:SetHp(arg_15_1)
	self.hpText_.text = math.floor(arg_15_1 * 100) .. "%"
	self.hpSlider_.fillAmount = arg_15_1

	self.hpController_:SetSelectedState(arg_15_1 ~= 0 and "true" or "false")
end

function HeroLongHead:SetLable(arg_16_1)
	self.lableText_.text = arg_16_1

	self.lableController_:SetSelectedState(arg_16_1 ~= nil and "true" or "false")
end

function HeroLongHead:SetLevel(arg_17_1)
	self.levelText_.text = tostring(arg_17_1 or 1)
end

function HeroLongHead:SetHeroCfgData(arg_18_1, arg_18_2, arg_18_3)
	self.heroCfg_ = HeroCfg[arg_18_1]
	self.campLogo_.sprite = HeroTools.GetHeroRaceIcon(arg_18_1)
	self.rareImg_.sprite = arg_18_3 == 0 and HeroTools.GetRareSprite(HeroCfg[arg_18_1].rare or 0) or HeroTools.GetRareSprite(arg_18_3)
	self.attackType_.sprite = HeroTools.GetHeroSkillAttributeIcon(arg_18_1)

	if arg_18_2 then
		self.headIcon_.sprite = HeroTools.GetHeadSprite(SkinCfg[arg_18_2].picture_id)

		self.headIcon_:SetNativeSize()
	end
end

function HeroLongHead:SetHeroSkin(arg_19_1)
	self.headIcon_.sprite = HeroTools.GetHeadSprite(arg_19_1)

	self.headIcon_:SetNativeSize()
end

function HeroLongHead:RegisterClickListener(arg_20_1)
	self.clickListener_ = arg_20_1
end

function HeroLongHead:AddUIListener()
	self:AddBtnListener(self.selfBtn_, nil, function()
		if self.heroViewProxy_ and self.heroViewProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.DEFAULT then
			self:ClearNewHeroRed(self.heroCfg_.id)
		end

		if self.clickListener_ ~= nil and self.heroCfg_ then
			self.clickListener_(self.heroCfg_.id)
		end
	end)
end

function HeroLongHead:ClearNewHeroRed(arg_23_1)
	if arg_23_1 and self.heroViewProxy_ and self.heroViewProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.DEFAULT then
		HeroTools.SetHeroNewTagRed(arg_23_1, "unlockHero", RedPointConst.HERO_ID .. arg_23_1, false)
	end
end

function HeroLongHead:Dispose()
	manager.redPoint:unbindUIandKey(self.noticePos_)
	self:RemoveAllEventListener()

	self.clickListener_ = nil

	HeroLongHead.super.Dispose(self)
end

return HeroLongHead
