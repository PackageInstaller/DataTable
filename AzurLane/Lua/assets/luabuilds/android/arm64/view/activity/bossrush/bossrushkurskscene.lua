local var_0_0 = class("BossRushKurskScene", import("view.base.BaseUI"))
local var_0_1 = require("Mgr/Pool/PoolPlural")

var_0_0.DISPLAY = {
	STORY = 2,
	BATTLE = 1
}

function var_0_0.getUIName(arg_1_0)
	return "BossRushKurskUI"
end

function var_0_0.GetAtalsName(arg_2_0)
	return "ui/BossRushKurskUI_atlas"
end

function var_0_0.ResUISettings(arg_3_0)
	return true
end

function var_0_0.Ctor(arg_4_0)
	var_0_0.super.Ctor(arg_4_0)

	arg_4_0.loader = AutoLoader.New()

	return
end

function var_0_0.preload(arg_5_0, arg_5_1)
	existCall(arg_5_1)
	arg_5_0.loader:LoadBundle(arg_5_0:GetAtalsName())

	return
end

function var_0_0.init(arg_6_0)
	arg_6_0.top = arg_6_0._tf:Find("Top")
	arg_6_0.map = arg_6_0._tf:Find("Map")

	local var_6_0 = arg_6_0._tf:Find("Battle/Nodes")

	arg_6_0.seriesNodes = {}

	for iter_6_0 = 1, var_6_0.childCount do
		local var_6_1 = var_6_0:GetChild(iter_6_0 - 1)

		if isActive(var_6_1) then
			table.insert(arg_6_0.seriesNodes, var_6_1)
		end
	end

	arg_6_0.ptText = arg_6_0._tf:Find("Battle/Reward/Text")
	arg_6_0.nodes = {}

	for iter_6_1 = 1, arg_6_0._tf:Find("Map").childCount do
		local var_6_2 = arg_6_0._tf:Find("Map"):GetChild(iter_6_1 - 1)

		arg_6_0.nodes[var_6_2.name] = {
			tfType = 1,
			trans = var_6_2
		}
	end

	for iter_6_2 = 1, arg_6_0._tf:Find("Story/Nodes").childCount do
		local var_6_3 = arg_6_0._tf:Find("Story/Nodes"):GetChild(iter_6_2 - 1)

		arg_6_0.nodes[var_6_3.name] = {
			tfType = 2,
			trans = var_6_3
		}
	end

	arg_6_0.pluralRoot = pg.PoolMgr.GetInstance().root

	local var_6_4 = go(arg_6_0._tf:Find("Link"))

	setActive(var_6_4, false)

	arg_6_0.plural = var_0_1.New(var_6_4, 32)
	arg_6_0.linksContainer = arg_6_0._tf:Find("Links")
	arg_6_0.links = {}
	arg_6_0.storyBar = arg_6_0._tf:Find("Story/StoryBar")
	arg_6_0.storyAward = arg_6_0._tf:Find("Story/PassLevel/Award")
	arg_6_0.ActionSequence = {}

	setText(arg_6_0._tf:Find("Battle/Rank/Title"), i18n("word_billboard"))
	setText(arg_6_0._tf:Find("Battle/Reward/Title"), i18n("series_enemy_reward"))
	setText(arg_6_0._tf:Find("Story/PassLevel/Title"), i18n("series_enemy_storyreward"))
	setText(arg_6_0._tf:Find("Story/PassLevel/PT/Tips"), i18n("series_enemy_storyunlock"))

	return
end

function var_0_0.SetActivity(arg_7_0, arg_7_1)
	arg_7_0.activity = arg_7_1

	return
end

function var_0_0.SetPtActivity(arg_8_0, arg_8_1)
	arg_8_0.ptActivity = arg_8_1
	arg_8_0.ptData = ActivityPtData.New(arg_8_0.ptActivity)

	return
end

function var_0_0.didEnter(arg_9_0)
	onButton(arg_9_0, arg_9_0.top:Find("back_btn"), function()
		arg_9_0:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(arg_9_0, arg_9_0.top:Find("option"), function()
		arg_9_0:quickExitFunc()

		return
	end, SFX_PANEL)
	onButton(arg_9_0, arg_9_0._tf:Find("Help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = {
				{
					info = i18n("series_enemy_help")
				}
			}
		})

		return
	end, SFX_PANEL)
	onButton(arg_9_0, arg_9_0._tf:Find("Battle/Rank"), function()
		arg_9_0:emit(BossRushKurskMediator.ON_EXTRA_RANK)

		return
	end, SFX_PANEL)
	onButton(arg_9_0, arg_9_0._tf:Find("Battle/Reward"), function()
		arg_9_0:emit(BossRushKurskMediator.GO_ACT_SHOP, arg_9_0.ptData)

		return
	end, SFX_PANEL)
	onButton(arg_9_0, arg_9_0._tf:Find("Battle/Story"), function()
		arg_9_0:SetDisplayMode(var_0_0.DISPLAY.STORY)

		return
	end, SFX_PANEL)
	onButton(arg_9_0, arg_9_0._tf:Find("Story/Battle"), function()
		arg_9_0:SetDisplayMode(var_0_0.DISPLAY.BATTLE)

		return
	end, SFX_PANEL)

	local var_9_0 = arg_9_0.activity:getConfig("config_client").storys or {}

	arg_9_0.storyNodesDict = {}

	_.each(var_9_0, function(arg_17_0)
		arg_9_0.storyNodesDict[arg_17_0] = BossRushStoryNode.New({
			id = arg_17_0
		})

		return
	end)

	local var_9_1 = arg_9_0.activity:getConfig("config_client").tasks or {}

	if #var_9_1 > 0 then
		local var_9_2 = arg_9_0.activity:getConfig("config_client").tasks[1]
		local var_9_3 = getProxy(TaskProxy):getTaskVO(var_9_2)

		var_9_3 = var_9_3 or Task.New({
			submitTime = 1,
			id = var_9_2
		})
		arg_9_0.storyTask = var_9_3
	end

	local var_9_4 = arg_9_0.contextData.displayMode or BossRushKurskScene.DISPLAY.BATTLE

	arg_9_0.contextData.displayMode = nil

	arg_9_0:SetDisplayMode(var_9_4)

	return
end

function var_0_0.getBGM(arg_18_0)
	if not pg.voice_bgm[arg_18_0.__cname] then
		return nil
	end

	local var_18_0 = pg.voice_bgm[arg_18_0.__cname].bgm

	if arg_18_0.contextData.displayMode == var_0_0.DISPLAY.BATTLE then
		return var_18_0
	elseif arg_18_0.contextData.displayMode == var_0_0.DISPLAY.STORY then
		return "battle-deepecho"
	end

	return
end

function var_0_0.SetDisplayMode(arg_19_0, arg_19_1)
	if arg_19_1 == arg_19_0.contextData.displayMode then
		return
	end

	arg_19_0.contextData.displayMode = arg_19_1

	arg_19_0:PlayBGM()
	arg_19_0:UpdateView()

	return
end

function var_0_0.UpdateView(arg_20_0)
	local var_20_0 = arg_20_0.contextData.displayMode == var_0_0.DISPLAY.BATTLE

	setActive(arg_20_0._tf:Find("Battle"), arg_20_0.contextData.displayMode == var_0_0.DISPLAY.BATTLE)
	setActive(arg_20_0._tf:Find("Story"), not var_20_0)
	setActive(arg_20_0._tf:Find("Links"), not var_20_0)
	arg_20_0:UpdateBattle()
	arg_20_0:UpdateStory()

	local var_20_1 = arg_20_0.contextData.displayMode

	arg_20_0:addbubbleMsgBoxList({
		function(arg_21_0)
			if arg_20_0.activity:HasPassSeries(1001) then
				pg.SystemGuideMgr.GetInstance():PlayByGuideId("NG0036", nil, arg_21_0)

				return
			end

			arg_21_0()

			return
		end,
		function(arg_22_0)
			local var_22_0

			if var_20_1 == var_0_0.DISPLAY.BATTLE then
				var_22_0 = arg_20_0.activity:getConfig("config_client").openActivityStory
			elseif var_20_1 == var_0_0.DISPLAY.STORY then
				var_22_0 = arg_20_0.activity:getConfig("config_client").openStory
			end

			arg_20_0:PlayStory(var_22_0, arg_22_0)

			return
		end,
		function(arg_23_0)
			if underscore.all(underscore.values(arg_20_0.storyNodesDict), function(arg_24_0)
				return arg_24_0:IsReaded()
			end) then
				arg_20_0:PlayStory(arg_20_0.activity:getConfig("config_client").endStory, function(arg_25_0)
					arg_23_0()

					if arg_25_0 then
						arg_20_0:UpdateView()
					end

					return
				end)

				return
			end

			arg_23_0()

			return
		end
	})

	return
end

function var_0_0.UpdateBattle(arg_26_0)
	local var_26_0 = arg_26_0.activity:GetActiveSeriesIds()

	table.Foreach(arg_26_0.seriesNodes, function(arg_27_0, arg_27_1)
		local var_27_0 = BossRushSeriesData.New({
			id = var_26_0[arg_27_0],
			actId = var_0.id
		})
		local var_27_1 = var_27_0:IsUnlock(var_0)

		setActive(arg_27_1:Find("Pin/NameBG"), var_27_1)
		setActive(arg_27_1:Find("Pin/Lock"), not var_27_1)
		setText(arg_27_1:Find("Pin/ChapterName"), var_27_0:GetSeriesCode())
		setText(arg_27_1:Find("Pin/NameBG/Name"), var_27_0:GetName())

		local var_27_2 = var_27_0:GetType() == BossRushSeriesData.TYPE.SP

		setActive(arg_27_1:Find("Pin/NameBG/BonusCount"), var_27_1 and var_27_2)

		local var_27_3 = true

		if var_27_2 then
			local var_27_4 = var_0:GetUsedBonus()[arg_27_0] or 0
			local var_27_5 = var_27_0:GetMaxBonusCount()

			setText(arg_27_1:Find("Pin/NameBG/BonusCount"):GetChild(0), i18n("series_enemy_SP_count"))
			setText(arg_27_1:Find("Pin/NameBG/BonusCount"):GetChild(1), math.max(0, var_27_5 - var_27_4) .. "/" .. var_27_5)

			var_27_3 = var_27_5 - var_27_4 > 0
		end

		onButton(arg_26_0, arg_27_1, function()
			if not var_27_1 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("series_enemy_unlock", BossRushSeriesData.New({
					id = var_27_0:GetPreSeriesId()
				}):GetName()))

				return
			end

			if not var_27_3 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("series_enemy_SP_error"))

				return
			end

			arg_26_0:emit(BossRushKurskMediator.ON_FLEET_SELECT, var_27_0)

			return
		end, SFX_PANEL)

		return
	end)
	setActive(arg_26_0._tf:Find("Battle/Reward/Tip"), arg_26_0.ptData:CanGetAward())
	setText(arg_26_0.ptText, arg_26_0.ptActivity.data1)

	return
end

local var_0_2 = {
	"story_bar_green",
	"story_bar_yellow",
	"story_bar_purple"
}

function var_0_0.UpdateStory(arg_29_0)
	local var_29_0 = pg.NewStoryMgr.GetInstance()
	local var_29_1
	local var_29_2

	arg_29_0:ReturnLinks()

	local var_29_3 = false

	table.Foreach(arg_29_0.storyNodesDict, function(arg_30_0, arg_30_1)
		local var_30_0 = arg_29_0.nodes[arg_30_1:GetIconName()].trans
		local var_30_1 = arg_30_1:IsActive(arg_29_0.activity, arg_29_0.ptActivity)
		local var_30_2 = arg_30_1:IsReaded()
		local var_30_3 = arg_30_1:GetType()

		if var_30_3 == BossRushStoryNode.NODE_TYPE.NORMAL then
			arg_29_0.loader:GetSprite(arg_29_0:GetAtalsName(), var_30_1 and "story_green_active" or "story_green", var_30_0:GetChild(0), true)
		elseif var_30_3 == BossRushStoryNode.NODE_TYPE.EVENT then
			setActive(var_30_0, var_30_1)
			arg_29_0.loader:GetSprite(arg_29_0:GetAtalsName(), var_30_1 and "story_yellow_active" or "story_yellow", var_30_0:GetChild(0), true)
		elseif var_30_3 == BossRushStoryNode.NODE_TYPE.BATTLE then
			-- block empty
		end

		if var_30_1 then
			setAnchoredPosition(arg_29_0.storyBar, (arg_29_0._tf:Find("Story"):InverseTransformPoint(var_30_0.position)))
			setText(arg_29_0.storyBar:Find("Text"), arg_30_1:GetName())
			arg_29_0.loader:GetSprite(arg_29_0:GetAtalsName(), var_0_2[var_30_3], arg_29_0.storyBar, true)
			onButton(arg_29_0, arg_29_0.storyBar, function()
				arg_29_0:PlayStory(arg_30_1:GetStory(), function()
					arg_29_0:UpdateView()

					return
				end)

				return
			end)

			var_29_3 = true
		end

		local var_30_4 = arg_30_1:GetActiveLink()

		;(function()
			if var_30_4 == 0 or not var_30_2 then
				return
			end

			local var_33_0 = arg_29_0.nodes[arg_29_0.storyNodesDict[var_30_4]:GetIconName()].trans
			local var_33_1 = arg_29_0.plural:Dequeue()

			table.insert(arg_29_0.links, go(var_33_1))
			setActive(var_33_1, true)
			setParent(var_33_1, arg_29_0.linksContainer)

			local var_33_2 = arg_29_0.linksContainer:InverseTransformPoint(var_30_0.position)
			local var_33_3 = arg_29_0.linksContainer:InverseTransformPoint(var_33_0.position) - var_33_2

			tf(var_33_1).sizeDelta = Vector2(Vector2.Magnitude(var_33_3), 2)
			tf(var_33_1).anchoredPosition = var_33_2
			tf(var_33_1).localRotation = Quaternion.FromToRotation(Vector3.right, var_33_3)

			return
		end)()
		_.each(arg_30_1:GetTriggers(), function(arg_34_0)
			if arg_34_0.type == BossRushStoryNode.TRIGGER_TYPE.PT_GOT then
				if var_30_1 then
					var_29_2 = var_29_2 and math.max(arg_34_0.value, var_29_2) or arg_34_0.value
				else
					var_29_1 = var_29_1 and math.min(arg_34_0.value, var_29_1) or arg_34_0.value
				end
			end

			return
		end)

		return
	end)
	setText(arg_29_0._tf:Find("Story/PassLevel/PT/Text"), arg_29_0.ptActivity.data1 .. "/" .. (nil or nil or ""))
	setText(arg_29_0._tf:Find("Story/PassLevel/Values"):GetChild(0), 0)
	setText(arg_29_0._tf:Find("Story/PassLevel/Values"):GetChild(2), 0)
	setActive(arg_29_0.storyBar, false)
	setActive(arg_29_0.storyAward, tobool(arg_29_0.storyTask))

	if arg_29_0.storyTask then
		local var_29_4 = arg_29_0.storyTask:getConfig("award_display")

		updateDrop(arg_29_0.storyAward:Find("Mask"):GetChild(0), {
			type = var_29_4[1][1],
			id = var_29_4[1][2],
			count = var_29_4[1][3]
		})
		onButton(arg_29_0, arg_29_0.storyAward:Find("Mask"):GetChild(0), function()
			arg_29_0:emit(BaseUI.ON_DROP, var_0)

			return
		end)

		local var_29_5 = arg_29_0.storyTask:getTaskStatus()

		setActive(arg_29_0.storyAward:Find("Got"), var_29_5 == 2)

		if var_29_5 == 1 then
			arg_29_0:emit(BossRushKurskMediator.ON_TASK_SUBMIT, arg_29_0.storyTask)
		end
	end

	setActive(arg_29_0._tf:Find("Battle/Story/New"), false)

	return
end

function var_0_0.ReturnLinks(arg_36_0, arg_36_1)
	for iter_36_0, iter_36_1 in ipairs(arg_36_0.links) do
		if not arg_36_0.plural:Enqueue(iter_36_1, arg_36_1) then
			setParent(iter_36_1, arg_36_0.pluralRoot)
		end
	end

	table.clean(arg_36_0.links)

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
				arg_37_0:emit(BossRushKurskMediator.ON_PERFORM_COMBAT, var_38_0)
			else
				var_37_0:Play(arg_37_1, arg_38_0)
			end

			return
		end,
		function(arg_39_0, ...)
			existCall(arg_37_2, ...)

			return
		end
	})

	return
end

function var_0_0.UpdateTasks(arg_40_0, arg_40_1)
	if _.any(arg_40_1, function(arg_41_0)
		return arg_40_0.storyTask and arg_40_0.storyTask.id == arg_41_0
	end) then
		arg_40_0.storyTask.submitTime = 1

		arg_40_0:UpdateView()
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
	arg_48_0:ReturnLinks(true)
	arg_48_0.loader:Clear()
	var_0_0.super.willExit(arg_48_0)

	return
end

return var_0_0
