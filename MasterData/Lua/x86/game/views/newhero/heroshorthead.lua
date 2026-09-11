local HeroShortHead = class("HeroShortHead", ReduxView)

function HeroShortHead:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function HeroShortHead:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroShortHead:InitUI()
	self:BindCfgUI()

	self.lockedController_ = self.controller_:GetController("lock")
	self.selectedController_ = self.controller_:GetController("selected")
	self.favorController_ = self.controller_:GetController("favor")
	self.isHeroOathController_ = self.controller_:GetController("isOath")
end

function HeroShortHead:SetRedPointEnable(arg_4_1)
	SetActive(self.noticePos_.gameObject, arg_4_1)
end

function HeroShortHead:SetProxy(arg_5_1)
	self.heroViewProxy_ = arg_5_1 or HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
end

function HeroShortHead:SetHeroId(arg_6_1, arg_6_2, arg_6_3)
	self.heroDataType = arg_6_2

	if arg_6_2 == HeroConst.HERO_DATA_TYPE.TRIAL then
		arg_6_1 = TempHeroData:GetHeroData(arg_6_1, arg_6_3).tempID
	end

	self:SetHeroData(arg_6_1, arg_6_2)
end

function HeroShortHead:SetHeroData(arg_7_1, arg_7_2)
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

function HeroShortHead:UpdateView()
	local var_8_0 = self.heroViewProxy_:GetHeroUsingSkinInfo(self.heroId_).id

	self.headIcon_.sprite = HeroTools.GetHeadSprite((self.isBattlePanel_ or nil) and HeroData:GetHeroBattleUsingSkinInfo(self.heroId_).id)

	self.headIcon_:SetNativeSize()

	self.levelText_.text = tostring(self.heroInfo_.level or 1)

	if self:GetHeroUnLock() then
		self.lockedController_:SetSelectedState("false")

		if self.heroDataType_ == HeroConst.HERO_DATA_TYPE.PREVIEW or self.heroDataType_ == HeroConst.HERO_DATA_TYPE.DRAW then
			SetActive(self.lvGo_, false)
		end
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

	if self.isHeroOathController_ then
		self.isHeroOathController_:SetSelectedState(self.heroViewProxy_:IsHeroOath(self.heroId_) and "true" or "false")
	end
end

function HeroShortHead:GetHeroUnLock()
	return self.heroInfo_.unlock == 1
end

function HeroShortHead:SetUnlockDisplay(arg_10_1)
	self.lockedController_:SetSelectedState(arg_10_1 and "true" or "false")
end

function HeroShortHead:SetSelected(arg_11_1)
	self.selectedController_:SetSelectedState(arg_11_1 and "true" or "false")
end

function HeroShortHead:RegisterClickListener(arg_12_1)
	self.clickListener_ = arg_12_1
end

function HeroShortHead:AddUIListener()
	self:AddBtnListener(self.selfBtn_, nil, function()
		self:ClearNewHeroRed(self.heroCfg_.id)

		if self.clickListener_ ~= nil then
			self.clickListener_(self.heroCfg_.id)
		end
	end)
end

function HeroShortHead:ClearNewHeroRed(arg_15_1)
	if arg_15_1 and self.heroViewProxy_ and self.heroViewProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.DEFAULT then
		HeroTools.SetHeroNewTagRed(arg_15_1, "unlockHero", RedPointConst.HERO_ID .. arg_15_1, false)
	end
end

function HeroShortHead:Dispose()
	manager.redPoint:unbindUIandKey(self.noticePos_)
	self:RemoveAllListeners()

	self.clickListener_ = nil

	HeroShortHead.super.Dispose(self)
end

return HeroShortHead
