local var_0_0 = class("NewEducateFavorPanel", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "NewEducateFavorPanel"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.favorPanelTF = arg_2_0._tf:Find("favor_panel")
	arg_2_0.favorPanelAnim = arg_2_0.favorPanelTF:GetComponent(typeof(Animation))
	arg_2_0.favorPanelAnimEvent = arg_2_0.favorPanelTF:GetComponent(typeof(DftAniEvent))

	arg_2_0.favorPanelAnimEvent:SetEndEvent(function()
		setActive(arg_2_0.favorPanelTF, false)

		return
	end)
	setActive(arg_2_0.favorPanelTF, false)

	local var_2_0 = arg_2_0._tf:Find("favor_panel/panel")
	local var_2_1 = var_2_0:Find("bg/view/content")

	arg_2_0.favorUIList = UIItemList.New(var_2_1, var_2_1:Find("tpl"))
	arg_2_0.favorCurTF = var_2_0:Find("bg/cur")

	arg_2_0:OverlayPanel(arg_2_0._tf, {
		pbList = {
			var_2_0:Find("bg")
		}
	})

	return
end

function var_0_0.OnInit(arg_4_0)
	onButton(arg_4_0, arg_4_0._tf:Find("favor_panel"), function()
		arg_4_0:Hide()

		return
	end, SFX_PANEL)
	arg_4_0.favorUIList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			arg_4_0:UpdateItem(arg_6_1, arg_6_2)
		end

		return
	end)

	return
end

function var_0_0.UpdateFavorPanel(arg_7_0)
	local var_7_0 = arg_7_0.contextData.char:GetFavorInfo()

	setText(arg_7_0.favorCurTF:Find("lv"), var_7_0.lv)

	local var_7_1 = arg_7_0.contextData.char:getConfig("favor_exp")[var_7_0.lv]

	setText(arg_7_0.favorCurTF:Find("progress"), i18n("child_favor_progress", var_7_0.value .. "/" .. (var_7_1 or "Max")))

	local var_7_3 = arg_7_0.favorCurTF:Find("slider")
	local var_7_4 = 0
	local var_7_5 = 1

	if var_7_1 then
		local var_7_6 = var_7_0.value / var_7_1 or 1

		var_7_2(var_7_3, var_7_4, var_7_5, var_7_6)
		arg_7_0.favorUIList:align(arg_7_0.contextData.char:getConfig("favor_level") - 1)

		return
	end
end

function var_0_0.UpdateItem(arg_8_0, arg_8_1, arg_8_2)
	setText(arg_8_2:Find("lv"), arg_8_1 + 1 + 1)

	local var_8_0 = arg_8_1 + 1 < arg_8_0.contextData.char:GetFavorInfo().lv

	setActive(arg_8_2:Find("lock"), not var_8_0)
	setActive(arg_8_2:Find("award/got"), var_8_0)
	setText(arg_8_2:Find("Text"), i18n("child_favor_lock1", arg_8_1 + 1 + 1))
	setTextColor(arg_8_2:Find("Text"), Color.NewHex(var_8_0 and "393A3C" or "F5F5F5"))
	setTextColor(arg_8_2:Find("lv"), Color.NewHex(var_8_0 and "FFFFFF" or "F5F5F5"))
	NewEducateHelper.UpdateItem(arg_8_2:Find("award/item"), (NewEducateHelper.Config2Drop(arg_8_0.contextData.char:getConfig("favor_result_display")[arg_8_1 + 1])))
	onButton(arg_8_0, arg_8_2:Find("award"), function()
		arg_8_0:emit(NewEducateBaseUI.ON_ITEM, {
			drop = var_0
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_10_0)
	var_0_0.super.Show(arg_10_0)
	setActive(arg_10_0.favorPanelTF, true)
	arg_10_0:UpdateFavorPanel()

	return
end

function var_0_0.Hide(arg_11_0)
	arg_11_0.favorPanelAnim:Play("anim_educate_educateUI_favor_out")

	return
end

function var_0_0.OnDestroy(arg_12_0)
	arg_12_0:UnOverlayPanel(arg_12_0._tf)

	return
end

return var_0_0
