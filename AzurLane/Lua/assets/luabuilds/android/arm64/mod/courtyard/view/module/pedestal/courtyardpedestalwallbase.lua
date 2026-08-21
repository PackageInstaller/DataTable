local var_0_0 = class("CourtYardPedestalWallBase", import(".CourtYardPedestalStructure"))

function var_0_0.GetAssetPath(arg_1_0)
	return "furnitrues/base/wall_" .. arg_1_0.level
end

function var_0_0.OnLoaded(arg_2_0, arg_2_1)
	arg_2_1.transform:SetAsFirstSibling()

	return
end

function var_0_0.GetParent(arg_3_0)
	return arg_3_0.parent._tf:Find("base")
end

return var_0_0
