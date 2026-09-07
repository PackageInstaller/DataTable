local TianqiongMedalTaskPanel = class("TianqiongMedalTaskPanel")

function TianqiongMedalTaskPanel:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self._parent = arg_1_2

	pg.DelegateInfo.New(self)

	self._mask = findTF(self._tf, "mask")
	self._backBtn = findTF(self._tf, "btnBack")
	self.UIlist = UIItemList.New(findTF(self._tf, "panel/list"), findTF(self._tf, "panel/list/Tasktpl"))

	onButton(self, self._mask, function()
		if self._parent.TASK_CLOSE_ANIM and self._parent.TASK_CLOSE_ANIM_Time then
			quickPlayAnimation(self._go, self._parent.TASK_CLOSE_ANIM)
			onDelayTick(function()
				self:SetActive(false)

				return
			end, self._parent.TASK_CLOSE_ANIM_Time)
		else
			self:SetActive(false)
		end

		return
	end, SFX_CANCEL)
	onButton(self, self._backBtn, function()
		if self._parent.TASK_CLOSE_ANIM and self._parent.TASK_CLOSE_ANIM_Time then
			quickPlayAnimation(self._go, self._parent.TASK_CLOSE_ANIM)
			onDelayTick(function()
				self:SetActive(false)

				return
			end, self._parent.TASK_CLOSE_ANIM_Time)
		else
			self:SetActive(false)
		end

		return
	end, SFX_CANCEL)

	return
end

function TianqiongMedalTaskPanel:SetMedalGroup(arg_6_1)
	self._medalGroup = arg_6_1
	self._taskList = {}

	for iter_6_0, iter_6_1 in ipairs(self._medalGroup:GetMedalGroupActivityConfig()[3]) do
		local var_6_0 = getProxy(TaskProxy):getTaskById(iter_6_1)

		var_6_0 = var_6_0 or getProxy(TaskProxy):getFinishTaskById(iter_6_1)

		table.insert(self._taskList, var_6_0)
	end

	return
end

function TianqiongMedalTaskPanel:ShowMedalTask()
	Canvas.ForceUpdateCanvases()
	self:sort(self._taskList)
	self:UpdateList(self._taskList)

	return
end

function TianqiongMedalTaskPanel:getTaskProgress(arg_8_1)
	local var_8_0 = arg_8_1:getProgress()
	local var_8_1 = tostring(arg_8_1:getProgress())
end

function TianqiongMedalTaskPanel:getTaskTarget(arg_9_1)
	local var_9_0 = arg_9_1:getConfig("target_num")
	local var_9_1 = tostring(arg_9_1:getConfig("target_num"))
end

function TianqiongMedalTaskPanel:UpdateList(arg_10_1)
	self.UIlist:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			local var_11_0 = arg_10_1[arg_11_1 + 1]
			local var_11_1 = arg_11_2:Find("frame/progressContent")
			local var_11_2 = arg_11_2:Find("frame/progressContent/progress")
			local var_11_3 = arg_11_2:Find("frame/awards")
			local var_11_4 = arg_11_2:Find("frame/get_btn")
			local var_11_5 = arg_11_2:Find("frame/got_btn")
			local var_11_6 = arg_11_2:Find("frame/go_btn")

			setText(arg_11_2:Find("frame/desc"), arg_10_1[arg_11_1 + 1]:getConfig("desc"))

			local var_11_7, var_11_8 = self:getTaskProgress(var_11_0)
			local var_11_9, var_11_10 = self:getTaskTarget(var_11_0)

			arg_11_2:Find("frame/slider"):GetComponent(typeof(Slider)).value = var_11_7 / var_11_9

			setText(arg_11_2:Find("frame/progressContent/progress_1"), var_11_8 .. "/" .. var_11_10)
			self:updateAwards(var_11_0:getConfig("award_display"), var_11_3, (var_11_3:GetChild(0)))
			setActive(var_11_5, var_11_0:getTaskStatus() == 2)
			setActive(var_11_4, var_11_0:getTaskStatus() == 1)
			setActive(var_11_6, var_11_0:getTaskStatus() == 0)
			onButton(self, var_11_6, function()
				self._parent:emit(MedalAlbumTemplateMediator.ON_TASK_GO, var_11_0)

				return
			end, SFX_PANEL)
			onButton(self, var_11_4, function()
				self._parent:emit(MedalAlbumTemplateMediator.ON_TASK_SUBMIT, var_11_0)

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.UIlist:align(#arg_10_1)

	if self._parent.TASK_ANIM and self._parent.TASK_ENTER_ANIM_Time and self._parent.TASK_Time then
		local var_10_0 = findTF(self._tf, "panel/list").transform.childCount

		onDelayTick(function()
			for iter_14_0 = 0, var_10_0 - 1 do
				local var_14_0 = findTF(self._tf, "panel/list"):GetChild(iter_14_0)

				onDelayTick(function()
					if self._parent.exited then
						return
					end

					quickPlayAnimation(var_14_0, self._parent.TASK_ANIM)

					return
				end, self._parent.TASK_Time * (iter_14_0 + 1))
			end

			return
		end, self._parent.TASK_ENTER_ANIM_Time)
	end

	return
end

function TianqiongMedalTaskPanel:updateAwards(arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = _.slice(arg_16_1, 1, 3)

	for iter_16_0 = arg_16_2.childCount, #var_16_0 - 1 do
		cloneTplTo(arg_16_3, arg_16_2)
	end

	for iter_16_1 = 1, arg_16_2.childCount do
		local var_16_1 = arg_16_2:GetChild(iter_16_1 - 1)
		local var_16_2 = iter_16_1 <= #var_16_0

		setActive(var_16_1, iter_16_1 <= #var_16_0)

		if var_16_2 then
			local var_16_3 = {
				type = var_16_0[iter_16_1][1],
				id = var_16_0[iter_16_1][2],
				count = var_16_0[iter_16_1][3]
			}

			updateDrop(findTF(var_16_1, "mask"), var_16_3)

			if var_16_3.type == DROP_TYPE_EQUIPMENT_SKIN then
				setActive(findTF(var_16_1, "specialFrame"), true)
			else
				setActive(findTF(var_16_1, "specialFrame"), false)
			end

			onButton(self, var_16_1, function()
				self._parent:emit(BaseUI.ON_DROP, var_16_3)

				return
			end, SFX_PANEL)
		end
	end

	return
end

function TianqiongMedalTaskPanel:sort(arg_18_1)
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in pairs(arg_18_1) do
		if iter_18_1:getTaskStatus() == 1 then
			table.insert(var_18_0, iter_18_1)
		end
	end

	for iter_18_2, iter_18_3 in pairs(arg_18_1) do
		if iter_18_3:getTaskStatus() == 0 then
			table.insert(var_18_0, iter_18_3)
		end
	end

	for iter_18_4, iter_18_5 in pairs(arg_18_1) do
		if iter_18_5:getTaskStatus() == 2 then
			table.insert(var_18_0, iter_18_5)
		end
	end

	self._taskList = var_18_0

	return
end

function TianqiongMedalTaskPanel:SetActive(arg_19_1)
	SetActive(self._go, arg_19_1)

	self._active = arg_19_1

	if arg_19_1 then
		pg.UIMgr.GetInstance():BlurPanel(self._go)
	else
		pg.UIMgr.GetInstance():UnOverlayPanel(self._go, self._parent._tf)

		if self._parent.TASK_ANIM and self._parent.TASK_ENTER_ANIM_Time and self._parent.TASK_Time then
			for iter_19_0 = 0, findTF(self._tf, "panel/list").transform.childCount - 1 do
				setCanvasGroupAlpha(findTF(self._tf, "panel/list"):GetChild(iter_19_0), 0)
			end
		end
	end

	return
end

function TianqiongMedalTaskPanel:IsActive()
	return self._active
end

function TianqiongMedalTaskPanel:Dispose()
	pg.DelegateInfo.Dispose(self)

	return
end

return TianqiongMedalTaskPanel
