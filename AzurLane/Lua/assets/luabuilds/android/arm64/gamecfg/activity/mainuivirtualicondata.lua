return {
	CurrentIconList = {
		1
	},
	{
		IsVirtualIcon = true,
		Image = "doa_virtual_buff",
		CheckExist = function()
			local var_1_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.DOA_PT_ID)

			if not var_1_0 then
				return false
			end

			local var_1_1 = ActivityPtData.New(var_1_0)

			if not var_1_0:isEnd() and var_1_1:isInBuffTime() then
				return true
			end

			return false
		end
	}
}
