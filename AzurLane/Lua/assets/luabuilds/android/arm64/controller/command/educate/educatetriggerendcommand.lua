local var_0_0 = class("EducateTriggerEndCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_2

	if var_1_0 then
		::label_1_0::

		local var_1_1 = var_1_0.callback

		var_1_2 = pg.child_ending[var_1_0.selId].performance
	end

	;({
		ending_id = var_1_0.selId
	}).qualified_id = var_1_0.ids

	pg.ConnectionMgr.GetInstance():Send(27008, {
		ending_id = var_1_0.selId
	}, 27009, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(EducateProxy):AddEnding(var_0, var_0)
			arg_1_0:sendNotification(GAME.EDUCATE_TRIGGER_END_DONE)
			pg.PerformMgr.GetInstance():PlayGroup(var_1_2, function()
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

return var_0_0
