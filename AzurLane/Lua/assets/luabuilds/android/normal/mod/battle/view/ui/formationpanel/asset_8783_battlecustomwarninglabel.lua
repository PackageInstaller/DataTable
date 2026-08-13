ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleDataFunction

class = var_0_10002

local var_0_2 = var_0_10002("BattleCustomWarningLabel")

var_0.Battle.BattleCustomWarningLabel = var_0_2
var_0_2.__name = "BattleCustomWarningLabel"

function var_0_2.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0._expire = false

	return
end

function var_0_2.ConfigData(arg_2_0, arg_2_1)
	setText = var_1_10002

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_3.Find(var_2_0, "text")

	i18n = var_2_0

	var_1_10002(var_2_1, var_2_0(arg_2_1.dialogue))

	arg_2_0._duration = arg_2_1.duration

	local var_2_2 = (arg_2_1.x + 1) * 0.5
	local var_2_3 = (arg_2_1.y + 1) * 0.5
	local var_2_4 = arg_2_0._tf

	Vector2 = var_5
	var_2_4.anchorMin = var_5(var_2_2, var_2_3)

	local var_2_5 = arg_2_0._tf

	Vector2 = var_5
	var_2_5.anchorMax = var_5(var_2_2, var_2_3)
	pg = var_2_5

	local var_2_6 = var_2_5.TimeMgr.GetInstance()

	arg_2_0._startTimeStamp = var_4.GetCombatTime(var_2_6)

	return
end

function var_0_2.GetDuration(arg_3_0)
	return arg_3_0._duration
end

function var_0_2.SetExpire(arg_4_0)
	arg_4_0._expire = true

	return
end

function var_0_2.IsExpire(arg_5_0)
	return arg_5_0._expire
end

function var_0_2.Update(arg_6_0)
	if arg_6_0._duration > 0 then
		pg = var_1

		local var_6_0 = var_1.TimeMgr.GetInstance()

		if var_1.GetCombatTime(var_6_0) - arg_6_0._startTimeStamp > arg_6_0._duration then
			arg_6_0:SetExpire()
		end
	end

	return
end

function var_0_2.Dispose(arg_7_0)
	Destroy = var_1_10001

	var_1_10001(arg_7_0._go)

	arg_7_0._go = nil
	arg_7_0._tf = nil

	return
end

return
