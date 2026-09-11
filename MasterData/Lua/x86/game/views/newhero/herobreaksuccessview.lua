local HeroBreakSuccessView = class("HeroBreakSuccessView", (import("game.views.pop.PopLevelUpBaseView")))

function HeroBreakSuccessView:UIName()
	return "Widget/System/Hero_arrt/HeroArrtBreakPopUI"
end

function HeroBreakSuccessView:UIParent()
	return manager.ui.uiPop.transform
end

function HeroBreakSuccessView:OnCtor()
	return
end

function HeroBreakSuccessView:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroBreakSuccessView:InitUI()
	self:BindCfgUI()

	local var_5_0, var_5_1, var_5_2 = SkillTools.GetAttr({
		HeroConst.HERO_ATTRIBUTE.CRITICAL,
		0
	})

	self.propName_.text = GetI18NText(var_5_0)
	self.iconImg_.sprite = var_5_2
end

function HeroBreakSuccessView:AddUIListener()
	self:AddBtnListener(self.btnBack_, nil, function()
		self:Back()

		if self.callBack_ then
			self.callBack_ = nil
			self.params_.callBack = nil

			self.callBack_()
		end
	end)
end

function HeroBreakSuccessView:OnEnter()
	self:CheckBack()

	self.heroInfo_ = HeroData:GetHeroList()[self.params_.heroId]
	self.heroCfg_ = HeroCfg[self.params_.heroId]
	self.breakCfg_ = HeroTools.GetHeroBreakConfig(self.heroCfg_.race, self.params_.breakLevel)
	self.oldBreakCfg_ = HeroTools.GetHeroBreakConfig(self.heroCfg_.race, self.params_.breakLevel - 1)
	self.heroViewProxy_ = self.params_.proxy
	self.callBack_ = self.params_.callBack

	self:UpdateView()
end

function HeroBreakSuccessView:UpdateView()
	self.levelFromText_.text = tostring(self.oldBreakCfg_.max_level)
	self.levelTopText_.text = tostring(self.breakCfg_.max_level)
	self.fromCritText_.text = string.format("%.2f", self.params_.oldCrit / 10) .. (PublicAttrCfg[HeroConst.HERO_ATTRIBUTE.CRITICAL].percent == 1 and "%" or "")

	local var_9_0 = HeroTools.CaculateHeroAttribute(self.heroInfo_, {})

	HeroTools.CalFinalAttribute(var_9_0)

	self.toCritText_.text = string.format("%.2f", var_9_0[HeroConst.HERO_ATTRIBUTE.CRITICAL] / 10) .. (PublicAttrCfg[HeroConst.HERO_ATTRIBUTE.CRITICAL].percent == 1 and "%" or "")
end

function HeroBreakSuccessView:Dispose()
	self:RemoveAllListeners()
	HeroBreakSuccessView.super.Dispose(self)
end

return HeroBreakSuccessView
