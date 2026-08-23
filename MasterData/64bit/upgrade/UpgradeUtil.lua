return {
	httpGet = function(arg_1_0, arg_1_1, arg_1_2)
		local var_1_0 = cc.XMLHttpRequest:new()

		var_1_0.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING

		var_1_0:open("GET", arg_1_0)
		release_print("UpgradeUtil.httpGet--------->" .. arg_1_0)
		var_1_0:registerScriptHandler(function(arg_2_0)
			if var_1_0.readyState == 4 then
				if var_1_0.status == 200 then
					if arg_1_1 then
						arg_1_1((json.decode(var_1_0.response, 1)))
					end
				elseif arg_1_2 then
					arg_1_2({
						status = var_1_0.status
					})
				end
			elseif arg_1_2 then
				arg_1_2({
					readyState = var_1_0.readyState
				})
			end
		end)
		var_1_0:send()

		return var_1_0
	end
}
