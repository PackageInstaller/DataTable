class = var_0_10000

local var_0_0 = "LotteryLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

pg = var_0_0

local var_0_2 = var_0_0.activity_random_award_template
local var_0_3 = true

function var_0_1.getUIName(arg_1_0)
	if var_0_3 then
		return "LotteryForCHTUI"
	else
		return "LotteryUI"
	end

	return
end

function var_0_1.setPlayerVO(arg_2_0, arg_2_1)
	arg_2_0.playerVO = arg_2_1

	arg_2_0:updateResource()

	return
end

function var_0_1.updateResource(arg_3_0)
	local var_3_0 = arg_3_0.playerVO

	id2res = var_1_10002
	arg_3_0.resCount = var_3_0[var_1_10002(arg_3_0.resId)]
	setText = var_1

	local var_3_1 = arg_3_0.resource

	var_1(var_2.Find(var_3_1, "Text"), arg_3_0.resCount)

	return
end

function var_0_1.setActivity(arg_4_0, arg_4_1)
	arg_4_0.activityVO = arg_4_1

	local var_4_0 = arg_4_0.activityVO

	arg_4_0.resId = var_2.getConfig(var_4_0, "config_client").resId
	arg_4_0.awardInfos = arg_4_1:getAwardInfos()

	arg_4_0:initActivityPools()

	return
end

function var_0_1.initActivityPools(arg_5_0)
	arg_5_0.activityPools = {}

	local var_5_0 = arg_5_0.activityVO
	local var_5_1 = var_1.getConfig(var_5_0, "config_data")

	_ = var_5_0

	local var_5_2 = var_5_0.select(var_0_2.all, function(arg_6_0)
		table = var_2_10001

		return var_2_10001.contains(var_5_1, arg_6_0)
	end)
	local var_5_3

	ipairs = var_4

	for iter_5_0, iter_5_1 in var_4(var_5_2) do
		ActivityItemPool = var_1_10009
		var_1_10009 = var_1_10009.New({
			id = iter_5_1,
			awards = arg_5_0.awardInfos[iter_5_1],
			prevId = var_5_3,
			index = iter_5_0
		})
		var_5_3 = iter_5_1
		arg_5_0.activityPools[var_1_10009.id] = var_1_10009
	end

	local var_5_4

	if not arg_5_0.activityVO.data1 then
		var_5_4 = var_5_1[1]
	end

	arg_5_0.activityPool = arg_5_0.activityPools[var_5_4]

	return
end

function var_0_1.init(arg_7_0)
	local var_7_0 = arg_7_0._tf

	arg_7_0.lotteryPoolContainer = var_1.Find(var_7_0, "left_panel/pool_list/content")

	local var_7_1 = arg_7_0._tf

	arg_7_0.attrs = var_1.Find(var_7_1, "left_panel/pool_list/arrs")

	local var_7_2 = arg_7_0._tf

	arg_7_0.mainItenContainer = var_1.Find(var_7_2, "right_panel/main_item_list/content")

	local var_7_3 = arg_7_0.mainItenContainer

	arg_7_0.mainItenTpl = var_1.Find(var_7_3, "equipmenttpl")

	local var_7_4 = arg_7_0._tf

	arg_7_0.resource = var_1.Find(var_7_4, "left_panel/resource")

	local var_7_5 = arg_7_0._tf

	arg_7_0.launchOneBtn = var_1.Find(var_7_5, "left_panel/launch_one_btn")

	local var_7_6 = arg_7_0.launchOneBtn
	local var_7_7 = var_1.Find(var_7_6, "res/Text")
	local var_7_8 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_7_0.launchOneBtnTxt = var_7_8(var_7_7, var_3(var_1_10004))

	local var_7_9 = arg_7_0._tf

	arg_7_0.launchTenBtn = var_1.Find(var_7_9, "left_panel/launch_ten_btn")

	local var_7_10 = arg_7_0.launchTenBtn
	local var_7_11 = var_1.Find(var_7_10, "res/Text")
	local var_7_12 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_7_0.launchTenBtnTxt = var_7_12(var_7_11, var_3(var_1_10004))

	local var_7_13 = arg_7_0._tf

	arg_7_0.launchMaxBtn = var_1.Find(var_7_13, "left_panel/launch_max_btn")

	local var_7_14 = arg_7_0.launchMaxBtn
	local var_7_15 = var_1.Find(var_7_14, "res/Text")
	local var_7_16 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_7_0.launchMaxBtnTxt = var_7_16(var_7_15, var_3(var_1_10004))

	local var_7_17 = arg_7_0._tf
	local var_7_18 = var_1.Find(var_7_17, "right_panel/count_container/Text")
	local var_7_19 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_7_0.awardsCounttxt = var_7_19(var_7_18, var_3(var_1_10004))

	local var_7_20 = arg_7_0._tf
	local var_7_21 = var_1.Find(var_7_20, "right_panel")
	local var_7_22 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_7_0.bgTF = var_7_22(var_7_21, var_3(var_1_10004))

	local var_7_23 = arg_7_0._tf

	arg_7_0.descBtn = var_1.Find(var_7_23, "right_panel/desc_btn")

	local var_7_24 = arg_7_0._tf

	arg_7_0.bonusWindow = var_1.Find(var_7_24, "Msgbox")
	setActive = var_1

	var_1(arg_7_0.bonusWindow, false)

	local var_7_25 = arg_7_0._tf

	arg_7_0.topPanel = var_1.Find(var_7_25, "top")

	return
end

function var_0_1.didEnter(arg_8_0)
	onButton = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0._tf
	local var_8_2 = var_3.Find(var_8_1, "top/back_btn")

	local function var_8_3()
		local var_9_0 = arg_8_0

		var_0.emit(var_9_0, var_0_1.ON_CLOSE)

		return
	end

	SOUND_BACK = var_5

	var_1_10001(var_8_0, var_8_2, var_8_3, var_5)

	local var_8_4 = {
		arg_8_0.launchOneBtn,
		arg_8_0.launchTenBtn,
		arg_8_0.launchMaxBtn
	}
	local var_8_5 = {
		1,
		10,
		"max"
	}

	ipairs = var_8_2

	for iter_8_0, iter_8_1 in var_8_2(var_8_4) do
		GetImageSpriteFromAtlasAsync = var_1_10008
		Drop = var_1_10009
		var_1_10009 = var_1_10009.New

		local var_8_6 = {}

		DROP_TYPE_RESOURCE = var_1_10011
		var_8_6.type = var_1_10011
		var_8_6.id = arg_8_0.resId

		local var_8_7 = var_1_10009(var_8_6)

		var_1_10008(var_1_10009.getIcon(var_8_7), "", iter_8_1:Find("res/icon"), true)

		onButton = var_1_10008
		var_1_10009 = arg_8_0

		local var_8_8 = iter_8_1

		function var_1_10011()
			if not arg_8_0.activityPool then
				return
			end

			if arg_8_0.activityPool ~= arg_8_0.showActivityPool then
				pg = var_0

				local var_10_0 = var_0.TipsMgr.GetInstance()
				local var_10_1 = var_0.ShowTips

				i18n = var_2_10002

				var_10_1(var_10_0, var_2_10002("amercian_notice_5"))

				return
			end

			local var_10_2 = arg_8_0.activityPool

			if var_0.getleftItemCount(var_10_2) == 0 then
				pg = var_10_2

				local var_10_3 = var_10_2.TipsMgr.GetInstance()
				local var_10_4 = var_1.ShowTips

				i18n = var_2_10003

				var_10_4(var_10_3, var_2_10003("activity_pool_awards_empty"))

				return
			end

			local var_10_5 = arg_8_0.activityPool
			local var_10_6 = var_1.getComsume(var_10_5)
			local var_10_7, var_10_10

			if var_8_5[iter_8_0] == "max" then
				math = var_10_7
				var_10_7 = var_10_7.min

				local var_10_8 = var_10_10

				math = var_2_10004

				local var_10_9 = var_2_10004.max

				math = var_2_10005
				var_10_10 = var_10_7(var_10_8, var_10_9(var_2_10005.floor(arg_8_0.resCount / var_10_6.count), 1))
			else
				math = var_10_7
				var_10_10 = var_10_7.min(var_10_10, var_8_5[iter_8_0])
			end

			local var_10_11 = arg_8_0.activityPool

			if not var_2.enoughResForUsage(var_10_11, var_10_10) then
				pg = var_2

				local var_10_12 = var_2.TipsMgr.GetInstance()
				local var_10_13 = var_2.ShowTips

				i18n = var_4

				var_10_13(var_10_12, var_4("common_no_resource"))

				return
			end

			local function var_10_14()
				pg = var_3_10000

				local var_11_0 = var_3_10000.MsgboxMgr.GetInstance()
				local var_11_1 = var_0.ShowMsgBox
				local var_11_2 = {}

				i18n = var_3_10003
				var_11_2.content = var_3_10003("amercian_notice_1", var_10_10 * var_10_6.count, var_10_10)

				function var_11_2.onYes()
					local var_12_0 = arg_8_0
					local var_12_1 = var_0.emit

					LotteryMediator = var_4_10002

					var_12_1(var_12_0, var_4_10002.ON_LAUNCH, arg_8_0.activityVO.id, arg_8_0.activityPool.id, var_10_10, var_8_5[iter_8_0] == "max")

					return
				end

				var_11_1(var_11_0, var_11_2)

				return
			end

			local var_10_15 = arg_8_0.playerVO

			if not var_3.OilMax(var_10_15, 1) then
				local var_10_16 = arg_8_0.playerVO

				if var_3.GoldMax(var_10_16, 1) then
					pg = var_3

					local var_10_17 = var_3.MsgboxMgr.GetInstance()
					local var_10_18 = var_3.ShowMsgBox
					local var_10_19 = {}

					i18n = var_2_10006
					var_10_19.content = var_2_10006("amercian_notice_6")

					function var_10_19.onYes()
						var_10_14()

						return
					end

					var_10_18(var_10_17, var_10_19)
				else
					var_10_14()
				end

				return
			end
		end

		SFX_PANEL = var_12

		var_1_10008(var_1_10009, var_8_8, var_1_10011, var_12)
	end

	onButton = var_3

	local var_8_9 = arg_8_0
	local var_8_10 = arg_8_0.descBtn

	local function var_8_11()
		if not arg_8_0.showActivityPool then
			return
		end

		local var_14_0 = arg_8_0.showActivityPool
		local var_14_1, var_14_2 = var_0.getItems(var_14_0)
		local var_14_3 = arg_8_0

		var_2.showBonus(var_14_3, var_14_1, var_14_2)

		return
	end

	SFX_PANEL = iter_8_1

	var_3(var_8_9, var_8_10, var_8_11, iter_8_1)

	onButton = var_3

	local var_8_12 = arg_8_0
	local var_8_13 = arg_8_0.bonusWindow

	var_3(var_8_12, var_5.Find(var_8_13, "window/top/btnBack"), function()
		setActive = var_2_10000

		var_2_10000(arg_8_0.bonusWindow, false)

		return
	end)

	onButton = var_3

	local var_8_14 = arg_8_0
	local var_8_15 = arg_8_0.bonusWindow

	var_3(var_8_14, var_5.Find(var_8_15, "window/button"), function()
		setActive = var_2_10000

		var_2_10000(arg_8_0.bonusWindow, false)

		return
	end)

	onButton = var_3

	var_3(arg_8_0, arg_8_0.bonusWindow, function()
		setActive = var_2_10000

		var_2_10000(arg_8_0.bonusWindow, false)

		return
	end)

	arg_8_0.bgs = {}
	arg_8_0.attrTFs = {}

	local var_8_16 = 1

	table = var_4

	for iter_8_2 = var_8_16, var_4.getCount(arg_8_0.activityPools) do
		local var_8_17 = arg_8_0.attrs
		local var_8_18 = var_7.Find(var_8_17, "arr_" .. iter_8_2)

		IsNil = var_8_17

		if not var_8_17(var_8_18) then
			table = var_8

			var_8.insert(arg_8_0.attrTFs, var_8_18)
		end
	end

	arg_8_0:updateResource()
	arg_8_0:initPoolTFs()
	arg_8_0:updateActivityPoolState()

	triggerToggle = var_3

	var_3(arg_8_0.activityPoolTFs[arg_8_0.activityPool.id], true)

	return
end

function var_0_1.onActivityUpdated(arg_18_0, arg_18_1)
	arg_18_0:setActivity(arg_18_1)
	arg_18_0:updateActivityPoolState()
	arg_18_0:switchToPool(arg_18_1.data1)

	return
end

function var_0_1.initPoolTFs(arg_19_0)
	arg_19_0.activityPoolTFs = {}
	pairs = var_1

	for iter_19_0, iter_19_1 in var_1(arg_19_0.activityPools) do
		local var_19_0 = arg_19_0.lotteryPoolContainer
		local var_19_1 = var_6.GetChild(var_19_0, iter_19_1.index - 1)
		local var_19_2 = arg_19_0.activityPoolTFs

		var_19_2[iter_19_1.id] = var_19_1
		onToggle = var_19_2

		var_19_2(arg_19_0, var_19_1, function(arg_20_0)
			if arg_20_0 then
				if iter_19_1.prevId then
					local var_20_0 = arg_19_0.activityPools[iter_19_1.prevId]

					if var_1.canOpenNext(var_20_0) then
						local var_20_1 = arg_19_0
						local var_20_2 = var_1.emit

						LotteryMediator = var_2_10003

						var_20_2(var_20_1, var_2_10003.ON_SWITCH, arg_19_0.activityVO.id, iter_19_1.id)
					else
						local var_20_3 = arg_19_0

						var_1.switchToPool(var_20_3, iter_19_1.id)
					end

					return
				end
			end
		end)
	end

	return
end

function var_0_1.updateActivityPoolState(arg_21_0)
	pairs = var_1_10001

	for iter_21_0, iter_21_1 in var_1_10001(arg_21_0.activityPools) do
		local var_21_0 = arg_21_0.activityPoolTFs[iter_21_0]
		local var_21_1

		if iter_21_1.prevId then
			var_1_10008 = arg_21_0.activityPools[iter_21_1.prevId]
			var_21_1 = var_7.canOpenNext(var_1_10008)

			if false then
				var_21_1 = false
			end
		else
			var_21_1 = true
		end

		setActive = var_1_10008

		var_1_10008(var_21_0:Find("bg/unlock"), var_21_1)

		setActive = var_1_10008

		var_1_10008(var_21_0:Find("bg/lock"), not var_21_1)

		setActive = var_1_10008

		var_1_10008(var_21_0:Find("selected/unlock"), var_21_1)

		setActive = var_1_10008

		var_1_10008(var_21_0:Find("selected/lock"), not var_21_1)

		if var_0_3 then
			setActive = var_1_10008

			var_1_10008(var_21_0:Find("icon"), var_21_1)

			setActive = var_1_10008

			var_1_10008(var_21_0:Find("icon_g"), not var_21_1)
		end

		local var_21_2 = iter_21_1

		var_1_10008 = iter_21_1.getleftItemCount(var_21_2)
		setActive = var_21_2

		var_21_2(var_21_0:Find("finish"), var_1_10008 == 0)

		if arg_21_0.attrTFs[iter_21_1.index - 1] then
			triggerToggle = var_9

			var_9(arg_21_0.attrTFs[iter_21_1.index - 1], var_21_1)
		end
	end

	return
end

function var_0_1.switchToPool(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.activityPools[arg_22_1]
	local var_22_1 = arg_22_0.activityPoolTFs[arg_22_1]

	arg_22_0:updateMainItems(var_22_0)
	arg_22_0:updateAwardsFetchedCount(var_22_0)

	local var_22_2

	if not arg_22_0.bgs[arg_22_1] then
		if var_0_3 then
			LoadSprite = var_5
			var_22_2 = var_5("lotterybg/cht_" .. var_22_0.index)
		else
			LoadSprite = var_5
			var_22_2 = var_5("lotterybg/kr_re_" .. var_22_0.index)
		end

		arg_22_0.bgs[arg_22_1] = var_22_2
	end

	arg_22_0.bgTF.sprite = var_22_2

	local var_22_3 = var_22_0
	local var_22_4 = var_22_0.getComsume(var_22_3)

	math = var_22_3

	local var_22_5 = var_22_3.min(var_22_0:getleftItemCount(), 10)

	math = var_7

	local var_22_6 = var_7.min
	local var_22_7 = var_22_0
	local var_22_8 = var_22_0.getleftItemCount(var_22_7)

	math = var_22_7

	local var_22_9 = var_22_7.max

	math = var_1_10010

	local var_22_10 = var_22_6(var_22_8, var_22_9(var_1_10010.floor(arg_22_0.resCount / var_22_4.count), 1))

	arg_22_0.launchOneBtnTxt.text = var_22_4.count
	arg_22_0.launchTenBtnTxt.text = var_22_4.count * var_22_5
	arg_22_0.launchMaxBtnTxt.text = var_22_4.count * var_22_10
	arg_22_0.showActivityPool = arg_22_0.activityPools[var_22_0.id]

	return
end

function var_0_1.updateAwardsFetchedCount(arg_23_0, arg_23_1)
	if arg_23_0.awardsCounttxt then
		local var_23_0 = arg_23_1:getFetchCount()
		local var_23_1 = arg_23_1:getItemCount()
		local var_23_2 = arg_23_0.awardsCounttxt

		setColorStr = var_1_10005

		local var_23_3 = var_23_1 - var_23_0

		if var_23_0 < var_23_1 then
			COLOR_GREEN = var_1_10007

			if not var_1_10007 then
				COLOR_RED = var_1_10007
			end

			var_23_2.text = var_1_10005(var_23_3, var_1_10007) .. "/" .. var_23_1

			return
		end
	end
end

function var_0_1.updateMainItems(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_1:getMainItems()

	for iter_24_0 = arg_24_0.mainItenContainer.childCount, #var_24_0 do
		cloneTplTo = var_1_10008

		var_1_10008(arg_24_0.mainItenTpl, arg_24_0.mainItenContainer)
	end

	local var_24_1 = arg_24_0.mainItenContainer.childCount

	for iter_24_1 = 1, var_24_1 do
		local var_24_2 = arg_24_0.mainItenContainer
		local var_24_3 = var_8.GetChild(var_24_2, iter_24_1 - 1)
		local var_24_4 = iter_24_1 <= #var_24_0

		setActive = var_10

		var_10(var_24_3, var_24_4)

		if var_24_4 then
			local var_24_5 = var_24_0[iter_24_1]

			updateDrop = var_11

			var_11(var_24_3, var_24_5)

			setActive = var_11

			var_11(var_24_3:Find("mask"), var_24_5.surplus <= 0)

			setText = var_11

			local var_24_6 = var_24_3:Find("icon_bg/surplus")
			local var_24_7 = "X"
			local var_24_8

			if not var_24_5.surplus then
				var_24_8 = ""
			end

			var_11(var_24_6, var_24_7 .. var_24_8)

			onButton = var_11

			local var_24_9 = arg_24_0
			local var_24_10 = var_24_3

			local function var_24_11()
				local var_25_0 = arg_24_0

				var_0.emit(var_25_0, var_0_1.ON_DROP, var_24_5)

				return
			end

			SFX_PANEL = var_1_10015

			var_11(var_24_9, var_24_10, var_24_11, var_1_10015)
		end
	end

	return
end

function var_0_1.showBonus(arg_26_0, arg_26_1, arg_26_2)
	setActive = var_1_10003

	var_1_10003(arg_26_0.bonusWindow, true)

	arg_26_0.awardMain = arg_26_1
	arg_26_0.awardNormal = arg_26_2

	local var_26_0 = arg_26_0._tf

	arg_26_0.trDropTpl = var_3.Find(var_26_0, "Msgbox/window/items/scrollview/item")

	local var_26_1 = arg_26_0._tf

	arg_26_0.trDrops = var_3.Find(var_26_1, "Msgbox/window/items/scrollview/list/list_main")
	UIItemList = var_3
	arg_26_0.dropList = var_3.New(arg_26_0.trDrops, arg_26_0.trDropTpl)

	local var_26_2 = arg_26_0.dropList

	var_3.make(var_26_2, function(arg_27_0, arg_27_1, arg_27_2)
		local var_27_0 = arg_26_0

		var_3.updateDrop(var_27_0, arg_27_0, arg_27_1, arg_27_2, arg_26_0.awardMain)

		return
	end)

	local var_26_3 = arg_26_0.dropList

	var_3.align(var_26_3, #arg_26_0.awardMain)

	local var_26_4 = arg_26_0._tf

	arg_26_0.trDropsN = var_3.Find(var_26_4, "Msgbox/window/items/scrollview/list/list_normal")
	UIItemList = var_3
	arg_26_0.dropListN = var_3.New(arg_26_0.trDropsN, arg_26_0.trDropTpl)

	local var_26_5 = arg_26_0.dropListN

	var_3.make(var_26_5, function(arg_28_0, arg_28_1, arg_28_2)
		local var_28_0 = arg_26_0

		var_3.updateDrop(var_28_0, arg_28_0, arg_28_1, arg_28_2, arg_26_0.awardNormal)

		return
	end)

	local var_26_6 = arg_26_0.dropListN

	var_3.align(var_26_6, #arg_26_0.awardNormal)

	return
end

function var_0_1.updateDrop(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4)
	UIItemList = var_1_10005

	if arg_29_1 == var_1_10005.EventUpdate then
		local var_29_0 = arg_29_4[arg_29_2 + 1]

		updateDrop = var_1_10006

		var_1_10006(arg_29_3, var_29_0)

		setText = var_1_10006

		var_1_10006(arg_29_3:Find("count"), var_29_0.surplus .. "/" .. var_29_0.total)

		setActive = var_1_10006

		var_1_10006(arg_29_3:Find("mask"), var_29_0.surplus <= 0)

		setScrollText = var_1_10006
		findTF = var_7

		local var_29_1 = var_7(arg_29_3, "name_mask/name")
		local var_29_2

		if not var_29_0.name then
			var_29_2 = var_29_0:getConfig("name")
		end

		var_1_10006(var_29_1, var_29_2)
	end

	return
end

function var_0_1.willExit(arg_30_0)
	arg_30_0.bgs = nil

	return
end

return var_0_1
