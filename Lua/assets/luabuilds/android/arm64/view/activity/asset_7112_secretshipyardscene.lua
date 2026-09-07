local SecretShipyardScene = class("SecretShipyardScene", import("..base.BaseUI"))

SecretShipyardScene.optionsPath = {
	"main/top/btn_home"
}
SecretShipyardScene.ACT_ID = 5625
SecretShipyardScene.GAME_ID = 59
SecretShipyardScene.ANIMATIONS = {
	"Phase_00",
	"Phase_01",
	"Phase_02",
	"Phase_03",
	"Phase_04",
	"Phase_05",
	"Phase_06",
	"Phase_07"
}
SecretShipyardScene.EFFECT_DELAY = 2
SecretShipyardScene.ANIMATION_DELAY = 1
SecretShipyardScene.STORY_DELAY = 3

function SecretShipyardScene:getUIName()
	return "SecretShipyardUI"
end

function SecretShipyardScene:init()
	self.activity = getProxy(ActivityProxy):getActivityById(SecretShipyardScene.ACT_ID)
	self.count = 0
	self.bgId = 1
	self.taskProxy = getProxy(TaskProxy)
	self.taskGroup = self.activity:getConfig("config_data")
	self.main = self._tf:Find("main")
	self.bottom = self.main:Find("bottom")
	self.gameButton = self.bottom:Find("btn_go_game")
	self.gameButtonLock = self.gameButton:Find("btn_go_game_lock")
	self.items = self.bottom:Find("items")
	self.item = self.bottom:Find("item")
	self.dayText = self.bottom:Find("day/nday")
	self.description = self.bottom:Find("description/Text")
	self.top = self.main:Find("top")
	self.buttonBack = self.top:Find("btn_back")
	self.buttonHelp = self.top:Find("btn_help")
	self.uilist = UIItemList.New(self.items, self.item)
	self.bg = self._tf:Find("bg")
	self.animator = self.bg:Find("anim"):GetComponent(typeof(Animator))
	self.effect = self.bg:Find("effect")

	return
end

function SecretShipyardScene:didEnter()
	onButton(self, self.buttonBack, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.buttonHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("shipyard_phase_1" or "shipyard_phase_2")
		})

		return
	end, SFX_PANEL)
	onButton(self, self.gameButton, function()
		if not self:checkTaskFinish() or not self:checkMinigame() then
			return
		end

		self:emit(SecretShipyardMediator.GO_MINI_GAME, SecretShipyardScene.GAME_ID)

		return
	end, SFX_PANEL)
	onButton(self, self.gameButtonLock, function()
		pg.TipsMgr.GetInstance():ShowTips(i18n(self:checkTaskFinish() and "shipyard_button_1" or "shipyard_button_2"))

		return
	end, SFX_PANEL)
	self.uilist:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventUpdate then
			self:UpdateTask(arg_8_1, arg_8_2)
		end

		return
	end)
	setText(self.description, i18n("shipyard_introduce"))
	setActive(self.effect, false)
	setActive(self.buttonHelp, self:checkMinigame())

	self.count = self.activity.data3
	self.bgId = self:CheckBgId()

	self.animator:Play(SecretShipyardScene.ANIMATIONS[self.bgId])
	self:OnUpdateFlush()

	local var_3_0 = self.activity:getConfig("config_client").firstStory

	if var_3_0 then
		playStory(var_3_0)
	end

	self:PlayStory()

	return
end

function SecretShipyardScene:UpdateTask(arg_9_1, arg_9_2)
	local var_9_0 = arg_9_2:Find("item")
	local var_9_1 = self.taskGroup[self.count][arg_9_1 + 1]
	local var_9_2 = self.taskProxy:getTaskById(self.taskGroup[self.count][arg_9_1 + 1]) or self.taskProxy:getFinishTaskById(var_9_1)

	assert(var_9_2, "without this task by id: " .. self.taskGroup[self.count][arg_9_1 + 1])

	local var_9_3 = var_9_2:getConfig("award_display")[1]
	local var_9_4 = {
		type = var_9_3[1],
		id = var_9_3[2],
		count = var_9_3[3]
	}

	updateDrop(var_9_0, var_9_4)
	onButton(self, var_9_0, function()
		warning("click")
		self:emit(BaseUI.ON_DROP, var_9_4)

		return
	end, SFX_PANEL)

	local var_9_5 = var_9_2:getProgress()
	local var_9_6 = var_9_2:getConfig("target_num")

	setText(arg_9_2:Find("description"), var_9_2:getConfig("desc"))
	setText(arg_9_2:Find("progress_text"), var_9_5 .. "/" .. var_9_6)
	setSlider(arg_9_2:Find("progress"), 0, var_9_6, var_9_5)

	local var_9_7 = arg_9_2:Find("go_btn")
	local var_9_8 = arg_9_2:Find("get_btn")
	local var_9_9 = arg_9_2:Find("got_btn")
	local var_9_10 = var_9_2:getTaskStatus()

	setActive(var_9_7, var_9_10 == 0)
	setActive(var_9_8, var_9_10 == 1)
	setActive(var_9_9, var_9_10 == 2)
	onButton(self, var_9_7, function()
		self:emit(SecretShipyardMediator.TASK_GO, var_9_2)

		return
	end, SFX_PANEL)
	onButton(self, var_9_8, function()
		self:emit(SecretShipyardMediator.SUBMIT_TASK, var_9_2.id)

		return
	end, SFX_PANEL)
	setActive(arg_9_2:Find("mask"), self.taskProxy:getFinishTaskById(var_9_1) ~= nil)

	return
end

function SecretShipyardScene:updateTaskLayers()
	updateActivityTaskStatus(self.activity)

	self.activity = getProxy(ActivityProxy):getActivityById(SecretShipyardScene.ACT_ID)

	self:OnUpdateFlush()

	return
end

function SecretShipyardScene:CheckBgId()
	local var_14_0 = self.activity.data3

	if self.taskProxy:getFinishTaskById(self.taskGroup[self.count][1]) ~= nil and self.taskProxy:getFinishTaskById(self.taskGroup[self.count][2]) ~= nil then
		var_14_0 = var_14_0 + 1
	end

	return var_14_0
end

function SecretShipyardScene:OnUpdateFlush()
	self.count = self.activity.data3

	if self.bgId ~= self:CheckBgId() then
		self.bgId = self:CheckBgId()

		self:ChangeBackground()
	end

	if self.dayText then
		setText(self.dayText, tostring(self.count))
	end

	setActive(self.gameButtonLock, not self:checkTaskFinish() or not self:checkMinigame())
	setActive(self.gameButton, self:checkTaskFinish() or self:checkMinigame())
	self.uilist:align(#self.taskGroup[self.count])

	return
end

function SecretShipyardScene:ChangeBackground()
	LeanTween.cancel(go(self._tf))
	setActive(self.effect, true)
	LeanTween.delayedCall(go(self._tf), SecretShipyardScene.ANIMATION_DELAY, System.Action(function()
		self.animator:Play(SecretShipyardScene.ANIMATIONS[self.bgId])

		return
	end))
	LeanTween.delayedCall(go(self._tf), SecretShipyardScene.EFFECT_DELAY, System.Action(function()
		setActive(self.effect, false)

		return
	end))
	LeanTween.delayedCall(go(self._tf), SecretShipyardScene.STORY_DELAY, System.Action(function()
		self:PlayStory()

		return
	end))

	return
end

function SecretShipyardScene:PlayStory()
	local var_20_0 = self.activity:getConfig("config_client").story

	if checkExist(var_20_0, {
		self.bgId - 1
	}, {
		1
	}) then
		playStory(var_20_0[self.bgId - 1][1])
	end

	return
end

function SecretShipyardScene:checkTaskFinish()
	if self.count < #self.taskGroup then
		return false
	end

	for iter_21_0, iter_21_1 in ipairs(self.taskGroup[self.count]) do
		if not self.taskProxy:getFinishTaskById(iter_21_1) then
			return false
		end
	end

	return true
end

function SecretShipyardScene:checkMinigame()
	return pg.mini_game[SecretShipyardScene.GAME_ID] ~= nil and pg.TimeMgr.GetInstance():inTime(pg.mini_game[SecretShipyardScene.GAME_ID].simple_config_data.show_time)
end

function SecretShipyardScene:willExit()
	LeanTween.cancel(go(self._tf))

	return
end

return SecretShipyardScene
