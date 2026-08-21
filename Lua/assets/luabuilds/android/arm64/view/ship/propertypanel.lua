local var_0_0 = class("PropertyPanel")
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
	arg_1_0.propertyTFs = findTF(arg_1_0.tf, "property")
	arg_1_0.drawTF = findTF(arg_1_0.tf, "property/draw")
	arg_1_0.drawPolygon = arg_1_0.drawTF:GetComponent("DrawPolygon")
	arg_1_0.drawTF2 = findTF(arg_1_0.tf, "property/draw_2")

	if arg_1_0.drawTF2 then
		arg_1_0.drawPolygon2 = arg_1_0.drawTF2:GetComponent("DrawPolygon")
	end

	return
end

function var_0_0.initProperty(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.type = arg_2_2 or var_0_0.TypeRotation

	arg_2_0:initRadar(ShipGroup.GetGroupConfig((Ship.getGroupIdByConfigId(arg_2_1))).property_hexagon)

	return
end

function var_0_0.initRadar(arg_3_0, arg_3_1)
	local var_3_0 = {}

	table.insert({}, Vector3(0, 0, 0))

	for iter_3_0, iter_3_1 in ipairs(var_0_2) do
		local var_3_1 = arg_3_0.propertyTFs:Find(iter_3_1 .. "_grade")

		arg_3_0:setSpriteTo("resources/" .. arg_3_1[iter_3_0], var_3_1:Find("grade"), true)

		if arg_3_0.type == var_0_0.TypeRotation then
			table.insert({}, arg_3_0:getGradeCoordinate(arg_3_1[iter_3_0], iter_3_0))
		elseif arg_3_0.type == var_0_0.TypeFlat then
			table.insert({}, arg_3_0:getGradeCoordinate1(arg_3_1[iter_3_0], iter_3_0))
		end

		table.insert(var_3_0, 0)
		table.insert(var_3_0, iter_3_0)

		if iter_3_0 + 1 > #var_0_2 then
			table.insert(var_3_0, 1)
		else
			table.insert(var_3_0, iter_3_0 + 1)
		end

		if findTF(var_3_1, "Text") then
			local var_3_2 = findTF(var_3_1, "Text")

			if var_3_2:GetComponent(typeof(Text)) then
				setText(findTF(var_3_1, "Text"), i18n("word_attr_" .. iter_3_1))
			end
		end
	end

	arg_3_0.drawPolygon:draw({}, var_3_0)

	if arg_3_0.drawPolygon2 then
		arg_3_0.drawPolygon2:draw({}, var_3_0)
	end

	return
end

function var_0_0.getGradeCoordinate(arg_4_0, arg_4_1, arg_4_2)
	return Vector3(0.163 * var_0_3[arg_4_1] * var_0_4[arg_4_2][1], 0.163 * var_0_3[arg_4_1] * var_0_4[arg_4_2][2], 0)
end

function var_0_0.getGradeCoordinate1(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_2 == var_0_8 then
		return Vector3(-(0.66 * var_0_3[arg_5_1]) * var_0_1, 0, 0)
	else
		local var_5_0

		if arg_5_2 == var_0_9 then
			do return Vector3(0.66 * var_0_3[arg_5_1] * var_0_1, 0, 0) end

			goto label_5_0

			var_5_0 = math.sin(math.rad(60)) * (0.66 * var_0_3[arg_5_1] * var_0_1)
		end

		local var_5_1 = math.cos(math.rad(60)) * (0.66 * var_0_3[arg_5_1] * var_0_1)

		if arg_5_2 == var_0_5 then
			var_5_1 = -var_5_1
		elseif arg_5_2 == var_0_6 then
			var_5_1 = -var_5_1
			var_5_0 = -var_5_0
		elseif arg_5_2 == var_0_7 then
			var_5_0 = -var_5_0
		end

		return Vector3(var_5_1, var_5_0, 0)
	end

	::label_5_0::

	return
end

function var_0_0.setSpriteTo(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_2:GetComponent(typeof(Image))

	var_6_0.sprite = findTF(arg_6_0.tf, arg_6_1):GetComponent(typeof(Image)).sprite

	if arg_6_3 then
		var_6_0:SetNativeSize()
	end

	return
end

return var_0_0
