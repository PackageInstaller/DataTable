local var_0_0 = class("MallSiteBox", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "MallSiteBox"
end

function var_0_0.OnLoaded(arg_2_0)
	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.uiCloseBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_5_0, arg_5_1)
	var_0_0.super.Show(arg_5_0)
	setText(arg_5_0.uiNameText, pg.activity_mall_story[arg_5_1].name)
	setText(arg_5_0.uiDescText, pg.activity_mall_story[arg_5_1].desc)
	setImageSprite(arg_5_0.uiIconImage, LoadSprite("ui/mallstorylineui_atlas", pg.activity_mall_story[arg_5_1].icon .. "_l"), true)

	return
end

function var_0_0.OnDestroy(arg_6_0)
	return
end

return var_0_0
