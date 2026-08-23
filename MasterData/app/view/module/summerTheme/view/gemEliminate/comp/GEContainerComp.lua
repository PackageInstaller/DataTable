local var_0_0 = g.core.const.ConstMgr.ThemeConst
local var_0_1 = g.core.config.game_eliminate_res_info
local var_0_2 = 110
local var_0_3 = 4
local var_0_4 = 10
local var_0_5 = 3
local var_0_6 = "summerThemeGame"
local var_0_7 = g.core.const.ConstMgr.SoundConst
local var_0_8 = require("app.view.module.summerTheme.const.GemEliminateConst").INVALID_GEM_COLOR
local var_0_9 = {
	RIGHT = 4,
	UP = 1,
	DOWN = 2,
	LEFT = 3,
	NONE = 0
}
local var_0_10 = g.core.sound.SoundManager
local GemEliminateCompPool = require("app.view.module.summerTheme.model.GemEliminateCompPool")
local GEContainerComp = class("GEContainerComp", require("app.fairyGUI.summerThemeGame.UI_GEContainerComp"))

function GEContainerComp:ctor()
	self._row = 5
	self._col = 4
	self._colorNum = 0
	self._gemColorArr = {}
	self._comboCount = 0
	self._moving = false
	self._playing = false
	self._inTouch = false
	self._preTouchPos = nil
	self._gemCellPool = GemEliminateCompPool.new("GemCellPool")
	self._choseRowCol = nil
	self._gemBgCellArr = {}
	self._gemCellDict = {}
	self._touchRangeRect = cc.rect(0, 0, 0, 0)
	self._themeValue = 0

	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
end

function GEContainerComp:updateWithInfo(arg_2_1, arg_2_2)
	self._themeValue = arg_2_2
	self._row = arg_2_1.range_y
	self._col = arg_2_1.range_x
	self._colorNum = arg_2_1.type_num
	self._gemColorArr = self:_getRandomColorArr(arg_2_1.res_group, self._colorNum)
	self._touchRangeRect = self:_getTouchRect(self._row, self._col)

	self:setSize(self._touchRangeRect.width, self._touchRangeRect.height)
	self:_removeAllGem()
	self:_initGemBgCell()
end

function GEContainerComp:_onTouchBegin(arg_3_1)
	if not self._playing then
		return
	elseif self._moving then
		return
	elseif self._inTouch then
		return
	end

	local var_3_0 = arg_3_1:getInput()
	local var_3_1 = self:globalToLocal((var_3_0:getPosition()))

	if cc.rectContainsPoint(self._touchRangeRect, var_3_0) then
		self._preTouchPos = var_3_1

		self:_touchStone(var_3_1)
		arg_3_1:captureTouch()
	else
		self._inTouch = false
	end

	arg_3_1:stopPropagation()
end

function GEContainerComp:_onTouchMove(arg_4_1)
	if not self._playing then
		return
	elseif self._moving then
		return
	elseif not self._inTouch then
		return
	end

	self:_moveStone((self:globalToLocal((arg_4_1:getInput():getPosition()))))
end

function GEContainerComp:_onTouchEnd(arg_5_1)
	if self._moving then
		return
	elseif not self._inTouch then
		return
	end

	self._inTouch = false
end

function GEContainerComp:_touchStone(arg_6_1)
	local var_6_0, var_6_1 = self:_posToRowCol(arg_6_1)
	local var_6_2 = self._gemCellDict[var_6_0][var_6_1]

	if self._choseRowCol then
		self._inTouch = false

		local var_6_3 = self._choseRowCol.row
		local var_6_4 = self._choseRowCol.col

		self._gemCellDict[self._choseRowCol.row][self._choseRowCol.col]:setSelected(false)

		if var_6_4 == var_6_1 and var_6_3 == var_6_0 then
			self._choseRowCol = nil
		else
			local var_6_5 = var_0_9.NONE

			if var_6_3 == var_6_0 then
				if var_6_1 - var_6_4 == -1 then
					var_6_5 = var_0_9.LEFT
				elseif var_6_1 - var_6_4 == 1 then
					var_6_5 = var_0_9.RIGHT
				end
			elseif var_6_4 == var_6_1 then
				if var_6_0 - var_6_3 == -1 then
					var_6_5 = var_0_9.UP
				elseif var_6_0 - var_6_3 == 1 then
					var_6_5 = var_0_9.DOWN
				end
			end

			if var_6_5 == var_0_9.NONE then
				self._choseRowCol = {
					row = var_6_0,
					col = var_6_1
				}

				var_6_2:setSelected(true)
			else
				self._choseRowCol = nil

				self:_doMove(var_6_3, var_6_4, var_6_5)
			end
		end
	else
		self._inTouch = true
		self._choseRowCol = {
			row = var_6_0,
			col = var_6_1
		}

		var_6_2:setSelected(true)
	end
end

function GEContainerComp:_moveStone(arg_7_1)
	local var_7_0, var_7_1 = self:_posToRowCol(self._preTouchPos)
	local var_7_2 = var_0_9.NONE

	if math.abs(arg_7_1.x - self._preTouchPos.x) >= math.abs(arg_7_1.y - self._preTouchPos.y) then
		if arg_7_1.x - self._preTouchPos.x > var_0_4 and var_7_1 < self._col then
			var_7_2 = var_0_9.RIGHT
		elseif arg_7_1.x - self._preTouchPos.x < -var_0_4 and var_7_1 > 1 then
			var_7_2 = var_0_9.LEFT
		end
	elseif arg_7_1.y - self._preTouchPos.y > var_0_4 and var_7_0 < self._row then
		var_7_2 = var_0_9.DOWN
	elseif arg_7_1.y - self._preTouchPos.y < -var_0_4 and var_7_0 > 1 then
		var_7_2 = var_0_9.UP
	end

	if var_7_2 ~= var_0_9.NONE then
		self._choseRowCol = nil
		self._inTouch = false

		self:_unTouchStone(self._preTouchPos)
		self:_doMove(var_7_0, var_7_1, var_7_2)
	end
end

function GEContainerComp:_unTouchStone(arg_8_1)
	if not arg_8_1 then
		return
	end

	local var_8_0, var_8_1 = self:_posToRowCol(arg_8_1)

	if self._gemCellDict[var_8_0][var_8_1] then
		self._gemCellDict[var_8_0][var_8_1]:setSelected(false)
	end
end

function GEContainerComp:_initGemBgCell()
	local var_9_0 = GemEliminateCompPool.new("GemBgCellPool")

	for iter_9_0, iter_9_1 in ipairs(self._gemBgCellArr) do
		for iter_9_2, iter_9_3 in ipairs(iter_9_1) do
			var_9_0:put(iter_9_3)
		end
	end

	for iter_9_4 = 1, self._row do
		self._gemBgCellArr[iter_9_4] = {}

		for iter_9_5 = 1, self._col do
			local var_9_1 = var_9_0:get()

			if not var_9_1 then
				var_9_1 = fgui.UIPackage:createObject(var_0_6, "GEGemBgCell")

				self.m_gemBgCellDad:addChild(var_9_1)
			end

			var_9_1:setPosition((self:_rowColToPos(iter_9_4, iter_9_5)))
			var_9_1:setStarVisible(iter_9_4 < self._row and iter_9_5 < self._col)

			self._gemBgCellArr[iter_9_4][iter_9_5] = var_9_1

			var_9_1:setGameId(var_0_0.THEME_ACTIVITY_GEM_GAME_ID[self._themeValue] or 1)
		end
	end
end

function GEContainerComp:onStartGame()
	if self._colorNum == 0 then
		g.core.log:error("-----------       Error! Start game failed. self._colorNum = 0        ----------")

		return
	end

	self._playing = true

	local var_10_0 = self:_getEnterAniList()

	self:_addGemCell(var_10_0)
	self:_verticalMoveAni(var_10_0, handler(self, self._eliSameGem))
end

function GEContainerComp:onGameOver()
	self._playing = false

	self:_removeAllGem()
	self:_unTouchStone(self._preTouchPos)
end

function GEContainerComp:_addGemCell(arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		local var_12_0 = self._gemCellPool:get()

		if not var_12_0 then
			var_12_0 = fgui.UIPackage:createObject(var_0_6, "GEGemCell")

			self.m_gemCellDad:addChild(var_12_0)
		end

		var_12_0:updateCell({
			selected = false,
			color = iter_12_1.color
		})
		var_12_0:setPosition((self:_rowColToPos(iter_12_1.row, iter_12_1.col)))

		self._gemCellDict[iter_12_1.row][iter_12_1.col] = var_12_0
	end
end

function GEContainerComp:_verticalMoveAni(arg_13_1, arg_13_2)
	self._moving = true

	local function var_13_0()
		self._moving = false

		if arg_13_2 then
			arg_13_2()
		end
	end

	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		self._gemCellDict[iter_13_1.row][iter_13_1.col]:stopAllFGActions()
		self._gemCellDict[iter_13_1.row][iter_13_1.col]:setPosition((self:_rowColToPos(iter_13_1.row - iter_13_1.dis, iter_13_1.col)))

		local var_13_1 = fgui.FMoveTo:create(iter_13_1.dis / 8, (self:_rowColToPos(iter_13_1.row, iter_13_1.col)))

		if iter_13_0 == #arg_13_1 then
			self._gemCellDict[iter_13_1.row][iter_13_1.col]:runFGAction(fgui.FSequence:create(var_13_1, (fgui.FCallFunc:create(handler(self, var_13_0)))))
		else
			self._gemCellDict[iter_13_1.row][iter_13_1.col]:runFGAction(var_13_1)
		end
	end
end

function GEContainerComp:_doMove(arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = arg_15_1
	local var_15_1 = arg_15_2

	if arg_15_3 == var_0_9.UP then
		var_15_0 = var_15_0 - 1
	elseif arg_15_3 == var_0_9.DOWN then
		var_15_0 = var_15_0 + 1
	else
		var_15_1 = arg_15_3 == var_0_9.LEFT and var_15_1 - 1 or var_15_1 + 1
	end

	local var_15_2 = {
		row = arg_15_1,
		col = arg_15_2,
		endRow = var_15_0,
		endCol = var_15_1
	}

	self:_exchangeGemCell(var_15_2, false, handler(self, function()
		local var_16_0 = self:_getEliIdx2DArr()

		if #var_16_0 > 0 then
			self._comboCount = 0

			self:_eliSameGem(var_16_0)
		else
			self:_exchangeGemCell(var_15_2, true)
		end
	end))
end

function GEContainerComp:_exchangeGemCell(arg_17_1, arg_17_2, arg_17_3)
	self._moving = true

	self._gemCellDict[arg_17_1.row][arg_17_1.col]:runFGAction(fgui.FMoveTo:create(0.2, (self:_rowColToPos(arg_17_1.endRow, arg_17_1.endCol))))
	self._gemCellDict[arg_17_1.endRow][arg_17_1.endCol]:runFGAction(fgui.FSequence:create(fgui.FMoveTo:create(0.2, (self:_rowColToPos(arg_17_1.row, arg_17_1.col))), (fgui.FCallFunc:create(handler(self, function()
		self._moving = false

		if arg_17_3 then
			arg_17_3()
		end
	end)))))

	self._gemCellDict[arg_17_1.row][arg_17_1.col] = self._gemCellDict[arg_17_1.endRow][arg_17_1.endCol]
	self._gemCellDict[arg_17_1.endRow][arg_17_1.endCol] = self._gemCellDict[arg_17_1.row][arg_17_1.col]

	if arg_17_2 then
		var_0_10:playSound(var_0_7.Sound.GEM_ELI_SWITCH_BACK)
	else
		var_0_10:playSound(var_0_7.Sound.GEM_ELI_SWITCH)
	end
end

function GEContainerComp:_removeAllGem()
	for iter_19_0, iter_19_1 in pairs(self._gemCellDict) do
		for iter_19_2, iter_19_3 in pairs(iter_19_1) do
			iter_19_3:stopAllFGActions()
			self._gemCellPool:put(iter_19_3)
		end
	end

	for iter_19_4 = 1, self._row do
		self._gemCellDict[iter_19_4] = {}
	end
end

function GEContainerComp:_rowColToPos(arg_20_1, arg_20_2)
	return cc.p((var_0_2 + var_0_3) * (arg_20_2 - 1), (var_0_2 + var_0_3) * (arg_20_1 - 1))
end

function GEContainerComp:_posToRowCol(arg_21_1)
	return math.floor(arg_21_1.y / (var_0_2 + var_0_3)) + 1, math.floor(arg_21_1.x / (var_0_2 + var_0_3)) + 1
end

function GEContainerComp:_getGemColor(arg_22_1, arg_22_2)
	if self._gemCellDict[arg_22_1] then
		if self._gemCellDict[arg_22_1][arg_22_2] then
			return self._gemCellDict[arg_22_1][arg_22_2]:getGemColor()
		end
	end

	return var_0_8
end

function GEContainerComp:_fillEmptySpace()
	local var_23_0 = {}
	local var_23_1 = {}

	for iter_23_0 = 1, self._col do
		local var_23_2 = 0

		for iter_23_1 = self._row, 1, -1 do
			if self._gemCellDict[iter_23_1][iter_23_0] then
				if var_23_2 > 0 then
					self._gemCellDict[iter_23_1][iter_23_0] = nil
					self._gemCellDict[iter_23_1 + var_23_2][iter_23_0] = self._gemCellDict[iter_23_1][iter_23_0]

					table.insert(var_23_1, {
						row = iter_23_1 + var_23_2,
						col = iter_23_0,
						dis = var_23_2
					})
				end
			else
				var_23_2 = var_23_2 + 1
			end
		end

		for iter_23_2 = 1, var_23_2 do
			local var_23_3 = {
				row = iter_23_2,
				col = iter_23_0,
				color = self:getOneRandomGemColor(),
				dis = var_23_2
			}

			table.insert(var_23_0, var_23_3)
			table.insert(var_23_1, var_23_3)
		end
	end

	self:_addGemCell(var_23_0)
	self:_verticalMoveAni(var_23_1, handler(self, self._eliSameGem))
end

function GEContainerComp:_eliSameGem(arg_24_1)
	arg_24_1 = arg_24_1 or self:_getEliIdx2DArr()

	local var_24_0 = #arg_24_1

	if #arg_24_1 == 0 then
		if self:_isCanContinue() then
			-- block empty
		else
			self:_resetGemCells()
		end
	else
		self._moving = true
		self._comboCount = self._comboCount + var_24_0

		local var_24_1 = 0

		for iter_24_0, iter_24_1 in ipairs(arg_24_1) do
			var_24_1 = var_24_1 + #iter_24_1

			for iter_24_2, iter_24_3 in ipairs(iter_24_1) do
				local var_24_2, var_24_3 = self:_indexToRowCol(iter_24_3)

				self:_eliGemWithRowCol(var_24_2, var_24_3)
			end
		end

		self:newScheduleOnce(handler(self, function()
			self._moving = false

			self:_fillEmptySpace()
		end), 0.02 * var_24_1)
		self:dispatchCompEvent("COMP_EVENT_COMBO_CHANGE", {
			comboNum = self._comboCount
		})
		var_0_10:playSound(var_0_7.Sound.GEM_ELI_ELIMINATE)
	end
end

function GEContainerComp:_eliGemWithRowCol(arg_26_1, arg_26_2)
	if not self._gemCellDict[arg_26_1][arg_26_2] then
		return
	end

	self._gemBgCellArr[arg_26_1][arg_26_2]:playEliminateAni((self._gemCellDict[arg_26_1][arg_26_2]:getGemColor()))
	self._gemCellDict[arg_26_1][arg_26_2]:stopAllFGActions()
	self._gemCellPool:put(self._gemCellDict[arg_26_1][arg_26_2])

	self._gemCellDict[arg_26_1][arg_26_2] = nil
end

function GEContainerComp:_getEliIdx2DArr()
	self._removeMarkArr = {}

	local var_27_0 = {}

	for iter_27_0 = 1, self._row do
		for iter_27_1, iter_27_2 in ipairs((self:_getGemIdx2DArrHorSameColor(iter_27_0, var_0_5))) do
			table.insertto(var_27_0, iter_27_2)
		end
	end

	for iter_27_3 = 1, self._col do
		for iter_27_4, iter_27_5 in ipairs((self:_getGemIdx2DArrVerSameColor(iter_27_3, var_0_5))) do
			table.insertto(var_27_0, iter_27_5)
		end
	end

	local var_27_1 = {}

	for iter_27_6, iter_27_7 in pairs(var_27_0) do
		local var_27_2 = {}

		self:_divideGroup(iter_27_7, var_27_2, var_27_0)

		if #var_27_2 > 0 then
			table.insert(var_27_1, var_27_2)
		end
	end

	return var_27_1
end

function GEContainerComp:_getGemIdx2DArrHorSameColor(arg_28_1, arg_28_2)
	local var_28_0 = {}

	local function var_28_1(arg_29_0, arg_29_1, arg_29_2)
		if arg_29_2 - arg_29_1 >= arg_28_2 then
			local var_29_0 = {}

			for iter_29_0 = arg_29_1, arg_29_2 - 1 do
				table.insert(var_29_0, (self:_rowColToIndex(arg_29_0, iter_29_0)))
			end

			table.insert(var_28_0, var_29_0)
		end
	end

	local var_28_2 = 1

	for iter_28_0 = 1, self._col do
		local var_28_4

		if iter_28_0 == self._col then
			if self._gemCellDict[arg_28_1][iter_28_0] and self._gemCellDict[arg_28_1][iter_28_0]:getGemColor() == var_0_8 then
				var_28_1(arg_28_1, var_28_2, iter_28_0 + 1)
			else
				var_28_1(arg_28_1, var_28_2, iter_28_0)
			end
		elseif self._gemCellDict[arg_28_1][iter_28_0] then
			local var_28_3 = self._gemCellDict[arg_28_1][iter_28_0]:getGemColor()

			if var_28_3 ~= var_0_8 then
				var_28_1(arg_28_1, var_28_2, iter_28_0)

				var_28_2 = iter_28_0
				var_28_4 = var_28_3
			end
		else
			var_28_1(arg_28_1, var_28_2, iter_28_0)

			var_28_2 = iter_28_0
			var_28_4 = var_0_8
		end
	end

	return var_28_0
end

function GEContainerComp:_getGemIdx2DArrVerSameColor(arg_30_1, arg_30_2)
	local var_30_0 = {}

	local function var_30_1(arg_31_0, arg_31_1, arg_31_2)
		if arg_31_2 - arg_31_1 >= arg_30_2 then
			local var_31_0 = {}

			for iter_31_0 = arg_31_1, arg_31_2 - 1 do
				table.insert(var_31_0, (self:_rowColToIndex(iter_31_0, arg_31_0)))
			end

			table.insert(var_30_0, var_31_0)
		end
	end

	local var_30_2 = 1

	for iter_30_0 = 1, self._row do
		local var_30_4

		if iter_30_0 == self._row then
			if self._gemCellDict[iter_30_0][arg_30_1] and self._gemCellDict[iter_30_0][arg_30_1]:getGemColor() == var_0_8 then
				var_30_1(arg_30_1, var_30_2, iter_30_0 + 1)
			else
				var_30_1(arg_30_1, var_30_2, iter_30_0)
			end
		elseif self._gemCellDict[iter_30_0][arg_30_1] then
			local var_30_3 = self._gemCellDict[iter_30_0][arg_30_1]:getGemColor()

			if var_30_3 ~= var_0_8 then
				var_30_1(arg_30_1, var_30_2, iter_30_0)

				var_30_2 = iter_30_0
				var_30_4 = var_30_3
			end
		else
			var_30_1(arg_30_1, var_30_2, iter_30_0)

			var_30_2 = iter_30_0
			var_30_4 = var_0_8
		end
	end

	return var_30_0
end

function GEContainerComp:_divideGroup(arg_32_1, arg_32_2, arg_32_3)
	if self._removeMarkArr[arg_32_1] then
		return
	end

	local var_32_0 = self._gemCellDict
	local var_32_1, var_32_2 = self:_indexToRowCol(arg_32_1)
	local var_32_3 = var_32_0[var_32_1] and var_32_0[var_32_1][var_32_2]

	if not var_32_3 then
		return
	end

	self._removeMarkArr[arg_32_1] = true

	table.insert(arg_32_2, arg_32_1)

	local var_32_4 = {
		1,
		-1,
		-self._col,
		self._col
	}
	local var_32_5 = var_32_3:getGemColor()

	for iter_32_0 = 1, #var_32_4 do
		if table.keyof(arg_32_3, arg_32_1 + var_32_4[iter_32_0]) then
			local var_32_6, var_32_7 = self:_indexToRowCol(arg_32_1 + var_32_4[iter_32_0])
			local var_32_8 = var_32_0[var_32_6] and var_32_0[var_32_6][var_32_7]

			if var_32_8 and var_32_8:getGemColor() == var_32_5 then
				self:_divideGroup(arg_32_1 + var_32_4[iter_32_0], arg_32_2, arg_32_3)
			end
		end
	end
end

function GEContainerComp:getOneRandomGemColor()
	return self._gemColorArr[math.random(self._colorNum)] or self._gemColorArr[1]
end

function GEContainerComp:getExceptRandomGemColor(arg_34_1)
	arg_34_1 = arg_34_1 or {}

	local var_34_0 = {}

	for iter_34_0, iter_34_1 in ipairs(self._gemColorArr) do
		if not table.indexof(arg_34_1, iter_34_1) then
			table.insert(var_34_0, iter_34_1)
		end
	end

	return var_34_0[math.random(#var_34_0)] or self._gemColorArr[1]
end

function GEContainerComp:_getEnterAniList()
	local var_35_0 = {}
	local var_35_1 = {}

	for iter_35_0 = 1, self._row do
		local var_35_2 = {}

		for iter_35_1 = 1, self._col do
			local var_35_3 = {}

			if var_35_2[iter_35_1 - 2] and var_35_2[iter_35_1 - 2] == var_35_2[iter_35_1 - 1] then
				table.insert(var_35_3, var_35_2[iter_35_1 - 2])
			end

			local var_35_4 = var_35_1[iter_35_0 - 2] and var_35_1[iter_35_0 - 2][iter_35_1]

			if var_35_4 and var_35_4 == (var_35_1[iter_35_0 - 1] and var_35_1[iter_35_0 - 1][iter_35_1]) then
				table.insert(var_35_3, var_35_4)
			end

			local var_35_5 = #var_35_3 > 0 and self:getExceptRandomGemColor(var_35_3) or self:getOneRandomGemColor()

			var_35_2[iter_35_1] = var_35_5

			table.insert(var_35_0, {
				row = iter_35_0,
				col = iter_35_1,
				color = var_35_5,
				dis = self._col
			})
		end

		var_35_1[iter_35_0] = var_35_2
	end

	return var_35_0
end

function GEContainerComp:_indexToRowCol(arg_36_1)
	local var_36_0 = 1
	local var_36_1 = 1

	if type(arg_36_1) == "number" then
		arg_36_1 = arg_36_1 - 1
		var_36_0 = math.floor(arg_36_1 / self._col) + 1
		var_36_1 = arg_36_1 % self._col + 1
	end

	return var_36_0, var_36_1
end

function GEContainerComp:_rowColToIndex(arg_37_1, arg_37_2)
	if type(arg_37_1) ~= "number" or type(arg_37_2) ~= "number" then
		return 1
	end

	return self._col * (arg_37_1 - 1) + arg_37_2
end

function GEContainerComp:_getTouchRect(arg_38_1, arg_38_2)
	return cc.rect(var_0_3, var_0_3, var_0_2 * arg_38_2 + var_0_3 * (arg_38_2 - 1), var_0_2 * arg_38_1 + var_0_3 * (arg_38_1 - 1))
end

function GEContainerComp:_resetGemCells()
	self:_removeAllGem()

	local var_39_0 = self:_getEnterAniList()

	self:_addGemCell(var_39_0)
	self:_verticalMoveAni(var_39_0, handler(self, self._eliSameGem))
end

function GEContainerComp:_isCanContinue()
	for iter_40_0 = 1, self._row do
		for iter_40_1 = 1, self._col do
			local var_40_0 = self:_getGemColor(iter_40_0, iter_40_1)

			if var_40_0 ~= var_0_8 then
				if iter_40_1 <= self._col - var_0_5 + 1 then
					local var_40_1 = self:_getGemColor(iter_40_0, iter_40_1 + 1)
					local var_40_2 = self:_getGemColor(iter_40_0, iter_40_1 + 2)

					if var_40_1 ~= var_0_8 and var_40_2 ~= var_0_8 then
						if var_40_0 == var_40_1 then
							if self:_isThereSameColorAround(var_40_0, iter_40_0, iter_40_1 + 2, {
								var_0_9.UP,
								var_0_9.DOWN,
								var_0_9.RIGHT
							}) then
								return true
							end
						elseif var_40_0 == var_40_2 then
							if self:_isThereSameColorAround(var_40_0, iter_40_0, iter_40_1 + 1, {
								var_0_9.UP,
								var_0_9.DOWN
							}) then
								return true
							end
						elseif var_40_1 == var_40_2 and self:_isThereSameColorAround(var_40_1, iter_40_0, iter_40_1, {
							var_0_9.UP,
							var_0_9.DOWN,
							var_0_9.LEFT
						}) then
							return true
						end
					end
				end

				if iter_40_0 <= self._row - var_0_5 + 1 then
					local var_40_3 = self:_getGemColor(iter_40_0 + 1, iter_40_1)
					local var_40_4 = self:_getGemColor(iter_40_0 + 2, iter_40_1)

					if var_40_3 ~= var_0_8 and var_40_4 ~= var_0_8 then
						if var_40_0 == var_40_3 then
							if self:_isThereSameColorAround(var_40_0, iter_40_0 + 2, iter_40_1, {
								var_0_9.LEFT,
								var_0_9.RIGHT,
								var_0_9.DOWN
							}) then
								return true
							end
						elseif var_40_0 == var_40_4 then
							if self:_isThereSameColorAround(var_40_0, iter_40_0 + 1, iter_40_1, {
								var_0_9.LEFT,
								var_0_9.RIGHT
							}) then
								return true
							end
						elseif var_40_3 == var_40_4 and self:_isThereSameColorAround(var_40_3, iter_40_0, iter_40_1, {
							var_0_9.LEFT,
							var_0_9.RIGHT,
							var_0_9.UP
						}) then
							return true
						end
					end
				end
			end
		end
	end

	return false
end

function GEContainerComp:_isThereSameColorAround(arg_41_1, arg_41_2, arg_41_3, arg_41_4)
	if self:_getGemColor(arg_41_2, arg_41_3) == arg_41_1 then
		return true
	end

	for iter_41_0, iter_41_1 in ipairs(arg_41_4) do
		local var_41_0 = var_0_8

		if iter_41_1 == var_0_9.UP then
			var_41_0 = self:_getGemColor(arg_41_2 - 1, arg_41_3)
		elseif iter_41_1 == var_0_9.DOWN then
			var_41_0 = self:_getGemColor(arg_41_2 + 1, arg_41_3)
		elseif iter_41_1 == var_0_9.LEFT then
			var_41_0 = self:_getGemColor(arg_41_2, arg_41_3 - 1)
		elseif iter_41_1 == var_0_9.RIGHT then
			var_41_0 = self:_getGemColor(arg_41_2, arg_41_3 + 1)
		end

		if arg_41_1 == var_41_0 then
			return true
		end
	end

	return false
end

function GEContainerComp:_getRandomColorArr(arg_42_1, arg_42_2)
	local var_42_0 = {}
	local var_42_1 = var_0_1.match("res_group", arg_42_1)

	if arg_42_2 < #var_42_1 then
		local var_42_2 = {}

		for iter_42_0 = 1, #var_42_1 do
			var_42_2[iter_42_0] = iter_42_0
		end

		math.newrandomseed()

		for iter_42_1 = 1, arg_42_2 do
			local var_42_3 = math.random(#var_42_2)

			table.remove(var_42_2, var_42_3)
			table.insert(var_42_0, var_42_1[var_42_2[var_42_3]].id)
		end
	else
		for iter_42_2, iter_42_3 in ipairs(var_42_1) do
			table.insert(var_42_0, iter_42_3.id)
		end
	end

	return var_42_0
end

return GEContainerComp
