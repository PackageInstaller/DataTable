pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
singletonClass = pg

local var_0_1 = var_0("NewStoryMgr")

pg = var_0_10001
var_0_10001.NewStoryMgr = var_0_1

local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3
local var_0_5 = 4
local var_0_6 = 5
local var_0_7 = 6
local var_0_8 = 7

Color = var_0_10008

local var_0_9 = var_0_10008.New(1, 0.8705, 0.4196, 1)

Color = var_0_10009

local var_0_10 = var_0_10009.New(1, 1, 1, 1)

require = var_10

var_10("Mgr/Story/Include")

local var_0_11 = true

local function var_0_12(...)
	if var_0_11 then
		IsUnityEditor = var_0

		if var_0 then
			originalPrint = var_0

			var_0(...)
		end
	end

	return
end

local var_0_13 = {
	"",
	"JP",
	"KR",
	"US",
	""
}

local function var_0_14(arg_2_0)
	local var_2_0 = var_0_13

	PLATFORM_CODE = var_1_10002

	local var_2_1 = var_2_0[var_1_10002]

	if arg_2_0 == "index" then
		arg_2_0 = arg_2_0 .. var_2_1
	end

	local var_2_2

	PLATFORM_CODE = var_1_10003
	PLATFORM_JP = var_1_10004

	if var_1_10003 == var_1_10004 then
		var_2_2 = "GameCfg.story" .. var_2_1 .. "." .. arg_2_0
	else
		var_2_2 = "GameCfg.story" .. "." .. arg_2_0
	end

	pcall = var_1_10003

	local var_2_3, var_2_4 = var_1_10003(function()
		require = var_2_10000

		return var_2_10000(var_2_2)
	end)

	if not var_2_3 then
		local var_2_5 = true

		UnGamePlayState = var_1_10006

		if var_1_10006 then
			var_1_10006 = "GameCfg.dungeon." .. arg_2_0
			pcall = var_7

			if var_7(function()
				require = var_2_10000

				return var_2_10000(var_1_10006)
			end) then
				var_2_5 = false
			end
		end

		if var_2_5 then
			errorMsg = var_1_10006

			var_1_10006("不存在剧情ID对应的Lua:" .. arg_2_0)
		end
	end

	return var_2_3 and var_2_4
end

function var_0_1.GetScript(arg_5_0, arg_5_1)
	return var_0_14(arg_5_1)
end

function var_0_1.SetData(arg_6_0, arg_6_1)
	arg_6_0.playedList = {}
	ipairs = var_2

	for iter_6_0, iter_6_1 in var_2(arg_6_1) do
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

function var_0_1.SetPlayedFlag(arg_7_0, arg_7_1)
	var_0_12("Update story id", arg_7_1)

	arg_7_0.playedList[arg_7_1] = true

	return
end

function var_0_1.SetPlayedFlagList(arg_8_0, arg_8_1)
	ipairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(arg_8_1) do
		arg_8_0.playedList[iter_8_1] = true
	end

	return
end

function var_0_1.GetPlayedFlag(arg_9_0, arg_9_1)
	return arg_9_0.playedList[arg_9_1]
end

function var_0_1.GetPlayedList(arg_10_0)
	return arg_10_0.playedList
end

function var_0_1.IsPlayed(arg_11_0, arg_11_1, arg_11_2)
	type = var_1_10003

	if var_1_10003(arg_11_1) ~= "table" then
		arg_11_1 = {
			arg_11_1
		}
	end

	underscore = var_3

	return var_3.any(arg_11_1, function(arg_12_0)
		local var_12_0 = arg_11_0
		local var_12_1, var_12_2 = var_1.StoryName2StoryId(var_12_0, arg_12_0)
		local var_12_3 = arg_11_0
		local var_12_4 = var_3.GetPlayedFlag(var_12_3, var_12_1)
		local var_12_5 = true

		if var_12_2 and not arg_11_2 then
			local var_12_6 = arg_11_0

			var_12_5 = var_5.GetPlayedFlag(var_12_6, var_12_2)
		end

		return var_12_4 and var_12_5
	end)
end

local function var_0_15(arg_13_0)
	local var_13_0 = {}

	pairs = var_1_10002

	for iter_13_0, iter_13_1 in var_1_10002(arg_13_0) do
		var_13_0[iter_13_1] = iter_13_0
	end

	return var_13_0
end

function var_0_1.StoryName2StoryId(arg_14_0, arg_14_1)
	if not var_0_1.indexs then
		var_0_1.indexs = var_0_15(var_0_14("index"))
	end

	if not var_0_1.againIndexs then
		var_0_1.againIndexs = var_0_15(var_0_14("index_again"))
	end

	return var_0_1.indexs[arg_14_1], var_0_1.againIndexs[arg_14_1]
end

function var_0_1.StoryId2StoryName(arg_15_0, arg_15_1)
	if not var_0_1.indexIds then
		var_0_1.indexIds = var_0_14("index")
	end

	if not var_0_1.againIndexIds then
		var_0_1.againIndexIds = var_0_14("index_again")
	end

	return var_0_1.indexIds[arg_15_1], var_0_1.againIndexIds[arg_15_1]
end

function var_0_1.StoryLinkNames(arg_16_0, arg_16_1)
	if not var_0_1.linkNames then
		var_0_1.linkNames = var_0_14("index_link")
	end

	return var_0_1.linkNames[arg_16_1]
end

function var_0_1._GetStoryPaintingsByName(arg_17_0, arg_17_1)
	return arg_17_1:GetUsingPaintingNames()
end

function var_0_1.GetStoryPaintingsByName(arg_18_0, arg_18_1)
	if not var_0_14(arg_18_1) then
		var_0_12("not exist story file")

		return {}
	end

	Story = var_1_10003

	local var_18_0 = var_1_10003.New(var_2, false)

	return arg_18_0:_GetStoryPaintingsByName(var_18_0)
end

function var_0_1.GetStoryPaintingsByNameList(arg_19_0, arg_19_1)
	local var_19_0 = {}
	local var_19_1 = {}

	ipairs = var_1_10004

	for iter_19_0, iter_19_1 in var_1_10004(arg_19_1) do
		ipairs = var_1_10009

		for iter_19_2, iter_19_3 in var_1_10009(arg_19_0:GetStoryPaintingsByName(iter_19_1)) do
			var_19_1[iter_19_3] = true
		end
	end

	pairs = var_4

	for iter_19_4, iter_19_5 in var_4(var_19_1) do
		table = var_1_10009

		var_1_10009.insert(var_19_0, iter_19_4)
	end

	return var_19_0
end

function var_0_1.GetStoryPaintingsById(arg_20_0, arg_20_1)
	return arg_20_0:GetStoryPaintingsByIdList({
		arg_20_1
	})
end

function var_0_1.GetStoryPaintingsByIdList(arg_21_0, arg_21_1)
	_ = var_1_10002

	local var_21_0 = var_1_10002.map(arg_21_1, function(arg_22_0)
		local var_22_0 = arg_21_0

		return var_1.StoryId2StoryName(var_22_0, arg_22_0)
	end)

	return arg_21_0:GetStoryPaintingsByNameList(var_21_0)
end

function var_0_1.ShouldDownloadRes(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:GetStoryPaintingsByName(arg_23_1)

	_ = var_1_10003

	return var_1_10003.any(var_23_0, function(arg_24_0)
		PaintingGroupConst = var_2_10001

		return var_2_10001.VerifyPaintingFileName(arg_24_0)
	end)
end

function var_0_1.Init(arg_25_0, arg_25_1)
	arg_25_0.state = var_0_2
	LoadAndInstantiateAsync = var_2

	var_2("ui", "NewStoryUI", function(arg_26_0)
		local var_26_0 = arg_25_0

		GameObject = var_2_10002
		var_26_0.UIOverlay = var_2_10002.Find("Overlay/UIOverlay")

		local var_26_1 = arg_26_0.transform

		var_1.SetParent(var_26_1, arg_25_0.UIOverlay.transform, false)

		local var_26_2 = arg_25_0

		var_1._Init(var_26_2, arg_26_0, arg_25_1)

		return
	end, true, true)

	return
end

function var_0_1._Init(arg_27_0, arg_27_1, arg_27_2)
	arg_27_0.playedList = {}
	arg_27_0.playQueue = {}
	arg_27_0._go = arg_27_1
	tf = var_3
	arg_27_0._tf = var_3(arg_27_0._go)
	findTF = var_3
	arg_27_0.frontTr = var_3(arg_27_0._tf, "front")
	findTF = var_3
	arg_27_0.frontEvtTr = var_3(arg_27_0._tf, "block")
	findTF = var_3
	arg_27_0.skipBtn = var_3(arg_27_0._tf, "front/btns/btns/skip_button")
	findTF = var_3
	arg_27_0.autoBtn = var_3(arg_27_0._tf, "front/btns/btns/auto_button")
	findTF = var_3

	local var_27_0 = var_3(arg_27_0._tf, "front/btns/btns/auto_button/sel")
	local var_27_1 = var_3.GetComponent

	typeof = var_6
	Image = var_1_10008
	arg_27_0.autoBtnImg = var_27_1(var_27_0, var_6(var_1_10008))

	local var_27_2 = arg_27_0._tf
	local var_27_3 = var_3.GetComponent

	typeof = var_6
	Image = var_1_10008
	arg_27_0.alphaImage = var_27_3(var_27_2, var_6(var_1_10008))

	local var_27_4 = arg_27_0._tf
	local var_27_5 = var_3.GetComponent

	typeof = var_6
	Image = var_1_10008
	arg_27_0.mainImage = var_27_5(var_27_4, var_6(var_1_10008))
	findTF = var_3
	arg_27_0.recordBtn = var_3(arg_27_0._tf, "front/btns/record")
	findTF = var_3
	arg_27_0.hideUIBtn = var_3(arg_27_0._tf, "front/btns/btns/hide_ui_button")
	findTF = var_3
	arg_27_0.dialogueContainer = var_3(arg_27_0._tf, "front/dialogue")

	local var_27_6 = {}

	AsideStoryPlayer = var_1_10004
	var_27_6[1] = var_1_10004.New(arg_27_1)
	DialogueStoryPlayer = var_4
	var_27_6[2] = var_4.New(arg_27_1)
	BgStoryPlayer = var_4
	var_27_6[3] = var_4.New(arg_27_1)
	CarouselPlayer = var_4
	var_27_6[4] = var_4.New(arg_27_1)
	VedioStoryPlayer = var_4
	var_27_6[5] = var_4.New(arg_27_1)
	CastStoryPlayer = var_4
	var_27_6[6] = var_4.New(arg_27_1)
	SpAnimStoryPlayer = var_4
	var_27_6[7] = var_4.New(arg_27_1)
	BlinkStoryPlayer = var_4
	var_27_6[8] = var_4.New(arg_27_1)
	arg_27_0.players = var_27_6
	StorySetSpeedPanel = var_27_6
	arg_27_0.setSpeedPanel = var_27_6.New(arg_27_0._tf, function(arg_28_0)
		local var_28_0 = arg_27_0

		var_1.UpdatePlaySpeed(var_28_0, arg_28_0)

		return
	end)
	NewStoryRecordPanel = var_3
	arg_27_0.recordPanel = var_3.New()
	StoryRecorder = var_3
	arg_27_0.recorder = var_3.New()
	setActive = var_3

	var_3(arg_27_0._go, false)

	arg_27_0.state = var_0_3

	if arg_27_2 then
		arg_27_2()
	end

	return
end

function var_0_1.GetPlayer(arg_29_0, arg_29_1)
	ipairs = var_1_10002

	for iter_29_0, iter_29_1 in var_1_10002(arg_29_0.players) do
		isa = var_1_10007

		if var_1_10007(iter_29_1, arg_29_1) then
			return iter_29_1
		end
	end

	return nil
end

function var_0_1.Play(arg_30_0, arg_30_1, arg_30_2, arg_30_3, arg_30_4, arg_30_5, arg_30_6, arg_30_7)
	table = var_1_10008

	var_1_10008.insert(arg_30_0.playQueue, {
		arg_30_1,
		arg_30_2,
		arg_30_7
	})

	if #arg_30_0.playQueue == 1 then
		local var_30_0

		;(function()
			if #arg_30_0.playQueue == 0 then
				return
			end

			local var_31_0 = arg_30_0.playQueue[1][1]
			local var_31_1 = arg_30_0.playQueue[1][2]
			local var_31_2 = arg_30_0.playQueue[1][3]
			local var_31_3 = arg_30_0

			var_3.SoloPlay(var_31_3, var_31_0, function(arg_32_0, arg_32_1)
				if var_31_1 then
					var_31_1(arg_32_0, arg_32_1)
				end

				table = var_2

				var_2.remove(arg_30_0.playQueue, 1)
				var_0()

				return
			end, arg_30_3, arg_30_4, arg_30_5, arg_30_6, var_31_2)

			return
		end)()
	end

	return
end

function var_0_1.Pause(arg_33_0)
	if arg_33_0.state ~= var_0_4 then
		var_0_12("state is not 'running'")

		return
	end

	arg_33_0.state = var_0_5
	ipairs = var_1

	for iter_33_0, iter_33_1 in var_1(arg_33_0.players) do
		iter_33_1:Pause()
	end

	return
end

function var_0_1.Resume(arg_34_0)
	if arg_34_0.state ~= var_0_5 then
		var_0_12("state is not 'pause'")

		return
	end

	arg_34_0.state = var_0_4
	ipairs = var_1

	for iter_34_0, iter_34_1 in var_1(arg_34_0.players) do
		iter_34_1:Resume()
	end

	return
end

function var_0_1.Stop(arg_35_0)
	if arg_35_0.state ~= var_0_4 then
		var_0_12("state is not 'running'")

		return
	end

	if arg_35_0.currPlayer then
		local var_35_0 = arg_35_0.currPlayer

		if var_1.WaitForEvent(var_35_0) then
			return
		end
	end

	arg_35_0.state = var_0_6
	ipairs = var_1

	for iter_35_0, iter_35_1 in var_1(arg_35_0.players) do
		iter_35_1:Stop()
	end

	return
end

function var_0_1.PlayForAcivitySpStory(arg_36_0, arg_36_1, arg_36_2, arg_36_3, arg_36_4, arg_36_5, arg_36_6, arg_36_7)
	local function var_36_0()
		_ = var_2_10000

		var_2_10000.each(arg_36_0.branchSelectCache, function(arg_38_0)
			ActivitySpStoryNode = var_3_10001

			if var_3_10001.GetOptionBranchByStoryName(arg_36_1, arg_38_0) then
				local var_38_0 = var_0_14(var_1.story).id
				local var_38_1 = arg_36_0
				local var_38_2 = var_3.SendNotification

				GAME = var_3_10006

				var_38_2(var_38_1, var_3_10006.STORY_UPDATE, {
					storyId = var_38_0
				})
			end

			return
		end)

		arg_36_0.branchSelectCache = nil

		arg_36_2()

		return
	end

	arg_36_0:Play(arg_36_1, var_36_0, arg_36_3, arg_36_4, arg_36_5, arg_36_6, arg_36_7)

	return
end

function var_0_1.PlayForTb(arg_39_0, arg_39_1, arg_39_2, arg_39_3, arg_39_4)
	arg_39_0:Play(arg_39_1, arg_39_3, arg_39_4, false, false, true, arg_39_2)

	return
end

function var_0_1.PlayForWorld(arg_40_0, arg_40_1, arg_40_2, arg_40_3, arg_40_4, arg_40_5, arg_40_6, arg_40_7, arg_40_8)
	arg_40_0.optionSelCodes = arg_40_2 or {}
	arg_40_0.autoPlayFlag = arg_40_6

	arg_40_0:Play(arg_40_1, arg_40_3, arg_40_4, arg_40_5, arg_40_7, true, arg_40_8)

	return
end

function var_0_1.ForceAutoPlay(arg_41_0, arg_41_1, arg_41_2, arg_41_3, arg_41_4, arg_41_5)
	arg_41_0.autoPlayFlag = true

	local function var_41_0(arg_42_0, arg_42_1)
		arg_41_2(arg_42_0, arg_42_1, arg_41_0.isAutoPlay)

		return
	end

	arg_41_0:Play(arg_41_1, var_41_0, arg_41_3, arg_41_4, true, false, arg_41_5)

	return
end

function var_0_1.ForceManualPlay(arg_43_0, arg_43_1, arg_43_2, arg_43_3, arg_43_4, arg_43_5)
	arg_43_0.banPlayFlag = true

	local function var_43_0(arg_44_0, arg_44_1)
		arg_43_2(arg_44_0, arg_44_1, arg_43_0.isAutoPlay)

		return
	end

	arg_43_0:Play(arg_43_1, var_43_0, arg_43_3, arg_43_4, true, false, arg_43_5)

	return
end

function var_0_1.ReViewPlay(arg_45_0, ...)
	arg_45_0.isReView = true

	arg_45_0:Play(...)

	return
end

function var_0_1.SeriesPlay(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4, arg_46_5, arg_46_6, arg_46_7)
	local var_46_0 = {}

	ipairs = var_1_10009

	for iter_46_0, iter_46_1 in var_1_10009(arg_46_1) do
		table = var_1_10014

		var_1_10014.insert(var_46_0, function(arg_47_0)
			local var_47_0 = arg_46_0

			var_1.SoloPlay(var_47_0, iter_46_1, arg_47_0, arg_46_3, arg_46_4, arg_46_5, arg_46_6, arg_46_7)

			return
		end)
	end

	seriesAsync = var_9

	var_9(var_46_0, arg_46_2)

	return
end

function var_0_1.SoloPlay(arg_48_0, arg_48_1, arg_48_2, arg_48_3, arg_48_4, arg_48_5, arg_48_6, arg_48_7)
	var_0_12("Play Story:", arg_48_1)

	local var_48_0 = 1

	local function var_48_1(arg_49_0, arg_49_1)
		var_48_0 = var_48_0 - 1

		if arg_48_2 and var_48_0 == 0 then
			onNextTick = var_2

			var_2(function()
				arg_48_2(arg_49_0, arg_49_1)

				return
			end)
		end

		return
	end

	if not var_0_14(arg_48_1) then
		var_48_1(false)
		var_0_12("not exist story file")

		return nil
	end

	if arg_48_0:IsReView() then
		arg_48_3 = true
	end

	Story = var_11
	arg_48_0.storyScript = var_11.New(var_10, arg_48_3, arg_48_0.optionSelCodes, arg_48_5, arg_48_6, arg_48_7)

	if not arg_48_0:CheckState() then
		var_0_12("story state error")
		var_48_1(false)

		return nil
	end

	local var_48_2 = arg_48_0.storyScript

	if not var_11.CanPlay(var_48_2) then
		var_0_12("story cant be played")
		var_48_1(false)

		return nil
	end

	arg_48_0:ExecuteScript(var_48_1)

	return
end

function var_0_1.ExecuteScript(arg_51_0, arg_51_1)
	seriesAsync = var_1_10002

	var_1_10002({
		function(arg_52_0)
			local var_52_0 = arg_51_0

			var_1.CheckResDownload(var_52_0, arg_51_0.storyScript, arg_52_0)

			return
		end,
		function(arg_53_0)
			originalPrint = var_2_10001

			var_2_10001("start load story window...")

			local var_53_0 = arg_51_0

			var_1.CheckAndLoadDialogue(var_53_0, arg_51_0.storyScript, arg_53_0)

			return
		end
	}, function()
		originalPrint = var_2_10000

		var_2_10000("enter story...")

		local var_54_0 = arg_51_0

		var_0.OnStart(var_54_0)

		local var_54_1 = {}

		arg_51_0.currPlayer = nil

		local var_54_2 = arg_51_0

		var_54_2.progress = 0
		ipairs = var_54_2

		for iter_54_0, iter_54_1 in var_54_2(arg_51_0.storyScript.steps) do
			table = var_2_10006

			var_2_10006.insert(var_54_1, function(arg_55_0)
				arg_51_0.progress = iter_54_0

				local var_55_0 = arg_51_0
				local var_55_1 = var_1.SendNotification

				GAME = var_3_10004

				var_55_1(var_55_0, var_3_10004.STORY_NEXT)

				local var_55_2 = arg_51_0.players
				local var_55_3 = iter_54_1
				local var_55_4 = var_55_2[var_2.GetMode(var_55_3)]

				arg_51_0.currPlayer = var_55_4

				var_55_4:Play(arg_51_0.storyScript, iter_54_0, arg_55_0)

				return
			end)
		end

		seriesAsync = var_1

		var_1(var_54_1, function()
			local var_56_0 = arg_51_0

			var_0.OnEnd(var_56_0, arg_51_1)

			return
		end)

		return
	end)

	return
end

function var_0_1.SendNotification(arg_57_0, arg_57_1, arg_57_2)
	pg = var_1_10003

	local var_57_0 = var_1_10003.m02

	var_3.sendNotification(var_57_0, arg_57_1, arg_57_2)

	return
end

function var_0_1.CheckResDownload(arg_58_0, arg_58_1, arg_58_2)
	local var_58_0 = arg_58_0:_GetResList(arg_58_1)

	SplitPackConst = var_1_10004

	var_1_10004.DownloadByLuaArr(var_58_0, arg_58_2)

	return
end

local function var_0_16(arg_59_0, arg_59_1)
	ResourceMgr = var_1_10002

	local var_59_0 = var_1_10002.Inst
	local var_59_1 = var_2.getAssetAsync
	local var_59_2 = "ui/" .. arg_59_0
	local var_59_3 = ""

	UnityEngine = var_1_10007

	var_59_1(var_59_0, var_59_2, var_59_3, var_1_10007.Events.UnityAction_UnityEngine_Object(function(arg_60_0)
		arg_59_1(arg_60_0)

		return
	end), true, true)

	return
end

function var_0_1.CheckAndLoadDialogue(arg_61_0, arg_61_1, arg_61_2)
	local var_61_0 = arg_61_1:GetDialogueStyleName()
	local var_61_1 = arg_61_0.dialogueContainer

	if not var_4.Find(var_61_1, var_61_0) then
		var_0_16("NewStoryDialogue" .. var_61_0, function(arg_62_0)
			Object = var_2_10001
			var_2_10001.Instantiate(arg_62_0, arg_61_0.dialogueContainer).name = var_61_0

			arg_61_2()

			return
		end)
	else
		arg_61_2()
	end

	return
end

function var_0_1.CheckState(arg_63_0)
	if arg_63_0.state == var_0_4 or arg_63_0.state == var_0_2 or arg_63_0.state == var_0_5 then
		return false
	end

	return true
end

function var_0_1.RegistSkipBtn(arg_64_0)
	local function var_64_0()
		local var_65_0 = arg_64_0

		var_0.TrackingSkip(var_65_0)

		local var_65_1 = arg_64_0.storyScript

		var_0.SkipAll(var_65_1)

		local var_65_2 = arg_64_0.currPlayer

		var_0.NextOneImmediately(var_65_2)

		return
	end

	onButton = var_1_10002

	local var_64_1 = arg_64_0
	local var_64_2 = arg_64_0.skipBtn

	local function var_64_3()
		local var_66_0 = arg_64_0

		if not var_0.IsStopping(var_66_0) then
			local var_66_1 = arg_64_0

			if var_0.IsPausing(var_66_1) then
				return
			end

			local var_66_2 = arg_64_0.currPlayer

			if not var_0.CanSkip(var_66_2) then
				return
			end

			local var_66_3 = arg_64_0

			if not var_0.IsReView(var_66_3) then
				local var_66_4 = arg_64_0.storyScript

				if not var_0.IsPlayed(var_66_4) then
					local var_66_5 = arg_64_0.storyScript

					if not var_0.ShowSkipTip(var_66_5) then
						var_64_0()

						return
					end

					local var_66_6 = arg_64_0

					var_0.Pause(var_66_6)

					local var_66_7 = arg_64_0

					var_66_7.isOpenMsgbox = true
					pg = var_66_7

					local var_66_8 = var_66_7.MsgboxMgr.GetInstance()
					local var_66_9 = var_0.ShowMsgBox
					local var_66_10 = {}

					rtf = var_2_10004

					local var_66_11 = arg_64_0._tf

					var_66_10.parent = var_2_10004(var_6.Find(var_66_11, "front"))
					i18n = var_4
					var_66_10.content = var_4("story_skip_confirm")

					function var_66_10.onYes()
						local var_67_0 = arg_64_0

						var_0.Resume(var_67_0)
						var_64_0()

						return
					end

					function var_66_10.onNo()
						arg_64_0.isOpenMsgbox = false

						local var_68_0 = arg_64_0

						var_0.Resume(var_68_0)

						return
					end

					var_66_9(var_66_8, var_66_10)

					return
				end
			end
		end
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_64_1, var_64_2, var_64_3, var_1_10007)

	return
end

function var_0_1.RegistAutoBtn(arg_69_0)
	onButton = var_1_10001

	local var_69_0 = arg_69_0
	local var_69_1 = arg_69_0.autoBtn

	local function var_69_2()
		local var_70_0 = arg_69_0

		if not var_0.IsStopping(var_70_0) then
			local var_70_1 = arg_69_0

			if var_0.IsPausing(var_70_1) then
				return
			end

			local var_70_2 = arg_69_0.storyScript

			if var_0.GetAutoPlayFlag(var_70_2) then
				local var_70_3 = arg_69_0.storyScript

				var_0.StopAutoPlay(var_70_3)

				local var_70_4 = arg_69_0.currPlayer

				var_0.CancelAuto(var_70_4)
			else
				local var_70_5 = arg_69_0.storyScript

				var_0.SetAutoPlay(var_70_5)

				local var_70_6 = arg_69_0.currPlayer

				var_0.NextOne(var_70_6)
			end

			if arg_69_0.storyScript then
				local var_70_7 = arg_69_0

				var_0.UpdateAutoBtn(var_70_7)
			end

			return
		end
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_69_0, var_69_1, var_69_2, var_1_10006)

	if arg_69_0:IsAutoPlay() then
		local var_69_3 = arg_69_0.storyScript

		var_2.SetAutoPlay(var_69_3)
		arg_69_0:UpdateAutoBtn()

		arg_69_0.autoPlayFlag = false
	end

	arg_69_0.banPlayFlag = false
	arg_69_0.isAutoPlay = var_1

	return
end

function var_0_1.RegistRecordBtn(arg_71_0)
	onButton = var_1_10001

	local var_71_0 = arg_71_0
	local var_71_1 = arg_71_0.recordBtn

	local function var_71_2()
		local var_72_0 = arg_71_0.storyScript

		if var_0.GetAutoPlayFlag(var_72_0) then
			return
		end

		local var_72_1 = arg_71_0.recordPanel

		if not var_0.CanOpen(var_72_1) then
			return
		end

		local var_72_2 = "Show"

		arg_71_0.recordPanel[var_72_2](arg_71_0.recordPanel, arg_71_0.recorder)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_71_0, var_71_1, var_71_2, var_1_10006)

	return
end

function var_0_1.TriggerAutoBtn(arg_73_0)
	if not arg_73_0:IsRunning() then
		return
	end

	triggerButton = var_1

	var_1(arg_73_0.autoBtn)

	return
end

function var_0_1.TriggerSkipBtn(arg_74_0)
	if not arg_74_0:IsRunning() then
		return
	end

	triggerButton = var_1

	var_1(arg_74_0.skipBtn)

	return
end

function var_0_1.ForEscPress(arg_75_0)
	local var_75_0 = arg_75_0.recordPanel

	if var_1.IsShowing(var_75_0) then
		local var_75_1 = arg_75_0.recordPanel

		var_1.Hide(var_75_1)

		goto label_75_0
	end

	if arg_75_0.currPlayer then
		do
			local var_75_2 = arg_75_0.currPlayer

			if not var_1.WaitForEvent(var_75_2) then
				if arg_75_0.currPlayer and arg_75_0.storyScript and arg_75_0.storyScript.hideSkip then
					-- block empty
				else
					arg_75_0:TriggerSkipBtn()
				end
			end
		end

		::label_75_0::

		return
	end
end

function var_0_1.UpdatePlaySpeed(arg_76_0, arg_76_1)
	if arg_76_0:IsRunning() and arg_76_0.storyScript then
		local var_76_0 = arg_76_0.storyScript

		var_2.SetPlaySpeed(var_76_0, arg_76_1)
	end

	return
end

function var_0_1.GetPlaySpeed(arg_77_0)
	if arg_77_0:IsRunning() and arg_77_0.storyScript then
		local var_77_0 = arg_77_0.storyScript

		return var_1.GetPlaySpeed(var_77_0)
	end

	return
end

function var_0_1.OnStart(arg_78_0)
	local var_78_0 = arg_78_0.recorder

	var_1.Clear(var_78_0)

	removeOnButton = var_1

	var_1(arg_78_0._go)

	removeOnButton = var_1

	var_1(arg_78_0.skipBtn)

	removeOnButton = var_1

	var_1(arg_78_0.autoBtn)

	removeOnButton = var_1

	var_1(arg_78_0.recordBtn)

	local var_78_1 = arg_78_0.mainImage

	Color = var_1_10002

	local var_78_2 = 0
	local var_78_3 = 0
	local var_78_4 = 0
	local var_78_5 = arg_78_0.storyScript

	var_78_1.color = var_1_10002(var_78_2, var_78_3, var_78_4, var_7.GetStoryAlpha(var_78_5))
	setActive = var_78_1

	local var_78_6 = arg_78_0.recordBtn
	local var_78_7 = arg_78_0.storyScript

	var_78_1(var_78_6, not var_4.ShouldHideRecord(var_78_7))
	arg_78_0:ClearStoryEventTriggerListener()

	local var_78_8 = arg_78_0.storyScript

	if #var_1.GetAllStepDispatcherRecallName(var_78_8) > 0 then
		StoryEventTriggerListener = var_2
		arg_78_0.storyEventTriggerListener = var_2.New(var_1)
	end

	local var_78_9 = arg_78_0.mainImage
	local var_78_10 = arg_78_0.storyScript

	var_78_9.enabled = not var_3.CanInteraction(var_78_10)
	arg_78_0.state = var_0_4

	arg_78_0:TrackingStart()

	local var_78_11 = arg_78_0
	local var_78_12 = arg_78_0.SendNotification

	GAME = var_78_10

	local var_78_13 = var_78_10.STORY_BEGIN
	local var_78_14 = arg_78_0.storyScript

	var_78_12(var_78_11, var_78_13, var_6.GetName(var_78_14))

	local var_78_16

	if not arg_78_0:IsReView() then
		local var_78_15 = arg_78_0

		var_78_16 = arg_78_0.SendNotification
		GAME = var_78_13

		local var_78_17 = var_78_13.STORY_UPDATE
		local var_78_18 = {}
		local var_78_19 = arg_78_0.storyScript

		var_78_18.storyId = var_7.GetName(var_78_19)

		var_78_16(var_78_15, var_78_17, var_78_18)
	end

	pg = var_78_16

	var_78_16.DelegateInfo.New(arg_78_0)

	ipairs = var_2

	for iter_78_0, iter_78_1 in var_2(arg_78_0.players) do
		iter_78_1:StoryStart(arg_78_0.storyScript)
	end

	setActive = var_2

	var_2(arg_78_0._go, true)

	local var_78_20 = arg_78_0._tf

	var_2.SetAsLastSibling(var_78_20)

	setActive = var_2

	local var_78_21 = arg_78_0.skipBtn
	local var_78_22 = arg_78_0.storyScript

	var_2(var_78_21, not var_5.ShouldHideSkip(var_78_22))

	setActive = var_2

	local var_78_23 = arg_78_0.autoBtn
	local var_78_24 = arg_78_0.storyScript

	var_2(var_78_23, not var_5.ShouldHideAutoBtn(var_78_24))

	pg = var_2

	local var_78_25 = var_2.CriMgr.GetInstance()

	arg_78_0.bgmVolumeValue = var_2.getBGMVolume(var_78_25)

	arg_78_0:RegistSkipBtn()
	arg_78_0:RegistAutoBtn()
	arg_78_0:RegistRecordBtn()
	arg_78_0:RegistHideUIBtn()

	return
end

function var_0_1.RegistHideUIBtn(arg_79_0)
	onButton = var_1_10001

	local var_79_0 = arg_79_0
	local var_79_1 = arg_79_0.hideUIBtn

	local function var_79_2()
		local var_80_0 = arg_79_0.storyScript

		if var_0.GetAutoPlayFlag(var_80_0) then
			local var_80_1 = arg_79_0.storyScript

			var_0.StopAutoPlay(var_80_1)

			local var_80_2 = arg_79_0.currPlayer

			var_0.CancelAuto(var_80_2)

			local var_80_3 = arg_79_0

			var_0.UpdateAutoBtn(var_80_3)
		end

		setActiveByCanvasGroup = var_0

		var_0(arg_79_0.frontTr, false)

		setActive = var_0

		var_0(arg_79_0.frontEvtTr, true)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_79_0, var_79_1, var_79_2, var_1_10006)

	onButton = var_1_10001

	local var_79_3 = arg_79_0
	local var_79_4 = arg_79_0.frontEvtTr

	local function var_79_5()
		setActiveByCanvasGroup = var_2_10000

		var_2_10000(arg_79_0.frontTr, true)

		setActive = var_2_10000

		var_2_10000(arg_79_0.frontEvtTr, false)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_79_3, var_79_4, var_79_5, var_1_10006)

	return
end

function var_0_1.TrackingStart(arg_82_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	if var_1_10001(var_1_10003) then
		getProxy = var_1
		PlayerProxy = var_1_10003

		local var_82_0 = var_1(var_1_10003)

		if not var_1.getRawData(var_82_0) then
			return
		end

		arg_82_0.trackFlag = false

		if not arg_82_0.storyScript then
			return
		end

		local var_82_1 = arg_82_0
		local var_82_2 = arg_82_0.StoryName2StoryId
		local var_82_3 = arg_82_0.storyScript

		if var_82_2(var_82_1, var_4.GetName(var_82_3)) and not arg_82_0:GetPlayedFlag(var_1) then
			pg = var_2

			local var_82_4 = var_2.GameTrackerMgr.GetInstance()
			local var_82_5 = var_2.Record

			GameTrackerBuilder = var_5

			var_82_5(var_82_4, var_5.BuildStoryStart(var_1, 0))

			arg_82_0.trackFlag = true
		end

		return
	end
end

function var_0_1.TrackingSkip(arg_83_0)
	if not arg_83_0.trackFlag or not arg_83_0.storyScript then
		return
	end

	local var_83_0 = arg_83_0
	local var_83_1 = arg_83_0.StoryName2StoryId
	local var_83_2 = arg_83_0.storyScript

	if var_83_1(var_83_0, var_4.GetName(var_83_2)) then
		pg = var_1_10002

		local var_83_3 = var_1_10002.GameTrackerMgr.GetInstance()
		local var_83_4 = var_2.Record

		GameTrackerBuilder = var_1_10005

		local var_83_5 = var_1_10005.BuildStorySkip
		local var_83_6 = var_1
		local var_83_7

		if not arg_83_0.progress then
			var_83_7 = 0
		end

		var_83_4(var_83_3, var_83_5(var_83_6, var_83_7))
	end

	return
end

function var_0_1.TrackingOption(arg_84_0, arg_84_1, arg_84_2)
	if not arg_84_0.storyScript or not arg_84_1 or not arg_84_2 then
		return
	end

	local var_84_0 = arg_84_0
	local var_84_1 = arg_84_0.StoryName2StoryId
	local var_84_2 = arg_84_0.storyScript

	if var_84_1(var_84_0, var_6.GetName(var_84_2)) then
		pg = var_1_10004

		local var_84_3 = var_1_10004.GameTrackerMgr.GetInstance()
		local var_84_4 = var_4.Record

		GameTrackerBuilder = var_1_10007

		var_84_4(var_84_3, var_1_10007.BuildStoryOption(var_3, arg_84_1 .. "_" .. (arg_84_2 or 0)))
	end

	return
end

function var_0_1.ClearStoryEvent(arg_85_0)
	if arg_85_0.storyEventTriggerListener then
		local var_85_0 = arg_85_0.storyEventTriggerListener

		var_1.Clear(var_85_0)
	end

	return
end

function var_0_1.CheckStoryEvent(arg_86_0, arg_86_1)
	if arg_86_0.storyEventTriggerListener then
		local var_86_0 = arg_86_0.storyEventTriggerListener

		return var_2.ExistCache(var_86_0, arg_86_1)
	end

	return false
end

function var_0_1.GetStoryEventArg(arg_87_0, arg_87_1)
	if not arg_87_0:CheckStoryEvent(arg_87_1) then
		return nil
	end

	if arg_87_0.storyEventTriggerListener then
		local var_87_0 = arg_87_0.storyEventTriggerListener

		if var_2.ExistArg(var_87_0, arg_87_1) then
			local var_87_1 = arg_87_0.storyEventTriggerListener

			return var_2.GetArg(var_87_1, arg_87_1)
		end
	end

	return nil
end

function var_0_1.UpdateAutoBtn(arg_88_0)
	local var_88_0 = arg_88_0.storyScript
	local var_88_1 = var_1.GetAutoPlayFlag(var_88_0)

	arg_88_0:ClearAutoBtn(var_88_1)

	return
end

function var_0_1.ClearAutoBtn(arg_89_0, arg_89_1)
	local var_89_0 = arg_89_0.autoBtnImg
	local var_89_1

	if not arg_89_1 or not var_0_9 then
		var_89_1 = var_0_10
	end

	var_89_0.color = var_89_1
	arg_89_0.isAutoPlay = arg_89_1

	local var_89_2 = arg_89_1 and "Show" or "Hide"

	arg_89_0.setSpeedPanel[var_89_2](arg_89_0.setSpeedPanel, arg_89_0.storyScript)

	return
end

function var_0_1.ClearStoryEventTriggerListener(arg_90_0)
	if arg_90_0.storyEventTriggerListener then
		local var_90_0 = arg_90_0.storyEventTriggerListener

		var_1.Dispose(var_90_0)

		arg_90_0.storyEventTriggerListener = nil
	end

	return
end

function var_0_1.Clear(arg_91_0)
	arg_91_0.progress = 0

	arg_91_0:ClearStoryEventTriggerListener()

	arg_91_0.mainImage.enabled = true

	local var_91_0 = arg_91_0.recorder

	var_1.Clear(var_91_0)

	local var_91_1 = arg_91_0.recordPanel

	var_1.Hide(var_91_1)

	arg_91_0.autoPlayFlag = false
	arg_91_0.banPlayFlag = false
	arg_91_0.isReView = false
	removeOnButton = var_1

	var_1(arg_91_0._go)

	removeOnButton = var_1

	var_1(arg_91_0.skipBtn)

	removeOnButton = var_1

	var_1(arg_91_0.recordBtn)

	removeOnButton = var_1

	var_1(arg_91_0.autoBtn)

	removeOnButton = var_1

	var_1(arg_91_0.hideUIBtn)

	removeOnButton = var_1

	var_1(arg_91_0.frontEvtTr)
	arg_91_0:ClearAutoBtn(false)

	isActive = var_1

	if var_1(arg_91_0._go) then
		pg = var_1

		var_1.DelegateInfo.Dispose(arg_91_0)
	end

	if arg_91_0.setSpeedPanel then
		local var_91_2 = arg_91_0.setSpeedPanel

		var_1.Clear(var_91_2)
	end

	setActive = var_1

	var_1(arg_91_0.skipBtn, false)

	setActive = var_1

	var_1(arg_91_0._go, false)

	arg_91_0.branchSelectCache = {}
	_ = var_1

	var_1.each(arg_91_0.players, function(arg_92_0)
		pairs = var_2_10001

		for iter_92_0, iter_92_1 in var_2_10001(arg_92_0.branchCodeList) do
			_ = var_2_10006

			var_2_10006.each(iter_92_1, function(arg_93_0)
				table = var_3_10001

				var_3_10001.insert(arg_91_0.branchSelectCache, arg_93_0)

				return
			end)
		end

		return
	end)

	ipairs = var_1

	for iter_91_0, iter_91_1 in var_1(arg_91_0.players) do
		iter_91_1:StoryEnd(arg_91_0.storyScript)
	end

	arg_91_0.optionSelCodes = nil

	local var_91_3 = arg_91_0
	local var_91_4 = arg_91_0.SendNotification

	GAME = iter_91_0

	var_91_4(var_91_3, iter_91_0.STORY_END)

	if arg_91_0.isOpenMsgbox then
		pg = var_1

		local var_91_5 = var_1.MsgboxMgr.GetInstance()

		var_1.hide(var_91_5)
	end

	arg_91_0:RevertBgmVolumeValue()

	return
end

function var_0_1.RevertBgmVolumeValue(arg_94_0)
	pg = var_1_10001

	local var_94_0 = var_1_10001.BgmMgr.GetInstance()

	var_1.ContinuePlay(var_94_0)

	pg = var_1

	local var_94_1 = var_1.CriMgr.GetInstance()
	local var_94_2 = var_1.getBGMVolume(var_94_1)

	if arg_94_0.bgmVolumeValue and arg_94_0.bgmVolumeValue ~= var_94_2 then
		pg = var_2

		local var_94_3 = var_2.CriMgr.GetInstance()

		var_2.setBGMVolume(var_94_3, arg_94_0.bgmVolumeValue)
	end

	arg_94_0.bgmVolumeValue = nil

	return
end

function var_0_1.OnEnd(arg_95_0, arg_95_1)
	arg_95_0:Clear()

	if arg_95_0.state == var_0_4 or arg_95_0.state == var_0_6 then
		arg_95_0.state = var_0_7

		local var_95_0 = arg_95_0.storyScript

		if var_2.GetNextScriptName(var_95_0) and not arg_95_0:IsReView() then
			arg_95_0.storyScript = nil

			arg_95_0:SoloPlay(var_2, arg_95_1, true)
		else
			local var_95_1 = arg_95_0.storyScript
			local var_95_2 = var_3.GetBranchCode(var_95_1)

			arg_95_0.storyScript = nil

			if arg_95_1 then
				arg_95_1(true, var_95_2)
			end
		end
	else
		arg_95_0.state = var_0_7

		local var_95_3 = arg_95_0.storyScript
		local var_95_4 = var_2.GetBranchCode(var_95_3)

		if arg_95_1 then
			arg_95_1(true, var_95_4)
		end
	end

	return
end

function var_0_1.OnSceneEnter(arg_96_0, arg_96_1)
	if not arg_96_0.scenes then
		arg_96_0.scenes = {}
	end

	arg_96_0.scenes[arg_96_1.view] = true

	return
end

function var_0_1.OnSceneExit(arg_97_0, arg_97_1)
	if not arg_97_0.scenes then
		return
	end

	arg_97_0.scenes[arg_97_1.view] = nil

	return
end

function var_0_1.IsReView(arg_98_0)
	tobool = var_1_10001

	return var_1_10001(arg_98_0.isReView)
end

function var_0_1.IsRunning(arg_99_0)
	return arg_99_0.state == var_0_4
end

function var_0_1.IsStopping(arg_100_0)
	return arg_100_0.state == var_0_6
end

function var_0_1.IsPausing(arg_101_0)
	return arg_101_0.state == var_0_5
end

function var_0_1.IsAutoPlay(arg_102_0)
	if arg_102_0.banPlayFlag then
		return false
	end

	getProxy = var_1
	SettingsProxy = var_1_10003

	local var_102_0 = var_1(var_1_10003)
	local var_102_1

	if not var_1.GetStoryAutoPlayFlag(var_102_0) then
		var_102_1 = arg_102_0.autoPlayFlag == true
	end

	return var_102_1
end

function var_0_1.GetRectSize(arg_103_0)
	Vector2 = var_1_10001

	return var_1_10001(arg_103_0._tf.rect.width, arg_103_0._tf.rect.height)
end

function var_0_1.AddRecord(arg_104_0, arg_104_1)
	local var_104_0 = arg_104_0.recorder

	var_2.Add(var_104_0, arg_104_1)

	return
end

function var_0_1.Quit(arg_105_0)
	local var_105_0 = arg_105_0.recorder

	var_1.Dispose(var_105_0)

	local var_105_1 = arg_105_0.recordPanel

	var_1.Dispose(var_105_1)

	local var_105_2 = arg_105_0.setSpeedPanel

	var_1.Dispose(var_105_2)

	if arg_105_0.currPlayer then
		local var_105_3 = arg_105_0.currPlayer

		if var_1.WaitForEvent(var_105_3) then
			arg_105_0:Clear()
		end
	end

	arg_105_0.state = var_0_8
	arg_105_0.storyScript = nil
	arg_105_0.currPlayer = nil
	arg_105_0.playQueue = {}
	arg_105_0.playedList = {}
	arg_105_0.scenes = {}

	return
end

function var_0_1.Fix(arg_106_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_106_0 = var_1_10001(var_1_10003)
	local var_106_1 = var_1.getRawData(var_106_0)
	local var_106_2 = var_1.GetRegisterTime(var_106_1)

	pg = var_106_0

	local var_106_3 = var_106_0.TimeMgr.GetInstance()
	local var_106_4 = var_3.parseTimeFromConfig(var_106_3, {
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
	})
	local var_106_5 = {
		10020,
		10021,
		10022,
		10023,
		10024,
		10025,
		10026,
		10027
	}

	if var_106_2 <= var_106_4 then
		_ = var_106_3

		var_106_3.each(var_106_5, function(arg_107_0)
			arg_106_0.playedList[arg_107_0] = true

			return
		end)
	end

	local var_106_6 = 5001
	local var_106_7 = 5020

	getProxy = var_7
	TaskProxy = var_1_10009

	local var_106_8 = var_7(var_1_10009)
	local var_106_9 = 0

	for iter_106_0 = var_106_6, var_106_7, -1 do
		if not var_106_8:getFinishTaskById(iter_106_0) then
			var_1_10013 = var_106_8:getTaskById(iter_106_0)
		end

		if var_1_10013 then
			var_106_9 = iter_106_0

			break
		end
	end

	for iter_106_1 = var_106_9, var_106_7, -1 do
		pg = var_1_10013

		if var_1_10013.task_data_template[iter_106_1] and var_1_10013.story_id then
			local var_106_10 = #var_14

			if 0 < var_106_10 and not arg_106_0:IsPlayed(var_14) then
				arg_106_0.playedList[var_14] = true
			end
		end
	end

	getProxy = var_9
	ActivityProxy = var_11

	local var_106_11 = var_9(var_11)
	local var_106_12 = var_9.getActivityById

	ActivityConst = iter_106_1

	if var_106_12(var_106_11, iter_106_1.JYHZ_ACTIVITY_ID) and not var_9:isEnd() then
		_ = var_10

		local var_106_13 = var_10.flatten(var_9:getConfig("config_data"))
		local var_106_14

		for iter_106_2 = #var_106_13, 1, -1 do
			pg = var_1_10016

			if var_1_10016.task_data_template[var_106_13[iter_106_2]].story_id and #var_1_10016 > 0 then
				local var_106_15 = arg_106_0:IsPlayed(var_1_10016)

				if var_106_14 then
					if not var_106_15 then
						arg_106_0.playedList[var_1_10016] = true
					end
				elseif var_106_15 then
					var_106_14 = iter_106_2
				end
			end
		end
	end

	return
end

function var_0_1._GetResList(arg_108_0, arg_108_1)
	local var_108_0 = "ui/newstoryui"
	local var_108_1 = arg_108_1:GetDialogueStyleName()
	local var_108_2 = "ui/newstorydialogue" .. var_108_1
	local var_108_3 = "ui/newstoryrecordui"
	local var_108_4 = arg_108_0
	local var_108_5 = arg_108_0._GetStoryPaintingsByName(var_108_4, arg_108_1)
	local var_108_6 = {}

	_ = var_108_4

	var_108_4.each(var_108_5, function(arg_109_0)
		PaintingGroupConst = var_2_10001

		var_2_10001.AddPaintingNameWithFilteMap(var_108_6, arg_109_0)

		return
	end)

	local var_108_7 = {}

	_ = var_9

	var_9.each(var_108_5, function(arg_110_0)
		table = var_2_10001

		var_2_10001.insert(var_108_7, "paintingface/" .. arg_110_0)

		return
	end)

	local var_108_8 = {}

	_ = var_10

	var_10.each(arg_108_1.steps, function(arg_111_0)
		local var_111_0 = arg_111_0:GetResList()

		_ = var_2_10002

		var_2_10002.each(var_111_0, function(arg_112_0)
			table = var_3_10001

			var_3_10001.insert(var_108_8, arg_112_0)

			return
		end)

		return
	end)

	SplitPackMediatorResMap = var_10

	local var_108_9 = var_10.MergeLuaArr(var_108_6, var_108_7, var_108_8)

	table = var_11

	var_11.insert(var_108_9, var_108_0)

	table = var_11

	var_11.insert(var_108_9, var_108_2)

	table = var_11

	var_11.insert(var_108_9, var_108_3)

	return var_108_9
end

return
