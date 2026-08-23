local var_0_0 = g.core.const.ConstMgr.ThemeConst
local ThemePuzzlePlayLayer = class("ThemePuzzlePlayLayer", require("app.fairyGUI.summerThemeGame.UI_ThemePuzzlePlayLayer"), function()
	local var_1_0 = {
		pkgPath = "ui/summerThemeGame/summerThemeGame",
		isFullScreen = true,
		pkgName = "summerThemeGame"
	}

	var_1_0.resName = var_0_0.THEME_PUZZLE_PLAY_LAYER[({
		...
	})[1].themeValue] or var_0_0.THEME_PUZZLE_PLAY_LAYER[10]

	return fgui.GComponent:create(var_1_0, ...)
end)
local var_0_2 = g.core.const.ConstMgr.ThemeConst
local var_0_3 = g.core.model.User.themeData
local var_0_4 = g.core.config.game_puzzle_wave_info
local var_0_5 = g.core.config.game_puzzle_res_info
local var_0_6 = 3

function ThemePuzzlePlayLayer:ctor(arg_2_1)
	self._themeId = arg_2_1 and arg_2_1.themeValue
	self._miniGameId = arg_2_1 and arg_2_1.miniGameId
	self._randPicId = arg_2_1 and arg_2_1.randPicId
	self._hasPlayed = false
	self._guideTimeRunner = 0
	self._needResetPartitionComp = false

	self:addBg(var_0_2.THEME_PUZZLE_BG[self._themeId] or var_0_2.THEME_PUZZLE_BG[10])

	local var_2_0 = var_0_3:getThemeData(self._themeId):getThemePuzzleData()

	self._themePuzzleData = var_2_0
	self._phase = var_2_0:getCurPhase()

	local var_2_1 = var_2_0:getPhasePuzzleInfo(self._phase)

	self._baseTime = var_2_1.base_time
	self._restTime = self._baseTime
	self._pieceNum = var_2_1.range_x * var_2_1.range_y
	self._efftime = var_2_1.efftime

	local var_2_2 = var_0_4.get((self._themePuzzleData:getRandPicId()))

	self._resGroup = var_2_2.res_group

	self:_initPieceData()

	local var_2_3 = self:_getPartitionCompNameByNum(self._pieceNum)

	self._partitionComp = require("app.view.module.summerTheme.view.puzzle.comp.ThemePuzzlePartitionComp").new({
		pieceNum = self._pieceNum,
		group = self._resGroup,
		resName = var_2_3,
		allPieceSet = self._allPieceSet
	})

	self._partitionComp:setName(var_2_3)
	self.m_partitionHolderComp:addChild(self._partitionComp)
	self.m_show_partitionController:setSelectedIndex(0)
	self.m_stageController:setSelectedIndex(0)
	self.m_showPicComp:updatePic({
		groupPic = var_2_2.group_pic,
		page = self._pieceNum
	})
	self.m_pauseBtn:addClickListener(handler(self, self._onClickPauseBtn))
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
end

function ThemePuzzlePlayLayer:_initPieceData()
	self._isDragging = false
	self._idlePieceArray = {}
	self._insertPieceMap = {}
	self._dragPiece = nil
	self._allPieceSet = {}

	for iter_3_0, iter_3_1 in var_0_5.ipairs() do
		if iter_3_1.group == self._resGroup then
			self._allPieceSet[#self._allPieceSet + 1] = iter_3_1
			self._idlePieceArray[#self._idlePieceArray + 1] = iter_3_1
		end
	end

	self._idlePieceArray = table.shuffle2(self._idlePieceArray)
end

function ThemePuzzlePlayLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUZZLE_RESULT, handler(self, self._onPuzzleResult), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MINIMAGE_EXIT_GAME, handler(self, self._exitGame), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)

	if self.m_stageController:getSelectedIndex() == 0 then
		self:_onDrawCurtainByStringText(g.core.lang:get(405900), true, handler(self, function()
			return
		end), true)
		self.m_enter_0Transition:play(handler(self, function()
			self.m_stageController:setSelectedIndex(1)
			self:_startPuzzleGame()
		end))
	end
end

function ThemePuzzlePlayLayer:_onPuzzleResult(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	return
end

function ThemePuzzlePlayLayer:receiveCompEvent(arg_8_1, arg_8_2)
	arg_8_2 = arg_8_2 or {}
end

function ThemePuzzlePlayLayer:_onGameStart()
	self.m_stageController:setSelectedIndex(0)
	self:_onDrawCurtainByStringText(g.core.lang:get(405900), true, handler(self, function()
		return
	end), true)
	self.m_enter_0Transition:play(handler(self, function()
		self.m_stageController:setSelectedIndex(1)
		self:_startPuzzleGame()
	end))
end

function ThemePuzzlePlayLayer:onUnload()
	self:_clearGuideTimer()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
end

function ThemePuzzlePlayLayer:_startPuzzleGame()
	self.m_countdownComp:update({
		restTime = self._baseTime,
		maxTime = self._baseTime
	})
	self.m_progressComp:update({
		complete = 0,
		total = self._pieceNum
	})
	self.m_show_partitionController:setSelectedIndex(1)
	self.m_showPicComp:showPic(false)
	self._partitionComp:playBreakAni()
	self._partitionComp:playFlyAni()
end

function ThemePuzzlePlayLayer:_startCountdown(arg_14_1)
	if arg_14_1 then
		self._restTime = self._baseTime
	end

	self._timeSchedule = self._timeSchedule or self:newSchedule(handler(self, self._updateTime), 0.1)
end

function ThemePuzzlePlayLayer:_updateTime(arg_15_1, arg_15_2)
	local var_15_0 = cc.utils.gettime() / 1000

	self._lastTIme = self._lastTIme or var_15_0

	if var_15_0 - self._lastTIme < arg_15_2 then
		return
	end

	self._lastTIme = var_15_0
	self._restTime = self._restTime - (var_15_0 - self._lastTIme)

	if self._restTime <= 0 then
		self._restTime = 0

		self:cancelSchedule(self._timeSchedule)

		self._timeSchedule = nil
		self._lastTIme = nil

		self:_timeOver()
	end

	self.m_countdownComp:update({
		restTime = self._restTime
	})
end

function ThemePuzzlePlayLayer:_pauseCountdown()
	self:cancelSchedule(self._timeSchedule)

	self._timeSchedule = nil
	self._lastTIme = nil
end

function ThemePuzzlePlayLayer:_onClickPauseBtn()
	self.m_pauseController:setSelectedIndex(1)
	self:_pauseCountdown()
end

function ThemePuzzlePlayLayer:_timeOver()
	self:_onDrawCurtainByStringText(g.core.lang:get(405808), false, handler(self, function()
		self:_sendPuzzleResult()
	end))

	self._isTimeOver = true
end

function ThemePuzzlePlayLayer:_sendPuzzleResult()
	self:_clearGuideTimer()
	g.core.network.GameNetProxy:send_C2S_Puzzle_Result({
		id = self._themeId,
		game_id = self._miniGameId,
		phase = self._phase,
		remain_time = math.ceil(self._restTime),
		state = self._partitionComp:checkRightPieceCount() == self._pieceNum and 1 or 0
	})
end

function ThemePuzzlePlayLayer:receiveCompEvent(arg_21_1, arg_21_2)
	arg_21_2 = arg_21_2 or {}

	if arg_21_1 == "QUIT_TURN_CARD_GAME" then
		self.m_pauseController:setSelectedIndex(0)
		self:_sendPuzzleResult()
	elseif arg_21_1 == "PAUSE_GAME" then
		self.m_pauseController:setSelectedIndex(0)
		self:_startCountdown()
	elseif arg_21_1 == "ThemePuzzle_EnterBigMove" then
		self.m_partitionHolderComp:runFGAction(fgui.FSequence:create(fgui.FMoveTo:create(0.4, (self.m_aniDistComp:getPosition())), fgui.FCallFunc:create(handler(self, function()
			self:_resetPartitionComp()
		end))))
	elseif arg_21_1 == "ThemePuzzle_EnterBigEnd" then
		self.m_pieceComp:updateView({
			group = self._resGroup,
			ctrlIdx = self:_getCtrlIndexByNum(self._pieceNum),
			allPieceSet = self._idlePieceArray
		})
	elseif arg_21_1 == "ThemePuzzle_onEnterBig" then
		self:_resetPartitionComp()
		self:_onDrawCurtainByStringText(g.core.lang:get(405900), false, handler(self, function()
			self:_startCountdown(true)

			if self._guideTimer then
				self:cancelSchedule(self._guideTimer)
			end

			self._guideTimer = self:newSchedule(handler(self, self._onGuideTimer), 0.1)
		end))
	elseif arg_21_1 == "ThemePuzzle_PressSmallPiece" then
		if not self._isDragging then
			self._isDragPiece = true
			self._isDragging = true

			self:_popPiece(self._idlePieceArray, arg_21_2.info, arg_21_2.pos or cc.p(0, 0))
			self.m_pieceComp:updateView({
				group = self._resGroup,
				ctrlIdx = self:_getCtrlIndexByNum(self._pieceNum),
				allPieceSet = self._idlePieceArray
			})
			self.m_pieceComp:setListScrollEnabled(false)
		end
	elseif arg_21_1 == "ThemePuzzle_PressBigPiece" and not self._isDragging then
		self._isDragPiece = true
		self._isDragging = true

		local var_21_0 = cc.pAdd(arg_21_2.pos or cc.p(0, 0), cc.p(10, 10))

		self._partitionComp:popPiece(arg_21_2.info, arg_21_2.cellIdx)
		self:_popPiece(self._insertPieceMap, arg_21_2.info, var_21_0)
	end
end

function ThemePuzzlePlayLayer:_onTouchBegin(arg_24_1)
	arg_24_1:captureTouch()

	local var_24_0 = arg_24_1:getInput():getTouch()

	if not var_24_0 then
		return
	end

	self._beginPos = var_24_0:getLocation()
end

function ThemePuzzlePlayLayer:_onTouchMove(arg_25_1)
	local var_25_0 = arg_25_1:getInput():getTouch()

	if not var_25_0 then
		return
	end

	local var_25_1 = var_25_0:getLocation()

	if self._isDragPiece then
		self._dragComp:setPosition({
			x = self._curPos.x + (var_25_1.x - self._beginPos.x),
			y = self._curPos.y - (var_25_1.y - self._beginPos.y)
		})
		self:_dragMovePiece()
	end
end

function ThemePuzzlePlayLayer:_onTouchEnd()
	if self._isDragPiece then
		self:_dragEndPiece()
	end
end

function ThemePuzzlePlayLayer:_dragMovePiece(arg_27_1)
	if self._stopDragWhenAction then
		return
	end

	if arg_27_1 then
		self._isDragPiece = false
	end

	if not self._isDragShow then
		local var_27_1 = self._partitionComp:getPieceInsertData(self._checkIndex or 0)

		if var_27_1 then
			self._isDragging = true

			local var_27_2 = cc.pAdd(var_27_1.pos or cc.p(0, 0), cc.p(10, 10))

			self._partitionComp:popPiece(var_27_1.info, var_27_1.cellIdx)
			self:_popPiece(self._insertPieceMap, var_27_1.info, var_27_2)
		end
	end

	self:_resetGuideTime()

	if self.m_showPicComp:containPoint((self._dragComp:getPosition())) then
		local var_27_3 = self.m_showPicComp:getPosition()
		local var_27_4 = self.m_showPicComp:getSize()
		local var_27_5 = self._dragComp:getSize()

		self._dragComp:setDragBounds((cc.rect(var_27_3.x, var_27_3.y, var_27_4.width + var_27_5.width, var_27_4.height + var_27_5.height)))
	end
end

function ThemePuzzlePlayLayer:_dragEndPiece(arg_28_1)
	if self._stopDragWhenAction then
		return
	end

	self._isDragPiece = false

	self:_resetGuideTime()
	self.m_pieceComp:setListScrollEnabled(true)

	if not self._isDragShow or self._isTimeOver then
		return
	end

	local var_28_0 = self._dragComp:getPosition()
	local var_28_1 = self._dragComp:getPieceInfo()

	if not self.m_showPicComp:containPoint(var_28_0) or self.m_pieceComp:containPoint(var_28_0) then
		self._stopDragWhenAction = true

		self._dragComp:runFGAction(fgui.FSequence:create({
			fgui.FMoveTo:create(0.1, (cc.p(self.m_aniDistComp:getPosition().x, var_28_0.y))),
			fgui.FFadeOut:create(0.1),
			fgui.FHide:create(),
			fgui.FCallFunc:create(function()
				self._isDragging = false

				self:_insertPiece(self._idlePieceArray, var_28_1, 1)
				self.m_pieceComp:updateView({
					group = self._resGroup,
					ctrlIdx = self:_getCtrlIndexByNum(self._pieceNum),
					allPieceSet = self._idlePieceArray
				})

				self._stopDragWhenAction = false
			end)
		}))

		return
	end

	local var_28_2, var_28_3, var_28_4 = self._partitionComp:checkInsertPiece({
		info = var_28_1,
		toPos = var_28_0
	})

	self._checkIndex = var_28_2 and var_28_4 or 0

	if var_28_2 then
		self._dragComp:setPosition(var_28_3)

		self._isDragging = false

		self._partitionComp:insert(var_28_1, var_28_4)
		self._partitionComp:updateView()
		self:_insertPiece(self._insertPieceMap, var_28_1, var_28_4)
		self:_updateProgress()
	end
end

function ThemePuzzlePlayLayer:_resetPartitionComp()
	if self._needResetPartitionComp then
		self._needResetPartitionComp = false

		self.m_partitionHolderComp:setPosition({
			x = self.m_showPicComp:getPosition().x + self.m_showPicComp:getWidth() / 2 + 3,
			y = self.m_showPicComp:getPosition().y + self.m_showPicComp:getHeight() / 2 + 4
		})
	else
		self._needResetPartitionComp = true
	end
end

function ThemePuzzlePlayLayer:_createDragComp(arg_31_1, arg_31_2)
	self._isDragShow = true
	self._dragPiece = arg_31_1
	self._curPos = arg_31_2

	if self._dragComp then
		self._dragComp:setVisible(true)
		self._dragComp:setOpacity(255)
		self._dragComp:update({
			info = arg_31_1
		})
		self._dragComp:setPosition(arg_31_2)

		return
	end

	local var_31_0 = fgui.UIPackage:createObject("summerThemeGame", "ThemePuzzlePieceCell")

	var_31_0:setPivot(0.5, 0.5, true)
	var_31_0:update({
		info = arg_31_1
	})
	var_31_0:setPosition(arg_31_2)
	self:getView():addChildAt(var_31_0, self:getView():numChildren() - 1)
	var_31_0:setDraggable(true)
	var_31_0:addEventListener(fgui.UIEventType.DragMove, handler(self, self._dragMovePiece))
	var_31_0:addEventListener(fgui.UIEventType.DragEnd, handler(self, self._dragEndPiece))

	self._dragComp = var_31_0
end

function ThemePuzzlePlayLayer:_popPiece(arg_32_1, arg_32_2, arg_32_3)
	self:_resetGuideTime()
	self:_createDragComp(arg_32_2, arg_32_3)

	if arg_32_1 == self._idlePieceArray then
		for iter_32_0, iter_32_1 in ipairs(self._idlePieceArray) do
			if iter_32_1.id == arg_32_2.id then
				table.remove(self._idlePieceArray, iter_32_0)

				break
			end
		end
	elseif arg_32_1 == self._insertPieceMap then
		for iter_32_2, iter_32_3 in pairs(self._insertPieceMap) do
			if iter_32_3.id == arg_32_2.id then
				self._insertPieceMap[iter_32_2] = nil

				break
			end
		end
	end
end

function ThemePuzzlePlayLayer:_insertPiece(arg_33_1, arg_33_2, arg_33_3)
	self._dragComp:setOpacity(0)

	self._isDragShow = false
	self._dragPiece = nil
	self._isDragging = false

	if arg_33_1 == self._insertPieceMap then
		if self._insertPieceMap[arg_33_3] then
			self._isDragging = true

			self:_createDragComp(self._insertPieceMap[arg_33_3], (cc.pAdd(self._dragComp:getPosition(), cc.p(10, 10))))
		end

		self._insertPieceMap[arg_33_3] = arg_33_2
	elseif arg_33_1 == self._idlePieceArray then
		table.insert(self._idlePieceArray, arg_33_3, arg_33_2)
	end

	self:_checkPuzzleComplete()
end

function ThemePuzzlePlayLayer:_checkPuzzleComplete()
	if self._partitionComp:checkRightPieceCount() == self._pieceNum then
		self:_playCompleteEffect()
	else
		self._hasPlayed = false
	end
end

function ThemePuzzlePlayLayer:_updateProgress()
	self.m_progressComp:update({
		complete = self._partitionComp:checkRightPieceCount()
	})
end

function ThemePuzzlePlayLayer:_playCompleteEffect()
	if not self._hasPlayed then
		self._hasPlayed = true

		self:_pauseCountdown()
		self.m_showPicComp:showPic(true)
		self.m_completeTransition:play()
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.PUZZLE_FINISH)
		self.m_effectComp:addEffectSpine({
			anim = "play",
			name = "eff_ui_themePuzzle_complete",
			isLoop = false,
			eventHandler = function(self, arg_37_1)
				if self.type == "complete" then
					self:_onDrawCurtainByStringText(g.core.lang:get(405807), false, handler(self, function()
						self:_sendPuzzleResult()
					end))
				end
			end
		})
	end
end

function ThemePuzzlePlayLayer:_onGuideTimer(arg_39_1, arg_39_2)
	if not self._guideTimer then
		return
	end

	if not self._timeSchedule then
		return
	end

	self._guideTimeRunner = self._guideTimeRunner + arg_39_2

	if self._guideTimeRunner > var_0_6 then
		if self._guideTimer then
			self:cancelSchedule(self._guideTimer)

			self._guideTimer = nil
		end

		self:_resetGuideTime()

		if self.m_pieceComp:getGuildComp() then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
				key = "GUILD_THEME_PUZZLE_START",
				targetBtn = self.m_effectComp,
				dragDist = self.m_pieceComp:getGuildComp()
			})
		end
	end
end

function ThemePuzzlePlayLayer:_resetGuideTime()
	self._guideTimeRunner = 0
end

function ThemePuzzlePlayLayer:_clearGuideTimer()
	if self._guideTimer then
		self:cancelSchedule(self._guideTimer)

		self._guideTimer = nil
	end
end

function ThemePuzzlePlayLayer:_onDrawCurtainByStringText(arg_42_1, arg_42_2, arg_42_3, arg_42_4)
	g.core.module.ModuleManager:pushPopup(require("app.view.module.summerTheme.view.turncard.ThemeTurnCardTipsLinePop").new({
		numType = 1,
		title = tostring(arg_42_1),
		isCountDown = arg_42_2,
		callBack = handler(self, function()
			if arg_42_3 then
				arg_42_3()
			end
		end),
		onlyShowTime = arg_42_4
	}), {
		blackOpacity = 0,
		ignoreTouch = true
	})
end

function ThemePuzzlePlayLayer:_exitGame(arg_44_1, arg_44_2, arg_44_3)
	g.core.module.ModuleManager:popModule()
end

function ThemePuzzlePlayLayer:_onCrossDayUpdate()
	if g.core.common.ServerTime:getTime() > self._themePuzzleData:getPuzzleEndTime() then
		g.core.module.ModuleManager:tip(g.core.lang:get(1005))
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function ThemePuzzlePlayLayer:_getCtrlIndexByNum(arg_46_1)
	if arg_46_1 == 9 then
		return 0
	elseif arg_46_1 == 12 then
		return 1
	elseif arg_46_1 == 16 then
		return 2
	end
end

function ThemePuzzlePlayLayer:_getPartitionCompNameByNum(arg_47_1)
	if arg_47_1 == 9 then
		return "ThemePuzzlePartitionComp1"
	elseif arg_47_1 == 12 then
		return "ThemePuzzlePartitionComp2"
	elseif arg_47_1 == 16 then
		return "ThemePuzzlePartitionComp3"
	end
end

return ThemePuzzlePlayLayer
