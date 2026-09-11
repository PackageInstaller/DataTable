local AutoChessOpenCardInfoPopView = class("AutoChessOpenCardInfoPopView", ReduxView)

function AutoChessOpenCardInfoPopView:UIName()
	return "Widget/System/Pool/PoolInfoPopUI"
end

function AutoChessOpenCardInfoPopView:UIParent()
	return manager.ui.uiPop.transform
end

function AutoChessOpenCardInfoPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AutoChessOpenCardInfoPopView:InitUI()
	self:BindCfgUI()

	self.stateCon_ = self.controllerEx_:GetController("state")
	self.recordView = AutoChessOpenCardInfoPopRecordView.New(self.recordGo_)
	self.bonusController_ = self.controllerEx_:GetController("ExtractReturn")
	self.pieceController_ = self.controllerEx_:GetController("ExtractPiece")
	self.hideTab4Controller_ = self.controllerEx_:GetController("tabltem04")

	self.hideTab4Controller_:SetSelectedState("off")
end

function AutoChessOpenCardInfoPopView:AddUIListener()
	self:AddBtnListener(self.bgMask_, nil, function()
		self.stateCon_:SetSelectedState("info")
		self:Back()
	end)
	self:AddBtnListener(self.btnInfo_, nil, function()
		self.stateCon_:SetSelectedState("info")
	end)
	self:AddBtnListener(self.btnRecord_, nil, function()
		AutoChessCardAction.RequestRecord(handler(self, self.OnRequestRecordBack))
		self.stateCon_:SetSelectedState("record")
	end)
end

function AutoChessOpenCardInfoPopView:OnEnter()
	self.stateCon_:SetSelectedState("info")
	self.ani_:Update(0)
	self:RefreshInfo()
	self.recordView:OnEnter()
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.layout_1)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.infoContent_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.layout_2)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.layout_3)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.layout_4)
	TimeTools.StartAfterSeconds(0.033, function()
		self.contentTrs_.localPosition = Vector3.New(0, 0, 0)
		self.infoContent_.localPosition = Vector3.New(0, 0, 0)
	end, {})
end

function AutoChessOpenCardInfoPopView:OnRequestRecordBack()
	self:RefreshRecord()
end

function AutoChessOpenCardInfoPopView:RefreshInfo()
	self.infoTxt_.text = GetTips("AUTO_CHESS_2_CARD_DRAW_RULE")
	self.txtSelectTab1_.text = GetTips("AUTO_CHESS_2_DRAW_TAB_RULE")
	self.txtTab1_.text = GetTips("AUTO_CHESS_2_DRAW_TAB_RULE")
	self.txtSelectTab3_.text = GetTips("AUTO_CHESS_2_DRAW_TAB_HISTORY")
	self.txtTab3_.text = GetTips("AUTO_CHESS_2_DRAW_TAB_HISTORY")
end

function AutoChessOpenCardInfoPopView:RefreshRecord()
	self.recordView:RefreshRecord()
end

function AutoChessOpenCardInfoPopView:Dispose()
	self.recordView:Dispose()
	AutoChessOpenCardInfoPopView.super.Dispose(self)
end

return AutoChessOpenCardInfoPopView
