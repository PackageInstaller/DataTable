local DormRoleTabItem = class("DormRoleTabItem", ReduxView)

function DormRoleTabItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.onClick_ = arg_1_2

	self:Init()
end

function DormRoleTabItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function DormRoleTabItem:InitUI()
	self:BindCfgUI()

	self.selectController_ = self.mainControllerEx_:GetController("select2")
end

function DormRoleTabItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, self.onClick_)
end

function DormRoleTabItem:Show(arg_5_1)
	self.headIcon_.sprite = DormHeroTools.GetBackHomeHeadSprite(arg_5_1, true)

	SetActive(self.gameObject_, true)
end

function DormRoleTabItem:Hide()
	SetActive(self.gameObject_, false)
end

function DormRoleTabItem:SetSelectState(arg_7_1)
	self.selectController_:SetSelectedState(arg_7_1 and "on" or "off")
end

function DormRoleTabItem:Dispose()
	DormRoleTabItem.super.Dispose(self)
end

return DormRoleTabItem
