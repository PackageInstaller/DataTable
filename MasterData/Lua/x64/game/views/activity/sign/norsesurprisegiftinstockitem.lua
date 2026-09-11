local NorseSurpriseGiftInStockItem = class("NorseSurpriseGiftInStockItem", ReduxView)

function NorseSurpriseGiftInStockItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function NorseSurpriseGiftInStockItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function NorseSurpriseGiftInStockItem:InitUI()
	self:BindCfgUI()

	self.stateCtrl = self.transform_:GetComponent("ControllerExCollection"):GetController("state")
end

function NorseSurpriseGiftInStockItem:AddUIListener()
	self:AddBtnListener(self.btnLook_, nil, function()
		JumpTools.OpenPageByJump("/heroPreviewMain", {
			isEnter = true,
			hid = self.heroId
		})
	end)
	self:AddBtnListener(self.selfBtn_, nil, function()
		if self.clickFunc then
			self.clickFunc(self.heroId)
		end
	end)
end

function NorseSurpriseGiftInStockItem:SetData(arg_7_1)
	self:UpdateView(arg_7_1)
end

function NorseSurpriseGiftInStockItem:UpdateView(arg_8_1)
	self.heroId = arg_8_1

	local var_8_1 = self.heroViewProxy_:GetHeroUsingSkinInfo(self.heroId).id

	self.headIcon_.sprite = HeroTools.GetHeadSprite(self.heroId)
	self.atkImg_.sprite = HeroTools.GetHeroSkillAttributeIcon(self.heroId)
	self.raceImg_.sprite = HeroTools.GetHeroRaceIcon(self.heroId)
end

function NorseSurpriseGiftInStockItem:SetChoose(arg_9_1)
	local var_9_0 = 1

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		if self.heroId == iter_9_1.id then
			var_9_0 = 0
			self.heroSortTxt_.text = iter_9_0

			break
		end
	end

	self.stateCtrl:SetSelectedState(var_9_0)
end

function NorseSurpriseGiftInStockItem:RegistCallBack(arg_10_1)
	self.clickFunc = arg_10_1
end

function NorseSurpriseGiftInStockItem:OnEnter()
	return
end

function NorseSurpriseGiftInStockItem:OnExit()
	NorseSurpriseGiftInStockItem.super.OnExit(self)
end

function NorseSurpriseGiftInStockItem:Dispose()
	NorseSurpriseGiftInStockItem.super.Dispose(self)

	self.clickFunc = nil
end

return NorseSurpriseGiftInStockItem
