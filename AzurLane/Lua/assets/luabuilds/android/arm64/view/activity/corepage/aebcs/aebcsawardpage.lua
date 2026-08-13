class = var_0_10000

local var_0_0 = "AEBCSAwardPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.BRS.HeiYanAwardPage"))

function var_0_1.InitData(arg_1_0)
	ipairs = var_1_10001

	for iter_1_0, iter_1_1 in var_1_10001(arg_1_0.table_Top) do
		onToggle = var_1_10006

		local var_1_0 = arg_1_0
		local var_1_1 = iter_1_1

		local function var_1_2(arg_2_0)
			if arg_2_0 then
				local var_2_0 = arg_1_0

				var_2_0.pageIndex = iter_1_0
				SetActive = var_2_0

				var_2_0(arg_1_0.bg_1, iter_1_0 == 1)

				SetActive = var_2_0

				var_2_0(arg_1_0.bg_2, iter_1_0 ~= 1)

				local var_2_1 = arg_1_0

				var_1.OnAnimation(var_2_1, iter_1_0)

				local var_2_2 = arg_1_0

				var_1.DataList(var_2_2, iter_1_0)
			end

			return
		end

		SFX_PANEL = var_1_10011

		var_1_10006(var_1_0, var_1_1, var_1_2, var_1_10011)
	end

	return
end

function var_0_1.OnAnimation(arg_3_0, arg_3_1)
	if arg_3_1 ~= 1 then
		local var_3_0 = arg_3_0.bg_2
		local var_3_1 = var_2.GetComponent

		typeof = var_1_10005
		Animation = var_1_10007

		local var_3_2 = var_3_1(var_3_0, var_1_10005(var_1_10007))

		var_2.Play(var_3_2, "AEBCSAwardPage_list_in")
	end

	return
end

function var_0_1.OnUpdateItem(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.showDataList[arg_4_1 + 1]
	local var_4_1 = arg_4_2:Find("icon_mask/icon")
	local var_4_2 = {
		type = var_4_0.config.type,
		id = var_4_0.config.drop_id
	}

	updateDrop = var_6

	var_6(var_4_1, var_4_2)

	onButton = var_6

	local var_4_3 = arg_4_0
	local var_4_4 = var_4_1

	local function var_4_5()
		local var_5_0 = {}

		MSGBOX_TYPE_LIKN_COLLECT_GUIDE = var_2_10001
		var_5_0.type = var_2_10001
		Msgbox4LinkCollectGuide = var_2_10001
		var_5_0.show_type = var_2_10001.SHOW_TYPE_LIMIT
		var_5_0.drop_type = var_4_0.config.type
		var_5_0.drop_id = var_4_0.config.drop_id
		var_5_0.count = var_4_0.count
		var_5_0.count_limit = var_4_0.config.count
		var_5_0.skipable_list = var_4_0.config.link_params

		local var_5_1 = arg_4_0

		var_1.selectBoxbg(var_5_1, var_5_0)

		local var_5_2 = arg_4_0

		var_1.updateBoxPanel(var_5_2, var_5_0)

		local var_5_3 = arg_4_0

		var_1.showBoxPanel(var_5_3, true)

		return
	end

	SFX_PANEL = var_1_10011

	var_6(var_4_3, var_4_4, var_4_5, var_1_10011)
	arg_4_0.super.OnUpdateItem(arg_4_0, arg_4_1, arg_4_2)

	return
end

function var_0_1.UpdateView(arg_6_0)
	for iter_6_0 = 1, #arg_6_0.table_Top do
		setText = var_1_10005

		local var_6_0 = arg_6_0.table_Top[iter_6_0]

		var_1_10005(var_7.Find(var_6_0, "Label"), arg_6_0:OnGetCount(iter_6_0) .. "/" .. arg_6_0:OnCount(iter_6_0))

		setText = var_1_10005

		local var_6_1 = arg_6_0.table_Top[iter_6_0]
		local var_6_2 = var_7.Find(var_6_1, "type_image/name")

		i18n = var_8

		var_1_10005(var_6_2, var_8("danmachi_award_" .. iter_6_0))
	end

	triggerToggle = var_1

	local var_6_3 = arg_6_0.table_Top
	local var_6_4

	if not arg_6_0.pageIndex then
		var_6_4 = 1
	end

	var_1(var_6_3[var_6_4], true)

	return
end

function var_0_1.selectBoxbg(arg_7_0, arg_7_1)
	table = var_1_10002

	if var_1_10002.getCount(arg_7_1.skipable_list) > 1 then
		setImageSprite = var_2

		local var_7_0 = arg_7_0.boxTF
		local var_7_1 = var_4.Find(var_7_0, "Panel/BG")

		LoadSprite = var_1_10005

		var_2(var_7_1, var_1_10005("ui/AEBCSAwardPage_atlas", "box_bg1"), true)
	else
		table = var_2

		if var_2.getCount(arg_7_1.skipable_list) == 1 then
			setImageSprite = var_2

			local var_7_2 = arg_7_0.boxTF
			local var_7_3 = var_4.Find(var_7_2, "Panel/BG")

			LoadSprite = var_1_10005

			var_2(var_7_3, var_1_10005("ui/AEBCSAwardPage_atlas", "box_bg2"), true)
		end
	end

	return
end

function var_0_1.RefreshCountText(arg_8_0, arg_8_1, arg_8_2)
	setText = var_1_10003

	var_1_10003(arg_8_2:Find("owner/number"), arg_8_1.count .. "/" .. arg_8_1.config.count)

	return
end

function var_0_1.showBoxPanel(arg_9_0, arg_9_1)
	setActive = var_1_10002

	var_1_10002(arg_9_0.boxTF, arg_9_1)

	if arg_9_1 == true then
		pg = var_1_10002

		local var_9_0 = var_1_10002.UIMgr.GetInstance()

		var_1_10002.BlurPanel(var_9_0, arg_9_0.boxTF)
	else
		pg = var_1_10002

		local var_9_1 = var_1_10002.UIMgr.GetInstance()

		var_2.UnOverlayPanel(var_9_1, arg_9_0.boxTF, arg_9_0._tf)
	end

	return
end

function var_0_1.OnDestroy(arg_10_0)
	arg_10_0:showBoxPanel(false)

	return
end

return var_0_1
