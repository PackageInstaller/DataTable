class = var_0_10000

local var_0_0 = "AuctionGameMainEventMsgLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "AuctionGameMainEventMsgUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:OverlayPanel(arg_2_0._tf, {
		pbList = {
			arg_2_0.uiBgBtn
		}
	})

	setText = var_1

	local var_2_0 = arg_2_0.uiCancelText

	i18n = var_4

	var_1(var_2_0, var_4("auction_cancel"))

	setText = var_1

	local var_2_1 = arg_2_0.uiConfirmText

	i18n = var_4

	var_1(var_2_1, var_4("auction_confirm"))

	onButton = var_1

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0.uiBgBtn

	local function var_2_4()
		local var_3_0 = arg_2_0

		var_0.closeView(var_3_0)

		return
	end

	SOUND_BACK = var_6

	var_1(var_2_2, var_2_3, var_2_4, var_6)

	onButton = var_1

	local var_2_5 = arg_2_0
	local var_2_6 = arg_2_0.uiCloseBtn

	local function var_2_7()
		local var_4_0 = arg_2_0

		var_0.closeView(var_4_0)

		return
	end

	SOUND_BACK = var_6

	var_1(var_2_5, var_2_6, var_2_7, var_6)

	onButton = var_1

	local var_2_8 = arg_2_0
	local var_2_9 = arg_2_0.uiCancelBtn

	local function var_2_10()
		local var_5_0 = arg_2_0

		var_0.closeView(var_5_0)

		return
	end

	SOUND_BACK = var_6

	var_1(var_2_8, var_2_9, var_2_10, var_6)

	onButton = var_1

	local var_2_11 = arg_2_0
	local var_2_12 = arg_2_0.uiConfirmBtn

	local function var_2_13()
		existCall = var_2_10000

		var_2_10000(arg_2_0.contextData.callback)

		local var_6_0 = arg_2_0

		var_0.closeView(var_6_0)

		return
	end

	SFX_PANEL = var_6

	var_1(var_2_11, var_2_12, var_2_13, var_6)

	return
end

function var_0_1.didEnter(arg_7_0)
	local var_7_0 = arg_7_0.contextData.eventID

	pg = var_1_10002

	local var_7_1 = var_1_10002.auction_event[var_7_0]

	setText = var_1_10003

	var_1_10003(arg_7_0.uiNameText, var_7_1.name)

	setText = var_1_10003

	var_1_10003(arg_7_0.uiDescText, var_7_1.describe)

	LoadSpriteAsync = var_1_10003

	var_1_10003(var_7_1.icon, function(arg_8_0)
		IsNil = var_2_10001

		if not var_2_10001(arg_7_0.uiIconImage) then
			arg_7_0.uiIconImage.sprite = arg_8_0
		end

		return
	end)

	return
end

function var_0_1.willExit(arg_9_0)
	arg_9_0:UnOverlayPanel(arg_9_0._tf)

	return
end

return var_0_1
