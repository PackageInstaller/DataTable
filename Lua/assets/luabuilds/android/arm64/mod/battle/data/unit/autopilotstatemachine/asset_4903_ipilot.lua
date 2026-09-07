ys = ys or {}

local var_0_0 = ys
local IPilot = class("IPilot")

ys.Battle.IPilot = IPilot
IPilot.__name = "IPilot"

function IPilot:Ctor(arg_1_1, arg_1_2)
	self._index = arg_1_1
	self._pilot = arg_1_2

	return
end

function IPilot:SetParameter(arg_2_1, arg_2_2)
	self._paramList = arg_2_1
	self._valve = arg_2_1.valve or var_0_0.Battle.AutoPilot.PILOT_VALVE
	self._toIndex = arg_2_2
	self._duration = arg_2_1.duration or -1

	return
end

function IPilot:GetIndex()
	return self._index
end

function IPilot:GetToIndex()
	return self._toIndex
end

function IPilot:Active(arg_5_1)
	self._startTime = pg.TimeMgr.GetInstance():GetCombatTime()

	return
end

function IPilot:IsExpired()
	if self._duration > 0 then
		if pg.TimeMgr.GetInstance():GetCombatTime() - self._startTime > self._duration then
			do return true end

			goto label_6_0
		end
	end

	do return false end

	::label_6_0::

	return
end

function IPilot:GetDirection(arg_7_1)
	return
end

function IPilot:Finish()
	self._pilot:NextStep()

	return
end

return
