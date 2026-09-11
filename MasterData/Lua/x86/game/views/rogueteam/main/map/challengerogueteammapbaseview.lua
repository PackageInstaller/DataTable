local ChallengeRogueTeamMapBaseView = class("ChallengeRogueTeamMapBaseView", ReduxView)

function ChallengeRogueTeamMapBaseView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.eulerAngles_ = Vector3(0, 0, 0)
	self.contentTmpPos_ = Vector3(0, 0, 0)
	self.nodeItemList_ = {}
	self.moveTime_ = GameSetting.rogue_team_map_horizontal_move_time.value[1]
	self.rotateTime_ = GameSetting.rogue_team_map_vertical_rotate_time.value[1]
	self.scrollMoveView_ = ScrollMoveView.New(self, self.gameObject_)
	self.selectedHandler_ = handler(self, self.OnSelectedNode)
	self.finishNodeHandler_ = handler(self, self.OnFinishNode)
	self.onSelectedUINodeHandler_ = handler(self, self.OnSelectedUINode)
	self.attachViewList_ = {}
end

function ChallengeRogueTeamMapBaseView:OnEnter()
	self.lastAnglesX_ = self.contentRect_.localEulerAngles.x

	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_PATH_SELECTED_NODE, self.selectedHandler_)
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_PATH_FINISH_NODE, self.finishNodeHandler_)
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_PATH_SELECTED_UI_NODE, self.onSelectedUINodeHandler_)
end

function ChallengeRogueTeamMapBaseView:OnEnterOver()
	self:RefreshScrollContent()

	if not self:IsOpenSectionInfo() then
		self.contentTmpPos_.x = self.contentRect_.localPosition.x
		self.contentTmpPos_.y = 0
		self.contentRect_.localPosition = self.contentTmpPos_

		self:RemoveTween()

		self.eulerAngles_.x = 0
		self.contentRect_.localEulerAngles = self.eulerAngles_
	end
end

function ChallengeRogueTeamMapBaseView:OnTop()
	self:ScrollReset()

	if not self:IsOpenSectionInfo() then
		self:RefreshSelectItemState()
	end
end

function ChallengeRogueTeamMapBaseView:OnExit()
	if self.currentAttachView_ then
		self.currentAttachView_:OnExit()

		self.currentAttachView_ = nil
	end

	self:StopTimer()
	self.scrollMoveView_:OnExit()
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_PATH_SELECTED_NODE, self.selectedHandler_)
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_PATH_FINISH_NODE, self.finishNodeHandler_)
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_PATH_SELECTED_UI_NODE, self.onSelectedUINodeHandler_)
end

function ChallengeRogueTeamMapBaseView:Dispose()
	for iter_6_0, iter_6_1 in pairs(self.attachViewList_) do
		iter_6_1:Dispose()
	end

	self.attachViewList_ = nil
	self.OnSelectedNode = nil
	self.finishNodeHandler_ = nil
	self.onSelectedUINodeHandler_ = nil

	self.scrollMoveView_:Dispose()

	self.scrollMoveView_ = nil

	for iter_6_2, iter_6_3 in pairs(self.nodeItemList_) do
		iter_6_3:Dispose()
	end

	self.nodeItemList_ = nil

	ChallengeRogueTeamMapBaseView.super.Dispose(self)
end

function ChallengeRogueTeamMapBaseView:AddListeners()
	return
end

function ChallengeRogueTeamMapBaseView:GetNodeClass()
	return ChallengeRogueTeamPathBaseNode
end

function ChallengeRogueTeamMapBaseView:RefreshItemList()
	local var_9_0 = ChallengeRogueTeamData:PathGetNodeList()

	for iter_9_0, iter_9_1 in pairs(var_9_0) do
		if self.nodeItemList_[iter_9_0] == nil then
			self.nodeItemList_[iter_9_0] = self:GetNodeClass().New(self.nodeItem_, self.content_, iter_9_0)
		end

		self:RefreshItem(self.nodeItemList_[iter_9_0])
	end

	local var_9_1 = {}

	for iter_9_2, iter_9_3 in pairs(self.nodeItemList_) do
		if var_9_0[iter_9_2] == nil then
			table.insert(var_9_1, iter_9_2)
		end
	end

	for iter_9_4, iter_9_5 in ipairs(var_9_1) do
		self.nodeItemList_[iter_9_5]:Dispose()

		self.nodeItemList_[iter_9_5] = nil
	end
end

function ChallengeRogueTeamMapBaseView:RefreshItem(arg_10_1)
	arg_10_1:RefreshUI()
end

function ChallengeRogueTeamMapBaseView:RefreshSelectItemState()
	for iter_11_0, iter_11_1 in pairs(self.nodeItemList_) do
		iter_11_1:RefreshSelectState()
	end
end

function ChallengeRogueTeamMapBaseView:OnSelectedUINode(arg_12_1)
	self:RefreshSelectItemState()

	for iter_12_0, iter_12_1 in pairs(self.nodeItemList_) do
		if iter_12_1:GetNodeID() == arg_12_1 then
			local var_12_0 = iter_12_1:GetPosition()

			if var_12_0.x - self.viewportRect_.rect.width / 2 + 350 == self.contentRect_.localPosition.x * -1 then
				self.contentTmpPos_.x = var_12_0.x + 150
				self.contentTmpPos_.y = var_12_0.y

				self.scrollMoveView_:ScrollVector(self.contentTmpPos_, nil, nil, self.rotateTime_)
				self:RotateScroll(arg_12_1)
			else
				self.contentTmpPos_.x = var_12_0.x + 150
				self.contentTmpPos_.y = 0

				self.scrollMoveView_:ScrollVector(self.contentTmpPos_, nil, function()
					self.contentTmpPos_.x = var_12_0.x + 150
					self.contentTmpPos_.y = var_12_0.y

					self.scrollMoveView_:ScrollVector(self.contentTmpPos_, nil, nil, self.rotateTime_)
					self:RotateScroll(arg_12_1)
				end, self.moveTime_)
			end

			return
		end
	end
end

function ChallengeRogueTeamMapBaseView:RefreshScrollContent()
	local var_14_0 = ChallengeRogueTeamTools.GetCanSelecteNodeCol()

	if ChallengeRogueTeamTools.HasMapNodeEffect() then
		var_14_0 = var_14_0 - 1
	end

	self.scrollMoveView_:RefreshUI(var_14_0 * ChallengeRogueTeamConst.COL_SPACE, #ChallengeRogueTeamData:PathGetNodePathList() * ChallengeRogueTeamConst.COL_SPACE, true)
end

function ChallengeRogueTeamMapBaseView:RefreshUI()
	self:RefreshItemList()

	local var_15_0 = self:GetAttachView()

	if self.currentAttachView_ then
		if self.currentAttachView_ ~= var_15_0 then
			self.currentAttachView_:OnExit()

			self.currentAttachView_ = var_15_0

			var_15_0:OnEnter()
		end
	elseif var_15_0 then
		self.currentAttachView_ = var_15_0

		var_15_0:OnEnter()
	end
end

function ChallengeRogueTeamMapBaseView:OnReset()
	self:RefreshUI()
	self:RefreshScrollContent()
	manager.rogueTeamMapPreviewBtnBar:RefreshUI()
end

function ChallengeRogueTeamMapBaseView:OnSelectedNode()
	self:RefreshSelectItemState()
end

function ChallengeRogueTeamMapBaseView:OnFinishNode()
	self:RefreshItemList()
end

function ChallengeRogueTeamMapBaseView:RotateScroll(arg_19_1)
	local var_19_0 = (ChallengeRogueTeamTools.GetMapMaxRowCnt() + 1) / 2
	local var_19_1 = ChallengeRogueTeamData:PathGetNodeData(arg_19_1)

	self:LeanTweenRotate((var_19_0 - (var_19_1.row == 0 and var_19_0 or var_19_1.row)) * ChallengeRogueTeamTools.GetRotationValueX() * -1)
end

function ChallengeRogueTeamMapBaseView:LeanTweenRotate(arg_20_1)
	self:RemoveTween()

	self.tween_ = LeanTween.value(self.gameObject_, self.contentRect_.localEulerAngles.x, (self.contentRect_.localEulerAngles.x > 180 or nil) and 360 + arg_20_1, self.rotateTime_):setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
		self.eulerAngles_.x = arg_21_0
		self.contentRect_.localEulerAngles = self.eulerAngles_

		self:PlayAudio()
	end)):setOnComplete(System.Action(function()
		self:RemoveTween()
	end)):setEase(LeanTweenType.easeOutSine)
end

function ChallengeRogueTeamMapBaseView:PlayAudio()
	if math.abs(self.lastAnglesX_ - self.contentRect_.localEulerAngles.x) > 3 then
		ChallengeRogueTeamTools.PlayAudio("node_select_audio_id")

		self.lastAnglesX_ = self.contentRect_.localEulerAngles.x
	end
end

function ChallengeRogueTeamMapBaseView:ScrollReset()
	self:LeanTweenRotate(0)

	if self.contentRect_.localPosition.y == 0 then
		if self.contentRect_.localPosition.x > 0 then
			self.contentTmpPos_.x = 0
			self.contentTmpPos_.y = 0

			self.scrollMoveView_:ScrollVector2(self.contentTmpPos_, false, function()
				return
			end, self.moveTime_)

			return
		elseif math.abs(self.contentRect_.localPosition.x) > self.contentRect_.rect.width - self.viewportRect_.rect.width then
			self.contentTmpPos_.x = (self.contentRect_.rect.width - self.viewportRect_.rect.width) * -1
			self.contentTmpPos_.y = 0

			self.scrollMoveView_:ScrollVector2(self.contentTmpPos_, false, function()
				return
			end, self.moveTime_)

			return
		end
	end

	self.contentTmpPos_.x = self.contentRect_.localPosition.x
	self.contentTmpPos_.y = 0

	self.scrollMoveView_:ScrollVector2(self.contentTmpPos_, false, function()
		return
	end, self.moveTime_)
end

function ChallengeRogueTeamMapBaseView:RemoveTween()
	if self.tween_ then
		self.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.tween_.id)

		self.tween_ = nil
	end
end

function ChallengeRogueTeamMapBaseView:IsOpenSectionInfo()
	return self:IsOpenRoute("challengeRogueTeamSectionInfo")
end

function ChallengeRogueTeamMapBaseView:GetAttachView()
	local var_30_0

	if ChallengeRogueTeamData:GetPlotID() == ChallengeRogueTeamConst.SPECIAL_ENDING.ENDING_POP_ID then
		var_30_0 = ChallengeRogueTeamConst.SPECIAL_ENDING.ENDING_Map_PATH or ChallengeRogueTeamTools.GetFloorPrefabPath()
		self.attachViewList_[var_30_0] = self.attachViewList_[var_30_0] or ChallengeRogueTeamMapTimelineView.New(self, var_30_0, self.bgParent_)
	end

	return self.attachViewList_[var_30_0]
end

function ChallengeRogueTeamMapBaseView:PalyNodeEffect()
	local var_31_0 = ChallengeRogueTeamData:UIGetNodeEffectID()

	if var_31_0 ~= nil then
		manager.ui:UIEventEnabled(false)

		local var_31_1 = ChallengeRogueTeamData:PathGetNodeData(var_31_0)

		ChallengeRogueTeamData:UISetNodeEffectID()
		ChallengeRogueTeamTools.PlayAudio("node_next_audio_id")
		self.nodeItemList_[var_31_0]:PlayLineAnimator(function()
			self.nodeItemList_[var_31_0]:StopAnimator()

			for iter_32_0, iter_32_1 in ipairs(var_31_1.nextIDList) do
				self.nodeItemList_[iter_32_1]:PlayUnlockLight()
			end

			manager.ui:UIEventEnabled(true)
			self:StopTimer()

			self.timer_ = Timer.New(function()
				self:Move2Column()
			end, 0.2, 1)

			self.timer_:Start()
		end)
	else
		self:RefreshItemList()
	end
end

function ChallengeRogueTeamMapBaseView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ChallengeRogueTeamMapBaseView:Move2Column()
	self.contentTmpPos_.x = (#ChallengeRogueTeamData:PathGetFinishPath() * ChallengeRogueTeamConst.COL_SPACE - 150 + 150) * -1
	self.contentTmpPos_.y = 0

	self.scrollMoveView_:ScrollForceVector(self.contentTmpPos_, nil, self.moveTime_)
end

return ChallengeRogueTeamMapBaseView
