local DormLinkGameLevelView = class("DormLinkGameLevelView", ReduxView)

local function var_0_1(arg_1_0)
	return arg_1_0.time > arg_1_0.initialTime and arg_1_0.time <= arg_1_0.duration
end

function DormLinkGameLevelView:UIName()
	return "Widget/Version/Alone_LinkGame/Alone_LGStageUI"
end

function DormLinkGameLevelView:UIParent()
	return manager.ui.uiMain.transform
end

function DormLinkGameLevelView:OnCtor()
	return
end

function DormLinkGameLevelView:Init()
	self:InitUI()
	self:AddUIListener()
end

local function var_0_2(arg_6_0)
	return "stage" .. arg_6_0 .. "Tgl_"
end

local var_0_3 = 9

function DormLinkGameLevelView:InitUI()
	self:BindCfgUI()

	self.stageBtnCtrl = {}

	local var_7_0 = {
		"select",
		"lock",
		"clear"
	}

	for iter_7_0 = 1, var_0_3 do
		local var_7_1 = nullable(self, var_0_2(iter_7_0), "transform")

		if var_7_1 then
			local var_7_2 = var_7_1:GetComponent("ControllerExCollection")
			local var_7_3 = {}

			self:BindCfgUI(var_7_1, var_7_3)

			for iter_7_1, iter_7_2 in ipairs(var_7_0) do
				var_7_3[iter_7_2] = var_7_2:GetController(iter_7_2)
			end

			self.stageBtnCtrl[iter_7_0] = var_7_3
		else
			break
		end
	end

	self.modeController = self.mode_:GetController("mode")
	self.detailPanel = {}

	self:BindCfgUI(self.detailPanel_, self.detailPanel)

	self.detailPanel.easyLockController = self.detailPanel.normal_:GetController("easyLevelLock")
	self.detailPanel.hardLockController = self.detailPanel.normal_:GetController("hardLevelLock")
	self.detailPanel.normalLockController = self.detailPanel.normal_:GetController("lock")
	self.detailPanel.spLockController = self.detailPanel.sp_:GetController("lock")
end

local function var_0_4(arg_8_0)
	return string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(arg_8_0))
end

local function var_0_5(arg_9_0)
	return string.format(GetTips("ACTIVITY_LINKGAME_PRE_LIMIT"), ActivityCfg[ActivityLinkGameCfg[arg_9_0].pre_stage].remark)
end

local function var_0_6(arg_10_0)
	local var_10_0, var_10_1, var_10_2 = DormLinkGameTools:ChecklevelUnLock(arg_10_0)

	if var_10_0 then
		return nil
	else
		if var_10_1 == DormLinkGameConst.LevelLockType.time then
			return var_0_4(ActivityData:GetActivityData(ActivityLinkGameCfg[arg_10_0].activity_id).startTime)
		elseif var_10_1 == DormLinkGameConst.LevelLockType.stop then
			return GetTips("TIME_OVER")
		elseif var_10_1 == DormLinkGameConst.LevelLockType.preLevel then
			return var_0_5(arg_10_0)
		end

		return ""
	end
end

function DormLinkGameLevelView:GoToGame(arg_11_1)
	if arg_11_1 then
		local var_11_0 = var_0_6(arg_11_1)

		if var_11_0 then
			ShowTips(var_11_0)
		else
			DormLinkGameData:CheckToEnterDormLinkScene(arg_11_1)
			manager.audio:PlayBGM("ui_battle", "ui_battle_stopbgm", "ui_battle.awb")
		end
	end
end

function DormLinkGameLevelView:AddUIListener()
	for iter_12_0 = 1, var_0_3 do
		self:AddBtnListenerScale(self[var_0_2(iter_12_0)], nil, function()
			if var_0_1(self.enterAniDirector_) then
				self.enterAniDirector_.time = self.enterAniDirector_.duration

				self.enterAniDirector_:Evaluate()
			end

			self:SelLevel((self.selIndex == iter_12_0 or nil) and nil)
		end)
	end

	self:AddBtnListener(self.emptyAreaBtn_, nil, function()
		if var_0_1(self.enterAniDirector_) then
			return
		end

		self:SelLevel(nil)
	end)
	self:AddBtnListenerScale(self.receiveBtn_, nil, function()
		JumpTools.OpenPageByJump("dormLinkGameActivityView", {
			activityID = self.activityID
		})
	end)
	self:AddBtnListenerScale(self.detailPanel.goToEasy_, nil, function()
		if self.easyLevel then
			self:GoToGame(self.easyLevel)
		end
	end)
	self:AddBtnListenerScale(self.detailPanel.goToHard_, nil, function()
		if self.hardLevel then
			self:GoToGame(self.hardLevel)
		end
	end)
	self:AddBtnListenerScale(self.detailPanel.goToSp_, nil, function()
		if self.spLevel then
			self:GoToGame(self.spLevel)
		end
	end)
	self:AddBtnListener(self.tipBtn_, nil, DormLinkGameTools.OpenGameTips)
end

function DormLinkGameLevelView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

local var_0_7 = 1e-14

function DormLinkGameLevelView:OnEnter()
	self.activityID = self.params_.activityID or DormLinkGameData:GetMainActivityID()
	self.levelActivityList = DormLinkGameTools:GetLevelActivityList(self.activityID)

	table.sort(self.levelActivityList)
	DormLinkGameData:HideLevelRedPoint()
	self:RefreshView()
	self:SelLevel(nil, true)
	manager.redPoint:bindUIandKey(self.receiveBtn_.transform, DormLinkGameData:RedPointKey(DormLinkGameData.LIANLIANKAN_LEVEL_REWARD))

	self.enterAniDirector_.time = var_0_7

	self.enterAniDirector_:Evaluate()
	self:StartTimeRefresh()
end

function DormLinkGameLevelView:StartTimeRefresh()
	self:StopTimeRefresh()

	self.timer = Timer.New(function()
		self:UpdataLastTime()
	end, 1, -1)

	self.timer:Start()
end

function DormLinkGameLevelView:StopTimeRefresh()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

function DormLinkGameLevelView:RefreshView()
	self:UpdataLastTime()
	self:UpdataLevelState()

	self.titleTxt_.text = ActivityCfg[self.activityID].remark
	self.uiCharacterImage_.sprite = getSpriteWithoutAtlas(DormLinkGameTools.GetVersionCharaImgPath(self.activityID))
end

local var_0_8 = "--"

local function var_0_9(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = var_0_6(arg_25_0)

	if arg_25_0 and var_25_0 == nil then
		arg_25_1:SetSelectedState("false")

		arg_25_3.text = DormLinkGameData:GetLevelScore(arg_25_0) or var_0_8
	else
		arg_25_1:SetSelectedState("true")

		arg_25_3.text = var_0_8
		arg_25_2.text = var_25_0
	end
end

function DormLinkGameLevelView:UpdateSpLevelDetail()
	var_0_9(self.spLevel, self.detailPanel.spLockController, self.detailPanel.spLockMsg_, self.detailPanel.spScore_)
end

function DormLinkGameLevelView:UpdateNormalLevelDetail()
	var_0_9(self.easyLevel, self.detailPanel.easyLockController, self.detailPanel.easyLockMsg_, self.detailPanel.easyScore_)
	var_0_9(self.hardLevel, self.detailPanel.hardLockController, self.detailPanel.hardLockMsg_, self.detailPanel.hardScore_)
end

function DormLinkGameLevelView:SelLevel(arg_28_1, arg_28_2)
	if arg_28_1 == nil then
		if self.selIndex then
			self.selIndex = nil

			self.levelPanelAni_:Play("Fx_NorseUI_3_2_LGStageUI_right_Back", 0, arg_28_2 and 1 or 0)
		end

		self.easyLevel, self.hardLevel, self.spLevel = nil
	else
		local var_28_1

		var_28_1, self.selIndex = self.selIndex, arg_28_1

		local var_28_2 = self.levelActivityList[arg_28_1]

		self.easyLevel, self.hardLevel, self.spLevel = DormLinkGameData:GetLevelControlledByActivity(self.levelActivityList[arg_28_1])

		if var_28_1 == nil then
			self.levelPanelAni_:Play("Fx_NorseUI_3_2_LGStageUI_right_skip", 0, arg_28_2 and 1 or 0)
		end

		if self.spLevel then
			self.modeController:SetSelectedState("special")
			self:UpdateSpLevelDetail()
		else
			self.modeController:SetSelectedState("normal")
			self:UpdateNormalLevelDetail()
		end

		self.detailPanel.levelTitle_.text = ActivityCfg[var_28_2].remark
		self.detailPanel.levelDesc_.text = ActivityLinkGameCfg[self.easyLevel or self.spLevel].linkgame_des
	end

	self:UpdataLevelState()
end

local function var_0_10(arg_29_0)
	local var_29_0

	if ActivityLinkGameCfg.get_id_list_by_activity_id[arg_29_0] then
		for iter_29_0, iter_29_1 in ipairs(ActivityLinkGameCfg.get_id_list_by_activity_id[arg_29_0]) do
			local var_29_1 = DormLinkGameData:GetLevelScore(iter_29_1)

			if var_29_0 == nil or var_29_1 and var_29_0 < var_29_1 then
				var_29_0 = var_29_1
			end
		end
	end

	return tostring(var_29_0 or var_0_8)
end

function DormLinkGameLevelView:UpdateStageBtn(arg_30_1, arg_30_2)
	local var_30_0 = self.levelActivityList[arg_30_1]
	local var_30_1 = self.stageBtnCtrl[arg_30_1]

	if DormLinkGameTools:CheckLevelActivityUnlock(self.levelActivityList[arg_30_1]) and DormLinkGameTools:CheckAnyLevelInActivityUnlock(var_30_0) then
		var_30_1.lock:SetSelectedState("false")

		if var_30_1.clear then
			if DormLinkGameData:CheckActivityComplete(var_30_0) then
				var_30_1.clear:SetSelectedState("true")
			else
				var_30_1.clear:SetSelectedState("false")
			end
		end
	else
		var_30_1.lock:SetSelectedState("true")
	end

	var_30_1.select:SetSelectedState(arg_30_1 == self.selIndex and "true" or "false")

	if var_30_1.score_ then
		var_30_1.score_.text = var_0_10(var_30_0)
	end
end

function DormLinkGameLevelView:UpdataLastTime()
	local var_31_0 = ActivityData:GetActivityData(self.activityID)
	local var_31_1 = manager.time:GetServerTime()

	self.lastTime_.text = var_31_1 < var_31_0.startTime and GetTips("SOLO_NOT_OPEN") or var_31_1 < var_31_0.stopTime and manager.time:GetLostTimeStrWith2Unit(var_31_0.stopTime, true) or GetTips("TIME_OVER")
end

function DormLinkGameLevelView:UpdataLevelState()
	local var_32_0 = DormLinkGameData:GetLevelInfoList()

	if var_32_0 then
		for iter_32_0 = 1, DormLinkGameConst.LevelMax do
			self:UpdateStageBtn(iter_32_0, var_32_0)
		end
	end
end

function DormLinkGameLevelView:OnBehind()
	manager.windowBar:HideBar()
end

function DormLinkGameLevelView:OnExit()
	self:StopTimeRefresh()
	self:RemoveAllEventListener()
	manager.redPoint:unbindUIandKey(self.receiveBtn_.transform, DormLinkGameData:RedPointKey(DormLinkGameData.LIANLIANKAN_LEVEL_REWARD))
end

function DormLinkGameLevelView:Dispose()
	if self.countTimer then
		self.countTimer:Stop()

		self.countTimer = nil
	end

	DormLinkGameLevelView.super.Dispose(self)
end

return DormLinkGameLevelView
