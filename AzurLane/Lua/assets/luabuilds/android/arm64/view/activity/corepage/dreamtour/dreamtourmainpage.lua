local var_0_0 = class("DreamTourMainPage", import("view.activity.CorePage.Helena.HelenaMainPage"))

function var_0_0.OnFirstFlush(arg_1_0)
	var_0_0.super.OnFirstFlush(arg_1_0)
	onButton(arg_1_0, arg_1_0.Manual, function()
		arg_1_0:emit(ActivityMediator.ON_ADD_SUBLAYER, (Context.New({
			mediator = MedalAlbumTemplateMediator,
			viewComponent = DreamTourMedalAlbumView
		})))

		return
	end)

	return
end

return var_0_0
