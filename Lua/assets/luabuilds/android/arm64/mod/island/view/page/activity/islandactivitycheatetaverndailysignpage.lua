local var_0_0 = class("IslandActivityCheateTavernDailySignPage", import("Mod.Island.View.page.activity.IslandBaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.scrollCom = arg_1_0.uiView:GetComponent("LScrollRect")

	function arg_1_0.scrollCom.onInitItem(arg_2_0)
		arg_1_0:InitAward(tf(arg_2_0))

		return
	end

	function arg_1_0.scrollCom.onUpdateItem(arg_3_0, arg_3_1)
		arg_1_0:UpdateTask(arg_3_0, tf(arg_3_1))

		return
	end

	onButton(arg_1_0, arg_1_0.uiGoBtn, function()
		arg_1_0:emit(IslandMediator.RECORD_PLAYER_POS)
		arg_1_0:emit(IslandMediator.OPEN_PAGE, "IslandCheaterTavernPrepareMainPage")

		return
	end, SFX_PANEL)
	onButton(arg_1_0, arg_1_0.uiRankBtn, function()
		arg_1_0:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = PlayRoomRankScene,
			mediator = PlayRoomRankMediator,
			data = {
				gameType = 101
			}
		}))

		return
	end)
	setText(arg_1_0.uiGoText, i18n("bar_ui_check1"))
	setText(arg_1_0.uiGotText, i18n("bar_ui_check2"))

	return
end

function var_0_0.UpdateTaskData(arg_6_0)
	arg_6_0.taskVOs = arg_6_0.actTaskProxy:getTaskById(arg_6_0.activity.id)
	arg_6_0.finishTaksVOs = arg_6_0.actTaskProxy:getFinishTaskById(arg_6_0.activity.id)
	arg_6_0.taskDic = {}

	_.each(arg_6_0.taskVOs, function(arg_7_0)
		arg_6_0.taskDic[arg_7_0.id] = arg_7_0

		return
	end)
	_.each(arg_6_0.finishTaksVOs, function(arg_8_0)
		arg_6_0.taskDic[arg_8_0.id] = arg_8_0

		return
	end)

	return
end

function var_0_0.InitAward(arg_9_0, arg_9_1)
	return
end

function var_0_0.UpdateTask(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = tf(arg_10_2)
	local var_10_1 = Drop.Create(arg_10_0.taskConfig[arg_10_0.taskGroup[arg_10_1 + 1]].award_display[1])

	if arg_10_1 + 1 >= 1 then
		updateCustomDrop(var_10_0:Find("IslandItemTpl"), Drop.Create(arg_10_0.taskConfig[arg_10_0.taskGroup[arg_10_1 + 1]].award_display[1]), {
			style = "island"
		})
		onButton(arg_10_0, arg_10_2, function()
			arg_10_0:emit(IslandMediator.SHOW_MSG_BOX, {
				title = i18n("island_word_desc"),
				type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
				dropData = var_10_1
			})

			return
		end, SFX_PANEL)
		onButton(arg_10_0, var_10_0:Find("canget"), function()
			pg.m02:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
				inIsland = true,
				act_id = arg_10_0.activity.id,
				task_ids = arg_10_0:GetCanSubmitTaskIds()
			})

			return
		end, SFX_PANEL)
	end

	setText(var_10_0:Find("target"), "Day" .. tostring(arg_10_1 + 1))
	setActive(var_10_0:Find("got"), arg_10_0.taskDic[arg_10_0.taskGroup[arg_10_1 + 1]] and arg_10_0.taskDic[arg_10_0.taskGroup[arg_10_1 + 1]]:isOver())
	setActive(var_10_0:Find("canget"), arg_10_0.taskDic[arg_10_0.taskGroup[arg_10_1 + 1]] and arg_10_0.taskDic[arg_10_0.taskGroup[arg_10_1 + 1]]:getTaskStatus() == 1 and not arg_10_0.taskDic[arg_10_0.taskGroup[arg_10_1 + 1]]:isOver())
	setActive(var_10_0:Find("lock"), arg_10_0.taskDic[arg_10_0.taskGroup[arg_10_1 + 1]] and arg_10_0.taskDic[arg_10_0.taskGroup[arg_10_1 + 1]]:getTaskStatus() == -1 and not arg_10_0.taskDic[arg_10_0.taskGroup[arg_10_1 + 1]]:isOver())

	return
end

function var_0_0.OnDataSetting(arg_13_0)
	arg_13_0.actTaskProxy = getProxy(ActivityTaskProxy)
	arg_13_0.taskGroup = underscore.flatten(arg_13_0.activity:getConfig("config_data"))
	arg_13_0.taskConfig = pg.task_data_template

	return
end

function var_0_0.OnFirstFlush(arg_14_0)
	arg_14_0.scrollCom:SetTotalCount(5)

	return
end

function var_0_0.OnUpdateFlush(arg_15_0)
	arg_15_0:UpdateTaskData()
	arg_15_0.scrollCom:SetTotalCount(5)
	setText(arg_15_0.uiPtNum, (PlayRoomTools.GetPtScrore(arg_15_0:GetGameType())))
	GetImageSpriteFromAtlasAsync("Island/IslandCheaterTavernIcon/" .. PlayRoomTools.GetPtScoreIcon(arg_15_0:GetGameType()), "", arg_15_0.uiPtIcon)

	return
end

function var_0_0.OnShowFlush(arg_16_0)
	return
end

function var_0_0.GetGameType(arg_17_0)
	return 101
end

function var_0_0.GetCanSubmitTaskIds(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0.taskVOs) do
		if iter_18_1:getTaskStatus() == 1 and not iter_18_1:isOver() then
			table.insert({}, iter_18_1.id)
		end
	end

	return {}
end

function var_0_0.OnDestroy(arg_19_0)
	ClearLScrollrect(arg_19_0.scrollCom)

	return
end

return var_0_0
