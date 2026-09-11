local PinballTools = import("game.tools.PinballTools")
local PinballStageView = class("PinballStageView", ReduxView)

function PinballStageView:UIName()
	return "Widget/Version/BaichaoUI_3_9/BaichaoUI_3_9_PinballUI/BaichaoUI_3_9_PinballCheckpointUI"
end

function PinballStageView:UIParent()
	return manager.ui.uiMain.transform
end

local function var_0_2(arg_3_0)
	return PinballData:GetStageCategoryActivityList()[arg_3_0 or 1]
end

local function var_0_3(arg_4_0, arg_4_1)
	arg_4_0[arg_4_1 .. "Controller"] = arg_4_0.controllers_:GetController(arg_4_1)
end

function PinballStageView:Init()
	self:BindCfgUI()
	self:InitUI()
	self:AddUIListener()
end

function PinballStageView:Dispose()
	PinballStageView.super.Dispose(self)
	self.stageList:Dispose()
	self.detailPanel.firstTimeDropRewardList:Dispose()

	if self.heroHeadItem then
		self.heroHeadItem:Dispose()
	end
end

function PinballStageView:OnEnter()
	self:SwitchDisplayStageCat(PinballData:GetLastEnterStageCategory(), true)
	self.stageList:StartScroll(#self:CurDisplayStageList())
	self:BindRedPoints()
end

function PinballStageView:OnExit()
	self:HideStageDetail()
	self:UnBindRedPoints()
end

function PinballStageView:OnTop()
	local var_9_0 = PinballTools.ActivityCoin()

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		var_9_0
	})
	manager.windowBar:SetBarCanClick(var_9_0, true)
	manager.windowBar:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			isPrefab = true,
			pages = {
				"Widget/Version/BaichaoUI_3_9/BaichaoUI_3_9_PinballUI/BaichaoUI_3_9_PinballDescription_01",
				"Widget/Version/BaichaoUI_3_9/BaichaoUI_3_9_PinballUI/BaichaoUI_3_9_PinballDescription_02",
				"Widget/Version/BaichaoUI_3_9/BaichaoUI_3_9_PinballUI/BaichaoUI_3_9_PinballDescription_03"
			}
		}
	})

	if ActivityTools.IsFirstEnterActivity(PinballData.activityID) then
		ActivityTools.MarkHasEnterActivity(PinballData.activityID)
		manager.windowBar:ShowGameHelp()
	end
end

function PinballStageView:OnBehind()
	manager.windowBar:HideBar()
end

local function var_0_4(arg_11_0)
	return nullable(ActivityCfg, PinballData:GetStageCategoryActivityList()[arg_11_0], "name")
end

function PinballStageView:EnsureItemInViewport(arg_12_1, arg_12_2)
	arg_12_1:ScrollToIndex(arg_12_2, true, true)
end

function PinballStageView:InitUI()
	var_0_3(self, "selectCategory")
	var_0_3(self, "showSubView")

	self.stageList = LuaList.New(handler(self, self.RenderStageItem), self.stageList_, PinballStageItem)

	function self:clickItemHandler()
		if self.stage == self.stageSelect then
			self:HideStageDetail()
		else
			self:DisplayStageDetail(self.stage)
			self:EnsureItemInViewport(self.stageList, self.index)
		end

		self.stageList:Refresh()
	end

	self.catName1_.text = var_0_4(1)
	self.catName2_.text = var_0_4(2)

	self:InitDetailPanel()

	if self.curHeroHeadItem_ then
		self.heroHeadItem = PinballRoleInfoView.RoleItem.New(self.curHeroHeadItem_)

		self.heroHeadItem:SetMuteRedPoint(true)
	end
end

function PinballStageView:InitDetailPanel()
	self.detailPanel = {}

	self:BindCfgUI(self.detailPanel_, self.detailPanel)

	self.detailPanel.stateController = self.detailPanel.controllerEx_:GetController("state")
	self.detailPanel.conditions = self:InitDetailConditionCom(self.detailPanel.conditionGo_)
	self.detailPanel.firstTimeDropRewardList = LuaList.New(handler(self, self.RenderFirstDrop), self.detailPanel.rewardUIListGo_, CommonItemView)
end

PinballStageView.InitDetailConditionCom = PinballTools.InitDetailConditionCom

local function var_0_5(arg_16_0)
	return PinballPlayerCfg.get_id_list_by_type[1][arg_16_0] or PinballPlayerCfg.get_id_list_by_type[1][1]
end

local function var_0_6(arg_17_0, arg_17_1)
	local var_17_0, var_17_1 = PinballData:GetStageUnlocked()

	if var_17_0 then
		PinballAction.PlayPinballGame(arg_17_0, arg_17_1)
	else
		ShowTips(var_17_1)
	end
end

function PinballStageView:CurDisplayStage()
	return var_0_2(self.stageCategory)
end

function PinballStageView:CurDisplayStageList()
	return PinballStageCfg.get_id_list_by_activity_id[self:CurDisplayStage()]
end

function PinballStageView:AddUIListener()
	self:AddBtnListenerScale(self.enterBtn_, nil, function()
		var_0_6(self.stageSelect, var_0_5(self.stageCategory))
	end)
	self:AddBtnListener(self.questBtn_, nil, function()
		local var_22_0 = PinballTools.GetTaskActivityID()

		if var_22_0 then
			JumpTools.OpenPageByJump("pinballTasks", {
				activityId = var_22_0
			})
		end
	end)
	self:AddBtnListener(self.changeRoleBtn_, nil, function()
		local var_23_0 = var_0_5(self.stageCategory)

		manager.redPoint:setTip(PinballTools.UpgradeRedPoint(var_23_0), 0)
		JumpTools.OpenPageByJump("/pinballRoleInfo", {
			heroID = var_23_0
		})
	end)
	self:AddBtnListenerScale(self.showCatBtn1_, nil, function()
		self:SwitchDisplayStageCat(1)
		self:UnBindUpdateRoleRedPoint()
		self:BindUpdateRoleRedPoint()
	end)
	self:AddBtnListenerScale(self.showCatBtn2_, nil, function()
		self:SwitchDisplayStageCat(2)
		self:UnBindUpdateRoleRedPoint()
		self:BindUpdateRoleRedPoint()
	end)
	self:AddBtnListenerScale(self.detailPanel.bossInfoBtn_, nil, function()
		self:GoToBossInfoView(self.stageSelect)
	end)
	self:AddBtnListener(self.hideDetailBtn_, nil, function()
		self:HideStageDetail()
		self.stageList:Refresh()
	end)
end

local function var_0_7(arg_28_0)
	local var_28_0 = PinballStageCfg.get_id_list_by_activity_id[var_0_2(arg_28_0)]
	local var_28_1 = 0

	for iter_28_0, iter_28_1 in ipairs(var_28_0) do
		if PinballData:GetStageComplete(iter_28_1) then
			var_28_1 = var_28_1 + 1
		end
	end

	return var_28_1, #var_28_0
end

function PinballStageView:SwitchDisplayStageCat(arg_29_1, arg_29_2)
	if self.stageCategory ~= arg_29_1 then
		self.stageCategory = arg_29_1

		self:HideStageDetail()

		if not arg_29_2 then
			self.stageList:StartScroll(#self:CurDisplayStageList())
		end

		PinballData:SetLastEnterStageCategory(arg_29_1)
		self.selectCategoryController:SetSelectedState(tostring(arg_29_1))

		self.title_.text = var_0_4(arg_29_1)

		local var_29_0, var_29_1 = var_0_7(arg_29_1)

		self.progress_.text = string.format("%d / %d", var_29_0, var_29_1)

		if self.heroHeadItem then
			self.heroHeadItem:SetData(var_0_5(arg_29_1))
			self.heroHeadItem:SetSelected(false)
		end
	end
end

function PinballStageView:RenderStageItem(arg_30_1, arg_30_2)
	local var_30_0 = self:CurDisplayStageList()[arg_30_1]

	arg_30_2:SetData(arg_30_1, var_30_0)
	arg_30_2:SetSelected(self.stageSelect == var_30_0)
	arg_30_2:SetOnClick(self.clickItemHandler)
end

function PinballStageView:RenderFirstDrop(arg_31_1, arg_31_2)
	local var_31_0

	if self.stageSelect == nil then
		do return end

		var_31_0 = nullable
	end

	local var_31_1 = var_31_0(PinballStageCfg, self.stageSelect, PinballData:GetStageComplete(self.stageSelect) and "repetition_reward" or "first_reward", arg_31_1)

	if var_31_1 then
		local var_31_2 = cfgToItemTemplate(var_31_1)

		function var_31_2.clickFun(arg_32_0)
			ShowPopItem(POP_ITEM, arg_32_0)
		end

		arg_31_2:SetData(var_31_2)
	end
end

function PinballStageView:DisplayStageDetail(arg_33_1)
	self.stageSelect = arg_33_1

	self.showSubViewController:SetSelectedState("true")
	self.stageList:Refresh()

	local var_33_0 = PinballStageCfg[arg_33_1]

	if PinballStageCfg[arg_33_1] then
		self.detailPanel.sectionName_.text = var_33_0.name

		local var_33_1, var_33_2 = PinballData:GetStageState(arg_33_1)

		self.detailPanel.stateController:SetSelectedState(var_33_1)

		if var_33_1 == "lock" then
			self.detailPanel.btnLockText_.text = var_33_2
		end

		for iter_33_0 = 1, PinballTools.CONDITOIN_CNT do
			PinballTools.RefreshDetailConditionCom(self.detailPanel.conditions[iter_33_0], arg_33_1, iter_33_0)
		end

		if PinballData:GetStageComplete(arg_33_1) then
			self.detailPanel.firstTimeDropRewardList:StartScroll(#var_33_0.repetition_reward)
		else
			self.detailPanel.firstTimeDropRewardList:StartScroll(#var_33_0.first_reward)
		end

		self.detailPanel.bossIcon_.spriteSync = PinballTools.GetBossIconPath(var_33_0.monster_list[1])
	end
end

function PinballStageView:HideStageDetail()
	self.detailPanel.firstTimeDropRewardList:StartScroll(0)

	self.stageSelect = nil

	self.showSubViewController:SetSelectedState("false")
end

function PinballStageView:GoToBossInfoView(arg_35_1)
	local var_35_0 = nullable(PinballStageCfg, arg_35_1, "monster_list", 1)

	if var_35_0 then
		JumpTools.OpenPageByJump("pinballBossInfo", {
			id = var_35_0
		})
	end
end

local function var_0_8(arg_36_0, arg_36_1)
	return string.format("%s_%d", arg_36_0, arg_36_1)
end

function PinballStageView:BindUpdateRoleRedPoint()
	manager.redPoint:bindUIandKey(self.changeRoleBtn_.transform, (PinballTools.UpgradeRedPoint((var_0_5(self.stageCategory)))))
end

function PinballStageView:UnBindUpdateRoleRedPoint()
	manager.redPoint:unbindUIandKey(self.changeRoleBtn_.transform)
end

function PinballStageView:BindRedPoints()
	self:BindUpdateRoleRedPoint()
	manager.redPoint:bindUIandKey(self.showCatBtn1_.transform, PinballTools.StageCatRedPoint(var_0_2(1)))
	manager.redPoint:bindUIandKey(self.showCatBtn2_.transform, PinballTools.StageCatRedPoint(var_0_2(2)))
	manager.redPoint:bindUIandKey(self.questBtn_.transform, var_0_8(RedPointConst.ACTIVITY_PINBALL_TASKS, PinballData.activityID))
end

function PinballStageView:UnBindRedPoints()
	self:UnBindUpdateRoleRedPoint()
	manager.redPoint:unbindUIandKey(self.showCatBtn1_.transform, PinballTools.StageCatRedPoint(var_0_2(1)))
	manager.redPoint:unbindUIandKey(self.showCatBtn2_.transform, PinballTools.StageCatRedPoint(var_0_2(2)))
	manager.redPoint:unbindUIandKey(self.questBtn_.transform, var_0_8(RedPointConst.ACTIVITY_PINBALL_TASKS, PinballData.activityID))
end

return PinballStageView
