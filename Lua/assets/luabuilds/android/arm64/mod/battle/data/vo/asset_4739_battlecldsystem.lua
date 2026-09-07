ys = ys or {}

local var_0_1 = ys.Battle.BattleConst
local var_0_2 = Vector3.zero
local var_0_3 = ys.Battle.BattleConst.OXY_STATE
local var_0_5 = ys.Battle.BattleAttr
local BattleCldSystem = class("BattleCldSystem")

ys.Battle.BattleCldSystem = BattleCldSystem
BattleCldSystem.__name = "BattleCldSystem"

function BattleCldSystem:Ctor(arg_1_1)
	self._proxy = arg_1_1

	self:InitCldTree()

	self._friendlyCode = arg_1_1:GetFriendlyCode()
	self._foeCode = arg_1_1:GetFoeCode()

	return
end

function BattleCldSystem:Dispose()
	self._proxy = nil
	self._shipTree = nil
	self._foeShipTree = nil
	self._aircraftTree = nil
	self._surfaceBulletTree = nil
	self._airBulletTree = nil
	self._bulletTreeList = nil
	self._foeSurafceBulletTree = nil
	self._foeAirbulletTree = nil
	self._foeBulleetTreeList = nil
	self._surfaceAOETree = nil
	self._airAOETree = nil
	self._AOETreeList = nil
	self._wallTree = nil

	return
end

function BattleCldSystem:InitCldTree()
	local var_3_0, var_3_1, var_3_2, var_3_3 = self._proxy:GetTotalBounds()
	local var_3_4 = Vector3(var_3_2, 0, var_3_1)
	local var_3_5 = Vector3(var_3_3, 0, var_3_0)

	self._shipTree = pg.ColliderTree.New("shipTree", var_3_4, var_3_5, 2)
	self._foeShipTree = pg.ColliderTree.New("foeShipTree", var_3_4, var_3_5, 2)
	self._aircraftTree = pg.ColliderTree.New("aircraftTree", var_3_4, var_3_5, 2)
	self._surfaceBulletTree = pg.ColliderTree.New("surfaceBullets", var_3_4, var_3_5, 4)
	self._airBulletTree = pg.ColliderTree.New("airBullets", var_3_4, var_3_5, 3)
	self._bulletTreeList = {}
	self._bulletTreeList[var_0_1.BulletField.SURFACE] = self._surfaceBulletTree
	self._bulletTreeList[var_0_1.BulletField.AIR] = self._airBulletTree
	self._foeSurafceBulletTree = pg.ColliderTree.New("foeSurfaceBullets", var_3_4, var_3_5, 3)
	self._foeAirbulletTree = pg.ColliderTree.New("foeAirBullets", var_3_4, var_3_5, 3)
	self._foeBulleetTreeList = {}
	self._foeBulleetTreeList[var_0_1.BulletField.SURFACE] = self._foeSurafceBulletTree
	self._foeBulleetTreeList[var_0_1.BulletField.AIR] = self._foeAirbulletTree
	self._surfaceAOETree = pg.ColliderTree.New("surfaceAOE", var_3_4, var_3_5, 2)
	self._airAOETree = pg.ColliderTree.New("airAOE", var_3_4, var_3_5, 2)
	self._bulletAOETree = pg.ColliderTree.New("bulletAOE", var_3_4, var_3_5, 2)
	self._AOETreeList = {}
	self._AOETreeList[var_0_1.AOEField.SURFACE] = self._surfaceAOETree
	self._AOETreeList[var_0_1.AOEField.AIR] = self._airAOETree
	self._AOETreeList[var_0_1.AOEField.BULLET] = self._bulletAOETree
	self._wallTree = pg.ColliderTree.New("wall", var_3_4, var_3_5, 2)

	return
end

function BattleCldSystem:UpdateShipCldTree(arg_4_1)
	local var_4_0 = arg_4_1:GetSpeed()
	local var_4_1 = arg_4_1:GetCldBox()
	local var_4_2
	local var_4_3 = not var_0_5.IsUnitCldImmune(arg_4_1)

	if arg_4_1:GetIFF() == self._foeCode then
		if var_4_3 then
			if arg_4_1:GetCldData().FriendlyCld then
				local var_4_4 = self._foeShipTree:GetCldList(var_4_1, var_4_0)

				arg_4_1:GetCldData().distList = {}

				if #var_4_4 > 1 then
					self:HandleEnemyShipCld(var_4_4, arg_4_1)
				end
			end

			local var_4_5 = self._shipTree:GetCldList(var_4_1, var_4_0)

			self._proxy:HandleShipCrashDecelerate(arg_4_1, (self.surfaceFilterCount(arg_4_1, var_4_5)))
			self:HandlePlayerShipCld(var_4_5, arg_4_1)
		end

		var_4_2 = self._foeShipTree
	elseif arg_4_1:GetIFF() == self._friendlyCode then
		if var_4_3 then
			self._proxy:HandleShipCrashDecelerate(arg_4_1, (self.surfaceFilterCount(arg_4_1, (self._foeShipTree:GetCldList(var_4_1, var_4_0)))))
		end

		var_4_2 = self._shipTree
	end

	var_4_2:Update(var_4_1)

	return
end

function BattleCldSystem:HandlePlayerShipCld(arg_5_1, arg_5_2)
	local var_5_0 = arg_5_2:GetCldData()
	local var_5_1

	if var_5_0.Active == false or var_5_0.ImmuneCLD == true then
		do return end

		var_5_1 = {}
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
			var_5_1[#var_5_1 + 1] = arg_5_1[iter_5_0].data.UID
		end
	end

	self._proxy:HandleShipCrashDamageList(arg_5_2, var_5_1)

	return
end

function BattleCldSystem:HandleEnemyShipCld(arg_6_1, arg_6_2)
	local var_6_0 = arg_6_2:GetCldData()

	if var_6_0.Active == false or var_6_0.ImmuneCLD == true then
		return
	end

	local var_6_1 = arg_6_2:GetPosition()
	local var_6_2 = {}

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
			var_6_2[#var_6_2 + 1] = var_6_1 - self:GetShip(arg_6_1[iter_6_0].data.UID):GetPosition()
		end
	end

	var_6_0.distList = var_6_2

	return
end

function BattleCldSystem:surfaceFilterCount(arg_7_1)
	local var_7_0 = self:GetCldData()
	local var_7_1 = 0

	for iter_7_0 = 1, #arg_7_1 do
		if arg_7_1[iter_7_0].data.Active == true and arg_7_1[iter_7_0].data.ImmuneCLD == false and arg_7_1[iter_7_0].data.UID ~= self:GetUniqueID() and var_7_0.IFF ~= arg_7_1[iter_7_0].data.IFF and var_7_0.Surface == arg_7_1[iter_7_0].data.Surface then
			var_7_1 = var_7_1 + 1
		end
	end

	return var_7_1
end

function BattleCldSystem:UpdateAircraftCld(arg_8_1)
	local var_8_0 = arg_8_1:GetSpeed()
	local var_8_1 = arg_8_1:GetCldBox()
	local var_8_2

	if arg_8_1:GetIFF() == self._foeCode then
		var_8_2 = self:GetBulletTree(var_0_1.BulletField.AIR)
	elseif arg_8_1:GetIFF() == self._friendlyCode then
		var_8_2 = self:GetFoeBulletTree(var_0_1.BulletField.AIR)
	end

	self:HandleBulletCldWithAircraft(var_8_2:GetCldList(var_8_1, var_8_0), arg_8_1)
	self._aircraftTree:Update(arg_8_1:GetCldBox())

	return
end

function BattleCldSystem:HandleBulletCldWithAircraft(arg_9_1, arg_9_2)
	for iter_9_0 = 1, #arg_9_1 do
		if arg_9_1[iter_9_0].data.type == var_0_1.CldType.BULLET and arg_9_1[iter_9_0].data.Active == true and arg_9_1[iter_9_0].data.ImmuneCLD == false then
			self._proxy:HandleBulletHit(self:GetBullet(arg_9_1[iter_9_0].data.UID), arg_9_2)
		end
	end

	return
end

function BattleCldSystem:UpdateBulletCld(arg_10_1)
	local var_10_0 = arg_10_1:GetEffectField()
	local var_10_1 = arg_10_1:GetCldBox()
	local var_10_2 = arg_10_1:GetCldData().IFF

	if var_10_0 == var_0_1.BulletField.SURFACE then
		local var_10_4 = self:getBulletCldShipList(arg_10_1, var_10_2 == self._foeCode and self._shipTree or self._foeShipTree)

		if arg_10_1:IsIndiscriminate() then
			for iter_10_0, iter_10_1 in ipairs((self:getBulletCldShipList(arg_10_1, (nil == self._shipTree or nil) and (self._foeShipTree or self._shipTree)))) do
				table.insert(var_10_4, iter_10_1)
			end
		end

		self:HandleBulletCldWithShip(var_10_4, arg_10_1)
	end

	local var_10_5 = var_10_2 == self._friendlyCode and self:GetBulletTree(var_10_0) or (var_10_2 ~= self._foeCode or true) and nil

	self:GetFoeBulletTree(var_10_0):Update(var_10_1)

	return
end

function BattleCldSystem:getBulletCldShipList(arg_11_1, arg_11_2)
	local var_11_0 = arg_11_1:GetCldBox()
	local var_11_1

	if arg_11_1:GetType() == var_0_1.BulletType.SCALE then
		local var_11_2, var_11_3, var_11_4 = arg_11_1:GetRadian()

		if math.abs(var_11_3) ~= 1 then
			if arg_11_1:GetIFF() == -1 then
				var_11_2 = var_11_2 + math.pi
			end

			local var_11_5 = arg_11_1:GetBoxSize()
			local var_11_6 = arg_11_1:GetPosition()

			var_11_1 = arg_11_2:GetCldListGradient(var_11_2, var_11_5.z * 2, var_11_5.x * 2, (Vector3(var_11_6.x + var_11_5.x * var_11_3, 1, var_11_6.z + var_11_5.x * var_11_4)))
		else
			var_11_1 = arg_11_2:GetCldList(var_11_0, var_0_2)
		end
	else
		var_11_1 = arg_11_2:GetCldList(var_11_0, var_0_2)
	end

	return var_11_1
end

function BattleCldSystem:HandleBulletCldWithShip(arg_12_1, arg_12_2)
	local var_12_0 = arg_12_2:GetType()

	for iter_12_0 = 1, #arg_12_1 do
		if arg_12_1[iter_12_0].data.type == var_0_1.CldType.SHIP and arg_12_1[iter_12_0].data.Active == true and arg_12_1[iter_12_0].data.ImmuneCLD == false then
			local var_12_1 = self:GetShip(arg_12_1[iter_12_0].data.UID)
			local var_12_2 = var_12_1:IsImmuneCommonBulletCLD()

			if var_12_1:GetCurrentOxyState() == var_0_3.DIVE and arg_12_2:GetCldData().Surface ~= var_0_1.OXY_STATE.DIVE then
				-- block empty
			elseif var_12_2 then
				-- block empty
			elseif self._proxy:HandleBulletHit(arg_12_2, var_12_1) then
				break
			end
		end
	end

	return
end

function BattleCldSystem:UpdateAOECld(arg_13_1)
	local var_13_0 = arg_13_1:GetCldBox()
	local var_13_1 = arg_13_1:GetFieldType()
	local var_13_2 = arg_13_1:GetCldData().IFF
	local var_13_3

	if arg_13_1:OpponentAffected() then
		var_13_3 = var_13_2 * -1 or var_13_2
	end

	if var_13_1 == var_0_1.AOEField.SURFACE then
		local var_13_5

		if arg_13_1:OpponentAffected() == (arg_13_1:GetCldData().IFF == self._foeCode) then
			var_13_5 = self._shipTree or self._foeShipTree
		end

		local var_13_6 = self:getAreaCldShipList(arg_13_1, var_13_5)

		if arg_13_1:GetIndiscriminate() then
			for iter_13_0, iter_13_1 in ipairs((self:getAreaCldShipList(arg_13_1, (var_13_5 == self._shipTree or nil) and (self._foeShipTree or self._shipTree)))) do
				table.insert(var_13_6, iter_13_1)
			end
		end

		self:HandleAreaCldWithVehicle(arg_13_1, var_13_6)
	elseif var_13_1 == var_0_1.AOEField.BULLET then
		local var_13_8 = (var_13_3 == self._foeCode and self._foeSurafceBulletTree or self._surfaceBulletTree):GetCldList(var_13_0, var_0_2)

		arg_13_1:ClearCLDList()
		self:HandleAreaCldWithBullet(arg_13_1, var_13_8)
	else
		local var_13_9 = {}

		for iter_13_2, iter_13_3 in ipairs((self._aircraftTree:GetCldList(var_13_0, var_0_2))) do
			if iter_13_3.data.IFF == var_13_3 then
				table.insert(var_13_9, iter_13_3)
			end
		end

		self:HandleAreaCldWithAircraft(arg_13_1, var_13_9)
	end

	return
end

function BattleCldSystem:getAreaCldShipList(arg_14_1, arg_14_2)
	local var_14_0
	local var_14_1 = arg_14_1:GetAreaType()

	if var_14_1 == var_0_1.AreaType.COLUMN or arg_14_1:GetAnchorPointAlignment() == Vector3.zero then
		var_14_0 = arg_14_2:GetCldList(arg_14_1:GetCldBox(), var_0_2)
	elseif var_14_1 == var_0_1.AreaType.ELLIPSE then
		var_14_0 = arg_14_2:GetCldListEllipse(arg_14_1:GetWidth(), arg_14_1:GetHeight(), pos)
	else
		local var_14_2 = arg_14_1:GetAngle() * math.deg2Rad

		if arg_14_1:GetCldData().IFF == self._foeCode then
			var_14_2 = var_14_2 + math.pi
		end

		var_14_0 = arg_14_2:GetCldListGradient(var_14_2, arg_14_1:GetHeight(), arg_14_1:GetWidth(), (arg_14_1:GetPosition()))
	end

	return var_14_0
end

function BattleCldSystem:HandleAreaCldWithVehicle(arg_15_1, arg_15_2)
	arg_15_1:ClearCLDList()

	local var_15_0 = arg_15_1:GetCldData()
	local var_15_1 = arg_15_1:OpponentAffected()

	for iter_15_0 = 1, #arg_15_2 do
		if arg_15_2[iter_15_0].data.Active == true and arg_15_2[iter_15_0].data.ImmuneCLD == false then
			local var_15_2 = arg_15_1:GetDiveFilter()
			local var_15_3 = self:GetShip(arg_15_2[iter_15_0].data.UID)

			if not (var_15_2 and table.contains(var_15_2, (var_15_3:GetCurrentOxyState()))) and not arg_15_1:IsOutOfAngle(var_15_3) then
				arg_15_1:AppendCldObj(arg_15_2[iter_15_0].data)
			end
		end
	end

	return
end

function BattleCldSystem:HandleAreaCldWithAircraft(arg_16_1, arg_16_2)
	arg_16_1:ClearCLDList()

	local var_16_0 = arg_16_1:GetCldData()
	local var_16_1 = arg_16_1:OpponentAffected()

	for iter_16_0 = 1, #arg_16_2 do
		if var_16_1 == (arg_16_2[iter_16_0].data.IFF ~= var_16_0.IFF) then
			arg_16_1:AppendCldObj(arg_16_2[iter_16_0].data)
		end
	end

	return
end

function BattleCldSystem:HandleAreaCldWithBullet(arg_17_1, arg_17_2)
	for iter_17_0 = 1, #arg_17_2 do
		arg_17_1:AppendCldObj(arg_17_2[iter_17_0].data)
	end

	return
end

function BattleCldSystem:UpdateWallCld(arg_18_1)
	local var_18_0 = arg_18_1:GetCldBox()
	local var_18_1 = arg_18_1:GetCldObjType()

	if var_18_1 == arg_18_1.CLD_OBJ_TYPE_BULLET then
		self:HandleWallCldWithBullet(arg_18_1, arg_18_1:GetIFF() == self._friendlyCode and self._foeSurafceBulletTree:GetCldList(var_18_0, var_0_2) or self._surfaceBulletTree:GetCldList(var_18_0, var_0_2))
	elseif var_18_1 == arg_18_1.CLD_OBJ_TYPE_SHIP then
		self:HandleWllCldWithShip(arg_18_1, arg_18_1:GetIFF() == self._friendlyCode and self._foeShipTree:GetCldList(var_18_0, var_0_2) or self._shipTree:GetCldList(var_18_0, var_0_2))
	end

	return
end

function BattleCldSystem:HandleWallCldWithBullet(arg_19_1, arg_19_2)
	for iter_19_0 = 1, #arg_19_2 do
		if arg_19_2[iter_19_0].data.type == var_0_1.CldType.BULLET and arg_19_2[iter_19_0].data.Active == true and arg_19_2[iter_19_0].data.ImmuneCLD == false and not self._proxy:HandleWallHitByBullet(arg_19_1, (self:GetBullet(arg_19_2[iter_19_0].data.UID))) then
			return
		end
	end

	return
end

function BattleCldSystem:HandleWllCldWithShip(arg_20_1, arg_20_2)
	local var_20_0 = {}

	for iter_20_0 = 1, #arg_20_2 do
		if arg_20_2[iter_20_0].data.type == var_0_1.CldType.SHIP and arg_20_2[iter_20_0].data.Active == true and arg_20_2[iter_20_0].data.ImmuneCLD == false then
			local var_20_1 = self:GetShip(arg_20_2[iter_20_0].data.UID)

			if var_20_1:GetCurrentOxyState() == var_0_3.DIVE then
				-- block empty
			else
				table.insert(var_20_0, var_20_1)
			end
		end
	end

	self._proxy:HandleWallHitByShip(arg_20_1, var_20_0)

	return
end

function BattleCldSystem:InsertToBulletCldTree(arg_21_1, arg_21_2)
	local var_21_0 = arg_21_2:GetCldData()
	local var_21_1 = var_21_0.IFF == self._foeCode and self:GetFoeBulletTree(arg_21_1) or (var_21_0.IFF ~= self._friendlyCode or true) and nil

	self:GetBulletTree(arg_21_1):Insert((arg_21_2:GetCldBox()))

	return
end

function BattleCldSystem:InsertToAOECldTree(arg_22_1, arg_22_2)
	self:GetAOETree(arg_22_1):Insert((arg_22_2:GetCldBox()))

	return
end

function BattleCldSystem:InsertToWallCldTree(arg_23_1)
	self:GetWallTree():Insert((arg_23_1:GetCldBox()))

	return
end

function BattleCldSystem:InsertToShipCldTree(arg_24_1)
	local var_24_0 = arg_24_1:GetCldData()
	local var_24_1 = var_24_0.IFF == self._foeCode and self:GetFoeShipTree() or (var_24_0.IFF ~= self._friendlyCode or true) and nil

	self:GetShipTree():Insert((arg_24_1:GetCldBox()))

	return
end

function BattleCldSystem:InsertToAircraftCldTree(arg_25_1)
	self._aircraftTree:Insert((arg_25_1:GetCldBox()))

	return
end

function BattleCldSystem:GetBulletTree(arg_26_1)
	return self._bulletTreeList[arg_26_1]
end

function BattleCldSystem:GetFoeBulletTree(arg_27_1)
	return self._foeBulleetTreeList[arg_27_1]
end

function BattleCldSystem:GetAOETree(arg_28_1)
	return self._AOETreeList[arg_28_1]
end

function BattleCldSystem:GetWallTree(arg_29_1)
	return self._wallTree
end

function BattleCldSystem:GetShipTree()
	return self._shipTree
end

function BattleCldSystem:GetFoeShipTree()
	return self._foeShipTree
end

function BattleCldSystem:GetAircraftTree()
	return self._aircraftTree
end

function BattleCldSystem:DeleteShipLeaf(arg_33_1)
	local var_33_0 = arg_33_1:GetCldData().IFF

	if var_33_0 == self._foeCode then
		self.DeleteCldLeaf(self:GetFoeShipTree(), arg_33_1)
	elseif var_33_0 == self._friendlyCode then
		self.DeleteCldLeaf(self:GetShipTree(), arg_33_1)
	end

	return
end

function BattleCldSystem:DeleteBulletLeaf(arg_34_1)
	local var_34_0 = arg_34_1:GetCldData().IFF

	if var_34_0 == self._foeCode then
		self.DeleteCldLeaf(self:GetFoeBulletTree(arg_34_1:GetEffectField()), arg_34_1)
	elseif var_34_0 == self._friendlyCode then
		self.DeleteCldLeaf(self:GetBulletTree(arg_34_1:GetEffectField()), arg_34_1)
	end

	return
end

function BattleCldSystem:DeleteCldLeaf(arg_35_1)
	self:Remove((arg_35_1:GetCldBox()))

	return
end

function BattleCldSystem:GetShip(arg_36_1)
	return self._proxy:GetUnitList()[arg_36_1]
end

function BattleCldSystem:GetAircraft(arg_37_1)
	return self._proxy:GetAircraftList()[arg_37_1]
end

function BattleCldSystem:GetBullet(arg_38_1)
	return self._proxy:GetBulletList()[arg_38_1]
end

function BattleCldSystem:GetAOE(arg_39_1)
	return self._proxy:GetAOEList()[arg_39_1]
end

function BattleCldSystem:InitShipCld(arg_40_1)
	self:InsertToShipCldTree(arg_40_1)

	return
end

function BattleCldSystem:DeleteShipCld(arg_41_1)
	arg_41_1:DeactiveCldBox()
	self:DeleteShipLeaf(arg_41_1)

	return
end

function BattleCldSystem:InitAircraftCld(arg_42_1)
	self:InsertToAircraftCldTree(arg_42_1)

	return
end

function BattleCldSystem:DeleteAircraftCld(arg_43_1)
	arg_43_1:DeactiveCldBox()
	self.DeleteCldLeaf(self:GetAircraftTree(), arg_43_1)

	return
end

function BattleCldSystem:InitBulletCld(arg_44_1)
	self:InsertToBulletCldTree(arg_44_1:GetEffectField(), arg_44_1)

	return
end

function BattleCldSystem:DeleteBulletCld(arg_45_1)
	arg_45_1:DeactiveCldBox()
	self:DeleteBulletLeaf(arg_45_1)

	return
end

function BattleCldSystem:ShiftBulletCld(arg_46_1)
	return
end

function BattleCldSystem:InitAOECld(arg_47_1)
	self:InsertToAOECldTree(arg_47_1:GetFieldType(), arg_47_1)

	return
end

function BattleCldSystem:DeleteAOECld(arg_48_1)
	arg_48_1:DeactiveCldBox()
	self.DeleteCldLeaf(self:GetAOETree(arg_48_1:GetFieldType()), arg_48_1)

	return
end

function BattleCldSystem:InitWallCld(arg_49_1)
	self:InsertToWallCldTree(arg_49_1)

	return
end

function BattleCldSystem:DeleteWallCld(arg_50_1)
	arg_50_1:DeactiveCldBox()

	local var_50_0 = self:GetWallTree()

	if var_50_0 then
		self.DeleteCldLeaf(var_50_0, arg_50_1)
	end

	return
end

return
