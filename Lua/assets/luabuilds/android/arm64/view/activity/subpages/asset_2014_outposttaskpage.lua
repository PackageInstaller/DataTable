local OutPostTaskPage = class("OutPostTaskPage", import(".TemplatePage.SkinTemplatePage"))

function OutPostTaskPage:OnUpdateFlush()
	OutPostTaskPage.super.OnUpdateFlush(self)
	setText(self.dayTF, self.nday)

	return
end

function OutPostTaskPage:PlayStory()
	local var_2_0 = self.activity:getConfig("config_client").story

	if checkExist(var_2_0, {
		self.nday - (((self.taskProxy:getTaskById(self.taskGroup[self.nday][1]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.nday][1])):getTaskStatus() == 2 and (self.taskProxy:getTaskById(self.taskGroup[self.nday][2]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.nday][2])):getTaskStatus() == 2 or nil) and 0)
	}, {
		1
	}) then
		pg.NewStoryMgr.GetInstance():Play(var_2_0[self.nday - (((self.taskProxy:getTaskById(self.taskGroup[self.nday][1]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.nday][1])):getTaskStatus() == 2 and (self.taskProxy:getTaskById(self.taskGroup[self.nday][2]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.nday][2])):getTaskStatus() == 2 or nil) and 0)][1])
	end

	return
end

return OutPostTaskPage
