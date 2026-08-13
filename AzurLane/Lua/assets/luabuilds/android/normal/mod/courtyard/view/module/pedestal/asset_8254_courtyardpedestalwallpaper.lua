class = var_0_10000

local var_0_0 = "CourtYardPedestalWallPaper"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".CourtYardPedestalStructure"))

function var_0_1.Update(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.paper = arg_1_1

	if not arg_1_0.paper then
		arg_1_0:Unload()

		return
	end

	var_0_1.super.Update(arg_1_0, arg_1_2)

	return
end

function var_0_1.GetAssetPath(arg_2_0)
	local var_2_0 = arg_2_0.paper
	local var_2_1 = var_1.GetObjType(var_2_0)

	CourtYardConst = var_2_0

	local var_2_2

	if var_2_1 == var_2_0.OBJ_TYPE_COMMOM then
		var_2_2 = "furnitrues/"

		local var_2_3 = arg_2_0.paper

		return var_2_2 .. var_3.GetPicture(var_2_3) .. arg_2_0.level
	else
		CourtYardConst = var_2_2

		if var_2_1 == var_2_2.OBJ_TYPE_SPINE then
			local var_2_4 = arg_2_0.paper
			local var_2_5, var_2_6 = var_2.GetSpineNameAndAction(var_2_4)

			return "sfurniture/" .. var_2_5 .. arg_2_0.level
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
	var_4_0.anchorMin = var_3(0.5, 1)
	rtf = var_4_0

	local var_4_1 = var_4_0(arg_4_1)

	Vector2 = var_3
	var_4_1.anchorMax = var_3(0.5, 1)
	rtf = var_4_1

	local var_4_2 = var_4_1(arg_4_1)

	Vector2 = var_3
	var_4_2.pivot = var_3(0.5, 1)
	rtf = var_4_2

	local var_4_3 = var_4_2(arg_4_1)

	Vector3 = var_3
	var_4_3.localScale = var_3(1, 1, 1)

	local var_4_4 = arg_4_0.paper
	local var_4_5 = var_2.GetObjType(var_4_4)

	CourtYardConst = var_4_4

	if var_4_5 == var_4_4.OBJ_TYPE_COMMOM then
		arg_4_0:InitCommon(arg_4_1)
	else
		CourtYardConst = var_3

		if var_4_5 == var_3.OBJ_TYPE_SPINE then
			arg_4_0:InitSpine(arg_4_1)
		end
	end

	tf = var_3

	local var_4_6 = var_3(arg_4_1)

	var_3.SetSiblingIndex(var_4_6, 1)

	return
end

function var_0_1.InitCommon(arg_5_0, arg_5_1)
	setAnchoredPosition = var_1_10002

	var_1_10002(arg_5_1, {
		x = 0,
		y = -6
	})

	return
end

function var_0_1.InitSpine(arg_6_0, arg_6_1)
	setAnchoredPosition = var_1_10002

	local var_6_0 = arg_6_1

	Vector3 = var_1_10004

	var_1_10002(var_6_0, var_1_10004(0, -10, 0))

	local var_6_1 = arg_6_0.paper
	local var_6_2, var_6_3 = var_2.GetSpineNameAndAction(var_6_1)

	if var_6_3 then
		GetOrAddComponent = var_4
		tf = var_5

		local var_6_4 = var_5(arg_6_1)
		local var_6_5 = var_5.GetChild(var_6_4, 0)

		typeof = var_6_4
		SpineAnimUI = var_7

		local var_6_6 = var_4(var_6_5, var_6_4(var_7))

		var_4.SetAction(var_6_6, var_6_3, 0)
	end

	return
end

return var_0_1
