local var_0_0 = require((...):gsub("%.SevenDaySkinData", "") .. ".SignInfoStruct")
local var_0_1 = singletonClass("SevenDaySkinData")

function var_0_1.Ctor(arg_1_0)
	arg_1_0.activity_map = {}
end

function var_0_1:InitData(arg_2_1)
	print("七日签到皮肤初始化", 11080)

	self.activity_map[arg_2_1.activity_id] = var_0_0.New(arg_2_1)

	self:UpdateRedDotCount(arg_2_1.activity_id)
end

function var_0_1:Clear()
	if not self.activity_map then
		return
	end

	for iter_3_0, iter_3_1 in pairs(self.activity_map) do
		iter_3_1:OnCrossDay()
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

function var_0_1:GetRedDotCount(arg_7_1)
	return self:GetActivityData(arg_7_1):RedDotCount()
end

function var_0_1:UpdateRedDotCount(arg_8_1)
	local var_8_0 = self:GetRedDotCount(arg_8_1)

	print(arg_8_1, "------------------------->", var_8_0)
	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN, arg_8_1), var_8_0)
end

return var_0_1
