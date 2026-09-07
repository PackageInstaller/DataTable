local HelenaLoginPage = class("HelenaLoginPage", import("view.activity.CorePage.CoreLoginTemplatePage"))

function HelenaLoginPage:OnDataSetting()
	self.nday = 0
	self.taskProxy = getProxy(TaskProxy)
	self.taskGroup = self.activity:getConfig("config_data")
	self.preStory = self.activity:getConfig("config_client").firstStory

	if self.preStory ~= nil then
		pg.NewStoryMgr.GetInstance():Play(self.preStory)
	end

	return updateActivityTaskStatus(self.activity)
end

function HelenaLoginPage:OnUpdateFlush()
	self.nday = self.activity.data3

	self:PlayStory()

	if self.dayTF then
		setText(self.dayTF, self.nday .. "/" .. #self.taskGroup)
	end

	self.uilist:align(#self.taskGroup[self.nday])

	return
end

function HelenaLoginPage:PlayStory()
	local var_3_0 = self.activity:getConfig("config_client").story
	local var_3_1 = self.nday - 1

	if self.nday < 8 then
		if (self.taskProxy:getTaskById(self.taskGroup[self.nday][1]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.nday][1])):getTaskStatus() == 2 and (self.taskProxy:getTaskById(self.taskGroup[self.nday][2]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.nday][2])):getTaskStatus() == 2 then
			var_3_1 = var_3_1 + 1
		end
	end

	if checkExist(var_3_0, {
		var_3_1
	}, {
		1
	}) then
		pg.NewStoryMgr.GetInstance():Play(var_3_0[var_3_1][1])
	end

	return
end

function HelenaLoginPage:GetProgressColor()
	return "#466cd4", "#737373"
end

return HelenaLoginPage
