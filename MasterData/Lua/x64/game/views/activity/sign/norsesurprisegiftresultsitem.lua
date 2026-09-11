local NorseSurpriseGiftResultsItem = class("NorseSurpriseGiftResultsItem", ReduxView)

function NorseSurpriseGiftResultsItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function NorseSurpriseGiftResultsItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function NorseSurpriseGiftResultsItem:InitUI()
	self:BindCfgUI()

	self.heartCtrl = self.transform_:GetComponent("ControllerExCollection"):GetController("heart")
	self.stockCtrl = self.transform_:GetComponent("ControllerExCollection"):GetController("Outofstock")
end

function NorseSurpriseGiftResultsItem:AddUIListener()
	return
end

function NorseSurpriseGiftResultsItem:SetData(arg_5_1)
	self:UpdateView(arg_5_1)
end

function NorseSurpriseGiftResultsItem:UpdateView(arg_6_1)
	self.heroId = arg_6_1

	local var_6_0 = self.heroViewProxy_:GetHeroUsingSkinInfo(arg_6_1).id

	self.bottomAmountText_.text = 1
	self.gradeImage_.sprite = getSprite("Atlas/SystemHeroGradeAtlas", "com_grade_" .. 3)
	self.raceImage_.sprite = getSprite("Atlas/SystemGroupAtlas", RaceEffectCfg[HeroCfg[arg_6_1].race].icon2)
	self.iconImage_.sprite = HeroTools.GetHeadSprite(self.heroId)

	self.heartCtrl:SetSelectedIndex(1)
	self.stockCtrl:SetSelectedIndex(1)
end

function NorseSurpriseGiftResultsItem:SetHeart(arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		if self.heroId == iter_7_1 then
			self.heartCtrl:SetSelectedIndex(0)

			break
		end
	end
end

function NorseSurpriseGiftResultsItem:SetDelete(arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		if self.heroId == iter_8_1 then
			self.stockCtrl:SetSelectedIndex(0)

			break
		end
	end
end

function NorseSurpriseGiftResultsItem:OnEnter()
	return
end

function NorseSurpriseGiftResultsItem:OnExit()
	NorseSurpriseGiftResultsItem.super.OnExit(self)
end

function NorseSurpriseGiftResultsItem:Dispose()
	NorseSurpriseGiftResultsItem.super.Dispose(self)
end

return NorseSurpriseGiftResultsItem
