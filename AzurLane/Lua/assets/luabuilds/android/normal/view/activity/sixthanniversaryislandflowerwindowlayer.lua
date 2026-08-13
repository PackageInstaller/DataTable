class = var_0_10000

local var_0_0 = "SixthAnniversaryIslandFlowerWindowLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "SixthAnniversaryIslandFlowerWindow"
end

function var_0_1.init(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_2_0, arg_2_0._tf)

	setText = var_1

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_2.Find(var_2_1, "content/title/Text")

	i18n = var_2_1

	var_1(var_2_2, var_2_1("islandnode_tips7", arg_2_0.contextData.name))

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "content/main/content")

	UIItemList = var_2_3
	arg_2_0.itemList = var_2_3.New(var_2_4, var_2_4:Find("icon"))

	local var_2_5 = arg_2_0.itemList

	var_2.make(var_2_5, function(arg_3_0, arg_3_1, arg_3_2)
		arg_3_1 = arg_3_1 + 1
		UIItemList = var_2_10003

		if arg_3_0 == var_2_10003.EventUpdate then
			updateDrop = var_3

			var_3(arg_3_2:Find("IconTpl"), arg_2_0.contextData.awards[arg_3_1])
		end

		return
	end)

	local var_2_6 = arg_2_0.itemList

	var_2.align(var_2_6, #arg_2_0.contextData.awards)

	onButton = var_2

	local var_2_7 = arg_2_0
	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_4.Find(var_2_8, "content/bottom/btn")

	local function var_2_10()
		local var_4_0 = arg_2_0

		var_0.closeView(var_4_0)

		return
	end

	SFX_CANCEL = var_6

	var_2(var_2_7, var_2_9, var_2_10, var_6)

	return
end

function var_0_1.didEnter(arg_5_0)
	return
end

function var_0_1.willExit(arg_6_0)
	pg = var_1_10001

	local var_6_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_6_0, arg_6_0._tf)

	return
end

return var_0_1
