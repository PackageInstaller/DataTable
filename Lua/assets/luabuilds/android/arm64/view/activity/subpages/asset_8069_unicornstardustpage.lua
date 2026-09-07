local UnicornStardustPage = class("UnicornStardustPage", import("view.base.BaseActivityPage"))

function UnicornStardustPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.textProgress = self.bg:Find("progress_text")
	self.btnGo = self.bg:Find("btn_go")
	self.got = self.bg:Find("got")

	return
end

function UnicornStardustPage:OnDataSetting()
	local var_2_0 = getProxy(TaskProxy)

	self.taskList = self.activity:getConfig("config_data")
	self.taskIndex = #self.taskList
	self.taskVO = nil

	while self.taskIndex > 0 do
		self.taskVO = var_2_0:getTaskVO(self.taskList[self.taskIndex])

		if self.taskVO then
			break
		end

		self.taskIndex = self.taskIndex - 1
	end

	return
end

function UnicornStardustPage:OnFirstFlush()
	onButton(self, self.btnGo, function()
		if self.taskVO and not self.taskVO:isReceive() then
			self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK)
		else
			self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.NAVALACADEMYSCENE)
		end

		return
	end, SFX_PANEL)

	return
end

function UnicornStardustPage:OnUpdateFlush()
	setText(self.textProgress, self.taskIndex .. "/" .. #self.taskList)
	setButtonEnabled(self.btnGo, self.taskIndex < #self.taskList)
	setActive(self.got, self.taskIndex == #self.taskList)

	return
end

function UnicornStardustPage:OnDestroy()
	return
end

return UnicornStardustPage
