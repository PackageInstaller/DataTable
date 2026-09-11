local AutoChessPVESelectStageView = class("AutoChessPVESelectStageView", ReduxView)

function AutoChessPVESelectStageView:UIName()
	return "Widget/System/Activity_OsirisHorus/Activity_OsirisHorus_Main/Activity_OsirisHorus_CheckpointMainUI"
end

function AutoChessPVESelectStageView:UIParent()
	return manager.ui.uiMain.transform
end

function AutoChessPVESelectStageView:Init()
	self:InitUI()

	self.curArea_ = 0
	self.canChangeDiff_ = false
	self.isDifficult_ = false
	self.stageList_ = {}
	self.tabList_ = {}
	self.stageItemList_ = {}
	self.selectHandle_ = handler(self, self.SelectStage)

	for iter_3_0 = 1, 3 do
		self.tabList_[iter_3_0] = AutoChessPVESelectStageTabItem.New(self["tabGo_" .. iter_3_0], function(arg_4_0)
			self:ChangeArea(arg_4_0, false)
		end)
		self.stageItemList_[iter_3_0] = AutoChessPVEStageItem.New(self["stageGo_" .. iter_3_0], self.selectHandle_)
	end

	self.headItem_ = AutoChessHeadItemView.New(self.headGo_, AutoChessConst.GAME_TYPE.PVE)
end

function AutoChessPVESelectStageView:InitUI()
	self:BindCfgUI()
	self:AddListener()

	self.tabLockController_ = self.mainControllerEx_:GetController("tablock")
	self.tabController_ = self.mainControllerEx_:GetController("tabswitchover")
	self.showTabController_ = self.mainControllerEx_:GetController("tab")
	self.bgController_ = self.mainControllerEx_:GetController("bg")
	self.disabledController_ = self.mainControllerEx_:GetController("disabled")

	self.tabLockController_:SetSelectedState("lock")
end

function AutoChessPVESelectStageView:AddListener()
	self:AddBtnListener(self.simpleBtn_, nil, function()
		self:OnClickSimple()
	end)
	self:AddBtnListener(self.diffBtn_, nil, function()
		self:OnClickDifficult()

		if self.isDifficult_ then
			saveData("auto_chess_pve_stage", "diffcult_" .. self.stageList_[4], 1)
			manager.redPoint:setTip(RedPointConst.AUTO_CHESS_PVE_STAGE_ITEM .. self.stageList_[4], 0)
		end
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		SetActive(self.maskBtn_.gameObject, false)
		self:SelectStage(0)
	end)
end

function AutoChessPVESelectStageView:OnClickDifficult()
	if not self.canChangeDiff_ then
		ShowTips("AUTO_CHESS_HARD_BOSS_LOCKED")

		return
	end

	if self.isDifficult_ then
		return
	end

	self.isDifficult_ = true

	self.stageItemList_[3]:SetData(self.stageList_[4], 3)
	self.tabController_:SetSelectedState("Difficulty")
end

function AutoChessPVESelectStageView:OnClickSimple()
	if not self.canChangeDiff_ then
		ShowTips("AUTO_CHESS_HARD_BOSS_LOCKED")

		return
	end

	if not self.isDifficult_ then
		return
	end

	self.isDifficult_ = false

	self.stageItemList_[3]:SetData(self.stageList_[3], 3)
	self.tabController_:SetSelectedState("Simple")
end

function AutoChessPVESelectStageView:OnEnter()
	AutoChessData:SetCurGameType(AutoChessConst.GAME_TYPE.PVE)

	for iter_12_0 = 1, 3 do
		self.tabList_[iter_12_0]:SetData(AutoChessAreaCfg.all[iter_12_0])
		manager.redPoint:bindUIandKey(self.tabList_[iter_12_0].transform_, RedPointConst.AUTO_CHESS_PVE_STAGE_AREA .. AutoChessAreaCfg.all[iter_12_0])
	end

	local function var_12_0()
		self.headItem_:RefreshUI()
		self:ChangeArea(AutoChessStageCfg[self:GetCurChallengeStage()].area, true)
	end

	local var_12_1 = AutoChessData:GetStageStoryId()

	if var_12_1 then
		gameContext:Go("/blank")
		manager.story:StartStoryById(var_12_1, function(arg_14_0)
			var_12_0()
			AutoChessData:SetStageStoryId(nil)
			JumpTools.Back()
		end)
	else
		var_12_0()
	end
end

function AutoChessPVESelectStageView:GetCurChallengeStage()
	if AutoChessTools.GetCurChallengeStage() > 0 then
		return AutoChessTools.GetCurChallengeStage()
	end

	return getData("auto_chess_pve_stage", "stage_id") or 101
end

function AutoChessPVESelectStageView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function AutoChessPVESelectStageView:OnExit()
	SetActive(self.maskBtn_.gameObject, false)
	manager.windowBar:HideBar()

	for iter_17_0 = 1, 3 do
		manager.redPoint:unbindUIandKey(self.tabList_[iter_17_0].transform_, RedPointConst.AUTO_CHESS_PVE_STAGE_AREA .. AutoChessAreaCfg.all[iter_17_0])
	end

	if AutoChessAreaCfg[self.curArea_] then
		manager.redPoint:unbindUIandKey(self.tabBtn_.transform, RedPointConst.AUTO_CHESS_PVE_STAGE_ITEM .. AutoChessAreaCfg[self.curArea_].stage_list[4])
	end
end

function AutoChessPVESelectStageView:Dispose()
	self.headItem_:Dispose()
	self:StopTimer()

	if self.tabLockTimer_ then
		self.tabLockTimer_:Stop()

		self.tabLockTimer_ = nil
	end

	for iter_18_0 = 1, 3 do
		self.tabList_[iter_18_0]:Dispose()
		self.stageItemList_[iter_18_0]:Dispose()
	end

	self.tabList_ = {}
	self.stageItemList_ = {}

	AutoChessPVESelectStageView.super.Dispose(self)
end

function AutoChessPVESelectStageView:ChangeArea(arg_19_1, arg_19_2)
	SetActive(self.maskBtn_.gameObject, false)
	self.disabledController_:SetSelectedState("false")

	if self.curArea_ == arg_19_1 and not arg_19_2 then
		self:SelectStage(0)

		return
	end

	if AutoChessData:IsMedalUnlocked(AutoChessMedalCfg.all[arg_19_1]) then
		if not getData("auto_chess_pve_stage", "logo_anim") then
			saveData("auto_chess_pve_stage", "logo_anim", 1)
			self.logoAnim_:Play("U_Logo_cx", 0, 0)
		end

		self.bgController_:SetSelectedIndex(arg_19_1 - 1)
	else
		self.bgController_:SetSelectedIndex(arg_19_1 - 1 + 3)
	end

	self.curArea_ = arg_19_1
	self.stageList_ = AutoChessAreaCfg[self.curArea_].stage_list

	manager.redPoint:bindUIandKey(self.tabBtn_.transform, RedPointConst.AUTO_CHESS_PVE_STAGE_ITEM .. AutoChessAreaCfg[self.curArea_].stage_list[4])

	self.isDifficult_ = false

	self:RefreshStage()
	self:RefreshAreaTabUI()

	local var_19_0 = self:GetCurChallengeStage()

	if AutoChessStageCfg[var_19_0].is_challenge == 1 and table.indexof(AutoChessAreaCfg[self.curArea_].stage_list, var_19_0) then
		self:OnClickDifficult()
	end

	self.tabController_:SetSelectedState(self.isDifficult_ and "Difficulty" or "Simple")
end

function AutoChessPVESelectStageView:SelectStage(arg_20_1)
	if arg_20_1 ~= 0 then
		SetActive(self.maskBtn_.gameObject, true)
	end

	for iter_20_0 = 1, 3 do
		self.stageItemList_[iter_20_0]:SetSelect(arg_20_1)
	end
end

function AutoChessPVESelectStageView:RefreshAreaTabUI()
	if AutoChessTools.IsStageUnlock(self.stageList_[3]) then
		self.showTabController_:SetSelectedState("on")
	else
		self.showTabController_:SetSelectedState("off")
	end

	if AutoChessTools.IsStageUnlock(self.stageList_[4]) then
		self.canChangeDiff_ = true

		if (getData("auto_chess_pve_stage", "difficulty_" .. self.stageList_[4]) or 0) == 0 then
			if self.curArea_ ~= AutoChessAreaCfg.all[#AutoChessAreaCfg.all] then
				self.disabledController_:SetSelectedState("true")
			end

			self.tabLockTimer_ = Timer.New(function()
				self.difficultAnim_:Play("U_unlockDifficulty_cx", 0, 0)
			end, 1, 1):Start()
			self.tabTimer_ = Timer.New(function()
				self.tabLockController_:SetSelectedState("unlock")
				saveData("auto_chess_pve_stage", "difficulty_" .. self.stageList_[4], 1)
				self.stageItemList_[3]:SelectDifficult(handler(self, self.ChangeArea))
				self:OnClickDifficult()
			end, 1.5, 1)

			self.tabTimer_:Start()
		else
			self.disabledController_:SetSelectedState("false")
			self.tabLockController_:SetSelectedState("unlock")
		end
	else
		self.canChangeDiff_ = false

		self.disabledController_:SetSelectedState("false")
		self.tabLockController_:SetSelectedState("lock")
		self.difficultAnim_:Play("U_lockDifficulty_cx", 0, 0)
	end

	for iter_21_0 = 1, 3 do
		self.tabList_[iter_21_0]:SetSelect(self.curArea_)
	end
end

function AutoChessPVESelectStageView:StopTimer()
	if self.tabTimer_ then
		self.tabTimer_:Stop()

		self.tabTimer_ = nil
	end
end

function AutoChessPVESelectStageView:RefreshStage()
	for iter_25_0 = 1, 3 do
		self.stageItemList_[iter_25_0]:SetData(self.stageList_[(iter_25_0 == 3 and self.isDifficult_ or nil) and iter_25_0 + 1], iter_25_0)
	end

	self:SelectStage(0)
end

return AutoChessPVESelectStageView
