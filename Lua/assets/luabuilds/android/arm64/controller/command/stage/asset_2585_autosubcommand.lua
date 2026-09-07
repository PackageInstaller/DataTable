local AutoSubCommand = class("AutoSubCommand", pm.SimpleCommand)

function AutoSubCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	PlayerPrefs.SetInt("autoSubIsAcitve" .. AutoSubCommand.GetAutoSubMark(var_1_0.system), not var_1_0.isActiveSub and 1 or 0)

	return
end

function AutoSubCommand:GetAutoSubMark()
	if self == SYSTEM_WORLD then
		return "_" .. self
	elseif self == SYSTEM_GUILD then
		return "_" .. SYSTEM_GUILD
	else
		return ""
	end

	return
end

return AutoSubCommand
