local WindowSimBusinessFundBarItem = class("WindowSimBusinessFundBarItem", import(".WindowBarItemBase"))

function WindowSimBusinessFundBarItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.data = arg_1_2

	self:Init()
end

function WindowSimBusinessFundBarItem:Init()
	WindowSimBusinessFundBarItem.super.Init(self)

	self.typeCon_ = ControllerUtil.GetController(self.transform_, "type")

	self:RefreshUI()
end

function WindowSimBusinessFundBarItem:AddListeners()
	WindowSimBusinessFundBarItem.super.AddListeners(self)
end

function WindowSimBusinessFundBarItem:OnClick()
	ShowPopItem(POP_ITEM, {
		SimBusinessData:GetSimBusinessFundItemID()
	})
end

function WindowSimBusinessFundBarItem:RefreshUI()
	self.icon_.sprite = ItemTools.getItemLittleSprite((SimBusinessData:GetSimBusinessFundItemID()))
	self.text_.text = SimBusinessTools.GetAvailableFund(self.data:GetStage())
end

function WindowSimBusinessFundBarItem:SetActive(arg_6_1)
	WindowSimBusinessFundBarItem.super.SetActive(self, arg_6_1)

	if arg_6_1 then
		self:RefreshUI()
	end
end

function WindowSimBusinessFundBarItem:RegisterEvents()
	self:RegistEventListener(CURRENCY_UPDATE, handler(self, self.RefreshUI))
	self:RegistEventListener("SIM_BUSINESS_SHELF_COST_UPDATE", handler(self, self.RefreshUI))
	self:RegistEventListener("SIM_BUSINESS_STAGE_CHANGED", handler(self, self.RefreshUI))
end

local SimBusinessFundBar = class("SimBusinessFundBar")

function SimBusinessFundBar:Ctor(arg_8_1)
	self.stage = arg_8_1
end

function SimBusinessFundBar:GetStage()
	if self.stage then
		return self.stage
	end

	return SimBusinessGame.GetInstance().stage
end

function SimBusinessFundBar:GetBarClass()
	return WindowSimBusinessFundBarItem
end

local SimBusinessNormalStageFundBar = class("SimBusinessNormalStageFundBar", SimBusinessFundBar)

function SimBusinessNormalStageFundBar:GetStage()
	if self.stage then
		return self.stage
	end

	return SimBusinessTools.GetDefaultEnterDailyLevel()
end

WindowSimBusinessFundBarItem.bar = SimBusinessFundBar
WindowSimBusinessFundBarItem.normalStageFundBar = SimBusinessNormalStageFundBar

return WindowSimBusinessFundBarItem
