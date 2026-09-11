local SevenDaySkinItem_3_0 = class("SevenDaySkinItem_3_0", ReduxView)

function SevenDaySkinItem_3_0:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:InitUI()
	self:AddListeners()
end

function SevenDaySkinItem_3_0:InitUI()
	self:BindCfgUI()

	self.rareController_ = self.controllerExCollection_:GetController("quality")
	self.starController_ = self.controllerExCollection_:GetController("star")
	self.pointController_ = self.controllerExCollection_:GetController("point")
	self.highLightController_ = self.controllerExCollection_:GetController("award")
	self.completedController_ = self.controllerExCollection_:GetController("completed")
	self.grayController_ = self.controllerExCollection_:GetController("gray")
	self.repController_ = self.controllerExCollection_:GetController("replenishment")
end

function SevenDaySkinItem_3_0:RefreshView(arg_3_1, arg_3_2, arg_3_3)
	self.item = arg_3_1
	self.isResign = arg_3_3
	self.rewardState = arg_3_2
	self.bottomAmountText_.text = arg_3_1[2]

	self.rareController_:SetSelectedIndex(ItemCfg[arg_3_1[1]].display_rare)
	self.starController_:SetSelectedIndex(ItemCfg[arg_3_1[1]].display_rare)

	self.iconImage_.sprite = ItemTools.getItemSprite(arg_3_1[1])

	if arg_3_2 == 0 then
		if arg_3_3 then
			self.highLightController_:SetSelectedIndex(0)
			self.completedController_:SetSelectedIndex(0)
			self.grayController_:SetSelectedIndex(0)
			self.pointController_:SetSelectedIndex(1)
			self.repController_:SetSelectedIndex(0)
		else
			self.highLightController_:SetSelectedIndex(0)
			self.completedController_:SetSelectedIndex(0)
			self.grayController_:SetSelectedIndex(0)
			self.pointController_:SetSelectedIndex(2)
			self.repController_:SetSelectedIndex(1)
		end
	elseif arg_3_2 == 1 then
		self.highLightController_:SetSelectedIndex(1)
		self.completedController_:SetSelectedIndex(0)
		self.grayController_:SetSelectedIndex(0)
		self.pointController_:SetSelectedIndex(1)
		self.repController_:SetSelectedIndex(1)
	elseif arg_3_2 == 2 then
		self.highLightController_:SetSelectedIndex(0)
		self.completedController_:SetSelectedIndex(1)
		self.grayController_:SetSelectedIndex(1)
		self.pointController_:SetSelectedIndex(0)
		self.repController_:SetSelectedIndex(1)
	end
end

function SevenDaySkinItem_3_0:AddListeners()
	self:AddBtnListener(self.clickBtn_, nil, handler(self, self.OnItemClick))
end

function SevenDaySkinItem_3_0:RegisterListener(arg_5_1)
	self.clickHandler_ = arg_5_1
end

function SevenDaySkinItem_3_0:OnItemClick()
	if self.clickHandler_ and self.rewardState == 1 then
		self.clickHandler_()
	elseif self.clickHandler_ and self.isResign and self.rewardState == 0 then
		self.clickHandler_()
	else
		ShowPopItem(POP_ITEM, self.item)
	end
end

function SevenDaySkinItem_3_0:Dispose()
	SevenDaySkinItem_3_0.super.Dispose(self)
end

return SevenDaySkinItem_3_0
