class = var_0_10000

local var_0_0 = var_0_10000("PropertyPanel")
local var_0_1 = 24.5
local var_0_2 = {
	"cannon",
	"torpedo",
	"air",
	"dodge",
	"antiaircraft",
	"durability"
}
local var_0_3 = {
	E = 1,
	C = 3,
	A = 5,
	D = 2,
	S = 6,
	B = 4
}
local var_0_4 = {
	{
		0,
		70.8
	},
	{
		-169.6,
		37.7
	},
	{
		-210.4,
		-49.8
	},
	{
		-0.9,
		-111.1
	},
	{
		210.1,
		-49.6
	},
	{
		169.9,
		38.4
	}
}
local var_0_5 = 1
local var_0_6 = 3
local var_0_7 = 4
local var_0_8 = 2
local var_0_9 = 5

var_0_0.TypeRotation = 1
var_0_0.TypeFlat = 2

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1 = arg_1_2 or var_0_1
	arg_1_0.tf = arg_1_1
	findTF = var_3
	arg_1_0.propertyTFs = var_3(arg_1_0.tf, "property")
	findTF = var_3
	arg_1_0.drawTF = var_3(arg_1_0.tf, "property/draw")

	local var_1_0 = arg_1_0.drawTF

	arg_1_0.drawPolygon = var_3.GetComponent(var_1_0, "DrawPolygon")
	findTF = var_3
	arg_1_0.drawTF2 = var_3(arg_1_0.tf, "property/draw_2")

	if arg_1_0.drawTF2 then
		local var_1_1 = arg_1_0.drawTF2

		arg_1_0.drawPolygon2 = var_3.GetComponent(var_1_1, "DrawPolygon")
	end

	return
end

function var_0_0.initProperty(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.type = arg_2_2 or var_0_0.TypeRotation
	Ship = var_3

	local var_2_0 = var_3.getGroupIdByConfigId(arg_2_1)

	ShipGroup = var_1_10004

	local var_2_1 = var_1_10004.GetGroupConfig(var_2_0).property_hexagon

	arg_2_0:initRadar(var_2_1)

	return
end

function var_0_0.initRadar(arg_3_0, arg_3_1)
	local var_3_0 = {}
	local var_3_1 = {}

	table = var_1_10004

	local var_3_2 = var_1_10004.insert
	local var_3_3 = var_3_0

	Vector3 = var_1_10007

	var_3_2(var_3_3, var_1_10007(0, 0, 0))

	ipairs = var_3_2

	for iter_3_0, iter_3_1 in var_3_2(var_0_2) do
		local var_3_4 = arg_3_0.propertyTFs
		local var_3_5 = var_9.Find(var_3_4, iter_3_1 .. "_grade")
		local var_3_6 = arg_3_1[iter_3_0]

		arg_3_0:setSpriteTo("resources/" .. var_3_6, var_3_5:Find("grade"), true)

		local var_3_7, var_3_9

		if arg_3_0.type == var_0_0.TypeRotation then
			table = var_3_7
			var_3_7 = var_3_7.insert

			local var_3_8 = var_3_0

			var_3_9 = arg_3_0

			var_3_7(var_3_8, arg_3_0.getGradeCoordinate(var_3_9, var_3_6, iter_3_0))
		elseif arg_3_0.type == var_0_0.TypeFlat then
			table = var_3_7
			var_3_7 = var_3_7.insert

			local var_3_10 = var_3_0

			var_3_9 = arg_3_0

			var_3_7(var_3_10, arg_3_0.getGradeCoordinate1(var_3_9, var_3_6, iter_3_0))
		end

		table = var_3_7

		var_3_7.insert(var_3_1, 0)

		table = var_11

		var_11.insert(var_3_1, iter_3_0)

		if iter_3_0 + 1 > #var_0_2 then
			table = var_11

			var_11.insert(var_3_1, 1)
		else
			table = var_11

			var_11.insert(var_3_1, iter_3_0 + 1)
		end

		findTF = var_11

		if var_11(var_3_5, "Text") then
			findTF = var_11

			local var_3_11 = var_11(var_3_5, "Text")
			local var_3_12 = var_11.GetComponent

			typeof = var_14
			Text = var_3_9

			if var_3_12(var_3_11, var_14(var_3_9)) then
				setText = var_11
				findTF = var_3_11

				local var_3_13 = var_3_11(var_3_5, "Text")

				i18n = var_14

				var_11(var_3_13, var_14("word_attr_" .. iter_3_1))
			end
		end
	end

	local var_3_14 = arg_3_0.drawPolygon

	var_4.draw(var_3_14, var_3_0, var_3_1)

	if arg_3_0.drawPolygon2 then
		local var_3_15 = arg_3_0.drawPolygon2

		var_4.draw(var_3_15, var_3_0, var_3_1)
	end

	return
end

function var_0_0.getGradeCoordinate(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = 0.163 * var_0_3[arg_4_1] * var_0_4[arg_4_2][1]
	local var_4_1 = 0.163 * var_0_3[arg_4_1] * var_0_4[arg_4_2][2]

	Vector3 = var_5

	return var_5(var_4_0, var_4_1, 0)
end

function var_0_0.getGradeCoordinate1(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = 0.66 * var_0_3[arg_5_1]

	if arg_5_2 == var_0_8 then
		Vector3 = var_4

		return var_4(-var_5_0 * var_0_1, 0, 0)
	elseif arg_5_2 == var_0_9 then
		Vector3 = var_4

		return var_4(var_5_0 * var_0_1, 0, 0)
	else
		local var_5_1 = 60
		local var_5_2 = var_5_0 * var_0_1

		math = var_1_10006

		local var_5_3 = var_1_10006.sin

		math = var_1_10008

		local var_5_4 = var_5_3(var_1_10008.rad(var_5_1)) * var_5_2

		math = var_1_10007

		local var_5_5 = var_1_10007.cos

		math = var_1_10009

		local var_5_6 = var_5_5(var_1_10009.rad(var_5_1)) * var_5_2

		if arg_5_2 == var_0_5 then
			var_5_6 = -var_5_6
		elseif arg_5_2 == var_0_6 then
			var_5_6 = -var_5_6
			var_5_4 = -var_5_4
		elseif arg_5_2 == var_0_7 then
			var_5_4 = -var_5_4
		end

		Vector3 = var_8

		return var_8(var_5_6, var_5_4, 0)
	end

	return
end

function var_0_0.setSpriteTo(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_2
	local var_6_1 = arg_6_2.GetComponent

	typeof = var_1_10007
	Image = var_1_10009

	local var_6_2 = var_6_1(var_6_0, var_1_10007(var_1_10009))

	findTF = var_1_10005

	local var_6_3 = var_1_10005(arg_6_0.tf, arg_6_1)
	local var_6_4 = var_5.GetComponent

	typeof = var_8
	Image = var_1_10010
	var_6_2.sprite = var_6_4(var_6_3, var_8(var_1_10010)).sprite

	if arg_6_3 then
		var_6_2:SetNativeSize()
	end

	return
end

return var_0_0
