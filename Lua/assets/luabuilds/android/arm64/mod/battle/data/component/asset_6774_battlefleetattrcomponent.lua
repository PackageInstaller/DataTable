ys = ys or {}
ys.Battle.BattleFleetAttrComponent = class("BattleFleetAttrComponent")
ys.Battle.BattleFleetAttrComponent.__name = "BattleFleetAttrComponent"

local var_0_0 = ys.Battle.BattleConst
local var_0_1 = ys.Battle.BattleConfig
local var_0_2 = ys.Battle.BattleEvent

function ys.Battle.BattleFleetAttrComponent:Ctor(arg_1_1)
	self._client = arg_1_1

	self:initFleetAttr()

	return
end

function ys.Battle.BattleFleetAttrComponent.Dispose(arg_2_0)
	arg_2_0._client = nil

	return
end

function ys.Battle.BattleFleetAttrComponent.initFleetAttr(arg_3_0)
	arg_3_0._fleetAttrList = {}

	return
end

function ys.Battle.BattleFleetAttrComponent:GetCurrent(arg_4_1)
	return self._fleetAttrList[arg_4_1] or 0
end

function ys.Battle.BattleFleetAttrComponent:SetCurrent(arg_5_1, arg_5_2)
	local var_5_0 = self:GetCurrent(arg_5_1)

	arg_5_2 = var_0_1.FLEET_ATTR_CAP[arg_5_1] and Mathf.Clamp(arg_5_2, 0, var_0_1.FLEET_ATTR_CAP[arg_5_1]) or math.max(arg_5_2, 0)
	self._fleetAttrList[arg_5_1] = arg_5_2

	if var_5_0 ~= arg_5_2 then
		self._client:FleetBuffTrigger(var_0_0.BuffEffectType.ON_FLEET_ATTR_UPDATE, {
			attr = arg_5_1,
			value = arg_5_2,
			delta = arg_5_2 - var_5_0
		})
		self._client:DispatchEvent(ys.Event.New(var_0_2.UPDATE_FLEET_ATTR, {
			attr = arg_5_1,
			value = arg_5_2
		}))
	end

	return
end

return
