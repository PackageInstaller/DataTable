local PushBoxView = class("PushBoxView", ReduxView)

function PushBoxView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionUI_2_10AnniversaryUI/JapanRegionUI_2_10AnniversaryBoxPlayUI"
end

function PushBoxView:UIParent()
	return manager.ui.uiMain.transform
end

function PushBoxView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function PushBoxView:InitUI()
	self:BindCfgUI()

	self.guideTitleTip_ = {
		GetTips("BOX_PUZZLE_TIPS1_1"),
		GetTips("BOX_PUZZLE_TIPS2_1"),
		GetTips("BOX_PUZZLE_TIPS3_1"),
		(GetTips("BOX_PUZZLE_TIPS4_1"))
	}
	self.guideDescTip_ = {
		GetTips("BOX_PUZZLE_TIPS1_2"),
		GetTips("BOX_PUZZLE_TIPS2_2"),
		GetTips("BOX_PUZZLE_TIPS3_2"),
		(GetTips("BOX_PUZZLE_TIPS4_2"))
	}
	self.onStopHandler_ = handler(self, self.OnStop)
	self.onSelectHandler_ = handler(self, self.OnSelect)
	self.onActionHandler_ = handler(self, self.OnAction)
	self.onResetHandler_ = handler(self, self.OnReset)
	self.boxItem_ = {}
	self.cellItem_ = {}
end

function PushBoxView:AddUIListeners()
	self:AddBtnListener(self.resetBtn_, nil, function()
		JumpTools.OpenPageByJump("activityPushBoxReset", {
			activityID = self.activityID_
		})
	end)
	self.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(self, self.BeginDrag)))
	self.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(self, self.EndDrag)))
end

function PushBoxView:BeginDrag(arg_7_1, arg_7_2)
	self.pressPos_ = arg_7_2.position
end

function PushBoxView:EndDrag(arg_8_1, arg_8_2)
	if not self.pressPos_ then
		return
	end

	if not self.boxItem_[self.curBoxIndex_] then
		return
	end

	SetActive(self.aniGo_, false)
	SetActive(self.guideGo_, false)
	self:CalDir(self.pressPos_, arg_8_2.position)
end

function PushBoxView:CalDir(arg_9_1, arg_9_2)
	if self.isAction_ then
		return
	end

	local var_9_0 = arg_9_2.x - arg_9_1.x

	if var_9_0 * var_9_0 + (arg_9_2.y - arg_9_1.y) * (arg_9_2.y - arg_9_1.y) < 0.001 then
		return
	end

	self.isAction_ = true

	if math.abs(var_9_0) / UnityEngine.Screen.width > math.abs(arg_9_2.y - arg_9_1.y) / UnityEngine.Screen.height then
		if var_9_0 > 0 then
			PushBoxTool:OperateMove(1, 0, self.curBoxIndex_)
		else
			PushBoxTool:OperateMove(-1, 0, self.curBoxIndex_)
		end
	elseif arg_9_2.y - arg_9_1.y > 0 then
		PushBoxTool:OperateMove(0, -1, self.curBoxIndex_)
	else
		PushBoxTool:OperateMove(0, 1, self.curBoxIndex_)
	end
end

function PushBoxView:OnEnter()
	self:RegisterListener()

	self.guideIndex_ = 0

	self:InitData()
	self:InitMap()
	self:ResetType()
	self:RefreshUI()
	self.guideGo_.transform:SetAsLastSibling()
end

function PushBoxView:InitData()
	self.id_ = self.params_.map_id
	self.activityID_ = self.params_.activityID
	self.goalTotal_ = 0
	self.cfg_ = ActivityCelebrationGameCfg[self.id_]

	for iter_11_0, iter_11_1 in ipairs(ActivityCelebrationBoxCfg.get_id_list_by_mapId[self.cfg_.mapId]) do
		if ActivityCelebrationBoxCfg[iter_11_1].type == PushBoxConst.CELL_TYPE.GOAL then
			self.goalTotal_ = self.goalTotal_ + 1
		end
	end

	self.pressPos_ = nil
end

function PushBoxView:InitMap()
	self.boxItem_, self.cellItem_, self.goalTbl_ = PushBoxTool:InitMap(self.id_, self.cellPanel_, self.boxPanel_, self.mapContent_, self.cellTemplate_, self.boxTemplate_)

	for iter_12_0, iter_12_1 in ipairs(self.boxItem_) do
		iter_12_1:RegistDragFunc(function(arg_13_0, arg_13_1)
			SetActive(self.guideGo_, false)
			SetActive(self.aniGo_, false)
			self:CalDir(arg_13_0, arg_13_1)
		end)
	end
end

function PushBoxView:ResetType()
	self.goalCnt_ = 0
	self.curBoxIndex_ = 1
	self.isAction_ = false

	PushBoxTool:SetStartTime()
	self:OnStop()
	self:RefreshBox()
end

function PushBoxView:RefreshBox()
	for iter_15_0 = 1, #self.cfg_.box_list do
		if self.boxItem_[iter_15_0] then
			self.boxItem_[iter_15_0]:SetSelect(iter_15_0 == self.curBoxIndex_)
		end
	end
end

function PushBoxView:RefreshUI()
	self.destID_ = self.params_.id
	self.title_.text = ActivityCelebrationOrderCfg[self.destID_].order_title

	self:RefreshGoal()
end

function PushBoxView:RefreshGoal()
	self.goal_.text = self.goalCnt_ .. "/" .. self.goalTotal_
end

function PushBoxView:EndGame()
	if table.indexof(ActivityPushBoxData:GetFinishList(self.activityID_), self.destID_) then
		PushBoxTool:SendSdk(self.activityID_, self.id_, 1)
		JumpTools.OpenPageByJump("pushBoxResult", {
			activityID = self.activityID_,
			rewardList = {}
		})
	else
		ActivityPushBoxAction.FinishPushBox(self.activityID_, self.destID_)
	end
end

function PushBoxView:CheckGuide()
	if #ActivityPushBoxData:GetFinishList(self.activityID_) > 0 or self.guideIndex_ >= #self.guideTitleTip_ then
		SetActive(self.guideGo_, false)
		SetActive(self.aniGo_, false)

		return
	end

	if self.boxItem_[self.curBoxIndex_] then
		local var_19_0 = self.boxItem_[self.curBoxIndex_].transform_.rect.width * self.boxItem_[self.curBoxIndex_].transform_.localScale.x / 2

		self.guideGo_.transform.localPosition = Vector3.New(self.boxItem_[self.curBoxIndex_].transform_.localPosition.x + var_19_0, self.boxItem_[self.curBoxIndex_].transform_.localPosition.y + var_19_0, self.boxItem_[self.curBoxIndex_].transform_.localPosition.z)
	end

	SetActive(self.guideGo_, true)

	self.guideIndex_ = self.guideIndex_ + 1
	self.guideTitle_.text = self.guideTitleTip_[self.guideIndex_]
	self.guideDesc_.text = self.guideDescTip_[self.guideIndex_]

	SetActive(self.aniGo_, true)

	if self.guideIndex_ == 1 then
		self.aniGo_.transform:SetParent(self.boxItem_[self.curBoxIndex_].transform_, false)
	elseif self.guideIndex_ == 2 then
		self.aniGo_.transform:SetParent(self.boxItem_[self.curBoxIndex_].transform_, false)
	elseif self.guideIndex_ == 3 then
		if self.cellItem_[self.goalTbl_[1]] then
			self.aniGo_.transform:SetParent(self.cellItem_[self.goalTbl_[1]].transform_, false)
		end
	elseif self.guideIndex_ == 4 then
		self.aniGo_.transform:SetParent(self.resetBtnRect_, false)
	end

	self.aniRect_:SetAsFirstSibling()

	self.aniRect_.anchorMin = Vector3.zero
	self.aniRect_.anchorMax = Vector3.one
	self.aniRect_.offsetMin = Vector2.New(0, 0)
	self.aniRect_.offsetMax = Vector2.New(0, 0)

	self.ani_:Play("Box_glow", -1, 0)
end

function PushBoxView:OnStop()
	self:CheckGuide()
	self:RefreshBox()

	self.isAction_ = false

	self:BoxStop(self.curBoxIndex_)

	for iter_20_0 = 1, #self.cfg_.box_list do
		if self.isAction_ then
			return
		end

		if iter_20_0 ~= self.curBoxIndex_ then
			self:BoxStop(iter_20_0)
		end
	end

	self:CalGoal()
end

function PushBoxView:BoxStop(arg_21_1)
	if self.boxItem_[arg_21_1] then
		local var_21_0, var_21_1 = self.boxItem_[arg_21_1]:GetCoordinate()

		self.cellItem_[PushBoxTool:GetCellIndex(var_21_0, var_21_1)]:OnStop()
	end
end

function PushBoxView:OnSelect(arg_22_1)
	if self.isAction_ then
		return
	end

	if self.curBoxIndex_ == arg_22_1 then
		return
	end

	self:CheckGuide()

	self.curBoxIndex_ = arg_22_1

	self:RefreshBox()
end

function PushBoxView:CalGoal()
	local var_23_0 = 0

	for iter_23_0 = 1, #self.cfg_.box_list do
		if self.boxItem_[iter_23_0] then
			local var_23_1, var_23_2 = self.boxItem_[iter_23_0]:GetCoordinate()

			if self.cellItem_[PushBoxTool:GetCellIndex(var_23_1, var_23_2)]:GetType() == PushBoxConst.CELL_TYPE.GOAL then
				var_23_0 = var_23_0 + 1
			end
		end
	end

	self.goalCnt_ = var_23_0

	self:RefreshGoal()

	if self.goalCnt_ == self.goalTotal_ then
		self:EndGame()
	end
end

function PushBoxView:OnAction(arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	if self.isAction_ then
		return
	end

	self.isAction_ = true

	for iter_24_0 = 1, #self.cfg_.box_list do
		if self.boxItem_[iter_24_0] then
			local var_24_0, var_24_1 = self.boxItem_[iter_24_0]:GetCoordinate()

			if var_24_0 == arg_24_3 and var_24_1 == arg_24_4 then
				self.curBoxIndex_ = iter_24_0

				self:RefreshBox()
				PushBoxTool:OperateMove(arg_24_1, arg_24_2, self.curBoxIndex_)

				break
			end
		end
	end
end

function PushBoxView:OnReset()
	PushBoxTool:SendSdk(self.activityID_, self.id_, 4)
	self:InitData()
	self:InitMap()
	self:ResetType()
end

function PushBoxView:RegisterListener()
	manager.notify:RegistListener(PUSH_BOX_STOP, self.onStopHandler_)
	manager.notify:RegistListener(PUSH_BOX_SELECT, self.onSelectHandler_)
	manager.notify:RegistListener(PUSH_BOX_ACTION, self.onActionHandler_)
	manager.notify:RegistListener(PUSH_BOX_RESET, self.onResetHandler_)
end

function PushBoxView:RemoveListener()
	manager.notify:RemoveListener(PUSH_BOX_STOP, self.onStopHandler_)
	manager.notify:RemoveListener(PUSH_BOX_SELECT, self.onSelectHandler_)
	manager.notify:RemoveListener(PUSH_BOX_ACTION, self.onActionHandler_)
	manager.notify:RemoveListener(PUSH_BOX_RESET, self.onResetHandler_)
end

function PushBoxView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.OpenPageByJump("activityPushBoxQuit", {
			way = "back",
			activityID = self.activityID_,
			id = self.id_
		})
	end)
	manager.windowBar:RegistHomeCallBack(function()
		JumpTools.OpenPageByJump("activityPushBoxQuit", {
			way = "home",
			activityID = self.activityID_,
			id = self.id_
		})
	end)
end

function PushBoxView:OnExit()
	manager.windowBar:HideBar()
	self:RemoveListener()

	for iter_31_0, iter_31_1 in ipairs(self.cellItem_) do
		iter_31_1:OnExit()
	end

	for iter_31_2, iter_31_3 in ipairs(self.boxItem_) do
		iter_31_3:OnExit()
	end

	PushBoxTool:OnExit()
end

function PushBoxView:Dispose()
	self:RemoveAllListeners()

	self.onStopHandler_ = nil
	self.onSelectHandler_ = nil
	self.onActionHandler_ = nil
	self.onResetHandler_ = nil

	for iter_32_0, iter_32_1 in ipairs(self.cellItem_) do
		iter_32_1:Dispose()
	end

	self.cellItem_ = {}

	for iter_32_2, iter_32_3 in ipairs(self.boxItem_) do
		iter_32_3:Dispose()
	end

	self.boxItem_ = {}
	self.goalTbl_ = {}

	PushBoxTool:Dispose()
	self.super.Dispose(self)
end

return PushBoxView
