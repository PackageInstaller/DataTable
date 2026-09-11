local SwimsuitBattleResultView = class("SwimsuitBattleResultView", ReduxView)

function SwimsuitBattleResultView:UIName()
	return "Widget/Version/SummerUI_3_4/SummerUI_3_4_SwimsuitUI/SummerUI_3_4_SwimsuitResultUI"
end

function SwimsuitBattleResultView:UIParent()
	return manager.ui.uiPop.transform
end

function SwimsuitBattleResultView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SwimsuitBattleResultView:InitUI()
	self:BindCfgUI()

	self.voteData_ = {}
	self.round_ = 0
	self.resultController_ = self.mainControllerEx_:GetController("result")
	self.winerUIList_ = LuaList.New(handler(self, self.IndexTabItem), self.startUIList_, SwimsuitBattleResultItem)
end

function SwimsuitBattleResultView:IndexTabItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.voteData_[arg_5_1].ID)
end

function SwimsuitBattleResultView:AddUIListeners()
	self:AddBtnListener(self.retBtn_, nil, function()
		self:Back()
	end)
end

function SwimsuitBattleResultView:OnEnter()
	self.round_ = SwimsuitBattleData:GetCurVoteRound()

	if self.round_ == 5 then
		self.voteData_ = SwimsuitBattleData:GetWinerListByRound(4)

		self.resultController_:SetSelectedState("result")
		self.winerUIList_:StartScroll(0)

		self.win1Img_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. SwimsuitVoteHeroCfg[self.voteData_[1].ID].show_image)
		self.win2Img_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. SwimsuitVoteHeroCfg[self.voteData_[2].ID].show_image)
		self.win3Img_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. SwimsuitVoteHeroCfg[self.voteData_[3].ID].show_image)
	else
		self.voteData_ = SwimsuitBattleData:GetSortVoteContestantsData(self.round_)

		self.resultController_:SetSelectedState("start")
		self.winerUIList_:StartScroll(#self.voteData_)
	end
end

function SwimsuitBattleResultView:OnExit()
	return
end

function SwimsuitBattleResultView:Dispose()
	self:RemoveAllListeners()

	if self.winerUIList_ then
		self.winerUIList_:Dispose()

		self.winerUIList_ = nil
	end

	SwimsuitBattleResultView.super.Dispose(self)
end

return SwimsuitBattleResultView
