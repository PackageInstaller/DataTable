local var_0_0 = class("ChallengeMainScene", import("..base.BaseUI"))

var_0_0.BOSS_NUM = 5
var_0_0.FADE_TIME = 5

function var_0_0.getUIName(arg_1_0)
	return "ChallengeMainUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:findUI()
	arg_2_0:initData()
	arg_2_0:addListener()

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:updateGrade(arg_3_0.challengeInfo:getGradeList())
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

function var_0_0.willExit(arg_4_0)
	LeanTween.cancel(go(arg_4_0.modTipTF))

	if arg_4_0.timer then
		arg_4_0.timer:Stop()
	end

	arg_4_0:destroyCommanderPanel()

	return
end

function var_0_0.onBackPressed(arg_5_0)
	if isActive(arg_5_0.fleetSelect) then
		arg_5_0:hideFleetEdit()
	else
		triggerButton(arg_5_0.backBtn)
	end

	return
end

function var_0_0.setFleet(arg_6_0, arg_6_1)
	arg_6_0.fleets = {}

	;(function(arg_7_0)
		arg_6_0.fleets[arg_7_0] = {
			arg_6_1[arg_7_0 + 1],
			[11] = arg_6_1[arg_7_0 + 11]
		}

		return
	end)(ChallengeProxy.MODE_CASUAL)
	;(function(arg_7_0)
		arg_6_0.fleets[arg_7_0] = {
			arg_6_1[arg_7_0 + 1],
			[11] = arg_6_1[arg_7_0 + 11]
		}

		return
	end)(ChallengeProxy.MODE_INFINITE)

	return
end

function var_0_0.findUI(arg_8_0)
	arg_8_0.northTF = arg_8_0._tf:Find("ForNorth")
	arg_8_0.paintingListTF = arg_8_0._tf:Find("PaintingList")
	arg_8_0.backBtn = arg_8_0.northTF:Find("top/back_button")
	arg_8_0.gradeContainer = arg_8_0.northTF:Find("GradeContainer")
	arg_8_0.seasonBestPointText = arg_8_0.gradeContainer:Find("SeasonBestPoint/Text")
	arg_8_0.activityBestPointText = arg_8_0.gradeContainer:Find("ActivityBestPoint/Text")
	arg_8_0.seasonLevelNumText = arg_8_0.gradeContainer:Find("SeasonLevelNum/Text")
	arg_8_0.activityLevelNumText = arg_8_0.gradeContainer:Find("ActivityLevelNum/Text")
	arg_8_0.timeTipTF = arg_8_0.northTF:Find("TimeTip")
	arg_8_0.activityTimeText = arg_8_0.timeTipTF:Find("ActivityTimeText")
	arg_8_0.seasonDayText = arg_8_0.timeTipTF:Find("SeasonTipText/DayText")
	arg_8_0.seasonTimeText = arg_8_0.timeTipTF:Find("SeasonTimeText")
	arg_8_0.switchModTF = arg_8_0.northTF:Find("SwitchMod")
	arg_8_0.casualModBtn = arg_8_0.switchModTF:Find("NormalBtn")
	arg_8_0.infiniteModBtn = arg_8_0.switchModTF:Find("EndlessBtn")
	arg_8_0.casualModBtnBG = arg_8_0.casualModBtn:Find("BG")
	arg_8_0.infiniteModBtnBG = arg_8_0.infiniteModBtn:Find("BG")
	arg_8_0.casualModBtnSC = GetComponent(arg_8_0.casualModBtn, "Button")
	arg_8_0.infiniteModBtnSC = GetComponent(arg_8_0.infiniteModBtn, "Button")
	arg_8_0.functionBtnsTF = arg_8_0.northTF:Find("FunctionBtns")
	arg_8_0.rankBtn = arg_8_0.functionBtnsTF:Find("RankBtn")
	arg_8_0.startBtn = arg_8_0.functionBtnsTF:Find("StartBtn")
	arg_8_0.resetBtn = arg_8_0.functionBtnsTF:Find("ResetBtn")
	arg_8_0.startBtnBanned = arg_8_0.functionBtnsTF:Find("StartBtnBanned")
	arg_8_0.resetBtnBanned = arg_8_0.functionBtnsTF:Find("ResetBtnBanned")
	arg_8_0.awardTF = arg_8_0.northTF:Find("Award")
	arg_8_0.helpBtn = arg_8_0.awardTF:Find("HelpBtn")
	arg_8_0.getBtn = arg_8_0.awardTF:Find("GetBtn")
	arg_8_0.gotBtn = arg_8_0.awardTF:Find("GotBtn")
	arg_8_0.getBtnBanned = arg_8_0.awardTF:Find("GetBtnBanned")
	arg_8_0.itemTF = arg_8_0.awardTF:Find("ItemBG/item")
	arg_8_0.scoreText = arg_8_0.awardTF:Find("Score/ScoreText")
	arg_8_0.slider = arg_8_0.northTF:Find("Slider")
	arg_8_0.squareContainer = arg_8_0.slider:Find("SquareList")
	arg_8_0.squareTpl = arg_8_0.slider:Find("Squre")
	arg_8_0.squareList = UIItemList.New(arg_8_0.squareContainer, arg_8_0.squareTpl)
	arg_8_0.sliderSC = GetComponent(arg_8_0.slider, "Slider")
	arg_8_0.paintingContainer = arg_8_0._tf:Find("PaintingList")
	arg_8_0.scrollSC = GetComponent(arg_8_0.paintingContainer, "Slider")
	arg_8_0.material = arg_8_0._tf:Find("material"):GetComponent(typeof(Image)).material
	arg_8_0.material1 = arg_8_0._tf:Find("material1"):GetComponent(typeof(Image)).material
	arg_8_0.painting = arg_8_0.paintingContainer:Find("Painting")
	arg_8_0.paintingShadow1 = arg_8_0.painting:Find("PaintingShadow1")
	arg_8_0.paintingShadow2 = arg_8_0.painting:Find("PaintingShadow2")
	arg_8_0.bossInfoImg = arg_8_0.painting:Find("InfoImg")
	arg_8_0.roundNumText = arg_8_0.painting:Find("Round/NumText")
	arg_8_0.completeEffectTF = arg_8_0.painting:Find("TZ02")

	SetActive(arg_8_0.completeEffectTF, false)

	arg_8_0.card1TF = arg_8_0.paintingContainer:Find("Card1")
	arg_8_0.shipPaintImg_1 = arg_8_0.card1TF:Find("Mask/ShipPaint")
	arg_8_0.tag_1 = arg_8_0.card1TF:Find("Tag")
	arg_8_0.mask_1 = arg_8_0.card1TF:Find("Mask")
	arg_8_0.roundTF_1 = arg_8_0.card1TF:Find("Round")
	arg_8_0.roundText_1 = arg_8_0.card1TF:Find("Round/RoundText")
	arg_8_0.card2TF = arg_8_0.paintingContainer:Find("Card2")
	arg_8_0.shipPaintImg_2 = arg_8_0.card2TF:Find("Mask/ShipPaint")
	arg_8_0.tag_2 = arg_8_0.card2TF:Find("Tag")
	arg_8_0.mask_2 = arg_8_0.card2TF:Find("Mask")
	arg_8_0.roundTF_2 = arg_8_0.card2TF:Find("Round")
	arg_8_0.roundText_2 = arg_8_0.card2TF:Find("Round/RoundText")
	arg_8_0.modTipBtn = arg_8_0.northTF:Find("ModTipBtn")
	arg_8_0.modTipTF = arg_8_0.northTF:Find("TipText")
	arg_8_0.modTipText = arg_8_0.modTipTF:Find("Text")

	setActive(arg_8_0.modTipTF, false)

	arg_8_0.fleetSelect = arg_8_0._tf:Find("LevelFleetSelectView")
	arg_8_0.fleetEditPanel = ActivityFleetPanel.New(arg_8_0.fleetSelect.gameObject)

	function arg_8_0.fleetEditPanel.onCancel()
		arg_8_0:hideFleetEdit()

		return
	end

	function arg_8_0.fleetEditPanel.onCommit()
		arg_8_0:commitEdit()

		return
	end

	function arg_8_0.fleetEditPanel.onCombat()
		arg_8_0:commitEdit()
		arg_8_0:emit(ChallengeMainMediator.ON_PRECOMBAT, arg_8_0.curMode)

		return
	end

	function arg_8_0.fleetEditPanel.onLongPressShip(arg_12_0, arg_12_1)
		arg_8_0:openShipInfo(arg_12_0, arg_12_1)

		return
	end

	arg_8_0:buildCommanderPanel()

	return
end

function var_0_0.tryPlayGuide(arg_13_0)
	pg.SystemGuideMgr.GetInstance():Play(arg_13_0)

	return
end

function var_0_0.initData(arg_14_0)
	arg_14_0.challengeProxy = getProxy(ChallengeProxy)
	arg_14_0.challengeInfo = arg_14_0.challengeProxy:getChallengeInfo()
	arg_14_0.userChallengeInfoList = arg_14_0.challengeProxy:getUserChallengeInfoList()
	arg_14_0.timeOverTag = false

	arg_14_0:updateData()

	arg_14_0.openedCommanerSystem = true

	return
end

function var_0_0.addListener(arg_15_0)
	onButton(arg_15_0, arg_15_0.backBtn, function()
		arg_15_0:emit(var_0_0.ON_BACK)

		return
	end, SFX_PANEL)
	onButton(arg_15_0, arg_15_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.challenge_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_15_0, arg_15_0.rankBtn, function()
		arg_15_0:emit(ChallengeMainMediator.ON_OPEN_RANK)

		return
	end, SFX_PANEL)
	onButton(arg_15_0, arg_15_0.startBtn, function()
		local var_19_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_CHALLENGE)

		if not var_19_0 or var_19_0:isEnd() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("challenge_end_tip"))
			triggerButton(arg_15_0.backBtn)

			return
		end

		if arg_15_0:isCrossedSeason() == true then
			local var_19_1 = arg_15_0.challengeProxy:getCurMode()
			local var_19_2 = var_19_1 == ChallengeProxy.MODE_CASUAL and "challenge_season_update_casual_clear" or "challenge_season_update_infinite_clear"

			if not arg_15_0.curModeInfo then
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					hideNo = true,
					content = i18n("challenge_season_update"),
					onYes = function()
						arg_15_0:emit(ChallengeConst.RESET_DATA_EVENT, var_19_1)

						return
					end,
					onNo = function()
						arg_15_0:emit(ChallengeConst.RESET_DATA_EVENT, var_19_1)

						return
					end
				})

				do return end

				goto label_19_0
			end

			::label_19_0::

			if var_19_1 == ChallengeProxy.MODE_CASUAL then
				do
					local var_19_3 = arg_15_0.curModeInfo:getScore() or arg_15_0.curModeInfo:getLevel()

					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						hideNo = false,
						content = i18n(var_19_2, var_19_3),
						onNo = function()
							arg_15_0:emit(ChallengeConst.RESET_DATA_EVENT, var_19_1)

							return
						end,
						onYes = function()
							arg_15_0:emit(ChallengeMainMediator.ON_PRECOMBAT, arg_15_0.curMode)

							return
						end
					})

					return
				end

				if not arg_15_0.curModeInfo then
					arg_15_0:doOnFleetPanel()

					return
				end

				arg_15_0:emit(ChallengeMainMediator.ON_PRECOMBAT, arg_15_0.curMode)

				return
			end
		end
	end, SFX_PANEL)
	onButton(arg_15_0, arg_15_0.resetBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = false,
			content = i18n("challenge_normal_reset"),
			onYes = function()
				arg_15_0:emit(ChallengeConst.RESET_DATA_EVENT, arg_15_0.challengeProxy:getCurMode())

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(arg_15_0, arg_15_0.modTipBtn, function()
		arg_15_0:showTipText()

		return
	end)
	addSlip(SLIP_TYPE_HRZ, arg_15_0.paintingContainer, function()
		if arg_15_0.showingIndex % ChallengeConst.BOSS_NUM == 1 then
			return
		end

		arg_15_0.showingIndex = arg_15_0.showingIndex - 1

		arg_15_0:updatePaintingList(arg_15_0.nameList, arg_15_0.showingIndex)
		arg_15_0:updateRoundText(arg_15_0.showingIndex)
		arg_15_0:updateSlider(arg_15_0.showingIndex)

		return
	end, function()
		if arg_15_0.showingIndex % ChallengeConst.BOSS_NUM == 0 then
			return
		end

		arg_15_0.showingIndex = arg_15_0.showingIndex + 1

		arg_15_0:updatePaintingList(arg_15_0.nameList, arg_15_0.showingIndex)
		arg_15_0:updateRoundText(arg_15_0.showingIndex)
		arg_15_0:updateSlider(arg_15_0.showingIndex)

		return
	end)

	return
end

function var_0_0.updateData(arg_29_0)
	arg_29_0.curMode = arg_29_0.challengeProxy:getCurMode()
	arg_29_0.curModeInfo = arg_29_0.userChallengeInfoList[arg_29_0.curMode]
	arg_29_0.timeOverTag = false

	if not arg_29_0.curModeInfo then
		arg_29_0.curLevel = 1
		arg_29_0.showingIndex = arg_29_0.curLevel

		if arg_29_0.curMode == ChallengeProxy.MODE_CASUAL then
			arg_29_0.dungeonIDList = arg_29_0.challengeInfo:getDungeonIDList()
		elseif arg_29_0.curMode == ChallengeProxy.MODE_INFINITE then
			arg_29_0.dungeonIDList = pg.activity_event_challenge[arg_29_0.challengeInfo:getActivityIndex()].infinite_stage[arg_29_0.challengeInfo:getSeasonID()][1]
		end
	else
		arg_29_0.curLevel = arg_29_0.curModeInfo:getLevel()
		arg_29_0.showingIndex = arg_29_0.curLevel
		arg_29_0.dungeonIDList = arg_29_0.curModeInfo:getDungeonIDList()
	end

	arg_29_0.nameList = {}
	arg_29_0.infoNameList = {}

	for iter_29_0, iter_29_1 in ipairs(arg_29_0.dungeonIDList) do
		arg_29_0.nameList[iter_29_0] = pg.expedition_challenge_template[iter_29_1].char_icon[1]
		arg_29_0.infoNameList[iter_29_0] = pg.expedition_challenge_template[iter_29_1].name_p
	end

	arg_29_0.nextNameList = {}

	if arg_29_0.curMode == ChallengeProxy.MODE_INFINITE then
		local var_29_0

		if arg_29_0.curModeInfo then
			var_29_0 = arg_29_0.curModeInfo:getNextInfiniteDungeonIDList()
		else
			local var_29_1 = arg_29_0.challengeInfo:getSeasonID()
			local var_29_2 = arg_29_0.challengeInfo:getActivityIndex()

			var_29_0 = pg.activity_event_challenge[var_29_2].infinite_stage[var_29_1][2] and pg.activity_event_challenge[var_29_2].infinite_stage[var_29_1][2] or pg.activity_event_challenge[var_29_2].infinite_stage[var_29_1][1]
		end

		for iter_29_2, iter_29_3 in ipairs(var_29_0) do
			arg_29_0.nextNameList[iter_29_2 + ChallengeConst.BOSS_NUM] = pg.expedition_challenge_template[iter_29_3].char_icon[1]
		end
	end

	return
end

function var_0_0.updatePaintingList(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_1 or arg_30_0.nameList
	local var_30_1 = arg_30_2 or arg_30_0.showingIndex
	local var_30_2 = arg_30_0.curLevel

	if (arg_30_2 or arg_30_0.showingIndex) > ChallengeConst.BOSS_NUM then
		var_30_1 = var_30_1 % ChallengeConst.BOSS_NUM == 0 and ChallengeConst.BOSS_NUM or var_30_1 % ChallengeConst.BOSS_NUM
	end

	if arg_30_0.curMode == ChallengeProxy.MODE_INFINITE and var_30_2 > ChallengeConst.BOSS_NUM then
		var_30_2 = var_30_2 % ChallengeConst.BOSS_NUM == 0 and ChallengeConst.BOSS_NUM or var_30_2 % ChallengeConst.BOSS_NUM
	end

	local function var_30_3(arg_31_0)
		arg_31_0.material:SetFloat("_LineGray", 0.3)
		arg_31_0.material:SetFloat("_TearDistance", 0)
		LeanTween.cancel(arg_31_0.gameObject)
		LeanTween.value(arg_31_0.gameObject, 0, 2, 2):setLoopClamp():setOnUpdate(System.Action_float(function(arg_32_0)
			if arg_32_0 >= 1.2 then
				arg_31_0.material:SetFloat("_LineGray", 0.3)
			elseif arg_32_0 >= 1.1 then
				arg_31_0.material:SetFloat("_LineGray", 0.45)
			elseif arg_32_0 >= 1.03 then
				arg_31_0.material:SetFloat("_TearDistance", 0)
			elseif arg_32_0 >= 1 then
				arg_31_0.material:SetFloat("_TearDistance", 0.3)
			elseif arg_32_0 >= 0.35 then
				arg_31_0.material:SetFloat("_LineGray", 0.3)
			elseif arg_32_0 >= 0.3 then
				arg_31_0.material:SetFloat("_LineGray", 0.4)
			elseif arg_32_0 >= 0.25 then
				arg_31_0.material:SetFloat("_LineGray", 0.3)
			elseif arg_32_0 >= 0.2 then
				arg_31_0.material:SetFloat("_LineGray", 0.4)
			end

			return
		end))

		return
	end

	setPaintingPrefabAsync(arg_30_0.painting, var_30_0[var_30_1], "chuanwu", function()
		local var_33_0 = arg_30_0.painting:Find("fitter"):GetChild(0)

		if var_33_0 then
			local var_33_1 = GetComponent(var_33_0, "MeshImage")
			local var_33_2 = var_30_2 - 1 - var_30_1 >= 0

			SetActive(arg_30_0.completeEffectTF, var_30_2 - 1 - var_30_1 >= 0)

			if var_33_2 then
				var_33_1.material = arg_30_0.material1

				var_33_1.material:SetFloat("_LineDensity", 7)
				var_30_3(var_33_1)
			else
				var_33_1.material = arg_30_0.material

				var_33_1.material:SetFloat("_Range", 16)
				var_33_1.material:SetFloat("_Degree", 7)
			end
		end

		return
	end)
	setPaintingPrefabAsync(arg_30_0.paintingShadow1, var_30_0[var_30_1], "chuanwu", function()
		local var_34_0 = arg_30_0.paintingShadow1:Find("fitter"):GetChild(0)

		if var_34_0 then
			var_34_0:GetComponent("Image").color = Color.New(0, 0, 0, 0.44)
		end

		return
	end)
	setPaintingPrefabAsync(arg_30_0.paintingShadow2, var_30_0[var_30_1], "chuanwu", function()
		local var_35_0 = arg_30_0.paintingShadow2:Find("fitter"):GetChild(0)

		if var_35_0 then
			var_35_0:GetComponent("Image").color = Color.New(1, 1, 1, 0.15)
		end

		return
	end)
	LoadSpriteAsync("ChallengeBossInfo/" .. arg_30_0.infoNameList[var_30_1], function(arg_36_0)
		setImageSprite(arg_30_0.bossInfoImg, arg_36_0, true)

		return
	end)

	if var_0_0.BOSS_NUM - var_30_1 >= 2 then
		setActive(arg_30_0.roundTF_1, true)
		setActive(arg_30_0.roundTF_2, true)
		setActive(arg_30_0.mask_1, true)
		setActive(arg_30_0.mask_2, true)
		LoadSpriteAsync("shipYardIcon/" .. var_30_0[var_30_1 + 1], function(arg_37_0)
			setImageSprite(arg_30_0.shipPaintImg_1, arg_37_0)

			return
		end)
		LoadSpriteAsync("shipYardIcon/" .. var_30_0[var_30_1 + 2], function(arg_38_0)
			setImageSprite(arg_30_0.shipPaintImg_2, arg_38_0)

			return
		end)
	elseif var_0_0.BOSS_NUM - var_30_1 == 1 then
		setActive(arg_30_0.roundTF_1, true)
		setActive(arg_30_0.roundTF_2, false)
		setActive(arg_30_0.mask_1, true)
		setActive(arg_30_0.mask_2, false)
		LoadSpriteAsync("shipYardIcon/" .. var_30_0[var_30_1 + 1], function(arg_39_0)
			setImageSprite(arg_30_0.shipPaintImg_1, arg_39_0)

			return
		end)

		if arg_30_0.curMode == ChallengeProxy.MODE_INFINITE then
			LoadSpriteAsync("shipYardIcon/" .. arg_30_0.nextNameList[var_30_1 + 2], function(arg_40_0)
				setImageSprite(arg_30_0.shipPaintImg_2, arg_40_0)
				setActive(arg_30_0.mask_2, true)
				setActive(arg_30_0.roundTF_2, true)

				return
			end)
		end
	else
		setActive(arg_30_0.roundTF_1, false)
		setActive(arg_30_0.roundTF_2, false)
		setActive(arg_30_0.mask_1, false)
		setActive(arg_30_0.mask_2, false)

		if arg_30_0.curMode == ChallengeProxy.MODE_INFINITE then
			LoadSpriteAsync("shipYardIcon/" .. arg_30_0.nextNameList[var_30_1 + 1], function(arg_41_0)
				setImageSprite(arg_30_0.shipPaintImg_1, arg_41_0)
				setActive(arg_30_0.mask_1, true)
				setActive(arg_30_0.roundTF_1, true)

				return
			end)
			LoadSpriteAsync("shipYardIcon/" .. arg_30_0.nextNameList[var_30_1 + 2], function(arg_42_0)
				setImageSprite(arg_30_0.shipPaintImg_2, arg_42_0)
				setActive(arg_30_0.mask_2, true)
				setActive(arg_30_0.roundTF_2, true)

				return
			end)
		end
	end

	if var_30_2 - 1 - var_30_1 >= 2 then
		setActive(arg_30_0.tag_1, true)
		setActive(arg_30_0.tag_2, true)
	elseif var_30_2 - 1 - var_30_1 == 1 then
		setActive(arg_30_0.tag_1, true)
		setActive(arg_30_0.tag_2, false)
	elseif var_30_2 - 1 - var_30_1 <= 0 then
		setActive(arg_30_0.tag_1, false)
		setActive(arg_30_0.tag_2, false)
	end

	return
end

function var_0_0.updateRoundText(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_1 or arg_43_0.showingIndex

	if arg_43_0.curMode == ChallengeProxy.MODE_CASUAL and var_43_0 > ChallengeConst.BOSS_NUM then
		var_43_0 = var_43_0 % ChallengeConst.BOSS_NUM == 0 and ChallengeConst.BOSS_NUM or var_43_0 % ChallengeConst.BOSS_NUM
	end

	setText(arg_43_0.roundNumText, string.format("%02d", var_43_0))
	setText(arg_43_0.roundText_1, "Round" .. var_43_0 + 1)
	setText(arg_43_0.roundText_2, "Round" .. var_43_0 + 2)

	return
end

function var_0_0.updateSlider(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_1 or arg_44_0.showingIndex
	local var_44_1 = arg_44_0.curLevel

	if (arg_44_1 or arg_44_0.showingIndex) > ChallengeConst.BOSS_NUM then
		var_44_0 = var_44_0 % ChallengeConst.BOSS_NUM == 0 and ChallengeConst.BOSS_NUM or var_44_0 % ChallengeConst.BOSS_NUM
	end

	if arg_44_0.curMode == ChallengeProxy.MODE_INFINITE and var_44_1 > ChallengeConst.BOSS_NUM and (var_44_1 % ChallengeConst.BOSS_NUM ~= 0 or not ChallengeConst.BOSS_NUM) then
		::label_44_0::

		var_44_1 = var_44_1 % ChallengeConst.BOSS_NUM
	end

	arg_44_0.sliderSC.value = (var_44_1 - 1) * (1 / (ChallengeConst.BOSS_NUM - 1))

	arg_44_0.squareList:make(function(arg_45_0, arg_45_1, arg_45_2)
		local var_45_0 = arg_45_2:Find("UnFinished")
		local var_45_1 = arg_45_2:Find("Finished")
		local var_45_2 = arg_45_2:Find("Challengeing")
		local var_45_3 = arg_45_2:Find("Arrow")

		if arg_45_0 == UIItemList.EventUpdate then
			if arg_45_1 + 1 < var_44_1 then
				(function()
					setActive(var_45_1, true)
					setActive(var_45_0, false)
					setActive(var_45_2, false)

					return
				end)()
			elseif arg_45_1 + 1 == var_44_1 then
				(function()
					setActive(var_45_1, false)
					setActive(var_45_0, false)
					setActive(var_45_2, true)

					return
				end)()
			elseif arg_45_1 + 1 > var_44_1 then
				(function()
					setActive(var_45_1, false)
					setActive(var_45_0, true)
					setActive(var_45_2, false)

					return
				end)()
			end

			if arg_45_1 + 1 == var_44_0 then
				setActive(var_45_3, true)
			else
				setActive(var_45_3, false)
			end
		end

		return
	end)
	arg_44_0.squareList:align(ChallengeConst.BOSS_NUM)

	return
end

function var_0_0.updateGrade(arg_49_0, arg_49_1)
	setText(arg_49_0.seasonBestPointText, arg_49_1.seasonMaxScore)
	setText(arg_49_0.activityBestPointText, arg_49_1.activityMaxScore)
	setText(arg_49_0.seasonLevelNumText, arg_49_1.seasonMaxLevel)
	setText(arg_49_0.activityLevelNumText, arg_49_1.activityMaxLevel)

	return
end

function var_0_0.updateTimePanel(arg_50_0)
	setText(arg_50_0.activityTimeText, (pg.TimeMgr.GetInstance():STimeDescS(getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_CHALLENGE).stopTime, "%Y.%m.%d")))

	local var_50_0 = pg.TimeMgr.GetInstance()
	local var_50_1, var_50_2, var_50_3, var_50_4 = var_50_0:parseTimeFrom(var_50_0:GetNextWeekTime(1, 0, 0, 0) - var_50_0:GetServerTime())

	setText(arg_50_0.seasonDayText, var_50_1)
	setText(arg_50_0.seasonTimeText, string.format("%02d:%02d:%02d", var_50_2, var_50_3, var_50_4))

	if arg_50_0.timer then
		arg_50_0.timer:Stop()
	end

	arg_50_0.timer = Timer.New(function()
		var_0 = var_0 - 1

		local var_51_0, var_51_1, var_51_2, var_51_3 = pg.TimeMgr.GetInstance():parseTimeFrom(var_0)

		setText(arg_50_0.seasonDayText, var_51_0)
		setText(arg_50_0.seasonTimeText, string.format("%02d:%02d:%02d", var_51_1, var_51_2, var_51_3))

		if var_0 <= 0 then
			arg_50_0.timeOverTag = true

			arg_50_0.timer:Stop()
		end

		return
	end, 1, -1)

	arg_50_0.timer:Start()

	return
end

function var_0_0.updateSwitchModBtn(arg_52_0)
	if not arg_52_0:isFinishedCasualMode() then
		setActive(arg_52_0.infiniteModBtn, false)
	else
		setActive(arg_52_0.infiniteModBtn, true)
	end

	if arg_52_0.curMode == ChallengeProxy.MODE_CASUAL then
		setActive(arg_52_0.casualModBtnBG, true)
		setActive(arg_52_0.infiniteModBtnBG, false)
	else
		setActive(arg_52_0.casualModBtnBG, false)
		setActive(arg_52_0.infiniteModBtnBG, true)
	end

	onButton(arg_52_0, arg_52_0.casualModBtn, function()
		if arg_52_0.curMode == ChallengeProxy.MODE_CASUAL then
			return
		end

		local var_53_0 = arg_52_0.curModeInfo and arg_52_0.curModeInfo:getLevel() or 0

		local function var_53_1()
			arg_52_0.challengeProxy:setCurMode(ChallengeProxy.MODE_CASUAL)
			setActive(arg_52_0.casualModBtnBG, true)
			setActive(arg_52_0.infiniteModBtnBG, false)
			arg_52_0:updateData()
			arg_52_0:updatePaintingList(arg_52_0.nameList, arg_52_0.showingIndex)
			arg_52_0:updateRoundText(arg_52_0.showingIndex)
			arg_52_0:updateSlider(arg_52_0.showingIndex)
			arg_52_0:updateSwitchModBtn()
			arg_52_0:updateFuncBtns()
			arg_52_0:showTipText()

			return
		end

		if arg_52_0:isCrossedSeason() then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = false,
				content = i18n("challenge_season_update_infinite_switch", var_53_0),
				onYes = function()
					arg_52_0:emit(ChallengeConst.RESET_DATA_EVENT, ChallengeProxy.MODE_INFINITE)

					return
				end,
				onNo = var_53_1
			})

			return
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = false,
			content = i18n("challenge_infinite_click_switch", var_53_0),
			onYes = var_53_1
		})

		return
	end, SFX_PANEL)
	onButton(arg_52_0, arg_52_0.infiniteModBtn, function()
		if arg_52_0.curMode == ChallengeProxy.MODE_INFINITE then
			return
		end

		if arg_52_0.curModeInfo then
			local var_56_0 = arg_52_0.curModeInfo:getScore() or arg_52_0.challengeInfo:getGradeList().seasonMaxScore

			local function var_56_1()
				arg_52_0.challengeProxy:setCurMode(ChallengeProxy.MODE_INFINITE)
				setActive(arg_52_0.casualModBtnBG, false)
				setActive(arg_52_0.infiniteModBtnBG, true)
				arg_52_0:updateData()
				arg_52_0:updatePaintingList(arg_52_0.nameList, arg_52_0.showingIndex)
				arg_52_0:updateRoundText(arg_52_0.showingIndex)
				arg_52_0:updateSlider(arg_52_0.showingIndex)
				arg_52_0:updateFuncBtns()
				arg_52_0:showTipText()

				return
			end

			if arg_52_0:isCrossedSeason() then
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					hideNo = false,
					content = i18n("challenge_season_update_casual_switch", var_56_0),
					onYes = function()
						arg_52_0:emit(ChallengeConst.RESET_DATA_EVENT, ChallengeProxy.MODE_CASUAL)

						return
					end,
					onNo = var_56_1
				})

				return
			end

			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = false,
				content = i18n("challenge_casual_click_switch", var_56_0),
				onYes = var_56_1
			})

			return
		end
	end, SFX_PANEL)

	return
end

function var_0_0.updateResetBtn(arg_59_0)
	if arg_59_0.userChallengeInfoList[arg_59_0.curMode] then
		setActive(arg_59_0.resetBtn, true)
		SetActive(arg_59_0.resetBtnBanned, false)
	else
		setActive(arg_59_0.resetBtn, false)
		SetActive(arg_59_0.resetBtnBanned, true)
	end

	return
end

function var_0_0.updateStartBtn(arg_60_0)
	if arg_60_0.userChallengeInfoList[arg_60_0.curMode] then
		if arg_60_0.curMode == ChallengeProxy.MODE_CASUAL and arg_60_0.userChallengeInfoList[arg_60_0.curMode]:getLevel() > ChallengeConst.BOSS_NUM then
			SetActive(arg_60_0.startBtn, false)
			SetActive(arg_60_0.startBtnBanned, true)
		else
			SetActive(arg_60_0.startBtn, true)
			SetActive(arg_60_0.startBtnBanned, false)
		end
	else
		SetActive(arg_60_0.startBtn, true)
		SetActive(arg_60_0.startBtnBanned, false)
	end

	return
end

function var_0_0.updateFuncBtns(arg_61_0)
	arg_61_0:updateResetBtn()
	arg_61_0:updateStartBtn()

	return
end

function var_0_0.updateAwardPanel(arg_62_0)
	local var_62_0 = pg.activity_template[getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_CHALLENGE).id].config_data[1]
	local var_62_1 = getProxy(TaskProxy):getTaskById(pg.activity_template[var_62_0].config_data[1]) or getProxy(TaskProxy):getFinishTaskById(pg.activity_template[var_62_0].config_data[1])

	setText(arg_62_0.scoreText, arg_62_0.challengeInfo:getGradeList().activityMaxScore .. " / " .. var_62_1:getConfig("target_num"))

	local var_62_2 = var_62_1:getTaskStatus()

	if var_62_2 == 0 then
		setActive(arg_62_0.getBtn, false)
		setActive(arg_62_0.getBtnBanned, true)
		setActive(arg_62_0.gotBtn, false)
	elseif var_62_2 == 1 then
		setActive(arg_62_0.getBtn, true)
		setActive(arg_62_0.getBtnBanned, false)
		setActive(arg_62_0.gotBtn, false)
	elseif var_62_2 == 2 then
		setActive(arg_62_0.getBtn, false)
		setActive(arg_62_0.getBtnBanned, false)
		setActive(arg_62_0.gotBtn, true)
	end

	local var_62_3 = var_62_1:getConfig("award_display")[1]

	updateDrop(arg_62_0.itemTF, {
		type = var_62_3[1],
		id = var_62_3[2],
		count = var_62_3[3]
	})
	onButton(arg_62_0, arg_62_0.itemTF, function()
		arg_62_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)
	onButton(arg_62_0, arg_62_0.getBtn, function()
		arg_62_0:emit(ChallengeConst.CLICK_GET_AWARD_BTN, var_62_1.id)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.showSLResetMsgBox(arg_65_0)
	local var_65_0 = false
	local var_65_1
	local var_65_2

	for iter_65_0, iter_65_1 in pairs(arg_65_0.userChallengeInfoList) do
		if iter_65_1:getResetFlag() >= ChallengeConst.NEED_TO_RESET_SAVELOAD then
			var_65_0 = true
			var_65_1 = iter_65_1
			var_65_2 = iter_65_0

			break
		end
	end

	if var_65_0 == true then
		local var_65_3
		local var_65_4

		if var_65_2 == ChallengeProxy.MODE_CASUAL then
			var_65_3 = "challenge_casual_reset"
			var_65_4 = var_65_1:getScore()
		elseif var_65_2 == ChallengeProxy.MODE_INFINITE then
			var_65_3 = "challenge_infinite_reset"
			var_65_4 = var_65_1:getLevel() - 1
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			content = i18n(var_65_3, var_65_4),
			onYes = function()
				arg_65_0:emit(ChallengeConst.RESET_DATA_EVENT, var_65_2)

				return
			end,
			onNo = function()
				arg_65_0:emit(ChallengeConst.RESET_DATA_EVENT, var_65_2)

				return
			end
		})
	end

	return
end

function var_0_0.showTipText(arg_68_0)
	setText(arg_68_0.modTipText, i18n(arg_68_0.curMode == ChallengeProxy.MODE_CASUAL and "challenge_normal_tip" or "challenge_unlimited_tip"))

	local var_68_1 = arg_68_0.modTipTF:GetComponent(typeof(DftAniEvent))

	if var_68_1 then
		var_68_1:SetEndEvent(function(arg_69_0)
			setActive(arg_68_0.modTipText, false)
			setActive(arg_68_0.modTipTF, false)

			return
		end)
	end

	setActive(arg_68_0.modTipTF, true)
	setActive(arg_68_0.modTipText, true)

	return
end

function var_0_0.doOnFleetPanel(arg_70_0)
	arg_70_0.fleetEditPanel:attach(arg_70_0)
	arg_70_0.fleetEditPanel:setFleets(arg_70_0.fleets[arg_70_0.curMode])
	arg_70_0.fleetEditPanel:set(1, 1)
	pg.UIMgr.GetInstance():BlurPanel(arg_70_0.fleetEditPanel._tf)

	return
end

function var_0_0.isFinishedCasualMode(arg_71_0)
	local var_71_0 = false

	if arg_71_0.userChallengeInfoList[ChallengeProxy.MODE_INFINITE] then
		var_71_0 = true
	elseif not arg_71_0.userChallengeInfoList[ChallengeProxy.MODE_INFINITE] then
		local var_71_1 = arg_71_0.challengeInfo:getGradeList().seasonMaxLevel

		if arg_71_0.userChallengeInfoList[ChallengeProxy.MODE_CASUAL] then
			var_71_0 = arg_71_0.userChallengeInfoList[ChallengeProxy.MODE_CASUAL]:getSeasonID() == arg_71_0.challengeInfo:getSeasonID() and var_71_1 >= ChallengeConst.BOSS_NUM or false
		elseif var_71_1 >= ChallengeConst.BOSS_NUM then
			var_71_0 = true
		elseif not arg_71_0.userChallengeInfoList[ChallengeProxy.MODE_CASUAL] then
			var_71_0 = false
		end
	end

	return var_71_0
end

function var_0_0.isCrossedSeason(arg_72_0)
	local var_72_0 = false

	if arg_72_0.timeOverTag == true then
		var_72_0 = true
	elseif arg_72_0.curModeInfo then
		if arg_72_0.curModeInfo:getSeasonID() ~= arg_72_0.challengeInfo:getSeasonID() then
			var_72_0 = true
		end
	else
		var_72_0 = false
	end

	return var_72_0
end

function var_0_0.commitEdit(arg_73_0)
	arg_73_0:emit(ChallengeMainMediator.ON_COMMIT_FLEET)

	return
end

function var_0_0.openShipInfo(arg_74_0, arg_74_1, arg_74_2)
	arg_74_0:emit(ChallengeMainMediator.ON_FLEET_SHIPINFO, {
		shipId = arg_74_1,
		shipVOs = arg_74_2
	})

	return
end

function var_0_0.hideFleetEdit(arg_75_0)
	setActive(arg_75_0.fleetSelect, false)
	arg_75_0:closeCommanderPanel()
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_75_0.fleetSelect, arg_75_0._tf)
	setParent(arg_75_0.fleetSelect, arg_75_0._tf, false)

	return
end

function var_0_0.updateEditPanel(arg_76_0)
	arg_76_0.fleetEditPanel:setFleets(arg_76_0.fleets[arg_76_0.curMode])
	arg_76_0.fleetEditPanel:updateFleets()

	return
end

function var_0_0.setCommanderPrefabs(arg_77_0, arg_77_1)
	arg_77_0.commanderPrefabs = arg_77_1

	return
end

function var_0_0.openCommanderPanel(arg_78_0, arg_78_1, arg_78_2)
	local var_78_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_CHALLENGE).id

	arg_78_0.levelCMDFormationView:setCallback(function(arg_79_0)
		if arg_79_0.type == LevelUIConst.COMMANDER_OP_SHOW_SKILL then
			arg_78_0:emit(ChallengeMainMediator.ON_COMMANDER_SKILL, arg_79_0.skill)
		elseif arg_79_0.type == LevelUIConst.COMMANDER_OP_ADD then
			arg_78_0.contextData.eliteCommanderSelected = {
				fleetIndex = arg_78_2,
				cmdPos = arg_79_0.pos,
				mode = arg_78_0.curMode
			}

			arg_78_0:emit(ChallengeMainMediator.ON_SELECT_ELITE_COMMANDER, arg_78_2, arg_79_0.pos)
			arg_78_0:closeCommanderPanel()
			arg_78_0:hideFleetEdit()
		else
			arg_78_0:emit(ChallengeMainMediator.COMMANDER_FORMATION_OP, {
				FleetType = LevelUIConst.FLEET_TYPE_ACTIVITY,
				data = arg_79_0,
				fleetId = arg_78_1.id,
				actId = var_78_0
			})
		end

		return
	end)
	arg_78_0.levelCMDFormationView:Load()
	arg_78_0.levelCMDFormationView:ActionInvoke("update", arg_78_1, arg_78_0.commanderPrefabs)
	arg_78_0.levelCMDFormationView:ActionInvoke("Show")

	return
end

function var_0_0.closeCommanderPanel(arg_80_0)
	if arg_80_0.levelCMDFormationView:isShowing() then
		arg_80_0.levelCMDFormationView:ActionInvoke("Hide")
	end

	return
end

function var_0_0.updateCommanderFleet(arg_81_0, arg_81_1)
	if arg_81_0.levelCMDFormationView:isShowing() then
		arg_81_0.levelCMDFormationView:ActionInvoke("updateFleet", arg_81_1)
	end

	return
end

function var_0_0.updateCommanderPrefab(arg_82_0)
	if arg_82_0.levelCMDFormationView:isShowing() then
		arg_82_0.levelCMDFormationView:ActionInvoke("updatePrefabs", arg_82_0.commanderPrefabs)
	end

	return
end

function var_0_0.buildCommanderPanel(arg_83_0)
	arg_83_0.levelCMDFormationView = LevelCMDFormationView.New(arg_83_0.fleetSelect, arg_83_0.event, arg_83_0.contextData)

	return
end

function var_0_0.destroyCommanderPanel(arg_84_0)
	arg_84_0.levelCMDFormationView:Destroy()

	arg_84_0.levelCMDFormationView = nil

	return
end

return var_0_0
