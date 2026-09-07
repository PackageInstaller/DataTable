local ReturnerActivity = class("ReturnerActivity", import(".Activity"))

ReturnerActivity.TYPE_INVITER = 1
ReturnerActivity.TYPE_RETURNER = 2

function ReturnerActivity:Ctor(arg_1_1)
	ReturnerActivity.super.Ctor(self, arg_1_1)

	self.roleType = self.data1

	return
end

function ReturnerActivity:IsPush()
	return self.data2_list[1] == 1
end

function ReturnerActivity:IsInviter()
	return self.roleType == ReturnerActivity.TYPE_INVITER
end

function ReturnerActivity:IsReturner()
	return self.roleType == ReturnerActivity.TYPE_RETURNER
end

function ReturnerActivity:ShouldAcceptTasks()
	if self:IsInviter() then
		return self:ShouldAcceptTasksIfInviter()
	elseif self:IsReturner() then
		return self:ShouldAcceptTasksIfReturner()
	end

	return
end

function ReturnerActivity:ShouldAcceptTasksIfInviter()
	if self:IsPush() then
		local var_6_0 = self:getDataConfigTable("tasklist")
		local var_6_1 = getProxy(TaskProxy)
		local var_6_2 = 0

		for iter_6_0 = #var_6_0, 1, -1 do
			if self:GetTask(var_6_0[iter_6_0]) then
				var_6_2 = iter_6_0

				break
			end
		end

		local var_6_3 = self:GetTask(var_6_0[var_6_2])

		if (not var_6_3 or var_6_3:isReceive()) and var_6_2 < self:getDayIndex() and (var_6_2 ~= #var_6_0 or not var_6_3 or not var_6_3:isReceive()) then
			return true
		end
	end

	return false
end

function ReturnerActivity:GetTask(arg_7_1)
	local var_7_0 = getProxy(TaskProxy)

	return var_7_0:getTaskById(arg_7_1) or var_7_0:getFinishTaskById(arg_7_1)
end

function ReturnerActivity:ShouldAcceptTasksIfReturner()
	local var_8_0 = self.data4

	if self.data2 == 0 then
		return false
	end

	if self.data4 == 0 then
		return true
	end

	local var_8_1 = self:getDataConfigTable("task_list")
	local var_8_2 = getProxy(TaskProxy)

	return _.all(var_8_1[self.data4], function(arg_10_0)
		return var_8_2:getTaskById(arg_10_0) == nil and var_8_2:getFinishTaskById(arg_10_0) == nil
	end) or _.all(var_8_1[self.data4], function(arg_9_0)
		return var_8_2:getFinishTaskById(arg_9_0) ~= nil
	end) and self.data4 ~= #var_8_1 and (function()
		return pg.TimeMgr.GetInstance():DiffDay(self:getStartTime(), (pg.TimeMgr.GetInstance():GetServerTime())) + 1 > var_8_0
	end)()
end

function ReturnerActivity:getDataConfigTable(arg_12_1)
	if self:IsInviter() then
		return pg.activity_template_headhunting[self.id][arg_12_1]
	elseif self:IsReturner() then
		return pg.activity_template_returnner[self.id][arg_12_1]
	end

	return
end

return ReturnerActivity
