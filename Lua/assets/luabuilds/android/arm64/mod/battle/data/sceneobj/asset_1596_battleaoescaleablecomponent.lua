ys = ys or {}

local BattleAOEScaleableComponent = class("BattleAOEScaleableComponent")

ys.Battle.BattleAOEScaleableComponent = BattleAOEScaleableComponent
BattleAOEScaleableComponent.__name = "BattleAOEScaleableComponent"
BattleAOEScaleableComponent.FILL = 1
BattleAOEScaleableComponent.EXPEND = 2

function BattleAOEScaleableComponent:Ctor(arg_1_1)
	self._area = arg_1_1

	self._area:AppendComponent(self)

	local var_1_0 = self._area.Settle

	function self._area.Settle()
		self:updateScale()
		var_1_0(self._area)

		return
	end

	return
end

function BattleAOEScaleableComponent:Dispose()
	self._area = nil
	self._referenceUnit = nil

	return
end

function BattleAOEScaleableComponent:SetReferenceUnit(arg_4_1)
	self._referenceUnit = arg_4_1
	self._referencePoint = Clone(arg_4_1:GetPosition())

	return
end

function BattleAOEScaleableComponent:ConfigData(arg_5_1, arg_5_2)
	if arg_5_1 == BattleAOEScaleableComponent.FILL then
		self.updateScale = BattleAOEScaleableComponent.doFill
		self._upperBound = arg_5_2.upperBound
		self._lowerBound = arg_5_2.lowerBound
		self._rearBound = arg_5_2.rearBound
		self._frontOffset = arg_5_2.frontOffset
	elseif arg_5_1 == BattleAOEScaleableComponent.EXPEND then
		self._area:SetFXStatic(false)

		self.updateScale = BattleAOEScaleableComponent.doExpend
		self._expendDuration = arg_5_2.expendDuration
		self._widthExpendSpeed = arg_5_2.widthSpeed
		self._heightExpendSpeed = arg_5_2.heightSpeed
		self._expendStartTime = pg.TimeMgr.GetInstance():GetCombatTime()
		self._lastExpendTime = pg.TimeMgr.GetInstance():GetCombatTime()
	end

	return
end

function BattleAOEScaleableComponent:doFill()
	local var_6_0 = self._area:GetIFF()
	local var_6_1 = math.abs(self._upperBound - self._lowerBound)

	self._area:SetWidth(self._frontOffset * 2)
	self._area:SetHeight(var_6_1)
	self._area:GetCldComponent():ResetSize(self._frontOffset * 2, 5, var_6_1)

	self._referencePoint.x = setmetatable({}, {
		__index = self._referenceUnit:GetPosition()
	}).x
	self._referencePoint.z = var_6_1 * 0.5 + self._lowerBound

	self._area:SetPosition(self._referencePoint)

	return
end

function BattleAOEScaleableComponent:doExpend()
	local var_7_0 = pg.TimeMgr.GetInstance():GetCombatTime()

	if var_7_0 - self._expendStartTime < self._expendDuration then
		local var_7_1 = self._area:GetWidth()
		local var_7_2 = self._area:GetHeight()

		self._area:SetWidth(var_7_1 + self._widthExpendSpeed * (var_7_0 - self._lastExpendTime))
		self._area:SetHeight(var_7_2 + self._heightExpendSpeed * (var_7_0 - self._lastExpendTime))
		self._area:GetCldComponent():ResetSize(var_7_1, 5, var_7_2)
	end

	return
end

return
