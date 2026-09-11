local MythicFinalRankHeroView = class("MythicFinalRankHeroView", ReduxView)

function MythicFinalRankHeroView:UIName()
	return "Widget/System/Challenge_Mythic/MythicRankHeroPopUI"
end

function MythicFinalRankHeroView:UIParent()
	return manager.ui.uiPop.transform
end

function MythicFinalRankHeroView:Init()
	self:InitUI()
	self:AddListeners()
end

function MythicFinalRankHeroView:AddListeners()
	self:AddBtnListener(self.bgbtn_, nil, function()
		JumpTools.Back()
	end)
end

function MythicFinalRankHeroView:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.listgo_, MythicFinalRankHeroItem)
end

function MythicFinalRankHeroView:IndexItem(arg_7_1, arg_7_2)
	arg_7_2:SetData(arg_7_1, self.params_.herolist[arg_7_1], self.userID_)
end

function MythicFinalRankHeroView:OnEnter()
	self.userID_ = self.params_.userID
	self.nametext_.text = GetI18NText(self.params_.name)

	self.list_:StartScroll(#self.params_.herolist)
end

function MythicFinalRankHeroView:Dispose()
	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	MythicFinalRankHeroView.super.Dispose(self)
end

return MythicFinalRankHeroView
