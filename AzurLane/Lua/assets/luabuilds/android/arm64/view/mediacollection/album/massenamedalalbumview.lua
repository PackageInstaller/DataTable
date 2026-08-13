class = var_0_10000

local var_0_0 = "MassenaMedalAlbumView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MedalAlbumTemplateView"))

var_0_1.GROUP_ID = 50087
var_0_1.MEDAL_COUNT = 8
var_0_1.HELP_TIPS = "help_starLightAlbum"
var_0_1.TASK_CLOSE_ANIM = "Anim_MedalAlbumMassenaPage_TaskView_Out"
var_0_1.TASK_CLOSE_ANIM_Time = 0.12
var_0_1.TASK_ANIM = "Anim_MedalAlbumMassenaPage_TaskView_TaskTpl_In"
var_0_1.TASK_ENTER_ANIM_Time = 0.27
var_0_1.TASK_Time = 0.08
var_0_1.DETAIL_CLOSE_ANIM = "Anim_MedalAlbumMassenaPage_DetailView_Out"
var_0_1.DETAIL_CLOSE_ANIM_Time = 0.1

function var_0_1.getUIName(arg_1_0)
	return "MedalAlbumMassenaPage"
end

function var_0_1.didEnter(arg_2_0)
	var_0_1.super.didEnter(arg_2_0)

	onButton = var_1

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.backBtn

	local function var_2_2()
		quickPlayAnimation = var_2_10000

		var_2_10000(arg_2_0._tf, "Anim_MedalAlbumMassenaPage_Out")

		onDelayTick = var_2_10000

		var_2_10000(function()
			local var_4_0 = arg_2_0

			var_0.closeView(var_4_0)

			return
		end, 0.1)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_2_0, var_2_1, var_2_2, var_1_10006)

	onButton = var_1

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.bg

	local function var_2_5()
		quickPlayAnimation = var_2_10000

		var_2_10000(arg_2_0._tf, "Anim_MedalAlbumMassenaPage_Out")

		onDelayTick = var_2_10000

		var_2_10000(function()
			local var_6_0 = arg_2_0

			var_0.closeView(var_6_0)

			return
		end, 0.1)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_3, var_2_4, var_2_5, var_1_10006)

	return
end

return var_0_1
