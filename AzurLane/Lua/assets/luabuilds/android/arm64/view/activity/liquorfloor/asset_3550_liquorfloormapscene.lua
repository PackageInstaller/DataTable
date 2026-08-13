class = var_0_10000

local var_0_0 = "LiquorFloorMapScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "LiquorFloorUI"
end

local var_0_2 = {}

Vector2 = var_0_0
var_0_2[1] = var_0_0.New(121.6, 121.6)
Vector2 = var_2
var_0_2[2] = var_2.New(-258.5, 22.8)
Vector2 = var_2
var_0_2[3] = var_2.New(-166.1, 283)
Vector2 = var_2
var_0_2[4] = var_2.New(-647.1, -14)
Vector2 = var_2
var_0_2[5] = var_2.New(-440.7, -26.8)
Vector2 = var_2
var_0_2[6] = var_2.New(-534.5, -285.1)
Vector2 = var_2
var_0_2[7] = var_2.New(279.7, -299.1)
Vector2 = var_2
var_0_2[8] = var_2.New(599.7, -299.1)
Vector2 = var_2
var_0_2[9] = var_2.New(897.5, -15.2)
Vector2 = var_2
var_0_2[10] = var_2.New(468.8, -15.2)
Vector2 = var_2
var_0_2[11] = var_2.New(952.9, 166.2)
Vector2 = var_2
var_0_2[12] = var_2.New(10.9, -91.6)
var_0_1.RANDOM_POS = var_0_2

local var_0_3 = {}

Vector2 = var_2
var_0_3[1] = var_2.New(213, 152)
Vector2 = var_2
var_0_3[2] = var_2.New(15, -137)
Vector2 = var_2
var_0_3[3] = var_2.New(348, -50)
Vector2 = var_2
var_0_3[4] = var_2.New(-32, -6)
Vector2 = var_2
var_0_3[5] = var_2.New(-296, -267)
Vector2 = var_2
var_0_3[6] = var_2.New(399, -113)
var_0_1.TOP_POS = var_0_3

local var_0_4 = {}

Vector2 = var_2
var_0_4[1] = var_2.New(-224.8, 183)
Vector2 = var_2
var_0_4[2] = var_2.New(-435, -81.5)
Vector2 = var_2
var_0_4[3] = var_2.New(452.5, 320.5)
Vector2 = var_2
var_0_4[4] = var_2.New(201, 53)
Vector2 = var_2
var_0_4[5] = var_2.New(26, -236.5)
Vector2 = var_2
var_0_4[6] = var_2.New(641.5, -63)
var_0_1.architecturePos = var_0_4

function var_0_1.SetActivity(arg_2_0, arg_2_1)
	arg_2_0.activity = arg_2_1

	return
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.ui = var_1.Find(var_3_0, "ui")

	local var_3_1 = arg_3_0.ui

	arg_3_0.fightBtn = var_1.Find(var_3_1, "fightBtn")

	local var_3_2 = arg_3_0.ui

	arg_3_0.taskBtn = var_1.Find(var_3_2, "decorate/decorate1_1/decorate1_2/taskBtn")

	local var_3_3 = arg_3_0.ui

	arg_3_0.storyBtn = var_1.Find(var_3_3, "decorate/decorate1_1/storyBtn")

	local var_3_4 = {}
	local var_3_5 = arg_3_0.ui

	var_3_4[1] = var_2.Find(var_3_5, "architecture/muchang_bg")

	local var_3_6 = arg_3_0.ui

	var_3_4[2] = var_2.Find(var_3_6, "architecture/nongchang_bg")

	local var_3_7 = arg_3_0.ui

	var_3_4[3] = var_2.Find(var_3_7, "architecture/kuangchang_bg")

	local var_3_8 = arg_3_0.ui

	var_3_4[4] = var_2.Find(var_3_8, "architecture/sheyingpeng_bg")

	local var_3_9 = arg_3_0.ui

	var_3_4[5] = var_2.Find(var_3_9, "architecture/huochezhan_bg")

	local var_3_10 = arg_3_0.ui

	var_3_4[6] = var_2.Find(var_3_10, "architecture/jiudian_bg")
	arg_3_0.architectureData = var_3_4

	local var_3_11 = {}
	local var_3_12 = arg_3_0._tf

	var_3_11[1] = var_2.Find(var_3_12, "bgs/muchang_xiao")

	local var_3_13 = arg_3_0._tf

	var_3_11[2] = var_2.Find(var_3_13, "bgs/nongchang_xiao")

	local var_3_14 = arg_3_0._tf

	var_3_11[3] = var_2.Find(var_3_14, "bgs/kuangchang_xiao")

	local var_3_15 = arg_3_0._tf

	var_3_11[4] = var_2.Find(var_3_15, "bgs/sheyingpeng_xiao")

	local var_3_16 = arg_3_0._tf

	var_3_11[5] = var_2.Find(var_3_16, "bgs/huochezhan_xiao")

	local var_3_17 = arg_3_0._tf

	var_3_11[6] = var_2.Find(var_3_17, "bgs/jiudian_xiao")
	arg_3_0.architectureMapData = var_3_11

	local var_3_18 = arg_3_0.ui

	arg_3_0.lv = var_1.Find(var_3_18, "LV")

	local var_3_19 = arg_3_0.ui

	arg_3_0.top = var_1.Find(var_3_19, "top")

	local var_3_20 = arg_3_0.top

	arg_3_0.backBtn = var_1.Find(var_3_20, "back_button")

	local var_3_21 = arg_3_0.top

	arg_3_0.homeBtn = var_1.Find(var_3_21, "home_button")

	local var_3_22 = arg_3_0._tf

	arg_3_0.slotTFs = var_1.Find(var_3_22, "bgs/content")

	local var_3_23 = arg_3_0._tf

	arg_3_0.slotTpl = var_1.Find(var_3_23, "bgs/content/tpl")
	setActive = var_1

	var_1(arg_3_0.slotTpl, false)

	local var_3_24 = arg_3_0.ui

	arg_3_0.box = var_1.Find(var_3_24, "box")
	SetActive = var_1

	var_1(arg_3_0.box, false)

	local var_3_25 = arg_3_0.ui

	arg_3_0.Text_new = var_1.Find(var_3_25, "LV/Lv_bg/Text_new")
	SetActive = var_1

	var_1(arg_3_0.Text_new, false)

	local var_3_26 = arg_3_0.ui

	arg_3_0.taskTip = var_1.Find(var_3_26, "decorate/decorate1_1/decorate1_2/taskBtn/tip")
	setText = var_1

	local var_3_27 = arg_3_0.top
	local var_3_28 = var_3.Find(var_3_27, "title/Text1")

	i18n = var_4

	var_1(var_3_28, var_4("LiquorFloor_title"))

	setText = var_1

	local var_3_29 = arg_3_0.top
	local var_3_30 = var_3.Find(var_3_29, "title/Text2")

	i18n = var_4

	var_1(var_3_30, var_4("LiquorFloor_title_en"))

	setText = var_1

	local var_3_31 = arg_3_0.ui
	local var_3_32 = var_3.Find(var_3_31, "decorate/decorate1_1/storyBtn/Text")

	i18n = var_4

	var_1(var_3_32, var_4("LiquorFloor_story_title"))

	setText = var_1

	local var_3_33 = arg_3_0.ui
	local var_3_34 = var_3.Find(var_3_33, "decorate/decorate1_1/decorate1_2/taskBtn/Text")

	i18n = var_4

	var_1(var_3_34, var_4("LiquorFloorTaskUI_title"))

	return
end

function var_0_1.OnStoryList(arg_4_0)
	arg_4_0.gather1 = {}
	arg_4_0.gather2 = {}
	arg_4_0.gather3 = {}

	local var_4_0 = arg_4_0.activity

	arg_4_0.client = var_1.getConfig(var_4_0, "config_client").BookData
	ipairs = var_1

	for iter_4_0, iter_4_1 in var_1(arg_4_0.client[1].data1) do
		table = var_1_10006

		var_1_10006.insert(arg_4_0.gather1, iter_4_1)
	end

	ipairs = var_1

	for iter_4_2, iter_4_3 in var_1(arg_4_0.client[2].data2) do
		table = var_1_10006

		var_1_10006.insert(arg_4_0.gather2, iter_4_3)
	end

	ipairs = var_1

	for iter_4_4, iter_4_5 in var_1(arg_4_0.client[3].data3) do
		table = var_1_10006

		var_1_10006.insert(arg_4_0.gather3, iter_4_5)
	end

	arg_4_0.storyList = {}

	arg_4_0:OnStory()

	return
end

function var_0_1.didEnter(arg_5_0)
	arg_5_0:OnStoryList()
	arg_5_0:InitData()

	onButton = var_1

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.fightBtn

	local function var_5_2()
		local var_6_0 = arg_5_0
		local var_6_1 = var_0.emit

		LiquorFloorMapMediator = var_2_10003

		var_6_1(var_6_0, var_2_10003.GO_FIGHT)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_5_0, var_5_1, var_5_2, var_1_10006)

	onButton = var_1

	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0.taskBtn

	local function var_5_5()
		local var_7_0 = arg_5_0
		local var_7_1 = var_0.emit

		LiquorFloorMapMediator = var_2_10003

		local var_7_2 = var_2_10003.OPEN_LAYER

		Context = var_2_10004

		local var_7_3 = var_2_10004.New
		local var_7_4 = {}

		LiquorFloorTaskMediator = var_2_10007
		var_7_4.mediator = var_2_10007
		LiquorFloorTaskScene = var_2_10007
		var_7_4.viewComponent = var_2_10007
		var_7_4.data = {
			activityID = arg_5_0.activity.id
		}

		var_7_1(var_7_0, var_7_2, var_7_3(var_7_4))

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_5_3, var_5_4, var_5_5, var_1_10006)

	onButton = var_1

	local var_5_6 = arg_5_0
	local var_5_7 = arg_5_0.storyBtn

	local function var_5_8()
		local var_8_0 = arg_5_0
		local var_8_1 = var_0.emit

		LiquorFloorMapMediator = var_2_10003

		var_8_1(var_8_0, var_2_10003.OPEN_CLUE_BOOK)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_5_6, var_5_7, var_5_8, var_1_10006)

	onButton = var_1

	local var_5_9 = arg_5_0
	local var_5_10 = arg_5_0.backBtn

	local function var_5_11()
		local var_9_0 = arg_5_0

		var_0.closeView(var_9_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_5_9, var_5_10, var_5_11, var_1_10006)

	onButton = var_1

	local var_5_12 = arg_5_0
	local var_5_13 = arg_5_0.homeBtn

	local function var_5_14()
		local var_10_0 = arg_5_0

		var_0.emit(var_10_0, var_0_1.ON_HOME)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_5_12, var_5_13, var_5_14, var_1_10006)

	onButton = var_1

	local var_5_15 = arg_5_0
	local var_5_16 = arg_5_0.box

	local function var_5_17()
		SetActive = var_2_10000

		var_2_10000(arg_5_0.box, false)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_5_15, var_5_16, var_5_17, var_1_10006)

	onButton = var_1

	local var_5_18 = arg_5_0
	local var_5_19 = arg_5_0.top
	local var_5_20 = var_4.Find(var_5_19, "help")

	local function var_5_21()
		pg = var_2_10000

		local var_12_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_12_1 = var_0.ShowMsgBox
		local var_12_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_12_2.type = var_2_10004
		pg = var_2_10004
		var_12_2.helps = var_2_10004.gametip.LiquorFloor_tip.tip

		var_12_1(var_12_0, var_12_2)

		return
	end

	SFX_CANCEL = var_5_19

	var_1(var_5_18, var_5_20, var_5_21, var_5_19)

	setText = var_1

	local var_5_22 = arg_5_0.ui
	local var_5_23 = var_3.Find(var_5_22, "Allgold/Text")

	i18n = var_5_20

	var_1(var_5_23, var_5_20("LiquorFloor_gold_get"))

	onButton = var_1

	local var_5_24 = arg_5_0
	local var_5_25 = arg_5_0.ui
	local var_5_26 = var_4.Find(var_5_25, "Allgold")

	local function var_5_27()
		SetActive = var_2_10000

		var_2_10000(arg_5_0.box, false)

		local var_13_0 = arg_5_0.activity
		local var_13_3

		if var_0.HasMaxGold(var_13_0) then
			pg = var_0

			local var_13_1 = var_0.MsgboxMgr.GetInstance()
			local var_13_2 = var_0.ShowMsgBox

			var_13_3 = {}
			i18n = var_2_10004
			var_13_3.content = var_2_10004("LiquorFloor_gold_max_tip")

			var_13_2(var_13_1, var_13_3)
		else
			local var_13_4 = arg_5_0
			local var_13_5 = var_0.emit

			LiquorFloorMapMediator = var_13_3

			var_13_5(var_13_4, var_13_3.ALL_WORKPLACE)
		end

		return
	end

	SFX_CANCEL = var_5_25

	var_1(var_5_24, var_5_26, var_5_27, var_5_25)

	local var_5_28 = arg_5_0.activity

	arg_5_0.timeCfg = var_1.getConfig(var_5_28, "config_client").endingtime

	local var_5_29 = arg_5_0.ui

	arg_5_0.Placeitems = var_1.Find(var_5_29, "architecture")

	local var_5_30 = arg_5_0.Placeitems

	arg_5_0.Placeitem = var_1.Find(var_5_30, "muchang_bg")
	UIItemList = var_1
	arg_5_0.uilistPlace = var_1.New(arg_5_0.Placeitems, arg_5_0.Placeitem)

	arg_5_0:OnPlaceDes()
	arg_5_0:UpdateBubbles()

	Timer = var_1
	arg_5_0.timer = var_1.New(function()
		local var_14_0 = arg_5_0

		var_0.OnUpdateTime(var_14_0)

		local var_14_1 = arg_5_0

		var_0.OnPlaceDes(var_14_1)

		return
	end, 1, -1)

	local var_5_31 = arg_5_0.timer

	var_1.Start(var_5_31)
	arg_5_0:OnUpdateTime()

	local var_5_32 = arg_5_0.activity

	arg_5_0.timeCfg = var_1.getConfig(var_5_32, "config_client").endingtime
	arg_5_0.spineRoles = {}

	local var_5_33 = arg_5_0.activity

	var_1.SetBubbleTipTag(var_5_33, true)
	arg_5_0:RefreshRedPoint()

	if arg_5_0.contextData.openStory == 1 then
		triggerButton = var_1

		var_1(arg_5_0.storyBtn)
	end

	return
end

function var_0_1.OnStory(arg_15_0)
	ipairs = var_1_10001

	for iter_15_0, iter_15_1 in var_1_10001(arg_15_0.gather1) do
		local var_15_0 = arg_15_0:getCollectDataBySiteId(iter_15_1).unlock[2]
		local var_15_1 = arg_15_0.activity

		if var_15_0 <= var_8.GetTownLevel(var_15_1) then
			pg = var_15_0

			local var_15_2 = var_15_0.NewStoryMgr.GetInstance()

			if not var_7.IsPlayed(var_15_2, var_6.luaID) then
				pg = var_8

				local var_15_3 = var_8.NewStoryMgr.GetInstance()

				var_8.Play(var_15_3, var_6.luaID, function()
					if iter_15_0 == 1 then
						pg = var_0

						local var_16_0 = var_0.NewGuideMgr.GetInstance()

						var_0.Play(var_16_0, "LiquorFloor_help")
					end

					return
				end)
			end
		end
	end

	local var_15_4 = arg_15_0.activity
	local var_15_5 = var_1.GetPlaceList(var_15_4)

	ipairs = var_2

	for iter_15_2, iter_15_3 in var_2(arg_15_0.gather2) do
		local var_15_6 = arg_15_0:getCollectDataBySiteId(iter_15_3).unlock[2]
		local var_15_7 = var_15_5[var_7.unlock[1]]

		if var_15_6 <= var_9.GetLevel(var_15_7) then
			pg = var_15_6

			local var_15_8 = var_15_6.NewStoryMgr.GetInstance()

			if not var_8.IsPlayed(var_15_8, var_7.luaID) then
				pg = var_9

				local var_15_9 = var_9.NewStoryMgr.GetInstance()

				var_9.Play(var_15_9, var_7.luaID, function()
					return
				end)
			end
		end
	end

	ipairs = var_2

	for iter_15_4, iter_15_5 in var_2(arg_15_0.gather3) do
		local var_15_10 = arg_15_0:getCollectDataBySiteId(iter_15_5).unlock[2]
		local var_15_11 = var_15_5[var_7.unlock[1]]

		if var_15_10 <= var_9.GetLevel(var_15_11) then
			pg = var_15_10

			local var_15_12 = var_15_10.NewStoryMgr.GetInstance()

			if not var_8.IsPlayed(var_15_12, var_7.luaID) then
				pg = var_9

				local var_15_13 = var_9.NewStoryMgr.GetInstance()

				var_9.Play(var_15_13, var_7.luaID, function()
					return
				end)
			end
		end
	end

	return
end

function var_0_1.OnstoryPlay(arg_19_0)
	if not arg_19_0.storyList or #arg_19_0.storyList == 0 then
		return
	end

	pg = var_1

	local var_19_0 = var_1.NewStoryMgr.GetInstance()

	var_1.Play(var_19_0, arg_19_0.storyList, function()
		return
	end, false)

	return
end

function var_0_1.OnUpdateTime(arg_21_0)
	return
end

function var_0_1.GetRandomPos(arg_22_0)
	local var_22_0 = {}

	for iter_22_0 = 1, #var_0_1.RANDOM_POS do
		table = var_1_10006

		var_1_10006.insert(var_22_0, iter_22_0)
	end

	shuffle = var_2

	var_2(var_22_0)

	local var_22_1 = {}

	for iter_22_1 = 1, 8 do
		table = var_1_10007

		var_1_10007.insert(var_22_1, var_0_1.RANDOM_POS[var_22_0[iter_22_1]])
	end

	return var_22_1
end

function var_0_1.UpdateBubbles(arg_23_0)
	arg_23_0.bubblesPosList = {}

	if arg_23_0.slotTpl then
		setActive = var_1

		var_1(arg_23_0.slotTpl, false)
	end

	Clone = var_1
	arg_23_0.randomPos = var_1(var_0_1.RANDOM_POS)
	ipairs = var_1

	for iter_23_0, iter_23_1 in var_1(arg_23_0.shipIds) do
		local var_23_0 = arg_23_0.slotTFs
		local var_23_1

		if not var_6.Find(var_23_0, iter_23_0) then
			cloneTplTo = var_23_1
			var_23_1 = var_23_1(arg_23_0.slotTpl, arg_23_0.slotTFs, iter_23_0)
		end

		if 0 < iter_23_1 then
			getProxy = var_7
			BayProxy = var_9

			local var_23_2 = var_7(var_9)
			local var_23_5

			if var_7.RawGetShipById(var_23_2, iter_23_1) then
				local var_23_3 = arg_23_0.activity
				local var_23_4 = var_7.GetBubbleCntByPos(var_23_3, iter_23_0)

				if not (0 < var_23_4) then
					var_23_5 = false
				else
					var_23_5 = true
				end
			end

			setActive = var_23_0

			var_23_0(var_23_1, var_23_5)

			if var_23_5 then
				table = var_23_0

				var_23_0.insert(arg_23_0.bubblesPosList, iter_23_0)
				arg_23_0:UpdateShip(var_23_1, iter_23_0, iter_23_1)
			end
		end
	end

	return
end

function var_0_1.UpdateShip(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_1

	if 0 < arg_24_3 then
		getProxy = var_4
		BayProxy = var_1_10006

		local var_24_0 = var_4(var_1_10006)

		var_24_1 = var_4.RawGetShipById(var_24_0, arg_24_3)
	else
		var_24_1 = false
	end

	if false then
		var_24_1 = true
	end

	if not var_24_1 then
		return
	end

	local var_24_2 = arg_24_0.activity
	local var_24_3 = var_5.GetBubbleCntByPos(var_24_2, arg_24_2)
	local var_24_4 = arg_24_0.randomPos[#arg_24_0.randomPos]

	setAnchoredPosition = var_7

	var_7(arg_24_1, var_24_4)

	table = var_7

	var_7.removebyvalue(arg_24_0.randomPos, var_24_4)

	LoadSprite = var_7

	local var_24_5 = var_7("qicon/" .. var_24_1:getPainting())

	setImageSprite = var_8

	var_8(arg_24_1:Find("icon"), var_24_5)

	onButton = var_8

	local var_24_6 = arg_24_0
	local var_24_7 = arg_24_1
	local var_24_8 = arg_24_1.Find(var_24_7, "icon")

	local function var_24_9()
		if not arg_24_0.bubblesPosList or #arg_24_0.bubblesPosList <= 0 then
			return
		end

		local var_25_0 = arg_24_0.activity

		if var_0.HasMaxGold(var_25_0) then
			pg = var_0

			local var_25_1 = var_0.MsgboxMgr.GetInstance()
			local var_25_2 = var_0.ShowMsgBox

			var_2_10003 = {}
			i18n = var_2_10004
			var_2_10003.content = var_2_10004("LiquorFloor_gold_max_tip")

			function var_2_10003.onYes()
				local var_26_0 = arg_24_0
				local var_26_1 = var_0.emit

				LiquorFloorMapMediator = var_3_10003

				var_26_1(var_26_0, var_3_10003.CLICK_BUBBLE, arg_24_0.bubblesPosList)

				return
			end

			var_25_2(var_25_1, var_2_10003)
		else
			local var_25_3 = arg_24_0
			local var_25_4 = var_0.emit

			LiquorFloorMapMediator = var_2_10003

			var_25_4(var_25_3, var_2_10003.CLICK_BUBBLE, arg_24_0.bubblesPosList)
		end

		return
	end

	SFX_PANEL = var_24_7

	var_8(var_24_6, var_24_8, var_24_9, var_24_7)

	return
end

function var_0_1.Onstory(arg_27_0)
	if not #arg_27_0.storyList or #arg_27_0.storyList == 0 then
		return
	end

	pg = var_1

	local var_27_0 = var_1.NewStoryMgr.GetInstance()

	var_1.SeriesPlay(var_27_0, arg_27_0.storyList)

	return
end

function var_0_1.CleanSpines(arg_28_0)
	if arg_28_0.spineRoles then
		table = var_1

		var_1.Foreach(arg_28_0.spineRoles, function(arg_29_0, arg_29_1)
			arg_29_1:Dispose()

			return
		end)
	end

	arg_28_0.spineRoles = {}

	return
end

function var_0_1.InitData(arg_30_0)
	local var_30_0 = arg_30_0.activity
	local var_30_1 = var_1.GetPlaceList(var_30_0)
	local var_30_2 = arg_30_0.activity

	arg_30_0.shipIds = var_2.GetShipIds(var_30_2)

	arg_30_0:AchitectureMessage(var_30_1)
	arg_30_0:OnLV()
	arg_30_0:UpdateGold()

	local var_30_3 = arg_30_0.activity
	local var_30_4 = var_2.getConfig(var_30_3, "config_client")

	SetActive = var_30_0

	local var_30_5 = arg_30_0.ui
	local var_30_6 = var_5.Find(var_30_5, "Allgold/tip")

	LiquorFloorMapScene = var_1_10006

	var_30_0(var_30_6, var_1_10006.GetLiquorFloorMapTip())

	return
end

function var_0_1.OnPlaceDes(arg_31_0)
	local var_31_0
	local var_31_1 = arg_31_0.activity
	local var_31_2 = var_2.GetPlaceList(var_31_1)
	local var_31_3 = arg_31_0.uilistPlace

	var_2.make(var_31_3, function(arg_32_0, arg_32_1, arg_32_2)
		UIItemList = var_2_10003

		if arg_32_0 == var_2_10003.EventUpdate then
			local var_32_0 = arg_31_0

			var_3.UpdatePlace(var_32_0, arg_32_1, arg_32_2, var_31_2)
		end

		return
	end)

	local var_31_4 = arg_31_0.uilistPlace

	var_2.align(var_31_4, #var_31_2)

	return
end

function var_0_1.UpdatePlace(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = arg_33_1 + 1

	pg = i

	local var_33_1 = var_4.TimeMgr.GetInstance()

	arg_33_0._subTime = var_4.GetServerTime(var_33_1)
	i = var_4

	local var_33_2 = arg_33_3[var_4]

	if var_4.GetType(var_33_2) == 1 then
		SetActive = var_33_6

		local var_33_3 = arg_33_0.architectureData

		i = var_1_10007

		local var_33_4 = var_33_3[var_1_10007]

		var_33_6(var_6.Find(var_33_4, "tip"), false)

		i = var_33_6

		local var_33_5 = arg_33_3[var_33_6]
		local var_33_6 = var_33_6.OnStartTime(var_33_5)

		i = var_1_10005
		var_1_10007 = arg_33_3[var_1_10005]

		if not (var_33_6 < var_5.GetTypeParam(var_1_10007) * 7200) then
			i = var_33_6

			local var_33_7 = arg_33_3[var_33_6]

			if var_33_6.GetTypeParam(var_33_7) == 0 then
				setImageSprite = var_33_6

				local var_33_8 = arg_33_0.architectureData

				i = var_1_10007

				local var_33_9 = var_33_8[var_1_10007]
				local var_33_10 = var_6.Find(var_33_9, "numbg/icon1")

				LoadSprite = var_1_10007

				var_33_6(var_33_10, var_1_10007("ui/LiquorFloorUI_atlas", "settleGold_1"), true)
			else
				i = var_33_6

				local var_33_11 = arg_33_3[var_33_6]

				var_33_6 = var_33_6.OnStartTime(var_33_11)
				i = var_5
				var_1_10007 = arg_33_3[var_5]

				if var_5.GetTypeParam(var_1_10007) * 7200 < var_33_6 then
					i = var_33_6

					local var_33_12 = arg_33_3[var_33_6]

					var_33_6 = var_33_6.OnStartTime(var_33_12)
					i = var_5
					var_1_10007 = arg_33_3[var_5]

					if var_33_6 < var_5.GetTypeParam(var_1_10007) * 14400 then
						setImageSprite = var_33_6

						local var_33_13 = arg_33_0.architectureData

						i = var_1_10007

						local var_33_14 = var_33_13[var_1_10007]
						local var_33_15 = var_6.Find(var_33_14, "numbg/icon1")

						LoadSprite = var_1_10007

						var_33_6(var_33_15, var_1_10007("ui/LiquorFloorUI_atlas", "settleGold_2"), true)

						goto label_33_0
					end
				end

				i = var_33_6

				local var_33_16 = arg_33_3[var_33_6]

				var_33_6 = var_33_6.OnStartTime(var_33_16)
				i = var_5
				var_1_10007 = arg_33_3[var_5]

				if var_33_6 > var_5.GetTypeParam(var_1_10007) * 14400 then
					SetActive = var_33_6

					local var_33_17 = arg_33_0.architectureData

					i = var_1_10007

					local var_33_18 = var_33_17[var_1_10007]

					var_33_6(var_6.Find(var_33_18, "tip"), true)

					setImageSprite = var_33_6

					local var_33_19 = arg_33_0.architectureData

					i = var_1_10007

					local var_33_20 = var_33_19[var_1_10007]
					local var_33_21 = var_6.Find(var_33_20, "numbg/icon1")

					LoadSprite = var_1_10007

					var_33_6(var_33_21, var_1_10007("ui/LiquorFloorUI_atlas", "settleGold_3"), true)
				end
			end

			::label_33_0::

			i = var_33_6

			local var_33_22 = arg_33_3[var_33_6]

			if var_4.OnStartTime(var_33_22) <= 0 then
				setText = var_4

				var_4(arg_33_2:Find("numbg/Text"), "0")
			else
				setText = var_4

				local var_33_23 = arg_33_2:Find("numbg/Text")

				TownActivity2 = var_1_10007

				local var_33_24 = var_1_10007.GoldToShow

				i = var_9

				local var_33_25 = arg_33_3[var_9]

				var_4(var_33_23, var_33_24(var_9.OnStartTime(var_33_25)))
			end

			return
		end
	end
end

function var_0_1.AchitectureMessage(arg_34_0, arg_34_1)
	for iter_34_0 = 1, #arg_34_1 do
		setText = var_1_10006

		local var_34_0 = arg_34_0.architectureData[iter_34_0]
		local var_34_1 = var_8.Find(var_34_0, "lv")
		local var_34_2 = arg_34_1[iter_34_0]

		var_1_10006(var_34_1, var_9.GetLevel(var_34_2))

		setText = var_1_10006

		local var_34_3 = arg_34_0.architectureData[iter_34_0]
		local var_34_4 = var_8.Find(var_34_3, "name")
		local var_34_5 = arg_34_1[iter_34_0]

		var_1_10006(var_34_4, var_9.GetName(var_34_5))

		local var_34_6 = arg_34_1[iter_34_0]

		if var_1_10006.GetType(var_34_6) == 1 then
			local var_34_7 = arg_34_1[iter_34_0]

			if var_1_10006.GetLevel(var_34_7) > 0 then
				SetActive = var_1_10006

				local var_34_8 = arg_34_0.architectureData[iter_34_0]

				var_1_10006(var_8.Find(var_34_8, "numbg"), true)

				onButton = var_1_10006

				local var_34_9 = arg_34_0

				var_34_5 = arg_34_0.architectureData[iter_34_0]

				local var_34_10 = var_9.Find(var_34_5, "numbg")

				local function var_34_11()
					local var_35_0 = arg_34_1[iter_34_0]

					if var_0.OnStartTime(var_35_0) <= 0 then
						return
					end

					local var_35_1 = arg_34_0.activity

					if var_0.HasMaxGold(var_35_1) then
						pg = var_0

						local var_35_2 = var_0.MsgboxMgr.GetInstance()
						local var_35_3 = var_0.ShowMsgBox

						var_2_10003 = {}
						i18n = var_2_10004
						var_2_10003.content = var_2_10004("LiquorFloor_gold_max_tip")

						var_35_3(var_35_2, var_2_10003)
					else
						local var_35_4 = arg_34_0
						local var_35_5 = var_0.emit

						LiquorFloorMapMediator = var_2_10003

						local var_35_6 = var_2_10003.ADD_WORKPLACE
						local var_35_7 = arg_34_1[iter_34_0]

						var_35_5(var_35_4, var_35_6, var_4.GetId(var_35_7))
					end

					return
				end

				SFX_CANCEL = var_34_5

				var_1_10006(var_34_9, var_34_10, var_34_11, var_34_5)

				goto label_34_0
			end
		end

		SetActive = var_1_10006

		do
			local var_34_12 = arg_34_0.architectureData[iter_34_0]

			var_1_10006(var_8.Find(var_34_12, "numbg"), false)
		end

		::label_34_0::

		onButton = var_1_10006

		local var_34_13 = arg_34_0
		local var_34_14 = arg_34_0.architectureData[iter_34_0]

		local function var_34_15()
			SetActive = var_2_10000

			var_2_10000(arg_34_0.box, true)

			setAnchoredPosition = var_2_10000

			var_2_10000(arg_34_0.box, var_0_1.TOP_POS[iter_34_0])

			local var_36_0 = arg_34_0

			var_0.OnBox(var_36_0, arg_34_1[iter_34_0], iter_34_0, arg_34_0.activity)

			return
		end

		SFX_CANCEL = var_34_5

		var_1_10006(var_34_13, var_34_14, var_34_15, var_34_5)
	end

	arg_34_0:OnMap()

	return
end

function var_0_1.OnMap(arg_37_0)
	local var_37_0 = arg_37_0.activity
	local var_37_1 = var_1.GetPlaceList(var_37_0)

	for iter_37_0 = 1, #var_37_1 do
		local var_37_2 = var_37_1[iter_37_0]

		var_1_10006 = var_1_10006.GetIcon(var_37_2)
		setImageSprite = var_1_10007

		local var_37_3 = arg_37_0.architectureMapData[iter_37_0]

		LoadSprite = var_1_10010

		var_1_10007(var_37_3, var_1_10010("ui/LiquorFloorUI_atlas", var_1_10006))
	end

	local var_37_4 = arg_37_0.activity

	if var_2.TownLevel(var_37_4) >= 0 and var_2 <= 3 then
		setImageSprite = var_3

		local var_37_5 = arg_37_0._tf
		local var_37_6 = var_5.Find(var_37_5, "bgs")

		LoadSprite = var_1_10006

		var_3(var_37_6, var_1_10006("ui/LiquorFloorUI_atlas", "bg1"), true)
	elseif var_2 > 3 and var_2 <= 7 then
		setImageSprite = var_3

		local var_37_7 = arg_37_0._tf
		local var_37_8 = var_5.Find(var_37_7, "bgs")

		LoadSprite = var_1_10006

		var_3(var_37_8, var_1_10006("ui/LiquorFloorUI_atlas", "bg2"), true)
	elseif var_2 > 7 and var_2 <= 10 then
		setImageSprite = var_3

		local var_37_9 = arg_37_0._tf
		local var_37_10 = var_5.Find(var_37_9, "bgs")

		LoadSprite = var_1_10006

		var_3(var_37_10, var_1_10006("ui/LiquorFloorUI_atlas", "bg3"), true)
	end

	return
end

function var_0_1.UpdateGold(arg_38_0)
	TownActivity2 = var_1_10001

	local var_38_0 = var_1_10001.GoldToShow
	local var_38_1 = arg_38_0.activity
	local var_38_2 = var_38_0(var_3.GetGold(var_38_1))
	local var_38_3 = arg_38_0.top
	local var_38_4 = var_2.Find(var_38_3, "res/gold1/Text")
	local var_38_5 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007

	local var_38_6 = var_38_5(var_38_4, var_5(var_1_10007))
	local var_38_7 = var_38_2
	local var_38_8 = "/"

	TownActivity2 = var_5

	local var_38_9 = var_5.GoldToShow
	local var_38_10 = arg_38_0.activity

	var_38_6.text = var_38_7 .. var_38_8 .. var_38_9(var_7.GetLimitGold(var_38_10))
	setText = var_38_6

	local var_38_11 = arg_38_0.top
	local var_38_12 = var_4.Find(var_38_11, "res/gold2/Text")
	local var_38_13 = " "

	TownActivity2 = var_38_11

	local var_38_14 = var_38_11.GoldToShow
	local var_38_15 = arg_38_0.activity

	var_38_6(var_38_12, var_38_13 .. var_38_14(var_8.GetGold2(var_38_15)))

	return
end

function var_0_1.OnLV(arg_39_0)
	local var_39_0 = arg_39_0.activity
	local var_39_1 = var_1.TownLevel(var_39_0)
	local var_39_5

	if #arg_39_0.activity.listLVList2 + 1 <= var_39_1 then
		setFillAmount = var_39_5

		local var_39_2 = arg_39_0.lv

		var_39_5(var_4.Find(var_39_2, "Slider"), 1)

		SetActive = var_39_5

		local var_39_3 = arg_39_0.lv

		var_39_5(var_4.Find(var_39_3, "num_bg"), false)
	else
		setFillAmount = var_39_5

		local var_39_4 = arg_39_0.lv

		var_39_5(var_4.Find(var_39_4, "Slider"), var_39_1 / arg_39_0.activity.listLVList[var_39_1])

		var_39_5 = nil

		if arg_39_0.activity.listLVList2[var_39_1 - 1] then
			local var_39_6 = arg_39_0.activity

			var_39_5 = var_3.GetPtAllGold(var_39_6) - arg_39_0.activity.listLVList2[var_39_1 - 1]
		else
			local var_39_7 = arg_39_0.activity

			var_39_5 = var_3.GetPtAllGold(var_39_7)
		end

		setText = var_3

		local var_39_8 = arg_39_0.lv
		local var_39_9 = var_5.Find(var_39_8, "num_bg/num")

		TownActivity2 = var_39_4

		local var_39_10 = var_39_4.GoldToShow(var_39_5)
		local var_39_11 = "/"

		TownActivity2 = var_8

		var_3(var_39_9, var_39_10 .. var_39_11 .. var_8.GoldToShow(arg_39_0.activity.listLVList[var_39_1]))
	end

	setText = var_39_5

	local var_39_12 = arg_39_0.lv

	var_39_5(var_4.Find(var_39_12, "Lv_bg/Text"), var_39_1)

	setText = var_39_5

	local var_39_13 = arg_39_0.ui
	local var_39_14 = var_4.Find(var_39_13, "LV/lvbtn/Text")

	i18n = var_5

	var_39_5(var_39_14, var_5("LiquorFloor_level"))

	return
end

function var_0_1.OnUpgradeMoveLV(arg_40_0)
	local var_40_0 = arg_40_0.activity
	local var_40_1 = var_1.GetTownLevel(var_40_0)

	setText = var_1_10002

	var_1_10002(arg_40_0.Text_new, var_40_1)

	SetActive = var_1_10002

	var_1_10002(arg_40_0.Text_new, true)

	LeanTween = var_1_10002

	local var_40_2 = var_1_10002.move
	local var_40_3 = arg_40_0.Text_new

	Vector3 = var_5

	local var_40_4 = var_40_2(var_40_3, var_5(0, 0, 0), 1)
	local var_40_5 = var_2.setOnComplete

	System = var_5

	var_40_5(var_40_4, var_5.Action(function()
		local var_41_0 = arg_40_0

		var_0.OnLV(var_41_0)

		return
	end))

	return
end

function var_0_1.OnBox(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	if arg_42_1:GetType() == 1 then
		SetActive = var_4

		local var_42_0 = arg_42_0.box

		var_4(var_6.Find(var_42_0, "role_bg"), false)
	elseif arg_42_1:GetType() == 3 then
		SetActive = var_4

		local var_42_1 = arg_42_0.box

		var_4(var_6.Find(var_42_1, "role_bg"), true)
		arg_42_0:OnRole_bg(arg_42_1)
	else
		SetActive = var_4

		local var_42_2 = arg_42_0.box

		var_4(var_6.Find(var_42_2, "role_bg"), false)
	end

	setText = var_4

	local var_42_3 = arg_42_0.box

	var_4(var_6.Find(var_42_3, "box_bg/lv"), arg_42_1:GetLevel())

	setText = var_4

	local var_42_4 = arg_42_0.box

	var_4(var_6.Find(var_42_4, "box_bg/name"), arg_42_1:GetName())

	setText = var_4

	local var_42_5 = arg_42_0.box

	var_4(var_6.Find(var_42_5, "box_bg/describe"), arg_42_1:GetDesc())

	if arg_42_1:GetType() == 1 then
		setText = var_4
		var_42_5 = arg_42_0.box

		local var_42_6 = var_6.Find(var_42_5, "box_bg/Text")

		i18n = var_7

		var_4(var_42_6, var_7("LiquorFloor_gold"))
	elseif arg_42_1:GetType() == 2 then
		setText = var_4
		var_42_5 = arg_42_0.box

		local var_42_7 = var_6.Find(var_42_5, "box_bg/Text")

		i18n = var_7

		var_4(var_42_7, var_7("LiquorFloor_gold_num"))
	elseif arg_42_1:GetType() == 3 then
		setText = var_4
		var_42_5 = arg_42_0.box

		local var_42_8 = var_6.Find(var_42_5, "box_bg/Text")

		i18n = var_7

		var_4(var_42_8, var_7("LiquorFloor_character_num"))
	end

	local var_42_9 = arg_42_3
	local var_42_10 = arg_42_3.GetGoldOutput(var_42_9)

	setText = var_1_10005

	local var_42_11 = arg_42_0.box
	local var_42_12 = var_7.Find(var_42_11, "box_bg/num")

	TownActivity2 = var_42_5

	var_1_10005(var_42_12, var_42_5.GoldToShow(arg_42_1:GetTypeParam(var_42_10)))

	if arg_42_0:OnNextArchitecture(arg_42_1:GetId()) == 0 then
		SetActive = var_42_9

		local var_42_13 = arg_42_0.box

		var_42_9(var_8.Find(var_42_13, "box_bg/num_1"), false)

		SetActive = var_42_9

		local var_42_14 = arg_42_0.box

		var_42_9(var_8.Find(var_42_14, "box_bg/decorate2"), false)
	else
		setText = var_42_9

		local var_42_15 = arg_42_0.box
		local var_42_16 = var_8.Find(var_42_15, "box_bg/num_1")

		TownActivity2 = var_42_11

		var_42_9(var_42_16, var_42_11.GoldToShow(var_5))
	end

	local var_42_17 = arg_42_1:GetNeedTownLv()
	local var_42_18 = arg_42_3

	if var_42_17 <= arg_42_3.TownLevel(var_42_18) and #arg_42_1:GetUpgrade() ~= 0 then
		SetActive = var_8

		local var_42_19 = arg_42_0.box

		var_8(var_10.Find(var_42_19, "box_bg/num"), true)

		SetActive = var_8

		local var_42_20 = arg_42_0.box

		var_8(var_10.Find(var_42_20, "box_bg/decorate2"), true)

		SetActive = var_8

		local var_42_21 = arg_42_0.box

		var_8(var_10.Find(var_42_21, "box_bg/num_1"), true)

		SetActive = var_8

		local var_42_22 = arg_42_0.box

		var_8(var_10.Find(var_42_22, "box_bg/btn_lock"), false)

		SetActive = var_8

		local var_42_23 = arg_42_0.box

		var_8(var_10.Find(var_42_23, "box_bg/upgrade"), true)

		local var_42_24 = arg_42_1
		local var_42_25 = arg_42_1.GetUpgrade(var_42_24)

		setText = var_42_18

		local var_42_26 = arg_42_0.box
		local var_42_27 = var_11.Find(var_42_26, "box_bg/upgrade/name")

		i18n = var_42_23

		var_42_18(var_42_27, var_42_23("LiquorFloor_update"))

		var_42_18 = arg_42_3:GetUpgradeGold(arg_42_1:GetId())
		setText = var_42_24

		local var_42_28 = arg_42_0.box
		local var_42_29 = var_12.Find(var_42_28, "box_bg/upgrade/num1")

		TownActivity2 = var_42_26

		var_42_24(var_42_29, var_42_26.GoldToShow(var_42_18[1][3]))

		SetActive = var_42_24

		local var_42_30 = arg_42_0.box

		var_42_24(var_12.Find(var_42_30, "box_bg/num_man"), false)

		if #var_42_18 == 1 then
			SetActive = var_10

			local var_42_31 = arg_42_0.box

			var_10(var_12.Find(var_42_31, "box_bg/upgrade/icon2"), false)

			SetActive = var_10

			local var_42_32 = arg_42_0.box

			var_10(var_12.Find(var_42_32, "box_bg/upgrade/num2"), false)
		else
			SetActive = var_10

			local var_42_33 = arg_42_0.box

			var_10(var_12.Find(var_42_33, "box_bg/upgrade/icon2"), true)

			SetActive = var_10

			local var_42_34 = arg_42_0.box

			var_10(var_12.Find(var_42_34, "box_bg/upgrade/num2"), true)

			setText = var_10

			local var_42_35 = arg_42_0.box
			local var_42_36 = var_12.Find(var_42_35, "box_bg/upgrade/num2")

			TownActivity2 = var_13

			var_10(var_42_36, var_13.GoldToShow(var_42_18[2][3]))
		end

		local var_42_37 = arg_42_3
		local var_42_38 = arg_42_3.UpgradeGold
		local var_42_39 = arg_42_1

		if var_42_38(var_42_37, arg_42_1.GetId(var_42_39)) then
			local var_42_40 = arg_42_0.box
			local var_42_41 = var_10.Find(var_42_40, "box_bg/upgrade")
			local var_42_42 = var_10.GetComponent

			typeof = var_13
			Button = var_42_39

			local var_42_43 = var_42_42(var_42_41, var_13(var_42_39))

			var_42_43.interactable = true
			onButton = var_42_43

			local var_42_44 = arg_42_0

			var_42_39 = arg_42_0.box

			local var_42_45 = var_13.Find(var_42_39, "box_bg/upgrade")

			local function var_42_46()
				local var_43_0 = arg_42_0
				local var_43_1 = var_0.emit

				LiquorFloorMapMediator = var_2_10003

				local var_43_2 = var_2_10003.UPGRADE_WORKPLACE
				local var_43_3 = arg_42_1

				var_43_1(var_43_0, var_43_2, var_4.GetId(var_43_3), arg_42_1, arg_42_2)

				return
			end

			SFX_CANCEL = var_42_39

			var_42_43(var_42_44, var_42_45, var_42_46, var_42_39)
		else
			local var_42_47 = arg_42_0.box
			local var_42_48 = var_10.Find(var_42_47, "box_bg/upgrade")
			local var_42_49 = var_10.GetComponent

			typeof = var_13
			Button = var_42_39
			var_42_49(var_42_48, var_13(var_42_39)).interactable = false
		end
	else
		local var_42_58

		if #arg_42_1:GetUpgrade() == 0 and var_42_17 == 0 then
			SetActive = var_42_58

			local var_42_50 = arg_42_0.box

			var_42_58(var_10.Find(var_42_50, "box_bg/num"), false)

			SetActive = var_42_58

			local var_42_51 = arg_42_0.box

			var_42_58(var_10.Find(var_42_51, "box_bg/decorate2"), false)

			SetActive = var_42_58

			local var_42_52 = arg_42_0.box

			var_42_58(var_10.Find(var_42_52, "box_bg/num_1"), false)

			SetActive = var_42_58

			local var_42_53 = arg_42_0.box

			var_42_58(var_10.Find(var_42_53, "box_bg/upgrade"), false)

			SetActive = var_42_58

			local var_42_54 = arg_42_0.box

			var_42_58(var_10.Find(var_42_54, "box_bg/btn_lock/icon"), false)

			SetActive = var_42_58

			local var_42_55 = arg_42_0.box

			var_42_58(var_10.Find(var_42_55, "box_bg/btn_lock"), true)

			SetActive = var_42_58

			local var_42_56 = arg_42_0.box

			var_42_58(var_10.Find(var_42_56, "box_bg/btn_lock/name"), true)

			SetActive = var_42_58

			local var_42_57 = arg_42_0.box

			var_42_58(var_10.Find(var_42_57, "box_bg/num_man"), true)

			var_42_58 = arg_42_3:GetGoldOutput()
			setText = var_42_18

			local var_42_59 = arg_42_0.box
			local var_42_60 = var_11.Find(var_42_59, "box_bg/num_man")

			TownActivity2 = var_42_57

			var_42_18(var_42_60, var_42_57.GoldToShow(arg_42_1:GetTypeParam(var_42_58)))

			setText = var_42_18

			local var_42_61 = arg_42_0.box
			local var_42_62 = var_11.Find(var_42_61, "box_bg/btn_lock/name")

			i18n = var_12

			var_42_18(var_42_62, var_12("LiquorFloor_update_max"))
		else
			SetActive = var_42_58

			local var_42_63 = arg_42_0.box

			var_42_58(var_10.Find(var_42_63, "box_bg/num_man"), false)

			SetActive = var_42_58

			local var_42_64 = arg_42_0.box

			var_42_58(var_10.Find(var_42_64, "box_bg/btn_lock"), true)

			SetActive = var_42_58

			local var_42_65 = arg_42_0.box

			var_42_58(var_10.Find(var_42_65, "box_bg/upgrade"), false)

			setText = var_42_58

			local var_42_66 = arg_42_0.box
			local var_42_67 = var_10.Find(var_42_66, "box_bg/btn_lock/name")

			i18n = var_11

			var_42_58(var_42_67, var_11("LiquorFloor_update_unlock", var_42_17))
		end
	end

	return
end

function var_0_1.OnRole_bg(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_0.box

	arg_44_0.items = var_2.Find(var_44_0, "role_bg/list")

	local var_44_1 = arg_44_0.items

	arg_44_0.item = var_2.Find(var_44_1, "bg")
	UIItemList = var_2
	arg_44_0.uilist = var_2.New(arg_44_0.items, arg_44_0.item)
	setActive = var_2

	var_2(arg_44_0.item, false)

	local var_44_2 = arg_44_0.uilist

	var_2.make(var_44_2, function(arg_45_0, arg_45_1, arg_45_2)
		UIItemList = var_2_10003

		if arg_45_0 == var_2_10003.EventUpdate then
			local var_45_0 = arg_44_0
			local var_45_1 = var_3.UpdateTask
			local var_45_2 = arg_45_1
			local var_45_3 = arg_45_2
			local var_45_4 = arg_44_1
			local var_45_5 = var_8.GetTypeParam(var_45_4)
			local var_45_6 = arg_44_0
			local var_45_7 = var_9.OnNextArchitecture
			local var_45_8 = arg_44_1

			var_45_1(var_45_0, var_45_2, var_45_3, var_45_5, var_45_7(var_45_6, var_12.GetId(var_45_8)), arg_44_1)
		end

		return
	end)

	local var_44_3 = arg_44_0.uilist

	var_2.align(var_44_3, 9)

	setText = var_2

	local var_44_4 = arg_44_0.box
	local var_44_5 = var_4.Find(var_44_4, "role_bg/rule1")

	i18n = var_5

	var_2(var_44_5, var_5("LiquorFloor_character_tip"))

	return
end

function var_0_1.UpdateTask(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4, arg_46_5)
	local var_46_0 = arg_46_1 + 1

	if not arg_46_5:GetUpgrade() or #arg_46_5:GetUpgrade() == 0 then
		SetActive = var_7

		var_7(arg_46_2:Find("icon"), false)

		SetActive = var_7

		var_7(arg_46_2:Find("Text"), false)

		SetActive = var_7

		var_7(arg_46_2:Find("btn"), false)
	else
		SetActive = var_7

		var_7(arg_46_2:Find("icon"), false)

		SetActive = var_7

		var_7(arg_46_2:Find("Text"), var_46_0 == arg_46_4)
	end

	setButtonEnabled = var_7

	var_7(arg_46_2, var_46_0 < arg_46_4 or arg_46_4 == -1)

	SetActive = var_7

	var_7(arg_46_2:Find("btn"), var_46_0 < arg_46_4 or arg_46_4 == -1)

	if var_46_0 < arg_46_4 and arg_46_4 == -1 then
		SetActive = var_7

		var_7(arg_46_2:Find("Text"), false)
	elseif var_46_0 == arg_46_4 then
		SetActive = var_7

		var_7(arg_46_2:Find("Text"), true)

		setText = var_7

		local var_46_1 = arg_46_2:Find("Text")

		i18n = var_10

		var_7(var_46_1, var_10("LiquorFloor_character_unlock", arg_46_4))
	else
		SetActive = var_7

		var_7(arg_46_2:Find("Text"), false)
	end

	LoadSprite = var_7

	local var_46_2 = var_7("ui/LiquorFloorUI_atlas", "box_decorate1")

	setImageSprite = var_1_10008

	var_1_10008(arg_46_2:Find("btn"), var_46_2, true)

	local var_46_3 = arg_46_0.shipIds[var_46_0]
	local var_46_4

	if arg_46_0.shipIds[var_46_0] then
		getProxy = var_10
		BayProxy = var_12

		local var_46_5 = var_10(var_12)

		if var_10.RawGetShipById(var_46_5, var_46_3) then
			LoadSprite = var_11

			local var_46_6 = var_11("qicon/" .. var_10:getPainting())

			setImageSprite = var_46_5

			var_46_5(arg_46_2:Find("btn"), var_46_6, true)
		end
	end

	onButton = var_10

	local var_46_7 = arg_46_0
	local var_46_8 = arg_46_2

	local function var_46_9()
		local var_47_0 = arg_46_0
		local var_47_1 = var_0.emit

		LiquorFloorMapMediator = var_2_10003

		local var_47_2 = var_2_10003.OPEN_CHUANWU
		local var_47_3 = var_46_0
		local var_47_4 = var_46_4
		local var_47_5 = arg_46_5

		var_47_1(var_47_0, var_47_2, var_47_3, var_47_4, var_6.GetId(var_47_5))

		return
	end

	SFX_CANCEL = var_1_10015

	var_10(var_46_7, var_46_8, var_46_9, var_1_10015)

	return
end

function var_0_1.OnNextArchitecture(arg_48_0, arg_48_1)
	pg = var_1_10002

	if var_1_10002.activity_town_work_level_2[arg_48_1 + 1] then
		pg = var_2

		return var_2.activity_town_work_level_2[arg_48_1 + 1].type_param
	end

	return -1
end

function var_0_1.willExit(arg_49_0)
	if arg_49_0.timer then
		local var_49_0 = arg_49_0.timer

		var_1.Stop(var_49_0)

		arg_49_0.timer = nil
	end

	return
end

function var_0_1.RefreshRedPoint(arg_50_0)
	setActive = var_1_10001

	var_1_10001(arg_50_0.taskTip, var_0_1.ShouldShowTaskTip())

	SetActive = var_1_10001

	local var_50_0 = arg_50_0.storyBtn

	var_1_10001(var_3.Find(var_50_0, "tip"), var_0_1.GetCollectionBookTip())

	return
end

function var_0_1.ShouldShowTaskTip()
	ActivityConst = var_1_10000

	local var_51_0 = var_1_10000.ACTIVITY_TYPE_TOWN2

	getProxy = var_1_10001
	TaskProxy = var_1_10003

	local var_51_1 = var_1_10001(var_1_10003)

	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_51_2 = var_1_10002(var_1_10004)
	local var_51_3 = var_2.getActivityByType(var_51_2, var_51_0)
	local var_51_4 = var_2.getConfig(var_51_3, "config_client").taskActivityID

	pg = var_51_2

	local var_51_5 = var_51_2.activity_template[var_51_4].config_data

	ipairs = var_51_3

	for iter_51_0, iter_51_1 in var_51_3(var_51_5) do
		if var_51_1:getTaskVO(iter_51_1) and var_10:getTaskStatus() == 1 then
			return true
		end
	end

	return false
end

function var_0_1.getCollectDataBySiteId(arg_52_0, arg_52_1)
	ipairs = var_1_10002
	pg = var_1_10004

	for iter_52_0, iter_52_1 in var_1_10002(var_1_10004.activity_town_collection_2.all) do
		pg = var_1_10007

		if var_1_10007.activity_town_collection_2[iter_52_1].id == arg_52_1 then
			pg = var_1_10007

			return var_1_10007.activity_town_collection_2[iter_52_1]
		end
	end

	return nil
end

function var_0_1.GetCollectionBookTip()
	ActivityConst = var_1_10000

	local var_53_0 = var_1_10000.ACTIVITY_TYPE_TOWN2

	getProxy = var_1_10001
	TaskProxy = var_1_10003

	local var_53_1 = var_1_10001(var_1_10003)

	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_53_2 = var_1_10002(var_1_10004)
	local var_53_3 = var_2.getActivityByType(var_53_2, var_53_0)
	local var_53_4 = var_2.getConfig(var_53_3, "config_client").BookData

	for iter_53_0 = 1, #var_53_4 do
		getProxy = var_1_10008
		TaskProxy = var_1_10010
		var_1_10010 = var_1_10008(var_1_10010)

		if var_1_10008.getTaskVO(var_1_10010, var_53_4[iter_53_0].task) and var_1_10008:getTaskStatus() == 1 then
			return true
		end
	end

	return false
end

function var_0_1.GetLiquorFloorMapTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_54_0 = var_1_10000(var_1_10002)
	local var_54_1 = var_0.getActivityByType

	ActivityConst = var_1_10003

	local var_54_2 = var_54_1(var_54_0, var_1_10003.ACTIVITY_TYPE_TOWN2)
	local var_54_3 = var_0.GetPlaceList(var_54_2)

	for iter_54_0 = 1, #var_54_3 do
		local var_54_4 = var_54_3[iter_54_0]

		if var_6.GetType(var_54_4) == 1 then
			local var_54_5 = var_54_3[iter_54_0]
			local var_54_6 = var_6.GetLevel(var_54_5)

			if 0 < var_54_6 then
				pg = var_54_6

				local var_54_7 = var_54_6.activity_town_2

				ActivityConst = var_7

				local var_54_8 = var_54_7[var_7.LiquorFloor_ACT_ID].gold_time_limit
				local var_54_9 = var_54_3[iter_54_0]
				local var_54_10 = var_7.OnStartTime(var_54_9)
				local var_54_11 = var_54_3[iter_54_0]

				if var_54_10 >= var_8.GetTypeParam(var_54_11) * var_54_8 then
					return true
				end
			end
		end
	end

	return false
end

return var_0_1
