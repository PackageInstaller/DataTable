local BilliardGameMainUI_5_1 = class("BilliardGameMainUI_5_1", ReduxView)

function BilliardGameMainUI_5_1:UIName()
	return "Widget/System/Activity_WuLuo/Activity_WuLuo_BallxPit/Activity_WuLuo_BallxPit_MainUI"
end

function BilliardGameMainUI_5_1:UIParent()
	return manager.ui.uiMain.transform
end

function BilliardGameMainUI_5_1:Init()
	self:OnInit()
end

function BilliardGameMainUI_5_1:BuildContext()
	self.bottomInfoModule_ = BilliardGameBottomInfoModule.New(self.bottomInfoGo_)
end

function BilliardGameMainUI_5_1:OnInit()
	self:BindCfgUI()
	self:BuildContext()
	BilliardGameTools.BindBilliardGameUI(self.turnBasedObj_)
	self:AddEventListner()

	self.mergeInfoController_ = self.mainControllerEx_:GetController("mergeInfo")
	self.magnifyEffectController_ = self.mainControllerEx_:GetController("fog")
	self.mergeBackHandler_ = handler(self.bottomInfoModule_, self.bottomInfoModule_.OnMergeBack)
end

function BilliardGameMainUI_5_1:AddEventListner()
	self:RegistEventListener(BilliardGameEvent.BILLIARD_UPDATE_VIEW, function()
		self:UpdateView()
	end)
	self:RegistEventListener(BilliardGameEvent.BILLIARD_VEHICLE_INJURED, function(arg_8_0)
		self.bottomInfoModule_:RefreshHp(arg_8_0)
	end)
	self:RegistEventListener(BilliardGameEvent.BILLIARD_MONSTER_DEAD, function(arg_9_0)
		BilliardGameMgr:UpdateKillMonsterCount(BilliardGameMgr:GetKillMonsterCount() + 1)
		self.bottomInfoModule_:RefreshMergeProcess((MergeBallMonsterCfg[arg_9_0] or nil) and (MergeBallMonsterCfg[arg_9_0].merge_process or 1))
	end)
	self:RegistEventListener(BilliardGameEvent.TEST_MERGE_PROCESS, function(arg_10_0)
		self.bottomInfoModule_:RefreshMergeProcess(arg_10_0)
	end)
	self:RegistEventListener(BilliardGameEvent.BILLIARD_PLAYER_ROUND_BEGIN, function()
		self:OnPlayerRoundBegin()
	end)
	self:RegistEventListener(BilliardGameEvent.BILLIARD_GAME_ROUND_OVER, function()
		self:OnRoundOver()
	end)
	self:RegistEventListener(BilliardGameEvent.UPDATE_VEHICLE_SKILL, function()
		self.bottomInfoModule_:RefreshBuff()
	end)
	self:RegistEventListener(BilliardGameEvent.SINGLE_SKILL_UPGRADE, function(arg_14_0)
		self.bottomInfoModule_:OnSingleSkillUpgrade(arg_14_0)
	end)
	self:RegistEventListener(BilliardGameEvent.SET_BOTTOM_INFO_GO_ACTIVE, function(arg_15_0)
		self:RefreshBottomActive(arg_15_0)
	end)
	self:RegistEventListener(BilliardGameEvent.SET_MERGE_AND_BALL_ACTIVE, function(arg_16_0)
		self.bottomInfoModule_:SetMergeAndBallActive(arg_16_0)
	end)
	self:RegistEventListener(BilliardGameEvent.MAIN_POP_END, function()
		self:CheckShowPop()
	end)
	self:RegistEventListener(BilliardGameEvent.MERGE_PROCESS_FEEDBACK, function(arg_18_0)
		self.bottomInfoModule_:FeedbackMergeProcess(arg_18_0)
		self.bottomInfoModule_:HideMergePop()
	end)
	self:RegistEventListener(BilliardGameEvent.MAGNIFY_EFFECT, function()
		self:ShowMagnifyEffect()
	end)
	self:RegistEventListener(BilliardGameEvent.SET_CLICK_SKILL_ITEM, function(arg_20_0)
		self.bottomInfoModule_:OnSkillClick(arg_20_0, nil, true)
	end)
	self:RegistEventListener(BilliardGameEvent.DRAG_STATE, function(arg_21_0)
		self.bottomInfoModule_:SetDragState(arg_21_0)
	end)
end

function BilliardGameMainUI_5_1:OnEnter()
	self.bottomInfoModule_:OnEnter()

	self.isFirstInGame_ = true
end

function BilliardGameMainUI_5_1:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		self:RefreshBottomActive(false)
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("MERGE_BALL_QUIT_CONFIRM"),
			OkCallback = function()
				SendBilliardMessage_5_1((BilliardGameLuaBridge.GetExchangeData()))
				LuaExchangeHelper.GoToMain()
			end,
			CancelCallback = function()
				self:RefreshBottomActive(true)
			end
		})
	end)
	self.bottomInfoModule_:OnTop()
	self.bottomInfoModule_:SetCanvasSortOrder(1)
end

function BilliardGameMainUI_5_1:OnBehind()
	manager.windowBar:HideBar()
end

function BilliardGameMainUI_5_1:OnPlayerRoundBegin()
	if not BilliardGameMgr:IsInBilliardGame() then
		return
	end

	self.isPlayerRound_ = true
	self.delayTimer_ = Timer.New(function()
		if self.isFirstInGame_ then
			self.isFirstInGame_ = false

			if not manager.guide:IsPlaying() then
				SetActive(self.startGo_, true)
			end

			self.startTimer_ = Timer.New(function()
				SetActive(self.startGo_, false)
				self:CheckShowPop()
			end, 2, 1)

			self.startTimer_:Start()
		else
			self.startTimer_ = Timer.New(function()
				SetActive(self.startGo_, false)
				self:CheckShowPop()
			end, 1, 1)

			self.startTimer_:Start()
		end
	end, 0.33, 1)

	self.delayTimer_:Start()
end

function BilliardGameMainUI_5_1:OnRoundOver()
	self.isPlayerRound_ = false
	self.isShowedSkillSelectPop_ = false
end

function BilliardGameMainUI_5_1:CheckShowPop()
	if not self.isPlayerRound_ or not BilliardGameMgr:IsInBilliardGame() then
		return
	end

	local var_33_0 = BilliardGameConst.HideSelectPopView[BilliardGameMgr:GetStageId()]

	local function var_33_1()
		if gameContext:GetLastOpenPage() == "activityWuluoVehicleIllustratePopView" then
			JumpTools.Back()
		end
	end

	local var_33_2 = false

	if not self.isShowedSkillSelectPop_ then
		if var_33_0 and table.indexof(var_33_0, BilliardGameMgr:GetCurRound()) then
			BilliardGameLuaBridge.SetSelectBuffOver(true)

			return
		end

		var_33_1()
		JumpTools.OpenPageByJump("billiardGameSelectSkillPopView")

		self.isShowedSkillSelectPop_ = true
		var_33_2 = true
	elseif self.bottomInfoModule_:GetIsNeedMerge() then
		self.bottomInfoModule_:HideMergePop()
		var_33_1()
		JumpTools.OpenPageByJump("billiardGameMergeSkillPopView", {
			backCallBack = self.mergeBackHandler_
		})

		var_33_2 = true
	end

	if var_33_2 then
		self.bottomInfoModule_:SetCanvasSortOrder(10)
		self.bottomInfoModule_:CheckGuide()
	else
		self.bottomInfoModule_:SetCanvasSortOrder(1)
	end
end

function BilliardGameMainUI_5_1:RefreshBottomActive(arg_35_1)
	SetActive(self.bottomInfoGo_, arg_35_1)
end

function BilliardGameMainUI_5_1:RefreshTips()
	return
end

function BilliardGameMainUI_5_1:UpdateView()
	return
end

function BilliardGameMainUI_5_1:ShowMagnifyEffect()
	self.magnifyEffectController_:SetSelectedState("on")
end

function BilliardGameMainUI_5_1:OnExit()
	if self.delayTimer_ then
		self.delayTimer_:Stop()

		self.delayTimer_ = nil
	end

	if self.startTimer_ then
		self.startTimer_:Stop()

		self.startTimer_ = nil
	end

	self.bottomInfoModule_:OnExit()
end

function BilliardGameMainUI_5_1:Dispose()
	self.bottomInfoModule_:Dispose()
	BilliardGameMainUI_5_1.super.Dispose(self)
end

return BilliardGameMainUI_5_1
