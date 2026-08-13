class = var_0_10000

local var_0_0 = "NewShopMainSkinToggleItem"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BasePanel"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_1.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_1.Init(arg_2_0)
	onToggle = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.uiToggle

	local function var_2_2(arg_3_0)
		if arg_3_0 then
			local var_3_0 = arg_2_0
			local var_3_1 = var_1.emit

			NewShopMainScene = var_2_10004

			var_3_1(var_3_0, var_2_10004.ON_CLICK_SKIN_SHOP, arg_2_0.skinShopID)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10006)

	return
end

function var_0_1.didEnter(arg_4_0, arg_4_1)
	arg_4_0.skinShopID = arg_4_1
	pg = var_1_10002

	local var_4_0 = var_1_10002.shop_skin_subsheet[arg_4_1]

	setText = var_1_10003

	var_1_10003(arg_4_0.uiNameText, var_4_0.site_tag_text)

	setText = var_1_10003

	var_1_10003(arg_4_0.uiNameText2, var_4_0.site_tag_text)

	return
end

function var_0_1.TriggerToggle(arg_5_0)
	triggerToggle = var_1_10001

	var_1_10001(arg_5_0.uiToggle, true)

	return
end

function var_0_1.willExit(arg_6_0)
	arg_6_0:detach()

	Object = var_1

	var_1.Destroy(arg_6_0._go)

	arg_6_0._tf = nil
	arg_6_0._go = nil

	return
end

return var_0_1
