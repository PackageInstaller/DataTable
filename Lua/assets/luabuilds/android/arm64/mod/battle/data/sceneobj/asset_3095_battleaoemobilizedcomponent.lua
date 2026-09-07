ys = ys or {}

local BattleAOEMobilizedComponent = class("BattleAOEMobilizedComponent")

ys.Battle.BattleAOEMobilizedComponent = BattleAOEMobilizedComponent
BattleAOEMobilizedComponent.__name = "BattleAOEMobilizedComponent"
BattleAOEMobilizedComponent.STAY = 0
BattleAOEMobilizedComponent.FOLLOW = 1
BattleAOEMobilizedComponent.REFERENCE = 2

function BattleAOEMobilizedComponent:Ctor(arg_1_1)
	self._area = arg_1_1

	self._area:AppendComponent(self)

	local var_1_0 = self._area.Settle

	function self._area.Settle()
		self:updatePosition()
		var_1_0(self._area)

		return
	end

	return
end

function BattleAOEMobilizedComponent:Dispose()
	self._area = nil
	self._referenceUnit = nil

	return
end

function BattleAOEMobilizedComponent:SetReferenceUnit(arg_4_1)
	self._referenceUnit = arg_4_1
	self._referencePoint = Clone(arg_4_1:GetPosition())

	return
end

function BattleAOEMobilizedComponent:ConfigData(arg_5_1, arg_5_2)
	if arg_5_1 == BattleAOEMobilizedComponent.STAY then
		self.updatePosition = BattleAOEMobilizedComponent.doStay
	elseif arg_5_1 == BattleAOEMobilizedComponent.FOLLOW then
		self.updatePosition = BattleAOEMobilizedComponent.doFollow
	elseif arg_5_1 == BattleAOEMobilizedComponent.REFERENCE then
		self.updatePosition = BattleAOEMobilizedComponent.doReference
		self._speedVector = Vector3.New(arg_5_2.speedX, 0, 0)
	end

	return
end

function BattleAOEMobilizedComponent.doStay()
	return
end

function BattleAOEMobilizedComponent:doFollow()
	self._area:SetPosition((setmetatable({}, {
		__index = self._referenceUnit:GetPosition()
	})))

	return
end

function BattleAOEMobilizedComponent:doReference()
	self._referencePoint:Add(self._speedVector)
	self._area:SetPosition(self._referencePoint)

	return
end

return
