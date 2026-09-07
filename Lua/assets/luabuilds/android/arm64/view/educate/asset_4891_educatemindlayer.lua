local EducateMindLayer = class("EducateMindLayer", import(".base.EducateBaseUI"))

function EducateMindLayer:getUIName()
	return "EducateMindUI"
end

function EducateMindLayer:init()
	self:initData()
	self:findUI()
	self:addListener()

	return
end

function EducateMindLayer:initData()
	self.taskProxy = getProxy(EducateProxy):GetTaskProxy()
	self.taskVOs = self.taskProxy:GetTasksBySystem(EducateTask.SYSTEM_TYPE_MIND)

	return
end

function EducateMindLayer:findUI()
	self.anim = self._tf:Find("anim_root"):GetComponent(typeof(Animation))
	self.animEvent = self._tf:Find("anim_root"):GetComponent(typeof(DftAniEvent))

	self.animEvent:SetEndEvent(function()
		self:emit(EducateMindLayer.ON_CLOSE)

		return
	end)

	self.windowTF = self._tf:Find("anim_root/window")
	self.scrollview = self.windowTF:Find("scrollview")
	self.emptyTF = self.scrollview:Find("empty")

	setText(self.emptyTF:Find("Text"), i18n("child_mind_empty_tip"))

	self.contentTF = self.scrollview:Find("view/content")
	self.finishListTF = self.contentTF:Find("finish_list")
	self.finishUIList = UIItemList.New(self.finishListTF:Find("list"), self.finishListTF:Find("list/tpl"))

	setText(self.finishListTF:Find("title/Text"), i18n("child_mind_finish_title"))
	setText(self.finishListTF:Find("list/tpl/get_btn/Text"), i18n("word_take"))

	self.unFinishListTF = self.contentTF:Find("unfinish_list")
	self.unFinishUIList = UIItemList.New(self.unFinishListTF:Find("list"), self.unFinishListTF:Find("list/tpl"))

	setText(self.unFinishListTF:Find("title/Text"), i18n("child_mind_processing_title"))
	setText(self.unFinishListTF:Find("list/tpl/time_desc"), i18n("child_mind_time_title"))

	return
end

function EducateMindLayer:addListener()
	onButton(self, self._tf:Find("anim_root/bg"), function()
		self:_close()

		return
	end, SFX_PANEL)

	return
end

function EducateMindLayer:didEnter()
	self:OverlayPanel(self._tf, {
		groupDelta = 1
	})
	self.finishUIList:make(function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventUpdate then
			GetOrAddComponent(arg_9_2, "CanvasGroup").alpha = 1

			self:updateFinishItem(arg_9_1, arg_9_2)
		end

		return
	end)
	self.unFinishUIList:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			self:updateUnfinishItem(arg_10_1, arg_10_2)
		end

		return
	end)
	self:updateItems()
	EducateTipHelper.ClearNewTip(EducateTipHelper.NEW_MIND_TASK)

	return
end

function EducateMindLayer:sumbitTask(arg_11_1)
	self:emit(EducateMindMediator.ON_TASK_SUBMIT, arg_11_1)

	return
end

function EducateMindLayer:updateItems()
	local var_12_0 = getProxy(EducateProxy):GetCurTime()

	self.taskVOs = underscore.select(self.taskVOs, function(arg_13_0)
		return arg_13_0:InTime(var_12_0)
	end)
	self.finishTaskVOs = {}
	self.unFinishTaskVOs = {}

	underscore.each(self.taskVOs, function(arg_14_0)
		if arg_14_0:IsFinish() then
			table.insert(self.finishTaskVOs, arg_14_0)
		else
			table.insert(self.unFinishTaskVOs, arg_14_0)
		end

		return
	end)

	local var_12_1 = CompareFuncs({
		function(arg_15_0)
			return arg_15_0:GetRemainTime(var_12_0)
		end,
		function(arg_16_0)
			return arg_16_0.id
		end
	})

	table.sort(self.finishTaskVOs, var_12_1)
	table.sort(self.unFinishTaskVOs, var_12_1)
	setActive(self.finishListTF, #self.finishTaskVOs > 0)
	self.finishUIList:align(#self.finishTaskVOs)
	setActive(self.unFinishListTF, #self.unFinishTaskVOs > 0)
	self.unFinishUIList:align(#self.unFinishTaskVOs)
	setActive(self.emptyTF, #self.finishTaskVOs <= 0 and #self.unFinishTaskVOs <= 0)

	return
end

function EducateMindLayer:updateFinishItem(arg_17_1, arg_17_2)
	if LeanTween.isTweening(arg_17_2.gameObject) then
		LeanTween.cancel(arg_17_2.gameObject)
	end

	GetOrAddComponent(arg_17_2, "CanvasGroup").alpha = 1

	setActive(arg_17_2, true)

	local var_17_0 = self.finishTaskVOs[arg_17_1 + 1]

	setText(arg_17_2:Find("desc"), self.finishTaskVOs[arg_17_1 + 1]:getConfig("name"))
	onButton(self, arg_17_2:Find("get_btn"), function()
		if not self.isClick then
			self.isClick = true

			self:doAnim(arg_17_2, function()
				return
			end)
			onDelayTick(function()
				self.isClick = nil

				self:sumbitTask(var_17_0)

				return
			end, 0.165)
		end

		return
	end, SFX_PANEL)

	return
end

function EducateMindLayer:updateUnfinishItem(arg_21_1, arg_21_2)
	setText(arg_21_2:Find("desc"), self.unFinishTaskVOs[arg_21_1 + 1]:getConfig("name"))

	local var_21_0 = self.unFinishTaskVOs[arg_21_1 + 1]:GetRemainTime()

	setText(arg_21_2:Find("time_desc/time"), (var_21_0 < 7 and 0 or math.floor(var_21_0 / 7)) .. i18n("word_week"))

	return
end

function EducateMindLayer:doAnim(arg_22_1, arg_22_2)
	local var_22_0 = arg_22_1.transform.localPosition

	LeanTween.alphaCanvas(GetOrAddComponent(arg_22_1, "CanvasGroup"), 0, 0.198):setFrom(1)
	LeanTween.value(go(arg_22_1), arg_22_1.transform.localPosition.x, arg_22_1.transform.localPosition.x + 200, 0.264):setOnUpdate(System.Action_float(function(arg_23_0)
		arg_22_1.transform.localPosition = Vector3(arg_23_0, var_22_0.y, var_22_0.z)

		return
	end)):setEase(LeanTweenType.easeInCubic):setOnComplete(System.Action(function()
		arg_22_1.transform.localPosition = var_22_0

		setActive(arg_22_1, false)
		arg_22_2()

		return
	end))

	return
end

function EducateMindLayer:updateView()
	self:initData()
	self:updateItems()

	return
end

function EducateMindLayer:_close()
	if self.isClick then
		return
	end

	self.anim:Play("anim_educate_mind_out")

	return
end

function EducateMindLayer:onBackPressed()
	self:_close()

	return
end

function EducateMindLayer:willExit()
	self.animEvent:SetEndEvent(nil)
	self:UnOverlayPanel(self._tf)

	if self.contextData.onExit then
		self.contextData.onExit()
	end

	return
end

return EducateMindLayer
