local LuodeniTaskPage = class("LuodeniTaskPage", import(".TemplatePage.SkinTemplatePage"))

function LuodeniTaskPage:OnUpdateFlush()
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
	setText(self.dayTF, setColorStr(self.nday, "#F2F5FF") .. setColorStr("/" .. #self.taskGroup, "#F2F5FF"))

	return
end

function LuodeniTaskPage:PlayStory()
	local var_2_0 = self.activity:getConfig("config_client").story
	local var_2_1 = false

	if self.nday == 1 then
		if (self.taskProxy:getTaskById(self.taskGroup[1][1]) or self.taskProxy:getFinishTaskById(self.taskGroup[1][1])):getTaskStatus() == 2 and (self.taskProxy:getTaskById(self.taskGroup[1][2]) or self.taskProxy:getFinishTaskById(self.taskGroup[1][2])):getTaskStatus() == 2 and checkExist(var_2_0, {
			1
		}, {
			1
		}) then
			var_2_1 = true
		end
	end

	if self.nday == 1 and (self.nday == 2 or nil) and true or self.nday == 2 then
		pg.NewStoryMgr.GetInstance():Play(var_2_0[1][1])
	end

	if self.nday == 5 then
		local var_2_3 = self.nday

		if (self.taskProxy:getTaskById(self.taskGroup[self.nday][1]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.nday][1])):getTaskStatus() == 2 and (self.taskProxy:getTaskById(self.taskGroup[self.nday][2]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.nday][2])):getTaskStatus() == 2 then
			var_2_3 = var_2_3 + 1
		end

		if checkExist(var_2_0, {
			var_2_3
		}, {
			1
		}) then
			pg.NewStoryMgr.GetInstance():Play(var_2_0[var_2_3][1])
		end
	elseif self.nday ~= 1 and checkExist(var_2_0, {
		self.nday
	}, {
		1
	}) then
		pg.NewStoryMgr.GetInstance():Play(var_2_0[self.nday][1])
	end

	return
end

function LuodeniTaskPage:GetProgressColor()
	return "#98A7D1", "#98A7D1"
end

return LuodeniTaskPage
