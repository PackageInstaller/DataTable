local CapsuleToysGetRewardView = class("CapsuleToysGetRewardView", ReduxView)

function CapsuleToysGetRewardView:UIName()
	return "Widget/System/ReturnTwo/RT2stBonusWindowsUI"
end

function CapsuleToysGetRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function CapsuleToysGetRewardView:Init()
	self:InitUI()
	self:AddUIListener()
end

function CapsuleToysGetRewardView:InitUI()
	self:BindCfgUI()

	self.rewardItemList_ = {}
	self.itemDataList_ = {}
	self.typeController_ = ControllerUtil.GetController(self.transform_, "type")
end

function CapsuleToysGetRewardView:AddUIListener()
	self:AddBtnListener(self.backMask_, nil, function()
		self:Back()
	end)
end

function CapsuleToysGetRewardView:OnEnter()
	self:RefreshUI()
end

function CapsuleToysGetRewardView:RefreshUI()
	for iter_8_0, iter_8_1 in ipairs(self.params_.list) do
		if not self.itemDataList_[iter_8_0] then
			self.itemDataList_[iter_8_0] = clone(ItemTemplateData)
			self.itemDataList_[iter_8_0].clickFun = function(self)
				ShowPopItem(POP_ITEM, {
					self.id,
					self.number
				})
			end
		end

		self.itemDataList_[iter_8_0].id = iter_8_1[1]
		self.itemDataList_[iter_8_0].number = iter_8_1[2]

		if self.rewardItemList_[iter_8_0] then
			self.rewardItemList_[iter_8_0]:SetData(self.itemDataList_[iter_8_0], false)
		else
			self.rewardItemList_[iter_8_0] = self:GetRewardItem(self.itemDataList_[iter_8_0])
		end
	end

	for iter_8_2 = #self.params_.list + 1, #self.rewardItemList_ do
		self.rewardItemList_[iter_8_2]:Show(false)
	end

	if #self.params_.list > 5 then
		self.typeController_:SetSelectedIndex(1)
	else
		self.typeController_:SetSelectedIndex(0)
	end
end

function CapsuleToysGetRewardView:GetRewardItem(arg_10_1)
	return CommonItemPool.New(self.goRewardPanel_, arg_10_1, false)
end

function CapsuleToysGetRewardView:Dispose()
	CapsuleToysGetRewardView.super.Dispose(self)

	if self.rewardItemList_ then
		for iter_11_0, iter_11_1 in ipairs(self.rewardItemList_) do
			iter_11_1:Dispose()
		end

		self.rewardItemList_ = nil
	end

	self.itemDataList_ = nil
end

return CapsuleToysGetRewardView
