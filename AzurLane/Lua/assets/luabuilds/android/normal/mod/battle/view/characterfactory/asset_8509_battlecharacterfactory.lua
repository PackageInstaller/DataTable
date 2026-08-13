ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig

singletonClass = var_0_10002

local var_0_2 = var_0_10002("BattleCharacterFactory")

var_0.Battle.BattleCharacterFactory = var_0_2
var_0_2.__name = "BattleCharacterFactory"
var_0_2.HP_BAR_NAME = ""
var_0_2.POPUP_NAME = "popup"
var_0_2.TAG_NAME = "ChargeAreaContainer/LockTag"
Vector3 = var_3
var_0_2.MOVE_WAVE_FX_POS = var_3(0, -2.3, -1.5)
var_0_2.MOVE_WAVE_FX_NAME = "movewave"
var_0_2.SMOKE_FX_NAME = "smoke"
var_0_2.BOMB_FX_NAME = "Bomb"
var_0_2.DANCHUAN_MOVE_WAVE_FX_NAME = "danchuanlanghuazhong2"

function var_0_2.Ctor(arg_1_0)
	return
end

function var_0_2.CreateCharacter(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.unit
	local var_2_1 = arg_2_0:MakeCharacter()

	var_3.SetFactory(var_2_1, arg_2_0)
	var_3:SetUnitData(var_2_0)
	arg_2_0:MakeModel(var_3)

	return var_3
end

function var_0_2.GetSceneMediator(arg_3_0)
	local var_3_0 = var_0.Battle.BattleState.GetInstance()

	return var_1.GetMediatorByName(var_3_0, var_0.Battle.BattleSceneMediator.__name)
end

function var_0_2.GetFXPool(arg_4_0)
	return var_0.Battle.BattleFXPool.GetInstance()
end

function var_0_2.GetCharacterPool(arg_5_0)
	return var_0.Battle.BattleResourceManager.GetInstance()
end

function var_0_2.GetHPBarPool(arg_6_0)
	return var_0.Battle.BattleHPBarManager.GetInstance()
end

function var_0_2.GetDivingFilterColor(arg_7_0)
	local var_7_0 = var_0.Battle.BattleDataProxy.GetInstance()._mapId
	local var_7_1 = var_0.Battle.BattleDataFunction.GetDivingFilter(var_7_0)

	Color = var_3

	return (var_3.New(var_7_1.r, var_7_1.g, var_7_1.b, var_7_1.a))
end

function var_0_2.GetFXContainerPool(arg_8_0)
	return var_0.Battle.BattleCharacterFXContainersPool.GetInstance()
end

function var_0_2.MakeCharacter(arg_9_0)
	return nil
end

function var_0_2.MakeModel(arg_10_0, arg_10_1)
	return nil
end

function var_0_2.MakeBloodBar(arg_11_0, arg_11_1)
	return nil
end

function var_0_2.MakeAimBiasBar(arg_12_0)
	return nil
end

function var_0_2.SetHPBarWidth(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_1:GetUnitData()
	local var_13_1 = var_4.GetTemplate(var_13_0).hp_bar[1]
	local var_13_2 = arg_13_2.transform.rect.height

	Vector2 = var_1_10008
	var_6.sizeDelta = var_1_10008(var_13_1, var_13_2)

	local var_13_3 = var_6:Find("blood").transform.rect.height

	Vector2 = var_9

	local var_13_4

	if not (var_13_1 + arg_13_3) then
		var_13_4 = 0
	end

	var_8.sizeDelta = var_9(var_13_4, var_13_3)

	return
end

function var_0_2.MakeUIComponentContainer(arg_14_0, arg_14_1)
	arg_14_1:AddUIComponentContainer()

	return
end

function var_0_2.MakeFXContainer(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1:GetTf()
	local var_15_1 = arg_15_0:GetFXPool()
	local var_15_2 = var_3.PopCharacterAttachPoint(var_15_1).transform

	SetActive = var_1_10005

	var_1_10005(var_15_2, true)

	local var_15_3 = var_15_2

	var_15_2.SetParent(var_15_3, var_15_0, false)

	Vector3 = var_5
	var_15_2.localPosition = var_5.zero

	local var_15_4 = var_15_0.localEulerAngles

	Vector3 = var_15_3
	var_15_2.localEulerAngles = var_15_3(var_15_4.x * -1, var_15_4.y, var_15_4.z)

	local var_15_5 = arg_15_1:GetUnitData()
	local var_15_6 = var_6.GetTemplate(var_15_5).fx_container
	local var_15_7 = {}

	ipairs = var_8

	for iter_15_0, iter_15_1 in var_8(var_0.Battle.BattleConst.FXContainerIndex) do
		local var_15_8 = var_15_6[iter_15_0]

		Vector3 = var_1_10014
		var_15_7[iter_15_0] = var_1_10014(var_15_8[1], var_15_8[2], var_15_8[3])
	end

	arg_15_1:AddFXOffsets(var_3, var_15_7)

	return
end

function var_0_2.MakeShadow(arg_16_0)
	return nil
end

function var_0_2.MakeSmokeFX(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1:GetUnitData()
	local var_17_1 = var_2.GetTemplate(var_17_0).smoke
	local var_17_2 = {}

	ipairs = var_1_10004

	for iter_17_0, iter_17_1 in var_1_10004(var_17_1) do
		local var_17_3 = iter_17_1[2]
		local var_17_4 = {}

		ipairs = var_1_10011

		for iter_17_2, iter_17_3 in var_1_10011(var_17_3) do
			local var_17_5 = {}

			var_17_5.unInitialize = true
			var_17_5.resID = iter_17_3[1]
			Vector3 = var_17
			var_17_5.pos = var_17(iter_17_3[2][1], iter_17_3[2][2], iter_17_3[2][3])
			var_17_4[var_17_5] = false
		end

		var_17_2[iter_17_0] = {
			active = false,
			rate = iter_17_1[1] / 100,
			smokes = var_17_4
		}
	end

	arg_17_1:AddSmokeFXs(var_17_2)

	return
end

function var_0_2.MakeWaveFX(arg_18_0, arg_18_1)
	arg_18_1:AddWaveFX(arg_18_0.MOVE_WAVE_FX_NAME)

	return
end

function var_0_2.MakePopNumPool(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1
	local var_19_1 = arg_19_1.AddPopNumPool
	local var_19_2 = arg_19_0:GetSceneMediator()

	var_19_1(var_19_0, var_4.GetPopNumPool(var_19_2))

	return
end

function var_0_2.MakeTag(arg_20_0, arg_20_1)
	local var_20_0 = var_0.Battle.BattleLockTag.New
	local var_20_1 = arg_20_0:GetSceneMediator()

	return (var_20_0(var_3.InstantiateCharacterComponent(var_20_1, arg_20_0.TAG_NAME), arg_20_1))
end

function var_0_2.MakePopup(arg_21_0)
	local var_21_0 = arg_21_0:GetSceneMediator()

	return (var_1.InstantiateCharacterComponent(var_21_0, arg_21_0.POPUP_NAME))
end

function var_0_2.MakeArrowBar(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:GetSceneMediator()

	arg_22_1:AddArrowBar(var_22_0:InstantiateCharacterComponent(arg_22_0.ARROW_BAR_NAME))
	arg_22_1:UpdateArrowBarPosition()

	return
end

function var_0_2.MakeCastClock(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:GetSceneMediator()

	arg_23_1:AddCastClock(var_23_0:InstantiateCharacterComponent("CastClockContainer/castClock"))

	return
end

function var_0_2.MakeBuffClock(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0:GetSceneMediator()

	arg_24_1:AddBuffClock(var_24_0:InstantiateCharacterComponent("CastClockContainer/buffClock"))

	return
end

function var_0_2.MakeBarrierClock(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0:GetSceneMediator()

	arg_25_1:AddBarrierClock(var_25_0:InstantiateCharacterComponent("CastClockContainer/shieldClock"))

	return
end

function var_0_2.MakeVigilantBar(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0:GetSceneMediator()

	arg_26_1:AddVigilantBar(var_26_0:InstantiateCharacterComponent("AntiSubVigilantContainer/antiSubMeter"))
	arg_26_1:UpdateVigilantBarPosition()

	return
end

function var_0_2.MakeCloakBar(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0:GetSceneMediator()

	arg_27_1:AddCloakBar(var_27_0:InstantiateCharacterComponent("CloakContainer/cloakMeter"))
	arg_27_1:UpdateCloakBarPosition()

	return
end

function var_0_2.MakeSkinOrbit(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_1:GetUnitData()

	if var_2.GetSkinAttachmentInfo(var_28_0) then
		ipairs = var_28_0

		for iter_28_0, iter_28_1 in var_28_0(var_3) do
			local var_28_1 = var_0.Battle.BattleDataFunction.GetEquipSkinDataFromID(iter_28_1)

			if arg_28_1:IsDoubleChar() then
				local var_28_2 = var_0.Battle.BattleResourceManager.GetInstance()
				local var_28_3 = var_10.InstOrbit(var_28_2, var_28_1.orbit_combat)
				local var_28_4 = var_0.Battle.BattleResourceManager.GetInstance()
				local var_28_5 = var_11.InstOrbit(var_28_4, var_28_1.orbit_combat)

				if var_28_1.double_char_bone and #var_12 > 0 and var_12[1] == 1 then
					arg_28_1:AddOrbit(var_28_5, var_28_1, "char2")
				end

				if var_12 and #var_12 > 0 and var_12[2] == 1 then
					arg_28_1:AddOrbit(var_28_3, var_28_1)
				end

				if var_12 and #var_12 > 0 and var_12[3] == 1 then
					arg_28_1:AddOrbit(var_28_3, var_28_1, "char1")
				end
			else
				local var_28_6 = var_0.Battle.BattleResourceManager.GetInstance()
				local var_28_7 = var_10.InstOrbit(var_28_6, var_28_1.orbit_combat)

				arg_28_1:AddOrbit(var_28_7, var_28_1)
			end
		end
	end

	return
end

function var_0_2.RemoveCharacter(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_1:GetUnitData()

	if var_3.GetTemplate(var_29_0).nationality then
		table = var_29_0

		if var_29_0.contains(var_0_1.SWEET_DEATH_NATIONALITY, var_3) then
			goto label_29_0
		end
	end

	if arg_29_2 and arg_29_2 ~= var_0.Battle.BattleConst.UnitDeathReason.KILLED then
		-- block empty
	else
		local var_29_1 = arg_29_1:GetUnitData()
		local var_29_2 = var_4.GetDeadFX(var_29_1)
		local var_29_3 = arg_29_0:GetFXPool()
		local var_29_4, var_29_5 = var_5.GetFX(var_29_3, var_29_2 or arg_29_0.BOMB_FX_NAME)

		pg = var_7

		local var_29_6 = var_7.EffectMgr.GetInstance()

		var_7.PlayBattleEffect(var_29_6, var_29_4, var_29_5:Add(arg_29_1:GetPosition()), true)
	end

	::label_29_0::

	arg_29_1:Dispose()

	local var_29_7 = arg_29_0:GetFXPool()

	var_4.PushCharacterAttachPoint(var_29_7, arg_29_1:GetAttachPoint())

	return
end

function var_0_2.SwitchCharacterSpine(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0

	if arg_30_2 then
		var_30_0 = var_0.Battle.BattleDataFunction.GetPlayerShipSkinDataFromID(arg_30_2).prefab
	else
		var_30_0 = arg_30_1:GetModleID()
	end

	local function var_30_1(arg_31_0)
		local var_31_0 = arg_30_1

		var_1.SwitchModel(var_31_0, arg_31_0, arg_30_2)

		local var_31_1 = arg_30_1
		local var_31_2 = var_1.CameraOrthogonal
		local var_31_3 = var_0.Battle.BattleCameraUtil.GetInstance()

		var_31_2(var_31_1, var_3.GetCamera(var_31_3))

		return
	end

	local var_30_2 = arg_30_0:GetCharacterPool()

	var_5.InstCharacter(var_30_2, var_30_0, function(arg_32_0)
		var_30_1(arg_32_0)

		return
	end)

	return
end

return
