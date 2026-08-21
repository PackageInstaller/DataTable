local var_0_0 = class("LinerLogEventPage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "LinerLogEventPage"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.leftTF = arg_2_0._tf:Find("left")
	arg_2_0.rightTF = arg_2_0._tf:Find("right")
	arg_2_0.togglesTF = arg_2_0._tf:Find("toggles")
	arg_2_0.anim = arg_2_0._tf:Find("content"):GetComponent(typeof(Animation))

	local var_2_0 = arg_2_0._tf:Find("content/view/content")

	arg_2_0.itemTFs = {
		var_2_0:Find("1"),
		var_2_0:Find("2"),
		(var_2_0:Find("3"))
	}

	for iter_2_0, iter_2_1 in pairs(arg_2_0.itemTFs) do
		iter_2_1:Find("empty"):GetComponent(typeof(Image)):SetNativeSize()
	end

	arg_2_0.eventIconTF = arg_2_0._tf:Find("content/title/Image")
	arg_2_0.awardTF = arg_2_0._tf:Find("award/mask/IconTpl")
	arg_2_0.awardDesc = arg_2_0._tf:Find("award/Text")
	arg_2_0.goBtn = arg_2_0._tf:Find("award/go")
	arg_2_0.getBtn = arg_2_0._tf:Find("award/get")
	arg_2_0.gotTF = arg_2_0._tf:Find("award/got")

	setText(arg_2_0._tf:Find("award/got/title"), i18n("liner_event_award_tip3"))

	arg_2_0.conclusionDesc = arg_2_0._tf:Find("award/got/Text")

	return
end

function var_0_0.OnInit(arg_3_0)
	arg_3_0:UpdateActivity()
	onButton(arg_3_0, arg_3_0.getBtn, function()
		arg_3_0:emit(LinerLogBookMediator.ON_START_REASONING, arg_3_0.activity.id, arg_3_0.curIdx)

		return
	end, SFX_CONFIRM)
	onButton(arg_3_0, arg_3_0.goBtn, function()
		arg_3_0:emit(LinerLogBookMediator.ON_CLOSE)

		return
	end, SFX_CONFIRM)

	arg_3_0.groupIds = arg_3_0.activity:GetEventGroupIds()
	arg_3_0.groups = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.groupIds) do
		arg_3_0.groups[iter_3_0] = LinerEventGroup.New(iter_3_1)
	end

	arg_3_0.toggleUIList = UIItemList.New(arg_3_0.togglesTF, arg_3_0.togglesTF:Find("tpl"))

	arg_3_0.toggleUIList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventInit then
			local var_6_0 = arg_6_1 + 1

			arg_6_2.name = arg_6_1 + 1

			local var_6_1 = i18n("liner_log_event_group_title" .. arg_6_1 + 1)

			setText(arg_6_2:Find("Text"), var_6_1)
			setText(arg_6_2:Find("selected/Text"), var_6_1)

			if arg_6_1 + 1 > 1 then
				local var_6_2 = arg_3_0:IsFinishWithGroupIdx(arg_6_1 + 1 - 1)

				SetCompomentEnabled(arg_6_2, typeof(Toggle), var_6_2)
				setActive(arg_6_2:Find("lock"), not var_6_2)

				if not var_6_2 then
					setActive(arg_6_2:Find("selected"), false)
				end
			end

			onToggle(arg_3_0, arg_6_2, function(arg_7_0)
				if arg_7_0 then
					if arg_3_0.curIdx and arg_3_0.curIdx == var_6_0 then
						return
					end

					arg_3_0.curIdx = var_6_0

					arg_3_0:FlushPage()
				end

				return
			end, SFX_CONFIRM)
		elseif arg_6_0 == UIItemList.EventUpdate then
			setActive(arg_6_2:Find("tip"), var_0_0.IsTipWithGroupId(arg_3_0.activity, arg_3_0.groups[arg_6_1 + 1].id))
		end

		return
	end)
	arg_3_0.toggleUIList:align(#arg_3_0.groupIds)
	triggerToggle(arg_3_0.toggleUIList.container:Find("1"), true)

	return
end

function var_0_0.UpdateActivity(arg_8_0, arg_8_1)
	arg_8_0.activity = arg_8_1 or getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_LINER)

	local var_8_0 = arg_8_0.activity and not arg_8_0.activity:isEnd()

	assert(var_8_0, "not exist liner act, type: " .. ActivityConst.ACTIVITY_TYPE_LINER)

	arg_8_0.finishEventIds = arg_8_0.activity:GetFinishEventIds()

	return
end

function var_0_0.FlushPage(arg_9_0)
	arg_9_0.anim:Play()
	arg_9_0.toggleUIList:align(#arg_9_0.groupIds)
	setImageSprite(arg_9_0.eventIconTF, GetSpriteFromAtlas("ui/linermainui_atlas", "event_title" .. arg_9_0.groups[arg_9_0.curIdx].id), true)

	local var_9_0 = false
	local var_9_1 = arg_9_0.groups[arg_9_0.curIdx]:GetIds()

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		setActive(arg_9_0.itemTFs[iter_9_0], true)

		local var_9_3 = var_9_2:Find("desc")
		local var_9_4 = arg_9_0.groups[arg_9_0.curIdx]:GetEvent(iter_9_1)
		local var_9_5 = table.contains(arg_9_0.finishEventIds, iter_9_1)
		local var_9_6 = var_9_5 and var_9_4:GetTitle() or i18n("liner_event_title" .. iter_9_0)

		setText(var_9_2:Find("name/Text"), var_9_6)

		if not var_9_5 then
			var_9_0 = true
		end

		if var_9_5 then
			local var_9_7 = "clue" .. iter_9_1 or "empty" .. iter_9_0

			setImageSprite(var_9_2:Find("icon"), GetSpriteFromAtlas("ui/linermainui_atlas", var_9_7), true)

			local var_9_8 = var_9_5 and var_9_4:GetLogDesc() or ""

			setText(var_9_3, var_9_8)
			setActive(var_9_2:Find("empty"), not var_9_5)
		end
	end

	for iter_9_2 = #var_9_1 + 1, #arg_9_0.itemTFs do
		setActive(arg_9_0.itemTFs[iter_9_2], false)
	end

	updateDrop(arg_9_0.awardTF, (arg_9_0.groups[arg_9_0.curIdx]:GetDrop()))
	onButton(arg_9_0, arg_9_0.awardTF, function()
		arg_9_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)

	local var_9_9 = arg_9_0.activity:IsGotEventAward(arg_9_0.curIdx)
	local var_9_10 = not var_9_9 and not var_9_0

	setActive(arg_9_0.goBtn, not var_9_9 and not var_9_10)
	setActive(arg_9_0.getBtn, var_9_10)
	setActive(arg_9_0.gotTF, var_9_9)
	setActive(arg_9_0.awardTF:Find("mask"), var_9_9)

	local var_9_11 = var_9_10 and i18n("liner_event_award_tip2") or i18n("liner_event_award_tip1")

	setText(arg_9_0.awardDesc, var_9_11)
	setActive(arg_9_0.awardDesc, not var_9_9)

	if var_9_9 then
		setText(arg_9_0.conclusionDesc, arg_9_0.groups[arg_9_0.curIdx]:GetConclusions()[arg_9_0.activity:GetEventAwardFlag(arg_9_0.curIdx)])
	end

	arg_9_0:Show()

	return
end

function var_0_0.OnDestroy(arg_11_0)
	return
end

function var_0_0.IsFinishWithGroupIdx(arg_12_0, arg_12_1)
	return underscore.all(arg_12_0.groups[arg_12_1]:GetIds(), function(arg_13_0)
		return table.contains(arg_12_0.finishEventIds, arg_13_0)
	end)
end

function var_0_0.IsTipWithGroupId(arg_14_0, arg_14_1)
	if arg_14_0:IsGotEventAward((table.indexof(arg_14_0:GetEventGroupIds(), arg_14_1))) then
		return false
	end

	local var_14_0 = arg_14_0:GetFinishEventIds()

	return underscore.all(pg.activity_liner_event_group[arg_14_1].ids, function(arg_15_0)
		return table.contains(var_14_0, arg_15_0)
	end)
end

function var_0_0.IsTip()
	local var_16_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_LINER)

	assert(var_16_0 and not var_16_0:isEnd(), "not exist liner act, type: " .. ActivityConst.ACTIVITY_TYPE_LINER)

	return underscore.any(var_16_0:GetEventGroupIds(), function(arg_17_0)
		return var_0_0.IsTipWithGroupId(var_16_0, arg_17_0)
	end)
end

function var_0_0.IsUnlcok()
	local var_18_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_LINER)

	assert(var_18_0 and not var_18_0:isEnd(), "not exist liner act, type: " .. ActivityConst.ACTIVITY_TYPE_LINER)

	return var_18_0:GetCurIdx() > 7
end

return var_0_0
