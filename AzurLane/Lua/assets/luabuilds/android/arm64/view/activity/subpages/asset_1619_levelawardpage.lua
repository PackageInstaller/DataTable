class = var_0_10000

local var_0_0 = "LevelAwardPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "bg")

	local var_1_1 = arg_1_0._tf

	arg_1_0.award = var_1.Find(var_1_1, "scroll/award")

	local var_1_2 = arg_1_0._tf

	arg_1_0.content = var_1.Find(var_1_2, "scroll/content")

	local var_1_3 = arg_1_0._tf

	arg_1_0.scrollTF = var_1.Find(var_1_3, "scroll")

	local var_1_4 = arg_1_0._tf

	arg_1_0.pageSignDownTF = var_1.Find(var_1_4, "sign")

	local var_1_5 = arg_1_0._tf

	arg_1_0.pageSignUpTF = var_1.Find(var_1_5, "sign_up")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.activity_level_award
	local var_2_1 = arg_2_0.activity

	arg_2_0.config = var_2_0[var_2.getConfig(var_2_1, "config_id")]

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	setActive = var_1_10001

	var_1_10001(arg_3_0.award, false)

	for iter_3_0 = 1, #arg_3_0.config.front_drops do
		local var_3_0 = arg_3_0.config.front_drops[iter_3_0][1]

		cloneTplTo = var_1_10007

		local var_3_1 = arg_3_0.award
		local var_3_2 = arg_3_0.content
		local var_3_3 = "award"

		tostring = var_1_10012

		local var_3_4 = var_1_10007(var_3_1, var_3_2, var_3_3 .. var_1_10012(iter_3_0))
		local var_3_5 = var_1_10007.Find(var_3_4, "limit_label/labelLevel")
		local var_3_6 = var_1_10007:Find("btnAchieve")

		var_1_10012 = var_1_10007

		local var_3_7 = var_1_10007.Find(var_1_10012, "items")
		local var_3_8 = var_1_10007:Find("item")

		setActive = var_1_10012

		var_1_10012(var_3_8, false)

		GetImageSpriteFromAtlasAsync = var_1_10012

		local var_3_9 = "ui/activityuipage/level_award_atlas"

		tostring = var_15

		var_1_10012(var_3_9, var_15(var_3_0), var_3_5, true)

		for iter_3_1 = 2, #var_5 do
			cloneTplTo = var_3_10

			local var_3_10 = var_3_10(var_3_8, var_3_7)
			local var_3_11 = var_5[iter_3_1]
			local var_3_12 = {
				type = var_3_11[1],
				id = var_3_11[2],
				count = var_3_11[3]
			}

			updateDrop = var_19

			var_19(var_3_10, var_3_12)

			onButton = var_19

			local var_3_13 = arg_3_0
			local var_3_14 = var_3_10

			local function var_3_15()
				local var_4_0 = arg_3_0
				local var_4_1 = var_0.emit

				BaseUI = var_2_10003

				var_4_1(var_4_0, var_2_10003.ON_DROP, var_3_12)

				return
			end

			SFX_PANEL = var_1_10024

			var_19(var_3_13, var_3_14, var_3_15, var_1_10024)
		end

		onButton = var_1_10012

		local var_3_16 = arg_3_0
		local var_3_17 = var_3_6

		local function var_3_18()
			local var_5_0 = arg_3_0
			local var_5_1 = var_0.emit

			ActivityMediator = var_2_10003

			var_5_1(var_5_0, var_2_10003.EVENT_OPERATION, {
				cmd = 1,
				activity_id = arg_3_0.activity.id,
				arg1 = var_3_0
			})

			return
		end

		SFX_PANEL = var_3_11

		var_1_10012(var_3_16, var_3_17, var_3_18, var_3_11)

		onScroll = var_1_10012

		var_1_10012(arg_3_0, arg_3_0.scrollTF, function(arg_6_0)
			setActive = var_2_10001

			var_2_10001(arg_3_0.pageSignDownTF, arg_6_0.y > 0.01)

			setActive = var_2_10001

			var_2_10001(arg_3_0.pageSignUpTF, arg_6_0.y < 0.99)

			return
		end)
	end

	return
end

function var_0_1.OnUpdateFlush(arg_7_0)
	for iter_7_0 = 1, #arg_7_0.config.front_drops do
		local var_7_0 = arg_7_0.config.front_drops[iter_7_0]
		local var_7_1 = arg_7_0.content
		local var_7_2 = var_6.Find
		local var_7_3 = "award"

		tostring = var_1_10010

		local var_7_4 = var_7_2(var_7_1, var_7_3 .. var_1_10010(iter_7_0))
		local var_7_5 = var_6.Find(var_7_4, "btnAchieve")

		var_1_10010 = var_6

		local var_7_6 = var_6.Find(var_1_10010, "achieve_sign")

		_ = var_7_4

		if var_7_4.include(arg_7_0.activity.data1_list, var_7_0[1]) then
			local var_7_7 = var_6.transform

			var_1_10010.SetAsLastSibling(var_7_7)
		end

		setGray = var_1_10010

		var_1_10010(var_6:Find("limit_label"), var_9)

		setGray = var_1_10010

		var_1_10010(var_6:Find("items"), var_9)

		setActive = var_1_10010

		var_1_10010(var_7_6, var_9)

		setActive = var_1_10010

		var_1_10010(var_7_5, arg_7_0.shareData.player.level >= var_7_0[1] and not var_9)
	end

	return
end

function var_0_1.OnDestroy(arg_8_0)
	return
end

return var_0_1
