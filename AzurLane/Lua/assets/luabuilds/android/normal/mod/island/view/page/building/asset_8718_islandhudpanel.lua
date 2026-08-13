class = var_0_10000

local var_0_0 = "IslandHudPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("Mod.Island.Core.View.IslandBaseUnit"))

function var_0_1.Init(arg_1_0, ...)
	PoolMgr = var_1_10001

	local var_1_0 = var_1_10001.GetInstance()

	var_1.GetUI(var_1_0, arg_1_0:GetUIName(), true, function(arg_2_0)
		arg_1_0._go = arg_2_0
		arg_1_0._tf = arg_2_0.transform

		var_0_1.super.Init(arg_1_0, arg_2_0)

		setParent = var_1

		var_1(arg_2_0, arg_1_0.parentTF)

		local var_2_0 = arg_2_0.transform

		var_1.SetAsFirstSibling(var_2_0)

		return
	end)

	return
end

function var_0_1.Ctor(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.super.Ctor(arg_3_0, arg_3_2)

	arg_3_0.parentTF = arg_3_1

	arg_3_0:InitHudHeight()

	return
end

function var_0_1.GetUIName(arg_4_0)
	return "IslandCollectHud"
end

function var_0_1.OnInit(arg_5_0, arg_5_1)
	assert = var_1_10002

	var_1_10002(arg_5_1)

	arg_5_0._go = arg_5_1
	arg_5_0._tf = arg_5_1.transform

	local var_5_0 = arg_5_0._tf

	arg_5_0.name = var_2.Find(var_5_0, "name_bg/name")

	local var_5_1 = arg_5_0._tf

	arg_5_0.productIcon = var_2.Find(var_5_1, "productIcon")

	local var_5_2 = arg_5_0._tf

	arg_5_0.timeTF = var_2.Find(var_5_2, "process/layout/time")

	local var_5_3 = arg_5_0._tf

	arg_5_0.energyTF = var_2.Find(var_5_3, "process/layout/enrgy_bar")

	local var_5_4 = arg_5_0._tf

	arg_5_0.numProcessTF = var_2.Find(var_5_4, "name_bg/name/numer")
	pg = var_2
	arg_5_0.timeMgr = var_2.TimeMgr.GetInstance()

	arg_5_0:UpdateHudDisplay()

	return
end

function var_0_1.InitHudHeight(arg_6_0)
	arg_6_0.heightUnitDic = {}
	pg = var_1

	local var_6_0 = var_1.island_set.information_hud_height.key_value_varchar[2]

	pairs = var_1_10002
	pg = var_1_10003

	for iter_6_0, iter_6_1 in var_1_10002(var_1_10003.island_set.information_hud_height.key_value_varchar[1]) do
		arg_6_0.heightUnitDic[iter_6_1] = var_6_0
	end

	return
end

function var_0_1.ShowUnitHud(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.unitId = arg_7_1
	pg = var_1_10004
	arg_7_0.position = var_1_10004.island_world_objects[arg_7_0.unitId].param.position
	arg_7_0.height = arg_7_3 or 1

	arg_7_0:UpdateUnitHud(arg_7_2)

	return
end

function var_0_1.UpdateUnitHud(arg_8_0, arg_8_1)
	arg_8_0.hudInfo = arg_8_1

	if arg_8_0:IsLoaded() then
		arg_8_0:UpdateHudDisplay()
	end

	return
end

function var_0_1.UpdateHudDisplay(arg_9_0)
	setActive = var_1_10001

	var_1_10001(arg_9_0._tf, arg_9_0.active)

	if arg_9_0.hudInfo.name then
		setActive = var_1

		var_1(arg_9_0.name, true)

		setText = var_1

		var_1(arg_9_0.name, arg_9_0.hudInfo.name)
	else
		setActive = var_1

		var_1(arg_9_0.name, false)
	end

	local var_9_0

	if arg_9_0.hudInfo.hudState then
		var_9_0 = arg_9_0.hudInfo.hudState
		setActive = var_2

		var_2(arg_9_0.timeTF, true)

		if var_9_0.stateEndTime then
			arg_9_0:UpdateTime(var_9_0)
		else
			setText = var_2

			var_2(arg_9_0.timeTF, var_9_0.stateText)
		end
	else
		setActive = var_9_0

		var_9_0(arg_9_0.timeTF, false)
	end

	if arg_9_0.hudInfo.process then
		setActive = var_1

		var_1(arg_9_0.energyTF, true)

		setSlider = var_1

		var_1(arg_9_0.energyTF, 0, 1, arg_9_0.hudInfo.process)
	else
		setActive = var_1

		var_1(arg_9_0.energyTF, false)
	end

	if arg_9_0.hudInfo.numProcess then
		setActive = var_1

		var_1(arg_9_0.numProcessTF, true)

		setText = var_1

		var_1(arg_9_0.numProcessTF, arg_9_0.hudInfo.numProcess)
	else
		setActive = var_1

		var_1(arg_9_0.numProcessTF, false)
	end

	if arg_9_0.hudInfo.itemIcon then
		GetImageSpriteFromAtlasAsync = var_1

		var_1(arg_9_0.hudInfo.itemIcon, "", arg_9_0.productIcon)
	end

	return
end

function var_0_1.HideHud(arg_10_0)
	if arg_10_0._tf then
		setActive = var_1

		var_1(arg_10_0._tf, false)

		arg_10_0.active = false
	end

	return
end

function var_0_1.UpdateTime(arg_11_0, arg_11_1)
	if not arg_11_1 then
		return
	end

	if arg_11_1.stateEndTime then
		local var_11_0 = arg_11_1.stateEndTime
		local var_11_1 = arg_11_0.timeMgr
		local var_11_2 = var_11_0 - var_3.GetServerTime(var_11_1)

		if 0 < var_11_2 then
			setText = var_3

			local var_11_3 = arg_11_0.timeTF
			local var_11_4 = arg_11_0.timeMgr

			var_3(var_11_3, var_5.DescCDTime(var_11_4, var_11_2))
		end
	end

	return
end

function var_0_1.Update(arg_12_0)
	if not arg_12_0:IsLoaded() then
		return
	end

	arg_12_0:UpdateTime(arg_12_0.hudInfo.hudState)

	return
end

function var_0_1.LateUpdate(arg_13_0)
	if not arg_13_0:IsLoaded() then
		return
	end

	Vector3 = var_1

	local var_13_0 = var_1(arg_13_0.position[1], arg_13_0.position[2], arg_13_0.position[3])

	Vector3 = var_2

	local var_13_1 = var_13_0 + var_2(0, arg_13_0.height, 0)

	IslandCalcUtil = var_3

	if not var_3.IsInViewport(var_13_1) then
		setActive = var_3

		var_3(arg_13_0._tf, false)
	else
		setActive = var_3

		var_3(arg_13_0._tf, true)

		IslandCalcUtil = var_3

		local var_13_2 = var_3.WorldPosition2LocalPosition(arg_13_0.parentTF, var_13_1)

		arg_13_0._tf.localPosition = var_13_2
	end

	return
end

function var_0_1.OnDispose(arg_14_0)
	PoolMgr = var_1_10001

	local var_14_0 = var_1_10001.GetInstance()

	var_1.ReturnUI(var_14_0, arg_14_0:GetUIName(), arg_14_0._go)

	return
end

function var_0_1.Clear(arg_15_0)
	return
end

return var_0_1
