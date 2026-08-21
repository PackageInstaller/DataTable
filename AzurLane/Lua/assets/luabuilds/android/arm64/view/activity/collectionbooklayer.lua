local var_0_0 = class("CollectionBookLayer", import("view.base.BaseUI"))
local var_0_1 = 3
local var_0_2 = 3

function var_0_0.getUIName(arg_1_0)
	return "CollectionBookUI"
end

function var_0_0.init(arg_2_0)
	local var_2_0 = getProxy(ActivityProxy):getActivityById(CollectionBookMediator.ACT_ID)

	arg_2_0.collectInfo = var_2_0:getData1List() or {}
	arg_2_0.taskIds = var_2_0:getConfig("config_client").collect_task
	arg_2_0.pageCollectSiteIds = {}

	for iter_2_0 = 1, var_0_2 do
		table.insert(arg_2_0.pageCollectSiteIds, pg.task_data_template[arg_2_0.taskIds[iter_2_0]].target_id)
	end

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0._ad = findTF(arg_3_0._tf, "ad")

	onButton(arg_3_0, findTF(arg_3_0._tf, "ad/close"), function()
		arg_3_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, findTF(arg_3_0._tf, "ad/buttom"), function()
		arg_3_0:closeView()

		return
	end, SFX_CANCEL)

	arg_3_0.tags = {}

	for iter_3_0 = 1, var_0_1 do
		local var_3_0 = iter_3_0
		local var_3_1 = findTF(arg_3_0._tf, "ad/tag/bg_part_" .. iter_3_0)
		local var_3_2 = findTF(arg_3_0._tf, "ad/tag/btn_part_" .. iter_3_0)

		table.insert(arg_3_0.tags, {
			btn = var_3_2,
			bg = var_3_1,
			index = iter_3_0
		})
		onButton(arg_3_0, var_3_2, function()
			arg_3_0:selectTag(var_3_0)

			return
		end, SFX_CONFIRM)
		setText(findTF(var_3_1, "ad/text"), i18n("collection_book_tag_" .. iter_3_0))
		setText(findTF(var_3_2, "ad/text"), i18n("collection_book_tag_" .. iter_3_0))
	end

	arg_3_0.pages = {}

	for iter_3_1 = 1, var_0_2 do
		table.insert(arg_3_0.pages, {
			tf = findTF(arg_3_0._tf, "ad/page_" .. iter_3_1),
			index = iter_3_1
		})
	end

	arg_3_0.awardPanelTf = findTF(arg_3_0._tf, "ad/award_panel")

	onButton(arg_3_0, findTF(arg_3_0.awardPanelTf, "btnGet"), function()
		pg.m02:sendNotification(GAME.SUBMIT_TASK, arg_3_0.taskIds[arg_3_0.selectTagIndex])

		return
	end, SFX_CONFIRM)
	arg_3_0:selectTag(1)
	pg.UIMgr.GetInstance():BlurPanel(arg_3_0._ad)

	return
end

function var_0_0.selectTag(arg_8_0, arg_8_1)
	arg_8_0.selectTagIndex = arg_8_1

	arg_8_0:updateTag()
	arg_8_0:updatePage()
	arg_8_0:updateAwardPanel()

	return
end

function var_0_0.updateTag(arg_9_0)
	for iter_9_0 = 1, #arg_9_0.tags do
		local var_9_0 = arg_9_0.tags[iter_9_0]

		setActive(arg_9_0.tags[iter_9_0].bg, arg_9_0.tags[iter_9_0].index == arg_9_0.selectTagIndex)
		setActive(var_9_0.btn, var_9_0.index ~= arg_9_0.selectTagIndex)

		local var_9_1 = getProxy(TaskProxy):getTaskById(arg_9_0.taskIds[iter_9_0])

		if var_9_1 and var_9_1:getTaskStatus() == 1 then
			setActive(findTF(var_9_0.btn, "ad/tip"), true)
		else
			setActive(findTF(var_9_0.btn, "ad/tip"), false)
		end
	end

	return
end

function var_0_0.updatePage(arg_10_0)
	for iter_10_0 = 1, #arg_10_0.pages do
		local var_10_0 = arg_10_0.pages[iter_10_0]

		setActive(arg_10_0.pages[iter_10_0].tf, arg_10_0.pages[iter_10_0].index == arg_10_0.selectTagIndex)

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

function var_0_0.updatePage1(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_0.page1Items then
		arg_11_0.page1Items = {}

		local var_11_0 = findTF(arg_11_1, "list/content/itemTpl")
		local var_11_1 = findTF(arg_11_1, "list/content")

		setActive(var_11_0, false)

		for iter_11_0 = 1, #arg_11_2 do
			local var_11_2 = arg_11_0:getCollectDataBySiteId(arg_11_2[iter_11_0])
			local var_11_3 = tf(instantiate(var_11_0))

			setParent(var_11_3, var_11_1)
			setActive(var_11_3, true)
			LoadImageSpriteAsync(pg.activity_holiday_site[var_11_2.site_id].jumpto[3][1], findTF(var_11_3, "place/mask/icon"), true)
			setText(findTF(var_11_3, "bg_title/text"), pg.activity_holiday_site[var_11_2.site_id].jumpto[1][1])
			setText(findTF(var_11_3, "desc/text"), pg.activity_holiday_site[var_11_2.site_id].jumpto[2][1])
			setText(findTF(var_11_3, "desc/lock"), i18n("collection_book_lock_place"))
			arg_11_0:setNumText(findTF(var_11_3, "place/num_1"), findTF(var_11_3, "place/num_2"), iter_11_0)
			table.insert(arg_11_0.page1Items, {
				tf = var_11_3,
				index = iter_11_0,
				site_id = var_11_2.site_id
			})
		end
	end

	for iter_11_1 = 1, #arg_11_0.page1Items do
		local var_11_4 = arg_11_0:getSiteOpen(arg_11_0.page1Items[iter_11_1].site_id)

		setActive(findTF(arg_11_0.page1Items[iter_11_1].tf, "place/mask"), var_11_4)
		setActive(findTF(arg_11_0.page1Items[iter_11_1].tf, "place/bg/icon_lock"), not var_11_4)
		setActive(findTF(arg_11_0.page1Items[iter_11_1].tf, "bg_title/text"), var_11_4)
		setActive(findTF(arg_11_0.page1Items[iter_11_1].tf, "bg_title/lock"), not var_11_4)
		setActive(findTF(arg_11_0.page1Items[iter_11_1].tf, "desc/text"), var_11_4)
		setActive(findTF(arg_11_0.page1Items[iter_11_1].tf, "desc/lock"), not var_11_4)
	end

	return
end

function var_0_0.updatePage2(arg_12_0, arg_12_1, arg_12_2)
	if not arg_12_0.page2Items then
		arg_12_0.page2Items = {}

		local var_12_0 = findTF(arg_12_1, "list/content/itemTpl")
		local var_12_1 = findTF(arg_12_1, "list/content")

		setActive(var_12_0, false)

		for iter_12_0 = 1, #arg_12_2 do
			local var_12_2 = arg_12_0:getCollectDataBySiteId(arg_12_2[iter_12_0])
			local var_12_3 = tf(instantiate(var_12_0))

			setParent(var_12_3, var_12_1)
			setActive(var_12_3, true)
			onButton(arg_12_0, var_12_3, function()
				if arg_12_0:getSiteOpen(var_12_2.site_id) then
					pg.NewStoryMgr.GetInstance():Play(var_12_2.luaID, function()
						return
					end, true)
				end

				return
			end, SFX_CONFIRM)
			LoadImageSpriteAsync("bg/" .. var_12_2.icon, findTF(var_12_3, "mask/icon"), true)

			local var_12_4 = arg_12_0:getMemoryData(var_12_2.luaID)
			local var_12_5 = findTF(var_12_3, "desc")

			if var_12_4 then
				setText(var_12_5, var_12_4.title)
			else
				setText(var_12_5, "")
			end

			arg_12_0:setNumText(findTF(var_12_3, "num_1"), findTF(var_12_3, "num_2"), iter_12_0)
			table.insert(arg_12_0.page2Items, {
				tf = var_12_3,
				index = iter_12_0,
				site_id = var_12_2.site_id
			})
		end
	end

	for iter_12_1 = 1, #arg_12_0.page2Items do
		local var_12_6 = arg_12_0:getSiteOpen(arg_12_0.page2Items[iter_12_1].site_id)
		local var_12_7 = findTF(arg_12_0.page2Items[iter_12_1].tf, "desc_lock")
		local var_12_8 = findTF(arg_12_0.page2Items[iter_12_1].tf, "lock")
		local var_12_9 = findTF(arg_12_0.page2Items[iter_12_1].tf, "mask/icon")

		setActive(findTF(arg_12_0.page2Items[iter_12_1].tf, "desc"), var_12_6)
		setActive(var_12_7, not var_12_6)
		setActive(var_12_8, not var_12_6)
		setActive(var_12_9, var_12_6)
	end

	return
end

var_0_0.StoryData = {}

function var_0_0.getMemoryData(arg_15_0, arg_15_1)
	if var_0_0.StoryData[arg_15_1] then
		return var_0_0.StoryData[arg_15_1]
	end

	for iter_15_0, iter_15_1 in ipairs(pg.memory_template.all) do
		if pg.memory_template[iter_15_1].story == arg_15_1 then
			var_0_0.StoryData[arg_15_1] = Clone(pg.memory_template[iter_15_1])

			return var_0_0.StoryData[arg_15_1]
		end
	end

	return nil
end

function var_0_0.updatePage3(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_0.page3Items then
		arg_16_0.page3Items = {}

		local var_16_0 = findTF(arg_16_1, "list/content/itemTpl")
		local var_16_1 = findTF(arg_16_1, "list/content")

		arg_16_0.page3ScrollRect = GetComponent(findTF(arg_16_1, "list"), typeof(ScrollRect))
		arg_16_0.leftA = findTF(arg_16_1, "left_aix")
		arg_16_0.rightA = findTF(arg_16_1, "right_aix")

		setActive(arg_16_0.leftA, false)
		arg_16_0.page3ScrollRect.onValueChanged:AddListener(function()
			if arg_16_0.page3ScrollRect.normalizedPosition.x <= 0.01 then
				setActive(arg_16_0.leftA, false)
			elseif arg_16_0.page3ScrollRect.normalizedPosition.x >= 1 then
				setActive(arg_16_0.rightA, false)
			else
				setActive(arg_16_0.leftA, true)
				setActive(arg_16_0.rightA, true)
			end

			return
		end)
		setActive(var_16_0, false)

		for iter_16_0 = 1, #arg_16_2 do
			local var_16_2 = arg_16_0:getCollectDataBySiteId(arg_16_2[iter_16_0])
			local var_16_3 = tf(instantiate(var_16_0))

			setParent(var_16_3, var_16_1)
			setActive(var_16_3, true)

			local var_16_4 = findTF(var_16_3, "ad/mask/icon")
			local var_16_5 = tonumber(var_16_2.icon)
			local var_16_6 = ""

			if pg.ship_skin_template[var_16_5] then
				var_16_6 = HXSet.hxLan(var_16_2.name)

				LoadPaintingPrefabAsync(var_16_4, pg.ship_skin_template[var_16_5].painting, var_0_0.StaticGetPaintingName(pg.ship_skin_template[var_16_5].painting), "biandui", function()
					return
				end)
			else
				print("skin_id no exist" .. var_16_5)
			end

			onButton(arg_16_0, var_16_3, function()
				if arg_16_0:getSiteOpen(var_16_2.site_id) then
					pg.NewStoryMgr.GetInstance():Play(var_16_2.luaID, function()
						return
					end, true)
				end

				return
			end, SFX_CONFIRM)

			findTF(var_16_3, "ad").anchoredPosition = Vector2(0, iter_16_0 % 2 == 0 and 0 or 25)

			setText(findTF(var_16_3, "ad/name"), var_16_6)

			local var_16_7 = findTF(var_16_3, "ad/name_lock")

			arg_16_0:setNumText(findTF(var_16_3, "ad/num_1"), findTF(var_16_3, "ad/num_2"), iter_16_0)
			table.insert(arg_16_0.page3Items, {
				tf = var_16_3,
				index = iter_16_0,
				site_id = var_16_2.site_id
			})
		end
	end

	for iter_16_1 = 1, #arg_16_0.page3Items do
		local var_16_8 = arg_16_0:getSiteOpen(arg_16_0.page3Items[iter_16_1].site_id)
		local var_16_9 = findTF(arg_16_0.page3Items[iter_16_1].tf, "ad/name")
		local var_16_10 = findTF(arg_16_0.page3Items[iter_16_1].tf, "ad/name_lock")
		local var_16_11 = findTF(arg_16_0.page3Items[iter_16_1].tf, "ad/lock")

		setActive(findTF(arg_16_0.page3Items[iter_16_1].tf, "ad/mask/icon"), var_16_8)
		setActive(var_16_9, var_16_8)
		setActive(var_16_10, not var_16_8)
		setActive(var_16_11, not var_16_8)
	end

	return
end

function var_0_0.getSiteOpen(arg_21_0, arg_21_1)
	return table.contains(arg_21_0.collectInfo, arg_21_1)
end

function var_0_0.getCollectDataBySiteId(arg_22_0, arg_22_1)
	for iter_22_0, iter_22_1 in ipairs(pg.activity_holiday_collection.all) do
		if pg.activity_holiday_collection[iter_22_1].site_id == arg_22_1 then
			return pg.activity_holiday_collection[iter_22_1]
		end
	end

	return nil
end

function var_0_0.StaticGetPaintingName(arg_23_0)
	local var_23_0 = arg_23_0

	if checkABExist("painting/" .. arg_23_0 .. "_n") and PlayerPrefs.GetInt("paint_hide_other_obj_" .. var_23_0, 0) ~= 0 then
		var_23_0 = var_23_0 .. "_n"
	end

	if HXSet.isHx() then
		return var_23_0
	end

	local var_23_1 = getProxy(SettingsProxy)
	local var_23_2 = var_23_1:GetMainPaintingVariantFlag(arg_23_0) == var_0_0.PAINTING_VARIANT_EX

	if var_23_2 and not checkABExist("painting/" .. var_23_0 .. "_ex") then
		return var_23_0
	end

	if var_23_2 then
		return var_23_0 .. "_ex" or var_23_0
	end
end

function var_0_0.setNumText(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	arg_24_0:setChildVisible(arg_24_1, false)
	arg_24_0:setChildVisible(arg_24_2, false)
	setActive(findTF(arg_24_1, "num_" .. tostring(arg_24_3 % 10)), true)
	setActive(findTF(arg_24_2, "num_" .. tostring(math.floor(arg_24_3 / 10))), true)

	return
end

function var_0_0.setChildVisible(arg_25_0, arg_25_1, arg_25_2)
	for iter_25_0 = 1, arg_25_1.childCount do
		setActive(arg_25_1:GetChild(iter_25_0 - 1), arg_25_2)
	end

	return
end

function var_0_0.updateAwardPanel(arg_26_0)
	local var_26_0 = getProxy(TaskProxy):getTaskById(arg_26_0.taskIds[arg_26_0.selectTagIndex])

	var_26_0 = var_26_0 or getProxy(TaskProxy):getFinishTaskById(arg_26_0.taskIds[arg_26_0.selectTagIndex])

	local var_26_1 = findTF(arg_26_0.awardPanelTf, "awardIcon")
	local var_26_2 = var_26_0:getConfig("award_display")[1]

	updateDrop(var_26_1, {
		type = var_26_2[1],
		id = var_26_2[2],
		count = var_26_2[3]
	})
	onButton(arg_26_0, var_26_1, function()
		arg_26_0:emit(var_0_0.ON_DROP, var_0)

		return
	end, SFX_PANEL)
	setText(findTF(arg_26_0.awardPanelTf, "progress"), var_26_0:getProgress() .. "/" .. var_26_0:getConfig("target_num"))
	setText(findTF(arg_26_0.awardPanelTf, "desc"), var_26_0:getConfig("desc"))

	local var_26_3 = findTF(arg_26_0.awardPanelTf, "btnGet")
	local var_26_4 = findTF(arg_26_0.awardPanelTf, "btnGot")
	local var_26_5 = findTF(arg_26_0.awardPanelTf, "btnGo")
	local var_26_6 = findTF(arg_26_0.awardPanelTf, "imgGot")

	setText(findTF(var_26_3, "text"), i18n("task_get"))
	setText(findTF(var_26_4, "text"), i18n("avatarframe_got"))
	setText(findTF(var_26_5, "text"), i18n("task_get"))
	setActive(var_26_3, false)
	setActive(var_26_4, false)
	setActive(var_26_6, false)
	setActive(var_26_5, false)

	if var_26_0:getTaskStatus() == 0 then
		var_26_5:GetComponent("UIGrayScale").enabled = false
		var_26_5:GetComponent("UIGrayScale").enabled = true

		setActive(var_26_5, true)
	elseif var_26_0:getTaskStatus() == 1 then
		setActive(var_26_3, true)
	elseif var_26_0:getTaskStatus() == 2 then
		setActive(var_26_4, true)
		setActive(var_26_6, true)
	end

	return
end

function var_0_0.willExit(arg_28_0)
	arg_28_0.page3ScrollRect.onValueChanged:RemoveAllListeners()
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_28_0._ad, arg_28_0._tf)

	return
end

return var_0_0
