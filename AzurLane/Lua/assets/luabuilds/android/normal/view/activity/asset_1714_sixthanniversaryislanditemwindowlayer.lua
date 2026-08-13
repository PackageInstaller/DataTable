class = var_0_10000

local var_0_0 = "SixthAnniversaryIslandItemWindowLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "SixthAnniversaryIslandItemWindow"
end

function var_0_1.init(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_2_0, arg_2_0._tf)

	setText = var_1

	local var_2_1 = arg_2_0._tf

	var_1(var_2.Find(var_2_1, "content/bottom/Text"), arg_2_0.contextData.text)

	onButton = var_1

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_3.Find(var_2_3, "bg")

	local function var_2_5()
		local var_3_0 = arg_2_0

		var_0.closeView(var_3_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_2_2, var_2_4, var_2_5, var_5)

	return
end

function var_0_1.didEnter(arg_4_0)
	local var_4_0 = arg_4_0.contextData.drop
	local var_4_1 = arg_4_0._tf
	local var_4_2 = var_2.Find(var_4_1, "content/main")
	local var_4_3

	if not var_4_0.count or not {
		var_4_0.count,
		true
	} then
		var_4_3 = {
			var_4_0:getOwnedCount()
		}
	end

	unpack = var_4

	local var_4_4, var_4_5 = var_4(var_4_3)

	setActive = var_1_10006

	var_1_10006(var_4_2:Find("owner"), var_4_5)

	if var_4_5 then
		setText = var_1_10006

		local var_4_6 = var_4_2
		local var_4_7 = var_4_2.Find(var_4_6, "owner")

		i18n = var_4_6

		var_1_10006(var_4_7, var_4_6("word_own1") .. var_4_4)
	end

	var_4_0.count = nil
	updateDrop = var_6

	var_6(var_4_2:Find("icon/IconTpl"), var_4_0)

	setText = var_6

	var_6(var_4_2:Find("line/name"), var_4_0:getConfig("name"))

	setText = var_6

	local var_4_8 = var_4_2:Find("line/content/Text")
	local var_4_9

	if not var_4_0.desc then
		var_4_9 = var_4_0:getConfig("desc")
	end

	var_6(var_4_8, var_4_9)

	return
end

function var_0_1.willExit(arg_5_0)
	pg = var_1_10001

	local var_5_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_5_0, arg_5_0._tf)

	return
end

return var_0_1
