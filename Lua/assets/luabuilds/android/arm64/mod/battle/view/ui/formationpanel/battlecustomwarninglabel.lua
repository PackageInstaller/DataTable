ys = ys or {}

local var_0_1 = class("BattleCustomWarningLabel")

ys.Battle.BattleCustomWarningLabel = var_0_1
var_0_1.__name = "BattleCustomWarningLabel"

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0._expire = false

	return
end

function var_0_1.ConfigData(arg_2_0, arg_2_1)
	setText(arg_2_0._tf:Find("text"), i18n(arg_2_1.dialogue))

	arg_2_0._duration = arg_2_1.duration
	arg_2_0._tf.anchorMin = Vector2((arg_2_1.x + 1) * 0.5, (arg_2_1.y + 1) * 0.5)
	arg_2_0._tf.anchorMax = Vector2((arg_2_1.x + 1) * 0.5, (arg_2_1.y + 1) * 0.5)
	arg_2_0._startTimeStamp = pg.TimeMgr.GetInstance():GetCombatTime()

	return
end

function var_0_1.GetDuration(arg_3_0)
	return arg_3_0._duration
end

function var_0_1.SetExpire(arg_4_0)
	arg_4_0._expire = true

	return
end

function var_0_1.IsExpire(arg_5_0)
	return arg_5_0._expire
end

function var_0_1.Update(arg_6_0)
	if arg_6_0._duration > 0 then
		if pg.TimeMgr.GetInstance():GetCombatTime() - arg_6_0._startTimeStamp > arg_6_0._duration then
			arg_6_0:SetExpire()
		end
	end

	return
end

function var_0_1.Dispose(arg_7_0)
	Destroy(arg_7_0._go)

	arg_7_0._go = nil
	arg_7_0._tf = nil

	return
end

return
