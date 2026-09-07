function GetBattleCheck()
	return 0
end

function GetBattleCheckResult(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0 = math.floor(arg_2_0 % 2621 * (arg_2_1 % 2621) % 2621 + arg_2_2)

	return arg_2_0, (tostring(math.floor(GetBattleCheck() % 3527 * (arg_2_1 % 3527) % (3527 + arg_2_0))))
end

ys.BattleShipLevelVertify = {}

return
