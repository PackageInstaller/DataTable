local EducatePolaroid = class("EducatePolaroid", import("model.vo.BaseVO"))

function EducatePolaroid:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = self.id
	self.time = arg_1_1.time or {
		week = 1,
		month = 3,
		day = 7
	}

	return
end

function EducatePolaroid:bindConfigTable()
	return pg.child_polaroid
end

function EducatePolaroid:GetTimeWeight()
	return self.time.month * 28 + self.time.week * 7 + self.time.day
end

return EducatePolaroid
