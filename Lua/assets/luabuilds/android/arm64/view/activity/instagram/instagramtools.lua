return {
	ExistOfficialAccounts = function()
		local var_1_0 = getProxy(InstagramProxy)

		return table.getCount(var_1_0:GetOfficialAccounts()) > 0
	end
}
