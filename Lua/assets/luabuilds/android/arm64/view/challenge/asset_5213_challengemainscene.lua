local ChallengeMainScene = class("ChallengeMainScene", import("..base.BaseUI"))

ChallengeMainScene.BOSS_NUM = 5
ChallengeMainScene.FADE_TIME = 5

function ChallengeMainScene:getUIName()
	return "ChallengeMainUI"
end

function ChallengeMainScene:init()
	self:findUI()
	self:initData()
	self:addListener()

	return
end

function ChallengeMainScene:didEnter()
	self:updateGrade(self.challengeInfo:getGradeList())
	self:updateTimePanel()
	self:updateSwitchModBtn()
	self:updateAwardPanel()
	self:updatePaintingList(self.nameList, self.showingIndex)
	self:updateRoundText(self.showingIndex)
	self:updateSlider(self.showingIndex)
	self:updateFuncBtns()
	self:showSLResetMsgBox()

	if self.contextData.editFleet then
		self:doOnFleetPanel()

		self.contextData.editFleet = nil
	end

	self:tryPlayGuide()

	return
end

function ChallengeMainScene:willExit()
	LeanTween.cancel(go(self.modTipTF))

	if self.timer then
		self.timer:Stop()
	end

	self:destroyCommanderPanel()

	return
end

function ChallengeMainScene:onBackPressed()
	if isActive(self.fleetSelect) then
		self:hideFleetEdit()
	else
		triggerButton(self.backBtn)
	end

	return
end

function ChallengeMainScene:setFleet(arg_6_1)
	self.fleets = {}

	local function var_6_0(arg_7_0)
		self.fleets[arg_7_0] = {
			arg_6_1[arg_7_0 + 1],
			[11] = arg_6_1[arg_7_0 + 11]
		}

		return
	end

	var_6_0(ChallengeProxy.MODE_CASUAL)
	var_6_0(ChallengeProxy.MODE_INFINITE)

	return
end

function ChallengeMainScene:findUI()
	self.northTF = self._tf:Find("ForNorth")
	self.paintingListTF = self._tf:Find("PaintingList")
	self.backBtn = self.northTF:Find("top/back_button")
	self.gradeContainer = self.northTF:Find("GradeContainer")
	self.seasonBestPointText = self.gradeContainer:Find("SeasonBestPoint/Text")
	self.activityBestPointText = self.gradeContainer:Find("ActivityBestPoint/Text")
	self.seasonLevelNumText = self.gradeContainer:Find("SeasonLevelNum/Text")
	self.activityLevelNumText = self.gradeContainer:Find("ActivityLevelNum/Text")
	self.timeTipTF = self.northTF:Find("TimeTip")
	self.activityTimeText = self.timeTipTF:Find("ActivityTimeText")
	self.seasonDayText = self.timeTipTF:Find("SeasonTipText/DayText")
	self.seasonTimeText = self.timeTipTF:Find("SeasonTimeText")
	self.switchModTF = self.northTF:Find("SwitchMod")
	self.casualModBtn = self.switchModTF:Find("NormalBtn")
	self.infiniteModBtn = self.switchModTF:Find("EndlessBtn")
	self.casualModBtnBG = self.casualModBtn:Find("BG")
	self.infiniteModBtnBG = self.infiniteModBtn:Find("BG")
	self.casualModBtnSC = GetComponent(self.casualModBtn, "Button")
	self.infiniteModBtnSC = GetComponent(self.infiniteModBtn, "Button")
	self.functionBtnsTF = self.northTF:Find("FunctionBtns")
	self.rankBtn = self.functionBtnsTF:Find("RankBtn")
	self.startBtn = self.functionBtnsTF:Find("StartBtn")
	self.resetBtn = self.functionBtnsTF:Find("ResetBtn")
	self.startBtnBanned = self.functionBtnsTF:Find("StartBtnBanned")
	self.resetBtnBanned = self.functionBtnsTF:Find("ResetBtnBanned")
	self.awardTF = self.northTF:Find("Award")
	self.helpBtn = self.awardTF:Find("HelpBtn")
	self.getBtn = self.awardTF:Find("GetBtn")
	self.gotBtn = self.awardTF:Find("GotBtn")
	self.getBtnBanned = self.awardTF:Find("GetBtnBanned")
	self.itemTF = self.awardTF:Find("ItemBG/item")
	self.scoreText = self.awardTF:Find("Score/ScoreText")
	self.slider = self.northTF:Find("Slider")
	self.squareContainer = self.slider:Find("SquareList")
	self.squareTpl = self.slider:Find("Squre")
	self.squareList = UIItemList.New(self.squareContainer, self.squareTpl)
	self.sliderSC = GetComponent(self.slider, "Slider")
	self.paintingContainer = self._tf:Find("PaintingList")
	self.scrollSC = GetComponent(self.paintingContainer, "Slider")
	self.material = self._tf:Find("material"):GetComponent(typeof(Image)).material
	self.material1 = self._tf:Find("material1"):GetComponent(typeof(Image)).material
	self.painting = self.paintingContainer:Find("Painting")
	self.paintingShadow1 = self.painting:Find("PaintingShadow1")
	self.paintingShadow2 = self.painting:Find("PaintingShadow2")
	self.bossInfoImg = self.painting:Find("InfoImg")
	self.roundNumText = self.painting:Find("Round/NumText")
	self.completeEffectTF = self.painting:Find("TZ02")

	SetActive(self.completeEffectTF, false)

	self.card1TF = self.paintingContainer:Find("Card1")
	self.shipPaintImg_1 = self.card1TF:Find("Mask/ShipPaint")
	self.tag_1 = self.card1TF:Find("Tag")
	self.mask_1 = self.card1TF:Find("Mask")
	self.roundTF_1 = self.card1TF:Find("Round")
	self.roundText_1 = self.card1TF:Find("Round/RoundText")
	self.card2TF = self.paintingContainer:Find("Card2")
	self.shipPaintImg_2 = self.card2TF:Find("Mask/ShipPaint")
	self.tag_2 = self.card2TF:Find("Tag")
	self.mask_2 = self.card2TF:Find("Mask")
	self.roundTF_2 = self.card2TF:Find("Round")
	self.roundText_2 = self.card2TF:Find("Round/RoundText")
	self.modTipBtn = self.northTF:Find("ModTipBtn")
	self.modTipTF = self.northTF:Find("TipText")
	self.modTipText = self.modTipTF:Find("Text")

	setActive(self.modTipTF, false)

	self.fleetSelect = self._tf:Find("LevelFleetSelectView")
	self.fleetEditPanel = ActivityFleetPanel.New(self.fleetSelect.gameObject)

	function self.fleetEditPanel.onCancel()
		self:hideFleetEdit()

		return
	end

	function self.fleetEditPanel.onCommit()
		self:commitEdit()

		return
	end

	function self.fleetEditPanel.onCombat()
		self:commitEdit()
		self:emit(ChallengeMainMediator.ON_PRECOMBAT, self.curMode)

		return
	end

	function self.fleetEditPanel.onLongPressShip(arg_12_0, arg_12_1)
		self:openShipInfo(arg_12_0, arg_12_1)

		return
	end

	self:buildCommanderPanel()

	return
end

function ChallengeMainScene:tryPlayGuide()
	pg.SystemGuideMgr.GetInstance():Play(self)

	return
end

function ChallengeMainScene:initData()
	self.challengeProxy = getProxy(ChallengeProxy)
	self.challengeInfo = self.challengeProxy:getChallengeInfo()
	self.userChallengeInfoList = self.challengeProxy:getUserChallengeInfoList()
	self.timeOverTag = false

	self:updateData()

	self.openedCommanerSystem = true

	return
end

function ChallengeMainScene:addListener()
	onButton(self, self.backBtn, function()
		self:emit(ChallengeMainScene.ON_BACK)

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.challenge_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.rankBtn, function()
		self:emit(ChallengeMainMediator.ON_OPEN_RANK)

		return
	end, SFX_PANEL)
	onButton(self, self.startBtn, function()
		local var_19_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_CHALLENGE)

		if not var_19_0 or var_19_0:isEnd() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("challenge_end_tip"))
			triggerButton(self.backBtn)

			return
		end

		if self:isCrossedSeason() == true then
			local var_19_1 = self.challengeProxy:getCurMode()

			if not self.curModeInfo then
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					hideNo = true,
					content = i18n("challenge_season_update"),
					onYes = function()
						self:emit(ChallengeConst.RESET_DATA_EVENT, var_19_1)

						return
					end,
					onNo = function()
						self:emit(ChallengeConst.RESET_DATA_EVENT, var_19_1)

						return
					end
				})

				return
			else
				local var_19_2 = var_19_1 == ChallengeProxy.MODE_CASUAL and "challenge_season_update_casual_clear" or "challenge_season_update_infinite_clear"

				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					hideNo = false,
					content = i18n(var_19_2, (var_19_1 == ChallengeProxy.MODE_CASUAL or nil) and (self.curModeInfo:getScore() or self.curModeInfo:getLevel())),
					onNo = function()
						self:emit(ChallengeConst.RESET_DATA_EVENT, var_19_1)

						return
					end,
					onYes = function()
						self:emit(ChallengeMainMediator.ON_PRECOMBAT, self.curMode)

						return
					end
				})

				return
			end
		end

		if not self.curModeInfo then
			self:doOnFleetPanel()

			return
		end

		self:emit(ChallengeMainMediator.ON_PRECOMBAT, self.curMode)

		return
	end, SFX_PANEL)
	onButton(self, self.resetBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = false,
			content = i18n("challenge_normal_reset"),
			onYes = function()
				self:emit(ChallengeConst.RESET_DATA_EVENT, self.challengeProxy:getCurMode())

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(self, self.modTipBtn, function()
		self:showTipText()

		return
	end)
	addSlip(SLIP_TYPE_HRZ, self.paintingContainer, function()
		if self.showingIndex % ChallengeConst.BOSS_NUM == 1 then
			return
		end

		self.showingIndex = self.showingIndex - 1

		self:updatePaintingList(self.nameList, self.showingIndex)
		self:updateRoundText(self.showingIndex)
		self:updateSlider(self.showingIndex)

		return
	end, function()
		if self.showingIndex % ChallengeConst.BOSS_NUM == 0 then
			return
		end

		self.showingIndex = self.showingIndex + 1

		self:updatePaintingList(self.nameList, self.showingIndex)
		self:updateRoundText(self.showingIndex)
		self:updateSlider(self.showingIndex)

		return
	end)

	return
end

function ChallengeMainScene:updateData()
	self.curMode = self.challengeProxy:getCurMode()
	self.curModeInfo = self.userChallengeInfoList[self.curMode]
	self.timeOverTag = false

	if not self.curModeInfo then
		self.curLevel = 1
		self.showingIndex = self.curLevel

		if self.curMode == ChallengeProxy.MODE_CASUAL then
			self.dungeonIDList = self.challengeInfo:getDungeonIDList()
		elseif self.curMode == ChallengeProxy.MODE_INFINITE then
			self.dungeonIDList = pg.activity_event_challenge[self.challengeInfo:getActivityIndex()].infinite_stage[self.challengeInfo:getSeasonID()][1]
		end
	else
		self.curLevel = self.curModeInfo:getLevel()
		self.showingIndex = self.curLevel
		self.dungeonIDList = self.curModeInfo:getDungeonIDList()
	end

	self.nameList = {}
	self.infoNameList = {}

	for iter_29_0, iter_29_1 in ipairs(self.dungeonIDList) do
		self.nameList[iter_29_0] = pg.expedition_challenge_template[iter_29_1].char_icon[1]
		self.infoNameList[iter_29_0] = pg.expedition_challenge_template[iter_29_1].name_p
	end

	self.nextNameList = {}

	if self.curMode == ChallengeProxy.MODE_INFINITE then
		local var_29_0

		if self.curModeInfo then
			var_29_0 = self.curModeInfo:getNextInfiniteDungeonIDList()
		else
			local var_29_1 = self.challengeInfo:getSeasonID()
			local var_29_2 = self.challengeInfo:getActivityIndex()

			var_29_0 = pg.activity_event_challenge[var_29_2].infinite_stage[var_29_1][2] and pg.activity_event_challenge[var_29_2].infinite_stage[var_29_1][2] or pg.activity_event_challenge[var_29_2].infinite_stage[var_29_1][1]
		end

		for iter_29_2, iter_29_3 in ipairs(var_29_0) do
			self.nextNameList[iter_29_2 + ChallengeConst.BOSS_NUM] = pg.expedition_challenge_template[iter_29_3].char_icon[1]
		end
	end

	return
end

function ChallengeMainScene:updatePaintingList(arg_30_1, arg_30_2)
	local var_30_0 = arg_30_1 or self.nameList
	local var_30_1 = arg_30_2 or self.showingIndex
	local var_30_2 = self.curLevel

	if (arg_30_2 or self.showingIndex) > ChallengeConst.BOSS_NUM then
		var_30_1 = var_30_1 % ChallengeConst.BOSS_NUM == 0 and ChallengeConst.BOSS_NUM or var_30_1 % ChallengeConst.BOSS_NUM
	end

	if self.curMode == ChallengeProxy.MODE_INFINITE and var_30_2 > ChallengeConst.BOSS_NUM then
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

	setPaintingPrefabAsync(self.painting, var_30_0[var_30_1], "chuanwu", function()
		local var_33_0 = self.painting:Find("fitter"):GetChild(0)

		if var_33_0 then
			local var_33_1 = GetComponent(var_33_0, "MeshImage")
			local var_33_2 = var_30_2 - 1 - var_30_1 >= 0

			SetActive(self.completeEffectTF, var_30_2 - 1 - var_30_1 >= 0)

			if var_33_2 then
				var_33_1.material = self.material1

				var_33_1.material:SetFloat("_LineDensity", 7)
				var_30_3(var_33_1)
			else
				var_33_1.material = self.material

				var_33_1.material:SetFloat("_Range", 16)
				var_33_1.material:SetFloat("_Degree", 7)
			end
		end

		return
	end)
	setPaintingPrefabAsync(self.paintingShadow1, var_30_0[var_30_1], "chuanwu", function()
		local var_34_0 = self.paintingShadow1:Find("fitter"):GetChild(0)

		if var_34_0 then
			var_34_0:GetComponent("Image").color = Color.New(0, 0, 0, 0.44)
		end

		return
	end)
	setPaintingPrefabAsync(self.paintingShadow2, var_30_0[var_30_1], "chuanwu", function()
		local var_35_0 = self.paintingShadow2:Find("fitter"):GetChild(0)

		if var_35_0 then
			var_35_0:GetComponent("Image").color = Color.New(1, 1, 1, 0.15)
		end

		return
	end)
	LoadSpriteAsync("ChallengeBossInfo/" .. self.infoNameList[var_30_1], function(arg_36_0)
		setImageSprite(self.bossInfoImg, arg_36_0, true)

		return
	end)

	if ChallengeMainScene.BOSS_NUM - var_30_1 >= 2 then
		setActive(self.roundTF_1, true)
		setActive(self.roundTF_2, true)
		setActive(self.mask_1, true)
		setActive(self.mask_2, true)
		LoadSpriteAsync("shipYardIcon/" .. var_30_0[var_30_1 + 1], function(arg_37_0)
			setImageSprite(self.shipPaintImg_1, arg_37_0)

			return
		end)
		LoadSpriteAsync("shipYardIcon/" .. var_30_0[var_30_1 + 2], function(arg_38_0)
			setImageSprite(self.shipPaintImg_2, arg_38_0)

			return
		end)
	elseif ChallengeMainScene.BOSS_NUM - var_30_1 == 1 then
		setActive(self.roundTF_1, true)
		setActive(self.roundTF_2, false)
		setActive(self.mask_1, true)
		setActive(self.mask_2, false)
		LoadSpriteAsync("shipYardIcon/" .. var_30_0[var_30_1 + 1], function(arg_39_0)
			setImageSprite(self.shipPaintImg_1, arg_39_0)

			return
		end)

		if self.curMode == ChallengeProxy.MODE_INFINITE then
			LoadSpriteAsync("shipYardIcon/" .. self.nextNameList[var_30_1 + 2], function(arg_40_0)
				setImageSprite(self.shipPaintImg_2, arg_40_0)
				setActive(self.mask_2, true)
				setActive(self.roundTF_2, true)

				return
			end)
		end
	else
		setActive(self.roundTF_1, false)
		setActive(self.roundTF_2, false)
		setActive(self.mask_1, false)
		setActive(self.mask_2, false)

		if self.curMode == ChallengeProxy.MODE_INFINITE then
			LoadSpriteAsync("shipYardIcon/" .. self.nextNameList[var_30_1 + 1], function(arg_41_0)
				setImageSprite(self.shipPaintImg_1, arg_41_0)
				setActive(self.mask_1, true)
				setActive(self.roundTF_1, true)

				return
			end)
			LoadSpriteAsync("shipYardIcon/" .. self.nextNameList[var_30_1 + 2], function(arg_42_0)
				setImageSprite(self.shipPaintImg_2, arg_42_0)
				setActive(self.mask_2, true)
				setActive(self.roundTF_2, true)

				return
			end)
		end
	end

	if var_30_2 - 1 - var_30_1 >= 2 then
		setActive(self.tag_1, true)
		setActive(self.tag_2, true)
	elseif var_30_2 - 1 - var_30_1 == 1 then
		setActive(self.tag_1, true)
		setActive(self.tag_2, false)
	elseif var_30_2 - 1 - var_30_1 <= 0 then
		setActive(self.tag_1, false)
		setActive(self.tag_2, false)
	end

	return
end

function ChallengeMainScene:updateRoundText(arg_43_1)
	local var_43_0 = arg_43_1 or self.showingIndex

	if self.curMode == ChallengeProxy.MODE_CASUAL and var_43_0 > ChallengeConst.BOSS_NUM then
		var_43_0 = var_43_0 % ChallengeConst.BOSS_NUM == 0 and ChallengeConst.BOSS_NUM or var_43_0 % ChallengeConst.BOSS_NUM
	end

	setText(self.roundNumText, string.format("%02d", var_43_0))
	setText(self.roundText_1, "Round" .. var_43_0 + 1)
	setText(self.roundText_2, "Round" .. var_43_0 + 2)

	return
end

function ChallengeMainScene:updateSlider(arg_44_1)
	local var_44_0 = arg_44_1 or self.showingIndex
	local var_44_1 = self.curLevel

	if (arg_44_1 or self.showingIndex) > ChallengeConst.BOSS_NUM then
		var_44_0 = var_44_0 % ChallengeConst.BOSS_NUM == 0 and ChallengeConst.BOSS_NUM or var_44_0 % ChallengeConst.BOSS_NUM
	end

	if self.curMode == ChallengeProxy.MODE_INFINITE and var_44_1 > ChallengeConst.BOSS_NUM and (var_44_1 % ChallengeConst.BOSS_NUM ~= 0 or not ChallengeConst.BOSS_NUM) then
		::label_44_0::

		var_44_1 = var_44_1 % ChallengeConst.BOSS_NUM
	end

	self.sliderSC.value = (var_44_1 - 1) * (1 / (ChallengeConst.BOSS_NUM - 1))

	self.squareList:make(function(arg_45_0, arg_45_1, arg_45_2)
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
	self.squareList:align(ChallengeConst.BOSS_NUM)

	return
end

function ChallengeMainScene:updateGrade(arg_49_1)
	setText(self.seasonBestPointText, arg_49_1.seasonMaxScore)
	setText(self.activityBestPointText, arg_49_1.activityMaxScore)
	setText(self.seasonLevelNumText, arg_49_1.seasonMaxLevel)
	setText(self.activityLevelNumText, arg_49_1.activityMaxLevel)

	return
end

function ChallengeMainScene:updateTimePanel()
	setText(self.activityTimeText, (pg.TimeMgr.GetInstance():STimeDescS(getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_CHALLENGE).stopTime, "%Y.%m.%d")))

	local var_50_0 = pg.TimeMgr.GetInstance()
	local var_50_1 = var_50_0:GetNextWeekTime(1, 0, 0, 0) - var_50_0:GetServerTime()
	local var_50_2, var_50_3, var_50_4, var_50_5 = var_50_0:parseTimeFrom(var_50_1)

	setText(self.seasonDayText, var_50_2)
	setText(self.seasonTimeText, string.format("%02d:%02d:%02d", var_50_3, var_50_4, var_50_5))

	if self.timer then
		self.timer:Stop()
	end

	self.timer = Timer.New(function()
		var_50_1 = var_50_1 - 1

		local var_51_0, var_51_1, var_51_2, var_51_3 = pg.TimeMgr.GetInstance():parseTimeFrom(var_50_1)

		setText(self.seasonDayText, var_51_0)
		setText(self.seasonTimeText, string.format("%02d:%02d:%02d", var_51_1, var_51_2, var_51_3))

		if var_50_1 <= 0 then
			self.timeOverTag = true

			self.timer:Stop()
		end

		return
	end, 1, -1)

	self.timer:Start()

	return
end

function ChallengeMainScene:updateSwitchModBtn()
	if not self:isFinishedCasualMode() then
		setActive(self.infiniteModBtn, false)
	else
		setActive(self.infiniteModBtn, true)
	end

	if self.curMode == ChallengeProxy.MODE_CASUAL then
		setActive(self.casualModBtnBG, true)
		setActive(self.infiniteModBtnBG, false)
	else
		setActive(self.casualModBtnBG, false)
		setActive(self.infiniteModBtnBG, true)
	end

	onButton(self, self.casualModBtn, function()
		if self.curMode == ChallengeProxy.MODE_CASUAL then
			return
		end

		local var_53_0 = self.curModeInfo and self.curModeInfo:getLevel() or 0

		local function var_53_1()
			self.challengeProxy:setCurMode(ChallengeProxy.MODE_CASUAL)
			setActive(self.casualModBtnBG, true)
			setActive(self.infiniteModBtnBG, false)
			self:updateData()
			self:updatePaintingList(self.nameList, self.showingIndex)
			self:updateRoundText(self.showingIndex)
			self:updateSlider(self.showingIndex)
			self:updateSwitchModBtn()
			self:updateFuncBtns()
			self:showTipText()

			return
		end

		if self:isCrossedSeason() then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = false,
				content = i18n("challenge_season_update_infinite_switch", var_53_0),
				onYes = function()
					self:emit(ChallengeConst.RESET_DATA_EVENT, ChallengeProxy.MODE_INFINITE)

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
	onButton(self, self.infiniteModBtn, function()
		if self.curMode == ChallengeProxy.MODE_INFINITE then
			return
		end

		local var_56_0

		if self.curModeInfo then
			var_56_0 = self.curModeInfo:getScore() or self.challengeInfo:getGradeList().seasonMaxScore
		end

		local function var_56_1()
			self.challengeProxy:setCurMode(ChallengeProxy.MODE_INFINITE)
			setActive(self.casualModBtnBG, false)
			setActive(self.infiniteModBtnBG, true)
			self:updateData()
			self:updatePaintingList(self.nameList, self.showingIndex)
			self:updateRoundText(self.showingIndex)
			self:updateSlider(self.showingIndex)
			self:updateFuncBtns()
			self:showTipText()

			return
		end

		if self:isCrossedSeason() then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = false,
				content = i18n("challenge_season_update_casual_switch", var_56_0),
				onYes = function()
					self:emit(ChallengeConst.RESET_DATA_EVENT, ChallengeProxy.MODE_CASUAL)

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
	end, SFX_PANEL)

	return
end

function ChallengeMainScene:updateResetBtn()
	if self.userChallengeInfoList[self.curMode] then
		setActive(self.resetBtn, true)
		SetActive(self.resetBtnBanned, false)
	else
		setActive(self.resetBtn, false)
		SetActive(self.resetBtnBanned, true)
	end

	return
end

function ChallengeMainScene:updateStartBtn()
	if self.userChallengeInfoList[self.curMode] then
		if self.curMode == ChallengeProxy.MODE_CASUAL and self.userChallengeInfoList[self.curMode]:getLevel() > ChallengeConst.BOSS_NUM then
			SetActive(self.startBtn, false)
			SetActive(self.startBtnBanned, true)
		else
			SetActive(self.startBtn, true)
			SetActive(self.startBtnBanned, false)
		end
	else
		SetActive(self.startBtn, true)
		SetActive(self.startBtnBanned, false)
	end

	return
end

function ChallengeMainScene:updateFuncBtns()
	self:updateResetBtn()
	self:updateStartBtn()

	return
end

function ChallengeMainScene:updateAwardPanel()
	local var_62_0 = getProxy(TaskProxy):getTaskById(pg.activity_template[pg.activity_template[getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_CHALLENGE).id].config_data[1]].config_data[1])

	var_62_0 = var_62_0 or getProxy(TaskProxy):getFinishTaskById(pg.activity_template[pg.activity_template[getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_CHALLENGE).id].config_data[1]].config_data[1])

	setText(self.scoreText, self.challengeInfo:getGradeList().activityMaxScore .. " / " .. var_62_0:getConfig("target_num"))

	local var_62_1 = var_62_0:getTaskStatus()

	if var_62_1 == 0 then
		setActive(self.getBtn, false)
		setActive(self.getBtnBanned, true)
		setActive(self.gotBtn, false)
	elseif var_62_1 == 1 then
		setActive(self.getBtn, true)
		setActive(self.getBtnBanned, false)
		setActive(self.gotBtn, false)
	elseif var_62_1 == 2 then
		setActive(self.getBtn, false)
		setActive(self.getBtnBanned, false)
		setActive(self.gotBtn, true)
	end

	local var_62_2 = var_62_0:getConfig("award_display")[1]
	local var_62_3 = {
		type = var_62_2[1],
		id = var_62_2[2],
		count = var_62_2[3]
	}

	updateDrop(self.itemTF, var_62_3)
	onButton(self, self.itemTF, function()
		self:emit(BaseUI.ON_DROP, var_62_3)

		return
	end, SFX_PANEL)
	onButton(self, self.getBtn, function()
		self:emit(ChallengeConst.CLICK_GET_AWARD_BTN, var_62_0.id)

		return
	end, SFX_PANEL)

	return
end

function ChallengeMainScene:showSLResetMsgBox()
	local var_65_0 = false
	local var_65_1
	local var_65_2

	for iter_65_0, iter_65_1 in pairs(self.userChallengeInfoList) do
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
				self:emit(ChallengeConst.RESET_DATA_EVENT, var_65_2)

				return
			end,
			onNo = function()
				self:emit(ChallengeConst.RESET_DATA_EVENT, var_65_2)

				return
			end
		})
	end

	return
end

function ChallengeMainScene:showTipText()
	setText(self.modTipText, i18n(self.curMode == ChallengeProxy.MODE_CASUAL and "challenge_normal_tip" or "challenge_unlimited_tip"))

	local var_68_1 = self.modTipTF:GetComponent(typeof(DftAniEvent))

	if var_68_1 then
		var_68_1:SetEndEvent(function(arg_69_0)
			setActive(self.modTipText, false)
			setActive(self.modTipTF, false)

			return
		end)
	end

	setActive(self.modTipTF, true)
	setActive(self.modTipText, true)

	return
end

function ChallengeMainScene:doOnFleetPanel()
	self.fleetEditPanel:attach(self)
	self.fleetEditPanel:setFleets(self.fleets[self.curMode])
	self.fleetEditPanel:set(1, 1)
	pg.UIMgr.GetInstance():BlurPanel(self.fleetEditPanel._tf)

	return
end

function ChallengeMainScene:isFinishedCasualMode()
	local var_71_0 = false

	if self.userChallengeInfoList[ChallengeProxy.MODE_INFINITE] then
		var_71_0 = true
	elseif not self.userChallengeInfoList[ChallengeProxy.MODE_INFINITE] then
		local var_71_1 = self.challengeInfo:getGradeList().seasonMaxLevel

		if self.userChallengeInfoList[ChallengeProxy.MODE_CASUAL] then
			var_71_0 = self.userChallengeInfoList[ChallengeProxy.MODE_CASUAL]:getSeasonID() == self.challengeInfo:getSeasonID() and var_71_1 >= ChallengeConst.BOSS_NUM or false
		elseif var_71_1 >= ChallengeConst.BOSS_NUM then
			var_71_0 = true
		elseif not self.userChallengeInfoList[ChallengeProxy.MODE_CASUAL] then
			var_71_0 = false
		end
	end

	return var_71_0
end

function ChallengeMainScene:isCrossedSeason()
	local var_72_0 = false

	if self.timeOverTag == true then
		var_72_0 = true
	elseif self.curModeInfo then
		if self.curModeInfo:getSeasonID() ~= self.challengeInfo:getSeasonID() then
			var_72_0 = true
		end
	else
		var_72_0 = false
	end

	return var_72_0
end

function ChallengeMainScene:commitEdit()
	self:emit(ChallengeMainMediator.ON_COMMIT_FLEET)

	return
end

function ChallengeMainScene:openShipInfo(arg_74_1, arg_74_2)
	self:emit(ChallengeMainMediator.ON_FLEET_SHIPINFO, {
		shipId = arg_74_1,
		shipVOs = arg_74_2
	})

	return
end

function ChallengeMainScene:hideFleetEdit()
	setActive(self.fleetSelect, false)
	self:closeCommanderPanel()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.fleetSelect, self._tf)
	setParent(self.fleetSelect, self._tf, false)

	return
end

function ChallengeMainScene:updateEditPanel()
	self.fleetEditPanel:setFleets(self.fleets[self.curMode])
	self.fleetEditPanel:updateFleets()

	return
end

function ChallengeMainScene:setCommanderPrefabs(arg_77_1)
	self.commanderPrefabs = arg_77_1

	return
end

function ChallengeMainScene:openCommanderPanel(arg_78_1, arg_78_2)
	local var_78_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_CHALLENGE).id

	self.levelCMDFormationView:setCallback(function(arg_79_0)
		if arg_79_0.type == LevelUIConst.COMMANDER_OP_SHOW_SKILL then
			self:emit(ChallengeMainMediator.ON_COMMANDER_SKILL, arg_79_0.skill)
		elseif arg_79_0.type == LevelUIConst.COMMANDER_OP_ADD then
			self.contextData.eliteCommanderSelected = {
				fleetIndex = arg_78_2,
				cmdPos = arg_79_0.pos,
				mode = self.curMode
			}

			self:emit(ChallengeMainMediator.ON_SELECT_ELITE_COMMANDER, arg_78_2, arg_79_0.pos)
			self:closeCommanderPanel()
			self:hideFleetEdit()
		else
			self:emit(ChallengeMainMediator.COMMANDER_FORMATION_OP, {
				FleetType = LevelUIConst.FLEET_TYPE_ACTIVITY,
				data = arg_79_0,
				fleetId = arg_78_1.id,
				actId = var_78_0
			})
		end

		return
	end)
	self.levelCMDFormationView:Load()
	self.levelCMDFormationView:ActionInvoke("update", arg_78_1, self.commanderPrefabs)
	self.levelCMDFormationView:ActionInvoke("Show")

	return
end

function ChallengeMainScene:closeCommanderPanel()
	if self.levelCMDFormationView:isShowing() then
		self.levelCMDFormationView:ActionInvoke("Hide")
	end

	return
end

function ChallengeMainScene:updateCommanderFleet(arg_81_1)
	if self.levelCMDFormationView:isShowing() then
		self.levelCMDFormationView:ActionInvoke("updateFleet", arg_81_1)
	end

	return
end

function ChallengeMainScene:updateCommanderPrefab()
	if self.levelCMDFormationView:isShowing() then
		self.levelCMDFormationView:ActionInvoke("updatePrefabs", self.commanderPrefabs)
	end

	return
end

function ChallengeMainScene:buildCommanderPanel()
	self.levelCMDFormationView = LevelCMDFormationView.New(self.fleetSelect, self.event, self.contextData)

	return
end

function ChallengeMainScene:destroyCommanderPanel()
	self.levelCMDFormationView:Destroy()

	self.levelCMDFormationView = nil

	return
end

return ChallengeMainScene
