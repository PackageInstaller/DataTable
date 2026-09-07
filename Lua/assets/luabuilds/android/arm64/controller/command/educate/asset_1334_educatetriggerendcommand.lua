local EducateTriggerEndCommand = class("EducateTriggerEndCommand", pm.SimpleCommand)

function EducateTriggerEndCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_2 = var_1_0.ids
	local var_1_3 = var_1_0.selId
	local var_1_4 = pg.child_ending[var_1_0.selId].performance

	pg.ConnectionMgr.GetInstance():Send(27008, {
		ending_id = var_1_0.selId,
		qualified_id = var_1_0.ids
	}, 27009, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(EducateProxy):AddEnding(var_1_3, var_1_2)
			self:sendNotification(GAME.EDUCATE_TRIGGER_END_DONE)
			pg.PerformMgr.GetInstance():PlayGroup(var_1_4, function()
				pg.PerformMgr.GetInstance():PlayOne(EducateConst.AFTER_END_PERFORM, function()
					getProxy(EducateProxy):CheckGuide("EducateScene", true)

					return
				end)

				return
			end)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("educate trigger end error: ", arg_2_0.result))
		end

		return
	end)

	return
end

return EducateTriggerEndCommand
