class = var_0_10000

local var_0_0 = "IslandSlotHudView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandBaseOpView"))
local var_0_2 = 4

function var_0_1.GetUIName(arg_1_0)
	return "IslandSlotHudUI"
end

function var_0_1.GetUIParent(arg_2_0, arg_2_1)
	return arg_2_0:GetView().hudContainer
end

function var_0_1.OnInit(arg_3_0, arg_3_1)
	arg_3_0._go = arg_3_1
	arg_3_0._tf = arg_3_1.transform

	local var_3_0 = arg_3_0._tf

	arg_3_0.parent = var_2.Find(var_3_0, "look")
	arg_3_0.hideHudDic = {}
	arg_3_0.unitHideHudQueue = {}

	return
end

function var_0_1.Update(arg_4_0)
	if arg_4_0.currentHud then
		local var_4_0 = arg_4_0.currentHud

		var_1.Update(var_4_0)
	end

	return
end

function var_0_1.LateUpdate(arg_5_0)
	if arg_5_0.currentHud then
		local var_5_0 = arg_5_0.currentHud

		var_1.LateUpdate(var_5_0)
	end

	return
end

function var_0_1.ShowHud(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == nil then
		return
	end

	if arg_6_0.currentHud then
		if arg_6_0.currentHud.unitId == arg_6_1 then
			return
		end

		arg_6_0:HideUnitHud(arg_6_0.currentHud.unitId)
	end

	arg_6_0:ShowUnitHud(arg_6_1, arg_6_2)

	return
end

function var_0_1.UpdateHud(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == nil then
		return
	end

	local var_7_0 = arg_7_0.view
	local var_7_1 = var_3.GetUnitModuleWithType

	IslandConst = var_1_10005

	if not var_7_1(var_7_0, var_1_10005.UNIT_LIST_OBJ, arg_7_1) then
		return
	end

	local var_7_2 = var_3:GetHudInfo()

	if not arg_7_0.currentHud then
		arg_7_0:ShowUnitHud(arg_7_1, arg_7_2)

		return
	end

	if arg_7_0.currentHud.unitId == arg_7_1 then
		local var_7_3 = arg_7_0.currentHud

		var_5.UpdateUnitHud(var_7_3, var_7_2)
	end

	return
end

function var_0_1.HideUnitHud(arg_8_0, arg_8_1)
	if not arg_8_0.currentHud then
		return
	end

	if arg_8_0.currentHud.unitId == arg_8_1 then
		local var_8_0 = arg_8_0.currentHud

		var_2.HideHud(var_8_0)
		arg_8_0:InPool(arg_8_0.currentHud)

		arg_8_0.currentHud = nil
	end

	return
end

function var_0_1.InPool(arg_9_0, arg_9_1)
	local var_9_0

	ipairs = var_1_10003

	for iter_9_0, iter_9_1 in var_1_10003(arg_9_0.unitHideHudQueue) do
		if iter_9_1 == arg_9_1.unitId then
			var_9_0 = iter_9_0
		end
	end

	if var_9_0 then
		table = var_3

		var_3.remove(arg_9_0.unitHideHudQueue, var_9_0)
	end

	table = var_3

	var_3.insert(arg_9_0.unitHideHudQueue, arg_9_1.unitId)

	arg_9_0.hideHudDic[arg_9_1.unitId] = arg_9_1

	local var_9_1 = #arg_9_0.unitHideHudQueue

	if var_0_2 < var_9_1 then
		local var_9_2 = arg_9_0.unitHideHudQueue[1]

		table = var_4

		var_4.remove(arg_9_0.unitHideHudQueue, 1)

		local var_9_3 = arg_9_0.hideHudDic[var_9_2]

		var_4.Dispose(var_9_3)

		arg_9_0.hideHudDic[var_9_2] = nil
	end

	return
end

function var_0_1.ShowUnitHud(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.view
	local var_10_1 = var_3.GetUnitModuleWithType

	IslandConst = var_1_10005

	local var_10_2 = var_10_1(var_10_0, var_1_10005.UNIT_LIST_OBJ, arg_10_1)
	local var_10_3 = var_3.GetHudInfo(var_10_2)

	if arg_10_0.hideHudDic[arg_10_1] then
		arg_10_0.currentHud = arg_10_0.hideHudDic[arg_10_1]

		local var_10_4 = arg_10_0.currentHud

		var_5.ShowUnitHud(var_10_4, arg_10_1, var_10_3, arg_10_2)
	else
		if not arg_10_0.currentHud then
			IslandHudPanel = var_5
			arg_10_0.currentHud = var_5.New(arg_10_0.parent, arg_10_0.view)

			local var_10_5 = arg_10_0.currentHud

			var_5.ShowUnitHud(var_10_5, arg_10_1, var_10_3, arg_10_2)

			local var_10_6 = arg_10_0.currentHud

			var_5.Init(var_10_6)

			return
		end

		local var_10_7 = arg_10_0.currentHud

		var_5.ShowUnitHud(var_10_7, arg_10_1, var_10_3, arg_10_2)
	end

	return
end

function var_0_1.OnDestroy(arg_11_0)
	return
end

return var_0_1
