local var_0_0 = class("EducateSelEndingLayer", import(".base.EducateBaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "EducateSelEndingUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.rootTF = arg_2_0._tf:Find("root")
	arg_2_0.blurPanel = arg_2_0.rootTF:Find("bg")
	arg_2_0.scrollrect = arg_2_0.blurPanel:Find("window/view")

	local var_2_0 = arg_2_0.blurPanel:Find("window/view/content")

	arg_2_0.uiList = UIItemList.New(var_2_0, var_2_0:Find("tpl"))

	arg_2_0.uiList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventInit then
			arg_2_0:InitItem(arg_3_1, arg_3_2)
		elseif arg_3_0 == UIItemList.EventUpdate then
			setActive(arg_3_2:Find("selected"), arg_2_0.selectedIdx == arg_3_1 + 1)
		end

		return
	end)

	arg_2_0.sureBtn = arg_2_0.blurPanel:Find("window/sure_btn")

	setText(arg_2_0.sureBtn:Find("Image"), i18n("word_ok"))

	return
end

function var_0_0.didEnter(arg_4_0)
	arg_4_0:OverlayPanel(arg_4_0.blurPanel, {
		groupDelta = 1,
		pbList = {
			arg_4_0.blurPanel
		}
	})
	onButton(arg_4_0, arg_4_0.sureBtn, function()
		arg_4_0:emit(EducateSelEndingMediator.ON_SELECT_ENDING, arg_4_0.endingList[arg_4_0.selectedIdx], arg_4_0.endingList)

		return
	end, SFX_PANEL)

	arg_4_0.selectedIdx = 1

	arg_4_0:RefreshView()

	return
end

function var_0_0.InitItem(arg_6_0, arg_6_1, arg_6_2)
	setScrollText(arg_6_2:Find("name_mask/name"), pg.child_ending[arg_6_0.endingList[arg_6_1 + 1]].name)
	LoadImageSpriteAsync("educatepicture/" .. pg.child_ending[arg_6_0.endingList[arg_6_1 + 1]].pic_preview, arg_6_2:Find("Image"))
	setActive(arg_6_2:Find("complete"), table.contains(arg_6_0.completeList, arg_6_0.endingList[arg_6_1 + 1]))
	onButton(arg_6_0, arg_6_2, function()
		arg_6_0.selectedIdx = var_0

		arg_6_0.uiList:align(#arg_6_0.endingList)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.RefreshView(arg_8_0)
	arg_8_0.endingList = getProxy(EducateProxy):GetEndingResult()
	arg_8_0.completeList = getProxy(EducateProxy):GetCompleteEndings()

	table.sort(arg_8_0.endingList, CompareFuncs({
		function(arg_9_0)
			return table.contains(arg_8_0.completeList, arg_9_0) and 1 or 0
		end,
		function(arg_10_0)
			return -arg_10_0
		end
	}))
	arg_8_0.uiList:align(#arg_8_0.endingList)
	scrollTo(arg_8_0.scrollrect, arg_8_0.uiList.container.rect.width / 2, 0)

	return
end

function var_0_0.onBackPressed(arg_11_0)
	return
end

function var_0_0.willExit(arg_12_0)
	existCall(arg_12_0.contextData.onExit)
	arg_12_0:UnOverlayPanel(arg_12_0.blurPanel, arg_12_0._tf)

	return
end

return var_0_0
