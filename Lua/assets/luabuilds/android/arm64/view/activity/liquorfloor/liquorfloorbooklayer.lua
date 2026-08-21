local var_0_0 = class("LiquorFloorBookLayer", import("view.base.BaseUI"))
local var_0_1 = 3
local var_0_2 = 3

function var_0_0.getUIName(arg_1_0)
	return "LiquorFloorBookUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.actid = getProxy(ActivityProxy):getActivityById(ActivityConst.LiquorFloor_ACT_ID)
	arg_2_0.Placeac = arg_2_0.actid:GetPlaceList()
	arg_2_0.gather1 = {}
	arg_2_0.gather2 = {}
	arg_2_0.gather3 = {}
	arg_2_0.client = arg_2_0.actid:getConfig("config_client").BookData
	arg_2_0.pageCollectSiteIds = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.client[1].data1) do
		table.insert(arg_2_0.gather1, iter_2_1)
	end

	for iter_2_2, iter_2_3 in ipairs(arg_2_0.client[2].data2) do
		table.insert(arg_2_0.gather2, iter_2_3)
	end

	for iter_2_4, iter_2_5 in ipairs(arg_2_0.client[3].data3) do
		table.insert(arg_2_0.gather3, iter_2_5)
	end

	arg_2_0.taskIds = {}

	for iter_2_6 = 1, #arg_2_0.client do
		arg_2_0.taskId = arg_2_0.client[iter_2_6].task

		table.insert(arg_2_0.taskIds, arg_2_0.taskId)
	end

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0._ad = arg_3_0._tf:Find("ad")

	setText(arg_3_0._ad:Find("bg/title_bg/title"), i18n("LiquorFloor_story_title_4"))
	onButton(arg_3_0, arg_3_0._tf:Find("ad/close"), function()
		arg_3_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0._tf:Find("ad/buttom"), function()
		arg_3_0:closeView()

		return
	end, SFX_CANCEL)

	arg_3_0.tags = {}

	local var_3_0 = 0

	for iter_3_0 = 1, var_0_1 do
		local var_3_1 = arg_3_0._tf:Find("ad/tag/" .. iter_3_0)

		table.insert(arg_3_0.tags, {
			btn = var_3_1,
			index = iter_3_0
		})
		onToggle(arg_3_0, var_3_1, function(arg_6_0)
			if arg_6_0 then
				if var_3_0 ~= var_0 then
					arg_3_0:selectTag(var_0, var_3_1)
				end

				var_3_0 = var_0
			end

			return
		end, SFX_PANEL)
	end

	arg_3_0.pages = {}

	for iter_3_1 = 1, var_0_2 do
		table.insert(arg_3_0.pages, {
			tf = arg_3_0._tf:Find("ad/page_" .. iter_3_1),
			index = iter_3_1
		})
	end

	arg_3_0.awardPanelTf = arg_3_0._tf:Find("ad/award_panel")

	onButton(arg_3_0, arg_3_0.awardPanelTf:Find("btnGet"), function()
		arg_3_0:emit(LiquorFloorBookMediator.ON_GET_TASK, arg_3_0.taskIds[arg_3_0.selectTagIndex])

		return
	end, SFX_CONFIRM)
	arg_3_0:selectTag(1)
	pg.UIMgr.GetInstance():BlurPanel(arg_3_0._ad)
	setText(arg_3_0._ad:Find("tag/1/off/text"), i18n("LiquorFloor_story_title_1"))
	setText(arg_3_0._ad:Find("tag/1/on/text"), i18n("LiquorFloor_story_title_1"))
	setText(arg_3_0._ad:Find("tag/2/off/text"), i18n("LiquorFloor_story_title_2"))
	setText(arg_3_0._ad:Find("tag/2/on/text"), i18n("LiquorFloor_story_title_2"))
	setText(arg_3_0._ad:Find("tag/3/off/text"), i18n("LiquorFloor_story_title_3"))
	setText(arg_3_0._ad:Find("tag/3/on/text"), i18n("LiquorFloor_story_title_3"))

	return
end

function var_0_0.selectTag(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.selectTagIndex = arg_8_1

	arg_8_0:updateTag()
	arg_8_0:updatePage()
	arg_8_0:updateAwardPanel()

	return
end

function var_0_0.updateTag(arg_9_0)
	for iter_9_0 = 1, #arg_9_0.taskIds do
		local var_9_0 = getProxy(TaskProxy):getTaskById(arg_9_0.taskIds[iter_9_0])

		if var_9_0 and var_9_0:getTaskStatus() == 1 then
			setActive(arg_9_0._ad:Find("tag/" .. iter_9_0 .. "/tip"), true)
		else
			setActive(arg_9_0._ad:Find("tag/" .. iter_9_0 .. "/tip"), false)
		end
	end

	return
end

function var_0_0.updatePage(arg_10_0)
	for iter_10_0 = 1, #arg_10_0.pages do
		local var_10_0 = arg_10_0.pages[iter_10_0]

		setActive(arg_10_0.pages[iter_10_0].tf, arg_10_0.pages[iter_10_0].index == arg_10_0.selectTagIndex)

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

function var_0_0.updatePage2(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_0.page2Items then
		arg_11_0.page2Items = {}

		local var_11_0 = findTF(arg_11_1, "list/content/itemTpl")
		local var_11_1 = findTF(arg_11_1, "list/content")

		setActive(var_11_0, false)

		for iter_11_0 = 1, #arg_11_2 do
			local var_11_2 = arg_11_0:getCollectDataBySiteId(arg_11_2[iter_11_0])
			local var_11_3 = tf(instantiate(var_11_0))

			setParent(var_11_3, var_11_1)
			setActive(var_11_3, true)
			setImageSprite(var_11_3:Find("bg/icon"), LoadSprite("ui/LiquorFloorUI_atlas", var_11_2.icon), true)
			setScrollText(var_11_3:Find("bg/GameObject/name"), var_11_2.name)
			setText(var_11_3:Find("bg/lock/name"), "???????")
			setText(var_11_3:Find("bg/lock/Text"), var_11_2.unlock_desc)
			table.insert(arg_11_0.page2Items, {
				tf = var_11_3,
				index = iter_11_0
			})
		end
	end

	for iter_11_1 = 1, #arg_11_0.page2Items do
		local var_11_5 = arg_11_0:getCollectDataBySiteId(arg_11_2[iter_11_1])
		local var_11_6 = var_11_5.unlock[2] <= arg_11_0.Placeac[var_11_5.unlock[1]]:GetLevel()

		setActive(arg_11_0.page2Items[iter_11_1].tf:Find("bg/icon"), var_11_6)
		setActive(var_11_4:Find("bg/lock"), not var_11_6)

		local var_11_7 = var_11_4:Find("bg/lock")

		setActive(var_11_4:Find("bg/GameObject/name"), var_11_6)
		setActive(var_11_7, not var_11_6)
	end

	return
end

function var_0_0.updatePage1(arg_12_0, arg_12_1, arg_12_2)
	if not arg_12_0.page1Items then
		arg_12_0.page1Items = {}

		local var_12_0 = arg_12_1:Find("list/content/itemTpl")
		local var_12_1 = arg_12_1:Find("list/content")

		setActive(var_12_0, false)

		for iter_12_0 = 1, #arg_12_2 do
			local var_12_2 = arg_12_0:getCollectDataBySiteId(arg_12_2[iter_12_0])
			local var_12_3 = tf(instantiate(var_12_0))

			setParent(var_12_3, var_12_1)
			setActive(var_12_3, true)
			LoadImageSpriteAsync("bg/" .. var_12_2.icon, (var_12_3:Find("icon")))

			local var_12_4 = var_12_3:Find("desc_bg/desc")

			SetActive(var_12_3:Find("desc_bg"), memoryData)

			if var_12_2.name then
				setText(var_12_4, var_12_2.name)
			end

			table.insert(arg_12_0.page1Items, {
				tf = var_12_3,
				index = iter_12_0
			})
		end
	end

	for iter_12_1 = 1, #arg_12_0.page1Items do
		local var_12_5 = arg_12_0:getCollectDataBySiteId(arg_12_2[iter_12_1]).unlock[2] <= arg_12_0.actid:GetTownLevel()
		local var_12_6 = arg_12_0:getCollectDataBySiteId(arg_12_2[iter_12_1]).unlock[2]
		local var_12_7 = arg_12_0.page1Items[iter_12_1].tf:Find("lock")
		local var_12_8 = arg_12_0.page1Items[iter_12_1].tf:Find("bg2")
		local var_12_9 = arg_12_0.page1Items[iter_12_1].tf:Find("desc_bg")
		local var_12_10 = arg_12_0.page1Items[iter_12_1].tf:Find("icon")

		setText(arg_12_0.page1Items[iter_12_1].tf:Find("lock/Text"), arg_12_0:getCollectDataBySiteId(arg_12_2[iter_12_1]).unlock_desc)
		setActive(var_12_10, var_12_5)
		setActive(var_12_9, var_12_5)
		setActive(var_12_7, not var_12_5)
		setActive(var_12_8, not var_12_5)
	end

	return
end

function var_0_0.updatePage3(arg_13_0, arg_13_1, arg_13_2)
	if not arg_13_0.page3Items then
		arg_13_0.page3Items = {}

		local var_13_0 = findTF(arg_13_1, "list/content/itemTpl")
		local var_13_1 = findTF(arg_13_1, "list/content")

		setActive(var_13_0, false)

		for iter_13_0 = 1, #arg_13_2 do
			local var_13_2 = arg_13_0:getCollectDataBySiteId(arg_13_2[iter_13_0])
			local var_13_3 = tf(instantiate(var_13_0))

			setParent(var_13_3, var_13_1)
			setActive(var_13_3, true)

			local var_13_4 = var_13_3:Find("ad/mask/icon")
			local var_13_5 = tonumber(var_13_2.icon)
			local var_13_6 = ""

			if pg.ship_skin_template[var_13_5] then
				var_13_6 = HXSet.hxLan(var_13_2.name)

				LoadPaintingPrefabAsync(var_13_4, pg.ship_skin_template[var_13_5].painting, var_0_0.StaticGetPaintingName(pg.ship_skin_template[var_13_5].painting), "biandui", function()
					return
				end)
			else
				print("skin_id no exist" .. var_13_5)
			end

			onButton(arg_13_0, var_13_3, function()
				if arg_13_0:getSiteOpen(var_13_2.site_id) then
					pg.NewStoryMgr.GetInstance():Play(var_13_2.luaID, function()
						return
					end, true)
				end

				return
			end, SFX_CONFIRM)

			local var_13_7 = var_13_3:Find("ad")

			setText(var_13_3:Find("ad/name_bg/name"), var_13_6)

			local var_13_8 = var_13_3:Find("ad/lock")

			setText(var_13_3:Find("ad/lock/Text"), var_13_2.unlock_desc)
			table.insert(arg_13_0.page3Items, {
				tf = var_13_3,
				index = iter_13_0
			})
		end
	end

	for iter_13_1 = 1, #arg_13_0.page3Items do
		local var_13_9 = arg_13_0:getCollectDataBySiteId(arg_13_2[iter_13_1])
		local var_13_10 = arg_13_0.Placeac[arg_13_0:getCollectDataBySiteId(arg_13_2[iter_13_1]).unlock[1]]
		local var_13_11 = arg_13_0:getCollectDataBySiteId(arg_13_2[iter_13_1]).unlock[2] <= var_13_10:GetLevel()
		local var_13_12 = arg_13_0.page3Items[iter_13_1].tf:Find("ad/name_bg")
		local var_13_13 = arg_13_0.page3Items[iter_13_1].tf:Find("ad/lock")

		setActive(arg_13_0.page3Items[iter_13_1].tf:Find("ad/mask/icon"), var_13_11)
		setActive(var_13_12, var_13_11)
		setActive(var_13_13, not var_13_11)
	end

	return
end

function var_0_0.getSiteOpen(arg_17_0, arg_17_1)
	return table.contains(arg_17_0.collectInfo, arg_17_1)
end

function var_0_0.getCollectDataBySiteId(arg_18_0, arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(pg.activity_town_collection_2.all) do
		if pg.activity_town_collection_2[iter_18_1].id == arg_18_1 then
			return pg.activity_town_collection_2[iter_18_1]
		end
	end

	return nil
end

function var_0_0.StaticGetPaintingName(arg_19_0)
	local var_19_0 = arg_19_0

	if checkABExist("painting/" .. arg_19_0 .. "_n") and PlayerPrefs.GetInt("paint_hide_other_obj_" .. var_19_0, 0) ~= 0 then
		var_19_0 = var_19_0 .. "_n"
	end

	if HXSet.isHx() then
		return var_19_0
	end

	local var_19_1 = getProxy(SettingsProxy)
	local var_19_2 = var_19_1:GetMainPaintingVariantFlag(arg_19_0) == var_0_0.PAINTING_VARIANT_EX

	if var_19_2 and not checkABExist("painting/" .. var_19_0 .. "_ex") then
		return var_19_0
	end

	if var_19_2 then
		return var_19_0 .. "_ex" or var_19_0
	end
end

function var_0_0.updateAwardPanel(arg_20_0)
	local var_20_9000
	local var_20_0 = getProxy(TaskProxy)
	local var_20_1 = var_20_0.getTaskVO(var_20_9000, arg_20_0.taskIds[arg_20_0.selectTagIndex])
	local var_20_2 = arg_20_0.awardPanelTf:Find("awardIcon")
	local var_20_3 = var_20_1:getConfig("award_display")[1]

	updateDrop(var_20_2, {
		type = var_20_0[1],
		id = var_20_3[2],
		count = var_20_3[3]
	})
	onButton(arg_20_0, var_20_2, function()
		arg_20_0:emit(var_0_0.ON_DROP, var_0)

		return
	end, SFX_PANEL)
	setText(findTF(arg_20_0.awardPanelTf, "progress"), var_20_1:getProgress() .. "/" .. var_20_1:getConfig("target_num"))
	setSlider(findTF(arg_20_0.awardPanelTf, "Slider"), 0, 1, var_20_1:getProgress() / var_20_1:getConfig("target_num"))
	setText(findTF(arg_20_0.awardPanelTf, "desc"), var_20_1:getConfig("desc"))

	local var_20_4 = findTF(arg_20_0.awardPanelTf, "btnGet")
	local var_20_5 = findTF(arg_20_0.awardPanelTf, "btnGot")
	local var_20_6 = findTF(arg_20_0.awardPanelTf, "btnGo")

	setText(findTF(var_20_4, "text"), i18n("LiquorFloor_story_get"))
	setText(findTF(var_20_5, "text"), i18n("LiquorFloor_story_got"))
	setText(findTF(var_20_6, "text"), i18n("LiquorFloor_story_go"))
	setActive(var_20_4, false)
	setActive(var_20_5, false)
	setActive(imgGot, false)
	setActive(var_20_6, false)

	if var_20_1:getTaskStatus() == 0 then
		setActive(var_20_6, true)
	elseif var_20_1:getTaskStatus() == 1 then
		setActive(var_20_4, true)
	elseif var_20_1:getTaskStatus() == 2 then
		setActive(var_20_5, true)
		setActive(imgGot, true)
	end

	onButton(arg_20_0, var_20_6, function()
		arg_20_0:closeView()

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.willExit(arg_23_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_23_0._ad, arg_23_0._tf)

	return
end

return var_0_0
