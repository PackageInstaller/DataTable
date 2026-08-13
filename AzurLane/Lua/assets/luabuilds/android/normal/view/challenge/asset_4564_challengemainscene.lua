class = var_0_10000

local var_0_0 = "ChallengeMainScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

var_0_1.BOSS_NUM = 5
var_0_1.FADE_TIME = 5

function var_0_1.getUIName(arg_1_0)
	return "ChallengeMainUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:findUI()
	arg_2_0:initData()
	arg_2_0:addListener()

	return
end

function var_0_1.didEnter(arg_3_0)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.updateGrade
	local var_3_2 = arg_3_0.challengeInfo

	var_3_1(var_3_0, var_3.getGradeList(var_3_2))
	arg_3_0:updateTimePanel()
	arg_3_0:updateSwitchModBtn()
	arg_3_0:updateAwardPanel()
	arg_3_0:updatePaintingList(arg_3_0.nameList, arg_3_0.showingIndex)
	arg_3_0:updateRoundText(arg_3_0.showingIndex)
	arg_3_0:updateSlider(arg_3_0.showingIndex)
	arg_3_0:updateFuncBtns()
	arg_3_0:showSLResetMsgBox()

	if arg_3_0.contextData.editFleet then
		arg_3_0:doOnFleetPanel()

		arg_3_0.contextData.editFleet = nil
	end

	arg_3_0:tryPlayGuide()

	return
end

function var_0_1.willExit(arg_4_0)
	LeanTween = var_1_10001

	local var_4_0 = var_1_10001.cancel

	go = var_1_10002

	var_4_0(var_1_10002(arg_4_0.modTipTF))

	if arg_4_0.timer then
		local var_4_1 = arg_4_0.timer

		var_1.Stop(var_4_1)
	end

	arg_4_0:destroyCommanderPanel()

	return
end

function var_0_1.onBackPressed(arg_5_0)
	isActive = var_1_10001

	if var_1_10001(arg_5_0.fleetSelect) then
		arg_5_0:hideFleetEdit()
	else
		triggerButton = var_1

		var_1(arg_5_0.backBtn)
	end

	return
end

function var_0_1.setFleet(arg_6_0, arg_6_1)
	arg_6_0.fleets = {}

	local function var_6_0(arg_7_0)
		arg_6_0.fleets[arg_7_0] = {
			arg_6_1[arg_7_0 + 1],
			[11] = arg_6_1[arg_7_0 + 11]
		}

		return
	end

	ChallengeProxy = var_1_10004

	var_6_0(var_1_10004.MODE_CASUAL)

	local var_6_1 = var_2

	ChallengeProxy = var_4

	var_6_1(var_4.MODE_INFINITE)

	return
end

function var_0_1.findUI(arg_8_0)
	local var_8_0 = arg_8_0._tf

	arg_8_0.northTF = var_1.Find(var_8_0, "ForNorth")

	local var_8_1 = arg_8_0._tf

	arg_8_0.paintingListTF = var_1.Find(var_8_1, "PaintingList")

	local var_8_2 = arg_8_0.northTF

	arg_8_0.backBtn = var_1.Find(var_8_2, "top/back_button")

	local var_8_3 = arg_8_0.northTF

	arg_8_0.gradeContainer = var_1.Find(var_8_3, "GradeContainer")

	local var_8_4 = arg_8_0.gradeContainer

	arg_8_0.seasonBestPointText = var_1.Find(var_8_4, "SeasonBestPoint/Text")

	local var_8_5 = arg_8_0.gradeContainer

	arg_8_0.activityBestPointText = var_1.Find(var_8_5, "ActivityBestPoint/Text")

	local var_8_6 = arg_8_0.gradeContainer

	arg_8_0.seasonLevelNumText = var_1.Find(var_8_6, "SeasonLevelNum/Text")

	local var_8_7 = arg_8_0.gradeContainer

	arg_8_0.activityLevelNumText = var_1.Find(var_8_7, "ActivityLevelNum/Text")

	local var_8_8 = arg_8_0.northTF

	arg_8_0.timeTipTF = var_1.Find(var_8_8, "TimeTip")

	local var_8_9 = arg_8_0.timeTipTF

	arg_8_0.activityTimeText = var_1.Find(var_8_9, "ActivityTimeText")

	local var_8_10 = arg_8_0.timeTipTF

	arg_8_0.seasonDayText = var_1.Find(var_8_10, "SeasonTipText/DayText")

	local var_8_11 = arg_8_0.timeTipTF

	arg_8_0.seasonTimeText = var_1.Find(var_8_11, "SeasonTimeText")

	local var_8_12 = arg_8_0.northTF

	arg_8_0.switchModTF = var_1.Find(var_8_12, "SwitchMod")

	local var_8_13 = arg_8_0.switchModTF

	arg_8_0.casualModBtn = var_1.Find(var_8_13, "NormalBtn")

	local var_8_14 = arg_8_0.switchModTF

	arg_8_0.infiniteModBtn = var_1.Find(var_8_14, "EndlessBtn")

	local var_8_15 = arg_8_0.casualModBtn

	arg_8_0.casualModBtnBG = var_1.Find(var_8_15, "BG")

	local var_8_16 = arg_8_0.infiniteModBtn

	arg_8_0.infiniteModBtnBG = var_1.Find(var_8_16, "BG")
	GetComponent = var_1
	arg_8_0.casualModBtnSC = var_1(arg_8_0.casualModBtn, "Button")
	GetComponent = var_1
	arg_8_0.infiniteModBtnSC = var_1(arg_8_0.infiniteModBtn, "Button")

	local var_8_17 = arg_8_0.northTF

	arg_8_0.functionBtnsTF = var_1.Find(var_8_17, "FunctionBtns")

	local var_8_18 = arg_8_0.functionBtnsTF

	arg_8_0.rankBtn = var_1.Find(var_8_18, "RankBtn")

	local var_8_19 = arg_8_0.functionBtnsTF

	arg_8_0.startBtn = var_1.Find(var_8_19, "StartBtn")

	local var_8_20 = arg_8_0.functionBtnsTF

	arg_8_0.resetBtn = var_1.Find(var_8_20, "ResetBtn")

	local var_8_21 = arg_8_0.functionBtnsTF

	arg_8_0.startBtnBanned = var_1.Find(var_8_21, "StartBtnBanned")

	local var_8_22 = arg_8_0.functionBtnsTF

	arg_8_0.resetBtnBanned = var_1.Find(var_8_22, "ResetBtnBanned")

	local var_8_23 = arg_8_0.northTF

	arg_8_0.awardTF = var_1.Find(var_8_23, "Award")

	local var_8_24 = arg_8_0.awardTF

	arg_8_0.helpBtn = var_1.Find(var_8_24, "HelpBtn")

	local var_8_25 = arg_8_0.awardTF

	arg_8_0.getBtn = var_1.Find(var_8_25, "GetBtn")

	local var_8_26 = arg_8_0.awardTF

	arg_8_0.gotBtn = var_1.Find(var_8_26, "GotBtn")

	local var_8_27 = arg_8_0.awardTF

	arg_8_0.getBtnBanned = var_1.Find(var_8_27, "GetBtnBanned")

	local var_8_28 = arg_8_0.awardTF

	arg_8_0.itemTF = var_1.Find(var_8_28, "ItemBG/item")

	local var_8_29 = arg_8_0.awardTF

	arg_8_0.scoreText = var_1.Find(var_8_29, "Score/ScoreText")

	local var_8_30 = arg_8_0.northTF

	arg_8_0.slider = var_1.Find(var_8_30, "Slider")

	local var_8_31 = arg_8_0.slider

	arg_8_0.squareContainer = var_1.Find(var_8_31, "SquareList")

	local var_8_32 = arg_8_0.slider

	arg_8_0.squareTpl = var_1.Find(var_8_32, "Squre")
	UIItemList = var_1
	arg_8_0.squareList = var_1.New(arg_8_0.squareContainer, arg_8_0.squareTpl)
	GetComponent = var_1
	arg_8_0.sliderSC = var_1(arg_8_0.slider, "Slider")

	local var_8_33 = arg_8_0._tf

	arg_8_0.paintingContainer = var_1.Find(var_8_33, "PaintingList")
	GetComponent = var_1
	arg_8_0.scrollSC = var_1(arg_8_0.paintingContainer, "Slider")

	local var_8_34 = arg_8_0._tf
	local var_8_35 = var_1.Find(var_8_34, "material")
	local var_8_36 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_8_0.material = var_8_36(var_8_35, var_3(var_1_10004)).material

	local var_8_37 = arg_8_0._tf
	local var_8_38 = var_1.Find(var_8_37, "material1")
	local var_8_39 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_8_0.material1 = var_8_39(var_8_38, var_3(var_1_10004)).material

	local var_8_40 = arg_8_0.paintingContainer

	arg_8_0.painting = var_1.Find(var_8_40, "Painting")

	local var_8_41 = arg_8_0.painting

	arg_8_0.paintingShadow1 = var_1.Find(var_8_41, "PaintingShadow1")

	local var_8_42 = arg_8_0.painting

	arg_8_0.paintingShadow2 = var_1.Find(var_8_42, "PaintingShadow2")

	local var_8_43 = arg_8_0.painting

	arg_8_0.bossInfoImg = var_1.Find(var_8_43, "InfoImg")

	local var_8_44 = arg_8_0.painting

	arg_8_0.roundNumText = var_1.Find(var_8_44, "Round/NumText")

	local var_8_45 = arg_8_0.painting

	arg_8_0.completeEffectTF = var_1.Find(var_8_45, "TZ02")
	SetActive = var_1

	var_1(arg_8_0.completeEffectTF, false)

	local var_8_46 = arg_8_0.paintingContainer

	arg_8_0.card1TF = var_1.Find(var_8_46, "Card1")

	local var_8_47 = arg_8_0.card1TF

	arg_8_0.shipPaintImg_1 = var_1.Find(var_8_47, "Mask/ShipPaint")

	local var_8_48 = arg_8_0.card1TF

	arg_8_0.tag_1 = var_1.Find(var_8_48, "Tag")

	local var_8_49 = arg_8_0.card1TF

	arg_8_0.mask_1 = var_1.Find(var_8_49, "Mask")

	local var_8_50 = arg_8_0.card1TF

	arg_8_0.roundTF_1 = var_1.Find(var_8_50, "Round")

	local var_8_51 = arg_8_0.card1TF

	arg_8_0.roundText_1 = var_1.Find(var_8_51, "Round/RoundText")

	local var_8_52 = arg_8_0.paintingContainer

	arg_8_0.card2TF = var_1.Find(var_8_52, "Card2")

	local var_8_53 = arg_8_0.card2TF

	arg_8_0.shipPaintImg_2 = var_1.Find(var_8_53, "Mask/ShipPaint")

	local var_8_54 = arg_8_0.card2TF

	arg_8_0.tag_2 = var_1.Find(var_8_54, "Tag")

	local var_8_55 = arg_8_0.card2TF

	arg_8_0.mask_2 = var_1.Find(var_8_55, "Mask")

	local var_8_56 = arg_8_0.card2TF

	arg_8_0.roundTF_2 = var_1.Find(var_8_56, "Round")

	local var_8_57 = arg_8_0.card2TF

	arg_8_0.roundText_2 = var_1.Find(var_8_57, "Round/RoundText")

	local var_8_58 = arg_8_0.northTF

	arg_8_0.modTipBtn = var_1.Find(var_8_58, "ModTipBtn")

	local var_8_59 = arg_8_0.northTF

	arg_8_0.modTipTF = var_1.Find(var_8_59, "TipText")

	local var_8_60 = arg_8_0.modTipTF

	arg_8_0.modTipText = var_1.Find(var_8_60, "Text")
	setActive = var_1

	var_1(arg_8_0.modTipTF, false)

	local var_8_61 = arg_8_0._tf

	arg_8_0.fleetSelect = var_1.Find(var_8_61, "LevelFleetSelectView")
	ActivityFleetPanel = var_1
	arg_8_0.fleetEditPanel = var_1.New(arg_8_0.fleetSelect.gameObject)

	function arg_8_0.fleetEditPanel.onCancel()
		local var_9_0 = arg_8_0

		var_0.hideFleetEdit(var_9_0)

		return
	end

	function arg_8_0.fleetEditPanel.onCommit()
		local var_10_0 = arg_8_0

		var_0.commitEdit(var_10_0)

		return
	end

	function arg_8_0.fleetEditPanel.onCombat()
		local var_11_0 = arg_8_0

		var_0.commitEdit(var_11_0)

		local var_11_1 = arg_8_0
		local var_11_2 = var_0.emit

		ChallengeMainMediator = var_2_10002

		var_11_2(var_11_1, var_2_10002.ON_PRECOMBAT, arg_8_0.curMode)

		return
	end

	function arg_8_0.fleetEditPanel.onLongPressShip(arg_12_0, arg_12_1)
		local var_12_0 = arg_8_0

		var_2.openShipInfo(var_12_0, arg_12_0, arg_12_1)

		return
	end

	arg_8_0:buildCommanderPanel()

	return
end

function var_0_1.tryPlayGuide(arg_13_0)
	pg = var_1_10001

	local var_13_0 = var_1_10001.SystemGuideMgr.GetInstance()

	var_1.Play(var_13_0, arg_13_0)

	return
end

function var_0_1.initData(arg_14_0)
	getProxy = var_1_10001
	ChallengeProxy = var_1_10002
	arg_14_0.challengeProxy = var_1_10001(var_1_10002)

	local var_14_0 = arg_14_0.challengeProxy

	arg_14_0.challengeInfo = var_1.getChallengeInfo(var_14_0)

	local var_14_1 = arg_14_0.challengeProxy

	arg_14_0.userChallengeInfoList = var_1.getUserChallengeInfoList(var_14_1)
	arg_14_0.timeOverTag = false

	arg_14_0:updateData()

	arg_14_0.openedCommanerSystem = true

	return
end

function var_0_1.addListener(arg_15_0)
	onButton = var_1_10001

	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.backBtn

	local function var_15_2()
		local var_16_0 = arg_15_0

		var_0.emit(var_16_0, var_0_1.ON_BACK)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_15_0, var_15_1, var_15_2, var_1_10005)

	onButton = var_1_10001

	local var_15_3 = arg_15_0
	local var_15_4 = arg_15_0.helpBtn

	local function var_15_5()
		pg = var_2_10000

		local var_17_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_17_1 = var_0.ShowMsgBox
		local var_17_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_17_2.type = var_2_10003
		pg = var_2_10003
		var_17_2.helps = var_2_10003.gametip.challenge_help.tip

		var_17_1(var_17_0, var_17_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_15_3, var_15_4, var_15_5, var_1_10005)

	onButton = var_1_10001

	local var_15_6 = arg_15_0
	local var_15_7 = arg_15_0.rankBtn

	local function var_15_8()
		local var_18_0 = arg_15_0
		local var_18_1 = var_0.emit

		ChallengeMainMediator = var_2_10002

		var_18_1(var_18_0, var_2_10002.ON_OPEN_RANK)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_15_6, var_15_7, var_15_8, var_1_10005)

	onButton = var_1_10001

	local var_15_9 = arg_15_0
	local var_15_10 = arg_15_0.startBtn

	local function var_15_11()
		getProxy = var_2_10000
		ActivityProxy = var_2_10001

		local var_19_0 = var_2_10000(var_2_10001)
		local var_19_1 = var_0.getActivityByType

		ActivityConst = var_2_10002

		if not var_19_1(var_19_0, var_2_10002.ACTIVITY_TYPE_CHALLENGE) or var_0:isEnd() then
			pg = var_19_0

			local var_19_2 = var_19_0.TipsMgr.GetInstance()
			local var_19_3 = var_1.ShowTips

			i18n = var_2_10003

			var_19_3(var_19_2, var_2_10003("challenge_end_tip"))

			triggerButton = var_19_3

			var_19_3(arg_15_0.backBtn)

			return
		end

		local var_19_4 = arg_15_0

		if var_1.isCrossedSeason(var_19_4) == true then
			local var_19_5 = arg_15_0.challengeProxy
			local var_19_6 = var_1.getCurMode(var_19_5)
			local var_19_7

			if not arg_15_0.curModeInfo then
				pg = var_19_7
				var_2_10003 = var_19_7.MsgboxMgr.GetInstance()
				var_19_7 = var_19_7.ShowMsgBox
				var_2_10004 = {
					hideNo = true
				}
				i18n = var_2_10005
				var_2_10004.content = var_2_10005("challenge_season_update")

				function var_2_10004.onYes()
					local var_20_0 = arg_15_0
					local var_20_1 = var_0.emit

					ChallengeConst = var_3_10002

					var_20_1(var_20_0, var_3_10002.RESET_DATA_EVENT, var_19_6)

					return
				end

				function var_2_10004.onNo()
					local var_21_0 = arg_15_0
					local var_21_1 = var_0.emit

					ChallengeConst = var_3_10002

					var_21_1(var_21_0, var_3_10002.RESET_DATA_EVENT, var_19_6)

					return
				end

				var_19_7(var_2_10003, var_2_10004)

				do return end

				goto label_19_0
			end

			ChallengeProxy = var_19_7

			local var_19_8 = var_19_6 == var_19_7.MODE_CASUAL and "challenge_season_update_casual_clear" or "challenge_season_update_infinite_clear"

			ChallengeProxy = var_2_10003

			if var_19_6 == var_2_10003.MODE_CASUAL then
				var_2_10004 = arg_15_0.curModeInfo

				if not var_2_10003.getScore(var_2_10004) then
					var_2_10004 = arg_15_0.curModeInfo
					var_2_10003 = var_2_10003.getLevel(var_2_10004)
				end

				pg = var_2_10004

				do
					local var_19_9 = var_2_10004.MsgboxMgr.GetInstance()
					local var_19_10 = var_4.ShowMsgBox
					local var_19_11 = {
						hideNo = false
					}

					i18n = var_2_10007
					var_19_11.content = var_2_10007(var_19_8, var_2_10003)

					function var_19_11.onNo()
						local var_22_0 = arg_15_0
						local var_22_1 = var_0.emit

						ChallengeConst = var_3_10002

						var_22_1(var_22_0, var_3_10002.RESET_DATA_EVENT, var_19_6)

						return
					end

					function var_19_11.onYes()
						local var_23_0 = arg_15_0
						local var_23_1 = var_0.emit

						ChallengeMainMediator = var_3_10002

						var_23_1(var_23_0, var_3_10002.ON_PRECOMBAT, arg_15_0.curMode)

						return
					end

					var_19_10(var_19_9, var_19_11)

					return
				end

				::label_19_0::

				if not arg_15_0.curModeInfo then
					local var_19_12 = arg_15_0

					var_1.doOnFleetPanel(var_19_12)

					return
				end

				local var_19_13 = arg_15_0
				local var_19_14 = var_1.emit

				ChallengeMainMediator = var_2_10003

				var_19_14(var_19_13, var_2_10003.ON_PRECOMBAT, arg_15_0.curMode)

				return
			end
		end
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_15_9, var_15_10, var_15_11, var_1_10005)

	onButton = var_1_10001

	local var_15_12 = arg_15_0
	local var_15_13 = arg_15_0.resetBtn

	local function var_15_14()
		pg = var_2_10000

		local var_24_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_24_1 = var_0.ShowMsgBox
		local var_24_2 = {
			hideNo = false
		}

		i18n = var_2_10003
		var_24_2.content = var_2_10003("challenge_normal_reset")

		function var_24_2.onYes()
			local var_25_0 = arg_15_0
			local var_25_1 = var_0.emit

			ChallengeConst = var_3_10002

			local var_25_2 = var_3_10002.RESET_DATA_EVENT
			local var_25_3 = arg_15_0.challengeProxy

			var_25_1(var_25_0, var_25_2, var_3.getCurMode(var_25_3))

			return
		end

		var_24_1(var_24_0, var_24_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_15_12, var_15_13, var_15_14, var_1_10005)

	onButton = var_1_10001

	var_1_10001(arg_15_0, arg_15_0.modTipBtn, function()
		local var_26_0 = arg_15_0

		var_0.showTipText(var_26_0)

		return
	end)

	local function var_15_15()
		local var_27_0 = arg_15_0.showingIndex

		ChallengeConst = var_2_10001

		if var_27_0 % var_2_10001.BOSS_NUM == 1 then
			return
		end

		arg_15_0.showingIndex = arg_15_0.showingIndex - 1

		local var_27_1 = arg_15_0

		var_0.updatePaintingList(var_27_1, arg_15_0.nameList, arg_15_0.showingIndex)

		local var_27_2 = arg_15_0

		var_0.updateRoundText(var_27_2, arg_15_0.showingIndex)

		local var_27_3 = arg_15_0

		var_0.updateSlider(var_27_3, arg_15_0.showingIndex)

		return
	end

	local function var_15_16()
		local var_28_0 = arg_15_0.showingIndex

		ChallengeConst = var_2_10001

		if var_28_0 % var_2_10001.BOSS_NUM == 0 then
			return
		end

		arg_15_0.showingIndex = arg_15_0.showingIndex + 1

		local var_28_1 = arg_15_0

		var_0.updatePaintingList(var_28_1, arg_15_0.nameList, arg_15_0.showingIndex)

		local var_28_2 = arg_15_0

		var_0.updateRoundText(var_28_2, arg_15_0.showingIndex)

		local var_28_3 = arg_15_0

		var_0.updateSlider(var_28_3, arg_15_0.showingIndex)

		return
	end

	addSlip = var_3
	SLIP_TYPE_HRZ = var_4

	var_3(var_4, arg_15_0.paintingContainer, var_15_15, var_15_16)

	return
end

function var_0_1.updateData(arg_29_0)
	local var_29_0 = arg_29_0.challengeProxy

	arg_29_0.curMode = var_1.getCurMode(var_29_0)
	arg_29_0.curModeInfo = arg_29_0.userChallengeInfoList[arg_29_0.curMode]
	arg_29_0.timeOverTag = false

	if not arg_29_0.curModeInfo then
		arg_29_0.curLevel = 1
		arg_29_0.showingIndex = arg_29_0.curLevel

		local var_29_1 = arg_29_0.curMode

		ChallengeProxy = var_2

		local var_29_2

		if var_29_1 == var_2.MODE_CASUAL then
			var_29_2 = arg_29_0.challengeInfo
			arg_29_0.dungeonIDList = var_1.getDungeonIDList(var_29_2)
		else
			local var_29_3 = arg_29_0.curMode

			ChallengeProxy = var_29_2

			if var_29_3 == var_29_2.MODE_INFINITE then
				local var_29_4 = arg_29_0.challengeInfo
				local var_29_5 = var_1.getSeasonID(var_29_4)
				local var_29_6 = arg_29_0.challengeInfo
				local var_29_7 = var_2.getActivityIndex(var_29_6)

				pg = var_29_6
				arg_29_0.dungeonIDList = var_29_6.activity_event_challenge[var_29_7].infinite_stage[var_29_5][1]
			end
		end
	else
		local var_29_8 = arg_29_0.curModeInfo

		arg_29_0.curLevel = var_1.getLevel(var_29_8)
		arg_29_0.showingIndex = arg_29_0.curLevel

		local var_29_9 = arg_29_0.curModeInfo

		arg_29_0.dungeonIDList = var_1.getDungeonIDList(var_29_9)
	end

	arg_29_0.nameList = {}
	arg_29_0.infoNameList = {}
	ipairs = var_1

	for iter_29_0, iter_29_1 in var_1(arg_29_0.dungeonIDList) do
		pg = var_1_10006
		var_1_10006 = var_1_10006.expedition_challenge_template[iter_29_1].char_icon[1]
		var_1_10007 = arg_29_0.nameList
		var_1_10007[iter_29_0] = var_1_10006
		pg = var_1_10007
		var_1_10007 = var_1_10007.expedition_challenge_template[iter_29_1].name_p
		arg_29_0.infoNameList[iter_29_0] = var_1_10007
	end

	arg_29_0.nextNameList = {}

	local var_29_10 = arg_29_0.curMode

	ChallengeProxy = var_2

	if var_29_10 == var_2.MODE_INFINITE then
		local var_29_11
		local var_29_14

		if arg_29_0.curModeInfo then
			local var_29_12 = arg_29_0.curModeInfo

			var_29_11 = var_29_14.getNextInfiniteDungeonIDList(var_29_12)
		else
			local var_29_13 = arg_29_0.challengeInfo

			var_29_14 = var_29_14.getSeasonID(var_29_13)

			local var_29_15 = arg_29_0.challengeInfo
			local var_29_16 = var_3.getActivityIndex(var_29_15)

			pg = var_29_15

			if var_29_15.activity_event_challenge[var_29_16].infinite_stage[var_29_14][2] then
				pg = var_4
				var_29_11 = var_4.activity_event_challenge[var_29_16].infinite_stage[var_29_14][2]
			else
				pg = var_4
				var_29_11 = var_4.activity_event_challenge[var_29_16].infinite_stage[var_29_14][1]
			end
		end

		ipairs = var_29_14

		for iter_29_2, iter_29_3 in var_29_14(var_29_11) do
			pg = var_1_10007
			var_1_10007 = var_1_10007.expedition_challenge_template[iter_29_3].char_icon[1]

			local var_29_17 = arg_29_0.nextNameList

			ChallengeConst = var_1_10009
			var_29_17[iter_29_2 + var_1_10009.BOSS_NUM] = var_1_10007
		end
	end

	return
end

function var_0_1.updatePaintingList(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_1 or arg_30_0.nameList
	local var_30_1 = arg_30_2 or arg_30_0.showingIndex
	local var_30_2 = arg_30_0.curLevel

	ChallengeConst = var_1_10006

	if var_1_10006.BOSS_NUM < var_30_1 then
		ChallengeConst = var_6

		if var_30_1 % var_6.BOSS_NUM == 0 then
			ChallengeConst = var_6

			if not var_6.BOSS_NUM then
				::label_30_0::

				ChallengeConst = var_6
				var_30_1 = var_30_1 % var_6.BOSS_NUM
			end

			local var_30_3 = arg_30_0.curMode

			ChallengeProxy = var_1_10007

			if var_30_3 == var_1_10007.MODE_INFINITE then
				ChallengeConst = var_30_3

				if var_30_3.BOSS_NUM < var_30_2 then
					ChallengeConst = var_6

					if var_30_2 % var_6.BOSS_NUM == 0 then
						ChallengeConst = var_6

						if not var_6.BOSS_NUM then
							::label_30_1::

							ChallengeConst = var_6
							var_30_2 = var_30_2 % var_6.BOSS_NUM
						end

						local function var_30_4(arg_31_0)
							local var_31_0 = arg_31_0.material

							var_1.SetFloat(var_31_0, "_LineGray", 0.3)

							local var_31_1 = arg_31_0.material

							var_1.SetFloat(var_31_1, "_TearDistance", 0)

							LeanTween = var_1

							var_1.cancel(arg_31_0.gameObject)

							LeanTween = var_1

							local var_31_2 = var_1.value(arg_31_0.gameObject, 0, 2, 2)
							local var_31_3 = var_1.setLoopClamp(var_31_2)
							local var_31_4 = var_1.setOnUpdate

							System = var_3

							var_31_4(var_31_3, var_3.Action_float(function(arg_32_0)
								if arg_32_0 >= 1.2 then
									local var_32_0 = arg_31_0.material

									var_1.SetFloat(var_32_0, "_LineGray", 0.3)
								elseif arg_32_0 >= 1.1 then
									local var_32_1 = arg_31_0.material

									var_1.SetFloat(var_32_1, "_LineGray", 0.45)
								elseif arg_32_0 >= 1.03 then
									local var_32_2 = arg_31_0.material

									var_1.SetFloat(var_32_2, "_TearDistance", 0)
								elseif arg_32_0 >= 1 then
									local var_32_3 = arg_31_0.material

									var_1.SetFloat(var_32_3, "_TearDistance", 0.3)
								elseif arg_32_0 >= 0.35 then
									local var_32_4 = arg_31_0.material

									var_1.SetFloat(var_32_4, "_LineGray", 0.3)
								elseif arg_32_0 >= 0.3 then
									local var_32_5 = arg_31_0.material

									var_1.SetFloat(var_32_5, "_LineGray", 0.4)
								elseif arg_32_0 >= 0.25 then
									local var_32_6 = arg_31_0.material

									var_1.SetFloat(var_32_6, "_LineGray", 0.3)
								elseif arg_32_0 >= 0.2 then
									local var_32_7 = arg_31_0.material

									var_1.SetFloat(var_32_7, "_LineGray", 0.4)
								end

								return
							end))

							return
						end

						setPaintingPrefabAsync = var_7

						var_7(arg_30_0.painting, var_30_0[var_30_1], "chuanwu", function()
							local var_33_0 = arg_30_0.painting
							local var_33_1 = var_0.Find(var_33_0, "fitter")

							if var_0.GetChild(var_33_1, 0) then
								GetComponent = var_33_1

								local var_33_2 = var_33_1(var_0, "MeshImage")
								local var_33_3 = var_30_2 - 1 - var_30_1
								local var_33_4 = 0 <= var_33_3

								SetActive = var_3

								var_3(arg_30_0.completeEffectTF, var_33_4)

								if var_33_4 then
									var_33_2.material = arg_30_0.material1

									local var_33_5 = var_33_2.material

									var_3.SetFloat(var_33_5, "_LineDensity", 7)
									var_30_4(var_33_2)
								else
									var_33_2.material = arg_30_0.material

									local var_33_6 = var_33_2.material

									var_3.SetFloat(var_33_6, "_Range", 16)

									local var_33_7 = var_33_2.material

									var_3.SetFloat(var_33_7, "_Degree", 7)
								end
							end

							return
						end)

						setPaintingPrefabAsync = var_7

						var_7(arg_30_0.paintingShadow1, var_30_0[var_30_1], "chuanwu", function()
							local var_34_0 = arg_30_0.paintingShadow1
							local var_34_1 = var_0.Find(var_34_0, "fitter")

							if var_0.GetChild(var_34_1, 0) then
								local var_34_2 = var_0
								local var_34_3 = var_0.GetComponent(var_34_2, "Image")

								Color = var_34_2
								var_34_3.color = var_34_2.New(0, 0, 0, 0.44)
							end

							return
						end)

						setPaintingPrefabAsync = var_7

						var_7(arg_30_0.paintingShadow2, var_30_0[var_30_1], "chuanwu", function()
							local var_35_0 = arg_30_0.paintingShadow2
							local var_35_1 = var_0.Find(var_35_0, "fitter")

							if var_0.GetChild(var_35_1, 0) then
								local var_35_2 = var_0
								local var_35_3 = var_0.GetComponent(var_35_2, "Image")

								Color = var_35_2
								var_35_3.color = var_35_2.New(1, 1, 1, 0.15)
							end

							return
						end)

						LoadSpriteAsync = var_7

						var_7("ChallengeBossInfo/" .. arg_30_0.infoNameList[var_30_1], function(arg_36_0)
							setImageSprite = var_2_10001

							var_2_10001(arg_30_0.bossInfoImg, arg_36_0, true)

							return
						end)

						if var_0_1.BOSS_NUM - var_30_1 >= 2 then
							setActive = var_7

							var_7(arg_30_0.roundTF_1, true)

							setActive = var_7

							var_7(arg_30_0.roundTF_2, true)

							setActive = var_7

							var_7(arg_30_0.mask_1, true)

							setActive = var_7

							var_7(arg_30_0.mask_2, true)

							LoadSpriteAsync = var_7

							var_7("shipYardIcon/" .. var_30_0[var_30_1 + 1], function(arg_37_0)
								setImageSprite = var_2_10001

								var_2_10001(arg_30_0.shipPaintImg_1, arg_37_0)

								return
							end)

							LoadSpriteAsync = var_7

							var_7("shipYardIcon/" .. var_30_0[var_30_1 + 2], function(arg_38_0)
								setImageSprite = var_2_10001

								var_2_10001(arg_30_0.shipPaintImg_2, arg_38_0)

								return
							end)
						else
							local var_30_5

							if var_0_1.BOSS_NUM - var_30_1 == 1 then
								setActive = var_30_5

								var_30_5(arg_30_0.roundTF_1, true)

								setActive = var_30_5

								var_30_5(arg_30_0.roundTF_2, false)

								setActive = var_30_5

								var_30_5(arg_30_0.mask_1, true)

								setActive = var_30_5

								var_30_5(arg_30_0.mask_2, false)

								LoadSpriteAsync = var_30_5

								var_30_5("shipYardIcon/" .. var_30_0[var_30_1 + 1], function(arg_39_0)
									setImageSprite = var_2_10001

									var_2_10001(arg_30_0.shipPaintImg_1, arg_39_0)

									return
								end)

								var_30_5 = arg_30_0.curMode
								ChallengeProxy = var_8

								if var_30_5 == var_8.MODE_INFINITE then
									LoadSpriteAsync = var_30_5

									var_30_5("shipYardIcon/" .. arg_30_0.nextNameList[var_30_1 + 2], function(arg_40_0)
										setImageSprite = var_2_10001

										var_2_10001(arg_30_0.shipPaintImg_2, arg_40_0)

										setActive = var_2_10001

										var_2_10001(arg_30_0.mask_2, true)

										setActive = var_2_10001

										var_2_10001(arg_30_0.roundTF_2, true)

										return
									end)
								end
							else
								setActive = var_30_5

								var_30_5(arg_30_0.roundTF_1, false)

								setActive = var_30_5

								var_30_5(arg_30_0.roundTF_2, false)

								setActive = var_30_5

								var_30_5(arg_30_0.mask_1, false)

								setActive = var_30_5

								var_30_5(arg_30_0.mask_2, false)

								local var_30_6 = arg_30_0.curMode

								ChallengeProxy = var_8

								if var_30_6 == var_8.MODE_INFINITE then
									LoadSpriteAsync = var_30_6

									var_30_6("shipYardIcon/" .. arg_30_0.nextNameList[var_30_1 + 1], function(arg_41_0)
										setImageSprite = var_2_10001

										var_2_10001(arg_30_0.shipPaintImg_1, arg_41_0)

										setActive = var_2_10001

										var_2_10001(arg_30_0.mask_1, true)

										setActive = var_2_10001

										var_2_10001(arg_30_0.roundTF_1, true)

										return
									end)

									LoadSpriteAsync = var_30_6

									var_30_6("shipYardIcon/" .. arg_30_0.nextNameList[var_30_1 + 2], function(arg_42_0)
										setImageSprite = var_2_10001

										var_2_10001(arg_30_0.shipPaintImg_2, arg_42_0)

										setActive = var_2_10001

										var_2_10001(arg_30_0.mask_2, true)

										setActive = var_2_10001

										var_2_10001(arg_30_0.roundTF_2, true)

										return
									end)
								end
							end
						end

						if var_30_2 - 1 - var_30_1 >= 2 then
							setActive = var_7

							var_7(arg_30_0.tag_1, true)

							setActive = var_7

							var_7(arg_30_0.tag_2, true)
						elseif var_30_2 - 1 - var_30_1 == 1 then
							setActive = var_7

							var_7(arg_30_0.tag_1, true)

							setActive = var_7

							var_7(arg_30_0.tag_2, false)
						elseif var_30_2 - 1 - var_30_1 <= 0 then
							setActive = var_7

							var_7(arg_30_0.tag_1, false)

							setActive = var_7

							var_7(arg_30_0.tag_2, false)
						end

						return
					end
				end
			end
		end
	end
end

function var_0_1.updateRoundText(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_1 or arg_43_0.showingIndex
	local var_43_1 = arg_43_0.curMode

	ChallengeProxy = var_1_10004

	if var_43_1 == var_1_10004.MODE_CASUAL then
		ChallengeConst = var_43_1

		if var_43_1.BOSS_NUM < var_43_0 then
			ChallengeConst = var_43_1

			if var_43_0 % var_43_1.BOSS_NUM == 0 then
				ChallengeConst = var_43_1

				if not var_43_1.BOSS_NUM then
					::label_43_0::

					ChallengeConst = var_43_1
					var_43_0 = var_43_0 % var_43_1.BOSS_NUM
				end

				setText = var_43_1

				local var_43_2 = arg_43_0.roundNumText

				string = var_1_10005

				var_43_1(var_43_2, var_1_10005.format("%02d", var_43_0))

				setText = var_43_1

				var_43_1(arg_43_0.roundText_1, "Round" .. var_43_0 + 1)

				setText = var_43_1

				var_43_1(arg_43_0.roundText_2, "Round" .. var_43_0 + 2)

				return
			end
		end
	end
end

function var_0_1.updateSlider(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_1 or arg_44_0.showingIndex
	local var_44_1 = arg_44_0.curLevel

	ChallengeConst = var_1_10004

	if var_1_10004.BOSS_NUM < var_44_0 then
		ChallengeConst = var_4

		if var_44_0 % var_4.BOSS_NUM == 0 then
			ChallengeConst = var_4

			if not var_4.BOSS_NUM then
				::label_44_0::

				ChallengeConst = var_4
				var_44_0 = var_44_0 % var_4.BOSS_NUM
			end

			local var_44_2 = arg_44_0.curMode

			ChallengeProxy = var_1_10005

			if var_44_2 == var_1_10005.MODE_INFINITE then
				ChallengeConst = var_44_2

				if var_44_2.BOSS_NUM < var_44_1 then
					ChallengeConst = var_44_2

					if var_44_1 % var_44_2.BOSS_NUM == 0 then
						ChallengeConst = var_44_2

						if not var_44_2.BOSS_NUM then
							::label_44_1::

							ChallengeConst = var_44_2
							var_44_1 = var_44_1 % var_44_2.BOSS_NUM
						end

						ChallengeConst = var_44_2

						local var_44_3 = 1 / (var_44_2.BOSS_NUM - 1)
						local var_44_4 = (var_44_1 - 1) * var_44_3

						arg_44_0.sliderSC.value = var_44_4

						local var_44_5 = arg_44_0.squareList

						var_6.make(var_44_5, function(arg_45_0, arg_45_1, arg_45_2)
							local var_45_0 = arg_45_2:Find("UnFinished")
							local var_45_1 = arg_45_2:Find("Finished")
							local var_45_2 = arg_45_2:Find("Challengeing")
							local var_45_3 = arg_45_2:Find("Arrow")

							local function var_45_4()
								setActive = var_3_10000

								var_3_10000(var_45_1, true)

								setActive = var_3_10000

								var_3_10000(var_45_0, false)

								setActive = var_3_10000

								var_3_10000(var_45_2, false)

								return
							end

							local function var_45_5()
								setActive = var_3_10000

								var_3_10000(var_45_1, false)

								setActive = var_3_10000

								var_3_10000(var_45_0, true)

								setActive = var_3_10000

								var_3_10000(var_45_2, false)

								return
							end

							local function var_45_6()
								setActive = var_3_10000

								var_3_10000(var_45_1, false)

								setActive = var_3_10000

								var_3_10000(var_45_0, false)

								setActive = var_3_10000

								var_3_10000(var_45_2, true)

								return
							end

							UIItemList = var_2_10010

							if arg_45_0 == var_2_10010.EventUpdate then
								if arg_45_1 + 1 < var_44_1 then
									var_45_4()
								elseif arg_45_1 + 1 == var_44_1 then
									var_45_6()
								elseif arg_45_1 + 1 > var_44_1 then
									var_45_5()
								end

								if arg_45_1 + 1 == var_44_0 then
									setActive = var_10

									var_10(var_45_3, true)
								else
									setActive = var_10

									var_10(var_45_3, false)
								end
							end

							return
						end)

						local var_44_6 = arg_44_0.squareList
						local var_44_7 = var_6.align

						ChallengeConst = var_8

						var_44_7(var_44_6, var_8.BOSS_NUM)

						return
					end
				end
			end
		end
	end
end

function var_0_1.updateGrade(arg_49_0, arg_49_1)
	setText = var_1_10002

	var_1_10002(arg_49_0.seasonBestPointText, arg_49_1.seasonMaxScore)

	setText = var_1_10002

	var_1_10002(arg_49_0.activityBestPointText, arg_49_1.activityMaxScore)

	setText = var_1_10002

	var_1_10002(arg_49_0.seasonLevelNumText, arg_49_1.seasonMaxLevel)

	setText = var_1_10002

	var_1_10002(arg_49_0.activityLevelNumText, arg_49_1.activityMaxLevel)

	return
end

function var_0_1.updateTimePanel(arg_50_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_50_0 = var_1_10001(var_1_10002)
	local var_50_1 = var_1.getActivityByType

	ActivityConst = var_1_10004

	local var_50_2 = var_50_1(var_50_0, var_1_10004.ACTIVITY_TYPE_CHALLENGE).stopTime

	pg = var_4

	local var_50_3 = var_4.TimeMgr.GetInstance()
	local var_50_4 = var_4.STimeDescS(var_50_3, var_50_2, "%Y.%m.%d")

	setText = var_50_3

	var_50_3(arg_50_0.activityTimeText, var_50_4)

	pg = var_50_3

	local var_50_5 = var_50_3.TimeMgr.GetInstance()
	local var_50_6 = var_5.GetNextWeekTime(var_50_5, 1, 0, 0, 0) - var_5:GetServerTime()
	local var_50_7, var_50_8, var_50_9, var_50_10 = var_5:parseTimeFrom(var_50_6)

	setText = var_11

	var_11(arg_50_0.seasonDayText, var_50_7)

	setText = var_11

	local var_50_11 = arg_50_0.seasonTimeText

	string = var_13

	var_11(var_50_11, var_13.format("%02d:%02d:%02d", var_50_8, var_50_9, var_50_10))

	if arg_50_0.timer then
		local var_50_12 = arg_50_0.timer

		var_11.Stop(var_50_12)
	end

	Timer = var_11
	arg_50_0.timer = var_11.New(function()
		var_50_6 = var_50_6 - 1
		pg = var_0

		local var_51_0 = var_0.TimeMgr.GetInstance()
		local var_51_1, var_51_2, var_51_3, var_51_4 = var_0.parseTimeFrom(var_51_0, var_50_6)

		setText = var_2_10004

		var_2_10004(arg_50_0.seasonDayText, var_51_1)

		setText = var_2_10004

		local var_51_5 = arg_50_0.seasonTimeText

		string = var_6

		var_2_10004(var_51_5, var_6.format("%02d:%02d:%02d", var_51_2, var_51_3, var_51_4))

		if var_50_6 <= 0 then
			arg_50_0.timeOverTag = true

			local var_51_6 = arg_50_0.timer

			var_4.Stop(var_51_6)
		end

		return
	end, 1, -1)

	local var_50_13 = arg_50_0.timer

	var_11.Start(var_50_13)

	return
end

function var_0_1.updateSwitchModBtn(arg_52_0)
	local var_52_0 = arg_52_0

	if not arg_52_0.isFinishedCasualMode(var_52_0) then
		setActive = var_1

		var_1(arg_52_0.infiniteModBtn, false)
	else
		setActive = var_1

		var_1(arg_52_0.infiniteModBtn, true)
	end

	local var_52_1 = arg_52_0.curMode

	ChallengeProxy = var_52_0

	if var_52_1 == var_52_0.MODE_CASUAL then
		setActive = var_52_1

		var_52_1(arg_52_0.casualModBtnBG, true)

		setActive = var_52_1

		var_52_1(arg_52_0.infiniteModBtnBG, false)
	else
		setActive = var_52_1

		var_52_1(arg_52_0.casualModBtnBG, false)

		setActive = var_52_1

		var_52_1(arg_52_0.infiniteModBtnBG, true)
	end

	onButton = var_52_1

	local var_52_2 = arg_52_0
	local var_52_3 = arg_52_0.casualModBtn

	local function var_52_4()
		local var_53_0 = arg_52_0.curMode

		ChallengeProxy = var_2_10001

		if var_53_0 == var_2_10001.MODE_CASUAL then
			return
		end

		if arg_52_0.curModeInfo then
			local var_53_1 = arg_52_0.curModeInfo
			local var_53_2

			if not var_0.getLevel(var_53_1) then
				var_53_2 = 0
			end

			local function var_53_3()
				local var_54_0 = arg_52_0.challengeProxy
				local var_54_1 = var_0.setCurMode

				ChallengeProxy = var_3_10002

				var_54_1(var_54_0, var_3_10002.MODE_CASUAL)

				setActive = var_54_1

				var_54_1(arg_52_0.casualModBtnBG, true)

				setActive = var_54_1

				var_54_1(arg_52_0.infiniteModBtnBG, false)

				local var_54_2 = arg_52_0

				var_0.updateData(var_54_2)

				local var_54_3 = arg_52_0

				var_0.updatePaintingList(var_54_3, arg_52_0.nameList, arg_52_0.showingIndex)

				local var_54_4 = arg_52_0

				var_0.updateRoundText(var_54_4, arg_52_0.showingIndex)

				local var_54_5 = arg_52_0

				var_0.updateSlider(var_54_5, arg_52_0.showingIndex)

				local var_54_6 = arg_52_0

				var_0.updateSwitchModBtn(var_54_6)

				local var_54_7 = arg_52_0

				var_0.updateFuncBtns(var_54_7)

				local var_54_8 = arg_52_0

				var_0.showTipText(var_54_8)

				return
			end

			local var_53_4 = arg_52_0
			local var_53_5

			if var_2.isCrossedSeason(var_53_4) then
				var_53_5 = "challenge_season_update_infinite_switch"

				local var_53_6 = var_53_2

				pg = var_2_10004
				var_2_10005 = var_2_10004.MsgboxMgr.GetInstance()

				local var_53_7 = var_4.ShowMsgBox
				local var_53_8 = {
					hideNo = false
				}

				i18n = var_2_10007
				var_53_8.content = var_2_10007(var_53_5, var_53_6)

				function var_53_8.onYes()
					local var_55_0 = arg_52_0
					local var_55_1 = var_0.emit

					ChallengeConst = var_3_10002

					local var_55_2 = var_3_10002.RESET_DATA_EVENT

					ChallengeProxy = var_3_10003

					var_55_1(var_55_0, var_55_2, var_3_10003.MODE_INFINITE)

					return
				end

				var_53_8.onNo = var_53_3

				var_53_7(var_2_10005, var_53_8)

				return
			end

			pg = var_53_5

			local var_53_9 = var_53_5.MsgboxMgr.GetInstance()
			local var_53_10 = var_2.ShowMsgBox
			local var_53_11 = {
				hideNo = false
			}

			i18n = var_2_10005
			var_53_11.content = var_2_10005("challenge_infinite_click_switch", var_53_2)
			var_53_11.onYes = var_53_3

			var_53_10(var_53_9, var_53_11)

			return
		end
	end

	SFX_PANEL = var_1_10005

	var_52_1(var_52_2, var_52_3, var_52_4, var_1_10005)

	onButton = var_52_1

	local var_52_5 = arg_52_0
	local var_52_6 = arg_52_0.infiniteModBtn

	local function var_52_7()
		local var_56_0 = arg_52_0.curMode

		ChallengeProxy = var_2_10001

		if var_56_0 == var_2_10001.MODE_INFINITE then
			return
		end

		if arg_52_0.curModeInfo then
			local var_56_1 = arg_52_0.curModeInfo
			local var_56_3

			if not var_0.getScore(var_56_1) then
				local var_56_2 = arg_52_0.challengeInfo

				var_56_3 = var_0.getGradeList(var_56_2).seasonMaxScore
			end

			local function var_56_4()
				local var_57_0 = arg_52_0.challengeProxy
				local var_57_1 = var_0.setCurMode

				ChallengeProxy = var_3_10002

				var_57_1(var_57_0, var_3_10002.MODE_INFINITE)

				setActive = var_57_1

				var_57_1(arg_52_0.casualModBtnBG, false)

				setActive = var_57_1

				var_57_1(arg_52_0.infiniteModBtnBG, true)

				local var_57_2 = arg_52_0

				var_0.updateData(var_57_2)

				local var_57_3 = arg_52_0

				var_0.updatePaintingList(var_57_3, arg_52_0.nameList, arg_52_0.showingIndex)

				local var_57_4 = arg_52_0

				var_0.updateRoundText(var_57_4, arg_52_0.showingIndex)

				local var_57_5 = arg_52_0

				var_0.updateSlider(var_57_5, arg_52_0.showingIndex)

				local var_57_6 = arg_52_0

				var_0.updateFuncBtns(var_57_6)

				local var_57_7 = arg_52_0

				var_0.showTipText(var_57_7)

				return
			end

			local var_56_5 = arg_52_0
			local var_56_6

			if var_2.isCrossedSeason(var_56_5) then
				var_56_6 = "challenge_season_update_casual_switch"

				local var_56_7 = var_56_3

				pg = var_2_10004
				var_2_10005 = var_2_10004.MsgboxMgr.GetInstance()

				local var_56_8 = var_4.ShowMsgBox
				local var_56_9 = {
					hideNo = false
				}

				i18n = var_2_10007
				var_56_9.content = var_2_10007(var_56_6, var_56_7)

				function var_56_9.onYes()
					local var_58_0 = arg_52_0
					local var_58_1 = var_0.emit

					ChallengeConst = var_3_10002

					local var_58_2 = var_3_10002.RESET_DATA_EVENT

					ChallengeProxy = var_3_10003

					var_58_1(var_58_0, var_58_2, var_3_10003.MODE_CASUAL)

					return
				end

				var_56_9.onNo = var_56_4

				var_56_8(var_2_10005, var_56_9)

				return
			end

			pg = var_56_6

			local var_56_10 = var_56_6.MsgboxMgr.GetInstance()
			local var_56_11 = var_2.ShowMsgBox
			local var_56_12 = {
				hideNo = false
			}

			i18n = var_2_10005
			var_56_12.content = var_2_10005("challenge_casual_click_switch", var_56_3)
			var_56_12.onYes = var_56_4

			var_56_11(var_56_10, var_56_12)

			return
		end
	end

	SFX_PANEL = var_1_10005

	var_52_1(var_52_5, var_52_6, var_52_7, var_1_10005)

	return
end

function var_0_1.updateResetBtn(arg_59_0)
	if arg_59_0.userChallengeInfoList[arg_59_0.curMode] then
		setActive = var_2

		var_2(arg_59_0.resetBtn, true)

		SetActive = var_2

		var_2(arg_59_0.resetBtnBanned, false)
	else
		setActive = var_2

		var_2(arg_59_0.resetBtn, false)

		SetActive = var_2

		var_2(arg_59_0.resetBtnBanned, true)
	end

	return
end

function var_0_1.updateStartBtn(arg_60_0)
	local var_60_0

	if arg_60_0.userChallengeInfoList[arg_60_0.curMode] then
		var_60_0 = arg_60_0.curMode
		ChallengeProxy = var_1_10003

		if var_60_0 == var_1_10003.MODE_CASUAL then
			local var_60_1 = var_1

			var_60_0 = var_1.getLevel(var_60_1)
			ChallengeConst = var_60_1

			if var_60_0 > var_60_1.BOSS_NUM then
				SetActive = var_60_0

				var_60_0(arg_60_0.startBtn, false)

				SetActive = var_60_0

				var_60_0(arg_60_0.startBtnBanned, true)

				goto label_60_0
			end
		end

		SetActive = var_60_0

		var_60_0(arg_60_0.startBtn, true)

		SetActive = var_60_0

		var_60_0(arg_60_0.startBtnBanned, false)
	else
		SetActive = var_60_0

		var_60_0(arg_60_0.startBtn, true)

		SetActive = var_60_0

		var_60_0(arg_60_0.startBtnBanned, false)
	end

	::label_60_0::

	return
end

function var_0_1.updateFuncBtns(arg_61_0)
	arg_61_0:updateResetBtn()
	arg_61_0:updateStartBtn()

	return
end

function var_0_1.updateAwardPanel(arg_62_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_62_0 = var_1_10001(var_1_10002)
	local var_62_1 = var_1.getActivityByType

	ActivityConst = var_1_10003

	local var_62_2 = var_62_1(var_62_0, var_1_10003.ACTIVITY_TYPE_CHALLENGE)

	pg = var_62_0

	local var_62_3 = var_62_0.activity_template[var_62_2.id].config_data[1]

	pg = var_3

	local var_62_4 = var_3.activity_template[var_62_3].config_data[1]

	getProxy = var_1_10004
	TaskProxy = var_1_10005

	local var_62_5 = var_1_10004(var_1_10005)
	local var_62_7

	if not var_4.getTaskById(var_62_5, var_62_4) then
		getProxy = var_62_5
		TaskProxy = var_6

		local var_62_6 = var_62_5(var_6)

		var_62_7 = var_5.getFinishTaskById(var_62_6, var_62_4)
	end

	local var_62_8 = var_62_7:getConfig("target_num")
	local var_62_9 = arg_62_0.challengeInfo
	local var_62_10 = var_6.getGradeList(var_62_9).activityMaxScore

	setText = var_62_9

	var_62_9(arg_62_0.scoreText, var_62_10 .. " / " .. var_62_8)

	local var_62_11 = var_62_7

	if var_62_7.getTaskStatus(var_62_11) == 0 then
		setActive = var_62_11

		var_62_11(arg_62_0.getBtn, false)

		setActive = var_62_11

		var_62_11(arg_62_0.getBtnBanned, true)

		setActive = var_62_11

		var_62_11(arg_62_0.gotBtn, false)
	elseif var_7 == 1 then
		setActive = var_62_11

		var_62_11(arg_62_0.getBtn, true)

		setActive = var_62_11

		var_62_11(arg_62_0.getBtnBanned, false)

		setActive = var_62_11

		var_62_11(arg_62_0.gotBtn, false)
	elseif var_7 == 2 then
		setActive = var_62_11

		var_62_11(arg_62_0.getBtn, false)

		setActive = var_62_11

		var_62_11(arg_62_0.getBtnBanned, false)

		setActive = var_62_11

		var_62_11(arg_62_0.gotBtn, true)
	end

	local var_62_12 = var_62_7:getConfig("award_display")[1]
	local var_62_13 = {
		type = var_62_12[1],
		id = var_62_12[2],
		count = var_62_12[3]
	}

	updateDrop = var_10

	var_10(arg_62_0.itemTF, var_62_13)

	onButton = var_10

	local var_62_14 = arg_62_0
	local var_62_15 = arg_62_0.itemTF

	local function var_62_16()
		local var_63_0 = arg_62_0
		local var_63_1 = var_0.emit

		BaseUI = var_2_10002

		var_63_1(var_63_0, var_2_10002.ON_DROP, var_62_13)

		return
	end

	SFX_PANEL = var_1_10014

	var_10(var_62_14, var_62_15, var_62_16, var_1_10014)

	onButton = var_10

	local var_62_17 = arg_62_0
	local var_62_18 = arg_62_0.getBtn

	local function var_62_19()
		local var_64_0 = arg_62_0
		local var_64_1 = var_0.emit

		ChallengeConst = var_2_10002

		var_64_1(var_64_0, var_2_10002.CLICK_GET_AWARD_BTN, var_62_7.id)

		return
	end

	SFX_PANEL = var_1_10014

	var_10(var_62_17, var_62_18, var_62_19, var_1_10014)

	local var_62_20

	return
end

function var_0_1.showSLResetMsgBox(arg_65_0)
	local var_65_0 = false
	local var_65_1
	local var_65_2

	pairs = var_1_10004

	for iter_65_0, iter_65_1 in var_1_10004(arg_65_0.userChallengeInfoList) do
		local var_65_3 = iter_65_1

		var_1_10009 = iter_65_1.getResetFlag(var_65_3)
		ChallengeConst = var_65_3

		if var_1_10009 >= var_65_3.NEED_TO_RESET_SAVELOAD then
			var_65_0 = true
			var_65_1 = iter_65_1
			var_65_2 = iter_65_0

			break
		end
	end

	if var_65_0 == true then
		local var_65_4
		local var_65_5

		ChallengeProxy = var_6

		if var_65_2 == var_6.MODE_CASUAL then
			var_65_4 = "challenge_casual_reset"
			var_65_5 = var_65_1:getScore()
		else
			ChallengeProxy = var_6

			if var_65_2 == var_6.MODE_INFINITE then
				var_65_4 = "challenge_infinite_reset"
				var_65_5 = var_65_1:getLevel() - 1
			end
		end

		pg = var_6

		local var_65_6 = var_6.MsgboxMgr.GetInstance()
		local var_65_7 = var_6.ShowMsgBox
		local var_65_8 = {
			hideNo = true
		}

		i18n = var_1_10009
		var_65_8.content = var_1_10009(var_65_4, var_65_5)

		function var_65_8.onYes()
			local var_66_0 = arg_65_0
			local var_66_1 = var_0.emit

			ChallengeConst = var_2_10002

			var_66_1(var_66_0, var_2_10002.RESET_DATA_EVENT, var_65_2)

			return
		end

		function var_65_8.onNo()
			local var_67_0 = arg_65_0
			local var_67_1 = var_0.emit

			ChallengeConst = var_2_10002

			var_67_1(var_67_0, var_2_10002.RESET_DATA_EVENT, var_65_2)

			return
		end

		var_65_7(var_65_6, var_65_8)
	end

	return
end

function var_0_1.showTipText(arg_68_0)
	local var_68_0
	local var_68_1 = arg_68_0.curMode

	ChallengeProxy = var_1_10003

	local var_68_2 = var_68_1 == var_1_10003.MODE_CASUAL and "challenge_normal_tip" or "challenge_unlimited_tip"

	setText = var_68_1

	local var_68_3 = arg_68_0.modTipText

	i18n = var_1_10004

	var_68_1(var_68_3, var_1_10004(var_68_2))

	local var_68_4 = arg_68_0.modTipTF
	local var_68_5 = var_2.GetComponent

	typeof = var_4
	DftAniEvent = var_5

	if var_68_5(var_68_4, var_4(var_5)) then
		var_2:SetEndEvent(function(arg_69_0)
			setActive = var_2_10001

			var_2_10001(arg_68_0.modTipText, false)

			setActive = var_2_10001

			var_2_10001(arg_68_0.modTipTF, false)

			return
		end)
	end

	setActive = var_68_4

	var_68_4(arg_68_0.modTipTF, true)

	setActive = var_68_4

	var_68_4(arg_68_0.modTipText, true)

	return
end

function var_0_1.doOnFleetPanel(arg_70_0)
	local var_70_0 = arg_70_0.fleetEditPanel

	var_1.attach(var_70_0, arg_70_0)

	local var_70_1 = arg_70_0.fleetEditPanel

	var_1.setFleets(var_70_1, arg_70_0.fleets[arg_70_0.curMode])

	local var_70_2 = arg_70_0.fleetEditPanel

	var_1.set(var_70_2, 1, 1)

	pg = var_1

	local var_70_3 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_70_3, arg_70_0.fleetEditPanel._tf)

	return
end

function var_0_1.isFinishedCasualMode(arg_71_0)
	local var_71_0 = false
	local var_71_1 = arg_71_0.userChallengeInfoList

	ChallengeProxy = var_1_10003

	local var_71_2 = var_71_1[var_1_10003.MODE_INFINITE]
	local var_71_3 = arg_71_0.userChallengeInfoList

	ChallengeProxy = var_1_10004

	local var_71_4 = var_71_3[var_1_10004.MODE_CASUAL]

	if var_71_2 then
		var_71_0 = true
	elseif not var_71_2 then
		local var_71_5 = arg_71_0.challengeInfo
		local var_71_6 = var_4.getGradeList(var_71_5).seasonMaxLevel

		if var_71_4 then
			var_71_5 = var_71_4:getSeasonID()

			local var_71_7 = arg_71_0.challengeInfo

			if var_71_5 == var_6.getSeasonID(var_71_7) then
				ChallengeConst = var_71_5

				if var_71_5.BOSS_NUM <= var_71_6 then
					var_71_0 = true
				else
					var_71_0 = false
				end
			else
				var_71_0 = false
			end
		else
			ChallengeConst = var_71_5

			if var_71_6 >= var_71_5.BOSS_NUM then
				var_71_0 = true
			elseif not var_71_4 then
				var_71_0 = false
			end
		end
	end

	return var_71_0
end

function var_0_1.isCrossedSeason(arg_72_0)
	local var_72_0 = false

	if arg_72_0.timeOverTag == true then
		var_72_0 = true
	elseif arg_72_0.curModeInfo then
		local var_72_1 = arg_72_0.curModeInfo
		local var_72_2 = var_2.getSeasonID(var_72_1)
		local var_72_3 = arg_72_0.challengeInfo

		if var_72_2 ~= var_3.getSeasonID(var_72_3) then
			var_72_0 = true
		end
	else
		var_72_0 = false
	end

	return var_72_0
end

function var_0_1.commitEdit(arg_73_0)
	local var_73_0 = arg_73_0
	local var_73_1 = arg_73_0.emit

	ChallengeMainMediator = var_1_10003

	var_73_1(var_73_0, var_1_10003.ON_COMMIT_FLEET)

	return
end

function var_0_1.openShipInfo(arg_74_0, arg_74_1, arg_74_2)
	local var_74_0 = arg_74_0
	local var_74_1 = arg_74_0.emit

	ChallengeMainMediator = var_1_10005

	var_74_1(var_74_0, var_1_10005.ON_FLEET_SHIPINFO, {
		shipId = arg_74_1,
		shipVOs = arg_74_2
	})

	return
end

function var_0_1.hideFleetEdit(arg_75_0)
	setActive = var_1_10001

	var_1_10001(arg_75_0.fleetSelect, false)
	arg_75_0:closeCommanderPanel()

	pg = var_1

	local var_75_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_75_0, arg_75_0.fleetSelect, arg_75_0._tf)

	setParent = var_1

	var_1(arg_75_0.fleetSelect, arg_75_0._tf, false)

	return
end

function var_0_1.updateEditPanel(arg_76_0)
	local var_76_0 = arg_76_0.fleetEditPanel

	var_1.setFleets(var_76_0, arg_76_0.fleets[arg_76_0.curMode])

	local var_76_1 = arg_76_0.fleetEditPanel

	var_1.updateFleets(var_76_1)

	return
end

function var_0_1.setCommanderPrefabs(arg_77_0, arg_77_1)
	arg_77_0.commanderPrefabs = arg_77_1

	return
end

function var_0_1.openCommanderPanel(arg_78_0, arg_78_1, arg_78_2)
	getProxy = var_1_10003
	ActivityProxy = var_1_10004

	local var_78_0 = var_1_10003(var_1_10004)
	local var_78_1 = var_3.getActivityByType

	ActivityConst = var_1_10005

	local var_78_2 = var_78_1(var_78_0, var_1_10005.ACTIVITY_TYPE_CHALLENGE).id
	local var_78_3 = arg_78_0.levelCMDFormationView

	var_4.setCallback(var_78_3, function(arg_79_0)
		local var_79_0 = arg_79_0.type

		LevelUIConst = var_2_10002

		local var_79_1

		if var_79_0 == var_2_10002.COMMANDER_OP_SHOW_SKILL then
			var_79_1 = arg_78_0

			local var_79_2 = var_1.emit

			ChallengeMainMediator = var_2_10003

			var_79_2(var_79_1, var_2_10003.ON_COMMANDER_SKILL, arg_79_0.skill)
		else
			local var_79_3 = arg_79_0.type

			LevelUIConst = var_79_1

			if var_79_3 == var_79_1.COMMANDER_OP_ADD then
				arg_78_0.contextData.eliteCommanderSelected = {
					fleetIndex = arg_78_2,
					cmdPos = arg_79_0.pos,
					mode = arg_78_0.curMode
				}

				local var_79_4 = arg_78_0
				local var_79_5 = var_1.emit

				ChallengeMainMediator = var_2_10003

				var_79_5(var_79_4, var_2_10003.ON_SELECT_ELITE_COMMANDER, arg_78_2, arg_79_0.pos)

				local var_79_6 = arg_78_0

				var_1.closeCommanderPanel(var_79_6)

				local var_79_7 = arg_78_0

				var_1.hideFleetEdit(var_79_7)
			else
				local var_79_8 = arg_78_0
				local var_79_9 = var_1.emit

				ChallengeMainMediator = var_2_10003

				local var_79_10 = var_2_10003.COMMANDER_FORMATION_OP
				local var_79_11 = {}

				LevelUIConst = var_2_10005
				var_79_11.FleetType = var_2_10005.FLEET_TYPE_ACTIVITY
				var_79_11.data = arg_79_0
				var_79_11.fleetId = arg_78_1.id
				var_79_11.actId = var_78_2

				var_79_9(var_79_8, var_79_10, var_79_11)
			end
		end

		return
	end)

	local var_78_4 = arg_78_0.levelCMDFormationView

	var_4.Load(var_78_4)

	local var_78_5 = arg_78_0.levelCMDFormationView

	var_4.ActionInvoke(var_78_5, "update", arg_78_1, arg_78_0.commanderPrefabs)

	local var_78_6 = arg_78_0.levelCMDFormationView

	var_4.ActionInvoke(var_78_6, "Show")

	return
end

function var_0_1.closeCommanderPanel(arg_80_0)
	local var_80_0 = arg_80_0.levelCMDFormationView

	if var_1.isShowing(var_80_0) then
		local var_80_1 = arg_80_0.levelCMDFormationView

		var_1.ActionInvoke(var_80_1, "Hide")
	end

	return
end

function var_0_1.updateCommanderFleet(arg_81_0, arg_81_1)
	local var_81_0 = arg_81_0.levelCMDFormationView

	if var_2.isShowing(var_81_0) then
		local var_81_1 = arg_81_0.levelCMDFormationView

		var_2.ActionInvoke(var_81_1, "updateFleet", arg_81_1)
	end

	return
end

function var_0_1.updateCommanderPrefab(arg_82_0)
	local var_82_0 = arg_82_0.levelCMDFormationView

	if var_1.isShowing(var_82_0) then
		local var_82_1 = arg_82_0.levelCMDFormationView

		var_1.ActionInvoke(var_82_1, "updatePrefabs", arg_82_0.commanderPrefabs)
	end

	return
end

function var_0_1.buildCommanderPanel(arg_83_0)
	LevelCMDFormationView = var_1_10001
	arg_83_0.levelCMDFormationView = var_1_10001.New(arg_83_0.fleetSelect, arg_83_0.event, arg_83_0.contextData)

	return
end

function var_0_1.destroyCommanderPanel(arg_84_0)
	local var_84_0 = arg_84_0.levelCMDFormationView

	var_1.Destroy(var_84_0)

	arg_84_0.levelCMDFormationView = nil

	return
end

return var_0_1
