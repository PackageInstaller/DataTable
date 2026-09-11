local SPKailiChallengeIllustratedView = class("SPKailiChallengeIllustratedView", ReduxView)

function SPKailiChallengeIllustratedView:Init()
	self:BindCfgUI()

	self.nodeList = {}

	self:AddListeners()

	self.stageList_ = LuaList.New(handler(self, self.IndexItem), self.uilistUilist_, SpKaliTreasureItem)
end

function SPKailiChallengeIllustratedView:IndexItem(arg_2_1, arg_2_2)
	arg_2_2:SetData(self.pointlist[arg_2_1])
end

function SPKailiChallengeIllustratedView:UIParent()
	return manager.ui.uiMain.transform
end

function SPKailiChallengeIllustratedView:OnCtor()
	return
end

function SPKailiChallengeIllustratedView:UIName()
	return "Widget/Version/ShashwatUI_3_6/ShashwatUI_3_6_kaliUI/ShashwatUI_3_6_kaliFistAffixPopUI"
end

function SPKailiChallengeIllustratedView:AddListeners()
	self:AddBtnListener(self.btnbackBtn_, nil, function()
		self:Back()
	end)
end

function SPKailiChallengeIllustratedView:UpdateData(arg_8_1)
	self.pointlist = SPKaliChallengeData:GetShowTreasureList(self.activityID) or {}
end

function SPKailiChallengeIllustratedView:RefreshStageList()
	self.stageList_:StartScroll(#self.pointlist)
end

function SPKailiChallengeIllustratedView:OnEnter()
	if self.params_ then
		self.activityID = self.params_.activityID_ or ActivityConst.ACTIVITY_3_6_KALI_FIGHT
	end

	SPKailiChallengeIllustratedView.super.OnEnter(self)
	self:UpdateData(self.activityID)
	self:RefreshStageList()
end

function SPKailiChallengeIllustratedView:OnTop()
	self:ChangeBar()
end

function SPKailiChallengeIllustratedView:OnExit()
	SPKailiChallengeIllustratedView.super.OnExit(self)
end

function SPKailiChallengeIllustratedView:ChangeBar()
	manager.windowBar:SwitchBar({})
end

function SPKailiChallengeIllustratedView:RefreshAffixDes()
	return
end

function SPKailiChallengeIllustratedView:Dispose()
	SPKailiChallengeIllustratedView.super.Dispose(self)
	self.stageList_:Dispose()

	self.stageList_ = nil

	SPKailiChallengeIllustratedView.super.Dispose(self)
end

return SPKailiChallengeIllustratedView
