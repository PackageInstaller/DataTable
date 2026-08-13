class = var_0_10000

local var_0_0 = "PlayRoomInfoViewerItem"

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
	return
end

function var_0_1.didEnter(arg_3_0, arg_3_1, arg_3_2)
	setText = var_1_10003

	var_1_10003(arg_3_0.uiNameText, arg_3_1.name)

	setText = var_1_10003

	var_1_10003(arg_3_0.uiPtCntText, arg_3_1.ptCnt)

	setText = var_1_10003

	var_1_10003(arg_3_0.uiServeText, "区服")

	setActive = var_1_10003

	var_1_10003(arg_3_0.uiKickBtn, arg_3_2)

	onButton = var_1_10003

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.uiKickBtn

	local function var_3_2()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		PlayRoomInfoViewerMediator = var_2_10003

		var_4_1(var_4_0, var_2_10003.ON_CLICK_KICK, {
			id = arg_3_1.id
		})

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_3_0, var_3_1, var_3_2, var_1_10008)

	Ship = var_1_10003

	local var_3_3 = var_1_10003.New({
		configId = arg_3_1.displayicon
	})

	LoadSpriteAsync = var_1_10004

	var_1_10004("qicon/" .. var_3_3:getPrefab(), function(arg_5_0)
		arg_3_0.uiIcon.sprite = arg_5_0

		return
	end)

	return
end

function var_0_1.willExit(arg_6_0)
	arg_6_0:detach()

	return
end

return var_0_1
