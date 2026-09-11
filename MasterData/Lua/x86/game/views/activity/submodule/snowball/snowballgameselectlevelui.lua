local SnowballGameSelectLevelUI = class("SnowballGameSelectLevelUI", ReduxView)

function SnowballGameSelectLevelUI:UIName()
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionSnowballUI/SnowballGameSelectLevelUI"
end

function SnowballGameSelectLevelUI:UIParent()
	return manager.ui.uiMain.transform
end

local var_0_1 = {
	hard = 2,
	inf = 3,
	normal = 1
}
local var_0_2 = -1

function SnowballGameSelectLevelUI:Init()
	self:BindCfgUI()
	self:AdaptScreen()
	self:InitLevels()

	self.readyController = ControllerUtil.GetController(self.transform_, "levelSelected")
	self.hardLevelLockedController = ControllerUtil.GetController(self.transform_, "hardLevelLocked")
	self.modeController = ControllerUtil.GetController(self.transform_, "mode")
	self.hardLevelBonusController = ControllerUtil.GetController(self.transform_, "bonus")
	self.showLevelCostController = ControllerUtil.GetController(self.transform_, "cost")
	self.lastSelect = {}

	self:AddBtnListener(self.normalBtn_, nil, function()
		if self.select == var_0_2 then
			return
		end

		if self.mode ~= var_0_1.normal then
			self.modeChangeAnimator_:Play("normal")
		end

		self.mode = var_0_1.normal
		self.select = nullable(self.lastSelect, var_0_1.normal) or 1

		self:RefreshLevelsUI()
	end)
	self:AddBtnListener(self.hardBtn_, nil, function()
		if self.select == var_0_2 then
			return
		end

		if not self:CheckAnyHardLevelUnlocked() then
			ShowTips("ACTIVITY_SNOWBALL_LEVEL_MODE_TIPS")

			return
		end

		if self.mode ~= var_0_1.hard then
			self.modeChangeAnimator_:Play("hard")
		end

		self.mode = var_0_1.hard
		self.select = nullable(self.lastSelect, var_0_1.hard) or 1

		self:RefreshLevelsUI()
	end)
	self:AddBtnListener(self.startBtn_, nil, handler(self, self.GoToGame))
	self:AddBtnListener(self.iceBtn_, nil, function()
		JumpTools.OpenPageByJump("/SnowBallInfinityMainView", {
			activityID = SnowballGameData.activityID
		})
	end)
	self:AddBtnListener(self.changePlayerBtn_, nil, function()
		JumpTools.OpenPageByJump("/snowballGameChangePlayer")
	end)
	self:AddBtnListener(self.questBtn_, nil, function()
		JumpTools.OpenPopUp("snowballQuestPopup")
	end)
end

local function var_0_3(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = {}

	arg_9_0:BindCfgUI(arg_9_1, var_9_0)

	var_9_0.idx = arg_9_2
	var_9_0.difficultyController = ControllerUtil.GetController(arg_9_1.transform, "difficulty")
	var_9_0.modeController = ControllerUtil.GetController(arg_9_1.transform, "mode")
	var_9_0.selectController = ControllerUtil.GetController(arg_9_1.transform, "select")

	arg_9_0:AddBtnListener(var_9_0.btn_, nil, function()
		if SnowballGameSelectLevelUI.CheckLevel(arg_9_0:GetLevel(arg_9_2), false, true) then
			arg_9_0.select = arg_9_2

			if arg_9_2 == var_0_2 then
				arg_9_0.lastSelect[var_0_1.inf] = arg_9_2
			else
				arg_9_0.lastSelect[arg_9_0.mode] = arg_9_2
			end

			arg_9_0:RefreshLevelsUI()
		end
	end)

	return var_9_0
end

function SnowballGameSelectLevelUI:InitLevels()
	self.levels = {}

	for iter_11_0 = 1, self.levelsRoot_.childCount do
		self.levels[iter_11_0] = var_0_3(self, GameObject.Instantiate(self.levelPrefab_, (self.levelsRoot_:GetChild(iter_11_0 - 1))), iter_11_0)
	end

	local var_11_0 = var_0_3(self, self.infLevelBtn_.gameObject, var_0_2)

	var_11_0.lockByTime = ControllerUtil.GetController(self.infLevelBtn_.transform, "lockByTime")
	self.levels[var_0_2] = var_11_0
end

function SnowballGameSelectLevelUI:StartTimer()
	self:StopTimer()
	self:RefreshTimeText()

	if manager.time:GetServerTime() > self.infLevelStop then
		return
	end

	local var_12_0 = manager.time:GetServerTime() < self.infLevelStart

	self.timer = Timer.New(function()
		local var_13_0 = manager.time:GetServerTime()

		if var_13_0 > self.infLevelStop then
			self:RefreshLevelsUI()
		elseif var_12_0 and var_13_0 >= self.infLevelStart then
			var_12_0 = false

			self:RefreshLevelsUI()
		end

		self:RefreshTimeText()
	end, 1, -1)

	self.timer:Start()
end

function SnowballGameSelectLevelUI:StopTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

function SnowballGameSelectLevelUI:RefreshTimeText()
	local var_15_0 = ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_SNOWBALL_INF_LEVEL)

	self.levels[var_0_2].lockByTime:SetSelectedState(var_15_0 and "false" or "true")

	self.activityCountdown_.text = manager.time:GetLostTimeStr2(ActivityData:GetActivityData(SnowballGameData.activityID).stopTime, nil, true)

	if not var_15_0 and self.infLevelCountdown_ then
		self.infLevelCountdown_.text = manager.time:GetLostTimeStr2(self.infLevelStart)
	end
end

function SnowballGameSelectLevelUI:OnEnter()
	local var_16_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_SNOWBALL_INF_LEVEL)

	self.infLevelStart = var_16_0.startTime
	self.infLevelStop = var_16_0.stopTime
	self.mode = self.mode or var_0_1.normal

	local var_16_1 = self.select or 1

	self.select = SnowballGameSelectLevelUI.CheckLevel(self:GetLevel(var_16_1), false, false) and var_16_1 or nil

	self:RefreshLevelsUI()
	self:StartTimer()
	self:RegistEventListener(ACTIVITY_UPDATE, handler(self, self.OnActivityUpdate))
	manager.redPoint:setTip(RedPointConst.ACTIVITY_2_6_SNOWBALL_UNCOMPLETE_LEVEL, 0)
	manager.redPoint:bindUIandKey(self.iceBtn_.transform, SnowballGameData:GetInfPoolRedPointKey(1))
	manager.redPoint:bindUIandKey(self.questBtn_.transform, RedPointConst.ACTIVITY_2_6_SNOWBALL_TASK_CHALLENGE)
end

function SnowballGameSelectLevelUI:OnExit()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
	self:StopTimer()
	manager.redPoint:unbindUIandKey(self.iceBtn_.transform, SnowballGameData:GetInfPoolRedPointKey(1))
	manager.redPoint:unbindUIandKey(self.questBtn_.transform, RedPointConst.ACTIVITY_2_6_SNOWBALL_TASK_CHALLENGE)
end

function SnowballGameSelectLevelUI:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		MaterialConst.SNOWBALL_ACTIVITY_STAGE_COIN,
		MaterialConst.SNOWBALL_ACTIVITY_ICE_COIN
	})
	manager.windowBar:SetBarCanAdd(MaterialConst.SNOWBALL_ACTIVITY_STAGE_COIN, true)
	manager.windowBar:SetBarCanAdd(MaterialConst.SNOWBALL_ACTIVITY_ICE_COIN, true)
	manager.windowBar:SetGameHelpKey("ACTIVITY_SNOWBALL_DESC")
	manager.windowBar:RegistBackCallBack(function()
		DestroyLua()
		LuaExchangeHelper.GoToMain()
		ActivityTools.JumpBackToActivityMainViewByActivityID(SnowballGameData.activityID)
	end)
end

function SnowballGameSelectLevelUI:OnBehind()
	manager.windowBar:HideBar()
end

function SnowballGameSelectLevelUI:GetLevel(arg_21_1)
	if arg_21_1 == var_0_2 then
		return nullable(SnowballGameCfg.get_id_list_by_level_mode, var_0_1.inf, 1)
	end

	return nullable(SnowballGameCfg.get_id_list_by_level_mode[self.mode], arg_21_1)
end

function SnowballGameSelectLevelUI:LevelLocked(arg_22_1)
	return not SnowballGameData:IsLevelUnlocked(arg_22_1)
end

function SnowballGameSelectLevelUI:LevelComplted(arg_23_1)
	return SnowballGameData:GetLevelHighScore(arg_23_1)
end

function SnowballGameSelectLevelUI:OnActivityUpdate(arg_24_1)
	if ActivityTools.GetActivityType(arg_24_1) == ActivityTemplateConst.MINIGAME_STAGE then
		self:RefreshLevelsUI()
	end
end

function SnowballGameSelectLevelUI:RefreshLevelsUI()
	local var_25_0 = self:GetLevel(self.select)

	self.hardLevelLockedController:SetSelectedState(self:CheckAnyHardLevelUnlocked() and "false" or "true")

	if self.select ~= var_0_2 then
		self.modeController:SetSelectedState(self.mode == var_0_1.normal and "normal" or "hard")
	else
		self.modeController:SetSelectedState("lock")
	end

	for iter_25_0, iter_25_1 in pairs(self.levels) do
		if iter_25_1.difficultyController then
			iter_25_1.difficultyController:SetSelectedState(self.mode == var_0_1.normal and "normal" or "hard")
		end

		iter_25_1.selectController:SetSelectedState(self.select == iter_25_0 and "true" or "false")

		local var_25_1 = self:GetLevel(iter_25_0)
		local var_25_2 = self:LevelComplted(var_25_1)

		if var_25_1 == nil or self:LevelLocked(var_25_1) then
			iter_25_1.modeController:SetSelectedState("lock")
		elseif var_25_2 then
			iter_25_1.modeController:SetSelectedState("completed")

			iter_25_1.score_.text = var_25_2
		else
			iter_25_1.modeController:SetSelectedState("unlock")

			if SnowballGameData:IsLevelFirstUnlocked(var_25_1) then
				DormUtils.CallOnNextUpdate(function()
					iter_25_1.unlockAnimator_:Play("unlock")
				end)
				SnowballGameData:CacheLevelAlreadyUnlocked(var_25_1)
			end
		end

		iter_25_1.name_.text = SnowballGameCfg[var_25_1].level_name
	end

	self.readyController:SetSelectedState(var_25_0 == nil and "false" or "true")

	if var_25_0 then
		local var_25_3 = SnowballGameCfg[var_25_0].level_mode

		if SnowballGameCfg[var_25_0].level_cost[1] == nil then
			self.showLevelCostController:SetSelectedState("hide")
		else
			self.showLevelCostController:SetSelectedState("show")

			self.consumeIcon_.sprite = ItemTools.getItemLittleSprite(SnowballGameCfg[var_25_0].level_cost[1][1])
			self.consumeText_.text = "x" .. SnowballGameCfg[var_25_0].level_cost[1][2]
		end

		local var_25_4 = GameSetting.activity_snowball_score_difficulty_factor.value[var_25_3] or 1

		self.hardLevelBonusController:SetSelectedState(var_25_4 ~= 1 and "on" or "off")

		self.bonus_.text = "x" .. var_25_4
	end
end

function SnowballGameSelectLevelUI:CheckLevel(arg_27_1, arg_27_2)
	local var_27_0, var_27_1, var_27_2 = SnowballGameData:IsLevelUnlocked(self, arg_27_2)

	if var_27_0 then
		if not arg_27_1 or SnowballGameData:CheckLevelCost(self) then
			return true
		elseif arg_27_2 then
			manager.tips:ShowTips(GetTipsF("ACTIVITY_SNOWBALL_LEVEL_COST_FAILED", (ItemTools.getItemName(MaterialConst.SNOWBALL_ACTIVITY_STAGE_COIN))))
		end
	elseif arg_27_2 and var_27_1 == SnowballGameData.LevelLockReason.NEED_UNLOCK_OTHER_LEVEL then
		manager.tips:ShowTips(GetTipsF("ACTIVITY_SNOWBALL_LEVEL_LOCKED", SnowballGameCfg[var_27_2].level_desc))
	end

	return false
end

function SnowballGameSelectLevelUI:CheckAnyHardLevelUnlocked()
	for iter_28_0, iter_28_1 in ipairs(SnowballGameCfg.get_id_list_by_level_mode[var_0_1.hard]) do
		if SnowballGameSelectLevelUI.CheckLevel(iter_28_1) then
			return true
		end
	end

	return false
end

function SnowballGameSelectLevelUI:GoToGame()
	local var_29_0 = self:GetLevel(self.select)

	if SnowballGameSelectLevelUI.CheckLevel(var_29_0, true, true) then
		JumpTools.OpenPageByJump("/snowballGameEnterUI", {
			level = var_29_0
		})
	end
end

return SnowballGameSelectLevelUI
