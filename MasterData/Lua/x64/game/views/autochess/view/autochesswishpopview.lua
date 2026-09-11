local AutoChessWishPopView = class("AutoChessWishPopView", ReduxView)

function AutoChessWishPopView:Init()
	self:InitUI()
	self:AddListeners()
end

function AutoChessWishPopView:InitUI()
	self:BindCfgUI()

	self.cardItem_ = AutoChessCardItem.New(self.cardGo_)
	self.URFactoryItem_ = AutoChessURFactoryItem.New(self.URItemGo_)
end

function AutoChessWishPopView:UIParent()
	return manager.ui.uiPop.transform
end

function AutoChessWishPopView:UIName()
	return "Widget/System/Activity_AutoChess_Main/Com/Activity_AutoChess_WishSuccessTipsPopUI"
end

function AutoChessWishPopView:AddListeners()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()

		if self.callBack_ then
			self.callBack_()
		end
	end)
end

function AutoChessWishPopView:OnEnter()
	saveData("autochess_4_8", "isShowWish", 1)

	local var_7_0 = AutoChessCardData:GetDesireInfo()

	self.cardItem_:SetData(var_7_0.CardID, self.URFactoryItem_:GetItem(var_7_0.CardID))

	self.callBack_ = self.params_.callback
end

function AutoChessWishPopView:Dispose()
	self.cardItem_:Dispose()
	self.URFactoryItem_:Dispose()
	AutoChessWishPopView.super.Dispose(self)
end

return AutoChessWishPopView
