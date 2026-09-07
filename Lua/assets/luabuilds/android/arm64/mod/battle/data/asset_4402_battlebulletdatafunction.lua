ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConst
local var_0_2 = pg.bullet_template
local var_0_3 = pg.barrage_template

ys.Battle.BattleDataFunction = ys.Battle.BattleDataFunction or {}

local var_0_4 = ys.Battle.BattleDataFunction

function ys.Battle.BattleDataFunction.CreateBattleBulletData(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	local var_1_0 = var_0_4.GetBulletTmpDataFromID(arg_1_1)

	if var_1_0.extra_param.currentdrop then
		arg_1_4 = arg_1_2:GetPosition()
	end

	local var_1_1, var_1_2 = var_0_4.generateBulletFuncs[var_1_0.type](arg_1_0, var_1_0, arg_1_2, arg_1_3, arg_1_4)

	var_1_1:SetTemplateData(var_1_0)
	var_1_1:SetAttr(arg_1_2._attr)
	var_1_1:SetBuffTrigger(arg_1_2)
	var_1_1:SetWeapon(arg_1_3)

	if arg_1_3 and arg_1_3:GetStandHost() then
		var_1_1:SetStandHostAttr((arg_1_3:GetStandHost():GetAttr()))
	end

	local var_1_3 = var_1_1:IsIngoreCld()

	if var_1_3 ~= nil then
		var_1_1:SetIsCld(not var_1_3)

		var_1_2 = not var_1_3
	end

	return var_1_1, var_1_2
end

function ys.Battle.BattleDataFunction.GetBulletTmpDataFromID(arg_2_0)
	assert(var_0_2[arg_2_0] ~= nil, "找不到子弹配置：id = " .. arg_2_0)

	return var_0_2[arg_2_0]
end

function ys.Battle.BattleDataFunction.GetBarrageTmpDataFromID(arg_3_0)
	assert(var_0_3[arg_3_0] ~= nil, "找不到弹幕配置：id = " .. arg_3_0)

	return var_0_3[arg_3_0]
end

function ys.Battle.BattleDataFunction.GetConvertedBarrageTableFromID(arg_4_0, arg_4_1)
	assert(var_0_3[arg_4_0] ~= nil, "获取转换弹幕数据失败，找不到弹幕原型配置：id = " .. arg_4_0)

	if var_0_4.ConvertedBarrageTableList[arg_4_0] == nil or var_0_4.ConvertedBarrageTableList[arg_4_0][arg_4_1] == nil then
		var_0_4.ConvertSpecificBarrage(arg_4_0, arg_4_1)
	end

	return var_0_4.ConvertedBarrageTableList[arg_4_0]
end

function ys.Battle.BattleDataFunction.GenerateTransBarrage(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = {}
	local var_5_1 = var_0_4.GetBarrageTmpDataFromID(arg_5_0)

	while var_5_1.trans_ID ~= -1 do
		var_5_1 = var_0_4.GetBarrageTmpDataFromID(var_5_1.trans_ID)

		local var_5_2 = {
			transStartDelay = var_5_1.first_delay + var_5_1.delay * arg_5_2 + var_5_1.delta_delay * arg_5_2
		}

		if var_5_1.offset_prioritise then
			var_5_2.transAimPosX = var_5_1.offset_x + var_5_1.delta_offset_x * arg_5_2
			var_5_2.transAimPosZ = var_5_1.offset_z + var_5_1.delta_offset_z * arg_5_2
		else
			var_5_2.transAimAngle = var_5_1.angle + var_5_1.delta_angle * arg_5_2

			if arg_5_1 == -1 then
				var_5_2.transAimAngle = var_5_2.transAimAngle + 180
			end
		end

		var_5_0[#var_5_0 + 1] = var_5_2
	end

	return var_5_0
end

function ys.Battle.BattleDataFunction._createCannonBullet(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0 = var_0_0.Battle.BattleCannonBulletUnit.New(arg_6_0, arg_6_2:GetIFF())

	var_6_0:SetIsCld(true)

	return var_6_0, true
end

function ys.Battle.BattleDataFunction._createBombBullet(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = var_0_0.Battle.BattleBombBulletUnit.New(arg_7_0, arg_7_2:GetIFF())

	var_7_0:SetAttr(arg_7_2._attr)
	var_7_0:SetTemplateData(arg_7_1)

	if arg_7_4:EqualZero() then
		arg_7_4 = arg_7_2:GetPosition():Clone()

		local var_7_1 = arg_7_3:GetTemplateData().range

		arg_7_4.x = arg_7_2:GetDirection() == var_0_1.UnitDir.RIGHT and arg_7_4.x + var_7_1 or arg_7_4.x - var_7_1
	end

	var_7_0:SetExplodePosition(arg_7_4)
	var_7_0:SetIsCld(false)

	return var_7_0, false
end

function ys.Battle.BattleDataFunction._createStrayBullet(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0 = var_0_0.Battle.BattleStrayBulletUnit.New(arg_8_0, arg_8_2:GetIFF())

	var_8_0:SetIsCld(true)

	return var_8_0, true
end

function ys.Battle.BattleDataFunction._createTorpedoBullet(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = var_0_0.Battle.BattleTorpedoBulletUnit.New(arg_9_0, arg_9_2:GetIFF())

	var_9_0:SetExplodePosition(arg_9_4)
	var_9_0:SetIsCld(true)

	return var_9_0, true
end

function ys.Battle.BattleDataFunction._createDirectBullet(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	local var_10_0 = var_0_0.Battle.BattleAntiAirBulletUnit.New(arg_10_0, arg_10_2:GetIFF())

	var_10_0:SetIsCld(false)

	return var_10_0, false
end

function ys.Battle.BattleDataFunction._createAntiAirBullet(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0 = var_0_0.Battle.BattleAntiAirBulletUnit.New(arg_11_0, arg_11_2:GetIFF())

	var_11_0:SetIsCld(false)

	return var_11_0, false
end

function ys.Battle.BattleDataFunction._createAntiSeaBullet(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = var_0_0.Battle.BattleAntiSeaBulletUnit.New(arg_12_0, arg_12_2:GetIFF())

	var_12_0:SetIsCld(false)

	return var_12_0, false
end

function ys.Battle.BattleDataFunction._createSharpnelBullet(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = var_0_0.Battle.BattleShrapnelBulletUnit.New(arg_13_0, arg_13_2:GetIFF())

	var_13_0:SetExplodePosition(arg_13_4)
	var_13_0:SetSrcHost(arg_13_2)
	var_13_0:SetIsCld(true)

	return var_13_0, true
end

function ys.Battle.BattleDataFunction._createEffectBullet(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	local var_14_0 = var_0_0.Battle.BattleEffectBulletUnit.New(arg_14_0, arg_14_2:GetIFF())

	var_14_0:SetTemplateData(arg_14_1)
	var_14_0:SetIsCld(false)
	var_14_0:SetImmuneCLS(true)

	if arg_14_1.attach_buff[1].flare then
		var_14_0:spawnArea(true)
	end

	return var_14_0, false
end

function ys.Battle.BattleDataFunction._createBeamBullet(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_0 = var_0_0.Battle.BattleAntiAirBulletUnit.New(arg_15_0, arg_15_2:GetIFF())

	var_15_0:SetIsCld(false)

	return var_15_0, false
end

function ys.Battle.BattleDataFunction._createGravitationBullet(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0 = var_0_0.Battle.BattleGravitationBulletUnit.New(arg_16_0, arg_16_2:GetIFF())

	var_16_0:SetExplodePosition(arg_16_4)
	var_16_0:SetIsCld(true)
	var_16_0:SetImmuneCLS(true)

	return var_16_0, true
end

function ys.Battle.BattleDataFunction._createMissile(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0 = var_0_0.Battle.BattleMissileUnit.New(arg_17_0, arg_17_2:GetIFF())

	var_17_0:SetAttr(arg_17_2._attr)
	var_17_0:SetTemplateData(arg_17_1)
	var_17_0:SetImmuneCLS(true)
	var_17_0:SetIsCld(false)

	return var_17_0, false
end

function ys.Battle.BattleDataFunction._createSpaceLaser(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	local var_18_0 = var_0_0.Battle.BattleSpaceLaserUnit.New(arg_18_0, arg_18_2:GetIFF())

	var_18_0:SetIsCld(true)
	var_18_0:SetImmuneCLS(true)

	return var_18_0, true
end

function ys.Battle.BattleDataFunction._createScaleBullet(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	local var_19_0 = var_0_0.Battle.BattleScaleBulletUnit.New(arg_19_0, arg_19_2:GetIFF())

	var_19_0:SetIsCld(true)

	return var_19_0, true
end

function ys.Battle.BattleDataFunction._createAAMissile(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	local var_20_0 = var_0_0.Battle.BattleTrackingAAMissileUnit.New(arg_20_0, arg_20_2:GetIFF())

	var_20_0:SetIsCld(true)

	return var_20_0, true
end

ys.Battle.BattleDataFunction.generateBulletFuncs = {}
ys.Battle.BattleDataFunction.generateBulletFuncs[ys.Battle.BattleConst.BulletType.CANNON] = ys.Battle.BattleDataFunction._createCannonBullet
ys.Battle.BattleDataFunction.generateBulletFuncs[ys.Battle.BattleConst.BulletType.BOMB] = ys.Battle.BattleDataFunction._createBombBullet
ys.Battle.BattleDataFunction.generateBulletFuncs[ys.Battle.BattleConst.BulletType.TORPEDO] = ys.Battle.BattleDataFunction._createTorpedoBullet
ys.Battle.BattleDataFunction.generateBulletFuncs[ys.Battle.BattleConst.BulletType.DIRECT] = ys.Battle.BattleDataFunction._createDirectBullet
ys.Battle.BattleDataFunction.generateBulletFuncs[ys.Battle.BattleConst.BulletType.ANTI_AIR] = ys.Battle.BattleDataFunction._createAntiAirBullet
ys.Battle.BattleDataFunction.generateBulletFuncs[ys.Battle.BattleConst.BulletType.ANTI_SEA] = ys.Battle.BattleDataFunction._createAntiSeaBullet
ys.Battle.BattleDataFunction.generateBulletFuncs[ys.Battle.BattleConst.BulletType.SHRAPNEL] = ys.Battle.BattleDataFunction._createSharpnelBullet
ys.Battle.BattleDataFunction.generateBulletFuncs[ys.Battle.BattleConst.BulletType.STRAY] = ys.Battle.BattleDataFunction._createStrayBullet
ys.Battle.BattleDataFunction.generateBulletFuncs[ys.Battle.BattleConst.BulletType.EFFECT] = ys.Battle.BattleDataFunction._createEffectBullet
ys.Battle.BattleDataFunction.generateBulletFuncs[ys.Battle.BattleConst.BulletType.BEAM] = ys.Battle.BattleDataFunction._createBeamBullet
ys.Battle.BattleDataFunction.generateBulletFuncs[ys.Battle.BattleConst.BulletType.G_BULLET] = ys.Battle.BattleDataFunction._createGravitationBullet
ys.Battle.BattleDataFunction.generateBulletFuncs[ys.Battle.BattleConst.BulletType.ELECTRIC_ARC] = ys.Battle.BattleDataFunction._createDirectBullet
ys.Battle.BattleDataFunction.generateBulletFuncs[ys.Battle.BattleConst.BulletType.MISSILE] = ys.Battle.BattleDataFunction._createMissile
ys.Battle.BattleDataFunction.generateBulletFuncs[ys.Battle.BattleConst.BulletType.SPACE_LASER] = ys.Battle.BattleDataFunction._createSpaceLaser
ys.Battle.BattleDataFunction.generateBulletFuncs[ys.Battle.BattleConst.BulletType.SCALE] = ys.Battle.BattleDataFunction._createScaleBullet
ys.Battle.BattleDataFunction.generateBulletFuncs[ys.Battle.BattleConst.BulletType.TRIGGER_BOMB] = ys.Battle.BattleDataFunction._createBombBullet
ys.Battle.BattleDataFunction.generateBulletFuncs[ys.Battle.BattleConst.BulletType.AAMissile] = ys.Battle.BattleDataFunction._createAAMissile

function ys.Battle.BattleDataFunction.ConvertSpecificBarrage(arg_21_0, arg_21_1)
	local var_21_0 = var_0_4.ConvertedBarrageTableList[arg_21_0] or {}

	var_21_0[arg_21_1] = var_0_4.barrageInteration(pg.barrage_template[arg_21_0], arg_21_1)
	var_0_4.ConvertedBarrageTableList[arg_21_0] = var_21_0

	return
end

function ys.Battle.BattleDataFunction.ClearConvertedBarrage()
	var_0_4.ConvertedBarrageTableList = {}

	return
end

function ys.Battle.BattleDataFunction:barrageInteration(arg_23_1)
	local var_23_1 = {}

	for iter_23_0 = 0, self.primal_repeat do
		table.insert(var_23_1, {
			OffsetX = self.offset_x * arg_23_1,
			OffsetZ = self.offset_z,
			Angle = self.angle,
			Delay = self.delay
		})
	end

	return var_23_1
end

ys.Battle.BattleDataFunction.ClearConvertedBarrage()

return
