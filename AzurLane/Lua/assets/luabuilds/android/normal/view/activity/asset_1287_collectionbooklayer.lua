class = var_0_10000

local var_0_0 = "CollectionBookLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))
local var_0_2 = 3
local var_0_3 = 3
local var_0_4 = 1
local var_0_5 = 2
local var_0_6 = 3

function var_0_1.getUIName(arg_1_0)
	return "CollectionBookUI"
end

function var_0_1.init(arg_2_0)
	CollectionBookMediator = var_1_10001

	local var_2_0 = var_1_10001.ACT_ID

	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_2_1 = var_1_10002(var_1_10003)
	local var_2_2 = var_2.getActivityById(var_2_1, var_2_0)

	arg_2_0.collectInfo = var_2.getData1List(var_2_2)

	if not arg_2_0.collectInfo then
		arg_2_0.collectInfo = {}
	end

	arg_2_0.taskIds = var_2:getConfig("config_client").collect_task
	arg_2_0.pageCollectSiteIds = {}

	for iter_2_0 = 1, var_0_3 do
		pg = var_1_10007
		var_1_10007 = var_1_10007.task_data_template[arg_2_0.taskIds[iter_2_0]]
		table = var_8

		var_8.insert(arg_2_0.pageCollectSiteIds, var_1_10007.target_id)
	end

	return
end

function var_0_1.didEnter(arg_3_0)
	findTF = var_1_10001
	arg_3_0._ad = var_1_10001(arg_3_0._tf, "ad")
	onButton = var_1

	local var_3_0 = arg_3_0

	findTF = var_3

	local var_3_1 = var_3(arg_3_0._tf, "ad/close")

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.closeView(var_4_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_3_0, var_3_1, var_3_2, var_5)

	onButton = var_1

	local var_3_3 = arg_3_0

	findTF = var_3_1

	local var_3_4 = var_3_1(arg_3_0._tf, "ad/buttom")

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.closeView(var_5_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_3_3, var_3_4, var_3_5, var_5)

	arg_3_0.tags = {}

	for iter_3_0 = 1, var_0_2 do
		local var_3_6 = iter_3_0

		findTF = var_1_10006
		var_1_10006 = var_1_10006(arg_3_0._tf, "ad/tag/bg_part_" .. var_3_6)
		findTF = var_7

		local var_3_7 = var_7(arg_3_0._tf, "ad/tag/btn_part_" .. var_3_6)

		table = var_8

		var_8.insert(arg_3_0.tags, {
			btn = var_3_7,
			bg = var_1_10006,
			index = var_3_6
		})

		onButton = var_8

		local var_3_8 = arg_3_0
		local var_3_9 = var_3_7

		local function var_3_10()
			local var_6_0 = arg_3_0

			var_0.selectTag(var_6_0, var_3_6)

			return
		end

		SFX_CONFIRM = var_1_10012

		var_8(var_3_8, var_3_9, var_3_10, var_1_10012)

		setText = var_8
		findTF = var_3_8

		local var_3_11 = var_3_8(var_1_10006, "ad/text")

		i18n = var_10

		var_8(var_3_11, var_10("collection_book_tag_" .. var_3_6))

		setText = var_8
		findTF = var_3_11

		local var_3_12 = var_3_11(var_3_7, "ad/text")

		i18n = var_10

		var_8(var_3_12, var_10("collection_book_tag_" .. var_3_6))
	end

	arg_3_0.pages = {}

	for iter_3_1 = 1, var_0_3 do
		local var_3_13 = iter_3_1

		findTF = var_1_10006
		var_1_10006 = var_1_10006(arg_3_0._tf, "ad/page_" .. var_3_13)
		table = var_7

		var_7.insert(arg_3_0.pages, {
			tf = var_1_10006,
			index = var_3_13
		})
	end

	findTF = var_1
	arg_3_0.awardPanelTf = var_1(arg_3_0._tf, "ad/award_panel")
	onButton = var_1

	local var_3_14 = arg_3_0

	findTF = var_3

	local var_3_15 = var_3(arg_3_0.awardPanelTf, "btnGet")

	local function var_3_16()
		pg = var_2_10000

		local var_7_0 = var_2_10000.m02
		local var_7_1 = var_0.sendNotification

		GAME = var_2_10002

		var_7_1(var_7_0, var_2_10002.SUBMIT_TASK, arg_3_0.taskIds[arg_3_0.selectTagIndex])

		return
	end

	SFX_CONFIRM = var_5

	var_1(var_3_14, var_3_15, var_3_16, var_5)
	arg_3_0:selectTag(1)

	pg = var_1

	local var_3_17 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_17, arg_3_0._ad)

	return
end

function var_0_1.selectTag(arg_8_0, arg_8_1)
	arg_8_0.selectTagIndex = arg_8_1

	arg_8_0:updateTag()
	arg_8_0:updatePage()
	arg_8_0:updateAwardPanel()

	return
end

function var_0_1.updateTag(arg_9_0)
	for iter_9_0 = 1, #arg_9_0.tags do
		local var_9_0 = arg_9_0.tags[iter_9_0]

		setActive = var_1_10006

		var_1_10006(var_9_0.bg, var_9_0.index == arg_9_0.selectTagIndex)

		setActive = var_1_10006

		var_1_10006(var_9_0.btn, var_9_0.index ~= arg_9_0.selectTagIndex)

		var_1_10006 = arg_9_0.taskIds[iter_9_0]
		getProxy = var_7
		TaskProxy = var_8

		local var_9_1 = var_7(var_8)
		local var_9_2

		if var_7.getTaskById(var_9_1, var_1_10006) then
			var_9_2 = var_7

			if var_7.getTaskStatus(var_9_2) == 1 then
				setActive = var_9_1
				findTF = var_9_2

				var_9_1(var_9_2(var_9_0.btn, "ad/tip"), true)

				goto label_9_0
			end
		end

		setActive = var_9_1
		findTF = var_9_2

		var_9_1(var_9_2(var_9_0.btn, "ad/tip"), false)

		::label_9_0::
	end

	return
end

function var_0_1.updatePage(arg_10_0)
	for iter_10_0 = 1, #arg_10_0.pages do
		local var_10_0 = arg_10_0.pages[iter_10_0]

		setActive = var_1_10006

		var_1_10006(var_10_0.tf, var_10_0.index == arg_10_0.selectTagIndex)

		if var_10_0.index == 1 then
			arg_10_0:updatePage1(var_10_0.tf, arg_10_0.pageCollectSiteIds[var_10_0.index])
		elseif var_10_0.index == 2 then
			arg_10_0:updatePage2(var_10_0.tf, arg_10_0.pageCollectSiteIds[var_10_0.index])
		elseif var_10_0.index == 3 then
			arg_10_0:updatePage3(var_10_0.tf, arg_10_0.pageCollectSiteIds[var_10_0.index])
		end
	end

	return
end

function var_0_1.updatePage1(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_0.page1Items then
		arg_11_0.page1Items = {}
		findTF = var_3

		local var_11_0 = var_3(arg_11_1, "list/content/itemTpl")

		findTF = var_4

		local var_11_1 = var_4(arg_11_1, "list/content")

		setActive = var_5

		var_5(var_11_0, false)

		for iter_11_0 = 1, #arg_11_2 do
			local var_11_2 = arg_11_0
			local var_11_3 = arg_11_0.getCollectDataBySiteId(var_11_2, arg_11_2[iter_11_0])

			tf = var_11_2
			instantiate = var_11

			local var_11_4 = var_11_2(var_11(var_11_0))

			setParent = var_11

			var_11(var_11_4, var_11_1)

			setActive = var_11

			var_11(var_11_4, true)

			findTF = var_11

			local var_11_5 = var_11(var_11_4, "place/mask/icon")

			LoadImageSpriteAsync = var_12
			pg = var_13

			var_12(var_13.activity_holiday_site[var_11_3.site_id].jumpto[3][1], var_11_5, true)

			findTF = var_12

			local var_11_6

			var_11_6, setText = var_12(var_11_4, "bg_title/text"), var_13
			pg = var_15

			var_13(var_11_6, var_15.activity_holiday_site[var_11_3.site_id].jumpto[1][1])

			findTF = var_13

			local var_11_7

			var_11_7, setText = var_13(var_11_4, "desc/text"), var_14
			pg = var_16

			var_14(var_11_7, var_16.activity_holiday_site[var_11_3.site_id].jumpto[2][1])

			findTF = var_14

			local var_11_8

			var_11_8, setText = var_14(var_11_4, "desc/lock"), var_15
			i18n = var_17

			var_15(var_11_8, var_17("collection_book_lock_place"))

			local var_11_9 = arg_11_0
			local var_11_10 = arg_11_0.setNumText

			findTF = var_17

			local var_11_11 = var_17(var_11_4, "place/num_1")

			findTF = var_18

			var_11_10(var_11_9, var_11_11, var_18(var_11_4, "place/num_2"), iter_11_0)

			table = var_11_10

			var_11_10.insert(arg_11_0.page1Items, {
				tf = var_11_4,
				index = iter_11_0,
				site_id = var_11_3.site_id
			})
		end
	end

	for iter_11_1 = 1, #arg_11_0.page1Items do
		local var_11_12 = arg_11_0.page1Items[iter_11_1].tf
		local var_11_13 = arg_11_0
		local var_11_14 = arg_11_0.getSiteOpen(var_11_13, arg_11_0.page1Items[iter_11_1].site_id)

		findTF = var_11_13

		local var_11_15 = var_11_13(var_11_12, "place/mask")

		setActive = var_10

		var_10(var_11_15, var_11_14)

		findTF = var_10

		local var_11_16 = var_10(var_11_12, "place/bg/icon_lock")

		setActive = var_11

		var_11(var_11_16, not var_11_14)

		findTF = var_11

		local var_11_17 = var_11(var_11_12, "bg_title/text")

		setActive = var_12

		var_12(var_11_17, var_11_14)

		findTF = var_12

		local var_11_18 = var_12(var_11_12, "bg_title/lock")

		setActive = var_13

		var_13(var_11_18, not var_11_14)

		findTF = var_13

		local var_11_19 = var_13(var_11_12, "desc/text")

		setActive = var_14

		var_14(var_11_19, var_11_14)

		findTF = var_14

		local var_11_20 = var_14(var_11_12, "desc/lock")

		setActive = var_15

		var_15(var_11_20, not var_11_14)
	end

	return
end

function var_0_1.updatePage2(arg_12_0, arg_12_1, arg_12_2)
	if not arg_12_0.page2Items then
		arg_12_0.page2Items = {}
		findTF = var_3

		local var_12_0 = var_3(arg_12_1, "list/content/itemTpl")

		findTF = var_4

		local var_12_1 = var_4(arg_12_1, "list/content")

		setActive = var_5

		var_5(var_12_0, false)

		for iter_12_0 = 1, #arg_12_2 do
			local var_12_2 = arg_12_0
			local var_12_3 = arg_12_0.getCollectDataBySiteId(var_12_2, arg_12_2[iter_12_0])

			tf = var_12_2
			instantiate = var_11

			local var_12_4 = var_12_2(var_11(var_12_0))

			setParent = var_11

			var_11(var_12_4, var_12_1)

			setActive = var_11

			var_11(var_12_4, true)

			onButton = var_11

			local var_12_5 = arg_12_0
			local var_12_6 = var_12_4

			local function var_12_7()
				local var_13_0 = arg_12_0

				if var_0.getSiteOpen(var_13_0, var_12_3.site_id) then
					pg = var_13_0

					local var_13_1 = var_13_0.NewStoryMgr.GetInstance()

					var_1.Play(var_13_1, var_12_3.luaID, function()
						return
					end, true)
				end

				return
			end

			SFX_CONFIRM = var_1_10015

			var_11(var_12_5, var_12_6, var_12_7, var_1_10015)

			findTF = var_11

			local var_12_8 = var_11(var_12_4, "mask/icon")

			LoadImageSpriteAsync = var_12

			var_12("bg/" .. var_12_3.icon, var_12_8, true)

			local var_12_9 = arg_12_0
			local var_12_10 = arg_12_0.getMemoryData(var_12_9, var_12_3.luaID)

			findTF = var_12_9

			local var_12_11 = var_12_9(var_12_4, "desc")

			if var_12_10 then
				setText = var_14

				var_14(var_12_11, var_12_10.title)
			else
				setText = var_14

				var_14(var_12_11, "")
			end

			var_1_10015 = arg_12_0

			local var_12_12 = arg_12_0.setNumText

			findTF = var_1_10016
			var_1_10016 = var_1_10016(var_12_4, "num_1")
			findTF = var_17

			var_12_12(var_1_10015, var_1_10016, var_17(var_12_4, "num_2"), iter_12_0)

			table = var_12_12

			var_12_12.insert(arg_12_0.page2Items, {
				tf = var_12_4,
				index = iter_12_0,
				site_id = var_12_3.site_id
			})
		end
	end

	for iter_12_1 = 1, #arg_12_0.page2Items do
		local var_12_13 = arg_12_0.page2Items[iter_12_1].tf
		local var_12_14 = arg_12_0
		local var_12_15 = arg_12_0.getSiteOpen(var_12_14, arg_12_0.page2Items[iter_12_1].site_id)

		findTF = var_12_14

		local var_12_16 = var_12_14(var_12_13, "desc")

		findTF = var_10

		local var_12_17 = var_10(var_12_13, "desc_lock")

		findTF = var_11

		local var_12_18 = var_11(var_12_13, "lock")

		findTF = var_12

		local var_12_19 = var_12(var_12_13, "mask/icon")

		setActive = var_13

		var_13(var_12_16, var_12_15)

		setActive = var_13

		var_13(var_12_17, not var_12_15)

		setActive = var_13

		var_13(var_12_18, not var_12_15)

		setActive = var_13

		var_13(var_12_19, var_12_15)
	end

	return
end

var_0_1.StoryData = {}

function var_0_1.getMemoryData(arg_15_0, arg_15_1)
	if var_0_1.StoryData[arg_15_1] then
		return var_0_1.StoryData[arg_15_1]
	end

	ipairs = var_2
	pg = var_1_10003

	for iter_15_0, iter_15_1 in var_2(var_1_10003.memory_template.all) do
		pg = var_1_10007

		if var_1_10007.memory_template[iter_15_1].story == arg_15_1 then
			local var_15_0 = var_0_1.StoryData

			Clone = var_1_10009
			var_15_0[arg_15_1] = var_1_10009(var_1_10007)

			return var_0_1.StoryData[arg_15_1]
		end
	end

	return nil
end

function var_0_1.updatePage3(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_0.page3Items then
		arg_16_0.page3Items = {}
		findTF = var_3

		local var_16_0 = var_3(arg_16_1, "list/content/itemTpl")

		findTF = var_4

		local var_16_1 = var_4(arg_16_1, "list/content")

		GetComponent = var_5
		findTF = var_6

		local var_16_2 = var_6(arg_16_1, "list")

		typeof = var_7
		ScrollRect = var_8
		arg_16_0.page3ScrollRect = var_5(var_16_2, var_7(var_8))
		findTF = var_5
		arg_16_0.leftA = var_5(arg_16_1, "left_aix")
		findTF = var_5
		arg_16_0.rightA = var_5(arg_16_1, "right_aix")
		setActive = var_5

		var_5(arg_16_0.leftA, false)

		local var_16_3 = arg_16_0.page3ScrollRect.onValueChanged

		var_5.AddListener(var_16_3, function()
			if arg_16_0.page3ScrollRect.normalizedPosition.x <= 0.01 then
				setActive = var_0

				var_0(arg_16_0.leftA, false)
			elseif arg_16_0.page3ScrollRect.normalizedPosition.x >= 1 then
				setActive = var_0

				var_0(arg_16_0.rightA, false)
			else
				setActive = var_0

				var_0(arg_16_0.leftA, true)

				setActive = var_0

				var_0(arg_16_0.rightA, true)
			end

			return
		end)

		setActive = var_5

		var_5(var_16_0, false)

		for iter_16_0 = 1, #arg_16_2 do
			local var_16_4 = arg_16_0
			local var_16_5 = arg_16_0.getCollectDataBySiteId(var_16_4, arg_16_2[iter_16_0])

			tf = var_16_4
			instantiate = var_11

			local var_16_6 = var_16_4(var_11(var_16_0))

			setParent = var_11

			var_11(var_16_6, var_16_1)

			setActive = var_11

			var_11(var_16_6, true)

			findTF = var_11

			local var_16_7 = var_11(var_16_6, "ad/mask/icon")

			tonumber = var_12

			local var_16_8 = var_12(var_16_5.icon)

			pg = var_13

			local var_16_9 = var_13.ship_skin_template[var_16_8]
			local var_16_10 = ""

			if var_16_9 then
				HXSet = var_1_10015
				var_16_10 = var_1_10015.hxLan(var_16_5.name)
				var_1_10015 = var_16_9.painting

				local var_16_11 = var_0_1.StaticGetPaintingName(var_1_10015)

				LoadPaintingPrefabAsync = var_17

				var_17(var_16_7, var_1_10015, var_16_11, "biandui", function()
					return
				end)
			else
				print = var_1_10015

				var_1_10015("skin_id no exist" .. var_16_8)
			end

			onButton = var_1_10015

			local var_16_12 = arg_16_0
			local var_16_13 = var_16_6

			local function var_16_14()
				local var_19_0 = arg_16_0

				if var_0.getSiteOpen(var_19_0, var_16_5.site_id) then
					pg = var_19_0

					local var_19_1 = var_19_0.NewStoryMgr.GetInstance()

					var_1.Play(var_19_1, var_16_5.luaID, function()
						return
					end, true)
				end

				return
			end

			SFX_CONFIRM = var_1_10019

			var_1_10015(var_16_12, var_16_13, var_16_14, var_1_10019)

			findTF = var_1_10015
			var_1_10015 = var_1_10015(var_16_6, "ad")
			Vector2 = var_16
			var_1_10015.anchoredPosition = var_16(0, iter_16_0 % 2 == 0 and 0 or 25)
			findTF = var_16

			local var_16_15 = var_16(var_16_6, "ad/name")

			setText = var_17

			var_17(var_16_15, var_16_10)

			findTF = var_17

			local var_16_16 = var_17(var_16_6, "ad/name_lock")

			var_1_10019 = arg_16_0

			local var_16_17 = arg_16_0.setNumText

			findTF = var_1_10020
			var_1_10020 = var_1_10020(var_16_6, "ad/num_1")
			findTF = var_21

			var_16_17(var_1_10019, var_1_10020, var_21(var_16_6, "ad/num_2"), iter_16_0)

			table = var_16_17

			var_16_17.insert(arg_16_0.page3Items, {
				tf = var_16_6,
				index = iter_16_0,
				site_id = var_16_5.site_id
			})
		end
	end

	for iter_16_1 = 1, #arg_16_0.page3Items do
		local var_16_18 = arg_16_0.page3Items[iter_16_1].tf
		local var_16_19 = arg_16_0
		local var_16_20 = arg_16_0.getSiteOpen(var_16_19, arg_16_0.page3Items[iter_16_1].site_id)

		findTF = var_16_19

		local var_16_21 = var_16_19(var_16_18, "ad/mask/icon")

		findTF = var_10

		local var_16_22 = var_10(var_16_18, "ad/name")

		findTF = var_11

		local var_16_23 = var_11(var_16_18, "ad/name_lock")

		findTF = var_12

		local var_16_24 = var_12(var_16_18, "ad/lock")

		setActive = var_13

		var_13(var_16_21, var_16_20)

		setActive = var_13

		var_13(var_16_22, var_16_20)

		setActive = var_13

		var_13(var_16_23, not var_16_20)

		setActive = var_13

		var_13(var_16_24, not var_16_20)
	end

	return
end

function var_0_1.getSiteOpen(arg_21_0, arg_21_1)
	table = var_1_10002

	return var_1_10002.contains(arg_21_0.collectInfo, arg_21_1)
end

function var_0_1.getCollectDataBySiteId(arg_22_0, arg_22_1)
	ipairs = var_1_10002
	pg = var_1_10003

	for iter_22_0, iter_22_1 in var_1_10002(var_1_10003.activity_holiday_collection.all) do
		pg = var_1_10007

		if var_1_10007.activity_holiday_collection[iter_22_1].site_id == arg_22_1 then
			pg = var_1_10007

			return var_1_10007.activity_holiday_collection[iter_22_1]
		end
	end

	return nil
end

function var_0_1.StaticGetPaintingName(arg_23_0)
	local var_23_0 = arg_23_0

	checkABExist = var_1_10002

	if var_1_10002("painting/" .. var_23_0 .. "_n") then
		PlayerPrefs = var_2

		if var_2.GetInt("paint_hide_other_obj_" .. var_23_0, 0) ~= 0 then
			var_23_0 = var_23_0 .. "_n"
		end
	end

	HXSet = var_2

	if var_2.isHx() then
		return var_23_0
	end

	getProxy = var_2
	SettingsProxy = var_3

	local var_23_1 = var_2(var_3)

	if var_2.GetMainPaintingVariantFlag(var_23_1, arg_23_0) == var_0_1.PAINTING_VARIANT_EX then
		checkABExist = var_4

		if not var_4("painting/" .. var_23_0 .. "_ex") then
			return var_23_0
		end
	end

	local var_23_2

	if not var_3 or not (var_23_0 .. "_ex") then
		var_23_2 = var_23_0
	end

	return var_23_2
end

function var_0_1.setNumText(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	tostring = var_1_10004
	math = var_1_10005

	local var_24_0 = var_1_10004(var_1_10005.floor(arg_24_3 / 10))

	tostring = var_5

	local var_24_1 = var_5(arg_24_3 % 10)

	arg_24_0:setChildVisible(arg_24_1, false)

	local var_24_2 = arg_24_0

	arg_24_0.setChildVisible(var_24_2, arg_24_2, false)

	setActive = var_6
	findTF = var_24_2

	var_6(var_24_2(arg_24_1, "num_" .. var_24_1), true)

	setActive = var_6
	findTF = var_7

	var_6(var_7(arg_24_2, "num_" .. var_24_0), true)

	return
end

function var_0_1.setChildVisible(arg_25_0, arg_25_1, arg_25_2)
	for iter_25_0 = 1, arg_25_1.childCount do
		local var_25_0 = arg_25_1
		local var_25_1 = arg_25_1.GetChild(var_25_0, iter_25_0 - 1)

		setActive = var_25_0

		var_25_0(var_25_1, arg_25_2)
	end

	return
end

function var_0_1.updateAwardPanel(arg_26_0)
	local var_26_0 = arg_26_0.taskIds[arg_26_0.selectTagIndex]

	getProxy = var_2
	TaskProxy = var_1_10003

	local var_26_1 = var_2(var_1_10003)
	local var_26_3

	if not var_2.getTaskById(var_26_1, var_26_0) then
		getProxy = var_26_1
		TaskProxy = var_4

		local var_26_2 = var_26_1(var_4)

		var_26_3 = var_26_1.getFinishTaskById(var_26_2, var_26_0)
	end

	findTF = var_26_1

	local var_26_4 = var_26_1(arg_26_0.awardPanelTf, "awardIcon")
	local var_26_5 = var_26_3:getConfig("award_display")[1]
	local var_26_6 = {
		type = var_26_5[1],
		id = var_26_5[2],
		count = var_26_5[3]
	}

	updateDrop = var_6

	var_6(var_26_4, var_26_6)

	onButton = var_6

	local var_26_7 = arg_26_0
	local var_26_8 = var_26_4

	local function var_26_9()
		local var_27_0 = arg_26_0

		var_0.emit(var_27_0, var_0_1.ON_DROP, var_26_6)

		return
	end

	SFX_PANEL = var_1_10010

	var_6(var_26_7, var_26_8, var_26_9, var_1_10010)

	findTF = var_6

	local var_26_10 = var_6(arg_26_0.awardPanelTf, "progress")

	setText = var_7

	var_7(var_26_10, var_26_3:getProgress() .. "/" .. var_26_3:getConfig("target_num"))

	findTF = var_7

	local var_26_11 = var_7(arg_26_0.awardPanelTf, "desc")

	setText = var_8

	var_8(var_26_11, var_26_3:getConfig("desc"))

	findTF = var_8

	local var_26_12 = var_8(arg_26_0.awardPanelTf, "btnGet")

	findTF = var_9

	local var_26_13 = var_9(arg_26_0.awardPanelTf, "btnGot")

	findTF = var_10

	local var_26_14 = var_10(arg_26_0.awardPanelTf, "btnGo")

	findTF = var_11

	local var_26_15 = var_11(arg_26_0.awardPanelTf, "imgGot")

	setText = var_12
	findTF = var_13

	local var_26_16 = var_13(var_26_12, "text")

	i18n = var_14

	var_12(var_26_16, var_14("task_get"))

	setText = var_12
	findTF = var_26_16

	local var_26_17 = var_26_16(var_26_13, "text")

	i18n = var_14

	var_12(var_26_17, var_14("avatarframe_got"))

	setText = var_12
	findTF = var_26_17

	local var_26_18 = var_26_17(var_26_14, "text")

	i18n = var_14

	var_12(var_26_18, var_14("task_get"))

	setActive = var_12

	var_12(var_26_12, false)

	setActive = var_12

	var_12(var_26_13, false)

	setActive = var_12

	var_12(var_26_15, false)

	setActive = var_12

	var_12(var_26_14, false)

	if var_26_3:getTaskStatus() == 0 then
		var_26_14:GetComponent("UIGrayScale").enabled = false

		local var_26_19 = var_26_14:GetComponent("UIGrayScale")

		var_26_19.enabled = true
		setActive = var_26_19

		var_26_19(var_26_14, true)
	elseif var_26_3:getTaskStatus() == 1 then
		setActive = var_12

		var_12(var_26_12, true)
	elseif var_26_3:getTaskStatus() == 2 then
		setActive = var_12

		var_12(var_26_13, true)

		setActive = var_12

		var_12(var_26_15, true)
	end

	return
end

function var_0_1.willExit(arg_28_0)
	local var_28_0 = arg_28_0.page3ScrollRect.onValueChanged

	var_1.RemoveAllListeners(var_28_0)

	pg = var_1

	local var_28_1 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_28_1, arg_28_0._ad, arg_28_0._tf)

	return
end

return var_0_1
