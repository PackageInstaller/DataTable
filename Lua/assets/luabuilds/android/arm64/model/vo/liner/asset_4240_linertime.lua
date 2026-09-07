local LinerTime = class("LinerTime", import("model.vo.BaseVO"))

LinerTime.TYPE = {
	EVENT = 3,
	STORY = 4,
	TARGET = 1,
	EXPLORE = 2
}
LinerTime.EVENT_SUB_TYPE = {
	STORY = 2,
	CLUE = 1
}
LinerTime.BG_TYPE = {
	DAY = "day",
	NIGTH = "night",
	AURORA = "aurora",
	DUSK = "dusk"
}

function LinerTime:Ctor(arg_1_1)
	self.id = arg_1_1
	self.configId = self.id

	return
end

function LinerTime:bindConfigTable()
	return pg.activity_liner_time
end

function LinerTime:GetTime()
	return self:getConfig("time")
end

function LinerTime:GetStartTimeDesc()
	local var_4_0 = self:GetTime()[1]

	if var_4_0 > 12 then
		var_4_0 = var_4_0 - 12
	end

	return var_4_0 .. ":00 " .. (var_4_0 < 12 and "AM" or "PM")
end

function LinerTime:GetEndTimeDesc()
	local var_5_0 = self:GetTime()[2]

	if var_5_0 > 12 then
		var_5_0 = var_5_0 - 12
	end

	return var_5_0 .. ":00 " .. (var_5_0 < 12 and "AM" or "PM")
end

function LinerTime:GetLogDesc()
	local var_6_0 = self:GetTime()[1]
	local var_6_1 = self:GetTime()[2] - 1
	local var_6_2

	if var_6_0 > 12 then
		var_6_2 = var_6_0 - 12 or var_6_0

		if var_6_1 > 12 and not (var_6_1 - 12) then
			-- block empty
		end
	end

	return string.format("%d:00 %s~%d:59 %s", var_6_2, var_6_0 < 12 and "AM" or "PM", var_6_1, var_6_1 < 12 and "AM" or "PM")
end

function LinerTime:GetType()
	return self:getConfig("type")
end

function LinerTime:GetEventSubType(arg_8_1)
	assert(self:GetType() == LinerTime.TYPE.EVENT, "error type")

	local var_8_0 = underscore.detect(self:GetParamInfo(), function(arg_9_0)
		return arg_9_0[1] == arg_8_1
	end)

	assert(var_8_0, "error roomId")

	return var_8_0[2]
end

function LinerTime:GetParamInfo()
	return self:getConfig("param")
end

function LinerTime:GetTargetRoomIds()
	local var_11_0 = {}

	switch(self:GetType(), {
		[LinerTime.TYPE.TARGET] = function()
			table.insert(var_11_0, tonumber(self:GetParamInfo()[1]))

			return
		end,
		[LinerTime.TYPE.EXPLORE] = function()
			return
		end,
		[LinerTime.TYPE.EVENT] = function()
			for iter_14_0, iter_14_1 in ipairs(self:GetParamInfo()) do
				table.insert(var_11_0, iter_14_1[1])
			end

			return
		end,
		[LinerTime.TYPE.STORY] = function()
			table.insert(var_11_0, tonumber(self:GetParamInfo()[1]))

			return
		end
	})

	return var_11_0
end

function LinerTime:GetExploreCnt()
	if self:GetType() ~= LinerTime.TYPE.EXPLORE then
		return 0
	end

	return tonumber(self:GetParamInfo())
end

function LinerTime:GetEventIds()
	if self:GetType() ~= LinerTime.TYPE.EVENT then
		return {}
	end

	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs(self:GetParamInfo()) do
		var_17_0 = table.mergeArray(var_17_0, iter_17_1[4], true)
	end

	return var_17_0
end

function LinerTime:GetStory(arg_18_1)
	local var_18_0 = ""

	switch(self:GetType(), {
		[LinerTime.TYPE.TARGET] = function()
			var_18_0 = self:GetParamInfo()[2]

			return
		end,
		[LinerTime.TYPE.EXPLORE] = function()
			return
		end,
		[LinerTime.TYPE.EVENT] = function()
			local var_21_0 = underscore.detect(self:GetParamInfo(), function(arg_22_0)
				return arg_22_0[1] == arg_18_1
			end)

			if var_21_0 and var_21_0[2] == LinerTime.EVENT_SUB_TYPE.STORY then
				var_18_0 = var_21_0[3]
			end

			return
		end,
		[LinerTime.TYPE.STORY] = function()
			var_18_0 = self:GetParamInfo()[2]

			return
		end
	})

	return ""
end

function LinerTime:GetBeforDesc(arg_24_1)
	local var_24_0 = self:getConfig("desc_before")

	if type(var_24_0) == "table" then
		return HXSet.hxLan(var_24_0[arg_24_1][1])
	else
		return HXSet.hxLan(var_24_0)
	end

	return
end

function LinerTime:GetAfterDesc(arg_25_1)
	local var_25_0 = self:getConfig("desc_after")

	if type(var_25_0) == "table" then
		return HXSet.hxLan(var_25_0[arg_25_1][1])
	else
		return HXSet.hxLan(var_25_0)
	end

	return
end

function LinerTime:GetBgType()
	return self:getConfig("bg_name")
end

function LinerTime:GetBgm(arg_27_1)
	local var_27_0 = "story-niceship-soft"

	switch(arg_27_1 or self:GetBgType(), {
		[LinerTime.BG_TYPE.DAY] = function()
			var_27_0 = "story-niceship-soft"

			return
		end,
		[LinerTime.BG_TYPE.DUSK] = function()
			var_27_0 = "story-richang-5"

			return
		end,
		[LinerTime.BG_TYPE.NIGTH] = function()
			var_27_0 = "story-richang-10"

			return
		end,
		[LinerTime.BG_TYPE.AURORA] = function()
			var_27_0 = "story-richang-quiet"

			return
		end
	})

	return var_27_0
end

return LinerTime
