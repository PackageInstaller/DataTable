class = var_0_10000

local var_0_0 = "EscapeManorMainPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.Helena.HelenaMainPage"))

function var_0_1.OnFirstFlush(arg_1_0)
	var_0_1.super.OnFirstFlush(arg_1_0)

	onButton = var_1

	var_1(arg_1_0, arg_1_0.Manual, function()
		Context = var_2_10000

		local var_2_0 = var_2_10000.New
		local var_2_1 = {}

		MedalAlbumTemplateMediator = var_2_10003
		var_2_1.mediator = var_2_10003
		EscapeManorMedalAlbumView = var_2_10003
		var_2_1.viewComponent = var_2_10003

		local var_2_2 = var_2_0(var_2_1)
		local var_2_3 = arg_1_0
		local var_2_4 = var_1.emit

		ActivityMediator = var_2_10004

		var_2_4(var_2_3, var_2_10004.ON_ADD_SUBLAYER, var_2_2)

		return
	end)

	return
end

function var_0_1.updateUI(arg_3_0)
	var_0_1.super.updateUI(arg_3_0)

	removeOnButton = var_1

	var_1(arg_3_0.fight)

	onButton = var_1

	var_1(arg_3_0, arg_3_0.fight, function()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_4_1(var_4_0, var_2_10003.ON_BOSSRUSH_MAP)

		return
	end)

	return
end

return var_0_1
