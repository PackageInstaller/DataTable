local NorseSurpriseGiftWishPoolItem = class("NorseSurpriseGiftWishPoolItem", ReduxView)

function NorseSurpriseGiftWishPoolItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function NorseSurpriseGiftWishPoolItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function NorseSurpriseGiftWishPoolItem:InitUI()
	self:BindCfgUI()

	self.stateCtrl = self.transform_:GetComponent("ControllerExCollection"):GetController("state")
	self.magnigierCtrl = self.transform_:GetComponent("ControllerExCollection"):GetController("magnigier")
end

function NorseSurpriseGiftWishPoolItem:AddUIListener()
	self:AddBtnListener(self.btnLook_, nil, function()
		JumpTools.OpenPageByJump("/heroPreviewMain", {
			isEnter = true,
			hid = self.heroId
		})
	end)
	self:AddBtnListener(self.btn_add, nil, function()
		JumpTools.OpenPageByJump("norseSurpriseGiftInStockPage")
	end)
end

function NorseSurpriseGiftWishPoolItem:SetData(arg_7_1)
	self:UpdateView(arg_7_1)
end

function NorseSurpriseGiftWishPoolItem:SetDrawState(arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		if self.heroId == iter_8_1 then
			self.stateCtrl:SetSelectedIndex(1)
			self.magnigierCtrl:SetSelectedIndex(0)

			break
		end
	end
end

function NorseSurpriseGiftWishPoolItem:SetGetState(arg_9_1)
	if arg_9_1 and self.heroId == arg_9_1 then
		self.stateCtrl:SetSelectedIndex(3)
		self.magnigierCtrl:SetSelectedIndex(0)
	end
end

function NorseSurpriseGiftWishPoolItem:UpdateView(arg_10_1)
	self.heroId = arg_10_1
	self.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. self.heroId)
	self.atkImg_.sprite = HeroTools.GetHeroSkillAttributeIcon(self.heroId)
	self.raceImg_.sprite = HeroTools.GetHeroRaceIcon(self.heroId)
	self.suffixTxt_.text = GetI18NText(HeroCfg[self.heroId].suffix)
	self.nameTxt_.text = GetI18NText(HeroCfg[self.heroId].name)

	self.stateCtrl:SetSelectedIndex(0)
	self.magnigierCtrl:SetSelectedIndex(0)
end

function NorseSurpriseGiftWishPoolItem:OnEnter()
	return
end

function NorseSurpriseGiftWishPoolItem:OnExit()
	NorseSurpriseGiftWishPoolItem.super.OnExit(self)
end

function NorseSurpriseGiftWishPoolItem:Dispose()
	NorseSurpriseGiftWishPoolItem.super.Dispose(self)
end

return NorseSurpriseGiftWishPoolItem
