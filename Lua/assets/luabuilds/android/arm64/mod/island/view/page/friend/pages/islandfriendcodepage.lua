local var_0_0 = class("IslandFriendCodePage", import("view.base.BaseSubView"))
local var_0_1 = 4

function var_0_0.getUIName(arg_1_0)
	return "IslandFirendCodeUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.enterBtn = arg_2_0._tf:Find("frame/visit")
	arg_2_0.saveBtn = arg_2_0._tf:Find("frame/like")
	arg_2_0.inputTr = arg_2_0._tf:Find("frame/input")
	arg_2_0.uiItemlist = UIItemList.New(arg_2_0._tf:Find("frame/list"), arg_2_0._tf:Find("frame/list/tpl"))
	arg_2_0.tipTxt = arg_2_0._tf:Find("frame/sub_title/Text"):GetComponent(typeof(Text))
	arg_2_0.frequentlyUsedList = arg_2_0:GetSaveCodeList()

	setText(arg_2_0._tf:Find("frame/title/Text"), i18n("island_input_code_tip"))
	setText(arg_2_0._tf:Find("frame/input/Text"), i18n("island_input_code_tip_1"))
	setText(arg_2_0._tf:Find("frame/like/Text"), i18n("island_set_like"))
	setText(arg_2_0._tf:Find("frame/visit/Text"), i18n("island_btn_label_visit"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.enterBtn, function()
		local var_4_0 = getInputText(arg_3_0.inputTr)

		if not var_4_0 or var_4_0 == "" then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_input_code_erro"))

			return
		end

		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandVisitByCode())
		arg_3_0:emit(IslandMediator.ENTER_ISLAND_BY_CODE, var_4_0)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.saveBtn, function()
		arg_3_0:AddCode()

		return
	end, SFX_PANEL)
	arg_3_0:InitFrequentlyUsedList()

	return
end

function var_0_0.GetSaveCodeList(arg_6_0)
	local var_6_0 = PlayerPrefs.GetString("_ISLAND_CODE_" .. getProxy(PlayerProxy):getRawData().id, "")

	if var_6_0 == "" then
		return {}
	end

	return (string.split(var_6_0, "#"))
end

function var_0_0.AddCode(arg_7_0)
	if #arg_7_0.frequentlyUsedList >= var_0_1 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_visit_tip7"))

		return
	end

	local var_7_0 = getInputText(arg_7_0.inputTr)

	if not var_7_0 or var_7_0 == "" then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_input_code_erro"))

		return
	end

	if table.contains(arg_7_0.frequentlyUsedList, var_7_0) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_code_exist"))

		return
	end

	table.insert(arg_7_0.frequentlyUsedList, var_7_0)
	arg_7_0:InitFrequentlyUsedList()

	return
end

function var_0_0.RemoveCode(arg_8_0, arg_8_1)
	table.removebyvalue(arg_8_0.frequentlyUsedList, arg_8_1)
	arg_8_0:InitFrequentlyUsedList()

	return
end

function var_0_0.SaveCodeList(arg_9_0)
	local var_9_0 = PlayerPrefs.SetString("_ISLAND_CODE_" .. getProxy(PlayerProxy):getRawData().id, (table.concat(arg_9_0.frequentlyUsedList, "#")))

	PlayerPrefs.Save()

	return
end

function var_0_0.InitFrequentlyUsedList(arg_10_0)
	arg_10_0.uiItemlist:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			setActive(arg_11_2:Find("btns"), arg_10_0.frequentlyUsedList[arg_11_1 + 1])
			setActive(arg_11_2:Find("empty"), not arg_10_0.frequentlyUsedList[arg_11_1 + 1])

			if arg_10_0.frequentlyUsedList[arg_11_1 + 1] then
				arg_10_0:UpdateCodeTpl(arg_11_2:Find("btns"), arg_10_0.frequentlyUsedList[arg_11_1 + 1])
			end
		end

		return
	end)
	arg_10_0.uiItemlist:align(var_0_1)

	arg_10_0.tipTxt.text = i18n("island_like_title") .. #arg_10_0.frequentlyUsedList .. "/" .. var_0_1

	return
end

function var_0_0.UpdateCodeTpl(arg_12_0, arg_12_1, arg_12_2)
	setText(arg_12_1:Find("id/Text"), arg_12_2)
	onButton(arg_12_0, arg_12_1:Find("copy"), function()
		UniPasteBoard.SetClipBoardString(arg_12_2)
		pg.TipsMgr.GetInstance():ShowTips(i18n("friend_id_copy_ok"))

		return
	end, SFX_PANEL)
	onButton(arg_12_0, arg_12_1:Find("remove"), function()
		arg_12_0:RemoveCode(arg_12_2)

		return
	end, SFX_PANEL)
	setText(arg_12_1:Find("remove/Text"), i18n("island_btn_label_remove"))
	setText(arg_12_1:Find("copy/Text"), i18n("island_btn_label_copy"))

	return
end

function var_0_0.Hide(arg_15_0)
	var_0_0.super.Hide(arg_15_0)
	arg_15_0:SaveCodeList()

	return
end

function var_0_0.OnDestroy(arg_16_0)
	if arg_16_0:isShowing() then
		arg_16_0:Hide()
	end

	return
end

return var_0_0
