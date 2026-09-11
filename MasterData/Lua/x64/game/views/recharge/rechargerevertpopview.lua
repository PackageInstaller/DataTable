local RechargeRevertPopView = class("RechargeRevertPopView", ReduxView)

function RechargeRevertPopView:UIName()
	return "Widget/System/Shop/ShopConversionUI"
end

function RechargeRevertPopView:UIParent()
	return manager.ui.uiPop.transform
end

function RechargeRevertPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RechargeRevertPopView:InitUI()
	self:BindCfgUI()

	self.rewardTypeController_ = ControllerUtil.GetController(self.gameObject_.transform, "rewardType")
	self.costTypeController_ = ControllerUtil.GetController(self.gameObject_.transform, "costType")
	self.list1 = LuaList.New(handler(self, self.indexItem1), self.list1Go_, CommonItemView)
	self.list2 = LuaList.New(handler(self, self.indexItem2), self.list2Go_, CommonItemView)
end

function RechargeRevertPopView:indexItem1(arg_5_1, arg_5_2)
	CommonTools.SetCommonData(arg_5_2, {
		id = self.buyItem[arg_5_1].id,
		num = self.buyItem[arg_5_1].num
	})
end

function RechargeRevertPopView:indexItem2(arg_6_1, arg_6_2)
	CommonTools.SetCommonData(arg_6_2, {
		id = self.revertItem[arg_6_1].id,
		num = self.revertItem[arg_6_1].num
	})
end

function RechargeRevertPopView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.okBtn_, nil, function()
		self.callBack()
	end)
end

function RechargeRevertPopView:UpdateBar()
	return
end

function RechargeRevertPopView:OnTop()
	self:UpdateBar()
	manager.windowBar:SetAsLastSibling()
end

function RechargeRevertPopView:OnEnter()
	self.callBack = self.params_.callBack
	self.goodID = self.params_.goodId
	self.buyNumber = self.params_.buyNumber

	self:UpdateView()
end

function RechargeRevertPopView:UpdateView()
	self.buyItem, self.revertItem = ShopTools.rewertReward(self.goodID, self.buyNumber)

	self.list1:StartScroll(#self.buyItem)
	self.list2:StartScroll(#self.revertItem)
end

function RechargeRevertPopView:OnShopBuyResult(arg_15_1, arg_15_2)
	self:Back()
end

function RechargeRevertPopView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function RechargeRevertPopView:Dispose()
	if self.list1 then
		self.list1:Dispose()

		self.list1 = nil
	end

	if self.list2 then
		self.list2:Dispose()

		self.list2 = nil
	end

	RechargeRevertPopView.super.Dispose(self)
end

return RechargeRevertPopView
