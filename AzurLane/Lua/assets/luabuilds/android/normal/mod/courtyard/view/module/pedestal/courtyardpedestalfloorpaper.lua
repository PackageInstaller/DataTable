class = var_0_10000

local var_0_0 = "CourtYardPedestalFloorPaper"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".CourtYardPedestalStructure"))
local var_0_2 = {
	0.5,
	0.67,
	0.83,
	1
}

function var_0_1.Update(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.paper = arg_1_1

	var_0_1.super.Update(arg_1_0, arg_1_2)

	return
end

function var_0_1.GetAssetPath(arg_2_0)
	if not arg_2_0.paper then
		return "furnitrues/base/floor_4"
	end

	local var_2_0 = arg_2_0.paper
	local var_2_1 = var_1.GetObjType(var_2_0)

	CourtYardConst = var_2_0

	local var_2_2

	if var_2_1 == var_2_0.OBJ_TYPE_COMMOM then
		var_2_2 = "furnitrues/"

		local var_2_3 = arg_2_0.paper

		return var_2_2 .. var_3.GetPicture(var_2_3)
	else
		CourtYardConst = var_2_2

		if var_2_1 == var_2_2.OBJ_TYPE_SPINE then
			local var_2_4 = arg_2_0.paper
			local var_2_5, var_2_6 = var_2.GetSpineNameAndAction(var_2_4)

			return "sfurniture/" .. var_2_5
		end
	end

	return
end

function var_0_1.GetParent(arg_3_0)
	local var_3_0 = arg_3_0.parent._tf

	return var_1.Find(var_3_0, "paper")
end

function var_0_1.OnLoaded(arg_4_0, arg_4_1)
	rtf = var_1_10002

	local var_4_0 = var_1_10002(arg_4_1)

	Vector2 = var_3
	var_4_0.sizeDelta = var_3(1888, 944)
	rtf = var_4_0

	local var_4_1 = var_4_0(arg_4_1)

	Vector2 = var_3
	var_4_1.anchorMin = var_3(0.5, 1)
	rtf = var_4_1

	local var_4_2 = var_4_1(arg_4_1)

	Vector2 = var_3
	var_4_2.anchorMax = var_3(0.5, 1)
	rtf = var_4_2

	local var_4_3 = var_4_2(arg_4_1)

	Vector2 = var_3
	var_4_3.pivot = var_3(0.5, 1)
	rtf = var_4_3

	local var_4_4 = var_4_3(arg_4_1)

	Vector3 = var_3
	var_4_4.localScale = var_3(1, 1, 1)
	setAnchoredPosition = var_4_4
	rtf = var_3

	local var_4_5 = var_3(arg_4_1)

	Vector3 = var_4

	var_4_4(var_4_5, var_4(0, -280, 0))

	if arg_4_0.paper then
		local var_4_6 = arg_4_0.paper
		local var_4_7 = var_2.GetObjType(var_4_6)

		CourtYardConst = var_4_6

		if var_4_7 == var_4_6.OBJ_TYPE_SPINE then
			arg_4_0:InitSpine(arg_4_1)
		end
	end

	local var_4_8 = arg_4_0:GetRect()
	local var_4_9 = var_2.GetSiblingIndex(var_4_8)

	tf = var_4_8

	local var_4_10 = var_4_8(arg_4_1)

	var_3.SetSiblingIndex(var_4_10, var_4_9)

	local var_4_11 = var_0_2[arg_4_0.level]
	local var_4_12 = arg_4_1.transform

	Vector3 = var_5
	var_4_12.localScale = var_5(var_4_11, var_4_11, 1)

	return
end

function var_0_1.InitSpine(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.paper
	local var_5_1, var_5_2 = var_2.GetSpineNameAndAction(var_5_0)

	if var_5_2 then
		GetOrAddComponent = var_1_10004
		tf = var_1_10005

		local var_5_3 = var_1_10005(arg_5_1)
		local var_5_4 = var_5.GetChild(var_5_3, 0)

		typeof = var_5_3
		SpineAnimUI = var_7

		local var_5_5 = var_1_10004(var_5_4, var_5_3(var_7))

		var_4.SetAction(var_5_5, var_5_2, 0)
	end

	return
end

return var_0_1
