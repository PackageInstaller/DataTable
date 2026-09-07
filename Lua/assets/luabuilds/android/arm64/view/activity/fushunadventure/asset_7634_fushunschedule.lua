local FushunSchedule = class("FushunSchedule")

function FushunSchedule:Ctor()
	self.time = 0
	self.schedules = {}

	return
end

function FushunSchedule:Update()
	for iter_2_0 = #self.schedules, 1, -1 do
		if self.time - self.schedules[iter_2_0].nowtime >= self.schedules[iter_2_0].targetTime then
			self.schedules[iter_2_0].callback()

			self.schedules[iter_2_0].count = self.schedules[iter_2_0].count - 1
			self.schedules[iter_2_0].nowtime = self.time

			if self.schedules[iter_2_0].count == 0 then
				table.remove(self.schedules, iter_2_0)
			end
		end
	end

	self.time = self.time + Time.deltaTime

	return
end

function FushunSchedule:AddSchedule(arg_3_1, arg_3_2, arg_3_3)
	table.insert(self.schedules, {
		targetTime = arg_3_1,
		count = arg_3_2,
		callback = arg_3_3,
		nowtime = self.time
	})

	return
end

function FushunSchedule:Dispose()
	self.schedules = nil

	return
end

return FushunSchedule
