ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleFormulas
local var_0_2 = var_0.Battle.BattleConst

Vector3 = var_0_10003

local var_0_3 = var_0_10003.zero
local var_0_4 = var_0_2.OXY_STATE
local var_0_5 = var_0_2.BulletType
local var_0_6 = var_0.Battle.BattleAttr

class = var_0_10007

local var_0_7 = var_0_10007("BattleCldSystem")

var_0.Battle.BattleCldSystem = var_0_7
var_0_7.__name = "BattleCldSystem"

function var_0_7.Ctor(arg_1_0, arg_1_1)
	arg_1_0._proxy = arg_1_1

	arg_1_0:InitCldTree()

	arg_1_0._friendlyCode = arg_1_1:GetFriendlyCode()
	arg_1_0._foeCode = arg_1_1:GetFoeCode()

	return
end

function var_0_7.Dispose(arg_2_0)
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

function var_0_7.InitCldTree(arg_3_0)
	local var_3_0 = arg_3_0._proxy
	local var_3_1, var_3_2, var_3_3, var_3_4 = var_1.GetTotalBounds(var_3_0)

	Vector3 = var_1_10005

	local var_3_5 = var_1_10005(var_3_3, 0, var_3_2)

	Vector3 = var_1_10006

	local var_3_6 = var_1_10006(var_3_4, 0, var_3_1)

	pg = var_7
	arg_3_0._shipTree = var_7.ColliderTree.New("shipTree", var_3_5, var_3_6, 2)
	pg = var_7
	arg_3_0._foeShipTree = var_7.ColliderTree.New("foeShipTree", var_3_5, var_3_6, 2)
	pg = var_7
	arg_3_0._aircraftTree = var_7.ColliderTree.New("aircraftTree", var_3_5, var_3_6, 2)
	pg = var_7
	arg_3_0._surfaceBulletTree = var_7.ColliderTree.New("surfaceBullets", var_3_5, var_3_6, 4)
	pg = var_7
	arg_3_0._airBulletTree = var_7.ColliderTree.New("airBullets", var_3_5, var_3_6, 3)
	arg_3_0._bulletTreeList = {}
	arg_3_0._bulletTreeList[var_0_2.BulletField.SURFACE] = arg_3_0._surfaceBulletTree

	local var_3_7 = arg_3_0._bulletTreeList

	var_3_7[var_0_2.BulletField.AIR] = arg_3_0._airBulletTree
	pg = var_3_7
	arg_3_0._foeSurafceBulletTree = var_3_7.ColliderTree.New("foeSurfaceBullets", var_3_5, var_3_6, 3)
	pg = var_7
	arg_3_0._foeAirbulletTree = var_7.ColliderTree.New("foeAirBullets", var_3_5, var_3_6, 3)
	arg_3_0._foeBulleetTreeList = {}
	arg_3_0._foeBulleetTreeList[var_0_2.BulletField.SURFACE] = arg_3_0._foeSurafceBulletTree

	local var_3_8 = arg_3_0._foeBulleetTreeList

	var_3_8[var_0_2.BulletField.AIR] = arg_3_0._foeAirbulletTree
	pg = var_3_8
	arg_3_0._surfaceAOETree = var_3_8.ColliderTree.New("surfaceAOE", var_3_5, var_3_6, 2)
	pg = var_7
	arg_3_0._airAOETree = var_7.ColliderTree.New("airAOE", var_3_5, var_3_6, 2)
	pg = var_7
	arg_3_0._bulletAOETree = var_7.ColliderTree.New("bulletAOE", var_3_5, var_3_6, 2)
	arg_3_0._AOETreeList = {}
	arg_3_0._AOETreeList[var_0_2.AOEField.SURFACE] = arg_3_0._surfaceAOETree
	arg_3_0._AOETreeList[var_0_2.AOEField.AIR] = arg_3_0._airAOETree

	local var_3_9 = arg_3_0._AOETreeList

	var_3_9[var_0_2.AOEField.BULLET] = arg_3_0._bulletAOETree
	pg = var_3_9
	arg_3_0._wallTree = var_3_9.ColliderTree.New("wall", var_3_5, var_3_6, 2)

	return
end

function var_0_7.UpdateShipCldTree(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:GetSpeed()
	local var_4_1 = arg_4_1:GetCldBox()
	local var_4_2
	local var_4_3 = not var_0_6.IsUnitCldImmune(arg_4_1)

	if arg_4_1:GetIFF() == arg_4_0._foeCode then
		if var_4_3 then
			if arg_4_1:GetCldData().FriendlyCld then
				local var_4_4 = arg_4_0._foeShipTree
				local var_4_5 = var_6.GetCldList(var_4_4, var_4_1, var_4_0)

				arg_4_1:GetCldData().distList = {}

				if #var_4_5 > 1 then
					arg_4_0:HandleEnemyShipCld(var_4_5, arg_4_1)
				end
			end

			local var_4_6 = arg_4_0._shipTree
			local var_4_7 = var_6.GetCldList(var_4_6, var_4_1, var_4_0)
			local var_4_8 = arg_4_0.surfaceFilterCount(arg_4_1, var_4_7)
			local var_4_9 = arg_4_0._proxy

			var_8.HandleShipCrashDecelerate(var_4_9, arg_4_1, var_4_8)
			arg_4_0:HandlePlayerShipCld(var_4_7, arg_4_1)
		end

		var_4_2 = arg_4_0._foeShipTree
	elseif arg_4_1:GetIFF() == arg_4_0._friendlyCode then
		if var_4_3 then
			local var_4_10 = arg_4_0._foeShipTree
			local var_4_11 = var_6.GetCldList(var_4_10, var_4_1, var_4_0)
			local var_4_12 = arg_4_0.surfaceFilterCount(arg_4_1, var_4_11)
			local var_4_13 = arg_4_0._proxy

			var_8.HandleShipCrashDecelerate(var_4_13, arg_4_1, var_4_12)
		end

		var_4_2 = arg_4_0._shipTree
	end

	var_4_2:Update(var_4_1)

	return
end

function var_0_7.HandlePlayerShipCld(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_2:GetCldData().Active == false or var_3.ImmuneCLD == true then
		return
	end

	local var_5_0 = #arg_5_1
	local var_5_1 = {}

	for iter_5_0 = 1, var_5_0 do
		if arg_5_1[iter_5_0].data.Active == false or var_10.ImmuneCLD == true then
			-- block empty
		elseif var_10.UID == arg_5_2:GetUniqueID() then
			-- block empty
		elseif var_3.IFF == var_10.IFF then
			-- block empty
		elseif var_3.Surface ~= var_10.Surface then
			-- block empty
		else
			var_5_1[#var_5_1 + 1] = var_10.UID
		end
	end

	local var_5_2 = arg_5_0._proxy

	var_6.HandleShipCrashDamageList(var_5_2, arg_5_2, var_5_1)

	return
end

function var_0_7.HandleEnemyShipCld(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_2:GetCldData().Active == false or var_3.ImmuneCLD == true then
		return
	end

	local var_6_0 = arg_6_2:GetPosition()
	local var_6_1 = {}
	local var_6_2 = #arg_6_1

	for iter_6_0 = 1, var_6_2 do
		if arg_6_1[iter_6_0].data.Active == false or var_11.ImmuneCLD == true then
			-- block empty
		elseif var_11.UID == arg_6_2:GetUniqueID() then
			-- block empty
		elseif var_3.IFF ~= var_11.IFF then
			-- block empty
		elseif not var_11.FriendlyCld then
			-- block empty
		elseif var_3.Surface ~= var_11.Surface then
			-- block empty
		else
			local var_6_3 = arg_6_0:GetShip(var_11.UID)
			local var_6_4 = var_6_0 - var_12.GetPosition(var_6_3)

			var_6_1[#var_6_1 + 1] = var_6_4
		end
	end

	var_3.distList = var_6_1

	return
end

function var_0_7.surfaceFilterCount(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:GetCldData()
	local var_7_1 = 0
	local var_7_2 = #arg_7_1

	for iter_7_0 = 1, var_7_2 do
		if arg_7_1[iter_7_0].data.Active == true and var_9.ImmuneCLD == false and var_9.UID ~= arg_7_0:GetUniqueID() and var_7_0.IFF ~= var_9.IFF and var_7_0.Surface == var_9.Surface then
			var_7_1 = var_7_1 + 1
		end
	end

	return var_7_1
end

function var_0_7.UpdateAircraftCld(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:GetSpeed()
	local var_8_1 = arg_8_1:GetCldBox()
	local var_8_2

	if arg_8_1:GetIFF() == arg_8_0._foeCode then
		var_8_2 = arg_8_0:GetBulletTree(var_0_2.BulletField.AIR)
	elseif arg_8_1:GetIFF() == arg_8_0._friendlyCode then
		var_8_2 = arg_8_0:GetFoeBulletTree(var_0_2.BulletField.AIR)
	end

	local var_8_3 = var_8_2:GetCldList(var_8_1, var_8_0)

	arg_8_0:HandleBulletCldWithAircraft(var_8_3, arg_8_1)

	local var_8_4 = arg_8_0._aircraftTree

	var_6.Update(var_8_4, arg_8_1:GetCldBox())

	return
end

function var_0_7.HandleBulletCldWithAircraft(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = #arg_9_1

	for iter_9_0 = 1, var_9_0 do
		if arg_9_1[iter_9_0].data.type == var_0_2.CldType.BULLET and var_8.Active == true and var_8.ImmuneCLD == false then
			local var_9_1 = arg_9_0:GetBullet(var_8.UID)
			local var_9_2 = arg_9_0._proxy

			var_10.HandleBulletHit(var_9_2, var_9_1, arg_9_2)
		end
	end

	return
end

function var_0_7.UpdateBulletCld(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1:GetEffectField()
	local var_10_1 = arg_10_1:GetCldBox()
	local var_10_2 = arg_10_1:GetCldData().IFF
	local var_10_3
	local var_10_4

	if var_10_0 == var_0_2.BulletField.SURFACE then
		local var_10_5 = var_10_2 == arg_10_0._foeCode and arg_10_0._shipTree or arg_10_0._foeShipTree
		local var_10_6 = arg_10_0:getBulletCldShipList(arg_10_1, var_10_5)
		local var_10_7 = arg_10_1

		if arg_10_1.IsIndiscriminate(var_10_7) then
			local var_10_8

			if var_10_5 ~= arg_10_0._shipTree or not arg_10_0._foeShipTree then
				var_10_8 = arg_10_0._shipTree
			end

			local var_10_9 = arg_10_0:getBulletCldShipList(arg_10_1, var_10_8)

			ipairs = var_10_7

			for iter_10_0, iter_10_1 in var_10_7(var_10_9) do
				table = var_1_10015

				var_1_10015.insert(var_10_6, iter_10_1)
			end
		end

		arg_10_0:HandleBulletCldWithShip(var_10_6, arg_10_1)
	end

	if var_10_2 == arg_10_0._friendlyCode then
		var_10_3 = arg_10_0:GetBulletTree(var_10_0)
	elseif var_10_2 == arg_10_0._foeCode then
		var_10_3 = arg_10_0:GetFoeBulletTree(var_10_0)
	end

	var_10_3:Update(var_10_1)

	return
end

function var_0_7.getBulletCldShipList(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_1:GetCldBox()
	local var_11_1

	if arg_11_1:GetType() == var_0_2.BulletType.SCALE then
		local var_11_2, var_11_3, var_11_4 = arg_11_1:GetRadian()

		math = var_1_10008

		if var_1_10008.abs(var_11_3) ~= 1 then
			if arg_11_1:GetIFF() == -1 then
				math = var_8
				var_11_2 = var_11_2 + var_8.pi
			end

			local var_11_5 = arg_11_1:GetBoxSize().x * 2
			local var_11_6 = var_8.z * 2
			local var_11_7 = arg_11_1:GetPosition()
			local var_11_8 = var_8.x * var_11_3
			local var_11_9 = var_12 * var_11_4

			Vector3 = var_1_10015

			local var_11_10 = var_1_10015(var_11_7.x + var_11_8, 1, var_11_7.z + var_11_9)

			var_11_1 = arg_11_2:GetCldListGradient(var_11_2, var_11_6, var_11_5, var_11_10)
		else
			var_11_1 = arg_11_2:GetCldList(var_11_0, var_0_3)
		end
	else
		var_11_1 = arg_11_2:GetCldList(var_11_0, var_0_3)
	end

	return var_11_1
end

function var_0_7.HandleBulletCldWithShip(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = #arg_12_1
	local var_12_1 = arg_12_2:GetType()

	for iter_12_0 = 1, var_12_0 do
		if arg_12_1[iter_12_0].data.type == var_0_2.CldType.SHIP and var_9.Active == true and var_9.ImmuneCLD == false then
			local var_12_2 = arg_12_0:GetShip(var_9.UID)
			local var_12_3 = var_10.GetCurrentOxyState(var_12_2)
			local var_12_4 = var_10:IsImmuneCommonBulletCLD()

			if var_12_3 == var_0_4.DIVE and arg_12_2:GetCldData().Surface ~= var_0_2.OXY_STATE.DIVE then
				-- block empty
			elseif var_12_4 then
				-- block empty
			else
				local var_12_5 = arg_12_0._proxy

				if var_13.HandleBulletHit(var_12_5, arg_12_2, var_10) then
					break
				end
			end
		end
	end

	return
end

function var_0_7.UpdateAOECld(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1:GetCldBox()
	local var_13_1 = arg_13_1:GetFieldType()
	local var_13_2 = arg_13_1:OpponentAffected()
	local var_13_3 = arg_13_1:GetCldData().IFF
	local var_13_4

	if not var_13_2 or not (var_13_3 * -1) then
		var_13_4 = var_13_3
	end

	local var_13_5

	if var_13_1 == var_0_2.AOEField.SURFACE then
		var_1_10009 = arg_13_1:GetCldData().IFF == arg_13_0._foeCode

		local var_13_6

		if arg_13_1:OpponentAffected() ~= var_1_10009 or not arg_13_0._shipTree then
			var_13_6 = arg_13_0._foeShipTree
		end

		local var_13_7 = arg_13_0:getAreaCldShipList(arg_13_1, var_13_6)
		local var_13_8 = arg_13_1

		if arg_13_1.GetIndiscriminate(var_13_8) then
			local var_13_9

			if var_13_6 ~= arg_13_0._shipTree or not arg_13_0._foeShipTree then
				var_13_9 = arg_13_0._shipTree
			end

			local var_13_10 = arg_13_0:getAreaCldShipList(arg_13_1, var_13_9)

			ipairs = var_13_8

			for iter_13_0, iter_13_1 in var_13_8(var_13_10) do
				table = var_1_10019

				var_1_10019.insert(var_13_7, iter_13_1)
			end
		end

		arg_13_0:HandleAreaCldWithVehicle(arg_13_1, var_13_7)
	elseif var_13_1 == var_0_2.AOEField.BULLET then
		local var_13_11

		if var_13_4 == arg_13_0._foeCode then
			var_13_11 = arg_13_0._foeSurafceBulletTree
		else
			var_13_11 = arg_13_0._surfaceBulletTree
		end

		local var_13_12 = var_13_11:GetCldList(var_13_0, var_0_3)

		arg_13_1:ClearCLDList()
		arg_13_0:HandleAreaCldWithBullet(arg_13_1, var_13_12)
	else
		local var_13_13 = {}
		local var_13_14 = arg_13_0._aircraftTree
		local var_13_15 = var_8.GetCldList(var_13_14, var_13_0, var_0_3)

		ipairs = var_1_10009

		for iter_13_2, iter_13_3 in var_1_10009(var_13_15) do
			if iter_13_3.data.IFF == var_13_4 then
				table = var_14

				var_14.insert(var_13_13, iter_13_3)
			end
		end

		arg_13_0:HandleAreaCldWithAircraft(arg_13_1, var_13_13)
	end

	return
end

function var_0_7.getAreaCldShipList(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0
	local var_14_1 = arg_14_1

	if arg_14_1.GetAreaType(var_14_1) ~= var_0_2.AreaType.COLUMN then
		local var_14_2 = arg_14_1:GetAnchorPointAlignment()

		Vector3 = var_14_1

		if var_14_2 == var_14_1.zero then
			local var_14_3 = arg_14_1:GetCldBox()

			var_14_0 = arg_14_2:GetCldList(var_14_3, var_0_3)
		elseif var_4 == var_0_2.AreaType.ELLIPSE then
			local var_14_4 = arg_14_1:GetWidth()
			local var_14_5 = arg_14_1:GetHeight()
			local var_14_6 = arg_14_2
			local var_14_7 = arg_14_2.GetCldListEllipse
			local var_14_8 = var_14_4
			local var_14_9 = var_14_5

			pos = var_1_10012
			var_14_0 = var_14_7(var_14_6, var_14_8, var_14_9, var_1_10012)
		else
			local var_14_10 = arg_14_1
			local var_14_11 = arg_14_1.GetCldData(var_14_10).IFF == arg_14_0._foeCode
			local var_14_12 = arg_14_1:GetAngle()

			math = var_14_10

			local var_14_13 = var_14_12 * var_14_10.deg2Rad

			if var_14_11 then
				math = var_7
				var_14_13 = var_14_13 + var_7.pi
			end

			local var_14_14 = arg_14_1:GetWidth()
			local var_14_15 = arg_14_1:GetHeight()
			local var_14_16 = arg_14_1:GetPosition()

			var_14_0 = arg_14_2:GetCldListGradient(var_14_13, var_14_15, var_14_14, var_14_16)
		end

		return var_14_0
	end
end

function var_0_7.HandleAreaCldWithVehicle(arg_15_0, arg_15_1, arg_15_2)
	arg_15_1:ClearCLDList()

	local var_15_0 = arg_15_1:GetCldData()
	local var_15_1 = arg_15_1:OpponentAffected()
	local var_15_2 = #arg_15_2

	for iter_15_0 = 1, var_15_2 do
		if arg_15_2[iter_15_0].data.Active == true and var_10.ImmuneCLD == false then
			local var_15_3 = arg_15_1:GetDiveFilter()
			local var_15_4 = arg_15_0:GetShip(var_10.UID)
			local var_15_5 = true

			if var_15_3 then
				local var_15_6 = var_15_4:GetCurrentOxyState()

				table = var_15

				if var_15.contains(var_15_3, var_15_6) then
					var_15_5 = false
				end
			end

			if var_15_5 and not arg_15_1:IsOutOfAngle(var_15_4) then
				arg_15_1:AppendCldObj(var_10)
			end
		end
	end

	return
end

function var_0_7.HandleAreaCldWithAircraft(arg_16_0, arg_16_1, arg_16_2)
	arg_16_1:ClearCLDList()

	local var_16_0 = arg_16_1:GetCldData()
	local var_16_1 = arg_16_1:OpponentAffected()
	local var_16_2 = #arg_16_2

	for iter_16_0 = 1, var_16_2 do
		if var_16_1 == (arg_16_2[iter_16_0].data.IFF ~= var_16_0.IFF) then
			arg_16_1:AppendCldObj(var_10)
		end
	end

	return
end

function var_0_7.HandleAreaCldWithBullet(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = #arg_17_2

	for iter_17_0 = 1, var_17_0 do
		local var_17_1 = arg_17_2[iter_17_0].data

		arg_17_1:AppendCldObj(var_17_1)
	end

	return
end

function var_0_7.UpdateWallCld(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1:GetCldBox()

	if arg_18_1:GetCldObjType() == arg_18_1.CLD_OBJ_TYPE_BULLET then
		local var_18_1

		if arg_18_1:GetIFF() == arg_18_0._friendlyCode then
			local var_18_2 = arg_18_0._foeSurafceBulletTree

			var_18_1 = var_5.GetCldList(var_18_2, var_18_0, var_0_3)
		else
			local var_18_3 = arg_18_0._surfaceBulletTree

			var_18_1 = var_5.GetCldList(var_18_3, var_18_0, var_0_3)
		end

		arg_18_0:HandleWallCldWithBullet(arg_18_1, var_18_1)
	elseif var_3 == arg_18_1.CLD_OBJ_TYPE_SHIP then
		local var_18_4

		if arg_18_1:GetIFF() == arg_18_0._friendlyCode then
			local var_18_5 = arg_18_0._foeShipTree

			var_18_4 = var_5.GetCldList(var_18_5, var_18_0, var_0_3)
		else
			local var_18_6 = arg_18_0._shipTree

			var_18_4 = var_5.GetCldList(var_18_6, var_18_0, var_0_3)
		end

		arg_18_0:HandleWllCldWithShip(arg_18_1, var_18_4)
	end

	return
end

function var_0_7.HandleWallCldWithBullet(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = #arg_19_2

	for iter_19_0 = 1, var_19_0 do
		if arg_19_2[iter_19_0].data.type == var_0_2.CldType.BULLET and var_8.Active == true and var_8.ImmuneCLD == false then
			local var_19_1 = arg_19_0:GetBullet(var_8.UID)
			local var_19_2 = arg_19_0._proxy

			if not var_10.HandleWallHitByBullet(var_19_2, arg_19_1, var_19_1) then
				return
			end
		end
	end

	return
end

function var_0_7.HandleWllCldWithShip(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = #arg_20_2
	local var_20_1 = {}

	for iter_20_0 = 1, var_20_0 do
		if arg_20_2[iter_20_0].data.type == var_0_2.CldType.SHIP and var_9.Active == true and var_9.ImmuneCLD == false then
			local var_20_2 = arg_20_0:GetShip(var_9.UID)

			if var_10.GetCurrentOxyState(var_20_2) == var_0_4.DIVE then
				-- block empty
			else
				table = var_12

				var_12.insert(var_20_1, var_10)
			end
		end
	end

	local var_20_3 = arg_20_0._proxy

	var_5.HandleWallHitByShip(var_20_3, arg_20_1, var_20_1)

	return
end

function var_0_7.InsertToBulletCldTree(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0

	if arg_21_2:GetCldData().IFF == arg_21_0._foeCode then
		var_21_0 = arg_21_0:GetFoeBulletTree(arg_21_1)
	elseif var_4.IFF == arg_21_0._friendlyCode then
		var_21_0 = arg_21_0:GetBulletTree(arg_21_1)
	end

	local var_21_1 = arg_21_2:GetCldBox()

	var_21_0:Insert(var_21_1)

	return
end

function var_0_7.InsertToAOECldTree(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0:GetAOETree(arg_22_1)
	local var_22_1 = arg_22_2:GetCldBox()

	var_22_0:Insert(var_22_1)

	return
end

function var_0_7.InsertToWallCldTree(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:GetWallTree()
	local var_23_1 = arg_23_1:GetCldBox()

	var_23_0:Insert(var_23_1)

	return
end

function var_0_7.InsertToShipCldTree(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_1:GetCldData()
	local var_24_1

	if var_24_0.IFF == arg_24_0._foeCode then
		var_24_1 = arg_24_0:GetFoeShipTree()
	elseif var_24_0.IFF == arg_24_0._friendlyCode then
		var_24_1 = arg_24_0:GetShipTree()
	end

	local var_24_2 = arg_24_1:GetCldBox()

	var_24_1:Insert(var_24_2)

	return
end

function var_0_7.InsertToAircraftCldTree(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_1:GetCldBox()
	local var_25_1 = arg_25_0._aircraftTree

	var_3.Insert(var_25_1, var_25_0)

	return
end

function var_0_7.GetBulletTree(arg_26_0, arg_26_1)
	return arg_26_0._bulletTreeList[arg_26_1]
end

function var_0_7.GetFoeBulletTree(arg_27_0, arg_27_1)
	return arg_27_0._foeBulleetTreeList[arg_27_1]
end

function var_0_7.GetAOETree(arg_28_0, arg_28_1)
	return arg_28_0._AOETreeList[arg_28_1]
end

function var_0_7.GetWallTree(arg_29_0, arg_29_1)
	return arg_29_0._wallTree
end

function var_0_7.GetShipTree(arg_30_0)
	return arg_30_0._shipTree
end

function var_0_7.GetFoeShipTree(arg_31_0)
	return arg_31_0._foeShipTree
end

function var_0_7.GetAircraftTree(arg_32_0)
	return arg_32_0._aircraftTree
end

function var_0_7.DeleteShipLeaf(arg_33_0, arg_33_1)
	if arg_33_1:GetCldData().IFF == arg_33_0._foeCode then
		arg_33_0.DeleteCldLeaf(arg_33_0:GetFoeShipTree(), arg_33_1)
	elseif var_2 == arg_33_0._friendlyCode then
		arg_33_0.DeleteCldLeaf(arg_33_0:GetShipTree(), arg_33_1)
	end

	return
end

function var_0_7.DeleteBulletLeaf(arg_34_0, arg_34_1)
	if arg_34_1:GetCldData().IFF == arg_34_0._foeCode then
		arg_34_0.DeleteCldLeaf(arg_34_0:GetFoeBulletTree(arg_34_1:GetEffectField()), arg_34_1)
	elseif var_2 == arg_34_0._friendlyCode then
		arg_34_0.DeleteCldLeaf(arg_34_0:GetBulletTree(arg_34_1:GetEffectField()), arg_34_1)
	end

	return
end

function var_0_7.DeleteCldLeaf(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_1:GetCldBox()

	arg_35_0:Remove(var_35_0)

	return
end

function var_0_7.GetShip(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0._proxy

	return var_2.GetUnitList(var_36_0)[arg_36_1]
end

function var_0_7.GetAircraft(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0._proxy

	return var_2.GetAircraftList(var_37_0)[arg_37_1]
end

function var_0_7.GetBullet(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_0._proxy

	return var_2.GetBulletList(var_38_0)[arg_38_1]
end

function var_0_7.GetAOE(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0._proxy

	return var_2.GetAOEList(var_39_0)[arg_39_1]
end

function var_0_7.InitShipCld(arg_40_0, arg_40_1)
	arg_40_0:InsertToShipCldTree(arg_40_1)

	return
end

function var_0_7.DeleteShipCld(arg_41_0, arg_41_1)
	arg_41_1:DeactiveCldBox()
	arg_41_0:DeleteShipLeaf(arg_41_1)

	return
end

function var_0_7.InitAircraftCld(arg_42_0, arg_42_1)
	arg_42_0:InsertToAircraftCldTree(arg_42_1)

	return
end

function var_0_7.DeleteAircraftCld(arg_43_0, arg_43_1)
	arg_43_1:DeactiveCldBox()
	arg_43_0.DeleteCldLeaf(arg_43_0:GetAircraftTree(), arg_43_1)

	return
end

function var_0_7.InitBulletCld(arg_44_0, arg_44_1)
	arg_44_0:InsertToBulletCldTree(arg_44_1:GetEffectField(), arg_44_1)

	return
end

function var_0_7.DeleteBulletCld(arg_45_0, arg_45_1)
	arg_45_1:DeactiveCldBox()
	arg_45_0:DeleteBulletLeaf(arg_45_1)

	return
end

function var_0_7.ShiftBulletCld(arg_46_0, arg_46_1)
	return
end

function var_0_7.InitAOECld(arg_47_0, arg_47_1)
	arg_47_0:InsertToAOECldTree(arg_47_1:GetFieldType(), arg_47_1)

	return
end

function var_0_7.DeleteAOECld(arg_48_0, arg_48_1)
	arg_48_1:DeactiveCldBox()
	arg_48_0.DeleteCldLeaf(arg_48_0:GetAOETree(arg_48_1:GetFieldType()), arg_48_1)

	return
end

function var_0_7.InitWallCld(arg_49_0, arg_49_1)
	arg_49_0:InsertToWallCldTree(arg_49_1)

	return
end

function var_0_7.DeleteWallCld(arg_50_0, arg_50_1)
	arg_50_1:DeactiveCldBox()

	if arg_50_0:GetWallTree() then
		arg_50_0.DeleteCldLeaf(var_2, arg_50_1)
	end

	return
end

return
