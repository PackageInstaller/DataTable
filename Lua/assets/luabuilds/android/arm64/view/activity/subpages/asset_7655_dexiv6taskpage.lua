local MaoxiV4TaskPage = class("MaoxiV4TaskPage", import(".TemplatePage.SkinTemplatePage"))

function MaoxiV4TaskPage:OnUpdateFlush()
	self.nday = self.activity.data3

	self:PlayStory()

	if self.dayTF then
		setText(self.dayTF, tostring(self.nday))
	end

	self.uilist:align(#self.taskGroup[self.nday])

	return
end

function MaoxiV4TaskPage:PlayStory()
	local var_2_0 = self.activity:getConfig("config_client").story
	local var_2_1 = self.activity:getConfig("config_client").specialstory
	local var_2_2 = self.nday == 1 and (self.taskProxy:getTaskVO(self.taskGroup[self.nday][1]):isReceive() and self.taskProxy:getTaskVO(self.taskGroup[self.nday][2]):isReceive() and var_2_1[1] or var_2_0[self.nday]) or self.nday == 2 and (not pg.NewStoryMgr.GetInstance():IsPlayed(var_2_1[1]) and var_2_1[1] or var_2_0[self.nday]) or self.nday == #var_2_0 and (self.taskProxy:getTaskVO(self.taskGroup[self.nday][1]):isReceive() and self.taskProxy:getTaskVO(self.taskGroup[self.nday][2]):isReceive() and var_2_1[2] or var_2_0[self.nday]) or var_2_0[self.nday]

	print("story name:" .. var_2_2)
	pg.NewStoryMgr.GetInstance():Play(var_2_2)

	return
end

return MaoxiV4TaskPage
