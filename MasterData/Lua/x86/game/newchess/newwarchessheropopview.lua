local NewWarChessHeroPopView = class("NewWarChessHeroPopView", ReduxView)

function NewWarChessHeroPopView:UIName()
	return "UI/NewWarChess/NewWarChessGet"
end

function NewWarChessHeroPopView:UIParent()
	return manager.ui.uiPop.transform
end

function NewWarChessHeroPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function NewWarChessHeroPopView:InitUI()
	self:BindCfgUI()

	self.heroItem_ = NewWarChessHeroItem.New(self.heroGo_)
end

function NewWarChessHeroPopView:AddUIListener()
	self:AddBtnListener(self.backbtn_, nil, function()
		JumpTools.Back()

		if self.params_.callBack then
			self.params_.callBack()
		end
	end)
end

function NewWarChessHeroPopView:OnEnter()
	self.heroItem_:SetData(NewWarChessData:GetHeroInfo(self.params_.newChessHeroID))
end

function NewWarChessHeroPopView:Dispose()
	NewWarChessHeroPopView.super.Dispose(self)

	if self.heroItem_ then
		self.heroItem_:Dispose()

		self.heroItem_ = nil
	end
end

return NewWarChessHeroPopView
