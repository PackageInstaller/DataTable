local EducateTargetLayer = class("EducateTargetLayer", import(".base.EducateBaseUI"))

function EducateTargetLayer:getUIName()
	return "EducateTargetUI"
end

function EducateTargetLayer:init()
	self:initData()
	self:findUI()
	self:addListener()

	return
end

function EducateTargetLayer:initData()
	self.taskProxy = getProxy(EducateProxy):GetTaskProxy()
	self.targetId = self.taskProxy:GetTargetId()
	self.mainTaskVOs = self.taskProxy:FilterByGroup(self.taskProxy:GetMainTasksForShow())
	self.otherTaskVOs = self.taskProxy:FilterByGroup(self.taskProxy:GetTargetTasksForShow())
	self.canGetTargetAward = self.taskProxy:CanGetTargetAward()

	return
end

function EducateTargetLayer:findUI()
	self.anim = self._tf:Find("anim_root"):GetComponent(typeof(Animation))
	self.animEvent = self._tf:Find("anim_root"):GetComponent(typeof(DftAniEvent))

	self.animEvent:SetEndEvent(function()
		self:emit(EducateTargetLayer.ON_CLOSE)

		return
	end)

	self.windowTF = self._tf:Find("anim_root/window")
	self.leftTF = self.windowTF:Find("left/content")
	self.leftEmptyTF = self.windowTF:Find("left/empty")

	setText(self.leftEmptyTF:Find("target_info/Text"), i18n("child_target_set_empty"))

	self.targetSetBtn = self.leftEmptyTF:Find("target_info/target_set_btn")

	setText(self.targetSetBtn:Find("skip_title"), i18n("child_target_set_skip"))

	self.targetInfoTF = self.leftTF:Find("target_info")
	self.iconTF = self.targetInfoTF:Find("icon")
	self.nameTF = self.targetInfoTF:Find("name_bg/name")
	self.unfinishTF = self.targetInfoTF:Find("unfinish")
	self.sliderTF = self.unfinishTF:Find("progress")
	self.progressWhiteTF = self.sliderTF:Find("white")

	setActive(self.progressWhiteTF, true)
	setText(self.unfinishTF:Find("progress/title"), i18n("child_target_progress"))

	self.progressTextTF = self.unfinishTF:Find("progress/title/Text")
	self.targetAwardTF = self.unfinishTF:Find("award")
	self.finishTF = self.targetInfoTF:Find("finish")

	setText(self.finishTF:Find("Text"), i18n("child_target_finish_tip"))
	setText(self.leftTF:Find("time/title"), i18n("child_target_time_title"))

	self.timeTF = self.leftTF:Find("time/Text")
	self.taskContentTF = self.windowTF:Find("task_scrollview/content")
	self.mainTaskTF = self.taskContentTF:Find("main_list")

	setText(self.mainTaskTF:Find("list/tpl/status/get/btn/Text"), i18n("word_take"))

	self.mainTaskUIList = UIItemList.New(self.mainTaskTF:Find("list"), self.mainTaskTF:Find("list/tpl"))
	self.mainTitleTF = self.mainTaskTF:Find("title/Text")

	setText(self.mainTitleTF, i18n("child_target_title1"))

	self.mainProgressTF = self.mainTaskTF:Find("title/progress")

	setActive(self.mainProgressTF, false)

	self.otherTaskTF = self.taskContentTF:Find("other_list")

	setText(self.otherTaskTF:Find("list/tpl/status/get/btn/Text"), i18n("word_take"))

	self.otherTaskUIList = UIItemList.New(self.otherTaskTF:Find("list"), self.otherTaskTF:Find("list/tpl"))
	self.otherTitleTF = self.otherTaskTF:Find("title/Text")

	setText(self.otherTitleTF, i18n("child_target_title2"))

	return
end

function EducateTargetLayer:addListener()
	onButton(self, self._tf:Find("anim_root/close"), function()
		self:_close()

		return
	end, SFX_PANEL)
	onButton(self, self.targetSetBtn, function()
		function self.onExit()
			getProxy(EducateProxy):MainAddLayer(Context.New({
				viewComponent = EducateTargetSetLayer,
				mediator = EducateTargetSetMediator
			}))

			return
		end

		self:_close()

		return
	end, SFX_PANEL)

	return
end

function EducateTargetLayer:didEnter()
	self:OverlayPanel(self._tf, {
		groupDelta = 1
	})
	self:initLeft()
	self.mainTaskUIList:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			self:updateItem(arg_11_1, arg_11_2, "main")
		end

		return
	end)
	self.otherTaskUIList:make(function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == UIItemList.EventUpdate then
			self:updateItem(arg_12_1, arg_12_2, "other")
		end

		return
	end)
	self:updateItems()
	EducateGuideSequence.CheckGuide(self.__cname, function()
		return
	end)

	return
end

function EducateTargetLayer:sumbitTask(arg_14_1)
	self:emit(EducateTargetMediator.ON_TASK_SUBMIT, arg_14_1)

	return
end

function EducateTargetLayer:initLeft()
	setActive(self.leftTF, self.targetId ~= 0)
	setActive(self.leftEmptyTF, self.targetId == 0)

	if self.targetId ~= 0 then
		LoadImageSpriteAsync("educatetarget/" .. pg.child_target_set[self.targetId].icon, self.iconTF, true)
		setText(self.nameTF, pg.child_target_set[self.targetId].name)

		local var_15_0 = {
			type = pg.child_target_set[self.targetId].drop_display[1],
			id = pg.child_target_set[self.targetId].drop_display[2],
			number = pg.child_target_set[self.targetId].drop_display[3]
		}

		EducateHelper.UpdateDropShow(self.targetAwardTF, var_15_0)
		onButton(self, self.targetAwardTF, function()
			if self.canGetFinishAward then
				self:emit(EducateTargetMediator.ON_GET_TARGET_AWARD)
			else
				self:emit(EducateTargetLayer.EDUCATE_ON_ITEM, {
					drop = var_15_0
				})
			end

			return
		end, SFX_PANEL)

		local var_15_1 = getProxy(EducateProxy):GetCharData():GetStageReaminWeek(pg.child_target_set[self.targetId].stage)

		setText(self.timeTF, var_15_1 <= 1 and i18n("word_in_one_week") or var_15_1 .. i18n("word_week"))
	end

	self:updataTarget()

	return
end

function EducateTargetLayer:updataTarget()
	local var_17_0, var_17_1 = getProxy(EducateProxy):GetTaskProxy():GetOtherTargetTaskProgress()
	local var_17_2 = var_17_0 / var_17_1

	if var_17_0 / var_17_1 > 1 then
		var_17_2 = 1
	end

	if var_17_1 == 0 then
		var_17_2 = 1
	end

	setText(self.progressTextTF, var_17_0 .. "/" .. var_17_1)

	if not self.lastProgress or var_17_2 <= self.lastProgress then
		setSlider(self.sliderTF, 0, 1, var_17_2)

		self.lastProgress = var_17_2
	else
		self:playProgressAnim(var_17_2)

		self.lastProgress = var_17_2
	end

	local var_17_3 = var_17_2 >= 1

	self.canGetFinishAward = var_17_2 >= 1 and self.canGetTargetAward

	setActive(self.unfinishTF, not var_17_3 or self.canGetFinishAward)
	setActive(self.targetAwardTF:Find("receiveVX"), self.canGetFinishAward)
	setActive(self.unfinishTF:Find("tip"), self.canGetFinishAward)
	setActive(self.finishTF, var_17_3 and not self.canGetTargetAward)

	return
end

function EducateTargetLayer:playProgressAnim(arg_18_1)
	self:cleanManagedTween()

	local var_18_0 = self.sliderTF:GetComponent(typeof(Slider)).value

	self.progressWhiteTF.sizeDelta = Vector2(self.sliderTF.rect.width * arg_18_1, self.sliderTF.rect.height)

	self.sliderTF:GetComponent(typeof(Animation)):Play("anim_educate_target_progress_add")
	self:managedTween(LeanTween.delayedCall, function()
		self:managedTween(LeanTween.value, nil, go(self.sliderTF), var_18_0, arg_18_1, 0.264):setOnUpdate(System.Action_float(function(arg_20_0)
			setSlider(self.sliderTF, 0, 1, arg_20_0)

			return
		end)):setEase(LeanTweenType.easeInCubic)

		return
	end, 0.132, nil)

	return
end

function EducateTargetLayer:updateItems()
	setActive(self.mainTaskTF, #self.mainTaskVOs > 0)
	self.mainTaskUIList:align(#self.mainTaskVOs)
	setActive(self.otherTaskTF, #self.otherTaskVOs > 0)
	self.otherTaskUIList:align(#self.otherTaskVOs)

	return
end

function EducateTargetLayer:updateItem(arg_22_1, arg_22_2, arg_22_3)
	local var_22_0

	if arg_22_3 == "main" then
		var_22_0 = self.mainTaskVOs[arg_22_1 + 1] or self.otherTaskVOs[arg_22_1 + 1]
	end

	setText(arg_22_2:Find("desc"), var_22_0:getConfig("name"))
	setText(arg_22_2:Find("status/go/btn/Text"), var_22_0:GetProgress() .. "/" .. var_22_0:GetFinishNum())

	local var_22_1 = var_22_0:GetTaskStatus()

	setActive(arg_22_2:Find("status/go"), var_22_1 == EducateTask.STATUS_UNFINISH)
	setActive(arg_22_2:Find("status/get"), var_22_1 == EducateTask.STATUS_FINISH)
	setActive(arg_22_2:Find("status/got"), var_22_1 == EducateTask.STATUS_RECEIVE)

	local var_22_2 = var_22_0:GetAwardShow()

	EducateHelper.UpdateDropShow(arg_22_2:Find("award"), var_22_2)
	onButton(self, arg_22_2:Find("award"), function()
		self:emit(EducateTargetLayer.EDUCATE_ON_ITEM, {
			drop = var_22_2
		})

		return
	end)
	onButton(self, arg_22_2:Find("status/get"), function()
		if self.isClick then
			return
		end

		self.isClick = true

		arg_22_2:GetComponent(typeof(Animation)):Play(var_22_0:IsMain() and "anim_educate_target_tpl_maingot" or "anim_educate_target_tpl_othergot")
		onDelayTick(function()
			self.isClick = nil

			self:sumbitTask(var_22_0)
			var_22_0:SetRecieve()

			return
		end, 0.5)

		return
	end, SFX_PANEL)

	return
end

function EducateTargetLayer:updateView()
	self:initData()
	self:updateItems()
	self:updataTarget()

	return
end

function EducateTargetLayer:_close()
	if self.isClick then
		return
	end

	self.anim:Play("anim_educate_target_out")

	return
end

function EducateTargetLayer:onBackPressed()
	self:_close()

	return
end

function EducateTargetLayer:willExit()
	self.animEvent:SetEndEvent(nil)
	self:UnOverlayPanel(self._tf)

	if self.onExit then
		self.onExit()
	elseif getProxy(EducateProxy):GetCurTime().month == 2 then
		getProxy(EducateProxy):CheckGuide("EducateScene")
	end

	return
end

return EducateTargetLayer
