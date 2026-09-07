local WorldMediaCollectionFileDetailLayer = class("WorldMediaCollectionFileDetailLayer", import(".WorldMediaCollectionSubLayer"))

function WorldMediaCollectionFileDetailLayer:getUIName()
	return "WorldMediaCollectionFileDetailUI"
end

function WorldMediaCollectionFileDetailLayer:OnInit()
	assert(self.viewParent, "Need assign ViewParent for " .. self.__cname)
	onButton(self, self._tf:Find("Buttom"), function()
		self.viewParent:Backward()

		return
	end)

	self.anim = self._tf:GetComponent(typeof(Animation))
	self.canvasGroup = self._tf:GetComponent(typeof(CanvasGroup))

	self:InitDocument()

	local var_2_0 = self._tf:Find("ArchiveList")

	self.scrollComp = var_2_0:GetComponent("LScrollRect")
	self.fileChild = {}
	self.fileChildIndex = {}

	function self.scrollComp.onUpdateItem(arg_4_0, ...)
		self:OnUpdateFile(arg_4_0 + 1, ...)

		return
	end

	setActive(var_2_0:Find("Item"), false)

	self.loader = AutoLoader.New()

	setText(self._tf:Find("ArchiveList/ProgressDesc"), i18n("world_collection_1"))

	return
end

function WorldMediaCollectionFileDetailLayer:InitDocument()
	self.document = self._tf:Find("Document")
	self.documentContentTF = self.document:Find("Viewport/Content")
	self.documentHead = self.documentContentTF:Find("Head")
	self.documentBody = self.documentContentTF:Find("Body")
	self.documentTitle = self.documentHead:Find("Title")
	self.documentRect = self.documentBody:Find("Rect")
	self.documentTip = self.documentRect:Find("SubTitle")
	self.documentText = self.documentRect:Find("Text")
	self.documentImage = self.documentRect:Find("Image")
	self.documentStamp = self.documentImage:Find("ClassifiedStamp")

	return
end

function WorldMediaCollectionFileDetailLayer:Openning()
	self.anim:Play("Enter")
	self:Enter()

	return
end

function WorldMediaCollectionFileDetailLayer:Enter()
	local var_7_0 = self.contextData.SelectedFile or (function()
		local var_8_0 = nowWorld():GetCollectionProxy()

		for iter_8_0, iter_8_1 in ipairs(WorldCollectionProxy.GetCollectionFileGroupTemplate(self.contextData.FileGroupIndex).child) do
			if var_8_0:IsUnlock(iter_8_1) then
				return iter_8_0
			end
		end

		return
	end)()

	self.contextData.SelectedFile = nil

	self:UpdateView()
	self:SwitchFileIndex(var_7_0)

	return
end

function WorldMediaCollectionFileDetailLayer:Hide()
	self.canvasGroup.alpha = 1

	WorldMediaCollectionFileDetailLayer.super.Hide(self)

	return
end

function WorldMediaCollectionFileDetailLayer:UpdateView()
	assert(self.contextData.FileGroupIndex, "Not Initialize FileGroupIndex")

	self.archiveList = _.map(WorldCollectionProxy.GetCollectionFileGroupTemplate(self.contextData.FileGroupIndex).child, function(arg_11_0)
		return WorldCollectionProxy.GetCollectionTemplate(arg_11_0)
	end)

	local var_10_0 = nowWorld():GetCollectionProxy()
	local var_10_1 = WorldCollectionProxy.GetCollectionFileGroupTemplate(self.contextData.FileGroupIndex)
	local var_10_2 = 0

	for iter_10_0, iter_10_1 in ipairs(var_10_1.child) do
		if var_10_0:IsUnlock(iter_10_1) then
			var_10_2 = var_10_2 + 1
		end
	end

	setText(self._tf:Find("ArchiveList/ProgressDesc/ProgressText"), var_10_2 .. "/" .. #var_10_1.child)
	self.scrollComp:SetTotalCount(#self.archiveList)

	return
end

local function var_0_1(arg_12_0)
	return (string.char(226, 133, 160 + (arg_12_0 - 1)))
end

function WorldMediaCollectionFileDetailLayer:OnUpdateFile(arg_13_1, arg_13_2)
	if self.exited then
		return
	end

	local var_13_0 = self.archiveList[arg_13_1]

	if self.fileChildIndex[arg_13_2] and self.fileChildIndex[arg_13_2] ~= arg_13_1 then
		self.fileChild[self.fileChildIndex[arg_13_2]] = nil
	end

	self.fileChildIndex[arg_13_2] = arg_13_1
	self.fileChild[arg_13_1] = arg_13_2

	local var_13_1 = tf(arg_13_2)
	local var_13_2 = WorldCollectionProxy.GetCollectionFileGroupTemplate(self.contextData.FileGroupIndex)
	local var_13_3 = nowWorld():GetCollectionProxy():IsUnlock(var_13_0.id)
	local var_13_4 = arg_13_1 == self.contextData.SelectedFile

	setActive(var_13_1:Find("Selected"), arg_13_1 == self.contextData.SelectedFile)

	local var_13_5 = "%s %s"
	local var_13_6 = shortenString
	local var_13_7 = var_13_2.name
	local var_13_9
	local var_13_10
	local var_13_8

	if not var_13_2.name then
		var_13_7 = ""
		var_13_8 = setText
		var_13_9 = var_13_1:Find("Desc")
		var_13_10 = setColorStr
	end

	var_13_8(var_13_9, var_13_10(string.format(var_13_5, var_13_6(var_13_7, 6), var_0_1(var_13_0.group_ID)), var_13_4 and "#000" or COLOR_WHITE))
	setActive(var_13_1:Find("Desc"), var_13_3)
	setActive(var_13_1:Find("Icon"), var_13_3)
	setActive(var_13_1:Find("Cover"), var_13_3)
	setActive(var_13_1:Find("Locked"), not var_13_3)
	self.loader:GetSprite("ui/WorldMediaCollectionFileDetailUI_atlas", "cover" .. var_13_2.type, var_13_1:Find("Cover"))
	onButton(self, var_13_1, function()
		if not nowWorld():GetCollectionProxy():IsUnlock(var_13_0.id) then
			return
		end

		self:SwitchFileIndex(arg_13_1)

		return
	end, SFX_PANEL)

	return
end

function WorldMediaCollectionFileDetailLayer:SwitchFileIndex(arg_15_1)
	if self.contextData.SelectedFile and self.contextData.SelectedFile == arg_15_1 then
		return
	end

	local var_15_0 = arg_15_1 and self.archiveList[arg_15_1]

	if arg_15_1 and self.archiveList[arg_15_1] and nowWorld():GetCollectionProxy():IsUnlock(var_15_0.id) then
		self.contextData.SelectedFile = arg_15_1

		if self.fileChild[self.contextData.SelectedFile] then
			self:OnUpdateFile(self.contextData.SelectedFile, self.fileChild[self.contextData.SelectedFile])
		end

		if self.fileChild[arg_15_1] then
			self:OnUpdateFile(arg_15_1, self.fileChild[arg_15_1])
		end

		setActive(self.document, true)
		setText(self.document:Find("Head/Title"), var_15_0.name)
		self:SetDocument(var_15_0)
	else
		setActive(self.document, false)
	end

	return
end

function WorldMediaCollectionFileDetailLayer:SetDocument(arg_16_1, arg_16_2)
	setText(self.documentTitle, arg_16_1.name)

	if arg_16_1.pic and #arg_16_1.pic > 0 then
		local var_16_0 = LoadSprite("CollectionFileIllustration/" .. arg_16_1.pic, "")

		setImageSprite(self.documentImage, var_16_0, true)
		setActive(self.documentImage, var_16_0)

		if var_16_0 then
			setActive(self.documentStamp, arg_16_1.is_classified == 1)

			if arg_16_1.is_classified == 1 then
				self.loader:GetSprite("ui/WorldMediaCollectionFileDetailUI_atlas", "stamp" .. WorldCollectionProxy.GetCollectionFileGroupTemplate((WorldCollectionProxy.GetCollectionGroup(arg_16_1.id))).type, self.documentStamp)
			end
		end
	else
		setActive(self.documentImage, false)
	end

	self:SetDocumentText(arg_16_1.content, arg_16_1.subTitle, arg_16_2)

	return
end

function WorldMediaCollectionFileDetailLayer:getTextPreferredHeight(arg_17_1, arg_17_2)
	return ReflectionHelp.RefCallMethod(typeof("UnityEngine.TextGenerator"), "GetPreferredHeight", self.cachedTextGeneratorForLayout, {
		typeof("System.String"),
		typeof("UnityEngine.TextGenerationSettings")
	}, {
		arg_17_2,
		(self:GetGenerationSettings(Vector2(arg_17_1, 0)))
	}) / self.pixelsPerUnit
end

function WorldMediaCollectionFileDetailLayer:SetDocumentText(arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = self.documentRect.rect.width
	local var_18_1 = isActive(self.documentImage)
	local var_18_2 = math.max(var_18_0 - ((var_18_1 or nil) and (self.documentImage.rect.width or 0)), 0)
	local var_18_3

	if var_18_1 then
		var_18_3 = self.documentImage.rect.height + 100 or 0
	end

	local var_18_4 = self.documentText:GetComponent(typeof(Text))

	var_18_4.text = ""

	local var_18_5 = ""

	local function var_18_6()
		local var_19_0 = 0

		if isActive(self.documentHead) then
			var_19_0 = var_19_0 + self.documentHead:GetComponent(typeof(LayoutElement)).preferredHeight
		end

		local var_19_1 = self.documentBody:GetComponent("LayoutGroup")
		local var_19_2 = var_19_0 + (var_19_1.padding.top + var_19_1.padding.bottom)

		setActive(self.documentTip, arg_18_2 and #arg_18_2 > 0)

		local var_19_3 = 0

		if arg_18_2 and #arg_18_2 > 0 then
			local var_19_4 = self.documentTip:Find("Text"):GetComponent(typeof(Text))

			var_19_4.text = arg_18_2
			var_19_3 = WorldMediaCollectionFileDetailLayer.getTextPreferredHeight(var_19_4, var_18_0, arg_18_2)
			var_19_3 = var_19_3 + self.documentRect:GetComponent(typeof(VerticalLayoutGroup)).spacing
			var_19_2 = var_19_2 + var_19_3
		end

		if var_18_1 then
			self.documentImage.anchoredPosition = Vector2(0, -50 - var_19_3)
		end

		local var_19_5 = WorldMediaCollectionFileDetailLayer.getTextPreferredHeight(var_18_4, var_18_0, var_18_5)
		local var_19_6 = var_19_2 + var_19_5

		self.documentContentTF.sizeDelta.y = var_19_2 + var_19_5
		self.documentContentTF.sizeDelta = self.documentContentTF.sizeDelta

		local var_19_7 = self.document:Find("Arrow")
		local var_19_8 = self.document:Find("Viewport").rect.height

		setActive(var_19_7, var_19_8 < var_19_6)

		local var_19_9 = self.document:GetComponent(typeof(ScrollRect))

		var_19_9.onValueChanged:RemoveAllListeners()

		arg_18_3 = arg_18_3 or 0
		self.documentContentTF.anchoredPosition = Vector2(0, math.max(var_19_5 - var_19_8, 0) * arg_18_3)
		var_19_9.velocity = Vector2.zero

		if var_19_8 < var_19_6 then
			onScroll(self, self.document, function(arg_20_0)
				setActive(var_19_7, arg_20_0.y > 0.01)

				return
			end)
		end

		return
	end

	if not var_18_1 then
		var_18_5 = arg_18_1
		var_18_4.text = arg_18_1

		var_18_6()

		return
	end

	local var_18_7, var_18_8 = self.SplitRichAndLetters(arg_18_1)
	local var_18_9 = 1
	local var_18_10 = 1

	local function var_18_11(arg_21_0)
		local var_21_0 = ""
		local var_21_1 = ""
		local var_21_2 = {}

		for iter_21_0 = arg_21_0 and 1 or var_18_10, #var_18_8 do
			if var_18_8[iter_21_0].start > var_18_7[var_18_9].start then
				break
			end

			local var_21_3 = var_18_8[iter_21_0]

			if iter_21_0 == var_18_10 then
				var_18_10 = var_18_10 + 1
				var_21_0 = var_21_0 .. var_21_3.value
			end

			if arg_21_0 then
				if var_21_3.EndTagIndex then
					var_21_2[#var_21_2 + 1] = var_21_3.EndTagIndex
				else
					table.remove(var_21_2)
				end
			end
		end

		local var_21_4 = ""

		if var_18_9 <= #var_18_7 then
			var_21_4 = var_18_7[var_18_9].value
		end

		for iter_21_1, iter_21_2 in ipairs(var_21_2) do
			var_21_1 = var_18_8[iter_21_2].value .. var_21_1
		end

		var_18_9 = var_18_9 + 1

		return var_21_4, var_21_0, var_21_1
	end

	while 0 < var_18_3 and 1 < #var_18_7 do
		local var_18_12, var_18_13, var_18_14 = var_18_11(true)

		var_18_4.text = var_18_5 .. var_18_13 .. var_18_12 .. var_18_14
		var_18_5 = var_18_2 < var_18_4.preferredWidth and var_18_5 .. "\n" .. var_18_13 .. var_18_12 or var_18_5 .. var_18_13 .. var_18_12
		var_18_4.text = var_18_5 .. var_18_13 .. var_18_12 .. var_18_14

		local var_18_16 = WorldMediaCollectionFileDetailLayer.getTextPreferredHeight(var_18_4, var_18_4.preferredWidth, var_18_5)
	end

	for iter_18_0 = 1, #var_18_7 do
		local var_18_17, var_18_18 = var_18_11(false)

		var_18_5 = var_18_5 .. var_18_18 .. var_18_17
	end

	local var_18_19, var_18_20, var_18_21 = var_18_11(true)

	var_18_5 = var_18_5 .. var_18_21
	var_18_4.text = var_18_5

	var_18_6()

	return
end

function WorldMediaCollectionFileDetailLayer:SplitRichAndLetters()
	local var_22_0 = 1
	local var_22_1 = {}
	local var_22_2 = {}

	while true do
		local var_22_3, var_22_4 = string.find(self, "<([^>]*)>", var_22_0)

		if not var_22_4 then
			break
		end

		local var_22_5 = string.sub(self, var_22_3, var_22_4)
		local var_22_6 = string.find(var_22_5, "=")
		local var_22_7 = string.find(var_22_5, "/")

		if not var_22_7 and not var_22_6 then
			var_22_0 = var_22_4 + 1
		else
			table.insert(var_22_1, {
				value = var_22_5,
				start = var_22_3
			})

			if var_22_6 then
				var_22_2[#var_22_2 + 1] = #var_22_1
			else
				local var_22_8

				if var_22_7 and #var_22_2 > 0 then
					var_22_1[table.remove(var_22_2)].EndTagIndex = #var_22_1
					var_22_8 = string.sub(self, 1, var_22_3 - 1)
				end
			end

			self = var_22_8 .. string.sub(self, var_22_4 + 1, -1)
			var_22_0 = var_22_3
		end
	end

	local var_22_9 = {}
	local var_22_10 = 1
	local var_22_11 = false
	local var_22_12 = 1

	while true do
		local var_22_13, var_22_14 = string.find(self, "[\x01-\x7F�-�][�-�]*", var_22_10)

		if not var_22_14 then
			var_22_9[#var_22_9 + 1] = {
				value = string.sub(self, var_22_12, #self),
				start = var_22_12
			}

			break
		end

		local var_22_15 = string.sub(self, var_22_13, var_22_14)
		local var_22_16 = false

		if PLATFORM_CODE == PLATFORM_US then
			if var_22_11 ~= (var_22_15 == " " or var_22_15 == " ") then
				var_22_16 = var_22_13 > 1
			end

			var_22_11 = var_22_15 == " " or var_22_15 == " "
		else
			var_22_16 = var_22_13 > 1
		end

		if var_22_16 then
			var_22_9[#var_22_9 + 1] = {
				value = string.sub(self, var_22_12, var_22_13 - 1),
				start = var_22_12
			}
			var_22_12 = var_22_13
		end

		var_22_10 = var_22_14 + 1
	end

	return var_22_9, var_22_1
end

return WorldMediaCollectionFileDetailLayer
