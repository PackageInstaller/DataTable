ys = var_0_10000

local var_0_0 = var_0_10000.Battle.BattleDataProxy

ys = var_0_10001

local var_0_1 = var_0_10001.Battle.BattleEvent

ys = var_0_10002

local var_0_2 = var_0_10002.Battle.BattleFormulas

ys = var_0_10003

local var_0_3 = var_0_10003.Battle.BattleConst

ys = var_0_10004

local var_0_4 = var_0_10004.Battle.BattleConfig

ys = var_0_10005

local var_0_5 = var_0_10005.Battle.BattleDataFunction

ys = var_0_10006

local var_0_6 = var_0_10006.Battle.BattleAttr

ys = var_0_10007

local var_0_7 = var_0_10007.Battle.BattleVariable

function var_0_0.__debug__BlockCldUpdate__(arg_1_0, arg_1_1)
	arg_1_0:UpdateCountDown(arg_1_1)

	pairs = var_2

	for iter_1_0, iter_1_1 in var_2(arg_1_0._fleetList) do
		iter_1_1:UpdateMotion()
	end

	pairs = var_2

	for iter_1_2, iter_1_3 in var_2(arg_1_0._unitList) do
		iter_1_3:Update(arg_1_1)
	end

	pairs = var_2

	for iter_1_4, iter_1_5 in var_2(arg_1_0._bulletList) do
		local var_1_0 = iter_1_5:GetSpeed()

		if iter_1_5:GetPosition().x > arg_1_0._bulletRightBound and var_1_0.x > 0 or var_8.z < arg_1_0._bulletLowerBound and var_1_0.z < 0 then
			arg_1_0:RemoveBulletUnit(iter_1_5:GetUniqueID())
		elseif var_8.x < arg_1_0._bulletLeftBound and var_1_0.x < 0 and iter_1_5:GetType() ~= var_0_3.BulletType.BOMB then
			arg_1_0:RemoveBulletUnit(iter_1_5:GetUniqueID())
		else
			iter_1_5:Update(arg_1_1)

			if var_8.z > arg_1_0._bulletUpperBound and var_1_0.z > 0 or iter_1_5:IsOutRange(arg_1_1) then
				iter_1_5:OutRange()
			end
		end
	end

	pairs = var_2

	for iter_1_6, iter_1_7 in var_2(arg_1_0._aircraftList) do
		iter_1_7:Update(arg_1_1)

		local var_1_1, var_1_2 = iter_1_7:GetIFF()

		if var_1_1 == var_0_4.FRIENDLY_CODE then
			var_1_2 = arg_1_0._totalRightBound
		elseif var_1_1 == var_0_4.FOE_CODE then
			var_1_2 = arg_1_0._totalLeftBound
		end

		local var_1_3 = iter_1_7:GetPosition().x * var_1_1

		math = var_10

		if var_1_3 > var_10.abs(var_1_2) and iter_1_7:GetSpeed().x * var_1_1 > 0 then
			iter_1_7:OutBound()
		end

		if not iter_1_7:IsAlive() then
			arg_1_0:KillAircraft(iter_1_7:GetUniqueID())
		end
	end

	pairs = var_2

	for iter_1_8, iter_1_9 in var_2(arg_1_0._AOEList) do
		iter_1_9:Settle()

		if iter_1_9:GetActiveFlag() == false then
			arg_1_0:RemoveAreaOfEffect(iter_1_9:GetUniqueID())
		end
	end

	pairs = var_2

	for iter_1_10, iter_1_11 in var_2(arg_1_0._foeShipList) do
		if iter_1_11:GetPosition().x + iter_1_11:GetBoxSize().x < arg_1_0._leftZoneLeftBound then
			iter_1_11:DeadAction()
			arg_1_0:KillUnit(iter_1_11:GetUniqueID())
			arg_1_0:HandleShipMissDamage(iter_1_11, arg_1_0._fleetList[var_0_4.FRIENDLY_CODE])
		end
	end

	return
end

return
