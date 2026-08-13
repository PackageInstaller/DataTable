class = var_0_10000

local var_0_0 = "FurnitureSlideExtraLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "Dorm3dFurnitureSlideExtraUI"
end

function var_0_1.init(arg_2_0)
	ApartmentProxy = var_1_10001
	arg_2_0.slideList = var_1_10001.GetSlideInviteList()

	arg_2_0:InitUI()

	return
end

function var_0_1.InitUI(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.queuePanel = var_1.Find(var_3_0, "top")

	local var_3_1 = arg_3_0._tf

	arg_3_0.performancePanel = var_1.Find(var_3_1, "performance")

	local var_3_2 = arg_3_0._tf

	arg_3_0.queueContainer = var_1.Find(var_3_2, "top/bg/container")

	local var_3_3 = arg_3_0._tf

	arg_3_0.performanceContainer = var_1.Find(var_3_3, "performance/line/container")
	setText = var_1

	local var_3_4 = arg_3_0._tf
	local var_3_5 = var_2.Find(var_3_4, "top/bg/Text")

	i18n = var_3_4

	var_1(var_3_5, var_3_4("3ddorm_beach_slide_tip2"))

	setText = var_1

	local var_3_6 = arg_3_0._tf
	local var_3_7 = var_2.Find(var_3_6, "performance/btn_invite/Text")

	i18n = var_3_6

	var_1(var_3_7, var_3_6("3ddorm_beach_slide_tip1"))

	UIItemList = var_1

	local var_3_8 = var_1.New
	local var_3_9 = arg_3_0.queueContainer
	local var_3_10 = arg_3_0.queueContainer

	arg_3_0.queueItemList = var_3_8(var_3_9, var_3.Find(var_3_10, "tpl"))
	UIItemList = var_1

	local var_3_11 = var_1.New
	local var_3_12 = arg_3_0.performanceContainer
	local var_3_13 = arg_3_0.performanceContainer

	arg_3_0.performanceItemList = var_3_11(var_3_12, var_3.Find(var_3_13, "tpl"))

	local var_3_14 = arg_3_0.queueItemList

	var_1.make(var_3_14, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_4_1 + 1 > #arg_3_0.slideList

		setActive = var_2_10005

		var_2_10005(arg_4_2:Find("icon"), not var_4_0)

		setActive = var_2_10005

		var_2_10005(arg_4_2:Find("front"), not var_4_0)

		setActive = var_2_10005

		var_2_10005(arg_4_2:Find("plus"), var_4_0)

		if not var_4_0 then
			local var_4_1 = arg_3_0.slideList[var_3]

			pg = var_6

			local var_4_2 = var_6.dorm3d_resource.get_id_list_by_ship_group[var_4_1][2]

			GetImageSpriteFromAtlasAsync = var_7
			pg = var_8

			var_7(var_8.dorm3d_resource[var_4_2].head_Icon, "", arg_4_2:Find("icon"), true)
		end

		return
	end)

	local var_3_15 = arg_3_0.performanceItemList

	var_1.make(var_3_15, function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_5_1 + 1
		local var_5_1 = arg_3_0.slideList[var_5_0]

		UIItemList = var_2_10005

		if arg_5_0 == var_2_10005.EventUpdate then
			pg = var_5

			local var_5_2 = var_5.dorm3d_resource.get_id_list_by_ship_group[var_5_1][2]

			GetImageSpriteFromAtlasAsync = var_2_10006
			pg = var_2_10007

			var_2_10006(var_2_10007.dorm3d_resource[var_5_2].head_Icon, "", arg_5_2:Find("icon"), true)

			setText = var_2_10006

			local var_5_3 = arg_5_2
			local var_5_4 = arg_5_2.Find(var_5_3, "name")

			ShipGroup = var_5_3

			var_2_10006(var_5_4, var_5_3.getDefaultShipNameByGroupID(var_5_1))

			onButton = var_2_10006

			local var_5_5 = arg_3_0
			local var_5_6 = arg_5_2

			local function var_5_7()
				local var_6_0 = arg_3_0
				local var_6_1 = var_0.emit

				FurnitureSlideExtraMediator = var_3_10002

				var_6_1(var_6_0, var_3_10002.GO_SLIDE_PERFORMANCE, var_5_1)

				return
			end

			SFX_DORM_CLICK = var_10

			var_2_10006(var_5_5, var_5_6, var_5_7, var_10)
		end

		return
	end)

	onButton = var_1

	local var_3_16 = arg_3_0
	local var_3_17 = arg_3_0._tf
	local var_3_18 = var_3.Find(var_3_17, "top/bg")

	local function var_3_19()
		local var_7_0 = arg_3_0
		local var_7_1 = var_0.emit

		FurnitureSlideExtraMediator = var_2_10002

		var_7_1(var_7_0, var_2_10002.OPEN_INVITE_LAYER, arg_3_0.slideList)

		return
	end

	SFX_DORM_CLICK = var_5

	var_1(var_3_16, var_3_18, var_3_19, var_5)

	return
end

function var_0_1.didEnter(arg_8_0)
	arg_8_0:HideInteraction()
	arg_8_0:HidePerformance()

	return
end

function var_0_1.UpdateSlideInviteList(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0.slideList = arg_9_1

	arg_9_0:Flush()

	return
end

function var_0_1.Flush(arg_10_0)
	local var_10_0 = arg_10_0.queueItemList

	var_1.align(var_10_0, #arg_10_0.slideList + 1)

	local var_10_1 = arg_10_0.performanceItemList

	var_1.align(var_10_1, #arg_10_0.slideList)

	return
end

function var_0_1.HandleDormUIState(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1 == "base"

	setActive = var_1_10003

	var_1_10003(arg_11_0._tf, var_11_0)

	return
end

function var_0_1.ShowInteraction(arg_12_0)
	setActive = var_1_10001

	var_1_10001(arg_12_0.queuePanel, true)

	local var_12_0 = arg_12_0.queueItemList

	var_1.align(var_12_0, #arg_12_0.slideList + 1)

	return
end

function var_0_1.HideInteraction(arg_13_0)
	setActive = var_1_10001

	var_1_10001(arg_13_0.queuePanel, false)

	return
end

function var_0_1.ShowPerformance(arg_14_0)
	setActive = var_1_10001

	var_1_10001(arg_14_0.performancePanel, true)

	local var_14_0 = arg_14_0.performanceItemList

	var_1.align(var_14_0, #arg_14_0.slideList)

	return
end

function var_0_1.HidePerformance(arg_15_0)
	setActive = var_1_10001

	var_1_10001(arg_15_0.performancePanel, false)

	return
end

function var_0_1.willExit(arg_16_0)
	return
end

return var_0_1
