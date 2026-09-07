local EducateBuff = class("EducateBuff", import("model.vo.BaseVO"))

EducateBuff.TYPE_ATTR = 1
EducateBuff.TYPE_RES = 2
EducateBuff.ADDITION_TYPE_RATIO = 1
EducateBuff.ADDITION_TYPE_NUMBER = 2

function EducateBuff:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = self.id
	self.endTime = arg_1_1.time or EducateHelper.GetTimeAfterWeeks(getProxy(EducateProxy):GetCurTime(), self:getConfig("during_time"))

	return
end

function EducateBuff:bindConfigTable()
	return pg.child_buff
end

function EducateBuff:GetReaminTime(arg_3_1)
	arg_3_1 = arg_3_1 or getProxy(EducateProxy):GetCurTime()

	return EducateHelper.GetDaysBetweenTimes(arg_3_1, self.endTime)
end

function EducateBuff:GetReaminWeek(arg_4_1)
	local var_4_0 = self:GetReaminTime(arg_4_1)

	if var_4_0 == 0 then
		return 0
	else
		return var_4_0 / 7
	end

	return
end

function EducateBuff:ResetEndTime(arg_5_1)
	arg_5_1 = arg_5_1 or getProxy(EducateProxy):GetCurTime()
	self.endTime = EducateHelper.GetTimeAfterWeeks(arg_5_1, self:getConfig("during_time"))

	return
end

function EducateBuff:IsEnd(arg_6_1)
	return self:GetReaminTime(arg_6_1) < 0
end

function EducateBuff:IsAttrType()
	return self:getConfig("effect")[1] == EducateBuff.TYPE_ATTR
end

function EducateBuff:IsResType()
	return self:getConfig("effect")[1] == EducateBuff.TYPE_RES
end

function EducateBuff:IsId(arg_9_1)
	return self:getConfig("effect")[2] == arg_9_1
end

function EducateBuff:IsRatio()
	return self:getConfig("effect")[3] == EducateBuff.ADDITION_TYPE_RATIO
end

function EducateBuff:IsNumber()
	return self:getConfig("effect")[3] == EducateBuff.ADDITION_TYPE_NUMBER
end

function EducateBuff:GetEffectValue()
	if self:IsRatio() then
		return self:getConfig("effect")[4] / 16
	elseif self:IsNumber() then
		return self:getConfig("effect")[4]
	end

	return 0
end

function EducateBuff:GetBuffEffects()
	local var_13_0 = 0
	local var_13_1 = 0

	underscore.each(self, function(arg_14_0)
		if arg_14_0:IsRatio() then
			var_13_0 = var_13_0 + arg_14_0:GetEffectValue()
		elseif arg_14_0:IsNumber() then
			var_13_1 = var_13_1 + arg_14_0:GetEffectValue()
		end

		return
	end)

	return 0, 0
end

return EducateBuff
