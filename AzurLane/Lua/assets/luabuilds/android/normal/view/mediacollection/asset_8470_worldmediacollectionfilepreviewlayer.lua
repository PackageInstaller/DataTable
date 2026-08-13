class = var_0_10000

local var_0_0 = "WorldMediaCollectionFilePreviewLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.__index(arg_1_0, arg_1_1)
	rawget = var_1_10002

	local var_1_0

	if not var_1_10002(var_0_1, arg_1_1) then
		var_1_0 = var_0_1.super[arg_1_1]
	end

	if not var_1_0 then
		WorldMediaCollectionFileDetailLayer = var_3
		var_1_0 = var_3[arg_1_1]
	end

	return var_1_0
end

function var_0_1.getUIName(arg_2_0)
	return "WorldMediaCollectionFilePreviewUI"
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf
	local var_3_1 = var_1.GetComponent

	typeof = var_1_10003
	CanvasGroup = var_1_10004
	arg_3_0.canvasGroup = var_3_1(var_3_0, var_1_10003(var_1_10004))

	arg_3_0:InitDocument()

	local var_3_2 = arg_3_0._tf

	arg_3_0.tipTF = var_1.Find(var_3_2, "Tip")
	setText = var_1

	local var_3_3 = arg_3_0.tipTF

	i18n = var_3

	var_1(var_3_3, var_3("world_file_tip"))

	local var_3_4 = arg_3_0._tf

	arg_3_0.animBar = var_1.Find(var_3_4, "Bar")
	setActive = var_1

	var_1(arg_3_0.animBar, false)

	setActive = var_1

	var_1(arg_3_0.document, false)

	setActive = var_1

	var_1(arg_3_0.tipTF, false)

	AutoLoader = var_1
	arg_3_0.loader = var_1.New()
	setText = var_1

	local var_3_5 = arg_3_0.animBar
	local var_3_6 = var_2.Find(var_3_5, "Text")

	i18n = var_3_5

	var_1(var_3_6, var_3_5("world_collection_back"))

	return
end

function var_0_1.didEnter(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_4_0, arg_4_0._tf)

	WorldCollectionProxy = var_1

	local var_4_1 = var_1.GetCollectionTemplate(arg_4_0.contextData.collectionId)

	arg_4_0:SetDocument(var_4_1)

	setActive = var_2

	var_2(arg_4_0.animBar, true)

	local var_4_2 = arg_4_0.animBar
	local var_4_3 = var_2.Find(var_4_2, "Anim/Frame/Mask")
	local var_4_4 = var_2.GetComponent

	typeof = var_4
	LayoutElement = var_1_10005

	local var_4_5 = var_4_4(var_4_3, var_4(var_1_10005))
	local var_4_6 = arg_4_0.animBar
	local var_4_7 = var_3.Find(var_4_6, "Anim/Frame/Mask/Name")
	local var_4_8 = var_3.GetComponent

	typeof = var_1_10006
	Text = var_1_10007

	local var_4_9 = var_4_8(var_4_7, var_1_10006(var_1_10007))

	RemoveComponent = var_4_7

	local var_4_10 = var_3

	typeof = var_1_10007
	ScrollText = var_1_10008

	var_4_7(var_4_10, var_1_10007(var_1_10008))

	local var_4_11 = var_4_5.preferredWidth

	Vector2 = var_4_10
	var_3.pivot = var_4_10(0, 0.5)
	Vector2 = var_6
	var_3.anchorMin = var_6(0, 0.5)
	Vector2 = var_6
	var_3.anchorMax = var_6(0, 0.5)
	Vector2 = var_6
	var_3.anchoredPosition = var_6.zero
	tostring = var_6

	local var_4_12

	if not var_4_1.name then
		var_4_12 = ""
	end

	var_4_9.text = var_6(var_4_12)
	math = var_6
	var_4_5.preferredWidth = var_6.min(var_4_9.preferredWidth, var_4_11)

	local function var_4_13()
		onButton = var_2_10000

		var_2_10000(arg_4_0, arg_4_0._tf, function()
			local var_6_0 = arg_4_0

			var_0.closeView(var_6_0)

			return
		end)

		return
	end

	local function var_4_14()
		local var_7_0 = var_4_9.preferredWidth

		if var_4_11 < var_7_0 then
			local var_7_1 = var_0

			Vector2 = var_1
			var_7_1.pivot = var_1(0.5, 0.5)

			local var_7_2 = var_0

			Vector2 = var_1
			var_7_2.anchorMin = var_1(0.5, 0.5)

			local var_7_3 = var_0

			Vector2 = var_1
			var_7_3.anchorMax = var_1(0.5, 0.5)
			setScrollText = var_7_3

			local var_7_4 = var_0
			local var_7_5

			if not var_4_1.name then
				var_7_5 = ""
			end

			var_7_3(var_7_4, var_7_5)
		end

		return
	end

	local var_4_15 = arg_4_0.animBar
	local var_4_16 = var_8.GetComponent

	typeof = var_1_10010
	DftAniEvent = var_1_10011

	local var_4_17 = var_4_16(var_4_15, var_1_10010(var_1_10011))

	removeOnButton = var_4_15

	var_4_15(arg_4_0._tf)

	if var_4_17 then
		var_4_17:SetTriggerEvent(var_4_14)
		var_4_17:SetEndEvent(var_4_13)
	else
		var_4_14()
		var_4_13()
	end

	onButton = var_4_15

	local var_4_18 = arg_4_0
	local var_4_19 = arg_4_0.animBar
	local var_4_20 = var_11.Find(var_4_19, "Button")

	local function var_4_21()
		setActive = var_2_10000

		var_2_10000(arg_4_0.animBar, false)

		setActive = var_2_10000

		var_2_10000(arg_4_0.document, true)

		setActive = var_2_10000

		var_2_10000(arg_4_0.tipTF, true)
		var_4_13()

		return
	end

	SFX_PANEL = var_13

	var_4_15(var_4_18, var_4_20, var_4_21, var_13)

	WorldCollectionProxy = var_4_15

	local var_4_22 = var_4_15.GetCollectionGroup(var_4_1.id)

	WorldCollectionProxy = var_10

	local var_4_23 = var_10.GetCollectionFileGroupTemplate(var_4_22)

	setImageSprite = var_11

	local var_4_24 = arg_4_0.animBar
	local var_4_25 = var_12.Find(var_4_24, "Anim/Icon")

	LoadSprite = var_4_24

	var_11(var_4_25, var_4_24("ui/WorldMediaCollectionFilePreviewUI_atlas", var_4_23.type))

	return
end

function var_0_1.willExit(arg_9_0)
	pg = var_1_10001

	local var_9_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_9_0, arg_9_0._tf)

	local var_9_1 = arg_9_0.loader

	var_1.Clear(var_9_1)

	if arg_9_0.contextData.callback then
		var_1()
	end

	var_0_1.super.willExit(arg_9_0)

	return
end

return var_0_1
