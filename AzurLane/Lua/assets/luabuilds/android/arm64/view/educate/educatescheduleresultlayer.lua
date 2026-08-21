local var_0_0 = class("EducateScheduleResultLayer", import(".base.EducateBaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "EducateScheduleResultUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.anim = arg_2_0._tf:Find("anim_root"):GetComponent(typeof(Animation))
	arg_2_0.animEvent = arg_2_0._tf:Find("anim_root"):GetComponent(typeof(DftAniEvent))
	arg_2_0.inAnimPlaying = true

	arg_2_0.animEvent:SetEndEvent(function()
		arg_2_0.inAnimPlaying = false

		arg_2_0.animEvent:SetEndEvent(function()
			arg_2_0:emit(var_0_0.ON_CLOSE)

			return
		end)

		return
	end)

	arg_2_0.windowTF = arg_2_0._tf:Find("anim_root/window")
	arg_2_0.personalTF = arg_2_0.windowTF:Find("personal")
	arg_2_0.majorArrTF = arg_2_0.windowTF:Find("major")
	arg_2_0.minorArrTF = arg_2_0.windowTF:Find("minor")
	arg_2_0.resTF = arg_2_0.windowTF:Find("res/content")

	setText(arg_2_0.windowTF:Find("tip"), i18n("child_close_tip"))
	arg_2_0:BlurPanel(arg_2_0._tf, {
		groupDelta = 1
	})

	return
end

function var_0_0.didEnter(arg_5_0)
	onButton(arg_5_0, arg_5_0._tf, function()
		arg_5_0:_close()

		return
	end, SFX_CANCEL)

	local var_5_0 = arg_5_0.contextData.plan_results or {}

	arg_5_0.result = {}
	arg_5_0.resResult = {}
	arg_5_0.resultEvent = {}
	arg_5_0.resResultEvent = {}
	arg_5_0.drops = {}

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		(function(arg_7_0, arg_7_1)
			for iter_7_0, iter_7_1 in ipairs(arg_7_0) do
				table.insert(arg_5_0.drops, iter_7_1)

				if iter_7_1.type == EducateConst.DROP_TYPE_ATTR then
					if arg_7_1 then
						arg_5_0.resultEvent[iter_7_1.id] = arg_5_0.resultEvent[iter_7_1.id] or 0
						arg_5_0.resultEvent[iter_7_1.id] = arg_5_0.resultEvent[iter_7_1.id] + iter_7_1.number
					else
						arg_5_0.result[iter_7_1.id] = arg_5_0.result[iter_7_1.id] or 0
						arg_5_0.result[iter_7_1.id] = arg_5_0.result[iter_7_1.id] + iter_7_1.number
					end
				end

				if iter_7_1.type == EducateConst.DROP_TYPE_RES then
					if arg_7_1 then
						arg_5_0.resResultEvent[iter_7_1.id] = arg_5_0.resResultEvent[iter_7_1.id] or 0
						arg_5_0.resResultEvent[iter_7_1.id] = arg_5_0.resResultEvent[iter_7_1.id] + iter_7_1.number
					else
						arg_5_0.resResult[iter_7_1.id] = arg_5_0.resResult[iter_7_1.id] or 0
						arg_5_0.resResult[iter_7_1.id] = arg_5_0.resResult[iter_7_1.id] + iter_7_1.number
					end
				end
			end

			return
		end)(iter_5_1.plan_drops)
		;(function(arg_7_0, arg_7_1)
			for iter_7_0, iter_7_1 in ipairs(arg_7_0) do
				table.insert(arg_5_0.drops, iter_7_1)

				if iter_7_1.type == EducateConst.DROP_TYPE_ATTR then
					if arg_7_1 then
						arg_5_0.resultEvent[iter_7_1.id] = arg_5_0.resultEvent[iter_7_1.id] or 0
						arg_5_0.resultEvent[iter_7_1.id] = arg_5_0.resultEvent[iter_7_1.id] + iter_7_1.number
					else
						arg_5_0.result[iter_7_1.id] = arg_5_0.result[iter_7_1.id] or 0
						arg_5_0.result[iter_7_1.id] = arg_5_0.result[iter_7_1.id] + iter_7_1.number
					end
				end

				if iter_7_1.type == EducateConst.DROP_TYPE_RES then
					if arg_7_1 then
						arg_5_0.resResultEvent[iter_7_1.id] = arg_5_0.resResultEvent[iter_7_1.id] or 0
						arg_5_0.resResultEvent[iter_7_1.id] = arg_5_0.resResultEvent[iter_7_1.id] + iter_7_1.number
					else
						arg_5_0.resResult[iter_7_1.id] = arg_5_0.resResult[iter_7_1.id] or 0
						arg_5_0.resResult[iter_7_1.id] = arg_5_0.resResult[iter_7_1.id] + iter_7_1.number
					end
				end
			end

			return
		end)(iter_5_1.event_drops, true)
		;(function(arg_7_0, arg_7_1)
			for iter_7_0, iter_7_1 in ipairs(arg_7_0) do
				table.insert(arg_5_0.drops, iter_7_1)

				if iter_7_1.type == EducateConst.DROP_TYPE_ATTR then
					if arg_7_1 then
						arg_5_0.resultEvent[iter_7_1.id] = arg_5_0.resultEvent[iter_7_1.id] or 0
						arg_5_0.resultEvent[iter_7_1.id] = arg_5_0.resultEvent[iter_7_1.id] + iter_7_1.number
					else
						arg_5_0.result[iter_7_1.id] = arg_5_0.result[iter_7_1.id] or 0
						arg_5_0.result[iter_7_1.id] = arg_5_0.result[iter_7_1.id] + iter_7_1.number
					end
				end

				if iter_7_1.type == EducateConst.DROP_TYPE_RES then
					if arg_7_1 then
						arg_5_0.resResultEvent[iter_7_1.id] = arg_5_0.resResultEvent[iter_7_1.id] or 0
						arg_5_0.resResultEvent[iter_7_1.id] = arg_5_0.resResultEvent[iter_7_1.id] + iter_7_1.number
					else
						arg_5_0.resResult[iter_7_1.id] = arg_5_0.resResult[iter_7_1.id] or 0
						arg_5_0.resResult[iter_7_1.id] = arg_5_0.resResult[iter_7_1.id] + iter_7_1.number
					end
				end
			end

			return
		end)(iter_5_1.spec_event_drops)
	end

	arg_5_0.char = getProxy(EducateProxy):GetCharData()
	arg_5_0.natureIds = arg_5_0.char:GetAttrIdsByType(EducateChar.ATTR_TYPE_PERSONALITY)
	arg_5_0.majorIds = arg_5_0.char:GetAttrIdsByType(EducateChar.ATTR_TYPE_MAJOR)
	arg_5_0.minorIds = arg_5_0.char:GetAttrIdsByType(EducateChar.ATTR_TYPE_MINOR)
	arg_5_0.resIds = {
		EducateChar.RES_MOOD_ID,
		EducateChar.RES_MONEY_ID
	}

	arg_5_0:updatePersonalPanel()
	arg_5_0:updateMajorPanel()
	arg_5_0:updateMinorPanel()
	arg_5_0:updateResPanel()

	return
end

function var_0_0.updatePersonalPanel(arg_8_0)
	local var_8_0 = EducateHelper.IsShowNature()

	setActive(arg_8_0.personalTF, var_8_0)

	if var_8_0 then
		for iter_8_0, iter_8_1 in ipairs(arg_8_0.natureIds) do
			local var_8_1 = arg_8_0.personalTF:Find(tostring(iter_8_1))

			setText(var_8_1:Find("old"), pg.child_attr[iter_8_1].name .. " " .. arg_8_0.char:GetAttrById(iter_8_1))

			local var_8_2 = arg_8_0.result[iter_8_1] or 0

			setActive(var_8_1:Find("new"), var_8_2 ~= 0)

			if var_8_2 ~= 0 then
				setText(var_8_1:Find("new"), (var_8_2 > 0 and "+" or "") .. " " .. var_8_2)
				setTextColor(var_8_1:Find("new"), Color.NewHex(var_8_3))
			end
		end
	end

	return
end

function var_0_0.updateMajorPanel(arg_9_0)
	for iter_9_0 = 1, arg_9_0.majorArrTF.childCount do
		local var_9_0 = arg_9_0.majorArrTF:GetChild(iter_9_0 - 1)

		GetImageSpriteFromAtlasAsync("ui/educatecommonui_atlas", "attr_" .. arg_9_0.majorIds[iter_9_0], var_9_0:Find("icon_bg/icon"), true)
		setScrollText(var_9_0:Find("name_mask/name"), pg.child_attr[arg_9_0.majorIds[iter_9_0]].name)

		local var_9_1 = arg_9_0.char:GetAttrInfo(arg_9_0.majorIds[iter_9_0])

		setText(var_9_0:Find("grade/Text"), var_9_1)

		local var_9_2 = arg_9_0.char:GetAttrById(arg_9_0.majorIds[iter_9_0])

		setText(var_9_0:Find("value_old"), var_9_2)
		setImageColor(var_9_0:Find("gradient"), Color.NewHex(EducateConst.GRADE_2_COLOR[var_9_1][1]))
		setImageColor(var_9_0:Find("grade"), Color.NewHex(EducateConst.GRADE_2_COLOR[var_9_1][2]))

		local var_9_3 = arg_9_0.result[arg_9_0.majorIds[iter_9_0]] or 0

		setActive(var_9_0:Find("VX"), var_9_3 ~= 0)
		setImageColor(var_9_0:Find("arrow"), Color.NewHex(var_9_4))
		setText(var_9_0:Find("value_new"), var_9_2 + var_9_3)
		setTextColor(var_9_0:Find("value_new"), Color.NewHex(var_9_4))
	end

	return
end

function var_0_0.updateMinorPanel(arg_10_0)
	for iter_10_0 = 1, arg_10_0.minorArrTF.childCount do
		local var_10_0 = arg_10_0.minorArrTF:GetChild(iter_10_0 - 1)

		GetImageSpriteFromAtlasAsync("ui/educatecommonui_atlas", "attr_" .. arg_10_0.minorIds[iter_10_0], var_10_0:Find("icon"), true)
		setText(var_10_0:Find("name"), pg.child_attr[arg_10_0.minorIds[iter_10_0]].name)
		setText(var_10_0:Find("value/value/old"), (arg_10_0.char:GetAttrById(arg_10_0.minorIds[iter_10_0])))

		local var_10_1 = arg_10_0.result[arg_10_0.minorIds[iter_10_0]] or 0

		setText(var_10_0:Find("value/value/add"), "")

		local var_10_2 = arg_10_0.resultEvent[arg_10_0.minorIds[iter_10_0]] or 0

		setText(var_10_0:Find("value/event_add"), "")

		local var_10_3 = var_10_1 ~= 0 or var_10_2 ~= 0

		setActive(var_10_0:Find("VX"), var_10_1 ~= 0 or var_10_2 ~= 0)

		if var_10_3 then
			onDelayTick(function()
				if var_10_1 > 0 then
					setText(var_10_0:Find("value/value/add"), "+" .. var_10_1)
				end

				if var_10_2 > 0 then
					setText(var_10_0:Find("value/event_add"), "+" .. var_10_2)
				end

				return
			end, 0.891)
		end
	end

	return
end

function var_0_0.updateResPanel(arg_12_0)
	for iter_12_0 = 1, #arg_12_0.resIds do
		local var_12_0 = arg_12_0.resTF:GetChild(iter_12_0 - 1)
		local var_12_1 = arg_12_0.resIds[iter_12_0]

		GetImageSpriteFromAtlasAsync("ui/educatecommonui_atlas", "res_" .. arg_12_0.resIds[iter_12_0], var_12_0:Find("icon"), true)
		setText(var_12_0:Find("name"), pg.child_resource[var_12_1].name)

		local var_12_2 = arg_12_0.char:GetResById(var_12_1)

		if var_12_2 < 0 then
			var_12_2 = 0
		end

		setText(var_12_0:Find("value/value/old"), var_12_2)

		local var_12_3 = arg_12_0.resResult[var_12_1]
		local var_12_4, var_12_5

		if not arg_12_0.resResult[var_12_1] then
			var_12_3 = 0
			var_12_4 = setText
			var_12_5 = var_12_0:Find("value/value/add")
		end

		var_12_4(var_12_5, var_12_3 == 0 and "" or "+" .. var_12_3)

		local var_12_6 = arg_12_0.resResultEvent[var_12_1]
		local var_12_7, var_12_8

		if not arg_12_0.resResultEvent[var_12_1] then
			var_12_6 = 0
			var_12_7 = setText
			var_12_8 = var_12_0:Find("value/event_add")
		end

		var_12_7(var_12_8, var_12_6 == 0 and "" or "+" .. var_12_6)
	end

	return
end

function var_0_0._close(arg_13_0)
	if arg_13_0.inAnimPlaying then
		return
	end

	arg_13_0.anim:Play("anim_educate_result_out")

	return
end

function var_0_0.onBackPressed(arg_14_0)
	arg_14_0:_close()

	return
end

function var_0_0.willExit(arg_15_0)
	getProxy(EducateProxy):OnNextWeek()
	arg_15_0.animEvent:SetEndEvent(nil)

	if arg_15_0.drops then
		EducateHelper.UpdateDropsData(arg_15_0.drops)
	end

	arg_15_0:UnOverlayPanel(arg_15_0._tf)

	if arg_15_0.contextData.onExit then
		arg_15_0.contextData.onExit()
	end

	return
end

return var_0_0
