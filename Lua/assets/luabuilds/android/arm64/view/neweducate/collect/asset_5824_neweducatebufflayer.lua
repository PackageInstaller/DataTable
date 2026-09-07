local NewEducateBuffLayer = class("NewEducateBuffLayer", import("view.base.BaseUI"))
local var_0_1 = {
	[NewEducateBuff.TYPE.TAROT] = i18n("child2_collect_tarot_progress"),
	[NewEducateBuff.TYPE.ENTRY] = i18n("child2_collect_entry_progress"),
	[NewEducateBuff.TYPE.TALENT] = i18n("child2_collect_talent_progress")
}
local var_0_2 = {
	[NewEducateBuff.TYPE.TAROT] = i18n("child2_collect_tarot"),
	[NewEducateBuff.TYPE.ENTRY] = i18n("child2_collect_entry"),
	[NewEducateBuff.TYPE.TALENT] = i18n("child2_collect_talent")
}

function NewEducateBuffLayer:getUIName()
	return "NewEducateBuffUI"
end

function NewEducateBuffLayer:getGroupName()
	return "NewEducateBaseUI"
end

function NewEducateBuffLayer:init()
	self.windowTF = self._tf:Find("window")
	self.nextBtn = self.windowTF:Find("next_btn")
	self.lastBtn = self.windowTF:Find("last_btn")
	self.togglesTF = self.windowTF:Find("toggles")

	local var_3_0 = self.windowTF:Find("pages")

	self.pageTFs = {}
	self.pageTFs[NewEducateBuff.TYPE.TAROT] = var_3_0:Find(tostring(NewEducateBuff.TYPE.TAROT))
	self.pageTFs[NewEducateBuff.TYPE.ENTRY] = var_3_0:Find(tostring(NewEducateBuff.TYPE.ENTRY))
	self.pageTFs[NewEducateBuff.TYPE.TALENT] = var_3_0:Find(tostring(NewEducateBuff.TYPE.TALENT))
	self.boxsTF = self._tf:Find("detail_boxs")
	self.animCom = self._tf:Find("window"):GetComponent(typeof(Animation))

	return
end

function NewEducateBuffLayer:didEnter()
	self:OverlayPanel(self._tf, {
		groupDelta = 2
	})
	onButton(self, self._tf:Find("bg"), function()
		self:closeView()

		return
	end, SFX_PANEL)
	eachChild(self.togglesTF, function(arg_6_0)
		setText(arg_6_0:Find("name"), var_0_2[tonumber(arg_6_0.name)])
		onButton(self, arg_6_0, function()
			self.animCom:Play("anim_NewEducateBuffUI_left_click")
			self:SwtichView((tonumber(arg_6_0.name)))

			return
		end, SFX_PANEL)

		return
	end)
	onButton(self, self.nextBtn, function()
		self.curPageIdx = self.curPageIdx + 1

		self.animCom:Play("anim_NewEducateBuffUI_left_click")
		self:UpdatePage()

		return
	end, SFX_PANEL)
	onButton(self, self.lastBtn, function()
		self.curPageIdx = self.curPageIdx - 1

		self.animCom:Play("anim_NewEducateBuffUI_left_click")
		self:UpdatePage()

		return
	end, SFX_PANEL)
	eachChild(self.boxsTF, function(arg_10_0)
		onButton(self, arg_10_0, function()
			setActive(arg_10_0, false)

			return
		end, SFX_PANEL)

		return
	end)
	self:InitData()
	self:UpdateToggles()
	self:SwtichView(tonumber(self.togglesTF:GetChild(0).name))

	return
end

function NewEducateBuffLayer:InitData()
	self.config = pg.child2_benefit_list
	self.allIdMap = {
		[NewEducateBuff.TYPE.TAROT] = self.contextData.permanentData:GetAllTarotIds(),
		[NewEducateBuff.TYPE.ENTRY] = self.contextData.permanentData:GetAllEntryIds(),
		[NewEducateBuff.TYPE.TALENT] = self.contextData.permanentData:GetAllTalentIds()
	}
	self.unlockIdMap = {
		[NewEducateBuff.TYPE.TAROT] = self.contextData.permanentData:GetActivatedTarotIds(),
		[NewEducateBuff.TYPE.ENTRY] = self.contextData.permanentData:GetActivatedEntryIds(),
		[NewEducateBuff.TYPE.TALENT] = self.contextData.permanentData:GetActivatedTalentIds()
	}
	self.pageAllCntMap = {}

	for iter_12_0, iter_12_1 in pairs(self.allIdMap) do
		self.pageAllCntMap[iter_12_0] = math.ceil(#iter_12_1 / self.pageTFs[iter_12_0]:Find("content").childCount)
	end

	return
end

function NewEducateBuffLayer:UpdateToggles()
	eachChild(self.togglesTF, function(arg_14_0)
		local var_14_0 = tonumber(arg_14_0.name)

		setText(arg_14_0:Find("value"), #self.unlockIdMap[var_14_0] .. "/" .. #self.allIdMap[var_14_0])

		return
	end)

	for iter_13_0, iter_13_1 in pairs(self.pageTFs) do
		setText(iter_13_1:Find("progress/Text"), var_0_1[iter_13_0])
		setText(iter_13_1:Find("progress/cur"), #self.unlockIdMap[iter_13_0])
		setText(iter_13_1:Find("progress/all"), "/" .. #self.allIdMap[iter_13_0])
	end

	return
end

function NewEducateBuffLayer:SwtichView(arg_15_1)
	if not self.curType or self.curType ~= arg_15_1 then
		self.curType = arg_15_1

		self:UpdateView()
	end

	eachChild(self.togglesTF, function(arg_16_0)
		setActive(arg_16_0:Find("sel"), tonumber(arg_16_0.name) == arg_15_1)

		return
	end)
	eachChild(self.windowTF:Find("pages"), function(arg_17_0)
		setActive(arg_17_0, tonumber(arg_17_0.name) == arg_15_1)

		return
	end)

	return
end

function NewEducateBuffLayer:UpdateView()
	if self.reverse then
		self.reverse = nil
		self.curPageIdx = self.pageAllCntMap[self.curType]
	else
		self.curPageIdx = 1
	end

	self:UpdatePage()

	return
end

function NewEducateBuffLayer:GetNextType()
	return switch(self.curType, {
		[NewEducateBuff.TYPE.TAROT] = function()
			return NewEducateBuff.TYPE.ENTRY
		end,
		[NewEducateBuff.TYPE.ENTRY] = function()
			return NewEducateBuff.TYPE.TALENT
		end,
		[NewEducateBuff.TYPE.TALENT] = function()
			return nil
		end
	})
end

function NewEducateBuffLayer:GetLastType()
	return switch(self.curType, {
		[NewEducateBuff.TYPE.TAROT] = function()
			return nil
		end,
		[NewEducateBuff.TYPE.ENTRY] = function()
			return NewEducateBuff.TYPE.TAROT
		end,
		[NewEducateBuff.TYPE.TALENT] = function()
			return NewEducateBuff.TYPE.ENTRY
		end
	})
end

function NewEducateBuffLayer:UpdatePage()
	local var_27_0 = self.pageTFs[self.curType]
	local var_27_1 = self.pageAllCntMap[self.curType]

	if self.pageAllCntMap[self.curType] < self.curPageIdx then
		local var_27_2 = self:GetNextType()

		if var_27_2 then
			self:SwtichView(var_27_2)

			return
		end
	elseif self.curPageIdx < 1 then
		local var_27_3 = self:GetLastType()
		local var_27_4

		if var_27_3 then
			self.reverse = true

			self:SwtichView(var_27_3)

			do return end

			var_27_4 = setActive
		end
	end

	var_27_4(self.nextBtn, not (self.curType == NewEducateBuff.TYPE.TALENT and var_27_1 <= self.curPageIdx))
	setActive(self.lastBtn, not (self.curType == NewEducateBuff.TYPE.TAROT and self.curPageIdx <= 1))
	setText(var_27_0:Find("pagination"), self.curPageIdx .. "/" .. var_27_1)

	local var_27_5 = var_27_0:Find("content")

	for iter_27_0 = 1, var_27_5.childCount do
		local var_27_6 = var_27_5:Find(tostring(iter_27_0))

		if self.allIdMap[self.curType][(self.curPageIdx - 1) * var_27_5.childCount + iter_27_0] then
			setActive(var_27_6, true)
			self:UpdateItem(self.allIdMap[self.curType][(self.curPageIdx - 1) * var_27_5.childCount + iter_27_0], var_27_6)
		else
			setActive(var_27_6, false)
		end
	end

	return
end

function NewEducateBuffLayer:UpdateItem(arg_28_1, arg_28_2)
	local var_28_0 = table.contains(self.unlockIdMap[self.curType], arg_28_1)

	setActive(arg_28_2:Find("lock"), not var_28_0)
	setActive(arg_28_2:Find("unlock"), var_28_0)
	switch(self.curType, {
		[NewEducateBuff.TYPE.TAROT] = function()
			NewEducateTarotCard.StaticShow(arg_28_2:Find("unlock"), arg_28_1)
			setText(arg_28_2:Find("lock/Text"), self.config[arg_28_1].get)
			setText(arg_28_2:Find("lock/name/Text"), self.config[arg_28_1].name)
			onButton(self, arg_28_2, function()
				if not var_28_0 then
					return
				end

				self:ShowDetailBox(arg_28_1)

				return
			end, SFX_PANEL)

			return
		end,
		[NewEducateBuff.TYPE.ENTRY] = function()
			NewEducateEntryCard.StaticShow(arg_28_2:Find("unlock"), arg_28_1)
			setText(arg_28_2:Find("lock/Text"), self.config[arg_28_1].get)
			setText(arg_28_2:Find("lock/name"), self.config[arg_28_1].name)
			onButton(self, arg_28_2, function()
				if not var_28_0 then
					return
				end

				self:ShowDetailBox(arg_28_1)

				return
			end, SFX_PANEL)

			return
		end,
		[NewEducateBuff.TYPE.TALENT] = function()
			LoadImageSpriteAsync("neweducateicon/" .. self.config[arg_28_1].item_icon, arg_28_2:Find("unlock/icon"))
			setText(arg_28_2:Find("lock/Text"), self.config[arg_28_1].get)
			setText(arg_28_2:Find("name"), self.config[arg_28_1].name)
			LoadImageSpriteAtlasAsync("ui/neweducatebuffui_atlas", "rarity_" .. self.config[arg_28_1].rare, arg_28_2:Find("unlock"))
			onButton(self, arg_28_2, function()
				if not var_28_0 then
					return
				end

				self:ShowDetailBox(arg_28_1)

				return
			end, SFX_PANEL)

			return
		end
	})

	return
end

function NewEducateBuffLayer:ShowDetailBox(arg_35_1, arg_35_2)
	eachChild(self.boxsTF, function(arg_36_0)
		setActive(arg_36_0, self.curType == tonumber(arg_36_0.name))

		return
	end)

	local var_35_0 = self.boxsTF:Find(tostring(self.curType))

	switch(self.curType, {
		[NewEducateBuff.TYPE.TAROT] = function()
			NewEducateTarotCard.StaticShow(var_35_0:Find("bg/tarot"), arg_35_1)

			return
		end,
		[NewEducateBuff.TYPE.ENTRY] = function()
			NewEducateEntryCard.StaticShow(var_35_0:Find("bg/entry/unlock"), arg_35_1)
			setText(var_35_0:Find("bg/entry/lv"), "LV." .. self.config[arg_35_1].benefit_level)
			setActive(var_35_0:Find("bg/entry/unlock"), true)
			setActive(var_35_0:Find("bg/entry/lock"), false)
			setActive(var_35_0:Find("bg/toggles"), false)

			return
		end,
		[NewEducateBuff.TYPE.TALENT] = function()
			local var_39_0 = var_35_0:Find("bg/talent")

			LoadImageSpriteAsync("neweducateicon/" .. self.config[arg_35_1].item_icon, var_39_0:Find("rarity/icon"))
			setText(var_39_0:Find("name"), self.config[arg_35_1].name)
			setText(var_39_0:Find("level"), "LV." .. self.config[arg_35_1].benefit_level)
			setText(var_39_0:Find("desc/Text"), self.config[arg_35_1].desc)
			LoadImageSpriteAtlasAsync("ui/neweducatebuffui_atlas", "rarity_" .. self.config[arg_35_1].rare, var_39_0:Find("rarity"))

			return
		end
	})

	return
end

function NewEducateBuffLayer:ShowEntryBox(arg_40_1, arg_40_2, arg_40_3)
	local var_40_0 = self.entryGroup2Ids[arg_40_2]

	table.sort(self.entryGroup2Ids[arg_40_2], CompareFuncs({
		function(arg_41_0)
			return self.config[arg_41_0].benefit_level
		end,
		function(arg_42_0)
			return arg_42_0
		end
	}))
	UIItemList.StaticAlign(arg_40_1:Find("bg/toggles"), arg_40_1:Find("bg/toggles"):GetChild(0), #self.entryGroup2Ids[arg_40_2], function(arg_43_0, arg_43_1, arg_43_2)
		if arg_43_0 == UIItemList.EventUpdate then
			local var_43_0 = var_40_0[arg_43_1 + 1]
			local var_43_1 = self.config[var_40_0[arg_43_1 + 1]]
			local var_43_2 = self.config[var_40_0[arg_43_1 + 1]].benefit_level

			arg_43_2.name = tostring(var_40_0[arg_43_1 + 1])

			setText(arg_43_2:Find("sel/Text"), "LV." .. self.config[var_40_0[arg_43_1 + 1]].benefit_level)
			setText(arg_43_2:Find("unsel/Text"), "LV." .. self.config[var_40_0[arg_43_1 + 1]].benefit_level)

			local var_43_3 = table.contains(self.unlockEntryIds, var_40_0[arg_43_1 + 1])

			setActive(arg_43_2:Find("sel/Image"), not var_43_3)
			setActive(arg_43_2:Find("unsel/Image"), not var_43_3)
			setActive(arg_43_2:Find("sel/Text"), var_43_3)
			setActive(arg_43_2:Find("unsel/Text"), var_43_3)
			onToggle(self, arg_43_2, function(arg_44_0)
				NewEducateEntryCard.StaticShow(arg_40_1:Find("bg/entry/unlock"), var_43_0)
				setText(arg_40_1:Find("bg/entry/lv"), "LV." .. var_43_2)
				setActive(arg_40_1:Find("bg/entry/unlock"), var_43_3)
				setActive(arg_40_1:Find("bg/entry/lock"), not var_43_3)
				setText(arg_40_1:Find("bg/entry/lock/Text"), var_43_1.get)
				setText(arg_40_1:Find("bg/entry/lock/name"), var_43_1.name)

				return
			end, SFX_PANEL)
		end

		return
	end)
	triggerToggle(arg_40_1:Find("bg/toggles"):Find(tostring(arg_40_3)), true)

	return
end

function NewEducateBuffLayer:willExit()
	self:UnOverlayPanel(self._tf)

	return
end

return NewEducateBuffLayer
