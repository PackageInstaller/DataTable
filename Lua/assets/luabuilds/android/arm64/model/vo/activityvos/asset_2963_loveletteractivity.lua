local LoveLetterActivity = class("LoveLetterActivity", import("model.vo.Activity"))

function LoveLetterActivity:Ctor(arg_1_1)
	LoveLetterActivity.super.Ctor(self, arg_1_1)

	return
end

function LoveLetterActivity:GetDailyProgress()
	return self.data2, self:getConfig("config_data")[2] * self:getNDay()
end

function LoveLetterActivity:AddDailyProgress(arg_3_1)
	self.data2 = self.data2 + arg_3_1

	assert(self.data2 <= self:getConfig("config_data")[2] * self:getNDay())

	return
end

function LoveLetterActivity:DayReset()
	return
end

function LoveLetterActivity:SetTargetGroupId(arg_5_1)
	self.data1 = arg_5_1

	return
end

function LoveLetterActivity:GetTargetGroupId()
	return self.data1
end

function LoveLetterActivity:AddChangeCount()
	self.data3 = self.data3 + 1

	return
end

function LoveLetterActivity:GetChangeCount()
	return self.data3, self:getConfig("config_data")[3]
end

function LoveLetterActivity:IsLimitExpItem(arg_9_1)
	return arg_9_1 == self:getConfig("config_data")[1]
end

function LoveLetterActivity:FilterExp(arg_10_1)
	local var_10_0, var_10_1 = self:GetDailyProgress()

	return math.min(arg_10_1, var_10_1 - var_10_0)
end

return LoveLetterActivity
