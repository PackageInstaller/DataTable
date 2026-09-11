local DormInfomationHeroItem = class("DormInfomationHeroItem", ReduxView)

function DormInfomationHeroItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function DormInfomationHeroItem:InitUI()
	self:BindCfgUI()

	self.emptyController = self.controller_:GetController("empty")
	self.characterItem = DormCharacterItem.New(self.heroItem)

	self:SetState(true, true)
	self:AddUIListener()
end

function DormInfomationHeroItem:AddUIListener()
	self:AddBtnListener(self.btn, nil, function()
		if self.clickFunc_ then
			self.clickFunc_(self.heroID)
		end
	end)
end

function DormInfomationHeroItem:SetData(arg_5_1)
	if arg_5_1 then
		self.heroID = arg_5_1.heroID

		self.characterItem:RefreshHeroInfo(arg_5_1.heroID)
		self.emptyController:SetSelectedState("off")
	else
		self.heroID = nil

		self.emptyController:SetSelectedState("on")
	end
end

function DormInfomationHeroItem:SetState(arg_6_1)
	self.characterItem:SetCanClickAndState(arg_6_1, true, false)
end

function DormInfomationHeroItem:RefreshState()
	self.characterItem:RefreshState()
end

function DormInfomationHeroItem:SetShowMaskCallback(arg_8_1)
	self.showMaskCallback = arg_8_1

	self.characterItem:ShowMaskCallBack(arg_8_1)
end

function DormInfomationHeroItem:RegistCallBack(arg_9_1)
	if self.showMaskCallback and self.showMaskCallback(self.heroID) then
		return
	end

	self.clickFunc_ = arg_9_1
end

function DormInfomationHeroItem:Dispose()
	self.characterItem:Dispose()
	self:RemoveAllEventListener()
	DormInfomationHeroItem.super.Dispose(self)
end

return DormInfomationHeroItem
