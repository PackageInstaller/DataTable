ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConst
local BattleCldComponent = class("BattleCldComponent")

ys.Battle.BattleCldComponent = BattleCldComponent
BattleCldComponent.__name = "BattleCldComponent"

function BattleCldComponent:Ctor()
	return
end

function BattleCldComponent:SetActive(arg_2_1)
	self._cldData.Active = arg_2_1

	return
end

function BattleCldComponent:SetImmuneCLD(arg_3_1)
	self._cldData.ImmuneCLD = arg_3_1

	return
end

function BattleCldComponent:SetCldData(arg_4_1)
	self._cldData = arg_4_1
	self._cldData.distList = {}
	self._cldData.Active = false
	self._cldData.ImmuneCLD = false
	self._cldData.FriendlyCld = false
	self._cldData.Surface = var_0_1.OXY_STATE.FLOAT
	self._box.data = arg_4_1

	return
end

function BattleCldComponent:ActiveFriendlyCld()
	self._cldData.FriendlyCld = true

	return
end

function BattleCldComponent:GetCldData()
	return self._cldData
end

function BattleCldComponent:GetCldBox(arg_7_1)
	assert(false, "BattleCldComponent.GetCldBox:重写这个方法啦！")

	return
end

function BattleCldComponent:GetCldBoxSize()
	assert(false, "BattleCldComponent.GetCldBoxSize:重写这个方法啦！")

	return nil
end

function BattleCldComponent:FixSpeed(arg_9_1)
	if not self._cldData.FriendlyCld then
		return
	end

	if #self._cldData.distList == 0 then
		return
	end

	if arg_9_1.x == 0 and arg_9_1.z == 0 then
		self:HandleStaticCld(arg_9_1)
	else
		self:HandleDynamicCld(arg_9_1)
	end

	return
end

function BattleCldComponent:HandleDynamicCld(arg_10_1)
	local var_10_0 = false
	local var_10_1 = false

	for iter_10_0, iter_10_1 in ipairs(self._cldData.distList) do
		if not var_10_0 and iter_10_1.x * math.abs(arg_10_1.x) / arg_10_1.x < 0 then
			arg_10_1.x = 0
			var_10_0 = true
		end

		if not var_10_1 and iter_10_1.z * math.abs(arg_10_1.z) / arg_10_1.z < 0 then
			arg_10_1.z = 0
			var_10_1 = true
		end

		if var_10_0 and var_10_1 then
			return
		end
	end

	return
end

function BattleCldComponent:HandleStaticCld(arg_11_1)
	local var_11_0 = Vector3(self._cldData.distList[1].x, 0, self._cldData.distList[1].z).normalized

	arg_11_1.x = var_0_0.Battle.BattleFormulas.ConvertShipSpeed(var_11_0.x)
	arg_11_1.z = var_0_0.Battle.BattleFormulas.ConvertShipSpeed(var_11_0.z)

	return
end

return
