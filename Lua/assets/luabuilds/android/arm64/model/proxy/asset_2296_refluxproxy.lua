local RefluxProxy = class("RefluxProxy", import(".NetProxy"))

function RefluxProxy:register()
	self:initData()
	self:addListener()

	return
end

function RefluxProxy:timeCall()
	return {
		[ProxyRegister.DayCall] = function(arg_3_0)
			self:setAutoActionForbidden(false)
			self:sendNotification(GAME.REFLUX_REQUEST_DATA)

			return
		end
	}
end

function RefluxProxy:initData()
	self.active = false
	self.returnLV = 0
	self.returnTimestamp = 0
	self.returnShipNum = 0
	self.returnLastTimestamp = 0
	self.ptNum = 0
	self.ptStage = 0
	self.signCount = 0
	self.signLastTimestamp = 0
	self.autoActionForbidden = false

	return
end

function RefluxProxy:setData(arg_5_1)
	self.active = arg_5_1.active == 1
	self.returnLV = arg_5_1.return_lv
	self.returnTimestamp = arg_5_1.return_time
	self.returnShipNum = arg_5_1.ship_number
	self.returnLastTimestamp = arg_5_1.last_offline_time
	self.ptNum = arg_5_1.pt
	self.ptStage = arg_5_1.pt_stage
	self.signCount = arg_5_1.sign_cnt
	self.signLastTimestamp = arg_5_1.sign_last_time

	return
end

function RefluxProxy:addListener()
	self:on(11752, function(arg_7_0)
		self:setData(arg_7_0)

		return
	end)

	return
end

function RefluxProxy:setSignLastTimestamp(arg_8_1)
	self.signLastTimestamp = arg_8_1 or pg.TimeMgr.GetInstance():GetServerTime()

	return
end

function RefluxProxy:addSignCount()
	self.signCount = self.signCount + 1

	return
end

function RefluxProxy:addPtAfterSubTasks(arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		self.ptNum = self.ptNum + pg.return_task_template[iter_10_1.id].pt_award
	end

	return
end

function RefluxProxy:addPTStage()
	self.ptStage = self.ptStage + 1

	return
end

function RefluxProxy:isActive()
	return self.active
end

function RefluxProxy:isCanSign()
	if self:isActive() and not self.autoActionForbidden then
		local var_13_0 = pg.TimeMgr.GetInstance()

		if self.signCount < #pg.return_sign_template.all and not var_13_0:IsSameDay(var_13_0:GetServerTime(), self.signLastTimestamp) then
			return true
		end
	end

	return
end

function RefluxProxy:isInRefluxTime()
	if self:isActive() then
		if self.returnTimestamp + #pg.return_sign_template.all * 0 <= pg.TimeMgr.GetInstance():GetServerTime() then
			return false
		else
			return true
		end
	else
		return false
	end

	return
end

function RefluxProxy:setAutoActionForbidden(arg_15_1)
	self.autoActionForbidden = arg_15_1

	return
end

function RefluxProxy:GetRefluxBgs()
	local var_16_0 = getProxy(RefluxProxy).returnLastTimestamp
	local var_16_1 = {}

	for iter_16_0, iter_16_1 in ipairs(pg.cg_display.all) do
		local var_16_2 = {
			{
				pg.cg_display[iter_16_1].version_time[1],
				pg.cg_display[iter_16_1].version_time[2],
				pg.cg_display[iter_16_1].version_time[3]
			}
		}
		local var_16_3 = {}

		var_16_3[1] = 0
		var_16_3[2] = 0
		var_16_3[3] = 0
		var_16_2[2] = var_16_3

		local var_16_4 = pg.TimeMgr.GetInstance():parseTimeFromConfig(var_16_2)

		if var_16_0 < var_16_4 then
			table.insert(var_16_1, {
				id = iter_16_1,
				time = var_16_4
			})
		end
	end

	table.sort(var_16_1, function(arg_17_0, arg_17_1)
		local var_17_1 = pg.cg_display[arg_17_0.id]
		local var_17_2 = pg.cg_display[arg_17_1.id]

		if pg.cg_display[arg_17_0.id].Cgpriority == pg.cg_display[arg_17_1.id].Cgpriority then
			return arg_17_1.time < arg_17_0.time
		else
			return var_17_1.Cgpriority > var_17_2.Cgpriority
		end

		return
	end)

	local var_16_5 = {}

	for iter_16_2 = 1, 20 do
		if var_16_1[iter_16_2] then
			table.insert(var_16_5, pg.cg_display[var_16_1[iter_16_2].id].Cgname)
		end
	end

	return var_16_5
end

return RefluxProxy
