local HeadIconChangeView = class("HeadIconChangeView", ReduxView)

function HeadIconChangeView:UIName()
	return "Widget/System/UserInfor/UserInfoExpiredUI"
end

function HeadIconChangeView:UIParent()
	return manager.ui.uiPop.transform
end

function HeadIconChangeView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function HeadIconChangeView:InitUI()
	self:BindCfgUI()

	self.expiredItemList_ = LuaList.New(handler(self, self.IndexItem), self.expiredListGo2_, CommonItemView)
end

function HeadIconChangeView:AddUIListeners()
	self:AddBtnListener(self.okBtn2_, nil, function()
		self:Back()
	end)
end

function HeadIconChangeView:IndexItem(arg_7_1, arg_7_2)
	local var_7_0 = clone(ItemTemplateData)

	var_7_0.id = self.expiredList_[arg_7_1].id
	var_7_0.number = self.expiredList_[arg_7_1].num

	arg_7_2:SetData(var_7_0)
end

function HeadIconChangeView:OnEnter()
	PlayerData:DealOverdueFrame()
	PlayerData:DealOverduePortrait()
	PlayerData:DealOverdueChatBubble()
	PlayerData:DealOverdueCardBgList()

	self.expiredList_ = self.params_.expiredList

	self.expiredItemList_:StartScroll(#self.expiredList_)

	self.descText1_.text = GetTips("DECORATE_ITEM_DUE_TIPS")
end

function HeadIconChangeView:OnExit()
	return
end

function HeadIconChangeView:Dispose()
	if self.expiredItemList_ then
		self.expiredItemList_:Dispose()
	end

	self:RemoveAllListeners()
	HeadIconChangeView.super.Dispose(self)
end

return HeadIconChangeView
