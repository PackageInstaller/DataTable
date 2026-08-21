local var_0_0 = class("IslandHudPanel", import("Mod.Island.Core.View.IslandBaseUnit"))

function var_0_0.Init(arg_1_0, ...)
	PoolMgr.GetInstance():GetUI(arg_1_0:GetUIName(), true, function(arg_2_0)
		arg_1_0._go = arg_2_0
		arg_1_0._tf = arg_2_0.transform

		var_0_0.super.Init(arg_1_0, arg_2_0)
		setParent(arg_2_0, arg_1_0.parentTF)
		arg_2_0.transform:SetAsFirstSibling()

		return
	end)

	return
end

function var_0_0.Ctor(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.super.Ctor(arg_3_0, arg_3_2)

	arg_3_0.parentTF = arg_3_1

	arg_3_0:InitHudHeight()

	return
end

function var_0_0.GetUIName(arg_4_0)
	return "IslandCollectHud"
end

function var_0_0.OnInit(arg_5_0, arg_5_1)
	assert(arg_5_1)

	arg_5_0._go = arg_5_1
	arg_5_0._tf = arg_5_1.transform
	arg_5_0.name = arg_5_0._tf:Find("name_bg/name")
	arg_5_0.productIcon = arg_5_0._tf:Find("productIcon")
	arg_5_0.timeTF = arg_5_0._tf:Find("process/layout/time")
	arg_5_0.energyTF = arg_5_0._tf:Find("process/layout/enrgy_bar")
	arg_5_0.numProcessTF = arg_5_0._tf:Find("name_bg/name/numer")
	arg_5_0.timeMgr = pg.TimeMgr.GetInstance()

	arg_5_0:UpdateHudDisplay()

	return
end

function var_0_0.InitHudHeight(arg_6_0)
	arg_6_0.heightUnitDic = {}

	for iter_6_0, iter_6_1 in pairs(pg.island_set.information_hud_height.key_value_varchar[1]) do
		arg_6_0.heightUnitDic[iter_6_1] = pg.island_set.information_hud_height.key_value_varchar[2]
	end

	return
end

function var_0_0.ShowUnitHud(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.unitId = arg_7_1
	arg_7_0.position = pg.island_world_objects[arg_7_0.unitId].param.position
	arg_7_0.height = arg_7_3 or 1

	arg_7_0:UpdateUnitHud(arg_7_2)

	return
end

function var_0_0.UpdateUnitHud(arg_8_0, arg_8_1)
	arg_8_0.hudInfo = arg_8_1

	if arg_8_0:IsLoaded() then
		arg_8_0:UpdateHudDisplay()
	end

	return
end

function var_0_0.UpdateHudDisplay(arg_9_0)
	setActive(arg_9_0._tf, arg_9_0.active)

	if arg_9_0.hudInfo.name then
		setActive(arg_9_0.name, true)
		setText(arg_9_0.name, arg_9_0.hudInfo.name)
	else
		setActive(arg_9_0.name, false)
	end

	if arg_9_0.hudInfo.hudState then
		setActive(arg_9_0.timeTF, true)

		if arg_9_0.hudInfo.hudState.stateEndTime then
			arg_9_0:UpdateTime(arg_9_0.hudInfo.hudState)
		else
			setText(arg_9_0.timeTF, arg_9_0.hudInfo.hudState.stateText)
		end
	else
		setActive(arg_9_0.timeTF, false)
	end

	if arg_9_0.hudInfo.process then
		setActive(arg_9_0.energyTF, true)
		setSlider(arg_9_0.energyTF, 0, 1, arg_9_0.hudInfo.process)
	else
		setActive(arg_9_0.energyTF, false)
	end

	if arg_9_0.hudInfo.numProcess then
		setActive(arg_9_0.numProcessTF, true)
		setText(arg_9_0.numProcessTF, arg_9_0.hudInfo.numProcess)
	else
		setActive(arg_9_0.numProcessTF, false)
	end

	if arg_9_0.hudInfo.itemIcon then
		GetImageSpriteFromAtlasAsync(arg_9_0.hudInfo.itemIcon, "", arg_9_0.productIcon)
	end

	return
end

function var_0_0.HideHud(arg_10_0)
	if arg_10_0._tf then
		setActive(arg_10_0._tf, false)

		arg_10_0.active = false
	end

	return
end

function var_0_0.UpdateTime(arg_11_0, arg_11_1)
	if not arg_11_1 then
		return
	end

	if arg_11_1.stateEndTime then
		local var_11_0 = arg_11_1.stateEndTime - arg_11_0.timeMgr:GetServerTime()

		if var_11_0 > 0 then
			setText(arg_11_0.timeTF, arg_11_0.timeMgr:DescCDTime(var_11_0))
		end
	end

	return
end

function var_0_0.Update(arg_12_0)
	if not arg_12_0:IsLoaded() then
		return
	end

	arg_12_0:UpdateTime(arg_12_0.hudInfo.hudState)

	return
end

function var_0_0.LateUpdate(arg_13_0)
	if not arg_13_0:IsLoaded() then
		return
	end

	local var_13_0 = Vector3(arg_13_0.position[1], arg_13_0.position[2], arg_13_0.position[3]) + Vector3(0, arg_13_0.height, 0)

	if not IslandCalcUtil.IsInViewport(var_13_0) then
		setActive(arg_13_0._tf, false)
	else
		setActive(arg_13_0._tf, true)

		arg_13_0._tf.localPosition = IslandCalcUtil.WorldPosition2LocalPosition(arg_13_0.parentTF, var_13_0)
	end

	return
end

function var_0_0.OnDispose(arg_14_0)
	PoolMgr.GetInstance():ReturnUI(arg_14_0:GetUIName(), arg_14_0._go)

	return
end

function var_0_0.Clear(arg_15_0)
	return
end

return var_0_0
