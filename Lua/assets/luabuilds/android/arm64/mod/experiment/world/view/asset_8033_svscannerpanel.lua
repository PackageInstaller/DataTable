local SVScannerPanel = class("SVScannerPanel", import("view.base.BaseSubView"))

SVScannerPanel.ShowView = "SVScannerPanel.ShowView"
SVScannerPanel.HideView = "SVScannerPanel.HideView"
SVScannerPanel.HideGoing = "SVScannerPanel.HideGoing"

function SVScannerPanel:getUIName()
	return "SVScannerPanel"
end

function SVScannerPanel:getBGM()
	return "echo-loop"
end

function SVScannerPanel:OnLoaded()
	return
end

function SVScannerPanel:OnInit()
	self.camera = GameObject.Find("OverlayCamera"):GetComponent(typeof(Camera))
	self.canvas = GetOrAddComponent(self._tf, "CanvasGroup")
	self.rtExit = self._tf:Find("adapt/exit")
	self.rtPanel = self._tf:Find("adapt/selected_panel")

	setActive(self.rtPanel, false)

	self.rtWindow = self.rtPanel:Find("window")
	self.rtTitle = self.rtWindow:Find("base_info/title")
	self.rtMark = self.rtWindow:Find("base_info/mark")
	self.rtBuffContent = self.rtWindow:Find("base_info/content")
	self.rtMapBuffContent = self.rtWindow:Find("base_info/map_buffs")
	self.rtInfo = self.rtWindow:Find("base_info/info")
	self.rtWeaknessContent = self.rtWindow:Find("weakness_info/content")
	self.rtRadiation = self.rtWindow:Find("radiation_info")
	self.rtAnim = self._tf:Find("adapt/anim")
	self.rtClick = self.rtPanel:Find("click")
	self.buffUIItemList = UIItemList.New(self.rtBuffContent, self.rtBuffContent:Find("buff"))

	self.buffUIItemList:make(function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_1 = arg_5_1 + 1

		if arg_5_0 == UIItemList.EventUpdate then
			local var_5_0 = self.buffList[arg_5_1]

			if #self.buffList[arg_5_1].config.icon > 0 then
				GetImageSpriteFromAtlasAsync("world/buff/" .. var_5_0.config.icon, "", arg_5_2:Find("icon"))
			else
				setImageSprite(arg_5_2:Find("icon"), nil)
			end

			setText(arg_5_2:Find("Text"), var_5_0.config.desc)
		end

		return
	end)

	self.mapBuffItemList = UIItemList.New(self.rtMapBuffContent, self.rtMapBuffContent:Find("buff"))

	self.mapBuffItemList:make(function(arg_6_0, arg_6_1, arg_6_2)
		arg_6_1 = arg_6_1 + 1

		if arg_6_0 == UIItemList.EventUpdate then
			local var_6_0 = self.mapBuffList[arg_6_1]

			if #self.mapBuffList[arg_6_1].config.icon > 0 then
				GetImageSpriteFromAtlasAsync("world/buff/" .. var_6_0.config.icon, "", arg_6_2:Find("icon"))
			else
				setImageSprite(arg_6_2:Find("icon"), nil)
			end

			setText(arg_6_2:Find("Text"), var_6_0.config.desc)
		end

		return
	end)

	self.weaknessUIItemList = UIItemList.New(self.rtWeaknessContent, self.rtWeaknessContent:Find("buff"))

	self.weaknessUIItemList:make(function(arg_7_0, arg_7_1, arg_7_2)
		arg_7_1 = arg_7_1 + 1

		if arg_7_0 == UIItemList.EventUpdate then
			setText(arg_7_2:Find("Text"), self.weaknessList[arg_7_1].config.desc)
		end

		return
	end)
	onButton(self, self.rtExit, function()
		self:Hide()

		return
	end, SFX_UI_CANCEL)
	onButton(self, self.rtClick:Find("enemy"), function()
		self:Hide(true)

		return
	end, SFX_CONFIRM)
	onButton(self, self.rtClick:Find("other"), function()
		self:Hide(true)

		return
	end, SFX_CONFIRM)

	return
end

function SVScannerPanel:OnDestroy()
	return
end

function SVScannerPanel:Show(arg_12_1, arg_12_2)
	self:emit(SVScannerPanel.ShowView)

	if arg_12_1 then
		self:DisplayWindow(arg_12_1, arg_12_2)
	else
		self:HideWindow()
	end

	function self.wsDragProxy.onDragFunction()
		if isActive(self.rtPanel) then
			self:HideWindow()
		end

		return
	end

	pg.UIMgr.GetInstance():OverlayPanel(self._tf)
	setActive(self._tf, true)
	self:EaseInOut(true)
	SVScannerPanel.super.Show(self)

	return
end

function SVScannerPanel:Hide(arg_14_1)
	if LeanTween.isTweening(self.alphaLT) then
		return
	end

	local var_14_0 = {}

	if not arg_14_1 then
		table.insert(var_14_0, function(arg_15_0)
			self:EaseInOut(false, arg_15_0)

			return
		end)
	end

	seriesAsync(var_14_0, function()
		self.wsDragProxy.onDragFunction = nil

		pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

		if arg_14_1 then
			self:emit(SVScannerPanel.HideGoing, self.attachment.row, self.attachment.column)
		else
			self:emit(SVScannerPanel.HideView)
		end

		SVScannerPanel.super.Hide(self)

		return
	end)

	return
end

function SVScannerPanel:Setup(arg_17_1, arg_17_2)
	self.map = arg_17_1
	self.wsDragProxy = arg_17_2

	return
end

function SVScannerPanel:DisplayWindow(arg_18_1, arg_18_2)
	if isActive(self.rtPanel) and self.attachment == arg_18_1 then
		self:HideWindow()
	else
		self:Update(arg_18_1)

		self.rtPanel.position = self.camera:ScreenToWorldPoint(arg_18_2)
		self.rtPanel.anchoredPosition3D = Vector3.New(self.rtPanel.anchoredPosition.x, self.rtPanel.anchoredPosition.y, 0)
		self.rtAnim.anchoredPosition = self.rtPanel.anchoredPosition
		self.rtWindow.anchorMin = Vector2.New(self.rtPanel.anchoredPosition.x > 0 and 0 or 1, self.rtPanel.anchoredPosition.y > 0 and 1 or 0)
		self.rtWindow.anchorMax = self.rtWindow.anchorMin
		self.rtWindow.pivot = Vector2.New(self.rtPanel.anchoredPosition.x > 0 and 1 or 0, self.rtPanel.anchoredPosition.y > 0 and 1 or 0)
		self.rtWindow.anchoredPosition = Vector2.zero
		self.rtClick.anchorMin = Vector2.New(self.rtPanel.anchoredPosition.x > 0 and 1 or 0, 0)
		self.rtClick.anchorMax = self.rtClick.anchorMin
		self.rtWindow.anchoredPosition = Vector2.zero

		local var_18_0 = WorldMapAttachment.IsEnemyType(arg_18_1.type) or arg_18_1:GetSpEventType() == WorldMapAttachment.SpEventEnemy

		setActive(self.rtClick:Find("enemy"), var_18_0)
		setActive(self.rtClick:Find("other"), not var_18_0)
		setActive(self.rtPanel, true)
	end

	return
end

function SVScannerPanel:HideWindow()
	setAnchoredPosition(self.rtAnim, Vector2.zero)
	setActive(self.rtPanel, false)

	return
end

function SVScannerPanel:EaseInOut(arg_20_1, arg_20_2)
	if self.alphaLT then
		LeanTween.cancel(self.alphaLT)
	end

	self.canvas.alpha = arg_20_1 and 0 or 1
	self.alphaLT = LeanTween.alphaCanvas(self.canvas, arg_20_1 and 1 or 0, 1):setOnComplete(System.Action(arg_20_2 or function()
		return
	end)).uniqueId

	return
end

function SVScannerPanel:Update(arg_22_1)
	if self.attachment ~= arg_22_1 then
		self.attachment = arg_22_1

		self:OnUpdate()
	end

	return
end

function SVScannerPanel:OnUpdate()
	local var_23_0 = self.attachment
	local var_23_1 = self.rtTitle:Find("Text")
	local var_23_2 = {}
	local var_23_3 = {}
	local var_23_4 = false
	local var_23_5 = false
	local var_23_6 = self.attachment.config.name or ""

	if WorldMapAttachment.IsEnemyType(var_23_0.type) then
		var_23_4 = true
		var_23_5 = false
		var_23_2 = var_23_0:GetBuffList()
		var_23_3 = self.map:GetBuffList(WorldMap.FactionEnemy, var_23_0)
		var_23_6 = var_23_0.config.difficulty == ys.Battle.BattleConst.Difficulty.WORLD and var_23_6 .. " LV." .. WorldConst.WorldLevelCorrect(self.map.config.expedition_level, var_23_0.config.type) or var_23_6 .. " LV." .. var_23_0.config.level
	elseif var_23_0.type == WorldMapAttachment.TypeEvent then
		var_23_2 = var_23_0:GetBuffList()
		var_23_3 = self.map:GetBuffList(WorldMap.FactionEnemy, var_23_0)

		if var_23_0.config.is_scanevent == 1 or var_23_0.config.is_scanevent == 3 then
			var_23_4 = var_23_0.config.is_scanevent == 3
			var_23_5 = true

			setActive(self.rtInfo:Find("Image"), false)
			setText(self.rtInfo:Find("Text"), var_23_0.config.scan_desc)
		elseif var_23_0.config.is_scanevent == 2 or var_23_0.config.is_scanevent == 4 then
			var_23_4 = var_23_0.config.is_scanevent == 4
			var_23_5 = true

			setActive(self.rtInfo:Find("Image"), true)
			GetImageSpriteFromAtlasAsync("icondesc/" .. var_23_0.config.icon, "", self.rtInfo:Find("Image"))
			setText(self.rtInfo:Find("Text"), var_23_0.config.scan_desc)
		end
	elseif var_23_0.type == WorldMapAttachment.TypeTrap then
		var_23_4 = true
		var_23_5 = true

		setActive(self.rtInfo:Find("Image"), true)
		GetImageSpriteFromAtlasAsync("world/buff/" .. WorldBuff.GetTemplate(var_23_0.config.buff_id).icon, "", self.rtInfo:Find("Image"))
		setText(self.rtInfo:Find("Text"), var_23_0.config.desc)
	elseif var_23_0.type == WorldMapAttachment.TypePort then
		if var_23_0.config.port_camp > 0 then
			if var_23_0.config.port_camp == nowWorld():GetRealm() then
				var_23_4 = false

				goto label_23_0
			end
		end

		var_23_4 = true

		::label_23_0::

		var_23_5 = true

		setActive(self.rtInfo:Find("Image"), false)
		setText(self.rtInfo:Find("Text"), var_23_0.config.scan_desc)
	end

	setText(var_23_1, var_23_6)

	local var_23_7 = var_23_0:GetWeaknessBuffId()

	self.buffList = {}
	self.weaknessList = {}

	for iter_23_0, iter_23_1 in ipairs(var_23_2) do
		if iter_23_1.id == var_23_7 then
			table.insert(self.weaknessList, iter_23_1)
		else
			table.insert(self.buffList, iter_23_1)
		end
	end

	self.buffUIItemList:align(#self.buffList)
	self.weaknessUIItemList:align(#self.weaknessList)

	self.mapBuffList = var_23_3

	self.mapBuffItemList:align(#self.mapBuffList)
	setActive(self.rtInfo, var_23_5)
	setActive(self.rtMark, var_23_5 and var_23_4)
	setActive(self.rtTitle:Find("red"), var_23_4)
	setActive(self.rtTitle:Find("yellow"), not var_23_4)

	local var_23_8 = var_23_0:GetRadiationBuffs()

	setActive(self.rtRadiation, #var_23_8 > 0)

	if #var_23_8 > 0 then
		local var_23_9, var_23_10, var_23_11 = unpack(var_23_8[1])

		GetImageSpriteFromAtlasAsync("world/mapbuff/" .. pg.world_SLGbuff_data[var_23_10].icon, "", self.rtRadiation:Find("info/map_buff/Image"))
		setText(self.rtRadiation:Find("info/Text"), i18n("world_mapbuff_tip"))
	end

	return
end

return SVScannerPanel
