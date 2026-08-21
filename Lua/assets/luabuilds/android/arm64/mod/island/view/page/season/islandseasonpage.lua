local var_0_0 = class("IslandSeasonPage", import("...base.IslandBasePage"))

var_0_0.CLOSE = "IslandSeasonPage:CLOSE"
var_0_0.UPDATE_REDDOT = "IslandSeasonPage:UPDATE_REDDOT"
var_0_0.PAGE_ACTIVITY = "activity"
var_0_0.PAGE_PT = "pt"
var_0_0.PAGE_TASK = "task"
var_0_0.PAGE_SHOP = "shop"
var_0_0.PAGE_RANK = "rank"
var_0_0.PAGE_REVIEW = "review"

function var_0_0.getUIName(arg_1_0)
	return "IslandSeasonUI"
end

function var_0_0.Preload(arg_2_0, arg_2_1)
	pg.PoolMgr.GetInstance():PreloadUI("IslandSeasonActivityPanel", arg_2_1)

	return
end

function var_0_0.OnLoaded(arg_3_0)
	arg_3_0.blurTF = arg_3_0._tf:Find("blur")

	setText(arg_3_0.blurTF:Find("top/title/Text"), i18n("island_season_title"))

	arg_3_0.ptTitleTF = arg_3_0.blurTF:Find("pt_title")
	arg_3_0.otherTitleTF = arg_3_0.blurTF:Find("other_title")

	local var_3_0 = arg_3_0.blurTF:Find("pages")

	arg_3_0.pages = {
		[var_0_0.PAGE_ACTIVITY] = IslandSeasonActivityPanel.New(var_3_0, arg_3_0.event, arg_3_0.contextData),
		[var_0_0.PAGE_PT] = IslandSeasonPtPanel.New(var_3_0, arg_3_0.event, setmetatable({
			ShowMsgBox = function(arg_4_0, arg_4_1)
				arg_3_0:ShowMsgBox(arg_4_1)

				return
			end
		}, {
			__index = arg_3_0.contextData
		})),
		[var_0_0.PAGE_TASK] = IslandSeasonTaskPanel.New(var_3_0, arg_3_0.event, setmetatable({
			ShowMsgBox = function(arg_5_0, arg_5_1)
				arg_3_0:ShowMsgBox(arg_5_1)

				return
			end
		}, {
			__index = arg_3_0.contextData
		})),
		[var_0_0.PAGE_SHOP] = IslandSeasonShopPanel.New(var_3_0, arg_3_0.event, setmetatable({
			openBuyLayer = function(arg_6_0, arg_6_1)
				arg_3_0:OpenPage(IslandShopItemLayer, arg_6_0, arg_6_1)

				return
			end
		}, {
			__index = arg_3_0.contextData
		})),
		[var_0_0.PAGE_RANK] = IslandSeasonRankPanel.New(var_3_0, arg_3_0.event, setmetatable({
			ShowMsgBox = function(arg_7_0, arg_7_1)
				arg_3_0:ShowMsgBox(arg_7_1)

				return
			end
		}, {
			__index = arg_3_0.contextData
		}))
	}

	for iter_3_0, iter_3_1 in pairs(arg_3_0.pages) do
		iter_3_1:RegisterView(arg_3_0.viewComponent)
	end

	local var_3_1 = IslandSeasonAgency.GetCurrentSeason() == 1

	if not var_3_1 then
		arg_3_0.pages[var_0_0.PAGE_REVIEW] = IslandSeasonReviewPanel.New(var_3_0, arg_3_0.event, arg_3_0.contextData)
	end

	arg_3_0.togglesTF = arg_3_0.blurTF:Find("toggles/content")

	setActive(arg_3_0.togglesTF:Find(var_0_0.PAGE_REVIEW), not var_3_1)
	;(function(arg_8_0, arg_8_1)
		setText(arg_8_0:Find("sel/Text"), arg_8_1)
		setText(arg_8_0:Find("sel/Text/shandw"), arg_8_1)
		setText(arg_8_0:Find("unsel/Text"), arg_8_1)
		setText(arg_8_0:Find("unsel/Text/shandw"), arg_8_1)

		return
	end)(arg_3_0.togglesTF:Find("activity"), i18n("island_season_activity"))
	;(function(arg_8_0, arg_8_1)
		setText(arg_8_0:Find("sel/Text"), arg_8_1)
		setText(arg_8_0:Find("sel/Text/shandw"), arg_8_1)
		setText(arg_8_0:Find("unsel/Text"), arg_8_1)
		setText(arg_8_0:Find("unsel/Text/shandw"), arg_8_1)

		return
	end)(arg_3_0.togglesTF:Find("pt"), i18n("island_season_pt"))
	;(function(arg_8_0, arg_8_1)
		setText(arg_8_0:Find("sel/Text"), arg_8_1)
		setText(arg_8_0:Find("sel/Text/shandw"), arg_8_1)
		setText(arg_8_0:Find("unsel/Text"), arg_8_1)
		setText(arg_8_0:Find("unsel/Text/shandw"), arg_8_1)

		return
	end)(arg_3_0.togglesTF:Find("task"), i18n("island_season_task"))
	;(function(arg_8_0, arg_8_1)
		setText(arg_8_0:Find("sel/Text"), arg_8_1)
		setText(arg_8_0:Find("sel/Text/shandw"), arg_8_1)
		setText(arg_8_0:Find("unsel/Text"), arg_8_1)
		setText(arg_8_0:Find("unsel/Text/shandw"), arg_8_1)

		return
	end)(arg_3_0.togglesTF:Find("shop"), i18n("island_season_shop"))
	;(function(arg_8_0, arg_8_1)
		setText(arg_8_0:Find("sel/Text"), arg_8_1)
		setText(arg_8_0:Find("sel/Text/shandw"), arg_8_1)
		setText(arg_8_0:Find("unsel/Text"), arg_8_1)
		setText(arg_8_0:Find("unsel/Text/shandw"), arg_8_1)

		return
	end)(arg_3_0.togglesTF:Find("rank"), i18n("island_season_charts"))
	;(function(arg_8_0, arg_8_1)
		setText(arg_8_0:Find("sel/Text"), arg_8_1)
		setText(arg_8_0:Find("sel/Text/shandw"), arg_8_1)
		setText(arg_8_0:Find("unsel/Text"), arg_8_1)
		setText(arg_8_0:Find("unsel/Text/shandw"), arg_8_1)

		return
	end)(arg_3_0.togglesTF:Find("review"), i18n("island_season_review"))

	arg_3_0.playRoomPop = PlayRoomPop.New(arg_3_0.blurTF:Find("playRoomPop"), arg_3_0)

	arg_3_0.playRoomPop:didEnter()

	return
end

function var_0_0.Close(arg_9_0, arg_9_1)
	arg_9_0:emit(IslandMediator.PLAY_ROOM_MATCH_STOP)
	arg_9_0:Hide(arg_9_1)

	return
end

function var_0_0.OnInit(arg_10_0)
	onButton(arg_10_0, arg_10_0.blurTF:Find("top/back"), function()
		arg_10_0:Close(true)

		return
	end, SFX_PANEL)
	onButton(arg_10_0, arg_10_0.blurTF:Find("top/help"), function()
		arg_10_0:ShowMsgBox({
			type = IslandMsgBox.TYPE_WHITOUT_BTN,
			content = i18n("island_season_help")
		})

		return
	end, SFX_PANEL)
	eachChild(arg_10_0.togglesTF, function(arg_13_0)
		onToggle(arg_10_0, arg_13_0, function(arg_14_0)
			if arg_14_0 then
				arg_10_0.curPage = arg_13_0.name

				arg_10_0:SwitchPage()
			end

			return
		end, SFX_PANEL)

		return
	end)
	arg_10_0:bind(var_0_0.CLOSE, function()
		arg_10_0:Close(false)

		return
	end)
	arg_10_0:bind(var_0_0.UPDATE_REDDOT, function(arg_16_0, arg_16_1)
		arg_10_0:UpdateRedDot(arg_16_1)

		return
	end)
	arg_10_0:UpdateRedDot()

	return
end

function var_0_0.UpdateRedDot(arg_17_0, arg_17_1)
	eachChild(arg_17_0.togglesTF, function(arg_18_0)
		if not arg_17_1 or arg_18_0.name == arg_17_1 then
			setActive(arg_18_0:Find("red"), IslandSeasonRedDotHelper.TipTag(arg_18_0.name))
		end

		return
	end)

	return
end

function var_0_0.AddListeners(arg_19_0)
	arg_19_0:AddListener(ActivityProxy.ACTIVITY_UPDATED, arg_19_0.FlushActivityPage)
	arg_19_0:AddListener(IslandSeasonAgency.ADD_PT, arg_19_0.FlushPtPage)
	arg_19_0:AddListener(GAME.ISLAND_GET_SEASON_PT_AWARD_DONE, arg_19_0.FlushPtPage)
	arg_19_0:AddListener(GAME.ISLAND_SUBMIT_TASK_DONE, arg_19_0.OnSubmitTaskDone)
	arg_19_0:AddListener(GAME.ISLAND_SUBMIT_TASK_ONE_STEP_DONE, arg_19_0.OnSubmitTaskDone)
	arg_19_0:AddListener(GAME.ISLAND_SHOP_OP_DONE, arg_19_0.FlushShopPage)
	arg_19_0:AddListener(GAME.ISLAND_GET_SEASON_RANK_DONE, arg_19_0.OnGetRankData)
	arg_19_0:AddListener(IslandTaskAgency.TASK_ADDED, arg_19_0.OnTaskAdded)
	arg_19_0:AddListener(IslandTaskAgency.TASK_UPDATED, arg_19_0.OnTaskUpdate)
	arg_19_0:AddListener(IslandTaskAgency.TASK_REMOVED, arg_19_0.OnTaskRemove)
	arg_19_0:AddListener(IslandTaskAgency.TASK_FINISH, arg_19_0.OnTaskFinish)

	return
end

function var_0_0.RemoveListeners(arg_20_0)
	arg_20_0:RemoveListener(ActivityProxy.ACTIVITY_UPDATED, arg_20_0.FlushActivityPage)
	arg_20_0:RemoveListener(IslandSeasonAgency.ADD_PT, arg_20_0.FlushPtPage)
	arg_20_0:RemoveListener(GAME.ISLAND_GET_SEASON_PT_AWARD_DONE, arg_20_0.FlushPtPage)
	arg_20_0:RemoveListener(GAME.ISLAND_SUBMIT_TASK_DONE, arg_20_0.OnSubmitTaskDone)
	arg_20_0:RemoveListener(GAME.ISLAND_SUBMIT_TASK_ONE_STEP_DONE, arg_20_0.OnSubmitTaskDone)
	arg_20_0:RemoveListener(GAME.ISLAND_SHOP_OP_DONE, arg_20_0.FlushShopPage)
	arg_20_0:RemoveListener(GAME.ISLAND_GET_SEASON_RANK_DONE, arg_20_0.OnGetRankData)
	arg_20_0:RemoveListener(IslandTaskAgency.TASK_ADDED, arg_20_0.OnTaskAdded)
	arg_20_0:RemoveListener(IslandTaskAgency.TASK_UPDATED, arg_20_0.OnTaskUpdate)
	arg_20_0:RemoveListener(IslandTaskAgency.TASK_REMOVED, arg_20_0.OnTaskRemove)
	arg_20_0:RemoveListener(IslandTaskAgency.TASK_FINISH, arg_20_0.OnTaskFinish)

	return
end

function var_0_0.OnShow(arg_21_0, arg_21_1)
	arg_21_0.contextData.season = getProxy(IslandProxy):GetIsland():GetSeasonAgency():GetSeason()

	if arg_21_1 and arg_21_1.target_act_id then
		triggerToggle(arg_21_0.togglesTF:Find(var_0_0.PAGE_ACTIVITY), true)
		arg_21_0.pages[var_0_0.PAGE_ACTIVITY]:ExecuteAction("verifyTabs", arg_21_1.target_act_id)
	else
		triggerToggle(arg_21_0.togglesTF:Find(var_0_0.PAGE_ACTIVITY), true)
	end

	arg_21_0.playRoomPop:Show(true)

	return
end

local var_0_1 = {
	[var_0_0.PAGE_ACTIVITY] = 1,
	[var_0_0.PAGE_PT] = 2,
	[var_0_0.PAGE_TASK] = 3,
	[var_0_0.PAGE_SHOP] = 3,
	[var_0_0.PAGE_RANK] = 3,
	[var_0_0.PAGE_REVIEW] = 4
}

function var_0_0.SwitchPage(arg_22_0)
	for iter_22_0, iter_22_1 in pairs(arg_22_0.pages) do
		if iter_22_0 == arg_22_0.curPage then
			iter_22_1:ExecuteAction("Show")
		else
			iter_22_1:ExecuteAction("Hide")
		end

		local var_22_0 = var_0_1[arg_22_0.curPage]

		SetCompomentEnabled(arg_22_0.blurTF, "Image", var_0_1[arg_22_0.curPage] == 1 or var_22_0 == 3 or var_22_0 == 4)
		setActive(arg_22_0.ptTitleTF, var_22_0 == 2)
		setActive(arg_22_0.otherTitleTF, var_22_0 == 3)

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

function var_0_0.UpdateTaskAct(arg_23_0, arg_23_1)
	arg_23_0.pages[var_0_0.PAGE_ACTIVITY]:ExecuteAction("OnTaskUpdate", arg_23_1)

	return
end

function var_0_0.OnTaskAdded(arg_24_0, arg_24_1)
	if not arg_24_1 then
		return
	end

	arg_24_0:UpdateTaskAct(arg_24_1.id)

	return
end

function var_0_0.OnTaskUpdate(arg_25_0, arg_25_1)
	if not arg_25_1 then
		return
	end

	arg_25_0:UpdateTaskAct(arg_25_1.id)

	return
end

function var_0_0.OnTaskRemove(arg_26_0, arg_26_1)
	if not arg_26_1 then
		return
	end

	arg_26_0:UpdateTaskAct(arg_26_1.id)

	return
end

function var_0_0.OnTaskFinish(arg_27_0, arg_27_1)
	if not arg_27_1 then
		return
	end

	arg_27_0:UpdateTaskAct(arg_27_1)

	return
end

function var_0_0.FlushActivityPage(arg_28_0, arg_28_1)
	arg_28_0.pages[var_0_0.PAGE_ACTIVITY]:ExecuteAction("updateActivity", arg_28_1)

	return
end

function var_0_0.FlushPtPage(arg_29_0)
	arg_29_0.contextData.season = getProxy(IslandProxy):GetIsland():GetSeasonAgency():GetSeason()

	arg_29_0.pages[var_0_0.PAGE_PT]:ExecuteAction("Flush")
	arg_29_0:UpdateRedDot(var_0_0.PAGE_PT)

	return
end

function var_0_0.OnSubmitTaskDone(arg_30_0)
	arg_30_0:FlushTaskPage()
	arg_30_0.pages[var_0_0.PAGE_ACTIVITY]:ExecuteAction("flushTabs")
	arg_30_0:UpdateRedDot(var_0_0.PAGE_TASK)

	return
end

function var_0_0.FlushTaskPage(arg_31_0)
	arg_31_0.pages[var_0_0.PAGE_TASK]:ExecuteAction("Flush")

	return
end

function var_0_0.FlushShopPage(arg_32_0, arg_32_1)
	arg_32_0.pages[var_0_0.PAGE_SHOP]:ExecuteAction("Flush")

	if arg_32_1.operation == IslandConst.SHOP_BUY_COMMODITY then
		arg_32_0:OpenPage(IslandShopBuySuccessLayer, arg_32_1.awards)
	end

	return
end

function var_0_0.OnGetRankData(arg_33_0, arg_33_1)
	arg_33_0.pages[var_0_0.PAGE_RANK]:ExecuteAction("UpdateRankVOs", arg_33_1.seasonId, arg_33_1.list, arg_33_1.playerInfo)
	arg_33_0.pages[var_0_0.PAGE_RANK]:ExecuteAction("UpdataRankView")

	if arg_33_0.pages[var_0_0.PAGE_REVIEW] then
		arg_33_0.pages[var_0_0.PAGE_REVIEW]:ExecuteAction("UpdateRankVOs", arg_33_1.seasonId, arg_33_1.list, arg_33_1.playerInfo)
		arg_33_0.pages[var_0_0.PAGE_REVIEW]:ExecuteAction("UpdataIcon")
	end

	return
end

function var_0_0.OnHide(arg_34_0)
	arg_34_0.playRoomPop:Show(false)
	arg_34_0:UnOverlayPanel(arg_34_0.blurTF, arg_34_0._tf)
	arg_34_0.pages[var_0_0.PAGE_PT]:OnHide()
	arg_34_0.pages[var_0_0.PAGE_ACTIVITY]:OnHide()

	if arg_34_0.pages[var_0_0.PAGE_REVIEW] then
		arg_34_0.pages[var_0_0.PAGE_REVIEW]:Hide()
	end

	return
end

function var_0_0.OnDisable(arg_35_0)
	arg_35_0:OnHide()

	return
end

function var_0_0.OnDestroy(arg_36_0)
	arg_36_0:OnHide()
	arg_36_0.playRoomPop:willExit()

	arg_36_0.playRoomPop = nil

	for iter_36_0, iter_36_1 in pairs(arg_36_0.pages) do
		if iter_36_1 then
			iter_36_1:Destroy()

			iter_36_1 = nil
		end
	end

	return
end

function var_0_0.OnEnable(arg_37_0)
	arg_37_0:OnShow()

	return
end

return var_0_0
