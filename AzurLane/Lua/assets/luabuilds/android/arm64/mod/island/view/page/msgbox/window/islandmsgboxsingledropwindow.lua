local var_0_0 = class("IslandMsgBoxSingleDropWindow", import(".IslandCommonMsgboxWindow"))

function var_0_0.getUIName(arg_1_0)
	return "IslandCommonMsgBoxWithSingleItem"
end

function var_0_0.OnLoaded(arg_2_0)
	var_0_0.super.OnLoaded(arg_2_0)

	arg_2_0.itemTr = arg_2_0._tf:Find("IslandItemTpl")
	arg_2_0.nameTxt = arg_2_0._tf:Find("name"):GetComponent(typeof(Text))
	arg_2_0.ownTxt = arg_2_0._tf:Find("own"):GetComponent(typeof(Text))
	arg_2_0.uiItemList = UIItemList.New(arg_2_0._tf:Find("way/Viewport/list"), arg_2_0._tf:Find("way/Viewport/list/tpl"))
	arg_2_0.contentTF = arg_2_0._tf:Find("way/Viewport/list")

	setText(arg_2_0._tf:Find("label/Text"), i18n("island_get_way"))

	return
end

function var_0_0.OnShow(arg_3_0)
	var_0_0.super.OnShow(arg_3_0)

	local var_3_0 = IslandDropDescribeInfo.New(arg_3_0.settings.dropData)

	arg_3_0:FlushMain(var_3_0)
	arg_3_0:FlushAcquiringWay(var_3_0)

	return
end

function var_0_0.FlushMain(arg_4_0, arg_4_1)
	arg_4_0.nameTxt.text = arg_4_1:GetName()
	arg_4_0.contentTxt.text = arg_4_1:GetDes()
	arg_4_0.ownTxt.text = i18n("island_own_cnt") .. setColorStr(arg_4_1:GetOwnCount(), "#39beff")

	updateCustomDrop(arg_4_0.itemTr, arg_4_1:GetDrop(), {
		style = "island"
	})

	return
end

function var_0_0.FlushAcquiringWay(arg_5_0, arg_5_1)
	local var_5_0

	if arg_5_1:IsTecUnlocked() then
		var_5_0 = arg_5_1:GetAcquiringWay()
	else
		var_5_0 = {}

		table.insert({}, arg_5_1:GetTecDes())
		table.insert(var_5_0, {})
	end

	local var_5_1 = #var_5_0 > 0

	setActive(arg_5_0._tf:Find("line"), #var_5_0 > 0)
	setActive(arg_5_0._tf:Find("label"), var_5_1)
	setActive(arg_5_0._tf:Find("way"), var_5_1)
	arg_5_0.uiItemList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			local var_6_0 = var_5_0[arg_6_1 + 1]

			setText(arg_6_2:Find("Text"), var_5_0[arg_6_1 + 1][1])
			setText(arg_6_2:Find("go/Text"), i18n("island_word_go"))
			onButton(arg_5_0, arg_6_2:Find("go"), function()
				local var_7_0 = Clone(var_6_0[2])

				table.remove(var_7_0, 1)
				arg_5_0:GetMsgBoxMgr():emit(IslandMediator.OPEN_PAGE, var_7_0[1], var_7_0)
				arg_5_0:Hide()

				return
			end, SFX_PANEL)

			local var_6_1 = var_5_0[arg_6_1 + 1][2] and #var_5_0[arg_6_1 + 1][2] > 0

			setActive(arg_6_2:Find("go"), var_6_1)
		end

		return
	end)
	arg_5_0.uiItemList:align(#var_5_0)
	setAnchoredPosition(arg_5_0.contentTF, {
		x = 0,
		y = 0
	})

	return
end

function var_0_0.FlushBtn(arg_8_0, arg_8_1)
	setActive(arg_8_0.cancelBtn, false)

	return
end

return var_0_0
