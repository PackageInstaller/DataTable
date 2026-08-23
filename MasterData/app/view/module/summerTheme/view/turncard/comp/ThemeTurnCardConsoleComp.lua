local var_0_0 = g.core.model.User.themeData
local var_0_1 = g.core.const.ConstMgr.ThemeConst
local ThemeTurnCardConsoleComp = class("ThemeTurnCardConsoleComp")

function ThemeTurnCardConsoleComp:ctor()
	self._waveId = 0
	self._cardCompArrays = nil
	self._cardTagArray = nil
	self._themeValue = 0
end

function ThemeTurnCardConsoleComp:refreshConsoleView(arg_2_1)
	self._themeValue = arg_2_1
	self._turnCardData = var_0_0:getThemeData(arg_2_1):getTurnCardData()
	self._phaseId = self._turnCardData:getCurTurnCardPhase()
	self._waveId = self._turnCardData:getCurTurnCardWave()
	self._cardTagArray = self._turnCardData:getRandWaveResGroupData(self._phaseId, self._waveId)

	self:_createCardsComp()
end

function ThemeTurnCardConsoleComp:_createCardsComp()
	self:removeChildren()

	local var_3_0 = var_0_1.TURNCARD_SIZE
	local var_3_1 = self._turnCardData:getWaveInfoByPhase(self._phaseId, self._waveId)

	if var_3_1 then
		local var_3_2 = var_3_1.column_num

		if var_3_1.column_num * var_3_1.row_num > var_0_1.TURNCARD_SCALE.COUNT then
			var_3_0.width = var_3_0.width * var_0_1.TURNCARD_SCALE.SCALE
			var_3_0.height = var_3_0.height * var_0_1.TURNCARD_SCALE.SCALE
		end

		local var_3_3 = (var_0_1.TURNCARD_CONSOLE_SIZE.width - var_3_0.width * var_3_2) / var_3_2
		local var_3_4 = {
			x = 0,
			y = 0
		}

		self._cardCompArrays = {}

		for iter_3_0 = 1, var_3_1.row_num do
			var_3_4.y = iter_3_0 > 1 and var_3_4.y + var_3_0.height + (var_0_1.TURNCARD_CONSOLE_SIZE.height - var_3_0.height * var_3_1.row_num) / var_3_1.row_num or var_3_0.height / 2 + (var_0_1.TURNCARD_CONSOLE_SIZE.height - var_3_0.height * var_3_1.row_num) / var_3_1.row_num / 2

			for iter_3_1 = 1, var_3_2 do
				local var_3_5 = fgui.UIPackage:createObject("summerThemeGame", "ThemeTurnCardComp")

				var_3_4.x = iter_3_1 > 1 and var_3_4.x + var_3_0.width + var_3_3 or var_3_0.width / 2 + var_3_3 / 2

				var_3_5:setPosition(var_3_4)
				self:addChild(var_3_5)
				table.insert(self._cardCompArrays, var_3_5)
			end
		end

		for iter_3_2 = 1, #self._cardCompArrays do
			if self._cardCompArrays[iter_3_2] and self._cardTagArray[iter_3_2] then
				self._cardCompArrays[iter_3_2]:setName(var_0_1.TURN_CARD_NAME .. iter_3_2)
				self._cardCompArrays[iter_3_2]:updateIcon(self._cardTagArray[iter_3_2], iter_3_2, self._themeValue)

				if var_3_1.column_num * var_3_1.row_num > var_0_1.TURNCARD_SCALE.COUNT then
					self._cardCompArrays[iter_3_2]:setScale(var_0_1.TURNCARD_SCALE.SCALE)
				end
			end
		end
	end
end

function ThemeTurnCardConsoleComp:getCardCompByIdx(arg_4_1)
	local var_4_0 = self:getChild(arg_4_1)

	if var_4_0 then
		return var_4_0
	end

	return nil
end

function ThemeTurnCardConsoleComp:getCanTurnCardComp()
	if not next(self._cardCompArrays) then
		return nil
	end

	for iter_5_0 = 1, #self._cardCompArrays do
		if self._cardCompArrays[iter_5_0]:isBack() then
			return self._cardCompArrays[iter_5_0]
		end
	end
end

function ThemeTurnCardConsoleComp:checkCurWaveTurnCardIsEnd()
	if not next(self._cardCompArrays) then
		return
	end

	for iter_6_0 = 1, #self._cardCompArrays do
		if not self._cardCompArrays[iter_6_0]:isRight() then
			return
		end
	end

	self:newScheduleOnce(handler(self, function()
		self:dispatchCompEvent("UPDATE_NEXT_WAVE")
	end), 0.3)
end

function ThemeTurnCardConsoleComp:playEnterAnimation()
	for iter_8_0 = 1, #self._cardCompArrays do
		local var_8_0 = self._cardCompArrays[iter_8_0]

		if self._cardCompArrays[iter_8_0] then
			self._cardCompArrays[iter_8_0]:runFGAction(fgui.FSequence:create(fgui.FDelayTime:create(0.03 * iter_8_0), fgui.FCallFunc:create(function()
				var_8_0:playTransition()
			end)))
		end
	end
end

function ThemeTurnCardConsoleComp:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
end

return ThemeTurnCardConsoleComp
