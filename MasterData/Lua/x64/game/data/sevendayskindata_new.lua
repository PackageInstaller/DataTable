local var_0_0 = require((...):gsub("%.SevenDaySkinData_New", "") .. ".SignInfoStruct_New")
local var_0_1 = singletonClass("SevenDaySkinData_New")

function var_0_1.Ctor(arg_1_0)
	arg_1_0.activity_map = {}
end

function var_0_1:InitData(arg_2_1)
	print("七日签到皮肤初始化", 11097)

	self.activity_map[arg_2_1.activity_id] = var_0_0.New(arg_2_1)

	self:UpdateRedDotCount(arg_2_1.activity_id)
end

function var_0_1:Clear()
	if not self.activity_map then
		return
	end

	for iter_3_0, iter_3_1 in pairs(self.activity_map) do
		iter_3_1:OnCrossDayNew()
		var_0_1:UpdateRedDotCount(iter_3_0)
	end
end

function var_0_1:MaxSignDay()
	return (ActivityCumulativeSignCfg[self.activity_id] or nil) and (#ActivityCumulativeSignCfg[self.activity_id].config_list or 7)
end

function var_0_1:GetActivityData(arg_5_1)
	self.activity_map = self.activity_map or {}

	local var_5_0 = self.activity_map[arg_5_1]

	if not self.activity_map[arg_5_1] then
		var_5_0 = var_0_0.New({
			activity_id = arg_5_1
		})
		self.activity_map[arg_5_1] = var_5_0
	end

	return var_5_0
end

function var_0_1:UpdateActivityData(arg_6_1, arg_6_2)
	self:GetActivityData(arg_6_1):Update(arg_6_2)
	self:UpdateRedDotCount(arg_6_1)
end

function var_0_1:UpdateActivityDataByGiftReward(arg_7_1)
	self:GetActivityData(arg_7_1):UpdateActivityDataByGiftReward()
	self:UpdateRedDotCount(arg_7_1)
end

function var_0_1:UpdateUnlockTimes(arg_8_1)
	self:GetActivityData(arg_8_1):UpdateUnlockTimes()
end

function var_0_1:GetRedDotCount(arg_9_1)
	return self:GetActivityData(arg_9_1):RedDotCount()
end

function var_0_1:GetGiftRedDotCount(arg_10_1)
	return self:GetActivityData(arg_10_1):GetGiftRedDotCount()
end

function var_0_1:UpdateRedDotCount(arg_11_1)
	local var_11_0 = self:GetRedDotCount(arg_11_1)

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN_NEWSIGN, arg_11_1), var_11_0)
	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN, arg_11_1), var_11_0)
	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN_GIFT, arg_11_1), self:GetGiftRedDotCount(arg_11_1) == 0 and 1 or 0)
end

local var_0_2 = false

function var_0_1.GetDlcReward(arg_12_0)
	return var_0_2
end

function var_0_1.SetDlcReward(arg_13_0, arg_13_1)
	var_0_2 = arg_13_1
end

return var_0_1
