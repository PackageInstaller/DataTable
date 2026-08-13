class = var_0_10000

local var_0_0 = "EducatePolaroidLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".EducateCollectLayerTemplate"))

function var_0_1.getUIName(arg_1_0)
	return "EducatePolaroidUI"
end

function var_0_1.initConfig(arg_2_0)
	pg = var_1_10001
	arg_2_0.config = var_1_10001.child_polaroid

	return
end

function var_0_1.initGroups(arg_3_0)
	arg_3_0.groupIds = {}
	arg_3_0.group2polaroidIds = {}
	pairs = var_1
	pg = var_1_10002

	for iter_3_0, iter_3_1 in var_1(var_1_10002.child_polaroid.get_id_list_by_group) do
		table = var_1_10006

		var_1_10006.insert(arg_3_0.groupIds, iter_3_0)

		var_1_10006 = arg_3_0.group2polaroidIds
		var_1_10006[iter_3_0] = iter_3_1
	end

	table = var_1

	var_1.sort(arg_3_0.groupIds)

	return
end

function var_0_1.initUnlockAttr(arg_4_0)
	arg_4_0.unlockAttrs = {}
	getProxy = var_1
	EducateProxy = var_1_10002

	local var_4_0 = var_1(var_1_10002)

	arg_4_0.endings = var_1.GetAllEndings(var_4_0)
	underscore = var_1

	var_1.each(arg_4_0.endings, function(arg_5_0)
		pg = var_2_10001

		if var_2_10001.child_ending[arg_5_0].polaroid_condition ~= 0 then
			table = var_2_10002

			if not var_2_10002.contains(arg_4_0.unlockAttrs, var_1) then
				table = var_2

				var_2.insert(arg_4_0.unlockAttrs, var_1)
			end
		end

		return
	end)

	return
end

function var_0_1.didEnter(arg_6_0)
	arg_6_0:initGroups()
	arg_6_0:initShowList()

	onButton = var_1

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.performTF

	local function var_6_2()
		setActive = var_2_10000

		var_2_10000(arg_6_0.performTF, false)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_6_0, var_6_1, var_6_2, var_1_10005)

	math = var_1
	arg_6_0.pages = var_1.ceil(#arg_6_0.groupIds / arg_6_0.onePageCnt)
	EducateTipHelper = var_1

	local var_6_3 = var_1.ClearNewTip

	EducateTipHelper = var_2

	var_6_3(var_2.NEW_POLAROID)

	local var_6_4 = arg_6_0.performTF
	local var_6_5 = var_1.Find(var_6_4, "bg/lock/unlock_btn/Text")
	local var_6_6 = var_1.GetComponent(var_6_5, "RichText")
	local var_6_7 = var_2.AddSprite
	local var_6_8 = "gold"
	local var_6_9 = arg_6_0._tf
	local var_6_10 = var_6.Find(var_6_9, "res/gold")
	local var_6_11 = var_6.GetComponent

	typeof = var_8
	Image = var_1_10009

	var_6_7(var_6_6, var_6_8, var_6_11(var_6_10, var_8(var_1_10009)).sprite)

	setText = var_6_7

	local var_6_12 = var_1

	i18n = var_6_8

	var_6_7(var_6_12, var_6_8("child_could_buy"))

	setText = var_6_7

	local var_6_13 = arg_6_0.windowTF
	local var_6_14 = var_4.Find(var_6_13, "tip")

	i18n = var_6_13

	var_6_7(var_6_14, var_6_13("child_buy_polaroid_tip"))

	pg = var_6_7
	arg_6_0.basePrice = var_6_7.gameset.child_polaroid_basic_price.key_value
	pg = var_3
	arg_6_0.addPrice = var_3.gameset.child_polaroid_add_price.key_value
	pg = var_3
	arg_6_0.maxPrice = var_3.gameset.child_polaroid_max_price.key_value

	arg_6_0:Flush()

	return
end

function var_0_1.initShowList(arg_8_0)
	arg_8_0.showIds = {}
	arg_8_0.selectedIndex = 1

	local var_8_0 = arg_8_0.performTF

	arg_8_0.groupsTF = var_1.Find(var_8_0, "bg/groups")
	UIItemList = var_1

	local var_8_1 = var_1.New
	local var_8_2 = arg_8_0.groupsTF
	local var_8_3 = arg_8_0.groupsTF

	arg_8_0.showList = var_8_1(var_8_2, var_3.Find(var_8_3, "tpl"))

	local var_8_4 = arg_8_0.showList

	var_1.make(var_8_4, function(arg_9_0, arg_9_1, arg_9_2)
		UIItemList = var_2_10003

		if arg_9_0 == var_2_10003.EventUpdate then
			local var_9_0 = arg_8_0.showIds[arg_9_1 + 1]
			local var_9_1 = arg_8_0
			local var_9_2 = var_4.IsUnlock(var_9_1, var_9_0)

			setText = var_9_1

			var_9_1(arg_9_2:Find("unlock/unselected/Text"), var_9_0)

			setText = var_9_1

			var_9_1(arg_9_2:Find("unlock/selected/Text"), var_9_0)

			setActive = var_9_1

			var_9_1(arg_9_2:Find("lock"), not var_9_2)

			setActive = var_9_1

			var_9_1(arg_9_2:Find("unlock"), var_9_2)

			setActive = var_9_1

			var_9_1(arg_9_2:Find("unlock/selected"), arg_8_0.selectedIndex == arg_9_1 + 1)

			setActive = var_9_1

			var_9_1(arg_9_2:Find("unlock/unselected"), arg_8_0.selectedIndex ~= arg_9_1 + 1)

			onButton = var_9_1

			var_9_1(arg_8_0, arg_9_2, function(arg_10_0)
				arg_8_0.selectedIndex = arg_9_1 + 1

				local var_10_0 = arg_8_0

				var_1.updatePerform(var_10_0, var_9_0, var_9_2)

				local var_10_1 = arg_8_0.showList

				var_1.align(var_10_1, #arg_8_0.showIds)

				if not var_9_2 then
					pg = var_1

					local var_10_2 = var_1.TipsMgr.GetInstance()
					local var_10_3 = var_1.ShowTips

					i18n = var_3

					var_10_3(var_10_2, var_3("child_polaroid_lock_tip"))
				end

				return
			end)
		end

		return
	end)

	return
end

function var_0_1.IsUnlock(arg_11_0, arg_11_1)
	if arg_11_0.polaroidData[arg_11_1] then
		return true
	end

	if #arg_11_0.endings > 0 then
		if arg_11_0.config[arg_11_1].stage[1] == 2 or var_2[1] == 3 then
			return true
		elseif var_2[1] == 4 then
			local var_11_0 = arg_11_0.config[arg_11_1].xingge[1]

			table = var_1_10004

			return var_1_10004.contains(arg_11_0.unlockAttrs, var_11_0)
		end
	end

	return false
end

function var_0_1.SetData(arg_12_0)
	getProxy = var_1_10001
	EducateProxy = var_1_10002

	local var_12_0 = var_1_10001(var_1_10002)

	arg_12_0.polaroidData = var_1.GetPolaroidData(var_12_0)
	arg_12_0.gameCnt = var_1:GetGameCnt()
	arg_12_0.bugCnt = var_1:GetPolaroidBuyCnt()

	arg_12_0:initUnlockAttr()

	return
end

function var_0_1.Flush(arg_13_0)
	local var_13_0 = arg_13_0

	arg_13_0.SetData(var_13_0)

	getProxy = var_1
	EducateProxy = var_13_0

	local var_13_1 = var_1(var_13_0)
	local var_13_2, var_13_3 = var_1.GetPolaroidGroupCnt(var_13_1)

	setText = var_1_10003

	var_1_10003(arg_13_0.curCntTF, var_13_2)

	setText = var_1_10003

	var_1_10003(arg_13_0.allCntTF, "/" .. var_13_3)
	arg_13_0:updatePage()

	isActive = var_3

	if var_3(arg_13_0.performTF) then
		local var_13_4 = arg_13_0.showIds[arg_13_0.selectedIndex]
		local var_13_5 = arg_13_0:IsUnlock(var_13_4)

		arg_13_0:updatePerform(var_13_4, var_13_5)

		local var_13_6 = arg_13_0.showList

		var_5.align(var_13_6, #arg_13_0.showIds)
	end

	return
end

function var_0_1.updatePage(arg_14_0)
	setActive = var_1_10001

	var_1_10001(arg_14_0.nextBtn, arg_14_0.pages ~= 1 and arg_14_0.curPageIndex < arg_14_0.pages)

	setActive = var_1_10001

	var_1_10001(arg_14_0.lastBtn, arg_14_0.pages ~= 1 and arg_14_0.curPageIndex > 1)

	setText = var_1_10001

	var_1_10001(arg_14_0.paginationTF, arg_14_0.curPageIndex .. "/" .. arg_14_0.pages)

	local var_14_0 = (arg_14_0.curPageIndex - 1) * arg_14_0.onePageCnt

	for iter_14_0 = 1, arg_14_0.onePageCnt do
		local var_14_1 = arg_14_0.pageTF
		local var_14_2 = var_6.Find(var_14_1, "frame_" .. iter_14_0)

		if arg_14_0.groupIds[var_14_0 + iter_14_0] then
			setActive = var_8

			var_8(var_14_2, true)
			arg_14_0:updateItem(var_7, var_14_2)
		else
			setActive = var_8

			var_8(var_14_2, false)
		end
	end

	return
end

function var_0_1.updateItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.group2polaroidIds[arg_15_1]

	table = var_1_10004

	local var_15_1 = var_1_10004.sort
	local var_15_2 = var_15_0

	CompareFuncs = var_1_10006

	var_15_1(var_15_2, var_1_10006({
		function(arg_16_0)
			return arg_15_0.polaroidData[arg_16_0] and 0 or 1
		end,
		function(arg_17_0)
			if arg_15_0.polaroidData[arg_17_0] then
				local var_17_0 = arg_15_0.polaroidData[arg_17_0]
				local var_17_1

				if not var_1.GetTimeWeight(var_17_0) then
					var_17_1 = 1
				end

				return var_17_1
			end
		end,
		function(arg_18_0)
			return arg_18_0
		end
	}))

	local var_15_3 = arg_15_0.config[var_15_0[1]]
	local var_15_4 = arg_15_0.polaroidData[var_15_0[1]]

	setActive = var_15_5

	var_15_5(arg_15_2:Find("lock"), not var_15_4)

	setActive = var_15_5

	var_15_5(arg_15_2:Find("unlock"), var_15_4)

	local var_15_5

	if var_15_4 then
		var_15_5 = arg_15_0.polaroidData[var_15_0[1]]
		LoadImageSpriteAsync = var_7

		var_7("educatepolaroid/" .. var_15_3.pic, arg_15_2:Find("unlock/mask/Image"))

		setText = var_7

		var_7(arg_15_2:Find("unlock/name"), var_15_3.title)

		onButton = var_7

		local var_15_6 = arg_15_0
		local var_15_7 = arg_15_2

		local function var_15_8()
			local var_19_0 = arg_15_0

			var_0.showPerformWindow(var_19_0, var_15_0)

			return
		end

		SFX_PANEL = var_1_10011

		var_7(var_15_6, var_15_7, var_15_8, var_1_10011)
	else
		removeOnButton = var_15_5

		var_15_5(arg_15_2)

		setText = var_15_5

		var_15_5(arg_15_2:Find("lock/desc/Text"), var_15_3.condition)

		local var_15_9 = arg_15_2
		local var_15_10 = arg_15_2.Find(var_15_9, "lock/unlock_btn")

		setActive = var_15_9

		var_15_9(var_15_10, arg_15_0.gameCnt > 1)

		onButton = var_15_9

		local var_15_11 = arg_15_0
		local var_15_12 = var_15_10

		local function var_15_13()
			local var_20_0 = arg_15_0

			var_0.OnClickBuyBtn(var_20_0, var_15_3)

			return
		end

		SFX_PANEL = var_1_10011

		var_15_9(var_15_11, var_15_12, var_15_13, var_1_10011)
	end

	return
end

function var_0_1.showPerformWindow(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0.showIds = arg_21_1

	local var_21_0 = arg_21_0.showList

	var_3.align(var_21_0, #arg_21_0.showIds)

	triggerButton = var_3

	local var_21_1 = arg_21_0.groupsTF

	var_3(var_4.GetChild(var_21_1, 0))

	setActive = var_3

	var_3(arg_21_0.performTF, true)

	return
end

function var_0_1.updatePerform(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0.config[arg_22_1]

	LoadImageSpriteAsync = var_1_10004

	local var_22_1 = "educatepolaroid/" .. var_22_0.pic
	local var_22_2 = arg_22_0.performTF

	var_1_10004(var_22_1, var_6.Find(var_22_2, "bg/icon/Image"))

	setActive = var_1_10004

	local var_22_3 = arg_22_0.performTF

	var_1_10004(var_5.Find(var_22_3, "bg/icon/lock"), not arg_22_2)

	setText = var_1_10004

	local var_22_4 = arg_22_0.performTF
	local var_22_5 = var_5.Find(var_22_4, "bg/Text")
	local var_22_6

	if not arg_22_2 or not var_22_0.title then
		var_22_6 = ""
	end

	var_1_10004(var_22_5, var_22_6)

	setActive = var_1_10004

	local var_22_7 = arg_22_0.performTF

	var_1_10004(var_5.Find(var_22_7, "bg/lock"), not arg_22_2)

	if not arg_22_2 then
		setText = var_1_10004

		local var_22_8 = arg_22_0.performTF

		var_1_10004(var_5.Find(var_22_8, "bg/lock/desc/Text"), var_22_0.condition)

		local var_22_9 = arg_22_0.performTF
		local var_22_10 = var_4.Find(var_22_9, "bg/lock/unlock_btn")

		setActive = var_22_9

		var_22_9(var_22_10, arg_22_0.gameCnt > 1)

		onButton = var_22_9

		local var_22_11 = arg_22_0
		local var_22_12 = var_22_10

		local function var_22_13()
			local var_23_0 = arg_22_0

			var_0.OnClickBuyBtn(var_23_0, var_22_0)

			return
		end

		SFX_PANEL = var_1_10009

		var_22_9(var_22_11, var_22_12, var_22_13, var_1_10009)
	end

	return
end

function var_0_1.OnClickBuyBtn(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_1.title

	math = var_1_10003

	local var_24_1 = var_1_10003.min(arg_24_0.maxPrice, arg_24_0.basePrice + arg_24_0.bugCnt * arg_24_0.addPrice)
	local var_24_2 = arg_24_0
	local var_24_3 = arg_24_0.emit

	EducateBaseUI = var_6

	local var_24_4 = var_6.EDUCATE_ON_MSG_TIP
	local var_24_5 = {}

	i18n = var_1_10008
	var_24_5.content = var_1_10008("child_polaroid_buy", var_24_1, var_24_0)

	function var_24_5.onYes()
		local var_25_0 = arg_24_0
		local var_25_1 = var_0.emit

		EducateCollectMediatorTemplate = var_2_10002

		local var_25_2 = var_2_10002.UNLOCK
		local var_25_3 = {}

		EducateBuyCollectCommand = var_2_10004
		var_25_3.type = var_2_10004.TYPE.POLAROID
		var_25_3.id = arg_24_1.id
		var_25_3.cost = var_24_1

		var_25_1(var_25_0, var_25_2, var_25_3)

		return
	end

	var_24_3(var_24_2, var_24_4, var_24_5)

	return
end

function var_0_1.playAnimChange(arg_26_0)
	local var_26_0 = arg_26_0.anim

	var_1.Stop(var_26_0)

	local var_26_1 = arg_26_0.anim

	var_1.Play(var_26_1, "anim_educate_Polaroid_change")

	return
end

function var_0_1.playAnimClose(arg_27_0)
	local var_27_0 = arg_27_0.anim

	var_1.Play(var_27_0, "anim_educate_Polaroid_out")

	return
end

return var_0_1
