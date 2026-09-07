local MaoxiV4TaskPage = class("MaoxiV4TaskPage", import(".TemplatePage.SkinTemplatePage"))

function MaoxiV4TaskPage:OnUpdateFlush()
	self.nday = self.activity.data3

	local var_1_0 = self.activity:getConfig("config_client").firstStory

	if var_1_0 then
		playStory(var_1_0)
	end

	self:PlayStory()

	if self.dayTF then
		setText(self.dayTF, tostring(self.nday))
	end

	self.uilist:align(#self.taskGroup[self.nday])

	return
end

function MaoxiV4TaskPage:PlayStory()
	local var_2_0 = self.activity:getConfig("config_client").story
	local var_2_1 = self.nday - 1

	if self.nday == 7 then
		if (self.taskProxy:getTaskById(self.taskGroup[self.nday][1]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.nday][1])):getTaskStatus() == 2 and (self.taskProxy:getTaskById(self.taskGroup[self.nday][2]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.nday][2])):getTaskStatus() == 2 then
			var_2_1 = var_2_1 + 1
		end
	end

	if checkExist(var_2_0, {
		var_2_1
	}, {
		1
	}) then
		pg.NewStoryMgr.GetInstance():Play(var_2_0[var_2_1][1])
	end

	return
end

return MaoxiV4TaskPage
