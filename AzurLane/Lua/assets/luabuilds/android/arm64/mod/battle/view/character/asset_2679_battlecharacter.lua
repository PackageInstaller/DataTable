ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleUnitEvent
local var_0_2 = var_0.Battle.BattleBuffEvent
local var_0_3 = var_0.Battle.BattleConst
local var_0_4 = var_0.Battle.BattleConfig
local var_0_5 = var_0.Battle.BattleResourceManager
local var_0_6 = var_0.Battle.BattleFormulas

class = var_0_10007

local var_0_7 = var_0_10007("BattleCharacter", var_0.Battle.BattleSceneObject)

var_0.Battle.BattleCharacter = var_0_7
var_0_7.__name = "BattleCharacter"
Vector2 = var_8

local var_0_8 = var_8(-1200, -1200)

Vector3 = var_9

local var_0_9 = var_9.New(0.3, -1.8, 0)

Vector3 = var_10
var_0_7.AIM_OFFSET = var_10.New(0, -3.5, 0)

function var_0_7.Ctor(arg_1_0)
	var_0_7.super.Ctor(arg_1_0)
	arg_1_0:Init()

	return
end

function var_0_7.Init(arg_2_0)
	var_0.EventListener.AttachEventListener(arg_2_0)
	arg_2_0:InitBulletFactory()
	arg_2_0:InitEffectView()

	arg_2_0._tagFXList = {}
	arg_2_0._cacheFXList = {}
	arg_2_0._allFX = {}
	arg_2_0._bulletCache = {}
	arg_2_0._weaponRegisterList = {}
	Vector3 = var_1
	arg_2_0._characterPos = var_1.zero
	arg_2_0._orbitCount = 0
	arg_2_0._orbitList = {}
	arg_2_0._orbitSpineOrderOffset = 0
	arg_2_0._orbitActionCacheList = {}
	arg_2_0._orbitSpeedUpdateList = {}
	arg_2_0._orbitActionUpdateList = {}
	arg_2_0._inViewArea = false
	arg_2_0._alwaysHideArrow = false
	arg_2_0._hideHP = false
	Vector3 = var_1
	arg_2_0._referenceVector = var_1.zero
	Vector3 = var_1
	arg_2_0._referenceVectorCache = var_1.zero
	Vector3 = var_1
	arg_2_0._referenceVectorTemp = var_1.zero
	arg_2_0._referenceUpdateFlag = false
	arg_2_0._referenceVectorBorn = nil
	Vector3 = var_1
	arg_2_0._hpBarPos = var_1.zero
	Vector3 = var_1
	arg_2_0._arrowVector = var_1.zero
	Vector3 = var_1
	arg_2_0._arrowAngleVector = var_1.zero
	arg_2_0._blinkDict = {}
	arg_2_0._coverSpineHPBarOffset = 0
	arg_2_0._shaderType = nil
	arg_2_0._color = nil
	arg_2_0._actionIndex = nil

	return
end

function var_0_7.InitBulletFactory(arg_3_0)
	arg_3_0._bulletFactoryList = var_0.Battle.BattleBulletFactory.GetFactoryList()

	return
end

function var_0_7.SetUnitData(arg_4_0, arg_4_1)
	arg_4_0._unitData = arg_4_1

	arg_4_0:AddUnitEvent()

	return
end

function var_0_7.SetBoneList(arg_5_0)
	arg_5_0._boneList = {}
	arg_5_0._remoteBoneTable = {}
	arg_5_0._bonePosTable = nil
	arg_5_0._posMatrix = nil

	local var_5_0 = arg_5_0:GetInitScale()

	pairs = var_1_10002

	local var_5_1 = arg_5_0._unitData

	for iter_5_0, iter_5_1 in var_1_10002(var_4.GetTemplate(var_5_1).bound_bone) do
		if iter_5_0 ~= "remote" then
			arg_5_0:insertBondList(iter_5_0, iter_5_1)
		end
	end

	pairs = var_2

	for iter_5_2, iter_5_3 in var_2(var_0_4.CommonBone) do
		arg_5_0:insertBondList(iter_5_2, iter_5_3)
	end

	return
end

function var_0_7.insertBondList(arg_6_0, arg_6_1, arg_6_2)
	ipairs = var_1_10003

	for iter_6_0, iter_6_1 in var_1_10003(arg_6_2) do
		type = var_1_10008

		if var_1_10008(iter_6_1) == "table" then
			local var_6_0 = #{} + 1

			Vector3 = var_10
			var_1_10008[var_6_0] = var_10(iter_6_1[1], iter_6_1[2], iter_6_1[3])
			arg_6_0._boneList[arg_6_1] = var_1_10008
		end
	end

	return
end

function var_0_7.SpawnBullet(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = arg_7_0._bulletFactoryList[arg_7_1:GetTemplate().type]
	local var_7_1 = arg_7_0._unitData
	local var_7_2 = var_6.GetRemoteBoundBone(var_7_1, arg_7_2)
	local var_7_3 = arg_7_4 or var_7_2 or arg_7_0:GetBonePos(arg_7_2)
	local var_7_4 = var_7_0
	local var_7_5 = var_7_0.CreateBullet
	local var_7_6 = arg_7_0._tf
	local var_7_7 = arg_7_1
	local var_7_8 = var_7_3
	local var_7_9 = arg_7_3
	local var_7_10 = arg_7_0._unitData

	var_7_5(var_7_4, var_7_6, var_7_7, var_7_8, var_7_9, var_15.GetDirection(var_7_10))

	return
end

function var_0_7.GetBonePos(arg_8_0, arg_8_1)
	if arg_8_0._boneList[arg_8_1] == nil or #var_8_0 == 0 then
		pairs = var_1_10003

		for iter_8_0, iter_8_1 in var_1_10003(arg_8_0._boneList) do
			local var_8_0 = iter_8_1

			break
		end
	end

	local var_8_1

	if not arg_8_0._posMatrix then
		arg_8_0._posMatrix = arg_8_0._tf.localToWorldMatrix
		arg_8_0._bonePosTable = {}
	else
		var_8_1 = arg_8_0._posMatrix
	end

	local var_8_2

	if arg_8_0._bonePosTable[arg_8_1] == nil then
		var_8_2 = {}
		ipairs = var_1_10005

		for iter_8_2, iter_8_3 in var_1_10005(var_8_0) do
			var_8_2[#var_8_2 + 1] = var_8_1:MultiplyPoint3x4(iter_8_3)
		end

		arg_8_0._bonePosTable[arg_8_1] = var_8_2
	end

	if #var_8_2 == 1 then
		return var_8_2[1]
	else
		math = var_5

		local var_8_3 = var_5.floor

		math = iter_8_1

		return var_8_2[var_8_3(iter_8_1.Random(0, #var_8_2)) + 1]
	end

	return
end

function var_0_7.GetBoneList(arg_9_0)
	return arg_9_0._boneList
end

function var_0_7.AddFXOffsets(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._FXAttachPoint = arg_10_1
	arg_10_0._FXOffset = arg_10_2

	return
end

function var_0_7.GetFXOffsets(arg_11_0, arg_11_1)
	arg_11_1 = arg_11_1 or 1

	return arg_11_0._FXOffset[arg_11_1]
end

function var_0_7.GetAttachPoint(arg_12_0)
	return arg_12_0._FXAttachPoint
end

function var_0_7.GetSpecificFXScale(arg_13_0)
	return {}
end

function var_0_7.PlayFX(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:GetFactory()
	local var_14_1 = var_2.GetFXPool(var_14_0)
	local var_14_2 = var_2.GetFX(var_14_1, arg_14_1)

	pg = var_1_10003

	local var_14_3 = var_1_10003.EffectMgr.GetInstance()

	var_3.PlayBattleEffect(var_14_3, var_14_2, arg_14_0:GetPosition(), true)

	return
end

function var_0_7.AddFX(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_0 = arg_15_0:GetFactory()
	local var_15_1 = var_5.GetFXPool(var_15_0)
	local var_15_2 = var_5.GetCharacterFX(var_15_1, arg_15_1, arg_15_0, not arg_15_2, function(arg_16_0)
		if arg_15_4 then
			arg_15_4()
		end

		arg_15_0._allFX[arg_16_0] = nil

		return
	end, arg_15_3)

	if arg_15_2 then
		local var_15_3

		if not arg_15_0._cacheFXList[arg_15_1] then
			var_15_3 = {}
		end

		table = var_15_1

		var_15_1.insert(var_15_3, var_15_2)

		arg_15_0._cacheFXList[arg_15_1] = var_15_3
	end

	arg_15_0._allFX[var_15_2] = true

	return var_15_2
end

function var_0_7.RemoveFX(arg_17_0, arg_17_1)
	if arg_17_0._allFX and arg_17_0._allFX[arg_17_1] then
		arg_17_0._allFX[arg_17_1] = nil

		local var_17_0 = var_0_5.GetInstance()

		var_2.DestroyOb(var_17_0, arg_17_1)
	end

	return
end

function var_0_7.RemoveCacheFX(arg_18_0, arg_18_1)
	if arg_18_0._cacheFXList[arg_18_1] ~= nil and #var_2 > 0 then
		table = var_3

		local var_18_0 = var_3.remove(var_2)

		arg_18_0._allFX[var_18_0] = nil

		local var_18_1 = var_0_5.GetInstance()

		var_4.DestroyOb(var_18_1, var_18_0)
	end

	return
end

function var_0_7.AddWaveFX(arg_19_0, arg_19_1)
	arg_19_0._waveFX = arg_19_0:AddFX(arg_19_1)

	return
end

function var_0_7.RemoveWaveFX(arg_20_0)
	if not arg_20_0._waveFX then
		return
	end

	arg_20_0:RemoveFX(arg_20_0._waveFX)

	return
end

function var_0_7.onAddBuffClock(arg_21_0, arg_21_1)
	if arg_21_1.Data.isActive then
		if not arg_21_0._buffClock then
			local var_21_0 = arg_21_0._factory

			var_3.MakeBuffClock(var_21_0, arg_21_0)
		end

		local var_21_1 = arg_21_0._buffClock

		var_3.Casting(var_21_1, var_2)
	else
		local var_21_2 = arg_21_0._buffClock

		var_3.Interrupt(var_21_2, var_2)
	end

	return
end

function var_0_7.AddBlink(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5, arg_22_6, arg_22_7)
	local var_22_0 = arg_22_0._unitData

	if var_8.GetDiveInvisible(var_22_0) then
		return nil
	end

	local var_22_1 = arg_22_0._unitData

	if not var_8.GetExposed(var_22_1) then
		return nil
	end

	arg_22_4 = arg_22_4 or 0.1
	arg_22_5 = arg_22_5 or 0.1
	arg_22_6 = arg_22_6 or false
	arg_22_7 = arg_22_7 or 0.18
	SpineAnim = var_8

	local var_22_2 = var_8.CharBlink(arg_22_0._go, arg_22_1, arg_22_2, arg_22_3, arg_22_7, arg_22_4, arg_22_5, arg_22_6)

	if not arg_22_6 then
		arg_22_0._blinkDict[var_22_2] = {
			r = arg_22_1,
			g = arg_22_2,
			b = arg_22_3,
			a = arg_22_7,
			peroid = arg_22_4,
			duration = arg_22_5
		}
	end

	return var_22_2
end

function var_0_7.RemoveBlink(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0._blinkDict

	var_23_0[arg_23_1] = nil
	SpineAnim = var_23_0

	var_23_0.RemoveBlink(arg_23_0._go, arg_23_1)

	return
end

function var_0_7.AddShaderColor(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0._unitData

	if not var_2.GetExposed(var_24_0) then
		return
	end

	if not arg_24_1 then
		Color = var_2
		arg_24_1 = var_2.New(0, 0, 0, 0)
	end

	SpineAnim = var_2

	var_2.AddShaderColor(arg_24_0._go, arg_24_1)

	return
end

function var_0_7.GetPosition(arg_25_0)
	return arg_25_0._characterPos
end

function var_0_7.GetUnitData(arg_26_0)
	return arg_26_0._unitData
end

function var_0_7.GetDestroyFXID(arg_27_0)
	local var_27_0 = arg_27_0:GetUnitData()

	return var_1.GetTemplate(var_27_0).bomb_fx
end

function var_0_7.GetOffsetPos(arg_28_0)
	BuildVector3 = var_1_10001

	local var_28_0 = arg_28_0._unitData

	return (var_1_10001(var_3.GetTemplate(var_28_0).position_offset))
end

function var_0_7.GetReferenceVector(arg_29_0, arg_29_1)
	if arg_29_1 == nil then
		return arg_29_0._referenceVector
	else
		local var_29_0 = arg_29_0._referenceVectorTemp

		var_2.Set(var_29_0, arg_29_0._characterPos.x, arg_29_0._characterPos.y, arg_29_0._characterPos.z)

		local var_29_1 = arg_29_0._referenceVectorTemp

		var_2.Sub(var_29_1, arg_29_1)
		var_0.Battle.BattleVariable.CameraPosToUICameraByRef(arg_29_0._referenceVectorTemp)

		arg_29_0._referenceVectorTemp.z = 2

		return arg_29_0._referenceVectorTemp
	end

	return
end

function var_0_7.GetInitScale(arg_30_0)
	local var_30_0 = arg_30_0._unitData

	return var_1.GetAttrByName(var_30_0, "modelScale")
end

function var_0_7.AddUnitEvent(arg_31_0)
	local var_31_0 = arg_31_0._unitData

	var_1.RegisterEventListener(var_31_0, arg_31_0, var_0_1.SPAWN_CACHE_BULLET, arg_31_0.onSpawnCacheBullet)

	local var_31_1 = arg_31_0._unitData

	var_1.RegisterEventListener(var_31_1, arg_31_0, var_0_1.CREATE_TEMPORARY_WEAPON, arg_31_0.onNewWeapon)

	local var_31_2 = arg_31_0._unitData

	var_1.RegisterEventListener(var_31_2, arg_31_0, var_0_1.POP_UP, arg_31_0.onPopup)

	local var_31_3 = arg_31_0._unitData

	var_1.RegisterEventListener(var_31_3, arg_31_0, var_0_1.VOICE, arg_31_0.onVoice)

	local var_31_4 = arg_31_0._unitData

	var_1.RegisterEventListener(var_31_4, arg_31_0, var_0_1.PLAY_FX, arg_31_0.onPlayFX)

	local var_31_5 = arg_31_0._unitData

	var_1.RegisterEventListener(var_31_5, arg_31_0, var_0_1.REMOVE_WEAPON, arg_31_0.onRemoveWeapon)

	local var_31_6 = arg_31_0._unitData

	var_1.RegisterEventListener(var_31_6, arg_31_0, var_0_1.ADD_BLINK, arg_31_0.onBlink)

	local var_31_7 = arg_31_0._unitData

	var_1.RegisterEventListener(var_31_7, arg_31_0, var_0_1.SUBMARINE_VISIBLE, arg_31_0.onUpdateDiveInvisible)

	local var_31_8 = arg_31_0._unitData

	var_1.RegisterEventListener(var_31_8, arg_31_0, var_0_1.SUBMARINE_DETECTED, arg_31_0.onDetected)

	local var_31_9 = arg_31_0._unitData

	var_1.RegisterEventListener(var_31_9, arg_31_0, var_0_1.SUBMARINE_FORCE_DETECTED, arg_31_0.onForceDetected)

	local var_31_10 = arg_31_0._unitData

	var_1.RegisterEventListener(var_31_10, arg_31_0, var_0_1.BLIND_VISIBLE, arg_31_0.onUpdateBlindInvisible)

	local var_31_11 = arg_31_0._unitData

	var_1.RegisterEventListener(var_31_11, arg_31_0, var_0_1.BLIND_EXPOSE, arg_31_0.onBlindExposed)

	local var_31_12 = arg_31_0._unitData

	var_1.RegisterEventListener(var_31_12, arg_31_0, var_0_1.INIT_ANIT_SUB_VIGILANCE, arg_31_0.onInitVigilantState)

	local var_31_13 = arg_31_0._unitData

	var_1.RegisterEventListener(var_31_13, arg_31_0, var_0_1.INIT_CLOAK, arg_31_0.onInitCloak)

	local var_31_14 = arg_31_0._unitData

	var_1.RegisterEventListener(var_31_14, arg_31_0, var_0_1.UPDATE_CLOAK_CONFIG, arg_31_0.onUpdateCloakConfig)

	local var_31_15 = arg_31_0._unitData

	var_1.RegisterEventListener(var_31_15, arg_31_0, var_0_1.UPDATE_CLOAK_LOCK, arg_31_0.onUpdateCloakLock)

	local var_31_16 = arg_31_0._unitData

	var_1.RegisterEventListener(var_31_16, arg_31_0, var_0_1.INIT_AIMBIAS, arg_31_0.onInitAimBias)

	local var_31_17 = arg_31_0._unitData

	var_1.RegisterEventListener(var_31_17, arg_31_0, var_0_1.UPDATE_AIMBIAS_LOCK, arg_31_0.onUpdateAimBiasLock)

	local var_31_18 = arg_31_0._unitData

	var_1.RegisterEventListener(var_31_18, arg_31_0, var_0_1.HOST_AIMBIAS, arg_31_0.onHostAimBias)

	local var_31_19 = arg_31_0._unitData

	var_1.RegisterEventListener(var_31_19, arg_31_0, var_0_1.REMOVE_AIMBIAS, arg_31_0.onRemoveAimBias)

	local var_31_20 = arg_31_0._unitData

	var_1.RegisterEventListener(var_31_20, arg_31_0, var_0_1.HIDE_WAVE_FX, arg_31_0.RemoveWaveFX)

	local var_31_21 = arg_31_0._unitData

	var_1.RegisterEventListener(var_31_21, arg_31_0, var_0_1.ADD_BUFF_CLOCK, arg_31_0.onAddBuffClock)

	local var_31_22 = arg_31_0._unitData

	var_1.RegisterEventListener(var_31_22, arg_31_0, var_0_1.SWITCH_SPINE, arg_31_0.onSwitchSpine)

	local var_31_23 = arg_31_0._unitData

	var_1.RegisterEventListener(var_31_23, arg_31_0, var_0_1.SWITCH_SHADER, arg_31_0.onSwitchShader)

	local var_31_24 = arg_31_0._unitData

	var_1.RegisterEventListener(var_31_24, arg_31_0, var_0_1.UPDATE_SCORE, arg_31_0.onUpdateScore)

	local var_31_25 = arg_31_0._unitData

	var_1.RegisterEventListener(var_31_25, arg_31_0, var_0_2.BUFF_EFFECT_CHNAGE_SIZE, arg_31_0.onChangeSize)

	local var_31_26 = arg_31_0._unitData

	var_1.RegisterEventListener(var_31_26, arg_31_0, var_0_2.BUFF_EFFECT_NEW_WEAPON, arg_31_0.onNewWeapon)

	local var_31_27 = arg_31_0._unitData

	var_1.RegisterEventListener(var_31_27, arg_31_0, var_0_2.BUFF_EFFECT_RECOIL_SHIELD, arg_31_0.onRecoilShield)

	local var_31_28 = arg_31_0._unitData
	local var_31_29 = var_1.GetAutoWeapons(var_31_28)

	ipairs = var_1_10002

	for iter_31_0, iter_31_1 in var_1_10002(var_31_29) do
		arg_31_0:RegisterWeaponListener(iter_31_1)
	end

	local var_31_30 = arg_31_0._effectOb

	var_2.SetUnitDataEvent(var_31_30, arg_31_0._unitData)

	return
end

function var_0_7.RemoveUnitEvent(arg_32_0)
	local var_32_0 = arg_32_0._unitData

	var_1.UnregisterEventListener(var_32_0, arg_32_0, var_0_1.UPDATE_HP)

	local var_32_1 = arg_32_0._unitData

	var_1.UnregisterEventListener(var_32_1, arg_32_0, var_0_1.CREATE_TEMPORARY_WEAPON)

	local var_32_2 = arg_32_0._unitData

	var_1.UnregisterEventListener(var_32_2, arg_32_0, var_0_1.CHANGE_ACTION)

	local var_32_3 = arg_32_0._unitData

	var_1.UnregisterEventListener(var_32_3, arg_32_0, var_0_1.SPAWN_CACHE_BULLET)

	local var_32_4 = arg_32_0._unitData

	var_1.UnregisterEventListener(var_32_4, arg_32_0, var_0_1.POP_UP)

	local var_32_5 = arg_32_0._unitData

	var_1.UnregisterEventListener(var_32_5, arg_32_0, var_0_1.VOICE)

	local var_32_6 = arg_32_0._unitData

	var_1.UnregisterEventListener(var_32_6, arg_32_0, var_0_1.PLAY_FX)

	local var_32_7 = arg_32_0._unitData

	var_1.UnregisterEventListener(var_32_7, arg_32_0, var_0_1.REMOVE_WEAPON)

	local var_32_8 = arg_32_0._unitData

	var_1.UnregisterEventListener(var_32_8, arg_32_0, var_0_1.ADD_BLINK)

	local var_32_9 = arg_32_0._unitData

	var_1.UnregisterEventListener(var_32_9, arg_32_0, var_0_1.SUBMARINE_VISIBLE)

	local var_32_10 = arg_32_0._unitData

	var_1.UnregisterEventListener(var_32_10, arg_32_0, var_0_1.SUBMARINE_DETECTED)

	local var_32_11 = arg_32_0._unitData

	var_1.UnregisterEventListener(var_32_11, arg_32_0, var_0_1.SUBMARINE_FORCE_DETECTED)

	local var_32_12 = arg_32_0._unitData

	var_1.UnregisterEventListener(var_32_12, arg_32_0, var_0_1.BLIND_VISIBLE)

	local var_32_13 = arg_32_0._unitData

	var_1.UnregisterEventListener(var_32_13, arg_32_0, var_0_1.BLIND_EXPOSE)

	local var_32_14 = arg_32_0._unitData

	var_1.UnregisterEventListener(var_32_14, arg_32_0, var_0_1.UPDATE_SCORE)

	local var_32_15 = arg_32_0._unitData

	var_1.UnregisterEventListener(var_32_15, arg_32_0, var_0_1.CHANGE_ANTI_SUB_VIGILANCE)

	local var_32_16 = arg_32_0._unitData

	var_1.UnregisterEventListener(var_32_16, arg_32_0, var_0_1.INIT_ANIT_SUB_VIGILANCE)

	local var_32_17 = arg_32_0._unitData

	var_1.UnregisterEventListener(var_32_17, arg_32_0, var_0_1.ANTI_SUB_VIGILANCE_SONAR_CHECK)

	local var_32_18 = arg_32_0._unitData

	var_1.UnregisterEventListener(var_32_18, arg_32_0, var_0_1.UPDATE_CLOAK_CONFIG)

	local var_32_19 = arg_32_0._unitData

	var_1.UnregisterEventListener(var_32_19, arg_32_0, var_0_1.UPDATE_CLOAK_LOCK)

	local var_32_20 = arg_32_0._unitData

	var_1.UnregisterEventListener(var_32_20, arg_32_0, var_0_1.INIT_CLOAK)

	local var_32_21 = arg_32_0._unitData

	var_1.UnregisterEventListener(var_32_21, arg_32_0, var_0_1.HOST_AIMBIAS)

	local var_32_22 = arg_32_0._unitData

	var_1.UnregisterEventListener(var_32_22, arg_32_0, var_0_1.UPDATE_AIMBIAS_LOCK)

	local var_32_23 = arg_32_0._unitData

	var_1.UnregisterEventListener(var_32_23, arg_32_0, var_0_1.INIT_AIMBIAS)

	local var_32_24 = arg_32_0._unitData

	var_1.UnregisterEventListener(var_32_24, arg_32_0, var_0_1.REMOVE_AIMBIAS)

	local var_32_25 = arg_32_0._unitData

	var_1.UnregisterEventListener(var_32_25, arg_32_0, var_0_1.ADD_BUFF_CLOCK)

	local var_32_26 = arg_32_0._unitData

	var_1.UnregisterEventListener(var_32_26, arg_32_0, var_0_1.SWITCH_SPINE)

	local var_32_27 = arg_32_0._unitData

	var_1.UnregisterEventListener(var_32_27, arg_32_0, var_0_1.SWITCH_SHADER)

	local var_32_28 = arg_32_0._unitData

	var_1.UnregisterEventListener(var_32_28, arg_32_0, var_0_2.BUFF_EFFECT_CHNAGE_SIZE)

	local var_32_29 = arg_32_0._unitData

	var_1.UnregisterEventListener(var_32_29, arg_32_0, var_0_2.BUFF_EFFECT_NEW_WEAPON)

	local var_32_30 = arg_32_0._unitData

	var_1.UnregisterEventListener(var_32_30, arg_32_0, var_0_2.BUFF_EFFECT_RECOIL_SHIELD)

	pairs = var_1

	for iter_32_0, iter_32_1 in var_1(arg_32_0._weaponRegisterList) do
		arg_32_0:UnregisterWeaponListener(iter_32_0)
	end

	return
end

function var_0_7.Update(arg_33_0)
	pg = var_1_10001

	local var_33_0 = var_1_10001.TimeMgr.GetInstance()
	local var_33_1 = var_1.GetCombatTime(var_33_0)

	arg_33_0._bonePosSet = nil

	arg_33_0:UpdateUIComponentPosition()
	arg_33_0:UpdateHPPop()
	arg_33_0:UpdateAniEffect(var_33_1)
	arg_33_0:UpdateTagEffect(var_33_1)

	if arg_33_0._referenceUpdateFlag then
		arg_33_0:UpdateHPBarPosition()
		arg_33_0:UpdateHPPopContainerPosition()
	end

	arg_33_0:UpdateChatPosition()
	arg_33_0:UpdateHpBar()
	arg_33_0:updateSomkeFX()
	arg_33_0:UpdateAimBiasBar()
	arg_33_0:UpdateShieldBar()
	arg_33_0:UpdateBuffClock()
	arg_33_0:UpdateOrbit()

	return
end

function var_0_7.RegisterWeaponListener(arg_34_0, arg_34_1)
	if arg_34_0._weaponRegisterList[arg_34_1] then
		return
	end

	arg_34_1:RegisterEventListener(arg_34_0, var_0_1.CREATE_BULLET, arg_34_0.onCreateBullet)
	arg_34_1:RegisterEventListener(arg_34_0, var_0_1.FIRE, arg_34_0.onCannonFire)

	arg_34_0._weaponRegisterList[arg_34_1] = true

	return
end

function var_0_7.UnregisterWeaponListener(arg_35_0, arg_35_1)
	arg_35_0._weaponRegisterList[arg_35_1] = nil

	arg_35_1:UnregisterEventListener(arg_35_0, var_0_1.CREATE_BULLET)
	arg_35_1:UnregisterEventListener(arg_35_0, var_0_1.FIRE)

	return
end

function var_0_7.onCreateBullet(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_1.Data.bullet
	local var_36_1 = arg_36_1.Data.spawnBound
	local var_36_2 = arg_36_1.Data.fireFxID
	local var_36_3 = arg_36_1.Data.position

	arg_36_0:SpawnBullet(var_36_0, var_36_1, var_36_2, var_36_3)

	return
end

function var_0_7.onCannonFire(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_1.Dispatcher
	local var_37_1 = arg_37_1.Data.target
	local var_37_2

	if not arg_37_1.Data.actionIndex then
		var_37_2 = "attack"
	end

	local var_37_3 = arg_37_0._unitData
	local var_37_4 = var_5.NeedWeaponCache(var_37_3)
	local var_37_5

	if not var_37_4 then
		if arg_37_0._cacheWeapon == nil then
			var_37_5 = false
		else
			var_37_5 = true
		end
	else
		arg_37_0._cacheWeapon = {}
		var_37_5 = true

		local var_37_6 = arg_37_0._unitData

		var_7.StateChange(var_37_6, var_0.Battle.UnitState.STATE_ATTACK, var_37_2)
	end

	if var_37_5 == true then
		local var_37_7 = {
			weapon = var_37_0,
			target = var_37_1,
			weapon = var_37_0,
			target = var_37_1
		}

		arg_37_0._cacheWeapon[#arg_37_0._cacheWeapon + 1] = var_37_7
	else
		var_37_0:DoAttack(var_37_1)
	end

	return
end

function var_0_7.onSpawnCacheBullet(arg_38_0)
	if arg_38_0._cacheWeapon then
		ipairs = var_1

		for iter_38_0, iter_38_1 in var_1(arg_38_0._cacheWeapon) do
			local var_38_0 = iter_38_1.weapon

			var_6.DoAttack(var_38_0, iter_38_1.target)

			local var_38_1 = arg_38_0._unitData

			if not var_6.IsAlive(var_38_1) then
				break
			end
		end

		arg_38_0._cacheWeapon = nil
	end

	return
end

function var_0_7.onNewWeapon(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_1.Data.weapon

	arg_39_0:RegisterWeaponListener(var_39_0)

	return
end

function var_0_7.onPopup(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_1.Data.content
	local var_40_1 = var_2.duration
	local var_40_2 = var_2.key

	arg_40_0:SetPopup(var_40_0, var_40_1, var_40_2)

	return
end

function var_0_7.onVoice(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_1.Data.content
	local var_41_1 = var_2.key

	arg_41_0:Voice(var_41_0, var_41_1)

	return
end

function var_0_7.onPlayFX(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_1.Data.fxName

	if arg_42_1.Data.notAttach then
		arg_42_0:PlayFX(var_42_0)
	else
		arg_42_0:AddFX(var_42_0)
	end

	return
end

function var_0_7.onRemoveWeapon(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_1.Data.weapon

	if arg_43_0._cacheWeapon then
		ipairs = var_3

		for iter_43_0, iter_43_1 in var_3(arg_43_0._cacheWeapon) do
			if iter_43_1.weapon == var_43_0 then
				table = var_8

				var_8.remove(arg_43_0._cacheWeapon, iter_43_0)

				break
			end
		end
	end

	arg_43_0:UnregisterWeaponListener(var_43_0)

	return
end

function var_0_7.onBlink(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_1.Data.blink.red
	local var_44_1 = var_2.green
	local var_44_2 = var_2.blue
	local var_44_3 = var_2.alpha
	local var_44_4 = var_2.peroid
	local var_44_5 = var_2.duration

	arg_44_0:AddBlink(var_44_0, var_44_1, var_44_2, var_44_4, var_44_5, true, var_44_3)

	return
end

function var_0_7.onUpdateDiveInvisible(arg_45_0, arg_45_1)
	arg_45_0:UpdateDiveInvisible()

	return
end

function var_0_7.UpdateDiveInvisible(arg_46_0, arg_46_1)
	if not arg_46_0._go then
		return
	end

	local var_46_0 = arg_46_0._unitData
	local var_46_2

	if not var_2.GetForceExpose(var_46_0) then
		local var_46_1 = arg_46_0._unitData

		var_46_2 = var_2.GetDiveInvisible(var_46_1)
	else
		var_46_2 = false
	end

	if false then
		var_46_2 = true
	end

	local var_46_3 = arg_46_0._unitData
	local var_46_4 = var_3.GetIFF(var_46_3) == var_0_4.FOE_CODE

	if var_46_2 then
		local var_46_5 = arg_46_0:GetFactory()
		local var_46_6 = var_4.GetDivingFilterColor(var_46_5)

		arg_46_0:updateInvisible(var_46_2, var_46_4 and "GRID_TRANSPARENT" or "SEMI_TRANSPARENT", var_46_6)

		if not arg_46_1 and var_46_4 then
			arg_46_0:spineSemiTransparentFade(0, 0.7, 0)
		end
	else
		arg_46_0:updateInvisible(var_46_2)

		if not var_46_4 then
			arg_46_0:AddShaderColor()
		end
	end

	if var_46_4 then
		arg_46_0:updateComponentVisible()
	end

	return
end

function var_0_7.onUpdateBlindInvisible(arg_47_0, arg_47_1)
	arg_47_0:UpdateBlindInvisible()

	return
end

function var_0_7.UpdateBlindInvisible(arg_48_0)
	local var_48_0 = arg_48_0._unitData
	local var_48_1 = var_1.GetExposed(var_48_0)
	local var_48_2 = arg_48_0:GetTf()
	local var_48_3 = var_2.GetComponent

	typeof = var_1_10005
	Renderer = var_1_10007
	var_48_3(var_48_2, var_1_10005(var_1_10007)).enabled = var_48_1

	arg_48_0:updateComponentVisible()

	return
end

function var_0_7.updateInvisible(arg_49_0, arg_49_1, arg_49_2, arg_49_3)
	if arg_49_1 then
		arg_49_0:SwitchShader(arg_49_2, arg_49_3)

		local var_49_0 = arg_49_0._animator

		var_4.ChangeRenderQueue(var_49_0, 2999)
	else
		arg_49_0:SwitchShader("COLORED_ALPHA")

		local var_49_1 = arg_49_0._animator

		var_4.ChangeRenderQueue(var_49_1, 3000)
	end

	if arg_49_0._waveFX then
		SetActive = var_4

		var_4(arg_49_0._waveFX.transform, not arg_49_1)
	end

	return
end

function var_0_7.onDetected(arg_50_0, arg_50_1)
	if not arg_50_0._go then
		return
	end

	local var_50_0 = arg_50_0._unitData
	local var_50_2

	if var_2.GetDiveDetected(var_50_0) then
		local var_50_1 = arg_50_0._unitData

		var_50_2 = var_2.GetIFF(var_50_1) == var_0_4.FOE_CODE
	end

	if var_50_2 then
		arg_50_0._shockFX = arg_50_0:AddFX("shock", true, true)
	else
		arg_50_0:RemoveCacheFX("shock")
	end

	local var_50_3 = arg_50_0._unitData

	if var_3.GetIFF(var_50_3) == var_0_4.FOE_CODE then
		arg_50_0:UpdateCharacterDetected()
	end

	arg_50_0:updateComponentVisible()

	return
end

function var_0_7.UpdateCharacterDetected(arg_51_0)
	local var_51_0 = arg_51_0._unitData

	if var_1.GetIFF(var_51_0) ~= var_0_4.FRIENDLY_CODE then
		local var_51_1 = arg_51_0._unitData

		if var_1.GetDiveDetected(var_51_1) then
			arg_51_0:spineSemiTransparentFade(0, 0.7, var_0_4.SUB_FADE_IN_DURATION)
		else
			arg_51_0:spineSemiTransparentFade(0.7, 0, var_0_4.SUB_FADE_OUT_DURATION)
		end

		return
	end
end

function var_0_7.onForceDetected(arg_52_0, arg_52_1)
	arg_52_0:UpdateCharacterForceDetected()

	return
end

function var_0_7.UpdateCharacterForceDetected(arg_53_0)
	local var_53_0 = arg_53_0._unitData

	if var_1.GetIFF(var_53_0) == var_0_4.FOE_CODE then
		local var_53_1 = arg_53_0._unitData

		if var_1.GetForceExpose(var_53_1) then
			arg_53_0:spineSemiTransparentFade(0, 0.7, var_0_4.SUB_FADE_IN_DURATION)
			arg_53_0:updateComponentVisible()
		end
	end

	return
end

function var_0_7.onBlindExposed(arg_54_0, arg_54_1)
	local var_54_0 = arg_54_0._unitData
	local var_54_1 = var_2.GetExposed(var_54_0)
	local var_54_2 = arg_54_0:GetTf()
	local var_54_3 = var_3.GetComponent

	typeof = var_1_10006
	Renderer = var_1_10008
	var_54_3(var_54_2, var_1_10006(var_1_10008)).enabled = var_54_1

	arg_54_0:updateComponentVisible()

	return
end

function var_0_7.updateComponentVisible(arg_55_0)
	local var_55_0
	local var_55_1 = arg_55_0._unitData
	local var_55_4

	if var_2.GetIFF(var_55_1) ~= var_0_4.FOE_CODE then
		local var_55_2 = arg_55_0._unitData

		var_55_0 = var_55_4.GetAttrByName(var_55_2, var_0.Battle.BattleBuffSetBattleUnitType.ATTR_KEY) > var_0_4.FUSION_ELEMENT_UNIT_TYPE
	else
		local var_55_3 = arg_55_0._unitData

		var_55_4 = var_55_4.GetExposed(var_55_3)

		local var_55_5 = arg_55_0._unitData
		local var_55_6 = var_3.GetDiveDetected(var_55_5)
		local var_55_7 = arg_55_0._unitData
		local var_55_8 = var_4.GetDiveInvisible(var_55_7)
		local var_55_9 = arg_55_0._unitData

		var_55_0 = var_5.GetForceExpose(var_55_9) or var_55_4 and (not var_55_8 or not not var_55_6)
	end

	SetActive = var_55_4

	var_55_4(arg_55_0._arrowBarTf, var_55_0)

	SetActive = var_55_4

	var_55_4(arg_55_0._HPBarTf, var_55_0)

	SetActive = var_55_4

	var_55_4(arg_55_0._FXAttachPoint, var_55_0)

	SetActive = var_55_4

	var_55_4(arg_55_0._hpPopContainerTF, var_55_0)

	if arg_55_0._hpCloakBar then
		local var_55_10 = arg_55_0._hpCloakBar

		var_2.SetActive(var_55_10, var_55_0)
	end

	if arg_55_0._cloakBar then
		local var_55_11 = arg_55_0._cloakBar

		var_2.SetActive(var_55_11, var_55_0)
	end

	if arg_55_0._aimBiarBar then
		local var_55_12 = arg_55_0._aimBiarBar

		var_2.SetActive(var_55_12, var_55_0)
	end

	if arg_55_0._shieldBar then
		local var_55_13 = arg_55_0._shieldBar

		var_2.SetActive(var_55_13, var_55_0)
	end

	return
end

function var_0_7.updateComponentDiveInvisible(arg_56_0)
	local var_56_0 = arg_56_0._unitData
	local var_56_2

	if var_1.GetDiveDetected(var_56_0) then
		local var_56_1 = arg_56_0._unitData

		var_56_2 = var_1.GetIFF(var_56_1) == var_0_4.FOE_CODE
	end

	local var_56_3 = arg_56_0._unitData
	local var_56_4 = var_2.GetDiveInvisible(var_56_3)
	local var_56_5
	local var_56_6 = (var_56_2 or not var_56_4) and true or false

	SetActive = var_56_3

	var_56_3(arg_56_0._arrowBarTf, var_56_6)

	SetActive = var_56_3

	var_56_3(arg_56_0._HPBarTf, var_56_6)

	SetActive = var_56_3

	var_56_3(arg_56_0._FXAttachPoint, var_56_6)

	return
end

function var_0_7.updateComponentBlindInvisible(arg_57_0)
	local var_57_0 = arg_57_0._unitData
	local var_57_1 = var_1.GetExposed(var_57_0)
	local var_57_2 = arg_57_0:GetTf()
	local var_57_3 = var_2.GetComponent

	typeof = var_1_10005
	Renderer = var_1_10007

	local var_57_4 = var_57_3(var_57_2, var_1_10005(var_1_10007))

	var_57_4.enabled = var_57_1
	SetActive = var_57_4

	var_57_4(arg_57_0._arrowBarTf, var_57_1)

	SetActive = var_57_4

	var_57_4(arg_57_0._HPBarTf, var_57_1)

	SetActive = var_57_4

	var_57_4(arg_57_0._FXAttachPoint, var_57_1)

	return
end

function var_0_7.spineSemiTransparentFade(arg_58_0, arg_58_1, arg_58_2, arg_58_3)
	LeanTween = var_1_10004

	var_1_10004.cancel(arg_58_0._go)

	onDelayTick = var_4

	var_4(function()
		if not arg_58_0._go then
			return
		end

		local var_59_0

		if not arg_58_3 then
			var_59_0 = 0
		end

		arg_58_3 = var_59_0
		SpineAnim = var_59_0

		var_59_0.ShaderTransparentFade(arg_58_0._go, arg_58_2, arg_58_1, arg_58_3, "_Invisible")

		return
	end, 0.06)

	return
end

function var_0_7.onInitVigilantState(arg_60_0, arg_60_1)
	local var_60_0 = arg_60_0._factory

	var_2.MakeVigilantBar(var_60_0, arg_60_0)

	local var_60_1 = arg_60_1.Data.sonarRange * 0.5
	local var_60_2 = range
	local var_60_3 = arg_60_0
	local var_60_4 = arg_60_0.AddFX(var_60_3, "AntiSubArea", true).transform

	Vector3 = var_60_3
	range = var_6

	local var_60_5 = 0

	range = var_1_10008
	var_60_4.localScale = var_60_3(var_6, var_60_5, var_1_10008)

	local function var_60_6()
		local var_61_0 = var_60_4
		local var_61_1 = var_0.Find(var_61_0, "Quad")
		local var_61_2 = var_0.GetComponent

		typeof = var_3
		Animator = var_2_10005

		local var_61_3 = var_61_2(var_61_1, var_3(var_2_10005))

		var_61_3.enabled = true

		var_61_3:Play("antiSubZoom", -1, 0)

		return
	end

	local var_60_7 = arg_60_0._unitData

	var_5.RegisterEventListener(var_60_7, arg_60_0, var_0_1.CHANGE_ANTI_SUB_VIGILANCE, arg_60_0.onVigilantStateChange)

	local var_60_8 = arg_60_0._unitData

	var_5.RegisterEventListener(var_60_8, arg_60_0, var_0_1.ANTI_SUB_VIGILANCE_SONAR_CHECK, var_60_6)

	return
end

function var_0_7.onVigilantStateChange(arg_62_0, arg_62_1)
	arg_62_0:updateVigilantMark()

	return
end

function var_0_7.updateVigilantMark(arg_63_0)
	if arg_63_0._vigilantBar then
		local var_63_0 = arg_63_0._vigilantBar

		var_1.UpdateVigilantMark(var_63_0)
	end

	return
end

function var_0_7.OnActionChange(arg_64_0, arg_64_1)
	local var_64_0 = arg_64_1.Data.actionType

	arg_64_0:PlayAction(var_64_0)

	return
end

function var_0_7.PlayAction(arg_65_0, arg_65_1)
	local var_65_0 = arg_65_1
	local var_65_1 = false
	local var_65_2

	if arg_65_0._skeleton then
		SpineAnimUtil = var_65_2
		var_65_2 = var_65_2.GetCharAnimDirect
		var_1_10006 = arg_65_0._skeleton
		math = var_1_10007

		local var_65_3

		var_65_2, var_65_3 = var_65_2(var_1_10006, var_1_10007.sign(arg_65_0._modelScale.x), var_65_0)
		var_65_1 = var_65_3
		var_65_0 = var_65_2
	end

	if var_65_1 then
		Vector3 = var_65_2
		math = var_1_10006

		local var_65_4 = var_65_2(var_1_10006.abs(arg_65_0._modelScale.x), arg_65_0._modelScale.y, arg_65_0._modelScale.z)

		arg_65_0:setLocalScale(var_65_4, true)
	end

	local var_65_5 = arg_65_0._animator

	var_4.SetAction(var_65_5, var_65_0, 0, var_0_3.ActionLoop[arg_65_1])

	arg_65_0._actionIndex = arg_65_1

	if arg_65_1 == var_0_3.ActionName.VICTORY or arg_65_1 == var_0_3.ActionName.VICTORY_SWIM then
		local var_65_6 = arg_65_0._effectOb

		var_4.ClearEffect(var_65_6)
	end

	if #arg_65_0._orbitActionUpdateList > 0 then
		ipairs = var_4

		for iter_65_0, iter_65_1 in var_4(arg_65_0._orbitActionUpdateList) do
			local var_65_7 = iter_65_1.orbit
			local var_65_8 = iter_65_1.change.condition.param
			local var_65_9 = false

			ipairs = var_1_10013

			for iter_65_2, iter_65_3 in var_1_10013(var_65_8) do
				string = var_1_10018

				if var_1_10018.find(arg_65_1, iter_65_3) then
					var_65_9 = true

					break
				end
			end

			if var_65_9 then
				arg_65_0:changeOrbitAction(var_65_7, var_10)

				break
			end
		end
	end

	return
end

function var_0_7.SetAnimaSpeed(arg_66_0, arg_66_1)
	local var_66_1

	if not arg_66_0._skeleton then
		local var_66_0 = arg_66_0:GetTf()

		var_66_1 = var_2.GetComponent(var_66_0, "SkeletonAnimation")
	end

	arg_66_0._skeleton = var_66_1
	arg_66_1 = arg_66_1 or 1
	arg_66_0._skeleton.timeScale = arg_66_1

	return
end

function var_0_7.UpdatePosition(arg_67_0)
	if not arg_67_0._go then
		return
	end

	local var_67_0 = arg_67_0._unitData
	local var_67_1 = var_1.GetPosition(var_67_0)
	local var_67_2 = arg_67_0._unitData
	local var_67_3 = var_2.GetSpeed(var_67_2)

	Vector3 = var_67_0

	if var_67_3 == var_67_0.zero and arg_67_0._characterPos == var_67_1 then
		return
	end

	arg_67_0._characterPos = var_67_1
	arg_67_0._tf.localPosition = arg_67_0:getCharacterPos()

	return
end

function var_0_7.getCharacterPos(arg_68_0)
	return arg_68_0._characterPos
end

function var_0_7.UpdateMatrix(arg_69_0)
	arg_69_0._bonePosTable = nil
	arg_69_0._posMatrix = nil

	return
end

function var_0_7.UpdateUIComponentPosition(arg_70_0)
	local var_70_0 = arg_70_0._unitData
	local var_70_1 = var_1.GetPosition(var_70_0)
	local var_70_2 = arg_70_0._referenceVector

	var_2.Set(var_70_2, var_70_1.x, var_70_1.y, var_70_1.z)
	var_0.Battle.BattleVariable.CameraPosToUICameraByRef(arg_70_0._referenceVector)

	arg_70_0._referenceVector.z = 10

	local var_70_3 = arg_70_0._referenceVector

	arg_70_0._referenceUpdateFlag = not var_2.Equals(var_70_3, arg_70_0._referenceVectorCache)

	if arg_70_0._referenceUpdateFlag then
		local var_70_4 = arg_70_0._referenceVectorCache

		var_2.Copy(var_70_4, arg_70_0._referenceVector)
	end

	return
end

function var_0_7.UpdateHPPopContainerPosition(arg_71_0)
	arg_71_0._hpPopContainerTF.position = arg_71_0._referenceVector

	return
end

function var_0_7.UpdateHPBarPosition(arg_72_0)
	if not arg_72_0._hideHP then
		local var_72_0 = arg_72_0._hpBarPos
		local var_72_1 = var_1.Copy(var_72_0, arg_72_0._referenceVector)

		var_1.Add(var_72_1, arg_72_0._hpBarOffset)

		arg_72_0._HPBarTf.position = arg_72_0._hpBarPos
	end

	return
end

function var_0_7.SetBarHidden(arg_73_0, arg_73_1, arg_73_2)
	arg_73_0._alwaysHideArrow = arg_73_1
	arg_73_0._hideHP = arg_73_2

	if arg_73_0._arrowBar then
		if arg_73_0._alwaysHideArrow then
			arg_73_0._arrowBarTf.anchoredPosition = var_0_8
		else
			arg_73_0._arrowBarTf.position = arg_73_0._arrowVector
		end
	end

	return
end

function var_0_7.UpdateCastClockPosition(arg_74_0)
	local var_74_0 = arg_74_0._castClock

	var_1.UpdateCastClockPosition(var_74_0, arg_74_0._referenceVector)

	return
end

function var_0_7.UpdateBarrierClockPosition(arg_75_0)
	local var_75_0 = arg_75_0._barrierClock

	var_1.UpdateBarrierClockPosition(var_75_0, arg_75_0._referenceVector)

	return
end

function var_0_7.SetArrowPoint(arg_76_0)
	local var_76_0 = arg_76_0._arrowVector

	var_1.Set(var_76_0)

	arg_76_0._cameraUtil = var_0.Battle.BattleCameraUtil.GetInstance()

	local var_76_1 = arg_76_0._cameraUtil

	arg_76_0._arrowCenterPos = var_1.GetArrowCenterPos(var_76_1)

	return
end

Vector3 = var_10

local var_0_10 = var_10(-1, 1, 1)

Vector3 = var_11

local var_0_11 = var_11(1, 1, 1)

function var_0_7.UpdateArrowBarPosition(arg_77_0)
	local var_77_0 = arg_77_0._cameraUtil

	if not var_1.GetCharacterArrowBarPosition(var_77_0, arg_77_0._referenceVector, arg_77_0._arrowVector) then
		if not arg_77_0._inViewArea then
			arg_77_0._inViewArea = true
			arg_77_0._arrowBarTf.anchoredPosition = var_0_8
		end
	else
		local var_77_1 = arg_77_0._unitData
		local var_77_4

		if var_2.GetBornPosition(var_77_1) then
			local var_77_2 = arg_77_0._unitData

			if var_2 ~= var_3.GetPosition(var_77_2) then
				local var_77_3 = arg_77_0._cameraUtil

				var_77_4 = var_3.GetCharacterArrowBarPosition(var_77_3, arg_77_0._referenceVectorBorn, arg_77_0._arrowVector)
			end
		end

		arg_77_0._arrowVector = var_77_4
		arg_77_0._inViewArea = false

		if not arg_77_0._alwaysHideArrow then
			arg_77_0._arrowBarTf.position = arg_77_0._arrowVector

			if arg_77_0._arrowVector.x > 0 then
				arg_77_0._arrowBarTf.localScale = var_0_10
			else
				arg_77_0._arrowBarTf.localScale = var_0_11
			end
		end
	end

	return
end

function var_0_7.UpdateArrowBarRotation(arg_78_0)
	if arg_78_0._inViewArea then
		return
	end

	local var_78_0 = arg_78_0._arrowVector.x
	local var_78_1 = arg_78_0._arrowVector.y

	math = var_1_10003

	local var_78_2 = var_1_10003.rad2Deg

	math = var_1_10004

	local var_78_3 = var_78_2 * var_1_10004.atan2(var_78_1 - arg_78_0._arrowCenterPos.y, var_78_0 - arg_78_0._arrowCenterPos.x)

	arg_78_0._arrowAngleVector.z = var_78_3
	arg_78_0._arrowBarTf.eulerAngles = arg_78_0._arrowAngleVector

	return
end

function var_0_7.UpdateChatPosition(arg_79_0)
	if not arg_79_0._popGO then
		return
	end

	if arg_79_0._inViewArea then
		arg_79_0._popTF.position = arg_79_0:GetReferenceVector()
	else
		arg_79_0._popTF.position = arg_79_0._arrowVector + var_0_9
	end

	return
end

function var_0_7.Dispose(arg_80_0)
	if arg_80_0._popGO then
		LeanTween = var_1

		var_1.cancel(arg_80_0._popGO)
	end

	if arg_80_0._popNumBundle then
		arg_80_0._hpPopContainerTF = nil

		local var_80_0 = arg_80_0._popNumBundle

		var_1.Clear(var_80_0)

		arg_80_0._popNumBundle = nil
	end

	arg_80_0._popNumPool = nil
	Object = var_1

	var_1.Destroy(arg_80_0._popGO)

	if arg_80_0._voicePlaybackInfo then
		local var_80_1 = arg_80_0._voicePlaybackInfo

		var_1.PlaybackStop(var_80_1)
	end

	if arg_80_0._cloakBar then
		local var_80_2 = arg_80_0._cloakBar

		var_1.Dispose(var_80_2)

		arg_80_0._cloakBar = nil
		arg_80_0._cloakBarTf = nil
	end

	if arg_80_0._aimBiarBar then
		local var_80_3 = arg_80_0._aimBiarBar

		var_1.Dispose(var_80_3)

		arg_80_0._aimBiarBar = nil
	end

	if arg_80_0._shieldBar then
		local var_80_4 = arg_80_0._shieldBar

		var_1.Dispose(var_80_4)

		arg_80_0._shieldBar = nil
	end

	if arg_80_0._buffClock then
		local var_80_5 = arg_80_0._buffClock

		var_1.Dispose(var_80_5)

		arg_80_0._buffClock = nil
	end

	arg_80_0._voicePlaybackInfo = nil
	arg_80_0._popGO = nil
	arg_80_0._popTF = nil
	arg_80_0._cacheWeapon = nil
	pairs = var_1

	for iter_80_0, iter_80_1 in var_1(arg_80_0._allFX) do
		local var_80_6 = var_0_5.GetInstance()

		var_6.DestroyOb(var_80_6, iter_80_0)
	end

	pairs = var_1

	for iter_80_2, iter_80_3 in var_1(arg_80_0._orbitList) do
		local var_80_7 = var_0_5.GetInstance()

		var_6.DestroyOb(var_80_7, iter_80_2)
	end

	arg_80_0._orbitList = nil
	arg_80_0._orbitActionCacheList = nil
	arg_80_0._orbitSpeedUpdateList = nil
	arg_80_0._orbitActionUpdateList = nil
	pg = var_1

	local var_80_8 = var_1.TimeMgr.GetInstance()

	var_1.RemoveBattleTimer(var_80_8, arg_80_0._voiceTimer)

	arg_80_0._voiceTimer = nil

	local var_80_9 = arg_80_0._effectOb

	var_1.RemoveUnitEvent(var_80_9, arg_80_0._unitData)

	local var_80_10 = arg_80_0._effectOb

	var_1.Dispose(var_80_10)

	arg_80_0._HPProgressBar = nil
	arg_80_0._HPProgress = nil

	local var_80_11 = arg_80_0._factory
	local var_80_12 = var_1.GetHPBarPool(var_80_11)

	var_1.DestroyObj(var_80_12, arg_80_0._HPBar)

	arg_80_0._HPBar = nil
	arg_80_0._HPBarTf = nil
	arg_80_0._arrowBar = nil
	arg_80_0._arrowBarTf = nil

	if arg_80_0._animator then
		local var_80_13 = arg_80_0._animator

		var_1.ClearOverrideMaterial(var_80_13)

		arg_80_0._animator = nil
	end

	arg_80_0._skeleton = nil
	arg_80_0._posMatrix = nil
	arg_80_0._shockFX = nil
	arg_80_0._waveFX = nil

	arg_80_0:RemoveUnitEvent()
	var_0.EventListener.DetachEventListener(arg_80_0)

	arg_80_0._bulletFactoryList = nil
	pairs = var_1

	for iter_80_4, iter_80_5 in var_1(arg_80_0._tagFXList) do
		iter_80_5:Dispose()
	end

	arg_80_0._tagFXList = nil
	arg_80_0._weaponRegisterList = nil

	var_0_7.super.Dispose(arg_80_0)

	return
end

function var_0_7.AddModel(arg_81_0, arg_81_1)
	arg_81_0:SetGO(arg_81_1)

	Vector3 = var_2

	local var_81_0 = 0
	local var_81_1 = arg_81_0._unitData

	arg_81_0._hpBarOffset = var_2(var_81_0, var_5.GetBoxSize(var_81_1).y, 0)

	local var_81_2 = arg_81_0:GetTf()
	local var_81_3 = var_2.GetComponent

	typeof = var_5
	SpineAnim = var_81_1
	arg_81_0._animator = var_81_3(var_81_2, var_5(var_81_1))

	local var_81_4 = arg_81_0:GetTf()

	arg_81_0._skeleton = var_2.GetComponent(var_81_4, "SkeletonAnimation")

	if arg_81_0._animator then
		local var_81_5 = arg_81_0._animator

		var_2.Start(var_81_5)
	end

	arg_81_0:SetBoneList()
	arg_81_0:UpdateMatrix()

	local var_81_6 = arg_81_0._unitData

	var_2.ActiveCldBox(var_81_6)

	local var_81_7 = arg_81_0:GetInitScale()
	local var_81_8 = arg_81_0
	local var_81_9 = arg_81_0.setLocalScale

	Vector3 = var_6

	local var_81_10 = arg_81_0._unitData

	var_81_9(var_81_8, var_6(var_81_7 * var_8.GetDirection(var_81_10), var_81_7, var_81_7))

	local var_81_11 = arg_81_0._unitData

	if var_3.GetOxyState(var_81_11) and var_3:GetCurrentDiveState() == var_0.Battle.BattleConst.OXY_STATE.DIVE then
		arg_81_0:PlayAction(var_0.Battle.BattleConst.ActionName.DIVE)
	else
		arg_81_0:PlayAction(var_0.Battle.BattleConst.ActionName.MOVE)
	end

	local var_81_12 = arg_81_0._animator

	var_4.SetActionCallBack(var_81_12, function(arg_82_0)
		if arg_82_0 == "finish" then
			local var_82_0 = arg_81_0

			var_1.OnAnimatorEnd(var_82_0)
		elseif arg_82_0 == "action" then
			local var_82_1 = arg_81_0

			var_1.OnAnimatorTrigger(var_82_1)
		else
			local var_82_2 = arg_81_0

			var_1.changeOrbitListVisible(var_82_2, arg_82_0)
		end

		return
	end)

	local var_81_13 = arg_81_0._unitData

	var_4.RegisterEventListener(var_81_13, arg_81_0, var_0_1.CHANGE_ACTION, arg_81_0.OnActionChange)

	return
end

function var_0_7.changeOrbitListVisible(arg_83_0, arg_83_1)
	local var_83_0

	if arg_83_1 == "skin_on" then
		var_83_0 = true
	elseif arg_83_1 == "skin_off" then
		var_83_0 = false
	else
		return
	end

	if arg_83_0._orbitList then
		pairs = var_3

		for iter_83_0, iter_83_1 in var_3(arg_83_0._orbitList) do
			SetActive = var_1_10008

			var_1_10008(iter_83_0, var_83_0)
		end
	end

	return
end

function var_0_7.SwitchModel(arg_84_0, arg_84_1, arg_84_2)
	local var_84_0 = arg_84_0._go

	arg_84_0:SetGO(arg_84_1)

	local var_84_1 = arg_84_0:GetTf()
	local var_84_2 = var_4.GetComponent

	typeof = var_7
	SpineAnim = var_1_10009
	arg_84_0._animator = var_84_2(var_84_1, var_7(var_1_10009))

	local var_84_3 = arg_84_0:GetTf()

	arg_84_0._skeleton = var_4.GetComponent(var_84_3, "SkeletonAnimation")

	if arg_84_0._animator then
		local var_84_4 = arg_84_0._animator

		var_4.Start(var_84_4)
	end

	arg_84_0:SetBoneList()

	local var_84_5 = arg_84_0._tf
	local var_84_6 = arg_84_0._unitData

	var_84_5.position = var_5.GetPosition(var_84_6)

	arg_84_0:UpdateMatrix()

	arg_84_0._hpBarOffset.y = arg_84_0._hpBarOffset.y + arg_84_0._coverSpineHPBarOffset

	arg_84_0:UpdateHPBarPosition()

	local var_84_7 = arg_84_0:GetInitScale()
	local var_84_8 = arg_84_0
	local var_84_9 = arg_84_0.setLocalScale

	Vector3 = var_1_10008

	local var_84_10 = arg_84_0._unitData

	var_84_9(var_84_8, var_1_10008(var_84_7 * var_10.GetDirection(var_84_10), var_84_7, var_84_7))

	local var_84_11 = arg_84_0._animator

	var_5.SetActionCallBack(var_84_11, function(arg_85_0)
		if arg_85_0 == "finish" then
			local var_85_0 = arg_84_0

			var_1.OnAnimatorEnd(var_85_0)
		elseif arg_85_0 == "action" then
			local var_85_1 = arg_84_0

			var_1.OnAnimatorTrigger(var_85_1)
		else
			local var_85_2 = arg_84_0

			var_1.changeAttachLListVisible(var_85_2, arg_85_0)
		end

		return
	end)

	local var_84_12 = arg_84_0

	arg_84_0.SwitchShader(var_84_12, arg_84_0._shaderType, arg_84_0._color)

	local var_84_13 = {}
	local var_84_14 = {}

	pairs = var_84_12

	for iter_84_0, iter_84_1 in var_84_12(arg_84_0._blinkDict) do
		SpineAnim = var_84_16
		var_84_13[var_84_16.CharBlink(arg_84_0._go, iter_84_1.r, iter_84_1.g, iter_84_1.b, iter_84_1.a, iter_84_1.peroid, iter_84_1.duration, false)] = iter_84_1
		var_84_14[iter_84_0] = var_84_16
	end

	arg_84_0._blinkDict = var_84_13

	arg_84_0:PlayAction(arg_84_0._actionIndex)

	if not arg_84_2 then
		pairs = var_7

		for iter_84_2, iter_84_3 in var_7(arg_84_0._orbitList) do
			SpineAnim = var_84_16

			local var_84_15 = var_84_16.AddFollower(iter_84_3.boundBone, arg_84_0._tf, iter_84_2.transform)
			local var_84_16 = var_84_16.GetComponent(var_84_15, "Spine.Unity.BoneFollower")

			var_84_16.followBoneRotation = false
		end
	end

	local var_84_17 = arg_84_0._effectOb

	var_7.SwitchOwner(var_84_17, arg_84_0, var_84_14)

	local var_84_18 = arg_84_0._FXAttachPoint.transform

	var_7.SetParent(var_84_18, arg_84_0:GetTf(), false)

	local var_84_19 = var_0_5.GetInstance()

	var_7.DestroyOb(var_84_19, var_84_0)

	return
end

function var_0_7.AddOrbit(arg_86_0, arg_86_1, arg_86_2, arg_86_3)
	local var_86_0 = arg_86_2.orbit_combat_bound[1]

	if arg_86_3 then
		var_86_0 = arg_86_3 .. "_" .. var_86_0
	end

	local var_86_1 = arg_86_2.orbit_combat_bound[2]
	local var_86_2 = arg_86_2.orbit_hidden_action
	local var_86_3 = arg_86_1.transform

	Vector3 = var_1_10008
	var_86_3.localPosition = var_1_10008(var_86_1[1], var_86_1[2], var_86_1[3])
	SpineAnim = var_86_3

	local var_86_4 = var_86_3.AddFollower(var_86_0, arg_86_0._tf, arg_86_1.transform)
	local var_86_5 = var_7.GetComponent(var_86_4, "Spine.Unity.BoneFollower")

	if arg_86_2.orbit_rotate then
		var_86_5.followBoneRotation = true

		local var_86_6 = arg_86_1.transform.localEulerAngles
		local var_86_7 = arg_86_1.transform

		Vector3 = var_10
		var_86_7.localEulerAngles = var_10(var_86_6.x, var_86_6.y, var_86_6.z - 90)
	else
		var_86_5.followBoneRotation = false
	end

	arg_86_0._orbitList[arg_86_1] = {
		hiddenAction = var_86_2,
		boundBone = var_86_0,
		offset = arg_86_0._orbitSpineOrderOffset
	}

	if arg_86_2.orbit_combat_anima_change.default then
		arg_86_0:changeOrbitAction(arg_86_1, var_8)

		ipairs = var_9

		for iter_86_0, iter_86_1 in var_9(arg_86_2.orbit_combat_anima_change.change) do
			if iter_86_1.condition.type == 1 then
				table = var_14

				local var_86_8 = var_14.insert
				local var_86_9 = arg_86_0._orbitSpeedUpdateList
				local var_86_10 = {
					orbit = arg_86_1
				}

				Clone = var_1_10018
				var_86_10.change = var_1_10018(iter_86_1)

				var_86_8(var_86_9, var_86_10)
			elseif iter_86_1.condition.type == 2 then
				table = var_14

				local var_86_11 = var_14.insert
				local var_86_12 = arg_86_0._orbitActionUpdateList
				local var_86_13 = {
					orbit = arg_86_1
				}

				Clone = var_1_10018
				var_86_13.change = var_1_10018(iter_86_1)

				var_86_11(var_86_12, var_86_13)
			end
		end
	end

	arg_86_0._orbitSpineOrderOffset = arg_86_0._orbitSpineOrderOffset + var_0_7.getMaxZSort(arg_86_1)

	arg_86_0:sortOrbitZOrder()

	return
end

function var_0_7.sortOrbitZOrder(arg_87_0)
	pairs = var_1_10001

	for iter_87_0, iter_87_1 in var_1_10001(arg_87_0._orbitList) do
		local var_87_0 = var_0_7.getMaxZSort(iter_87_0)

		eachChild = var_1_10007

		var_1_10007(iter_87_0, function(arg_88_0)
			if arg_88_0 and arg_88_0:GetComponent("MeshRenderer") and arg_88_0:GetComponent("MeshRenderer").sortingOrder > 0 then
				arg_88_0:GetComponent("MeshRenderer").sortingOrder = arg_87_0._orbitSpineOrderOffset - iter_87_1.offset - var_87_0 + var_1
			end

			return
		end)
	end

	return
end

function var_0_7.getMaxZSort(arg_89_0)
	local var_89_0 = 0

	eachChild = var_1_10002

	var_1_10002(arg_89_0, function(arg_90_0)
		if arg_90_0 and arg_90_0:GetComponent("MeshRenderer") then
			local var_90_0 = arg_90_0:GetComponent("MeshRenderer").sortingOrder

			math = var_2_10002
			var_89_0 = var_2_10002.max(var_89_0, var_90_0)
		end

		return
	end)

	return var_89_0
end

function var_0_7.changeOrbitAction(arg_91_0, arg_91_1, arg_91_2)
	ipairs = var_1_10003

	for iter_91_0, iter_91_1 in var_1_10003(arg_91_2) do
		local var_91_0 = arg_91_1.transform

		if var_8.Find(var_91_0, iter_91_1.node) then
			SetActive = var_1_10010

			var_1_10010(var_9, iter_91_1.active)

			if iter_91_1.active and arg_91_0._orbitActionCacheList[var_9] ~= iter_91_1.activate then
				var_1_10010 = iter_91_1.activate

				local var_91_1 = var_9
				local var_91_2 = var_9.GetComponent

				typeof = var_1_10014
				Animator = var_1_10016

				local var_91_3 = var_91_2(var_91_1, var_1_10014(var_1_10016))

				var_11.SetBool(var_91_3, "activate", var_1_10010)

				arg_91_0._orbitActionCacheList[var_9] = iter_91_1.activate
			end
		end
	end

	return
end

function var_0_7.UpdateOrbit(arg_92_0)
	if #arg_92_0._orbitSpeedUpdateList <= 0 then
		return
	end

	local var_92_0 = arg_92_0._unitData
	local var_92_1 = var_1.GetSpeed(var_92_0)
	local var_92_2 = var_1.Magnitude(var_92_1)

	pairs = var_2

	for iter_92_0, iter_92_1 in var_2(arg_92_0._orbitSpeedUpdateList) do
		local var_92_3 = iter_92_1.orbit
		local var_92_4 = iter_92_1.change.condition.param
		local var_92_5 = true

		ipairs = var_1_10011

		for iter_92_2, iter_92_3 in var_1_10011(var_92_4) do
			var_92_5 = var_0_6.simpleCompare(iter_92_3, var_92_2) and var_92_5
		end

		if var_92_5 then
			arg_92_0:changeOrbitAction(var_92_3, var_8)
		end
	end

	return
end

function var_0_7.AddSmokeFXs(arg_93_0, arg_93_1)
	arg_93_0._smokeList = arg_93_1

	arg_93_0:updateSomkeFX()

	return
end

function var_0_7.AddShadow(arg_94_0, arg_94_1)
	arg_94_0._shadow = arg_94_1

	return
end

function var_0_7.AddHPBar(arg_95_0, arg_95_1)
	arg_95_0._HPBar = arg_95_1
	arg_95_0._HPBarTf = arg_95_1.transform

	local var_95_0 = arg_95_0._HPBarTf

	arg_95_0._HPProgressBar = var_2.Find(var_95_0, "blood")

	local var_95_1 = arg_95_0._HPProgressBar
	local var_95_2 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007
	arg_95_0._HPProgress = var_95_2(var_95_1, var_5(var_1_10007))

	local var_95_3 = arg_95_0._unitData

	var_2.RegisterEventListener(var_95_3, arg_95_0, var_0_1.UPDATE_HP, arg_95_0.OnUpdateHP)

	arg_95_0._HPBarTf.position = arg_95_0._referenceVector + arg_95_0._hpBarOffset

	return
end

function var_0_7.AddUIComponentContainer(arg_96_0, arg_96_1)
	arg_96_0:UpdateUIComponentPosition()

	return
end

function var_0_7.AddPopNumPool(arg_97_0, arg_97_1)
	arg_97_0._popNumPool = arg_97_1
	arg_97_0._hpPopIndex_put = 1
	arg_97_0._hpPopIndex_get = 1
	arg_97_0._hpPopCount = 0
	arg_97_0._hpPopCatch = {}

	local var_97_0 = arg_97_0._popNumPool
	local var_97_1 = var_2.GetBundle
	local var_97_2 = arg_97_0._unitData

	arg_97_0._popNumBundle = var_97_1(var_97_0, var_5.GetUnitType(var_97_2))

	local var_97_3 = arg_97_0._popNumBundle

	arg_97_0._hpPopContainerTF = var_2.GetContainer(var_97_3).transform

	return
end

function var_0_7.AddArrowBar(arg_98_0, arg_98_1)
	arg_98_0._arrowBar = arg_98_1
	arg_98_0._arrowBarTf = arg_98_1.transform

	arg_98_0:SetArrowPoint()

	return
end

function var_0_7.AddCastClock(arg_99_0, arg_99_1)
	local var_99_0 = arg_99_1.transform

	SetActive = var_1_10003

	var_1_10003(var_99_0, false)

	arg_99_0._castClock = var_0.Battle.BattleCastBar.New(var_99_0)

	arg_99_0:UpdateCastClockPosition()

	return
end

function var_0_7.AddBuffClock(arg_100_0, arg_100_1)
	local var_100_0 = arg_100_1.transform

	SetActive = var_1_10003

	var_1_10003(var_100_0, false)

	arg_100_0._buffClock = var_0.Battle.BattleBuffClock.New(var_100_0)

	return
end

function var_0_7.AddBarrierClock(arg_101_0, arg_101_1)
	local var_101_0 = arg_101_1.transform

	SetActive = var_1_10003

	var_1_10003(var_101_0, false)

	arg_101_0._barrierClock = var_0.Battle.BattleBarrierBar.New(var_101_0)

	arg_101_0:UpdateBarrierClockPosition()

	return
end

function var_0_7.AddVigilantBar(arg_102_0, arg_102_1)
	arg_102_0._vigilantBar = var_0.Battle.BattleVigilantBar.New(arg_102_1.transform)

	local var_102_0 = arg_102_0._vigilantBar
	local var_102_1 = var_2.ConfigVigilant
	local var_102_2 = arg_102_0._unitData

	var_102_1(var_102_0, var_5.GetAntiSubState(var_102_2))

	local var_102_3 = arg_102_0._vigilantBar

	var_2.UpdateVigilantProgress(var_102_3)
	arg_102_0:updateVigilantMark()

	return
end

function var_0_7.UpdateVigilantBarPosition(arg_103_0)
	local var_103_0 = arg_103_0._vigilantBar

	var_1.UpdateVigilantBarPosition(var_103_0, arg_103_0._hpBarPos)

	return
end

function var_0_7.AddCloakBar(arg_104_0, arg_104_1)
	arg_104_0._cloakBarTf = arg_104_1.transform
	arg_104_0._cloakBar = var_0.Battle.BattleCloakBar.New(arg_104_0._cloakBarTf)

	local var_104_0 = arg_104_0._cloakBar
	local var_104_1 = var_2.ConfigCloak
	local var_104_2 = arg_104_0._unitData

	var_104_1(var_104_0, var_5.GetCloak(var_104_2))

	local var_104_3 = arg_104_0._cloakBar

	var_2.UpdateCloakProgress(var_104_3)

	return
end

function var_0_7.UpdateCloakBarPosition(arg_105_0, arg_105_1)
	if arg_105_0._inViewArea then
		arg_105_0._cloakBarTf.anchoredPosition = var_0_8
	else
		local var_105_0 = arg_105_0._cloakBar

		var_2.UpdateCloarBarPosition(var_105_0, arg_105_0._arrowVector)
	end

	return
end

function var_0_7.onInitCloak(arg_106_0, arg_106_1)
	local var_106_0 = arg_106_0._factory

	var_2.MakeCloakBar(var_106_0, arg_106_0)

	return
end

function var_0_7.onUpdateCloakConfig(arg_107_0, arg_107_1)
	local var_107_0 = arg_107_0._cloakBar

	var_2.UpdateCloakConfig(var_107_0)

	return
end

function var_0_7.onUpdateCloakLock(arg_108_0, arg_108_1)
	local var_108_0 = arg_108_0._cloakBar

	var_2.UpdateCloakLock(var_108_0)

	return
end

function var_0_7.IsDoubleChar(arg_109_0)
	if arg_109_0._skeleton then
		local var_109_0 = arg_109_0._skeleton.skeleton
		local var_109_1 = var_1.FindBoneIndex(var_109_0, "char1_face")
		local var_109_2 = arg_109_0._skeleton.skeleton
		local var_109_3 = var_2.FindBoneIndex(var_109_2, "char2_face")

		if var_109_1 >= 0 and var_109_3 >= 0 then
			return true
		end
	end

	return false
end

function var_0_7.AddAimBiasBar(arg_110_0, arg_110_1)
	arg_110_0._aimBiarBarTF = arg_110_1
	arg_110_0._aimBiarBar = var_0.Battle.BattleAimbiasBar.New(arg_110_1)

	local var_110_0 = arg_110_0._aimBiarBar
	local var_110_1 = var_2.ConfigAimBias
	local var_110_2 = arg_110_0._unitData

	var_110_1(var_110_0, var_5.GetAimBias(var_110_2))

	local var_110_3 = arg_110_0._aimBiarBar

	var_2.UpdateAimBiasProgress(var_110_3)

	return
end

function var_0_7.UpdateAimBiasBar(arg_111_0)
	if arg_111_0._aimBiarBar then
		local var_111_0 = arg_111_0._aimBiarBar

		var_1.UpdateAimBiasProgress(var_111_0)
	end

	return
end

function var_0_7.AddShieldBar(arg_112_0, arg_112_1)
	arg_112_0._shieldBarTF = arg_112_1
	arg_112_0._shieldBar = var_0.Battle.BattleRecoilShieldBar.New(arg_112_0._shieldBarTF)

	arg_112_0:configShieldBuffBar()

	local var_112_0 = arg_112_0._shieldBar

	var_2.UpdateRecoilShieldProgress(var_112_0)

	return
end

function var_0_7.UpdateShieldBar(arg_113_0)
	if arg_113_0._shieldBar then
		local var_113_0 = arg_113_0._shieldBar

		var_1.UpdateRecoilShieldProgress(var_113_0)
	end

	return
end

function var_0_7.onRecoilShield(arg_114_0, arg_114_1)
	if not arg_114_0._shieldBar then
		local var_114_0 = arg_114_0._factory

		var_2.MakeShieldBar(var_114_0, arg_114_0)
	else
		arg_114_0:configShieldBuffBar()
	end

	return
end

function var_0_7.configShieldBuffBar(arg_115_0)
	local var_115_0 = arg_115_0._unitData
	local var_115_1 = var_1.GetBuffList(var_115_0)
	local var_115_2

	pairs = var_115_0

	for iter_115_0, iter_115_1 in var_115_0(var_115_1) do
		local var_115_3 = iter_115_1:GetEffectList()

		ipairs = var_1_10009

		for iter_115_2, iter_115_3 in var_1_10009(var_115_3) do
			if iter_115_3.__name == var_0.Battle.BattleBuffRecoilShield.__name then
				var_115_2 = iter_115_3

				break
			end
		end
	end

	local var_115_4 = arg_115_0._shieldBar

	var_3.ConfigShieldBuff(var_115_4, var_115_2)

	return
end

function var_0_7.UpdateBuffClock(arg_116_0)
	if arg_116_0._buffClock then
		local var_116_0 = arg_116_0._buffClock

		if var_1.IsActive(var_116_0) then
			local var_116_1 = arg_116_0._buffClock

			var_1.UpdateCastClockPosition(var_116_1, arg_116_0._referenceVector)

			local var_116_2 = arg_116_0._buffClock

			var_1.UpdateCastClock(var_116_2)
		end
	end

	return
end

function var_0_7.onUpdateAimBiasLock(arg_117_0, arg_117_1)
	local var_117_0 = arg_117_0._aimBiarBar

	var_2.UpdateLockStateView(var_117_0)

	return
end

function var_0_7.onInitAimBias(arg_118_0, arg_118_1)
	local var_118_0 = arg_118_0._unitData
	local var_118_1 = var_2.GetAimBias(var_118_0)

	if var_2.GetHost(var_118_1) == arg_118_0._unitData then
		local var_118_2 = arg_118_0._factory

		var_2.MakeAimBiasBar(var_118_2, arg_118_0)
	end

	return
end

function var_0_7.onHostAimBias(arg_119_0, arg_119_1)
	local var_119_0 = arg_119_0._factory

	var_2.MakeAimBiasBar(var_119_0, arg_119_0)

	return
end

function var_0_7.onRemoveAimBias(arg_120_0, arg_120_1)
	local var_120_0 = arg_120_0._aimBiarBar

	var_2.SetActive(var_120_0, false)

	local var_120_1 = arg_120_0._aimBiarBar

	var_2.Dispose(var_120_1)

	arg_120_0._aimBiarBar = nil
	arg_120_0._aimBiarBarTF = nil

	return
end

function var_0_7.AddAimBiasFogFX(arg_121_0)
	local var_121_0 = arg_121_0._unitData

	if var_1.GetTemplate(var_121_0).fog_fx and var_1 ~= "" then
		arg_121_0._fogFx = arg_121_0:AddFX(var_1)
	end

	return
end

function var_0_7.OnUpdateHP(arg_122_0, arg_122_1)
	arg_122_0:_DealHPPop(arg_122_1.Data)

	return
end

function var_0_7._DealHPPop(arg_123_0, arg_123_1)
	if arg_123_0._hpPopIndex_put == arg_123_0._hpPopIndex_get and arg_123_0._hpPopCount == 0 then
		arg_123_0:_PlayHPPop(arg_123_1)

		arg_123_0._hpPopCount = 1
	else
		local var_123_0 = arg_123_0._unitData

		if var_2.IsAlive(var_123_0) then
			arg_123_0._hpPopCatch[arg_123_0._hpPopIndex_put] = arg_123_1
			arg_123_0._hpPopIndex_put = arg_123_0._hpPopIndex_put + 1
		else
			arg_123_0:_PlayHPPop(arg_123_1)
		end
	end

	return
end

function var_0_7.UpdateHPPop(arg_124_0)
	if arg_124_0._hpPopIndex_put == arg_124_0._hpPopIndex_get then
		return
	else
		arg_124_0._hpPopCount = arg_124_0._hpPopCount + 1

		if arg_124_0:_CalcHPPopCount() <= arg_124_0._hpPopCount then
			arg_124_0:_PlayHPPop(arg_124_0._hpPopCatch[arg_124_0._hpPopIndex_get])

			arg_124_0._hpPopCatch[arg_124_0._hpPopIndex_get] = nil
			arg_124_0._hpPopIndex_get = arg_124_0._hpPopIndex_get + 1
			arg_124_0._hpPopCount = 0
		end
	end

	return
end

function var_0_7._PlayHPPop(arg_125_0, arg_125_1)
	local var_125_0 = arg_125_0._popNumBundle

	if var_2.IsScorePop(var_125_0) then
		return
	end

	local var_125_1 = arg_125_1.dHP
	local var_125_2 = arg_125_1.isCri
	local var_125_3 = arg_125_1.isMiss
	local var_125_4 = arg_125_1.isHeal
	local var_125_5

	if not arg_125_1.posOffset then
		Vector3 = var_125_5
		var_125_5 = var_125_5.zero
	end

	local var_125_6 = arg_125_1.font
	local var_125_7 = arg_125_0._popNumBundle
	local var_125_8 = var_8.GetPop(var_125_7, var_125_4, var_125_2, var_125_3, var_125_1, var_125_6)

	var_8.SetReferenceCharacter(var_125_8, arg_125_0, var_125_5)
	var_8:Play()

	return
end

function var_0_7._CalcHPPopCount(arg_126_0)
	if arg_126_0._hpPopIndex_put - arg_126_0._hpPopIndex_get > 5 then
		return 1
	else
		return 5
	end

	return
end

function var_0_7.onUpdateScore(arg_127_0, arg_127_1)
	local var_127_0 = arg_127_1.Data.score
	local var_127_1 = arg_127_0._popNumBundle
	local var_127_2 = var_3.GetScorePop(var_127_1, var_127_0)
	local var_127_3 = var_3.SetReferenceCharacter
	local var_127_4 = arg_127_0

	Vector3 = var_1_10008

	var_127_3(var_127_2, var_127_4, var_1_10008.zero)
	var_3:Play()

	return
end

function var_0_7.UpdateHpBar(arg_128_0)
	local var_128_0 = arg_128_0._unitData
	local var_128_1 = var_1.GetCurrentHP(var_128_0)

	if arg_128_0._HPProgress and arg_128_0._cacheHP ~= var_128_1 then
		local var_128_2 = arg_128_0._unitData
		local var_128_3 = var_2.GetHPRate(var_128_2)

		arg_128_0._HPProgress.fillAmount = var_128_3
		arg_128_0._cacheHP = var_128_1
	end

	return
end

function var_0_7.onChangeSize(arg_129_0, arg_129_1)
	arg_129_0:doChangeSize(arg_129_1)

	return
end

function var_0_7.updateSomkeFX(arg_130_0)
	local var_130_0 = arg_130_0._unitData
	local var_130_1 = var_1.GetHPRate(var_130_0)

	ipairs = var_1_10002

	for iter_130_0, iter_130_1 in var_1_10002(arg_130_0._smokeList) do
		if var_130_1 < iter_130_1.rate then
			if iter_130_1.active == false then
				iter_130_1.active = true

				local var_130_2 = iter_130_1.smokes

				pairs = var_1_10008

				for iter_130_2, iter_130_3 in var_1_10008(var_130_2) do
					if iter_130_2.unInitialize then
						local var_130_3 = arg_130_0:AddFX(iter_130_2.resID).transform

						var_130_3.localPosition = iter_130_2.pos
						var_130_2[iter_130_2] = var_13
						SetActive = var_130_3

						var_130_3(var_13, true)

						iter_130_2.unInitialize = false
					else
						SetActive = var_13

						var_13(iter_130_3, true)
					end
				end
			end
		elseif iter_130_1.active == true then
			iter_130_1.active = false

			local var_130_4 = iter_130_1.smokes

			pairs = var_1_10008

			for iter_130_4, iter_130_5 in var_1_10008(var_130_4) do
				if iter_130_4.unInitialize then
					-- block empty
				else
					SetActive = var_13

					var_13(iter_130_5, false)
				end
			end
		end
	end

	return
end

function var_0_7.doChangeSize(arg_131_0, arg_131_1)
	local var_131_0 = arg_131_0._unitData
	local var_131_1 = var_2.GetAttrByName(var_131_0, "modelScale")
	local var_131_2 = arg_131_0
	local var_131_3 = arg_131_0.setLocalScale

	Vector3 = var_1_10006

	local var_131_4 = arg_131_0._unitData

	var_131_3(var_131_2, var_1_10006(var_131_1 * var_8.GetDirection(var_131_4), var_131_1, var_131_1))

	return
end

function var_0_7.InitEffectView(arg_132_0)
	arg_132_0._effectOb = var_0.Battle.BattleEffectComponent.New(arg_132_0)

	return
end

function var_0_7.UpdateAniEffect(arg_133_0, arg_133_1)
	local var_133_0 = arg_133_0._effectOb

	var_2.Update(var_133_0, arg_133_1)

	return
end

function var_0_7.UpdateTagEffect(arg_134_0, arg_134_1)
	local var_134_0 = arg_134_0._unitData
	local var_134_1 = var_2.GetBoxSize(var_134_0).y * 0.5

	pairs = var_1_10003

	for iter_134_0, iter_134_1 in var_1_10003(arg_134_0._tagFXList) do
		iter_134_1:Update(arg_134_1)

		local var_134_2 = iter_134_1
		local var_134_3 = iter_134_1.SetPosition
		local var_134_4 = arg_134_0._referenceVector

		Vector3 = var_1_10012

		var_134_3(var_134_2, var_134_4 + var_1_10012(0, var_134_1, 0))
	end

	return
end

function var_0_7.SetPopup(arg_135_0, arg_135_1, arg_135_2, arg_135_3)
	if arg_135_0._voiceTimer then
		if arg_135_0._voiceKey == arg_135_3 then
			arg_135_0._voiceKey = nil
		else
			return
		end
	end

	if arg_135_0._popGO then
		LeanTween = var_4

		var_4.cancel(arg_135_0._popGO)

		local var_135_0 = arg_135_0._popGO.transform
		local var_135_1 = var_4.GetComponent

		typeof = var_1_10007
		Animation = var_1_10009

		if var_135_1(var_135_0, var_1_10007(var_1_10009)) then
			var_1_10007 = var_4

			var_4.Play(var_1_10007, "popup_out")

			var_1_10007 = arg_135_0._popGO
			var_1_10008 = var_1_10005.GetComponent(var_1_10007, "DftAniEvent")

			var_1_10005.SetEndEvent(var_1_10008, function(arg_136_0)
				arg_135_0.ChatPopAnimation(arg_135_0._popGO, arg_135_2)

				return
			end)
		else
			LeanTween = var_1_10005

			var_1_10005.cancel(arg_135_0._popGO)

			LeanTween = var_5

			local var_135_2 = var_5.scale

			rtf = var_1_10007
			var_1_10007 = var_1_10007(arg_135_0._popGO.gameObject)
			Vector3 = var_1_10008
			var_1_10007 = var_135_2(var_1_10007, var_1_10008.New(0, 0, 1), 0.1)

			local var_135_3 = var_5.setEase

			LeanTweenType = var_8
			var_1_10007 = var_135_3(var_1_10007, var_8.easeInBack)

			local var_135_4 = var_5.setOnComplete

			System = var_8

			var_135_4(var_1_10007, var_8.Action(function()
				arg_135_0.ChatPop(arg_135_0._popGO, arg_135_2)

				return
			end))
		end
	else
		local var_135_5 = arg_135_0._factory

		arg_135_0._popGO = var_4.MakePopup(var_135_5)
		arg_135_0._popTF = arg_135_0._popGO.transform

		local var_135_6 = arg_135_0._popGO.transform
		local var_135_7 = var_4.GetComponent

		typeof = var_1_10007
		Animation = var_1_10009

		if var_135_7(var_135_6, var_1_10007(var_1_10009)) then
			arg_135_0.ChatPopAnimation(arg_135_0._popGO, arg_135_2)
		else
			local var_135_8 = arg_135_0._popTF

			Vector3 = var_135_6
			var_135_8.localScale = var_135_6(0, 0, 0)

			arg_135_0.ChatPop(arg_135_0._popGO, arg_135_2)
		end
	end

	var_0_7.setChatText(arg_135_0._popGO, arg_135_1)

	SetActive = var_4

	var_4(arg_135_0._popGO, true)

	return
end

function var_0_7.ChatPopAnimation(arg_138_0, arg_138_1)
	local var_138_0 = arg_138_0.transform
	local var_138_1 = var_2.GetComponent

	typeof = var_1_10005
	Animation = var_1_10007

	local var_138_2 = var_138_1(var_138_0, var_1_10005(var_1_10007))

	var_2.Play(var_138_2, "popup_in")

	LeanTween = var_3

	local var_138_3 = var_3.delayedCall
	local var_138_4 = arg_138_0.gameObject
	local var_138_5 = arg_138_1

	System = var_1_10007

	var_138_3(var_138_4, var_138_5, var_1_10007.Action(function()
		local var_139_0 = var_0

		var_0.Play(var_139_0, "popup_out")

		local var_139_1 = arg_138_0
		local var_139_2 = var_0.GetComponent(var_139_1, "DftAniEvent")

		var_0.SetEndEvent(var_139_2, function(arg_140_0)
			SetActive = var_3_10001

			var_3_10001(arg_138_0, false)

			return
		end)

		return
	end))

	return
end

function var_0_7.ChatPop(arg_141_0, arg_141_1)
	arg_141_1 = arg_141_1 or 2.5
	LeanTween = var_1_10002

	local var_141_0 = var_1_10002.scale

	rtf = var_1_10004

	local var_141_1 = var_1_10004(arg_141_0.gameObject)

	Vector3 = var_1_10005

	local var_141_2 = var_141_0(var_141_1, var_1_10005.New(1, 1, 1), 0.3)
	local var_141_3 = var_2.setEase

	LeanTweenType = var_5

	local var_141_4 = var_141_3(var_141_2, var_5.easeOutBack)
	local var_141_5 = var_2.setOnComplete

	System = var_5

	var_141_5(var_141_4, var_5.Action(function()
		LeanTween = var_2_10000

		local var_142_0 = var_2_10000.scale

		rtf = var_2_10002

		local var_142_1 = var_2_10002(arg_141_0.gameObject)

		Vector3 = var_2_10003

		local var_142_2 = var_142_0(var_142_1, var_2_10003.New(0, 0, 1), 0.3)
		local var_142_3 = var_0.setEase

		LeanTweenType = var_3

		local var_142_4 = var_142_3(var_142_2, var_3.easeInBack)
		local var_142_5 = var_0.setDelay(var_142_4, arg_141_1)
		local var_142_6 = var_0.setOnComplete

		System = var_3

		var_142_6(var_142_5, var_3.Action(function()
			SetActive = var_3_10000

			var_3_10000(arg_141_0, false)

			return
		end))

		return
	end))

	return
end

function var_0_7.setChatText(arg_144_0, arg_144_1)
	findTF = var_1_10002

	local var_144_0 = var_1_10002(arg_144_0, "Text")
	local var_144_1 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007

	local var_144_2 = var_144_1(var_144_0, var_5(var_1_10007))

	var_144_2.text = arg_144_1

	local var_144_3 = #var_144_2.text

	CHAT_POP_STR_LEN = var_144_0

	if var_144_0 < var_144_3 then
		TextAnchor = var_144_3
		var_144_2.alignment = var_144_3.MiddleLeft
	else
		TextAnchor = var_144_3
		var_144_2.alignment = var_144_3.MiddleCenter
	end

	return
end

function var_0_7.Voice(arg_145_0, arg_145_1, arg_145_2)
	if arg_145_0._voiceTimer then
		return
	end

	pg = var_3

	local var_145_0 = var_3.CriMgr.GetInstance()

	var_3.PlayMultipleSound_V3(var_145_0, arg_145_1, function(arg_146_0)
		if arg_146_0 then
			arg_145_0._voiceKey = arg_145_2
			arg_145_0._voicePlaybackInfo = arg_146_0

			local var_146_0 = arg_145_0

			pg = var_2

			local var_146_1 = var_2.TimeMgr.GetInstance()
			local var_146_2 = var_2.AddBattleTimer
			local var_146_3 = ""
			local var_146_4 = 0
			local var_146_5 = arg_145_0._voicePlaybackInfo

			var_146_0._voiceTimer = var_146_2(var_146_1, var_146_3, var_146_4, var_7.GetLength(var_146_5) * 0.001, function()
				pg = var_3_10000

				local var_147_0 = var_3_10000.TimeMgr.GetInstance()

				var_0.RemoveBattleTimer(var_147_0, arg_145_0._voiceTimer)

				arg_145_0._voiceTimer = nil
				arg_145_0._voiceKey = nil
				arg_145_0._voicePlaybackInfo = nil

				return
			end)
		end

		return
	end)

	return
end

function var_0_7.setLocalScale(arg_148_0, arg_148_1, arg_148_2)
	arg_148_0._tf.localScale = arg_148_1

	if not arg_148_2 then
		arg_148_0._modelScale = arg_148_1
	end

	return
end

function var_0_7.SonarAcitve(arg_149_0, arg_149_1)
	return
end

function var_0_7.SwitchShader(arg_150_0, arg_150_1, arg_150_2, arg_150_3)
	LeanTween = var_1_10004

	var_1_10004.cancel(arg_150_0._go)

	if not arg_150_2 then
		Color = var_4
		arg_150_2 = var_4.New(0, 0, 0, 0)
	end

	if arg_150_1 then
		local var_150_0 = var_0_5.GetInstance()
		local var_150_1 = var_4.GetShader(var_150_0, arg_150_1)
		local var_150_2 = arg_150_0._animator

		var_5.ShiftShader(var_150_2, var_150_1, arg_150_2)

		if arg_150_3 then
			arg_150_0:spineSemiTransparentFade(0, arg_150_3.invisible, 0)
		end
	end

	arg_150_0._shaderType = arg_150_1
	arg_150_0._color = arg_150_2

	return
end

function var_0_7.PauseActionAnimation(arg_151_0, arg_151_1)
	local var_151_0 = arg_151_1 and 0 or 1
	local var_151_1 = arg_151_0._animator

	var_3.GetAnimationState(var_151_1).TimeScale = var_151_0

	return
end

function var_0_7.GetFactory(arg_152_0)
	return arg_152_0._factory
end

function var_0_7.SetFactory(arg_153_0, arg_153_1)
	arg_153_0._factory = arg_153_1

	return
end

function var_0_7.onSwitchSpine(arg_154_0, arg_154_1)
	local var_154_0 = arg_154_1.Data.skin
	local var_154_1

	if not var_2.HPBarOffset then
		var_154_1 = 0
	end

	arg_154_0._coverSpineHPBarOffset = var_154_1

	arg_154_0:SwitchSpine(var_154_0)

	return
end

function var_0_7.SwitchSpine(arg_155_0, arg_155_1)
	pairs = var_1_10002

	for iter_155_0, iter_155_1 in var_1_10002(arg_155_0._blinkDict) do
		SpineAnim = var_1_10007

		var_1_10007.RemoveBlink(arg_155_0._go, iter_155_0)
	end

	local var_155_0 = arg_155_0._factory

	var_2.SwitchCharacterSpine(var_155_0, arg_155_0, arg_155_1)

	return
end

function var_0_7.onSwitchShader(arg_156_0, arg_156_1)
	local var_156_0 = arg_156_1.Data.shader
	local var_156_1 = var_2.color
	local var_156_2 = var_2.args

	arg_156_0:SwitchShader(var_156_0, var_156_1, var_156_2)

	return
end

return
