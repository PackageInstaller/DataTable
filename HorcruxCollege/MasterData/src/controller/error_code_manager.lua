return {
	check = function(arg_1_0, arg_1_1)
		if config.packagechannel == "palmpi" then
			if not require("devtools.errorcode.error_code_dev_manager"):check(arg_1_1) then
				print(debug.traceback())
			end
		end
	end
}
