local var_0_0 = class("BossRushEscapeManorScene", import("view.base.BaseUI"))

var_0_0.DISPLAY = {
	STORY = "Story",
	BATTLE = "Battle"
}

function var_0_0.getUIName(arg_1_0)
	return "BossRushEscapeManorUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.top = arg_2_0._tf:Find("Top")
	arg_2_0.ptBtn = arg_2_0.top:Find("right/pt")
	arg_2_0.ptTip = arg_2_0.ptBtn:Find("tip")
	arg_2_0.rankBtn = arg_2_0.top:Find("right/rank")

	setText(arg_2_0.rankBtn:Find("Text"), i18n("escape_series_rank"))

	arg_2_0.taskBtn = arg_2_0.top:Find("right/task")

	setText(arg_2_0.taskBtn:Find("Text"), i18n("escape_series_task"))

	arg_2_0.taskTip = arg_2_0.taskBtn:Find("tip")
	arg_2_0.seriesNodes = {}

	eachChild(arg_2_0._tf:Find("Battle/Nodes"), function(arg_3_0, arg_3_1)
		arg_2_0.seriesNodes[arg_3_0.name] = arg_3_0

		return
	end)

	arg_2_0.nodes = {}

	eachChild(arg_2_0._tf:Find("Story/Nodes"), function(arg_4_0, arg_4_1)
		arg_2_0.nodes[arg_4_0.name] = arg_4_0

		return
	end)

	arg_2_0.switchToggle = arg_2_0.top:Find("bottom/switch_toggle")
	arg_2_0.ActionSequence = {}

	arg_2_0:UpdateRatioScale()

	arg_2_0.camEventId = pg.CameraFixMgr.GetInstance():bind(pg.CameraFixMgr.ASPECT_RATIO_UPDATE, function(arg_5_0, arg_5_1)
		arg_2_0:UpdateRatioScale()

		return
	end)
	arg_2_0.storyAward = arg_2_0.top:Find("bottom/Award")
	arg_2_0.progressText = arg_2_0.storyAward:Find("desc")

	return
end

function var_0_0.SetActivity(arg_6_0, arg_6_1)
	arg_6_0.activity = arg_6_1

	return
end

function var_0_0.SetPtActivity(arg_7_0, arg_7_1)
	arg_7_0.ptActivity = arg_7_1
	arg_7_0.ptData = ActivityPtData.New(arg_7_0.ptActivity)

	return
end

function var_0_0.didEnter(arg_8_0)
	onButton(arg_8_0, arg_8_0.top:Find("top/back"), function()
		arg_8_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_8_0, arg_8_0.top:Find("top/home"), function()
		arg_8_0:quickExitFunc()

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.top:Find("top/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("escape_manor_series_help")
		})

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.rankBtn, function()
		arg_8_0:emit(BossRushEscapeManorMediator.ON_EXTRA_RANK)

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.ptBtn, function()
		arg_8_0:emit(BossRushEscapeManorMediator.GO_SCENE, SCENE.ACTIVITY, {
			id = arg_8_0.ptActivity.id
		})

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.taskBtn, function()
		arg_8_0:emit(BossRushEscapeManorMediator.GO_SCENE, SCENE.TASK)

		return
	end, SFX_PANEL)
	onToggle(arg_8_0, arg_8_0.switchToggle:Find("Story"), function(arg_15_0)
		if arg_15_0 then
			if arg_8_0.blockAnim then
				arg_8_0.blockAnim = false
			end

			arg_8_0:SetDisplayMode(var_0_0.DISPLAY.STORY)
		end

		return
	end, SFX_PANEL)
	onToggle(arg_8_0, arg_8_0.switchToggle:Find("Battle"), function(arg_16_0)
		if arg_16_0 then
			if arg_8_0.blockAnim then
				arg_8_0.blockAnim = false
			end

			arg_8_0:SetDisplayMode(var_0_0.DISPLAY.BATTLE)
		end

		return
	end, SFX_PANEL)

	arg_8_0.storyNodesDict = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.activity:getConfig("config_client").storys) do
		arg_8_0.storyNodesDict[iter_8_1] = BossRushStoryNode.New({
			id = iter_8_1
		})
	end

	arg_8_0.blockAnim = true

	local var_8_0 = arg_8_0.contextData.displayMode or var_0_0.DISPLAY.BATTLE

	triggerToggle(arg_8_0.switchToggle:Find(var_8_0), true)

	return
end

function var_0_0.getBGM(arg_17_0)
	if arg_17_0.contextData.displayMode ~= var_0_0.DISPLAY.STORY then
		return var_0_0.super.getBGM(arg_17_0)
	else
		local var_17_0 = arg_17_0.activity:getConfig("config_client").storybgm
		local var_17_1 = pg.TimeMgr.GetInstance():GetServerHour()
		local var_17_2 = var_17_0[#var_17_0][2]

		for iter_17_0, iter_17_1 in ipairs(var_17_0) do
			if var_17_1 < iter_17_1[1] then
				break
			else
				var_17_2 = iter_17_1[2]
			end
		end

		return var_17_2
	end

	return
end

function var_0_0.getBG(arg_18_0)
	if arg_18_0.contextData.displayMode ~= var_0_0.DISPLAY.STORY then
		return "bg1"
	else
		return "bg2"
	end

	return
end

function var_0_0.SetDisplayMode(arg_19_0, arg_19_1)
	arg_19_0.contextData.displayMode = arg_19_1

	arg_19_0:UpdateView()

	return
end

function var_0_0.UpdateRatioScale(arg_20_0, arg_20_1)
	local var_20_0

	for iter_20_0, iter_20_1 in ipairs({
		"Mask",
		"Battle",
		"Story"
	}) do
		local var_20_1 = arg_20_0._tf:Find(iter_20_1)

		var_20_0 = var_20_0 or var_20_1.rect.height > 1440 and var_20_1.rect.height / 1440 or 1

		setLocalScale(var_20_1, {
			x = var_20_0,
			y = var_20_0
		})
	end

	return
end

function var_0_0.UpdateView(arg_21_0)
	local var_21_0 = arg_21_0.contextData.displayMode == var_0_0.DISPLAY.BATTLE

	setActive(arg_21_0._tf:Find("Battle"), arg_21_0.contextData.displayMode == var_0_0.DISPLAY.BATTLE)
	setActive(arg_21_0._tf:Find("Story"), not var_21_0)
	setActive(arg_21_0.storyAward, not var_21_0)

	if var_21_0 then
		arg_21_0:UpdateBattle()
	else
		arg_21_0:UpdateStory()
	end

	arg_21_0:UpdateStoryTask()

	local var_21_1 = arg_21_0:getBG()

	eachChild(arg_21_0._tf:Find("Mask"), function(arg_22_0, arg_22_1)
		setActive(arg_22_0, arg_22_0.name == var_21_1 or arg_22_0.name == "FX")

		return
	end)
	arg_21_0:PlayBGM()
	setText(arg_21_0.ptBtn:Find("Text"), i18n("escape_series_pt", arg_21_0.ptActivity.data1))
	setActive(arg_21_0.ptTip, Activity.IsActivityReady(arg_21_0.ptActivity))

	local var_21_2 = arg_21_0.contextData.displayMode

	arg_21_0:addbubbleMsgBoxList({
		function(arg_23_0)
			local var_23_0

			if var_21_2 == var_0_0.DISPLAY.BATTLE then
				var_23_0 = arg_21_0.activity:getConfig("config_client").openActivityStory
			elseif var_21_2 == var_0_0.DISPLAY.STORY then
				var_23_0 = arg_21_0.activity:getConfig("config_client").openStory
			end

			arg_21_0:PlayStory(var_23_0, arg_23_0)

			return
		end,
		function(arg_24_0)
			if underscore.all(underscore.values(arg_21_0.storyNodesDict), function(arg_25_0)
				return arg_25_0:IsReaded()
			end) and arg_21_0.storyTask and arg_21_0.storyTask:getTaskStatus() == 2 then
				arg_21_0:PlayStory(arg_21_0.activity:getConfig("config_client").endStory, arg_24_0)
			else
				arg_24_0()
			end

			return
		end
	})

	return
end

function var_0_0.UpdateBattle(arg_26_0)
	for iter_26_0, iter_26_1 in ipairs((arg_26_0.activity:GetActiveSeriesIds())) do
		local var_26_0 = arg_26_0.seriesNodes[tostring(iter_26_1)]
		local var_26_1 = BossRushSeriesData.New({
			id = iter_26_1,
			actId = arg_26_0.activity.id
		})

		setActive(var_26_0, (var_26_1:IsUnlock(arg_26_0.activity)))

		local var_26_2 = var_26_1:GetType()

		setActive(var_26_0:Find("blue"), var_26_2 == BossRushSeriesData.TYPE.NORMAL)
		setActive(var_26_0:Find("red"), var_26_2 ~= BossRushSeriesData.TYPE.NORMAL)

		local var_26_3 = var_26_2 == BossRushSeriesData.TYPE.NORMAL and var_26_0:Find("blue") or var_26_0:Find("red")

		setText(var_26_3:Find("Text"), var_26_1:GetName())
		setText(var_26_3:Find("diff/Text"), switch(iter_26_1, {
			[6001] = function()
				return i18n("zengke_series_easy")
			end,
			[6002] = function()
				return i18n("zengke_series_normal")
			end,
			[6003] = function()
				return i18n("zengke_series_hard")
			end,
			[6004] = function()
				return i18n("zengke_series_sp")
			end,
			[6005] = function()
				return i18n("zengke_series_ex")
			end
		}))

		local var_26_4 = var_26_2 == BossRushSeriesData.TYPE.SP

		setActive(var_26_0:Find("times"), var_26_2 == BossRushSeriesData.TYPE.SP)

		if var_26_4 then
			local var_26_6 = arg_26_0.activity:GetUsedBonus()[iter_26_0] or 0
			local var_26_7 = var_26_1:GetMaxBonusCount()

			setText(var_26_0:Find("times/Text"), i18n("series_enemy_SP_count") .. setColorStr(math.max(0, var_26_7 - var_26_6) .. "/" .. var_26_7, var_26_7 - var_26_6 > 0 and "#6EE868" or "#7f7f7f"))
		end

		onButton(arg_26_0, var_26_0, function()
			if not var_0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("series_enemy_unlock", BossRushSeriesData.New({
					id = var_26_1:GetPreSeriesId()
				}):GetName()))

				return
			end

			arg_26_0:emit(BossRushEscapeManorMediator.ON_FLEET_SELECT, var_26_1)

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.UpdateStory(arg_33_0)
	local var_33_0 = pg.NewStoryMgr.GetInstance()
	local var_33_1 = 0
	local var_33_2 = 0

	for iter_33_0, iter_33_1 in pairs(arg_33_0.storyNodesDict) do
		print("find node id " .. tostring(iter_33_1.id))

		local var_33_3 = arg_33_0.nodes[tostring(iter_33_1.id)]

		setActive(var_33_3, (iter_33_1:IsActive(arg_33_0.activity, arg_33_0.ptActivity)))
		setText(var_33_3:Find("main/char/bg/Text"), iter_33_1:GetName())

		local var_33_4 = iter_33_1:IsReaded()

		var_33_1 = var_33_1 + (var_33_4 and 1 or 0)
		var_33_2 = var_33_2 + 1

		setActive(var_33_3:Find("main/char"), not var_33_4)
		setActive(var_33_3:Find("main/talk"), var_33_4)
		onButton(arg_33_0, var_33_3, function()
			if not var_0 or var_33_4 then
				return
			end

			arg_33_0:PlayStory(iter_33_1:GetStory(), function()
				arg_33_0:UpdateView()

				return
			end)

			return
		end)
	end

	setText(arg_33_0.progressText, i18n("escape_story_reward_count"))
	setText(findTF(arg_33_0.progressText, "progress"), setColorStr(var_33_1, "#f34f66") .. "/" .. var_33_2)

	if arg_33_0.storyTask then
		local var_33_5 = arg_33_0.storyAward:Find("award_bg")

		updateDrop(var_33_5:Find("IconTpl"), (Drop.Create(arg_33_0.storyTask:getConfig("award_display")[1])))
		onButton(arg_33_0, var_33_5, function()
			arg_33_0:emit(BaseUI.ON_DROP, var_0)

			return
		end, SFX_PANEL)

		local var_33_6 = arg_33_0.storyTask:getTaskStatus()

		setActive(var_33_5:Find("get"), var_33_6 == 1)
		setActive(var_33_5:Find("got"), var_33_6 == 2)
	end

	return
end

function var_0_0.PlayStory(arg_37_0, arg_37_1, arg_37_2)
	if not arg_37_1 then
		return existCall(arg_37_2)
	end

	local var_37_0 = pg.NewStoryMgr.GetInstance()
	local var_37_1 = var_37_0:IsPlayed(arg_37_1)

	seriesAsync({
		function(arg_38_0)
			if var_37_1 then
				return arg_38_0()
			end

			local var_38_0 = tonumber(arg_37_1)

			if var_38_0 and var_38_0 > 0 then
				arg_37_0:emit(BossRushEscapeManorMediator.ON_PERFORM_COMBAT, var_38_0)
			else
				var_37_0:Play(arg_37_1, arg_38_0)
			end

			return
		end
	}, arg_37_2)

	return
end

function var_0_0.UpdateStoryTask(arg_39_0)
	local var_39_0 = arg_39_0.activity:getConfig("config_client").tasks[1]
	local var_39_1 = getProxy(TaskProxy):getTaskVO(var_39_0)

	var_39_1 = var_39_1 or Task.New({
		submit_time = 1,
		id = var_39_0
	})
	arg_39_0.storyTask = var_39_1

	local var_39_2 = arg_39_0.storyTask and arg_39_0.storyTask:getTaskStatus() ~= 2

	setActive(arg_39_0.switchToggle:Find("Story/new"), var_39_2)
	setActive(arg_39_0.taskTip, Activity.IsActivityReady(getProxy(ActivityProxy):getActivityById(ActivityConst.ESCAPE_BOSS_RUSH_TASK_ACT_ID)))

	local var_39_5

	if arg_39_0.storyTask then
		local var_39_3 = arg_39_0.storyAward:Find("award_bg")

		updateDrop(var_39_3:Find("IconTpl"), (Drop.Create(arg_39_0.storyTask:getConfig("award_display")[1])))
		onButton(arg_39_0, var_39_3:Find("IconTpl"), function()
			arg_39_0:emit(BaseUI.ON_DROP, var_0)

			return
		end, SFX_PANEL)

		local var_39_4 = arg_39_0.storyTask:getTaskStatus()

		setActive(var_39_3:Find("get"), var_39_4 == 1)
		setActive(var_39_3:Find("got"), var_39_4 == 2)

		var_39_5 = arg_39_0.storyAward:Find("award_bg")
	end

	updateDrop(var_39_5:Find("IconTpl"), (Drop.Create(arg_39_0.storyTask:getConfig("award_display")[1])))
	onButton(arg_39_0, var_39_5, function()
		return
	end, SFX_PANEL)

	local var_39_6 = arg_39_0.storyTask:getTaskStatus()

	setActive(var_39_5:Find("get"), var_39_6 == 1)
	setActive(var_39_5:Find("got"), var_39_6 == 2)

	if var_39_6 == 1 then
		arg_39_0:emit(BossRushEscapeManorMediator.ON_TASK_SUBMIT, arg_39_0.storyTask)
	end

	return
end

function var_0_0.addbubbleMsgBoxList(arg_42_0, arg_42_1)
	local var_42_0 = #arg_42_0.ActionSequence == 0

	table.insertto(arg_42_0.ActionSequence, arg_42_1)

	if not var_42_0 then
		return
	end

	arg_42_0:resumeBubble()

	return
end

function var_0_0.addbubbleMsgBox(arg_43_0, arg_43_1)
	local var_43_0 = #arg_43_0.ActionSequence == 0

	table.insert(arg_43_0.ActionSequence, arg_43_1)

	if not var_43_0 then
		return
	end

	arg_43_0:resumeBubble()

	return
end

function var_0_0.resumeBubble(arg_44_0)
	if #arg_44_0.ActionSequence == 0 then
		return
	end

	;(function()
		if arg_44_0.ActionSequence[1] then
			arg_44_0.ActionSequence[1](function()
				table.remove(arg_44_0.ActionSequence, 1)
				var_0()

				return
			end)
		end

		return
	end)()

	return
end

function var_0_0.CleanBubbleMsgbox(arg_47_0)
	table.clean(arg_47_0.ActionSequence)

	return
end

function var_0_0.willExit(arg_48_0)
	if arg_48_0.camEventId then
		pg.CameraFixMgr.GetInstance():disconnect(arg_48_0.camEventId)

		arg_48_0.camEventId = nil
	end

	return
end

return var_0_0
