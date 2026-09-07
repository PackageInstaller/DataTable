ys = ys or {}

local var_0_0 = ys
local var_0_3 = ys.Battle.BattleDataFunction
local BattleEnvironmentUnit = class("BattleEnvironmentUnit")

ys.Battle.BattleEnvironmentUnit = BattleEnvironmentUnit
BattleEnvironmentUnit.__name = "BattleEnvironmentUnit"

function BattleEnvironmentUnit:Ctor(arg_1_1, arg_1_2)
	var_0_0.EventDispatcher.AttachEventDispatcher(self)

	self._uid = arg_1_1

	return
end

function BattleEnvironmentUnit:ConfigCallback(arg_2_1)
	self._callback = arg_2_1

	return
end

function BattleEnvironmentUnit:GetUniqueID()
	return self._uid
end

function BattleEnvironmentUnit:SetTemplate(arg_4_1)
	self._template = arg_4_1

	self:initBehaviours()

	return
end

function BattleEnvironmentUnit:SetAOEData(arg_5_1)
	self._expireTimeStamp = pg.TimeMgr.GetInstance():GetCombatTime() + self._template.life_time
	self._aoeData = arg_5_1

	return
end

function BattleEnvironmentUnit:GetAOEData()
	return self._aoeData
end

function BattleEnvironmentUnit:GetBehaviours()
	return self._behaviours
end

function BattleEnvironmentUnit:GetTemplate()
	return self._template
end

function BattleEnvironmentUnit:UpdateFrequentlyCollide(arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(self._behaviours) do
		iter_9_1:UpdateCollideUnitList(arg_9_1)
	end

	return
end

function BattleEnvironmentUnit:Update()
	for iter_10_0, iter_10_1 in ipairs(self._behaviours) do
		iter_10_1:OnUpdate()
	end

	return
end

function BattleEnvironmentUnit:IsExpire(arg_11_1)
	return arg_11_1 > self._expireTimeStamp
end

function BattleEnvironmentUnit:Dispose()
	if self._callback then
		self._callback()
	end

	for iter_12_0, iter_12_1 in ipairs(self._behaviours) do
		iter_12_1:Dispose()
	end

	return
end

function BattleEnvironmentUnit:initBehaviours()
	self._behaviours = {}

	for iter_13_0, iter_13_1 in ipairs(var_0_3.GetEnvironmentBehaviour(self._template.behaviours).behaviour_list) do
		local var_13_0 = var_0_0.Battle.BattleEnvironmentBehaviour.CreateBehaviour(iter_13_1)

		var_13_0:SetUnitRef(self)
		var_13_0:SetTemplate(iter_13_1)
		table.insert(self._behaviours, var_13_0)
	end

	return
end

return
