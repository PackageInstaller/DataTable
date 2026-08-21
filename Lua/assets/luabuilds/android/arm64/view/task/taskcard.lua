local var_0_0 = class("TaskCard")
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3
local var_0_5 = 4
local var_0_6 = 0.3

function var_0_0.Type2Tag(arg_1_0)
	var_0_0.types = var_0_0.types or {
		[0] = "subtitle_week",
		"subtitle_brach",
		"subtitle_activity",
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		"subtitle_week",
		nil,
		nil,
		"subtitle_activity",
		26,
		"subtitle_activity",
		36,
		"subtitle_activity",
		[nil] = "subtitle_main",
		subtitle_brach = "subtitle_daily"
	}

	return var_0_0.types[arg_1_0]
end

function var_0_0.Ctor(arg_2_0, arg_2_1, arg_2_2)
	pg.DelegateInfo.New(arg_2_0)

	arg_2_0._go = arg_2_1
	arg_2_0._tf = tf(arg_2_0._go)
	arg_2_0.viewComponent = arg_2_2
	arg_2_0.frame = arg_2_0._tf:Find("frame")
	arg_2_0.descTxt = arg_2_0._tf:Find("frame/desc"):GetComponent(typeof(Text))
	arg_2_0.tagTF = arg_2_0._tf:Find("frame/tag"):GetComponent(typeof(Image))
	arg_2_0.rewardPanel = arg_2_0._tf:Find("frame/awards")
	arg_2_0._rewardModel = arg_2_0.rewardPanel:GetChild(0)
	arg_2_0.progressBar = arg_2_0._tf:Find("frame/slider"):GetComponent(typeof(Slider))
	arg_2_0.progressNum = arg_2_0._tf:Find("frame/slider/Text"):GetComponent(typeof(Text))
	arg_2_0.GotoBtn = arg_2_0._tf:Find("frame/go_btn")
	arg_2_0.GetBtn = arg_2_0._tf:Find("frame/get_btn")
	arg_2_0.storyIconFrame = arg_2_0._tf:Find("frame/storyIcon")
	arg_2_0.storyIcon = arg_2_0._tf:Find("frame/storyIcon/icon")
	arg_2_0._modelWidth = arg_2_0.frame.rect.width + 100
	arg_2_0.finishBg = arg_2_0._tf:Find("frame/finish_bg")
	arg_2_0.unfinishBg = arg_2_0._tf:Find("frame/unfinish_bg")
	arg_2_0.tip = arg_2_0._tf:Find("frame/tip")
	arg_2_0.cg = GetOrAddComponent(arg_2_0._tf, "CanvasGroup")
	arg_2_0.height = arg_2_0._tf.rect.height
	arg_2_0.urTag = arg_2_0._tf:Find("frame/urTag")
	arg_2_0.lockBg = arg_2_0._tf:Find("lock_bg")
	arg_2_0.lockTxt = arg_2_0.lockBg:Find("btn/Text"):GetComponent(typeof(Text))
	arg_2_0.sIconOldPosition = Vector2(0, 20)
	arg_2_0.framePos = arg_2_0.frame.localPosition

	return
end

function var_0_0.update(arg_3_0, arg_3_1)
	assert(isa(arg_3_1, Task), "should be an instance of Task")

	arg_3_0.taskVO = arg_3_1

	if arg_3_1.id == 10302 then
		arg_3_0._go.name = arg_3_1.id
	end

	arg_3_0.descTxt.text = arg_3_1:getConfig("desc")
	arg_3_0.tagTF.sprite = GetSpriteFromAtlas("ui/TaskUI_atlas", var_0_0.Type2Tag(arg_3_1:GetRealType()))

	local var_3_0 = arg_3_1:getConfig("target_num")

	arg_3_0:updateAwards(arg_3_1:getConfig("award_display"))

	local var_3_1 = arg_3_1:getProgress()

	arg_3_0.progressNum.text = arg_3_1:isFinish() and "COMPLETE" or arg_3_1:getConfig("sub_type") == 1012 and math.floor(var_3_1 / 100) .. "/" .. math.floor(var_3_0 / 100) or var_3_1 .. "/" .. var_3_0
	arg_3_0.progressBar.value = var_3_1 / var_3_0

	arg_3_0:updateBtnState(arg_3_1)

	local var_3_2 = arg_3_1:getConfig("story_id")
	local var_3_3 = arg_3_1:IsUrTask()

	setActive(arg_3_0.urTag, var_3_3)
	setActive(arg_3_0.storyIconFrame, var_3_2 and var_3_2 ~= "" and not var_3_3)

	if var_3_2 and var_3_2 ~= "" then
		local var_3_4 = arg_3_1:getConfig("story_icon")

		if not var_3_4 or var_3_4 == "" then
			var_3_4 = "task_icon_default"
		end

		LoadSpriteAsync("shipmodels/" .. var_3_4, function(arg_4_0)
			if arg_4_0 then
				setImageSprite(arg_3_0.storyIcon, arg_4_0, true)
				arg_3_0:UpdateStoryIconPosition(arg_3_1)
			end

			return
		end)
		onButton(arg_3_0, arg_3_0.storyIconFrame, function()
			pg.NewStoryMgr.GetInstance():Play(var_3_2, nil, true)

			return
		end, SFX_PANEL)
	else
		removeOnButton(arg_3_0.storyIconFrame)
	end

	arg_3_0.cg.alpha = 1

	setActive(arg_3_0.frame, true)
	setActive(arg_3_0._go, true)

	arg_3_0.frame.transform.localPosition = arg_3_0.framePos

	return
end

function var_0_0.UpdateStoryIconPosition(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getConfig("story_icon_shift")

	if type(var_6_0) == "table" and #var_6_0 >= 2 then
		setAnchoredPosition(arg_6_0.storyIcon, {
			x = arg_6_0.sIconOldPosition.x + var_6_0[1],
			y = arg_6_0.sIconOldPosition.y + var_6_0[2]
		})
	else
		({}).x = arg_6_0.sIconOldPosition.x + 0
		;({}).y = arg_6_0.sIconOldPosition.y + 0

		setAnchoredPosition(arg_6_0.storyIcon, {})
	end

	return
end

function var_0_0.updateBtnState(arg_7_0, arg_7_1)
	local var_7_0 = var_0_1

	removeOnButton(arg_7_0.GotoBtn)
	removeOnButton(arg_7_0.GetBtn)

	if arg_7_1:isLock() then
		var_7_0 = var_0_5
	elseif arg_7_1:isFinish() then
		var_7_0 = arg_7_1:isReceive() and var_0_4 or var_0_3

		onButton(arg_7_0, arg_7_0.GetBtn, function()
			local function var_8_0()
				if not arg_7_0.isClick then
					arg_7_0.isClick = true

					arg_7_0:DoSubmitAnim(function()
						arg_7_0.isClick = nil

						arg_7_0:Submit(arg_7_1)

						return
					end)
				end

				return
			end

			local var_8_1

			coroutine.wrap(function()
				if arg_7_1:getConfig("sub_type") == TASK_SUB_TYPE_GIVE_ITEM or arg_7_1:getConfig("sub_type") == TASK_SUB_TYPE_GIVE_VIRTUAL_ITEM or arg_7_1:getConfig("sub_type") == TASK_SUB_TYPE_PLAYER_RES then
					local var_11_0 = DROP_TYPE_ITEM
					local var_11_1

					if arg_7_1:getConfig("sub_type") == TASK_SUB_TYPE_PLAYER_RES then
						var_11_0 = DROP_TYPE_RESOURCE
						var_11_1 = {
							type = MSGBOX_TYPE_ITEM_BOX,
							content = i18n("sub_item_warning")
						}
					end

					;({})[1] = {
						type = var_11_0,
						id = tonumber(arg_7_1:getConfig("target_id")),
						count = arg_7_1:getConfig("target_num")
					}
					var_11_1.items = {}

					function var_11_1.onYes()
						var_8_1()

						return
					end

					pg.MsgboxMgr.GetInstance():ShowMsgBox(var_11_1)
					coroutine.yield()
				end

				local var_11_2, var_11_3 = arg_7_1:judgeOverflow()

				if var_11_2 then
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						type = MSGBOX_TYPE_ITEM_BOX,
						content = i18n("award_max_warning"),
						items = var_11_3,
						onYes = function()
							var_8_1()

							return
						end
					})
					coroutine.yield()
				end

				var_8_0()

				return
			end)()

			return
		end, SFX_PANEL)
	else
		var_7_0 = var_0_2

		onButton(arg_7_0, arg_7_0.GotoBtn, function()
			arg_7_0:Skip(arg_7_1)

			return
		end, SFX_PANEL)
	end

	SetActive(arg_7_0.GotoBtn, var_7_0 == var_0_2)
	SetActive(arg_7_0.GetBtn, var_7_0 == var_0_3)
	setActive(arg_7_0.finishBg, var_7_0 == var_0_3 or var_7_0 == var_0_4)
	setActive(arg_7_0.unfinishBg, var_7_0 ~= var_0_3 and var_7_0 ~= var_0_4)
	setActive(arg_7_0.tip, var_7_0 == var_0_3 or var_7_0 == var_0_4)
	setActive(arg_7_0.lockBg, var_7_0 == var_0_5)
	setGray(arg_7_0.frame, var_7_0 == var_0_5, true)

	if var_7_0 == var_0_5 then
		arg_7_0.lockTxt.text = i18n("task_lock", arg_7_1:getConfig("level"))
	end

	return
end

function var_0_0.Submit(arg_15_0, arg_15_1)
	if arg_15_1.isWeekTask then
		arg_15_0.viewComponent:onSubmitForWeek(arg_15_1)
	elseif arg_15_1:isAvatarTask() then
		arg_15_0.viewComponent:onSubmitForAvatar(arg_15_1)
	else
		arg_15_0.viewComponent:onSubmit(arg_15_1)
	end

	return
end

function var_0_0.Skip(arg_16_0, arg_16_1)
	arg_16_0.viewComponent:onGo(arg_16_1)

	return
end

function var_0_0.updateAwards(arg_17_0, arg_17_1)
	local var_17_0 = _.slice(arg_17_1, 1, 3)

	for iter_17_0 = arg_17_0.rewardPanel.childCount, #var_17_0 - 1 do
		cloneTplTo(arg_17_0._rewardModel, arg_17_0.rewardPanel)
	end

	for iter_17_1 = 1, arg_17_0.rewardPanel.childCount do
		local var_17_1 = arg_17_0.rewardPanel:GetChild(iter_17_1 - 1)
		local var_17_2 = iter_17_1 <= #var_17_0

		setActive(var_17_1, iter_17_1 <= #var_17_0)

		if var_17_2 then
			updateDrop(var_17_1, {
				type = var_17_0[iter_17_1][1],
				id = var_17_0[iter_17_1][2],
				count = var_17_0[iter_17_1][3]
			})
			setActive(findTF(var_17_1, "got"), Task.OwnSpAward(var_17_0[iter_17_1]))
			onButton(arg_17_0, var_17_1, function()
				arg_17_0.viewComponent:emit(TaskMediator.ON_DROP, var_0)

				return
			end, SFX_PANEL)
		end
	end

	return
end

function var_0_0.DoSubmitAnim(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.frame.localPosition

	LeanTween.alphaCanvas(arg_19_0.cg, 0, var_0_6):setFrom(1)
	LeanTween.value(go(arg_19_0.frame), arg_19_0.frame.localPosition.x, arg_19_0.frame.localPosition.x + arg_19_0._modelWidth, var_0_6):setOnUpdate(System.Action_float(function(arg_20_0)
		arg_19_0.frame.transform.localPosition = Vector3(arg_20_0, var_19_0.y, var_19_0.z)

		return
	end)):setOnComplete(System.Action(function()
		arg_19_0.frame.transform.localPosition = var_19_0

		setActive(arg_19_0.frame, false)
		arg_19_1()

		return
	end))

	return
end

function var_0_0.dispose(arg_22_0)
	pg.DelegateInfo.Dispose(arg_22_0)

	return
end

return var_0_0
