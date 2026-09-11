local AutoChessHeadTipsCollectPopView = class("AutoChessHeadTipsCollectPopView", ReduxView)

function AutoChessHeadTipsCollectPopView:UIName()
	return "Widget/System/Activity_Xihe/Com/Com_Xihe_Tips"
end

function AutoChessHeadTipsCollectPopView:UIParent()
	return manager.ui.uiPop.transform
end

function AutoChessHeadTipsCollectPopView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function AutoChessHeadTipsCollectPopView:AddUIListeners()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function AutoChessHeadTipsCollectPopView:InitUI()
	self:BindCfgUI()

	self.Item1_ = AutoChessCardCollectInfoItem.New(self.tipsGo1_, AutoChessCardConst.CARD_TYPE.UR)
	self.Item2_ = AutoChessCardCollectInfoItem.New(self.tipsGo2_, AutoChessCardConst.CARD_TYPE.SR)
	self.Item3_ = AutoChessCardCollectInfoItem.New(self.tipsGo3_, AutoChessCardConst.CARD_TYPE.R)
end

function AutoChessHeadTipsCollectPopView:OnEnter()
	self.Item1_:RefreshUI()
	self.Item2_:RefreshUI()
	self.Item3_:RefreshUI()

	self.txtName_.text = PlayerData:GetPlayerInfo().nick
end

function AutoChessHeadTipsCollectPopView:Dispose()
	self.Item1_:Dispose()
	self.Item2_:Dispose()
	self.Item3_:Dispose()
	AutoChessHeadTipsCollectPopView.super.Dispose(self)
end

return AutoChessHeadTipsCollectPopView
