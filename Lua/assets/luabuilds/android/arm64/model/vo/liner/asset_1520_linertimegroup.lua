local LinerTimeGroup = class("LinerTimeGroup", import("model.vo.BaseVO"))

function LinerTimeGroup:Ctor(arg_1_1)
	self.id = arg_1_1
	self.configId = self.id
	self.times = {}

	for iter_1_0, iter_1_1 in ipairs(self:GetIds()) do
		self.times[iter_1_1] = LinerTime.New(iter_1_1)
	end

	return
end

function LinerTimeGroup:bindConfigTable()
	return pg.activity_liner_time_group
end

function LinerTimeGroup:GetTime(arg_3_1)
	return self.times[arg_3_1]
end

function LinerTimeGroup:GetTimes()
	return self.times
end

function LinerTimeGroup:GetIds()
	return self:getConfig("ids")
end

function LinerTimeGroup:GetTimeList()
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(self.times) do
		table.insert(var_6_0, iter_6_1)
	end

	return var_6_0
end

function LinerTimeGroup:GetDrop()
	return Drop.Create(self:getConfig("drop_display"))
end

return LinerTimeGroup
