local WorldMediaCollectionFilePreviewLayer = class("WorldMediaCollectionFilePreviewLayer", import("view.base.BaseUI"))

function WorldMediaCollectionFilePreviewLayer:__index(arg_1_1)
	return rawget(WorldMediaCollectionFilePreviewLayer, arg_1_1) or WorldMediaCollectionFilePreviewLayer.super[arg_1_1] or WorldMediaCollectionFileDetailLayer[arg_1_1]
end

function WorldMediaCollectionFilePreviewLayer:getUIName()
	return "WorldMediaCollectionFilePreviewUI"
end

function WorldMediaCollectionFilePreviewLayer:init()
	self.canvasGroup = self._tf:GetComponent(typeof(CanvasGroup))

	self:InitDocument()

	self.tipTF = self._tf:Find("Tip")

	setText(self.tipTF, i18n("world_file_tip"))

	self.animBar = self._tf:Find("Bar")

	setActive(self.animBar, false)
	setActive(self.document, false)
	setActive(self.tipTF, false)

	self.loader = AutoLoader.New()

	setText(self.animBar:Find("Text"), i18n("world_collection_back"))

	return
end

function WorldMediaCollectionFilePreviewLayer:didEnter()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	local var_4_0 = WorldCollectionProxy.GetCollectionTemplate(self.contextData.collectionId)

	self:SetDocument(var_4_0)
	setActive(self.animBar, true)

	local var_4_1 = self.animBar:Find("Anim/Frame/Mask"):GetComponent(typeof(LayoutElement))
	local var_4_2 = self.animBar:Find("Anim/Frame/Mask/Name")
	local var_4_3 = var_4_2:GetComponent(typeof(Text))

	RemoveComponent(var_4_2, typeof(ScrollText))

	local var_4_4 = var_4_1.preferredWidth

	var_4_2.pivot = Vector2(0, 0.5)
	var_4_2.anchorMin = Vector2(0, 0.5)
	var_4_2.anchorMax = Vector2(0, 0.5)
	var_4_2.anchoredPosition = Vector2.zero
	var_4_3.text = tostring(var_4_0.name or "")
	var_4_1.preferredWidth = math.min(var_4_3.preferredWidth, var_4_1.preferredWidth)

	local function var_4_5()
		onButton(self, self._tf, function()
			self:closeView()

			return
		end)

		return
	end

	local function var_4_6()
		if var_4_3.preferredWidth > var_4_4 then
			var_4_2.pivot = Vector2(0.5, 0.5)
			var_4_2.anchorMin = Vector2(0.5, 0.5)
			var_4_2.anchorMax = Vector2(0.5, 0.5)

			setScrollText(var_4_2, var_4_0.name or "")
		end

		return
	end

	local var_4_7 = self.animBar:GetComponent(typeof(DftAniEvent))

	removeOnButton(self._tf)

	if var_4_7 then
		var_4_7:SetTriggerEvent(var_4_6)
		var_4_7:SetEndEvent(var_4_5)
	else
		var_4_6()
		var_4_5()
	end

	onButton(self, self.animBar:Find("Button"), function()
		setActive(self.animBar, false)
		setActive(self.document, true)
		setActive(self.tipTF, true)
		var_4_5()

		return
	end, SFX_PANEL)
	setImageSprite(self.animBar:Find("Anim/Icon"), LoadSprite("ui/WorldMediaCollectionFilePreviewUI_atlas", WorldCollectionProxy.GetCollectionFileGroupTemplate((WorldCollectionProxy.GetCollectionGroup(var_4_0.id))).type))

	return
end

function WorldMediaCollectionFilePreviewLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)
	self.loader:Clear()

	if self.contextData.callback then
		self.contextData.callback()
	end

	WorldMediaCollectionFilePreviewLayer.super.willExit(self)

	return
end

return WorldMediaCollectionFilePreviewLayer
