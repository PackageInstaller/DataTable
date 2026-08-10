local var_0_0 = singletonClass("SystemData")
local var_0_1 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.open_system

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		table.insert(var_0_1, iter_2_1)
	end
end

function var_0_0.ModifyData(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.open_system
	local var_3_1 = arg_3_1.close_system
	local var_3_2 = {}

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		table.insert(var_0_1, iter_3_1)
		table.insert(var_3_2, iter_3_1)
	end

	for iter_3_2, iter_3_3 in ipairs(var_3_1) do
		local var_3_3 = table.indexof(var_0_1, iter_3_3)

		if var_3_3 then
			table.remove(var_0_1, var_3_3)
		end
	end

	arg_3_0:SolveSystemRed(var_3_2)
end

var_0_0.ChessSystemId = 312

function var_0_0.SolveSystemRed(arg_4_0, arg_4_1)
	SystemRedPoint:CheckIsSystemUnlock(arg_4_1)
	BattleEquipData:OnSystemUnlock(arg_4_1)
	DailyNewRedPoint:OnSystemUnlock(arg_4_1)

	if arg_4_0:GetSystemIsOpen(var_0_0.ChessSystemId) then
		WarChessAction.UpdateWarChessRedPoint()
	end

	manager.notify:Invoke(SYSTEM_OPEN_OR_LOCK, arg_4_1)
end

function var_0_0.GetSystemIsOpen(arg_5_0, arg_5_1)
	return table.indexof(var_0_1, arg_5_1) ~= false
end

function var_0_0.GetOpenSystemList(arg_6_0)
	return var_0_1
end

function var_0_0.ServerSystemIsLocked(arg_7_0, arg_7_1)
	local var_7_0 = SystemCfg[arg_7_1]

	if var_7_0 and var_7_0.system_hide == 1 then
		return {
			"server_lock"
		}
	end

	if var_7_0 and not SystemData:GetSystemIsOpen(arg_7_1) then
		return {
			"server_lock"
		}
	end

	return JumpTools.CustomLock(arg_7_1)
end

return var_0_0
