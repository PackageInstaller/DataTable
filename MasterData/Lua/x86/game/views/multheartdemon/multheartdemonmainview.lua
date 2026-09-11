local MultHeartDemonMainView = class("MultHeartDemonMainView", ReduxView)

function MultHeartDemonMainView:UIName()
	return "Widget/System/Activity_Resident/Acitvity_SoloHeartDemon/Acitvity_SoloHeartDemon"
end

function MultHeartDemonMainView:UIParent()
	return manager.ui.uiMain.transform
end

function MultHeartDemonMainView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MultHeartDemonMainView:InitUI()
	self:BindCfgUI()

	self.difficultyBtnControllerList = {}
	self.difficultyBtnControllerList[1] = self.difficultyController1_:GetController("select")
	self.difficultyBtnControllerList[2] = self.difficultyController2_:GetController("select")
	self.rankController = ControllerUtil.GetController(self.rankGo_.transform, "state")
	self.list = LuaList.New(handler(self, self.SetListItem), self.list_, MultHeartDemonListItem)
end

function MultHeartDemonMainView:SetListItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.rankData.rankList[arg_5_1], arg_5_1, 1)
end

function MultHeartDemonMainView:IsLocked()
	return self:CheckIsChallengeTime() and MultHeartDemonData:GetDataByPara("isLock")
end

function MultHeartDemonMainView:AddUIListener()
	for iter_7_0 = 1, 2 do
		self:AddBtnListener(self["difficultyBtn" .. iter_7_0 .. "_"], nil, function()
			if self.selectDifficulty == iter_7_0 then
				return
			end

			if MultHeartDemonData:GetDataByPara("difficultyData")[3 - iter_7_0] ~= nil and self:IsLocked() then
				ShowTips("MULTI_HEART_DEMON_CHALLENGE_HAS_BEGUN")

				return
			end

			self:UpdateSelectedDifficultyParams(iter_7_0)
			self.animator_:Play(self.selectDifficulty == 1 and "change_blue" or "change_red", 0, 0)
			self:UpdateView()
			self:UpdateDifficultyControllerState()
		end)
	end

	self:AddBtnListener(self.fightBtn_, nil, function()
		JumpTools.GoToSystem("/MultHeartDemonCombine", {
			isMain = true,
			activityId = self.activityId,
			difficult = self.selectDifficulty
		})
	end)
	self:AddBtnListener(self.fight2Btn_, nil, function()
		JumpTools.GoToSystem("/MultHeartDemonCombine", {
			isMain = true,
			activityId = self.activityId,
			difficult = self.selectDifficulty
		})
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		if ActivityData:GetActivityIsOpen(self.activityId) then
			JumpTools.GoToSystem("/multHeartDemonReward", {
				activityId = self.activityId
			})
		else
			ShowTips("MULTI_HEART_DEMON_REFRESH_TIPS")
		end
	end)
	self:AddBtnListener(self.listGoBtn_, nil, function()
		JumpTools.GoToSystem("/multHeartDemonRank", {
			activityId = self.activityId
		})
	end)
end

function MultHeartDemonMainView:CheckIsChallengeTime()
	return ActivityData:GetActivityIsOpen(self.activityId) and self.challengeStage == 0
end

function MultHeartDemonMainView:CheckIsRankProcessingTime()
	return self.challengeStage == 1
end

function MultHeartDemonMainView:CheckIsRankReleaseTime()
	return self.challengeStage == 2
end

function MultHeartDemonMainView:UpdateSelectedDifficultyParams(arg_16_1)
	local var_16_0

	if not arg_16_1 then
		::label_16_0::

		var_16_0 = self.params_.difficulty or self.selectDifficulty or 1
	end

	self.selectDifficulty = var_16_0

	if self:IsLocked() then
		self.selectDifficulty = MultHeartDemonData:GetDataByPara("enterFlag") and 2 or 1
	end

	self.params_.difficulty = self.selectDifficulty
end

function MultHeartDemonMainView:UpdateView()
	self.activityId = MultHeartDemonData:GetDataByPara("activityId")
	self.challengeStage = MultHeartDemonData:GetDataByPara("challengeStage")
	self.maxScore = nullable(MultHeartDemonData:GetDataByPara("maxScore"), 2) or 0
	self.remainTime = ActivityData:GetActivityRefreshTime(self.activityId)
	self.cfg = MultHeartDemonCfg[MultHeartDemonCfg.get_id_list_by_activity_id[self.activityId][1]]

	self:UpdateSelectedDifficultyParams()
	self:UpdateDifficultyControllerState()
	self:OnRankUpdate()
	self:LoadModel()

	self.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureBg/Activity_Resident/Acitvity_SoloHeartDemon/" .. (self.selectDifficulty == 2 and "SoloHeartDemonUI_00026x" or "SoloHeartDemonUI_00012x"))
	self.easyTxt_.text = GetTips("MULTI_HEART_DEMON_EASY_NAME")
	self.hardTxt_.text = GetTips("MULTI_HEART_DEMON_HARD_NAME")

	SetActive(self.nameGo1_, self.selectDifficulty == 1)
	SetActive(self.nameGo2_, self.selectDifficulty == 2)
	SetActive(self.list.gameObject, self.selectDifficulty == 2)
	SetActive(self.normalEffect_, self.selectDifficulty == 1)
	SetActive(self.hardEffect_, self.selectDifficulty == 2)

	self.rawImage1_.color = self.selectDifficulty == 1 and Color(0.266, 0.403, 0.607) or Color(0.509, 0.38, 1)
	self.rawImage2_.color = self.selectDifficulty == 1 and Color(0.266, 0.403, 0.607) or Color(0.509, 0.38, 1)
	self.maxScoreTxt_.text = GetTipsF("ACTIVITY_LINKGAME_SCORE_RECORDER", self.maxScore)

	self:UpdateBtnAvailableByActivityTime()
	self:StartTimer(function()
		self:UpdateBtnAvailableByActivityTime()
	end)
	SetActive(self.rankGo_, not self:CheckIsRankProcessingTime())
end

function MultHeartDemonMainView:UpdateBtnAvailableByActivityTime()
	if self:CheckIsChallengeTime() then
		self.remainTxt2_.text = TimeMgr.WrapTimeStrWithTips(manager.time:GetLostTimeStrWith2Unit(self.remainTime), "MULTI_HEART_DEMON_CHALLENGE_TIME")

		local var_19_0 = self:IsLocked()

		SetActive(self.ashGo_, false)
		SetActive(self.fightBtn_.gameObject, self.selectDifficulty == 1)
		SetActive(self.fight2Btn_.gameObject, self.selectDifficulty == 2)
		SetActive(self.fight1Go_, var_19_0 and MultHeartDemonData:GetDataByPara("difficultyData")[1] ~= nil)
		SetActive(self.fight2Go_, var_19_0 and MultHeartDemonData:GetDataByPara("difficultyData")[2] ~= nil and MultHeartDemonData:GetDataByPara("difficultyData")[1] == nil)
	else
		self.remainTxt2_.text = GetTips("MULTI_HEART_DEMON_REFRESH_TIPS")

		SetActive(self.ashGo_, true)
		SetActive(self.fightBtn_.gameObject, false)
		SetActive(self.fight2Btn_.gameObject, false)
		SetActive(self.fight1Go_, false)
		SetActive(self.fight2Go_, false)
	end
end

function MultHeartDemonMainView:UpdateDifficultyControllerState()
	for iter_20_0 = 1, 2 do
		self.difficultyBtnControllerList[iter_20_0]:SetSelectedState(self.selectDifficulty == iter_20_0 and "true" or "false")
	end
end

function MultHeartDemonMainView:OnEnter()
	self.exitView_ = false

	self.animator_:Play("Acitvity_SoloHeartDemon", 1, 0)
	manager.ui:SetMainCamera("multiHeartDemon")
	self:InitBackScene()
	self:UpdateView()
	RankAction.QueryCommonRank(RankConst.RANK_ID.MULTHEARTDEMON, nil, nil, 300)
	self:BindRedPoint()
	self:RegisterEvents()
end

function MultHeartDemonMainView:OnRankUpdate()
	self.rankData = RankData:GetCommonRank(RankConst.RANK_ID.MULTHEARTDEMON)

	self.rankController:SetSelectedState("mini")

	if self.rankData == nil then
		return
	end

	if #self.rankData.rankList >= 5 then
		self.rankController:SetSelectedState("all")
	end

	self.list:StartScroll(5)
end

function MultHeartDemonMainView:OnMultDemonHeartUpdate()
	self:UpdateView()
end

function MultHeartDemonMainView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, RedPointConst.MULT_HEART_DEMON_REWARD)
	manager.redPoint:bindUIandKey(self.fightBtn_.transform, RedPointConst.MULT_HEART_DEMON_FIRST_VIEW)
	manager.redPoint:bindUIandKey(self.fight2Btn_.transform, RedPointConst.MULT_HEART_DEMON_FIRST_VIEW)
end

function MultHeartDemonMainView:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, RedPointConst.MULT_HEART_DEMON_REWARD)
	manager.redPoint:unbindUIandKey(self.fightBtn_.transform, RedPointConst.MULT_HEART_DEMON_FIRST_VIEW)
	manager.redPoint:unbindUIandKey(self.fight2Btn_.transform, RedPointConst.MULT_HEART_DEMON_FIRST_VIEW)
end

function MultHeartDemonMainView:StartTimer(arg_26_1)
	self:StopTimer()

	self.updateTimer2_ = Timer.New(arg_26_1, 1, -1, 1)

	self.updateTimer2_:Start()
end

function MultHeartDemonMainView:StopTimer()
	if self.updateTimer2_ then
		self.updateTimer2_:Stop()

		self.updateTimer2_ = nil
	end
end

function MultHeartDemonMainView:OnExit()
	self:RemoveAllEventListener()

	self.exitView_ = true

	self:UnbindRedPoint()
	manager.windowBar:HideBar()
	self:DestroyBackScene()
	self:UnloadModel()
	manager.ui:ResetMainCamera()
	self:StopTimer()
	SetActive(self.hardEffect_, false)
end

function MultHeartDemonMainView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		NAVI_BAR
	})
	manager.windowBar:SetGameHelpKey("MULTI_HEART_DEMON_GAMEPLAY_DESC")
end

function MultHeartDemonMainView:Dispose()
	if self.list then
		self.list:Dispose()

		self.list = nil
	end

	MultHeartDemonMainView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

function MultHeartDemonMainView:RegisterEvents()
	self:RegistEventListener(ACTIVITY_UPDATE, function(arg_32_0)
		if arg_32_0 == self.activityId then
			self.remainTime = ActivityData:GetActivityRefreshTime(arg_32_0)

			self:UpdateBtnAvailableByActivityTime()
		end
	end)
end

function MultHeartDemonMainView:InitBackScene()
	self.backGround_ = manager.resourcePool:Get("UI/Common/BackgroundQuad", ASSET_TYPE.SCENE)
	self.backGroundTrs_ = self.backGround_.transform

	self.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	self.backGroundTrs_.localPosition = Vector3(GameDisplayCfg.multi_heart_demon_bg_pos.value[1], GameDisplayCfg.multi_heart_demon_bg_pos.value[2], GameDisplayCfg.multi_heart_demon_bg_pos.value[3])
	self.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
	self.backGroundTrs_.localScale = Vector3(GameDisplayCfg.multi_heart_demon_bg_pos.scale[1], GameDisplayCfg.multi_heart_demon_bg_pos.scale[2], GameDisplayCfg.multi_heart_demon_bg_pos.scale[3])
end

function MultHeartDemonMainView:DestroyBackScene()
	if self.backGround_ then
		manager.resourcePool:DestroyOrReturn(self.backGround_, ASSET_TYPE.SCENE)

		self.backGround_ = nil
	end
end

function MultHeartDemonMainView:UnloadModel()
	if self.bossModelList ~= nil then
		for iter_35_0 = 1, 3 do
			if not isNil(self.bossModelList[iter_35_0]) then
				manager.resourcePool:DestroyOrReturn(self.bossModelList[iter_35_0], ASSET_TYPE.TPOSE)
			end

			manager.resourcePool:StopAsyncQuest(self.loadList[iter_35_0])

			self.currentBossTemplateID = nil
		end

		self.bossModelList = nil
		self.loadList = nil
	end
end

function MultHeartDemonMainView:LoadModel()
	if self.currentBossTemplateID == self.cfg.id then
		return
	end

	self:UnloadModel()

	self.currentBossTemplateID = self.cfg.id

	local var_36_0 = {
		"left",
		"middle",
		"right"
	}
	local var_36_1 = MultHeartDemonUICfg[self.cfg.id]

	self.loadList = {}
	self.bossModelList = {}

	for iter_36_0 = 1, 3 do
		local var_36_2 = var_36_0[iter_36_0]

		self.loadList[iter_36_0] = manager.resourcePool:AsyncLoad("Char/" .. MultHeartDemonUICfg[self.cfg.id]["model_" .. var_36_0[iter_36_0]], ASSET_TYPE.TPOSE, function(arg_37_0)
			if self.exitView_ or self.currentBossTemplateID ~= self.cfg.id then
				manager.resourcePool:DestroyOrReturn(arg_37_0, ASSET_TYPE.TPOSE)

				return
			end

			local var_37_0 = var_36_1["model_" .. var_36_2 .. "_pos"]

			self.bossModelList[iter_36_0] = arg_37_0
			arg_37_0.transform.localPosition = Vector3(var_37_0[1], var_37_0[2], var_37_0[3])
			arg_37_0.transform.localEulerAngles = Vector3(var_36_1["model_" .. var_36_2 .. "_rot"][1], var_36_1["model_" .. var_36_2 .. "_rot"][2], var_36_1["model_" .. var_36_2 .. "_rot"][3])
			arg_37_0.transform.localScale = Vector3(var_36_1["model_" .. var_36_2 .. "_scale"][1], var_36_1["model_" .. var_36_2 .. "_scale"][2], var_36_1["model_" .. var_36_2 .. "_scale"][3])
		end)
	end
end

return MultHeartDemonMainView
