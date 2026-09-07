ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConfig
local var_0_2 = singletonClass("BattleCharacterFactory")

ys.Battle.BattleCharacterFactory = var_0_2
var_0_2.__name = "BattleCharacterFactory"
var_0_2.HP_BAR_NAME = ""
var_0_2.POPUP_NAME = "popup"
var_0_2.TAG_NAME = "ChargeAreaContainer/LockTag"
var_0_2.MOVE_WAVE_FX_POS = Vector3(0, -2.3, -1.5)
var_0_2.MOVE_WAVE_FX_NAME = "movewave"
var_0_2.SMOKE_FX_NAME = "smoke"
var_0_2.BOMB_FX_NAME = "Bomb"
var_0_2.DANCHUAN_MOVE_WAVE_FX_NAME = "danchuanlanghuazhong2"

function var_0_2.Ctor(arg_1_0)
	return
end

function var_0_2:CreateCharacter(arg_2_1)
	local var_2_0 = self:MakeCharacter()

	var_2_0:SetFactory(self)
	var_2_0:SetUnitData(arg_2_1.unit)
	self:MakeModel(var_2_0)

	return var_2_0
end

function var_0_2.GetSceneMediator(arg_3_0)
	return var_0_0.Battle.BattleState.GetInstance():GetMediatorByName(var_0_0.Battle.BattleSceneMediator.__name)
end

function var_0_2.GetFXPool(arg_4_0)
	return var_0_0.Battle.BattleFXPool.GetInstance()
end

function var_0_2.GetCharacterPool(arg_5_0)
	return var_0_0.Battle.BattleResourceManager.GetInstance()
end

function var_0_2.GetHPBarPool(arg_6_0)
	return var_0_0.Battle.BattleHPBarManager.GetInstance()
end

function var_0_2.GetDivingFilterColor(arg_7_0)
	local var_7_0 = var_0_0.Battle.BattleDataFunction.GetDivingFilter(var_0_0.Battle.BattleDataProxy.GetInstance()._mapId)

	return (Color.New(var_7_0.r, var_7_0.g, var_7_0.b, var_7_0.a))
end

function var_0_2.GetFXContainerPool(arg_8_0)
	return var_0_0.Battle.BattleCharacterFXContainersPool.GetInstance()
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
	local var_13_0 = arg_13_1:GetUnitData():GetTemplate().hp_bar[1]

	arg_13_2.transform.sizeDelta = Vector2(var_13_0, arg_13_2.transform.rect.height)

	local var_13_1 = arg_13_2.transform:Find("blood").transform

	var_13_1.sizeDelta = Vector2(var_13_0 + arg_13_3 or 0, var_13_1.rect.height)

	return
end

function var_0_2.MakeUIComponentContainer(arg_14_0, arg_14_1)
	arg_14_1:AddUIComponentContainer()

	return
end

function var_0_2:MakeFXContainer(arg_15_1)
	local var_15_0 = arg_15_1:GetTf()
	local var_15_1 = self:GetFXPool():PopCharacterAttachPoint()

	SetActive(var_15_1.transform, true)
	var_15_1.transform:SetParent(var_15_0, false)

	var_15_1.transform.localPosition = Vector3.zero
	var_15_1.transform.localEulerAngles = Vector3(var_15_0.localEulerAngles.x * -1, var_15_0.localEulerAngles.y, var_15_0.localEulerAngles.z)

	local var_15_2 = arg_15_1:GetUnitData():GetTemplate().fx_container
	local var_15_3 = {}

	for iter_15_0, iter_15_1 in ipairs(var_0_0.Battle.BattleConst.FXContainerIndex) do
		var_15_3[iter_15_0] = Vector3(var_15_2[iter_15_0][1], var_15_2[iter_15_0][2], var_15_2[iter_15_0][3])
	end

	arg_15_1:AddFXOffsets(var_15_1, var_15_3)

	return
end

function var_0_2.MakeShadow(arg_16_0)
	return nil
end

function var_0_2.MakeSmokeFX(arg_17_0, arg_17_1)
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_1:GetUnitData():GetTemplate().smoke) do
		local var_17_1 = {}

		for iter_17_2, iter_17_3 in ipairs(iter_17_1[2]) do
			local var_17_2 = {}

			var_17_2.unInitialize = true
			var_17_2.resID = iter_17_3[1]
			var_17_2.pos = Vector3(iter_17_3[2][1], iter_17_3[2][2], iter_17_3[2][3])
			var_17_1[var_17_2] = false
		end

		var_17_0[iter_17_0] = {
			active = false,
			rate = iter_17_1[1] / 100,
			smokes = var_17_1
		}
	end

	arg_17_1:AddSmokeFXs(var_17_0)

	return
end

function var_0_2:MakeWaveFX(arg_18_1)
	arg_18_1:AddWaveFX(self.MOVE_WAVE_FX_NAME)

	return
end

function var_0_2:MakePopNumPool(arg_19_1)
	arg_19_1:AddPopNumPool(self:GetSceneMediator():GetPopNumPool())

	return
end

function var_0_2:MakeTag(arg_20_1)
	return (var_0_0.Battle.BattleLockTag.New(self:GetSceneMediator():InstantiateCharacterComponent(self.TAG_NAME), arg_20_1))
end

function var_0_2:MakePopup()
	return (self:GetSceneMediator():InstantiateCharacterComponent(self.POPUP_NAME))
end

function var_0_2:MakeArrowBar(arg_22_1)
	arg_22_1:AddArrowBar(self:GetSceneMediator():InstantiateCharacterComponent(self.ARROW_BAR_NAME))
	arg_22_1:UpdateArrowBarPosition()

	return
end

function var_0_2:MakeCastClock(arg_23_1)
	arg_23_1:AddCastClock(self:GetSceneMediator():InstantiateCharacterComponent("CastClockContainer/castClock"))

	return
end

function var_0_2:MakeBuffClock(arg_24_1)
	arg_24_1:AddBuffClock(self:GetSceneMediator():InstantiateCharacterComponent("CastClockContainer/buffClock"))

	return
end

function var_0_2:MakeBarrierClock(arg_25_1)
	arg_25_1:AddBarrierClock(self:GetSceneMediator():InstantiateCharacterComponent("CastClockContainer/shieldClock"))

	return
end

function var_0_2:MakeVigilantBar(arg_26_1)
	arg_26_1:AddVigilantBar(self:GetSceneMediator():InstantiateCharacterComponent("AntiSubVigilantContainer/antiSubMeter"))
	arg_26_1:UpdateVigilantBarPosition()

	return
end

function var_0_2:MakeCloakBar(arg_27_1)
	arg_27_1:AddCloakBar(self:GetSceneMediator():InstantiateCharacterComponent("CloakContainer/cloakMeter"))
	arg_27_1:UpdateCloakBarPosition()

	return
end

function var_0_2.MakeSkinOrbit(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_1:GetUnitData():GetSkinAttachmentInfo()

	if var_28_0 then
		for iter_28_0, iter_28_1 in ipairs(var_28_0) do
			local var_28_1 = var_0_0.Battle.BattleDataFunction.GetEquipSkinDataFromID(iter_28_1)

			if arg_28_1:IsDoubleChar() then
				local var_28_2 = var_0_0.Battle.BattleResourceManager.GetInstance():InstOrbit(var_28_1.orbit_combat)

				if var_28_1.double_char_bone and #var_28_1.double_char_bone > 0 and var_28_1.double_char_bone[1] == 1 then
					arg_28_1:AddOrbit(var_0_0.Battle.BattleResourceManager.GetInstance():InstOrbit(var_28_1.orbit_combat), var_28_1, "char2")
				end

				if var_28_1.double_char_bone and #var_28_1.double_char_bone > 0 and var_28_1.double_char_bone[2] == 1 then
					arg_28_1:AddOrbit(var_28_2, var_28_1)
				end

				if var_28_1.double_char_bone and #var_28_1.double_char_bone > 0 and var_28_1.double_char_bone[3] == 1 then
					arg_28_1:AddOrbit(var_28_2, var_28_1, "char1")
				end
			else
				arg_28_1:AddOrbit(var_0_0.Battle.BattleResourceManager.GetInstance():InstOrbit(var_28_1.orbit_combat), var_28_1)
			end
		end
	end

	return
end

function var_0_2:RemoveCharacter(arg_29_1, arg_29_2)
	local var_29_0 = arg_29_1:GetUnitData():GetTemplate().nationality

	if var_29_0 and table.contains(var_0_1.SWEET_DEATH_NATIONALITY, var_29_0) then
		-- block empty
	elseif arg_29_2 and arg_29_2 ~= var_0_0.Battle.BattleConst.UnitDeathReason.KILLED then
		-- block empty
	else
		local var_29_1, var_29_2 = self:GetFXPool():GetFX(arg_29_1:GetUnitData():GetDeadFX() or self.BOMB_FX_NAME)

		pg.EffectMgr.GetInstance():PlayBattleEffect(var_29_1, var_29_2:Add(arg_29_1:GetPosition()), true)
	end

	arg_29_1:Dispose()
	self:GetFXPool():PushCharacterAttachPoint(arg_29_1:GetAttachPoint())

	return
end

function var_0_2:SwitchCharacterSpine(arg_30_1, arg_30_2)
	local function var_30_1(arg_31_0)
		arg_30_1:SwitchModel(arg_31_0, arg_30_2)
		arg_30_1:CameraOrthogonal(var_0_0.Battle.BattleCameraUtil.GetInstance():GetCamera())

		return
	end

	self:GetCharacterPool():InstCharacter(arg_30_2 and var_0_0.Battle.BattleDataFunction.GetPlayerShipSkinDataFromID(arg_30_2).prefab or arg_30_1:GetModleID(), function(arg_32_0)
		var_30_1(arg_32_0)

		return
	end)

	return
end

return
