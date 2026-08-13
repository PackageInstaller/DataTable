class = var_0_10000

local var_0_0 = "GeZiURMainPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.Helena.HelenaMainPage"))

function var_0_1.OnFirstFlush(arg_1_0)
	var_0_1.super.OnFirstFlush(arg_1_0)

	onButton = var_1

	var_1(arg_1_0, arg_1_0.Manual, function()
		Context = var_2_10000

		local var_2_0 = var_2_10000.New
		local var_2_1 = {}

		MedalAlbumTemplateMediator = var_2_10002
		var_2_1.mediator = var_2_10002
		GeZiMedalAlbumView = var_2_10002
		var_2_1.viewComponent = var_2_10002

		local var_2_2 = var_2_0(var_2_1)
		local var_2_3 = arg_1_0
		local var_2_4 = var_1.emit

		ActivityMediator = var_2_10003

		var_2_4(var_2_3, var_2_10003.ON_ADD_SUBLAYER, var_2_2)

		return
	end)

	return
end

return var_0_1
