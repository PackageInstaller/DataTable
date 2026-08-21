local var_0_0 = class("AnniversaryNineEvertsenSkinPage", import("view.activity.CorePage.9thAnniversary.AnniversaryNineHwahJahSkinPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("bg")
	arg_1_0.dayTF = arg_1_0.bg:Find("total_progress/day")
	arg_1_0.maxDayTF = arg_1_0.bg:Find("total_progress/max_day")
	arg_1_0.item = arg_1_0.bg:Find("item")
	arg_1_0.items = arg_1_0.bg:Find("items")
	arg_1_0.uilist = UIItemList.New(arg_1_0.items, arg_1_0.item)
	arg_1_0.btnDetail = arg_1_0.bg:Find("btn_detail")
	arg_1_0.txtDetail = arg_1_0.btnDetail:Find("detail")
	arg_1_0.btnStory = arg_1_0.bg:Find("btn_story")
	arg_1_0.taskWindow = AnniversaryNineEvertsenTaskWindow.New(arg_1_0._tf, arg_1_0.event)

	setActive(arg_1_0.item, false)

	arg_1_0.progressLabel = arg_1_0.bg:Find("total_progress/label_1")

	setText(arg_1_0.progressLabel, i18n("Outpost_20250904_Progress"))
	setText(arg_1_0.txtDetail, i18n("Outpost_20260514_Detail"))

	return
end

return var_0_0
