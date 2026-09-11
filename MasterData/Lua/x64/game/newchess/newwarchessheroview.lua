local NewWarChessHeroView = class("NewWarChessHeroView", ReduxView)

function NewWarChessHeroView:UIName()
	return "UI/NewWarChess/NewWarChessTeamUIPop"
end

function NewWarChessHeroView:UIParent()
	return manager.ui.uiPop.transform
end

function NewWarChessHeroView:Init()
	self:InitUI()
	self:AddUIListener()
end

function NewWarChessHeroView:InitUI()
	self:BindCfgUI()

	self.List_ = LuaList.New(handler(self, self.indexItem), self.listGo_, NewWarChessHeroItem)
end

function NewWarChessHeroView:indexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.heroInfoList_[arg_5_1])
	arg_5_2:EnableSkillItemClick()
	arg_5_2:BindSkillRedPoint()
end

function NewWarChessHeroView:AddUIListener()
	self:AddBtnListener(self.backbtn_, nil, function()
		JumpTools.Back()
	end)
end

function NewWarChessHeroView:OnEnter()
	self:RefreshUI()
end

function NewWarChessHeroView:RefreshUI()
	self.heroInfoList_ = NewWarChessData:GetHeroInfoList()

	self.List_:StartScroll(#self.heroInfoList_)
end

function NewWarChessHeroView:Dispose()
	NewWarChessHeroView.super.Dispose(self)

	if self.List_ then
		self.List_:Dispose()

		self.List_ = nil
	end
end

return NewWarChessHeroView
