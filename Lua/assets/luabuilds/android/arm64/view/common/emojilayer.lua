local var_0_0 = class("EmojiLayer", import("..base.BaseUI"))

var_0_0.PageEmojiNums = 8
var_0_0.Frequently_Used_Emoji_Num = 6
var_0_0.True_Emoji_Num_Of_Page = 15

function var_0_0.getUIName(arg_1_0)
	return "EmojiUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.emojiGroup = arg_2_0._tf:Find("frame/group")
	arg_2_0.emojiType = arg_2_0.emojiGroup:Find("type")
	arg_2_0.emojiEvent = arg_2_0._tf:Find("frame/bg/mask/event")
	arg_2_0.emojiSnap = arg_2_0._tf:Find("frame/bg/mask/event"):GetComponent("HScrollSnap")

	arg_2_0.emojiSnap:Init()

	arg_2_0.emojiContent = tf(arg_2_0.emojiSnap):Find("content")
	arg_2_0.emojiItem = tf(arg_2_0.emojiSnap):Find("item")
	arg_2_0.emojiDots = arg_2_0._tf:Find("frame/dots")
	arg_2_0.emojiIconDots = arg_2_0._tf:Find("frame/emojiDots")
	arg_2_0.emojiDot = tf(arg_2_0.emojiSnap):Find("dot")

	setText(arg_2_0.emojiEvent:Find("null_tpl/Text"), i18n("recently_sticker_placeholder"))
	setActive(arg_2_0.emojiItem, false)
	setActive(arg_2_0.emojiDot, false)

	arg_2_0.emojiIconEvent = arg_2_0._tf:Find("frame/bg/mask/emojiicon_event")
	arg_2_0.emojiIconSnap = arg_2_0._tf:Find("frame/bg/mask/emojiicon_event"):GetComponent("HScrollSnap")

	arg_2_0.emojiIconSnap:Init()

	arg_2_0.emojiIconContent = tf(arg_2_0.emojiIconSnap):Find("content")
	arg_2_0.emojiIconItem = tf(arg_2_0.emojiIconSnap):Find("item_emojiicon")

	setActive(arg_2_0.emojiIconItem, false)

	arg_2_0.parentTr = arg_2_0._tf.parent
	arg_2_0.resource = arg_2_0._tf:Find("frame/resource")
	arg_2_0.frame = arg_2_0._tf:Find("frame")
	arg_2_0.frame.position = arg_2_0.contextData.pos or Vector3(0, 0, 0)
	arg_2_0.frame.localPosition = Vector3(arg_2_0.frame.localPosition.x, arg_2_0.frame.localPosition.y, 0)
	arg_2_0.newTag = arg_2_0._tf:Find("newtag")
	arg_2_0.emojiProxy = getProxy(EmojiProxy)

	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:emit(var_0_0.ON_CLOSE)

		return
	end, SFX_CANCEL)
	arg_3_0:display()
	arg_3_0:OverlayPanel(arg_3_0._tf)

	return
end

function var_0_0.display(arg_5_0)
	local var_5_0 = UIItemList.New(arg_5_0.emojiGroup, arg_5_0.emojiType)

	var_5_0:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			local var_6_0 = ChatConst.EmojiTypes[arg_6_1 + 1]

			arg_5_0:SetTagText(arg_6_2, ChatConst.EmojiTypes[arg_6_1 + 1])

			if arg_5_0.emojiProxy:fliteNewEmojiDataByType()[ChatConst.EmojiTypes[arg_6_1 + 1]] then
				setActive(arg_6_2:Find("point"), true)
			else
				setActive(arg_6_2:Find("point"), false)
			end

			onToggle(arg_5_0, arg_6_2, function(arg_7_0)
				if arg_7_0 then
					setActive(arg_5_0.emojiDots, var_6_0 ~= ChatConst.EmojiIcon)
					setActive(arg_5_0.emojiIconDots, var_6_0 == ChatConst.EmojiIcon)
					setActive(arg_5_0.emojiEvent, var_6_0 ~= ChatConst.EmojiIcon)
					setActive(arg_5_0.emojiIconEvent, var_6_0 == ChatConst.EmojiIcon)

					if var_6_0 ~= ChatConst.EmojiIcon then
						arg_5_0:filter(var_6_0)
					elseif var_6_0 == ChatConst.EmojiIcon then
						arg_5_0:emojiIconFliter()
					end

					var_5_0:align(#ChatConst.EmojiTypes)
				end

				return
			end, SFX_PANEL)
		end

		return
	end)
	var_5_0:align(#ChatConst.EmojiTypes)
	triggerToggle(arg_5_0.emojiGroup:GetChild(0), true)

	return
end

function var_0_0.SetTagText(arg_8_0, arg_8_1, arg_8_2)
	setText(arg_8_1:Find("Text"), i18n("emoji_type_" .. arg_8_2))

	return
end

function var_0_0.filter(arg_9_0, arg_9_1)
	local var_9_0 = _.map(pg.emoji_template.all, function(arg_10_0)
		if pg.emoji_template[arg_10_0].achieve == 0 then
			return pg.emoji_template[arg_10_0]
		end

		return
	end)
	local var_9_1 = arg_9_0.emojiProxy:getNewEmojiIDLIst()
	local var_9_2 = arg_9_0.emojiProxy:fliteNewEmojiDataByType()

	for iter_9_0, iter_9_1 in pairs((arg_9_0.emojiProxy:getExEmojiDataByType(arg_9_1))) do
		table.insert(var_9_0, 1, iter_9_1)
	end

	table.sort(var_9_0, function(arg_11_0, arg_11_1)
		if arg_11_0.index == arg_11_1.index then
			return arg_11_0.id < arg_11_1.id
		end

		return arg_11_0.index < arg_11_1.index
	end)

	if arg_9_1 == ChatConst.EmojiCommon then
		for iter_9_2, iter_9_3 in pairs((getProxy(ChatProxy):getUsedEmoji())) do
			table.insert({}, {
				id = iter_9_2,
				count = iter_9_3
			})
		end

		table.sort({}, function(arg_12_0, arg_12_1)
			if arg_12_0.count == arg_12_1.count then
				return arg_12_0.id < arg_12_1.id
			end

			return arg_12_0.count > arg_12_1.count
		end)

		var_9_0 = _.map({}, function(arg_13_0)
			return pg.emoji_template[arg_13_0.id]
		end)
	else
		var_9_0 = _.filter(var_9_0, function(arg_14_0)
			return table.contains(arg_14_0.type, arg_9_1)
		end)
	end

	if var_9_2[arg_9_1] then
		for iter_9_4, iter_9_5 in pairs(var_9_2[arg_9_1]) do
			table.insert(var_9_0, 1, iter_9_5)
		end
	end

	arg_9_0.tplCaches = arg_9_0.tplCaches or {}

	local var_9_3 = math.ceil(#var_9_0 / var_0_0.PageEmojiNums)

	setActive(arg_9_0.emojiEvent:Find("null_tpl"), var_9_3 == 0)

	for iter_9_6 = arg_9_0.emojiContent.childCount - 1, var_9_3, -1 do
		Destroy(arg_9_0.emojiDots:GetChild(iter_9_6))

		local var_9_4 = arg_9_0.emojiSnap:RemoveChild(iter_9_6)

		var_9_4.transform.localScale = Vector3.one

		var_9_4.transform:SetParent(arg_9_0._tf, false)
		setActive(var_9_4, false)
		arg_9_0:clearItem(var_9_4)
		table.insert(arg_9_0.tplCaches, var_9_4)
	end

	for iter_9_7 = arg_9_0.emojiContent.childCount + 1, var_9_3 do
		local var_9_5 = #arg_9_0.tplCaches > 0 and table.remove(arg_9_0.tplCaches) or Instantiate(arg_9_0.emojiItem)

		setActive(var_9_5, true)
		arg_9_0.emojiSnap:AddChild(var_9_5)
		cloneTplTo(arg_9_0.emojiDot, arg_9_0.emojiDots)
	end

	if var_9_3 > 1 then
		arg_9_0.emojiSnap:GoToScreen(0)
	end

	for iter_9_8 = 0, arg_9_0.emojiContent.childCount - 1 do
		local var_9_6 = arg_9_0.emojiContent:GetChild(iter_9_8)

		arg_9_0:clearItem(var_9_6)

		local var_9_7 = _.slice(var_9_0, iter_9_8 * var_0_0.PageEmojiNums + 1, var_0_0.PageEmojiNums)
		local var_9_8 = GetComponent(var_9_6, typeof(GridLayoutGroup))
		local var_9_9 = UIItemList.New(var_9_6, var_9_6:Find("face"))

		var_9_9:make(function(arg_15_0, arg_15_1, arg_15_2)
			local var_15_0 = var_9_7[arg_15_1 + 1]

			if arg_15_0 == UIItemList.EventUpdate then
				PoolMgr.GetInstance():GetPrefab("emoji/" .. var_9_7[arg_15_1 + 1].pic, var_9_7[arg_15_1 + 1].pic, true, function(arg_16_0)
					if not IsNil(arg_15_2) then
						arg_16_0.name = var_15_0.pic

						local var_16_0 = arg_16_0:GetComponent(typeof(Image))

						if var_16_0 then
							var_16_0.preserveAspect = true
						end

						tf(arg_16_0).sizeDelta = Vector2(var_9_8.cellSize.x, var_9_8.cellSize.y)
						tf(arg_16_0).anchoredPosition = Vector2.zero

						local var_16_1 = arg_16_0:GetComponent("Animator")

						if var_16_1 then
							var_16_1.enabled = false
						end

						local var_16_2 = arg_16_0:GetComponent("CriManaEffectUI")

						if var_16_2 then
							var_16_2:Pause(true)
						end

						setParent(arg_16_0, arg_15_2, false)

						if table.contains(var_9_1, var_15_0.id) then
							cloneTplTo(arg_9_0.newTag, arg_15_2, "newtag")
							arg_9_0.emojiProxy:removeNewEmojiID(var_15_0.id)
						end
					else
						PoolMgr.GetInstance():ReturnPrefab("emoji/" .. var_15_0.pic, var_15_0.pic, arg_16_0)
					end

					return
				end)
				onButton(arg_9_0, arg_15_2, function()
					getProxy(ChatProxy):addUsedEmoji(var_15_0.id)
					arg_9_0.contextData.callback(var_15_0.id)
					triggerButton(arg_9_0._tf)

					return
				end, SFX_PANEL)
			end

			return
		end)
		var_9_9:align(#var_9_7)
	end

	return
end

function var_0_0.emojiIconFliter(arg_18_0)
	local var_18_0 = _.map(pg.emoji_small_template.all, function(arg_19_0)
		return pg.emoji_small_template[arg_19_0]
	end)
	local var_18_1 = {}

	for iter_18_0, iter_18_1 in ipairs((getProxy(ChatProxy):getUsedEmojiIcon())) do
		table.insert({}, var_18_0[iter_18_1])
	end

	local var_18_2 = math.min(9, #var_18_0)
	local var_18_3 = 1 + math.ceil((#var_18_0 - var_18_2) / var_0_0.True_Emoji_Num_Of_Page)

	for iter_18_2 = arg_18_0.emojiIconContent.childCount + 1, var_18_3 do
		cloneTplTo(arg_18_0.emojiDot, arg_18_0.emojiIconDots)
	end

	for iter_18_3 = arg_18_0.emojiIconContent.childCount + 1, var_18_3 do
		local var_18_4 = Instantiate(arg_18_0.emojiIconItem)
		local var_18_5 = tf(var_18_4)
		local var_18_6 = var_18_5:Find("TitleCommom")
		local var_18_7 = var_18_5:Find("TitleAll")
		local var_18_8 = var_18_5:Find("CommomIconContainer")
		local var_18_9 = var_18_5:Find("AllIconContainer")
		local var_18_10 = GetComponent(var_18_9, "GridLayoutGroup")

		if iter_18_3 == 1 then
			local var_18_11 = UIItemList.New(var_18_8, (var_18_8:Find("Icon")))

			var_18_11:make(function(arg_20_0, arg_20_1, arg_20_2)
				local var_20_0 = var_18_1[arg_20_1 + 1]

				if arg_20_0 == UIItemList.EventUpdate then
					PoolMgr.GetInstance():GetPrefab("emoji/" .. var_18_1[arg_20_1 + 1].pic, var_18_1[arg_20_1 + 1].pic, true, function(arg_21_0)
						if not IsNil(arg_20_2) then
							arg_21_0.name = var_20_0.pic

							setParent(arg_21_0, arg_20_2, false)
							onButton(arg_18_0, arg_21_0, function()
								if arg_18_0.contextData.emojiIconCallback then
									getProxy(ChatProxy):addUsedEmojiIcon(var_20_0.id)
									arg_18_0.contextData.emojiIconCallback(var_20_0.id)
								end

								return
							end, SFX_PANEL)
						end

						return
					end)
				end

				return
			end)
			var_18_11:align(#{})

			var_18_10.padding.left = 20

			local var_18_12 = UIItemList.New(var_18_9, (var_18_9:Find("Icon")))

			var_18_12:make(function(arg_23_0, arg_23_1, arg_23_2)
				local var_23_0 = var_18_0[arg_23_1 + 1]

				if arg_23_0 == UIItemList.EventUpdate then
					PoolMgr.GetInstance():GetPrefab("emoji/" .. var_18_0[arg_23_1 + 1].pic, var_18_0[arg_23_1 + 1].pic, true, function(arg_24_0)
						if not IsNil(arg_23_2) then
							arg_24_0.name = var_23_0.pic

							setParent(arg_24_0, arg_23_2, false)
							onButton(arg_18_0, arg_24_0, function()
								if arg_18_0.contextData.emojiIconCallback then
									getProxy(ChatProxy):addUsedEmojiIcon(var_23_0.id)
									arg_18_0.contextData.emojiIconCallback(var_23_0.id)
								end

								return
							end, SFX_PANEL)
						end

						return
					end)
				end

				return
			end)
			var_18_12:align(var_18_2)
		else
			local var_18_14 = _.slice(var_18_0, (iter_18_3 - 2) * var_0_0.True_Emoji_Num_Of_Page + var_18_2 + 1, var_0_0.True_Emoji_Num_Of_Page)

			var_18_10.padding.left = 60

			local var_18_15 = UIItemList.New(var_18_9, (var_18_9:Find("Icon")))

			var_18_15:make(function(arg_26_0, arg_26_1, arg_26_2)
				local var_26_0 = var_18_14[arg_26_1 + 1]

				if arg_26_0 == UIItemList.EventUpdate then
					PoolMgr.GetInstance():GetPrefab("emoji/" .. var_18_14[arg_26_1 + 1].pic, var_18_14[arg_26_1 + 1].pic, true, function(arg_27_0)
						if not IsNil(arg_26_2) then
							arg_27_0.name = var_26_0.pic

							setParent(arg_27_0, arg_26_2, false)
							onButton(arg_18_0, arg_27_0, function()
								if arg_18_0.contextData.emojiIconCallback then
									getProxy(ChatProxy):addUsedEmojiIcon(var_26_0.id)
									arg_18_0.contextData.emojiIconCallback(var_26_0.id)
								end

								return
							end, SFX_PANEL)
						end

						return
					end)
				end

				return
			end)
			var_18_15:align(#var_18_14)
		end

		setActive(var_18_6, iter_18_3 == 1)
		setActive(var_18_7, iter_18_3 == 1)
		setActive(var_18_8, iter_18_3 == 1)
		setActive(var_18_4, true)
		arg_18_0.emojiIconSnap:AddChild(var_18_4)
	end

	return
end

function var_0_0.onBackPressed(arg_29_0)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
	triggerButton(arg_29_0._tf)

	return
end

function var_0_0.clearItem(arg_30_0, arg_30_1)
	eachChild(arg_30_1, function(arg_31_0)
		if arg_31_0.childCount > 0 then
			local var_31_0 = arg_31_0:Find("newtag")

			if var_31_0 then
				Destroy(var_31_0)
			end

			local var_31_1 = arg_31_0:GetChild(0).gameObject

			PoolMgr.GetInstance():ReturnPrefab("emoji/" .. var_31_1.name, var_31_1.name, var_31_1)
		end

		return
	end)

	return
end

function var_0_0.willExit(arg_32_0)
	eachChild(arg_32_0.emojiContent, function(arg_33_0)
		arg_32_0:clearItem(arg_33_0)

		return
	end)
	_.each(arg_32_0.tplCaches, function(arg_34_0)
		arg_32_0:clearItem(arg_34_0)

		return
	end)

	arg_32_0.tplCaches = {}

	arg_32_0:UnOverlayPanel(arg_32_0._tf)

	return
end

return var_0_0
