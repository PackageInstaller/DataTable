local PaperCutMainView = class("PaperCutMainView", ReduxView)

function PaperCutMainView:UIName()
	return "UI/EmptyDream/PaperCut/PaperCutMainUI"
end

function PaperCutMainView:UIParent()
	return manager.ui.uiMain.transform
end

function PaperCutMainView:Init()
	self.clickSwitchItemHandler_ = handler(self, self.OnClickSwitchItem)
	self.onSenceLoadedHandler_ = handler(self, self.OnSceneLoaded)

	self:InitUI()
	self:AddUIListener()

	self.sceneLoaded_ = false
	self.switchList_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, PaperCutSelectItem)
end

function PaperCutMainView:InitUI()
	self:BindCfgUI()
end

function PaperCutMainView:AddUIListener()
	self:AddBtnListener(self.rewardBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if manager.time:GetServerTime() >= self.stopTime_ then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("paperCutReward", {
			activityID = self.activityID_
		})
	end)
end

function PaperCutMainView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_CUT_DESCRIPE")
	manager.windowBar:RegistBackCallBack(function()
		self:UnLoadPaperCutScene()
		self:Back()
	end)
	manager.windowBar:RegistHomeCallBack(function()
		self:UnLoadPaperCutScene()
		gameContext:Go("/home", nil, nil, true)
	end)

	if self.sceneLoaded_ == false then
		self:LoadPaperCutScene()
	end

	self.activityID_ = self.params_.activityID
	self.stopTime_ = ActivityData:GetActivityData(self.activityID_).stopTime

	self:RefreshUI()
	self:AddTimer()
	manager.redPoint:bindUIandKey(self.rewardBtnTrans_, string.format("%s_%s_Reward", RedPointConst.PAPER_CUT, self.activityID_))
end

function PaperCutMainView:OnExit()
	manager.windowBar:HideBar()
	self:StopTimer()
	manager.redPoint:unbindUIandKey(self.rewardBtnTrans_, string.format("%s_%s_Reward", RedPointConst.PAPER_CUT, self.activityID_))

	self.scrollPos_ = self.switchList_:GetScrolledPosition()
end

function PaperCutMainView:Dispose()
	self.onSenceLoadedHandler_ = nil
	self.clickSwitchItemHandler_ = nil

	self.switchList_:Dispose()
	PaperCutMainView.super.Dispose(self)
end

function PaperCutMainView:LoadPaperCutScene()
	manager.ui:SetMainCamera("paperCut")

	manager.ui.mainCameraCom_.orthographic = true

	PaperCutTool:LoadScene(self.onSenceLoadedHandler_)
end

function PaperCutMainView:OnSceneLoaded()
	self.sceneLoaded_ = true
end

function PaperCutMainView:UnLoadPaperCutScene()
	self.sceneLoaded_ = false

	manager.ui:ResetMainCamera()

	manager.ui.mainCameraCom_.orthographic = false

	PaperCutTool:UnLoadScene()
end

function PaperCutMainView:RefreshUI()
	self.subActivityList_ = ActivityCfg[self.activityID_].sub_activity_list

	if self.scrollPos_ ~= nil then
		self.switchList_:StartScrollByPosition(#self.subActivityList_, self.scrollPos_)
	else
		self.switchList_:StartScroll(#self.subActivityList_)
	end
end

function PaperCutMainView:IndexItem(arg_16_1, arg_16_2)
	arg_16_2:SetData(self.activityID_, self.subActivityList_[arg_16_1])
	arg_16_2:SetClickCallBack(self.clickSwitchItemHandler_)
end

function PaperCutMainView:AddTimer()
	if manager.time:GetServerTime() >= self.stopTime_ then
		self.remainTimeText_.text = GetTips("TIME_OVER")

		return
	end

	self.remainTimeText_.text = manager.time:GetLostTimeStr(self.stopTime_)

	local var_17_0 = self.switchList_:GetItemList()

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		iter_17_1:RefreshLock()
	end

	self:StopTimer()

	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= self.stopTime_ then
			self:StopTimer()

			self.remainTimeText_.text = GetTips("TIME_OVER")

			return
		end

		var_17_0 = self.switchList_:GetItemList()

		for iter_18_0, iter_18_1 in ipairs(var_17_0) do
			iter_18_1:RefreshLock()
		end

		self.remainTimeText_.text = manager.time:GetLostTimeStr(self.stopTime_)
	end, 1, -1)

	self.timer_:Start()
end

function PaperCutMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function PaperCutMainView:OnClickSwitchItem(arg_20_1)
	self.selectActivityID_ = arg_20_1

	self:Go("/paperCutPlay", {
		activityID = arg_20_1,
		mainActivityID = self.activityID_,
		goHomeHandler = handler(self, self.OnGoHome)
	})
	PaperCutTool:GameStart(arg_20_1)
end

function PaperCutMainView:OnGoHome()
	self:UnLoadPaperCutScene()
	gameContext:Go("/home", nil, nil, true)
end

return PaperCutMainView
