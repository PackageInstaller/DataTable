local var_0_0 = class("WorldMediaCollectionFilePreviewLayer", import("view.base.BaseUI"))

function var_0_0.__index(arg_1_0, arg_1_1)
	return rawget(var_0_0, arg_1_1) or var_0_0.super[arg_1_1] or WorldMediaCollectionFileDetailLayer[arg_1_1]
end

function var_0_0.getUIName(arg_2_0)
	return "WorldMediaCollectionFilePreviewUI"
end

function var_0_0.init(arg_3_0)
	arg_3_0.canvasGroup = arg_3_0._tf:GetComponent(typeof(CanvasGroup))

	arg_3_0:InitDocument()

	arg_3_0.tipTF = arg_3_0._tf:Find("Tip")

	setText(arg_3_0.tipTF, i18n("world_file_tip"))

	arg_3_0.animBar = arg_3_0._tf:Find("Bar")

	setActive(arg_3_0.animBar, false)
	setActive(arg_3_0.document, false)
	setActive(arg_3_0.tipTF, false)

	arg_3_0.loader = AutoLoader.New()

	setText(arg_3_0.animBar:Find("Text"), i18n("world_collection_back"))

	return
end

function var_0_0.didEnter(arg_4_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_4_0._tf)

	local var_4_0 = WorldCollectionProxy.GetCollectionTemplate(arg_4_0.contextData.collectionId)

	arg_4_0:SetDocument(var_4_0)
	setActive(arg_4_0.animBar, true)

	local var_4_1 = arg_4_0.animBar:Find("Anim/Frame/Mask"):GetComponent(typeof(LayoutElement))
	local var_4_2 = arg_4_0.animBar:Find("Anim/Frame/Mask/Name")
	local var_4_3 = var_4_2:GetComponent(typeof(Text))

	RemoveComponent(var_4_2, typeof(ScrollText))

	local var_4_4 = var_4_1.preferredWidth

	var_4_2.pivot = Vector2(0, 0.5)
	var_4_2.anchorMin = Vector2(0, 0.5)
	var_4_2.anchorMax = Vector2(0, 0.5)
	var_4_2.anchoredPosition = Vector2.zero

	local var_4_5 = var_4_0.name or ""

	var_4_3.text = tostring(var_4_5)
	var_4_1.preferredWidth = math.min(var_4_3.preferredWidth, var_4_1.preferredWidth)

	local function var_4_6()
		onButton(arg_4_0, arg_4_0._tf, function()
			arg_4_0:closeView()

			return
		end)

		return
	end

	local var_4_7 = arg_4_0.animBar:GetComponent(typeof(DftAniEvent))

	removeOnButton(arg_4_0._tf)

	if var_4_7 then
		var_4_7:SetTriggerEvent(function()
			if var_4_3.preferredWidth > var_4_4 then
				var_4_2.pivot = Vector2(0.5, 0.5)
				var_4_2.anchorMin = Vector2(0.5, 0.5)
				var_4_2.anchorMax = Vector2(0.5, 0.5)

				local var_7_0 = var_4_0.name or ""

				setScrollText(var_4_2, var_7_0)
			end

			return
		end)
		var_4_7:SetEndEvent(function()
			onButton(arg_4_0, arg_4_0._tf, function()
				arg_4_0:closeView()

				return
			end)

			return
		end)
	else
		(function()
			if var_4_3.preferredWidth > var_4_4 then
				var_4_2.pivot = Vector2(0.5, 0.5)
				var_4_2.anchorMin = Vector2(0.5, 0.5)
				var_4_2.anchorMax = Vector2(0.5, 0.5)

				local var_7_0 = var_4_0.name or ""

				setScrollText(var_4_2, var_7_0)
			end

			return
		end)()
		;(function()
			onButton(arg_4_0, arg_4_0._tf, function()
				arg_4_0:closeView()

				return
			end)

			return
		end)()
	end

	onButton(arg_4_0, arg_4_0.animBar:Find("Button"), function()
		setActive(arg_4_0.animBar, false)
		setActive(arg_4_0.document, true)
		setActive(arg_4_0.tipTF, true)
		var_4_6()

		return
	end, SFX_PANEL)
	setImageSprite(arg_4_0.animBar:Find("Anim/Icon"), LoadSprite("ui/WorldMediaCollectionFilePreviewUI_atlas", WorldCollectionProxy.GetCollectionFileGroupTemplate((WorldCollectionProxy.GetCollectionGroup(var_4_0.id))).type))

	return
end

function var_0_0.willExit(arg_9_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_9_0._tf)
	arg_9_0.loader:Clear()

	if arg_9_0.contextData.callback then
		arg_9_0.contextData.callback()
	end

	var_0_0.super.willExit(arg_9_0)

	return
end

return var_0_0
