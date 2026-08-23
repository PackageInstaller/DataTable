local var_0_0 = {
	StopProcessing = 8,
	Error = 7,
	PlayEnd = 6,
	Playing = 5,
	Ready = 4,
	Prep = 3,
	WaitPrep = 2,
	DecHdr = 1,
	Stop = 0,
	NONE = -1
}
local CriSprite = class("CriSprite", function()
	return cricocos2d.Sprite:createWithPlayer()
end)

function CriSprite:ctor(arg_2_1)
	if type(arg_2_1) ~= "table" then
		arg_2_1 = {}
	end

	if g.core.utils.Rule.isSwitchPV2() and arg_2_1.movieName == "cg/02_1334x750_40333" then
		arg_2_1.movieName = "cg/01_1334x750_34583"
	end

	self._params = arg_2_1

	local var_2_0 = arg_2_1.movieName

	assert(arg_2_1.movieName, "unkown movie name")

	local var_2_1, var_2_2, var_2_3 = self:parseMovieName(var_2_0)
	local var_2_4 = arg_2_1.x or 0
	local var_2_5 = arg_2_1.y or 0
	local var_2_6 = arg_2_1.anchorX or 0.5
	local var_2_7 = arg_2_1.anchorY or 0.5
	local var_2_8 = arg_2_1.width or var_2_1
	local var_2_9 = arg_2_1.height or var_2_2
	local var_2_10 = arg_2_1.fullScreenState or 0
	local var_2_11 = arg_2_1.additiveFlag or var_2_3
	local var_2_12 = arg_2_1.isReverse or false
	local var_2_13 = arg_2_1.moduleName

	if arg_2_1.autoRemove ~= nil then
		self._autoRemove = arg_2_1.autoRemove
	end

	self._listener = arg_2_1.listener
	self._isLoop = arg_2_1.isLoop or false

	if var_2_10 > 0 then
		if (var_2_10 == 1 or nil) and (display.width / var_2_8 > 1 or display.height / var_2_9 > 1) then
			local var_2_16 = math.max(display.width / var_2_8, display.height / var_2_9)

			var_2_8 = var_2_8 * var_2_16
			var_2_9 = var_2_9 * var_2_16
		end
	elseif var_2_10 < 0 then
		if display.height / var_2_9 < display.height / var_2_9 then
			var_2_8 = var_2_8 * (display.width / var_2_8)
			var_2_9 = var_2_9 * (display.width / var_2_8)
		else
			var_2_8 = var_2_8 * (display.height / var_2_9)
			var_2_9 = var_2_9 * (display.height / var_2_9)
		end
	end

	self:setAnchorPoint(cc.p(var_2_6, var_2_7))
	self:setPosition(var_2_4, var_2_5)
	self:setQuadVertices(cc.rect(0, 0, var_2_8, var_2_9))
	self:setAdditive(var_2_11)

	if var_2_12 then
		self:setScaleX(-1)
	end

	self:setEventHandler(handler(self, self.cuePointCallback))

	if g.core.utils.Quality.needSkipCriSprite() and self._listener then
		g.core.common.Scheduler:newScheduleOnce(handler(self, self._forceCompleteCallback), 0)
	else
		self:playCriMovie(var_2_0, var_2_13)
	end

	self:onNodeEvent()
	self:setStrictModel(arg_2_1.strict)

	self._statue = var_0_0.NONE
end

function CriSprite:checkStatue()
	if tolua.isnull(self) then
		return
	end

	self._statue = self:getPlayer():getStatus()
end

function CriSprite:_forceCompleteCallback()
	self:cuePointCallback("complete", true)
end

function CriSprite:cuePointCallback(arg_5_1, arg_5_2)
	if self._listener then
		self._listener(arg_5_1, self._isLoop, arg_5_2, self)
	end

	if not self._strictModel then
		if arg_5_1 == "complete" and not self._isLoop and self._autoRemove then
			self:dispose()
		end
	elseif self._statue == var_0_0.PlayEnd and not self._isLoop and self._autoRemove then
		self:dispose()
	end
end

function CriSprite:parseMovieName(arg_6_1)
	local var_6_0 = 100
	local var_6_1 = 100
	local var_6_2 = false

	if arg_6_1 then
		local var_6_3 = string.split(arg_6_1, "_")

		if #var_6_3 > 1 then
			local var_6_4 = string.split(var_6_3[2], "x")

			if #var_6_4 > 1 then
				var_6_0 = tonumber(var_6_4[1])
				var_6_1 = tonumber(var_6_4[2])

				if #var_6_4 > 2 then
					var_6_2 = tonumber(var_6_4[3]) == 1
				end
			end

			if #var_6_3 > 2 then
				self._time = tonumber(var_6_3[3])
			end
		end
	end

	return var_6_0, var_6_1, var_6_2
end

function CriSprite:playCriMovie(arg_7_1, arg_7_2)
	self._manaPlayer = self:getPlayer()

	local var_7_0 = cc.FileUtils:getInstance():fullPathForFilename((g.core.common.Path:getCriMoviePath(arg_7_1, arg_7_2)))

	if device.isAndroid() then
		var_7_0 = string.gsub(var_7_0, "assets/", "")
	end

	self._manaPlayer:setFile(var_7_0)
	self._manaPlayer:loop(self._isLoop)
	self._manaPlayer:prepare()
end

function CriSprite:onEnter()
	self:start()
end

function CriSprite:onExit()
	self:stop()
end

function CriSprite:pause(arg_10_1)
	if self._manaPlayer then
		self._manaPlayer:pause(arg_10_1)
	end
end

function CriSprite:start()
	if self._manaPlayer then
		self._manaPlayer:start()
	end
end

function CriSprite:stop()
	if self._manaPlayer then
		self._manaPlayer:stop()
	end
end

function CriSprite:loop(arg_13_1)
	if arg_13_1 == self._isLoop then
		return
	end

	self._isLoop = arg_13_1

	if self._manaPlayer then
		self._manaPlayer:loop(self._isLoop)
	end
end

function CriSprite:prepare()
	if self._manaPlayer then
		self._manaPlayer:prepare()
	end
end

function CriSprite:getTotalTime()
	if self._time then
		return self._time
	end

	return 0
end

function CriSprite:getTotalFrame()
	return (math.floor(self:getTotalTime() / 33.333334))
end

function CriSprite:isCriSprite()
	return true
end

function CriSprite:setPlaySpeed(arg_18_1)
	if self._manaPlayer == nil then
		return
	end

	local var_18_0 = 1000

	var_18_0 = arg_18_1 >= 1 and arg_18_1 * var_18_0 or arg_18_1 * var_18_0

	self._manaPlayer:setPlaySpeed(var_18_0, 1000)
end

function CriSprite:setPlayFrame(arg_19_1, arg_19_2)
	if self._manaPlayer then
		self._manaPlayer:setPlayPosition(arg_19_1, arg_19_2)
	end
end

function CriSprite:setSeekPositionEditor(arg_20_1)
	if self._manaPlayer then
		self._manaPlayer:setSeekPositionEditor(arg_20_1)
	end
end

function CriSprite:getTotalFramesPerFile()
	if self._manaPlayer then
		return self._manaPlayer:getTotalFramesPerFile()
	end

	return 0
end

function CriSprite:dispose()
	self:clearCheckTimer()
	self:stop()

	self._manaPlayer = nil

	self:removeFromParent()
end

function CriSprite:setStrictModel(arg_23_1)
	self:clearCheckTimer()

	self._strictModel = arg_23_1

	if arg_23_1 then
		self._statueTimer = g.core.common.Scheduler:newSchedule(handler(self, self.checkStatue), 0.5)
	end
end

function CriSprite:clearCheckTimer()
	if self._statueTimer then
		g.core.common.Scheduler:cancelSchedule(self._statueTimer)
	end

	self._statueTimer = nil
end

return CriSprite
