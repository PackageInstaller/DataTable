ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleUnitEvent

ys.Battle.BattleAircraftCharacter = class("BattleAircraftCharacter", ys.Battle.BattleCharacter)
ys.Battle.BattleAircraftCharacter.__name = "BattleAircraftCharacter"

local var_0_2 = ys.Battle.BattleAircraftCharacter

function ys.Battle.BattleAircraftCharacter.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	arg_1_0._hpBarOffset = Vector3(0, 1.6, 0)

	arg_1_0:SetYShakeMin()
	arg_1_0:SetYShakeMax()

	arg_1_0.shadowScale = Vector3.one
	arg_1_0.shadowPos = Vector3.zero

	return
end

function ys.Battle.BattleAircraftCharacter.SetUnitData(arg_2_0, arg_2_1)
	arg_2_0._unitData = arg_2_1

	arg_2_0:AddUnitEvent()

	return
end

function ys.Battle.BattleAircraftCharacter.InitWeapon(arg_3_0)
	arg_3_0._weapon = arg_3_0._unitData:GetWeapon()

	for iter_3_0, iter_3_1 in ipairs(arg_3_0._weapon) do
		iter_3_1:RegisterEventListener(arg_3_0, var_0_1.CREATE_BULLET, arg_3_0.onCreateBullet)
	end

	return
end

function ys.Battle.BattleAircraftCharacter.GetModleID(arg_4_0)
	return arg_4_0._unitData:GetSkinID()
end

function ys.Battle.BattleAircraftCharacter.GetInitScale(arg_5_0)
	return 1
end

function ys.Battle.BattleAircraftCharacter.AddUnitEvent(arg_6_0)
	return
end

function ys.Battle.BattleAircraftCharacter.RemoveUnitEvent(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0._weapon) do
		iter_7_1:UnregisterEventListener(arg_7_0, var_0_1.CREATE_BULLET)
	end

	if arg_7_0._unitData:GetIFF() == var_0_0.Battle.BattleConfig.FOE_CODE then
		arg_7_0._unitData:UnregisterEventListener(arg_7_0, var_0_1.UPDATE_AIR_CRAFT_HP)
	end

	return
end

function ys.Battle.BattleAircraftCharacter.PlayAction(arg_8_0)
	return
end

function ys.Battle.BattleAircraftCharacter.Update(arg_9_0)
	arg_9_0:UpdateMatrix()
	arg_9_0:UpdateDirection()
	arg_9_0:UpdateUIComponentPosition()
	arg_9_0:UpdateShadow()
	arg_9_0:UpdatePosition()

	if arg_9_0._unitData:GetIFF() == var_0_0.Battle.BattleConfig.FOE_CODE then
		arg_9_0:UpdateHPPop()
		arg_9_0:UpdateHPPopContainerPosition()
		arg_9_0:UpdateHPBarPosition()
		arg_9_0:UpdateHpBar()
	end

	return
end

function ys.Battle.BattleAircraftCharacter.UpdatePosition(arg_10_0)
	if not arg_10_0._unitData:IsOutViewBound() then
		arg_10_0._tf.localPosition = arg_10_0._unitData:GetPosition()
	end

	arg_10_0._characterPos = arg_10_0._unitData:GetPosition()

	return
end

function ys.Battle.BattleAircraftCharacter.UpdateDirection(arg_11_0)
	if arg_11_0._unitData:GetCurrentState() ~= arg_11_0._unitData.STATE_CREATE then
		return
	end

	local var_11_0 = arg_11_0._unitData:GetSize()

	if arg_11_0._unitData:GetDirection() == var_0_0.Battle.BattleConst.UnitDir.RIGHT then
		arg_11_0._tf.localScale = Vector3(var_11_0, var_11_0, var_11_0)
	elseif arg_11_0._unitData:GetDirection() == var_0_0.Battle.BattleConst.UnitDir.LEFT then
		arg_11_0._tf.localScale = Vector3(-var_11_0, var_11_0, var_11_0)
	end

	return
end

function ys.Battle.BattleAircraftCharacter.UpdateHPBarPosition(arg_12_0)
	arg_12_0._hpBarPos:Copy(arg_12_0._referenceVector):Add(arg_12_0._hpBarOffset)

	arg_12_0._HPBarTf.position = arg_12_0._hpBarPos

	return
end

function ys.Battle.BattleAircraftCharacter.UpdateShadow(arg_13_0)
	if arg_13_0._shadow and arg_13_0._unitData:GetCurrentState() == arg_13_0._unitData.STATE_CREATE then
		local var_13_0 = arg_13_0._unitData:GetPosition()
		local var_13_1 = math.min(4, math.max(2, 4 - 4 * var_13_0.y / var_0_0.Battle.BattleConfig.AircraftHeight))

		arg_13_0.shadowScale.x, arg_13_0.shadowScale.z = var_13_1, var_13_1
		arg_13_0._shadowTF.localScale = arg_13_0.shadowScale
		arg_13_0.shadowPos.x, arg_13_0.shadowPos.z = var_13_0.x, var_13_0.z
		arg_13_0._shadowTF.position = arg_13_0.shadowPos
	end

	return
end

function ys.Battle.BattleAircraftCharacter.GetYShake(arg_14_0)
	arg_14_0._YShakeCurrent = arg_14_0._YShakeCurrent or 0
	arg_14_0._YShakeDir = arg_14_0._YShakeDir or 1
	arg_14_0._YShakeCurrent = arg_14_0._YShakeCurrent + 0.1 * arg_14_0._YShakeDir

	if arg_14_0._YShakeCurrent > arg_14_0._YShakeMax and arg_14_0._YShakeDir == 1 then
		arg_14_0._YShakeDir = -1

		arg_14_0:SetYShakeMin()
	elseif arg_14_0._YShakeCurrent < arg_14_0._YShakeMin and arg_14_0._YShakeDir == -1 then
		arg_14_0._YShakeDir = 1

		arg_14_0:SetYShakeMax()
	end

	return arg_14_0._YShakeCurrent
end

function ys.Battle.BattleAircraftCharacter.SetYShakeMin(arg_15_0)
	arg_15_0._YShakeMin = -1 - 2 * math.random()

	return
end

function ys.Battle.BattleAircraftCharacter.SetYShakeMax(arg_16_0)
	arg_16_0._YShakeMax = 1 + 2 * math.random()

	return
end

function ys.Battle.BattleAircraftCharacter.AddModel(arg_17_0, arg_17_1)
	arg_17_0:SetGO(arg_17_1)

	arg_17_0._hpBarOffset = Vector3(0, arg_17_0._unitData:GetBoxSize().y, 0)

	arg_17_0:SetBoneList()

	arg_17_0._tf.position = arg_17_0._unitData:GetPosition()

	arg_17_0:UpdateMatrix()
	arg_17_0._unitData:ActiveCldBox()

	return
end

function ys.Battle.BattleAircraftCharacter.AddShadow(arg_18_0, arg_18_1)
	arg_18_0._shadow = arg_18_0:GetTf():Find("model/shadow").gameObject
	arg_18_0._shadowTF = arg_18_0._shadow.transform

	return
end

function ys.Battle.BattleAircraftCharacter.AddHPBar(arg_19_0, arg_19_1)
	arg_19_0._HPBar = arg_19_1
	arg_19_0._HPBarTf = arg_19_1.transform
	arg_19_0._HPProgress = arg_19_0._HPBarTf:Find("blood"):GetComponent(typeof(Image))

	arg_19_1:SetActive(true)
	arg_19_0._unitData:RegisterEventListener(arg_19_0, var_0_1.UPDATE_AIR_CRAFT_HP, arg_19_0.OnUpdateHP)
	arg_19_0:UpdateHpBar()

	return
end

function ys.Battle.BattleAircraftCharacter.updateSomkeFX(arg_20_0)
	return
end

return
