local var_0_0 = class("PushBoxView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionUI_2_10AnniversaryUI/JapanRegionUI_2_10AnniversaryBoxPlayUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.guideTitleTip_ = {
		GetTips("BOX_PUZZLE_TIPS1_1"),
		GetTips("BOX_PUZZLE_TIPS2_1"),
		GetTips("BOX_PUZZLE_TIPS3_1"),
		(GetTips("BOX_PUZZLE_TIPS4_1"))
	}
	arg_4_0.guideDescTip_ = {
		GetTips("BOX_PUZZLE_TIPS1_2"),
		GetTips("BOX_PUZZLE_TIPS2_2"),
		GetTips("BOX_PUZZLE_TIPS3_2"),
		(GetTips("BOX_PUZZLE_TIPS4_2"))
	}
	arg_4_0.onStopHandler_ = handler(arg_4_0, arg_4_0.OnStop)
	arg_4_0.onSelectHandler_ = handler(arg_4_0, arg_4_0.OnSelect)
	arg_4_0.onActionHandler_ = handler(arg_4_0, arg_4_0.OnAction)
	arg_4_0.onResetHandler_ = handler(arg_4_0, arg_4_0.OnReset)
	arg_4_0.boxItem_ = {}
	arg_4_0.cellItem_ = {}
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.resetBtn_, nil, function()
		JumpTools.OpenPageByJump("activityPushBoxReset", {
			activityID = arg_5_0.activityID_
		})
	end)
	arg_5_0.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(arg_5_0, arg_5_0.BeginDrag)))
	arg_5_0.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(arg_5_0, arg_5_0.EndDrag)))
end

function var_0_0.BeginDrag(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.pressPos_ = arg_7_2.position
end

function var_0_0.EndDrag(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0.pressPos_ then
		return
	end

	if not arg_8_0.boxItem_[arg_8_0.curBoxIndex_] then
		return
	end

	SetActive(arg_8_0.aniGo_, false)
	SetActive(arg_8_0.guideGo_, false)

	local var_8_0 = arg_8_2.position

	arg_8_0:CalDir(arg_8_0.pressPos_, var_8_0)
end

function var_0_0.CalDir(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0.isAction_ then
		return
	end

	local var_9_0 = arg_9_2.x - arg_9_1.x
	local var_9_1 = arg_9_2.y - arg_9_1.y

	if var_9_0 * var_9_0 + var_9_1 * var_9_1 < 0.001 then
		return
	end

	arg_9_0.isAction_ = true

	if math.abs(var_9_0) / UnityEngine.Screen.width > math.abs(var_9_1) / UnityEngine.Screen.height then
		if var_9_0 > 0 then
			PushBoxTool:OperateMove(1, 0, arg_9_0.curBoxIndex_)
		else
			PushBoxTool:OperateMove(-1, 0, arg_9_0.curBoxIndex_)
		end
	elseif var_9_1 > 0 then
		PushBoxTool:OperateMove(0, -1, arg_9_0.curBoxIndex_)
	else
		PushBoxTool:OperateMove(0, 1, arg_9_0.curBoxIndex_)
	end
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0:RegisterListener()

	arg_10_0.guideIndex_ = 0

	arg_10_0:InitData()
	arg_10_0:InitMap()
	arg_10_0:ResetType()
	arg_10_0:RefreshUI()
	arg_10_0.guideGo_.transform:SetAsLastSibling()
end

function var_0_0.InitData(arg_11_0)
	arg_11_0.id_ = arg_11_0.params_.map_id
	arg_11_0.activityID_ = arg_11_0.params_.activityID
	arg_11_0.goalTotal_ = 0
	arg_11_0.cfg_ = ActivityCelebrationGameCfg[arg_11_0.id_]

	local var_11_0 = ActivityCelebrationBoxCfg.get_id_list_by_mapId[arg_11_0.cfg_.mapId]

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		if ActivityCelebrationBoxCfg[iter_11_1].type == PushBoxConst.CELL_TYPE.GOAL then
			arg_11_0.goalTotal_ = arg_11_0.goalTotal_ + 1
		end
	end

	arg_11_0.pressPos_ = nil
end

function var_0_0.InitMap(arg_12_0)
	arg_12_0.boxItem_, arg_12_0.cellItem_, arg_12_0.goalTbl_ = PushBoxTool:InitMap(arg_12_0.id_, arg_12_0.cellPanel_, arg_12_0.boxPanel_, arg_12_0.mapContent_, arg_12_0.cellTemplate_, arg_12_0.boxTemplate_)

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.boxItem_) do
		iter_12_1:RegistDragFunc(function(arg_13_0, arg_13_1)
			SetActive(arg_12_0.guideGo_, false)
			SetActive(arg_12_0.aniGo_, false)
			arg_12_0:CalDir(arg_13_0, arg_13_1)
		end)
	end
end

function var_0_0.ResetType(arg_14_0)
	arg_14_0.goalCnt_ = 0
	arg_14_0.curBoxIndex_ = 1
	arg_14_0.isAction_ = false

	PushBoxTool:SetStartTime()
	arg_14_0:OnStop()
	arg_14_0:RefreshBox()
end

function var_0_0.RefreshBox(arg_15_0)
	for iter_15_0 = 1, #arg_15_0.cfg_.box_list do
		if arg_15_0.boxItem_[iter_15_0] then
			arg_15_0.boxItem_[iter_15_0]:SetSelect(iter_15_0 == arg_15_0.curBoxIndex_)
		end
	end
end

function var_0_0.RefreshUI(arg_16_0)
	arg_16_0.destID_ = arg_16_0.params_.id

	local var_16_0 = ActivityCelebrationOrderCfg[arg_16_0.destID_]

	arg_16_0.title_.text = var_16_0.order_title

	arg_16_0:RefreshGoal()
end

function var_0_0.RefreshGoal(arg_17_0)
	arg_17_0.goal_.text = arg_17_0.goalCnt_ .. "/" .. arg_17_0.goalTotal_
end

function var_0_0.EndGame(arg_18_0)
	local var_18_0 = ActivityPushBoxData:GetFinishList(arg_18_0.activityID_)

	if table.indexof(var_18_0, arg_18_0.destID_) then
		PushBoxTool:SendSdk(arg_18_0.activityID_, arg_18_0.id_, 1)
		JumpTools.OpenPageByJump("pushBoxResult", {
			activityID = arg_18_0.activityID_,
			rewardList = {}
		})
	else
		ActivityPushBoxAction.FinishPushBox(arg_18_0.activityID_, arg_18_0.destID_)
	end
end

function var_0_0.CheckGuide(arg_19_0)
	if #ActivityPushBoxData:GetFinishList(arg_19_0.activityID_) > 0 or arg_19_0.guideIndex_ >= #arg_19_0.guideTitleTip_ then
		SetActive(arg_19_0.guideGo_, false)
		SetActive(arg_19_0.aniGo_, false)

		return
	end

	if arg_19_0.boxItem_[arg_19_0.curBoxIndex_] then
		local var_19_0 = arg_19_0.boxItem_[arg_19_0.curBoxIndex_].transform_
		local var_19_1 = var_19_0.localPosition
		local var_19_2 = var_19_0.rect.width * var_19_0.localScale.x / 2

		arg_19_0.guideGo_.transform.localPosition = Vector3.New(var_19_1.x + var_19_2, var_19_1.y + var_19_2, var_19_1.z)
	end

	SetActive(arg_19_0.guideGo_, true)

	arg_19_0.guideIndex_ = arg_19_0.guideIndex_ + 1
	arg_19_0.guideTitle_.text = arg_19_0.guideTitleTip_[arg_19_0.guideIndex_]
	arg_19_0.guideDesc_.text = arg_19_0.guideDescTip_[arg_19_0.guideIndex_]

	SetActive(arg_19_0.aniGo_, true)

	if arg_19_0.guideIndex_ == 1 then
		arg_19_0.aniGo_.transform:SetParent(arg_19_0.boxItem_[arg_19_0.curBoxIndex_].transform_, false)
	elseif arg_19_0.guideIndex_ == 2 then
		arg_19_0.aniGo_.transform:SetParent(arg_19_0.boxItem_[arg_19_0.curBoxIndex_].transform_, false)
	elseif arg_19_0.guideIndex_ == 3 then
		local var_19_3 = arg_19_0.goalTbl_[1]

		if arg_19_0.cellItem_[var_19_3] then
			arg_19_0.aniGo_.transform:SetParent(arg_19_0.cellItem_[var_19_3].transform_, false)
		end
	elseif arg_19_0.guideIndex_ == 4 then
		arg_19_0.aniGo_.transform:SetParent(arg_19_0.resetBtnRect_, false)
	end

	arg_19_0.aniRect_:SetAsFirstSibling()

	arg_19_0.aniRect_.anchorMin = Vector3.zero
	arg_19_0.aniRect_.anchorMax = Vector3.one
	arg_19_0.aniRect_.offsetMin = Vector2.New(0, 0)
	arg_19_0.aniRect_.offsetMax = Vector2.New(0, 0)

	arg_19_0.ani_:Play("Box_glow", -1, 0)
end

function var_0_0.OnStop(arg_20_0)
	arg_20_0:CheckGuide()
	arg_20_0:RefreshBox()

	arg_20_0.isAction_ = false

	arg_20_0:BoxStop(arg_20_0.curBoxIndex_)

	for iter_20_0 = 1, #arg_20_0.cfg_.box_list do
		if arg_20_0.isAction_ then
			return
		end

		if iter_20_0 ~= arg_20_0.curBoxIndex_ then
			arg_20_0:BoxStop(iter_20_0)
		end
	end

	arg_20_0:CalGoal()
end

function var_0_0.BoxStop(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.boxItem_[arg_21_1]

	if var_21_0 then
		local var_21_1, var_21_2 = var_21_0:GetCoordinate()
		local var_21_3 = PushBoxTool:GetCellIndex(var_21_1, var_21_2)

		arg_21_0.cellItem_[var_21_3]:OnStop()
	end
end

function var_0_0.OnSelect(arg_22_0, arg_22_1)
	if arg_22_0.isAction_ then
		return
	end

	if arg_22_0.curBoxIndex_ == arg_22_1 then
		return
	end

	arg_22_0:CheckGuide()

	arg_22_0.curBoxIndex_ = arg_22_1

	arg_22_0:RefreshBox()
end

function var_0_0.CalGoal(arg_23_0)
	local var_23_0 = 0

	for iter_23_0 = 1, #arg_23_0.cfg_.box_list do
		local var_23_1 = arg_23_0.boxItem_[iter_23_0]

		if var_23_1 then
			local var_23_2, var_23_3 = var_23_1:GetCoordinate()
			local var_23_4 = PushBoxTool:GetCellIndex(var_23_2, var_23_3)

			if arg_23_0.cellItem_[var_23_4]:GetType() == PushBoxConst.CELL_TYPE.GOAL then
				var_23_0 = var_23_0 + 1
			end
		end
	end

	arg_23_0.goalCnt_ = var_23_0

	arg_23_0:RefreshGoal()

	if arg_23_0.goalCnt_ == arg_23_0.goalTotal_ then
		arg_23_0:EndGame()
	end
end

function var_0_0.OnAction(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	if arg_24_0.isAction_ then
		return
	end

	arg_24_0.isAction_ = true

	for iter_24_0 = 1, #arg_24_0.cfg_.box_list do
		local var_24_0 = arg_24_0.boxItem_[iter_24_0]

		if var_24_0 then
			local var_24_1, var_24_2 = var_24_0:GetCoordinate()

			if var_24_1 == arg_24_3 and var_24_2 == arg_24_4 then
				arg_24_0.curBoxIndex_ = iter_24_0

				arg_24_0:RefreshBox()
				PushBoxTool:OperateMove(arg_24_1, arg_24_2, arg_24_0.curBoxIndex_)

				break
			end
		end
	end
end

function var_0_0.OnReset(arg_25_0)
	PushBoxTool:SendSdk(arg_25_0.activityID_, arg_25_0.id_, 4)
	arg_25_0:InitData()
	arg_25_0:InitMap()
	arg_25_0:ResetType()
end

function var_0_0.RegisterListener(arg_26_0)
	manager.notify:RegistListener(PUSH_BOX_STOP, arg_26_0.onStopHandler_)
	manager.notify:RegistListener(PUSH_BOX_SELECT, arg_26_0.onSelectHandler_)
	manager.notify:RegistListener(PUSH_BOX_ACTION, arg_26_0.onActionHandler_)
	manager.notify:RegistListener(PUSH_BOX_RESET, arg_26_0.onResetHandler_)
end

function var_0_0.RemoveListener(arg_27_0)
	manager.notify:RemoveListener(PUSH_BOX_STOP, arg_27_0.onStopHandler_)
	manager.notify:RemoveListener(PUSH_BOX_SELECT, arg_27_0.onSelectHandler_)
	manager.notify:RemoveListener(PUSH_BOX_ACTION, arg_27_0.onActionHandler_)
	manager.notify:RemoveListener(PUSH_BOX_RESET, arg_27_0.onResetHandler_)
end

function var_0_0.OnTop(arg_28_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.OpenPageByJump("activityPushBoxQuit", {
			way = "back",
			activityID = arg_28_0.activityID_,
			id = arg_28_0.id_
		})
	end)
	manager.windowBar:RegistHomeCallBack(function()
		JumpTools.OpenPageByJump("activityPushBoxQuit", {
			way = "home",
			activityID = arg_28_0.activityID_,
			id = arg_28_0.id_
		})
	end)
end

function var_0_0.OnExit(arg_31_0)
	manager.windowBar:HideBar()
	arg_31_0:RemoveListener()

	for iter_31_0, iter_31_1 in ipairs(arg_31_0.cellItem_) do
		iter_31_1:OnExit()
	end

	for iter_31_2, iter_31_3 in ipairs(arg_31_0.boxItem_) do
		iter_31_3:OnExit()
	end

	PushBoxTool:OnExit()
end

function var_0_0.Dispose(arg_32_0)
	arg_32_0:RemoveAllListeners()

	arg_32_0.onStopHandler_ = nil
	arg_32_0.onSelectHandler_ = nil
	arg_32_0.onActionHandler_ = nil
	arg_32_0.onResetHandler_ = nil

	for iter_32_0, iter_32_1 in ipairs(arg_32_0.cellItem_) do
		iter_32_1:Dispose()
	end

	arg_32_0.cellItem_ = {}

	for iter_32_2, iter_32_3 in ipairs(arg_32_0.boxItem_) do
		iter_32_3:Dispose()
	end

	arg_32_0.boxItem_ = {}
	arg_32_0.goalTbl_ = {}

	PushBoxTool:Dispose()
	arg_32_0.super.Dispose(arg_32_0)
end

return var_0_0
