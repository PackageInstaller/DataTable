local var_0_2 = ys.Battle.BattleConst
local var_0_3 = ys.Battle.BattleConfig

function ys.Battle.BattleDataProxy.__debug__BlockCldUpdate__(arg_1_0, arg_1_1)
	arg_1_0:UpdateCountDown(arg_1_1)

	for iter_1_0, iter_1_1 in pairs(arg_1_0._fleetList) do
		iter_1_1:UpdateMotion()
	end

	for iter_1_2, iter_1_3 in pairs(arg_1_0._unitList) do
		iter_1_3:Update(arg_1_1)
	end

	for iter_1_4, iter_1_5 in pairs(arg_1_0._bulletList) do
		local var_1_0 = iter_1_5:GetSpeed()
		local var_1_1 = iter_1_5:GetPosition()

		if var_1_1.x > arg_1_0._bulletRightBound and var_1_0.x > 0 or var_1_1.z < arg_1_0._bulletLowerBound and var_1_0.z < 0 then
			arg_1_0:RemoveBulletUnit(iter_1_5:GetUniqueID())
		elseif var_1_1.x < arg_1_0._bulletLeftBound and var_1_0.x < 0 and iter_1_5:GetType() ~= var_0_2.BulletType.BOMB then
			arg_1_0:RemoveBulletUnit(iter_1_5:GetUniqueID())
		else
			iter_1_5:Update(arg_1_1)

			if var_1_1.z > arg_1_0._bulletUpperBound and var_1_0.z > 0 or iter_1_5:IsOutRange(arg_1_1) then
				iter_1_5:OutRange()
			end
		end
	end

	for iter_1_6, iter_1_7 in pairs(arg_1_0._aircraftList) do
		iter_1_7:Update(arg_1_1)

		local var_1_2, var_1_3 = iter_1_7:GetIFF()

		if var_1_2 == var_0_3.FRIENDLY_CODE then
			var_1_3 = arg_1_0._totalRightBound
		elseif var_1_2 == var_0_3.FOE_CODE then
			var_1_3 = arg_1_0._totalLeftBound
		end

		if iter_1_7:GetPosition().x * var_1_2 > math.abs(var_1_3) and iter_1_7:GetSpeed().x * var_1_2 > 0 then
			iter_1_7:OutBound()
		end

		if not iter_1_7:IsAlive() then
			arg_1_0:KillAircraft(iter_1_7:GetUniqueID())
		end
	end

	for iter_1_8, iter_1_9 in pairs(arg_1_0._AOEList) do
		iter_1_9:Settle()

		if iter_1_9:GetActiveFlag() == false then
			arg_1_0:RemoveAreaOfEffect(iter_1_9:GetUniqueID())
		end
	end

	for iter_1_10, iter_1_11 in pairs(arg_1_0._foeShipList) do
		if iter_1_11:GetPosition().x + iter_1_11:GetBoxSize().x < arg_1_0._leftZoneLeftBound then
			iter_1_11:DeadAction()
			arg_1_0:KillUnit(iter_1_11:GetUniqueID())
			arg_1_0:HandleShipMissDamage(iter_1_11, arg_1_0._fleetList[var_0_3.FRIENDLY_CODE])
		end
	end

	return
end

return
