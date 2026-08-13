class = var_0_10000

local var_0_0 = "SecondSummaryPage4"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".SummaryAnimationPage"))

var_0_1.PerPageCount = 6
var_0_1.PageTypeFurniture = 1
var_0_1.PageTypeIconFrame = 2

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0.summaryInfoVO.pageType

	setActive = var_1_10002

	local var_1_1 = arg_1_0._tf

	var_1_10002(var_3.Find(var_1_1, "tip"), var_1_0 == var_0_1.PageTypeFurniture)

	setActive = var_1_10002

	local var_1_2 = arg_1_0._tf

	var_1_10002(var_3.Find(var_1_2, "tip_2"), var_1_0 == var_0_1.PageTypeIconFrame)

	local var_1_3

	if var_1_0 == var_0_1.PageTypeFurniture then
		var_1_3 = arg_1_0.summaryInfoVO.medalList
	elseif var_1_0 == var_0_1.PageTypeIconFrame then
		var_1_3 = arg_1_0.summaryInfoVO.iconFrameList
	else
		assert = var_3

		var_3(false, "page type error")
	end

	local var_1_4 = {}
	local var_1_5 = var_0_1.PerPageCount * (arg_1_0.summaryInfoVO.samePage - 1) + 1

	math = var_1_10006

	for iter_1_0 = var_1_5, var_1_10006.min(var_4 + var_0_1.PerPageCount - 1, #var_1_3) do
		table = var_1_10009

		var_1_10009.insert(var_1_4, var_1_3[iter_1_0])
	end

	getProxy = var_1_5
	AttireProxy = var_6

	local var_1_6 = var_1_5(var_6)

	UIItemList = var_6

	local var_1_7 = var_6.New
	local var_1_8 = arg_1_0._tf
	local var_1_9 = var_7.Find(var_1_8, "scroll_rect/content")
	local var_1_10 = arg_1_0._tf
	local var_1_11 = var_1_7(var_1_9, var_8.Find(var_1_10, "scroll_rect/content/item_tpl"))

	var_6.make(var_1_11, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_2_1 + 1

		UIItemList = var_2_10004

		if arg_2_0 == var_2_10004.EventUpdate then
			setActive = var_4

			var_4(arg_2_2:Find("icon/Image"), var_1_0 == var_0_1.PageTypeFurniture)

			setActive = var_4

			var_4(arg_2_2:Find("icon/frame"), var_1_0 == var_0_1.PageTypeIconFrame)

			setActive = var_4

			var_4(arg_2_2:Find("date"), var_1_0 == var_0_1.PageTypeFurniture)

			setText = var_4

			local var_2_1 = arg_2_2
			local var_2_2 = arg_2_2.Find(var_2_1, "date")

			i18n = var_2_1

			var_4(var_2_2, var_2_1("player_summary_data"))

			setText = var_4

			local var_2_3 = arg_2_2
			local var_2_4 = arg_2_2.Find(var_2_3, "from")

			i18n = var_2_3

			var_4(var_2_4, var_2_3("player_summary_from"))

			if arg_1_0.summaryInfoVO.pageType == var_0_1.PageTypeFurniture then
				local var_2_5 = var_1_4[var_2_0]
				local var_2_6 = arg_1_0.summaryInfoVO.furnitures[var_2_5]

				pg = var_6

				local var_2_7 = var_6.furniture_data_template[var_2_5]

				GetImageSpriteFromAtlasAsync = var_7

				var_7("furnitureicon/" .. var_2_7.icon, "", arg_2_2:Find("icon/Image"), true)

				setText = var_7

				var_7(arg_2_2:Find("controll/name/Text"), var_2_7.name)

				setText = var_7

				var_7(arg_2_2:Find("from/Text"), var_2_7.gain_by)

				setText = var_7

				local var_2_8 = arg_2_2

				var_2_10008 = arg_2_2.Find(var_2_8, "date/Text")

				if not var_2_6 or not var_2_6:getDate() then
					i18n = var_2_8
					var_2_8 = var_2_8("summary_page_un_rearch")
				end

				var_7(var_2_10008, var_2_8)
			else
				local var_2_9

				if arg_1_0.summaryInfoVO.pageType == var_0_1.PageTypeIconFrame then
					unpack = var_2_9

					local var_2_10

					var_2_9, var_2_10 = var_2_9(var_1_4[var_2_0])

					local var_2_11 = var_1_6
					local var_2_12 = var_6.getAttireFrame

					AttireConst = var_2_10008

					local var_2_13 = var_2_12(var_2_11, var_2_10008.TYPE_ICON_FRAME, var_2_9)

					setLocalScale = var_2_11

					local var_2_14 = arg_2_2
					local var_2_15 = arg_2_2.Find(var_2_14, "icon/frame")

					Vector3 = var_2_14

					var_2_11(var_2_15, var_2_14(var_2_10, var_2_10, var_2_10))

					PoolMgr = var_2_11

					local var_2_16 = var_2_11.GetInstance()

					var_7.GetPrefab(var_2_16, var_2_13:getIcon(), var_2_13:getConfig("id"), true, function(arg_3_0)
						setParent = var_3_10001

						local var_3_0 = arg_3_0
						local var_3_1 = arg_2_2

						var_3_10001(var_3_0, var_3.Find(var_3_1, "icon/frame"), false)

						return
					end)

					setText = var_7

					var_7(arg_2_2:Find("controll/name/Text"), var_2_13:getConfig("name"))

					setText = var_7

					var_7(arg_2_2:Find("from/Text"), var_2_13:getConfig("gain_by"))
				else
					assert = var_2_9

					var_2_9(false, "logic error")
				end
			end
		end

		return
	end)
	var_6:align(#var_1_4)

	return
end

return var_0_1
