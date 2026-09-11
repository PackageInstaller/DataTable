local AshSectionView = class("AshSectionView", ReduxView)
local var_0_1 = {
	Third = 3,
	Second = 2,
	First = 1
}

function AshSectionView:UIName()
	return "Widget/System/Activity_EkChuah/EkChuah_Com/EkChuah_StageUI"
end

function AshSectionView:UIParent()
	return manager.ui.uiMain.transform
end

function AshSectionView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function AshSectionView:InitUI()
	self:BindCfgUI()

	self.lineList_ = {}
	self.missionItem_ = {}
	self.tabController = self.mainControllerEx_:GetController("SelectStage")
	self.tab = {
		[var_0_1.First] = {
			controller = self.area1Controller_:GetController("default")
		},
		[var_0_1.Second] = {
			controller = self.area2Controller_:GetController("default")
		},
		[var_0_1.Third] = {
			controller = self.area3Controller_:GetController("default")
		}
	}

	self:BuildContext()
end

function AshSectionView:BuildContext()
	self.curSelectTab = -1
	self.curUseLine = 0
	self.curUseItem = 0
	self.selectChild = nil
	self.isSelect = false
end

function AshSectionView:AddUIListeners()
	self:AddBtnListener(self.area1Btn_, nil, function()
		if self.isSelect then
			self:TryToCloseSectionView()

			return
		end

		self:SwitchTab(var_0_1.First)
	end)
	self:AddBtnListener(self.area2Btn_, nil, function()
		if self.isSelect then
			self:TryToCloseSectionView()

			return
		end

		if not AshSystemData:CheckIsOpenArea(var_0_1.Second) then
			ShowTips("ASH_AREA_UNLOCK_TIP_1")

			return
		end

		self:SwitchTab(var_0_1.Second)
	end)
	self:AddBtnListener(self.area3Btn_, nil, function()
		if self.isSelect then
			self:TryToCloseSectionView()

			return
		end

		if not AshSystemData:CheckIsOpenArea(var_0_1.Third) then
			ShowTips("ASH_AREA_UNLOCK_TIP_2")

			return
		end

		self:SwitchTab(var_0_1.Third)
	end)
	self:AddBtnListener(self.limitedBtn_, nil, function()
		if self.isSelect then
			self:TryToCloseSectionView()

			return
		end

		JumpTools.OpenPageByJump("/ashPointView")
	end)
	self:AddBtnListener(self.bgbtn_, nil, function()
		self:TryToCloseSectionView()
	end)
	self.eventTrigger1_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_12_0, arg_12_1)
		self:TryToCloseSectionView()
	end))
	self.eventTrigger1_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_13_0, arg_13_1)
		self:TryToCloseSectionView()
	end))
	self.eventTrigger1_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_14_0, arg_14_1)
		self:TryToCloseSectionView()
	end))
	self.eventTrigger1_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_15_0, arg_15_1)
		self:TryToCloseSectionView()
	end))
	self.eventTrigger1_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_16_0, arg_16_1)
		self:TryToCloseSectionView()
	end))
	self.eventTrigger1_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_17_0, arg_17_1)
		self:TryToCloseSectionView()
	end))
	self.eventTrigger1_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_18_0, arg_18_1)
		self:TryToCloseSectionView()
	end))
	self.eventTrigger1_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_19_0, arg_19_1)
		self:TryToCloseSectionView()
	end))
end

function AshSectionView:TryToCloseSectionView()
	if self:IsOpenSectionInfo() then
		self.isSelect = false
		self.scrollView1_.enabled = true

		self.selectChild:RenderSelect(false)
		SetActive(self.areaGo_, true)

		self.selectChild = nil

		JumpTools.Back()
	end
end

function AshSectionView:OnEnter()
	local var_21_0 = AshSystemData:GetMomoTalkList()

	for iter_21_0 = 1, 4 do
		if not var_21_0[iter_21_0] then
			break
		end

		if var_21_0[iter_21_0].unlockRate and var_21_0[iter_21_0].unlockRate <= AshSystemData:GetHomologyRate() then
			if not (getData("ash", "CowbotPlotUnlock" .. iter_21_0) or AshSystemData:IsMomotalkDone(var_21_0[iter_21_0].correlation_id)) then
				saveData("ash", "CowbotPlotUnlock" .. iter_21_0, true)
				AshSystemAction:ReadMomotalk(var_21_0[iter_21_0].correlation_id)

				self.waitForInit_ = 0

				JumpTools.OpenPageByJump("stageAshMomoTalk", {
					isSelectEnter = true,
					customID = var_21_0[iter_21_0].correlation_id
				})

				return
			end
		end
	end

	if AshSystemData:GetEndStoryIsUnlock() and not (getData("ash", "end_avg") or PlayerData:GetStoryList()[GameSetting.ash_end_story.value[1]] == true) then
		local var_21_2 = self:GetCustomSceneController()

		if var_21_2 then
			var_21_2:ReleaseHero("1083ui_dynamic")
		end

		saveData("ash", "end_avg", true)
		manager.story:StartStoryById(GameSetting.ash_end_story.value[1], function()
			self:OnEnterFunc()
		end)
	else
		self:OnEnterFunc()
	end
end

function AshSectionView:OnEnterFunc()
	self.activityID_ = ActivityConst.ACTIVITY_ASH_MAIN

	local var_23_0 = AshSystemData:GetCacheInfo()

	AshSystemData:SetCacheInfo(nil)

	if self.params_.isBack or self.params_.fromBattle then
		if var_23_0 then
			self:SwitchTab(var_23_0.tab, true)

			self.content1_.transform.localPosition = Vector3.New(var_23_0.positionx, var_23_0.positiony, var_23_0.positionz)

			self:SelectStage(self.missionItem_[var_23_0.index])
		end

		for iter_23_0 = 2, 3 do
			self["area" .. iter_23_0 .. "Anim_"].enabled = false
		end

		if self.params_.fromBattle then
			self.params_.fromBattle = nil

			self:ResetSelect()
		end
	elseif self.params_.lastOpenArea then
		self:SwitchTab(self.params_.lastOpenArea, true)

		self.params_.lastOpenArea = nil

		self:ResetSelect()
	else
		self:SwitchTab(var_0_1.First, true)
		self:ResetSelect()
	end

	self:RefreshLimitTime()
	self:RefreshTask()
	self:bindRed()
	AshSystemData:UpdateTaskRedPoint()
end

function AshSectionView:ResetSelect()
	SetActive(self.areaGo_, true)

	self.isSelect = false
	self.scrollView1_.enabled = true

	if self.selectChild then
		self.selectChild:RenderSelect(false)
	end

	self.selectChild = nil
end

function AshSectionView:bindRed()
	manager.redPoint:bindUIandKey(self.limitedBtn_.transform, RedPointConst.ASH_ACTIVITY_RESIDENT_TASK .. ActivityConst.ACTIVITY_ASH_MAIN)
	manager.redPoint:bindUIandKey(self.area1Btn_.transform, RedPointConst.ASH_ACTIVITY_SECTION_AREA .. 1)
	manager.redPoint:bindUIandKey(self.area2Btn_.transform, RedPointConst.ASH_ACTIVITY_SECTION_AREA .. 2)
	manager.redPoint:bindUIandKey(self.area3Btn_.transform, RedPointConst.ASH_ACTIVITY_SECTION_AREA .. 3)
end

function AshSectionView:unbindRed()
	manager.redPoint:unbindUIandKey(self.limitedBtn_.transform)
	manager.redPoint:unbindUIandKey(self.area1Btn_.transform)
	manager.redPoint:unbindUIandKey(self.area2Btn_.transform)
	manager.redPoint:unbindUIandKey(self.area3Btn_.transform)
end

function AshSectionView:SwitchTab(arg_27_1, arg_27_2)
	if not AshSystemData:CheckIsOpenArea(arg_27_1) then
		return
	end

	if arg_27_2 or arg_27_1 ~= self.curSelectTab then
		self.curSelectTab = arg_27_1

		self.tabController:SetSelectedState("state" .. arg_27_1)
		self.scrollView1_:StopMovement()

		self.content1_.transform.localPosition = Vector3.New(0, self.content1_.transform.localPosition.y, self.content1_.transform.localPosition.z)

		self:RenderSection()
		self:RenderTab()
		self.mainAnimator_:Play("UI_complete_cx 1", 0, 0)

		for iter_27_0, iter_27_1 in ipairs(self.missionItem_) do
			iter_27_1:RefreshAnim()
		end
	end
end

function AshSectionView:RenderTab()
	for iter_28_0 = 1, 3 do
		SetActive(self["lock" .. iter_28_0 .. "Obj_"], false)
	end

	for iter_28_1 = 1, 3 do
		if AshSystemData:CheckIsOpenArea(iter_28_1) then
			if self.curSelectTab == iter_28_1 then
				self.tab[iter_28_1].controller:SetSelectedState("select")
			else
				self.tab[iter_28_1].controller:SetSelectedState("default")

				if iter_28_1 ~= 1 then
					local var_28_0 = "CowbotSectionTabLock" .. iter_28_1

					if not getData("ash", "CowbotSectionTabLock" .. iter_28_1) then
						FrameTimer.New(function()
							self.aniTimer_ = Timer.New(function()
								if self["area" .. iter_28_1 .. "Anim_"]:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
									if self.aniTimer_ then
										self.aniTimer_:Stop()

										self.aniTimer_ = nil
									end

									saveData("ash", var_28_0, true)
									manager.ui:UIEventEnabled(true)
								end
							end, 0.033, -1)

							manager.ui:UIEventEnabled(false)

							self["area" .. iter_28_1 .. "Anim_"].enabled = true

							SetActive(self["lock" .. iter_28_1 .. "Obj_"], true)
							self["area" .. iter_28_1 .. "Anim_"]:Play("stageGroup_unlock", 0, 0)
							self.aniTimer_:Start()
						end, 1, 1):Start()
					end
				end
			end
		else
			self.tab[iter_28_1].controller:SetSelectedState("lock")
		end
	end
end

function AshSectionView:RenderSection()
	self:ResetAll()

	local var_31_0 = AshTools:GetTypeLevels(self.curSelectTab)
	local var_31_1 = true
	local var_31_2 = -350
	local var_31_3 = 50
	local var_31_4 = -400
	local var_31_5 = 480
	local var_31_6 = 150

	for iter_31_0, iter_31_1 in ipairs(var_31_0) do
		if var_31_1 then
			var_31_1 = false
		else
			var_31_4 = var_31_4 + var_31_5
		end

		var_31_4 = var_31_4 + var_31_6
	end

	self:CalculateWidth(var_31_4)

	local var_31_8 = 200
	local var_31_9 = true
	local var_31_10 = true

	for iter_31_2, iter_31_3 in ipairs(var_31_0) do
		if var_31_10 then
			var_31_10 = false
		else
			self:InstLine():RefreshUI(Vector3.New(var_31_8 + var_31_5 / 2 - 5, var_31_2, 0), var_31_9 and true or false)

			var_31_8 = var_31_8 + var_31_5
		end

		self:InstItem():RenderItem({
			level = iter_31_3,
			index = iter_31_2
		}, Vector3.New(var_31_8 + var_31_6 / 2, var_31_2 + (var_31_9 and -1 or 1) * var_31_3, 0))

		var_31_8 = var_31_8 + var_31_6
		var_31_9 = not var_31_9
	end

	local var_31_11 = 1

	for iter_31_4, iter_31_5 in ipairs(self.missionItem_) do
		if iter_31_5:GetIsUnlock() then
			var_31_11 = iter_31_4
		else
			break
		end
	end

	local var_31_12 = self.missionItem_[var_31_11]

	if not self.missionItem_[var_31_11] then
		return
	end

	self.content1_.transform.localPosition = Vector3(-var_31_12.transform_.localPosition.x + self.scrollViewTrans_.rect.width / 2 - var_31_12.transform_.rect.width / 2, 0, 0)
end

function AshSectionView:CalculateWidth(arg_32_1)
	self.contentTrans_.transform.sizeDelta = Vector2(arg_32_1 + self.viewport_.rect.width / 2, 700)
end

function AshSectionView:SelectStage(arg_33_1)
	if self.selectChild then
		self.selectChild:RenderSelect(false)
	end

	self.selectChild = arg_33_1

	if self.selectChild then
		SetActive(self.areaGo_, false)
		self.selectChild:RenderSelect(true)
		self:OnSelectLevelItem(arg_33_1)
	end
end

function AshSectionView:RefreshTask()
	local var_34_0 = ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_ASH_COIN_4_4.item_id)

	self.processTxt_.text = string.format("%d/%d", var_34_0, GameSetting.skuld_trust_max.value[1])
	self.progressImg_.fillAmount = var_34_0 / GameSetting.skuld_trust_max.value[1]
end

function AshSectionView:RefreshLimitTime()
	local var_35_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_ASH_LIMITED_TASK)

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_ASH_LIMITED_TASK) then
		SetActive(self.limitedBtn_.gameObject, true)

		self.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_35_0.stopTime)
	else
		SetActive(self.limitedBtn_.gameObject, false)
	end

	self:LimitStopTimer()

	if self.limittimer_ == nil then
		self.limittimer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(self.activityID_) then
				self.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_35_0.stopTime)
			else
				if manager.time:GetServerTime() < var_35_0.startTime then
					self.limitTimeTxt_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStr2(var_35_0.startTime))
				elseif manager.time:GetServerTime() > var_35_0.stopTime then
					self.limitTimeTxt_.text = GetTips("TIME_OVER")
				end

				SetActive(self.limitedBtn_.gameObject, false)
			end
		end, 1, -1)
	end

	self.limittimer_:Start()
end

function AshSectionView:LimitStopTimer()
	if self.limittimer_ then
		self.limittimer_:Stop()

		self.limittimer_ = nil
	end
end

function AshSectionView:IsOpenSectionInfo()
	return self:IsOpenRoute("ashSectionBaseView")
end

function AshSectionView:ResetAll()
	self.curUseLine = 0
	self.curUseItem = 0
end

function AshSectionView:InstLine()
	self.curUseLine = self.curUseLine + 1

	if #self.lineList_ < self.curUseLine then
		table.insert(self.lineList_, AshSectionLineItem.New(self.content1_.transform))
	end

	return self.lineList_[self.curUseLine]
end

function AshSectionView:InstItem()
	self.curUseItem = self.curUseItem + 1

	if #self.missionItem_ < self.curUseItem then
		table.insert(self.missionItem_, AshSectionItem.New(self.content1_.transform, self, handler(self, self.ResetSelect)))
	end

	return self.missionItem_[self.curUseItem]
end

function AshSectionView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function AshSectionView:OnSelectLevelItem(arg_43_1)
	if arg_43_1 then
		self.isSelect = true
		self.scrollView1_.enabled = false

		self:RemoveTween()

		self.tween_ = LeanTween.value(self.content1_, self.content1_.transform.localPosition.x, -arg_43_1.transform_.localPosition.x + self.scrollViewTrans_.rect.width / 2 - arg_43_1.transform_.rect.width / 2, 0.2):setOnUpdate(LuaHelper.FloatAction(function(arg_44_0)
			self.content1_.transform.localPosition = Vector3(arg_44_0, 0, 0)
		end))
	end
end

function AshSectionView:RemoveTween()
	if self.tween_ then
		self.tween_:setOnUpdate(nil)
		LeanTween.cancel(self.content1_)

		self.tween_ = nil
	end
end

function AshSectionView:OnTop()
	if self.waitForInit_ then
		self.waitForInit_ = self.waitForInit_ + 1

		if self.waitForInit_ >= 2 then
			self:OnEnterFunc()

			self.waitForInit_ = nil
		end
	end

	self:UpdateBar()
end

function AshSectionView:OnBehind()
	manager.windowBar:HideBar()
end

function AshSectionView:OnExit()
	if self.aniTimer_ then
		manager.ui:UIEventEnabled(true)
		self.aniTimer_:Stop()

		self.aniTimer_ = nil
	end

	self:unbindRed()
	self:RemoveTween()
	self:LimitStopTimer()

	if self.selectChild then
		AshSystemData:SetCacheInfo({
			tab = self.curSelectTab,
			index = self.selectChild:GetIndex(),
			positionx = self.content1_.transform.localPosition.x,
			positiony = self.content1_.transform.localPosition.y,
			positionz = self.content1_.transform.localPosition.z
		})
	end
end

function AshSectionView:Dispose()
	if self.aniTimer_ then
		manager.ui:UIEventEnabled(true)
		self.aniTimer_:Stop()

		self.aniTimer_ = nil
	end

	self:RemoveTween()
	self:LimitStopTimer()
	self.super.Dispose(self)
end

return AshSectionView
