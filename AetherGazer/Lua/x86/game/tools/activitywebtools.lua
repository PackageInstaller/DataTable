return {
	OpenUrl = function(arg_1_0)
		local var_1_0 = ActivityWebCfg[arg_1_0]

		if not var_1_0 then
			Debug.LogError("ActivityWebCfg不存在配置：" .. arg_1_0)

			return
		end

		OperationAction.OpenOperationUrl(var_1_0.url_key, nil, var_1_0.url_open_way, var_1_0.screen_orientation, var_1_0.need_close_btn == 1)
	end
}
