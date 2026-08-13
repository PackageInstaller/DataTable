import = var_0_10000

local var_0_0 = var_0_10000(".DynamicCellView")

import = var_0_10001

local var_0_1 = var_0_10001(".SpineCellView")

class = var_2

local var_0_2 = "FleetCellView"

DecorateClass = var_0_10005

local var_0_3 = var_2(var_0_2, var_0_10005(var_0_0, var_0_1))

function var_0_3.Ctor(arg_1_0, arg_1_1)
	var_0_3.super.Ctor(arg_1_0, arg_1_1)
	var_0_1.Ctor(arg_1_0)
	var_0_1.InitCellTransform(arg_1_0)

	local var_1_0 = arg_1_0.tf

	arg_1_0.tfArrow = var_2.Find(var_1_0, "arrow")

	local var_1_1 = arg_1_0.tf

	arg_1_0.tfAmmo = var_2.Find(var_1_1, "ammo")

	local var_1_2 = arg_1_0.tfAmmo

	arg_1_0.tfAmmoText = var_2.Find(var_1_2, "text")

	local var_1_3 = arg_1_0.tf

	arg_1_0.tfOp = var_2.Find(var_1_3, "op")
	arg_1_0.tfIconRecorded = nil
	arg_1_0.RecordedFlag = nil

	return
end

function var_0_3.GetOrder(arg_2_0)
	ChapterConst = var_1_10001

	return var_1_10001.CellPriorityFleet
end

function var_0_3.showPoisonDamage(arg_3_0, arg_3_1)
	local var_3_0 = "dexiv4_SLG_poison"
	local var_3_1 = arg_3_0.tfShip.localPosition
	local var_3_2 = arg_3_0:GetLoader()

	var_4.GetPrefab(var_3_2, "ui/" .. var_3_0, var_3_0, function(arg_4_0)
		setParent = var_2_10001

		var_2_10001(arg_4_0.transform, arg_3_0.tf, false)

		LeanTween = var_2_10001

		local var_4_0 = var_2_10001.moveY(arg_3_0.tfShip, var_3_1.y - 10, 0.1)
		local var_4_1 = var_1.setEase

		LeanTweenType = var_4

		local var_4_2 = var_4_1(var_4_0, var_4.easeInOutSine)

		var_1.setLoopPingPong(var_4_2)

		local var_4_3 = arg_4_0
		local var_4_4 = arg_4_0.GetComponent

		typeof = var_4
		ParticleSystemEvent = var_2_10006

		local var_4_5 = var_4_4(var_4_3, var_4(var_2_10006))

		IsNil = var_2_10002

		if not var_2_10002(var_4_5) then
			var_4_5:AddEndEvent(function()
				arg_3_0.tfShip.localPosition = var_3_1

				local var_5_0 = arg_3_0.loader

				var_0.ClearRequest(var_5_0, "PoisonDamage")

				LeanTween = var_0

				var_0.cancel(arg_3_0.tfShip.gameObject)

				if arg_3_1 then
					arg_3_1()
				end

				return
			end)
		end

		return
	end, "PoisonDamage")

	return
end

function var_0_3.SetActiveNoPassIcon(arg_6_0, arg_6_1)
	local var_6_0 = "NoPassIcon"

	if not arg_6_1 then
		if arg_6_0.loader then
			local var_6_1 = arg_6_0.loader

			var_3.ClearRequest(var_6_1, var_6_0)
		end
	else
		local var_6_2 = arg_6_0:GetLoader()

		if var_3.GetRequestPackage(var_6_2, var_6_0) then
			return
		end

		local var_6_3 = "event_task_small"
		local var_6_4 = arg_6_0:GetLoader()

		var_5.GetPrefabBYStopLoading(var_6_4, "boxprefab/" .. var_6_3, var_6_3, function(arg_7_0)
			setParent = var_2_10001

			var_2_10001(arg_7_0.transform, arg_6_0.tf, false)

			local var_7_0 = 150

			setLocalPosition = var_2_10002

			local var_7_1 = arg_7_0

			Vector3 = var_5

			var_2_10002(var_7_1, var_5(0, var_7_0, 0))

			LeanTween = var_2_10002

			local var_7_2 = var_2_10002.moveY

			rtf = var_7_1

			local var_7_3 = var_7_2(var_7_1(arg_7_0), var_7_0 - 10, 1)
			local var_7_4 = var_2.setEase

			LeanTweenType = var_5

			local var_7_5 = var_7_4(var_7_3, var_5.easeInOutSine)

			var_2.setLoopPingPong(var_7_5)

			return
		end, var_6_0)
	end

	return
end

function var_0_3.UpdateIconRecordedFlag(arg_8_0, arg_8_1)
	arg_8_0.RecordedFlag = arg_8_1

	arg_8_0:UpdateIconRecorded()

	return
end

function var_0_3.UpdateIconRecorded(arg_9_0)
	local var_9_0

	if arg_9_0.RecordedFlag then
		var_9_0 = arg_9_0.visible
	end

	if not var_9_0 then
		IsNil = var_1_10002

		if not var_1_10002(arg_9_0.tfIconRecorded) then
			setActive = var_1_10002

			var_1_10002(arg_9_0.tfIconRecorded, false)
		end
	else
		IsNil = var_1_10002

		if var_1_10002(arg_9_0.tfIconRecorded) then
			pg = var_2

			local var_9_1 = var_2.PoolMgr.GetInstance()

			var_2.GetPrefab(var_9_1, "effect/fleet_status_recorded", "", false, function(arg_10_0)
				local var_10_0 = arg_9_0

				tf = var_2_10002
				var_10_0.tfIconRecorded = var_2_10002(arg_10_0)
				setParent = var_10_0

				var_10_0(arg_10_0, arg_9_0.tf, false)

				return
			end)
		end

		setActive = var_2

		var_2(arg_9_0.tfIconRecorded, true)
	end

	return
end

function var_0_3.TweenShining(arg_11_0)
	local var_11_0 = arg_11_0

	if not arg_11_0.GetSpineRole(var_11_0) then
		return
	end

	Color = var_1_10002

	local var_11_1 = var_1_10002.black

	Color = var_11_0

	local var_11_2 = var_11_0.gray

	var_11_1.a = 0
	var_11_2.a = 0

	var_1:TweenShining(0.2, 2, 0, 1, var_11_1, var_11_2, true, true)

	return
end

function var_0_3.SetSpineVisible(arg_12_0, arg_12_1)
	arg_12_0.visible = arg_12_1

	var_0_3.super.SetSpineVisible(arg_12_0, arg_12_1)

	setActive = var_2

	var_2(arg_12_0.tfShadow, arg_12_1)
	arg_12_0:UpdateIconRecorded()

	return
end

function var_0_3.StopTween(arg_13_0)
	if not arg_13_0:GetSpineRole() then
		return
	end

	var_1:StopTweenShining()

	return
end

function var_0_3.unloadSpine(arg_14_0)
	var_0_3.super.UnloadSpine(arg_14_0)

	return
end

function var_0_3.OnCanvasUpDate(arg_15_0)
	var_0_1.UpdateSortingOrder(arg_15_0)

	return
end

function var_0_3.Clear(arg_16_0)
	var_0_1.ClearSpine(arg_16_0)
	var_0_3.super.Clear(arg_16_0)

	return
end

return var_0_3
