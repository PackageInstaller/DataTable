local var_0_0 = class("BossRushAlvitScene", import("view.base.BaseUI"))

var_0_0.DISPLAY = {
	STORY = 2,
	BATTLE = 1
}

function var_0_0.getUIName(arg_1_0)
	return "BossRushAlvitUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.top = arg_2_0._tf:Find("Top")
	arg_2_0.ptBtn = arg_2_0.top:Find("right/pt")
	arg_2_0.ptText = arg_2_0.ptBtn:Find("value/Text")
	arg_2_0.ptTip = arg_2_0.ptBtn:Find("tip")
	arg_2_0.rankBtn = arg_2_0.top:Find("right/rank")
	arg_2_0.taskBtn = arg_2_0.top:Find("right/task")
	arg_2_0.taskTip = arg_2_0.taskBtn:Find("tip")
	arg_2_0.seriesNodes = _.map(_.range(arg_2_0._tf:Find("Battle/Nodes").childCount), function(arg_3_0)
		return arg_2_0._tf:Find("Battle/Nodes"):GetChild(arg_3_0 - 1)
	end)
	arg_2_0.nodes = {}

	for iter_2_0 = 1, arg_2_0._tf:Find("Story/Nodes").childCount do
		local var_2_0 = arg_2_0._tf:Find("Story/Nodes"):GetChild(iter_2_0 - 1)

		arg_2_0.nodes[var_2_0.name] = var_2_0
	end

	arg_2_0.progressText = arg_2_0._tf:Find("Story/Desc/Text")
	arg_2_0.storyAward = arg_2_0._tf:Find("Story/Award")
	arg_2_0.ActionSequence = {}

	return
end

function var_0_0.SetActivity(arg_4_0, arg_4_1)
	arg_4_0.activity = arg_4_1

	return
end

function var_0_0.SetPtActivity(arg_5_0, arg_5_1)
	arg_5_0.ptActivity = arg_5_1
	arg_5_0.ptData = ActivityPtData.New(arg_5_0.ptActivity)

	return
end

function var_0_0.didEnter(arg_6_0)
	onButton(arg_6_0, arg_6_0.top:Find("top/back"), function()
		arg_6_0:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(arg_6_0, arg_6_0.top:Find("top/home"), function()
		arg_6_0:quickExitFunc()

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.rankBtn, function()
		arg_6_0:emit(BossRushAlvitMediator.ON_EXTRA_RANK)

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.ptBtn, function()
		arg_6_0:emit(BossRushAlvitMediator.GO_SUBLAYER, Context.New({
			mediator = ChildishnessSchoolPtMediator,
			viewComponent = ChildishnessSchoolPtPage
		}))

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.taskBtn, function()
		arg_6_0:emit(BossRushAlvitMediator.GO_SUBLAYER, Context.New({
			mediator = ChildishnessSchoolTaskMediator,
			viewComponent = ChildishnessSchoolTaskPage
		}))

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0._tf:Find("Battle/Story"), function()
		arg_6_0:SetDisplayMode(var_0_0.DISPLAY.STORY)

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0._tf:Find("Story/Battle"), function()
		arg_6_0:SetDisplayMode(var_0_0.DISPLAY.BATTLE)

		return
	end, SFX_PANEL)

	arg_6_0.storyNodesDict = {}

	_.each(arg_6_0.activity:getConfig("config_client").storys, function(arg_14_0)
		arg_6_0.storyNodesDict[arg_14_0] = BossRushStoryNode.New({
			id = arg_14_0
		})

		return
	end)
	arg_6_0:UpdateStoryTask()

	local var_6_0 = arg_6_0.contextData.displayMode or BossRushAlvitScene.DISPLAY.BATTLE

	arg_6_0.contextData.displayMode = nil

	arg_6_0:SetDisplayMode(var_6_0)

	return
end

function var_0_0.getBGM(arg_15_0)
	if not pg.voice_bgm[arg_15_0.__cname] then
		return nil
	end

	local var_15_0 = pg.voice_bgm[arg_15_0.__cname].bgm

	if arg_15_0.contextData.displayMode == var_0_0.DISPLAY.BATTLE then
		return var_15_0
	elseif arg_15_0.contextData.displayMode == var_0_0.DISPLAY.STORY then
		return "story-richang-11"
	end

	return
end

function var_0_0.SetDisplayMode(arg_16_0, arg_16_1)
	if arg_16_1 == arg_16_0.contextData.displayMode then
		return
	end

	arg_16_0.contextData.displayMode = arg_16_1

	arg_16_0:PlayBGM()
	arg_16_0:UpdateView()

	return
end

function var_0_0.UpdateView(arg_17_0)
	local var_17_0 = arg_17_0.contextData.displayMode == var_0_0.DISPLAY.BATTLE

	setActive(arg_17_0._tf:Find("Battle"), arg_17_0.contextData.displayMode == var_0_0.DISPLAY.BATTLE)
	setActive(arg_17_0._tf:Find("Story"), not var_17_0)
	arg_17_0:UpdateBattle()

	if not var_17_0 then
		arg_17_0:UpdateStory()
	end

	arg_17_0:UpdateTaskTip()

	local var_17_1 = arg_17_0.contextData.displayMode

	arg_17_0:addbubbleMsgBoxList({
		function(arg_18_0)
			local var_18_0

			if var_17_1 == var_0_0.DISPLAY.BATTLE then
				var_18_0 = arg_17_0.activity:getConfig("config_client").openActivityStory
			elseif var_17_1 == var_0_0.DISPLAY.STORY then
				var_18_0 = arg_17_0.activity:getConfig("config_client").openStory
			end

			arg_17_0:PlayStory(var_18_0, arg_18_0)

			return
		end,
		function(arg_19_0)
			if underscore.all(underscore.values(arg_17_0.storyNodesDict), function(arg_20_0)
				return arg_20_0:IsReaded()
			end) and arg_17_0.storyTask and arg_17_0.storyTask:getTaskStatus() == 2 then
				arg_17_0:PlayStory(arg_17_0.activity:getConfig("config_client").endStory, function(arg_21_0)
					arg_19_0()

					if arg_21_0 then
						arg_17_0:UpdateView()
					end

					return
				end)

				return
			end

			arg_19_0()

			return
		end
	})

	return
end

function var_0_0.UpdateBattle(arg_22_0)
	local var_22_0 = arg_22_0.activity:GetActiveSeriesIds()

	table.Foreach(arg_22_0.seriesNodes, function(arg_23_0, arg_23_1)
		local var_23_0 = BossRushSeriesData.New({
			id = var_22_0[arg_23_0],
			actId = var_0.id
		})

		setActive(arg_23_1, (var_23_0:IsUnlock(var_0)))

		local var_23_1 = true

		if var_23_0:GetType() == BossRushSeriesData.TYPE.SP then
			local var_23_2 = var_0:GetUsedBonus()[arg_23_0] or 0
			local var_23_3 = var_23_0:GetMaxBonusCount()

			setText(arg_23_1:Find("count/Text"), i18n("series_enemy_SP_count") .. math.max(0, var_23_3 - var_23_2) .. "/" .. var_23_3)

			var_23_1 = var_23_3 - var_23_2 > 0
		end

		local function var_23_4()
			if not var_0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("series_enemy_unlock", BossRushSeriesData.New({
					id = var_23_0:GetPreSeriesId()
				}):GetName()))

				return
			end

			if not var_23_1 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("series_enemy_SP_error"))

				return
			end

			arg_22_0:emit(BossRushAlvitMediator.ON_FLEET_SELECT, var_23_0)

			return
		end

		onButton(arg_22_0, arg_23_1:Find("icon"), function()
			var_23_4()

			return
		end, SFX_PANEL)
		onButton(arg_22_0, arg_23_1:Find("text"), function()
			var_23_4()

			return
		end, SFX_PANEL)

		return
	end)
	setText(arg_22_0.ptText, arg_22_0.ptActivity.data1)
	setActive(arg_22_0.ptTip, Activity.IsActivityReady(arg_22_0.ptActivity))

	local var_22_1 = arg_22_0.storyTask and arg_22_0.storyTask:getTaskStatus() ~= 2

	setActive(arg_22_0._tf:Find("Battle/Story/new"), var_22_1)

	return
end

function var_0_0.UpdateStory(arg_27_0)
	local var_27_0 = pg.NewStoryMgr.GetInstance()
	local var_27_1 = 0
	local var_27_2 = 0

	table.Foreach(arg_27_0.storyNodesDict, function(arg_28_0, arg_28_1)
		local var_28_0 = arg_27_0.nodes[tostring(arg_28_1.id)]
		local var_28_1 = isActive(var_28_0)

		if arg_28_1:IsActive(arg_27_0.activity, arg_27_0.ptActivity) then
			if not var_28_1 then
				setActive(var_28_0, true)
			end

			setActive(var_28_0, true)

			if not var_28_1 then
				var_28_0:GetComponent(typeof(Animation)):Play("anim_kinder_bossrush_story_tip")
			end
		else
			setActive(var_28_0, false)
		end

		setText(var_28_0:Find("main/Text"), arg_28_1:GetName())

		local var_28_2 = arg_28_1:GetType()

		if var_28_2 == BossRushStoryNode.NODE_TYPE.NORMAL then
			setActive(var_28_0:Find("tags/story"), true)
			setActive(var_28_0:Find("tags/battle"), false)
		elseif var_28_2 == BossRushStoryNode.NODE_TYPE.EVENT then
			-- block empty
		elseif var_28_2 == BossRushStoryNode.NODE_TYPE.BATTLE then
			setActive(var_28_0:Find("tags/story"), false)
			setActive(var_28_0:Find("tags/battle"), true)
		end

		local var_28_3 = arg_28_1:IsReaded()

		var_27_1 = var_27_1 + (var_28_3 and 1 or 0)
		var_27_2 = var_27_2 + 1

		setActive(var_28_0:Find("main"), not var_28_3)
		setActive(var_28_0:Find("finish"), var_28_3)
		setActive(var_28_0:Find("finish_tag"), var_28_3)
		onButton(arg_27_0, var_28_0, function()
			if not var_0 or var_28_3 then
				return
			end

			arg_27_0:PlayStory(arg_28_1:GetStory(), function()
				arg_27_0:UpdateView()

				return
			end)

			return
		end)

		return
	end)
	setText(arg_27_0.progressText, 0 .. "/" .. 0)
	setActive(arg_27_0.storyAward, tobool(arg_27_0.storyTask))

	if arg_27_0.storyTask then
		local var_27_3 = arg_27_0.storyTask:getConfig("award_display")

		updateDrop(arg_27_0.storyAward:GetChild(0), (Drop.New({
			type = var_27_3[1][1],
			id = var_27_3[1][2],
			count = var_27_3[1][3]
		})))

		local var_27_4 = arg_27_0.storyTask:getTaskStatus()

		setActive(arg_27_0.storyAward:Find("get"), var_27_4 == 1)
		setActive(arg_27_0.storyAward:Find("got"), var_27_4 == 2)

		if var_27_4 == 1 then
			arg_27_0:emit(BossRushAlvitMediator.ON_TASK_SUBMIT, arg_27_0.storyTask)
		end

		onButton(arg_27_0, arg_27_0.storyAward, function()
			arg_27_0:emit(BaseUI.ON_DROP, var_0)

			return
		end)
	end

	return
end

function var_0_0.PlayStory(arg_32_0, arg_32_1, arg_32_2)
	if not arg_32_1 then
		return existCall(arg_32_2)
	end

	local var_32_0 = pg.NewStoryMgr.GetInstance()
	local var_32_1 = var_32_0:IsPlayed(arg_32_1)

	seriesAsync({
		function(arg_33_0)
			if var_32_1 then
				return arg_33_0()
			end

			local var_33_0 = tonumber(arg_32_1)

			if var_33_0 and var_33_0 > 0 then
				arg_32_0:emit(BossRushAlvitMediator.ON_PERFORM_COMBAT, var_33_0)
			else
				var_32_0:Play(arg_32_1, arg_33_0)
			end

			return
		end,
		function(arg_34_0, ...)
			existCall(arg_32_2, ...)

			return
		end
	})

	return
end

function var_0_0.UpdateStoryTask(arg_35_0)
	local var_35_0 = arg_35_0.activity:getConfig("config_client").tasks[1]
	local var_35_1 = getProxy(TaskProxy):getTaskVO(var_35_0)

	var_35_1 = var_35_1 or Task.New({
		submit_time = 1,
		id = var_35_0
	})
	arg_35_0.storyTask = var_35_1

	return
end

function var_0_0.UpdateTaskTip(arg_36_0)
	setActive(arg_36_0.taskTip, Activity.IsActivityReady(getProxy(ActivityProxy):getActivityById(ActivityConst.ALVIT_TASK_ACT_ID)))

	return
end

function var_0_0.addbubbleMsgBoxList(arg_37_0, arg_37_1)
	local var_37_0 = #arg_37_0.ActionSequence == 0

	table.insertto(arg_37_0.ActionSequence, arg_37_1)

	if not var_37_0 then
		return
	end

	arg_37_0:resumeBubble()

	return
end

function var_0_0.addbubbleMsgBox(arg_38_0, arg_38_1)
	local var_38_0 = #arg_38_0.ActionSequence == 0

	table.insert(arg_38_0.ActionSequence, arg_38_1)

	if not var_38_0 then
		return
	end

	arg_38_0:resumeBubble()

	return
end

function var_0_0.resumeBubble(arg_39_0)
	if #arg_39_0.ActionSequence == 0 then
		return
	end

	;(function()
		if arg_39_0.ActionSequence[1] then
			arg_39_0.ActionSequence[1](function()
				table.remove(arg_39_0.ActionSequence, 1)
				var_0()

				return
			end)
		end

		return
	end)()

	return
end

function var_0_0.onBackPressed(arg_42_0)
	arg_42_0:emit(BossRushAlvitMediator.GO_SCENE, SCENE.KINDERGARTEN, {
		isBack = true
	})

	return
end

function var_0_0.CleanBubbleMsgbox(arg_43_0)
	table.clean(arg_43_0.ActionSequence)

	return
end

return var_0_0
