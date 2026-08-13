class = var_0_10000

local var_0_0 = "AutoSubCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().isActiveSub
	local var_1_1 = var_2.toggle
	local var_1_2 = var_2.system
	local var_1_3 = var_0_1.GetAutoSubMark(var_1_2)

	PlayerPrefs = var_1_10007

	var_1_10007.SetInt("autoSubIsAcitve" .. var_1_3, not var_1_0 and 1 or 0)

	return
end

function var_0_1.GetAutoSubMark(arg_2_0)
	SYSTEM_WORLD = var_1_10001

	if arg_2_0 == var_1_10001 then
		return "_" .. arg_2_0
	else
		SYSTEM_GUILD = var_1_10001

		if arg_2_0 == var_1_10001 then
			local var_2_0 = "_"

			SYSTEM_GUILD = var_1_10002

			return var_2_0 .. var_1_10002
		else
			return ""
		end
	end

	return
end

return var_0_1
