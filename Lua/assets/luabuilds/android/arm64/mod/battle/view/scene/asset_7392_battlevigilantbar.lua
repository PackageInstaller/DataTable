ys = ys or {}
ys.Battle.BattleVigilantBar = class("BattleVigilantBar")
ys.Battle.BattleVigilantBar.__name = "BattleVigilantBar"

local var_0_0 = ys.Battle.BattleVigilantBar

ys.Battle.BattleVigilantBar.MIN = 0.267
ys.Battle.BattleVigilantBar.MAX = 0.7335
ys.Battle.BattleVigilantBar.METER_LENGTH = ys.Battle.BattleVigilantBar.MAX - ys.Battle.BattleVigilantBar.MIN
ys.Battle.BattleVigilantBar.STATE_CALM = 0
ys.Battle.BattleVigilantBar.STATE_SUSPICIOUS = 1
ys.Battle.BattleVigilantBar.STATE_VIGILANT = 2
ys.Battle.BattleVigilantBar.STATE_ENGAGE = 3

function ys.Battle.BattleVigilantBar:Ctor(arg_1_1)
	self._vigilantBar = arg_1_1
	self._vigilantBarGO = self._vigilantBar.gameObject
	self._progress = self._vigilantBar:Find("progress"):GetComponent(typeof(Image))
	self._markList = {}
	self._markList[var_0_0.STATE_CALM] = self._vigilantBar:Find("mark/" .. var_0_0.STATE_CALM)
	self._markList[var_0_0.STATE_SUSPICIOUS] = self._vigilantBar:Find("mark/" .. var_0_0.STATE_SUSPICIOUS)
	self._markList[var_0_0.STATE_VIGILANT] = self._vigilantBar:Find("mark/" .. var_0_0.STATE_VIGILANT)
	self._markList[var_0_0.STATE_ENGAGE] = self._vigilantBar:Find("mark/" .. var_0_0.STATE_ENGAGE)

	return
end

function ys.Battle.BattleVigilantBar.ConfigVigilant(arg_2_0, arg_2_1)
	arg_2_0._vigilantState = arg_2_1

	return
end

function ys.Battle.BattleVigilantBar:UpdateVigilantProgress()
	self._progress.fillAmount = self.meterConvert((self._vigilantState:GetVigilantRate()))

	return
end

function ys.Battle.BattleVigilantBar:UpdateVigilantMark()
	local var_4_0 = self._vigilantState:GetVigilantMark()

	for iter_4_0, iter_4_1 in ipairs(self._markList) do
		SetActive(iter_4_1, var_4_0 == iter_4_0)
	end

	return
end

function ys.Battle.BattleVigilantBar:UpdateVigilantBarPosition(arg_5_1)
	self._vigilantBar.position = arg_5_1

	return
end

function ys.Battle.BattleVigilantBar.meterConvert(arg_6_0)
	return var_0_0.METER_LENGTH * arg_6_0 + var_0_0.MIN
end

function ys.Battle.BattleVigilantBar:Dispose()
	self._vigilantState = nil

	Object.Destroy(self._vigilantBarGO)

	self._vigilantBar = nil
	self._vigilantBarGO = nil
	self._markList = nil
	self._progress = nil

	return
end

return
