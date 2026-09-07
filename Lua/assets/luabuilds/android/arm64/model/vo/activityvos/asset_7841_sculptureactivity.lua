local SculptureActivity = class("SculptureActivity", import("model.vo.Activity"))

SculptureActivity.STATE_NIL = 0
SculptureActivity.STATE_UNLOCK = 1
SculptureActivity.STATE_DRAW = 2
SculptureActivity.STATE_JOINT = 3
SculptureActivity.STATE_FINSIH = 4

function SculptureActivity:UpdateState(arg_1_1, arg_1_2)
	self.data1KeyValueList[1] = self.data1KeyValueList[1] or {}
	self.data1KeyValueList[1][arg_1_1] = arg_1_2

	return
end

function SculptureActivity:GetSculptureState(arg_2_1)
	return (self.data1KeyValueList[1] or {})[arg_2_1] or SculptureActivity.STATE_NIL
end

function SculptureActivity:getDataConfigTable()
	return pg.activity_giftmake_template
end

function SculptureActivity:getDataConfig(arg_4_1, arg_4_2)
	local var_4_0 = self:getDataConfigTable()

	return var_4_0[arg_4_1] and var_4_0[arg_4_1][arg_4_2]
end

function SculptureActivity:GetComsume(arg_5_1)
	return self:getDataConfig(arg_5_1, "consume")[3]
end

function SculptureActivity:_GetComsume(arg_6_1)
	local var_6_0 = self:getDataConfig(arg_6_1, "consume")

	return var_6_0[2], var_6_0[3]
end

function SculptureActivity:GetResorceName(arg_7_1)
	return self:getDataConfig(arg_7_1, "resources")
end

function SculptureActivity:GetScale(arg_8_1)
	local var_8_0 = self:getDataConfig(arg_8_1, "scaling")

	return Vector3(var_8_0[1], var_8_0[2], 1)
end

function SculptureActivity:CanEnterState(arg_9_1, arg_9_2)
	return self:GetSculptureState(arg_9_1) + 1 == arg_9_2
end

function SculptureActivity:GetAwardProgress()
	local var_10_0 = self:getConfig("config_data")
	local var_10_1 = 0

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		if self:GetSculptureState(iter_10_1) == SculptureActivity.STATE_FINSIH then
			var_10_1 = var_10_1 + 1
		end
	end

	return var_10_1, #var_10_0
end

function SculptureActivity:GetAwards(arg_11_1)
	return self:getDataConfig(arg_11_1, "reward_display")
end

function SculptureActivity:GetAwardDesc(arg_12_1)
	return self:getDataConfig(arg_12_1, "reward_describe") or ""
end

function SculptureActivity:EnoughResToOpen(arg_13_1, arg_13_2)
	local var_13_0, var_13_1 = self:_GetComsume(arg_13_1)

	return var_13_1 < arg_13_2:getVitemNumber(var_13_0)
end

function SculptureActivity:readyToAchieve()
	local var_14_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_VIRTUAL_BAG)

	if not var_14_0 or var_14_0:isEnd() then
		return false
	end

	for iter_14_0, iter_14_1 in ipairs((self:getConfig("config_data"))) do
		if self:GetSculptureState(iter_14_1) == SculptureActivity.STATE_NIL and self:EnoughResToOpen(iter_14_1, var_14_0) then
			return true
		end
	end

	return false
end

return SculptureActivity
