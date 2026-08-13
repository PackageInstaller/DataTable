class = var_0_10000

local var_0_0 = "EducateSiteDetailPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "EducateSiteDetailUI"
end

function var_0_1.OnInit(arg_2_0)
	setActive = var_1_10001

	var_1_10001(arg_2_0._tf, false)

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "adapt")
	local var_2_2 = var_1.GetComponent

	typeof = var_4
	Animation = var_1_10006
	arg_2_0.anim = var_2_2(var_2_1, var_4(var_1_10006))

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "adapt")
	local var_2_5 = var_1.GetComponent

	typeof = var_4
	DftAniEvent = var_1_10006
	arg_2_0.animEvent = var_2_5(var_2_4, var_4(var_1_10006))

	local var_2_6 = arg_2_0.animEvent

	var_1.SetEndEvent(var_2_6, function()
		setActive = var_2_10000

		var_2_10000(arg_2_0._tf, false)

		if arg_2_0.contextData.onExit then
			arg_2_0.contextData.onExit()
		end

		return
	end)

	local var_2_7 = arg_2_0._tf

	arg_2_0.windowTF = var_1.Find(var_2_7, "adapt/window")

	local var_2_8 = arg_2_0.windowTF

	arg_2_0.closeBtn = var_1.Find(var_2_8, "close_btn")

	local var_2_9 = arg_2_0.windowTF

	arg_2_0.nameTF = var_1.Find(var_2_9, "name_bg/name")

	local var_2_10 = arg_2_0.windowTF

	arg_2_0.picTF = var_1.Find(var_2_10, "pic")

	local var_2_11 = arg_2_0.windowTF

	arg_2_0.descTF = var_1.Find(var_2_11, "desc")

	local var_2_12 = arg_2_0.windowTF

	arg_2_0.optionsTF = var_1.Find(var_2_12, "options/content")

	local var_2_13 = arg_2_0.windowTF

	arg_2_0.optionTpl = var_1.Find(var_2_13, "option_tpl")
	setText = var_1

	local var_2_14 = arg_2_0.optionTpl
	local var_2_15 = var_3.Find(var_2_14, "limit/Text")

	i18n = var_4

	var_1(var_2_15, var_4("child_option_limit"))

	setText = var_1

	local var_2_16 = arg_2_0.optionTpl
	local var_2_17 = var_3.Find(var_2_16, "type_2/awards/polaroid/Text")

	i18n = var_4

	var_1(var_2_17, var_4("child_random_polaroid_drop"))

	setActive = var_1

	var_1(arg_2_0.optionTpl, false)

	UIItemList = var_1
	arg_2_0.optionUIList = var_1.New(arg_2_0.optionsTF, arg_2_0.optionTpl)

	local var_2_18 = arg_2_0._tf

	arg_2_0.performTF = var_1.Find(var_2_18, "perform")

	local var_2_19 = arg_2_0.performTF

	arg_2_0.performName = var_1.Find(var_2_19, "name")

	arg_2_0:addListener()
	arg_2_0:OverlayPanel(arg_2_0._tf, {
		groupDelta = -2
	})

	return
end

function var_0_1.addListener(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0._tf
	local var_4_2 = var_4.Find(var_4_1, "bg")

	local function var_4_3()
		local var_5_0 = arg_4_0

		var_0.onClose(var_5_0)

		return
	end

	SFX_PANEL = var_4_1

	var_1_10001(var_4_0, var_4_2, var_4_3, var_4_1)

	onButton = var_1_10001

	local var_4_4 = arg_4_0
	local var_4_5 = arg_4_0.closeBtn

	local function var_4_6()
		local var_6_0 = arg_4_0

		var_0.onClose(var_6_0)

		return
	end

	SFX_PANEL = var_4_1

	var_1_10001(var_4_4, var_4_5, var_4_6, var_4_1)

	local var_4_7 = arg_4_0.optionUIList

	var_1.make(var_4_7, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			local var_7_0 = arg_4_0

			var_3.updateOptionItem(var_7_0, arg_7_1, arg_7_2)
		end

		return
	end)

	arg_4_0.optionIds = {}

	return
end

function var_0_1.checkSpecEvent(arg_8_0, arg_8_1, arg_8_2)
	getProxy = var_1_10003
	EducateProxy = var_1_10005

	local var_8_0 = var_1_10003(var_1_10005)
	local var_8_1 = var_3.GetEventProxy(var_8_0)

	if #var_3.GetSiteSpecEvents(var_8_1, arg_8_1) > 0 then
		local var_8_2 = arg_8_0
		local var_8_3 = arg_8_0.emit

		EducateMapMediator = var_1_10007

		var_8_3(var_8_2, var_1_10007.ON_SPECIAL_EVENT_TRIGGER, {
			siteId = arg_8_1,
			id = var_3[1].id,
			callback = arg_8_2
		})
	else
		arg_8_2()
	end

	return
end

function var_0_1.showSpecEvent(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	pg = var_1_10005

	local var_9_0 = var_1_10005.child_event_special[arg_9_2].performance

	EducateHelper = var_1_10006

	local var_9_1 = var_1_10006.GetDialogueShowDrops(arg_9_3)

	EducateHelper = var_1_10007

	local var_9_2 = var_1_10007.GetCommonShowDrops(arg_9_3)

	local function var_9_3()
		local var_10_1

		if #var_9_2 > 0 then
			local var_10_0 = arg_9_0

			var_10_1 = var_10_1.emit
			EducateBaseUI = var_2_10003

			var_10_1(var_10_0, var_2_10003.EDUCATE_ON_AWARD, {
				items = var_9_2,
				removeFunc = function()
					local var_11_0 = arg_9_0

					var_0.checkSpecEvent(var_11_0, arg_9_1, arg_9_4)

					return
				end
			})
		else
			local var_10_2 = arg_9_0

			var_10_1.checkSpecEvent(var_10_2, arg_9_1, arg_9_4)
		end

		setActive = var_10_1

		var_10_1(arg_9_0.performTF, false)

		return
	end

	if #var_9_0 > 0 then
		setActive = var_9

		var_9(arg_9_0.performTF, true)

		pg = var_9

		local var_9_4 = var_9.PerformMgr.GetInstance()

		var_9.PlayGroup(var_9_4, var_9_0, var_9_3, var_9_1)
	elseif var_9_3 then
		var_9_3()
	end

	return
end

function var_0_1.showSiteDetailById(arg_12_0, arg_12_1)
	if arg_12_0.siteId == arg_12_1 then
		return
	end

	arg_12_0.siteId = arg_12_1
	pg = var_2
	arg_12_0.config = var_2.child_site[arg_12_0.siteId]

	arg_12_0:checkSpecEvent(arg_12_0.siteId, function()
		local var_13_0 = arg_12_0

		var_0.showDetailPanel(var_13_0)

		return
	end)

	return
end

function var_0_1.addTaskProgress(arg_14_0)
	getProxy = var_1_10001
	EducateProxy = var_1_10003

	local var_14_0 = var_1_10001(var_1_10003)
	local var_14_1 = var_1.GetTaskProxy(var_14_0)
	local var_14_2 = var_1.GetSiteEnterAddTasks(var_14_1, arg_14_0.siteId)
	local var_14_3 = {}
	local var_14_4 = {}
	local var_14_5 = {}

	ipairs = var_1_10005

	for iter_14_0, iter_14_1 in var_1_10005(var_14_2) do
		if iter_14_1:IsMind() then
			table = var_1_10010

			var_1_10010.insert(var_14_3, {
				progress = 1,
				task_id = iter_14_1.id
			})
		end

		if iter_14_1:IsTarget() then
			table = var_1_10010

			var_1_10010.insert(var_14_4, {
				progress = 1,
				task_id = iter_14_1.id
			})
		end

		if iter_14_1:IsMain() then
			table = var_1_10010

			var_1_10010.insert(var_14_5, {
				progress = 1,
				task_id = iter_14_1.id
			})
		end
	end

	if #var_14_3 > 0 then
		local var_14_6 = arg_14_0
		local var_14_7 = arg_14_0.emit

		EducateMapMediator = iter_14_0
		iter_14_0 = iter_14_0.ON_ADD_TASK_PROGRESS

		local var_14_8 = {}

		EducateTask = var_1_10010
		var_14_8.system = var_1_10010.SYSTEM_TYPE_MIND
		var_14_8.progresses = var_14_3

		var_14_7(var_14_6, iter_14_0, var_14_8)
	end

	if #var_14_4 > 0 then
		local var_14_9 = arg_14_0
		local var_14_10 = arg_14_0.emit

		EducateMapMediator = iter_14_0
		iter_14_0 = iter_14_0.ON_ADD_TASK_PROGRESS

		local var_14_11 = {}

		EducateTask = var_1_10010
		var_14_11.system = var_1_10010.SYSTEM_TYPE_TARGET
		var_14_11.progresses = var_14_4

		var_14_10(var_14_9, iter_14_0, var_14_11)
	end

	if #var_14_5 > 0 then
		local var_14_12 = arg_14_0
		local var_14_13 = arg_14_0.emit

		EducateMapMediator = iter_14_0

		local var_14_14 = iter_14_0.ON_ADD_TASK_PROGRESS
		local var_14_15 = {}

		EducateTask = var_1_10010
		var_14_15.system = var_1_10010.STSTEM_TYPE_MAIN
		var_14_15.progresses = var_14_5

		var_14_13(var_14_12, var_14_14, var_14_15)
	end

	return
end

local function var_0_2(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1[2] == -1 then
		LoadImageSpriteAtlasAsync = var_3

		local var_15_0 = "ui/educatecommonui_atlas"

		var_1_10006 = "res_-1"
		findTF = var_1_10007

		var_3(var_15_0, var_1_10006, var_1_10007(arg_15_0, "Image"), true)

		setText = var_3
		findTF = var_15_0

		local var_15_1 = var_15_0(arg_15_0, "Text")

		i18n = var_1_10006

		var_3(var_15_1, var_1_10006("child_random_ops_drop"))
	else
		local var_15_2 = ""
		local var_15_3 = ""
		local var_15_4 = arg_15_1[1]

		EducateConst = var_1_10006

		if var_15_4 == var_1_10006.DROP_TYPE_ATTR then
			var_15_2 = "attr_"
			pg = var_15_4
			var_15_3 = var_15_4.child_attr[arg_15_1[2]].name
		else
			var_15_4 = arg_15_1[1]
			EducateConst = var_6

			if var_15_4 == var_6.DROP_TYPE_RES then
				var_15_2 = "res_"
				pg = var_15_4
				var_15_3 = var_15_4.child_resource[arg_15_1[2]].name
			end
		end

		LoadImageSpriteAtlasAsync = var_15_4

		local var_15_5 = "ui/educatecommonui_atlas"
		local var_15_6 = var_15_2 .. arg_15_1[2]

		findTF = var_9

		var_15_4(var_15_5, var_15_6, var_9(arg_15_0, "Image"), true)

		setText = var_15_4
		findTF = var_15_5

		var_15_4(var_15_5(arg_15_0, "Text"), var_15_3 .. "+" .. arg_15_1[3])
	end

	return
end

local function var_0_3(arg_16_0, arg_16_1)
	local var_16_0 = ""
	local var_16_1 = arg_16_1[1]

	EducateConst = var_1_10004

	if var_16_1 == var_1_10004.DROP_TYPE_ATTR then
		var_16_0 = "attr_"
	else
		var_16_1 = arg_16_1[1]
		EducateConst = var_4

		if var_16_1 == var_4.DROP_TYPE_RES then
			var_16_0 = "res_"
		end
	end

	LoadImageSpriteAtlasAsync = var_16_1

	local var_16_2 = "ui/educatecommonui_atlas"
	local var_16_3 = var_16_0 .. arg_16_1[2]

	findTF = var_7

	var_16_1(var_16_2, var_16_3, var_7(arg_16_0, "Image"), true)

	setText = var_16_1
	findTF = var_16_2

	var_16_1(var_16_2(arg_16_0, "Text"), "-" .. arg_16_1[3])

	return
end

function var_0_1.updateOptionItem(arg_17_0, arg_17_1, arg_17_2)
	GetOrAddComponent = var_1_10003

	local var_17_0 = var_1_10003(arg_17_2, "CanvasGroup")

	var_17_0.alpha = 1
	tostring = var_17_0
	arg_17_2.name = var_17_0(arg_17_1 + 1)

	local var_17_1 = arg_17_0.optionVOs[arg_17_1 + 1]

	setActive = var_4

	local var_17_2 = arg_17_2:Find("limit")
	local var_17_3 = var_17_1

	var_4(var_17_2, var_17_1.IsShowLimit(var_17_3))

	local var_17_4 = var_17_1:GetType()

	for iter_17_0 = 1, 3 do
		setActive = var_17_3

		var_17_3(arg_17_2:Find("type_" .. iter_17_0), iter_17_0 == var_17_4)
	end

	local var_17_5 = arg_17_2
	local var_17_6 = arg_17_2.Find(var_17_5, "type_" .. var_17_4)
	local var_17_7 = not var_17_1:IsCountLimit() and true or var_17_1:CanTrigger()

	setGray = var_17_5

	var_17_5(arg_17_2, not var_17_7)

	switch = var_17_5

	local var_17_8 = var_17_4
	local var_17_9 = {}

	EducateSiteOption = var_1_10011
	var_17_9[var_1_10011.TYPE_SHOP] = function()
		setText = var_2_10000

		local var_18_0 = var_17_6
		local var_18_1 = var_2.Find(var_18_0, "name/Text")
		local var_18_2 = var_17_1

		var_2_10000(var_18_1, var_3.getConfig(var_18_2, "name"))

		onButton = var_2_10000

		local var_18_3 = arg_17_0
		local var_18_4 = arg_17_2

		local function var_18_5()
			local var_19_0 = arg_17_0
			local var_19_1 = var_0.emit

			EducateMapMediator = var_3_10003

			local var_19_2 = var_3_10003.ON_OPEN_SHOP
			local var_19_3 = var_17_1

			var_19_1(var_19_0, var_19_2, var_4.GetLinkId(var_19_3))

			return
		end

		SFX_PANEL = var_18_2

		var_2_10000(var_18_3, var_18_4, var_18_5, var_18_2)

		return
	end
	EducateSiteOption = var_11
	var_17_9[var_11.TYPE_EVENT] = function()
		setText = var_2_10000

		local var_20_0 = var_17_6
		local var_20_1 = var_2.Find(var_20_0, "name")

		shortenString = var_2_10003

		local var_20_2 = var_17_1
		local var_20_3 = var_5.getConfig(var_20_2, "name")
		local var_20_4 = var_17_1

		var_2_10000(var_20_1, var_2_10003(var_20_3 .. var_6.GetCntText(var_20_4), 12))

		local var_20_5 = var_17_1
		local var_20_6 = var_0.IsShowPolaroid(var_20_5)

		setActive = var_2_10001

		local var_20_7 = var_17_6

		var_2_10001(var_3.Find(var_20_7, "awards/polaroid"), var_20_6)

		local var_20_8 = var_20_6 and 2 or 3
		local var_20_9 = var_17_1
		local var_20_10 = var_2.GetResults(var_20_9)

		UIItemList = var_3

		local var_20_11 = var_3.New
		local var_20_12 = var_17_6
		local var_20_13 = var_5.Find(var_20_12, "awards/normal")
		local var_20_14 = var_17_6
		local var_20_15 = var_20_11(var_20_13, var_6.Find(var_20_14, "awards/normal/tpl"))

		var_3.make(var_20_15, function(arg_21_0, arg_21_1, arg_21_2)
			UIItemList = var_3_10003

			if arg_21_0 == var_3_10003.EventUpdate then
				var_0_2(arg_21_2, var_20_10[arg_21_1 + 1])
			end

			return
		end)

		local var_20_16 = var_20_8 < #var_20_10 and var_20_8 or #var_20_10

		var_3:align(var_20_16)

		local var_20_17 = var_17_1
		local var_20_18 = var_5.GetCost(var_20_17)

		UIItemList = var_20_15

		local var_20_19 = var_20_15.New
		local var_20_20 = var_17_6
		local var_20_21 = var_8.Find(var_20_20, "costs")
		local var_20_22 = var_17_6
		local var_20_23 = var_20_19(var_20_21, var_9.Find(var_20_22, "costs/tpl"))

		var_6.make(var_20_23, function(arg_22_0, arg_22_1, arg_22_2)
			UIItemList = var_3_10003

			if arg_22_0 == var_3_10003.EventUpdate then
				var_0_3(arg_22_2, var_20_18[arg_22_1 + 1], "-")
			end

			return
		end)
		var_6:align(#var_20_18)

		onButton = var_7

		local var_20_24 = arg_17_0
		local var_20_25 = arg_17_2

		local function var_20_26()
			if not var_17_7 then
				return
			end

			local var_23_0 = arg_17_0
			local var_23_1 = var_0.emit

			EducateMapMediator = var_3_10003

			var_23_1(var_23_0, var_3_10003.ON_MAP_SITE_OPERATE, {
				siteId = arg_17_0.siteId,
				optionVO = var_17_1
			})

			return
		end

		SFX_PANEL = var_12

		var_7(var_20_24, var_20_25, var_20_26, var_12)

		return
	end
	EducateSiteOption = var_11
	var_17_9[var_11.TYPE_SITE] = function()
		setText = var_2_10000

		local var_24_0 = var_17_6
		local var_24_1 = var_2.Find(var_24_0, "name/Text")
		local var_24_2 = var_17_1

		var_2_10000(var_24_1, var_3.getConfig(var_24_2, "name"))

		onButton = var_2_10000

		local var_24_3 = arg_17_0
		local var_24_4 = arg_17_2

		local function var_24_5()
			local var_25_0 = var_17_1
			local var_25_1 = var_0.GetLinkId(var_25_0)

			assert = var_3_10001
			pg = var_3_10003

			var_3_10001(var_3_10003.child_site[var_25_1], "child_site不存在id:" .. var_25_1)

			table = var_3_10001

			var_3_10001.insert(arg_17_0.siteQueue, var_25_1)

			local var_25_2 = arg_17_0

			var_1.showSiteDetailById(var_25_2, var_25_1)

			return
		end

		SFX_PANEL = var_24_2

		var_2_10000(var_24_3, var_24_4, var_24_5, var_24_2)

		return
	end

	var_17_5(var_17_8, var_17_9)

	return
end

function var_0_1.showDetailPanel(arg_26_0)
	arg_26_0:addTaskProgress()

	setActive = var_1

	var_1(arg_26_0.windowTF, true)

	setText = var_1

	var_1(arg_26_0.nameTF, arg_26_0.config.name)

	setText = var_1

	var_1(arg_26_0.descTF, arg_26_0.config.desc)

	LoadImageSpriteAsync = var_1

	var_1("educatesite/" .. arg_26_0.config.pic, arg_26_0.picTF, true)

	getProxy = var_1
	EducateProxy = var_3

	local var_26_0 = var_1(var_3)

	arg_26_0.optionVOs = var_1.GetOptionsBySiteId(var_26_0, arg_26_0.siteId)

	local var_26_1 = arg_26_0.optionUIList

	var_1.align(var_26_1, #arg_26_0.optionVOs)

	return
end

function var_0_1.showSitePerform(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5)
	EducateHelper = var_1_10006

	local var_27_0 = var_1_10006.GetDialogueShowDrops(arg_27_4)

	EducateHelper = var_1_10007

	local var_27_1 = var_1_10007.GetDialogueShowDrops(arg_27_5)

	table = var_8

	local var_27_2 = var_8.mergeArray

	EducateHelper = var_1_10010

	local var_27_3 = var_1_10010.GetCommonShowDrops(arg_27_4)

	EducateHelper = var_1_10011

	local var_27_4 = var_27_2(var_27_3, var_1_10011.GetCommonShowDrops(arg_27_5))
	local var_27_5 = {}

	pg = var_27_3

	local var_27_6 = var_27_3.child_site_option_branch[arg_27_2].performance

	pg = var_11

	local var_27_7 = var_11.child_site_option[arg_27_1].name

	table = var_12

	var_12.insert(var_27_5, function(arg_28_0)
		pg = var_2_10001

		local var_28_0 = var_2_10001.PerformMgr.GetInstance()

		var_1.PlayGroupNoHide(var_28_0, var_27_6, arg_28_0, var_27_0, var_27_7)

		return
	end)

	if arg_27_3 and #arg_27_3 > 0 then
		ipairs = var_12

		for iter_27_0, iter_27_1 in var_12(arg_27_3) do
			pg = var_1_10017
			var_1_10017 = var_1_10017.child_event[iter_27_1].performance
			table = var_1_10018

			var_1_10018.insert(var_27_5, function(arg_29_0)
				pg = var_2_10001

				local var_29_0 = var_2_10001.PerformMgr.GetInstance()

				var_1.PlayGroupNoHide(var_29_0, var_1_10017, arg_29_0, var_27_1)

				return
			end)
		end
	end

	setText = var_12

	var_12(arg_27_0.performName, var_27_7)

	setActive = var_12

	var_12(arg_27_0.performTF, true)

	pg = var_12

	local var_27_8 = var_12.PerformMgr.GetInstance()

	var_12.Show(var_27_8)

	seriesAsync = var_12

	var_12(var_27_5, function()
		setActive = var_2_10000

		var_2_10000(arg_27_0.performTF, false)

		local var_30_1

		if #var_27_4 > 0 then
			local var_30_0 = arg_27_0

			var_30_1 = var_30_1.emit
			EducateBaseUI = var_3

			var_30_1(var_30_0, var_3.EDUCATE_ON_AWARD, {
				items = var_27_4
			})
		end

		pg = var_30_1

		local var_30_2 = var_30_1.PerformMgr.GetInstance()

		var_0.Hide(var_30_2)

		local var_30_3 = arg_27_0

		var_0.showDetailPanel(var_30_3)

		return
	end)

	return
end

function var_0_1.Hide(arg_31_0)
	local var_31_0 = arg_31_0.anim

	var_1.Play(var_31_0, "anim_educate_sitedatail_out")

	return
end

function var_0_1.Show(arg_32_0, arg_32_1)
	if not arg_32_0:GetLoaded() then
		return
	end

	arg_32_0.siteId = arg_32_1
	pg = var_2
	arg_32_0.config = var_2.child_site[arg_32_0.siteId]
	assert = var_2

	var_2(arg_32_0.config, "child_site不存在id:" .. arg_32_0.siteId)

	setActive = var_2

	var_2(arg_32_0._tf, true)

	setActive = var_2

	var_2(arg_32_0.windowTF, false)

	arg_32_0.siteQueue = {
		arg_32_0.siteId
	}

	local var_32_0 = arg_32_0

	arg_32_0.checkSpecEvent(var_32_0, arg_32_0.siteId, function()
		local var_33_0 = arg_32_0

		var_0.showDetailPanel(var_33_0)

		if arg_32_0.contextData.onEnter then
			arg_32_0.contextData.onEnter()
		end

		return
	end)

	EducateTipHelper = var_2

	local var_32_1 = var_2.ClearNewTip

	EducateTipHelper = var_32_0

	var_32_1(var_32_0.NEW_SITE, arg_32_0.siteId)

	return
end

function var_0_1.onClose(arg_34_0)
	if #arg_34_0.siteQueue > 1 then
		table = var_1

		var_1.remove(arg_34_0.siteQueue, #arg_34_0.siteQueue)
		arg_34_0:showSiteDetailById(arg_34_0.siteQueue[#arg_34_0.siteQueue])
	else
		arg_34_0:Hide()
	end

	return
end

function var_0_1.OnDestroy(arg_35_0)
	local var_35_0 = arg_35_0.animEvent

	var_1.SetEndEvent(var_35_0, nil)
	arg_35_0:UnOverlayPanel(arg_35_0._tf)

	return
end

return var_0_1
