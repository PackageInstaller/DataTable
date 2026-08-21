ys = ys or {}

local var_0_1 = Vector3.zero
local var_0_2 = ys.Battle.BattleConst.OXY_STATE
local var_0_4 = ys.Battle.BattleAttr
local var_0_5 = class("BattleCldSystem")

ys.Battle.BattleCldSystem = var_0_5
var_0_5.__name = "BattleCldSystem"

function var_0_5.Ctor(arg_1_0, arg_1_1)
	arg_1_0._proxy = arg_1_1

	arg_1_0:InitCldTree()

	arg_1_0._friendlyCode = arg_1_1:GetFriendlyCode()
	arg_1_0._foeCode = arg_1_1:GetFoeCode()

	return
end

function var_0_5.Dispose(arg_2_0)
	arg_2_0._proxy = nil
	arg_2_0._shipTree = nil
	arg_2_0._foeShipTree = nil
	arg_2_0._aircraftTree = nil
	arg_2_0._surfaceBulletTree = nil
	arg_2_0._airBulletTree = nil
	arg_2_0._bulletTreeList = nil
	arg_2_0._foeSurafceBulletTree = nil
	arg_2_0._foeAirbulletTree = nil
	arg_2_0._foeBulleetTreeList = nil
	arg_2_0._surfaceAOETree = nil
	arg_2_0._airAOETree = nil
	arg_2_0._AOETreeList = nil
	arg_2_0._wallTree = nil

	return
end

function var_0_5.InitCldTree(arg_3_0)
	local var_3_0, var_3_1, var_3_2, var_3_3 = arg_3_0._proxy:GetTotalBounds()
	local var_3_4 = Vector3(var_3_2, 0, var_3_1)
	local var_3_5 = Vector3(var_3_3, 0, var_3_0)

	arg_3_0._shipTree = pg.ColliderTree.New("shipTree", var_3_4, var_3_5, 2)
	arg_3_0._foeShipTree = pg.ColliderTree.New("foeShipTree", var_3_4, var_3_5, 2)
	arg_3_0._aircraftTree = pg.ColliderTree.New("aircraftTree", var_3_4, var_3_5, 2)
	arg_3_0._surfaceBulletTree = pg.ColliderTree.New("surfaceBullets", var_3_4, var_3_5, 4)
	arg_3_0._airBulletTree = pg.ColliderTree.New("airBullets", var_3_4, var_3_5, 3)
	arg_3_0._bulletTreeList = {}
	arg_3_0._bulletTreeList[var_0.BulletField.SURFACE] = arg_3_0._surfaceBulletTree
	arg_3_0._bulletTreeList[var_0.BulletField.AIR] = arg_3_0._airBulletTree
	arg_3_0._foeSurafceBulletTree = pg.ColliderTree.New("foeSurfaceBullets", var_3_4, var_3_5, 3)
	arg_3_0._foeAirbulletTree = pg.ColliderTree.New("foeAirBullets", var_3_4, var_3_5, 3)
	arg_3_0._foeBulleetTreeList = {}
	arg_3_0._foeBulleetTreeList[var_0.BulletField.SURFACE] = arg_3_0._foeSurafceBulletTree
	arg_3_0._foeBulleetTreeList[var_0.BulletField.AIR] = arg_3_0._foeAirbulletTree
	arg_3_0._surfaceAOETree = pg.ColliderTree.New("surfaceAOE", var_3_4, var_3_5, 2)
	arg_3_0._airAOETree = pg.ColliderTree.New("airAOE", var_3_4, var_3_5, 2)
	arg_3_0._bulletAOETree = pg.ColliderTree.New("bulletAOE", var_3_4, var_3_5, 2)
	arg_3_0._AOETreeList = {}
	arg_3_0._AOETreeList[var_0.AOEField.SURFACE] = arg_3_0._surfaceAOETree
	arg_3_0._AOETreeList[var_0.AOEField.AIR] = arg_3_0._airAOETree
	arg_3_0._AOETreeList[var_0.AOEField.BULLET] = arg_3_0._bulletAOETree
	arg_3_0._wallTree = pg.ColliderTree.New("wall", var_3_4, var_3_5, 2)

	return
end

function var_0_5.UpdateShipCldTree(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:GetSpeed()
	local var_4_1 = arg_4_1:GetCldBox()
	local var_4_2
	local var_4_3 = not var_0_4.IsUnitCldImmune(arg_4_1)

	if arg_4_1:GetIFF() == arg_4_0._foeCode then
		if var_4_3 then
			if arg_4_1:GetCldData().FriendlyCld then
				local var_4_4 = arg_4_0._foeShipTree:GetCldList(var_4_1, var_4_0)

				arg_4_1:GetCldData().distList = {}

				if #var_4_4 > 1 then
					arg_4_0:HandleEnemyShipCld(var_4_4, arg_4_1)
				end
			end

			local var_4_5 = arg_4_0._shipTree:GetCldList(var_4_1, var_4_0)

			arg_4_0._proxy:HandleShipCrashDecelerate(arg_4_1, (arg_4_0.surfaceFilterCount(arg_4_1, var_4_5)))
			arg_4_0:HandlePlayerShipCld(var_4_5, arg_4_1)
		end

		var_4_2 = arg_4_0._foeShipTree
	elseif arg_4_1:GetIFF() == arg_4_0._friendlyCode then
		if var_4_3 then
			arg_4_0._proxy:HandleShipCrashDecelerate(arg_4_1, (arg_4_0.surfaceFilterCount(arg_4_1, (arg_4_0._foeShipTree:GetCldList(var_4_1, var_4_0)))))
		end

		var_4_2 = arg_4_0._shipTree
	end

	var_4_2:Update(var_4_1)

	return
end

function var_0_5.HandlePlayerShipCld(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_2:GetCldData()

	if var_5_0.Active == false or var_5_0.ImmuneCLD == true then
		return
	end

	for iter_5_0 = 1, #arg_5_1 do
		if arg_5_1[iter_5_0].data.Active == false or arg_5_1[iter_5_0].data.ImmuneCLD == true then
			-- block empty
		elseif arg_5_1[iter_5_0].data.UID == arg_5_2:GetUniqueID() then
			-- block empty
		elseif var_5_0.IFF == arg_5_1[iter_5_0].data.IFF then
			-- block empty
		elseif var_5_0.Surface ~= arg_5_1[iter_5_0].data.Surface then
			-- block empty
		else
			({})[#{} + 1] = arg_5_1[iter_5_0].data.UID
		end
	end

	arg_5_0._proxy:HandleShipCrashDamageList(arg_5_2, {})

	return
end

function var_0_5.HandleEnemyShipCld(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_2:GetCldData()

	if var_6_0.Active == false or var_6_0.ImmuneCLD == true then
		return
	end

	local var_6_1 = arg_6_2:GetPosition()

	for iter_6_0 = 1, #arg_6_1 do
		if arg_6_1[iter_6_0].data.Active == false or arg_6_1[iter_6_0].data.ImmuneCLD == true then
			-- block empty
		elseif arg_6_1[iter_6_0].data.UID == arg_6_2:GetUniqueID() then
			-- block empty
		elseif var_6_0.IFF ~= arg_6_1[iter_6_0].data.IFF then
			-- block empty
		elseif not arg_6_1[iter_6_0].data.FriendlyCld then
			-- block empty
		elseif var_6_0.Surface ~= arg_6_1[iter_6_0].data.Surface then
			-- block empty
		else
			local var_6_2 = arg_6_0:GetShip(arg_6_1[iter_6_0].data.UID)

			;({})[#{} + 1] = var_6_1 - var_6_2:GetPosition()
		end
	end

	var_6_0.distList = {}

	return
end

function var_0_5.surfaceFilterCount(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:GetCldData()
	local var_7_1 = 0

	for iter_7_0 = 1, #arg_7_1 do
		if arg_7_1[iter_7_0].data.Active == true and arg_7_1[iter_7_0].data.ImmuneCLD == false and arg_7_1[iter_7_0].data.UID ~= arg_7_0:GetUniqueID() and var_7_0.IFF ~= arg_7_1[iter_7_0].data.IFF and var_7_0.Surface == arg_7_1[iter_7_0].data.Surface then
			var_7_1 = var_7_1 + 1
		end
	end

	return var_7_1
end

function var_0_5.UpdateAircraftCld(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:GetSpeed()
	local var_8_1 = arg_8_1:GetCldBox()
	local var_8_2

	if arg_8_1:GetIFF() == arg_8_0._foeCode then
		var_8_2 = arg_8_0:GetBulletTree(var_0.BulletField.AIR)
	elseif arg_8_1:GetIFF() == arg_8_0._friendlyCode then
		var_8_2 = arg_8_0:GetFoeBulletTree(var_0.BulletField.AIR)
	end

	arg_8_0:HandleBulletCldWithAircraft(var_8_2:GetCldList(var_8_1, var_8_0), arg_8_1)
	arg_8_0._aircraftTree:Update(arg_8_1:GetCldBox())

	return
end

function var_0_5.HandleBulletCldWithAircraft(arg_9_0, arg_9_1, arg_9_2)
	for iter_9_0 = 1, #arg_9_1 do
		if arg_9_1[iter_9_0].data.type == var_0.CldType.BULLET and arg_9_1[iter_9_0].data.Active == true and arg_9_1[iter_9_0].data.ImmuneCLD == false then
			arg_9_0._proxy:HandleBulletHit(arg_9_0:GetBullet(arg_9_1[iter_9_0].data.UID), arg_9_2)
		end
	end

	return
end

function var_0_5.UpdateBulletCld(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1:GetEffectField()
	local var_10_1 = arg_10_1:GetCldBox()
	local var_10_2 = arg_10_1:GetCldData().IFF

	if var_10_0 == var_0.BulletField.SURFACE then
		local var_10_4 = arg_10_0:getBulletCldShipList(arg_10_1, var_10_2 == arg_10_0._foeCode and arg_10_0._shipTree or arg_10_0._foeShipTree)

		if arg_10_1:IsIndiscriminate() then
			if nil == arg_10_0._shipTree then
				local var_10_5 = arg_10_0._foeShipTree or arg_10_0._shipTree

				for iter_10_0, iter_10_1 in ipairs((arg_10_0:getBulletCldShipList(arg_10_1, var_10_5))) do
					table.insert(var_10_4, iter_10_1)
				end

				arg_10_0:HandleBulletCldWithShip(var_10_4, arg_10_1)

				local var_10_6 = var_10_2 == arg_10_0._friendlyCode and arg_10_0:GetBulletTree(var_10_0) or (var_10_2 ~= arg_10_0._foeCode or true) and nil

				arg_10_0:GetFoeBulletTree(var_10_0):Update(var_10_1)

				return
			end
		end
	end
end

function var_0_5.getBulletCldShipList(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_1:GetCldBox()
	local var_11_1

	if arg_11_1:GetType() == var_0.BulletType.SCALE then
		local var_11_2, var_11_3, var_11_4 = arg_11_1:GetRadian()

		if math.abs(var_11_3) ~= 1 then
			if arg_11_1:GetIFF() == -1 then
				var_11_2 = var_11_2 + math.pi
			end

			local var_11_5 = arg_11_1:GetBoxSize()
			local var_11_6 = arg_11_1:GetPosition()

			var_11_1 = arg_11_2:GetCldListGradient(var_11_2, var_11_5.z * 2, var_11_5.x * 2, (Vector3(var_11_6.x + var_11_5.x * var_11_3, 1, var_11_6.z + var_11_5.x * var_11_4)))
		else
			var_11_1 = arg_11_2:GetCldList(var_11_0, var_0_1)
		end
	else
		var_11_1 = arg_11_2:GetCldList(var_11_0, var_0_1)
	end

	return var_11_1
end

function var_0_5.HandleBulletCldWithShip(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_2:GetType()

	for iter_12_0 = 1, #arg_12_1 do
		if arg_12_1[iter_12_0].data.type == var_0.CldType.SHIP and arg_12_1[iter_12_0].data.Active == true and arg_12_1[iter_12_0].data.ImmuneCLD == false then
			local var_12_1 = arg_12_0:GetShip(arg_12_1[iter_12_0].data.UID)
			local var_12_2 = var_12_1:IsImmuneCommonBulletCLD()

			if var_12_1:GetCurrentOxyState() == var_0_2.DIVE and arg_12_2:GetCldData().Surface ~= var_0.OXY_STATE.DIVE then
				-- block empty
			elseif var_12_2 then
				-- block empty
			elseif arg_12_0._proxy:HandleBulletHit(arg_12_2, var_12_1) then
				break
			end
		end
	end

	return
end

function var_0_5.UpdateAOECld(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1:GetCldBox()
	local var_13_1 = arg_13_1:GetFieldType()
	local var_13_2 = arg_13_1:GetCldData().IFF

	if arg_13_1:OpponentAffected() then
		local var_13_3 = var_13_2 * -1 or var_13_2

		if var_13_1 == var_0.AOEField.SURFACE then
			if arg_13_1:OpponentAffected() == (arg_13_1:GetCldData().IFF == arg_13_0._foeCode) then
				local var_13_5 = arg_13_0._shipTree or arg_13_0._foeShipTree
				local var_13_6 = arg_13_0:getAreaCldShipList(arg_13_1, var_13_5)

				if arg_13_1:GetIndiscriminate() then
					if var_13_5 == arg_13_0._shipTree then
						local var_13_7 = arg_13_0._foeShipTree or arg_13_0._shipTree

						for iter_13_0, iter_13_1 in ipairs((arg_13_0:getAreaCldShipList(arg_13_1, var_13_7))) do
							table.insert(var_13_6, iter_13_1)
						end

						arg_13_0:HandleAreaCldWithVehicle(arg_13_1, var_13_6)

						goto label_13_0

						if var_13_1 == var_0.AOEField.BULLET then
							local var_13_9 = (var_13_3 == arg_13_0._foeCode and arg_13_0._foeSurafceBulletTree or arg_13_0._surfaceBulletTree):GetCldList(var_13_0, var_0_1)

							arg_13_1:ClearCLDList()
							arg_13_0:HandleAreaCldWithBullet(arg_13_1, var_13_9)
						else
							local var_13_10 = {}

							for iter_13_2, iter_13_3 in ipairs((arg_13_0._aircraftTree:GetCldList(var_13_0, var_0_1))) do
								if iter_13_3.data.IFF == var_13_3 then
									table.insert(var_13_10, iter_13_3)
								end
							end

							arg_13_0:HandleAreaCldWithAircraft(arg_13_1, var_13_10)
						end

						::label_13_0::

						return
					end
				end
			end
		end
	end
end

function var_0_5.getAreaCldShipList(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0
	local var_14_1 = arg_14_1:GetAreaType()

	if var_14_1 ~= var_0.AreaType.COLUMN then
		if arg_14_1:GetAnchorPointAlignment() == Vector3.zero then
			var_14_0 = arg_14_2:GetCldList(arg_14_1:GetCldBox(), var_0_1)
		else
			local var_14_2

			if var_14_1 == var_0.AreaType.ELLIPSE then
				var_14_0 = arg_14_2:GetCldListEllipse(arg_14_1:GetWidth(), arg_14_1:GetHeight(), pos)

				goto label_14_0

				var_14_2 = arg_14_1:GetAngle() * math.deg2Rad
			end

			if arg_14_1:GetCldData().IFF == arg_14_0._foeCode then
				var_14_2 = var_14_2 + math.pi
			end

			var_14_0 = arg_14_2:GetCldListGradient(var_14_2, arg_14_1:GetHeight(), arg_14_1:GetWidth(), (arg_14_1:GetPosition()))
		end

		::label_14_0::

		return var_14_0
	end
end

function var_0_5.HandleAreaCldWithVehicle(arg_15_0, arg_15_1, arg_15_2)
	arg_15_1:ClearCLDList()

	local var_15_0 = arg_15_1:GetCldData()
	local var_15_1 = arg_15_1:OpponentAffected()

	for iter_15_0 = 1, #arg_15_2 do
		if arg_15_2[iter_15_0].data.Active == true and arg_15_2[iter_15_0].data.ImmuneCLD == false then
			local var_15_2 = arg_15_1:GetDiveFilter()
			local var_15_3 = arg_15_0:GetShip(arg_15_2[iter_15_0].data.UID)
			local var_15_4 = true

			if var_15_2 and table.contains(var_15_2, (var_15_3:GetCurrentOxyState())) then
				var_15_4 = false
			end

			if var_15_4 and not arg_15_1:IsOutOfAngle(var_15_3) then
				arg_15_1:AppendCldObj(arg_15_2[iter_15_0].data)
			end
		end
	end

	return
end

function var_0_5.HandleAreaCldWithAircraft(arg_16_0, arg_16_1, arg_16_2)
	arg_16_1:ClearCLDList()

	local var_16_0 = arg_16_1:GetCldData()
	local var_16_1 = arg_16_1:OpponentAffected()

	for iter_16_0 = 1, #arg_16_2 do
		local var_16_2 = arg_16_2[iter_16_0].data

		if var_16_1 == (arg_16_2[iter_16_0].data.IFF ~= var_16_0.IFF) then
			arg_16_1:AppendCldObj(var_16_2)
		end
	end

	return
end

function var_0_5.HandleAreaCldWithBullet(arg_17_0, arg_17_1, arg_17_2)
	for iter_17_0 = 1, #arg_17_2 do
		arg_17_1:AppendCldObj(arg_17_2[iter_17_0].data)
	end

	return
end

function var_0_5.UpdateWallCld(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1:GetCldBox()
	local var_18_1 = arg_18_1:GetCldObjType()

	if var_18_1 == arg_18_1.CLD_OBJ_TYPE_BULLET then
		local var_18_2 = arg_18_1:GetIFF() == arg_18_0._friendlyCode and arg_18_0._foeSurafceBulletTree:GetCldList(var_18_0, var_0_1) or arg_18_0._surfaceBulletTree:GetCldList(var_18_0, var_0_1)

		arg_18_0:HandleWallCldWithBullet(arg_18_1, var_18_2)
	elseif var_18_1 == arg_18_1.CLD_OBJ_TYPE_SHIP then
		local var_18_3 = arg_18_1:GetIFF() == arg_18_0._friendlyCode and arg_18_0._foeShipTree:GetCldList(var_18_0, var_0_1) or arg_18_0._shipTree:GetCldList(var_18_0, var_0_1)

		arg_18_0:HandleWllCldWithShip(arg_18_1, var_18_3)
	end

	return
end

function var_0_5.HandleWallCldWithBullet(arg_19_0, arg_19_1, arg_19_2)
	for iter_19_0 = 1, #arg_19_2 do
		if arg_19_2[iter_19_0].data.type == var_0.CldType.BULLET and arg_19_2[iter_19_0].data.Active == true and arg_19_2[iter_19_0].data.ImmuneCLD == false and not arg_19_0._proxy:HandleWallHitByBullet(arg_19_1, (arg_19_0:GetBullet(arg_19_2[iter_19_0].data.UID))) then
			return
		end
	end

	return
end

function var_0_5.HandleWllCldWithShip(arg_20_0, arg_20_1, arg_20_2)
	for iter_20_0 = 1, #arg_20_2 do
		if arg_20_2[iter_20_0].data.type == var_0.CldType.SHIP and arg_20_2[iter_20_0].data.Active == true and arg_20_2[iter_20_0].data.ImmuneCLD == false then
			local var_20_0 = arg_20_0:GetShip(arg_20_2[iter_20_0].data.UID)

			if var_20_0:GetCurrentOxyState() == var_0_2.DIVE then
				-- block empty
			else
				table.insert({}, var_20_0)
			end
		end
	end

	arg_20_0._proxy:HandleWallHitByShip(arg_20_1, {})

	return
end

function var_0_5.InsertToBulletCldTree(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0
	local var_21_1 = arg_21_2:GetCldData()

	if var_21_1.IFF == arg_21_0._foeCode then
		var_21_0 = arg_21_0:GetFoeBulletTree(arg_21_1)
	elseif var_21_1.IFF == arg_21_0._friendlyCode then
		-- block empty
	end

	arg_21_0:GetBulletTree(arg_21_1):Insert((arg_21_2:GetCldBox()))

	return
end

function var_0_5.InsertToAOECldTree(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0:GetAOETree(arg_22_1):Insert((arg_22_2:GetCldBox()))

	return
end

function var_0_5.InsertToWallCldTree(arg_23_0, arg_23_1)
	arg_23_0:GetWallTree():Insert((arg_23_1:GetCldBox()))

	return
end

function var_0_5.InsertToShipCldTree(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_1:GetCldData()
	local var_24_1

	if var_24_0.IFF == arg_24_0._foeCode then
		var_24_1 = arg_24_0:GetFoeShipTree()
	elseif var_24_0.IFF == arg_24_0._friendlyCode then
		-- block empty
	end

	arg_24_0:GetShipTree():Insert((arg_24_1:GetCldBox()))

	return
end

function var_0_5.InsertToAircraftCldTree(arg_25_0, arg_25_1)
	arg_25_0._aircraftTree:Insert((arg_25_1:GetCldBox()))

	return
end

function var_0_5.GetBulletTree(arg_26_0, arg_26_1)
	return arg_26_0._bulletTreeList[arg_26_1]
end

function var_0_5.GetFoeBulletTree(arg_27_0, arg_27_1)
	return arg_27_0._foeBulleetTreeList[arg_27_1]
end

function var_0_5.GetAOETree(arg_28_0, arg_28_1)
	return arg_28_0._AOETreeList[arg_28_1]
end

function var_0_5.GetWallTree(arg_29_0, arg_29_1)
	return arg_29_0._wallTree
end

function var_0_5.GetShipTree(arg_30_0)
	return arg_30_0._shipTree
end

function var_0_5.GetFoeShipTree(arg_31_0)
	return arg_31_0._foeShipTree
end

function var_0_5.GetAircraftTree(arg_32_0)
	return arg_32_0._aircraftTree
end

function var_0_5.DeleteShipLeaf(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_1:GetCldData().IFF

	if var_33_0 == arg_33_0._foeCode then
		arg_33_0.DeleteCldLeaf(arg_33_0:GetFoeShipTree(), arg_33_1)
	elseif var_33_0 == arg_33_0._friendlyCode then
		arg_33_0.DeleteCldLeaf(arg_33_0:GetShipTree(), arg_33_1)
	end

	return
end

function var_0_5.DeleteBulletLeaf(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_1:GetCldData().IFF

	if var_34_0 == arg_34_0._foeCode then
		arg_34_0.DeleteCldLeaf(arg_34_0:GetFoeBulletTree(arg_34_1:GetEffectField()), arg_34_1)
	elseif var_34_0 == arg_34_0._friendlyCode then
		arg_34_0.DeleteCldLeaf(arg_34_0:GetBulletTree(arg_34_1:GetEffectField()), arg_34_1)
	end

	return
end

function var_0_5.DeleteCldLeaf(arg_35_0, arg_35_1)
	arg_35_0:Remove((arg_35_1:GetCldBox()))

	return
end

function var_0_5.GetShip(arg_36_0, arg_36_1)
	return arg_36_0._proxy:GetUnitList()[arg_36_1]
end

function var_0_5.GetAircraft(arg_37_0, arg_37_1)
	return arg_37_0._proxy:GetAircraftList()[arg_37_1]
end

function var_0_5.GetBullet(arg_38_0, arg_38_1)
	return arg_38_0._proxy:GetBulletList()[arg_38_1]
end

function var_0_5.GetAOE(arg_39_0, arg_39_1)
	return arg_39_0._proxy:GetAOEList()[arg_39_1]
end

function var_0_5.InitShipCld(arg_40_0, arg_40_1)
	arg_40_0:InsertToShipCldTree(arg_40_1)

	return
end

function var_0_5.DeleteShipCld(arg_41_0, arg_41_1)
	arg_41_1:DeactiveCldBox()
	arg_41_0:DeleteShipLeaf(arg_41_1)

	return
end

function var_0_5.InitAircraftCld(arg_42_0, arg_42_1)
	arg_42_0:InsertToAircraftCldTree(arg_42_1)

	return
end

function var_0_5.DeleteAircraftCld(arg_43_0, arg_43_1)
	arg_43_1:DeactiveCldBox()
	arg_43_0.DeleteCldLeaf(arg_43_0:GetAircraftTree(), arg_43_1)

	return
end

function var_0_5.InitBulletCld(arg_44_0, arg_44_1)
	arg_44_0:InsertToBulletCldTree(arg_44_1:GetEffectField(), arg_44_1)

	return
end

function var_0_5.DeleteBulletCld(arg_45_0, arg_45_1)
	arg_45_1:DeactiveCldBox()
	arg_45_0:DeleteBulletLeaf(arg_45_1)

	return
end

function var_0_5.ShiftBulletCld(arg_46_0, arg_46_1)
	return
end

function var_0_5.InitAOECld(arg_47_0, arg_47_1)
	arg_47_0:InsertToAOECldTree(arg_47_1:GetFieldType(), arg_47_1)

	return
end

function var_0_5.DeleteAOECld(arg_48_0, arg_48_1)
	arg_48_1:DeactiveCldBox()
	arg_48_0.DeleteCldLeaf(arg_48_0:GetAOETree(arg_48_1:GetFieldType()), arg_48_1)

	return
end

function var_0_5.InitWallCld(arg_49_0, arg_49_1)
	arg_49_0:InsertToWallCldTree(arg_49_1)

	return
end

function var_0_5.DeleteWallCld(arg_50_0, arg_50_1)
	arg_50_1:DeactiveCldBox()

	local var_50_0 = arg_50_0:GetWallTree()

	if var_50_0 then
		arg_50_0.DeleteCldLeaf(var_50_0, arg_50_1)
	end

	return
end

return
