ys = ys or {}

local var_0_0 = ys
local var_0_3 = ys.Battle.BattleConst.AircraftUnitType
local var_0_4 = ys.Battle.BattleConst.CharacterUnitType

ys.Battle.BattleShrapnelBulletFactory = singletonClass("BattleShrapnelBulletFactory", ys.Battle.BattleBulletFactory)
ys.Battle.BattleShrapnelBulletFactory.__name = "BattleShrapnelBulletFactory"

local var_0_5 = ys.Battle.BattleShrapnelBulletFactory

ys.Battle.BattleShrapnelBulletFactory.INHERIT_NONE = 0
ys.Battle.BattleShrapnelBulletFactory.INHERIT_ANGLE = 1
ys.Battle.BattleShrapnelBulletFactory.INHERIT_SPEED_NORMALIZE = 2
ys.Battle.BattleShrapnelBulletFactory.INHERIT_VELOCITY_TEMPLATE = 1
ys.Battle.BattleShrapnelBulletFactory.INHERIT_VELOCITY_CURRENT = 2
ys.Battle.BattleShrapnelBulletFactory.FRAGILE_DAMAGE_NOT_SPLIT = 1
ys.Battle.BattleShrapnelBulletFactory.FRAGILE_NOT_DAMAGE_NOT_SPLIT = 2

function ys.Battle.BattleShrapnelBulletFactory.Ctor(arg_1_0)
	var_0_5.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleShrapnelBulletFactory.MakeBullet(arg_2_0)
	return var_0_0.Battle.BattleShrapnelBullet.New()
end

function ys.Battle.BattleShrapnelBulletFactory:CreateBullet(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	arg_3_2:SetOutRangeCallback(self.OutRangeFunc)

	local var_3_0 = self:MakeBullet()

	var_3_0:SetFactory(self)
	var_3_0:SetBulletData(arg_3_2)
	self:MakeModel(var_3_0, arg_3_3, arg_3_4, arg_3_5)

	if arg_3_4 and arg_3_4 ~= "" then
		self:PlayFireFX(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, nil)
	end

	if not arg_3_2:GetTemplate().extra_param.rangeAA then
		var_0_5.bulletSplit(var_3_0)
	end

	return var_3_0
end

function ys.Battle.BattleShrapnelBulletFactory:onBulletHitFunc(arg_4_1, arg_4_2)
	local var_4_0 = var_0_5.GetDataProxy()
	local var_4_1 = self:GetBulletData()
	local var_4_2 = var_4_1:GetCurrentState()
	local var_4_3 = var_4_1:GetTemplate()

	if not arg_4_1 and var_4_3.extra_param.hitSplitOnly then
		var_4_0:RemoveBulletUnit(var_4_1:GetUniqueID())

		return
	end

	if var_4_3.extra_param.fragile and arg_4_1 then
		if var_4_3.extra_param.fragile == var_0_5.FRAGILE_DAMAGE_NOT_SPLIT then
			var_0_0.Battle.BattleCannonBulletFactory.onBulletHitFunc(self, arg_4_1, arg_4_2)
		elseif var_4_3.extra_param.fragile == var_0_5.FRAGILE_NOT_DAMAGE_NOT_SPLIT then
			var_4_0:RemoveBulletUnit(var_4_1:GetUniqueID())
		end

		return
	end

	if var_4_2 == var_4_1.STATE_SPLIT or var_4_2 == var_4_1.STATE_SPIN then
		-- block empty
	elseif var_4_2 == var_4_1.STATE_FINAL_SPLIT then
		return
	elseif var_4_1:GetPierceCount() > 0 then
		var_0_0.Battle.BattleCannonBulletFactory.onBulletHitFunc(self, arg_4_1, arg_4_2)

		return
	end

	if arg_4_1 ~= nil and arg_4_2 ~= nil then
		local var_4_5

		if table.contains(var_0_3, arg_4_2) then
			var_4_5 = var_0_5.GetSceneMediator():GetAircraft(arg_4_1)
		elseif table.contains(var_0_4, arg_4_2) then
			var_4_5 = var_0_5.GetSceneMediator():GetCharacter(arg_4_1)
		end

		if var_4_5:GetUnitData():GetIFF() == var_4_0:GetFoeCode() then
			var_4_5:AddFX(self:GetFXID()).transform.localRotation = Vector3(var_4_5:AddFX(self:GetFXID()).transform.localRotation.x, 180, var_4_5:AddFX(self:GetFXID()).transform.localRotation.z)
		end
	end

	var_0_0.Battle.PlayBattleSFX(var_4_1:GetHitSFX())

	if var_4_3.extra_param.rangeAA then
		var_0_5.areaSplit(self)
	else
		var_0_5.bulletSplit(self, true)
	end

	return
end

function ys.Battle.BattleShrapnelBulletFactory:areaSplit()
	local var_5_0 = self:GetBulletData()

	var_5_0:GetWeapon():DoAreaSplit(var_5_0)
	var_0_5.GetDataProxy():RemoveBulletUnit(var_5_0:GetUniqueID())

	return
end

function ys.Battle.BattleShrapnelBulletFactory:bulletSplit(arg_6_1)
	local var_6_0 = self:GetBulletData()
	local var_6_1 = var_0_5.GetDataProxy()
	local var_6_2 = var_6_0:GetTemplate()
	local var_6_3 = var_6_2.extra_param.shrapnel
	local var_6_4 = var_6_0:GetSrcHost()
	local var_6_5 = var_6_0:GetWeapon()

	if var_6_2.extra_param.FXID ~= nil then
		local var_6_6, var_6_7 = var_0_5.GetFXPool():GetFX(var_6_2.extra_param.FXID)

		pg.EffectMgr.GetInstance():PlayBattleEffect(var_6_6, var_6_7:Add(self:GetPosition()), true)
	end

	local var_6_8 = var_6_0:GetSpeed().x > 0 and 0 or 180

	for iter_6_0, iter_6_1 in ipairs(var_6_3) do
		if arg_6_1 ~= iter_6_1.initialSplit then
			local var_6_10 = iter_6_1.bullet_ID
			local var_6_11 = iter_6_1.inheritAngle
			local var_6_12 = iter_6_1.inheritSpeed
			local var_6_13 = iter_6_1.reaim
			local var_6_14 = iter_6_1.rotateOffset
			local var_6_15

			var_6_15 = var_0_0.Battle[iter_6_1.emitterType or var_0_0.Battle.BattleWeaponUnit.EMITTER_SHOTGUN].New(function(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
				local var_7_0 = var_6_1:CreateBulletUnit(var_6_10, var_6_4, var_6_5, Vector3.zero)

				var_7_0:OverrideCorrectedDMG(iter_6_1.damage)
				var_7_0:SetOffsetPriority(arg_7_3)

				if var_6_14 then
					local var_7_1 = math.sqrt(arg_7_0 * arg_7_0 + arg_7_1 * arg_7_1)
					local var_7_2 = math.rad(var_6_0:GetYAngle())
					local var_7_3 = math.atan2(arg_7_1, arg_7_0) + var_7_2
					local var_7_4 = math.abs(math.cos(var_7_2))

					arg_7_0 = var_7_1 * math.cos(var_7_3) * (0.5 + 0.5 * var_7_4)
					arg_7_1 = var_7_1 * math.sin(var_7_3) * (2 - var_7_4)
				end

				var_7_0:SetShiftInfo(arg_7_0, arg_7_1)

				local var_7_5 = var_6_8

				if var_6_11 == var_0_5.INHERIT_ANGLE then
					var_7_5 = var_6_0:GetYAngle()
				elseif var_6_11 == var_0_5.INHERIT_SPEED_NORMALIZE then
					var_7_5 = var_6_0:GetCurrentYAngle()
				end

				if var_6_13 then
					local var_7_6
					local var_7_7 = var_6_0:GetWeapon():GetHost()

					if type(var_6_13) == "table" and var_7_7 then
						local var_7_8

						for iter_7_0, iter_7_1 in ipairs(var_6_13) do
							var_7_8 = var_0_0.Battle.BattleTargetChoise[iter_7_1](var_7_7, iter_6_1.reaimParam, var_7_8)
						end

						var_7_6 = var_7_8[1]
					else
						var_7_6 = var_0_0.Battle.BattleTargetChoise.TargetHarmNearest(var_6_0)[1]
					end

					if var_7_6 == nil then
						var_7_0:SetRotateInfo(nil, var_7_5, arg_7_2)
					else
						var_7_0:SetRotateInfo(var_7_6:GetBeenAimedPosition(), var_7_5, arg_7_2)
					end
				else
					var_7_0:SetRotateInfo(nil, var_7_5, arg_7_2)
				end

				if var_6_12 == var_0_5.INHERIT_VELOCITY_TEMPLATE then
					var_7_0:ResetVelocity(var_6_0:GetVelocity())
				elseif var_6_12 == var_0_5.INHERIT_VELOCITY_CURRENT then
					var_7_0:InheritSpeed(var_6_0:GetSpeed())
				end

				var_0_5.GetFactoryList()[var_7_0:GetTemplate().type]:CreateBullet(self:GetTf(), var_7_0, self:GetPosition())

				return
			end, function()
				var_6_15:Destroy()
				var_6_0:SplitFinishCount()

				if var_6_0:IsAllSplitFinish() then
					var_6_1:RemoveBulletUnit(var_6_0:GetUniqueID())
				end

				return
			end, iter_6_1.barrage_ID)

			var_6_0:CacheChildEimtter(nil)
			var_6_15:Ready()
			var_6_15:Fire(nil, var_6_5:GetDirection(), var_0_0.Battle.BattleDataFunction.GetBarrageTmpDataFromID(iter_6_1.barrage_ID).angle)
		end
	end

	if arg_6_1 then
		var_6_0:ChangeShrapnelState(var_0_0.Battle.BattleShrapnelBulletUnit.STATE_FINAL_SPLIT)
	end

	return
end

function ys.Battle.BattleShrapnelBulletFactory.onBulletMissFunc(arg_9_0)
	return
end

function ys.Battle.BattleShrapnelBulletFactory:MakeModel(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	local var_10_0 = arg_10_1:GetBulletData()

	if not self:GetBulletPool():InstBullet(arg_10_1:GetModleID(), function(arg_11_0)
		arg_10_1:AddModel(arg_11_0)

		return
	end) then
		arg_10_1:AddTempModel(self:GetTempGOPool():GetObject())
	end

	arg_10_1:SetSpawn(arg_10_2)
	arg_10_1:SetFXFunc(self.onBulletHitFunc, self.onBulletMissFunc)
	self:GetSceneMediator():AddBullet(arg_10_1)

	return
end

function ys.Battle.BattleShrapnelBulletFactory:OutRangeFunc()
	if self:IsOutRange() then
		self:ChangeShrapnelState(var_0_0.Battle.BattleShrapnelBulletUnit.STATE_SPIN)
	else
		self:ChangeShrapnelState(var_0_0.Battle.BattleShrapnelBulletUnit.STATE_SPLIT)
	end

	return
end

return
