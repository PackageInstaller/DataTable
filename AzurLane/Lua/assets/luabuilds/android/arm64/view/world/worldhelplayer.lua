local var_0_0 = class("WorldHelpLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "WorldHelpUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.rtTitle = arg_2_0._tf:Find("title")
	arg_2_0.btnBack = arg_2_0.rtTitle:Find("btn_back")

	onButton(arg_2_0, arg_2_0.btnBack, function()
		arg_2_0:closeView()

		return
	end, SFX_CANCEL)

	arg_2_0.groupList = UIItemList.New(arg_2_0.rtTitle:Find("toggles"), arg_2_0.rtTitle:Find("toggles/toggle"))

	arg_2_0.groupList:make(function(arg_4_0, arg_4_1, arg_4_2)
		arg_4_1 = arg_4_1 + 1

		if arg_4_0 == UIItemList.EventUpdate then
			setText(arg_4_2:Find("Text"), pg.world_help_data[arg_2_0.titles[arg_4_1]].name)
			onToggle(arg_2_0, arg_4_2, function(arg_5_0)
				if arg_5_0 then
					if arg_2_0.curGroupId ~= var_0 then
						arg_2_0:toggleAnim(arg_4_2, true)
						arg_2_0:setCurGroup(var_0)
					end
				else
					arg_2_0:toggleAnim(arg_4_2, false)
				end

				return
			end, SFX_PANEL)
		end

		return
	end)

	arg_2_0.rtMain = arg_2_0._tf:Find("main")
	arg_2_0.rtScroll = arg_2_0.rtMain:Find("Scroll")

	onButton(arg_2_0, arg_2_0.rtMain:Find("left"), function()
		if LeanTween.isTweening(go(arg_2_0.rtScroll)) then
			return
		end

		if arg_2_0.curPageIndex > 1 then
			table.insert({}, function(arg_7_0)
				arg_2_0:pageAnim(false, arg_7_0)

				return
			end)
			table.insert({}, function(arg_8_0)
				arg_2_0:setCurPage(arg_2_0.curPageIndex - 1)
				arg_8_0()

				return
			end)
			table.insert({}, function(arg_9_0)
				arg_2_0:pageAnim(true, arg_9_0)

				return
			end)
			seriesAsync({}, function()
				return
			end)
		end

		return
	end)
	onButton(arg_2_0, arg_2_0.rtMain:Find("right"), function()
		if LeanTween.isTweening(go(arg_2_0.rtScroll)) then
			return
		end

		if arg_2_0.curPageIndex < #arg_2_0.pageList then
			table.insert({}, function(arg_12_0)
				arg_2_0:pageAnim(false, arg_12_0)

				return
			end)
			table.insert({}, function(arg_13_0)
				arg_2_0:setCurPage(arg_2_0.curPageIndex + 1)
				arg_13_0()

				return
			end)
			table.insert({}, function(arg_14_0)
				arg_2_0:pageAnim(true, arg_14_0)

				return
			end)
			seriesAsync({}, function()
				return
			end)
		end

		return
	end)

	return
end

function var_0_0.setCurGroup(arg_16_0, arg_16_1)
	if arg_16_0.curGroupId then
		table.insert({}, function(arg_17_0)
			arg_16_0:pageAnim(false, arg_17_0)

			return
		end)
	end

	arg_16_0.curGroupId = arg_16_1

	table.insert({}, function(arg_18_0)
		arg_16_0.pageList = {}

		local var_18_0 = nowWorld():GetProgress()

		for iter_18_0, iter_18_1 in ipairs(pg.world_help_data[arg_16_0.curGroupId].stage_help) do
			if var_18_0 >= iter_18_1[1] then
				table.insert(arg_16_0.pageList, {
					id = iter_18_0,
					path = iter_18_1[2]
				})
			end
		end

		if #arg_16_0.pageList > 0 then
			arg_16_0:setCurPage(1)
		end

		arg_18_0()

		return
	end)
	seriesAsync({}, function()
		arg_16_0:pageAnim(true)

		return
	end)

	return
end

function var_0_0.setCurPage(arg_20_0, arg_20_1)
	arg_20_0.curPageIndex = arg_20_1

	setText(arg_20_0.rtMain:Find("page/Text"), arg_20_0.curPageIndex .. "/" .. #arg_20_0.pageList)

	local var_20_0 = arg_20_0.rtScroll:Find("Card")

	setImageAlpha(arg_20_0.rtScroll:Find("Card"):Find("Image"), 0)
	GetSpriteFromAtlasAsync(arg_20_0.pageList[arg_20_1].path, "", function(arg_21_0)
		if arg_20_0.curPageIndex == arg_20_1 then
			setImageSprite(var_20_0:Find("Image"), arg_21_0)
			setImageAlpha(var_20_0:Find("Image"), 1)
		end

		return
	end)

	return
end

function var_0_0.getPageIndex(arg_22_0, arg_22_1)
	for iter_22_0, iter_22_1 in ipairs(arg_22_0.pageList) do
		if iter_22_1.id == arg_22_1 then
			return iter_22_0
		end
	end

	return 1
end

function var_0_0.pageAnim(arg_23_0, arg_23_1, arg_23_2)
	LeanTween.cancel(go(arg_23_0.rtScroll))

	local var_23_0 = GetOrAddComponent(arg_23_0.rtScroll, "CanvasGroup")

	var_23_0.alpha = arg_23_1 and 0 or 1

	LeanTween.alphaCanvas(var_23_0, arg_23_1 and 1 or 0, 0.3):setOnComplete(System.Action(function()
		return existCall(arg_23_2)
	end))

	return
end

function var_0_0.toggleAnim(arg_25_0, arg_25_1, arg_25_2)
	LeanTween.cancel(arg_25_1.gameObject)

	local var_25_0 = GetComponent(arg_25_1, typeof(LayoutElement))

	if arg_25_2 then
		LeanTween.value(arg_25_1.gameObject, var_25_0.preferredWidth, 238, 0.15):setOnUpdate(System.Action_float(function(arg_26_0)
			var_25_0.preferredWidth = arg_26_0

			return
		end)):setOnComplete(System.Action(function()
			setActive(arg_25_1:Find("selected"), arg_25_2)

			return
		end))
	else
		setActive(arg_25_1:Find("selected"), arg_25_2)
		LeanTween.value(arg_25_1.gameObject, var_25_0.preferredWidth, 176, 0.15):setOnUpdate(System.Action_float(function(arg_28_0)
			var_25_0.preferredWidth = arg_28_0

			return
		end))
	end

	return
end

function var_0_0.didEnter(arg_29_0)
	pg.UIMgr.GetInstance():OverlayPanel(arg_29_0._tf)

	local var_29_0

	arg_29_0.titles = {}

	local var_29_1 = nowWorld():GetProgress()

	for iter_29_0, iter_29_1 in ipairs(pg.world_help_data.all) do
		if var_29_1 >= pg.world_help_data[iter_29_1].stage then
			table.insert(arg_29_0.titles, iter_29_1)

			if arg_29_0.contextData.titleId == iter_29_1 then
				var_29_0 = #arg_29_0.titles
			end
		end
	end

	arg_29_0.groupList:align(#arg_29_0.titles)
	setActive(arg_29_0.rtScroll, #arg_29_0.titles > 0)

	if #arg_29_0.titles > 0 then
		if var_29_0 then
			triggerToggle(arg_29_0.groupList.container:GetChild(var_29_0 - 1), true)
			arg_29_0:setCurPage(arg_29_0:getPageIndex(arg_29_0.contextData.pageId))
		else
			triggerToggle(arg_29_0.groupList.container:GetChild(0), true)
		end
	end

	return
end

function var_0_0.willExit(arg_30_0)
	LeanTween.cancel(go(arg_30_0.rtScroll))
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_30_0._tf)

	return
end

return var_0_0
