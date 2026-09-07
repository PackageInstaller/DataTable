local NewMeixiV4Scene = class("NewMeixiV4Scene", import("..base.BaseUI"))

function NewMeixiV4Scene:getUIName()
	return "NewMeixiV4UI"
end

function NewMeixiV4Scene:ResUISettings()
	return true
end

function NewMeixiV4Scene:init()
	self.ani = self._tf:Find("TV01")
	self.progress = self._tf:Find("progress/Text")
	self.nodes = self._tf:Find("nodes")
	self.nodeInfo = self._tf:Find("node_info")
	self.titleTxt = self._tf:Find("progress/title")
	self.titleNum = self._tf:Find("progress/cur")
	self.helpBtn = self._tf:Find("help_btn")
	self.storyTip = self._tf:Find("get_story")
	self.taskProxy = getProxy(TaskProxy)
	self.storyGroup = pg.activity_template[ActivityConst.NEWMEIXIV4_SKIRMISH_ID].config_client.storys
	self.memoryGroup = pg.activity_template[ActivityConst.NEWMEIXIV4_SKIRMISH_ID].config_client.memoryGroup

	return
end

function NewMeixiV4Scene:didEnter()
	onButton(self, self._tf:Find("top/back_btn"), function()
		self:emit(NewMeixiV4Scene.ON_BACK)

		return
	end, SOUND_BACK)
	onButton(self, self._tf:Find("top/option"), function()
		self:emit(NewMeixiV4Scene.ON_HOME)

		return
	end, SFX_CANCEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("MeixiV4_help")
		})

		return
	end, SFX_PANEL)
	setText(self.storyTip:Find("bar/tip"), i18n("world_collection_back"))
	self:playAni()
	self:updateNodes()

	return
end

function NewMeixiV4Scene:setPlayer(arg_8_1)
	self.player = arg_8_1

	self:onUpdateRes(arg_8_1)

	return
end

function NewMeixiV4Scene:onUpdateRes(arg_9_1)
	self.player = arg_9_1

	return
end

function NewMeixiV4Scene:playAni()
	SetActive(self.ani, true)
	self.ani:GetComponent("DftAniEvent"):SetEndEvent(function(arg_11_0)
		SetActive(self.ani, false)

		return
	end)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WARNING)

	return
end

function NewMeixiV4Scene:setCurIndex()
	self.curIndex = 1
	self.clearTaskNum = 0
	self.clearTaskNum = (function()
		for iter_13_0, iter_13_1 in ipairs(self.contextData.taskList) do
			if self.taskProxy:getTaskById(iter_13_1) or self.taskProxy:getFinishTaskById(iter_13_1) then
				return iter_13_0 - 1
			end
		end

		return
	end)()

	for iter_12_0, iter_12_1 in ipairs(self.contextData.taskList) do
		local var_12_0 = self.taskProxy:getTaskById(iter_12_1) or self.taskProxy:getFinishTaskById(iter_12_1)
		local var_12_1 = self.contextData.taskList[iter_12_0 + 1]

		if var_12_0 and var_12_0:getTaskStatus() == 2 then
			self.curIndex = self.curIndex + 1

			if not var_12_1 or not (self.taskProxy:getTaskById(self.contextData.taskList[iter_12_0 + 1]) or self.taskProxy:getFinishTaskById(var_12_1)) then
				self.curIndex = self.curIndex - 1
			end
		end
	end

	self.curIndex = self.curIndex + self.clearTaskNum

	return
end

function NewMeixiV4Scene:updateNodes()
	self:setCurIndex()
	setText(self.titleTxt, "POSITION " .. string.format("%02d", self.curIndex))
	setText(self.titleNum, string.format("%02d", self.curIndex))
	eachChild(self.nodes, function(arg_15_0)
		local var_15_0 = tonumber(arg_15_0.name)

		if not self.taskProxy:getTaskById(self.contextData.taskList[var_15_0]) then
			local var_15_1 = self.taskProxy:getFinishTaskById(self.contextData.taskList[var_15_0])
		end

		setActive(arg_15_0, var_15_0 <= self.curIndex)
		onButton(self, arg_15_0, function()
			self:updateNodeInfo(var_15_0)

			return
		end, SFX_PANEL)

		return
	end)
	self:updateNodeInfo(self.curIndex)

	return
end

function NewMeixiV4Scene:nodeInfoTween(arg_17_1)
	local var_17_0 = tf(self._tf:Find(tostring(arg_17_1), self.nodes)).localPosition

	if arg_17_1 == 9 then
		var_17_0.x = var_17_0.x - 80
	end

	if arg_17_1 == 7 then
		var_17_0.y = var_17_0.y - 20
	end

	local function var_17_1()
		setLocalPosition(self.nodeInfo, Vector3(var_17_0.x, var_17_0.y + 120, 0))
		setLocalScale(self.nodeInfo, Vector3(0, 0, 0))
		LeanTween.scale(tf(self.nodeInfo), Vector3.one, 0.1)

		return
	end

	if not isActive(self.nodeInfo) then
		setActive(self.nodeInfo, true)
		var_17_1()
	else
		(function(arg_19_0)
			setLocalScale(self.nodeInfo, Vector3(1, 1, 1))
			LeanTween.scale(tf(self.nodeInfo), Vector3.zero, 0.1):setOnComplete(System.Action(function()
				if arg_19_0 then
					arg_19_0()
				end

				return
			end))

			return
		end)(var_17_1)
	end

	return
end

function NewMeixiV4Scene:updateNodeInfo(arg_21_1)
	updateActivityTaskStatus((getProxy(ActivityProxy):getActivityById(ActivityConst.NEWMEIXIV4_SKIRMISH_ID)))

	local var_21_0 = self.taskProxy:getTaskById(self.contextData.taskList[arg_21_1]) or self.taskProxy:getFinishTaskById(self.contextData.taskList[arg_21_1])
	local var_21_1 = pg.task_data_template[self.contextData.taskList[arg_21_1]]
	local var_21_2 = var_21_0 and var_21_0:getProgress() or var_21_1.target_num
	local var_21_3 = var_21_0 and var_21_0:getConfig("target_num") or var_21_1.target_num
	local var_21_4 = var_21_0 and var_21_0:getTaskStatus() or 2
	local var_21_5 = var_21_0 and var_21_0:getConfig("desc") or var_21_1.desc

	setSlider(self.nodeInfo:Find("progress"), 0, var_21_3, var_21_2)
	setText(self.nodeInfo:Find("step"), var_21_2 .. "/" .. var_21_3)
	setText(self.nodeInfo:Find("content"), var_21_5)
	setText(self.nodeInfo:Find("title"), string.format("%02d", arg_21_1))

	local var_21_6 = self.nodeInfo:Find("go_btn")
	local var_21_7 = self.nodeInfo:Find("get_btn")
	local var_21_8 = self.nodeInfo:Find("step/finish")

	setActive(var_21_6, var_21_4 == 0)
	setActive(var_21_7, var_21_4 == 1)
	setActive(var_21_8, var_21_4 == 2)
	onButton(self, var_21_6, function()
		self:emit(NewMeixiV4Mediator.ON_TASK_GO, var_21_0)

		return
	end, SFX_PANEL)
	onButton(self, var_21_7, function()
		self:emit(NewMeixiV4Mediator.ON_TASK_SUBMIT, var_21_0)

		return
	end, SFX_PANEL)
	eachChild(self.nodes, function(arg_24_0)
		local var_24_0 = arg_24_0:Find("arrow")

		LeanTween.cancel(var_24_0.gameObject)
		setLocalPosition(var_24_0, Vector3(0, 27, 0))

		if tonumber(arg_24_0.name) == arg_21_1 then
			setActive(var_24_0, true)
			LeanTween.moveY(var_24_0, 40, 0.5):setEase(LeanTweenType.easeInOutSine):setLoopPingPong()
		else
			setActive(var_24_0, false)
		end

		return
	end)
	self:nodeInfoTween(arg_21_1)

	return
end

function NewMeixiV4Scene:onUpdateTask()
	for iter_25_0, iter_25_1 in pairs(self.storyGroup) do
		if self.contextData.taskList[self.curIndex] == iter_25_1[1] then
			self:getStory(iter_25_1[2], iter_25_1[3])
		end
	end

	self:updateNodes()

	return
end

function NewMeixiV4Scene:getStory(arg_26_1, arg_26_2)
	setActive(self.storyTip, true)
	pg.NewStoryMgr.GetInstance():SetPlayedFlag(arg_26_2)
	setText(self.storyTip:Find("bar/Anim/Frame/Mask/Name"), pg.memory_template[arg_26_1].title)
	removeOnButton(self.storyTip)
	removeOnButton(self.storyTip:Find("bar/Button"))
	pg.UIMgr.GetInstance():BlurPanel(self.storyTip)
	self.storyTip:Find("bar"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		onButton(self, self.storyTip, function()
			pg.UIMgr.GetInstance():UnOverlayPanel(self.storyTip)
			setActive(self.storyTip, false)

			return
		end)
		onButton(self, self.storyTip:Find("bar/Button"), function()
			self:emit(NewMeixiV4Mediator.GO_STORY, self.memoryGroup)
			triggerButton(self.storyTip)

			return
		end, SFX_PANEL)

		return
	end)

	return
end

function NewMeixiV4Scene:willExit()
	setActive(self.storyTip, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(self.storyTip)

	return
end

return NewMeixiV4Scene
