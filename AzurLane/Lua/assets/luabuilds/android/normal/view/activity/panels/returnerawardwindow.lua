class = var_0_10000

local var_0_0 = "ReturnerAwardWindow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".PtAwardWindow"))

local function var_0_2(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = arg_1_0.UIlist

	var_4.make(var_1_0, function(arg_2_0, arg_2_1, arg_2_2)
		UIItemList = var_2_10003

		if arg_2_0 == var_2_10003.EventUpdate then
			local var_2_0 = arg_1_1[arg_2_1 + 1]
			local var_2_1 = arg_1_2[arg_2_1 + 1]
			local var_2_2 = arg_1_0

			string = var_2_10006
			var_2_2.resTitle = var_2_10006.gsub(arg_1_0.resTitle, "：", "")
			setText = var_2_2

			var_2_2(arg_2_2:Find("title/Text"), "PHASE " .. arg_2_1 + 1)

			setText = var_2_2

			var_2_2(arg_2_2:Find("target/Text"), var_2_1)

			setText = var_2_2

			var_2_2(arg_2_2:Find("target/title"), arg_1_0.resTitle)

			local var_2_3 = {
				type = var_2_0[1],
				id = var_2_0[2],
				count = var_2_0[3]
			}

			updateDrop = var_6

			var_6(arg_2_2:Find("award"), var_2_3, {
				hideName = true
			})

			onButton = var_6

			local var_2_4 = arg_1_0.binder
			local var_2_5 = arg_2_2:Find("award")

			local function var_2_6()
				local var_3_0 = arg_1_0.binder
				local var_3_1 = var_0.emit

				BaseUI = var_3_10002

				var_3_1(var_3_0, var_3_10002.ON_DROP, var_2_3)

				return
			end

			SFX_PANEL = var_10

			var_6(var_2_4, var_2_5, var_2_6, var_10)

			setActive = var_6

			local var_2_7 = arg_2_2
			local var_2_8 = arg_2_2.Find(var_2_7, "award/mask")

			table = var_2_7

			var_6(var_2_8, var_2_7.contains(arg_1_3, var_2_1))

			if arg_2_2:Find("target/icon") and arg_1_0.resIcon and arg_1_0.resIcon ~= "" then
				setActive = var_6

				var_6(arg_2_2:Find("target/icon"), true)

				LoadImageSpriteAsync = var_6

				var_6(arg_1_0.resIcon, arg_2_2:Find("target/icon"), false)
			else
				setActive = var_6

				var_6(arg_2_2:Find("target/icon"), false)
			end
		end

		return
	end)

	local var_1_1 = arg_1_0.UIlist

	var_4.align(var_1_1, #arg_1_1)

	return
end

function var_0_1.Show(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.dropList
	local var_4_1 = arg_4_1.targets
	local var_4_2 = arg_4_1.fetchList
	local var_4_3 = arg_4_1.count
	local var_4_4 = arg_4_1.resId

	arg_4_0.blur = arg_4_1.blur
	Drop = var_7

	local var_4_5 = var_7.New
	local var_4_6 = {}

	DROP_TYPE_RESOURCE = var_1_10009
	var_4_6.type = var_1_10009
	var_4_6.id = var_4_4

	local var_4_7 = var_4_5(var_4_6)
	local var_4_8 = var_7.getName(var_4_7)

	i18n = var_4_7

	local var_4_9 = var_4_7("pt_count", var_4_8)

	i18n = var_9
	arg_4_0.cntTitle = var_9("pt_total_count", var_4_8)
	arg_4_0.resTitle = var_4_9
	string = var_4_9
	arg_4_0.cntTitle = var_4_9.gsub(arg_4_0.cntTitle, "：", "")

	arg_4_0:updateResIcon(arg_4_1.resId, arg_4_1.resIcon, arg_4_1.type)
	var_0_2(arg_4_0, var_4_0, var_4_1, var_4_2)

	arg_4_0.totalTxt.text = var_4_3

	local var_4_10 = arg_4_0.totalTitleTxt

	var_4_10.text = arg_4_0.cntTitle
	setActive = var_4_10

	var_4_10(arg_4_0._tf, true)

	if arg_4_0.blur then
		pg = var_8

		local var_4_11 = var_8.UIMgr.GetInstance()

		var_8.BlurPanel(var_4_11, arg_4_0._tf)
	end

	return
end

return var_0_1
