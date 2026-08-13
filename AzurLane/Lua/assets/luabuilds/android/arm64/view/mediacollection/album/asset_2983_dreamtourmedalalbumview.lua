class = var_0_10000

local var_0_0 = "DreamTourMedalAlbumView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.mediaCollection.album.FujinBayMedalAlbumView"))

var_0_1.GROUP_ID = 50659
var_0_1.MEDAL_COUNT = 8
var_0_1.HELP_TIPS = "help_starLightAlbum"

function var_0_1.getUIName(arg_1_0)
	return "MedalAlbumDreamTourPage"
end

function var_0_1.FindUI(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "Top")
	local var_2_2 = arg_2_0._tf

	arg_2_0.bg = var_2.Find(var_2_2, "mask")
	arg_2_0.backBtn = var_2_1:Find("BackBtn")
	arg_2_0.helpBtn = var_2_1:Find("InfoBtn")

	local var_2_3 = arg_2_0._tf

	arg_2_0.taskBtn = var_2.Find(var_2_3, "Desk/taskBtn")

	local var_2_4 = arg_2_0._tf

	arg_2_0.prevBtn = var_2.Find(var_2_4, "Desk/prevBtn")

	local var_2_5 = arg_2_0._tf

	arg_2_0.nextBtn = var_2.Find(var_2_5, "Desk/nextBtn")
	arg_2_0.slots = {}

	for iter_2_0 = 1, arg_2_0.MEDAL_COUNT do
		local var_2_6 = arg_2_0.slots
		local var_2_7 = {}
		local var_2_8 = arg_2_0._tf

		var_2_7.slot = var_8.Find(var_2_8, "Desk/Slot" .. iter_2_0)

		local var_2_9 = arg_2_0._tf

		var_2_7.active = var_8.Find(var_2_9, "Desk/Slot" .. iter_2_0 .. "/active")

		local var_2_10 = arg_2_0._tf

		var_2_7.tips = var_8.Find(var_2_10, "Desk/Slot" .. iter_2_0 .. "/reddot")

		local var_2_11 = arg_2_0._tf

		var_2_7.click = var_8.Find(var_2_11, "Desk/Slot" .. iter_2_0 .. "/Click")
		var_2_6[iter_2_0] = var_2_7
	end

	local var_2_12 = arg_2_0._tf

	arg_2_0.medalLock = var_2.Find(var_2_12, "Desk/medal")

	local var_2_13 = arg_2_0._tf

	arg_2_0.trophyLock = var_2.Find(var_2_13, "Desk/trophy")
	DreamTourMedalDetailPanel = var_2

	local var_2_14 = var_2.New
	local var_2_15 = arg_2_0._tf

	arg_2_0.medalDetailView = var_2_14(var_4.Find(var_2_15, "DetailView"), arg_2_0)

	local var_2_16 = arg_2_0.medalDetailView

	var_2.SetIconScale(var_2_16, arg_2_0.ICON_SCALE)

	FujinBayMedalTaskPanel = var_2

	local var_2_17 = var_2.New
	local var_2_18 = arg_2_0._tf

	arg_2_0.medalTaskView = var_2_17(var_4.Find(var_2_18, "TaskView"), arg_2_0)

	return
end

return var_0_1
