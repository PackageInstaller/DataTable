local WorldMediaCollectionRecordGroupLayer = class("WorldMediaCollectionRecordGroupLayer", import(".WorldMediaCollectionTemplateLayer"))

function WorldMediaCollectionRecordGroupLayer:getUIName()
	return "WorldMediaCollectionRecordGroupUI"
end

function WorldMediaCollectionRecordGroupLayer:OnInit()
	self.scroll = self._tf:Find("ScrollRect")
	self.scrollComp = self.scroll:GetComponent("LScrollRect")

	setActive(self.scroll:Find("Item"), false)

	self.content = self.scroll:Find("Viewport/Content")
	self.progressText = self.scroll:Find("ProgressText")
	self.recordTogGroup = self._tf:Find("Toggles")
	self.recordToggles = {
		self.recordTogGroup:Find("0"),
		self.recordTogGroup:Find("1"),
		self.recordTogGroup:Find("2"),
		self.recordTogGroup:Find("3")
	}
	self.recordFilterIndex = {
		false,
		false,
		false
	}

	_.each(pg.world_collection_record_group.all, function(arg_3_0)
		self.recordFilterIndex[pg.world_collection_record_group[arg_3_0].type] = true

		return
	end)

	local var_2_0 = #self.recordFilterIndex
	local var_2_1

	for iter_2_0 = 1, #self.recordFilterIndex do
		setActive(self.recordToggles[1 + iter_2_0], self.recordFilterIndex[iter_2_0])

		if not self.recordFilterIndex[iter_2_0] then
			var_2_0 = var_2_0 - 1
		else
			var_2_1 = var_2_1 or iter_2_0 + 1
		end
	end

	setActive(self.recordToggles[1], var_2_0 > 1)

	var_2_1 = var_2_0 <= 1 and var_2_1 or 1

	local var_2_2 = self.contextData.toggle or var_2_1

	self.contextData.toggle = nil

	triggerToggle(self.recordToggles[var_2_2], true)
	self:SwitchRecordFilter(var_2_2)

	for iter_2_1, iter_2_2 in ipairs(self.recordToggles) do
		onToggle(self, iter_2_2, function(arg_4_0)
			if not arg_4_0 then
				return
			end

			self:SwitchRecordFilter(iter_2_1)
			self:RecordFilter()

			return
		end, SFX_UI_TAG)
	end

	function self.scrollComp.onUpdateItem(arg_5_0, arg_5_1)
		self:OnUpdateGroup(arg_5_0 + 1, arg_5_1)

		return
	end

	self.recordGroups = {}

	self:OverlayPanel(self.recordTogGroup, {
		overlayType = LayerWeightConst.OVERLAY_UI_ADAPT
	})

	self.loader = AutoLoader.New()

	setText(self.scroll:Find("ProgressDesc"), i18n("world_collection_3"))

	return
end

function WorldMediaCollectionRecordGroupLayer:Show()
	WorldMediaCollectionRecordGroupLayer.super.Show(self)
	setActive(self.recordTogGroup, true)

	return
end

function WorldMediaCollectionRecordGroupLayer:Hide()
	LeanTween.cancel(go(self.content))
	self.scrollComp:SetDraggingStatus(false)
	self.scrollComp:StopMovement()

	self.scrolling = false

	WorldMediaCollectionRecordGroupLayer.super.Hide(self)
	setActive(self.recordTogGroup, false)
	WorldMediaCollectionRecordGroupLayer.super.Hide(self)

	return
end

local var_0_1 = {
	"img_zhuxian",
	"img_zhixian",
	"img_shoujijilu"
}

function WorldMediaCollectionRecordGroupLayer:OnUpdateGroup(arg_8_1, arg_8_2)
	if self.exited then
		return
	end

	local var_8_0 = self.recordGroups[arg_8_1]

	assert(self.recordGroups[arg_8_1], "Not Initialize FileGroup Index " .. arg_8_1)

	local var_8_1 = tf(arg_8_2)

	setText(var_8_1:Find("FileIndex"), var_8_0.id)

	local var_8_2 = var_8_1:Find("NameRect/FileName1")
	local var_8_3 = GetPerceptualSize(var_8_0.name_abbreviate)
	local var_8_5 = var_8_2:GetComponent(typeof(Text))

	var_8_5.fontSize = var_8_3 <= 4 and 32 or var_8_3 <= 6 and 28 or 24
	var_8_5.text = var_8_0.name_abbreviate

	self.loader:GetSprite("ui/WorldMediaCollectionRecordUI_atlas", var_0_1[var_8_0.type], var_8_1:Find("BG"))

	local var_8_6 = nowWorld():GetCollectionProxy()

	setText(var_8_1:Find("FileProgress"), _.reduce(var_8_0.child, 0, function(arg_9_0, arg_9_1)
		local var_9_0 = WorldCollectionProxy.GetCollectionTemplate(arg_9_1)

		if var_9_0 and WorldMediaCollectionRecordDetailLayer.CheckRecordIsUnlock(var_9_0) then
			arg_9_0 = arg_9_0 + 1
		end

		return arg_9_0
	end) .. "/" .. #var_8_0.child)

	local var_8_8 = self.scroll:Find("Item").rect.width
	local var_8_9 = self.content:GetComponent(typeof(HorizontalLayoutGroup))

	onButton(self, var_8_1, function()
		self.viewParent:ShowRecordGroup(var_8_0.id)

		return
	end, SFX_PANEL)

	return
end

function WorldMediaCollectionRecordGroupLayer:SwitchRecordFilter(arg_11_1)
	if arg_11_1 == 1 then
		self.recordFilterIndex = {
			true,
			true,
			true
		}
	else
		for iter_11_0 in ipairs(self.recordFilterIndex) do
			self.recordFilterIndex[iter_11_0] = arg_11_1 - 1 == iter_11_0
		end
	end

	return
end

function WorldMediaCollectionRecordGroupLayer:RecordFilter()
	table.clear(self.recordGroups)

	local var_12_0 = 0
	local var_12_1 = 0

	_.each(pg.world_collection_record_group.all, function(arg_13_0)
		var_12_0 = var_12_0 + #pg.world_collection_record_group[arg_13_0].child
		var_12_1 = var_12_1 + _.reduce(pg.world_collection_record_group[arg_13_0].child, 0, function(arg_14_0, arg_14_1)
			local var_14_0 = WorldCollectionProxy.GetCollectionTemplate(arg_14_1)

			if var_14_0 and WorldMediaCollectionRecordDetailLayer.CheckRecordIsUnlock(var_14_0) then
				arg_14_0 = arg_14_0 + 1
			end

			return arg_14_0
		end)

		if self.recordFilterIndex[pg.world_collection_record_group[arg_13_0].type] then
			table.insert(self.recordGroups, pg.world_collection_record_group[arg_13_0])
		end

		return
	end)
	setText(self.progressText, 0 .. "/" .. 0)
	table.sort(self.recordGroups, function(arg_15_0, arg_15_1)
		return arg_15_0.id < arg_15_1.id
	end)
	self.scrollComp:SetTotalCount(#self.recordGroups)

	return
end

return WorldMediaCollectionRecordGroupLayer
