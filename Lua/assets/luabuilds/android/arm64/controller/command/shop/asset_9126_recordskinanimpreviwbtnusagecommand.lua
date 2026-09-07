local RecordSkinAnimPreviwBtnUsageCommand = class("RecordSkinAnimPreviwBtnUsageCommand", pm.SimpleCommand)

function RecordSkinAnimPreviwBtnUsageCommand:execute(arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(16203, {
		flag = arg_1_1:getBody().isOpen and 1 or 0
	}, 16204, function(arg_2_0)
		if arg_2_0.ret == 0 then
			-- block empty
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return RecordSkinAnimPreviwBtnUsageCommand
