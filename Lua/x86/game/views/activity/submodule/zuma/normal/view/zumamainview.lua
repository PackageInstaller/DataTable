local var_0_0 = class("ZumaMainView", ReduxView)
local var_0_1 = {
	tabState = {
		hard = "state1",
		name = "tab",
		endless = "state2",
		night = "state2",
		easy = "state0"
	},
	tabLockState = {
		onlyNightLock = "state1",
		name = "lock",
		onlyEasyOpen = "state2",
		allOpen = "state0"
	},
	rankShow = {
		noData = "state0",
		name = "ranking",
		showData = "state1"
	}
}

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ZumaUI/NorseUI_3_0_ZumaUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.InitData(arg_3_0)
	arg_3_0.difficultList = {
		ZumaConst.ZUMA_DIFFICULT.ESAY,
		ZumaConst.ZUMA_DIFFICULT.HARD,
		ZumaConst.ZUMA_DIFFICULT.NIGHT
	}
	arg_3_0.chapterCalss = ZumaMainViewChapterInfo
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitData()
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.leftRootTrsCanvas = arg_5_0.leftRootTrs_:GetComponent(typeof(CanvasGroup))
	arg_5_0.tabStateController = arg_5_0.controllerexcollection_:GetController(var_0_1.tabState.name)
	arg_5_0.tabLockStateController = arg_5_0.controllerexcollection_:GetController(var_0_1.tabLockState.name)
	arg_5_0.rankShowController = arg_5_0.controllerexcollection_:GetController(var_0_1.rankShow.name)
	arg_5_0.chapterInfoView = arg_5_0.chapterCalss.New(arg_5_0.chaptersectioninfouiGo_)

	arg_5_0.chapterInfoView:IsShowPanel(false)

	arg_5_0.stageInfoViewList = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.difficultList) do
		local var_5_0 = ZumaConst.ZUMA_DIFFICULT_VIEW_NAME[iter_5_1]

		if iter_5_1 == ZumaConst.ZUMA_DIFFICULT.ENDLESS then
			arg_5_0.stageInfoViewList[iter_5_1] = SpringFestivalZumaEndlessStageInfoView.New(arg_5_0[var_5_0], iter_5_1)
		else
			arg_5_0.stageInfoViewList[iter_5_1] = ZumaMainStageInfoView.New(arg_5_0[var_5_0], iter_5_1)
		end
	end
end

function var_0_0.CheckIsEndless(arg_6_0)
	if arg_6_0.selectDifficultType and arg_6_0.selectDifficultType == ZumaConst.ZUMA_DIFFICULT.ENDLESS then
		return true
	end

	return false
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.easyBtn_, nil, function()
		arg_7_0:OnClickStageDifficultChangeBtn(ZumaConst.ZUMA_DIFFICULT.ESAY)
	end)
	arg_7_0:AddBtnListener(arg_7_0.hardBtn_, nil, function()
		arg_7_0:OnClickStageDifficultChangeBtn(ZumaConst.ZUMA_DIFFICULT.HARD)
	end)

	if arg_7_0.nightmareBtn_ then
		arg_7_0:AddBtnListener(arg_7_0.nightmareBtn_, nil, function()
			arg_7_0:OnClickStageDifficultChangeBtn(ZumaConst.ZUMA_DIFFICULT.NIGHT)
		end)
	end

	arg_7_0:AddBtnListener(arg_7_0.taskBtn_, nil, function()
		JumpTools.OpenPageByJump("ZumaTask")
	end)
	arg_7_0:AddBtnListener(arg_7_0.talentBtn_, nil, function()
		JumpTools.OpenPageByJump("/ZumaTalent")
	end)
	arg_7_0:AddBtnListener(arg_7_0.bgBtn_, nil, function()
		arg_7_0:RefreshZumaChapterInfo()
	end)
	arg_7_0:AddBtnListener(arg_7_0.maskBtn_, nil, function()
		arg_7_0:RefreshZumaChapterInfo()
	end)
	arg_7_0:AddBtnListener(arg_7_0.btnrankingBtn_, nil, function()
		arg_7_0:OnClickRankBtn()
	end)
	arg_7_0:RegistEventListener(ACTIVITY_UPDATE, function(arg_16_0)
		local var_16_0 = ActivityTools.GetActivityType(arg_16_0)

		if var_16_0 == ActivityTemplateConst.ACTIVITY_ZUMA_ENTER or var_16_0 == ActivityTemplateConst.ACTIVITY_ZUMA then
			arg_7_0:UpdateStageList()
			arg_7_0.chapterInfoView:UpdateBtnController()
		end
	end)
end

function var_0_0.OnClickRankBtn(arg_17_0)
	local var_17_0 = 242881

	JumpTools.OpenPageByJump("/ZumaRank", {
		rank_activity_id = var_17_0
	})
end

function var_0_0.OnClickStageDifficultChangeBtn(arg_18_0, arg_18_1)
	if arg_18_0.selectDifficultType == arg_18_1 then
		return
	end

	local var_18_0

	if arg_18_1 == ZumaConst.ZUMA_DIFFICULT.ESAY then
		var_18_0 = var_0_1.tabState.easy
	elseif arg_18_1 == ZumaConst.ZUMA_DIFFICULT.HARD then
		var_18_0 = var_0_1.tabState.hard
	elseif arg_18_1 == ZumaConst.ZUMA_DIFFICULT.NIGHT then
		var_18_0 = var_0_1.tabState.night
	elseif arg_18_1 == ZumaConst.ZUMA_DIFFICULT.ENDLESS then
		var_18_0 = var_0_1.tabState.endless
	end

	arg_18_0.tabStateController:SetSelectedState(var_18_0)

	arg_18_0.selectDifficultType = arg_18_1

	if arg_18_0.selectDifficultType == ZumaConst.ZUMA_DIFFICULT.NIGHT or arg_18_0.selectDifficultType == ZumaConst.ZUMA_DIFFICULT.ENDLESS then
		local var_18_1 = arg_18_0.stageInfoViewList[arg_18_1]:GetAllScore()

		if var_18_1 == 0 then
			arg_18_0.rankShowController:SetSelectedState(var_0_1.rankShow.noData)
		else
			arg_18_0.rankShowController:SetSelectedState(var_0_1.rankShow.showData)
		end

		arg_18_0.numText_.text = var_18_1
	end

	if arg_18_1 == ZumaConst.ZUMA_DIFFICULT.ENDLESS then
		ZumaData:SetZumaEndless(true)
	else
		ZumaData:SetZumaEndless(false)
	end
end

function var_0_0.RefreshZumaChapterInfo(arg_19_0, arg_19_1)
	if not arg_19_1 then
		arg_19_0.chapterInfoView:IsShowPanel(false)

		if arg_19_0.selectStageItem then
			arg_19_0.selectStageItem:UpdateSelectState(false)
			arg_19_0.stageInfoViewList[arg_19_0.selectDifficultType]:UpdateMoveView()
		end

		arg_19_0.selectStageItem = nil
		arg_19_0.leftRootTrsCanvas.blocksRaycasts = true

		return
	end

	arg_19_0.chapterInfoView:RefreshUI(arg_19_1)

	arg_19_0.leftRootTrsCanvas.blocksRaycasts = false
end

function var_0_0.UpdateZumaStageSelectItem(arg_20_0, arg_20_1)
	if arg_20_0:CheckIsEndless() then
		local var_20_0 = arg_20_0.stageInfoViewList[arg_20_0.selectDifficultType]:GetLevelCfg()

		arg_20_0:RefreshZumaChapterInfo(var_20_0)

		return
	end

	arg_20_0:SelectStageItem(arg_20_1)
end

function var_0_0.SelectStageItem(arg_21_0, arg_21_1)
	if arg_21_0:CheckIsEndless() then
		return
	end

	local var_21_0 = arg_21_0.stageInfoViewList[arg_21_0.selectDifficultType]:GetTragetItem(arg_21_1)

	if arg_21_0.selectStageItem == var_21_0 then
		return
	end

	if arg_21_0.selectStageItem then
		arg_21_0.selectStageItem:UpdateSelectState(false)
	end

	arg_21_0.selectStageItem = var_21_0

	arg_21_0.selectStageItem:UpdateSelectState(true)

	local var_21_1 = arg_21_0.selectStageItem:GetLevelCfg()

	arg_21_0:RefreshZumaChapterInfo(var_21_1)
	arg_21_0.stageInfoViewList[arg_21_0.selectDifficultType]:UpdateMoveView(arg_21_1)
end

function var_0_0.DefaultSelectChapter(arg_22_0)
	if arg_22_0:CheckIsEndless() then
		return
	end

	if arg_22_0.selectDifficultType ~= nil then
		return
	end

	local var_22_0 = ZumaData:GetZumaGameId()
	local var_22_1 = ActivityZumaLevelCfg[var_22_0] and ActivityZumaLevelCfg[var_22_0].difficult or ZumaConst.ZUMA_DIFFICULT.ESAY

	arg_22_0:OnClickStageDifficultChangeBtn(var_22_1)
	arg_22_0.stageInfoViewList[arg_22_0.selectDifficultType]:DefalutSelect(var_22_0)
	ZumaData:SetZumaGameId(0)
end

function var_0_0.UpdateStageList(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_1 then
		arg_23_0.stageInfoViewList[arg_23_1]:RefreshStageUI(arg_23_2)
	else
		for iter_23_0, iter_23_1 in pairs(arg_23_0.stageInfoViewList) do
			iter_23_1:RefreshStageUI()
		end
	end
end

function var_0_0.GetDiffcultBtnRedTrs(arg_24_0, arg_24_1)
	local var_24_0

	if arg_24_1 == ZumaConst.ZUMA_DIFFICULT.ESAY then
		var_24_0 = arg_24_0.easyBtn_.transform
	elseif arg_24_1 == ZumaConst.ZUMA_DIFFICULT.HARD then
		var_24_0 = arg_24_0.hardBtn_.transform
	elseif arg_24_1 == ZumaConst.ZUMA_DIFFICULT.NIGHT then
		var_24_0 = arg_24_0.nightmareBtn_.transform
	elseif arg_24_1 == ZumaConst.ZUMA_DIFFICULT.ENDLESS then
		var_24_0 = arg_24_0.endlessBtn_.transform
	end

	return var_24_0
end

function var_0_0.ShowDiffcultRed(arg_25_0, arg_25_1)
	for iter_25_0, iter_25_1 in pairs(arg_25_0.stageInfoViewList) do
		local var_25_0 = iter_25_1:GetDifficultCfgList()

		iter_25_1:SetRedState(arg_25_1)

		for iter_25_2, iter_25_3 in pairs(var_25_0 or {}) do
			local var_25_1 = iter_25_3.activity_id
			local var_25_2 = arg_25_0:GetDiffcultBtnRedTrs(iter_25_0)

			if arg_25_1 then
				manager.redPoint:bindUIandKey(var_25_2, string.format("%s_%s", RedPointConst.ZUMA_DIFFICULT, iter_25_0))
			else
				manager.redPoint:unbindUIandKey(var_25_2, string.format("%s_%s", RedPointConst.ZUMA_DIFFICULT, iter_25_0))
			end
		end
	end
end

function var_0_0.OnTop(arg_26_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if arg_26_0.chapterInfoView and arg_26_0.chapterInfoView.isShow then
			arg_26_0:RefreshZumaChapterInfo()
		else
			JumpTools.Back()
		end
	end)

	local var_26_0 = GameSetting.activity_zuma_describe and GameSetting.activity_zuma_describe.value or {}

	manager.windowBar:RegistInfoCallBack(function()
		if arg_26_0.chapterInfoView and arg_26_0.chapterInfoView.isShow then
			arg_26_0:RefreshZumaChapterInfo()
		else
			JumpTools.OpenPageByJump("gameHelpPro", {
				isPrefab = true,
				pages = var_26_0
			})
		end
	end)
end

function var_0_0.OnEnter(arg_29_0)
	arg_29_0:UpdateStageList()
	arg_29_0:DefaultSelectChapter()
	arg_29_0:ShowDiffcultRed(true)
	manager.redPoint:bindUIandKey(arg_29_0.taskBtn_.transform, RedPointConst.ZUMA_REWARD)
	manager.redPoint:bindUIandKey(arg_29_0.talentBtn_.transform, RedPointConst.ZUMA_TALENT)
	arg_29_0:RefreshTime()
	arg_29_0.chapterInfoView:OnEnter()

	if not getData("ZumaGame", "showHelp") then
		local var_29_0 = GameSetting.activity_zuma_describe and GameSetting.activity_zuma_describe.value or {}

		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = var_29_0
		})
		saveData("ZumaGame", "showHelp", 1)
	end
end

function var_0_0.RefreshTime(arg_30_0)
	arg_30_0.activityData_ = ActivityData:GetActivityData(ZumaData:GetZumaActivityID())
	arg_30_0.startTime_ = arg_30_0.activityData_.startTime
	arg_30_0.stopTime_ = arg_30_0.activityData_.stopTime
	arg_30_0.timeLable_.text = manager.time:GetLostTimeStrWith2Unit(arg_30_0.stopTime_, true)
	arg_30_0.timer_ = Timer.New(function()
		arg_30_0.timeLable_.text = manager.time:GetLostTimeStrWith2Unit(arg_30_0.stopTime_, true)
		arg_30_0.stopTime_ = arg_30_0.stopTime_ - 1
	end, 1, -1)

	arg_30_0.timer_:Start()
end

function var_0_0.StopTimer(arg_32_0)
	if arg_32_0.timer_ then
		arg_32_0.timer_:Stop()

		arg_32_0.timer_ = nil
	end
end

function var_0_0.OnExit(arg_33_0)
	arg_33_0:RefreshZumaChapterInfo()
	manager.windowBar:HideBar()
	arg_33_0:StopTimer()
	arg_33_0:ShowDiffcultRed(false)
	arg_33_0.chapterInfoView:OnExit()
	manager.redPoint:unbindUIandKey(arg_33_0.taskBtn_.transform, RedPointConst.ZUMA_REWARD)
	manager.redPoint:unbindUIandKey(arg_33_0.talentBtn_.transform, RedPointConst.ZUMA_TALENT)
end

function var_0_0.Dispose(arg_34_0)
	for iter_34_0, iter_34_1 in pairs(arg_34_0.stageInfoViewList) do
		iter_34_1:Dispose()
	end

	var_0_0.super.Dispose(arg_34_0)
	arg_34_0.chapterInfoView:Dispose()
end

return var_0_0
