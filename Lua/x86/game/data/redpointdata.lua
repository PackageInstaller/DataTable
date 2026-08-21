local var_0_0 = singletonClass("RedPointData")
local var_0_1
local var_0_2
local var_0_3

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
	var_0_2 = {}
	var_0_3 = {}
end

function var_0_0.InitRedPointS(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		arg_2_0:SetNeedRedPointOpen(iter_2_1, true)
	end
end

function var_0_0.SetNeedRedPointOpen(arg_3_0, arg_3_1, arg_3_2)
	var_0_3[tonumber(arg_3_1)] = arg_3_2
end

function var_0_0.InitClientRedPoint(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		arg_4_0:SetRedPointOpen(iter_4_1, true)
	end
end

function var_0_0.SetRedPointOpen(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == RED_POINT_ID.BATTLE_EQUIP then
		manager.redPoint:setTip(RedPointConst.BATTLE_EQUIP, not arg_5_2 and 0)
	end

	var_0_1[tonumber(arg_5_1)] = arg_5_2
end

function var_0_0.GetRedPointOpen(arg_6_0, arg_6_1)
	return var_0_3[arg_6_1]
end

function var_0_0.GetIsRedPointOpen(arg_7_0, arg_7_1)
	return var_0_1[arg_7_1]
end

function var_0_0.GetJsonCacheRedPoint(arg_8_0, arg_8_1)
	return getData("RedPoint", arg_8_1) or 1
end

function var_0_0.SetJsonCacheRedPoint(arg_9_0, arg_9_1)
	saveData("RedPoint", arg_9_1, 0)
end

var_0_0.HasNotified = 0
var_0_0.NotYetNotified = 1

function var_0_0.GetSessionCacheRedPoint(arg_10_0, arg_10_1)
	return nullable(var_0_2, arg_10_1) or 1
end

function var_0_0.SetSessionCacheRedPoint(arg_11_0, arg_11_1)
	var_0_2[arg_11_1] = 0
end

function var_0_0.UpdateRedPoint(arg_12_0, arg_12_1)
	if arg_12_1 == ActivityConst.CHESS_ACTIVITY_CHINESE_ZONE then
		local var_12_0 = RedPointConst.WARCHESS_CHINESE .. "_" .. ActivityConst.CHESS_ACTIVITY_CHINESE_ZONE

		if ActivityData:GetActivityIsOpen(ActivityConst.CHESS_ACTIVITY_CHINESE_ZONE) then
			manager.redPoint:setTip(var_12_0, arg_12_0:GetJsonCacheRedPoint(var_12_0))
		else
			manager.redPoint:setTip(var_12_0, 0)
		end
	end
end

return var_0_0
