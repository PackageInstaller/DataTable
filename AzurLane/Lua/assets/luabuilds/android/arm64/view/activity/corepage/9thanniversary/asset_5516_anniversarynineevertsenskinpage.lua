class = var_0_10000

local var_0_0 = "AnniversaryNineEvertsenSkinPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.9thAnniversary.AnniversaryNineHwahJahSkinPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "bg")

	local var_1_1 = arg_1_0.bg

	arg_1_0.dayTF = var_1.Find(var_1_1, "total_progress/day")

	local var_1_2 = arg_1_0.bg

	arg_1_0.maxDayTF = var_1.Find(var_1_2, "total_progress/max_day")

	local var_1_3 = arg_1_0.bg

	arg_1_0.item = var_1.Find(var_1_3, "item")

	local var_1_4 = arg_1_0.bg

	arg_1_0.items = var_1.Find(var_1_4, "items")
	UIItemList = var_1
	arg_1_0.uilist = var_1.New(arg_1_0.items, arg_1_0.item)

	local var_1_5 = arg_1_0.bg

	arg_1_0.btnDetail = var_1.Find(var_1_5, "btn_detail")

	local var_1_6 = arg_1_0.btnDetail

	arg_1_0.txtDetail = var_1.Find(var_1_6, "detail")

	local var_1_7 = arg_1_0.bg

	arg_1_0.btnStory = var_1.Find(var_1_7, "btn_story")
	AnniversaryNineEvertsenTaskWindow = var_1
	arg_1_0.taskWindow = var_1.New(arg_1_0._tf, arg_1_0.event)
	setActive = var_1

	var_1(arg_1_0.item, false)

	local var_1_8 = arg_1_0.bg

	arg_1_0.progressLabel = var_1.Find(var_1_8, "total_progress/label_1")
	setText = var_1

	local var_1_9 = arg_1_0.progressLabel

	i18n = var_4

	var_1(var_1_9, var_4("Outpost_20250904_Progress"))

	setText = var_1

	local var_1_10 = arg_1_0.txtDetail

	i18n = var_4

	var_1(var_1_10, var_4("Outpost_20260514_Detail"))

	return
end

return var_0_1
