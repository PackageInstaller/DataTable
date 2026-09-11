local ActivitySummerSwimsuitPreheatGameView = class("ActivitySummerSwimsuitPreheatGameView", ReduxView)

function ActivitySummerSwimsuitPreheatGameView:UIName()
	return "Widget/Version/Alone_SummerUI_PreheatUI/Alone_SummerUI_PreheatGameUI"
end

function ActivitySummerSwimsuitPreheatGameView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivitySummerSwimsuitPreheatGameView:Init()
	self:InitUI()
	self:AddUIListener()

	self.stateController_ = self.conEx_:GetController("state")
end

function ActivitySummerSwimsuitPreheatGameView:InitUI()
	self:BindCfgUI()
	self:CreateControllerItem()
end

function ActivitySummerSwimsuitPreheatGameView:AddUIListener()
	return
end

function ActivitySummerSwimsuitPreheatGameView:OnEnter()
	self:InitBar()

	self.cfgId_ = self.params_.cfgId
	self.cfg_ = ActivitySummerSwimsuitPreheatCfg[self.cfgId_]

	self.panelAni_:Play("New State", -1, 0)
	self.panelAni_:Update(0)
	self.shutterAni_:Play("shutter", -1, 0)
	self.shutterAni_:Update(0)
	self.stateController_:SetSelectedState("play")
	self:RefreshUI()
	self:StartGame()
end

function ActivitySummerSwimsuitPreheatGameView:InitBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})

	if GameSetting.activity_summer_swimsuit_preheat_info_describe then
		if #GameSetting.activity_summer_swimsuit_preheat_info_describe.value > 0 then
			manager.windowBar:SetGameHelpKey({
				view = "/gameHelpPro",
				type = "jump",
				params = {
					hideHomeBtn = 1,
					isPrefab = true,
					pages = GameSetting.activity_summer_swimsuit_preheat_info_describe.value
				}
			})
		end

		if getData("ActivitySummerSwimsuitPreheatGame", "visit_tutorial") ~= 1 then
			JumpTools.OpenPageByJump("/gameHelpPro", {
				hideHomeBtn = 1,
				isPrefab = true,
				pages = GameSetting.activity_summer_swimsuit_preheat_info_describe.value
			})
			saveData("ActivitySummerSwimsuitPreheatGame", "visit_tutorial", 1)
		end
	end
end

function ActivitySummerSwimsuitPreheatGameView:OnExit()
	manager.windowBar:HideBar()
	self:StopGame()
	AnimatorTools.Stop()
end

function ActivitySummerSwimsuitPreheatGameView:RefreshUI()
	return
end

function ActivitySummerSwimsuitPreheatGameView:StartTimer()
	self:StopTimer()

	if self.updateTimer_ == nil then
		self.updateTimer_ = Timer.New(function()
			self:UpdateGameState()
		end, 0.11, -1)

		self.updateTimer_:Start()
	end

	if self.audioTimer_ == nil then
		self.audioTimer_ = FrameTimer.New(function()
			self:AudioTick()
		end, 1, -1)

		self.audioTimer_:Start()
	end

	self:StopControllerTipsTimer()

	self.canShowControllerTips_ = false
	self.controllerTipsTimer_ = Timer.New(function()
		self.canShowControllerTips_ = true
	end, GameSetting.summer_preheat_foolproof_time.value[1], 1)

	self.controllerTipsTimer_:Start()
end

function ActivitySummerSwimsuitPreheatGameView:StopTimer()
	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end

	if self.audioTimer_ then
		self.audioTimer_:Stop()

		self.audioTimer_ = nil
	end

	self:StopControllerTipsTimer()
end

function ActivitySummerSwimsuitPreheatGameView:StopControllerTipsTimer()
	if self.controllerTipsTimer_ then
		self.controllerTipsTimer_:Stop()

		self.controllerTipsTimer_ = nil
	end
end

local cjson = require("cjson")

function ActivitySummerSwimsuitPreheatGameView:UpdateGameState()
	local var_16_0 = cjson.decode((FloGameLuaBridge.GetGameData()))

	AudioManager.Instance:SetAisacControlOfCategory("music", "phase_controller", var_16_0.percent)

	self.tickAudioPlayRate_ = 0.005 / math.max(math.abs(var_16_0.value1 - self.lastValue1_), math.abs(var_16_0.value2 - self.lastValue2_))
	self.lastValue1_ = var_16_0.value1
	self.lastValue2_ = var_16_0.value2

	self:UpdateControllerItem(var_16_0)

	if var_16_0.isWin then
		self:WinGame()
	end
end

function ActivitySummerSwimsuitPreheatGameView:AudioTick()
	if not self.tickAudioPlayRate_ then
		return
	end

	if self.tickAudioPlayRate_ < Time.time - self.lastAudioPlayTime_ then
		manager.audio:PlayEffect("minigame_activity_3_3", "minigame_activity_3_3_preheat_gear", "")

		self.lastAudioPlayTime_ = Time.time
	end
end

function ActivitySummerSwimsuitPreheatGameView:StartGame()
	self:InitControllerItem()
	FloGameLuaBridge.SetGameData((cjson.encode({
		gameType = self.cfg_.type,
		winBlur = self.cfg_.settings,
		winDistance = self.cfg_.settings
	})))
	FloGameLuaBridge.StartGame()
	self:StartTimer()

	self.lastValue1_ = 1
	self.lastValue2_ = 1
	self.lastAudioPlayTime_ = 0
	self.tickAudioPlayRate_ = nil

	for iter_18_0 = 1, 4 do
		if self["playImg_" .. iter_18_0] then
			self["playImg_" .. iter_18_0].sprite = ActivitySummerSwimsuitPreheatTools.GetCfgStageImage(self.cfg_)
		end
	end
end

function ActivitySummerSwimsuitPreheatGameView:StopGame()
	FloGameLuaBridge.StopGame()
	self:StopTimer()
end

function ActivitySummerSwimsuitPreheatGameView:WinGame()
	self:StopTimer()
	self:StopGame()

	local var_20_0 = ActivitySummerSwimsuitPreheatTools.GetCfgMainActivityId(self.cfg_)

	ActivitySummerSwimsuitPreheatAction.SendStageClear(var_20_0, self.cfg_.id, function()
		ActivitySummerSwimsuitPreheatAction.UpdateRedPoint(var_20_0)
		self:GotoResult()
	end)
end

function ActivitySummerSwimsuitPreheatGameView:GotoResult()
	if self.isAniPlaying_ then
		return
	end

	self:PlayEffects(function()
		self:Back()
		JumpTools.GoToSystem("activitySummerSwimsuitPreheatStage", {
			isWin = true,
			cfgId = self.cfgId_
		})
	end)
end

function ActivitySummerSwimsuitPreheatGameView:PlayEffects(arg_24_1)
	self.isAniPlaying_ = true

	self.stateController_:SetSelectedState("win")
	self.signAni_:Play("SummerUI_3_3_PreheatGameUI_Dec", -1, 0)
	self.signAni_:Update(0)
	self.panelAni_:Play("shutter_02", -1, 0)
	self.panelAni_:Update(0)
	manager.windowBar:HideBar()
	AnimatorTools.PlayAnimationWithCallback(self.panelAni_, "shutter_02", function()
		self.isAniPlaying_ = false

		self:InitBar()
		arg_24_1()
	end)
end

function ActivitySummerSwimsuitPreheatGameView:CreateControllerItem()
	self.controllerItemList_ = {}

	for iter_26_0 = 1, self.controllerItemPanelTrans_.childCount do
		self.controllerItemList_[iter_26_0] = ActivitySummerSwimsuitPreheatControllerItem.New(self.controllerItemPanelTrans_:GetChild(iter_26_0 - 1).gameObject)
	end
end

function ActivitySummerSwimsuitPreheatGameView:InitControllerItem()
	for iter_27_0, iter_27_1 in ipairs(self.controllerItemList_) do
		iter_27_1:InitData(self.cfgId_, iter_27_0)
	end
end

function ActivitySummerSwimsuitPreheatGameView:UpdateControllerItem(arg_28_1)
	if not self.canShowControllerTips_ then
		return
	end

	for iter_28_0, iter_28_1 in ipairs(self.controllerItemList_) do
		iter_28_1:UpdateGameData(arg_28_1)
	end
end

function ActivitySummerSwimsuitPreheatGameView:Dispose()
	for iter_29_0, iter_29_1 in ipairs(self.controllerItemList_) do
		iter_29_1:Dispose()
	end

	ActivitySummerSwimsuitPreheatGameView.super.Dispose(self)
end

return ActivitySummerSwimsuitPreheatGameView
