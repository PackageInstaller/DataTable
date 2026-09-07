ys = ys or {}

local BattleBuffAntiSubVigilance = class("BattleBuffAntiSubVigilance", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffAntiSubVigilance = BattleBuffAntiSubVigilance
BattleBuffAntiSubVigilance.__name = "BattleBuffAntiSubVigilance"

function BattleBuffAntiSubVigilance:Ctor(arg_1_1)
	BattleBuffAntiSubVigilance.super.Ctor(self, arg_1_1)

	return
end

function BattleBuffAntiSubVigilance:SetArgs(arg_2_1, arg_2_2)
	self._vigilantRange = self._tempData.arg_list.vigilanceRange
	self._sonarRange = self._tempData.arg_list.sonarRange
	self._sonarFrequency = self._tempData.arg_list.sonarFrequency

	return
end

function BattleBuffAntiSubVigilance:onAttach(arg_3_1)
	self._vigilantUnit = arg_3_1
	self._vigilantState = arg_3_1:InitAntiSubState(self._sonarRange, self._sonarFrequency)

	self._vigilantState:InitCheck(#self:getTargetList(self._vigilantUnit, "TargetHarmNearest", {
		range = 200
	}))

	self._sonarCheckTimeStamp = pg.TimeMgr.GetInstance():GetCombatTime()

	return
end

function BattleBuffAntiSubVigilance:onUpdate()
	local var_4_0

	if #self:getTargetList(self._vigilantUnit, "TargetHarmNearest", {
		range = self._vigilantRange
	}) > 0 then
		self._vigilantState:VigilantAreaEngage()

		var_4_0 = #self:getTargetList(self._vigilantUnit, {
			"TargetAllFoe",
			"TargetHarmNearest",
			"TargetDiveState"
		}, {
			range = self._sonarRange
		})
	end

	self._vigilantState:Update(#self:getTargetList(self._vigilantUnit, "TargetHarmNearest", {
		range = 200
	}), var_4_0)

	local var_4_1 = pg.TimeMgr.GetInstance():GetCombatTime()

	if var_4_1 - self._sonarCheckTimeStamp >= self._sonarFrequency then
		self._vigilantState:SonarDetect(var_4_0)

		self._sonarCheckTimeStamp = var_4_1
	end

	return
end

function BattleBuffAntiSubVigilance:onAntiSubHateChain()
	self._vigilantState:HateChain()

	return
end

function BattleBuffAntiSubVigilance:onTeammateShipDying(arg_6_1, arg_6_2, arg_6_3)
	self._vigilantState:MineExplode()

	return
end

function BattleBuffAntiSubVigilance:onSubmarinFreeDive(arg_7_1, arg_7_2, arg_7_3)
	return
end

function BattleBuffAntiSubVigilance:onSubmarinFreeFloat(arg_8_1, arg_8_2, arg_8_3)
	self._vigilantState:SubmarineFloat()

	return
end

return
