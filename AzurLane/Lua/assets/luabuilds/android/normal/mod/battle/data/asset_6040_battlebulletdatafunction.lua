ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst

pg = var_0_10002

local var_0_2 = var_0_10002.bullet_template

pg = var_0_10003

local var_0_3 = var_0_10003.barrage_template
local var_0_4 = var_0.Battle
local var_0_5

if not var_0.Battle.BattleDataFunction then
	var_0_5 = {}
end

var_0_4.BattleDataFunction = var_0_5

local var_0_6 = var_0.Battle.BattleDataFunction
local var_0_7 = var_0_1.UnitDir.LEFT
local var_0_8 = var_0_1.UnitDir.RIGHT

function var_0_6.CreateBattleBulletData(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	local var_1_0 = var_0_6.GetBulletTmpDataFromID(arg_1_1).type

	if var_5.extra_param.currentdrop then
		arg_1_4 = arg_1_2:GetPosition()
	end

	local var_1_1, var_1_2 = var_0_6.generateBulletFuncs[var_1_0](arg_1_0, var_5, arg_1_2, arg_1_3, arg_1_4)

	var_1_1:SetTemplateData(var_5)
	var_1_1:SetAttr(arg_1_2._attr)
	var_1_1:SetBuffTrigger(arg_1_2)
	var_1_1:SetWeapon(arg_1_3)

	if arg_1_3 and arg_1_3:GetStandHost() then
		local var_1_3 = arg_1_3:GetStandHost()
		local var_1_4 = var_9.GetAttr(var_1_3)

		var_1_1:SetStandHostAttr(var_1_4)
	end

	if var_1_1:IsIngoreCld() ~= nil then
		local var_1_5 = not var_9

		var_1_1:SetIsCld(var_1_5)

		var_1_2 = var_1_5
	end

	return var_1_1, var_1_2
end

function var_0_6.GetBulletTmpDataFromID(arg_2_0)
	assert = var_1_10001

	var_1_10001(var_0_2[arg_2_0] ~= nil, "找不到子弹配置：id = " .. arg_2_0)

	return var_0_2[arg_2_0]
end

function var_0_6.GetBarrageTmpDataFromID(arg_3_0)
	assert = var_1_10001

	var_1_10001(var_0_3[arg_3_0] ~= nil, "找不到弹幕配置：id = " .. arg_3_0)

	return var_0_3[arg_3_0]
end

function var_0_6.GetConvertedBarrageTableFromID(arg_4_0, arg_4_1)
	assert = var_1_10002

	var_1_10002(var_0_3[arg_4_0] ~= nil, "获取转换弹幕数据失败，找不到弹幕原型配置：id = " .. arg_4_0)

	if var_0_6.ConvertedBarrageTableList[arg_4_0] == nil or var_0_6.ConvertedBarrageTableList[arg_4_0][arg_4_1] == nil then
		var_0_6.ConvertSpecificBarrage(arg_4_0, arg_4_1)
	end

	return var_0_6.ConvertedBarrageTableList[arg_4_0]
end

function var_0_6.GenerateTransBarrage(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = {}
	local var_5_1 = var_0_6.GetBarrageTmpDataFromID(arg_5_0)

	while var_5_1.trans_ID ~= -1 do
		local var_5_2 = var_5_1.trans_ID

		var_5_1 = var_0_6.GetBarrageTmpDataFromID(var_5_2)

		local var_5_3 = {
			transStartDelay = var_5_1.first_delay + var_5_1.delay * arg_5_2 + var_5_1.delta_delay * arg_5_2
		}

		if var_5_1.offset_prioritise then
			var_5_3.transAimPosX = var_5_1.offset_x + var_5_1.delta_offset_x * arg_5_2
			var_5_3.transAimPosZ = var_5_1.offset_z + var_5_1.delta_offset_z * arg_5_2
		else
			var_5_3.transAimAngle = var_5_1.angle + var_5_1.delta_angle * arg_5_2

			if arg_5_1 == -1 then
				var_5_3.transAimAngle = var_5_3.transAimAngle + 180
			end
		end

		var_5_0[#var_5_0 + 1] = var_5_3
	end

	return var_5_0
end

function var_0_6._createCannonBullet(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0 = var_0.Battle.BattleCannonBulletUnit.New(arg_6_0, arg_6_2:GetIFF())

	var_5.SetIsCld(var_6_0, true)

	return var_5, true
end

function var_0_6._createBombBullet(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = var_0.Battle.BattleBombBulletUnit.New(arg_7_0, arg_7_2:GetIFF())

	var_5.SetAttr(var_7_0, arg_7_2._attr)
	var_5:SetTemplateData(arg_7_1)

	if arg_7_4:EqualZero() then
		local var_7_1 = arg_7_2:GetPosition()

		arg_7_4 = var_6.Clone(var_7_1)

		local var_7_2 = arg_7_3:GetTemplateData().range

		if arg_7_2:GetDirection() == var_0_1.UnitDir.RIGHT then
			arg_7_4.x = arg_7_4.x + var_7_2
		else
			arg_7_4.x = arg_7_4.x - var_7_2
		end
	end

	var_5:SetExplodePosition(arg_7_4)
	var_5:SetIsCld(false)

	return var_5, false
end

function var_0_6._createStrayBullet(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0 = var_0.Battle.BattleStrayBulletUnit.New(arg_8_0, arg_8_2:GetIFF())

	var_5.SetIsCld(var_8_0, true)

	return var_5, true
end

function var_0_6._createTorpedoBullet(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = var_0.Battle.BattleTorpedoBulletUnit.New(arg_9_0, arg_9_2:GetIFF())

	var_5.SetExplodePosition(var_9_0, arg_9_4)
	var_5:SetIsCld(true)

	return var_5, true
end

function var_0_6._createDirectBullet(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	local var_10_0 = var_0.Battle.BattleAntiAirBulletUnit.New(arg_10_0, arg_10_2:GetIFF())

	var_5.SetIsCld(var_10_0, false)

	return var_5, false
end

function var_0_6._createAntiAirBullet(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0 = var_0.Battle.BattleAntiAirBulletUnit.New(arg_11_0, arg_11_2:GetIFF())

	var_5.SetIsCld(var_11_0, false)

	return var_5, false
end

function var_0_6._createAntiSeaBullet(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = var_0.Battle.BattleAntiSeaBulletUnit.New(arg_12_0, arg_12_2:GetIFF())

	var_5.SetIsCld(var_12_0, false)

	return var_5, false
end

function var_0_6._createSharpnelBullet(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = var_0.Battle.BattleShrapnelBulletUnit.New(arg_13_0, arg_13_2:GetIFF())

	var_5.SetExplodePosition(var_13_0, arg_13_4)
	var_5:SetSrcHost(arg_13_2)
	var_5:SetIsCld(true)

	return var_5, true
end

function var_0_6._createEffectBullet(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	local var_14_0 = var_0.Battle.BattleEffectBulletUnit.New(arg_14_0, arg_14_2:GetIFF())

	var_5.SetTemplateData(var_14_0, arg_14_1)
	var_5:SetIsCld(false)
	var_5:SetImmuneCLS(true)

	if arg_14_1.attach_buff[1].flare then
		var_5:spawnArea(true)
	end

	return var_5, false
end

function var_0_6._createBeamBullet(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_0 = var_0.Battle.BattleAntiAirBulletUnit.New(arg_15_0, arg_15_2:GetIFF())

	var_5.SetIsCld(var_15_0, false)

	return var_5, false
end

function var_0_6._createGravitationBullet(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0 = var_0.Battle.BattleGravitationBulletUnit.New(arg_16_0, arg_16_2:GetIFF())

	var_5.SetExplodePosition(var_16_0, arg_16_4)
	var_5:SetIsCld(true)
	var_5:SetImmuneCLS(true)

	return var_5, true
end

function var_0_6._createMissile(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0 = var_0.Battle.BattleMissileUnit.New(arg_17_0, arg_17_2:GetIFF())

	var_5.SetAttr(var_17_0, arg_17_2._attr)
	var_5:SetTemplateData(arg_17_1)
	var_5:SetImmuneCLS(true)
	var_5:SetIsCld(false)

	return var_5, false
end

function var_0_6._createSpaceLaser(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	local var_18_0 = var_0.Battle.BattleSpaceLaserUnit.New(arg_18_0, arg_18_2:GetIFF())

	var_5.SetIsCld(var_18_0, true)
	var_5:SetImmuneCLS(true)

	return var_5, true
end

function var_0_6._createScaleBullet(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	local var_19_0 = var_0.Battle.BattleScaleBulletUnit.New(arg_19_0, arg_19_2:GetIFF())

	var_5.SetIsCld(var_19_0, true)

	return var_5, true
end

function var_0_6._createAAMissile(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	local var_20_0 = var_0.Battle.BattleTrackingAAMissileUnit.New(arg_20_0, arg_20_2:GetIFF())

	var_5.SetIsCld(var_20_0, true)

	return var_5, true
end

var_0_6.generateBulletFuncs = {}
var_0_6.generateBulletFuncs[var_0_1.BulletType.CANNON] = var_0_6._createCannonBullet
var_0_6.generateBulletFuncs[var_0_1.BulletType.BOMB] = var_0_6._createBombBullet
var_0_6.generateBulletFuncs[var_0_1.BulletType.TORPEDO] = var_0_6._createTorpedoBullet
var_0_6.generateBulletFuncs[var_0_1.BulletType.DIRECT] = var_0_6._createDirectBullet
var_0_6.generateBulletFuncs[var_0_1.BulletType.ANTI_AIR] = var_0_6._createAntiAirBullet
var_0_6.generateBulletFuncs[var_0_1.BulletType.ANTI_SEA] = var_0_6._createAntiSeaBullet
var_0_6.generateBulletFuncs[var_0_1.BulletType.SHRAPNEL] = var_0_6._createSharpnelBullet
var_0_6.generateBulletFuncs[var_0_1.BulletType.STRAY] = var_0_6._createStrayBullet
var_0_6.generateBulletFuncs[var_0_1.BulletType.EFFECT] = var_0_6._createEffectBullet
var_0_6.generateBulletFuncs[var_0_1.BulletType.BEAM] = var_0_6._createBeamBullet
var_0_6.generateBulletFuncs[var_0_1.BulletType.G_BULLET] = var_0_6._createGravitationBullet
var_0_6.generateBulletFuncs[var_0_1.BulletType.ELECTRIC_ARC] = var_0_6._createDirectBullet
var_0_6.generateBulletFuncs[var_0_1.BulletType.MISSILE] = var_0_6._createMissile
var_0_6.generateBulletFuncs[var_0_1.BulletType.SPACE_LASER] = var_0_6._createSpaceLaser
var_0_6.generateBulletFuncs[var_0_1.BulletType.SCALE] = var_0_6._createScaleBullet
var_0_6.generateBulletFuncs[var_0_1.BulletType.TRIGGER_BOMB] = var_0_6._createBombBullet
var_0_6.generateBulletFuncs[var_0_1.BulletType.AAMissile] = var_0_6._createAAMissile

function var_0_6.ConvertSpecificBarrage(arg_21_0, arg_21_1)
	local var_21_0 = var_0_6.barrageInteration

	pg = var_1_10003

	local var_21_1 = var_21_0(var_1_10003.barrage_template[arg_21_0], arg_21_1)
	local var_21_2

	if not var_0_6.ConvertedBarrageTableList[arg_21_0] then
		var_21_2 = {}
	end

	var_21_2[arg_21_1] = var_21_1
	var_0_6.ConvertedBarrageTableList[arg_21_0] = var_21_2

	return
end

function var_0_6.ClearConvertedBarrage()
	var_0_6.ConvertedBarrageTableList = {}

	return
end

function var_0_6.barrageInteration(arg_23_0, arg_23_1)
	local var_23_0 = 1
	local var_23_1 = arg_23_0.primal_repeat
	local var_23_2 = {}
	local var_23_3 = arg_23_0.offset_x
	local var_23_4 = arg_23_0.offset_z
	local var_23_5 = arg_23_0.angle
	local var_23_6 = arg_23_0.delay
	local var_23_7 = arg_23_0.delta_offset_x
	local var_23_8 = arg_23_0.delta_offset_z
	local var_23_9 = arg_23_0.delta_angle
	local var_23_10 = arg_23_0.delta_delay

	for iter_23_0 = 0, var_23_1 do
		local var_23_11 = {
			OffsetX = var_23_3 * arg_23_1,
			OffsetZ = var_23_4,
			Angle = var_23_5,
			Delay = var_23_6
		}

		table = var_18

		var_18.insert(var_23_2, var_23_11)

		var_23_3 = var_23_3 + var_23_7
		var_23_4 = var_23_4 + var_23_8
		var_23_5 = var_23_5 + var_23_9
		var_23_6 = var_23_6 + var_23_10
	end

	return var_23_2
end

var_0_6.ClearConvertedBarrage()

return
