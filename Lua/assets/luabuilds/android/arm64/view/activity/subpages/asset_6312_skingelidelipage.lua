local SkinGelideliPage = class("SkinGelideliPage", import("view.base.BaseActivityPage"))

function SkinGelideliPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.textProgress = self.bg:Find("progress_text")
	self.btnGo = self.bg:Find("btn_go")
	self.markGot = self.btnGo:Find("got")

	return
end

function SkinGelideliPage:OnDataSetting()
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

function SkinGelideliPage:OnFirstFlush()
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

function SkinGelideliPage:OnUpdateFlush()
	setText(self.textProgress, self.taskIndex .. "/" .. #self.taskList)
	setButtonEnabled(self.btnGo, self.taskIndex < #self.taskList)
	setActive(self.markGot, self.taskIndex == #self.taskList)

	return
end

function SkinGelideliPage:OnDestroy()
	return
end

return SkinGelideliPage
