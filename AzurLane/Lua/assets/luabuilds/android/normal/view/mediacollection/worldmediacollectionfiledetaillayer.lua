class = var_0_10000

local var_0_0 = "WorldMediaCollectionFileDetailLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".WorldMediaCollectionSubLayer"))

function var_0_1.getUIName(arg_1_0)
	return "WorldMediaCollectionFileDetailUI"
end

function var_0_1.OnInit(arg_2_0)
	assert = var_1_10001

	var_1_10001(arg_2_0.viewParent, "Need assign ViewParent for " .. arg_2_0.__cname)

	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0._tf

	var_1_10001(var_2_0, var_3.Find(var_2_1, "Buttom"), function()
		local var_3_0 = arg_2_0.viewParent

		var_0.Backward(var_3_0)

		return
	end)

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_1.GetComponent

	typeof = var_3
	Animation = var_4
	arg_2_0.anim = var_2_3(var_2_2, var_3(var_4))

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_1.GetComponent

	typeof = var_3
	CanvasGroup = var_4
	arg_2_0.canvasGroup = var_2_5(var_2_4, var_3(var_4))

	arg_2_0:InitDocument()

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_1.Find(var_2_6, "ArchiveList")

	arg_2_0.scrollComp = var_1.GetComponent(var_2_7, "LScrollRect")
	arg_2_0.fileChild = {}
	arg_2_0.fileChildIndex = {}

	local var_2_8 = arg_2_0.scrollComp

	function var_2_8.onUpdateItem(arg_4_0, ...)
		local var_4_0 = arg_2_0

		var_1.OnUpdateFile(var_4_0, arg_4_0 + 1, ...)

		return
	end

	setActive = var_2_8

	var_2_8(var_1:Find("Item"), false)

	AutoLoader = var_2_8
	arg_2_0.loader = var_2_8.New()
	setText = var_2

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_3.Find(var_2_9, "ArchiveList/ProgressDesc")

	i18n = var_2_9

	var_2(var_2_10, var_2_9("world_collection_1"))

	return
end

function var_0_1.InitDocument(arg_5_0)
	local var_5_0 = arg_5_0._tf

	arg_5_0.document = var_1.Find(var_5_0, "Document")

	local var_5_1 = arg_5_0.document

	arg_5_0.documentContentTF = var_1.Find(var_5_1, "Viewport/Content")

	local var_5_2 = arg_5_0.documentContentTF

	arg_5_0.documentHead = var_1.Find(var_5_2, "Head")

	local var_5_3 = arg_5_0.documentContentTF

	arg_5_0.documentBody = var_1.Find(var_5_3, "Body")

	local var_5_4 = arg_5_0.documentHead

	arg_5_0.documentTitle = var_1.Find(var_5_4, "Title")

	local var_5_5 = arg_5_0.documentBody

	arg_5_0.documentRect = var_1.Find(var_5_5, "Rect")

	local var_5_6 = arg_5_0.documentRect

	arg_5_0.documentTip = var_1.Find(var_5_6, "SubTitle")

	local var_5_7 = arg_5_0.documentRect

	arg_5_0.documentText = var_1.Find(var_5_7, "Text")

	local var_5_8 = arg_5_0.documentRect

	arg_5_0.documentImage = var_1.Find(var_5_8, "Image")

	local var_5_9 = arg_5_0.documentImage

	arg_5_0.documentStamp = var_1.Find(var_5_9, "ClassifiedStamp")

	return
end

function var_0_1.Openning(arg_6_0)
	local var_6_0 = arg_6_0.anim

	var_1.Play(var_6_0, "Enter")
	arg_6_0:Enter()

	return
end

function var_0_1.Enter(arg_7_0)
	local function var_7_0()
		nowWorld = var_2_10000

		local var_8_0 = var_2_10000()
		local var_8_1 = var_0.GetCollectionProxy(var_8_0)

		WorldCollectionProxy = var_8_0

		local var_8_2 = var_8_0.GetCollectionFileGroupTemplate(arg_7_0.contextData.FileGroupIndex)

		ipairs = var_2

		for iter_8_0, iter_8_1 in var_2(var_8_2.child) do
			if var_8_1:IsUnlock(iter_8_1) then
				return iter_8_0
			end
		end

		return
	end

	local var_7_1

	if not arg_7_0.contextData.SelectedFile then
		var_7_1 = var_7_0()
	end

	arg_7_0.contextData.SelectedFile = nil

	arg_7_0:UpdateView()
	arg_7_0:SwitchFileIndex(var_7_1)

	return
end

function var_0_1.Hide(arg_9_0)
	arg_9_0.canvasGroup.alpha = 1

	var_0_1.super.Hide(arg_9_0)

	return
end

function var_0_1.UpdateView(arg_10_0)
	assert = var_1_10001

	var_1_10001(arg_10_0.contextData.FileGroupIndex, "Not Initialize FileGroupIndex")

	_ = var_1_10001

	local var_10_0 = var_1_10001.map

	WorldCollectionProxy = var_2
	arg_10_0.archiveList = var_10_0(var_2.GetCollectionFileGroupTemplate(arg_10_0.contextData.FileGroupIndex).child, function(arg_11_0)
		WorldCollectionProxy = var_2_10001

		return var_2_10001.GetCollectionTemplate(arg_11_0)
	end)
	nowWorld = var_1

	local var_10_1 = var_1()
	local var_10_2 = var_1.GetCollectionProxy(var_10_1)

	WorldCollectionProxy = var_10_1

	local var_10_3 = var_10_1.GetCollectionFileGroupTemplate(arg_10_0.contextData.FileGroupIndex)
	local var_10_4 = 0
	local var_10_5 = #var_10_3.child

	ipairs = var_1_10005

	for iter_10_0, iter_10_1 in var_1_10005(var_10_3.child) do
		if var_10_2:IsUnlock(iter_10_1) then
			var_10_4 = var_10_4 + 1
		end
	end

	setText = var_5

	local var_10_6 = arg_10_0._tf

	var_5(var_6.Find(var_10_6, "ArchiveList/ProgressDesc/ProgressText"), var_10_4 .. "/" .. var_10_5)

	local var_10_7 = arg_10_0.scrollComp

	var_5.SetTotalCount(var_10_7, #arg_10_0.archiveList)

	return
end

local function var_0_2(arg_12_0)
	string = var_1_10001

	return (var_1_10001.char(226, 133, 160 + (arg_12_0 - 1)))
end

function var_0_1.OnUpdateFile(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_0.exited then
		return
	end

	local var_13_0 = arg_13_0.archiveList[arg_13_1]

	if arg_13_0.fileChildIndex[arg_13_2] and arg_13_0.fileChildIndex[arg_13_2] ~= arg_13_1 then
		local var_13_1 = arg_13_0.fileChildIndex[arg_13_2]

		arg_13_0.fileChild[var_13_1] = nil
	end

	arg_13_0.fileChildIndex[arg_13_2] = arg_13_1

	local var_13_2 = arg_13_0.fileChild

	var_13_2[arg_13_1] = arg_13_2
	nowWorld = var_13_2

	local var_13_3 = var_13_2()
	local var_13_4 = var_4.GetCollectionProxy(var_13_3)

	tf = var_13_3

	local var_13_5 = var_13_3(arg_13_2)

	WorldCollectionProxy = var_6

	local var_13_6 = var_6.GetCollectionFileGroupTemplate(arg_13_0.contextData.FileGroupIndex)
	local var_13_7 = var_13_4:IsUnlock(var_13_0.id)
	local var_13_8 = arg_13_1 == arg_13_0.contextData.SelectedFile

	setActive = var_9

	var_9(var_13_5:Find("Selected"), var_13_8)

	string = var_9

	local var_13_9 = var_9.format
	local var_13_10 = "%s %s"

	shortenString = var_11

	local var_13_11

	if not var_13_6.name then
		var_13_11 = ""
	end

	local var_13_12 = var_13_9(var_13_10, var_11(var_13_11, 6), var_0_2(var_13_0.group_ID))

	setText = var_13_10

	local var_13_13 = var_13_5
	local var_13_14 = var_13_5.Find(var_13_13, "Desc")

	setColorStr = var_13_13

	local var_13_15 = var_13_12

	if var_13_8 then
		var_1_10014 = "#000"
	else
		COLOR_WHITE = var_1_10014
	end

	var_13_10(var_13_14, var_13_13(var_13_15, var_1_10014))

	setActive = var_13_10

	var_13_10(var_13_5:Find("Desc"), var_13_7)

	setActive = var_13_10

	var_13_10(var_13_5:Find("Icon"), var_13_7)

	setActive = var_13_10

	var_13_10(var_13_5:Find("Cover"), var_13_7)

	setActive = var_13_10

	var_13_10(var_13_5:Find("Locked"), not var_13_7)

	local var_13_16 = arg_13_0.loader

	var_10.GetSprite(var_13_16, "ui/WorldMediaCollectionFileDetailUI_atlas", "cover" .. var_13_6.type, var_13_5:Find("Cover"))

	onButton = var_10

	local var_13_17 = arg_13_0
	local var_13_18 = var_13_5

	local function var_13_19()
		nowWorld = var_2_10000

		local var_14_0 = var_2_10000()
		local var_14_1 = var_0.GetCollectionProxy(var_14_0)

		if not var_0.IsUnlock(var_14_1, var_13_0.id) then
			return
		end

		local var_14_2 = arg_13_0

		var_0.SwitchFileIndex(var_14_2, arg_13_1)

		return
	end

	SFX_PANEL = var_14

	var_10(var_13_17, var_13_18, var_13_19, var_14)

	return
end

function var_0_1.SwitchFileIndex(arg_15_0, arg_15_1)
	if arg_15_0.contextData.SelectedFile and arg_15_0.contextData.SelectedFile == arg_15_1 then
		return
	end

	if arg_15_1 and arg_15_0.archiveList[arg_15_1] then
		::label_15_0::

		nowWorld = var_1_10003
		var_1_10004 = var_1_10003()
		var_1_10004 = var_1_10003.GetCollectionProxy(var_1_10004)
		var_1_10003 = var_1_10003.IsUnlock(var_1_10004, var_2.id)
	end

	if var_1_10003 then
		var_1_10004 = arg_15_0.contextData.SelectedFile

		local var_15_0 = arg_15_0.fileChild[var_1_10004]

		arg_15_0.contextData.SelectedFile = arg_15_1

		if var_15_0 then
			arg_15_0:OnUpdateFile(var_1_10004, var_15_0)
		end

		if arg_15_0.fileChild[arg_15_1] then
			arg_15_0:OnUpdateFile(arg_15_1, arg_15_0.fileChild[arg_15_1])
		end

		setActive = var_6

		var_6(arg_15_0.document, true)

		setText = var_6

		local var_15_1 = arg_15_0.document

		var_6(var_7.Find(var_15_1, "Head/Title"), var_2.name)
		arg_15_0:SetDocument(var_2)
	else
		setActive = var_1_10004

		var_1_10004(arg_15_0.document, false)
	end

	return
end

function var_0_1.SetDocument(arg_16_0, arg_16_1, arg_16_2)
	setText = var_1_10003

	var_1_10003(arg_16_0.documentTitle, arg_16_1.name)

	local var_16_0

	if arg_16_1.pic and #var_3 > 0 then
		LoadSprite = var_16_0
		var_16_0 = var_16_0("CollectionFileIllustration/" .. var_3, "")
		setImageSprite = var_5

		var_5(arg_16_0.documentImage, var_16_0, true)

		setActive = var_5

		var_5(arg_16_0.documentImage, var_16_0)

		if var_16_0 then
			setActive = var_5

			var_5(arg_16_0.documentStamp, arg_16_1.is_classified == 1)

			if arg_16_1.is_classified == 1 then
				WorldCollectionProxy = var_5

				local var_16_1 = var_5.GetCollectionGroup(arg_16_1.id)

				WorldCollectionProxy = var_6

				local var_16_2 = var_6.GetCollectionFileGroupTemplate(var_16_1).type
				local var_16_3 = arg_16_0.loader

				var_8.GetSprite(var_16_3, "ui/WorldMediaCollectionFileDetailUI_atlas", "stamp" .. var_16_2, arg_16_0.documentStamp)
			end
		end
	else
		setActive = var_16_0

		var_16_0(arg_16_0.documentImage, false)
	end

	arg_16_0:SetDocumentText(arg_16_1.content, arg_16_1.subTitle, arg_16_2)

	return
end

function var_0_1.getTextPreferredHeight(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0.cachedTextGeneratorForLayout
	local var_17_1 = arg_17_0
	local var_17_2 = arg_17_0.GetGenerationSettings

	Vector2 = var_1_10006

	local var_17_3 = var_17_2(var_17_1, var_1_10006(arg_17_1, 0))

	ReflectionHelp = var_17_1

	local var_17_4 = var_17_1.RefCallMethod

	typeof = var_6

	local var_17_5 = var_6("UnityEngine.TextGenerator")
	local var_17_6 = "GetPreferredHeight"
	local var_17_7 = var_17_0
	local var_17_8 = {}

	typeof = var_1_10010
	var_17_8[1] = var_1_10010("System.String")
	typeof = var_10
	var_17_8[2] = var_10("UnityEngine.TextGenerationSettings")

	return var_17_4(var_17_5, var_17_6, var_17_7, var_17_8, {
		arg_17_2,
		var_17_3
	}) / arg_17_0.pixelsPerUnit
end

function var_0_1.SetDocumentText(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_0.documentRect.rect.width

	isActive = var_1_10005

	local var_18_1

	if not var_1_10005(arg_18_0.documentImage) or not arg_18_0.documentImage.rect.width then
		var_18_1 = 0
	end

	math = var_1_10007

	local var_18_2 = var_1_10007.max(var_18_0 - var_18_1, 0)
	local var_18_3 = arg_18_0.documentImage.rect.height
	local var_18_4

	if not var_5 or not (var_18_3 + 100) then
		var_18_4 = 0
	end

	local var_18_5 = arg_18_0.documentText
	local var_18_6 = var_10.GetComponent

	typeof = var_1_10012
	Text = var_1_10013

	local var_18_7 = var_18_6(var_18_5, var_1_10012(var_1_10013))

	var_18_7.text = ""

	local var_18_8 = ""

	local function var_18_9()
		local var_19_0 = 0

		isActive = var_2_10001

		if var_2_10001(arg_18_0.documentHead) then
			local var_19_1 = arg_18_0.documentHead
			local var_19_2 = var_1.GetComponent

			typeof = var_2_10003
			LayoutElement = var_2_10004
			var_19_0 = var_19_0 + var_19_2(var_19_1, var_2_10003(var_2_10004)).preferredHeight
		end

		local var_19_3 = arg_18_0.documentBody
		local var_19_4 = var_19_0 + (var_1.GetComponent(var_19_3, "LayoutGroup").padding.top + var_1.padding.bottom)

		setActive = var_3

		local var_19_5 = arg_18_0.documentTip
		local var_19_6

		if arg_18_2 then
			var_19_6 = #arg_18_2 > 0
		end

		var_3(var_19_5, var_19_6)

		local var_19_7 = 0

		if arg_18_2 then
			local var_19_8 = #arg_18_2

			if 0 < var_19_8 then
				var_19_6 = arg_18_0.documentTip
				var_19_6 = var_4.Find(var_19_6, "Text")

				local var_19_9 = var_4.GetComponent

				typeof = var_6
				Text = var_2_10007

				local var_19_10 = var_19_9(var_19_6, var_6(var_2_10007))

				var_19_10.text = arg_18_2
				var_19_7 = var_0_1.getTextPreferredHeight(var_19_10, var_18_0, arg_18_2)

				local var_19_11 = arg_18_0.documentRect

				var_19_6 = var_19_6.GetComponent
				typeof = var_7
				VerticalLayoutGroup = var_8
				var_19_4 = var_19_4 + (var_19_7 + var_19_6(var_19_11, var_7(var_8)).spacing)
			end
		end

		if var_0 then
			local var_19_12 = arg_18_0.documentImage

			Vector2 = var_19_6
			var_19_12.anchoredPosition = var_19_6(0, -50 - var_19_7)
		end

		local var_19_13 = var_19_4 + var_0_1.getTextPreferredHeight(var_18_7, var_18_0, var_18_8)
		local var_19_14 = arg_18_0.documentContentTF.sizeDelta

		var_19_14.y = var_19_13
		arg_18_0.documentContentTF.sizeDelta = var_19_14

		local var_19_15 = arg_18_0.document
		local var_19_16 = var_6.Find(var_19_15, "Viewport")
		local var_19_17 = arg_18_0.document
		local var_19_18 = var_7.Find(var_19_17, "Arrow")
		local var_19_19 = var_19_16.rect.height

		setActive = var_9

		var_9(var_19_18, var_19_19 < var_19_13)

		local var_19_20 = arg_18_0.document
		local var_19_21 = var_9.GetComponent

		typeof = var_11
		ScrollRect = var_2_10012

		local var_19_22 = var_19_21(var_19_20, var_11(var_2_10012)).onValueChanged

		var_10.RemoveAllListeners(var_19_22)

		local var_19_23

		if not arg_18_3 then
			var_19_23 = 0
		end

		arg_18_3 = var_19_23
		math = var_19_23

		local var_19_24 = var_19_23.max(var_4 - var_19_19, 0) * arg_18_3
		local var_19_25 = arg_18_0.documentContentTF

		Vector2 = var_13
		var_19_25.anchoredPosition = var_13(0, var_19_24)
		Vector2 = var_19_25
		var_9.velocity = var_19_25.zero

		if var_19_19 < var_19_13 then
			onScroll = var_12

			var_12(arg_18_0, arg_18_0.document, function(arg_20_0)
				setActive = var_3_10001

				var_3_10001(var_19_18, arg_20_0.y > 0.01)

				return
			end)
		end

		return
	end

	if not var_5 then
		var_18_7.text = arg_18_1

		var_18_9()

		return
	end

	local var_18_10, var_18_11 = arg_18_0.SplitRichAndLetters(arg_18_1)
	local var_18_12 = 1
	local var_18_13 = 1

	local function var_18_14(arg_21_0)
		local var_21_0 = ""
		local var_21_1 = ""
		local var_21_2 = {}

		for iter_21_0 = arg_21_0 and 1 or var_18_13, #var_18_11 do
			if var_18_11[iter_21_0].start > var_18_10[var_18_12].start then
				break
			end

			local var_21_3 = var_18_11[iter_21_0]

			if iter_21_0 == var_18_13 then
				var_18_13 = var_18_13 + 1
				var_21_0 = var_21_0 .. var_21_3.value
			end

			if arg_21_0 then
				if var_21_3.EndTagIndex then
					var_21_2[#var_21_2 + 1] = var_21_3.EndTagIndex
				else
					table = var_10

					var_10.remove(var_21_2)
				end
			end
		end

		local var_21_4 = ""

		if var_18_12 <= #var_18_10 then
			var_21_4 = var_18_10[var_18_12].value
		end

		ipairs = var_6

		for iter_21_1, iter_21_2 in var_6(var_21_2) do
			var_21_1 = var_18_11[iter_21_2].value .. var_21_1
		end

		var_18_12 = var_18_12 + 1

		return var_21_4, var_21_0, var_21_1
	end

	local var_18_15 = 0

	while var_18_15 < var_18_4 and var_18_12 < #var_18_10 do
		local var_18_16, var_18_17, var_18_18 = var_18_14(true)

		var_18_7.text = var_18_8 .. var_18_17 .. var_18_16 .. var_18_18

		local var_18_19

		if var_18_2 < var_18_7.preferredWidth then
			var_18_19 = var_18_8 .. "\n" .. var_18_17 .. var_18_16
		else
			var_18_19 = var_18_8 .. var_18_17 .. var_18_16
		end

		var_18_7.text = var_18_19
		var_18_15 = var_0_1.getTextPreferredHeight(var_18_7, var_18_7.preferredWidth, var_18_8)
	end

	for iter_18_0 = var_18_12, #var_18_10 do
		local var_18_20, var_18_21 = var_18_14(false)

		var_18_8 = var_18_8 .. var_18_21 .. var_18_20
	end

	local var_18_22, var_18_23, var_18_24 = var_18_14(true)

	var_18_7.text = var_18_8 .. var_18_24

	var_18_9()

	return
end

function var_0_1.SplitRichAndLetters(arg_22_0)
	local var_22_0 = 1
	local var_22_1 = "<([^>]*)>"
	local var_22_2 = {}
	local var_22_3 = {}

	while true do
		string = var_1_10005

		local var_22_4

		var_1_10005, var_22_4 = var_1_10005.find(arg_22_0, var_22_1, var_22_0)

		if not var_22_4 then
			break
		end

		string = var_7

		local var_22_5 = var_7.sub(arg_22_0, var_1_10005, var_22_4)

		string = var_1_10008
		var_1_10008 = var_1_10008.find(var_22_5, "=")
		string = var_9

		if not var_9.find(var_22_5, "/") and not var_1_10008 then
			var_22_0 = var_22_4 + 1
		else
			table = var_10

			var_10.insert(var_22_2, {
				value = var_22_5,
				start = var_1_10005
			})

			if var_1_10008 then
				var_22_3[#var_22_3 + 1] = #var_22_2
			elseif var_9 and #var_22_3 > 0 then
				table = var_10
				var_22_2[var_10.remove(var_22_3)].EndTagIndex = #var_22_2
			end

			string = var_10

			local var_22_6 = var_10.sub(arg_22_0, var_22_4 + 1, -1)

			string = var_11
			arg_22_0 = var_11.sub(arg_22_0, 1, var_1_10005 - 1) .. var_22_6
			var_22_0 = var_1_10005
		end
	end

	local var_22_7 = {}
	local var_22_8 = 1
	local var_22_9 = false
	local var_22_10 = 1

	while true do
		string = var_1_10008

		local var_22_11

		var_1_10008, var_22_11 = var_1_10008.find(arg_22_0, "[\x01-\x7F�-�][�-�]*", var_22_8)

		local var_22_12

		if not var_22_11 then
			var_22_12 = #var_22_7 + 1

			local var_22_13 = {}

			string = var_1_10012
			var_22_13.value = var_1_10012.sub(arg_22_0, var_22_10, #arg_22_0)
			var_22_13.start = var_22_10
			var_22_7[var_22_12] = var_22_13

			break
		end

		string = var_22_12

		local var_22_14 = var_22_12.sub(arg_22_0, var_1_10008, var_22_11)
		local var_22_15 = false

		PLATFORM_CODE = var_1_10012
		PLATFORM_US = var_13

		if var_1_10012 == var_13 then
			var_1_10012 = var_22_14 == " " or var_22_14 == " "

			if var_22_9 ~= var_1_10012 then
				var_22_15 = var_1_10008 > 1
			end

			var_22_9 = var_1_10012
		else
			var_22_15 = 1 < var_1_10008
		end

		if var_22_15 then
			var_1_10012 = #var_22_7 + 1

			local var_22_16 = {}

			string = var_1_10014
			var_22_16.value = var_1_10014.sub(arg_22_0, var_22_10, var_1_10008 - 1)
			var_22_16.start = var_22_10
			var_22_7[var_1_10012] = var_22_16
			var_22_10 = var_1_10008
		end

		var_22_8 = var_22_11 + 1
	end

	return var_22_7, var_22_2
end

return var_0_1
