ys = ys or {}

local var_0_0 = ys.Battle.BattleConfig
local var_0_1 = singletonClass("BattleCharacterFactory")

ys.Battle.BattleCharacterFactory = var_0_1
var_0_1.__name = "BattleCharacterFactory"
var_0_1.HP_BAR_NAME = ""
var_0_1.POPUP_NAME = "popup"
var_0_1.TAG_NAME = "ChargeAreaContainer/LockTag"
var_0_1.MOVE_WAVE_FX_POS = Vector3(0, -2.3, -1.5)
var_0_1.MOVE_WAVE_FX_NAME = "movewave"
var_0_1.SMOKE_FX_NAME = "smoke"
var_0_1.BOMB_FX_NAME = "Bomb"
var_0_1.DANCHUAN_MOVE_WAVE_FX_NAME = "danchuanlanghuazhong2"

function var_0_1.Ctor(arg_1_0)
	return
end

function var_0_1.CreateCharacter(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0:MakeCharacter()

	var_2_0:SetFactory(arg_2_0)
	var_2_0:SetUnitData(arg_2_1.unit)
	arg_2_0:MakeModel(var_2_0)

	return var_2_0
end

function var_0_1.GetSceneMediator(arg_3_0)
	return var_0.Battle.BattleState.GetInstance():GetMediatorByName(var_0.Battle.BattleSceneMediator.__name)
end

function var_0_1.GetFXPool(arg_4_0)
	return var_0.Battle.BattleFXPool.GetInstance()
end

function var_0_1.GetCharacterPool(arg_5_0)
	return var_0.Battle.BattleResourceManager.GetInstance()
end

function var_0_1.GetHPBarPool(arg_6_0)
	return var_0.Battle.BattleHPBarManager.GetInstance()
end

function var_0_1.GetDivingFilterColor(arg_7_0)
	local var_7_0 = var_0.Battle.BattleDataFunction.GetDivingFilter(var_0.Battle.BattleDataProxy.GetInstance()._mapId)

	return (Color.New(var_7_0.r, var_7_0.g, var_7_0.b, var_7_0.a))
end

function var_0_1.GetFXContainerPool(arg_8_0)
	return var_0.Battle.BattleCharacterFXContainersPool.GetInstance()
end

function var_0_1.MakeCharacter(arg_9_0)
	return nil
end

function var_0_1.MakeModel(arg_10_0, arg_10_1)
	return nil
end

function var_0_1.MakeBloodBar(arg_11_0, arg_11_1)
	return nil
end

function var_0_1.MakeAimBiasBar(arg_12_0)
	return nil
end

function var_0_1.SetHPBarWidth(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_1:GetUnitData():GetTemplate().hp_bar[1]

	arg_13_2.transform.sizeDelta = Vector2(var_13_0, arg_13_2.transform.rect.height)

	local var_13_1 = arg_13_2.transform:Find("blood").transform
	local var_13_2 = var_13_0 + arg_13_3 or 0

	var_13_1.sizeDelta = Vector2(var_13_2, var_13_1.rect.height)

	return
end

function var_0_1.MakeUIComponentContainer(arg_14_0, arg_14_1)
	arg_14_1:AddUIComponentContainer()

	return
end

function var_0_1.MakeFXContainer(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1:GetTf()
	local var_15_1 = arg_15_0:GetFXPool():PopCharacterAttachPoint()

	SetActive(var_15_1.transform, true)
	var_15_1.transform:SetParent(var_15_0, false)

	var_15_1.transform.localPosition = Vector3.zero
	var_15_1.transform.localEulerAngles = Vector3(var_15_0.localEulerAngles.x * -1, var_15_0.localEulerAngles.y, var_15_0.localEulerAngles.z)

	local var_15_2 = arg_15_1:GetUnitData():GetTemplate().fx_container

	for iter_15_0, iter_15_1 in ipairs(var_0.Battle.BattleConst.FXContainerIndex) do
		({})[iter_15_0] = Vector3(var_15_2[iter_15_0][1], var_15_2[iter_15_0][2], var_15_2[iter_15_0][3])
	end

	arg_15_1:AddFXOffsets(var_15_1, {})

	return
end

function var_0_1.MakeShadow(arg_16_0)
	return nil
end

function var_0_1.MakeSmokeFX(arg_17_0, arg_17_1)
	for iter_17_0, iter_17_1 in ipairs(arg_17_1:GetUnitData():GetTemplate().smoke) do
		for iter_17_2, iter_17_3 in ipairs(iter_17_1[2]) do
			({}).unInitialize = true
			;({}).resID = iter_17_3[1]
			;({}).pos = Vector3(iter_17_3[2][1], iter_17_3[2][2], iter_17_3[2][3])
			;({})[{}] = false
		end

		;({})[iter_17_0] = {
			active = false,
			rate = iter_17_1[1] / 100,
			smokes = {}
		}
	end

	arg_17_1:AddSmokeFXs({})

	return
end

function var_0_1.MakeWaveFX(arg_18_0, arg_18_1)
	arg_18_1:AddWaveFX(arg_18_0.MOVE_WAVE_FX_NAME)

	return
end

function var_0_1.MakePopNumPool(arg_19_0, arg_19_1)
	arg_19_1:AddPopNumPool(arg_19_0:GetSceneMediator():GetPopNumPool())

	return
end

function var_0_1.MakeTag(arg_20_0, arg_20_1)
	return (var_0.Battle.BattleLockTag.New(arg_20_0:GetSceneMediator():InstantiateCharacterComponent(arg_20_0.TAG_NAME), arg_20_1))
end

function var_0_1.MakePopup(arg_21_0)
	return (arg_21_0:GetSceneMediator():InstantiateCharacterComponent(arg_21_0.POPUP_NAME))
end

function var_0_1.MakeArrowBar(arg_22_0, arg_22_1)
	arg_22_1:AddArrowBar(arg_22_0:GetSceneMediator():InstantiateCharacterComponent(arg_22_0.ARROW_BAR_NAME))
	arg_22_1:UpdateArrowBarPosition()

	return
end

function var_0_1.MakeCastClock(arg_23_0, arg_23_1)
	arg_23_1:AddCastClock(arg_23_0:GetSceneMediator():InstantiateCharacterComponent("CastClockContainer/castClock"))

	return
end

function var_0_1.MakeBuffClock(arg_24_0, arg_24_1)
	arg_24_1:AddBuffClock(arg_24_0:GetSceneMediator():InstantiateCharacterComponent("CastClockContainer/buffClock"))

	return
end

function var_0_1.MakeBarrierClock(arg_25_0, arg_25_1)
	arg_25_1:AddBarrierClock(arg_25_0:GetSceneMediator():InstantiateCharacterComponent("CastClockContainer/shieldClock"))

	return
end

function var_0_1.MakeVigilantBar(arg_26_0, arg_26_1)
	arg_26_1:AddVigilantBar(arg_26_0:GetSceneMediator():InstantiateCharacterComponent("AntiSubVigilantContainer/antiSubMeter"))
	arg_26_1:UpdateVigilantBarPosition()

	return
end

function var_0_1.MakeCloakBar(arg_27_0, arg_27_1)
	arg_27_1:AddCloakBar(arg_27_0:GetSceneMediator():InstantiateCharacterComponent("CloakContainer/cloakMeter"))
	arg_27_1:UpdateCloakBarPosition()

	return
end

function var_0_1.MakeSkinOrbit(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_1:GetUnitData():GetSkinAttachmentInfo()

	if var_28_0 then
		for iter_28_0, iter_28_1 in ipairs(var_28_0) do
			local var_28_1 = var_0.Battle.BattleDataFunction.GetEquipSkinDataFromID(iter_28_1)

			if arg_28_1:IsDoubleChar() then
				local var_28_2 = var_0.Battle.BattleResourceManager.GetInstance():InstOrbit(var_28_1.orbit_combat)
				local var_28_3 = var_0.Battle.BattleResourceManager.GetInstance():InstOrbit(var_28_1.orbit_combat)

				if var_28_1.double_char_bone and #var_28_1.double_char_bone > 0 and var_28_1.double_char_bone[1] == 1 then
					arg_28_1:AddOrbit(var_28_3, var_28_1, "char2")
				end

				if var_28_1.double_char_bone and #var_28_1.double_char_bone > 0 and var_28_1.double_char_bone[2] == 1 then
					arg_28_1:AddOrbit(var_28_2, var_28_1)
				end

				if var_28_1.double_char_bone and #var_28_1.double_char_bone > 0 and var_28_1.double_char_bone[3] == 1 then
					arg_28_1:AddOrbit(var_28_2, var_28_1, "char1")
				end
			else
				local var_28_4 = var_0.Battle.BattleResourceManager.GetInstance()

				arg_28_1:AddOrbit(var_28_4:InstOrbit(var_28_1.orbit_combat), var_28_1)
			end
		end
	end

	return
end

function var_0_1.RemoveCharacter(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_1:GetUnitData():GetTemplate().nationality

	if var_29_0 and table.contains(var_0_0.SWEET_DEATH_NATIONALITY, var_29_0) then
		-- block empty
	elseif arg_29_2 and arg_29_2 ~= var_0.Battle.BattleConst.UnitDeathReason.KILLED then
		-- block empty
	else
		local var_29_1 = arg_29_1:GetUnitData()
		local var_29_2, var_29_3 = arg_29_0:GetFXPool():GetFX(var_29_1:GetDeadFX() or arg_29_0.BOMB_FX_NAME)

		pg.EffectMgr.GetInstance():PlayBattleEffect(var_29_2, var_29_3:Add(arg_29_1:GetPosition()), true)
	end

	arg_29_1:Dispose()
	arg_29_0:GetFXPool():PushCharacterAttachPoint(arg_29_1:GetAttachPoint())

	return
end

function var_0_1.SwitchCharacterSpine(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_2 and var_0.Battle.BattleDataFunction.GetPlayerShipSkinDataFromID(arg_30_2).prefab or arg_30_1:GetModleID()

	local function var_30_1(arg_31_0)
		arg_30_1:SwitchModel(arg_31_0, arg_30_2)
		arg_30_1:CameraOrthogonal(var_0.Battle.BattleCameraUtil.GetInstance():GetCamera())

		return
	end

	arg_30_0:GetCharacterPool():InstCharacter(var_30_0, function(arg_32_0)
		var_30_1(arg_32_0)

		return
	end)

	return
end

return
