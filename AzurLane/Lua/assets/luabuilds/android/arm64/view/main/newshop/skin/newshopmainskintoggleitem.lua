local var_0_0 = class("NewShopMainSkinToggleItem", import("view.base.BasePanel"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_0.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	onToggle(arg_2_0, arg_2_0.uiToggle, function(arg_3_0)
		if arg_3_0 then
			arg_2_0:emit(NewShopMainScene.ON_CLICK_SKIN_SHOP, arg_2_0.skinShopID)
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.didEnter(arg_4_0, arg_4_1)
	arg_4_0.skinShopID = arg_4_1

	setText(arg_4_0.uiNameText, pg.shop_skin_subsheet[arg_4_1].site_tag_text)
	setText(arg_4_0.uiNameText2, pg.shop_skin_subsheet[arg_4_1].site_tag_text)

	return
end

function var_0_0.TriggerToggle(arg_5_0)
	triggerToggle(arg_5_0.uiToggle, true)

	return
end

function var_0_0.willExit(arg_6_0)
	arg_6_0:detach()
	Object.Destroy(arg_6_0._go)

	arg_6_0._tf = nil
	arg_6_0._go = nil

	return
end

return var_0_0
