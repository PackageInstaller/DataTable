local ManualSignDoneCommand = class("ManualSignDoneCommand", pm.SimpleCommand)

function ManualSignDoneCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(ActivityProxy):getActivityById(var_1_0.id)
	local var_1_2 = var_1_1:getConfig("config_client")

	if not var_1_1 or var_1_1:isEnd() and not (var_1_2 and var_1_2.manulSign == true) then
		return
	end

	if var_1_0.cmd == ManualSignActivity.OP_SIGN and var_1_1:GetSignedDayCnt() < 7 and var_1_1:AnyAwardCanGet() then
		self:sendNotification(GAME.ACT_MANUAL_SIGN, {
			activity_id = var_1_1.id,
			cmd = ManualSignActivity.OP_GET_AWARD
		})
	end

	return
end

return ManualSignDoneCommand
