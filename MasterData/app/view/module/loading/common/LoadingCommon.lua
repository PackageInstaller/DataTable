local var_0_0 = g.core.config.loading_text_info

return {
	getLoadingBgList = function()
		local var_1_0 = {}

		for iter_1_0 = 1, var_0_0.getLength() do
			local var_1_1 = var_0_0.indexOf(iter_1_0)

			if var_1_1.type == 1 then
				table.insert(var_1_0, {
					title = var_1_1.title,
					desc = var_1_1.text,
					groupIcon = g.core.common.Path:getCampURL(var_1_1.group, 7),
					bgPic = g.core.common.Path:getLoadingBackground(var_1_1.loadingbg)
				})
			end
		end

		return var_1_0
	end,
	getUpgradeTextList = function()
		local var_2_0 = {}

		for iter_2_0 = 1, var_0_0.getLength() do
			local var_2_1 = var_0_0.indexOf(iter_2_0)

			if var_2_1.type == 2 then
				table.insert(var_2_0, {
					desc = var_2_1.text
				})
			end
		end

		return var_2_0
	end,
	getCommonLoadingTextList = function()
		local var_3_0 = g.core.utils.Time.isNight()
		local var_3_1 = {}

		for iter_3_0 = 1, var_0_0.getLength() do
			local var_3_2 = var_0_0.indexOf(iter_3_0)

			if var_3_2.type == 3 then
				table.insert(var_3_1, {
					title = var_3_2.title,
					desc = var_3_2.text,
					groupIcon = g.core.common.Path:getLoadingIcon(var_3_2.icon, var_3_0 and 2 or 1)
				})
			end
		end

		return var_3_1
	end
}
