class = var_0_10000

local var_0_0 = "IslandSeasonPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.IslandBasePage"))

var_0_1.CLOSE = "IslandSeasonPage:CLOSE"
var_0_1.UPDATE_REDDOT = "IslandSeasonPage:UPDATE_REDDOT"
var_0_1.PAGE_ACTIVITY = "activity"
var_0_1.PAGE_PT = "pt"
var_0_1.PAGE_TASK = "task"
var_0_1.PAGE_SHOP = "shop"
var_0_1.PAGE_RANK = "rank"
var_0_1.PAGE_REVIEW = "review"

function var_0_1.getUIName(arg_1_0)
	return "IslandSeasonUI"
end

function var_0_1.Preload(arg_2_0, arg_2_1)
	pg = var_1_10002

	local var_2_0 = var_1_10002.PoolMgr.GetInstance()

	var_2.PreloadUI(var_2_0, "IslandSeasonActivityPanel", arg_2_1)

	return
end

function var_0_1.OnLoaded(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.blurTF = var_1.Find(var_3_0, "blur")
	setText = var_1

	local var_3_1 = arg_3_0.blurTF
	local var_3_2 = var_2.Find(var_3_1, "top/title/Text")

	i18n = var_3_1

	var_1(var_3_2, var_3_1("island_season_title"))

	local var_3_3 = arg_3_0.blurTF

	arg_3_0.ptTitleTF = var_1.Find(var_3_3, "pt_title")

	local var_3_4 = arg_3_0.blurTF

	arg_3_0.otherTitleTF = var_1.Find(var_3_4, "other_title")

	local var_3_5 = arg_3_0.blurTF
	local var_3_6 = var_1.Find(var_3_5, "pages")
	local var_3_7 = {}
	local var_3_8 = var_0_1.PAGE_ACTIVITY

	IslandSeasonActivityPanel = var_4
	var_3_7[var_3_8] = var_4.New(var_3_6, arg_3_0.event, arg_3_0.contextData)

	local var_3_9 = var_0_1.PAGE_PT

	IslandSeasonPtPanel = var_4

	local var_3_10 = var_4.New
	local var_3_11 = var_3_6
	local var_3_12 = arg_3_0.event

	setmetatable = var_7
	var_3_7[var_3_9] = var_3_10(var_3_11, var_3_12, var_7({
		ShowMsgBox = function(arg_4_0, arg_4_1)
			local var_4_0 = arg_3_0

			var_2.ShowMsgBox(var_4_0, arg_4_1)

			return
		end
	}, {
		__index = arg_3_0.contextData
	}))

	local var_3_13 = var_0_1.PAGE_TASK

	IslandSeasonTaskPanel = var_4

	local var_3_14 = var_4.New
	local var_3_15 = var_3_6
	local var_3_16 = arg_3_0.event

	setmetatable = var_7
	var_3_7[var_3_13] = var_3_14(var_3_15, var_3_16, var_7({
		ShowMsgBox = function(arg_5_0, arg_5_1)
			local var_5_0 = arg_3_0

			var_2.ShowMsgBox(var_5_0, arg_5_1)

			return
		end
	}, {
		__index = arg_3_0.contextData
	}))

	local var_3_17 = var_0_1.PAGE_SHOP

	IslandSeasonShopPanel = var_4

	local var_3_18 = var_4.New
	local var_3_19 = var_3_6
	local var_3_20 = arg_3_0.event

	setmetatable = var_7
	var_3_7[var_3_17] = var_3_18(var_3_19, var_3_20, var_7({
		openBuyLayer = function(arg_6_0, arg_6_1)
			local var_6_0 = arg_3_0
			local var_6_1 = var_2.OpenPage

			IslandShopItemLayer = var_2_10004

			var_6_1(var_6_0, var_2_10004, arg_6_0, arg_6_1)

			return
		end
	}, {
		__index = arg_3_0.contextData
	}))

	local var_3_21 = var_0_1.PAGE_RANK

	IslandSeasonRankPanel = var_4

	local var_3_22 = var_4.New
	local var_3_23 = var_3_6
	local var_3_24 = arg_3_0.event

	setmetatable = var_7
	var_3_7[var_3_21] = var_3_22(var_3_23, var_3_24, var_7({
		ShowMsgBox = function(arg_7_0, arg_7_1)
			local var_7_0 = arg_3_0

			var_2.ShowMsgBox(var_7_0, arg_7_1)

			return
		end
	}, {
		__index = arg_3_0.contextData
	}))
	arg_3_0.pages = var_3_7
	pairs = var_3_7

	for iter_3_0, iter_3_1 in var_3_7(arg_3_0.pages) do
		iter_3_1:RegisterView(arg_3_0.viewComponent)
	end

	IslandSeasonAgency = var_2

	if not (var_2.GetCurrentSeason() == 1) then
		local var_3_25 = arg_3_0.pages
		local var_3_26 = var_0_1.PAGE_REVIEW

		IslandSeasonReviewPanel = iter_3_0
		var_3_25[var_3_26] = iter_3_0.New(var_3_6, arg_3_0.event, arg_3_0.contextData)
	end

	local var_3_27 = arg_3_0.blurTF

	arg_3_0.togglesTF = var_3.Find(var_3_27, "toggles/content")
	setActive = var_3

	local var_3_28 = arg_3_0.togglesTF

	var_3(var_4.Find(var_3_28, var_0_1.PAGE_REVIEW), not var_2)

	local function var_3_29(arg_8_0, arg_8_1)
		setText = var_2_10002

		var_2_10002(arg_8_0:Find("sel/Text"), arg_8_1)

		setText = var_2_10002

		var_2_10002(arg_8_0:Find("sel/Text/shandw"), arg_8_1)

		setText = var_2_10002

		var_2_10002(arg_8_0:Find("unsel/Text"), arg_8_1)

		setText = var_2_10002

		var_2_10002(arg_8_0:Find("unsel/Text/shandw"), arg_8_1)

		return
	end

	local var_3_30 = arg_3_0.togglesTF
	local var_3_31 = var_5.Find(var_3_30, "activity")

	i18n = var_3_30

	var_3_29(var_3_31, var_3_30("island_season_activity"))

	local var_3_32 = var_3
	local var_3_33 = arg_3_0.togglesTF
	local var_3_34 = var_5.Find(var_3_33, "pt")

	i18n = var_3_33

	var_3_32(var_3_34, var_3_33("island_season_pt"))

	local var_3_35 = var_3
	local var_3_36 = arg_3_0.togglesTF
	local var_3_37 = var_5.Find(var_3_36, "task")

	i18n = var_3_36

	var_3_35(var_3_37, var_3_36("island_season_task"))

	local var_3_38 = var_3
	local var_3_39 = arg_3_0.togglesTF
	local var_3_40 = var_5.Find(var_3_39, "shop")

	i18n = var_3_39

	var_3_38(var_3_40, var_3_39("island_season_shop"))

	local var_3_41 = var_3
	local var_3_42 = arg_3_0.togglesTF
	local var_3_43 = var_5.Find(var_3_42, "rank")

	i18n = var_3_42

	var_3_41(var_3_43, var_3_42("island_season_charts"))

	local var_3_44 = var_3
	local var_3_45 = arg_3_0.togglesTF
	local var_3_46 = var_5.Find(var_3_45, "review")

	i18n = var_3_45

	var_3_44(var_3_46, var_3_45("island_season_review"))

	PlayRoomPop = var_3_44

	local var_3_47 = var_3_44.New
	local var_3_48 = arg_3_0.blurTF

	arg_3_0.playRoomPop = var_3_47(var_5.Find(var_3_48, "playRoomPop"), arg_3_0)

	local var_3_49 = arg_3_0.playRoomPop

	var_4.didEnter(var_3_49)

	return
end

function var_0_1.Close(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.emit

	IslandMediator = var_1_10004

	var_9_1(var_9_0, var_1_10004.PLAY_ROOM_MATCH_STOP)
	arg_9_0:Hide(arg_9_1)

	return
end

function var_0_1.OnInit(arg_10_0)
	local var_10_0 = arg_10_0.blurTF
	local var_10_1 = var_1.Find(var_10_0, "top/back")

	onButton = var_10_0

	local var_10_2 = arg_10_0
	local var_10_3 = var_10_1

	local function var_10_4()
		local var_11_0 = arg_10_0

		var_0.Close(var_11_0, true)

		return
	end

	SFX_PANEL = var_1_10006

	var_10_0(var_10_2, var_10_3, var_10_4, var_1_10006)

	onButton = var_10_0

	local var_10_5 = arg_10_0
	local var_10_6 = arg_10_0.blurTF
	local var_10_7 = var_4.Find(var_10_6, "top/help")

	local function var_10_8()
		local var_12_0 = arg_10_0
		local var_12_1 = var_0.ShowMsgBox
		local var_12_2 = {}

		IslandMsgBox = var_2_10003
		var_12_2.type = var_2_10003.TYPE_WHITOUT_BTN
		i18n = var_3
		var_12_2.content = var_3("island_season_help")

		var_12_1(var_12_0, var_12_2)

		return
	end

	SFX_PANEL = var_6

	var_10_0(var_10_5, var_10_7, var_10_8, var_6)

	eachChild = var_10_0

	var_10_0(arg_10_0.togglesTF, function(arg_13_0)
		onToggle = var_2_10001

		local var_13_0 = arg_10_0
		local var_13_1 = arg_13_0

		local function var_13_2(arg_14_0)
			if arg_14_0 then
				arg_10_0.curPage = arg_13_0.name

				local var_14_0 = arg_10_0

				var_1.SwitchPage(var_14_0)
			end

			return
		end

		SFX_PANEL = var_2_10005

		var_2_10001(var_13_0, var_13_1, var_13_2, var_2_10005)

		return
	end)
	arg_10_0:bind(var_0_1.CLOSE, function()
		local var_15_0 = arg_10_0

		var_0.Close(var_15_0, false)

		return
	end)
	arg_10_0:bind(var_0_1.UPDATE_REDDOT, function(arg_16_0, arg_16_1)
		local var_16_0 = arg_10_0

		var_2.UpdateRedDot(var_16_0, arg_16_1)

		return
	end)
	arg_10_0:UpdateRedDot()

	return
end

function var_0_1.UpdateRedDot(arg_17_0, arg_17_1)
	eachChild = var_1_10002

	var_1_10002(arg_17_0.togglesTF, function(arg_18_0)
		if not arg_17_1 or arg_18_0.name == arg_17_1 then
			setActive = var_1

			local var_18_0 = arg_18_0
			local var_18_1 = arg_18_0.Find(var_18_0, "red")

			IslandSeasonRedDotHelper = var_18_0

			var_1(var_18_1, var_18_0.TipTag(arg_18_0.name))
		end

		return
	end)

	return
end

function var_0_1.AddListeners(arg_19_0)
	local var_19_0 = arg_19_0
	local var_19_1 = arg_19_0.AddListener

	ActivityProxy = var_1_10003

	var_19_1(var_19_0, var_1_10003.ACTIVITY_UPDATED, arg_19_0.FlushActivityPage)

	local var_19_2 = arg_19_0
	local var_19_3 = arg_19_0.AddListener

	IslandSeasonAgency = var_3

	var_19_3(var_19_2, var_3.ADD_PT, arg_19_0.FlushPtPage)

	local var_19_4 = arg_19_0
	local var_19_5 = arg_19_0.AddListener

	GAME = var_3

	var_19_5(var_19_4, var_3.ISLAND_GET_SEASON_PT_AWARD_DONE, arg_19_0.FlushPtPage)

	local var_19_6 = arg_19_0
	local var_19_7 = arg_19_0.AddListener

	GAME = var_3

	var_19_7(var_19_6, var_3.ISLAND_SUBMIT_TASK_DONE, arg_19_0.OnSubmitTaskDone)

	local var_19_8 = arg_19_0
	local var_19_9 = arg_19_0.AddListener

	GAME = var_3

	var_19_9(var_19_8, var_3.ISLAND_SUBMIT_TASK_ONE_STEP_DONE, arg_19_0.OnSubmitTaskDone)

	local var_19_10 = arg_19_0
	local var_19_11 = arg_19_0.AddListener

	GAME = var_3

	var_19_11(var_19_10, var_3.ISLAND_SHOP_OP_DONE, arg_19_0.FlushShopPage)

	local var_19_12 = arg_19_0
	local var_19_13 = arg_19_0.AddListener

	GAME = var_3

	var_19_13(var_19_12, var_3.ISLAND_GET_SEASON_RANK_DONE, arg_19_0.OnGetRankData)

	local var_19_14 = arg_19_0
	local var_19_15 = arg_19_0.AddListener

	IslandTaskAgency = var_3

	var_19_15(var_19_14, var_3.TASK_ADDED, arg_19_0.OnTaskAdded)

	local var_19_16 = arg_19_0
	local var_19_17 = arg_19_0.AddListener

	IslandTaskAgency = var_3

	var_19_17(var_19_16, var_3.TASK_UPDATED, arg_19_0.OnTaskUpdate)

	local var_19_18 = arg_19_0
	local var_19_19 = arg_19_0.AddListener

	IslandTaskAgency = var_3

	var_19_19(var_19_18, var_3.TASK_REMOVED, arg_19_0.OnTaskRemove)

	local var_19_20 = arg_19_0
	local var_19_21 = arg_19_0.AddListener

	IslandTaskAgency = var_3

	var_19_21(var_19_20, var_3.TASK_FINISH, arg_19_0.OnTaskFinish)

	return
end

function var_0_1.RemoveListeners(arg_20_0)
	local var_20_0 = arg_20_0
	local var_20_1 = arg_20_0.RemoveListener

	ActivityProxy = var_1_10003

	var_20_1(var_20_0, var_1_10003.ACTIVITY_UPDATED, arg_20_0.FlushActivityPage)

	local var_20_2 = arg_20_0
	local var_20_3 = arg_20_0.RemoveListener

	IslandSeasonAgency = var_3

	var_20_3(var_20_2, var_3.ADD_PT, arg_20_0.FlushPtPage)

	local var_20_4 = arg_20_0
	local var_20_5 = arg_20_0.RemoveListener

	GAME = var_3

	var_20_5(var_20_4, var_3.ISLAND_GET_SEASON_PT_AWARD_DONE, arg_20_0.FlushPtPage)

	local var_20_6 = arg_20_0
	local var_20_7 = arg_20_0.RemoveListener

	GAME = var_3

	var_20_7(var_20_6, var_3.ISLAND_SUBMIT_TASK_DONE, arg_20_0.OnSubmitTaskDone)

	local var_20_8 = arg_20_0
	local var_20_9 = arg_20_0.RemoveListener

	GAME = var_3

	var_20_9(var_20_8, var_3.ISLAND_SUBMIT_TASK_ONE_STEP_DONE, arg_20_0.OnSubmitTaskDone)

	local var_20_10 = arg_20_0
	local var_20_11 = arg_20_0.RemoveListener

	GAME = var_3

	var_20_11(var_20_10, var_3.ISLAND_SHOP_OP_DONE, arg_20_0.FlushShopPage)

	local var_20_12 = arg_20_0
	local var_20_13 = arg_20_0.RemoveListener

	GAME = var_3

	var_20_13(var_20_12, var_3.ISLAND_GET_SEASON_RANK_DONE, arg_20_0.OnGetRankData)

	local var_20_14 = arg_20_0
	local var_20_15 = arg_20_0.RemoveListener

	IslandTaskAgency = var_3

	var_20_15(var_20_14, var_3.TASK_ADDED, arg_20_0.OnTaskAdded)

	local var_20_16 = arg_20_0
	local var_20_17 = arg_20_0.RemoveListener

	IslandTaskAgency = var_3

	var_20_17(var_20_16, var_3.TASK_UPDATED, arg_20_0.OnTaskUpdate)

	local var_20_18 = arg_20_0
	local var_20_19 = arg_20_0.RemoveListener

	IslandTaskAgency = var_3

	var_20_19(var_20_18, var_3.TASK_REMOVED, arg_20_0.OnTaskRemove)

	local var_20_20 = arg_20_0
	local var_20_21 = arg_20_0.RemoveListener

	IslandTaskAgency = var_3

	var_20_21(var_20_20, var_3.TASK_FINISH, arg_20_0.OnTaskFinish)

	return
end

function var_0_1.OnShow(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.contextData

	getProxy = var_1_10003
	IslandProxy = var_1_10004

	local var_21_1 = var_1_10003(var_1_10004)
	local var_21_2 = var_3.GetIsland(var_21_1)
	local var_21_3 = var_3.GetSeasonAgency(var_21_2)

	var_21_0.season = var_3.GetSeason(var_21_3)

	local var_21_4 = arg_21_0.contextData

	if arg_21_1 and arg_21_1.target_act_id then
		triggerToggle = var_3

		local var_21_5 = arg_21_0.togglesTF

		var_3(var_4.Find(var_21_5, var_0_1.PAGE_ACTIVITY), true)

		local var_21_6 = arg_21_0.pages[var_0_1.PAGE_ACTIVITY]

		var_3.ExecuteAction(var_21_6, "verifyTabs", arg_21_1.target_act_id)
	else
		triggerToggle = var_3

		local var_21_7 = arg_21_0.togglesTF

		var_3(var_4.Find(var_21_7, var_0_1.PAGE_ACTIVITY), true)
	end

	local var_21_8 = arg_21_0.playRoomPop

	var_3.Show(var_21_8, true)

	return
end

local var_0_2 = {
	[var_0_1.PAGE_ACTIVITY] = 1,
	[var_0_1.PAGE_PT] = 2,
	[var_0_1.PAGE_TASK] = 3,
	[var_0_1.PAGE_SHOP] = 3,
	[var_0_1.PAGE_RANK] = 3,
	[var_0_1.PAGE_REVIEW] = 4
}

function var_0_1.SwitchPage(arg_22_0)
	pairs = var_1_10001

	for iter_22_0, iter_22_1 in var_1_10001(arg_22_0.pages) do
		if iter_22_0 == arg_22_0.curPage then
			iter_22_1:ExecuteAction("Show")
		else
			iter_22_1:ExecuteAction("Hide")
		end

		local var_22_0 = var_0_2[arg_22_0.curPage]

		SetCompomentEnabled = var_7

		var_7(arg_22_0.blurTF, "Image", var_22_0 == 1 or var_22_0 == 3 or var_22_0 == 4)

		setActive = var_7

		var_7(arg_22_0.ptTitleTF, var_22_0 == 2)

		setActive = var_7

		var_7(arg_22_0.otherTitleTF, var_22_0 == 3)

		if var_22_0 == 1 or var_22_0 == 3 or var_22_0 == 4 then
			arg_22_0:OverlayPanel(arg_22_0.blurTF, {
				pbList = {
					arg_22_0.blurTF
				}
			})
		else
			arg_22_0:UnOverlayPanel(arg_22_0.blurTF, arg_22_0._tf)
		end
	end

	return
end

function var_0_1.UpdateTaskAct(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0.pages[var_0_1.PAGE_ACTIVITY]

	var_2.ExecuteAction(var_23_0, "OnTaskUpdate", arg_23_1)

	return
end

function var_0_1.OnTaskAdded(arg_24_0, arg_24_1)
	if not arg_24_1 then
		return
	end

	arg_24_0:UpdateTaskAct(arg_24_1.id)

	return
end

function var_0_1.OnTaskUpdate(arg_25_0, arg_25_1)
	if not arg_25_1 then
		return
	end

	arg_25_0:UpdateTaskAct(arg_25_1.id)

	return
end

function var_0_1.OnTaskRemove(arg_26_0, arg_26_1)
	if not arg_26_1 then
		return
	end

	arg_26_0:UpdateTaskAct(arg_26_1.id)

	return
end

function var_0_1.OnTaskFinish(arg_27_0, arg_27_1)
	if not arg_27_1 then
		return
	end

	arg_27_0:UpdateTaskAct(arg_27_1)

	return
end

function var_0_1.FlushActivityPage(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0.pages[var_0_1.PAGE_ACTIVITY]

	var_2.ExecuteAction(var_28_0, "updateActivity", arg_28_1)

	return
end

function var_0_1.FlushPtPage(arg_29_0)
	local var_29_0 = arg_29_0.contextData

	getProxy = var_1_10002
	IslandProxy = var_1_10003

	local var_29_1 = var_1_10002(var_1_10003)
	local var_29_2 = var_2.GetIsland(var_29_1)
	local var_29_3 = var_2.GetSeasonAgency(var_29_2)

	var_29_0.season = var_2.GetSeason(var_29_3)

	local var_29_4 = arg_29_0.pages[var_0_1.PAGE_PT]

	var_1.ExecuteAction(var_29_4, "Flush")
	arg_29_0:UpdateRedDot(var_0_1.PAGE_PT)

	return
end

function var_0_1.OnSubmitTaskDone(arg_30_0)
	arg_30_0:FlushTaskPage()

	local var_30_0 = arg_30_0.pages[var_0_1.PAGE_ACTIVITY]

	var_1.ExecuteAction(var_30_0, "flushTabs")
	arg_30_0:UpdateRedDot(var_0_1.PAGE_TASK)

	return
end

function var_0_1.FlushTaskPage(arg_31_0)
	local var_31_0 = arg_31_0.pages[var_0_1.PAGE_TASK]

	var_1.ExecuteAction(var_31_0, "Flush")

	return
end

function var_0_1.FlushShopPage(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0.pages[var_0_1.PAGE_SHOP]

	var_2.ExecuteAction(var_32_0, "Flush")

	local var_32_1 = arg_32_1.operation

	IslandConst = var_32_0

	if var_32_1 == var_32_0.SHOP_BUY_COMMODITY then
		local var_32_2 = arg_32_0
		local var_32_3 = arg_32_0.OpenPage

		IslandShopBuySuccessLayer = var_4

		var_32_3(var_32_2, var_4, arg_32_1.awards)
	end

	return
end

function var_0_1.OnGetRankData(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0.pages[var_0_1.PAGE_RANK]

	var_2.ExecuteAction(var_33_0, "UpdateRankVOs", arg_33_1.seasonId, arg_33_1.list, arg_33_1.playerInfo)

	local var_33_1 = arg_33_0.pages[var_0_1.PAGE_RANK]

	var_2.ExecuteAction(var_33_1, "UpdataRankView")

	if arg_33_0.pages[var_0_1.PAGE_REVIEW] then
		local var_33_2 = arg_33_0.pages[var_0_1.PAGE_REVIEW]

		var_2.ExecuteAction(var_33_2, "UpdateRankVOs", arg_33_1.seasonId, arg_33_1.list, arg_33_1.playerInfo)

		local var_33_3 = arg_33_0.pages[var_0_1.PAGE_REVIEW]

		var_2.ExecuteAction(var_33_3, "UpdataIcon")
	end

	return
end

function var_0_1.OnHide(arg_34_0)
	local var_34_0 = arg_34_0.playRoomPop

	var_1.Show(var_34_0, false)
	arg_34_0:UnOverlayPanel(arg_34_0.blurTF, arg_34_0._tf)

	local var_34_1 = arg_34_0.pages[var_0_1.PAGE_PT]

	var_1.OnHide(var_34_1)

	local var_34_2 = arg_34_0.pages[var_0_1.PAGE_ACTIVITY]

	var_1.OnHide(var_34_2)

	if arg_34_0.pages[var_0_1.PAGE_REVIEW] then
		local var_34_3 = arg_34_0.pages[var_0_1.PAGE_REVIEW]

		var_1.Hide(var_34_3)
	end

	return
end

function var_0_1.OnDisable(arg_35_0)
	arg_35_0:OnHide()

	return
end

function var_0_1.OnDestroy(arg_36_0)
	arg_36_0:OnHide()

	local var_36_0 = arg_36_0.playRoomPop

	var_1.willExit(var_36_0)

	arg_36_0.playRoomPop = nil
	pairs = var_1

	for iter_36_0, iter_36_1 in var_1(arg_36_0.pages) do
		if iter_36_1 then
			iter_36_1:Destroy()

			iter_36_1 = nil
		end
	end

	return
end

function var_0_1.OnEnable(arg_37_0)
	arg_37_0:OnShow()

	return
end

return var_0_1
