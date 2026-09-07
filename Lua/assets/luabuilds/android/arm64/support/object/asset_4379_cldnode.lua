pg = pg or {}

local CldNode = class("CldNode")

pg.CldNode = CldNode

function CldNode:Ctor(arg_1_1)
	self.cylinder = false

	return
end

function CldNode:UpdateBox(arg_2_1, arg_2_2, arg_2_3)
	self.min = arg_2_1:Copy2(self.min)
	self.max = arg_2_2:Copy2(self.max)

	if arg_2_3 then
		self.min:Add(arg_2_3)
		self.max:Add(arg_2_3)
	end

	return self
end

function CldNode:UpdateStaticBox(arg_3_1, arg_3_2)
	self.min = arg_3_1
	self.max = arg_3_2

	return self
end

function CldNode:UpdateCylinder(arg_4_1, arg_4_2, arg_4_3)
	if arg_4_3 < 0 then
		arg_4_3 = -arg_4_3
	end

	self.center = arg_4_1:Copy2(self.center)
	self.range = arg_4_3

	local var_4_0 = Vector3(arg_4_3, arg_4_2, arg_4_3)

	self.min = arg_4_1 - var_4_0
	self.max = arg_4_1 + var_4_0
	self.cylinder = true

	return self
end

return
