local var_0_0 = class("WorldMediaCollectionFileDetailLayer", import(".WorldMediaCollectionSubLayer"))

function var_0_0.getUIName(arg_1_0)
	return "WorldMediaCollectionFileDetailUI"
end

function var_0_0.OnInit(arg_2_0)
	assert(arg_2_0.viewParent, "Need assign ViewParent for " .. arg_2_0.__cname)
	onButton(arg_2_0, arg_2_0._tf:Find("Buttom"), function()
		arg_2_0.viewParent:Backward()

		return
	end)

	arg_2_0.anim = arg_2_0._tf:GetComponent(typeof(Animation))
	arg_2_0.canvasGroup = arg_2_0._tf:GetComponent(typeof(CanvasGroup))

	arg_2_0:InitDocument()

	local var_2_0 = arg_2_0._tf:Find("ArchiveList")

	arg_2_0.scrollComp = var_2_0:GetComponent("LScrollRect")
	arg_2_0.fileChild = {}
	arg_2_0.fileChildIndex = {}

	function arg_2_0.scrollComp.onUpdateItem(arg_4_0, ...)
		arg_2_0:OnUpdateFile(arg_4_0 + 1, ...)

		return
	end

	setActive(var_2_0:Find("Item"), false)

	arg_2_0.loader = AutoLoader.New()

	setText(arg_2_0._tf:Find("ArchiveList/ProgressDesc"), i18n("world_collection_1"))

	return
end

function var_0_0.InitDocument(arg_5_0)
	arg_5_0.document = arg_5_0._tf:Find("Document")
	arg_5_0.documentContentTF = arg_5_0.document:Find("Viewport/Content")
	arg_5_0.documentHead = arg_5_0.documentContentTF:Find("Head")
	arg_5_0.documentBody = arg_5_0.documentContentTF:Find("Body")
	arg_5_0.documentTitle = arg_5_0.documentHead:Find("Title")
	arg_5_0.documentRect = arg_5_0.documentBody:Find("Rect")
	arg_5_0.documentTip = arg_5_0.documentRect:Find("SubTitle")
	arg_5_0.documentText = arg_5_0.documentRect:Find("Text")
	arg_5_0.documentImage = arg_5_0.documentRect:Find("Image")
	arg_5_0.documentStamp = arg_5_0.documentImage:Find("ClassifiedStamp")

	return
end

function var_0_0.Openning(arg_6_0)
	arg_6_0.anim:Play("Enter")
	arg_6_0:Enter()

	return
end

function var_0_0.Enter(arg_7_0)
	local var_7_0 = arg_7_0.contextData.SelectedFile or (function()
		local var_8_0 = nowWorld():GetCollectionProxy()

		for iter_8_0, iter_8_1 in ipairs(WorldCollectionProxy.GetCollectionFileGroupTemplate(arg_7_0.contextData.FileGroupIndex).child) do
			if var_8_0:IsUnlock(iter_8_1) then
				return iter_8_0
			end
		end

		return
	end)()

	arg_7_0.contextData.SelectedFile = nil

	arg_7_0:UpdateView()
	arg_7_0:SwitchFileIndex(var_7_0)

	return
end

function var_0_0.Hide(arg_9_0)
	arg_9_0.canvasGroup.alpha = 1

	var_0_0.super.Hide(arg_9_0)

	return
end

function var_0_0.UpdateView(arg_10_0)
	assert(arg_10_0.contextData.FileGroupIndex, "Not Initialize FileGroupIndex")

	arg_10_0.archiveList = _.map(WorldCollectionProxy.GetCollectionFileGroupTemplate(arg_10_0.contextData.FileGroupIndex).child, function(arg_11_0)
		return WorldCollectionProxy.GetCollectionTemplate(arg_11_0)
	end)

	local var_10_0 = nowWorld():GetCollectionProxy()
	local var_10_1 = WorldCollectionProxy.GetCollectionFileGroupTemplate(arg_10_0.contextData.FileGroupIndex)
	local var_10_2 = 0

	for iter_10_0, iter_10_1 in ipairs(var_10_1.child) do
		if var_10_0:IsUnlock(iter_10_1) then
			var_10_2 = var_10_2 + 1
		end
	end

	setText(arg_10_0._tf:Find("ArchiveList/ProgressDesc/ProgressText"), var_10_2 .. "/" .. #var_10_1.child)
	arg_10_0.scrollComp:SetTotalCount(#arg_10_0.archiveList)

	return
end

local function var_0_1(arg_12_0)
	return (string.char(226, 133, 160 + (arg_12_0 - 1)))
end

function var_0_0.OnUpdateFile(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_0.exited then
		return
	end

	local var_13_0 = arg_13_0.archiveList[arg_13_1]

	if arg_13_0.fileChildIndex[arg_13_2] and arg_13_0.fileChildIndex[arg_13_2] ~= arg_13_1 then
		arg_13_0.fileChild[arg_13_0.fileChildIndex[arg_13_2]] = nil
	end

	arg_13_0.fileChildIndex[arg_13_2] = arg_13_1
	arg_13_0.fileChild[arg_13_1] = arg_13_2

	local var_13_1 = tf(arg_13_2)
	local var_13_2 = WorldCollectionProxy.GetCollectionFileGroupTemplate(arg_13_0.contextData.FileGroupIndex)
	local var_13_3 = nowWorld():GetCollectionProxy():IsUnlock(var_13_0.id)

	setActive(var_13_1:Find("Selected"), arg_13_1 == arg_13_0.contextData.SelectedFile)

	local var_13_8 = var_13_2.name
	local var_13_9, var_13_10, var_13_11

	if not var_13_2.name then
		var_13_8 = ""
		var_13_9 = setText
		var_13_10 = var_13_1:Find("Desc")
		var_13_11 = setColorStr
	end

	var_13_9(var_13_10, var_13_11(var_13_5(var_13_6, var_13_7(var_13_8, 6), var_0_1(var_13_0.group_ID)), var_13_4 and "#000" or COLOR_WHITE))
	setActive(var_13_1:Find("Desc"), var_13_3)
	setActive(var_13_1:Find("Icon"), var_13_3)
	setActive(var_13_1:Find("Cover"), var_13_3)
	setActive(var_13_1:Find("Locked"), not var_13_3)
	arg_13_0.loader:GetSprite("ui/WorldMediaCollectionFileDetailUI_atlas", "cover" .. var_13_2.type, var_13_1:Find("Cover"))
	onButton(arg_13_0, var_13_1, function()
		if not nowWorld():GetCollectionProxy():IsUnlock(var_13_0.id) then
			return
		end

		arg_13_0:SwitchFileIndex(arg_13_1)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.SwitchFileIndex(arg_15_0, arg_15_1)
	if arg_15_0.contextData.SelectedFile and arg_15_0.contextData.SelectedFile == arg_15_1 then
		return
	end

	local var_15_0 = arg_15_1 and arg_15_0.archiveList[arg_15_1]
	local var_15_1 = arg_15_1 and arg_15_0.archiveList[arg_15_1] and nowWorld():GetCollectionProxy():IsUnlock(var_15_0.id)

	if var_15_1 then
		arg_15_0.contextData.SelectedFile = arg_15_1

		if arg_15_0.fileChild[arg_15_0.contextData.SelectedFile] then
			arg_15_0:OnUpdateFile(arg_15_0.contextData.SelectedFile, arg_15_0.fileChild[arg_15_0.contextData.SelectedFile])
		end

		if arg_15_0.fileChild[arg_15_1] then
			arg_15_0:OnUpdateFile(arg_15_1, arg_15_0.fileChild[arg_15_1])
		end

		setActive(arg_15_0.document, true)
		setText(arg_15_0.document:Find("Head/Title"), var_15_0.name)
		arg_15_0:SetDocument(var_15_0)
	else
		setActive(arg_15_0.document, false)
	end

	return
end

function var_0_0.SetDocument(arg_16_0, arg_16_1, arg_16_2)
	setText(arg_16_0.documentTitle, arg_16_1.name)

	if arg_16_1.pic and #arg_16_1.pic > 0 then
		local var_16_0 = LoadSprite("CollectionFileIllustration/" .. arg_16_1.pic, "")

		setImageSprite(arg_16_0.documentImage, var_16_0, true)
		setActive(arg_16_0.documentImage, var_16_0)

		if var_16_0 then
			setActive(arg_16_0.documentStamp, arg_16_1.is_classified == 1)

			if arg_16_1.is_classified == 1 then
				arg_16_0.loader:GetSprite("ui/WorldMediaCollectionFileDetailUI_atlas", "stamp" .. WorldCollectionProxy.GetCollectionFileGroupTemplate((WorldCollectionProxy.GetCollectionGroup(arg_16_1.id))).type, arg_16_0.documentStamp)
			end
		end
	else
		setActive(arg_16_0.documentImage, false)
	end

	arg_16_0:SetDocumentText(arg_16_1.content, arg_16_1.subTitle, arg_16_2)

	return
end

function var_0_0.getTextPreferredHeight(arg_17_0, arg_17_1, arg_17_2)
	return ReflectionHelp.RefCallMethod(typeof("UnityEngine.TextGenerator"), "GetPreferredHeight", arg_17_0.cachedTextGeneratorForLayout, {
		typeof("System.String"),
		typeof("UnityEngine.TextGenerationSettings")
	}, {
		arg_17_2,
		(arg_17_0:GetGenerationSettings(Vector2(arg_17_1, 0)))
	}) / arg_17_0.pixelsPerUnit
end

function var_0_0.SetDocumentText(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_0.documentRect.rect.width
	local var_18_1 = isActive(arg_18_0.documentImage)

	if var_18_1 then
		local var_18_2 = arg_18_0.documentImage.rect.width or 0
		local var_18_3 = math.max(var_18_0 - var_18_2, 0)

		if var_18_1 then
			local var_18_4 = arg_18_0.documentImage.rect.height + 100 or 0
			local var_18_5 = arg_18_0.documentText:GetComponent(typeof(Text))

			var_18_5.text = ""

			local var_18_6 = ""

			if not var_18_1 then
				var_18_6 = arg_18_1
				var_18_5.text = arg_18_1

				;(function()
					local var_19_0 = 0

					if isActive(arg_18_0.documentHead) then
						var_19_0 = var_19_0 + arg_18_0.documentHead:GetComponent(typeof(LayoutElement)).preferredHeight
					end

					local var_19_1 = arg_18_0.documentBody:GetComponent("LayoutGroup")
					local var_19_2 = var_19_0 + (var_19_1.padding.top + var_19_1.padding.bottom)
					local var_19_3 = arg_18_2 and #arg_18_2 > 0

					setActive(arg_18_0.documentTip, var_19_3)

					local var_19_4 = 0

					if arg_18_2 and #arg_18_2 > 0 then
						local var_19_5 = arg_18_0.documentTip:Find("Text"):GetComponent(typeof(Text))

						var_19_5.text = arg_18_2
						var_19_4 = var_0_0.getTextPreferredHeight(var_19_5, var_18_0, arg_18_2)
						var_19_4 = var_19_4 + arg_18_0.documentRect:GetComponent(typeof(VerticalLayoutGroup)).spacing
						var_19_2 = var_19_2 + var_19_4
					end

					if var_18_1 then
						arg_18_0.documentImage.anchoredPosition = Vector2(0, -50 - var_19_4)
					end

					local var_19_6 = var_0_0.getTextPreferredHeight(var_18_5, var_18_0, var_18_6)
					local var_19_7 = var_19_2 + var_19_6

					arg_18_0.documentContentTF.sizeDelta.y = var_19_2 + var_19_6
					arg_18_0.documentContentTF.sizeDelta = arg_18_0.documentContentTF.sizeDelta

					local var_19_8 = arg_18_0.document:Find("Viewport").rect.height

					setActive(arg_18_0.document:Find("Arrow"), var_19_8 < var_19_7)

					local var_19_9 = arg_18_0.document:GetComponent(typeof(ScrollRect))

					var_19_9.onValueChanged:RemoveAllListeners()

					arg_18_3 = arg_18_3 or 0
					arg_18_0.documentContentTF.anchoredPosition = Vector2(0, math.max(var_19_6 - var_19_8, 0) * arg_18_3)
					var_19_9.velocity = Vector2.zero

					if var_19_8 < var_19_7 then
						onScroll(arg_18_0, arg_18_0.document, function(arg_20_0)
							setActive(var_0, arg_20_0.y > 0.01)

							return
						end)
					end

					return
				end)()

				return
			end

			local var_18_7, var_18_8 = arg_18_0.SplitRichAndLetters(arg_18_1)
			local var_18_9 = 1
			local var_18_10 = 1

			while 0 < var_18_4 and 1 < #var_18_7 do
				local var_18_11, var_18_12, var_18_13 = (function(arg_21_0)
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
				end)(true)
				local var_18_14 = var_18_6 .. var_18_12 .. var_18_11 .. var_18_13

				var_18_5.text = var_18_6 .. var_18_12 .. var_18_11 .. var_18_13
				var_18_14 = var_18_3 < var_18_5.preferredWidth and var_18_6 .. "\n" .. var_18_12 .. var_18_11 or var_18_6 .. var_18_12 .. var_18_11
				var_18_6 = var_18_14
				var_18_5.text = var_18_14

				local var_18_15 = var_0_0.getTextPreferredHeight(var_18_5, var_18_5.preferredWidth, var_18_6)
			end

			for iter_18_0 = 1, #var_18_7 do
				local var_18_16, var_18_17 = (function(arg_21_0)
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
				end)(false)

				var_18_6 = var_18_6 .. var_18_17 .. var_18_16
			end

			local var_18_18, var_18_19, var_18_20 = (function(arg_21_0)
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
			end)(true)

			var_18_6 = var_18_6 .. var_18_20
			var_18_5.text = var_18_6

			;(function()
				local var_19_0 = 0

				if isActive(arg_18_0.documentHead) then
					var_19_0 = var_19_0 + arg_18_0.documentHead:GetComponent(typeof(LayoutElement)).preferredHeight
				end

				local var_19_1 = arg_18_0.documentBody:GetComponent("LayoutGroup")
				local var_19_2 = var_19_0 + (var_19_1.padding.top + var_19_1.padding.bottom)
				local var_19_3 = arg_18_2 and #arg_18_2 > 0

				setActive(arg_18_0.documentTip, var_19_3)

				local var_19_4 = 0

				if arg_18_2 and #arg_18_2 > 0 then
					local var_19_5 = arg_18_0.documentTip:Find("Text"):GetComponent(typeof(Text))

					var_19_5.text = arg_18_2
					var_19_4 = var_0_0.getTextPreferredHeight(var_19_5, var_18_0, arg_18_2)
					var_19_4 = var_19_4 + arg_18_0.documentRect:GetComponent(typeof(VerticalLayoutGroup)).spacing
					var_19_2 = var_19_2 + var_19_4
				end

				if var_18_1 then
					arg_18_0.documentImage.anchoredPosition = Vector2(0, -50 - var_19_4)
				end

				local var_19_6 = var_0_0.getTextPreferredHeight(var_18_5, var_18_0, var_18_6)
				local var_19_7 = var_19_2 + var_19_6

				arg_18_0.documentContentTF.sizeDelta.y = var_19_2 + var_19_6
				arg_18_0.documentContentTF.sizeDelta = arg_18_0.documentContentTF.sizeDelta

				local var_19_8 = arg_18_0.document:Find("Viewport").rect.height

				setActive(arg_18_0.document:Find("Arrow"), var_19_8 < var_19_7)

				local var_19_9 = arg_18_0.document:GetComponent(typeof(ScrollRect))

				var_19_9.onValueChanged:RemoveAllListeners()

				arg_18_3 = arg_18_3 or 0
				arg_18_0.documentContentTF.anchoredPosition = Vector2(0, math.max(var_19_6 - var_19_8, 0) * arg_18_3)
				var_19_9.velocity = Vector2.zero

				if var_19_8 < var_19_7 then
					onScroll(arg_18_0, arg_18_0.document, function(arg_20_0)
						setActive(var_0, arg_20_0.y > 0.01)

						return
					end)
				end

				return
			end)()

			return
		end
	end
end

function var_0_0.SplitRichAndLetters(arg_22_0)
	local var_22_0 = 1

	while true do
		local var_22_1, var_22_2 = string.find(arg_22_0, "<([^>]*)>", var_22_0)

		if not var_22_2 then
			break
		end

		local var_22_3 = string.sub(arg_22_0, var_22_1, var_22_2)
		local var_22_4 = string.find(var_22_3, "=")
		local var_22_5 = string.find(var_22_3, "/")

		if not var_22_5 and not var_22_4 then
			var_22_0 = var_22_2 + 1
		else
			table.insert({}, {
				value = var_22_3,
				start = var_22_1
			})

			local var_22_6

			if var_22_4 then
				({})[#{} + 1] = #{}
			elseif var_22_5 and #{} > 0 then
				({})[table.remove({})].EndTagIndex = #{}
				var_22_6 = string.sub(arg_22_0, 1, var_22_1 - 1)
			end

			arg_22_0 = var_22_6 .. string.sub(arg_22_0, var_22_2 + 1, -1)
			var_22_0 = var_22_1
		end
	end

	local var_22_7 = {}
	local var_22_8 = 1
	local var_22_9 = false
	local var_22_10 = 1

	while true do
		local var_22_11, var_22_12 = string.find(arg_22_0, "[\x01-\x7F�-�][�-�]*", var_22_8)

		if not var_22_12 then
			var_22_7[#var_22_7 + 1] = {
				value = string.sub(arg_22_0, var_22_10, #arg_22_0),
				start = var_22_10
			}

			break
		end

		local var_22_13 = string.sub(arg_22_0, var_22_11, var_22_12)
		local var_22_14 = false

		if PLATFORM_CODE == PLATFORM_US then
			local var_22_15 = var_22_13 == " " or var_22_13 == " "

			if var_22_9 ~= (var_22_13 == " " or var_22_13 == " ") then
				var_22_14 = var_22_11 > 1
			end

			var_22_9 = var_22_15
		else
			var_22_14 = var_22_11 > 1
		end

		if var_22_14 then
			var_22_7[#var_22_7 + 1] = {
				value = string.sub(arg_22_0, var_22_10, var_22_11 - 1),
				start = var_22_10
			}
			var_22_10 = var_22_11
		end

		var_22_8 = var_22_12 + 1
	end

	return var_22_7, {}
end

return var_0_0
