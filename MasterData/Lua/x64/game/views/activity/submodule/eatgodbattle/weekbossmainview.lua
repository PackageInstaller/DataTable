local WeekBossMainView = class("WeekBossMainView", ReduxView)

function WeekBossMainView:UIName()
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_Monster/V4_2_GodEaterUI_Monster_BossUI"
end

function WeekBossMainView:UIParent()
	return manager.ui.uiMain.transform
end

function WeekBossMainView:Init()
	self:InitUI()
	self:AddUIListener()
end

function WeekBossMainView:InitUI()
	self:BindCfgUI()

	self.rewardList_ = LuaList.New(handler(self, self.IndexItem), self.rewardListGo_, CommonItemView)
	self.diffController_ = self.transCon_:GetController("diff")
	self.rightController_ = self.transCon_:GetController("right")
	self.btnController_ = self.btnCon_:GetController("btn")
	self.diffBtn_ = {}
	self.diffBtnController_ = {}
	self.animList_ = {}

	for iter_4_0 = 1, 3 do
		self.diffBtn_[iter_4_0] = self["diffBtn_" .. iter_4_0]
		self.diffBtnController_[iter_4_0] = self["diffBtnCon_" .. iter_4_0]:GetController("status")
		self.animList_[iter_4_0] = self["anim_" .. iter_4_0]
	end

	self.splineProgress_ = self.splineGo_:GetComponent("SplineProgressBar")
	self.bossModel_ = {}
	self.loadIndexList_ = {}
	self.bossAnimatorList_ = {}
	self.cacheRootMotionList_ = {}
	self.animatorTimer_ = {}
	self.skillList_ = {}
end

function WeekBossMainView:IndexItem(arg_5_1, arg_5_2)
	local var_5_0 = clone(ItemTemplateData)

	var_5_0.id = self.rewardData_[arg_5_1].id
	var_5_0.number = self.rewardData_[arg_5_1].num
	var_5_0.completedFlag = self.isComplete_

	function var_5_0.clickFun()
		ShowPopItem(POP_ITEM, {
			var_5_0.id,
			var_5_0.number
		})
	end

	arg_5_2:SetData(var_5_0)
end

function WeekBossMainView:AddUIListener()
	self:AddBtnListener(self.btnGo_, nil, function()
		if self.isComplete_ then
			ShowTips("ERROR_USER_COMPLETED")

			return
		end

		self.reserveBack_ = true

		JumpTools.OpenPageByJump("/weekBossHeroView", {
			isBoss = true,
			type = "weekBoss",
			stageType = self.selectStageType_,
			stageId = self.selectStageId_,
			activityId = WeekBossData:GetActivityId()
		})
	end)

	for iter_7_0 = 1, 3 do
		self:AddBtnListener(self.diffBtn_[iter_7_0], nil, function()
			if self.selectDiff_ ~= iter_7_0 and self.canClick_ then
				if table.indexof(self.unLockStageList_, iter_7_0) then
					self:OnSelectDiff(iter_7_0)
				elseif IsConditionAchieved(GameSetting.activity_god_eater_week_boss.value[iter_7_0][4]) then
					ShowTips("ACTIVITY_MONSTER_COSPLAY_STAGE_CONDITION")
				else
					ShowTips(string.format(GetTips("GODEATER_DES_5"), iter_7_0))
				end
			end
		end)
	end
end

function WeekBossMainView:OnEnter()
	self.trackGo_, self.virtualCameras_ = EatGodBattleTools.GetVirtualCameras()

	if self.trackGo_ and self.virtualCameras_ then
		self:SetCamera()
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("GOD_EATER_GAME_TIPS_4")

	self.activityId_ = WeekBossData:GetActivityId()
	self.bossChallengeCfg_ = WeekBossData:GetBossChallengeCfg()
	self.exitView_ = false
	self.reserveBack_ = false
	self.canClick_ = true

	self:RefreshStageStatus()
	self:LoadModel()
	self:RefreshBossInfo()
	EatGodBattleTools.SetBackGroundStatus("show", self.selectDiff_)
	self:BindRedPoint()
end

function WeekBossMainView:SetCamera()
	self.cinemachineBrain_ = manager.ui.mainCamera:GetComponent("CinemachineBrain") or manager.ui:AddMainCameraCom(typeof(CinemachineBrain))
	self.cinemachineBrain_.m_CustomBlends = Asset.Load("UI/HeroCamera/CameraData/I19_MainCamera_Blends")
	self.cinemachineBrain_.enabled = true
	self.virtualCameras_[1].Priority = 100
	self.virtualCameras_[2].Priority = 0
end

function WeekBossMainView:RefreshStageStatus()
	self.selectDiff_ = WeekBossData:GetDefaultDiff()

	self.diffController_:SetSelectedState(self.selectDiff_)

	self.unLockStageList_ = {}

	for iter_12_0, iter_12_1 in ipairs(self.diffBtnController_) do
		if iter_12_0 < self.selectDiff_ then
			iter_12_1:SetSelectedState("normal")
			table.insert(self.unLockStageList_, iter_12_0)
		elseif iter_12_0 == self.selectDiff_ then
			iter_12_1:SetSelectedState("select")
			table.insert(self.unLockStageList_, iter_12_0)
		else
			iter_12_1:SetSelectedState("lock")
		end
	end
end

function WeekBossMainView:RefreshBossInfo()
	self:RemoveTimer()

	local var_13_0 = ActivityData:GetActivityData(self.activityId_).stopTime

	self.bossTotalHp_ = WeekBossData:GetBossTotalHp(self.selectDiff_)
	self.bossRemainHp_ = math.max(self.bossTotalHp_ - WeekBossData:GetBossConsumeHp(self.selectDiff_), 0)
	self.selectStageId_ = WeekBossData:GetStageId(self.selectDiff_)
	self.selectStageType_ = BattleGodEaterDailyMonsterCfg[self.selectStageId_].type
	self.isComplete_ = self.bossRemainHp_ <= 0
	self.remianHpText_.text = self.bossRemainHp_
	self.totalHpText_.text = "/" .. self.bossTotalHp_

	self.splineProgress_:SetValue(self.bossRemainHp_ / self.bossTotalHp_)
	self.btnController_:SetSelectedState(self.isComplete_ and "complete" or "normal")

	self.nameText_.text = self.bossChallengeCfg_.main_name

	self:RefreshSkill()
	self:RefreshReward()
end

function WeekBossMainView:LoadModel()
	self:UnloadModel()

	local var_14_0 = self.bossChallengeCfg_

	for iter_14_0, iter_14_1 in pairs(self.bossChallengeCfg_.boss_id_list) do
		self.loadIndexList_[iter_14_0] = manager.resourcePool:AsyncLoad("Char/" .. MonsterCfg[iter_14_1].model_name, ASSET_TYPE.TPOSE, function(arg_15_0)
			if self.exitView_ then
				manager.resourcePool:DestroyOrReturn(arg_15_0, ASSET_TYPE.TPOSE)

				return
			end

			local var_15_0 = var_14_0.model_pos[iter_14_0]

			self.bossModel_[iter_14_0] = arg_15_0
			self.bossModel_[iter_14_0].transform.localPosition = Vector3(var_15_0[1], var_15_0[2], var_15_0[3])
			self.bossModel_[iter_14_0].transform.localEulerAngles = Vector3(var_14_0.model_rot[iter_14_0][1], var_14_0.model_rot[iter_14_0][2], var_14_0.model_rot[iter_14_0][3])
			self.bossModel_[iter_14_0].transform.localScale = Vector3(var_14_0.model_scale[iter_14_0][1], var_14_0.model_scale[iter_14_0][2], var_14_0.model_scale[iter_14_0][3])
			self.bossAnimatorList_[iter_14_0] = self.bossModel_[iter_14_0]:GetComponent(typeof(Animator))

			self:PlayAppearAnimation(iter_14_0, function()
				self.bossAnimatorList_[iter_14_0]:CrossFadeInFixedTime("stand", 0.01)
			end)
		end)
	end
end

function WeekBossMainView:UnloadModel()
	for iter_17_0, iter_17_1 in pairs(self.bossModel_) do
		self.bossAnimatorList_[iter_17_0].applyRootMotion = self.cacheRootMotionList_[iter_17_0]

		manager.resourcePool:DestroyOrReturn(iter_17_1, ASSET_TYPE.TPOSE)
	end

	self.bossModel_ = {}
	self.bossAnimatorList_ = {}

	for iter_17_2, iter_17_3 in pairs(self.loadIndexList_) do
		manager.resourcePool:StopAsyncQuest(iter_17_3)
	end

	self.loadIndexList_ = {}

	self:StopAllAnimatorTimer()
end

function WeekBossMainView:PlayAppearAnimation(arg_18_1, arg_18_2)
	local var_18_0 = self.bossAnimatorList_[arg_18_1]

	self.cacheRootMotionList_[arg_18_1] = self.bossAnimatorList_[arg_18_1].applyRootMotion
	self.bossAnimatorList_[arg_18_1].applyRootMotion = false

	if type(self.bossChallengeCfg_.appear_ani) == "table" and self.bossChallengeCfg_.appear_ani[arg_18_1] ~= "" then
		self.bossAnimatorList_[arg_18_1]:Play(self.bossChallengeCfg_.appear_ani[arg_18_1])

		local var_18_1

		var_18_1 = FrameTimer.New(function()
			if var_18_0:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
				var_18_1:Stop()
				table.removebyvalue(self.animatorTimer_, var_18_1)

				var_18_1 = nil

				arg_18_2()
			end
		end, 1, -1)

		table.insert(self.animatorTimer_, nil)
		var_18_1:Start()
	else
		arg_18_2()
	end
end

function WeekBossMainView:StopAllAnimatorTimer()
	for iter_20_0 = #self.animatorTimer_, 1, -1 do
		self.animatorTimer_[iter_20_0]:Stop()

		self.animatorTimer_[iter_20_0] = nil
	end
end

function WeekBossMainView:RefreshSkill()
	local var_21_1 = GetMonsterSkillDesList({
		self.bossChallengeCfg_.boss_id_list[1]
	})

	for iter_21_0, iter_21_1 in ipairs(var_21_1) do
		if not self.skillList_[iter_21_0] then
			local var_21_2 = Object.Instantiate(self.skillGo_, self.skillParent_)
			local var_21_3 = {}

			ComponentBinder.GetInstance():BindCfgUI(var_21_3, var_21_2)

			var_21_3.gameObject = var_21_2
			self.skillList_[iter_21_0] = var_21_3
		end

		self.skillList_[iter_21_0].titleText_.text = iter_21_1.name
		self.skillList_[iter_21_0].descText_.text = iter_21_1.info

		SetActive(self.skillList_[iter_21_0].gameObject, true)
	end

	for iter_21_2 = #var_21_1 + 1, #self.skillList_ do
		SetActive(self.skillList_[iter_21_2].gameObject, false)
	end
end

function WeekBossMainView:RefreshReward()
	self.rewardData_ = getRewardFromDropCfg(BattleGodEaterDailyMonsterCfg[self.selectStageId_].drop_lib_id, true)

	self.rewardList_:StartScroll(#self.rewardData_)
end

function WeekBossMainView:RemoveTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function WeekBossMainView:OnSelectDiff(arg_24_1)
	if self.selectDiff_ then
		self.diffBtnController_[self.selectDiff_]:SetSelectedState("normal")
	end

	self.rightController_:SetSelectedState("hide")
	self.rightController_:SetSelectedState("show")

	self.canClick_ = false

	AnimatorTools.PlayAnimatorWithCallback(self.animList_[self.selectDiff_], "UI_bgmask_xs", function()
		self.diffController_:SetSelectedState(arg_24_1)

		self.canClick_ = true
	end)

	self.selectDiff_ = arg_24_1

	self.diffBtnController_[arg_24_1]:SetSelectedState("select")
	EatGodBattleTools.SetBackGroundStatus("show", arg_24_1)
	self:RefreshBossInfo()
end

function WeekBossMainView:BindRedPoint()
	for iter_26_0 = 1, 3 do
		manager.redPoint:bindUIandKey(self.diffBtn_[iter_26_0].transform, RedPointConst.ACTIVITY_GODEATER_BOSS_BATTLE .. iter_26_0)
	end
end

function WeekBossMainView:UnBindRedPoint()
	for iter_27_0 = 1, 3 do
		manager.redPoint:unbindUIandKey(self.diffBtn_[iter_27_0].transform, RedPointConst.ACTIVITY_GODEATER_BOSS_BATTLE .. iter_27_0)
	end
end

function WeekBossMainView:OnExit()
	self.exitView_ = true

	manager.windowBar:HideBar()
	self:RemoveTimer()
	self:UnloadModel()
	self:UnBindRedPoint()

	if self.enterTimer_ then
		self.enterTimer_:Stop()

		self.enterTimer_ = nil
	end

	if not self.reserveBack_ then
		EatGodBattleTools.ResetCamera()
		EatGodBattleTools.UnloadBackScene()
	end
end

function WeekBossMainView:Dispose()
	if self.rewardList_ then
		self.rewardList_:Dispose()
	end

	WeekBossMainView.super.Dispose(self)
end

return WeekBossMainView
