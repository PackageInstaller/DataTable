local HeroFileArchiveTabItem = class("HeroFileArchiveTabItem", ReduxView)

function HeroFileArchiveTabItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.itemIndex = arg_1_2
	self.lock = false

	function self.clickHandler()
		if self.onClick then
			self:onClick(self.itemIndex)
		end
	end

	self:Init()
end

function HeroFileArchiveTabItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroFileArchiveTabItem:InitUI()
	self:BindCfgUI()

	self.lockController = self.linktabitemControllerEx_:GetController("lock")
	self.selectController = self.linktabitemControllerEx_:GetController("select")
	self.bgController = self.linktabitemControllerEx_:GetController("bg")
end

function HeroFileArchiveTabItem:AddUIListener()
	self:AddBtnListener(self.selectBtn_, nil, self.clickHandler)
end

function HeroFileArchiveTabItem:SetTitle(arg_6_1)
	self.titleText_.text = arg_6_1
end

function HeroFileArchiveTabItem:SetOnClick(arg_7_1)
	self.onClick = arg_7_1
end

function HeroFileArchiveTabItem:SetLockState(arg_8_1)
	self.lock = arg_8_1

	self.lockController:SetSelectedState(arg_8_1 and "lock" or "unlock")
end

function HeroFileArchiveTabItem:SetSelectState(arg_9_1)
	self.selectController:SetSelectedState(arg_9_1 and "select" or "cancel")
end

function HeroFileArchiveTabItem:SetBgState(arg_10_1)
	self.bgController:SetSelectedState(arg_10_1)
end

function HeroFileArchiveTabItem:SetIsShow(arg_11_1)
	SetActive(self.gameObject_, arg_11_1)
end

function HeroFileArchiveTabItem:Dispose()
	HeroFileArchiveTabItem.super.Dispose(self)
end

return HeroFileArchiveTabItem
