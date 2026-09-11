local WhackMoleDescView = class("WhackMoleDescView", ReduxView)

function WhackMoleDescView:UIName()
	return "Widget/System/Summer2024/Summer2024_Minicom/SUminiDuckInfoPopUI"
end

function WhackMoleDescView:UIParent()
	return manager.ui.uiPop.transform
end

function WhackMoleDescView:Init()
	self:BindCfgUI()
	self:AddUIListener()

	self.leftBtnController_ = self.leftBtnControllerEx_:GetController("state")
	self.rightBtnController_ = self.rightBtnControllerEx_:GetController("state")
end

function WhackMoleDescView:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.leftBtn_, nil, function()
		self:Switch(self.index_ - 1)
	end)
	self:AddBtnListener(self.rightBtn_, nil, function()
		self:Switch(self.index_ + 1)
	end)
end

function WhackMoleDescView:OnEnter()
	self.idList_ = self.params_.idList

	self:Switch(self.params_.index or 1)
end

function WhackMoleDescView:Switch(arg_9_1)
	self.index_ = arg_9_1
	self.id_ = self.idList_[arg_9_1]

	local var_9_0 = self:GetSprite()

	if var_9_0 then
		self.icon_.sprite = var_9_0
	end

	self.nameText_.text = self:GetName()
	self.descText_.text = self:GetDesc()

	self.leftBtnController_:SetSelectedState(arg_9_1 > 1 and "on" or "off")

	self.leftBtn_.interactable = arg_9_1 > 1

	self.rightBtnController_:SetSelectedState(arg_9_1 < #self.idList_ and "on" or "off")

	self.rightBtn_.interactable = arg_9_1 < #self.idList_
end

function WhackMoleDescView:GetName()
	return ActivityMoleCfg[self.id_].name
end

function WhackMoleDescView:GetDesc()
	return ActivityMoleCfg[self.id_].desc
end

function WhackMoleDescView:GetSprite()
	return pureGetSpriteWithoutAtlas(ActivityMoleCfg[self.id_].pitcture_path)
end

return WhackMoleDescView
