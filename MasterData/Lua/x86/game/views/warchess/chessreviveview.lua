local WarChessReviveView = class("WarChessReviveView", ReduxView)

function WarChessReviveView:UIName()
	return "Widget/System/WarChess_Battle/WarChessReviveUI"
end

function WarChessReviveView:UIParent()
	return manager.ui.uiPop.transform
end

function WarChessReviveView:Init()
	self.selectItem_ = 1

	self:InitUI()
	self:AddUIListener()
end

function WarChessReviveView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.indexItem), self.panelitemGo_, ChessReviveItem)
end

function WarChessReviveView:AddUIListener()
	self:AddBtnListener(self.okbtnBtn_, nil, function()
		if self.selectItem_ ~= 0 then
			WarChessAction.ReviveHero(self.pos_, self.itemList_[self.selectItem_])
		end
	end)
end

function WarChessReviveView:UpdateData()
	self.itemList_ = {}

	for iter_7_0, iter_7_1 in pairs((WarChessData:GetHeroList())) do
		if iter_7_1 <= 0 then
			table.insert(self.itemList_, iter_7_0)
		end
	end
end

function WarChessReviveView:indexItem(arg_8_1, arg_8_2)
	arg_8_2:RefreshUI(self.itemList_[arg_8_1], arg_8_1)
	arg_8_2:ShowSelect(arg_8_1 == self.selectItem_)
	arg_8_2:RegisterListener(function(arg_9_0)
		for iter_9_0, iter_9_1 in pairs((self.scrollHelper_:GetItemList())) do
			iter_9_1:ShowSelect(arg_9_0 == iter_9_0)

			self.selectItem_ = arg_9_0
		end
	end)
end

function WarChessReviveView:OnEnter()
	self.selectItem_ = 1
	self.pos_ = {
		x = self.params_.x,
		z = self.params_.z
	}
	self.callback_ = self.params_.callback

	self:UpdateData()
	self.scrollHelper_:StartScroll(#self.itemList_)
end

function WarChessReviveView:OnExit()
	return
end

function WarChessReviveView:OnReviveHero(arg_12_1, arg_12_2)
	if isSuccess(arg_12_1.result) then
		WarChessData:ModifyHp(arg_12_2.param, 10000)
		self:Back()
		self.callback_()
	else
		manager.ChessManager:EventsEnd()
		ShowTips(arg_12_1.result)
	end
end

function WarChessReviveView:Dispose()
	self.scrollHelper_:Dispose()
	WarChessReviveView.super.Dispose(self)
end

return WarChessReviveView
