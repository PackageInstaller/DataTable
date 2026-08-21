local var_0_0 = class("SVScannerPanel", import("view.base.BaseSubView"))

var_0_0.ShowView = "SVScannerPanel.ShowView"
var_0_0.HideView = "SVScannerPanel.HideView"
var_0_0.HideGoing = "SVScannerPanel.HideGoing"

function var_0_0.getUIName(arg_1_0)
	return "SVScannerPanel"
end

function var_0_0.getBGM(arg_2_0)
	return "echo-loop"
end

function var_0_0.OnLoaded(arg_3_0)
	return
end

function var_0_0.OnInit(arg_4_0)
	arg_4_0.camera = GameObject.Find("OverlayCamera"):GetComponent(typeof(Camera))
	arg_4_0.canvas = GetOrAddComponent(arg_4_0._tf, "CanvasGroup")
	arg_4_0.rtExit = arg_4_0._tf:Find("adapt/exit")
	arg_4_0.rtPanel = arg_4_0._tf:Find("adapt/selected_panel")

	setActive(arg_4_0.rtPanel, false)

	arg_4_0.rtWindow = arg_4_0.rtPanel:Find("window")
	arg_4_0.rtTitle = arg_4_0.rtWindow:Find("base_info/title")
	arg_4_0.rtMark = arg_4_0.rtWindow:Find("base_info/mark")
	arg_4_0.rtBuffContent = arg_4_0.rtWindow:Find("base_info/content")
	arg_4_0.rtMapBuffContent = arg_4_0.rtWindow:Find("base_info/map_buffs")
	arg_4_0.rtInfo = arg_4_0.rtWindow:Find("base_info/info")
	arg_4_0.rtWeaknessContent = arg_4_0.rtWindow:Find("weakness_info/content")
	arg_4_0.rtRadiation = arg_4_0.rtWindow:Find("radiation_info")
	arg_4_0.rtAnim = arg_4_0._tf:Find("adapt/anim")
	arg_4_0.rtClick = arg_4_0.rtPanel:Find("click")
	arg_4_0.buffUIItemList = UIItemList.New(arg_4_0.rtBuffContent, arg_4_0.rtBuffContent:Find("buff"))

	arg_4_0.buffUIItemList:make(function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_1 = arg_5_1 + 1

		if arg_5_0 == UIItemList.EventUpdate then
			local var_5_0 = arg_4_0.buffList[arg_5_1]

			if #arg_4_0.buffList[arg_5_1].config.icon > 0 then
				GetImageSpriteFromAtlasAsync("world/buff/" .. var_5_0.config.icon, "", arg_5_2:Find("icon"))
			else
				setImageSprite(arg_5_2:Find("icon"), nil)
			end

			setText(arg_5_2:Find("Text"), var_5_0.config.desc)
		end

		return
	end)

	arg_4_0.mapBuffItemList = UIItemList.New(arg_4_0.rtMapBuffContent, arg_4_0.rtMapBuffContent:Find("buff"))

	arg_4_0.mapBuffItemList:make(function(arg_6_0, arg_6_1, arg_6_2)
		arg_6_1 = arg_6_1 + 1

		if arg_6_0 == UIItemList.EventUpdate then
			local var_6_0 = arg_4_0.mapBuffList[arg_6_1]

			if #arg_4_0.mapBuffList[arg_6_1].config.icon > 0 then
				GetImageSpriteFromAtlasAsync("world/buff/" .. var_6_0.config.icon, "", arg_6_2:Find("icon"))
			else
				setImageSprite(arg_6_2:Find("icon"), nil)
			end

			setText(arg_6_2:Find("Text"), var_6_0.config.desc)
		end

		return
	end)

	arg_4_0.weaknessUIItemList = UIItemList.New(arg_4_0.rtWeaknessContent, arg_4_0.rtWeaknessContent:Find("buff"))

	arg_4_0.weaknessUIItemList:make(function(arg_7_0, arg_7_1, arg_7_2)
		arg_7_1 = arg_7_1 + 1

		if arg_7_0 == UIItemList.EventUpdate then
			setText(arg_7_2:Find("Text"), arg_4_0.weaknessList[arg_7_1].config.desc)
		end

		return
	end)
	onButton(arg_4_0, arg_4_0.rtExit, function()
		arg_4_0:Hide()

		return
	end, SFX_UI_CANCEL)
	onButton(arg_4_0, arg_4_0.rtClick:Find("enemy"), function()
		arg_4_0:Hide(true)

		return
	end, SFX_CONFIRM)
	onButton(arg_4_0, arg_4_0.rtClick:Find("other"), function()
		arg_4_0:Hide(true)

		return
	end, SFX_CONFIRM)

	return
end

function var_0_0.OnDestroy(arg_11_0)
	return
end

function var_0_0.Show(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:emit(var_0_0.ShowView)

	if arg_12_1 then
		arg_12_0:DisplayWindow(arg_12_1, arg_12_2)
	else
		arg_12_0:HideWindow()
	end

	function arg_12_0.wsDragProxy.onDragFunction()
		if isActive(arg_12_0.rtPanel) then
			arg_12_0:HideWindow()
		end

		return
	end

	pg.UIMgr.GetInstance():OverlayPanel(arg_12_0._tf)
	setActive(arg_12_0._tf, true)
	arg_12_0:EaseInOut(true)
	var_0_0.super.Show(arg_12_0)

	return
end

function var_0_0.Hide(arg_14_0, arg_14_1)
	if LeanTween.isTweening(arg_14_0.alphaLT) then
		return
	end

	local var_14_0 = {}

	if not arg_14_1 then
		table.insert(var_14_0, function(arg_15_0)
			arg_14_0:EaseInOut(false, arg_15_0)

			return
		end)
	end

	seriesAsync(var_14_0, function()
		arg_14_0.wsDragProxy.onDragFunction = nil

		pg.UIMgr.GetInstance():UnOverlayPanel(arg_14_0._tf, arg_14_0._parentTf)

		if arg_14_1 then
			arg_14_0:emit(var_0_0.HideGoing, arg_14_0.attachment.row, arg_14_0.attachment.column)
		else
			arg_14_0:emit(var_0_0.HideView)
		end

		var_0_0.super.Hide(arg_14_0)

		return
	end)

	return
end

function var_0_0.Setup(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0.map = arg_17_1
	arg_17_0.wsDragProxy = arg_17_2

	return
end

function var_0_0.DisplayWindow(arg_18_0, arg_18_1, arg_18_2)
	if isActive(arg_18_0.rtPanel) and arg_18_0.attachment == arg_18_1 then
		arg_18_0:HideWindow()
	else
		arg_18_0:Update(arg_18_1)

		arg_18_0.rtPanel.position = arg_18_0.camera:ScreenToWorldPoint(arg_18_2)
		arg_18_0.rtPanel.anchoredPosition3D = Vector3.New(arg_18_0.rtPanel.anchoredPosition.x, arg_18_0.rtPanel.anchoredPosition.y, 0)
		arg_18_0.rtAnim.anchoredPosition = arg_18_0.rtPanel.anchoredPosition
		arg_18_0.rtWindow.anchorMin = Vector2.New(arg_18_0.rtPanel.anchoredPosition.x > 0 and 0 or 1, arg_18_0.rtPanel.anchoredPosition.y > 0 and 1 or 0)
		arg_18_0.rtWindow.anchorMax = arg_18_0.rtWindow.anchorMin
		arg_18_0.rtWindow.pivot = Vector2.New(arg_18_0.rtPanel.anchoredPosition.x > 0 and 1 or 0, arg_18_0.rtPanel.anchoredPosition.y > 0 and 1 or 0)
		arg_18_0.rtWindow.anchoredPosition = Vector2.zero
		arg_18_0.rtClick.anchorMin = Vector2.New(arg_18_0.rtPanel.anchoredPosition.x > 0 and 1 or 0, 0)
		arg_18_0.rtClick.anchorMax = arg_18_0.rtClick.anchorMin
		arg_18_0.rtWindow.anchoredPosition = Vector2.zero

		local var_18_0 = WorldMapAttachment.IsEnemyType(arg_18_1.type) or arg_18_1:GetSpEventType() == WorldMapAttachment.SpEventEnemy

		setActive(arg_18_0.rtClick:Find("enemy"), var_18_0)
		setActive(arg_18_0.rtClick:Find("other"), not var_18_0)
		setActive(arg_18_0.rtPanel, true)
	end

	return
end

function var_0_0.HideWindow(arg_19_0)
	setAnchoredPosition(arg_19_0.rtAnim, Vector2.zero)
	setActive(arg_19_0.rtPanel, false)

	return
end

function var_0_0.EaseInOut(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_0.alphaLT then
		LeanTween.cancel(arg_20_0.alphaLT)
	end

	arg_20_0.canvas.alpha = arg_20_1 and 0 or 1
	arg_20_0.alphaLT = LeanTween.alphaCanvas(arg_20_0.canvas, arg_20_1 and 1 or 0, 1):setOnComplete(System.Action(arg_20_2 or function()
		return
	end)).uniqueId

	return
end

function var_0_0.Update(arg_22_0, arg_22_1)
	if arg_22_0.attachment ~= arg_22_1 then
		arg_22_0.attachment = arg_22_1

		arg_22_0:OnUpdate()
	end

	return
end

function var_0_0.OnUpdate(arg_23_0)
	local var_23_0 = arg_23_0.attachment
	local var_23_1 = arg_23_0.rtTitle:Find("Text")
	local var_23_2 = {}
	local var_23_3 = {}
	local var_23_4 = false
	local var_23_5 = false
	local var_23_6 = arg_23_0.attachment.config.name or ""

	if WorldMapAttachment.IsEnemyType(var_23_0.type) then
		var_23_4 = true
		var_23_5 = false
		var_23_2 = var_23_0:GetBuffList()
		var_23_3 = arg_23_0.map:GetBuffList(WorldMap.FactionEnemy, var_23_0)
		var_23_6 = var_23_0.config.difficulty == ys.Battle.BattleConst.Difficulty.WORLD and var_23_6 .. " LV." .. WorldConst.WorldLevelCorrect(arg_23_0.map.config.expedition_level, var_23_0.config.type) or var_23_6 .. " LV." .. var_23_0.config.level

		goto label_23_0
	end

	if var_23_0.type == WorldMapAttachment.TypeEvent then
		var_23_2 = var_23_0:GetBuffList()
		var_23_3 = arg_23_0.map:GetBuffList(WorldMap.FactionEnemy, var_23_0)

		if var_23_0.config.is_scanevent == 1 or var_23_0.config.is_scanevent == 3 then
			var_23_4 = var_23_0.config.is_scanevent == 3
			var_23_5 = true

			setActive(arg_23_0.rtInfo:Find("Image"), false)
			setText(arg_23_0.rtInfo:Find("Text"), var_23_0.config.scan_desc)
		elseif var_23_0.config.is_scanevent == 2 or var_23_0.config.is_scanevent == 4 then
			var_23_4 = var_23_0.config.is_scanevent == 4
			var_23_5 = true

			setActive(arg_23_0.rtInfo:Find("Image"), true)
			GetImageSpriteFromAtlasAsync("icondesc/" .. var_23_0.config.icon, "", arg_23_0.rtInfo:Find("Image"))
			setText(arg_23_0.rtInfo:Find("Text"), var_23_0.config.scan_desc)
		end

		goto label_23_0
	end

	if var_23_0.type == WorldMapAttachment.TypeTrap then
		var_23_4 = true
		var_23_5 = true

		setActive(arg_23_0.rtInfo:Find("Image"), true)
		GetImageSpriteFromAtlasAsync("world/buff/" .. WorldBuff.GetTemplate(var_23_0.config.buff_id).icon, "", arg_23_0.rtInfo:Find("Image"))
		setText(arg_23_0.rtInfo:Find("Text"), var_23_0.config.desc)

		goto label_23_0
	end

	::label_23_0::

	if var_23_0.type == WorldMapAttachment.TypePort then
		if var_23_0.config.port_camp > 0 then
			var_23_4 = var_23_0.config.port_camp ~= nowWorld():GetRealm()
			var_23_5 = true

			setActive(arg_23_0.rtInfo:Find("Image"), false)
			setText(arg_23_0.rtInfo:Find("Text"), var_23_0.config.scan_desc)
			setText(var_23_1, var_23_6)

			local var_23_7 = var_23_0:GetWeaknessBuffId()

			arg_23_0.buffList = {}
			arg_23_0.weaknessList = {}

			for iter_23_0, iter_23_1 in ipairs(var_23_2) do
				if iter_23_1.id == var_23_7 then
					table.insert(arg_23_0.weaknessList, iter_23_1)
				else
					table.insert(arg_23_0.buffList, iter_23_1)
				end
			end

			arg_23_0.buffUIItemList:align(#arg_23_0.buffList)
			arg_23_0.weaknessUIItemList:align(#arg_23_0.weaknessList)

			arg_23_0.mapBuffList = var_23_3

			arg_23_0.mapBuffItemList:align(#arg_23_0.mapBuffList)
			setActive(arg_23_0.rtInfo, var_23_5)
			setActive(arg_23_0.rtMark, var_23_5 and var_23_4)
			setActive(arg_23_0.rtTitle:Find("red"), var_23_4)
			setActive(arg_23_0.rtTitle:Find("yellow"), not var_23_4)

			local var_23_8 = var_23_0:GetRadiationBuffs()

			setActive(arg_23_0.rtRadiation, #var_23_8 > 0)

			if #var_23_8 > 0 then
				local var_23_9, var_23_10, var_23_11 = unpack(var_23_8[1])

				GetImageSpriteFromAtlasAsync("world/mapbuff/" .. pg.world_SLGbuff_data[var_23_10].icon, "", arg_23_0.rtRadiation:Find("info/map_buff/Image"))
				setText(arg_23_0.rtRadiation:Find("info/Text"), i18n("world_mapbuff_tip"))
			end

			return
		end
	end
end

return var_0_0
