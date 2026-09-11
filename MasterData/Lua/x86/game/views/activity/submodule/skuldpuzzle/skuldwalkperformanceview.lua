local SkuldWalkPerformanceView = class("SkuldWalkPerformanceView", ReduxView)

function SkuldWalkPerformanceView:UIName()
	return "Widget/System/Activity_Skuld/Activity_Skuld_WalkUI"
end

function SkuldWalkPerformanceView:UIParent()
	return manager.ui.uiMain.transform
end

function SkuldWalkPerformanceView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SkuldWalkPerformanceView:InitUI()
	self:BindCfgUI()

	self.skuldSpine_ = self.skuldGo_:GetComponent("Spine.Unity.SkeletonGraphic")
	self.adminSpine_ = self.adminGo_:GetComponent("Spine.Unity.SkeletonGraphic")
	self.peopleController_ = self.controllerEx_:GetController("people")
end

function SkuldWalkPerformanceView:AddUIListeners()
	self:AddBtnListener(self.bgbtn_, nil, function()
		if self.isClickBg then
			self.isClickBg = false

			self:OnBgBtn()
		end
	end)
	self:AddBtnListener(self.btnSkip_, nil, function()
		self.skuldSpine_.AnimationState:SetAnimation(0, "idle", true)
		self.adminSpine_.AnimationState:SetAnimation(0, "idle", true)

		self.bgTrans_.localPosition = self.startPos

		self:StopMoveTimer()
		JumpTools.OpenPageByJump("skuldPuzzleSettleView", {
			levelID = self.params_.levelID,
			rewardList = self.params_.rewardList
		}, nil, true)
	end)
end

function SkuldWalkPerformanceView:OnBgBtn()
	SetActive(self.talkGo_, false)

	if self.num >= #self.actions_list then
		JumpTools.OpenPageByJump("skuldPuzzleSettleView", {
			levelID = self.params_.levelID,
			rewardList = self.params_.rewardList
		}, nil, true)

		return
	end

	self:BgSpriteMove()
end

function SkuldWalkPerformanceView:OnTop()
	self:UpdateBar()
end

function SkuldWalkPerformanceView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function SkuldWalkPerformanceView:OnEnter()
	if self.params_.stage_id then
		self.stage_id = self.params_.stage_id
	end

	self.pointSpot = {}
	self.isClickBg = false
	self.isFirst = self.params_.isFirst
	self.num = 0
	self.isMove = true
	self.reachList = {}
	self.puzzleCfg = SkuldPuzzleStageCfg[self.stage_id]
	self.characterType = self.puzzleCfg.character
	self.actions_list = self.puzzleCfg.actions_list
	self.spot_list = self.puzzleCfg.spot_list
	self.startPos = self.bgTrans_.localPosition

	self.peopleController_:SetSelectedIndex(self.characterType - 1)

	self.skuldPos = self.skuldTrans_.localPosition
	self.adminPos = self.adminTrans_.localPosition
	self.skuldSpine_.initialSkinName = self.puzzleCfg.skuld_skin

	self.skuldSpine_:Initialize(true)

	self.lastUpdateTime_role = Time.time

	for iter_11_0 = 1, #self.actions_list do
		self.reachList[iter_11_0] = {
			isReach = false
		}
	end

	self:InstantiatePoint()
	SetActive(self.talkGo_, false)
	SetActive(self.btnSkip_.gameObject, not self.isFirst)
	self:RoleStartMove()
end

function SkuldWalkPerformanceView:OnEnterOver()
	SkuldSystemAction.RefreshAudio()
end

function SkuldWalkPerformanceView:RoleStartMove()
	if self.characterType == 1 then
		self.skuldSpine_.AnimationState:SetAnimation(0, "walk", true)
		manager.audio:PlayEffect("minigame_activity_4_0", "minigame_activity_4_0_pintu_walk01", "")
	elseif self.characterType == 2 then
		self.adminSpine_.AnimationState:SetAnimation(0, "walk", true)
		manager.audio:PlayEffect("minigame_activity_4_0", "minigame_activity_4_0_pintu_walk01", "")
	elseif self.characterType == 3 then
		self.skuldSpine_.AnimationState:SetAnimation(0, "walk", true)
		self.adminSpine_.AnimationState:SetAnimation(0, "walk", true)
		manager.audio:PlayEffect("minigame_activity_4_0", "minigame_activity_4_0_pintu_walk03", "")
	elseif self.characterType == 4 then
		self.skuldSpine_.AnimationState:SetAnimation(0, "walk", true)
		manager.audio:PlayEffect("minigame_activity_4_0", "minigame_activity_4_0_pintu_walk01", "")
	end

	self:StopMoveRoleTimer()

	self.moveRoleTimer_ = FrameTimer.New(function()
		local var_14_0 = Time.time

		if self.skuldTrans_.localPosition.x >= GameSetting.skuld_walk_distance.value[1] then
			self.skuldTrans_.localPosition = Vector3.New(self.skuldTrans_.localPosition.x, self.skuldTrans_.localPosition.y, self.skuldTrans_.localPosition.z)
			self.adminTrans_.localPosition = Vector3.New(self.adminTrans_.localPosition.x, self.adminTrans_.localPosition.y, self.adminTrans_.localPosition.z)

			self:BgSpriteMove()
			self:StopMoveRoleTimer()
		else
			self.skuldTrans_.localPosition = Vector3.New(self.skuldTrans_.localPosition.x + GameSetting.skuld_walk_speed.value[1] * (Time.time - self.lastUpdateTime_role), self.skuldTrans_.localPosition.y, self.skuldTrans_.localPosition.z)
			self.adminTrans_.localPosition = Vector3.New(self.adminTrans_.localPosition.x + GameSetting.skuld_walk_speed.value[1] * (Time.time - self.lastUpdateTime_role), self.adminTrans_.localPosition.y, self.adminTrans_.localPosition.z)
		end

		self.lastUpdateTime_role = var_14_0
	end, 1, -1)

	self.moveRoleTimer_:Start()
end

function SkuldWalkPerformanceView:StopMoveRoleTimer()
	if self.moveRoleTimer_ then
		self.moveRoleTimer_:Stop()

		self.moveRoleTimer_ = nil
	end
end

function SkuldWalkPerformanceView:InstantiatePoint()
	for iter_16_0 = 1, #self.spot_list do
		self.pointSpot[iter_16_0] = Object.Instantiate(Asset.Load("Widget/System/Activity_Skuld/walking/" .. self.spot_list[iter_16_0]), self["point_" .. iter_16_0])
	end
end

function SkuldWalkPerformanceView:StopMoveTimer()
	if self.moveTimer_ then
		self.moveTimer_:Stop()

		self.moveTimer_ = nil
	end
end

function SkuldWalkPerformanceView:BgSpriteMove()
	self:StopMoveTimer()

	self.moveTimer_ = FrameTimer.New(function()
		self:StopMoveRoleTimer()

		if self.characterType == 1 then
			if self.skuldSpine_.AnimationState:GetCurrent(0).Animation.Name ~= "walk" then
				self.skuldSpine_.AnimationState:SetAnimation(0, "walk", true)

				if #self.actions_list > 1 then
					manager.audio:PlayEffect("minigame_activity_4_0", "minigame_activity_4_0_pintu_walk02", "")
				end
			end
		elseif self.characterType == 2 then
			if self.adminSpine_.AnimationState:GetCurrent(0).Animation.Name ~= "walk" then
				self.adminSpine_.AnimationState:SetAnimation(0, "walk", true)

				if #self.actions_list > 1 then
					manager.audio:PlayEffect("minigame_activity_4_0", "minigame_activity_4_0_pintu_walk02", "")
				end
			end
		elseif self.characterType == 3 then
			if self.skuldSpine_.AnimationState:GetCurrent(0).Animation.Name ~= "walk" then
				self.skuldSpine_.AnimationState:SetAnimation(0, "walk", true)
				self.adminSpine_.AnimationState:SetAnimation(0, "walk", true)

				if #self.actions_list > 1 then
					manager.audio:PlayEffect("minigame_activity_4_0", "minigame_activity_4_0_pintu_walk04", "")
				end
			end
		elseif self.characterType == 4 and self.skuldSpine_.AnimationState:GetCurrent(0).Animation.Name ~= "walk" then
			self.skuldSpine_.AnimationState:SetAnimation(0, "walk", true)

			if #self.actions_list > 1 then
				manager.audio:PlayEffect("minigame_activity_4_0", "minigame_activity_4_0_pintu_walk02", "")
			end
		end

		self.skuldTrans_.localPosition = Vector3.New(self.skuldTrans_.localPosition.x, self.skuldTrans_.localPosition.y, self.skuldTrans_.localPosition.z)
		self.adminTrans_.localPosition = Vector3.New(self.adminTrans_.localPosition.x, self.adminTrans_.localPosition.y, self.adminTrans_.localPosition.z)
		self.bgTrans_.localPosition = Vector3.New(self.bgTrans_.localPosition.x - GameSetting.skuld_walk_speed.value[1] * (Time.time - self.lastUpdateTime_bg), self.bgTrans_.localPosition.y, self.bgTrans_.localPosition.z)

		self:IsReachTargetPoint(self.bgTrans_.localPosition.x)

		self.lastUpdateTime_bg = Time.time
	end, 1, -1)
	self.lastUpdateTime_bg = Time.time

	self.moveTimer_:Start()
end

function SkuldWalkPerformanceView:IsReachTargetPoint(arg_20_1)
	for iter_20_0 = 1, #self.actions_list do
		if math.abs(self["point_" .. iter_20_0].position.x - self.skuldTrans_.position.x) <= 1 and not self.reachList[iter_20_0].isReach then
			self.isClickBg = true

			local var_20_0 = ActivitySkuldWalkingCfg[self.actions_list[iter_20_0][math.random(1, #self.actions_list[iter_20_0])]]

			if self.characterType == 1 then
				self.skuldSpine_.AnimationState:SetAnimation(0, var_20_0.skuld_action, false)
				manager.audio:StopEffect()
				self:SetOnceSkuldTimer()
			elseif self.characterType == 2 then
				self.adminSpine_.AnimationState:SetAnimation(0, var_20_0.admin_action, false)
				manager.audio:StopEffect()
				self:SetOnceAdminTimer()
			elseif self.characterType == 3 then
				self.skuldSpine_.AnimationState:SetAnimation(0, var_20_0.skuld_action, false)
				self.adminSpine_.AnimationState:SetAnimation(0, var_20_0.admin_action, false)
				manager.audio:StopEffect()
				self:SetOnceSkuldTimer()
				self:SetOnceAdminTimer()
			elseif self.characterType == 4 then
				self.skuldSpine_.AnimationState:SetAnimation(0, var_20_0.skuld_action, false)
				manager.audio:StopEffect()
				self:SetOnceSkuldTimer()
			end

			self:StopMoveTimer()
			SetActive(self.talkGo_, true)
			self:RefreshTalk(iter_20_0)

			self.num = self.num + 1
			self.reachList[iter_20_0] = {
				isReach = true
			}

			break
		end
	end
end

function SkuldWalkPerformanceView:StopOnceTimer()
	if self.onceTimer_ then
		self.onceTimer_:Stop()

		self.onceTimer_ = nil
	end
end

function SkuldWalkPerformanceView:SetOnceSkuldTimer()
	self:StopOnceTimer()

	self.onceTimer_ = FrameTimer.New(function()
		local var_23_0 = self.skuldSpine_.AnimationState:GetCurrent(0)

		if var_23_0.Animation.Name ~= "idle" and var_23_0.IsComplete == true then
			self.skuldSpine_.AnimationState:SetAnimation(0, "idle", true)
			manager.audio:StopEffect()
			self:StopOnceTimer()
		end
	end, 1, -1)

	self.onceTimer_:Start()
end

function SkuldWalkPerformanceView:StopOnceAdminTimer()
	if self.onceAdminTimer_ then
		self.onceAdminTimer_:Stop()

		self.onceAdminTimer_ = nil
	end
end

function SkuldWalkPerformanceView:SetOnceAdminTimer()
	self:StopOnceAdminTimer()

	self.onceAdminTimer_ = FrameTimer.New(function()
		local var_26_0 = self.adminSpine_.AnimationState:GetCurrent(0)

		if var_26_0.Animation.Name ~= "idle" and var_26_0.IsComplete == true then
			self.adminSpine_.AnimationState:SetAnimation(0, "idle", true)
			manager.audio:StopEffect()
			self:StopOnceAdminTimer()
		end
	end, 1, -1)

	self.onceAdminTimer_:Start()
end

function SkuldWalkPerformanceView:RefreshTalk(arg_27_1)
	self.talkText_.text = ActivitySkuldWalkingCfg[self.actions_list[arg_27_1][math.random(1, #self.actions_list[arg_27_1])]].skuld_chat
end

function SkuldWalkPerformanceView:OnExit()
	self:RemoveAllEventListener()
	self:StopMoveTimer()
	self:StopOnceTimer()
	self:StopOnceAdminTimer()
	self:StopMoveRoleTimer()
	self.skuldSpine_.AnimationState:SetAnimation(0, "idle", true)
	self.adminSpine_.AnimationState:SetAnimation(0, "idle", true)

	self.bgTrans_.localPosition = self.startPos
	self.skuldTrans_.localPosition = self.skuldPos
	self.adminTrans_.localPosition = self.adminPos

	for iter_28_0 = 1, #self.pointSpot do
		Object.Destroy(self.pointSpot[iter_28_0])

		self.pointSpot[iter_28_0] = nil
	end
end

function SkuldWalkPerformanceView:Dispose()
	if self.reachList then
		self.reachList = nil
	end

	for iter_29_0 = 1, #self.pointSpot do
		Object.Destroy(self.pointSpot[iter_29_0])

		self.pointSpot[iter_29_0] = nil
	end

	self.pointSpot = nil

	self.super.Dispose(self)
end

return SkuldWalkPerformanceView
