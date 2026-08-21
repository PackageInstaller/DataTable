local var_0_0 = class("IslandSlotHudView", import(".IslandBaseOpView"))
local var_0_1 = 4

function var_0_0.GetUIName(arg_1_0)
	return "IslandSlotHudUI"
end

function var_0_0.GetUIParent(arg_2_0, arg_2_1)
	return arg_2_0:GetView().hudContainer
end

function var_0_0.OnInit(arg_3_0, arg_3_1)
	arg_3_0._go = arg_3_1
	arg_3_0._tf = arg_3_1.transform
	arg_3_0.parent = arg_3_0._tf:Find("look")
	arg_3_0.hideHudDic = {}
	arg_3_0.unitHideHudQueue = {}

	return
end

function var_0_0.Update(arg_4_0)
	if arg_4_0.currentHud then
		arg_4_0.currentHud:Update()
	end

	return
end

function var_0_0.LateUpdate(arg_5_0)
	if arg_5_0.currentHud then
		arg_5_0.currentHud:LateUpdate()
	end

	return
end

function var_0_0.ShowHud(arg_6_0, arg_6_1, arg_6_2)
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

function var_0_0.UpdateHud(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == nil then
		return
	end

	local var_7_0 = arg_7_0.view:GetUnitModuleWithType(IslandConst.UNIT_LIST_OBJ, arg_7_1)

	if not var_7_0 then
		return
	end

	local var_7_1 = var_7_0:GetHudInfo()

	if not arg_7_0.currentHud then
		arg_7_0:ShowUnitHud(arg_7_1, arg_7_2)

		return
	end

	if arg_7_0.currentHud.unitId == arg_7_1 then
		arg_7_0.currentHud:UpdateUnitHud(var_7_1)
	end

	return
end

function var_0_0.HideUnitHud(arg_8_0, arg_8_1)
	if not arg_8_0.currentHud then
		return
	end

	if arg_8_0.currentHud.unitId == arg_8_1 then
		arg_8_0.currentHud:HideHud()
		arg_8_0:InPool(arg_8_0.currentHud)

		arg_8_0.currentHud = nil
	end

	return
end

function var_0_0.InPool(arg_9_0, arg_9_1)
	local var_9_0

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.unitHideHudQueue) do
		if iter_9_1 == arg_9_1.unitId then
			var_9_0 = iter_9_0
		end
	end

	if var_9_0 then
		table.remove(arg_9_0.unitHideHudQueue, var_9_0)
	end

	table.insert(arg_9_0.unitHideHudQueue, arg_9_1.unitId)

	arg_9_0.hideHudDic[arg_9_1.unitId] = arg_9_1

	if #arg_9_0.unitHideHudQueue > var_0_1 then
		table.remove(arg_9_0.unitHideHudQueue, 1)
		arg_9_0.hideHudDic[arg_9_0.unitHideHudQueue[1]]:Dispose()

		arg_9_0.hideHudDic[arg_9_0.unitHideHudQueue[1]] = nil
	end

	return
end

function var_0_0.ShowUnitHud(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.view:GetUnitModuleWithType(IslandConst.UNIT_LIST_OBJ, arg_10_1):GetHudInfo()

	if arg_10_0.hideHudDic[arg_10_1] then
		arg_10_0.currentHud = arg_10_0.hideHudDic[arg_10_1]

		arg_10_0.currentHud:ShowUnitHud(arg_10_1, var_10_0, arg_10_2)
	else
		if not arg_10_0.currentHud then
			arg_10_0.currentHud = IslandHudPanel.New(arg_10_0.parent, arg_10_0.view)

			arg_10_0.currentHud:ShowUnitHud(arg_10_1, var_10_0, arg_10_2)
			arg_10_0.currentHud:Init()

			return
		end

		arg_10_0.currentHud:ShowUnitHud(arg_10_1, var_10_0, arg_10_2)
	end

	return
end

function var_0_0.OnDestroy(arg_11_0)
	return
end

return var_0_0
