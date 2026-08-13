class = var_0_10000

local var_0_0 = "SailingShip3SkinActPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CorePreviewTemplatePage"))

function var_0_1.OnFirstFlush(arg_1_0)
	arg_1_0.super.OnFirstFlush(arg_1_0)

	onButton = var_1

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.btnList

	var_1(var_1_0, var_4.Find(var_1_1, "activity"), function()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_2_2 = var_2_10003.OPEN_LAYER

		Context = var_2_10004

		local var_2_3 = var_2_10004.New
		local var_2_4 = {}

		SailingShip3SkinMediator = var_2_10007
		var_2_4.mediator = var_2_10007
		SailingShip3SkinLayer = var_2_10007
		var_2_4.viewComponent = var_2_10007

		var_2_1(var_2_0, var_2_2, var_2_3(var_2_4))

		return
	end)

	return
end

function var_0_1.OnUpdateFlush(arg_3_0)
	local var_3_0 = arg_3_0._tf
	local var_3_1

	var_3_1, setActive = var_1.Find(var_3_0, "AD/redDot"), var_1_10002
	SailingShip3SkinLayer = var_1_10005

	var_1_10002(var_3_1, var_1_10005.ShouldShowTip())

	return
end

return var_0_1
