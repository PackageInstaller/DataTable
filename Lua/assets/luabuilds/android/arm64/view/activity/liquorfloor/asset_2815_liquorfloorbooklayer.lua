local LiquorFloorBookLayer = class("LiquorFloorBookLayer", import("view.base.BaseUI"))
local var_0_1 = 3
local var_0_2 = 3

function LiquorFloorBookLayer:getUIName()
	return "LiquorFloorBookUI"
end

function LiquorFloorBookLayer:init()
	self.actid = getProxy(ActivityProxy):getActivityById(ActivityConst.LiquorFloor_ACT_ID)
	self.Placeac = self.actid:GetPlaceList()
	self.gather1 = {}
	self.gather2 = {}
	self.gather3 = {}
	self.client = self.actid:getConfig("config_client").BookData
	self.pageCollectSiteIds = {}

	for iter_2_0, iter_2_1 in ipairs(self.client[1].data1) do
		table.insert(self.gather1, iter_2_1)
	end

	for iter_2_2, iter_2_3 in ipairs(self.client[2].data2) do
		table.insert(self.gather2, iter_2_3)
	end

	for iter_2_4, iter_2_5 in ipairs(self.client[3].data3) do
		table.insert(self.gather3, iter_2_5)
	end

	self.taskIds = {}

	for iter_2_6 = 1, #self.client do
		self.taskId = self.client[iter_2_6].task

		table.insert(self.taskIds, self.taskId)
	end

	return
end

function LiquorFloorBookLayer:didEnter()
	self._ad = self._tf:Find("ad")

	setText(self._ad:Find("bg/title_bg/title"), i18n("LiquorFloor_story_title_4"))
	onButton(self, self._tf:Find("ad/close"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("ad/buttom"), function()
		self:closeView()

		return
	end, SFX_CANCEL)

	self.tags = {}

	local var_3_0 = 0

	for iter_3_0 = 1, var_0_1 do
		local var_3_1 = iter_3_0
		local var_3_2 = self._tf:Find("ad/tag/" .. iter_3_0)

		table.insert(self.tags, {
			btn = var_3_2,
			index = iter_3_0
		})
		onToggle(self, var_3_2, function(arg_6_0)
			if arg_6_0 then
				if var_3_0 ~= var_3_1 then
					self:selectTag(var_3_1, var_3_2)
				end

				var_3_0 = var_3_1
			end

			return
		end, SFX_PANEL)
	end

	self.pages = {}

	for iter_3_1 = 1, var_0_2 do
		table.insert(self.pages, {
			tf = self._tf:Find("ad/page_" .. iter_3_1),
			index = iter_3_1
		})
	end

	self.awardPanelTf = self._tf:Find("ad/award_panel")

	onButton(self, self.awardPanelTf:Find("btnGet"), function()
		self:emit(LiquorFloorBookMediator.ON_GET_TASK, self.taskIds[self.selectTagIndex])

		return
	end, SFX_CONFIRM)
	self:selectTag(1)
	pg.UIMgr.GetInstance():BlurPanel(self._ad)
	setText(self._ad:Find("tag/1/off/text"), i18n("LiquorFloor_story_title_1"))
	setText(self._ad:Find("tag/1/on/text"), i18n("LiquorFloor_story_title_1"))
	setText(self._ad:Find("tag/2/off/text"), i18n("LiquorFloor_story_title_2"))
	setText(self._ad:Find("tag/2/on/text"), i18n("LiquorFloor_story_title_2"))
	setText(self._ad:Find("tag/3/off/text"), i18n("LiquorFloor_story_title_3"))
	setText(self._ad:Find("tag/3/on/text"), i18n("LiquorFloor_story_title_3"))

	return
end

function LiquorFloorBookLayer:selectTag(arg_8_1, arg_8_2)
	self.selectTagIndex = arg_8_1

	self:updateTag()
	self:updatePage()
	self:updateAwardPanel()

	return
end

function LiquorFloorBookLayer:updateTag()
	for iter_9_0 = 1, #self.taskIds do
		local var_9_0 = getProxy(TaskProxy):getTaskById(self.taskIds[iter_9_0])

		if var_9_0 and var_9_0:getTaskStatus() == 1 then
			setActive(self._ad:Find("tag/" .. iter_9_0 .. "/tip"), true)
		else
			setActive(self._ad:Find("tag/" .. iter_9_0 .. "/tip"), false)
		end
	end

	return
end

function LiquorFloorBookLayer:updatePage()
	for iter_10_0 = 1, #self.pages do
		local var_10_0 = self.pages[iter_10_0]

		setActive(self.pages[iter_10_0].tf, self.pages[iter_10_0].index == self.selectTagIndex)

		if var_10_0.index == 1 then
			self:updatePage1(var_10_0.tf, self.gather1)
		elseif var_10_0.index == 2 then
			self:updatePage2(var_10_0.tf, self.gather2)
		elseif var_10_0.index == 3 then
			self:updatePage3(var_10_0.tf, self.gather3)
		end
	end

	return
end

function LiquorFloorBookLayer:updatePage2(arg_11_1, arg_11_2)
	if not self.page2Items then
		self.page2Items = {}

		local var_11_0 = findTF(arg_11_1, "list/content/itemTpl")
		local var_11_1 = findTF(arg_11_1, "list/content")

		setActive(var_11_0, false)

		for iter_11_0 = 1, #arg_11_2 do
			local var_11_2 = self:getCollectDataBySiteId(arg_11_2[iter_11_0])
			local var_11_3 = tf(instantiate(var_11_0))

			setParent(var_11_3, var_11_1)
			setActive(var_11_3, true)
			setImageSprite(var_11_3:Find("bg/icon"), LoadSprite("ui/LiquorFloorUI_atlas", var_11_2.icon), true)
			setScrollText(var_11_3:Find("bg/GameObject/name"), var_11_2.name)
			setText(var_11_3:Find("bg/lock/name"), "???????")
			setText(var_11_3:Find("bg/lock/Text"), var_11_2.unlock_desc)
			table.insert(self.page2Items, {
				tf = var_11_3,
				index = iter_11_0
			})
		end
	end

	for iter_11_1 = 1, #self.page2Items do
		local var_11_4 = self.page2Items[iter_11_1].tf
		local var_11_5 = self:getCollectDataBySiteId(arg_11_2[iter_11_1])
		local var_11_6 = var_11_5.unlock[2] <= self.Placeac[var_11_5.unlock[1]]:GetLevel()

		setActive(self.page2Items[iter_11_1].tf:Find("bg/icon"), var_11_6)
		setActive(var_11_4:Find("bg/lock"), not var_11_6)

		local var_11_7 = var_11_4:Find("bg/lock")

		setActive(var_11_4:Find("bg/GameObject/name"), var_11_6)
		setActive(var_11_7, not var_11_6)
	end

	return
end

function LiquorFloorBookLayer:updatePage1(arg_12_1, arg_12_2)
	if not self.page1Items then
		self.page1Items = {}

		local var_12_0 = arg_12_1:Find("list/content/itemTpl")
		local var_12_1 = arg_12_1:Find("list/content")

		setActive(var_12_0, false)

		for iter_12_0 = 1, #arg_12_2 do
			local var_12_2 = self:getCollectDataBySiteId(arg_12_2[iter_12_0])
			local var_12_3 = tf(instantiate(var_12_0))

			setParent(var_12_3, var_12_1)
			setActive(var_12_3, true)
			LoadImageSpriteAsync("bg/" .. var_12_2.icon, (var_12_3:Find("icon")))

			local var_12_4 = var_12_3:Find("desc_bg/desc")

			SetActive(var_12_3:Find("desc_bg"), memoryData)

			if var_12_2.name then
				setText(var_12_4, var_12_2.name)
			end

			table.insert(self.page1Items, {
				tf = var_12_3,
				index = iter_12_0
			})
		end
	end

	for iter_12_1 = 1, #self.page1Items do
		local var_12_5 = self:getCollectDataBySiteId(arg_12_2[iter_12_1]).unlock[2] <= self.actid:GetTownLevel()
		local var_12_6 = self:getCollectDataBySiteId(arg_12_2[iter_12_1]).unlock[2]
		local var_12_7 = self.page1Items[iter_12_1].tf:Find("lock")
		local var_12_8 = self.page1Items[iter_12_1].tf:Find("bg2")
		local var_12_9 = self.page1Items[iter_12_1].tf:Find("desc_bg")
		local var_12_10 = self.page1Items[iter_12_1].tf:Find("icon")

		setText(self.page1Items[iter_12_1].tf:Find("lock/Text"), self:getCollectDataBySiteId(arg_12_2[iter_12_1]).unlock_desc)
		setActive(var_12_10, var_12_5)
		setActive(var_12_9, var_12_5)
		setActive(var_12_7, not var_12_5)
		setActive(var_12_8, not var_12_5)
	end

	return
end

function LiquorFloorBookLayer:updatePage3(arg_13_1, arg_13_2)
	if not self.page3Items then
		self.page3Items = {}

		local var_13_0 = findTF(arg_13_1, "list/content/itemTpl")
		local var_13_1 = findTF(arg_13_1, "list/content")

		setActive(var_13_0, false)

		for iter_13_0 = 1, #arg_13_2 do
			local var_13_2 = self:getCollectDataBySiteId(arg_13_2[iter_13_0])
			local var_13_3 = tf(instantiate(var_13_0))

			setParent(var_13_3, var_13_1)
			setActive(var_13_3, true)

			local var_13_4 = var_13_3:Find("ad/mask/icon")
			local var_13_5 = tonumber(var_13_2.icon)
			local var_13_6 = ""

			if pg.ship_skin_template[var_13_5] then
				var_13_6 = HXSet.hxLan(var_13_2.name)

				LoadPaintingPrefabAsync(var_13_4, pg.ship_skin_template[var_13_5].painting, LiquorFloorBookLayer.StaticGetPaintingName(pg.ship_skin_template[var_13_5].painting), "biandui", function()
					return
				end)
			else
				print("skin_id no exist" .. var_13_5)
			end

			onButton(self, var_13_3, function()
				if self:getSiteOpen(var_13_2.site_id) then
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
			table.insert(self.page3Items, {
				tf = var_13_3,
				index = iter_13_0
			})
		end
	end

	for iter_13_1 = 1, #self.page3Items do
		local var_13_9 = self:getCollectDataBySiteId(arg_13_2[iter_13_1])
		local var_13_10 = self:getCollectDataBySiteId(arg_13_2[iter_13_1]).unlock[2] <= self.Placeac[self:getCollectDataBySiteId(arg_13_2[iter_13_1]).unlock[1]]:GetLevel()
		local var_13_11 = self.page3Items[iter_13_1].tf:Find("ad/name_bg")
		local var_13_12 = self.page3Items[iter_13_1].tf:Find("ad/lock")

		setActive(self.page3Items[iter_13_1].tf:Find("ad/mask/icon"), var_13_10)
		setActive(var_13_11, var_13_10)
		setActive(var_13_12, not var_13_10)
	end

	return
end

function LiquorFloorBookLayer:getSiteOpen(arg_17_1)
	return table.contains(self.collectInfo, arg_17_1)
end

function LiquorFloorBookLayer:getCollectDataBySiteId(arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(pg.activity_town_collection_2.all) do
		if pg.activity_town_collection_2[iter_18_1].id == arg_18_1 then
			return pg.activity_town_collection_2[iter_18_1]
		end
	end

	return nil
end

function LiquorFloorBookLayer:StaticGetPaintingName()
	local var_19_0 = self

	if checkABExist("painting/" .. self .. "_n") and PlayerPrefs.GetInt("paint_hide_other_obj_" .. var_19_0, 0) ~= 0 then
		var_19_0 = var_19_0 .. "_n"
	end

	if HXSet.isHx() then
		return var_19_0
	end

	local var_19_1 = getProxy(SettingsProxy):GetMainPaintingVariantFlag(self) == LiquorFloorBookLayer.PAINTING_VARIANT_EX

	if var_19_1 and not checkABExist("painting/" .. var_19_0 .. "_ex") then
		return var_19_0
	end

	return (var_19_1 or nil) and (var_19_0 .. "_ex" or var_19_0)
end

function LiquorFloorBookLayer:updateAwardPanel()
	local var_20_0 = getProxy(TaskProxy)
	local var_20_1 = var_20_0:getTaskVO(self.taskIds[self.selectTagIndex])
	local var_20_2 = self.awardPanelTf:Find("awardIcon")
	local var_20_3 = var_20_1:getConfig("award_display")[1]
	local var_20_4 = {
		type = var_20_0[1],
		id = var_20_3[2],
		count = var_20_3[3]
	}

	updateDrop(var_20_2, var_20_4)
	onButton(self, var_20_2, function()
		self:emit(LiquorFloorBookLayer.ON_DROP, var_20_4)

		return
	end, SFX_PANEL)
	setText(findTF(self.awardPanelTf, "progress"), var_20_1:getProgress() .. "/" .. var_20_1:getConfig("target_num"))
	setSlider(findTF(self.awardPanelTf, "Slider"), 0, 1, var_20_1:getProgress() / var_20_1:getConfig("target_num"))
	setText(findTF(self.awardPanelTf, "desc"), var_20_1:getConfig("desc"))

	local var_20_5 = findTF(self.awardPanelTf, "btnGet")
	local var_20_6 = findTF(self.awardPanelTf, "btnGot")
	local var_20_7 = findTF(self.awardPanelTf, "btnGo")

	setText(findTF(var_20_5, "text"), i18n("LiquorFloor_story_get"))
	setText(findTF(var_20_6, "text"), i18n("LiquorFloor_story_got"))
	setText(findTF(var_20_7, "text"), i18n("LiquorFloor_story_go"))
	setActive(var_20_5, false)
	setActive(var_20_6, false)
	setActive(imgGot, false)
	setActive(var_20_7, false)

	if var_20_1:getTaskStatus() == 0 then
		setActive(var_20_7, true)
	elseif var_20_1:getTaskStatus() == 1 then
		setActive(var_20_5, true)
	elseif var_20_1:getTaskStatus() == 2 then
		setActive(var_20_6, true)
		setActive(imgGot, true)
	end

	onButton(self, var_20_7, function()
		self:closeView()

		return
	end, SFX_CANCEL)

	return
end

function LiquorFloorBookLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._ad, self._tf)

	return
end

return LiquorFloorBookLayer
