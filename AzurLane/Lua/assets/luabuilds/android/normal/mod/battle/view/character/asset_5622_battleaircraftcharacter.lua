ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleUnitEvent
local var_0_2 = var_0.Battle

class = var_0_10003
var_0_2.BattleAircraftCharacter = var_0_10003("BattleAircraftCharacter", var_0.Battle.BattleCharacter)
var_0.Battle.BattleAircraftCharacter.__name = "BattleAircraftCharacter"

local var_0_3 = var_0.Battle.BattleAircraftCharacter

function var_0_3.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	Vector3 = var_1
	arg_1_0._hpBarOffset = var_1(0, 1.6, 0)

	arg_1_0:SetYShakeMin()
	arg_1_0:SetYShakeMax()

	Vector3 = var_1
	arg_1_0.shadowScale = var_1.one
	Vector3 = var_1
	arg_1_0.shadowPos = var_1.zero

	return
end

function var_0_3.SetUnitData(arg_2_0, arg_2_1)
	arg_2_0._unitData = arg_2_1

	arg_2_0:AddUnitEvent()

	return
end

function var_0_3.InitWeapon(arg_3_0)
	local var_3_0 = arg_3_0._unitData

	arg_3_0._weapon = var_1.GetWeapon(var_3_0)
	ipairs = var_1

	for iter_3_0, iter_3_1 in var_1(arg_3_0._weapon) do
		iter_3_1:RegisterEventListener(arg_3_0, var_0_1.CREATE_BULLET, arg_3_0.onCreateBullet)
	end

	return
end

function var_0_3.GetModleID(arg_4_0)
	local var_4_0 = arg_4_0._unitData

	return var_1.GetSkinID(var_4_0)
end

function var_0_3.GetInitScale(arg_5_0)
	return 1
end

function var_0_3.AddUnitEvent(arg_6_0)
	return
end

function var_0_3.RemoveUnitEvent(arg_7_0)
	ipairs = var_1_10001

	for iter_7_0, iter_7_1 in var_1_10001(arg_7_0._weapon) do
		iter_7_1:UnregisterEventListener(arg_7_0, var_0_1.CREATE_BULLET)
	end

	local var_7_0 = arg_7_0._unitData

	if var_1.GetIFF(var_7_0) == var_0.Battle.BattleConfig.FOE_CODE then
		local var_7_1 = arg_7_0._unitData

		var_1.UnregisterEventListener(var_7_1, arg_7_0, var_0_1.UPDATE_AIR_CRAFT_HP)
	end

	return
end

function var_0_3.PlayAction(arg_8_0)
	return
end

function var_0_3.Update(arg_9_0)
	arg_9_0:UpdateMatrix()
	arg_9_0:UpdateDirection()
	arg_9_0:UpdateUIComponentPosition()
	arg_9_0:UpdateShadow()
	arg_9_0:UpdatePosition()

	local var_9_0 = arg_9_0._unitData

	if var_1.GetIFF(var_9_0) == var_0.Battle.BattleConfig.FOE_CODE then
		arg_9_0:UpdateHPPop()
		arg_9_0:UpdateHPPopContainerPosition()
		arg_9_0:UpdateHPBarPosition()
		arg_9_0:UpdateHpBar()
	end

	return
end

function var_0_3.UpdatePosition(arg_10_0)
	local var_10_0 = arg_10_0._unitData

	if not var_1.IsOutViewBound(var_10_0) then
		local var_10_1 = arg_10_0._tf
		local var_10_2 = arg_10_0._unitData

		var_10_1.localPosition = var_2.GetPosition(var_10_2)
	end

	local var_10_3 = arg_10_0._unitData

	arg_10_0._characterPos = var_1.GetPosition(var_10_3)

	return
end

function var_0_3.UpdateDirection(arg_11_0)
	local var_11_0 = arg_11_0._unitData

	if var_1.GetCurrentState(var_11_0) ~= arg_11_0._unitData.STATE_CREATE then
		return
	end

	local var_11_1 = arg_11_0._unitData
	local var_11_2 = var_1.GetSize(var_11_1)
	local var_11_3 = arg_11_0._unitData

	if var_2.GetDirection(var_11_3) == var_0.Battle.BattleConst.UnitDir.RIGHT then
		local var_11_4 = arg_11_0._tf

		Vector3 = var_3
		var_11_4.localScale = var_3(var_11_2, var_11_2, var_11_2)
	else
		local var_11_5 = arg_11_0._unitData

		if var_2.GetDirection(var_11_5) == var_0.Battle.BattleConst.UnitDir.LEFT then
			local var_11_6 = arg_11_0._tf

			Vector3 = var_3
			var_11_6.localScale = var_3(-var_11_2, var_11_2, var_11_2)
		end
	end

	return
end

function var_0_3.UpdateHPBarPosition(arg_12_0)
	local var_12_0 = arg_12_0._hpBarPos
	local var_12_1 = var_1.Copy(var_12_0, arg_12_0._referenceVector)

	var_1.Add(var_12_1, arg_12_0._hpBarOffset)

	arg_12_0._HPBarTf.position = arg_12_0._hpBarPos

	return
end

function var_0_3.UpdateShadow(arg_13_0)
	if arg_13_0._shadow then
		local var_13_0 = arg_13_0._unitData

		if var_1.GetCurrentState(var_13_0) == arg_13_0._unitData.STATE_CREATE then
			local var_13_1 = arg_13_0._unitData
			local var_13_2 = var_1.GetPosition(var_13_1)

			math = var_13_1

			local var_13_3 = var_13_1.min
			local var_13_4 = 4

			math = var_1_10004

			local var_13_5 = var_13_3(var_13_4, var_1_10004.max(2, 4 - 4 * var_13_2.y / var_0.Battle.BattleConfig.AircraftHeight))

			arg_13_0.shadowScale.x, arg_13_0.shadowScale.z = var_13_5, var_13_5
			arg_13_0._shadowTF.localScale = arg_13_0.shadowScale
			arg_13_0.shadowPos.x, arg_13_0.shadowPos.z = var_13_2.x, var_13_2.z
			arg_13_0._shadowTF.position = arg_13_0.shadowPos
		end
	end

	return
end

function var_0_3.GetYShake(arg_14_0)
	local var_14_0

	if not arg_14_0._YShakeCurrent then
		var_14_0 = 0
	end

	arg_14_0._YShakeCurrent = var_14_0

	local var_14_1

	if not arg_14_0._YShakeDir then
		var_14_1 = 1
	end

	arg_14_0._YShakeDir = var_14_1
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

function var_0_3.SetYShakeMin(arg_15_0)
	math = var_1_10001
	arg_15_0._YShakeMin = -1 - 2 * var_1_10001.random()

	return
end

function var_0_3.SetYShakeMax(arg_16_0)
	math = var_1_10001
	arg_16_0._YShakeMax = 1 + 2 * var_1_10001.random()

	return
end

function var_0_3.AddModel(arg_17_0, arg_17_1)
	arg_17_0:SetGO(arg_17_1)

	Vector3 = var_2

	local var_17_0 = 0
	local var_17_1 = arg_17_0._unitData

	arg_17_0._hpBarOffset = var_2(var_17_0, var_4.GetBoxSize(var_17_1).y, 0)

	arg_17_0:SetBoneList()

	local var_17_2 = arg_17_0._tf
	local var_17_3 = arg_17_0._unitData

	var_17_2.position = var_3.GetPosition(var_17_3)

	arg_17_0:UpdateMatrix()

	local var_17_4 = arg_17_0._unitData

	var_2.ActiveCldBox(var_17_4)

	return
end

function var_0_3.AddShadow(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:GetTf()

	arg_18_0._shadow = var_2.Find(var_18_0, "model/shadow").gameObject
	arg_18_0._shadowTF = arg_18_0._shadow.transform

	return
end

function var_0_3.AddHPBar(arg_19_0, arg_19_1)
	arg_19_0._HPBar = arg_19_1
	arg_19_0._HPBarTf = arg_19_1.transform

	local var_19_0 = arg_19_0._HPBarTf
	local var_19_1 = var_2.Find(var_19_0, "blood")
	local var_19_2 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_19_0._HPProgress = var_19_2(var_19_1, var_4(var_1_10005))

	arg_19_1:SetActive(true)

	local var_19_3 = arg_19_0._unitData

	var_2.RegisterEventListener(var_19_3, arg_19_0, var_0_1.UPDATE_AIR_CRAFT_HP, arg_19_0.OnUpdateHP)
	arg_19_0:UpdateHpBar()

	return
end

function var_0_3.updateSomkeFX(arg_20_0)
	return
end

return
