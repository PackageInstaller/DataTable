local var_0_0
local var_0_1

function ShowAwakeName(arg_1_0, arg_1_1)
	var_0_0 = arg_1_0
	var_0_1 = arg_1_1

	if PlayerData:GetPlayerInfo().is_changed_nick < 1 then
		gameContext:Go("/awakeName")
	else
		ShowAwakeNameCallBack()
	end
end

function ShowAwakeNameCallBack()
	LuaExchangeHelper.EnableATrigger(var_0_0, var_0_1)
end
