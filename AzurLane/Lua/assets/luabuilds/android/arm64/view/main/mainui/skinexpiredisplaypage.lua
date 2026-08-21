local var_0_0 = class("SkinExpireDisplayPage", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "SkinOverDueUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.uilist = UIItemList.New(arg_2_0._tf:Find("window/list/scrollrect/content"), arg_2_0._tf:Find("window/list/scrollrect/content/tpl"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf:Find("window/button_container/confirm_btn"), function()
		arg_3_0:Hide()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0._tf:Find("window/top/btnBack"), function()
		arg_3_0:Hide()

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.Show(arg_7_0, arg_7_1)
	var_0_0.super.Show(arg_7_0)
	arg_7_0:Display(arg_7_1)
	pg.UIMgr.GetInstance():BlurPanel(arg_7_0._tf)

	return
end

function var_0_0.Display(arg_8_0, arg_8_1)
	arg_8_0.uilist:make(function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventUpdate then
			setText(arg_9_2:Find("name/Text"), arg_8_1[arg_9_1 + 1]:getConfig("name"))

			local var_9_0 = arg_9_2:Find("icon_bg/icon")

			LoadSpriteAsync("qicon/" .. arg_8_1[arg_9_1 + 1]:getIcon(), function(arg_10_0)
				if not IsNil(arg_8_0._tf) then
					var_9_0:GetComponent(typeof(Image)).sprite = arg_10_0
				end

				return
			end)
		end

		return
	end)
	arg_8_0.uilist:align(#arg_8_1)

	return
end

function var_0_0.OnDestroy(arg_11_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_11_0._tf, pg.UIMgr.GetInstance()._normalUIMain)

	return
end

return var_0_0
