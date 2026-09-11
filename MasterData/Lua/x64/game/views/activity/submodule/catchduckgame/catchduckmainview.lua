local CatchDuckMainView = class("CatchDuckMainView", ReduxView)

function CatchDuckMainView:UIName()
	return "Widget/System/Summer2024/Summer2024_Duck/DuckPartyEntranceUI"
end

function CatchDuckMainView:UIParent()
	return manager.ui.uiMain.transform
end

function CatchDuckMainView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function CatchDuckMainView:InitUI()
	self:BindCfgUI()

	self.stateController_ = self.controllerEx_:GetController("state")
	self.endlessController_ = self.controllerEx_:GetController("endless")
	self.maskController_ = self.controllerEx_:GetController("mask")
	self.tabController_ = self.btnCon_:GetController("status")
	self.poolItemList_ = {}

	for iter_4_0 = 1, 8 do
		self.poolItemList_[iter_4_0] = CatchDuckStageItem.New(self["itemPool_" .. iter_4_0])

		self.poolItemList_[iter_4_0]:SetSelectCallBack(handler(self, self.OnSelectStageItem))
	end

	self.poolItemEndless_ = CatchDuckStageItem.New(self.itemEndlessPool_)

	self.poolItemEndless_:SetSelectCallBack(handler(self, self.OnSelectStageItem))

	self.endlessId_ = ActivityCatchDuckCfg.get_id_list_by_type[2][1]
end

function CatchDuckMainView:AddUIListeners()
	self:AddBtnListener(self.btnMask_, nil, function()
		self:CloseSectionInfo()
	end)
	self:AddBtnListener(self.btnTask_, nil, function()
		self:Go("/summerChessBoardTask", {
			taskActivityID = 280416
		})
	end)
	self:AddBtnListener(self.btnFirstHalf_, nil, function()
		self:OnTabClick(true)
	end)
	self:AddBtnListener(self.btnSecondHalf_, nil, function()
		self:OnTabClick(false)
	end)
end

function CatchDuckMainView:OnEnter()
	manager.redPoint:setTip(RedPointConst.ACTIVITY_3_5_CATCH_DUCK_STAGE, 0)
	manager.redPoint:bindUIandKey(self.btnTask_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, 280416))

	self.isFirst_ = self.params_.isFirst == nil and CatchDuckData:GetIsFirst() or self.params_.isFirst

	CatchDuckData:SetIsFirst(self.isFirst_)
	self:RefreshUI()
	self:SetScrollPos(CatchDuckData:GetEnterIndex())
	self.stageAnim_:Play("DuckParty_Stage", -1, 0)
end

function CatchDuckMainView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_CATCH_DUCK_DESCRIPE")
	manager.windowBar:RegistBackCallBack(function()
		if self:IsOpenRoute("catchDuckSelectionInfo") then
			self:CloseSectionInfo()
		else
			JumpTools.Back()
		end
	end)
end

function CatchDuckMainView:RefreshUI()
	self.textTime_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(ActivityConst.Activity_3_5_CATCH_DUCK).stopTime)

	self:RefreTabState()
	self:RefreshStage()
end

function CatchDuckMainView:RefreTabState()
	self.stateController_:SetSelectedState(CatchDuckData:IsOpenSecondHalf() and "show" or "hide")
	self.tabController_:SetSelectedState(self.isFirst_ and "left" or "right")
end

function CatchDuckMainView:RefreshStage()
	self.duckStageRecord_ = CatchDuckData:GetDuckStageData()

	self:RefreshNormalStage()
	self:RefreshEndlessStage()
end

function CatchDuckMainView:RefreshNormalStage()
	if self.isFirst_ then
		self.conditionId_ = CatchDuckData:GetConditionId(1) or CatchDuckData:GetConditionId(2)
	end

	local var_16_0 = true

	for iter_16_0 = 1, 8 do
		local var_16_1 = clone(ActivityCatchDuckCfg[ActivityCatchDuckCfg.get_id_list_by_half[self.conditionId_][iter_16_0]])
		local var_16_2 = self.duckStageRecord_[var_16_1.stage_id]
		local var_16_3

		if self.duckStageRecord_[var_16_1.stage_id] then
			var_16_3 = var_16_2.score or nil

			if var_16_3 == nil then
				var_16_1.isLock = true

				if var_16_0 then
					var_16_0 = false

					local var_16_4 = ActivityCatchDuckCfg[var_16_1.pre]

					if ActivityCatchDuckCfg[var_16_1.pre] == nil then
						var_16_1.isLock = false
					else
						local var_16_5 = self.duckStageRecord_[var_16_4.stage_id]

						var_16_1.isLock = not self.duckStageRecord_[var_16_4.stage_id] or var_16_5 and var_16_5.score < var_16_4.target_score
					end
				end

				goto label_16_0
			end
		end

		var_16_1.isLock = false
		var_16_1.isComplete = var_16_3 >= var_16_1.target_score

		::label_16_0::

		var_16_1.score = var_16_3

		if var_16_2 then
			var_16_1.seconds = var_16_2.seconds or nil
		end

		self.poolItemList_[iter_16_0]:RefreshUI(var_16_1, iter_16_0)
	end
end

function CatchDuckMainView:RefreshEndlessStage()
	if self.isFirst_ then
		self.endlessController_:SetSelectedState("first")
	else
		self.endlessController_:SetSelectedState("second")

		local var_17_0 = clone(ActivityCatchDuckCfg[self.endlessId_])

		if self.duckStageRecord_[var_17_0.stage_id] then
			var_17_0.score = self.duckStageRecord_[var_17_0.stage_id].score or nil
		end

		var_17_0.isEndless = true

		local var_17_1 = self.duckStageRecord_[ActivityCatchDuckCfg[var_17_0.pre].stage_id]

		var_17_0.isLock = not self.duckStageRecord_[ActivityCatchDuckCfg[var_17_0.pre].stage_id] or var_17_1 and var_17_1.score < ActivityCatchDuckCfg[var_17_0.pre].target_score

		self.poolItemEndless_:RefreshUI(var_17_0, 9)
	end
end

function CatchDuckMainView:CloseSectionInfo()
	if self.selectedItem_ then
		self.selectedItem_:SelectItem(false)

		self.selectedItem_ = nil
	end

	self:OnDuckStageInfoShow(false)
	JumpTools.Back()
end

function CatchDuckMainView:OnDuckStageInfoShow(arg_19_1, arg_19_2, arg_19_3)
	self.maskController_:SetSelectedState(arg_19_1 and "show" or "hide")

	if arg_19_1 then
		self:RemoveTween()

		self.scrollRect_.enabled = false
		self.tween_ = LeanTween.value(self.scrollRect_.gameObject, self.scrollRect_.horizontalNormalizedPosition, self:CaculateMoveX(arg_19_3), 0.2)

		self.tween_:setOnUpdate(LuaHelper.FloatAction(function(arg_20_0)
			self.scrollRect_.horizontalNormalizedPosition = arg_20_0
		end))
	else
		self.scrollRect_.enabled = true
	end
end

function CatchDuckMainView:CaculateMoveX(arg_21_1)
	return self.scrollRect_.horizontalNormalizedPosition + (UnityEngine.RectTransformUtility.WorldToScreenPoint(manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera, arg_21_1).x - Screen.width / 2) * manager.ui.canvasRate / (self.content_.rect.width - self.viewPortTrans_.rect.width)
end

function CatchDuckMainView:OnTabClick(arg_22_1)
	if self.isFirst_ == arg_22_1 then
		return
	end

	self.isFirst_ = arg_22_1

	self.tabController_:SetSelectedState(self.isFirst_ and "left" or "right")
	CatchDuckData:SetIsFirst(self.isFirst_)

	self.scrollRect_.horizontalNormalizedPosition = 0

	self:RefreshStage()
	self.stageAnim_:Play("DuckParty_Stage", -1, 0)
end

function CatchDuckMainView:SetScrollPos(arg_23_1)
	self.content_.anchoredPosition = Vector2((2 - arg_23_1) * 500, 0)
end

function CatchDuckMainView:OnSelectStageItem(arg_24_1, arg_24_2, arg_24_3)
	if self.selectedItem_ then
		self.selectedItem_:SelectItem(false)
	end

	self.selectedItem_ = arg_24_1

	self.selectedItem_:SelectItem(true)
	self:OnDuckStageInfoShow(true, arg_24_3, arg_24_1.transform_.position)
	self:Go("catchDuckSelectionInfo", {
		stageData = arg_24_2,
		index = arg_24_3
	})
end

function CatchDuckMainView:RemoveTween()
	if self.tween_ then
		self.tween_:setOnComplete(nil)
		LeanTween.cancel(self.content_.gameObject)

		self.tween_ = nil
	end
end

function CatchDuckMainView:OnExit()
	manager.windowBar:HideBar()
	self:RemoveTween()
	manager.redPoint:unbindUIandKey(self.btnTask_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, 280416))
end

function CatchDuckMainView:Dispose()
	CatchDuckMainView.super.Dispose(self)

	for iter_27_0, iter_27_1 in pairs(self.poolItemList_) do
		iter_27_1:Dispose()
	end

	self.poolItemEndless_:Dispose()
end

return CatchDuckMainView
