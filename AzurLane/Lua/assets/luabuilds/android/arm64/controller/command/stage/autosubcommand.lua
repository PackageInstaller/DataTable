local var_0_0 = class("AutoSubCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	PlayerPrefs.SetInt("autoSubIsAcitve" .. var_0_0.GetAutoSubMark(var_1_0.system), not var_1_0.isActiveSub and 1 or 0)

	return
end

function var_0_0.GetAutoSubMark(arg_2_0)
	if arg_2_0 == SYSTEM_WORLD then
		return "_" .. arg_2_0
	elseif arg_2_0 == SYSTEM_GUILD then
		return "_" .. SYSTEM_GUILD
	else
		return ""
	end

	return
end

return var_0_0
