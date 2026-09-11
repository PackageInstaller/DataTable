local RoguelikeMapView_2_1 = class("RoguelikeMapView_2_1", ReduxView)

function RoguelikeMapView_2_1:UIBackCount()
	return 2
end

function RoguelikeMapView_2_1:UIName()
	return "UI/VersionUI/XuHeng2ndUI/XH2ndRoguelikeUI/XH2ndRoguelikeMapUI"
end

function RoguelikeMapView_2_1:UIParent()
	return manager.ui.uiMain.transform
end

function RoguelikeMapView_2_1:Init()
	self.map = nil
	self.activity_id = self.params_.activity_id
	self.activityData = ActivityData:GetActivityData(self.activity_id)

	self.gameObject_:InjectUI(self)
	self:AddUIListener()
end

function RoguelikeMapView_2_1:AddUIListener()
	self:AddBtnListener(self.BtnReset, nil, handler(self, self.OnBtnResetClick))
	self:AddBtnListener(self.BtnRole, nil, handler(self, self.OnBtnRoleClick))
	self:AddBtnListener(self.BtnReward, nil, handler(self, self.OnBtnRewardClick))
	self:AddBtnListener(self.BtnRank, nil, handler(self, self.OnBtnRankClick))
end

function RoguelikeMapView_2_1:OnBtnResetClick()
	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = GetTips("GIVE_UP_MATRIX"),
		OkCallback = function()
			StrategyMatrixAction.QueryMatrixGiveUp(self.activity_id)
		end,
		CancelCallback = function()
			return
		end
	})
end

function RoguelikeMapView_2_1:OnBtnRoleClick()
	JumpTools.OpenPageByJump("/strategyMatrixHero", {
		matrix_activity_id = self.activity_id,
		heroId = StrategyMatrixData:GetMatrixHeroTeam(self.activity_id)[1]
	})
end

function RoguelikeMapView_2_1:OnBtnRewardClick()
	JumpTools.OpenPageByJump("strategyMatrixRward", {
		task_activity_id = 170043
	})
end

function RoguelikeMapView_2_1:OnBtnRankClick()
	JumpTools.OpenPageByJump("/roguelikeRank", {
		rank_id = self.rank_id
	})
end

function RoguelikeMapView_2_1:OnEnter()
	self.activity_id = self.params_.activity_id
	self.rank_id = self:GetRankId(self.activity_id)

	self:BindRedPoint()
	self:GenerateRoguelikeMap(self.Content)
	self:Refresh()

	self.timer = Timer.New(handler(self, self.Tick), 1, -1)

	self.timer:Start()
end

function RoguelikeMapView_2_1:OnExit()
	manager.windowBar:HideBar()

	if self.map then
		self.map:Exit()
	end

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self:UnBindRedPoint()
end

function RoguelikeMapView_2_1:OnUpdate()
	self:InitBar()
end

function RoguelikeMapView_2_1:OnTop()
	self:InitBar()

	if self.map then
		self.map:OnTop()
	end
end

function RoguelikeMapView_2_1:InitBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey(StrategyMatrixTools.GetGameTipKey(self.activity_id))
	manager.windowBar:RegistBackCallBack(function()
		self:Back()
	end)
end

function RoguelikeMapView_2_1:Refresh()
	self:TryPlayAnimation()
	self:Tick()
	self:RefreshTitleAndBg()
end

function RoguelikeMapView_2_1:GenerateRoguelikeMap(arg_19_1)
	self.mapId = StrategyMatrixData:GetMapId(self.activity_id)

	if self.map and self.mapId ~= self.map:GetMapId() then
		self.map:Dispose()

		self.map = nil
	end

	self.map = self.map or StrategyMatrixMap.New(self.mapId, arg_19_1)

	self.map:SetData(self.activity_id)
end

function RoguelikeMapView_2_1:TryPlayAnimation()
	if self.params_.playerAnim then
		self.m_animation:Play(nil, 0)

		self.params_.playerAnim = nil

		self.map:PlayerAnim(true)
	else
		self.m_animation:Play(nil, 1)
		self.map:PlayerAnim(false)
	end
end

function RoguelikeMapView_2_1:RefreshTitleAndBg()
	local var_21_0 = RoguelikeConst[self.activity_id]
	local var_21_1 = StrategyMatrixCfg[self.activity_id]

	if not RoguelikeConst[self.activity_id] or not var_21_1 then
		print("请在RoguelikeConst加上对应活动id的配置")

		return
	end

	local var_21_2 = StrategyMatrixData:GetTierID(self.activity_id)

	if not var_21_2 then
		self.TxtTier.text = ""

		return
	end

	local var_21_3 = StrategyMatrixTierTemplateCfg[var_21_2]
	local var_21_4 = StrategyMatrixData:GetRoguelikeScore(self.activity_id)
	local var_21_5 = var_21_1.activity_difficulty ~= 1

	self.CtrlDifficult:SetSelectedIndex(var_21_1.activity_difficulty ~= 1 and 1 or 0)

	self.TxtDifficult.text = GetTips(var_21_5 and "HARDLEVEL_HARD" or "HARDLEVEL_EASY")
	self.TxtTier.text = GetTips("ROGUELIKE_2_1_TITLE_" .. var_21_3.tier)
	self.ImgBg.sprite = pureGetSpriteWithoutAtlas(var_21_0.background[var_21_3.tier])

	self.CtrlRank.gameObject:SetActive(self.rank_id ~= 0)
	self.CtrlRank:SetSelectedIndex(var_21_4 > 0 and 1 or 0)

	self.TxtScore.text = var_21_4
end

function RoguelikeMapView_2_1:BindRedPoint()
	manager.redPoint:bindUIandKey(self.BtnReward.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_REWARD, self.activity_id))
end

function RoguelikeMapView_2_1:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.BtnReward.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_REWARD, self.activity_id))
end

function RoguelikeMapView_2_1:Tick()
	self.TxtTime.text = manager.time:GetServerTime() <= self.activityData.stopTime and manager.time:GetLostTimeStr(self.activityData.stopTime) or GetTips("TIME_OVER")
end

function RoguelikeMapView_2_1:GetRankId(arg_25_1)
	if not ActivityCfg[arg_25_1] then
		return 0
	end

	for iter_25_0, iter_25_1 in ipairs(ActivityCfg[arg_25_1].sub_activity_list) do
		if ActivityCfg[iter_25_1] and ActivityCfg[iter_25_1].activity_template == ActivityTemplateConst.ROGUELIKE_RANK then
			return iter_25_1
		end
	end

	return 0
end

function RoguelikeMapView_2_1:Dispose()
	if self.map then
		self.map:Dispose()
	end

	self.map = nil

	RoguelikeMapView_2_1.super.Dispose(self)
end

return RoguelikeMapView_2_1
