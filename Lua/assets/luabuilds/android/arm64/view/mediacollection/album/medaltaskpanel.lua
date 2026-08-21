local var_0_0 = class("MedalTaskPanel")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0._parent = arg_1_2

	pg.DelegateInfo.New(arg_1_0)

	arg_1_0._mask = findTF(arg_1_0._tf, "mask")
	arg_1_0._backBtn = findTF(arg_1_0._tf, "btnBack")
	arg_1_0.UIlist = UIItemList.New(findTF(arg_1_0._tf, "panel/list"), findTF(arg_1_0._tf, "panel/list/Tasktpl"))

	onButton(arg_1_0, arg_1_0._mask, function()
		if arg_1_0._parent.TASK_CLOSE_ANIM and arg_1_0._parent.TASK_CLOSE_ANIM_Time then
			quickPlayAnimation(arg_1_0._go, arg_1_0._parent.TASK_CLOSE_ANIM)
			onDelayTick(function()
				arg_1_0:SetActive(false)

				return
			end, arg_1_0._parent.TASK_CLOSE_ANIM_Time)
		else
			arg_1_0:SetActive(false)
		end

		return
	end, SFX_CANCEL)
	onButton(arg_1_0, arg_1_0._backBtn, function()
		if arg_1_0._parent.TASK_CLOSE_ANIM and arg_1_0._parent.TASK_CLOSE_ANIM_Time then
			quickPlayAnimation(arg_1_0._go, arg_1_0._parent.TASK_CLOSE_ANIM)
			onDelayTick(function()
				arg_1_0:SetActive(false)

				return
			end, arg_1_0._parent.TASK_CLOSE_ANIM_Time)
		else
			arg_1_0:SetActive(false)
		end

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.SetMedalGroup(arg_6_0, arg_6_1)
	arg_6_0._medalGroup = arg_6_1
	arg_6_0._taskList = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._medalGroup:GetMedalGroupActivityConfig()[3]) do
		local var_6_0 = getProxy(TaskProxy):getTaskById(iter_6_1)

		var_6_0 = var_6_0 or getProxy(TaskProxy):getFinishTaskById(iter_6_1)

		table.insert(arg_6_0._taskList, var_6_0)
	end

	return
end

function var_0_0.ShowMedalTask(arg_7_0)
	Canvas.ForceUpdateCanvases()
	arg_7_0:sort(arg_7_0._taskList)
	arg_7_0:UpdateList(arg_7_0._taskList)

	return
end

function var_0_0.getTaskProgress(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getProgress()
	local var_8_1 = tostring(arg_8_1:getProgress())
end

function var_0_0.getTaskTarget(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:getConfig("target_num")
	local var_9_1 = tostring(arg_9_1:getConfig("target_num"))
end

function var_0_0.UpdateList(arg_10_0, arg_10_1)
	arg_10_0.UIlist:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			local var_11_0 = arg_10_1[arg_11_1 + 1]
			local var_11_1 = arg_11_2:Find("frame/awards")
			local var_11_2 = arg_11_2:Find("frame/get_btn")
			local var_11_3 = arg_11_2:Find("frame/got_btn")
			local var_11_4 = arg_11_2:Find("frame/go_btn")

			setText(arg_11_2:Find("frame/desc"), arg_10_1[arg_11_1 + 1]:getConfig("desc"))

			local var_11_5, var_11_6 = arg_10_0:getTaskProgress(var_11_0)
			local var_11_7, var_11_8 = arg_10_0:getTaskTarget(var_11_0)

			arg_11_2:Find("frame/slider"):GetComponent(typeof(Slider)).value = var_11_5 / var_11_7

			setText(arg_11_2:Find("frame/progress"), var_11_6)
			setText(arg_11_2:Find("frame/progress_1"), "/" .. var_11_8)
			arg_10_0:updateAwards(var_11_0:getConfig("award_display"), var_11_1, (var_11_1:GetChild(0)))
			setActive(var_11_3, var_11_0:getTaskStatus() == 2)
			setActive(var_11_2, var_11_0:getTaskStatus() == 1)
			setActive(var_11_4, var_11_0:getTaskStatus() == 0)
			onButton(arg_10_0, var_11_4, function()
				arg_10_0._parent:emit(MedalAlbumTemplateMediator.ON_TASK_GO, var_11_0)

				return
			end, SFX_PANEL)
			onButton(arg_10_0, var_11_2, function()
				arg_10_0._parent:emit(MedalAlbumTemplateMediator.ON_TASK_SUBMIT, var_11_0)

				return
			end, SFX_PANEL)
		end

		return
	end)
	arg_10_0.UIlist:align(#arg_10_1)

	if arg_10_0._parent.TASK_ANIM and arg_10_0._parent.TASK_ENTER_ANIM_Time and arg_10_0._parent.TASK_Time then
		local var_10_0 = findTF(arg_10_0._tf, "panel/list").transform.childCount

		onDelayTick(function()
			for iter_14_0 = 0, var_10_0 - 1 do
				local var_14_0 = findTF(arg_10_0._tf, "panel/list"):GetChild(iter_14_0)

				onDelayTick(function()
					if arg_10_0._parent.exited then
						return
					end

					quickPlayAnimation(var_14_0, arg_10_0._parent.TASK_ANIM)

					return
				end, arg_10_0._parent.TASK_Time * (iter_14_0 + 1))
			end

			return
		end, arg_10_0._parent.TASK_ENTER_ANIM_Time)
	end

	return
end

function var_0_0.updateAwards(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = _.slice(arg_16_1, 1, 3)

	for iter_16_0 = arg_16_2.childCount, #var_16_0 - 1 do
		cloneTplTo(arg_16_3, arg_16_2)
	end

	for iter_16_1 = 1, arg_16_2.childCount do
		local var_16_1 = arg_16_2:GetChild(iter_16_1 - 1)
		local var_16_2 = iter_16_1 <= #var_16_0

		setActive(var_16_1, iter_16_1 <= #var_16_0)

		if var_16_2 then
			local var_16_4 = {
				type = var_16_0[iter_16_1][1],
				id = var_16_0[iter_16_1][2],
				count = var_16_0[iter_16_1][3]
			}

			updateDrop(findTF(var_16_1, "mask"), {
				type = var_16_0[iter_16_1][1],
				id = var_16_0[iter_16_1][2],
				count = var_16_0[iter_16_1][3]
			})

			if ({
				type = var_16_0[iter_16_1][1],
				id = var_16_0[iter_16_1][2],
				count = var_16_0[iter_16_1][3]
			}).type == DROP_TYPE_EQUIPMENT_SKIN then
				setActive(findTF(var_16_1, "specialFrame"), true)
			else
				setActive(findTF(var_16_1, "specialFrame"), false)
			end

			onButton(arg_16_0, var_16_1, function()
				arg_16_0._parent:emit(BaseUI.ON_DROP, var_16_4)

				return
			end, SFX_PANEL)
			setActive(findTF(var_16_1, "got"), Task.OwnSpAward(var_16_3))
		end
	end

	return
end

function var_0_0.sort(arg_18_0, arg_18_1)
	for iter_18_0, iter_18_1 in pairs(arg_18_1) do
		if iter_18_1:getTaskStatus() == 1 then
			table.insert({}, iter_18_1)
		end
	end

	for iter_18_2, iter_18_3 in pairs(arg_18_1) do
		if iter_18_3:getTaskStatus() == 0 then
			table.insert({}, iter_18_3)
		end
	end

	for iter_18_4, iter_18_5 in pairs(arg_18_1) do
		if iter_18_5:getTaskStatus() == 2 then
			table.insert({}, iter_18_5)
		end
	end

	arg_18_0._taskList = {}

	return
end

function var_0_0.SetActive(arg_19_0, arg_19_1)
	SetActive(arg_19_0._go, arg_19_1)

	arg_19_0._active = arg_19_1

	if arg_19_1 then
		pg.UIMgr.GetInstance():BlurPanel(arg_19_0._go)
	else
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_19_0._go, arg_19_0._parent._tf)

		if arg_19_0._parent.TASK_ANIM and arg_19_0._parent.TASK_ENTER_ANIM_Time and arg_19_0._parent.TASK_Time then
			for iter_19_0 = 0, findTF(arg_19_0._tf, "panel/list").transform.childCount - 1 do
				local var_19_0 = findTF(arg_19_0._tf, "panel/list")

				setCanvasGroupAlpha(var_19_0:GetChild(iter_19_0), 0)
			end
		end
	end

	return
end

function var_0_0.IsActive(arg_20_0)
	return arg_20_0._active
end

function var_0_0.Dispose(arg_21_0)
	pg.DelegateInfo.Dispose(arg_21_0)

	return
end

return var_0_0
