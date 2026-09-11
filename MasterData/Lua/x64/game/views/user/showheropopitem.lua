local ShowHeroPopItem = class("ShowHeroPopItem", ReduxView)

function ShowHeroPopItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()

	self.ownHeroDataProxy = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	self.foreignHeroDataProxy = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.FOREIGN)
end

function ShowHeroPopItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ShowHeroPopItem:InitUI()
	self:BindCfgUI()

	self.headIcon_.immediate = true
	self.heroCampCon_ = ControllerUtil.GetController(self.transform_, "camp")
	self.heroStarCon_ = ControllerUtil.GetController(self.transform_, "grade")
	self.heroStateCon_ = ControllerUtil.GetController(self.transform_, "state")
	self.isHeroOathController = self.controllers_:GetController("isOath")
end

function ShowHeroPopItem:AddUIListeners()
	self:AddBtnListener(self.selfBtn_, nil, function()
		if self.clickFunc_ then
			self.clickFunc_()
		end
	end)
end

function ShowHeroPopItem:OnEnter()
	return
end

function ShowHeroPopItem:RefreshData(arg_7_1, arg_7_2)
	self.data_ = arg_7_1
	self.isForeign_ = arg_7_2

	if self.data_.hero_id == 0 then
		if not self.isForeign_ then
			self.heroStateCon_:SetSelectedState(1)
		else
			self.heroStateCon_:SetSelectedState(2)
		end
	else
		self.heroStateCon_:SetSelectedState(0)
		self:RefreshUI()
	end
end

function ShowHeroPopItem:RefreshUI()
	self.isHeroOathController:SetSelectedState((self.data_.oath == nil or nil) and ((self.isForeign_ or nil) and (self.foreignHeroDataProxy or self.ownHeroDataProxy)):IsHeroOath(self.data_.hero_id) and "true" or "false")

	self.headIcon_.spriteSync = getSpritePathViaConfig("HeroIcon", (self.data_.using_skin == 0 or nil) and (self.data_.hero_id or self.data_.using_skin))

	self.heroStarCon_:SetSelectedState((HeroStarCfg[self.data_.star] ~= nil or nil) and (HeroStarCfg[self.data_.star].star or 1))

	self.campIcon_.sprite = HeroTools.GetHeroRaceIcon(self.data_.hero_id)
	self.levelText_.text = self.data_.level

	SetActive(self.lvGo_, not self.isForeign_)
end

function ShowHeroPopItem:RegistClickFunction(arg_9_1)
	self.clickFunc_ = arg_9_1
end

function ShowHeroPopItem:OnExit()
	return
end

function ShowHeroPopItem:Dispose()
	self:RemoveAllEventListener()
	ShowHeroPopItem.super.Dispose(self)
end

return ShowHeroPopItem
