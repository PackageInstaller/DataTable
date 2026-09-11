local NorseSurpriseGiftChooseItem = class("NorseSurpriseGiftChooseItem", ReduxView)

function NorseSurpriseGiftChooseItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function NorseSurpriseGiftChooseItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function NorseSurpriseGiftChooseItem:InitUI()
	self:BindCfgUI()

	self.stateCtrl = self.transform_:GetComponent("ControllerExCollection"):GetController("state")
	self.heartCtrl = self.transform_:GetComponent("ControllerExCollection"):GetController("heart")
end

function NorseSurpriseGiftChooseItem:AddUIListener()
	self:AddBtnListener(self.btnLook_, nil, function()
		JumpTools.OpenPageByJump("/heroPreviewMain", {
			isEnter = true,
			hid = self.heroId
		})
	end)
end

function NorseSurpriseGiftChooseItem:SetData(arg_6_1)
	self:UpdateView(arg_6_1)
end

function NorseSurpriseGiftChooseItem:UpdateView(arg_7_1)
	self.heroId = arg_7_1

	local var_7_1 = self.heroViewProxy_:GetHeroUsingSkinInfo(self.heroId).id

	self.headIcon_.sprite = HeroTools.GetHeadSprite(self.heroId)
	self.atkImg_.sprite = HeroTools.GetHeroSkillAttributeIcon(self.heroId)
	self.raceImg_.sprite = HeroTools.GetHeroRaceIcon(self.heroId)

	self.stateCtrl:SetSelectedIndex(0)
	self.heartCtrl:SetSelectedIndex(0)
end

function NorseSurpriseGiftChooseItem:SetHeart(arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		if self.heroId == iter_8_1 then
			self.heartCtrl:SetSelectedIndex(1)

			break
		end
	end
end

function NorseSurpriseGiftChooseItem:SetDelete(arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		if self.heroId == iter_9_1 then
			self.stateCtrl:SetSelectedIndex(1)

			break
		end
	end
end

function NorseSurpriseGiftChooseItem:SetDraw(arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		if self.heroId == iter_10_1 then
			self.stateCtrl:SetSelectedIndex(2)

			break
		end
	end
end

function NorseSurpriseGiftChooseItem:SetResultRoleId(arg_11_1)
	if self.heroId == arg_11_1 then
		self.stateCtrl:SetSelectedIndex(3)
	end
end

function NorseSurpriseGiftChooseItem:OnEnter()
	return
end

function NorseSurpriseGiftChooseItem:OnExit()
	NorseSurpriseGiftChooseItem.super.OnExit(self)
end

function NorseSurpriseGiftChooseItem:Dispose()
	NorseSurpriseGiftChooseItem.super.Dispose(self)
end

return NorseSurpriseGiftChooseItem
