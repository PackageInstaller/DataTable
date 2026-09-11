local MoonCakeDelegateRecordView = class("MoonCakeDelegateRecordView", ReduxView)

function MoonCakeDelegateRecordView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonCakeDelegateRecordUI"
end

function MoonCakeDelegateRecordView:UIParent()
	return manager.ui.uiPop.transform
end

function MoonCakeDelegateRecordView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MoonCakeDelegateRecordView:InitUI()
	self:BindCfgUI()

	self.typeController_ = ControllerUtil.GetController(self.transform_, "type")
	self.submitedDelegateList_ = LuaList.New(handler(self, self.IndexSubmitedItem), self.completedListGo_, MoonCakeDelegateItem)
	self.ownDelegateList_ = LuaList.New(handler(self, self.IndexOwnItem), self.ownListGo_, MoonCakeOwnDelegateItem)
	self.recordTypeConst_ = {
		other = 2,
		own = 1
	}
end

function MoonCakeDelegateRecordView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function MoonCakeDelegateRecordView:Dispose()
	self.submitedDelegateList_:Dispose()

	self.submitedDelegateList_ = nil

	self.ownDelegateList_:Dispose()

	self.ownDelegateList_ = nil

	MoonCakeDelegateRecordView.super.Dispose(self)
end

function MoonCakeDelegateRecordView:OnEnter()
	self.activityID_ = self.params_.activityID

	if self.params_.isBack then
		self.curType_ = MoonCakeTools.GetTempRecordViewType(self.activityID_)
		self.tempScrollPos_ = MoonCakeTools.GetTempRecordViewScrollPos(self.activityID_)
	else
		self.curType_ = self.params_.recoverType
		self.tempScrollPos_ = nil
	end

	if self.recordTypeConst_.own == self.curType_ then
		self:RefreshOwnDelegate(self.tempScrollPos_)
	else
		self:RefreshSubmitedDelegate(self.tempScrollPos_)
	end

	self.typeController_:SetSelectedIndex(self.curType_ - 1)
end

function MoonCakeDelegateRecordView:OnExit()
	MoonCakeTools.SetTempRecordViewType(self.activityID_, self.curType_)
	MoonCakeTools.SetTempRecordViewScrollPos(self.activityID_, self.curType_ == self.recordTypeConst_.own and self.ownDelegateList_:GetScrolledPosition() or self.submitedDelegateList_:GetScrolledPosition())

	self.tempScrollPos_ = nil
end

function MoonCakeDelegateRecordView:RefreshSubmitedDelegate(arg_10_1)
	self.submitedDelegateDataList_ = MoonCakeData:GetSubmitedDelegateList(self.activityID_)

	if not arg_10_1 then
		self.submitedDelegateList_:StartScroll(#self.submitedDelegateDataList_)
	else
		self.submitedDelegateList_:StartScrollByPosition(#self.submitedDelegateDataList_, arg_10_1)
	end
end

function MoonCakeDelegateRecordView:RefreshOwnDelegate(arg_11_1)
	self.ownDelegateDataList_ = MoonCakeData:GetOwnSubmitedDelegateList(self.activityID_)

	if not arg_11_1 then
		self.ownDelegateList_:StartScroll(#self.ownDelegateDataList_)
	else
		self.ownDelegateList_:StartScrollByPosition(#self.ownDelegateDataList_, arg_11_1)
	end
end

function MoonCakeDelegateRecordView:IndexSubmitedItem(arg_12_1, arg_12_2)
	arg_12_2:SetData(self.submitedDelegateDataList_[arg_12_1], self.activityID_)
end

function MoonCakeDelegateRecordView:IndexOwnItem(arg_13_1, arg_13_2)
	arg_13_2:SetData(self.ownDelegateDataList_[arg_13_1], self.activityID_)
end

function MoonCakeDelegateRecordView:OnReceiveDelegateReward()
	self:RefreshOwnDelegate()
end

function MoonCakeDelegateRecordView:OnFriendsListChange()
	for iter_15_0, iter_15_1 in ipairs(self.recordTypeConst_.own == self.curType_ and self.ownDelegateList_:GetItemList() or self.submitedDelegateList_:GetItemList()) do
		iter_15_1:RefreshFriend()
	end
end

return MoonCakeDelegateRecordView
