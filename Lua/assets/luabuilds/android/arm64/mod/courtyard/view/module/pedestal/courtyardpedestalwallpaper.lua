local var_0_0 = class("CourtYardPedestalWallPaper", import(".CourtYardPedestalStructure"))

function var_0_0.Update(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.paper = arg_1_1

	if not arg_1_0.paper then
		arg_1_0:Unload()

		return
	end

	var_0_0.super.Update(arg_1_0, arg_1_2)

	return
end

function var_0_0.GetAssetPath(arg_2_0)
	local var_2_0 = arg_2_0.paper:GetObjType()

	if var_2_0 == CourtYardConst.OBJ_TYPE_COMMOM then
		return "furnitrues/" .. arg_2_0.paper:GetPicture() .. arg_2_0.level
	elseif var_2_0 == CourtYardConst.OBJ_TYPE_SPINE then
		local var_2_1, var_2_2 = arg_2_0.paper:GetSpineNameAndAction()

		return "sfurniture/" .. var_2_1 .. arg_2_0.level
	end

	return
end

function var_0_0.GetParent(arg_3_0)
	return arg_3_0.parent._tf:Find("paper")
end

function var_0_0.OnLoaded(arg_4_0, arg_4_1)
	rtf(arg_4_1).anchorMin = Vector2(0.5, 1)
	rtf(arg_4_1).anchorMax = Vector2(0.5, 1)
	rtf(arg_4_1).pivot = Vector2(0.5, 1)
	rtf(arg_4_1).localScale = Vector3(1, 1, 1)

	local var_4_0 = arg_4_0.paper:GetObjType()

	if var_4_0 == CourtYardConst.OBJ_TYPE_COMMOM then
		arg_4_0:InitCommon(arg_4_1)
	elseif var_4_0 == CourtYardConst.OBJ_TYPE_SPINE then
		arg_4_0:InitSpine(arg_4_1)
	end

	tf(arg_4_1):SetSiblingIndex(1)

	return
end

function var_0_0.InitCommon(arg_5_0, arg_5_1)
	setAnchoredPosition(arg_5_1, {
		x = 0,
		y = -6
	})

	return
end

function var_0_0.InitSpine(arg_6_0, arg_6_1)
	setAnchoredPosition(arg_6_1, Vector3(0, -10, 0))

	local var_6_0, var_6_1 = arg_6_0.paper:GetSpineNameAndAction()

	if var_6_1 then
		GetOrAddComponent(tf(arg_6_1):GetChild(0), typeof(SpineAnimUI)):SetAction(var_6_1, 0)
	end

	return
end

return var_0_0
