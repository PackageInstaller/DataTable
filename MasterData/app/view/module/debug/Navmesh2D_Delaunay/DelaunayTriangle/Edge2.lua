local Edge2 = class("Edge2")

function Edge2:ctor(arg_1_1, arg_1_2)
	if arg_1_1.x > arg_1_2.x then
		arg_1_1 = arg_1_2
		arg_1_2 = arg_1_1
	end

	self.u = arg_1_1
	self.w = arg_1_2
	self.invalid = false
	self.centerPos = {
		x = (arg_1_1.x + arg_1_2.x) * 0.5,
		y = (arg_1_1.y + arg_1_2.y) * 0.5
	}
	self.len = math.sqrt((self.u.x - self.w.x) * (self.u.x - self.w.x) + (self.u.y - self.w.y) * (self.u.y - self.w.y))
	self._key = nil
end

function Edge2:getKey()
	self._key = self._key or self.u.x == self.w.x and self.u.y > self.w.y and string.format("%s,%s,%s,%s", self.w.x, self.w.y, self.u.x, self.u.y) or string.format("%s,%s,%s,%s", self.u.x, self.u.y, self.w.x, self.w.y)

	return self._key
end

function Edge2:Equal(arg_3_1)
	return self:getKey() == arg_3_1:getKey()
end

function Edge2:pointDistance2(arg_4_1)
	if self.w.x - self.u.x == 0 and self.w.y - self.u.y == 0 then
		return self.u:distance2(arg_4_1)
	end

	local var_4_0 = ((arg_4_1.x - self.u.x) * (self.w.x - self.u.x) + (arg_4_1.y - self.u.y) * (self.w.y - self.u.y)) / ((self.w.x - self.u.x) * (self.w.x - self.u.x) + (self.w.y - self.u.y) * (self.w.y - self.u.y))

	if ((arg_4_1.x - self.u.x) * (self.w.x - self.u.x) + (arg_4_1.y - self.u.y) * (self.w.y - self.u.y)) / ((self.w.x - self.u.x) * (self.w.x - self.u.x) + (self.w.y - self.u.y) * (self.w.y - self.u.y)) < 0 then
		return self.u:distance2(arg_4_1)
	elseif var_4_0 > 1 then
		return self.w:distance2(arg_4_1)
	end

	return (arg_4_1.x - (self.u.x + var_4_0 * (self.w.x - self.u.x))) * (arg_4_1.x - (self.u.x + var_4_0 * (self.w.x - self.u.x))) + (arg_4_1.y - (self.u.y + var_4_0 * (self.w.y - self.u.y))) * (arg_4_1.y - (self.u.y + var_4_0 * (self.w.y - self.u.y)))
end

return Edge2
