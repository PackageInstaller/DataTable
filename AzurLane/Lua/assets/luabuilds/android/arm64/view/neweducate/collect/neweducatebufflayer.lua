local var_0_0 = class("NewEducateBuffLayer", import("view.base.BaseUI"))
local var_0_1 = {
	[NewEducateBuff.TYPE.TAROT] = i18n("child2_collect_tarot_progress"),
	[NewEducateBuff.TYPE.ENTRY] = i18n("child2_collect_entry_progress"),
	[NewEducateBuff.TYPE.TALENT] = i18n("child2_collect_talent_progress")
}
local var_0_2 = {
	[NewEducateBuff.TYPE.TAROT] = i18n("child2_collect_tarot"),
	[NewEducateBuff.TYPE.ENTRY] = i18n("child2_collect_entry"),
	[NewEducateBuff.TYPE.TALENT] = i18n("child2_collect_talent")
}

function var_0_0.getUIName(arg_1_0)
	return "NewEducateBuffUI"
end

function var_0_0.getGroupName(arg_2_0)
	return "NewEducateBaseUI"
end

function var_0_0.init(arg_3_0)
	arg_3_0.windowTF = arg_3_0._tf:Find("window")
	arg_3_0.nextBtn = arg_3_0.windowTF:Find("next_btn")
	arg_3_0.lastBtn = arg_3_0.windowTF:Find("last_btn")
	arg_3_0.togglesTF = arg_3_0.windowTF:Find("toggles")

	local var_3_0 = arg_3_0.windowTF:Find("pages")

	arg_3_0.pageTFs = {}
	arg_3_0.pageTFs[NewEducateBuff.TYPE.TAROT] = var_3_0:Find(tostring(NewEducateBuff.TYPE.TAROT))
	arg_3_0.pageTFs[NewEducateBuff.TYPE.ENTRY] = var_3_0:Find(tostring(NewEducateBuff.TYPE.ENTRY))
	arg_3_0.pageTFs[NewEducateBuff.TYPE.TALENT] = var_3_0:Find(tostring(NewEducateBuff.TYPE.TALENT))
	arg_3_0.boxsTF = arg_3_0._tf:Find("detail_boxs")
	arg_3_0.animCom = arg_3_0._tf:Find("window"):GetComponent(typeof(Animation))

	return
end

function var_0_0.didEnter(arg_4_0)
	arg_4_0:OverlayPanel(arg_4_0._tf, {
		groupDelta = 2
	})
	onButton(arg_4_0, arg_4_0._tf:Find("bg"), function()
		arg_4_0:closeView()

		return
	end, SFX_PANEL)
	eachChild(arg_4_0.togglesTF, function(arg_6_0)
		setText(arg_6_0:Find("name"), var_0_2[tonumber(arg_6_0.name)])
		onButton(arg_4_0, arg_6_0, function()
			arg_4_0.animCom:Play("anim_NewEducateBuffUI_left_click")
			arg_4_0:SwtichView((tonumber(arg_6_0.name)))

			return
		end, SFX_PANEL)

		return
	end)
	onButton(arg_4_0, arg_4_0.nextBtn, function()
		arg_4_0.curPageIdx = arg_4_0.curPageIdx + 1

		arg_4_0.animCom:Play("anim_NewEducateBuffUI_left_click")
		arg_4_0:UpdatePage()

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.lastBtn, function()
		arg_4_0.curPageIdx = arg_4_0.curPageIdx - 1

		arg_4_0.animCom:Play("anim_NewEducateBuffUI_left_click")
		arg_4_0:UpdatePage()

		return
	end, SFX_PANEL)
	eachChild(arg_4_0.boxsTF, function(arg_10_0)
		onButton(arg_4_0, arg_10_0, function()
			setActive(arg_10_0, false)

			return
		end, SFX_PANEL)

		return
	end)
	arg_4_0:InitData()
	arg_4_0:UpdateToggles()
	arg_4_0:SwtichView(tonumber(arg_4_0.togglesTF:GetChild(0).name))

	return
end

function var_0_0.InitData(arg_12_0)
	arg_12_0.config = pg.child2_benefit_list
	arg_12_0.allIdMap = {
		[NewEducateBuff.TYPE.TAROT] = arg_12_0.contextData.permanentData:GetAllTarotIds(),
		[NewEducateBuff.TYPE.ENTRY] = arg_12_0.contextData.permanentData:GetAllEntryIds(),
		[NewEducateBuff.TYPE.TALENT] = arg_12_0.contextData.permanentData:GetAllTalentIds()
	}
	arg_12_0.unlockIdMap = {
		[NewEducateBuff.TYPE.TAROT] = arg_12_0.contextData.permanentData:GetActivatedTarotIds(),
		[NewEducateBuff.TYPE.ENTRY] = arg_12_0.contextData.permanentData:GetActivatedEntryIds(),
		[NewEducateBuff.TYPE.TALENT] = arg_12_0.contextData.permanentData:GetActivatedTalentIds()
	}
	arg_12_0.pageAllCntMap = {}

	for iter_12_0, iter_12_1 in pairs(arg_12_0.allIdMap) do
		arg_12_0.pageAllCntMap[iter_12_0] = math.ceil(#iter_12_1 / arg_12_0.pageTFs[iter_12_0]:Find("content").childCount)
	end

	return
end

function var_0_0.UpdateToggles(arg_13_0)
	eachChild(arg_13_0.togglesTF, function(arg_14_0)
		local var_14_0 = tonumber(arg_14_0.name)

		setText(arg_14_0:Find("value"), #arg_13_0.unlockIdMap[var_14_0] .. "/" .. #arg_13_0.allIdMap[var_14_0])

		return
	end)

	for iter_13_0, iter_13_1 in pairs(arg_13_0.pageTFs) do
		setText(iter_13_1:Find("progress/Text"), var_0_1[iter_13_0])
		setText(iter_13_1:Find("progress/cur"), #arg_13_0.unlockIdMap[iter_13_0])
		setText(iter_13_1:Find("progress/all"), "/" .. #arg_13_0.allIdMap[iter_13_0])
	end

	return
end

function var_0_0.SwtichView(arg_15_0, arg_15_1)
	if not arg_15_0.curType or arg_15_0.curType ~= arg_15_1 then
		arg_15_0.curType = arg_15_1

		arg_15_0:UpdateView()
	end

	eachChild(arg_15_0.togglesTF, function(arg_16_0)
		setActive(arg_16_0:Find("sel"), tonumber(arg_16_0.name) == arg_15_1)

		return
	end)
	eachChild(arg_15_0.windowTF:Find("pages"), function(arg_17_0)
		setActive(arg_17_0, tonumber(arg_17_0.name) == arg_15_1)

		return
	end)

	return
end

function var_0_0.UpdateView(arg_18_0)
	if arg_18_0.reverse then
		arg_18_0.reverse = nil
		arg_18_0.curPageIdx = arg_18_0.pageAllCntMap[arg_18_0.curType]
	else
		arg_18_0.curPageIdx = 1
	end

	arg_18_0:UpdatePage()

	return
end

function var_0_0.GetNextType(arg_19_0)
	return switch(arg_19_0.curType, {
		[NewEducateBuff.TYPE.TAROT] = function()
			return NewEducateBuff.TYPE.ENTRY
		end,
		[NewEducateBuff.TYPE.ENTRY] = function()
			return NewEducateBuff.TYPE.TALENT
		end,
		[NewEducateBuff.TYPE.TALENT] = function()
			return nil
		end
	})
end

function var_0_0.GetLastType(arg_23_0)
	return switch(arg_23_0.curType, {
		[NewEducateBuff.TYPE.TAROT] = function()
			return nil
		end,
		[NewEducateBuff.TYPE.ENTRY] = function()
			return NewEducateBuff.TYPE.TAROT
		end,
		[NewEducateBuff.TYPE.TALENT] = function()
			return NewEducateBuff.TYPE.ENTRY
		end
	})
end

function var_0_0.UpdatePage(arg_27_0)
	local var_27_1 = arg_27_0.pageAllCntMap[arg_27_0.curType]
	local var_27_4

	if arg_27_0.pageAllCntMap[arg_27_0.curType] < arg_27_0.curPageIdx then
		local var_27_2 = arg_27_0:GetNextType()

		if var_27_2 then
			arg_27_0:SwtichView(var_27_2)

			return
		end
	elseif arg_27_0.curPageIdx < 1 then
		local var_27_3 = arg_27_0:GetLastType()

		if var_27_3 then
			arg_27_0.reverse = true

			arg_27_0:SwtichView(var_27_3)

			do return end

			var_27_4 = setActive
		end
	end

	var_27_4(arg_27_0.nextBtn, not (arg_27_0.curType == NewEducateBuff.TYPE.TALENT and var_27_1 <= arg_27_0.curPageIdx))
	setActive(arg_27_0.lastBtn, not (arg_27_0.curType == NewEducateBuff.TYPE.TAROT and arg_27_0.curPageIdx <= 1))
	setText(var_27_0:Find("pagination"), arg_27_0.curPageIdx .. "/" .. var_27_1)

	local var_27_5 = var_27_0:Find("content")

	for iter_27_0 = 1, var_27_5.childCount do
		local var_27_6 = var_27_5:Find(tostring(iter_27_0))

		if arg_27_0.allIdMap[arg_27_0.curType][(arg_27_0.curPageIdx - 1) * var_27_5.childCount + iter_27_0] then
			setActive(var_27_6, true)
			arg_27_0:UpdateItem(arg_27_0.allIdMap[arg_27_0.curType][(arg_27_0.curPageIdx - 1) * var_27_5.childCount + iter_27_0], var_27_6)
		else
			setActive(var_27_6, false)
		end
	end

	return
end

function var_0_0.UpdateItem(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = table.contains(arg_28_0.unlockIdMap[arg_28_0.curType], arg_28_1)

	setActive(arg_28_2:Find("lock"), not var_28_0)
	setActive(arg_28_2:Find("unlock"), var_28_0)
	switch(arg_28_0.curType, {
		[NewEducateBuff.TYPE.TAROT] = function()
			NewEducateTarotCard.StaticShow(arg_28_2:Find("unlock"), arg_28_1)
			setText(arg_28_2:Find("lock/Text"), arg_28_0.config[arg_28_1].get)
			setText(arg_28_2:Find("lock/name/Text"), arg_28_0.config[arg_28_1].name)
			onButton(arg_28_0, arg_28_2, function()
				if not var_28_0 then
					return
				end

				arg_28_0:ShowDetailBox(arg_28_1)

				return
			end, SFX_PANEL)

			return
		end,
		[NewEducateBuff.TYPE.ENTRY] = function()
			NewEducateEntryCard.StaticShow(arg_28_2:Find("unlock"), arg_28_1)
			setText(arg_28_2:Find("lock/Text"), arg_28_0.config[arg_28_1].get)
			setText(arg_28_2:Find("lock/name"), arg_28_0.config[arg_28_1].name)
			onButton(arg_28_0, arg_28_2, function()
				if not var_28_0 then
					return
				end

				arg_28_0:ShowDetailBox(arg_28_1)

				return
			end, SFX_PANEL)

			return
		end,
		[NewEducateBuff.TYPE.TALENT] = function()
			LoadImageSpriteAsync("neweducateicon/" .. arg_28_0.config[arg_28_1].item_icon, arg_28_2:Find("unlock/icon"))
			setText(arg_28_2:Find("lock/Text"), arg_28_0.config[arg_28_1].get)
			setText(arg_28_2:Find("name"), arg_28_0.config[arg_28_1].name)
			LoadImageSpriteAtlasAsync("ui/neweducatebuffui_atlas", "rarity_" .. arg_28_0.config[arg_28_1].rare, arg_28_2:Find("unlock"))
			onButton(arg_28_0, arg_28_2, function()
				if not var_28_0 then
					return
				end

				arg_28_0:ShowDetailBox(arg_28_1)

				return
			end, SFX_PANEL)

			return
		end
	})

	return
end

function var_0_0.ShowDetailBox(arg_35_0, arg_35_1, arg_35_2)
	eachChild(arg_35_0.boxsTF, function(arg_36_0)
		setActive(arg_36_0, arg_35_0.curType == tonumber(arg_36_0.name))

		return
	end)

	local var_35_0 = arg_35_0.boxsTF:Find(tostring(arg_35_0.curType))

	switch(arg_35_0.curType, {
		[NewEducateBuff.TYPE.TAROT] = function()
			NewEducateTarotCard.StaticShow(var_35_0:Find("bg/tarot"), arg_35_1)

			return
		end,
		[NewEducateBuff.TYPE.ENTRY] = function()
			NewEducateEntryCard.StaticShow(var_35_0:Find("bg/entry/unlock"), arg_35_1)
			setText(var_35_0:Find("bg/entry/lv"), "LV." .. arg_35_0.config[arg_35_1].benefit_level)
			setActive(var_35_0:Find("bg/entry/unlock"), true)
			setActive(var_35_0:Find("bg/entry/lock"), false)
			setActive(var_35_0:Find("bg/toggles"), false)

			return
		end,
		[NewEducateBuff.TYPE.TALENT] = function()
			local var_39_0 = var_35_0:Find("bg/talent")

			LoadImageSpriteAsync("neweducateicon/" .. arg_35_0.config[arg_35_1].item_icon, var_39_0:Find("rarity/icon"))
			setText(var_39_0:Find("name"), arg_35_0.config[arg_35_1].name)
			setText(var_39_0:Find("level"), "LV." .. arg_35_0.config[arg_35_1].benefit_level)
			setText(var_39_0:Find("desc/Text"), arg_35_0.config[arg_35_1].desc)
			LoadImageSpriteAtlasAsync("ui/neweducatebuffui_atlas", "rarity_" .. arg_35_0.config[arg_35_1].rare, var_39_0:Find("rarity"))

			return
		end
	})

	return
end

function var_0_0.ShowEntryBox(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	local var_40_0 = arg_40_0.entryGroup2Ids[arg_40_2]

	table.sort(arg_40_0.entryGroup2Ids[arg_40_2], CompareFuncs({
		function(arg_41_0)
			return arg_40_0.config[arg_41_0].benefit_level
		end,
		function(arg_42_0)
			return arg_42_0
		end
	}))
	UIItemList.StaticAlign(arg_40_1:Find("bg/toggles"), arg_40_1:Find("bg/toggles"):GetChild(0), #arg_40_0.entryGroup2Ids[arg_40_2], function(arg_43_0, arg_43_1, arg_43_2)
		if arg_43_0 == UIItemList.EventUpdate then
			local var_43_0 = var_40_0[arg_43_1 + 1]
			local var_43_1 = arg_40_0.config[var_40_0[arg_43_1 + 1]].benefit_level

			arg_43_2.name = tostring(var_40_0[arg_43_1 + 1])

			setText(arg_43_2:Find("sel/Text"), "LV." .. arg_40_0.config[var_40_0[arg_43_1 + 1]].benefit_level)
			setText(arg_43_2:Find("unsel/Text"), "LV." .. arg_40_0.config[var_40_0[arg_43_1 + 1]].benefit_level)

			local var_43_2 = table.contains(arg_40_0.unlockEntryIds, var_40_0[arg_43_1 + 1])

			setActive(arg_43_2:Find("sel/Image"), not var_43_2)
			setActive(arg_43_2:Find("unsel/Image"), not var_43_2)
			setActive(arg_43_2:Find("sel/Text"), var_43_2)
			setActive(arg_43_2:Find("unsel/Text"), var_43_2)
			onToggle(arg_40_0, arg_43_2, function(arg_44_0)
				NewEducateEntryCard.StaticShow(arg_40_1:Find("bg/entry/unlock"), var_43_0)
				setText(arg_40_1:Find("bg/entry/lv"), "LV." .. var_43_1)
				setActive(arg_40_1:Find("bg/entry/unlock"), var_43_2)
				setActive(arg_40_1:Find("bg/entry/lock"), not var_43_2)
				setText(arg_40_1:Find("bg/entry/lock/Text"), var_0.get)
				setText(arg_40_1:Find("bg/entry/lock/name"), var_0.name)

				return
			end, SFX_PANEL)
		end

		return
	end)
	triggerToggle(arg_40_1:Find("bg/toggles"):Find(tostring(arg_40_3)), true)

	return
end

function var_0_0.willExit(arg_45_0)
	arg_45_0:UnOverlayPanel(arg_45_0._tf)

	return
end

return var_0_0
