class = var_0_10000

local var_0_0 = "MemoryBookLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseUI"))
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3

var_0_1.PAGE_ONE = 1
var_0_1.PAGE_TWO = 2

local var_0_5 = 12
local var_0_6 = {
	{
		-503,
		83
	},
	{
		-371.4,
		72.6
	},
	{
		-464,
		-211
	},
	{
		-234.3,
		-176
	},
	{
		-74.5,
		30.1
	},
	{
		80,
		121.5
	},
	{
		80,
		25.4
	},
	{
		80,
		-89
	},
	{
		291,
		25.4
	},
	{
		483,
		-33
	},
	{
		334,
		-246
	},
	{
		483,
		-217.5
	},
	{
		-478.4,
		84.5
	},
	{
		-290,
		44.5
	},
	{
		-137,
		12.5
	},
	{
		100.5,
		92.5
	},
	{
		-364.3,
		-179.6
	},
	{
		-137,
		-176.9
	},
	{
		78,
		-176.9
	},
	{
		247,
		-242
	},
	{
		383,
		33
	},
	{
		548,
		69
	},
	{
		456,
		-184
	},
	{
		573,
		-106
	}
}

local function var_0_7(arg_1_0)
	local var_1_0 = {}

	local function var_1_1(arg_2_0)
		arg_2_0.root = arg_1_0
		arg_2_0.list = {}

		return
	end

	function var_1_0.Get(arg_3_0)
		local var_3_0
		local var_3_2

		if #arg_3_0.list == 0 then
			GameObject = var_3_2

			local var_3_1 = var_3_2("Image")

			var_3_2 = var_3_0.AddComponent
			typeof = var_2_10004
			Image = var_2_10005

			var_3_2(var_3_1, var_2_10004(var_2_10005))
		else
			table = var_3_2
			var_3_0 = var_3_2.remove(arg_3_0.list, #arg_3_0.list)
		end

		setActive = var_3_2

		var_3_2(var_3_0, true)

		return var_3_0
	end

	function var_1_0.Return(arg_4_0, arg_4_1)
		arg_4_0:Clear(arg_4_1)

		setParent = var_2

		var_2(arg_4_1, arg_4_0.root)

		table = var_2

		var_2.insert(arg_4_0.list, arg_4_1)

		return
	end

	function var_1_0.Clear(arg_5_0, arg_5_1)
		local var_5_0 = arg_5_1
		local var_5_1 = arg_5_1.GetComponent

		typeof = var_2_10004
		Image = var_2_10005
		var_5_1(var_5_0, var_2_10004(var_2_10005)).sprite = nil
		setActive = var_3

		var_3(arg_5_1, false)

		return
	end

	function var_1_0.Dispose(arg_6_0)
		_ = var_2_10001

		var_2_10001.each(arg_6_0.list, function(arg_7_0)
			Destroy = var_3_10001

			var_3_10001(arg_7_0)

			return
		end)

		arg_6_0.list = nil

		return
	end

	var_1_1(var_1_0)

	return var_1_0
end

function var_0_1.getUIName(arg_8_0)
	return "MemoryBookUI"
end

function var_0_1.setActivity(arg_9_0, arg_9_1)
	arg_9_0.activity = arg_9_1

	local var_9_0 = arg_9_0.activity

	arg_9_0.targetItems = var_2.getConfig(var_9_0, "config_data")
	arg_9_0.fetchItems = arg_9_0.activity.data1_list
	arg_9_0.unlockItems = arg_9_0.activity.data2_list

	local var_9_1 = arg_9_0.activity

	arg_9_0.awardVO = var_2.getConfig(var_9_1, "config_client")[1]

	return
end

function var_0_1.getMemoryState(arg_10_0, arg_10_1)
	table = var_1_10002

	local var_10_0 = var_1_10002.contains(arg_10_0.fetchItems, arg_10_1)

	table = var_3

	local var_10_1

	if (not var_3.contains(arg_10_0.unlockItems, arg_10_1) or not var_0_4) and (not var_10_0 or not var_0_3) then
		var_10_1 = var_0_2
	end

	return var_10_1
end

function var_0_1.updateMemorys(arg_11_0)
	arg_11_0.memorys = {}
	ipairs = var_1

	for iter_11_0, iter_11_1 in var_1(arg_11_0.targetItems) do
		local var_11_0 = arg_11_0:getMemoryState(iter_11_1)
		local var_11_1 = iter_11_0 % var_0_5

		table = var_8

		local var_11_2 = var_8.insert
		local var_11_3 = arg_11_0.memorys
		local var_11_4 = {
			id = iter_11_1
		}
		local var_11_5

		if var_11_1 ~= 0 or not var_0_5 then
			var_11_5 = var_11_1
		end

		var_11_4.index = var_11_5
		var_11_4.pos = var_0_6[iter_11_0]
		var_11_4.state = var_11_0

		var_11_2(var_11_3, var_11_4)
	end

	local var_11_6

	if not arg_11_0.contextData.page then
		var_11_6 = 1
	end

	arg_11_0:updateMemoryBook(var_11_6, true)

	return
end

function var_0_1.init(arg_12_0)
	local var_12_0 = arg_12_0._tf

	arg_12_0.backBtn = var_1.Find(var_12_0, "back_btn")

	local var_12_1 = arg_12_0._tf

	arg_12_0.page1 = var_1.Find(var_12_1, "page1")

	local var_12_2 = arg_12_0._tf

	arg_12_0.page2 = var_1.Find(var_12_2, "page2")

	local var_12_3 = arg_12_0._tf
	local var_12_4 = var_1.Find(var_12_3, "get")

	setActive = var_12_3

	var_12_3(var_12_4, false)

	local var_12_5 = var_12_4
	local var_12_6 = var_12_4.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_12_0.getSprite = var_12_6(var_12_5, var_4(var_1_10005)).sprite

	local var_12_7 = arg_12_0._tf
	local var_12_8 = var_2.Find(var_12_7, "slider")
	local var_12_9 = var_2.GetComponent

	typeof = var_4
	Slider = var_1_10005
	arg_12_0.slider = var_12_9(var_12_8, var_4(var_1_10005))

	local var_12_10 = arg_12_0._tf
	local var_12_11 = var_2.Find(var_12_10, "progress")
	local var_12_12 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_12_0.totalTxt = var_12_12(var_12_11, var_4(var_1_10005))

	local var_12_13 = arg_12_0._tf
	local var_12_14 = var_2.Find(var_12_13, "progress/value")
	local var_12_15 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_12_0.currValueTxt = var_12_15(var_12_14, var_4(var_1_10005))

	local var_12_16 = arg_12_0._tf

	arg_12_0.awardIcon = var_2.Find(var_12_16, "award_bg/icon")

	local var_12_17 = arg_12_0._tf

	arg_12_0.awardLabel = var_2.Find(var_12_17, "award_bg/label")

	local var_12_18 = arg_12_0._tf

	arg_12_0.awardLabelGot = var_2.Find(var_12_18, "award_bg/label_got")

	local var_12_19 = arg_12_0._tf

	arg_12_0.helpBtn = var_2.Find(var_12_19, "help")
	arg_12_0.pool = var_0_7(arg_12_0._tf)

	return
end

function var_0_1.didEnter(arg_13_0)
	arg_13_0:addRingDragListenter()

	onButton = var_1

	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.backBtn

	local function var_13_2()
		local var_14_0 = arg_13_0

		var_0.emit(var_14_0, var_0_1.ON_CLOSE)

		return
	end

	SOUND_BACK = var_1_10005

	var_1(var_13_0, var_13_1, var_13_2, var_1_10005)

	onButton = var_1

	local var_13_3 = arg_13_0
	local var_13_4 = arg_13_0.helpBtn

	local function var_13_5()
		pg = var_2_10000

		local var_15_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_15_1 = var_0.ShowMsgBox
		local var_15_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_15_2.type = var_2_10003
		pg = var_2_10003
		var_15_2.helps = var_2_10003.gametip.memorybook_notice.tip

		var_15_1(var_15_0, var_15_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_13_3, var_13_4, var_13_5, var_1_10005)

	onButton = var_1

	local var_13_6 = arg_13_0
	local var_13_7 = arg_13_0.page1
	local var_13_8 = var_3.Find(var_13_7, "switch")

	local function var_13_9()
		local var_16_0 = arg_13_0

		var_0.updateMemoryBook(var_16_0, var_0_1.PAGE_TWO)

		return
	end

	SFX_PANEL = var_5

	var_1(var_13_6, var_13_8, var_13_9, var_5)

	onButton = var_1

	local var_13_10 = arg_13_0
	local var_13_11 = arg_13_0.page2
	local var_13_12 = var_3.Find(var_13_11, "switch")

	local function var_13_13()
		local var_17_0 = arg_13_0

		var_0.updateMemoryBook(var_17_0, var_0_1.PAGE_ONE)

		return
	end

	SFX_PANEL = var_5

	var_1(var_13_10, var_13_12, var_13_13, var_5)

	arg_13_0.sprites = {}
	arg_13_0.gameObjects = {}

	arg_13_0:updateMemorys()
	arg_13_0:updateProgress()

	return
end

function var_0_1.getStartAndEndIndex(arg_18_0, arg_18_1)
	local var_18_0 = (arg_18_1 - 1) * var_0_5 + 1 + var_0_5 - 1

	return var_2, var_18_0
end

function var_0_1.updateMemoryBook(arg_19_0, arg_19_1, arg_19_2)
	ipairs = var_1_10003

	for iter_19_0, iter_19_1 in var_1_10003(arg_19_0.gameObjects) do
		local var_19_0 = arg_19_0.pool

		var_8.Return(var_19_0, iter_19_1)
	end

	arg_19_0.gameObjects = {}

	local var_19_1 = arg_19_0["page" .. arg_19_1]
	local var_19_2, var_19_3 = arg_19_0:getStartAndEndIndex(arg_19_1)

	for iter_19_2 = var_19_2, var_19_3 do
		local var_19_4 = arg_19_0.memorys[iter_19_2]

		arg_19_0:updateMemoryItem(arg_19_1, var_19_4)
	end

	local var_19_5 = false

	if arg_19_1 == var_0_1.PAGE_ONE then
		var_19_5 = arg_19_0:updatePageTip(var_0_1.PAGE_TWO)
	elseif arg_19_1 == var_0_1.PAGE_TWO then
		var_19_5 = arg_19_0:updatePageTip(var_0_1.PAGE_ONE)
	end

	setActive = var_7

	var_7(var_19_1:Find("switch/tip"), var_19_5)

	arg_19_0.page = arg_19_1
	arg_19_0.contextData.page = arg_19_1

	if arg_19_2 then
		if arg_19_1 == var_0_1.PAGE_TWO then
			local var_19_6 = arg_19_0.page2
			local var_19_7 = var_7.Find(var_19_6, "switch")
			local var_19_8 = arg_19_0.page2

			Vector3 = var_9
			var_19_8.localPosition = var_9.New(0, 0)

			local var_19_9 = arg_19_0.page1

			Vector3 = var_9
			var_19_9.localPosition = var_9.New(-1280, 0)
			setActive = var_19_9

			var_19_9(var_19_7, true)
		else
			local var_19_10 = arg_19_0.page1
			local var_19_11 = var_7.Find(var_19_10, "switch")
			local var_19_12 = arg_19_0.page2

			Vector3 = var_9
			var_19_12.localPosition = var_9.New(1280, 0)

			local var_19_13 = arg_19_0.page1

			Vector3 = var_9
			var_19_13.localPosition = var_9.New(0, 0)
			setActive = var_19_13

			var_19_13(var_19_11, true)
		end
	elseif arg_19_1 == var_0_1.PAGE_TWO then
		local var_19_14 = arg_19_0.page2
		local var_19_15 = var_7.Find(var_19_14, "switch")

		setActive = var_19_14

		var_19_14(var_19_15, false)

		local var_19_16 = arg_19_0.page2

		Vector3 = var_9
		var_19_16.localPosition = var_9.New(1280, 0)

		local var_19_17 = arg_19_0.page1

		Vector3 = var_9
		var_19_17.localPosition = var_9.New(0, 0)
		LeanTween = var_19_17

		var_19_17.moveX(arg_19_0.page2, 0, 0.5)

		LeanTween = var_8

		local var_19_18 = var_8.moveX(arg_19_0.page1, -1280, 0.5)
		local var_19_19 = var_8.setOnComplete

		System = var_10

		var_19_19(var_19_18, var_10.Action(function()
			setActive = var_2_10000

			var_2_10000(var_19_15, true)

			return
		end))
	else
		local var_19_20 = arg_19_0.page1
		local var_19_21 = var_7.Find(var_19_20, "switch")

		setActive = var_19_20

		var_19_20(var_19_21, false)

		local var_19_22 = arg_19_0.page2

		Vector3 = var_9
		var_19_22.localPosition = var_9.New(0, 0)

		local var_19_23 = arg_19_0.page1

		Vector3 = var_9
		var_19_23.localPosition = var_9.New(-1280, 0)
		LeanTween = var_19_23

		var_19_23.moveX(arg_19_0.page2, 1280, 0.5)

		LeanTween = var_8

		local var_19_24 = var_8.moveX(arg_19_0.page1, 0, 0.5)
		local var_19_25 = var_8.setOnComplete

		System = var_10

		var_19_25(var_19_24, var_10.Action(function()
			setActive = var_2_10000

			var_2_10000(var_19_21, true)

			return
		end))
	end

	return
end

function var_0_1.addRingDragListenter(arg_22_0)
	GetOrAddComponent = var_1_10001

	local var_22_0 = var_1_10001(arg_22_0._tf, "EventTriggerListener")
	local var_22_1 = 0
	local var_22_2

	var_22_0:AddBeginDragFunc(function()
		var_22_1 = 0
		var_22_2 = nil

		return
	end)
	var_22_0:AddDragFunc(function(arg_24_0, arg_24_1)
		local var_24_0 = arg_24_1.position

		if not var_22_2 then
			var_22_2 = var_24_0
		end

		var_22_1 = var_24_0.x - var_22_2.x

		return
	end)
	var_22_0:AddDragEndFunc(function(arg_25_0, arg_25_1)
		if var_22_1 < -50 then
			if arg_22_0.page == var_0_1.PAGE_ONE then
				local var_25_0 = arg_22_0

				var_2.updateMemoryBook(var_25_0, var_0_1.PAGE_TWO)
			end
		elseif var_22_1 > 50 and arg_22_0.page == var_0_1.PAGE_TWO then
			local var_25_1 = arg_22_0

			var_2.updateMemoryBook(var_25_1, var_0_1.PAGE_ONE)
		end

		return
	end)

	return
end

function var_0_1.updatePageTip(arg_26_0, arg_26_1)
	local var_26_0, var_26_1 = arg_26_0:getStartAndEndIndex(arg_26_1)

	_ = var_4

	local var_26_2 = var_4.any

	_ = var_1_10005

	return var_26_2(var_1_10005.slice(arg_26_0.memorys, var_26_0, var_0_5), function(arg_27_0)
		return arg_27_0.state == var_0_3
	end)
end

function var_0_1.updateMemoryItem(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_2.state
	local var_28_1 = arg_28_0["page" .. arg_28_1]

	local function var_28_2()
		local var_29_0 = arg_28_0.pool
		local var_29_1 = var_0.Get(var_29_0)
		local var_29_2, var_29_3

		if var_28_0 ~= var_0_3 or not arg_28_0.getSprite then
			var_29_2 = arg_28_0
			var_29_3 = var_1.GetMemorySprite(var_29_2, arg_28_1, arg_28_2.index)
		end

		setImageSprite = var_29_2

		var_29_2(var_29_1, var_29_3, true)

		local var_29_4 = var_29_1
		local var_29_5 = var_29_1.GetComponent

		typeof = var_4
		Image = var_5

		local var_29_6 = var_29_5(var_29_4, var_4(var_5))

		var_29_6.raycastTarget = var_28_0 == var_0_3
		setParent = var_29_6

		local var_29_7 = var_29_1
		local var_29_8 = var_28_1

		var_29_6(var_29_7, var_4.Find(var_29_8, "container"))

		tf = var_29_6

		local var_29_9 = var_29_6(var_29_1)

		Vector3 = var_3
		var_29_9.localPosition = var_3(arg_28_2.pos[1], arg_28_2.pos[2], 0)
		table = var_29_9

		var_29_9.insert(arg_28_0.gameObjects, var_29_1)

		return var_29_1
	end

	if var_28_0 == var_0_2 then
		-- block empty
	elseif var_28_0 == var_0_3 then
		local var_28_3 = var_28_2()

		onButton = var_1_10007

		local var_28_4 = arg_28_0
		local var_28_5 = var_28_3

		local function var_28_6()
			local var_30_0 = arg_28_0
			local var_30_1 = var_0.emit

			MemoryBookMediator = var_2_10002

			var_30_1(var_30_0, var_2_10002.ON_UNLOCK, arg_28_2.id, arg_28_0.activity.id)

			return
		end

		SFX_PANEL = var_1_10011

		var_1_10007(var_28_4, var_28_5, var_28_6, var_1_10011)
	elseif var_28_0 == var_0_4 then
		var_28_2()
	end

	return
end

function var_0_1.GetMemorySprite(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_1 .. "_" .. arg_31_2

	if arg_31_0.sprites[var_31_0] then
		return arg_31_0.sprites[var_31_0]
	else
		GetSpriteFromAtlas = var_4

		local var_31_1 = var_4("puzzla/bg_2", var_31_0)

		arg_31_0.sprites[var_31_0] = var_31_1

		return var_31_1
	end

	return
end

function var_0_1.updateProgress(arg_32_0)
	local var_32_0 = #arg_32_0.targetItems
	local var_32_1 = #arg_32_0.unlockItems

	arg_32_0.slider.value = var_32_1 / var_32_0
	arg_32_0.totalTxt.text = var_32_0
	arg_32_0.currValueTxt.text = var_32_1

	local var_32_2 = var_32_1 == var_32_0

	arg_32_0:updateAward(var_32_2)

	return
end

function var_0_1.updateAward(arg_33_0, arg_33_1)
	if not arg_33_0.isInitAward then
		arg_33_0.isInitAward = true

		local var_33_0 = arg_33_0.awardVO[1]

		var_1_10003 = arg_33_0.awardVO[2]
		DROP_TYPE_FURNITURE = var_1_10004

		if var_33_0 == var_1_10004 then
			Furniture = var_1_10004
			var_1_10004 = var_1_10004.New({
				id = var_1_10003
			})
			GetSpriteFromAtlasAsync = var_5

			var_5("furniture/" .. var_1_10004:getConfig("picture"), "", function(arg_34_0)
				if arg_33_0.exited then
					return
				end

				setImageSprite = var_1

				var_1(arg_33_0.awardIcon, arg_34_0, true)

				return
			end)
		else
			assert = var_1_10004

			var_1_10004(false, "this award type is not deal")
		end
	end

	local var_33_1 = arg_33_0.activity.data1 == 1

	setGray = var_1_10003

	var_1_10003(arg_33_0.awardIcon, not arg_33_1, false)

	setActive = var_1_10003

	var_1_10003(arg_33_0.awardLabel, arg_33_1 and not var_33_1)

	setActive = var_1_10003

	var_1_10003(arg_33_0.awardLabelGot, var_33_1)

	LeanTween = var_1_10003

	local var_33_2 = var_1_10003.isTweening

	go = var_4

	local var_33_3

	if var_33_2(var_4(arg_33_0.awardLabel)) then
		LeanTween = var_33_3
		var_33_3 = var_33_3.cancel
		go = var_4

		var_33_3(var_4(arg_33_0.awardLabel))
	end

	if arg_33_1 and not var_33_1 then
		blinkAni = var_33_3

		var_33_3(arg_33_0.awardLabel, 0.8, nil, 0.5)
	end

	removeOnButton = var_33_3

	var_33_3(arg_33_0.awardIcon)

	if not var_33_1 then
		onButton = var_33_3

		local var_33_4 = arg_33_0
		local var_33_5 = arg_33_0.awardIcon

		local function var_33_6()
			if not arg_33_1 then
				pg = var_0

				local var_35_0 = var_0.TipsMgr.GetInstance()
				local var_35_1 = var_0.ShowTips

				i18n = var_2_10002

				var_35_1(var_35_0, var_2_10002("memorybook_get_award_tip"))
			else
				local var_35_2 = arg_33_0
				local var_35_3 = var_0.emit

				MemoryBookMediator = var_2_10002

				var_35_3(var_35_2, var_2_10002.EVENT_OPERATION, {
					cmd = 1,
					activity_id = arg_33_0.activity.id
				})
			end

			return
		end

		SFX_PANEL = var_1_10007

		var_33_3(var_33_4, var_33_5, var_33_6, var_1_10007)
	end

	return
end

function var_0_1.willExit(arg_36_0)
	local var_36_0 = arg_36_0.pool

	var_1.Dispose(var_36_0)

	arg_36_0.sprites = nil
	arg_36_0.getSprite = nil

	return
end

return var_0_1
