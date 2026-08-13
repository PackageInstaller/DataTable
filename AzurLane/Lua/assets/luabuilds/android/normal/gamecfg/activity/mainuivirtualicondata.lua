return {
	CurrentIconList = {
		1
	},
	{
		IsVirtualIcon = true,
		Image = "doa_virtual_buff",
		CheckExist = function()
			getProxy = var_1_10000
			ActivityProxy = var_1_10001

			local var_1_0 = var_1_10000(var_1_10001)
			local var_1_1 = var_0.getActivityById

			ActivityConst = var_1_10002

			if not var_1_1(var_1_0, var_1_10002.DOA_PT_ID) then
				return false
			end

			ActivityPtData = var_1_0

			local var_1_2 = var_1_0.New(var_0)

			if not var_0:isEnd() and var_1_2:isInBuffTime() then
				return true
			end

			return false
		end
	}
}
