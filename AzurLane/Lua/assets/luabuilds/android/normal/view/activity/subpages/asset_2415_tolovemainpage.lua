class = var_0_10000

local var_0_0 = "ToLoveMainPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.PreviewTemplatePage"))

var_0_1.CHARIMG_NUM = 6

function var_0_1.OnInit(arg_1_0)
	arg_1_0.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.charImg = var_1.Find(var_1_0, "character/Image")

	local var_1_1 = arg_1_0.bg

	arg_1_0.skinShop = var_1.Find(var_1_1, "btn_list/skinshop")

	local var_1_2 = arg_1_0.bg

	arg_1_0.build = var_1.Find(var_1_2, "btn_list/build")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	local var_2_0 = arg_2_0.activity

	arg_2_0.buildLinkId = var_1.getConfig(var_2_0, "config_client").build_linkId

	local var_2_1 = arg_2_0.activity

	arg_2_0.skinLinkId = var_1.getConfig(var_2_1, "config_client").skin_linkId

	arg_2_0:initBtn()

	local var_2_2 = arg_2_0.btnFuncList

	function var_2_2.activity(arg_3_0)
		onButton = var_2_10001

		var_2_10001(arg_2_0, arg_3_0, function()
			local var_4_0 = arg_2_0
			local var_4_1 = var_0.emit

			ActivityMediator = var_3_10002

			local var_4_2 = var_3_10002.EVENT_GO_SCENE

			SCENE = var_3_10003

			var_4_1(var_4_0, var_4_2, var_3_10003.TOLOVE_COLLAB_BACKHILL)

			return
		end)

		return
	end

	eachChild = var_2_2

	var_2_2(arg_2_0.btnList, function(arg_5_0)
		arg_2_0.btnFuncList[arg_5_0.name](arg_5_0)

		return
	end)

	getProxy = var_2_2
	ActivityProxy = var_2

	local var_2_3 = var_2_2(var_2)

	if var_1.getActivityById(var_2_3, arg_2_0.buildLinkId) then
		local var_2_4 = var_1

		if var_1.isEnd(var_2_4) then
			setActive = var_2_3

			local var_2_5 = arg_2_0.build

			var_2_3(var_2_4.Find(var_2_5, "time"), false)
		else
			var_2_3 = var_1.stopTime
			pg = var_2_4

			local var_2_6 = var_2_4.TimeMgr.GetInstance()

			var_2_3 = var_2_3 - var_3.GetServerTime(var_2_6)
			setActive = var_3

			local var_2_7 = arg_2_0.build

			var_3(var_4.Find(var_2_7, "time"), var_2_3 < 0)

			setText = var_3

			local var_2_8 = arg_2_0.build
			local var_2_9 = var_4.Find(var_2_8, "time/Text")

			i18n = var_2_8

			var_3(var_2_9, var_2_8("tolovemainpage_build_countdown"))
		end

		pg = var_2_3

		local var_2_10 = var_2_3.shop_template[arg_2_0.skinLinkId].time

		pg = var_3

		local var_2_11 = var_3.TimeMgr.GetInstance()
		local var_2_12, var_2_13 = var_3.inTime(var_2_11, var_2_10)
		local var_2_15

		if var_2_12 then
			pg = var_2_15

			local var_2_14 = var_2_15.TimeMgr.GetInstance()

			var_2_15 = var_2_15.Table2ServerTime(var_2_14, var_2_13)
			pg = var_2_14

			local var_2_16 = var_2_14.TimeMgr.GetInstance()
			local var_2_17 = var_2_15 - var_6.GetServerTime(var_2_16)

			setActive = var_2_16

			local var_2_18 = arg_2_0.skinShop

			var_2_16(var_8.Find(var_2_18, "time"), var_2_17 < 0)

			setText = var_2_16

			local var_2_19 = arg_2_0.skinShop
			local var_2_20 = var_8.Find(var_2_19, "time/Text")

			i18n = var_2_19

			local var_2_21 = "tolovemainpage_skin_countdown"

			math = var_1_10011

			var_2_16(var_2_20, var_2_19(var_2_21, var_1_10011.floor(var_2_17 / 16)))
		else
			setActive = var_2_15

			var_2_15(arg_2_0.skinShop, false)
		end

		math = var_2_15

		local var_2_22 = var_2_15.random(1, var_0_1.CHARIMG_NUM)

		GetImageSpriteFromAtlasAsync = var_6

		var_6("ui/activityuipage/tolovemainpage_atlas", "character_" .. var_2_22, arg_2_0.charImg)

		return
	end
end

return var_0_1
