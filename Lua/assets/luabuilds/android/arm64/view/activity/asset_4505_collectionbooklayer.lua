local CollectionBookLayer = class("CollectionBookLayer", import("view.base.BaseUI"))
local var_0_1 = 3
local var_0_2 = 3

function CollectionBookLayer:getUIName()
	return "CollectionBookUI"
end

function CollectionBookLayer:init()
	local var_2_0 = getProxy(ActivityProxy):getActivityById(CollectionBookMediator.ACT_ID)

	self.collectInfo = var_2_0:getData1List() or {}
	self.taskIds = var_2_0:getConfig("config_client").collect_task
	self.pageCollectSiteIds = {}

	for iter_2_0 = 1, var_0_2 do
		table.insert(self.pageCollectSiteIds, pg.task_data_template[self.taskIds[iter_2_0]].target_id)
	end

	return
end

function CollectionBookLayer:didEnter()
	self._ad = findTF(self._tf, "ad")

	onButton(self, findTF(self._tf, "ad/close"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self._tf, "ad/buttom"), function()
		self:closeView()

		return
	end, SFX_CANCEL)

	self.tags = {}

	for iter_3_0 = 1, var_0_1 do
		local var_3_0 = iter_3_0
		local var_3_1 = findTF(self._tf, "ad/tag/bg_part_" .. iter_3_0)
		local var_3_2 = findTF(self._tf, "ad/tag/btn_part_" .. iter_3_0)

		table.insert(self.tags, {
			btn = var_3_2,
			bg = var_3_1,
			index = iter_3_0
		})
		onButton(self, var_3_2, function()
			self:selectTag(var_3_0)

			return
		end, SFX_CONFIRM)
		setText(findTF(var_3_1, "ad/text"), i18n("collection_book_tag_" .. iter_3_0))
		setText(findTF(var_3_2, "ad/text"), i18n("collection_book_tag_" .. iter_3_0))
	end

	self.pages = {}

	for iter_3_1 = 1, var_0_2 do
		table.insert(self.pages, {
			tf = findTF(self._tf, "ad/page_" .. iter_3_1),
			index = iter_3_1
		})
	end

	self.awardPanelTf = findTF(self._tf, "ad/award_panel")

	onButton(self, findTF(self.awardPanelTf, "btnGet"), function()
		pg.m02:sendNotification(GAME.SUBMIT_TASK, self.taskIds[self.selectTagIndex])

		return
	end, SFX_CONFIRM)
	self:selectTag(1)
	pg.UIMgr.GetInstance():BlurPanel(self._ad)

	return
end

function CollectionBookLayer:selectTag(arg_8_1)
	self.selectTagIndex = arg_8_1

	self:updateTag()
	self:updatePage()
	self:updateAwardPanel()

	return
end

function CollectionBookLayer:updateTag()
	for iter_9_0 = 1, #self.tags do
		local var_9_0 = self.tags[iter_9_0]

		setActive(self.tags[iter_9_0].bg, self.tags[iter_9_0].index == self.selectTagIndex)
		setActive(var_9_0.btn, var_9_0.index ~= self.selectTagIndex)

		local var_9_1 = getProxy(TaskProxy):getTaskById(self.taskIds[iter_9_0])

		if var_9_1 and var_9_1:getTaskStatus() == 1 then
			setActive(findTF(var_9_0.btn, "ad/tip"), true)
		else
			setActive(findTF(var_9_0.btn, "ad/tip"), false)
		end
	end

	return
end

function CollectionBookLayer:updatePage()
	for iter_10_0 = 1, #self.pages do
		local var_10_0 = self.pages[iter_10_0]

		setActive(self.pages[iter_10_0].tf, self.pages[iter_10_0].index == self.selectTagIndex)

		if var_10_0.index == 1 then
			self:updatePage1(var_10_0.tf, self.pageCollectSiteIds[var_10_0.index])
		elseif var_10_0.index == 2 then
			self:updatePage2(var_10_0.tf, self.pageCollectSiteIds[var_10_0.index])
		elseif var_10_0.index == 3 then
			self:updatePage3(var_10_0.tf, self.pageCollectSiteIds[var_10_0.index])
		end
	end

	return
end

function CollectionBookLayer:updatePage1(arg_11_1, arg_11_2)
	if not self.page1Items then
		self.page1Items = {}

		local var_11_0 = findTF(arg_11_1, "list/content/itemTpl")
		local var_11_1 = findTF(arg_11_1, "list/content")

		setActive(var_11_0, false)

		for iter_11_0 = 1, #arg_11_2 do
			local var_11_2 = self:getCollectDataBySiteId(arg_11_2[iter_11_0])
			local var_11_3 = tf(instantiate(var_11_0))

			setParent(var_11_3, var_11_1)
			setActive(var_11_3, true)
			LoadImageSpriteAsync(pg.activity_holiday_site[var_11_2.site_id].jumpto[3][1], findTF(var_11_3, "place/mask/icon"), true)
			setText(findTF(var_11_3, "bg_title/text"), pg.activity_holiday_site[var_11_2.site_id].jumpto[1][1])
			setText(findTF(var_11_3, "desc/text"), pg.activity_holiday_site[var_11_2.site_id].jumpto[2][1])
			setText(findTF(var_11_3, "desc/lock"), i18n("collection_book_lock_place"))
			self:setNumText(findTF(var_11_3, "place/num_1"), findTF(var_11_3, "place/num_2"), iter_11_0)
			table.insert(self.page1Items, {
				tf = var_11_3,
				index = iter_11_0,
				site_id = var_11_2.site_id
			})
		end
	end

	for iter_11_1 = 1, #self.page1Items do
		local var_11_4 = self:getSiteOpen(self.page1Items[iter_11_1].site_id)

		setActive(findTF(self.page1Items[iter_11_1].tf, "place/mask"), var_11_4)
		setActive(findTF(self.page1Items[iter_11_1].tf, "place/bg/icon_lock"), not var_11_4)
		setActive(findTF(self.page1Items[iter_11_1].tf, "bg_title/text"), var_11_4)
		setActive(findTF(self.page1Items[iter_11_1].tf, "bg_title/lock"), not var_11_4)
		setActive(findTF(self.page1Items[iter_11_1].tf, "desc/text"), var_11_4)
		setActive(findTF(self.page1Items[iter_11_1].tf, "desc/lock"), not var_11_4)
	end

	return
end

function CollectionBookLayer:updatePage2(arg_12_1, arg_12_2)
	if not self.page2Items then
		self.page2Items = {}

		local var_12_0 = findTF(arg_12_1, "list/content/itemTpl")
		local var_12_1 = findTF(arg_12_1, "list/content")

		setActive(var_12_0, false)

		for iter_12_0 = 1, #arg_12_2 do
			local var_12_2 = self:getCollectDataBySiteId(arg_12_2[iter_12_0])
			local var_12_3 = tf(instantiate(var_12_0))

			setParent(var_12_3, var_12_1)
			setActive(var_12_3, true)
			onButton(self, var_12_3, function()
				if self:getSiteOpen(var_12_2.site_id) then
					pg.NewStoryMgr.GetInstance():Play(var_12_2.luaID, function()
						return
					end, true)
				end

				return
			end, SFX_CONFIRM)
			LoadImageSpriteAsync("bg/" .. var_12_2.icon, findTF(var_12_3, "mask/icon"), true)

			local var_12_4 = self:getMemoryData(var_12_2.luaID)
			local var_12_5 = findTF(var_12_3, "desc")

			if var_12_4 then
				setText(var_12_5, var_12_4.title)
			else
				setText(var_12_5, "")
			end

			self:setNumText(findTF(var_12_3, "num_1"), findTF(var_12_3, "num_2"), iter_12_0)
			table.insert(self.page2Items, {
				tf = var_12_3,
				index = iter_12_0,
				site_id = var_12_2.site_id
			})
		end
	end

	for iter_12_1 = 1, #self.page2Items do
		local var_12_6 = self:getSiteOpen(self.page2Items[iter_12_1].site_id)
		local var_12_7 = findTF(self.page2Items[iter_12_1].tf, "desc_lock")
		local var_12_8 = findTF(self.page2Items[iter_12_1].tf, "lock")
		local var_12_9 = findTF(self.page2Items[iter_12_1].tf, "mask/icon")

		setActive(findTF(self.page2Items[iter_12_1].tf, "desc"), var_12_6)
		setActive(var_12_7, not var_12_6)
		setActive(var_12_8, not var_12_6)
		setActive(var_12_9, var_12_6)
	end

	return
end

CollectionBookLayer.StoryData = {}

function CollectionBookLayer:getMemoryData(arg_15_1)
	if CollectionBookLayer.StoryData[arg_15_1] then
		return CollectionBookLayer.StoryData[arg_15_1]
	end

	for iter_15_0, iter_15_1 in ipairs(pg.memory_template.all) do
		if pg.memory_template[iter_15_1].story == arg_15_1 then
			CollectionBookLayer.StoryData[arg_15_1] = Clone(pg.memory_template[iter_15_1])

			return CollectionBookLayer.StoryData[arg_15_1]
		end
	end

	return nil
end

function CollectionBookLayer:updatePage3(arg_16_1, arg_16_2)
	if not self.page3Items then
		self.page3Items = {}

		local var_16_0 = findTF(arg_16_1, "list/content/itemTpl")
		local var_16_1 = findTF(arg_16_1, "list/content")

		self.page3ScrollRect = GetComponent(findTF(arg_16_1, "list"), typeof(ScrollRect))
		self.leftA = findTF(arg_16_1, "left_aix")
		self.rightA = findTF(arg_16_1, "right_aix")

		setActive(self.leftA, false)
		self.page3ScrollRect.onValueChanged:AddListener(function()
			if self.page3ScrollRect.normalizedPosition.x <= 0.01 then
				setActive(self.leftA, false)
			elseif self.page3ScrollRect.normalizedPosition.x >= 1 then
				setActive(self.rightA, false)
			else
				setActive(self.leftA, true)
				setActive(self.rightA, true)
			end

			return
		end)
		setActive(var_16_0, false)

		for iter_16_0 = 1, #arg_16_2 do
			local var_16_2 = self:getCollectDataBySiteId(arg_16_2[iter_16_0])
			local var_16_3 = tf(instantiate(var_16_0))

			setParent(var_16_3, var_16_1)
			setActive(var_16_3, true)

			local var_16_4 = findTF(var_16_3, "ad/mask/icon")
			local var_16_5 = tonumber(var_16_2.icon)
			local var_16_6 = ""

			if pg.ship_skin_template[var_16_5] then
				var_16_6 = HXSet.hxLan(var_16_2.name)

				LoadPaintingPrefabAsync(var_16_4, pg.ship_skin_template[var_16_5].painting, CollectionBookLayer.StaticGetPaintingName(pg.ship_skin_template[var_16_5].painting), "biandui", function()
					return
				end)
			else
				print("skin_id no exist" .. var_16_5)
			end

			onButton(self, var_16_3, function()
				if self:getSiteOpen(var_16_2.site_id) then
					pg.NewStoryMgr.GetInstance():Play(var_16_2.luaID, function()
						return
					end, true)
				end

				return
			end, SFX_CONFIRM)

			findTF(var_16_3, "ad").anchoredPosition = Vector2(0, iter_16_0 % 2 == 0 and 0 or 25)

			setText(findTF(var_16_3, "ad/name"), var_16_6)

			local var_16_7 = findTF(var_16_3, "ad/name_lock")

			self:setNumText(findTF(var_16_3, "ad/num_1"), findTF(var_16_3, "ad/num_2"), iter_16_0)
			table.insert(self.page3Items, {
				tf = var_16_3,
				index = iter_16_0,
				site_id = var_16_2.site_id
			})
		end
	end

	for iter_16_1 = 1, #self.page3Items do
		local var_16_8 = self:getSiteOpen(self.page3Items[iter_16_1].site_id)
		local var_16_9 = findTF(self.page3Items[iter_16_1].tf, "ad/name")
		local var_16_10 = findTF(self.page3Items[iter_16_1].tf, "ad/name_lock")
		local var_16_11 = findTF(self.page3Items[iter_16_1].tf, "ad/lock")

		setActive(findTF(self.page3Items[iter_16_1].tf, "ad/mask/icon"), var_16_8)
		setActive(var_16_9, var_16_8)
		setActive(var_16_10, not var_16_8)
		setActive(var_16_11, not var_16_8)
	end

	return
end

function CollectionBookLayer:getSiteOpen(arg_21_1)
	return table.contains(self.collectInfo, arg_21_1)
end

function CollectionBookLayer:getCollectDataBySiteId(arg_22_1)
	for iter_22_0, iter_22_1 in ipairs(pg.activity_holiday_collection.all) do
		if pg.activity_holiday_collection[iter_22_1].site_id == arg_22_1 then
			return pg.activity_holiday_collection[iter_22_1]
		end
	end

	return nil
end

function CollectionBookLayer:StaticGetPaintingName()
	local var_23_0 = self

	if checkABExist("painting/" .. self .. "_n") and PlayerPrefs.GetInt("paint_hide_other_obj_" .. var_23_0, 0) ~= 0 then
		var_23_0 = var_23_0 .. "_n"
	end

	if HXSet.isHx() then
		return var_23_0
	end

	local var_23_1 = getProxy(SettingsProxy):GetMainPaintingVariantFlag(self) == CollectionBookLayer.PAINTING_VARIANT_EX

	if var_23_1 and not checkABExist("painting/" .. var_23_0 .. "_ex") then
		return var_23_0
	end

	return (var_23_1 or nil) and (var_23_0 .. "_ex" or var_23_0)
end

function CollectionBookLayer:setNumText(arg_24_1, arg_24_2, arg_24_3)
	self:setChildVisible(arg_24_1, false)
	self:setChildVisible(arg_24_2, false)
	setActive(findTF(arg_24_1, "num_" .. tostring(arg_24_3 % 10)), true)
	setActive(findTF(arg_24_2, "num_" .. tostring(math.floor(arg_24_3 / 10))), true)

	return
end

function CollectionBookLayer:setChildVisible(arg_25_1, arg_25_2)
	for iter_25_0 = 1, arg_25_1.childCount do
		setActive(arg_25_1:GetChild(iter_25_0 - 1), arg_25_2)
	end

	return
end

function CollectionBookLayer:updateAwardPanel()
	local var_26_0 = getProxy(TaskProxy):getTaskById(self.taskIds[self.selectTagIndex])

	var_26_0 = var_26_0 or getProxy(TaskProxy):getFinishTaskById(self.taskIds[self.selectTagIndex])

	local var_26_1 = findTF(self.awardPanelTf, "awardIcon")
	local var_26_2 = var_26_0:getConfig("award_display")[1]
	local var_26_3 = {
		type = var_26_2[1],
		id = var_26_2[2],
		count = var_26_2[3]
	}

	updateDrop(var_26_1, var_26_3)
	onButton(self, var_26_1, function()
		self:emit(CollectionBookLayer.ON_DROP, var_26_3)

		return
	end, SFX_PANEL)
	setText(findTF(self.awardPanelTf, "progress"), var_26_0:getProgress() .. "/" .. var_26_0:getConfig("target_num"))
	setText(findTF(self.awardPanelTf, "desc"), var_26_0:getConfig("desc"))

	local var_26_4 = findTF(self.awardPanelTf, "btnGet")
	local var_26_5 = findTF(self.awardPanelTf, "btnGot")
	local var_26_6 = findTF(self.awardPanelTf, "btnGo")
	local var_26_7 = findTF(self.awardPanelTf, "imgGot")

	setText(findTF(var_26_4, "text"), i18n("task_get"))
	setText(findTF(var_26_5, "text"), i18n("avatarframe_got"))
	setText(findTF(var_26_6, "text"), i18n("task_get"))
	setActive(var_26_4, false)
	setActive(var_26_5, false)
	setActive(var_26_7, false)
	setActive(var_26_6, false)

	if var_26_0:getTaskStatus() == 0 then
		var_26_6:GetComponent("UIGrayScale").enabled = false
		var_26_6:GetComponent("UIGrayScale").enabled = true

		setActive(var_26_6, true)
	elseif var_26_0:getTaskStatus() == 1 then
		setActive(var_26_4, true)
	elseif var_26_0:getTaskStatus() == 2 then
		setActive(var_26_5, true)
		setActive(var_26_7, true)
	end

	return
end

function CollectionBookLayer:willExit()
	self.page3ScrollRect.onValueChanged:RemoveAllListeners()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._ad, self._tf)

	return
end

return CollectionBookLayer
