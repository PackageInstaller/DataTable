local DormDanceHeroItem = class("DormDanceHeroItem", ReduxView)

function DormDanceHeroItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.onClick_ = nil

	self:Init()
end

function DormDanceHeroItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function DormDanceHeroItem:InitUI()
	self:BindCfgUI()

	self.selectController_ = self.mainControllerEx_:GetController("select")
end

function DormDanceHeroItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		self.onClick_(self.heroID_)
	end)
end

function DormDanceHeroItem:Show(arg_6_1)
	self.heroID_ = arg_6_1
	self.headIcon_.sprite = DormHeroTools.GetBackHomeHeadSprite(arg_6_1, true)

	SetActive(self.gameObject_, true)
end

function DormDanceHeroItem:Hide()
	SetActive(self.gameObject_, false)
end

function DormDanceHeroItem:SetSelectState(arg_8_1)
	self.selectController_:SetSelectedState((self.heroID_ == arg_8_1 and true or false) and "true" or "false")
end

function DormDanceHeroItem:RegistCallBack(arg_9_1)
	self.onClick_ = arg_9_1
end

function DormDanceHeroItem:Dispose()
	DormDanceHeroItem.super.Dispose(self)
end

return DormDanceHeroItem
