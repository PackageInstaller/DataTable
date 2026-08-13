class = var_0_10000

local var_0_0 = "VoteEntranceScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

var_0_1.MAIN_STAGE_CLOSE = 0
var_0_1.MAIN_STAGE_OPEN = 1
var_0_1.MAIN_STAGE_FINAL = 2
var_0_1.MAIN_STAGE_END = 3
var_0_1.SUB_STAGE_CLOSE = 0
var_0_1.SUB_STAGE_META = 1
var_0_1.SUB_STAGE_KID = 2
var_0_1.SUB_STAGE_SIREN = 3
var_0_1.EXCHANGE_STAGE_CLOSE = 0
var_0_1.EXCHANGE_STAGE_OPEN = 1
var_0_1.BILLBOARD_STAGE_NORMAL = 0
var_0_1.BILLBOARD_STAGE_FINAL = 1

function var_0_1.getUIName(arg_1_0)
	return "VoteEntranceUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.backBtn = var_1.Find(var_2_0, "frame/back")

	local var_2_1 = arg_2_0._tf

	arg_2_0.homeBtn = var_1.Find(var_2_1, "frame/home")

	local var_2_2 = arg_2_0._tf

	arg_2_0.helpBtn = var_1.Find(var_2_2, "frame/help")

	local var_2_3 = arg_2_0._tf

	arg_2_0.votesTr = var_1.Find(var_2_3, "frame/votes")

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_1.Find(var_2_4, "frame/votes/Text")
	local var_2_6 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.votesTxt = var_2_6(var_2_5, var_3(var_1_10004))

	local var_2_7 = arg_2_0._tf

	arg_2_0.scheduleTr = var_1.Find(var_2_7, "frame/schedule")

	local var_2_8 = arg_2_0.scheduleTr
	local var_2_9 = var_1.Find(var_2_8, "Text")
	local var_2_10 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.scheduleTxt = var_2_10(var_2_9, var_3(var_1_10004))

	local var_2_11 = arg_2_0.scheduleTr
	local var_2_12 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.scheduleImg = var_2_12(var_2_11, var_3(var_1_10004))

	local var_2_13 = arg_2_0._tf

	arg_2_0.awardBtn = var_1.Find(var_2_13, "frame/award")

	local var_2_14 = arg_2_0._tf
	local var_2_15 = var_1.Find(var_2_14, "bg/main")
	local var_2_16 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.mainTr = var_2_16(var_2_15, var_3(var_1_10004))

	local var_2_17 = arg_2_0.mainTr.gameObject.transform

	arg_2_0.mainTip = var_1.Find(var_2_17, "tip")

	local var_2_18 = arg_2_0.mainTr.gameObject.transform

	arg_2_0.mainTitle = var_1.Find(var_2_18, "title")

	local var_2_19 = arg_2_0._tf

	arg_2_0.awardItem = var_1.Find(var_2_19, "bg/main/item")

	local var_2_20 = arg_2_0.awardItem

	arg_2_0.dropTr = var_1.Find(var_2_20, "Award")

	local var_2_21 = arg_2_0.awardItem

	arg_2_0.dropGetTr = var_1.Find(var_2_21, "get")

	local var_2_22 = arg_2_0.awardItem

	arg_2_0.dropGotTr = var_1.Find(var_2_22, "got")

	local var_2_23 = arg_2_0._tf
	local var_2_24 = var_1.Find(var_2_23, "bg/sub")
	local var_2_25 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.subTr = var_2_25(var_2_24, var_3(var_1_10004))

	local var_2_26 = arg_2_0.subTr.gameObject.transform

	arg_2_0.subTip = var_1.Find(var_2_26, "tip")

	local var_2_27 = arg_2_0.subTr.gameObject.transform

	arg_2_0.subTitle = var_1.Find(var_2_27, "title")

	local var_2_28 = arg_2_0._tf
	local var_2_29 = var_1.Find(var_2_28, "bg/exchange")
	local var_2_30 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.exchangeTr = var_2_30(var_2_29, var_3(var_1_10004))

	local var_2_31 = arg_2_0.exchangeTr.gameObject.transform

	arg_2_0.exchangeTip = var_1.Find(var_2_31, "tip")

	local var_2_32 = arg_2_0.exchangeTr.gameObject.transform

	arg_2_0.exchangeTitle = var_1.Find(var_2_32, "title")

	local var_2_33 = arg_2_0._tf
	local var_2_34 = var_1.Find(var_2_33, "bg/billboard")
	local var_2_35 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.billboardTr = var_2_35(var_2_34, var_3(var_1_10004))

	local var_2_36 = arg_2_0.billboardTr.gameObject.transform

	arg_2_0.billboardTip = var_1.Find(var_2_36, "tip")

	local var_2_37 = arg_2_0._tf
	local var_2_38 = var_1.Find(var_2_37, "bg/honor")
	local var_2_39 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.honorTr = var_2_39(var_2_38, var_3(var_1_10004))

	local var_2_40 = arg_2_0.honorTr.gameObject.transform

	arg_2_0.honorTip = var_1.Find(var_2_40, "tip")
	VoteAwardWindowPage = var_1
	arg_2_0.awardWindowPage = var_1.New(arg_2_0._tf, arg_2_0.event)
	VoteStoryUtil = var_1

	local var_2_41 = var_1.Notify

	VoteStoryUtil = var_2

	var_2_41(var_2.ENTER_SCENE)

	setActive = var_2_41

	var_2_41(arg_2_0.dropGetTr, false)

	setActive = var_2_41

	var_2_41(arg_2_0.dropGotTr, false)

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.backBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.emit(var_4_0, var_0_1.ON_BACK)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.homeBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.emit(var_5_0, var_0_1.ON_HOME)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.helpBtn

	local function var_3_8()
		pg = var_2_10000

		local var_6_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_6_1 = var_0.ShowMsgBox
		local var_6_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_6_2.type = var_2_10003
		pg = var_2_10003
		var_6_2.helps = var_2_10003.gametip.vote_help_2025.tip

		var_6_1(var_6_0, var_6_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	onButton = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.awardBtn

	local function var_3_11()
		local var_7_0 = arg_3_0.awardWindowPage

		var_0.ExecuteAction(var_7_0, "Show")

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_9, var_3_10, var_3_11, var_1_10005)

	getProxy = var_1_10001
	ActivityProxy = var_3_9

	local var_3_12 = var_1_10001(var_3_9)
	local var_3_13 = var_1.getActivityByType

	ActivityConst = var_3_10
	arg_3_0.voteActivity = var_3_13(var_3_12, var_3_10.ACTIVITY_TYPE_VOTE)

	arg_3_0:FlushAll()

	return
end

function var_0_1.FlushAll(arg_8_0)
	VoteStoryUtil = var_1_10001
	arg_8_0.allPreheatStoriesPlayed = var_1_10001.AllPreheatStoriesPlayed()

	arg_8_0:UpdateSchedule()
	arg_8_0:UpdateVotes()
	arg_8_0:UpdateMainEntrance()
	arg_8_0:UpdateSubEntrance()
	arg_8_0:UpdateExchangeEntrance()
	arg_8_0:UpdateBillboardEntrance()
	arg_8_0:UpdateHonorEntrance()

	return
end

function var_0_1.UpdateSchedule(arg_9_0)
	if not arg_9_0.allPreheatStoriesPlayed then
		setActive = var_1

		var_1(arg_9_0.scheduleTr, false)

		return
	end

	getProxy = var_1
	VoteProxy = var_1_10002

	local var_9_0 = var_1(var_1_10002)
	local var_9_1

	if not var_1.GetOpeningNonFunVoteGroup(var_9_0) then
		getProxy = var_9_1
		VoteProxy = var_9_0
		var_9_0 = var_9_1(var_9_0)
		var_9_1 = var_9_1.GetOpeningFunVoteGroup(var_9_0)
	end

	setActive = var_9_0

	var_9_0(arg_9_0.scheduleTr, var_9_1 ~= nil)

	local var_9_3

	if var_9_1 then
		local var_9_2 = arg_9_0.scheduleTxt

		var_9_3 = var_9_1
		var_9_2.text = var_9_1.getConfig(var_9_3, "name")
	end

	local var_9_4 = "schedule_bg"

	if var_9_1 then
		var_9_3 = var_9_1

		if var_9_1.isFinalsRace(var_9_3) then
			var_9_4 = "schedule_bg_finals"

			goto label_9_0
		end
	end

	if var_9_1 then
		var_9_3 = var_9_1

		if var_9_1.isResurrectionRace(var_9_3) then
			var_9_4 = "schedule_bg_resurrection"

			goto label_9_0
		end
	end

	if var_9_1 then
		var_9_3 = var_9_1

		if var_9_1.IsFunMetaRace(var_9_3) then
			var_9_4 = "schedule_bg_meta"

			goto label_9_0
		end
	end

	if var_9_1 then
		var_9_3 = var_9_1

		if var_9_1.IsFunSireRace(var_9_3) then
			var_9_4 = "schedule_bg_sire"

			goto label_9_0
		end
	end

	if var_9_1 then
		var_9_3 = var_9_1

		if var_9_1.IsFunKidRace(var_9_3) then
			var_9_4 = "schedule_bg_kid"
		end
	end

	::label_9_0::

	local var_9_5 = arg_9_0.scheduleImg

	GetSpriteFromAtlas = var_9_3
	var_9_5.sprite = var_9_3("ui/Vote2023MainUI_atlas", var_9_4)

	return
end

function var_0_1.UpdateVotes(arg_10_0)
	if not arg_10_0.allPreheatStoriesPlayed then
		setActive = var_1

		var_1(arg_10_0.votesTr, false)

		setActive = var_1

		var_1(arg_10_0.awardBtn, false)

		return
	end

	setActive = var_1

	local var_10_0 = arg_10_0.awardBtn

	getProxy = var_1_10003
	VoteProxy = var_1_10004

	local var_10_1 = var_1_10003(var_1_10004)

	var_1(var_10_0, not var_3.IsAllRaceEnd(var_10_1))

	getProxy = var_1
	VoteProxy = var_10_0

	local var_10_2 = var_1(var_10_0)
	local var_10_3

	if not var_1.GetOpeningNonFunVoteGroup(var_10_2) then
		getProxy = var_10_3
		VoteProxy = var_10_2
		var_10_2 = var_10_3(var_10_2)
		var_10_3 = var_10_3.GetOpeningFunVoteGroup(var_10_2)
	end

	setActive = var_10_2

	var_10_2(arg_10_0.votesTr, var_10_3 ~= nil)

	if var_10_3 and var_10_3:IsFunRace() then
		arg_10_0.votesTxt.text = arg_10_0:GetSubVotes()
	else
		arg_10_0.votesTxt.text = arg_10_0:GetVotes()
	end

	return
end

function var_0_1.UpdateMainEntrance(arg_11_0)
	local var_11_0 = arg_11_0
	local var_11_1 = arg_11_0.GetMainStageState(var_11_0)

	GetSpriteFromAtlas = var_11_0

	local var_11_2

	var_11_2.sprite, var_11_2 = var_11_0("ui/Vote2023MainUI_atlas", "icon_main_" .. var_11_1), arg_11_0.mainTr
	onButton = var_11_2

	local var_11_3 = arg_11_0
	local var_11_4 = arg_11_0.mainTr.gameObject

	local function var_11_5()
		local var_12_0 = arg_11_0
		local var_12_1 = var_0.ShouldPlayMainStory(var_12_0)

		VoteStoryUtil = var_12_0

		local var_12_2 = var_12_0.Notify

		VoteStoryUtil = var_2_10002

		var_12_2(var_2_10002.ENTER_MAIN_STAGE)

		if var_12_1 then
			return
		end

		local var_12_3 = arg_11_0

		if not var_1.CheckPreheatStories(var_12_3) then
			return
		end

		local var_12_4 = arg_11_0

		var_1.MarkMainRaceNonNew(var_12_4)

		local var_12_5 = arg_11_0

		if var_1.ExistMainStageAward(var_12_5) then
			local var_12_6 = arg_11_0
			local var_12_7 = var_1.emit

			VoteEntranceMediator = var_2_10003

			var_12_7(var_12_6, var_2_10003.SUBMIT_TASK)

			return
		end

		local var_12_8 = arg_11_0
		local var_12_9 = var_1.emit

		VoteEntranceMediator = var_2_10003

		var_12_9(var_12_8, var_2_10003.ON_VOTE)

		return
	end

	SFX_PANEL = var_1_10007

	var_11_2(var_11_3, var_11_4, var_11_5, var_1_10007)

	local var_11_6 = arg_11_0

	arg_11_0.UpdateMainAward(var_11_6)

	getProxy = var_3
	VoteProxy = var_11_6

	local var_11_7 = var_3(var_11_6)

	if var_3.GetOpeningNonFunVoteGroup(var_11_7) then
		var_11_4 = var_3

		local var_11_8

		if not var_3.IsOpening(var_11_4) then
			var_11_4 = arg_11_0

			if not arg_11_0.ExistMainStageAward(var_11_4) then
				var_11_4 = arg_11_0
				var_11_8 = arg_11_0.ShouldPlayMainStory(var_11_4)
			end
		end

		setGray = var_11_4

		var_11_4(arg_11_0.mainTitle, not var_11_8, true)
		arg_11_0:UpdateMainStageTip()

		return
	end
end

function var_0_1.UpdateMainAward(arg_13_0)
	local var_13_0 = arg_13_0:GetMainStageState() == var_0_1.MAIN_STAGE_END
	local var_13_1 = false

	if var_13_0 then
		getProxy = var_1_10004
		ActivityProxy = var_1_10005

		local var_13_2 = var_1_10004(var_1_10005)

		var_1_10004 = var_1_10004.getActivityById
		ActivityConst = var_1_10006

		local var_13_3 = var_1_10004(var_13_2, var_1_10006.VOTE_ENTRANCE_ACT_ID)
		local var_13_4

		if not var_1_10004.getConfig(var_13_3, "config_client")[2] then
			var_13_4 = -1
		end

		pg = var_13_3

		local var_13_5 = var_13_3.task_data_template[var_13_4].award_display

		updateDrop = var_1_10008

		var_1_10008(arg_13_0.dropTr, {
			type = var_13_5[1][1],
			id = var_13_5[1][2],
			count = var_13_5[1][3]
		})

		getProxy = var_1_10008
		TaskProxy = var_9

		local var_13_6 = var_1_10008(var_9)
		local var_13_7

		if not var_8.getTaskById(var_13_6, var_13_4) then
			getProxy = var_13_7
			TaskProxy = var_13_6
			var_13_6 = var_13_7(var_13_6)
			var_13_7 = var_13_7.getFinishTaskById(var_13_6, var_13_4)
		end

		var_13_1 = var_13_7 and var_13_7:isFinish()
		setActive = var_13_6

		local var_13_8 = arg_13_0.dropGetTr
		local var_13_9

		if var_13_7 and var_13_7:isFinish() then
			var_13_9 = not var_13_7:isReceive()
		end

		var_13_6(var_13_8, var_13_9)

		setActive = var_13_6

		local var_13_10 = arg_13_0.dropGotTr
		local var_13_11

		if var_13_7 and var_13_7:isFinish() then
			var_13_11 = var_13_7:isReceive()
		end

		var_13_6(var_13_10, var_13_11)
	end

	setActive = var_1_10004

	var_1_10004(arg_13_0.awardItem, var_13_0 and var_13_1)

	return
end

function var_0_1.UpdateMainStageTip(arg_14_0)
	setActive = var_1_10001

	var_1_10001(arg_14_0.mainTip, arg_14_0:ShouldTipMainStage())

	return
end

function var_0_1.UpdateSubEntrance(arg_15_0)
	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.GetSubStageState(var_15_0)

	GetSpriteFromAtlas = var_15_0

	local var_15_2 = var_15_0("ui/Vote2023MainUI_atlas", "icon_sub_" .. var_15_1)

	arg_15_0.subTr.sprite = var_15_2

	arg_15_0:UpdateSubStageTip()

	onButton = var_3

	local var_15_3 = arg_15_0
	local var_15_4 = arg_15_0.subTr.gameObject

	local function var_15_5()
		local var_16_0 = arg_15_0
		local var_16_1 = var_0.ShouldPlaySubStory(var_16_0)

		VoteStoryUtil = var_16_0

		local var_16_2 = var_16_0.Notify

		VoteStoryUtil = var_2_10002

		var_16_2(var_2_10002.ENTER_SUB_STAGE)

		if var_16_1 then
			return
		end

		local var_16_3 = arg_15_0

		if not var_1.CheckPreheatStories(var_16_3) then
			return
		end

		local var_16_4 = arg_15_0

		var_1.MarkSubRaceNonNew(var_16_4)

		local var_16_5 = arg_15_0
		local var_16_6 = var_1.emit

		VoteEntranceMediator = var_2_10003

		var_16_6(var_16_5, var_2_10003.ON_FUN_VOTE)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_15_3, var_15_4, var_15_5, var_1_10007)

	getProxy = var_3
	VoteProxy = var_15_3

	local var_15_6 = var_3(var_15_3)

	if var_3.GetOpeningFunVoteGroup(var_15_6) then
		var_15_4 = var_3

		local var_15_7

		if not var_3.IsOpening(var_15_4) then
			var_15_4 = arg_15_0
			var_15_7 = arg_15_0.ShouldPlaySubStory(var_15_4)
		end

		setGray = var_15_4

		var_15_4(arg_15_0.subTitle, not var_15_7, true)

		return
	end
end

function var_0_1.UpdateSubStageTip(arg_17_0)
	setActive = var_1_10001

	var_1_10001(arg_17_0.subTip, arg_17_0:ShouldTipSubStage())

	return
end

function var_0_1.UpdateExchangeEntrance(arg_18_0)
	local var_18_0 = arg_18_0
	local var_18_1 = arg_18_0.GetExchangeState(var_18_0)

	GetSpriteFromAtlas = var_18_0

	local var_18_2 = var_18_0("ui/Vote2023MainUI_atlas", "icon_exchange_" .. var_18_1)

	arg_18_0.exchangeTr.sprite = var_18_2

	arg_18_0:UpdateExchangeTip()

	onButton = var_3

	local var_18_3 = arg_18_0
	local var_18_4 = arg_18_0.exchangeTr.gameObject

	local function var_18_5()
		local var_19_0 = arg_18_0
		local var_19_1 = var_0.ShouldPlayExchangeStory(var_19_0)

		VoteStoryUtil = var_19_0

		local var_19_2 = var_19_0.Notify

		VoteStoryUtil = var_2_10002

		var_19_2(var_2_10002.ENTER_EXCHANGE)

		if var_19_1 then
			return
		end

		local var_19_3 = arg_18_0

		if not var_1.CheckPreheatStories(var_19_3) then
			return
		end

		getProxy = var_1
		PlayerProxy = var_19_3

		local var_19_4 = var_1(var_19_3)

		if var_1.getRawData(var_19_4).level < 25 then
			pg = var_1

			local var_19_5 = var_1.TipsMgr.GetInstance()
			local var_19_6 = var_1.ShowTips

			i18n = var_2_10003

			var_19_6(var_19_5, var_2_10003("vote_tip_level_limit"))

			return
		end

		local var_19_7 = arg_18_0
		local var_19_8 = var_1.emit

		VoteEntranceMediator = var_2_10003

		var_19_8(var_19_7, var_2_10003.ON_EXCHANGE)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_18_3, var_18_4, var_18_5, var_1_10007)

	getProxy = var_3
	VoteProxy = var_18_3

	local var_18_6 = var_3(var_18_3)

	if var_3.GetOpeningNonFunVoteGroup(var_18_6) then
		var_18_4 = var_3

		local var_18_7

		if not var_3.IsOpening(var_18_4) then
			var_18_4 = arg_18_0
			var_18_7 = arg_18_0.ShouldPlayExchangeStory(var_18_4)
		end

		setGray = var_18_4

		var_18_4(arg_18_0.exchangeTitle, not var_18_7, true)

		return
	end
end

function var_0_1.UpdateExchangeTip(arg_20_0)
	setActive = var_1_10001

	var_1_10001(arg_20_0.exchangeTip, arg_20_0:ShouldTipExchange())

	return
end

function var_0_1.UpdateBillboardEntrance(arg_21_0)
	local var_21_0 = arg_21_0
	local var_21_1 = arg_21_0.GetBillboardState(var_21_0)

	GetSpriteFromAtlas = var_21_0

	local var_21_2 = var_21_0("ui/Vote2023MainUI_atlas", "icon_billboard_" .. var_21_1)

	arg_21_0.billboardTr.sprite = var_21_2

	arg_21_0:UpdateBillboardTip()

	onButton = var_3

	local var_21_3 = arg_21_0
	local var_21_4 = arg_21_0.billboardTr.gameObject

	local function var_21_5()
		local var_22_0 = arg_21_0
		local var_22_1 = var_0.ShouldPlayBillboardStory(var_22_0)

		VoteStoryUtil = var_22_0

		local var_22_2 = var_22_0.Notify

		VoteStoryUtil = var_2_10002

		var_22_2(var_2_10002.ENTER_SCHEDULE)

		if var_22_1 then
			return
		end

		local var_22_3 = arg_21_0

		if not var_1.CheckPreheatStories(var_22_3) then
			return
		end

		local var_22_4 = arg_21_0
		local var_22_5 = var_1.emit

		VoteEntranceMediator = var_2_10003

		var_22_5(var_22_4, var_2_10003.ON_SCHEDULE)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_21_3, var_21_4, var_21_5, var_1_10007)

	return
end

function var_0_1.UpdateBillboardTip(arg_23_0)
	setActive = var_1_10001

	var_1_10001(arg_23_0.billboardTip, arg_23_0:ShouldTipBillboard())

	return
end

function var_0_1.UpdateHonorEntrance(arg_24_0)
	arg_24_0:UpdateHonorTip()

	onButton = var_1

	local var_24_0 = arg_24_0
	local var_24_1 = arg_24_0.honorTr.gameObject

	local function var_24_2()
		local var_25_0 = arg_24_0
		local var_25_1 = var_0.ShouldPlayHonorStory(var_25_0)

		VoteStoryUtil = var_25_0

		local var_25_2 = var_25_0.Notify

		VoteStoryUtil = var_2_10002

		var_25_2(var_2_10002.ENTER_HALL)

		if var_25_1 then
			return
		end

		local var_25_3 = arg_24_0

		if not var_1.CheckPreheatStories(var_25_3) then
			return
		end

		local var_25_4 = arg_24_0
		local var_25_5 = var_1.emit

		VoteEntranceMediator = var_2_10003

		var_25_5(var_25_4, var_2_10003.GO_HALL)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_24_0, var_24_1, var_24_2, var_1_10005)

	return
end

function var_0_1.UpdateHonorTip(arg_26_0)
	setActive = var_1_10001

	var_1_10001(arg_26_0.honorTip, arg_26_0:ShouldTipHonor())

	return
end

function var_0_1.onBackPressed(arg_27_0)
	if arg_27_0.awardWindowPage then
		local var_27_0 = arg_27_0.awardWindowPage

		if var_1.GetLoaded(var_27_0) then
			local var_27_1 = arg_27_0.awardWindowPage

			if var_1.isShowing(var_27_1) then
				local var_27_2 = arg_27_0.awardWindowPage

				var_1.Hide(var_27_2)

				return
			end
		end
	end

	var_0_1.super.onBackPressed(arg_27_0)

	return
end

function var_0_1.willExit(arg_28_0)
	if arg_28_0.awardWindowPage then
		local var_28_0 = arg_28_0.awardWindowPage

		var_1.Destroy(var_28_0)

		arg_28_0.awardWindowPage = nil
	end

	return
end

function var_0_1.ExistMainStageAward(arg_29_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10002

	local var_29_0 = var_1_10001(var_1_10002)

	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_29_1 = var_1_10002(var_1_10003)
	local var_29_2 = var_2.getActivityById

	ActivityConst = var_1_10004

	if not var_29_2(var_29_1, var_1_10004.VOTE_ENTRANCE_ACT_ID) or var_2:isEnd() then
		return false
	end

	local var_29_3

	if not var_2:getConfig("config_client")[2] then
		var_29_3 = -1
	end

	local var_29_4

	if not var_29_0:getTaskById(var_29_3) then
		var_29_4 = var_29_0:getFinishTaskById(var_29_3)
	end

	local var_29_5

	if var_29_4 and var_29_4:isFinish() then
		var_29_5 = not var_29_4:isReceive()
	end

	return var_29_5
end

function var_0_1.GetMainStageState(arg_30_0)
	if not arg_30_0.allPreheatStoriesPlayed then
		return var_0_1.MAIN_STAGE_CLOSE
	end

	getProxy = var_1
	VoteProxy = var_1_10002

	local var_30_0 = var_1(var_1_10002)
	local var_30_1 = not var_1.GetOpeningNonFunVoteGroup(var_30_0)

	getProxy = var_1_10003
	VoteProxy = var_1_10004

	local var_30_2 = var_1_10003(var_1_10004)

	if var_3.IsAllRaceEnd(var_30_2) then
		return var_0_1.MAIN_STAGE_END
	elseif var_1 then
		if var_1:isFinalsRace() then
			return var_0_1.MAIN_STAGE_FINAL
		else
			return var_0_1.MAIN_STAGE_OPEN
		end
	else
		return var_0_1.MAIN_STAGE_CLOSE
	end

	return
end

function var_0_1.ShouldTipMainStage(arg_31_0)
	if not arg_31_0.allPreheatStoriesPlayed then
		return arg_31_0:ShouldPlayMainStory()
	else
		if not (arg_31_0:GetVotes() > 0) then
			if not arg_31_0:IsNewMainRace() and not arg_31_0:ShouldPlayMainStory() then
				isActive = var_31_0

				local var_31_0 = var_31_0(arg_31_0.dropGetTr)
			end

			if false then
				var_31_0 = false
			end
		else
			var_31_0 = true
		end

		return var_31_0
	end

	return
end

function var_0_1.ShouldPlayMainStory(arg_32_0)
	VoteStoryUtil = var_1_10001

	local var_32_0 = var_1_10001.GetStoryNameByType

	VoteStoryUtil = var_1_10002

	local var_32_1 = var_32_0(var_1_10002.ENTER_MAIN_STAGE)

	if arg_32_0.voteActivity then
		local var_32_2 = arg_32_0.voteActivity
		local var_32_4

		if not var_32_4.isEnd(var_32_2) then
			pg = var_32_4

			local var_32_3 = var_32_4.NewStoryMgr.GetInstance()

			var_32_4 = not var_32_4.IsPlayed(var_32_3, var_32_1)
		else
			var_32_4 = false
		end
	end

	if false then
		var_32_4 = true
	end

	return var_32_4
end

function var_0_1.IsNewMainRace(arg_33_0)
	getProxy = var_1_10001
	VoteProxy = var_1_10002

	local var_33_0 = var_1_10001(var_1_10002)
	local var_33_1 = var_1.GetOpeningNonFunVoteGroup(var_33_0)

	getProxy = var_33_0
	VoteProxy = var_1_10003

	local var_33_2 = var_33_0(var_1_10003)

	return var_2.IsNewRace(var_33_2, var_33_1)
end

function var_0_1.MarkMainRaceNonNew(arg_34_0)
	getProxy = var_1_10001
	VoteProxy = var_1_10002

	local var_34_0 = var_1_10001(var_1_10002)
	local var_34_1 = var_1.GetOpeningNonFunVoteGroup(var_34_0)

	getProxy = var_34_0
	VoteProxy = var_1_10003

	local var_34_2 = var_34_0(var_1_10003)

	var_2.MarkRaceNonNew(var_34_2, var_34_1)

	return
end

function var_0_1.GetSubStageState(arg_35_0)
	if not arg_35_0.allPreheatStoriesPlayed then
		return var_0_1.SUB_STAGE_CLOSE
	end

	getProxy = var_1
	VoteProxy = var_1_10002

	local var_35_0 = var_1(var_1_10002)

	if var_1.GetOpeningFunVoteGroup(var_35_0) then
		if var_1:IsFunSireRace() then
			return var_0_1.SUB_STAGE_SIREN
		elseif var_1:IsFunMetaRace() then
			return var_0_1.SUB_STAGE_META
		elseif var_1:IsFunKidRace() then
			return var_0_1.SUB_STAGE_KID
		else
			assert = var_2

			var_2(false)
		end
	else
		return var_0_1.SUB_STAGE_CLOSE
	end

	return
end

function var_0_1.ShouldTipSubStage(arg_36_0)
	if not arg_36_0.allPreheatStoriesPlayed then
		return arg_36_0:ShouldPlaySubStory()
	else
		if not (arg_36_0:GetSubVotes() > 0) then
			if not arg_36_0:IsNewSubRace() then
				local var_36_0 = arg_36_0:ShouldPlaySubStory()
			end

			if false then
				var_36_0 = false
			end
		else
			var_36_0 = true
		end

		return var_36_0
	end

	return
end

function var_0_1.ShouldPlaySubStory(arg_37_0)
	VoteStoryUtil = var_1_10001

	local var_37_0 = var_1_10001.GetStoryNameByType

	VoteStoryUtil = var_1_10002

	local var_37_1 = var_37_0(var_1_10002.ENTER_SUB_STAGE)

	if arg_37_0.voteActivity then
		local var_37_2 = arg_37_0.voteActivity
		local var_37_4

		if not var_37_4.isEnd(var_37_2) then
			pg = var_37_4

			local var_37_3 = var_37_4.NewStoryMgr.GetInstance()

			var_37_4 = not var_37_4.IsPlayed(var_37_3, var_37_1)
		else
			var_37_4 = false
		end
	end

	if false then
		var_37_4 = true
	end

	return var_37_4
end

function var_0_1.IsNewSubRace(arg_38_0)
	getProxy = var_1_10001
	VoteProxy = var_1_10002

	local var_38_0 = var_1_10001(var_1_10002)
	local var_38_1 = var_1.GetOpeningFunVoteGroup(var_38_0)

	getProxy = var_38_0
	VoteProxy = var_1_10003

	local var_38_2 = var_38_0(var_1_10003)

	return var_2.IsNewRace(var_38_2, var_38_1)
end

function var_0_1.MarkSubRaceNonNew(arg_39_0)
	getProxy = var_1_10001
	VoteProxy = var_1_10002

	local var_39_0 = var_1_10001(var_1_10002)
	local var_39_1 = var_1.GetOpeningFunVoteGroup(var_39_0)

	getProxy = var_39_0
	VoteProxy = var_1_10003

	local var_39_2 = var_39_0(var_1_10003)

	var_2.MarkRaceNonNew(var_39_2, var_39_1)

	return
end

function var_0_1.GetExchangeState(arg_40_0)
	if not arg_40_0.allPreheatStoriesPlayed then
		return var_0_1.EXCHANGE_STAGE_CLOSE
	end

	getProxy = var_1
	VoteProxy = var_1_10002

	local var_40_0 = var_1(var_1_10002)

	if var_1.GetOpeningNonFunVoteGroup(var_40_0) then
		return var_0_1.EXCHANGE_STAGE_OPEN
	else
		return var_0_1.EXCHANGE_STAGE_CLOSE
	end

	return
end

function var_0_1.ShouldTipExchange(arg_41_0)
	return arg_41_0:ShouldPlayExchangeStory()
end

function var_0_1.ShouldPlayExchangeStory(arg_42_0)
	VoteStoryUtil = var_1_10001

	local var_42_0 = var_1_10001.GetStoryNameByType

	VoteStoryUtil = var_1_10002

	local var_42_1 = var_42_0(var_1_10002.ENTER_EXCHANGE)

	if arg_42_0.voteActivity then
		local var_42_2 = arg_42_0.voteActivity
		local var_42_4

		if not var_42_4.isEnd(var_42_2) then
			pg = var_42_4

			local var_42_3 = var_42_4.NewStoryMgr.GetInstance()

			var_42_4 = not var_42_4.IsPlayed(var_42_3, var_42_1)
		else
			var_42_4 = false
		end
	end

	if false then
		var_42_4 = true
	end

	return var_42_4
end

function var_0_1.GetBillboardState(arg_43_0)
	if not arg_43_0.allPreheatStoriesPlayed then
		return var_0_1.BILLBOARD_STAGE_NORMAL
	end

	getProxy = var_1
	VoteProxy = var_1_10002

	local var_43_0 = var_1(var_1_10002)

	if var_1.GetOpeningNonFunVoteGroup(var_43_0) and var_1:isFinalsRace() then
		return var_0_1.BILLBOARD_STAGE_FINAL
	else
		return var_0_1.BILLBOARD_STAGE_NORMAL
	end

	return
end

function var_0_1.ShouldTipBillboard(arg_44_0)
	return arg_44_0:ShouldPlayBillboardStory()
end

function var_0_1.ShouldPlayBillboardStory(arg_45_0)
	VoteStoryUtil = var_1_10001

	local var_45_0 = var_1_10001.GetStoryNameByType

	VoteStoryUtil = var_1_10002

	local var_45_1 = var_45_0(var_1_10002.ENTER_SCHEDULE)

	if arg_45_0.voteActivity then
		local var_45_2 = arg_45_0.voteActivity
		local var_45_4

		if not var_45_4.isEnd(var_45_2) then
			pg = var_45_4

			local var_45_3 = var_45_4.NewStoryMgr.GetInstance()

			var_45_4 = not var_45_4.IsPlayed(var_45_3, var_45_1)
		else
			var_45_4 = false
		end
	end

	if false then
		var_45_4 = true
	end

	return var_45_4
end

function var_0_1.ShouldTipHonor(arg_46_0)
	if not arg_46_0.allPreheatStoriesPlayed then
		var_1_10002 = arg_46_0

		return arg_46_0.ShouldPlayHonorStory(var_1_10002)
	else
		getProxy = var_1
		VoteProxy = var_1_10002

		local var_46_0 = var_1(var_1_10002)
		local var_46_1

		if not var_1.ExistPastVoteAward(var_46_0) then
			var_46_1 = arg_46_0:ShouldPlayHonorStory()
		end

		return var_46_1
	end

	return
end

function var_0_1.ShouldPlayHonorStory(arg_47_0)
	VoteStoryUtil = var_1_10001

	local var_47_0 = var_1_10001.GetStoryNameByType

	VoteStoryUtil = var_1_10002

	local var_47_1 = var_47_0(var_1_10002.ENTER_HALL)

	if arg_47_0.voteActivity then
		local var_47_2 = arg_47_0.voteActivity
		local var_47_4

		if not var_47_4.isEnd(var_47_2) then
			pg = var_47_4

			local var_47_3 = var_47_4.NewStoryMgr.GetInstance()

			var_47_4 = not var_47_4.IsPlayed(var_47_3, var_47_1)
		else
			var_47_4 = false
		end
	end

	if false then
		var_47_4 = true
	end

	return var_47_4
end

function var_0_1.GetVotes(arg_48_0)
	if arg_48_0:GetMainStageState() == var_0_1.MAIN_STAGE_OPEN or var_1 == var_0_1.MAIN_STAGE_FINAL then
		getProxy = var_2
		VoteProxy = var_1_10003

		local var_48_0 = var_2(var_1_10003)

		if var_2.GetOpeningNonFunVoteGroup(var_48_0) then
			getProxy = var_48_0
			VoteProxy = var_1_10004

			local var_48_1 = var_48_0(var_1_10004)
			local var_48_2

			if not var_3.GetVotesByConfigId(var_48_1, var_2.configId) then
				var_48_2 = 0
			end

			do return var_48_2 end
			return 0
		end
	end
end

function var_0_1.GetSubVotes(arg_49_0)
	local var_49_0 = var_0_1.SUB_STAGE_CLOSE
	local var_49_1 = arg_49_0

	if var_49_0 ~= arg_49_0.GetSubStageState(var_49_1) then
		getProxy = var_49_0
		VoteProxy = var_2

		local var_49_2 = var_49_0(var_2)

		if var_1.GetOpeningFunVoteGroup(var_49_2) then
			getProxy = var_49_2
			VoteProxy = var_49_1

			local var_49_3 = var_49_2(var_49_1)
			local var_49_4

			if not var_2.GetVotesByConfigId(var_49_3, var_1.configId) then
				var_49_4 = 0
			end

			do return var_49_4 end

			if false then
				return 0
			end

			return
		end
	end
end

function var_0_1.CheckPreheatStories(arg_50_0)
	if not arg_50_0.allPreheatStoriesPlayed then
		pg = var_1

		local var_50_0 = var_1.NewGuideMgr.GetInstance()

		var_1.Play(var_50_0, "NG0043")

		return false
	end

	return true
end

return var_0_1
