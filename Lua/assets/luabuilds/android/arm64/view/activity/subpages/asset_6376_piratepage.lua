local PiratePage = class("PiratePage", import("view.base.BaseActivityPage"))

PiratePage.PROGRESS_TEXT = "%d/7"
PiratePage.DIALOG_DELAY = 15

function PiratePage:OnInit()
	self.bg = self._tf:Find("AD")
	self.progress = self.bg:Find("progress")
	self.progressText = self.progress:Find("Text")
	self.complete = self.bg:Find("complete")
	self.goBtn = self.bg:Find("go_btn")
	self.red = self.goBtn:Find("red")
	self.dialogTf = self.bg:Find("dialog")
	self.dialogText = self.dialogTf:Find("Text")

	return
end

function PiratePage:OnDataSetting()
	self.count = 0
	self.taskProxy = getProxy(TaskProxy)
	self.taskGroup = self.activity:getConfig("config_data")
	self.totoalCount = #self.taskGroup
	self.dialog_progress = self.activity:getConfig("config_client").shipyard_phase_1
	self.dialog_complete = self.activity:getConfig("config_client").shipyard_phase_2

	return updateActivityTaskStatus(self.activity)
end

function PiratePage:OnShowFlush()
	setActive(self.dialogTf, true)
	setImageAlpha(self.dialogTf, 1)
	setText(self.dialogText, not self.activity:canPermanentFinish() and self.dialog_progress[math.random(#self.dialog_progress)] or self.dialog_complete[math.random(#self.dialog_complete)])
	LeanTween.alpha(self.dialogTf, 0, 0.5):setDelay(PiratePage.DIALOG_DELAY):setOnComplete(System.Action(function()
		SetActive(self.dialogTf, false)

		return
	end))

	return
end

function PiratePage:OnHideFlush()
	LeanTween.cancel(self.dialogTf)

	return
end

function PiratePage:OnFirstFlush()
	self.count = self.activity.data3

	setActive(self.red, self:CheckRed())
	onButton(self, self.goBtn, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SECRET_SHIPYARD)

		return
	end, SFX_PANEL)

	return
end

function PiratePage:CheckRed()
	local var_8_0 = not not self.activity:readyToAchieve()
	local var_8_1 = self.activity:getNDay()

	if var_8_1 < 8 and PlayerPrefs.GetInt("PiratePage" .. var_8_1, 0) == 0 then
		PlayerPrefs.SetInt("PiratePage" .. var_8_1, 1)

		var_8_0 = true
	end

	return var_8_0
end

function PiratePage:OnUpdateFlush()
	self.count = self.activity.data3

	if self.progress then
		setText(self.progressText, string.format(PiratePage.PROGRESS_TEXT, self.count))
		setActive(self.progress, not self.activity:canPermanentFinish())
		setActive(self.complete, self.activity:canPermanentFinish())
	end

	return
end

return PiratePage
