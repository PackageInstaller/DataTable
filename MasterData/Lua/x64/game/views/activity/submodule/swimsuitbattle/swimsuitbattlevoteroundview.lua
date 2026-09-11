local SwimsuitBattleVoteRoundView = class("SwimsuitBattleVoteRoundView", ReduxView)

function SwimsuitBattleVoteRoundView:UIName()
	return "Widget/Version/SummerUI_3_4/SummerUI_3_4_SwimsuitUI/SummerUI_3_4_SwimsuitVoteRoundUI_new"
end

function SwimsuitBattleVoteRoundView:UIParent()
	return manager.ui.uiMain.transform
end

function SwimsuitBattleVoteRoundView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SwimsuitBattleVoteRoundView:InitUI()
	self:BindCfgUI()

	self.roundItemList_ = {}

	for iter_4_0 = 1, 3 do
		if self["round" .. iter_4_0 .. "Go_"] then
			self.roundItemList_[iter_4_0] = SwimsuitBattleVoteRoundItem.New(self["round" .. iter_4_0 .. "Go_"])
		end
	end

	self.roundFinalItem_ = SwimsuitBattleVoteRoundFinalItem.New(self.round4Go_)
end

function SwimsuitBattleVoteRoundView:AddUIListeners()
	return
end

function SwimsuitBattleVoteRoundView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	for iter_6_0 = 1, #self.roundItemList_ do
		self.roundItemList_[iter_6_0]:SetData(iter_6_0)
	end

	self.roundFinalItem_:SetData(4)
end

function SwimsuitBattleVoteRoundView:OnExit()
	manager.windowBar:HideBar()
end

function SwimsuitBattleVoteRoundView:Dispose()
	self:RemoveAllListeners()

	for iter_8_0 = 1, 3 do
		if self.roundItemList_[iter_8_0] then
			self.roundItemList_[iter_8_0]:Dispose()

			self.roundItemList_[iter_8_0] = nil
		end
	end

	if self.roundFinalItem_ then
		self.roundFinalItem_:Dispose()

		self.roundFinalItem_ = nil
	end

	SwimsuitBattleVoteRoundView.super.Dispose(self)
end

return SwimsuitBattleVoteRoundView
