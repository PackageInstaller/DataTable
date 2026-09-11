local NorseSurpriseGiftMachineItem = class("NorseSurpriseGiftMachineItem", ReduxView)

function NorseSurpriseGiftMachineItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function NorseSurpriseGiftMachineItem:Init()
	self:InitUI()
	self:AddUIListener()

	self.stateCtrl = self.transform_:GetComponent("ControllerExCollection"):GetController("state")
end

function NorseSurpriseGiftMachineItem:InitUI()
	self:BindCfgUI()
end

function NorseSurpriseGiftMachineItem:AddUIListener()
	return
end

function NorseSurpriseGiftMachineItem:SetData(arg_5_1)
	self:UpdateView(arg_5_1)
end

function NorseSurpriseGiftMachineItem:UpdateView(arg_6_1)
	self.heroId = arg_6_1

	local var_6_1 = self.heroViewProxy_:GetHeroUsingSkinInfo(arg_6_1).id

	self.raceImage_.sprite = HeroTools.GetHeroRaceIcon(self.heroId)
	self.iconImage_.sprite = HeroTools.GetHeadSprite(self.heroId)
end

function NorseSurpriseGiftMachineItem:SetState(arg_7_1, arg_7_2)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		if self.heroId == iter_7_1 then
			self.stateCtrl:SetSelectedState("heart")

			break
		end
	end

	self.stateCtrl:SetSelectedState(heartState)

	if arg_7_2 and arg_7_2 > 0 then
		if arg_7_2 == self.heroId then
			self.stateCtrl:SetSelectedState("receive")
		else
			self.stateCtrl:SetSelectedState("notreceive")
		end
	else
		self.stateCtrl:SetSelectedIndex(0)
	end
end

function NorseSurpriseGiftMachineItem:ResetState()
	self.stateCtrl:SetSelectedIndex(0)
end

function NorseSurpriseGiftMachineItem:PlayAnim(arg_9_1)
	if arg_9_1 then
		self.anim_:Play("NorseSurpriseGiftMachineUI_item")
		self.animZhuanhua_:Play("CommonItem_zhuanhua")
	else
		self.anim_:Play("New State")
		self.animZhuanhua_:Play("New State")
		SetActive(self.animZhuanhua_.gameObject, false)
	end
end

function NorseSurpriseGiftMachineItem:OnEnter()
	self.stateCtrl:SetSelectedIndex(0)
end

function NorseSurpriseGiftMachineItem:OnExit()
	NorseSurpriseGiftMachineItem.super.OnExit(self)
end

function NorseSurpriseGiftMachineItem:Dispose()
	NorseSurpriseGiftMachineItem.super.Dispose(self)
end

return NorseSurpriseGiftMachineItem
