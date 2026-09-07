local WorldMediaCollectionFileGroupLayer = class("WorldMediaCollectionFileGroupLayer", import(".WorldMediaCollectionSubLayer"))

function WorldMediaCollectionFileGroupLayer:getUIName()
	return "WorldMediaCollectionFileGroupUI"
end

function WorldMediaCollectionFileGroupLayer:OnInit()
	self.scroll = self._tf:Find("ScrollRect")
	self.scrollComp = self.scroll:GetComponent("LScrollRect")

	setActive(self.scroll:Find("Item"), false)

	self.content = self.scroll:Find("Viewport/Content")
	self.progressText = self.scroll:Find("ProgressText")
	self.emptyTip = self._tf:Find("EmptyTip")
	self.fileGroups = {}

	function self.scrollComp.onUpdateItem(arg_3_0, ...)
		self:OnUpdateFileGroup(arg_3_0 + 1, ...)

		return
	end

	self.scrolling = false
	self.blurFlag = nil

	setText(self.scroll:Find("ProgressDesc"), i18n("world_collection_3"))

	self.loader = AutoLoader.New()

	return
end

function WorldMediaCollectionFileGroupLayer:UpdateGroupList()
	local var_4_0 = nowWorld():GetCollectionProxy()

	table.clear(self.fileGroups)

	local var_4_1 = 0
	local var_4_2 = 0

	_.each(pg.world_collection_file_group.all, function(arg_5_0)
		local var_5_0 = _.reduce(pg.world_collection_file_group[arg_5_0].child, 0, function(arg_6_0, arg_6_1)
			if var_4_0:IsUnlock(arg_6_1) then
				arg_6_0 = arg_6_0 + 1
			end

			return arg_6_0
		end)

		if var_5_0 > 0 then
			table.insert(self.fileGroups, pg.world_collection_file_group[arg_5_0])
		end

		var_4_1 = var_4_1 + #pg.world_collection_file_group[arg_5_0].child
		var_4_2 = var_4_2 + var_5_0

		return
	end)

	local var_4_3 = #self.fileGroups == 0

	setActive(self.emptyTip, #self.fileGroups == 0)

	if var_4_3 then
		self:BlurTip()
	else
		self:UnBlurTip()
	end

	setActive(self.scroll, not var_4_3)
	self.scrollComp:SetTotalCount(#self.fileGroups)
	setText(self.progressText, var_4_2 .. "/" .. var_4_1)

	return
end

function WorldMediaCollectionFileGroupLayer:BlurTip()
	self:OverlayPanel(self.emptyTip, {
		groupDelta = -1,
		pbList = {
			self.emptyTip:Find("EmptyTip")
		}
	})
	self.emptyTip:SetSiblingIndex(0)

	self.blurFlag = true

	return
end

function WorldMediaCollectionFileGroupLayer:UnBlurTip()
	if self.blurFlag then
		self:UnOverlayPanel(self.emptyTip, self._tf)
	end

	self.blurFlag = nil

	return
end

function WorldMediaCollectionFileGroupLayer:Show()
	WorldMediaCollectionFileGroupLayer.super.Show(self)

	if self.blurFlag then
		self:BlurTip()
	end

	return
end

function WorldMediaCollectionFileGroupLayer:Hide()
	LeanTween.cancel(go(self.content))
	self.scrollComp:SetDraggingStatus(false)
	self.scrollComp:StopMovement()

	self.scrolling = false

	self:UnBlurTip()
	WorldMediaCollectionFileGroupLayer.super.Hide(self)

	return
end

function WorldMediaCollectionFileGroupLayer:OnUpdateFileGroup(arg_11_1, arg_11_2)
	if self.exited then
		return
	end

	local var_11_0 = self.fileGroups[arg_11_1]

	assert(self.fileGroups[arg_11_1], "Not Initialize FileGroup Index " .. arg_11_1)

	local var_11_1 = tf(arg_11_2)

	setText(var_11_1:Find("FileIndex"), var_11_0.id_2)
	self.loader:GetSprite("ui/WorldMediaCollectionFileUI_atlas", var_11_0.type, var_11_1:Find("BG"))
	self.loader:GetSprite("CollectionFileTitle/" .. var_11_0.name_abbreviate, "", var_11_1:Find("FileTitle"), true)

	local var_11_2 = nowWorld():GetCollectionProxy()
	local var_11_3 = 0

	for iter_11_0, iter_11_1 in ipairs(var_11_0.child) do
		if var_11_2:IsUnlock(iter_11_1) then
			var_11_3 = var_11_3 + 1
		end
	end

	setText(var_11_1:Find("FileProgress"), var_11_3 .. "/" .. #var_11_0.child)

	local var_11_5 = self.scroll:Find("Item").rect.width
	local var_11_6 = self.content:GetComponent(typeof(HorizontalLayoutGroup))

	onButton(self, var_11_1, function()
		self.viewParent:OpenDetailLayer(var_11_0.id, true)

		return
	end, SFX_PANEL)

	return
end

return WorldMediaCollectionFileGroupLayer
