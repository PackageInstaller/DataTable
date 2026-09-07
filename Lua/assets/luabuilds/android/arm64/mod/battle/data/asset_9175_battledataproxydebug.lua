local var_0_2 = ys.Battle.BattleConst
local var_0_3 = ys.Battle.BattleConfig

function ys.Battle.BattleDataProxy:__debug__BlockCldUpdate__(arg_1_1)
	self:UpdateCountDown(arg_1_1)

	for iter_1_0, iter_1_1 in pairs(self._fleetList) do
		iter_1_1:UpdateMotion()
	end

	for iter_1_2, iter_1_3 in pairs(self._unitList) do
		iter_1_3:Update(arg_1_1)
	end

	for iter_1_4, iter_1_5 in pairs(self._bulletList) do
		local var_1_0 = iter_1_5:GetSpeed()
		local var_1_1 = iter_1_5:GetPosition()

		if var_1_1.x > self._bulletRightBound and var_1_0.x > 0 or var_1_1.z < self._bulletLowerBound and var_1_0.z < 0 then
			self:RemoveBulletUnit(iter_1_5:GetUniqueID())
		elseif var_1_1.x < self._bulletLeftBound and var_1_0.x < 0 and iter_1_5:GetType() ~= var_0_2.BulletType.BOMB then
			self:RemoveBulletUnit(iter_1_5:GetUniqueID())
		else
			iter_1_5:Update(arg_1_1)

			if var_1_1.z > self._bulletUpperBound and var_1_0.z > 0 or iter_1_5:IsOutRange(arg_1_1) then
				iter_1_5:OutRange()
			end
		end
	end

	for iter_1_6, iter_1_7 in pairs(self._aircraftList) do
		iter_1_7:Update(arg_1_1)

		local var_1_2, var_1_3 = iter_1_7:GetIFF()

		if var_1_2 == var_0_3.FRIENDLY_CODE then
			var_1_3 = self._totalRightBound
		elseif var_1_2 == var_0_3.FOE_CODE then
			var_1_3 = self._totalLeftBound
		end

		if iter_1_7:GetPosition().x * var_1_2 > math.abs(var_1_3) and iter_1_7:GetSpeed().x * var_1_2 > 0 then
			iter_1_7:OutBound()
		end

		if not iter_1_7:IsAlive() then
			self:KillAircraft(iter_1_7:GetUniqueID())
		end
	end

	for iter_1_8, iter_1_9 in pairs(self._AOEList) do
		iter_1_9:Settle()

		if iter_1_9:GetActiveFlag() == false then
			self:RemoveAreaOfEffect(iter_1_9:GetUniqueID())
		end
	end

	for iter_1_10, iter_1_11 in pairs(self._foeShipList) do
		if iter_1_11:GetPosition().x + iter_1_11:GetBoxSize().x < self._leftZoneLeftBound then
			iter_1_11:DeadAction()
			self:KillUnit(iter_1_11:GetUniqueID())
			self:HandleShipMissDamage(iter_1_11, self._fleetList[var_0_3.FRIENDLY_CODE])
		end
	end

	return
end

return
