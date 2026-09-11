local HeroUpgradeSuccessView = class("HeroUpgradeSuccessView", (import("game.views.pop.PopLevelUpBaseView")))

function HeroUpgradeSuccessView:UIName()
	return "Widget/System/Hero_arrt/HeroLevelUpUI"
end

function HeroUpgradeSuccessView:UIParent()
	return manager.ui.uiPop.transform
end

function HeroUpgradeSuccessView:OnCtor()
	return
end

function HeroUpgradeSuccessView:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroUpgradeSuccessView:InitUI()
	self:BindCfgUI()

	self.fromPropValueTexts_ = {
		self.fromValue1_,
		self.fromValue2_,
		self.fromValue3_
	}
	self.toPropValueTexts_ = {
		self.toValue1_,
		self.toValue2_,
		self.toValue3_
	}
	self.propNames_ = {
		self.propName1_,
		self.propName2_,
		self.propName3_
	}
	self.propIndexes_ = {
		1,
		2,
		3
	}

	for iter_5_0 = 1, 3 do
		self.propNames_[iter_5_0].text = GetI18NText(PublicAttrCfg[self.propIndexes_[iter_5_0]].name)
	end
end

function HeroUpgradeSuccessView:AddUIListener()
	self:AddBtnListener(self.btnBack_, nil, function()
		self:Back()

		if self.params_.callback then
			self.params_.callBack = nil

			self.params_.callback()
		end
	end)
end

function HeroUpgradeSuccessView:OnEnter()
	self:CheckBack()

	self.oldLv_ = self.params_.oldLv
	self.oldAttr_ = self.params_.oldAttr
	self.heroViewProxy_ = self.params_.proxy
	self.heroInfo_ = HeroData:GetHeroList()[self.params_.heroId]
	self.newAttr_ = self.heroViewProxy_:GetHeroAllAttribute(self.heroInfo_.id)

	self:UpdateView()
end

function HeroUpgradeSuccessView:UpdateView()
	self.fromLevelText_.text = string.format("%d", self.oldLv_)
	self.toLevelText_.text = string.format("%d", self.heroInfo_.level)

	for iter_9_0 = 1, 3 do
		self.fromPropValueTexts_[iter_9_0].text = string.format("%d", self.oldAttr_[iter_9_0])
		self.toPropValueTexts_[iter_9_0].text = string.format("%d", self.newAttr_[iter_9_0])
	end

	self:PlayHeroTalk(self.heroInfo_.id)
end

function HeroUpgradeSuccessView:PlayHeroTalk(arg_10_1)
	if self.isTalkCD_ then
		return
	end

	HeroTools.PlayTalk(arg_10_1, "expup")

	self.isTalkCD_ = true
	self.talkCDTimer_ = Timer.New(function()
		self.isTalkCD_ = false
	end, HeroConst.LEVEL_UPGRADE_VOICE_CD, 1)

	self.talkCDTimer_:Start()
end

function HeroUpgradeSuccessView:OnExit()
	return
end

function HeroUpgradeSuccessView:Dispose()
	self:RemoveAllListeners()

	if self.talkCDTimer_ then
		self.talkCDTimer_:Stop()

		self.talkCDTimer_ = nil
	end

	self.isTalkCD_ = nil

	HeroUpgradeSuccessView.super.Dispose(self)
end

return HeroUpgradeSuccessView
