pg = pg or {}

local var_0_0 = singletonClass("NewStoryMgr")

pg.NewStoryMgr = var_0_0

local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4
local var_0_5 = 5
local var_0_6 = 6
local var_0_7 = 7
local var_0_8 = Color.New(1, 0.8705, 0.4196, 1)
local var_0_9 = Color.New(1, 1, 1, 1)

require("Mgr/Story/Include")

local var_0_10 = true

local function var_0_11(...)
	if var_0_10 and IsUnityEditor then
		originalPrint(...)
	end

	return
end

local var_0_12 = {
	"",
	"JP",
	"KR",
	"US",
	""
}

local function var_0_13(arg_2_0)
	if arg_2_0 == "index" then
		arg_2_0 = arg_2_0 .. var_0_12[PLATFORM_CODE]
	end

	local var_2_0 = PLATFORM_CODE == PLATFORM_JP and "GameCfg.story" .. var_0_12[PLATFORM_CODE] .. "." .. arg_2_0 or "GameCfg.story" .. "." .. arg_2_0
	local var_2_1, var_2_2 = pcall(function()
		return require(var_2_0)
	end)

	if not var_2_1 then
		local var_2_3 = true

		if UnGamePlayState then
			local var_2_4 = "GameCfg.dungeon." .. arg_2_0

			if pcall(function()
				return require(var_2_4)
			end) then
				var_2_3 = false
			end
		end

		if var_2_3 then
			errorMsg("不存在剧情ID对应的Lua:" .. arg_2_0)
		end
	end

	return var_2_1 and var_2_2
end

function var_0_0.GetScript(arg_5_0, arg_5_1)
	return var_0_13(arg_5_1)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.playedList = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		local var_6_0 = iter_6_1

		if iter_6_1 == 20008 then
			var_6_0 = 1131
		end

		if iter_6_1 == 20009 then
			var_6_0 = 1132
		end

		if iter_6_1 == 20010 then
			var_6_0 = 1133
		end

		if iter_6_1 == 20011 then
			var_6_0 = 1134
		end

		if iter_6_1 == 20012 then
			var_6_0 = 1135
		end

		if iter_6_1 == 20013 then
			var_6_0 = 1136
		end

		if iter_6_1 == 20014 then
			var_6_0 = 1137
		end

		arg_6_0.playedList[var_6_0] = true
	end

	return
end

function var_0_0.SetPlayedFlag(arg_7_0, arg_7_1)
	var_0_11("Update story id", arg_7_1)

	arg_7_0.playedList[arg_7_1] = true

	return
end

function var_0_0.SetPlayedFlagList(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		arg_8_0.playedList[iter_8_1] = true
	end

	return
end

function var_0_0.GetPlayedFlag(arg_9_0, arg_9_1)
	return arg_9_0.playedList[arg_9_1]
end

function var_0_0.GetPlayedList(arg_10_0)
	return arg_10_0.playedList
end

function var_0_0.IsPlayed(arg_11_0, arg_11_1, arg_11_2)
	if type(arg_11_1) ~= "table" then
		arg_11_1 = {
			arg_11_1
		}
	end

	return underscore.any(arg_11_1, function(arg_12_0)
		local var_12_0, var_12_1 = arg_11_0:StoryName2StoryId(arg_12_0)
		local var_12_2 = true

		if var_12_1 and not arg_11_2 then
			var_12_2 = arg_11_0:GetPlayedFlag(var_12_1)
		end

		return arg_11_0:GetPlayedFlag(var_12_0) and var_12_2
	end)
end

local function var_0_14(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0) do
		({})[iter_13_1] = iter_13_0
	end

	return {}
end

function var_0_0.StoryName2StoryId(arg_14_0, arg_14_1)
	var_0_0.indexs = var_0_0.indexs or var_0_14(var_0_13("index"))
	var_0_0.againIndexs = var_0_0.againIndexs or var_0_14(var_0_13("index_again"))

	return var_0_0.indexs[arg_14_1], var_0_0.againIndexs[arg_14_1]
end

function var_0_0.StoryId2StoryName(arg_15_0, arg_15_1)
	var_0_0.indexIds = var_0_0.indexIds or var_0_13("index")
	var_0_0.againIndexIds = var_0_0.againIndexIds or var_0_13("index_again")

	return var_0_0.indexIds[arg_15_1], var_0_0.againIndexIds[arg_15_1]
end

function var_0_0.StoryLinkNames(arg_16_0, arg_16_1)
	var_0_0.linkNames = var_0_0.linkNames or var_0_13("index_link")

	return var_0_0.linkNames[arg_16_1]
end

function var_0_0._GetStoryPaintingsByName(arg_17_0, arg_17_1)
	return arg_17_1:GetUsingPaintingNames()
end

function var_0_0.GetStoryPaintingsByName(arg_18_0, arg_18_1)
	local var_18_0 = var_0_13(arg_18_1)

	if not var_18_0 then
		var_0_11("not exist story file")

		return {}
	end

	return arg_18_0:_GetStoryPaintingsByName((Story.New(var_18_0, false)))
end

function var_0_0.GetStoryPaintingsByNameList(arg_19_0, arg_19_1)
	for iter_19_0, iter_19_1 in ipairs(arg_19_1) do
		for iter_19_2, iter_19_3 in ipairs(arg_19_0:GetStoryPaintingsByName(iter_19_1)) do
			({})[iter_19_3] = true
		end
	end

	for iter_19_4, iter_19_5 in pairs({}) do
		table.insert({}, iter_19_4)
	end

	return {}
end

function var_0_0.GetStoryPaintingsById(arg_20_0, arg_20_1)
	return arg_20_0:GetStoryPaintingsByIdList({
		arg_20_1
	})
end

function var_0_0.GetStoryPaintingsByIdList(arg_21_0, arg_21_1)
	return arg_21_0:GetStoryPaintingsByNameList((_.map(arg_21_1, function(arg_22_0)
		return arg_21_0:StoryId2StoryName(arg_22_0)
	end)))
end

function var_0_0.ShouldDownloadRes(arg_23_0, arg_23_1)
	return _.any(arg_23_0:GetStoryPaintingsByName(arg_23_1), function(arg_24_0)
		return PaintingGroupConst.VerifyPaintingFileName(arg_24_0)
	end)
end

function var_0_0.Init(arg_25_0, arg_25_1)
	arg_25_0.state = var_0_1

	LoadAndInstantiateAsync("ui", "NewStoryUI", function(arg_26_0)
		arg_25_0.UIOverlay = GameObject.Find("Overlay/UIOverlay")

		arg_26_0.transform:SetParent(arg_25_0.UIOverlay.transform, false)
		arg_25_0:_Init(arg_26_0, arg_25_1)

		return
	end, true, true)

	return
end

function var_0_0._Init(arg_27_0, arg_27_1, arg_27_2)
	arg_27_0.playedList = {}
	arg_27_0.playQueue = {}
	arg_27_0._go = arg_27_1
	arg_27_0._tf = tf(arg_27_0._go)
	arg_27_0.frontTr = findTF(arg_27_0._tf, "front")
	arg_27_0.frontEvtTr = findTF(arg_27_0._tf, "block")
	arg_27_0.skipBtn = findTF(arg_27_0._tf, "front/btns/btns/skip_button")
	arg_27_0.autoBtn = findTF(arg_27_0._tf, "front/btns/btns/auto_button")
	arg_27_0.autoBtnImg = findTF(arg_27_0._tf, "front/btns/btns/auto_button/sel"):GetComponent(typeof(Image))
	arg_27_0.alphaImage = arg_27_0._tf:GetComponent(typeof(Image))
	arg_27_0.mainImage = arg_27_0._tf:GetComponent(typeof(Image))
	arg_27_0.recordBtn = findTF(arg_27_0._tf, "front/btns/record")
	arg_27_0.hideUIBtn = findTF(arg_27_0._tf, "front/btns/btns/hide_ui_button")
	arg_27_0.dialogueContainer = findTF(arg_27_0._tf, "front/dialogue")
	arg_27_0.players = {
		AsideStoryPlayer.New(arg_27_1),
		DialogueStoryPlayer.New(arg_27_1),
		BgStoryPlayer.New(arg_27_1),
		CarouselPlayer.New(arg_27_1),
		VedioStoryPlayer.New(arg_27_1),
		CastStoryPlayer.New(arg_27_1),
		SpAnimStoryPlayer.New(arg_27_1),
		BlinkStoryPlayer.New(arg_27_1),
		DialogueStoryPlayer.New(arg_27_1),
		SubPageStoryPlayer.New(arg_27_1)
	}
	arg_27_0.setSpeedPanel = StorySetSpeedPanel.New(arg_27_0._tf, function(arg_28_0)
		arg_27_0:UpdatePlaySpeed(arg_28_0)

		return
	end)
	arg_27_0.recordPanel = NewStoryRecordPanel.New()
	arg_27_0.recorder = StoryRecorder.New()

	setActive(arg_27_0._go, false)

	arg_27_0.state = var_0_2

	if arg_27_2 then
		arg_27_2()
	end

	return
end

function var_0_0.GetPlayer(arg_29_0, arg_29_1)
	for iter_29_0, iter_29_1 in ipairs(arg_29_0.players) do
		if isa(iter_29_1, arg_29_1) then
			return iter_29_1
		end
	end

	return nil
end

function var_0_0.Play(arg_30_0, arg_30_1, arg_30_2, arg_30_3, arg_30_4, arg_30_5, arg_30_6, arg_30_7)
	table.insert(arg_30_0.playQueue, {
		arg_30_1,
		arg_30_2,
		arg_30_7
	})

	if #arg_30_0.playQueue == 1 then
		(function()
			local var_31_0

			if #arg_30_0.playQueue == 0 then
				do return end

				var_31_0 = arg_30_0.playQueue[1][2]
			end

			arg_30_0:SoloPlay(arg_30_0.playQueue[1][1], function(arg_32_0, arg_32_1)
				if var_31_0 then
					var_31_0(arg_32_0, arg_32_1)
				end

				table.remove(arg_30_0.playQueue, 1)
				var_0()

				return
			end, arg_30_3, arg_30_4, arg_30_5, arg_30_6, arg_30_0.playQueue[1][3])

			return
		end)()
	end

	return
end

function var_0_0.Pause(arg_33_0)
	if arg_33_0.state ~= var_0_3 then
		var_0_11("state is not 'running'")

		return
	end

	arg_33_0.state = var_0_4

	for iter_33_0, iter_33_1 in ipairs(arg_33_0.players) do
		iter_33_1:Pause()
	end

	return
end

function var_0_0.Resume(arg_34_0)
	if arg_34_0.state ~= var_0_4 then
		var_0_11("state is not 'pause'")

		return
	end

	arg_34_0.state = var_0_3

	for iter_34_0, iter_34_1 in ipairs(arg_34_0.players) do
		iter_34_1:Resume()
	end

	return
end

function var_0_0.Stop(arg_35_0)
	if arg_35_0.state ~= var_0_3 then
		var_0_11("state is not 'running'")

		return
	end

	if arg_35_0.currPlayer and arg_35_0.currPlayer:WaitForEvent() then
		return
	end

	arg_35_0.state = var_0_5

	for iter_35_0, iter_35_1 in ipairs(arg_35_0.players) do
		iter_35_1:Stop()
	end

	return
end

function var_0_0.PlayForAcivitySpStory(arg_36_0, arg_36_1, arg_36_2, arg_36_3, arg_36_4, arg_36_5, arg_36_6, arg_36_7)
	arg_36_0:Play(arg_36_1, function()
		_.each(arg_36_0.branchSelectCache, function(arg_38_0)
			local var_38_0 = ActivitySpStoryNode.GetOptionBranchByStoryName(arg_36_1, arg_38_0)

			if var_38_0 then
				arg_36_0:SendNotification(GAME.STORY_UPDATE, {
					storyId = var_0_13(var_38_0.story).id
				})
			end

			return
		end)

		arg_36_0.branchSelectCache = nil

		arg_36_2()

		return
	end, arg_36_3, arg_36_4, arg_36_5, arg_36_6, arg_36_7)

	return
end

function var_0_0.PlayForTb(arg_39_0, arg_39_1, arg_39_2, arg_39_3, arg_39_4)
	arg_39_0:Play(arg_39_1, arg_39_3, arg_39_4, false, false, true, arg_39_2)

	return
end

function var_0_0.PlayForWorld(arg_40_0, arg_40_1, arg_40_2, arg_40_3, arg_40_4, arg_40_5, arg_40_6, arg_40_7, arg_40_8)
	arg_40_0.optionSelCodes = arg_40_2 or {}
	arg_40_0.autoPlayFlag = arg_40_6

	arg_40_0:Play(arg_40_1, arg_40_3, arg_40_4, arg_40_5, arg_40_7, true, arg_40_8)

	return
end

function var_0_0.ForceAutoPlay(arg_41_0, arg_41_1, arg_41_2, arg_41_3, arg_41_4, arg_41_5)
	arg_41_0.autoPlayFlag = true

	arg_41_0:Play(arg_41_1, function(arg_42_0, arg_42_1)
		arg_41_2(arg_42_0, arg_42_1, arg_41_0.isAutoPlay)

		return
	end, arg_41_3, arg_41_4, true, false, arg_41_5)

	return
end

function var_0_0.ForceManualPlay(arg_43_0, arg_43_1, arg_43_2, arg_43_3, arg_43_4, arg_43_5)
	arg_43_0.banPlayFlag = true

	arg_43_0:Play(arg_43_1, function(arg_44_0, arg_44_1)
		arg_43_2(arg_44_0, arg_44_1, arg_43_0.isAutoPlay)

		return
	end, arg_43_3, arg_43_4, true, false, arg_43_5)

	return
end

function var_0_0.ReViewPlay(arg_45_0, ...)
	arg_45_0.isReView = true

	arg_45_0:Play(...)

	return
end

function var_0_0.SeriesPlay(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4, arg_46_5, arg_46_6, arg_46_7)
	for iter_46_0, iter_46_1 in ipairs(arg_46_1) do
		table.insert({}, function(arg_47_0)
			arg_46_0:SoloPlay(iter_46_1, arg_47_0, arg_46_3, arg_46_4, arg_46_5, arg_46_6, arg_46_7)

			return
		end)
	end

	seriesAsync({}, arg_46_2)

	return
end

function var_0_0.SoloPlay(arg_48_0, arg_48_1, arg_48_2, arg_48_3, arg_48_4, arg_48_5, arg_48_6, arg_48_7)
	var_0_11("Play Story:", arg_48_1)

	local var_48_0 = 1
	local var_48_1 = var_0_13(arg_48_1)

	if not var_48_1 then
		(function(arg_49_0, arg_49_1)
			var_48_0 = var_48_0 - 1

			if arg_48_2 and var_48_0 == 0 then
				onNextTick(function()
					arg_48_2(arg_49_0, arg_49_1)

					return
				end)
			end

			return
		end)(false)
		var_0_11("not exist story file")

		return nil
	end

	if arg_48_0:IsReView() then
		arg_48_3 = true
	end

	arg_48_0.storyScript = Story.New(var_48_1, arg_48_3, arg_48_0.optionSelCodes, arg_48_5, arg_48_6, arg_48_7)

	if not arg_48_0:CheckState() then
		var_0_11("story state error")
		;(function(arg_49_0, arg_49_1)
			var_48_0 = var_48_0 - 1

			if arg_48_2 and var_48_0 == 0 then
				onNextTick(function()
					arg_48_2(arg_49_0, arg_49_1)

					return
				end)
			end

			return
		end)(false)

		return nil
	end

	if not arg_48_0.storyScript:CanPlay() then
		var_0_11("story cant be played")
		;(function(arg_49_0, arg_49_1)
			var_48_0 = var_48_0 - 1

			if arg_48_2 and var_48_0 == 0 then
				onNextTick(function()
					arg_48_2(arg_49_0, arg_49_1)

					return
				end)
			end

			return
		end)(false)

		return nil
	end

	arg_48_0:ExecuteScript(function(arg_49_0, arg_49_1)
		var_48_0 = var_48_0 - 1

		if arg_48_2 and var_48_0 == 0 then
			onNextTick(function()
				arg_48_2(arg_49_0, arg_49_1)

				return
			end)
		end

		return
	end)

	return
end

function var_0_0.ExecuteScript(arg_51_0, arg_51_1)
	seriesAsync({
		function(arg_52_0)
			arg_51_0:CheckResDownload(arg_51_0.storyScript, arg_52_0)

			return
		end,
		function(arg_53_0)
			originalPrint("start load story window...")
			arg_51_0:CheckAndLoadDialogue(arg_51_0.storyScript, arg_53_0)

			return
		end
	}, function()
		originalPrint("enter story...")
		arg_51_0:OnStart()

		arg_51_0.currPlayer = nil
		arg_51_0.progress = 0

		for iter_54_0, iter_54_1 in ipairs(arg_51_0.storyScript.steps) do
			table.insert({}, function(arg_55_0)
				arg_51_0.progress = iter_54_0

				arg_51_0:SendNotification(GAME.STORY_NEXT)

				local var_55_0 = arg_51_0.players[iter_54_1:GetMode()]

				arg_51_0.currPlayer = var_55_0

				var_55_0:Play(arg_51_0.storyScript, iter_54_0, arg_55_0)

				return
			end)
		end

		seriesAsync({}, function()
			arg_51_0:OnEnd(arg_51_1)

			return
		end)

		return
	end)

	return
end

function var_0_0.SendNotification(arg_57_0, arg_57_1, arg_57_2)
	pg.m02:sendNotification(arg_57_1, arg_57_2)

	return
end

function var_0_0.CheckResDownload(arg_58_0, arg_58_1, arg_58_2)
	SplitPackConst.DownloadByLuaArr(arg_58_0:_GetResList(arg_58_1), arg_58_2)

	return
end

local function var_0_15(arg_59_0, arg_59_1)
	ResourceMgr.Inst:getAssetAsync("ui/" .. arg_59_0, "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_60_0)
		arg_59_1(arg_60_0)

		return
	end), true, true)

	return
end

function var_0_0.CheckAndLoadDialogue(arg_61_0, arg_61_1, arg_61_2)
	local var_61_0 = arg_61_1:GetDialogueStyleName()

	if not arg_61_0.dialogueContainer:Find(var_61_0) then
		var_0_15("NewStoryDialogue" .. var_61_0, function(arg_62_0)
			Object.Instantiate(arg_62_0, arg_61_0.dialogueContainer).name = var_61_0

			arg_61_2()

			return
		end)
	else
		arg_61_2()
	end

	return
end

function var_0_0.CheckState(arg_63_0)
	if arg_63_0.state == var_0_3 or arg_63_0.state == var_0_1 or arg_63_0.state == var_0_4 then
		return false
	end

	return true
end

function var_0_0.RegistSkipBtn(arg_64_0)
	local function var_64_0()
		arg_64_0:TrackingSkip()
		arg_64_0.storyScript:SkipAll()
		arg_64_0.currPlayer:NextOneImmediately()

		return
	end

	onButton(arg_64_0, arg_64_0.skipBtn, function()
		if arg_64_0:IsStopping() or arg_64_0:IsPausing() then
			return
		end

		if not arg_64_0.currPlayer:CanSkip() then
			return
		end

		if arg_64_0:IsReView() or arg_64_0.storyScript:IsPlayed() or not arg_64_0.storyScript:ShowSkipTip() then
			var_64_0()

			return
		end

		arg_64_0:Pause()

		arg_64_0.isOpenMsgbox = true

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			parent = rtf(arg_64_0._tf:Find("front")),
			content = i18n("story_skip_confirm"),
			onYes = function()
				arg_64_0:Resume()
				var_64_0()

				return
			end,
			onNo = function()
				arg_64_0.isOpenMsgbox = false

				arg_64_0:Resume()

				return
			end
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.RegistAutoBtn(arg_69_0)
	onButton(arg_69_0, arg_69_0.autoBtn, function()
		if arg_69_0:IsStopping() or arg_69_0:IsPausing() then
			return
		end

		if arg_69_0.storyScript:GetAutoPlayFlag() then
			arg_69_0.storyScript:StopAutoPlay()
			arg_69_0.currPlayer:CancelAuto()
		else
			arg_69_0.storyScript:SetAutoPlay()
			arg_69_0.currPlayer:NextOne()
		end

		if arg_69_0.storyScript then
			arg_69_0:UpdateAutoBtn()
		end

		return
	end, SFX_PANEL)

	local var_69_0 = arg_69_0:IsAutoPlay()

	if var_69_0 then
		arg_69_0.storyScript:SetAutoPlay()
		arg_69_0:UpdateAutoBtn()

		arg_69_0.autoPlayFlag = false
	end

	arg_69_0.banPlayFlag = false
	arg_69_0.isAutoPlay = var_69_0

	return
end

function var_0_0.RegistRecordBtn(arg_71_0)
	onButton(arg_71_0, arg_71_0.recordBtn, function()
		if arg_71_0.storyScript:GetAutoPlayFlag() then
			return
		end

		if not arg_71_0.recordPanel:CanOpen() then
			return
		end

		arg_71_0.recordPanel:Show(arg_71_0.recorder)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.TriggerAutoBtn(arg_73_0)
	if not arg_73_0:IsRunning() then
		return
	end

	triggerButton(arg_73_0.autoBtn)

	return
end

function var_0_0.TriggerSkipBtn(arg_74_0)
	if not arg_74_0:IsRunning() then
		return
	end

	triggerButton(arg_74_0.skipBtn)

	return
end

function var_0_0.ForEscPress(arg_75_0)
	if arg_75_0.recordPanel:IsShowing() then
		arg_75_0.recordPanel:Hide()
	elseif arg_75_0.currPlayer and arg_75_0.currPlayer:WaitForEvent() or arg_75_0.currPlayer and arg_75_0.storyScript and arg_75_0.storyScript.hideSkip then
		-- block empty
	else
		arg_75_0:TriggerSkipBtn()
	end

	return
end

function var_0_0.UpdatePlaySpeed(arg_76_0, arg_76_1)
	if arg_76_0:IsRunning() and arg_76_0.storyScript then
		arg_76_0.storyScript:SetPlaySpeed(arg_76_1)
	end

	return
end

function var_0_0.GetPlaySpeed(arg_77_0)
	if arg_77_0:IsRunning() and arg_77_0.storyScript then
		return arg_77_0.storyScript:GetPlaySpeed()
	end

	return
end

function var_0_0.OnStart(arg_78_0)
	arg_78_0.recorder:Clear()
	removeOnButton(arg_78_0._go)
	removeOnButton(arg_78_0.skipBtn)
	removeOnButton(arg_78_0.autoBtn)
	removeOnButton(arg_78_0.recordBtn)

	arg_78_0.mainImage.color = Color(0, 0, 0, arg_78_0.storyScript:GetStoryAlpha())

	setActive(arg_78_0.recordBtn, not arg_78_0.storyScript:ShouldHideRecord())
	arg_78_0:ClearStoryEventTriggerListener()

	local var_78_0 = arg_78_0.storyScript:GetAllStepDispatcherRecallName()

	if #var_78_0 > 0 then
		arg_78_0.storyEventTriggerListener = StoryEventTriggerListener.New(var_78_0)
	end

	arg_78_0.mainImage.enabled = not arg_78_0.storyScript:CanInteraction()
	arg_78_0.state = var_0_3

	arg_78_0:TrackingStart()
	arg_78_0:SendNotification(GAME.STORY_BEGIN, arg_78_0.storyScript:GetName())

	if not arg_78_0:IsReView() then
		arg_78_0:SendNotification(GAME.STORY_UPDATE, {
			storyId = arg_78_0.storyScript:GetName()
		})
	end

	pg.DelegateInfo.New(arg_78_0)

	for iter_78_0, iter_78_1 in ipairs(arg_78_0.players) do
		iter_78_1:StoryStart(arg_78_0.storyScript)
	end

	setActive(arg_78_0._go, true)
	arg_78_0._tf:SetAsLastSibling()
	setActive(arg_78_0.skipBtn, not arg_78_0.storyScript:ShouldHideSkip())
	setActive(arg_78_0.autoBtn, not arg_78_0.storyScript:ShouldHideAutoBtn())

	arg_78_0.bgmVolumeValue = pg.CriMgr.GetInstance():getBGMVolume()

	arg_78_0:RegistSkipBtn()
	arg_78_0:RegistAutoBtn()
	arg_78_0:RegistRecordBtn()
	arg_78_0:RegistHideUIBtn()

	return
end

function var_0_0.RegistHideUIBtn(arg_79_0)
	onButton(arg_79_0, arg_79_0.hideUIBtn, function()
		if arg_79_0.storyScript:GetAutoPlayFlag() then
			arg_79_0.storyScript:StopAutoPlay()
			arg_79_0.currPlayer:CancelAuto()
			arg_79_0:UpdateAutoBtn()
		end

		setActiveByCanvasGroup(arg_79_0.frontTr, false)
		setActive(arg_79_0.frontEvtTr, true)

		return
	end, SFX_PANEL)
	onButton(arg_79_0, arg_79_0.frontEvtTr, function()
		setActiveByCanvasGroup(arg_79_0.frontTr, true)
		setActive(arg_79_0.frontEvtTr, false)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.TrackingStart(arg_82_0)
	if getProxy(PlayerProxy) then
		if not getProxy(PlayerProxy):getRawData() then
			return
		end

		arg_82_0.trackFlag = false

		if not arg_82_0.storyScript then
			return
		end

		local var_82_0 = arg_82_0:StoryName2StoryId(arg_82_0.storyScript:GetName())

		if var_82_0 and not arg_82_0:GetPlayedFlag(var_82_0) then
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildStoryStart(var_82_0, 0))

			arg_82_0.trackFlag = true
		end

		return
	end
end

function var_0_0.TrackingSkip(arg_83_0)
	if not arg_83_0.trackFlag or not arg_83_0.storyScript then
		return
	end

	local var_83_0 = arg_83_0:StoryName2StoryId(arg_83_0.storyScript:GetName())

	if var_83_0 then
		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildStorySkip(var_83_0, var_83_1))
	end

	return
end

function var_0_0.TrackingOption(arg_84_0, arg_84_1, arg_84_2)
	if not arg_84_0.storyScript or not arg_84_1 or not arg_84_2 then
		return
	end

	local var_84_0 = arg_84_0:StoryName2StoryId(arg_84_0.storyScript:GetName())

	if var_84_0 then
		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildStoryOption(var_84_0, arg_84_1 .. "_" .. (arg_84_2 or 0)))
	end

	return
end

function var_0_0.ClearStoryEvent(arg_85_0)
	if arg_85_0.storyEventTriggerListener then
		arg_85_0.storyEventTriggerListener:Clear()
	end

	return
end

function var_0_0.CheckStoryEvent(arg_86_0, arg_86_1)
	if arg_86_0.storyEventTriggerListener then
		return arg_86_0.storyEventTriggerListener:ExistCache(arg_86_1)
	end

	return false
end

function var_0_0.GetStoryEventArg(arg_87_0, arg_87_1)
	if not arg_87_0:CheckStoryEvent(arg_87_1) then
		return nil
	end

	if arg_87_0.storyEventTriggerListener and arg_87_0.storyEventTriggerListener:ExistArg(arg_87_1) then
		return arg_87_0.storyEventTriggerListener:GetArg(arg_87_1)
	end

	return nil
end

function var_0_0.UpdateAutoBtn(arg_88_0)
	arg_88_0:ClearAutoBtn((arg_88_0.storyScript:GetAutoPlayFlag()))

	return
end

function var_0_0.ClearAutoBtn(arg_89_0, arg_89_1)
	if arg_89_1 then
		arg_89_0.autoBtnImg.color = var_0_8 or var_0_9
		arg_89_0.isAutoPlay = arg_89_1

		arg_89_0.setSpeedPanel[arg_89_1 and "Show" or "Hide"](arg_89_0.setSpeedPanel, arg_89_0.storyScript)

		return
	end
end

function var_0_0.ClearStoryEventTriggerListener(arg_90_0)
	if arg_90_0.storyEventTriggerListener then
		arg_90_0.storyEventTriggerListener:Dispose()

		arg_90_0.storyEventTriggerListener = nil
	end

	return
end

function var_0_0.Clear(arg_91_0)
	arg_91_0.progress = 0

	arg_91_0:ClearStoryEventTriggerListener()

	arg_91_0.mainImage.enabled = true

	arg_91_0.recorder:Clear()
	arg_91_0.recordPanel:Hide()

	arg_91_0.autoPlayFlag = false
	arg_91_0.banPlayFlag = false
	arg_91_0.isReView = false

	removeOnButton(arg_91_0._go)
	removeOnButton(arg_91_0.skipBtn)
	removeOnButton(arg_91_0.recordBtn)
	removeOnButton(arg_91_0.autoBtn)
	removeOnButton(arg_91_0.hideUIBtn)
	removeOnButton(arg_91_0.frontEvtTr)
	arg_91_0:ClearAutoBtn(false)

	if isActive(arg_91_0._go) then
		pg.DelegateInfo.Dispose(arg_91_0)
	end

	if arg_91_0.setSpeedPanel then
		arg_91_0.setSpeedPanel:Clear()
	end

	setActive(arg_91_0.skipBtn, false)
	setActive(arg_91_0._go, false)

	arg_91_0.branchSelectCache = {}

	_.each(arg_91_0.players, function(arg_92_0)
		for iter_92_0, iter_92_1 in pairs(arg_92_0.branchCodeList) do
			_.each(iter_92_1, function(arg_93_0)
				table.insert(arg_91_0.branchSelectCache, arg_93_0)

				return
			end)
		end

		return
	end)

	for iter_91_0, iter_91_1 in ipairs(arg_91_0.players) do
		iter_91_1:StoryEnd(arg_91_0.storyScript)
	end

	arg_91_0.optionSelCodes = nil

	arg_91_0:SendNotification(GAME.STORY_END)

	if arg_91_0.isOpenMsgbox then
		pg.MsgboxMgr.GetInstance():hide()
	end

	arg_91_0:RevertBgmVolumeValue()

	return
end

function var_0_0.RevertBgmVolumeValue(arg_94_0)
	pg.BgmMgr.GetInstance():ContinuePlay()

	if arg_94_0.bgmVolumeValue and arg_94_0.bgmVolumeValue ~= pg.CriMgr.GetInstance():getBGMVolume() then
		pg.CriMgr.GetInstance():setBGMVolume(arg_94_0.bgmVolumeValue)
	end

	arg_94_0.bgmVolumeValue = nil

	return
end

function var_0_0.OnEnd(arg_95_0, arg_95_1)
	arg_95_0:Clear()

	if arg_95_0.state == var_0_3 or arg_95_0.state == var_0_5 then
		arg_95_0.state = var_0_6

		local var_95_0 = arg_95_0.storyScript:GetNextScriptName()

		if var_95_0 and not arg_95_0:IsReView() then
			arg_95_0.storyScript = nil

			arg_95_0:SoloPlay(var_95_0, arg_95_1, true)
		else
			local var_95_1 = arg_95_0.storyScript:GetBranchCode()

			arg_95_0.storyScript = nil

			if arg_95_1 then
				arg_95_1(true, var_95_1)
			end
		end
	else
		arg_95_0.state = var_0_6

		if arg_95_1 then
			arg_95_1(true, (arg_95_0.storyScript:GetBranchCode()))
		end
	end

	return
end

function var_0_0.OnSceneEnter(arg_96_0, arg_96_1)
	arg_96_0.scenes = arg_96_0.scenes or {}
	arg_96_0.scenes[arg_96_1.view] = true

	return
end

function var_0_0.OnSceneExit(arg_97_0, arg_97_1)
	if not arg_97_0.scenes then
		return
	end

	arg_97_0.scenes[arg_97_1.view] = nil

	return
end

function var_0_0.IsReView(arg_98_0)
	return tobool(arg_98_0.isReView)
end

function var_0_0.IsRunning(arg_99_0)
	return arg_99_0.state == var_0_3
end

function var_0_0.IsStopping(arg_100_0)
	return arg_100_0.state == var_0_5
end

function var_0_0.IsPausing(arg_101_0)
	return arg_101_0.state == var_0_4
end

function var_0_0.IsAutoPlay(arg_102_0)
	if arg_102_0.banPlayFlag then
		return false
	end

	local var_102_0 = getProxy(SettingsProxy):GetStoryAutoPlayFlag()

	var_102_0 = var_102_0 or arg_102_0.autoPlayFlag == true

	return var_102_0
end

function var_0_0.GetRectSize(arg_103_0)
	return Vector2(arg_103_0._tf.rect.width, arg_103_0._tf.rect.height)
end

function var_0_0.AddRecord(arg_104_0, arg_104_1)
	arg_104_0.recorder:Add(arg_104_1)

	return
end

function var_0_0.Quit(arg_105_0)
	arg_105_0.recorder:Dispose()
	arg_105_0.recordPanel:Dispose()
	arg_105_0.setSpeedPanel:Dispose()

	if arg_105_0.currPlayer and arg_105_0.currPlayer:WaitForEvent() then
		arg_105_0:Clear()
	end

	arg_105_0.state = var_0_7
	arg_105_0.storyScript = nil
	arg_105_0.currPlayer = nil
	arg_105_0.playQueue = {}
	arg_105_0.playedList = {}
	arg_105_0.scenes = {}

	return
end

function var_0_0.Fix(arg_106_0)
	local var_106_9000
	local var_106_0 = getProxy(PlayerProxy)
	local var_106_1, var_106_2

	if var_106_0.getRawData(var_106_9000):GetRegisterTime() <= pg.TimeMgr.GetInstance().parseTimeFromConfig(var_106_0, {
		{
			2021,
			4,
			8
		},
		{
			9,
			0,
			0
		}
	}) then
		_.each({
			10020,
			10021,
			10022,
			10023,
			10024,
			10025,
			10026,
			10027
		}, function(arg_107_0)
			arg_106_0.playedList[arg_107_0] = true

			return
		end)

		var_106_1 = getProxy(TaskProxy)
		var_106_2 = 0
	end

	for iter_106_0 = 5001, 5020, -1 do
		local var_106_3 = var_106_1:getFinishTaskById(iter_106_0) or var_106_1:getTaskById(iter_106_0)

		if var_106_3 then
			var_106_2 = iter_106_0

			break
		end
	end

	for iter_106_1 = var_106_2, 5020, -1 do
		if pg.task_data_template[iter_106_1] then
			if pg.task_data_template[iter_106_1].story_id and #pg.task_data_template[iter_106_1].story_id > 0 and not arg_106_0:IsPlayed(pg.task_data_template[iter_106_1].story_id) then
				arg_106_0.playedList[pg.task_data_template[iter_106_1].story_id] = true
			end
		end
	end

	local var_106_4 = getProxy(ActivityProxy):getActivityById(ActivityConst.JYHZ_ACTIVITY_ID)

	if var_106_4 and not var_106_4:isEnd() then
		local var_106_5 = _.flatten(var_106_4:getConfig("config_data"))

		for iter_106_2 = #var_106_5, 1, -1 do
			local var_106_7

			if pg.task_data_template[var_106_5[iter_106_2]].story_id and #pg.task_data_template[var_106_5[iter_106_2]].story_id > 0 then
				local var_106_6 = arg_106_0:IsPlayed(pg.task_data_template[var_106_5[iter_106_2]].story_id)

				if nil then
					if not var_106_6 then
						arg_106_0.playedList[pg.task_data_template[var_106_5[iter_106_2]].story_id] = true
					end
				elseif var_106_6 then
					var_106_7 = iter_106_2
				end
			end
		end
	end

	return
end

function var_0_0._GetResList(arg_108_0, arg_108_1)
	local var_108_0 = arg_108_0:_GetStoryPaintingsByName(arg_108_1)
	local var_108_1 = {}

	_.each(var_108_0, function(arg_109_0)
		PaintingGroupConst.AddPaintingNameWithFilteMap(var_108_1, arg_109_0)

		return
	end)

	local var_108_2 = {}

	_.each(var_108_0, function(arg_110_0)
		table.insert(var_108_2, "paintingface/" .. arg_110_0)

		return
	end)

	local var_108_3 = {}

	_.each(arg_108_1.steps, function(arg_111_0)
		_.each(arg_111_0:GetResList(), function(arg_112_0)
			table.insert(var_108_3, arg_112_0)

			return
		end)

		return
	end)

	local var_108_4 = SplitPackMediatorResMap.MergeLuaArr({}, {}, {})

	table.insert(var_108_4, "ui/newstoryui")
	table.insert(var_108_4, "ui/newstorydialogue" .. arg_108_1:GetDialogueStyleName())
	table.insert(var_108_4, "ui/newstoryrecordui")

	return var_108_4
end

return
