local var_0_0 = class("LinerLogRoomPage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "LinerLogRoomPage"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.leftTF = arg_2_0._tf:Find("left")
	arg_2_0.rightTF = arg_2_0._tf:Find("right")
	arg_2_0.togglesTF = arg_2_0._tf:Find("toggles")
	arg_2_0.anim = arg_2_0._tf:Find("view"):GetComponent(typeof(Animation))

	local var_2_0 = arg_2_0._tf:Find("view/content")

	arg_2_0.itemTFs = {
		var_2_0:Find("1"),
		var_2_0:Find("2"),
		var_2_0:Find("3"),
		(var_2_0:Find("4"))
	}

	for iter_2_0, iter_2_1 in pairs(arg_2_0.itemTFs) do
		iter_2_1:Find("empty"):GetComponent(typeof(Image)):SetNativeSize()
	end

	arg_2_0.awardTF = arg_2_0._tf:Find("award/mask/IconTpl")
	arg_2_0.awardDesc = arg_2_0._tf:Find("award/Text")

	setText(arg_2_0.awardDesc, i18n("liner_room_award_tip"))

	arg_2_0.goBtn = arg_2_0._tf:Find("award/go")
	arg_2_0.getBtn = arg_2_0._tf:Find("award/get")
	arg_2_0.gotTF = arg_2_0._tf:Find("award/got")

	return
end

function var_0_0.OnInit(arg_3_0)
	arg_3_0:UpdateActivity()
	onButton(arg_3_0, arg_3_0.getBtn, function()
		arg_3_0:emit(LinerLogBookMediator.GET_ROOM_AWARD, arg_3_0.activity.id, arg_3_0.curIdx, arg_3_0.groups[arg_3_0.curIdx]:GetDrop())

		return
	end, SFX_CONFIRM)
	onButton(arg_3_0, arg_3_0.goBtn, function()
		arg_3_0:emit(LinerLogBookMediator.ON_CLOSE)

		return
	end, SFX_CONFIRM)

	arg_3_0.groupIds = arg_3_0.activity:getConfig("config_data")[2]
	arg_3_0.groups = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.groupIds) do
		arg_3_0.groups[iter_3_0] = LinerRoomGroup.New(iter_3_1)
	end

	arg_3_0.toggleUIList = UIItemList.New(arg_3_0.togglesTF, arg_3_0.togglesTF:Find("tpl"))

	arg_3_0.toggleUIList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventInit then
			local var_6_0 = arg_6_1 + 1

			arg_6_2.name = arg_6_1 + 1

			local var_6_1 = "PAGE " .. string.format("%02d", arg_6_1 + 1)

			setText(arg_6_2:Find("Text"), var_6_1)
			setText(arg_6_2:Find("selected/Text"), var_6_1)
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

	arg_8_0.finishRoomIds = arg_8_0.activity:GetExploredRoomIds()

	return
end

function var_0_0.FlushPage(arg_9_0)
	arg_9_0.anim:Play()
	arg_9_0.toggleUIList:align(#arg_9_0.groupIds)

	local var_9_0 = false
	local var_9_1 = arg_9_0.groups[arg_9_0.curIdx]:GetIds()

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		local var_9_2 = arg_9_0.itemTFs[iter_9_0]

		if arg_9_0.itemTFs[iter_9_0] then
			setActive(var_9_2, true)

			local var_9_3 = var_9_2:Find("desc")
			local var_9_4 = arg_9_0.groups[arg_9_0.curIdx]:GetRoom(iter_9_1)

			setText(var_9_2:Find("name/Text"), var_9_4:GetName())
			setImageSprite(var_9_2:Find("icon"), GetSpriteFromAtlas("ui/linermainui_atlas", "area" .. iter_9_1, true))

			local var_9_5 = table.contains(arg_9_0.finishRoomIds, iter_9_1)
			local var_9_6

			if not var_9_5 then
				var_9_0 = true
				var_9_6 = var_9_5 and var_9_4:GetDesc() or ""
			end

			setText(var_9_3, var_9_6)
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

	local var_9_7 = arg_9_0.activity:IsGotRoomAward(arg_9_0.curIdx)
	local var_9_8 = not var_9_7 and not var_9_0

	setActive(arg_9_0.goBtn, not var_9_7 and not var_9_8)
	setActive(arg_9_0.gotTF, var_9_7)
	setActive(arg_9_0.awardTF:Find("mask"), var_9_7)
	setActive(arg_9_0.getBtn, var_9_8)
	arg_9_0:Show()

	return
end

function var_0_0.OnDestroy(arg_11_0)
	return
end

function var_0_0.IsTipWithGroupId(arg_12_0, arg_12_1)
	if arg_12_0:IsGotRoomAward((table.indexof(arg_12_0:GetRoomGroupIds(), arg_12_1))) then
		return false
	end

	local var_12_0 = arg_12_0:GetExploredRoomIds()

	return underscore.all(pg.activity_liner_room_group[arg_12_1].ids, function(arg_13_0)
		return table.contains(var_12_0, arg_13_0)
	end)
end

function var_0_0.IsTip()
	local var_14_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_LINER)

	assert(var_14_0 and not var_14_0:isEnd(), "not exist liner act, type: " .. ActivityConst.ACTIVITY_TYPE_LINER)

	return underscore.any(var_14_0:GetRoomGroupIds(), function(arg_15_0)
		return var_0_0.IsTipWithGroupId(var_14_0, arg_15_0)
	end)
end

return var_0_0
