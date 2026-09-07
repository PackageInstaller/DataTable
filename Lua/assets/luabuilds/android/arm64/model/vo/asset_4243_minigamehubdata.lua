local MiniGameHubData = class("MiniGameHubData", import(".BaseVO"))

function MiniGameHubData:Ctor(arg_1_1)
	MiniGameHubData.super.Ctor(self, arg_1_1)

	self.id = arg_1_1.id
	self.configId = arg_1_1.id
	self.count = arg_1_1.available_cnt or self:getConfig("reborn_times")
	self.usedtime = arg_1_1.used_cnt or 0
	self.ultimate = arg_1_1.ultimate or 0
	self.highScores = {}

	underscore.each(arg_1_1.maxscores or {}, function(arg_2_0)
		self.highScores[arg_2_0.key] = {
			arg_2_0.value1,
			arg_2_0.value2
		}

		return
	end)

	return
end

function MiniGameHubData:bindConfigTable()
	return pg.mini_game_hub
end

function MiniGameHubData:UpdateData(arg_4_1)
	self.count = arg_4_1.available_cnt or self.count
	self.usedtime = arg_4_1.used_cnt or self.usedtime
	self.ultimate = arg_4_1.ultimate or self.ultimate

	underscore.each(arg_4_1.maxscores or {}, function(arg_5_0)
		self.highScores[arg_5_0.key] = {
			arg_5_0.value1,
			arg_5_0.value2
		}

		return
	end)
	print("Hub 更新", "ID:", tostring(self.id), "Count:", tostring(self.count), "UsedTime:", tostring(self.usedtime), "Ultimate:", tostring(self.ultimate))

	return
end

function MiniGameHubData:CheckInTime()
	local var_6_0 = self:getConfig("act_id")

	if var_6_0 ~= nil then
		if pg.activity_template[var_6_0] then
			return (pg.TimeMgr.GetInstance():inTime(pg.activity_template[var_6_0].time))
		end
	else
		return true
	end

	return
end

return MiniGameHubData
