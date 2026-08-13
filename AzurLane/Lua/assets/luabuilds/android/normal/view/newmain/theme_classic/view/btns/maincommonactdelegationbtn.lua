class = var_0_10000

local var_0_0 = "MainCommonActDelegationBtn"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MainBaseSpcailActBtn"))

function var_0_1.GetEventName(arg_1_0)
	return "event_old_act"
end

function var_0_1.GetContainer(arg_2_0)
	local var_2_0 = arg_2_0.root.parent

	return var_1.Find(var_2_0, "eventPanel")
end

function var_0_1.GetLinkConfig(arg_3_0)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.GetEventName(var_3_0)

	pg = var_3_0

	local var_3_2

	if not var_3_0.activity_link_button.get_id_list_by_name[var_3_1] then
		var_3_2 = {}
	end

	_ = var_1_10004

	if #var_1_10004.select(var_3_2, function(arg_4_0)
		local var_4_0 = var_0[arg_4_0].time

		type = var_2_10002

		if var_2_10002(var_4_0) == "table" and var_4_0[1] and var_4_0[1] == "default" then
			local var_4_1 = arg_3_0

			return var_2.InActTime(var_4_1, var_4_0[2])
		else
			pg = var_2

			local var_4_2 = var_2.TimeMgr.GetInstance()

			return var_2.inTime(var_4_2, var_4_0)
		end

		return
	end) > 0 then
		table = var_5

		local var_3_3 = var_5.sort
		local var_3_4 = var_4

		CompareFuncs = var_1_10007

		var_3_3(var_3_4, var_1_10007({
			function(arg_5_0)
				return var_0[arg_5_0].order
			end
		}))

		return var_2[var_4[1]]
	end

	return
end

function var_0_1.InActTime(arg_6_0, arg_6_1)
	local var_6_0

	if not arg_6_1 then
		::label_6_0::

		var_1_10003 = arg_6_0
		var_6_0 = arg_6_0.GetActivityID(var_1_10003)
	end

	if var_6_0 then
		getProxy = var_1_10003
		ActivityProxy = var_1_10004

		local var_6_1 = var_1_10003(var_1_10004)
		local var_6_2

		var_6_2 = var_3.getActivityById(var_6_1, var_6_0) and not var_3:isEnd()

		return var_6_2
	end

	return false
end

function var_0_1.InShowTime(arg_7_0)
	if arg_7_0:GetLinkConfig() ~= nil then
		arg_7_0.config = var_1

		return true
	else
		return false
	end

	return
end

function var_0_1.GetUIName(arg_8_0)
	return "MainCommonActDelegationBtn"
end

function var_0_1.OnClick(arg_9_0)
	MainBaseActivityBtn = var_1_10001

	var_1_10001.Skip(arg_9_0, arg_9_0.config)

	return
end

function var_0_1.OnInit(arg_10_0)
	local var_10_0 = arg_10_0._tf

	arg_10_0.tipTr = var_1.Find(var_10_0, "tip")
	setActive = var_1

	var_1(arg_10_0.tipTr, arg_10_0:IsShowTip())

	return
end

function var_0_1.GetActivity(arg_11_0)
	if arg_11_0.config and arg_11_0.config.time and arg_11_0.config.time[1] == "default" then
		local var_11_0 = arg_11_0.config.time[2]

		getProxy = var_1_10002
		ActivityProxy = var_1_10003

		local var_11_1 = var_1_10002(var_1_10003)

		if var_2.getActivityById(var_11_1, var_11_0) and not var_2:isEnd() then
			return var_2
		end
	end

	return nil
end

function var_0_1.IsShowTip(arg_12_0)
	local var_12_0 = arg_12_0:GetActivity()
	local var_12_1

	var_12_1, switch = var_1.getConfig(var_12_0, "type"), var_12_0

	local var_12_2 = {}

	ActivityConst = var_1_10006
	var_12_2[var_1_10006.ACTIVITY_TYPE_TOWN2] = function()
		LiquorFloorMapScene = var_2_10000

		return var_2_10000.ShouldShowTaskTip()
	end

	return var_12_0(var_12_1, var_12_2, function()
		local var_14_0 = var_0

		return var_0.readyToAchieve(var_14_0)
	end)
end

function var_0_1.emit(arg_15_0, ...)
	local var_15_0 = arg_15_0.event

	var_1.emit(var_15_0, ...)

	return
end

function var_0_1.OnRegister(arg_16_0)
	return
end

function var_0_1.OnClear(arg_17_0)
	return
end

return var_0_1
