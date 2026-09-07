local PropertyPanel = class("PropertyPanel")
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

PropertyPanel.TypeRotation = 1
PropertyPanel.TypeFlat = 2

function PropertyPanel:Ctor(arg_1_1, arg_1_2)
	var_0_1 = arg_1_2 or var_0_1
	self.tf = arg_1_1
	self.propertyTFs = findTF(self.tf, "property")
	self.drawTF = findTF(self.tf, "property/draw")
	self.drawPolygon = self.drawTF:GetComponent("DrawPolygon")
	self.drawTF2 = findTF(self.tf, "property/draw_2")

	if self.drawTF2 then
		self.drawPolygon2 = self.drawTF2:GetComponent("DrawPolygon")
	end

	return
end

function PropertyPanel:initProperty(arg_2_1, arg_2_2)
	self.type = arg_2_2 or PropertyPanel.TypeRotation

	self:initRadar(ShipGroup.GetGroupConfig((Ship.getGroupIdByConfigId(arg_2_1))).property_hexagon)

	return
end

function PropertyPanel:initRadar(arg_3_1)
	local var_3_0 = {}
	local var_3_1 = {}

	table.insert(var_3_0, Vector3(0, 0, 0))

	for iter_3_0, iter_3_1 in ipairs(var_0_2) do
		local var_3_2 = self.propertyTFs:Find(iter_3_1 .. "_grade")

		self:setSpriteTo("resources/" .. arg_3_1[iter_3_0], var_3_2:Find("grade"), true)

		if self.type == PropertyPanel.TypeRotation then
			table.insert(var_3_0, self:getGradeCoordinate(arg_3_1[iter_3_0], iter_3_0))
		elseif self.type == PropertyPanel.TypeFlat then
			table.insert(var_3_0, self:getGradeCoordinate1(arg_3_1[iter_3_0], iter_3_0))
		end

		table.insert(var_3_1, 0)
		table.insert(var_3_1, iter_3_0)

		if iter_3_0 + 1 > #var_0_2 then
			table.insert(var_3_1, 1)
		else
			table.insert(var_3_1, iter_3_0 + 1)
		end

		if findTF(var_3_2, "Text") then
			if findTF(var_3_2, "Text"):GetComponent(typeof(Text)) then
				setText(findTF(var_3_2, "Text"), i18n("word_attr_" .. iter_3_1))
			end
		end
	end

	self.drawPolygon:draw(var_3_0, var_3_1)

	if self.drawPolygon2 then
		self.drawPolygon2:draw(var_3_0, var_3_1)
	end

	return
end

function PropertyPanel:getGradeCoordinate(arg_4_1, arg_4_2)
	return Vector3(0.163 * var_0_3[arg_4_1] * var_0_4[arg_4_2][1], 0.163 * var_0_3[arg_4_1] * var_0_4[arg_4_2][2], 0)
end

function PropertyPanel:getGradeCoordinate1(arg_5_1, arg_5_2)
	if arg_5_2 == var_0_8 then
		return Vector3(-(0.66 * var_0_3[arg_5_1]) * var_0_1, 0, 0)
	elseif arg_5_2 == var_0_9 then
		return Vector3(0.66 * var_0_3[arg_5_1] * var_0_1, 0, 0)
	else
		local var_5_0 = math.sin(math.rad(60)) * (0.66 * var_0_3[arg_5_1] * var_0_1)
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

	return
end

function PropertyPanel:setSpriteTo(arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_2:GetComponent(typeof(Image))

	var_6_0.sprite = findTF(self.tf, arg_6_1):GetComponent(typeof(Image)).sprite

	if arg_6_3 then
		var_6_0:SetNativeSize()
	end

	return
end

return PropertyPanel
