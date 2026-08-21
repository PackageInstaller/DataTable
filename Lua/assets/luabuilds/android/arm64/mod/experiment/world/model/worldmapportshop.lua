local var_0_0 = class("WorldMapPortShop", import("...BaseEntity"))

var_0_0.Fields = {
	items = "table",
	expiredTime = "number"
}

function var_0_0.Setup(arg_1_0)
	return
end

function var_0_0.IsValid(arg_2_0)
	local var_2_0 = pg.TimeMgr.GetInstance()

	return arg_2_0.expiredTime >= var_2_0:GetServerTime()
end

return var_0_0
