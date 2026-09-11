local TowerGameView = class("TowerGameView", ReduxView)

function TowerGameView:UIName()
	return "UI/MardukUI/snakeactive/MardukSnakemainUI"
end

function TowerGameView:UIParent()
	return manager.ui.uiMain.transform
end

function TowerGameView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function TowerGameView:InitUI()
	self:BindCfgUI()

	self.selectStageItemHandler_ = handler(self, self.OnSelectStageItem)
	self.list_ = LuaList.New(handler(self, self.IndexItem), self.uiList_, TowerGameItem)
end

function TowerGameView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_1)
	arg_5_2:SetSelectCallBack(self.selectStageItemHandler_)
end

function TowerGameView:OnEnter()
	self:RefreshUI()

	self.stopTime_ = ActivityData:GetActivityData(ActivityConst.FACTORY_TOWERGAME).stopTime
	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() < self.stopTime_ then
			self.timeText_.text = manager.time:GetLostTimeStr(self.stopTime_)

			self:RefreshItemTime()
		else
			self:StopTimer()

			self.timeText_.text = GetTips("TIME_OVER")

			return
		end
	end, 1, -1)

	self.timer_:Start()
end

function TowerGameView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_TOWER_DEFENSE_DESC")
	manager.windowBar:RegistBackCallBack(function()
		if self:IsOpenSectionView() then
			self:RefreshSelectStageItem(0)

			self.m_scrollCom.horizontal = true
		end

		JumpTools.Back()
	end)
end

function TowerGameView:OnTowerGameBack()
	if self:IsOpenSectionView() then
		self:RefreshSelectStageItem(0)

		self.m_scrollCom.horizontal = true
	end
end

function TowerGameView:OnTowerGameRefresh()
	self.list_:Refresh()
end

function TowerGameView:RefreshUI()
	self.stopTime_ = ActivityData:GetActivityData(ActivityConst.FACTORY_TOWERGAME).stopTime
	self.timeText_.text = manager.time:GetServerTime() < self.stopTime_ and manager.time:GetLostTimeStr(self.stopTime_) or GetTips("TIME_OVER")

	self.list_:StartScroll(#TowerGameCfg.all)
	self:RefreshSelectStageItem(0)
	self:RefreshItemTime()
	manager.redPoint:bindUIandKey(self.rewardbtntrans_, RedPointConst.MARDUK_TOWERGAME_REWARD)
end

function TowerGameView:RefreshItemTime()
	for iter_13_0, iter_13_1 in pairs((self.list_:GetItemList())) do
		iter_13_1:UpdateTime()
	end
end

function TowerGameView:AddUIListeners()
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("towerGameRewardView", {
			activityId = self.activityID_
		})
	end)
	self:AddBtnListener(self.planeBtn_, nil, function()
		JumpTools.OpenPageByJump("towerGamePlaneView", {
			activityId = self.activityID_
		})
	end)
	self:AddBtnListener(self.bgbtn_, nil, function()
		self:TryToCloseSectionView()
	end)
	self.scrollViewEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_18_0, arg_18_1)
		self:TryToCloseSectionView()
	end))
	self.scrollViewEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_19_0, arg_19_1)
		self:TryToCloseSectionView()
	end))
end

function TowerGameView:IsOpenSectionView()
	return self:IsOpenRoute("towerGameSectionInfoView")
end

function TowerGameView:OnBehind()
	manager.windowBar:HideBar()
end

function TowerGameView:OnExit()
	manager.windowBar:HideBar()
	self:StopTimer()
	self:RemoveTween()
	manager.redPoint:unbindUIandKey(self.rewardbtntrans_, RedPointConst.MARDUK_TOWERGAME_REWARD)
end

function TowerGameView:OnSelectStageItem(arg_23_1, arg_23_2)
	self:RefreshSelectStageItem(arg_23_1)
	TowerGameData:SetLevleClick(arg_23_1)

	local var_23_0 = self.list_:GetItemList()[arg_23_2]

	if var_23_0 then
		self.m_scrollCom.horizontal = false

		self:RemoveTween()

		self.tween_ = LeanTween.value(self.m_scrollContent, self.m_scrollContent.transform.localPosition.x, -var_23_0.transform_.localPosition.x + self.m_scrollViewTrans.rect.width / 3 - var_23_0.transform_.rect.width / 2, 0.2):setOnUpdate(LuaHelper.FloatAction(function(arg_24_0)
			self.m_scrollContent.transform.localPosition = Vector3(arg_24_0, 0, 0)
		end))
	else
		self.m_scrollCom.horizontal = true
	end

	if self:IsOpenSectionView() then
		JumpTools.Back()
	end
end

function TowerGameView:RemoveTween()
	if self.tween_ then
		self.tween_:setOnUpdate(nil)
		LeanTween.cancel(self.m_scrollContent)

		self.tween_ = nil
	end
end

function TowerGameView:TryToCloseSectionView()
	if self:IsOpenSectionView() then
		self:RefreshSelectStageItem(0)

		self.m_scrollCom.horizontal = true

		JumpTools.Back()
	end
end

function TowerGameView:RefreshSelectStageItem(arg_27_1)
	self.selectStageID_ = arg_27_1

	for iter_27_0, iter_27_1 in pairs((self.list_:GetItemList())) do
		iter_27_1:RefreshSelect(self.selectStageID_)
	end
end

function TowerGameView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function TowerGameView:Dispose()
	TowerGameView.super.Dispose(self)
	self.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerDown)
	self.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	self:StopTimer()

	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	self.selectStageItemHandler_ = nil
end

return TowerGameView
