local EmojiLayer = class("EmojiLayer", import("..base.BaseUI"))

EmojiLayer.PageEmojiNums = 8
EmojiLayer.Frequently_Used_Emoji_Num = 6
EmojiLayer.True_Emoji_Num_Of_Page = 15

function EmojiLayer:getUIName()
	return "EmojiUI"
end

function EmojiLayer:init()
	self.emojiGroup = self._tf:Find("frame/group")
	self.emojiType = self.emojiGroup:Find("type")
	self.emojiEvent = self._tf:Find("frame/bg/mask/event")
	self.emojiSnap = self._tf:Find("frame/bg/mask/event"):GetComponent("HScrollSnap")

	self.emojiSnap:Init()

	self.emojiContent = tf(self.emojiSnap):Find("content")
	self.emojiItem = tf(self.emojiSnap):Find("item")
	self.emojiDots = self._tf:Find("frame/dots")
	self.emojiIconDots = self._tf:Find("frame/emojiDots")
	self.emojiDot = tf(self.emojiSnap):Find("dot")

	setText(self.emojiEvent:Find("null_tpl/Text"), i18n("recently_sticker_placeholder"))
	setActive(self.emojiItem, false)
	setActive(self.emojiDot, false)

	self.emojiIconEvent = self._tf:Find("frame/bg/mask/emojiicon_event")
	self.emojiIconSnap = self._tf:Find("frame/bg/mask/emojiicon_event"):GetComponent("HScrollSnap")

	self.emojiIconSnap:Init()

	self.emojiIconContent = tf(self.emojiIconSnap):Find("content")
	self.emojiIconItem = tf(self.emojiIconSnap):Find("item_emojiicon")

	setActive(self.emojiIconItem, false)

	self.parentTr = self._tf.parent
	self.resource = self._tf:Find("frame/resource")
	self.frame = self._tf:Find("frame")
	self.frame.position = self.contextData.pos or Vector3(0, 0, 0)
	self.frame.localPosition = Vector3(self.frame.localPosition.x, self.frame.localPosition.y, 0)
	self.newTag = self._tf:Find("newtag")
	self.emojiProxy = getProxy(EmojiProxy)

	return
end

function EmojiLayer:didEnter()
	onButton(self, self._tf, function()
		self:emit(EmojiLayer.ON_CLOSE)

		return
	end, SFX_CANCEL)
	self:display()
	self:OverlayPanel(self._tf)

	return
end

function EmojiLayer:display()
	local var_5_0 = UIItemList.New(self.emojiGroup, self.emojiType)

	var_5_0:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			local var_6_0 = ChatConst.EmojiTypes[arg_6_1 + 1]

			self:SetTagText(arg_6_2, ChatConst.EmojiTypes[arg_6_1 + 1])

			if self.emojiProxy:fliteNewEmojiDataByType()[ChatConst.EmojiTypes[arg_6_1 + 1]] then
				setActive(arg_6_2:Find("point"), true)
			else
				setActive(arg_6_2:Find("point"), false)
			end

			onToggle(self, arg_6_2, function(arg_7_0)
				if arg_7_0 then
					setActive(self.emojiDots, var_6_0 ~= ChatConst.EmojiIcon)
					setActive(self.emojiIconDots, var_6_0 == ChatConst.EmojiIcon)
					setActive(self.emojiEvent, var_6_0 ~= ChatConst.EmojiIcon)
					setActive(self.emojiIconEvent, var_6_0 == ChatConst.EmojiIcon)

					if var_6_0 ~= ChatConst.EmojiIcon then
						self:filter(var_6_0)
					elseif var_6_0 == ChatConst.EmojiIcon then
						self:emojiIconFliter()
					end

					var_5_0:align(#ChatConst.EmojiTypes)
				end

				return
			end, SFX_PANEL)
		end

		return
	end)
	var_5_0:align(#ChatConst.EmojiTypes)
	triggerToggle(self.emojiGroup:GetChild(0), true)

	return
end

function EmojiLayer:SetTagText(arg_8_1, arg_8_2)
	setText(arg_8_1:Find("Text"), i18n("emoji_type_" .. arg_8_2))

	return
end

function EmojiLayer:filter(arg_9_1)
	local var_9_0 = _.map(pg.emoji_template.all, function(arg_10_0)
		if pg.emoji_template[arg_10_0].achieve == 0 then
			return pg.emoji_template[arg_10_0]
		end

		return
	end)
	local var_9_1 = self.emojiProxy:getNewEmojiIDLIst()
	local var_9_2 = self.emojiProxy:fliteNewEmojiDataByType()

	for iter_9_0, iter_9_1 in pairs((self.emojiProxy:getExEmojiDataByType(arg_9_1))) do
		table.insert(var_9_0, 1, iter_9_1)
	end

	table.sort(var_9_0, function(arg_11_0, arg_11_1)
		if arg_11_0.index == arg_11_1.index then
			return arg_11_0.id < arg_11_1.id
		end

		return arg_11_0.index < arg_11_1.index
	end)

	if arg_9_1 == ChatConst.EmojiCommon then
		local var_9_3 = {}

		for iter_9_2, iter_9_3 in pairs((getProxy(ChatProxy):getUsedEmoji())) do
			table.insert(var_9_3, {
				id = iter_9_2,
				count = iter_9_3
			})
		end

		table.sort(var_9_3, function(arg_12_0, arg_12_1)
			if arg_12_0.count == arg_12_1.count then
				return arg_12_0.id < arg_12_1.id
			end

			return arg_12_0.count > arg_12_1.count
		end)

		var_9_0 = _.map(var_9_3, function(arg_13_0)
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

	self.tplCaches = self.tplCaches or {}

	local var_9_4 = math.ceil(#var_9_0 / EmojiLayer.PageEmojiNums)

	setActive(self.emojiEvent:Find("null_tpl"), var_9_4 == 0)

	for iter_9_6 = self.emojiContent.childCount - 1, var_9_4, -1 do
		Destroy(self.emojiDots:GetChild(iter_9_6))

		local var_9_5 = self.emojiSnap:RemoveChild(iter_9_6)

		var_9_5.transform.localScale = Vector3.one

		var_9_5.transform:SetParent(self._tf, false)
		setActive(var_9_5, false)
		self:clearItem(var_9_5)
		table.insert(self.tplCaches, var_9_5)
	end

	for iter_9_7 = self.emojiContent.childCount + 1, var_9_4 do
		local var_9_6 = #self.tplCaches > 0 and table.remove(self.tplCaches) or Instantiate(self.emojiItem)

		setActive(var_9_6, true)
		self.emojiSnap:AddChild(var_9_6)
		cloneTplTo(self.emojiDot, self.emojiDots)
	end

	if var_9_4 > 1 then
		self.emojiSnap:GoToScreen(0)
	end

	for iter_9_8 = 0, self.emojiContent.childCount - 1 do
		local var_9_7 = self.emojiContent:GetChild(iter_9_8)

		self:clearItem(var_9_7)

		local var_9_8 = _.slice(var_9_0, iter_9_8 * EmojiLayer.PageEmojiNums + 1, EmojiLayer.PageEmojiNums)
		local var_9_9 = GetComponent(var_9_7, typeof(GridLayoutGroup))
		local var_9_10 = UIItemList.New(var_9_7, var_9_7:Find("face"))

		var_9_10:make(function(arg_15_0, arg_15_1, arg_15_2)
			local var_15_0 = var_9_8[arg_15_1 + 1]

			if arg_15_0 == UIItemList.EventUpdate then
				PoolMgr.GetInstance():GetPrefab("emoji/" .. var_9_8[arg_15_1 + 1].pic, var_9_8[arg_15_1 + 1].pic, true, function(arg_16_0)
					if not IsNil(arg_15_2) then
						arg_16_0.name = var_15_0.pic

						local var_16_0 = arg_16_0:GetComponent(typeof(Image))

						if var_16_0 then
							var_16_0.preserveAspect = true
						end

						tf(arg_16_0).sizeDelta = Vector2(var_9_9.cellSize.x, var_9_9.cellSize.y)
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
							cloneTplTo(self.newTag, arg_15_2, "newtag")
							self.emojiProxy:removeNewEmojiID(var_15_0.id)
						end
					else
						PoolMgr.GetInstance():ReturnPrefab("emoji/" .. var_15_0.pic, var_15_0.pic, arg_16_0)
					end

					return
				end)
				onButton(self, arg_15_2, function()
					getProxy(ChatProxy):addUsedEmoji(var_15_0.id)
					self.contextData.callback(var_15_0.id)
					triggerButton(self._tf)

					return
				end, SFX_PANEL)
			end

			return
		end)
		var_9_10:align(#var_9_8)
	end

	return
end

function EmojiLayer:emojiIconFliter()
	local var_18_0 = _.map(pg.emoji_small_template.all, function(arg_19_0)
		return pg.emoji_small_template[arg_19_0]
	end)
	local var_18_1 = {}

	for iter_18_0, iter_18_1 in ipairs((getProxy(ChatProxy):getUsedEmojiIcon())) do
		table.insert(var_18_1, var_18_0[iter_18_1])
	end

	local var_18_2 = math.min(9, #var_18_0)
	local var_18_3 = 1 + math.ceil((#var_18_0 - var_18_2) / EmojiLayer.True_Emoji_Num_Of_Page)

	for iter_18_2 = self.emojiIconContent.childCount + 1, var_18_3 do
		cloneTplTo(self.emojiDot, self.emojiIconDots)
	end

	for iter_18_3 = self.emojiIconContent.childCount + 1, var_18_3 do
		local var_18_4 = Instantiate(self.emojiIconItem)
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
							onButton(self, arg_21_0, function()
								if self.contextData.emojiIconCallback then
									getProxy(ChatProxy):addUsedEmojiIcon(var_20_0.id)
									self.contextData.emojiIconCallback(var_20_0.id)
								end

								return
							end, SFX_PANEL)
						end

						return
					end)
				end

				return
			end)
			var_18_11:align(#var_18_1)

			var_18_10.padding.left = 20

			local var_18_12 = UIItemList.New(var_18_9, (var_18_9:Find("Icon")))

			var_18_12:make(function(arg_23_0, arg_23_1, arg_23_2)
				local var_23_0 = var_18_0[arg_23_1 + 1]

				if arg_23_0 == UIItemList.EventUpdate then
					PoolMgr.GetInstance():GetPrefab("emoji/" .. var_18_0[arg_23_1 + 1].pic, var_18_0[arg_23_1 + 1].pic, true, function(arg_24_0)
						if not IsNil(arg_23_2) then
							arg_24_0.name = var_23_0.pic

							setParent(arg_24_0, arg_23_2, false)
							onButton(self, arg_24_0, function()
								if self.contextData.emojiIconCallback then
									getProxy(ChatProxy):addUsedEmojiIcon(var_23_0.id)
									self.contextData.emojiIconCallback(var_23_0.id)
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
			local var_18_14 = _.slice(var_18_0, (iter_18_3 - 2) * EmojiLayer.True_Emoji_Num_Of_Page + var_18_2 + 1, EmojiLayer.True_Emoji_Num_Of_Page)

			var_18_10.padding.left = 60

			local var_18_15 = UIItemList.New(var_18_9, (var_18_9:Find("Icon")))

			var_18_15:make(function(arg_26_0, arg_26_1, arg_26_2)
				local var_26_0 = var_18_14[arg_26_1 + 1]

				if arg_26_0 == UIItemList.EventUpdate then
					PoolMgr.GetInstance():GetPrefab("emoji/" .. var_18_14[arg_26_1 + 1].pic, var_18_14[arg_26_1 + 1].pic, true, function(arg_27_0)
						if not IsNil(arg_26_2) then
							arg_27_0.name = var_26_0.pic

							setParent(arg_27_0, arg_26_2, false)
							onButton(self, arg_27_0, function()
								if self.contextData.emojiIconCallback then
									getProxy(ChatProxy):addUsedEmojiIcon(var_26_0.id)
									self.contextData.emojiIconCallback(var_26_0.id)
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
		self.emojiIconSnap:AddChild(var_18_4)
	end

	return
end

function EmojiLayer:onBackPressed()
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
	triggerButton(self._tf)

	return
end

function EmojiLayer:clearItem(arg_30_1)
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

function EmojiLayer:willExit()
	eachChild(self.emojiContent, function(arg_33_0)
		self:clearItem(arg_33_0)

		return
	end)
	_.each(self.tplCaches, function(arg_34_0)
		self:clearItem(arg_34_0)

		return
	end)

	self.tplCaches = {}

	self:UnOverlayPanel(self._tf)

	return
end

return EmojiLayer
