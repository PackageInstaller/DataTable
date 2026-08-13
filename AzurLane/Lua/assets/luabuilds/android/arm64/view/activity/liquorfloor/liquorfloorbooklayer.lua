class = var_0_10000

local var_0_0 = "LiquorFloorBookLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))
local var_0_2 = 3
local var_0_3 = 3
local var_0_4 = 1
local var_0_5 = 2
local var_0_6 = 3

function var_0_1.getUIName(arg_1_0)
	return "LiquorFloorBookUI"
end

function var_0_1.init(arg_2_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_2_0 = var_1_10001(var_1_10003)
	local var_2_1 = var_1.getActivityById

	ActivityConst = var_1_10004
	arg_2_0.actid = var_2_1(var_2_0, var_1_10004.LiquorFloor_ACT_ID)

	local var_2_2 = arg_2_0.actid

	arg_2_0.Placeac = var_1.GetPlaceList(var_2_2)
	arg_2_0.gather1 = {}
	arg_2_0.gather2 = {}
	arg_2_0.gather3 = {}

	local var_2_3 = arg_2_0.actid

	arg_2_0.client = var_1.getConfig(var_2_3, "config_client").BookData
	arg_2_0.pageCollectSiteIds = {}
	ipairs = var_1

	for iter_2_0, iter_2_1 in var_1(arg_2_0.client[1].data1) do
		table = var_1_10006

		var_1_10006.insert(arg_2_0.gather1, iter_2_1)
	end

	ipairs = var_1

	for iter_2_2, iter_2_3 in var_1(arg_2_0.client[2].data2) do
		table = var_1_10006

		var_1_10006.insert(arg_2_0.gather2, iter_2_3)
	end

	ipairs = var_1

	for iter_2_4, iter_2_5 in var_1(arg_2_0.client[3].data3) do
		table = var_1_10006

		var_1_10006.insert(arg_2_0.gather3, iter_2_5)
	end

	arg_2_0.taskIds = {}

	for iter_2_6 = 1, #arg_2_0.client do
		arg_2_0.taskId = arg_2_0.client[iter_2_6].task
		table = var_5

		var_5.insert(arg_2_0.taskIds, arg_2_0.taskId)
	end

	return
end

function var_0_1.didEnter(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0._ad = var_1.Find(var_3_0, "ad")
	setText = var_1

	local var_3_1 = arg_3_0._ad
	local var_3_2 = var_3.Find(var_3_1, "bg/title_bg/title")

	i18n = var_4

	var_1(var_3_2, var_4("LiquorFloor_story_title_4"))

	onButton = var_1

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0._tf
	local var_3_5 = var_4.Find(var_3_4, "ad/close")

	local function var_3_6()
		local var_4_0 = arg_3_0

		var_0.closeView(var_4_0)

		return
	end

	SFX_CANCEL = var_3_4

	var_1(var_3_3, var_3_5, var_3_6, var_3_4)

	onButton = var_1

	local var_3_7 = arg_3_0
	local var_3_8 = arg_3_0._tf
	local var_3_9 = var_4.Find(var_3_8, "ad/buttom")

	local function var_3_10()
		local var_5_0 = arg_3_0

		var_0.closeView(var_5_0)

		return
	end

	SFX_CANCEL = var_3_8

	var_1(var_3_7, var_3_9, var_3_10, var_3_8)

	arg_3_0.tags = {}

	local var_3_11 = 0

	for iter_3_0 = 1, var_0_2 do
		local var_3_12 = iter_3_0
		local var_3_13 = arg_3_0._tf
		local var_3_14 = var_7.Find(var_3_13, "ad/tag/" .. var_3_12)

		table = var_1_10008

		var_1_10008.insert(arg_3_0.tags, {
			btn = var_3_14,
			index = var_3_12
		})

		onToggle = var_1_10008

		local var_3_15 = arg_3_0
		local var_3_16 = var_3_14

		local function var_3_17(arg_6_0)
			if arg_6_0 then
				if var_3_11 ~= var_3_12 then
					local var_6_0 = arg_3_0

					var_1.selectTag(var_6_0, var_3_12, var_3_14)
				end

				var_3_11 = var_3_12
			end

			return
		end

		SFX_PANEL = var_1_10013

		var_1_10008(var_3_15, var_3_16, var_3_17, var_1_10013)
	end

	arg_3_0.pages = {}

	for iter_3_1 = 1, var_0_3 do
		local var_3_18 = iter_3_1
		local var_3_19 = arg_3_0._tf
		local var_3_20 = var_7.Find(var_3_19, "ad/page_" .. var_3_18)

		table = var_1_10008

		var_1_10008.insert(arg_3_0.pages, {
			tf = var_3_20,
			index = var_3_18
		})
	end

	local var_3_21 = arg_3_0._tf

	arg_3_0.awardPanelTf = var_2.Find(var_3_21, "ad/award_panel")
	onButton = var_2

	local var_3_22 = arg_3_0
	local var_3_23 = arg_3_0.awardPanelTf
	local var_3_24 = var_5.Find(var_3_23, "btnGet")

	local function var_3_25()
		local var_7_0 = arg_3_0
		local var_7_1 = var_0.emit

		LiquorFloorBookMediator = var_2_10003

		var_7_1(var_7_0, var_2_10003.ON_GET_TASK, arg_3_0.taskIds[arg_3_0.selectTagIndex])

		return
	end

	SFX_CONFIRM = var_3_23

	var_2(var_3_22, var_3_24, var_3_25, var_3_23)
	arg_3_0:selectTag(1)

	pg = var_2

	local var_3_26 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_3_26, arg_3_0._ad)

	setText = var_2

	local var_3_27 = arg_3_0._ad
	local var_3_28 = var_4.Find(var_3_27, "tag/1/off/text")

	i18n = var_5

	var_2(var_3_28, var_5("LiquorFloor_story_title_1"))

	setText = var_2

	local var_3_29 = arg_3_0._ad
	local var_3_30 = var_4.Find(var_3_29, "tag/1/on/text")

	i18n = var_5

	var_2(var_3_30, var_5("LiquorFloor_story_title_1"))

	setText = var_2

	local var_3_31 = arg_3_0._ad
	local var_3_32 = var_4.Find(var_3_31, "tag/2/off/text")

	i18n = var_5

	var_2(var_3_32, var_5("LiquorFloor_story_title_2"))

	setText = var_2

	local var_3_33 = arg_3_0._ad
	local var_3_34 = var_4.Find(var_3_33, "tag/2/on/text")

	i18n = var_5

	var_2(var_3_34, var_5("LiquorFloor_story_title_2"))

	setText = var_2

	local var_3_35 = arg_3_0._ad
	local var_3_36 = var_4.Find(var_3_35, "tag/3/off/text")

	i18n = var_5

	var_2(var_3_36, var_5("LiquorFloor_story_title_3"))

	setText = var_2

	local var_3_37 = arg_3_0._ad
	local var_3_38 = var_4.Find(var_3_37, "tag/3/on/text")

	i18n = var_5

	var_2(var_3_38, var_5("LiquorFloor_story_title_3"))

	return
end

function var_0_1.selectTag(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.selectTagIndex = arg_8_1

	arg_8_0:updateTag()
	arg_8_0:updatePage()
	arg_8_0:updateAwardPanel()

	return
end

function var_0_1.updateTag(arg_9_0)
	for iter_9_0 = 1, #arg_9_0.taskIds do
		local var_9_0 = arg_9_0.taskIds[iter_9_0]

		getProxy = var_1_10006
		TaskProxy = var_1_10008
		var_1_10008 = var_1_10006(var_1_10008)

		if var_1_10006.getTaskById(var_1_10008, var_9_0) and var_1_10006:getTaskStatus() == 1 then
			setActive = var_1_10007

			local var_9_1 = arg_9_0._ad

			var_1_10007(var_9.Find(var_9_1, "tag/" .. iter_9_0 .. "/tip"), true)
		else
			setActive = var_1_10007

			local var_9_2 = arg_9_0._ad

			var_1_10007(var_9.Find(var_9_2, "tag/" .. iter_9_0 .. "/tip"), false)
		end
	end

	return
end

function var_0_1.updatePage(arg_10_0)
	for iter_10_0 = 1, #arg_10_0.pages do
		local var_10_0 = arg_10_0.pages[iter_10_0]

		setActive = var_1_10006

		var_1_10006(var_10_0.tf, var_10_0.index == arg_10_0.selectTagIndex)

		if var_10_0.index == 1 then
			arg_10_0:updatePage1(var_10_0.tf, arg_10_0.gather1)
		elseif var_10_0.index == 2 then
			arg_10_0:updatePage2(var_10_0.tf, arg_10_0.gather2)
		elseif var_10_0.index == 3 then
			arg_10_0:updatePage3(var_10_0.tf, arg_10_0.gather3)
		end
	end

	return
end

function var_0_1.updatePage2(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_0.page2Items then
		arg_11_0.page2Items = {}
		findTF = var_3

		local var_11_0 = var_3(arg_11_1, "list/content/itemTpl")

		findTF = var_1_10004

		local var_11_1 = var_1_10004(arg_11_1, "list/content")

		setActive = var_5

		var_5(var_11_0, false)

		for iter_11_0 = 1, #arg_11_2 do
			local var_11_2 = arg_11_0
			local var_11_3 = arg_11_0.getCollectDataBySiteId(var_11_2, arg_11_2[iter_11_0])

			tf = var_1_10010
			instantiate = var_12
			var_1_10010 = var_1_10010(var_12(var_11_0))
			setParent = var_11_2

			var_11_2(var_1_10010, var_11_1)

			setActive = var_11_2

			var_11_2(var_1_10010, true)

			local var_11_4 = var_1_10010
			local var_11_5

			var_11_5, setImageSprite = var_1_10010.Find(var_11_4, "bg/icon"), var_12
			LoadSprite = var_1_10015

			var_12(var_11_5, var_1_10015("ui/LiquorFloorUI_atlas", var_11_3.icon), true)

			local var_11_6 = var_1_10010
			local var_11_7 = var_1_10010.Find(var_11_6, "bg/GameObject/name")

			setScrollText = var_11_4

			var_11_4(var_11_7, var_11_3.name)

			var_1_10015 = var_1_10010

			local var_11_8 = var_1_10010.Find(var_1_10015, "bg/lock/name")

			setText = var_11_6

			var_11_6(var_11_8, "???????")

			local var_11_9 = var_1_10010:Find("bg/lock/Text")

			setText = var_1_10015

			var_1_10015(var_11_9, var_11_3.unlock_desc)

			table = var_1_10015

			var_1_10015.insert(arg_11_0.page2Items, {
				tf = var_1_10010,
				index = iter_11_0
			})
		end
	end

	for iter_11_1 = 1, #arg_11_0.page2Items do
		local var_11_10 = arg_11_0.page2Items[iter_11_1].tf
		local var_11_11 = arg_11_0:getCollectDataBySiteId(arg_11_2[iter_11_1]).unlock[2]
		local var_11_12 = arg_11_0.Placeac[var_8.unlock[1]]
		local var_11_13 = var_11_11 <= var_10.GetLevel(var_11_12)
		local var_11_14 = var_11_10
		local var_11_15 = var_11_10.Find(var_11_14, "bg/icon")

		setActive = var_11

		var_11(var_11_15, var_11_13)

		local var_11_16 = var_11_10:Find("bg/lock")

		setActive = var_11_14

		var_11_14(var_11_16, not var_11_13)

		local var_11_17 = var_11_10
		local var_11_18 = var_11_10.Find(var_11_17, "bg/GameObject/name")
		local var_11_19 = var_11_10:Find("bg/lock")

		setActive = var_11_17

		var_11_17(var_11_18, var_11_13)

		setActive = var_11_17

		var_11_17(var_11_19, not var_11_13)
	end

	return
end

function var_0_1.updatePage1(arg_12_0, arg_12_1, arg_12_2)
	if not arg_12_0.page1Items then
		arg_12_0.page1Items = {}

		local var_12_0 = arg_12_1
		local var_12_1 = arg_12_1.Find(var_12_0, "list/content/itemTpl")
		local var_12_2 = arg_12_1:Find("list/content")

		setActive = var_12_0

		var_12_0(var_12_1, false)

		for iter_12_0 = 1, #arg_12_2 do
			local var_12_3 = arg_12_0
			local var_12_4 = arg_12_0.getCollectDataBySiteId(var_12_3, arg_12_2[iter_12_0])

			tf = var_1_10010
			instantiate = var_12
			var_1_10010 = var_1_10010(var_12(var_12_1))
			setParent = var_12_3

			var_12_3(var_1_10010, var_12_2)

			setActive = var_12_3

			var_12_3(var_1_10010, true)

			local var_12_5 = var_1_10010
			local var_12_6 = var_1_10010.Find(var_12_5, "icon")

			LoadImageSpriteAsync = var_12

			var_12("bg/" .. var_12_4.icon, var_12_6)

			local var_12_7 = var_1_10010:Find("desc_bg/desc")

			SetActive = var_12_5

			local var_12_8 = var_1_10010:Find("desc_bg")

			memoryData = var_1_10016

			var_12_5(var_12_8, var_1_10016)

			if var_12_4.name then
				setText = var_13

				var_13(var_12_7, var_12_4.name)
			end

			table = var_13

			var_13.insert(arg_12_0.page1Items, {
				tf = var_1_10010,
				index = iter_12_0
			})
		end
	end

	for iter_12_1 = 1, #arg_12_0.page1Items do
		local var_12_9 = arg_12_0.page1Items[iter_12_1].tf
		local var_12_10 = arg_12_0:getCollectDataBySiteId(arg_12_2[iter_12_1]).unlock[2]
		local var_12_11 = arg_12_0.actid
		local var_12_12 = var_12_10 <= var_9.GetTownLevel(var_12_11)
		local var_12_13 = arg_12_0:getCollectDataBySiteId(arg_12_2[iter_12_1]).unlock[2]
		local var_12_14 = var_12_9:Find("lock")
		local var_12_15 = var_12_9:Find("bg2")
		local var_12_16 = var_12_9:Find("desc_bg")
		local var_12_17 = var_12_9
		local var_12_18 = var_12_9.Find(var_12_17, "icon")
		local var_12_19 = var_12_9:Find("lock/Text")

		setText = var_12_17

		var_12_17(var_12_19, arg_12_0:getCollectDataBySiteId(arg_12_2[iter_12_1]).unlock_desc)

		setActive = var_12_17

		var_12_17(var_12_18, var_12_12)

		setActive = var_12_17

		var_12_17(var_12_16, var_12_12)

		setActive = var_12_17

		var_12_17(var_12_14, not var_12_12)

		setActive = var_12_17

		var_12_17(var_12_15, not var_12_12)
	end

	return
end

function var_0_1.updatePage3(arg_13_0, arg_13_1, arg_13_2)
	if not arg_13_0.page3Items then
		arg_13_0.page3Items = {}
		findTF = var_3

		local var_13_0 = var_3(arg_13_1, "list/content/itemTpl")

		findTF = var_1_10004

		local var_13_1 = var_1_10004(arg_13_1, "list/content")

		setActive = var_5

		var_5(var_13_0, false)

		for iter_13_0 = 1, #arg_13_2 do
			local var_13_2 = arg_13_0
			local var_13_3 = arg_13_0.getCollectDataBySiteId(var_13_2, arg_13_2[iter_13_0])

			tf = var_1_10010
			instantiate = var_12
			var_1_10010 = var_1_10010(var_12(var_13_0))
			setParent = var_13_2

			var_13_2(var_1_10010, var_13_1)

			setActive = var_13_2

			var_13_2(var_1_10010, true)

			local var_13_4 = var_1_10010
			local var_13_5 = var_1_10010.Find(var_13_4, "ad/mask/icon")

			tonumber = var_12

			local var_13_6 = var_12(var_13_3.icon)

			pg = var_13_4

			local var_13_7 = var_13_4.ship_skin_template[var_13_6]
			local var_13_8 = ""

			if var_13_7 then
				HXSet = var_1_10015
				var_13_8 = var_1_10015.hxLan(var_13_3.name)
				var_1_10015 = var_13_7.painting

				local var_13_9 = var_0_1.StaticGetPaintingName(var_1_10015)

				LoadPaintingPrefabAsync = var_17

				var_17(var_13_5, var_1_10015, var_13_9, "biandui", function()
					return
				end)
			else
				print = var_1_10015

				var_1_10015("skin_id no exist" .. var_13_6)
			end

			onButton = var_1_10015

			local var_13_10 = arg_13_0
			local var_13_11 = var_1_10010

			local function var_13_12()
				local var_15_0 = arg_13_0

				if var_0.getSiteOpen(var_15_0, var_13_3.site_id) then
					pg = var_2_10001

					local var_15_1 = var_2_10001.NewStoryMgr.GetInstance()

					var_1.Play(var_15_1, var_13_3.luaID, function()
						return
					end, true)
				end

				return
			end

			SFX_CONFIRM = var_1_10020

			var_1_10015(var_13_10, var_13_11, var_13_12, var_1_10020)

			local var_13_13 = var_1_10010

			var_1_10015 = var_1_10010.Find(var_13_13, "ad")

			local var_13_14 = var_1_10010:Find("ad/name_bg/name")

			setText = var_13_13

			var_13_13(var_13_14, var_13_8)

			local var_13_15 = var_1_10010
			local var_13_16 = var_1_10010.Find(var_13_15, "ad/lock")

			var_1_10020 = var_1_10010

			local var_13_17 = var_1_10010.Find(var_1_10020, "ad/lock/Text")

			setText = var_13_15

			var_13_15(var_13_17, var_13_3.unlock_desc)

			table = var_13_15

			var_13_15.insert(arg_13_0.page3Items, {
				tf = var_1_10010,
				index = iter_13_0
			})
		end
	end

	for iter_13_1 = 1, #arg_13_0.page3Items do
		local var_13_18 = arg_13_0.page3Items[iter_13_1].tf
		local var_13_19 = arg_13_0:getCollectDataBySiteId(arg_13_2[iter_13_1])
		local var_13_20 = arg_13_0:getCollectDataBySiteId(arg_13_2[iter_13_1]).unlock[2]
		local var_13_21 = arg_13_0.Placeac[arg_13_0:getCollectDataBySiteId(arg_13_2[iter_13_1]).unlock[1]]
		local var_13_22 = var_13_20 <= var_10.GetLevel(var_13_21)
		local var_13_23 = var_13_18:Find("ad/mask/icon")
		local var_13_24 = var_13_18
		local var_13_25 = var_13_18.Find(var_13_24, "ad/name_bg")
		local var_13_26 = var_13_18:Find("ad/lock")

		setActive = var_13_24

		var_13_24(var_13_23, var_13_22)

		setActive = var_13_24

		var_13_24(var_13_25, var_13_22)

		setActive = var_13_24

		var_13_24(var_13_26, not var_13_22)
	end

	return
end

function var_0_1.getSiteOpen(arg_17_0, arg_17_1)
	table = var_1_10002

	return var_1_10002.contains(arg_17_0.collectInfo, arg_17_1)
end

function var_0_1.getCollectDataBySiteId(arg_18_0, arg_18_1)
	ipairs = var_1_10002
	pg = var_1_10004

	for iter_18_0, iter_18_1 in var_1_10002(var_1_10004.activity_town_collection_2.all) do
		pg = var_1_10007

		if var_1_10007.activity_town_collection_2[iter_18_1].id == arg_18_1 then
			pg = var_1_10007

			return var_1_10007.activity_town_collection_2[iter_18_1]
		end
	end

	return nil
end

function var_0_1.StaticGetPaintingName(arg_19_0)
	local var_19_0 = arg_19_0

	checkABExist = var_1_10002

	if var_1_10002("painting/" .. var_19_0 .. "_n") then
		PlayerPrefs = var_2

		if var_2.GetInt("paint_hide_other_obj_" .. var_19_0, 0) ~= 0 then
			var_19_0 = var_19_0 .. "_n"
		end
	end

	HXSet = var_2

	if var_2.isHx() then
		return var_19_0
	end

	getProxy = var_2
	SettingsProxy = var_4

	local var_19_1 = var_2(var_4)

	if var_2.GetMainPaintingVariantFlag(var_19_1, arg_19_0) == var_0_1.PAINTING_VARIANT_EX then
		checkABExist = var_19_1

		if not var_19_1("painting/" .. var_19_0 .. "_ex") then
			return var_19_0
		end
	end

	local var_19_2

	if not var_3 or not (var_19_0 .. "_ex") then
		var_19_2 = var_19_0
	end

	return var_19_2
end

function var_0_1.updateAwardPanel(arg_20_0)
	local var_20_0 = arg_20_0.taskIds[arg_20_0.selectTagIndex]

	getProxy = var_2
	TaskProxy = var_1_10004

	local var_20_1 = var_2(var_1_10004)
	local var_20_2 = var_2.getTaskVO(var_20_1, var_20_0)
	local var_20_3 = arg_20_0.awardPanelTf
	local var_20_4 = var_3.Find(var_20_3, "awardIcon")
	local var_20_5 = var_20_2:getConfig("award_display")[1]
	local var_20_6 = {
		type = var_20_5[1],
		id = var_20_5[2],
		count = var_20_5[3]
	}

	updateDrop = var_6

	var_6(var_20_4, var_20_6)

	onButton = var_6

	local var_20_7 = arg_20_0
	local var_20_8 = var_20_4

	local function var_20_9()
		local var_21_0 = arg_20_0

		var_0.emit(var_21_0, var_0_1.ON_DROP, var_20_6)

		return
	end

	SFX_PANEL = var_1_10011

	var_6(var_20_7, var_20_8, var_20_9, var_1_10011)

	findTF = var_6

	local var_20_10 = var_6(arg_20_0.awardPanelTf, "progress")

	setText = var_7

	var_7(var_20_10, var_20_2:getProgress() .. "/" .. var_20_2:getConfig("target_num"))

	findTF = var_7

	local var_20_11 = var_7(arg_20_0.awardPanelTf, "Slider")

	setSlider = var_8

	var_8(var_20_11, 0, 1, var_20_2:getProgress() / var_20_2:getConfig("target_num"))

	findTF = var_8

	local var_20_12 = var_8(arg_20_0.awardPanelTf, "desc")

	setText = var_9

	var_9(var_20_12, var_20_2:getConfig("desc"))

	findTF = var_9

	local var_20_13 = var_9(arg_20_0.awardPanelTf, "btnGet")

	findTF = var_10

	local var_20_14 = var_10(arg_20_0.awardPanelTf, "btnGot")

	findTF = var_11

	local var_20_15 = var_11(arg_20_0.awardPanelTf, "btnGo")

	setText = var_12
	findTF = var_14

	local var_20_16 = var_14(var_20_13, "text")

	i18n = var_15

	var_12(var_20_16, var_15("LiquorFloor_story_get"))

	setText = var_12
	findTF = var_20_16

	local var_20_17 = var_20_16(var_20_14, "text")

	i18n = var_15

	var_12(var_20_17, var_15("LiquorFloor_story_got"))

	setText = var_12
	findTF = var_20_17

	local var_20_18 = var_20_17(var_20_15, "text")

	i18n = var_15

	var_12(var_20_18, var_15("LiquorFloor_story_go"))

	setActive = var_12

	var_12(var_20_13, false)

	setActive = var_12

	var_12(var_20_14, false)

	setActive = var_12
	imgGot = var_14

	var_12(var_14, false)

	setActive = var_12

	var_12(var_20_15, false)

	if var_20_2:getTaskStatus() == 0 then
		setActive = var_12

		var_12(var_20_15, true)
	elseif var_20_2:getTaskStatus() == 1 then
		setActive = var_12

		var_12(var_20_13, true)
	elseif var_20_2:getTaskStatus() == 2 then
		setActive = var_12

		var_12(var_20_14, true)

		setActive = var_12
		imgGot = var_14

		var_12(var_14, true)
	end

	onButton = var_12

	local var_20_19 = arg_20_0
	local var_20_20 = var_20_15

	local function var_20_21()
		local var_22_0 = arg_20_0

		var_0.closeView(var_22_0)

		return
	end

	SFX_CANCEL = var_17

	var_12(var_20_19, var_20_20, var_20_21, var_17)

	return
end

function var_0_1.willExit(arg_23_0)
	pg = var_1_10001

	local var_23_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_23_0, arg_23_0._ad, arg_23_0._tf)

	return
end

return var_0_1
