local NewHeroHead = class("NewHeroHead", ReduxView)

function NewHeroHead:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function NewHeroHead:Init()
	self:InitUI()
	self:AddUIListener()
	self:SetProxy()
end

function NewHeroHead:InitUI()
	self:BindCfgUI()

	self.lockedController_ = ControllerUtil.GetController(self.gameObject_.transform, "locked")
	self.campController_ = ControllerUtil.GetController(self.gameObject_.transform, "camp")
	self.gradeController_ = ControllerUtil.GetController(self.gameObject_.transform, "grade")
	self.sizeController_ = ControllerUtil.GetController(self.gameObject_.transform, "size")
	self.selectedController_ = ControllerUtil.GetController(self.gameObject_.transform, "selected")
	self.hpController_ = ControllerUtil.GetController(self.gameObject_.transform, "hp")
	self.loveCon_ = ControllerUtil.GetController(self.gameObject_.transform, "love")
end

function NewHeroHead:SetRedPointEnable(arg_4_1)
	SetActive(self.noticePos_.gameObject, arg_4_1)
end

function NewHeroHead:SetProxy(arg_5_1)
	self.heroViewProxy_ = arg_5_1 or HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
end

function NewHeroHead:SetHeroId(arg_6_1, arg_6_2, arg_6_3)
	self.heroDataType = arg_6_2

	if arg_6_2 == HeroConst.HERO_DATA_TYPE.TRIAL then
		arg_6_1 = self.heroViewProxy_:GetHeroData(arg_6_1).tempID
	end

	self:SetHeroData(arg_6_1, arg_6_2)
end

function NewHeroHead:SetHeroData(arg_7_1, arg_7_2)
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

	if self.heroViewProxy_ and self.heroViewProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.DEFAULT then
		manager.redPoint:bindUIandKey(self.noticePos_, RedPointConst.HERO_ID .. arg_7_1, {
			x = 0,
			y = 0
		})
	end

	if not self.heroViewProxy_.showfavorBtn then
		if self.loveCon_ then
			self.loveCon_:SetSelectedState(HeroData:IsFavorite(arg_7_1) == false and "off" or "on")
		end
	elseif self.loveCon_ then
		self.loveCon_:SetSelectedState("off")
	end
end

function NewHeroHead:UpdateView()
	self.headIcon_.sprite = HeroTools.GetHeadSprite(self.heroViewProxy_:GetHeroUsingSkinInfo(self.heroId_).id)

	self.headIcon_:SetNativeSize()
	self.campController_:SetSelectedState(self.heroCfg_.race)

	if self:GetHeroUnLock() then
		self.lockedController_:SetSelectedState("false")

		if self.heroDataType_ == HeroConst.HERO_DATA_TYPE.POLYHEDRON then
			self.levelText_.text = tostring(self.heroInfo_.level or 1)

			self.gradeController_:SetSelectedState(HeroStarCfg[self.heroInfo_.star].star)
		elseif self.heroDataType_ == HeroConst.HERO_DATA_TYPE.PREVIEW or self.heroDataType_ == HeroConst.HERO_DATA_TYPE.DRAW then
			SetActive(self.lvGo_, false)
			self.gradeController_:SetSelectedState(HeroStarCfg[self.heroCfg_.unlock_star].star)
		else
			self.levelText_.text = tostring((not self.heroInfo_.level or nil) and 1)

			self.gradeController_:SetSelectedState(HeroStarCfg[self.heroInfo_.star].star)
		end
	else
		self.pieceText_.text = not self.heroDataType_ == HeroConst.HERO_DATA_TYPE.PREVIEW and not self.heroDataType_ == HeroConst.HERO_DATA_TYPE.DRAW and string.format("%d/%d", self.heroInfo_.piece, GameSetting.unlock_hero_need.value[self.heroCfg_.rare]) or ""

		self.lockedController_:SetSelectedState("true")
		self.gradeController_:SetSelectedState(HeroStarCfg[self.heroCfg_.unlock_star].star)
	end

	if self.level_ then
		self.level_.text = GetTips("LEVEL")
	end
end

function NewHeroHead:GetHeroUnLock()
	return self.heroInfo_.unlock == 1
end

function NewHeroHead:SetUnlockDisplay(arg_10_1)
	self.lockedController_:SetSelectedState(arg_10_1 and "true" or "false")
end

function NewHeroHead:SetSelected(arg_11_1)
	self.selectedController_:SetSelectedState(arg_11_1 and "true" or "false")
end

function NewHeroHead:SetSize(arg_12_1)
	self.sizeController_:SetSelectedState(arg_12_1)
end

function NewHeroHead:RegisterClickListener(arg_13_1)
	self.clickListener_ = arg_13_1
end

function NewHeroHead:AddUIListener()
	self:AddBtnListener(self.selfBtn_, nil, function()
		self:ClearNewHeroRed(self.heroCfg_.id)

		if self.clickListener_ ~= nil then
			self.clickListener_(self.heroCfg_.id)
		end
	end)
end

function NewHeroHead:ClearNewHeroRed(arg_16_1)
	if arg_16_1 and self.heroViewProxy_ and self.heroViewProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.DEFAULT then
		HeroTools.SetHeroNewTagRed(arg_16_1, "unlockHero", RedPointConst.HERO_ID .. arg_16_1, false)
	end
end

function NewHeroHead:Dispose()
	manager.redPoint:unbindUIandKey(self.noticePos_)
	self:RemoveAllListeners()

	self.clickListener_ = nil

	NewHeroHead.super.Dispose(self)
end

return NewHeroHead
