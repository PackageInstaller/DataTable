return {
	HeroUsingSkinInfo = function(arg_1_0)
		return AdminSystemData:GetAdminUsingSkin(arg_1_0) == 0 and 1001 or AdminSystemData:GetAdminUsingSkin(arg_1_0)
	end,
	SelectSkin = function(arg_2_0, arg_2_1)
		AdminSystemAction.SelectSkin(arg_2_0, arg_2_1)
	end
}
