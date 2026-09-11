local NorseSurpriseGiftReceiveItem = class("NorseSurpriseGiftReceiveItem", ReduxView)
local var_0_1 = {
	"第一抽",
	"第二抽",
	"第三抽",
	"第四抽",
	"第五抽"
}

function NorseSurpriseGiftReceiveItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function NorseSurpriseGiftReceiveItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function NorseSurpriseGiftReceiveItem:InitUI()
	self:BindCfgUI()

	self.stateCtrl = self.transform_:GetComponent("ControllerExCollection"):GetController("state")
	self.heartCtrl = self.transform_:GetComponent("ControllerExCollection"):GetController("heart")
end

function NorseSurpriseGiftReceiveItem:AddUIListener()
	self:AddBtnListener(self.btn_look, nil, function()
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

function NorseSurpriseGiftReceiveItem:SetData(arg_7_1, arg_7_2)
	self:UpdateView(arg_7_1, arg_7_2)
end

function NorseSurpriseGiftReceiveItem:UpdateView(arg_8_1, arg_8_2)
	self.heroId = arg_8_1
	self.icon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. self.heroId)
	self.numTxt_.text = var_0_1[arg_8_2]
	self.atkImg_.sprite = HeroTools.GetHeroSkillAttributeIcon(self.heroId)
	self.raceImg_.sprite = HeroTools.GetHeroRaceIcon(self.heroId)
	self.suffixTxt_.text = GetI18NText(HeroCfg[self.heroId].suffix)
	self.nameTxt_.text = GetI18NText(HeroCfg[self.heroId].name)

	self.stateCtrl:SetSelectedIndex(0)
	self.heartCtrl:SetSelectedIndex(0)
end

function NorseSurpriseGiftReceiveItem:SetHeart(arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		if self.heroId == iter_9_1 then
			self.heartCtrl:SetSelectedIndex(1)

			break
		end
	end
end

function NorseSurpriseGiftReceiveItem:SetSelect(arg_10_1)
	if arg_10_1.id == self.heroId then
		self.stateCtrl:SetSelectedIndex(2)
	else
		self.stateCtrl:SetSelectedIndex(0)
	end
end

function NorseSurpriseGiftReceiveItem:RegistCallBack(arg_11_1)
	self.clickFunc = arg_11_1
end

function NorseSurpriseGiftReceiveItem:OnEnter()
	return
end

function NorseSurpriseGiftReceiveItem:OnExit()
	NorseSurpriseGiftReceiveItem.super.OnExit(self)
end

function NorseSurpriseGiftReceiveItem:Dispose()
	NorseSurpriseGiftReceiveItem.super.Dispose(self)

	self.clickFunc = nil
end

return NorseSurpriseGiftReceiveItem
