local var_0_0 = class("ChallengeRogueTeamMapBaseView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.eulerAngles_ = Vector3(0, 0, 0)
	arg_1_0.contentTmpPos_ = Vector3(0, 0, 0)
	arg_1_0.nodeItemList_ = {}
	arg_1_0.moveTime_ = GameSetting.rogue_team_map_horizontal_move_time.value[1]
	arg_1_0.rotateTime_ = GameSetting.rogue_team_map_vertical_rotate_time.value[1]
	arg_1_0.scrollMoveView_ = ScrollMoveView.New(arg_1_0, arg_1_0.gameObject_)
	arg_1_0.selectedHandler_ = handler(arg_1_0, arg_1_0.OnSelectedNode)
	arg_1_0.finishNodeHandler_ = handler(arg_1_0, arg_1_0.OnFinishNode)
	arg_1_0.onSelectedUINodeHandler_ = handler(arg_1_0, arg_1_0.OnSelectedUINode)
	arg_1_0.attachViewList_ = {}
end

function var_0_0.OnEnter(arg_2_0)
	arg_2_0.lastAnglesX_ = arg_2_0.contentRect_.localEulerAngles.x

	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_PATH_SELECTED_NODE, arg_2_0.selectedHandler_)
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_PATH_FINISH_NODE, arg_2_0.finishNodeHandler_)
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_PATH_SELECTED_UI_NODE, arg_2_0.onSelectedUINodeHandler_)
end

function var_0_0.OnEnterOver(arg_3_0)
	arg_3_0:RefreshScrollContent()

	if not arg_3_0:IsOpenSectionInfo() then
		arg_3_0.contentTmpPos_.x = arg_3_0.contentRect_.localPosition.x
		arg_3_0.contentTmpPos_.y = 0
		arg_3_0.contentRect_.localPosition = arg_3_0.contentTmpPos_

		arg_3_0:RemoveTween()

		arg_3_0.eulerAngles_.x = 0
		arg_3_0.contentRect_.localEulerAngles = arg_3_0.eulerAngles_
	end
end

function var_0_0.OnTop(arg_4_0)
	arg_4_0:ScrollReset()

	if not arg_4_0:IsOpenSectionInfo() then
		arg_4_0:RefreshSelectItemState()
	end
end

function var_0_0.OnExit(arg_5_0)
	if arg_5_0.currentAttachView_ then
		arg_5_0.currentAttachView_:OnExit()

		arg_5_0.currentAttachView_ = nil
	end

	arg_5_0:StopTimer()
	arg_5_0.scrollMoveView_:OnExit()
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_PATH_SELECTED_NODE, arg_5_0.selectedHandler_)
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_PATH_FINISH_NODE, arg_5_0.finishNodeHandler_)
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_PATH_SELECTED_UI_NODE, arg_5_0.onSelectedUINodeHandler_)
end

function var_0_0.Dispose(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.attachViewList_) do
		iter_6_1:Dispose()
	end

	arg_6_0.attachViewList_ = nil
	arg_6_0.OnSelectedNode = nil
	arg_6_0.finishNodeHandler_ = nil
	arg_6_0.onSelectedUINodeHandler_ = nil

	arg_6_0.scrollMoveView_:Dispose()

	arg_6_0.scrollMoveView_ = nil

	for iter_6_2, iter_6_3 in pairs(arg_6_0.nodeItemList_) do
		iter_6_3:Dispose()
	end

	arg_6_0.nodeItemList_ = nil

	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.AddListeners(arg_7_0)
	return
end

function var_0_0.GetNodeClass(arg_8_0)
	return ChallengeRogueTeamPathBaseNode
end

function var_0_0.RefreshItemList(arg_9_0)
	local var_9_0 = ChallengeRogueTeamData:PathGetNodeList()

	for iter_9_0, iter_9_1 in pairs(var_9_0) do
		if arg_9_0.nodeItemList_[iter_9_0] == nil then
			arg_9_0.nodeItemList_[iter_9_0] = arg_9_0:GetNodeClass().New(arg_9_0.nodeItem_, arg_9_0.content_, iter_9_0)
		end

		arg_9_0:RefreshItem(arg_9_0.nodeItemList_[iter_9_0])
	end

	local var_9_1 = {}

	for iter_9_2, iter_9_3 in pairs(arg_9_0.nodeItemList_) do
		if var_9_0[iter_9_2] == nil then
			table.insert(var_9_1, iter_9_2)
		end
	end

	for iter_9_4, iter_9_5 in ipairs(var_9_1) do
		arg_9_0.nodeItemList_[iter_9_5]:Dispose()

		arg_9_0.nodeItemList_[iter_9_5] = nil
	end
end

function var_0_0.RefreshItem(arg_10_0, arg_10_1)
	arg_10_1:RefreshUI()
end

function var_0_0.RefreshSelectItemState(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.nodeItemList_) do
		iter_11_1:RefreshSelectState()
	end
end

function var_0_0.OnSelectedUINode(arg_12_0, arg_12_1)
	arg_12_0:RefreshSelectItemState()

	for iter_12_0, iter_12_1 in pairs(arg_12_0.nodeItemList_) do
		if iter_12_1:GetNodeID() == arg_12_1 then
			local var_12_0 = iter_12_1:GetPosition()

			if var_12_0.x - arg_12_0.viewportRect_.rect.width / 2 + 350 == arg_12_0.contentRect_.localPosition.x * -1 then
				arg_12_0.contentTmpPos_.x = var_12_0.x + 150
				arg_12_0.contentTmpPos_.y = var_12_0.y

				arg_12_0.scrollMoveView_:ScrollVector(arg_12_0.contentTmpPos_, nil, nil, arg_12_0.rotateTime_)
				arg_12_0:RotateScroll(arg_12_1)
			else
				arg_12_0.contentTmpPos_.x = var_12_0.x + 150
				arg_12_0.contentTmpPos_.y = 0

				arg_12_0.scrollMoveView_:ScrollVector(arg_12_0.contentTmpPos_, nil, function()
					arg_12_0.contentTmpPos_.x = var_12_0.x + 150
					arg_12_0.contentTmpPos_.y = var_12_0.y

					arg_12_0.scrollMoveView_:ScrollVector(arg_12_0.contentTmpPos_, nil, nil, arg_12_0.rotateTime_)
					arg_12_0:RotateScroll(arg_12_1)
				end, arg_12_0.moveTime_)
			end

			return
		end
	end
end

function var_0_0.RefreshScrollContent(arg_14_0)
	local var_14_0 = #ChallengeRogueTeamData:PathGetNodePathList() * ChallengeRogueTeamConst.COL_SPACE
	local var_14_1 = ChallengeRogueTeamTools.GetCanSelecteNodeCol()

	if ChallengeRogueTeamTools.HasMapNodeEffect() then
		var_14_1 = var_14_1 - 1
	end

	local var_14_2 = var_14_1 * ChallengeRogueTeamConst.COL_SPACE

	arg_14_0.scrollMoveView_:RefreshUI(var_14_2, var_14_0, true)
end

function var_0_0.RefreshUI(arg_15_0)
	arg_15_0:RefreshItemList()

	local var_15_0 = arg_15_0:GetAttachView()

	if arg_15_0.currentAttachView_ then
		if arg_15_0.currentAttachView_ ~= var_15_0 then
			arg_15_0.currentAttachView_:OnExit()

			arg_15_0.currentAttachView_ = var_15_0

			var_15_0:OnEnter()
		end
	elseif var_15_0 then
		arg_15_0.currentAttachView_ = var_15_0

		var_15_0:OnEnter()
	end
end

function var_0_0.OnReset(arg_16_0)
	arg_16_0:RefreshUI()
	arg_16_0:RefreshScrollContent()
	manager.rogueTeamMapPreviewBtnBar:RefreshUI()
end

function var_0_0.OnSelectedNode(arg_17_0)
	arg_17_0:RefreshSelectItemState()
end

function var_0_0.OnFinishNode(arg_18_0)
	arg_18_0:RefreshItemList()
end

function var_0_0.RotateScroll(arg_19_0, arg_19_1)
	local var_19_0 = (ChallengeRogueTeamTools.GetMapMaxRowCnt() + 1) / 2
	local var_19_1 = ChallengeRogueTeamData:PathGetNodeData(arg_19_1)
	local var_19_2 = (var_19_0 - (var_19_1.row == 0 and var_19_0 or var_19_1.row)) * ChallengeRogueTeamTools.GetRotationValueX()

	arg_19_0:LeanTweenRotate(var_19_2 * -1)
end

function var_0_0.LeanTweenRotate(arg_20_0, arg_20_1)
	arg_20_0:RemoveTween()

	local var_20_0 = arg_20_0.contentRect_.localEulerAngles.x
	local var_20_1 = arg_20_1

	if arg_20_0.contentRect_.localEulerAngles.x > 180 then
		var_20_1 = 360 + arg_20_1
	end

	arg_20_0.tween_ = LeanTween.value(arg_20_0.gameObject_, var_20_0, var_20_1, arg_20_0.rotateTime_):setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
		arg_20_0.eulerAngles_.x = arg_21_0
		arg_20_0.contentRect_.localEulerAngles = arg_20_0.eulerAngles_

		arg_20_0:PlayAudio()
	end)):setOnComplete(System.Action(function()
		arg_20_0:RemoveTween()
	end)):setEase(LeanTweenType.easeOutSine)
end

function var_0_0.PlayAudio(arg_23_0)
	local var_23_0 = arg_23_0.contentRect_.localEulerAngles.x

	if math.abs(arg_23_0.lastAnglesX_ - var_23_0) > 3 then
		ChallengeRogueTeamTools.PlayAudio("node_select_audio_id")

		arg_23_0.lastAnglesX_ = var_23_0
	end
end

function var_0_0.ScrollReset(arg_24_0)
	arg_24_0:LeanTweenRotate(0)

	if arg_24_0.contentRect_.localPosition.y == 0 then
		if arg_24_0.contentRect_.localPosition.x > 0 then
			arg_24_0.contentTmpPos_.x = 0
			arg_24_0.contentTmpPos_.y = 0

			arg_24_0.scrollMoveView_:ScrollVector2(arg_24_0.contentTmpPos_, false, function()
				return
			end, arg_24_0.moveTime_)

			return
		elseif math.abs(arg_24_0.contentRect_.localPosition.x) > arg_24_0.contentRect_.rect.width - arg_24_0.viewportRect_.rect.width then
			arg_24_0.contentTmpPos_.x = (arg_24_0.contentRect_.rect.width - arg_24_0.viewportRect_.rect.width) * -1
			arg_24_0.contentTmpPos_.y = 0

			arg_24_0.scrollMoveView_:ScrollVector2(arg_24_0.contentTmpPos_, false, function()
				return
			end, arg_24_0.moveTime_)

			return
		end
	end

	arg_24_0.contentTmpPos_.x = arg_24_0.contentRect_.localPosition.x
	arg_24_0.contentTmpPos_.y = 0

	arg_24_0.scrollMoveView_:ScrollVector2(arg_24_0.contentTmpPos_, false, function()
		return
	end, arg_24_0.moveTime_)
end

function var_0_0.RemoveTween(arg_28_0)
	if arg_28_0.tween_ then
		arg_28_0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_28_0.tween_.id)

		arg_28_0.tween_ = nil
	end
end

function var_0_0.IsOpenSectionInfo(arg_29_0)
	return arg_29_0:IsOpenRoute("challengeRogueTeamSectionInfo")
end

function var_0_0.GetAttachView(arg_30_0)
	local var_30_0 = ChallengeRogueTeamData:GetPlotID() == ChallengeRogueTeamConst.SPECIAL_ENDING.ENDING_POP_ID and ChallengeRogueTeamConst.SPECIAL_ENDING.ENDING_Map_PATH or ChallengeRogueTeamTools.GetFloorPrefabPath()

	if not arg_30_0.attachViewList_[var_30_0] then
		arg_30_0.attachViewList_[var_30_0] = ChallengeRogueTeamMapTimelineView.New(arg_30_0, var_30_0, arg_30_0.bgParent_)
	end

	return arg_30_0.attachViewList_[var_30_0]
end

function var_0_0.PalyNodeEffect(arg_31_0)
	local var_31_0 = ChallengeRogueTeamData:UIGetNodeEffectID()

	if var_31_0 ~= nil then
		manager.ui:UIEventEnabled(false)

		local var_31_1 = arg_31_0.nodeItemList_[var_31_0]
		local var_31_2 = ChallengeRogueTeamData:PathGetNodeData(var_31_0)

		ChallengeRogueTeamData:UISetNodeEffectID()
		ChallengeRogueTeamTools.PlayAudio("node_next_audio_id")
		var_31_1:PlayLineAnimator(function()
			arg_31_0.nodeItemList_[var_31_0]:StopAnimator()

			for iter_32_0, iter_32_1 in ipairs(var_31_2.nextIDList) do
				arg_31_0.nodeItemList_[iter_32_1]:PlayUnlockLight()
			end

			manager.ui:UIEventEnabled(true)
			arg_31_0:StopTimer()

			arg_31_0.timer_ = Timer.New(function()
				arg_31_0:Move2Column()
			end, 0.2, 1)

			arg_31_0.timer_:Start()
		end)
	else
		arg_31_0:RefreshItemList()
	end
end

function var_0_0.StopTimer(arg_34_0)
	if arg_34_0.timer_ then
		arg_34_0.timer_:Stop()

		arg_34_0.timer_ = nil
	end
end

function var_0_0.Move2Column(arg_35_0)
	local var_35_0 = #ChallengeRogueTeamData:PathGetFinishPath()

	arg_35_0.contentTmpPos_.x = (var_35_0 * ChallengeRogueTeamConst.COL_SPACE - 150 + 150) * -1
	arg_35_0.contentTmpPos_.y = 0

	arg_35_0.scrollMoveView_:ScrollForceVector(arg_35_0.contentTmpPos_, nil, arg_35_0.moveTime_)
end

return var_0_0
