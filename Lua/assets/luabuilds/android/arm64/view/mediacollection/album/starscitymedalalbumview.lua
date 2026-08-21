local var_0_0 = class("StarsCityMedalAlbumView", import(".MedalAlbumTemplateView"))

var_0_0.GROUP_ID = 51110
var_0_0.HELP_TIPS = "help_starLightAlbum"

function var_0_0.getUIName(arg_1_0)
	return "MedalAlbumStarsCityPage"
end

function var_0_0.FindUI(arg_2_0)
	local var_2_0 = arg_2_0._tf:Find("Top")

	arg_2_0.bg = arg_2_0._tf:Find("mask")
	arg_2_0.backBtn = var_2_0:Find("BackBtn")
	arg_2_0.helpBtn = var_2_0:Find("InfoBtn")
	arg_2_0.taskBtn = arg_2_0._tf:Find("Desk/taskBtn")
	arg_2_0.prevBtn = arg_2_0._tf:Find("Desk/prevBtn")
	arg_2_0.nextBtn = arg_2_0._tf:Find("Desk/nextBtn")
	arg_2_0.slots = {}

	for iter_2_0 = 1, arg_2_0.MEDAL_COUNT do
		arg_2_0.slots[iter_2_0] = {
			slot = arg_2_0._tf:Find("Desk/Slot" .. iter_2_0),
			active = arg_2_0._tf:Find("Desk/Slot" .. iter_2_0 .. "/active"),
			tips = arg_2_0._tf:Find("Desk/Slot" .. iter_2_0 .. "/reddot"),
			click = arg_2_0._tf:Find("Desk/Slot" .. iter_2_0 .. "/Click")
		}
	end

	arg_2_0.medalLock = arg_2_0._tf:Find("Desk/medal")
	arg_2_0.trophyLock = arg_2_0._tf:Find("Desk/trophy")
	arg_2_0.medalDetailView = DreamTourMedalDetailPanel.New(arg_2_0._tf:Find("DetailView"), arg_2_0)

	arg_2_0.medalDetailView:SetIconScale(arg_2_0.ICON_SCALE)

	arg_2_0.medalTaskView = FujinBayMedalTaskPanel.New(arg_2_0._tf:Find("TaskView"), arg_2_0)

	return
end

return var_0_0
