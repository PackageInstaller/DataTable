local ActivityMatrixView = class("ActivityMatrixView", ReduxView)

function ActivityMatrixView:UIBackCount()
	return 2
end

function ActivityMatrixView:UIName()
	return "UI/VolumeIIIUI/SoloRoguelike/VolumeSoloRoguelikeMainUI"
end

function ActivityMatrixView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityMatrixView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivityMatrixView:InitUI()
	self:BindCfgUI()

	self.campController = ControllerUtil.GetController(self.m_titleTrans, "camp")
	self.entranceController = ControllerUtil.GetController(self.m_titleTrans, "entrance")
	self.maxCamp = 6
	self.rankActivityId = -1
	self.rotationDiagram = MatrixRotationDiagram2D.New(self.m_rotationDiagram, self.m_particle)
	self.clickTime = 0
	self.selectCamp = ActivityMatrixAction.GetSelectCamp()
	self.noticeController = ControllerUtil.GetController(self.m_particle.transform, "notice")
	self.particleController = ControllerUtil.GetController(self.m_particle.transform, "particle")
end

function ActivityMatrixView:AddUIListener()
	self:AddBtnListener(self.m_storyBtn, nil, function()
		JumpTools.OpenPageByJump("/activityMatrixStoryReview")
	end)
	self:AddBtnListener(self.m_clueBtn, nil, function()
		JumpTools.OpenPageByJump("activityMatrixClue", {
			main_matrix_activity_id = self.main_matrix_activity_id
		})
	end)
	self:AddBtnListener(self.m_rewardBtn, nil, function()
		if not self.subActivityIdList[self.selectCamp] then
			return
		end

		JumpTools.OpenPageByJump("activityMatrixScoreExchange", {
			matrix_activity_id = self.subActivityIdList[self.selectCamp]
		})
	end)
	self:AddBtnListener(self.m_rankBtn, nil, function()
		if self.rankActivityId == -1 then
			return
		end

		JumpTools.OpenPageByJump("/activityMatrixRank", {
			activityId = self.rankActivityId
		})
	end)
	self:AddBtnListener(self.m_leftBtn, nil, function()
		if Time.realtimeSinceStartup < self.clickTime + 0.4 then
			return
		end

		self.clickTime = Time.realtimeSinceStartup
		self.selectCamp = self.selectCamp <= 1 and self.maxCamp or self.selectCamp - 1

		ActivityMatrixAction.SetSelectCamp(self.selectCamp)

		self.params_.selectCamp = self.selectCamp

		self.rotationDiagram:Change(self.selectCamp)
		self:RefreshUI()
		manager.audio:PlayEffect("minigame_activity_1_3", "minigame_activity_1_3_select", "")
	end)
	self:AddBtnListener(self.m_rightBtn, nil, function()
		if Time.realtimeSinceStartup < self.clickTime + 0.5 then
			return
		end

		self.clickTime = Time.realtimeSinceStartup
		self.selectCamp = self.selectCamp % self.maxCamp + 1

		ActivityMatrixAction.SetSelectCamp(self.selectCamp)

		self.params_.selectCamp = self.selectCamp

		self.rotationDiagram:Change(self.selectCamp)
		self:RefreshUI()
		manager.audio:PlayEffect("minigame_activity_1_3", "minigame_activity_1_3_select", "")
	end)
	self:AddBtnListener(self.m_clickBtn, nil, function()
		self:StartMatrix()
	end)
end

function ActivityMatrixView:StartMatrix()
	if not self.subActivityIdList[self.selectCamp] then
		return
	end

	if ActivityMatrixCfg[self.subActivityIdList[self.selectCamp]].preconditions ~= 0 and not ActivityMatrixData:GetIsClearance(ActivityMatrixCfg[self.subActivityIdList[self.selectCamp]].preconditions) then
		ShowTips(string.format(GetTips("ACTIVITY_MATRIX_PRECONDITIONS"), GetI18NText(ActivityMatrixCfg[ActivityMatrixCfg[self.subActivityIdList[self.selectCamp]].preconditions].name)))

		return
	end

	if not ActivityTools.GetActivityIsOpenWithTip(self.subActivityIdList[self.selectCamp]) then
		return
	end

	local var_14_0 = ActivityMatrixData:GetGameState(self.subActivityIdList[self.selectCamp])

	if var_14_0 == MatrixConst.STATE_TYPE.SUCCESS or var_14_0 == MatrixConst.STATE_TYPE.FAIL then
		OpenPageUntilLoaded("/matrixBlank/activityMatrixOver", {
			matrix_activity_id = self.subActivityIdList[self.selectCamp]
		})
	elseif var_14_0 == MatrixConst.STATE_TYPE.NOTSTARTED then
		OpenPageUntilLoaded("/activityMatrixSelectHero", {
			matrix_activity_id = self.subActivityIdList[self.selectCamp]
		})
	elseif var_14_0 == MatrixConst.STATE_TYPE.STARTED then
		JumpTools.GoToSystem("/matrixBlank/activityMatrixOrigin", {
			matrix_activity_id = self.subActivityIdList[self.selectCamp]
		})
	else
		error("activity matrix with error game state by id : " .. self.subActivityIdList[self.selectCamp] .. " gameState:" .. var_14_0)
	end
end

function ActivityMatrixView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_MATRIX_DESC")
end

function ActivityMatrixView:OnEnter()
	if self.params_.playerAnim then
		self.m_animator:Play("VolumeSoloRoguelikeMainUI", 0, 0)

		self.params_.playerAnim = nil
	else
		self.m_animator:Play("VolumeSoloRoguelikeMainUI", 0, 9999999)
	end

	self.main_matrix_activity_id = self.params_.main_matrix_activity_id

	if ActivityCfg[self.main_matrix_activity_id] then
		self.subActivityIdList = ActivityCfg[self.main_matrix_activity_id].sub_activity_list or {}
	end

	self.selectCamp = self.params_.selectCamp or self.selectCamp or 1

	if self.params_.matrix_activity_id then
		self.selectCamp = table.indexof(self.subActivityIdList, self.params_.matrix_activity_id) or self.selectCamp
		self.params_.matrix_activity_id = nil
	end

	self:RefreshUI()
	self.rotationDiagram:SetData(self.selectCamp)

	self.timer = Timer.New(function()
		self:RefrenTime()
	end, 1, -1)

	self.timer:Start()
	SetActive(self.m_particle, true)
	manager.redPoint:bindUIandKey(self.m_clueBtn.transform, string.format("%s_%s", RedPointConst.ACTIVITY_MATRIX_CLUE, self.main_matrix_activity_id))
end

function ActivityMatrixView:RefreshUI()
	self.campController:SetSelectedIndex(self.selectCamp - 1)

	local var_18_0 = self.subActivityIdList[self.selectCamp]

	self.m_scoreLab.text = ActivityMatrixData:GetMatrixScore(self.subActivityIdList[self.selectCamp])

	self:RefrenTime()

	self.rankActivityId = -1

	for iter_18_0, iter_18_1 in ipairs(ActivityCfg[var_18_0].sub_activity_list) do
		if ActivityCfg[iter_18_1] and ActivityTemplateConst.SINGLE_MATRIX_RANK == ActivityCfg[iter_18_1].activity_template then
			self.rankActivityId = iter_18_1

			break
		end
	end

	if self.rankActivityId == -1 then
		SetActive(self.m_rankBtn.gameObject, false)
	else
		SetActive(self.m_rankBtn.gameObject, true)
	end

	manager.redPoint:SetRedPointIndependent(self.m_rewardBtn.transform, ActivityMatrixData:GetMatrixPointCanReward(var_18_0))
	ActivityMatrixAction.SetActivityMtairxRead(self.main_matrix_activity_id, var_18_0)

	if self.selectCamp == 3 then
		self.noticeController:SetSelectedIndex(1)
	else
		self.noticeController:SetSelectedIndex(0)
	end

	local var_18_1 = ActivityMatrixCfg[var_18_0]

	if not ActivityMatrixData:GetIsClearance(ActivityMatrixCfg[var_18_0].preconditions) or not ActivityData:GetActivityIsOpen(var_18_0) then
		self.particleController:SetSelectedIndex(0)
	elseif MatrixConst.STATE_TYPE.NOTSTARTED ~= ActivityMatrixData:GetGameState(var_18_0) then
		self.particleController:SetSelectedIndex(2)

		self.m_enterText_1.text = GetTips("ACTIVITY_MATRIX_PERFORM_TIPS")
		self.m_enterText_2.text = GetTips("ACTIVITY_MATRIX_PERFORM_TIPS")
		self.m_enterText_3.text = GetTips("ACTIVITY_MATRIX_PERFORM_TIPS")
	else
		self.particleController:SetSelectedIndex(1)

		self.m_enterText_1.text = GetTips("ACTIVITY_MATRIX_ENTER_TIPS")
		self.m_enterText_2.text = GetTips("ACTIVITY_MATRIX_ENTER_TIPS")
		self.m_enterText_3.text = GetTips("ACTIVITY_MATRIX_ENTER_TIPS")
	end

	self.m_titleText.text = GetI18NText(var_18_1.name)

	local var_18_2 = false

	for iter_18_2 = self.selectCamp + 1, self.selectCamp + 3 do
		if ActivityMatrixAction.CheckSubReadRedPonit(self.subActivityIdList[iter_18_2 % self.maxCamp]) or ActivityMatrixData:GetMatrixPointCanReward(self.subActivityIdList[iter_18_2 % self.maxCamp]) then
			var_18_2 = true

			break
		end
	end

	manager.redPoint:SetRedPointIndependent(self.m_rightBtn.transform, var_18_2)

	local var_18_3 = false

	for iter_18_3 = self.selectCamp - 1, self.selectCamp - 2, -1 do
		if ActivityMatrixAction.CheckSubReadRedPonit(self.subActivityIdList[((iter_18_3 + self.maxCamp) % self.maxCamp == 0 or nil) and self.maxCamp]) or ActivityMatrixData:GetMatrixPointCanReward(self.subActivityIdList[((iter_18_3 + self.maxCamp) % self.maxCamp == 0 or nil) and self.maxCamp]) then
			var_18_3 = true

			break
		end
	end

	manager.redPoint:SetRedPointIndependent(self.m_leftBtn.transform, var_18_3)
end

function ActivityMatrixView:RefrenTime()
	local var_19_0 = manager.time:GetServerTime()
	local var_19_1 = ActivityData:GetActivityData(self.main_matrix_activity_id)

	self.m_mainTimeLab.text = var_19_1 and var_19_0 < var_19_1.stopTime and manager.time:GetLostTimeStr(var_19_1.stopTime) or GetTips("TIME_OVER")

	local var_19_2 = self.subActivityIdList[self.selectCamp]

	if ActivityMatrixCfg[self.subActivityIdList[self.selectCamp]].preconditions ~= 0 and not ActivityMatrixData:GetIsClearance(ActivityMatrixCfg[self.subActivityIdList[self.selectCamp]].preconditions) then
		self.entranceController:SetSelectedIndex(0)

		self.m_timeLab.text = string.format(GetTips("ACTIVITY_MATRIX_PRECONDITIONS"), GetI18NText(ActivityMatrixCfg[ActivityMatrixCfg[self.subActivityIdList[self.selectCamp]].preconditions].name))

		return
	end

	if ActivityData:GetActivityIsOpen(var_19_2) then
		self.entranceController:SetSelectedIndex(1)
	else
		self.entranceController:SetSelectedIndex(0)

		local var_19_3 = ActivityData:GetActivityData(var_19_2)

		self.m_timeLab.text = var_19_3 and var_19_0 < var_19_3.startTime and string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_19_3.startTime)) or GetTips("TIME_OVER")
	end
end

function ActivityMatrixView:OnExit()
	manager.windowBar:HideBar()

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self.clickTime = 0

	manager.redPoint:unbindUIandKey(self.m_clueBtn.transform, string.format("%s_%s", RedPointConst.ACTIVITY_MATRIX_CLUE, self.main_matrix_activity_id))
end

function ActivityMatrixView:OnReceivePointReward()
	manager.redPoint:SetRedPointIndependent(self.m_rewardBtn.transform, ActivityMatrixData:GetMatrixPointCanReward(self.subActivityIdList[self.selectCamp]))
end

function ActivityMatrixView:Dispose()
	self.rotationDiagram:Dispose()
	ActivityMatrixView.super.Dispose(self)
end

return ActivityMatrixView
