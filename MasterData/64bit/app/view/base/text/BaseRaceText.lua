local var_0_0 = 3
local var_0_1 = 1
local var_0_2 = 0
local var_0_3 = {
	MOVE_TO = 2,
	MOVE_BY = 1
}
local var_0_4 = {
	left = {
		alignStyle = 0,
		anchorPos = {
			x = 0,
			y = 0.5
		}
	},
	right = {
		alignStyle = 2,
		anchorPos = {
			x = 1,
			y = 0.5
		}
	},
	middle = {
		alignStyle = 1,
		anchorPos = {
			x = 0.5,
			y = 0.5
		}
	}
}
local var_0_5 = {
	ONLY_LONG = 2,
	EVERY_TIME = 1,
	NOT_PLAY = 3
}
local var_0_6 = {
	L2R = 2,
	R2L = 1
}
local BaseRaceText = class("BaseRaceText", require("app.fairyGUI.base_new.UI_BaseRaceText"))

function BaseRaceText:ctor()
	self._maxWidth = 0
	self._maxHeight = 0
	self._scrollDirection = 1
	self._duration = 0
	self._startPos = cc.p(0, 0)
	self._endPos = cc.p(0, 0)
	self._moveDis = 0
	self._moveType = var_0_3.MOVE_TO
	self._alignType = "left"
	self._pauseTime = var_0_2
	self.m_title = self:getChild("title")
end

function BaseRaceText:initRaceTextParams(arg_2_1)
	self:_initRaceParameters(arg_2_1)
	self:setTitle(arg_2_1.title or "")

	if arg_2_1 and arg_2_1.bg then
		self.m_bg:setURL(arg_2_1.bg)
	end
end

function BaseRaceText:play()
	if self._playMode == var_0_5.NOT_PLAY then
		return
	elseif self._playMode == var_0_5.EVERY_TIME then
		self:_playRaceTxt()
	elseif self._playMode == var_0_5.ONLY_LONG then
		local var_3_0 = self:getTextSize()
		local var_3_1 = self:getContainerSize()

		if self._scrollDirection == 1 or self._scrollDirection == 2 then
			if var_3_0.width > var_3_1.width then
				self:_playRaceTxt()
			end
		elseif var_3_0.height > var_3_1.height then
			self:_playRaceTxt()
		end
	end
end

function BaseRaceText:_playRaceTxt()
	local var_4_0 = self._startPos
	local var_4_1 = self._endPos
	local var_4_2 = self._duration
	local var_4_3 = self._moveDis
	local var_4_4 = self._scrollDirection

	self.m_title:stopAllFGActions()
	self.m_title:runFGAction((fgui.FRepeatForever:create((fgui.FSequence:create({
		fgui.FCallFunc:create(function()
			self:setTitlePos(var_4_0.x)
		end),
		(function()
			local var_5_0

			if self._moveType == var_0_3.MOVE_TO then
				var_5_0 = fgui.FMoveTo:create(var_4_2, var_4_1)
			elseif var_4_4 == var_0_6.R2L then
				var_5_0 = fgui.FMoveBy:create(var_4_2, {
					y = 0,
					x = -var_4_3
				})
			elseif var_4_4 == var_0_6.L2R then
				var_5_0 = fgui.FMoveBy:create(var_4_2, {
					y = 0,
					x = var_4_3
				})
			end

			return var_5_0
		end)(),
		fgui.FDelayTime:create(self._pauseTime)
	})))))
end

function BaseRaceText:_initRaceParameters(arg_7_1)
	if arg_7_1 then
		self._moveType = arg_7_1.moveType or var_0_3.MOVE_TO
	end

	if arg_7_1 then
		self._scrollDirection = arg_7_1.direction or var_0_1
	end

	if arg_7_1 then
		self._duration = arg_7_1.duration or var_0_0
	end

	if arg_7_1 then
		self._playMode = arg_7_1.playMode or var_0_5.EVERY_TIME
	end

	if self._moveType == var_0_3.MOVE_TO then
		self:_setStartAndEndPos(arg_7_1)
	else
		self:setStartPos(arg_7_1)

		self._moveDis = arg_7_1 and arg_7_1.moveDistance and arg_7_1.moveDistance or math.max(0, self:getTextSize().width - self:getContainerSize().width)
	end

	if arg_7_1 then
		self._pauseTime = arg_7_1.pauseTime or var_0_2
	end
end

function BaseRaceText:_getDefaultMoveDisByRangeType(arg_8_1)
	if arg_8_1 == 1 then
		-- block empty
	elseif arg_8_1 == 2 then
		-- block empty
	end
end

function BaseRaceText:_setStartAndEndPos(arg_9_1)
	local var_9_1

	self:setStartPos(arg_9_1.startPos)

	if arg_9_1 and arg_9_1.endPos then
		var_9_1 = arg_9_1.endPos
	elseif self._scrollDirection == var_0_6.R2L then
		var_9_1 = cc.p(0, self.m_title:getY())
	elseif self._scrollDirection == var_0_6.L2R then
		var_9_1 = cc.p(self:getContainerSize().width, self.m_title:getY())
	end

	self._endPos = var_9_1
end

function BaseRaceText:getTextSize()
	return self.m_title:getSize()
end

function BaseRaceText:setTitlePos(arg_11_1)
	if type(arg_11_1) == "number" then
		self.m_title:setX(arg_11_1)
	end
end

function BaseRaceText:setTitleAlign(arg_12_1)
	if arg_12_1 then
		self._alignType = arg_12_1

		self.m_title:setPivot(var_0_4[arg_12_1].anchorPos.x, var_0_4[arg_12_1].anchorPos.y, true)

		if arg_12_1 == "left" then
			self.m_title:setPosition(cc.p(0, self.m_title:getY()))
		elseif arg_12_1 == "middle" then
			self.m_title:setPosition(cc.p(self:getContainerSize().width / 2, self.m_title:getY()))
		else
			self.m_title:setPosition(cc.p(self:getContainerSize().width, self.m_title:getY()))
		end
	end
end

function BaseRaceText:getContainerSize()
	return self:getSize()
end

function BaseRaceText:setStartPos(arg_14_1)
	if arg_14_1 then
		self._startPos = arg_14_1

		return
	end

	local var_14_0 = self:getTextPosition().y

	self._startPos = self._alignType == "left" and cc.p(0, var_14_0) or cc.p(self:getContainerSize().width, var_14_0)
end

function BaseRaceText:setEndPos(arg_15_1)
	if arg_15_1 then
		self._endPos = arg_15_1

		return
	end

	local var_15_0 = self:getTextPosition().y
	local var_15_1 = math.max(self:getTextPosition().x - self:getContainerSize().width, 0)

	self._endPos = self._alignType == "left" and cc.p(-var_15_1, var_15_0) or cc.p(self:getContainerSize().width + var_15_1, var_15_0)
end

function BaseRaceText:setContainerSize(arg_16_1)
	self:setSize(arg_16_1)
end

function BaseRaceText:setMoveDistance(arg_17_1)
	self._moveDis = arg_17_1
end

function BaseRaceText:getTextPosition()
	return self.m_title:getPosition()
end

function BaseRaceText:setDuration(arg_19_1)
	self._duration = arg_19_1
end

function BaseRaceText:setAlignType(arg_20_1, arg_20_2)
	self._alignType = arg_20_1

	if arg_20_2 then
		self:setTitleAlign(self._alignType)
	end
end

function BaseRaceText:setPauseTime(arg_21_1)
	self._pauseTime = arg_21_1 > 0 and arg_21_1 or var_0_2
end

return BaseRaceText
