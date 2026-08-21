local var_0_0 = class("CourtYardPedestalFloorPaper", import(".CourtYardPedestalStructure"))
local var_0_1 = {
	0.5,
	0.67,
	0.83,
	1
}

function var_0_0.Update(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.paper = arg_1_1

	var_0_0.super.Update(arg_1_0, arg_1_2)

	return
end

function var_0_0.GetAssetPath(arg_2_0)
	if not arg_2_0.paper then
		return "furnitrues/base/floor_4"
	end

	local var_2_0 = arg_2_0.paper:GetObjType()

	if var_2_0 == CourtYardConst.OBJ_TYPE_COMMOM then
		return "furnitrues/" .. arg_2_0.paper:GetPicture()
	elseif var_2_0 == CourtYardConst.OBJ_TYPE_SPINE then
		local var_2_1, var_2_2 = arg_2_0.paper:GetSpineNameAndAction()

		return "sfurniture/" .. var_2_1
	end

	return
end

function var_0_0.GetParent(arg_3_0)
	return arg_3_0.parent._tf:Find("paper")
end

function var_0_0.OnLoaded(arg_4_0, arg_4_1)
	rtf(arg_4_1).sizeDelta = Vector2(1888, 944)
	rtf(arg_4_1).anchorMin = Vector2(0.5, 1)
	rtf(arg_4_1).anchorMax = Vector2(0.5, 1)
	rtf(arg_4_1).pivot = Vector2(0.5, 1)
	rtf(arg_4_1).localScale = Vector3(1, 1, 1)

	setAnchoredPosition(rtf(arg_4_1), Vector3(0, -280, 0))

	if arg_4_0.paper and arg_4_0.paper:GetObjType() == CourtYardConst.OBJ_TYPE_SPINE then
		arg_4_0:InitSpine(arg_4_1)
	end

	local var_4_0 = arg_4_0:GetRect()

	tf(arg_4_1):SetSiblingIndex((var_4_0:GetSiblingIndex()))

	arg_4_1.transform.localScale = Vector3(var_0_1[arg_4_0.level], var_0_1[arg_4_0.level], 1)

	return
end

function var_0_0.InitSpine(arg_5_0, arg_5_1)
	local var_5_0, var_5_1 = arg_5_0.paper:GetSpineNameAndAction()

	if var_5_1 then
		GetOrAddComponent(tf(arg_5_1):GetChild(0), typeof(SpineAnimUI)):SetAction(var_5_1, 0)
	end

	return
end

return var_0_0
