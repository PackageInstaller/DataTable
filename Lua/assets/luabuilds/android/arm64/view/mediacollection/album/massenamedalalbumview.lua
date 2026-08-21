local var_0_0 = class("MassenaMedalAlbumView", import(".MedalAlbumTemplateView"))

var_0_0.GROUP_ID = 50087
var_0_0.MEDAL_COUNT = 8
var_0_0.HELP_TIPS = "help_starLightAlbum"
var_0_0.TASK_CLOSE_ANIM = "Anim_MedalAlbumMassenaPage_TaskView_Out"
var_0_0.TASK_CLOSE_ANIM_Time = 0.12
var_0_0.TASK_ANIM = "Anim_MedalAlbumMassenaPage_TaskView_TaskTpl_In"
var_0_0.TASK_ENTER_ANIM_Time = 0.27
var_0_0.TASK_Time = 0.08
var_0_0.DETAIL_CLOSE_ANIM = "Anim_MedalAlbumMassenaPage_DetailView_Out"
var_0_0.DETAIL_CLOSE_ANIM_Time = 0.1

function var_0_0.getUIName(arg_1_0)
	return "MedalAlbumMassenaPage"
end

function var_0_0.didEnter(arg_2_0)
	var_0_0.super.didEnter(arg_2_0)
	onButton(arg_2_0, arg_2_0.backBtn, function()
		quickPlayAnimation(arg_2_0._tf, "Anim_MedalAlbumMassenaPage_Out")
		onDelayTick(function()
			arg_2_0:closeView()

			return
		end, 0.1)

		return
	end, SFX_CANCEL)
	onButton(arg_2_0, arg_2_0.bg, function()
		quickPlayAnimation(arg_2_0._tf, "Anim_MedalAlbumMassenaPage_Out")
		onDelayTick(function()
			arg_2_0:closeView()

			return
		end, 0.1)

		return
	end, SFX_PANEL)

	return
end

return var_0_0
