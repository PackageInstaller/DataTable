local ChatBubble = class("ChatBubble")

function ChatBubble:Ctor(arg_1_1)
	self.tf = tf(arg_1_1)
	self.isLoadChatBg = false

	self:init()

	self.chatFrameTr = findTF(self.tf, "chat_fram")

	if IsNil(self.chatFrameTr) then
		self.chatFrameTr = self.tf
	end

	return
end

function ChatBubble:init()
	self.nameTF = findTF(self.tf, "desc/name"):GetComponent("Text")
	self.face = findTF(self.tf, "face/content")
	self.circle = findTF(self.tf, "shipicon/frame")
	self.timeTF = findTF(self.tf, "time"):GetComponent("Text")
	self.headTF = findTF(self.tf, "shipicon/icon"):GetComponent("Image")
	self.stars = findTF(self.tf, "shipicon/stars")
	self.star = findTF(self.stars, "star")
	self.dutyTF = findTF(self.tf, "desc/duty")
	self.channel = findTF(self.tf, "desc/channel")
	self.chatBgWidth = 665

	return
end

function ChatBubble:update(arg_3_1)
	if self.data == arg_3_1 then
		return
	end

	self.data = arg_3_1

	local var_3_0 = arg_3_1.isSelf
	local var_3_1 = arg_3_1.player

	if arg_3_1.player.icon == 0 then
		var_3_1.icon = 101171
	end

	local var_3_2 = pg.ship_data_statistics[var_3_1.icon]
	local var_3_3 = false

	if not var_3_0 then
		var_3_3 = var_3_1.propose
	elseif var_3_1.character then
		local var_3_4 = getProxy(BayProxy):getShipById(var_3_1.character)

		if var_3_4 then
			var_3_3 = var_3_4:ShowPropose()
		end
	end

	self.nameTF.text = var_3_1.name
	self.timeTF.text = getOfflineTimeStamp(arg_3_1.timestamp)

	if self.dutyTF then
		self:UpdateDuty(var_3_1)
	end

	for iter_3_0 = self.stars.childCount, Ship.New({
		configId = var_3_2.id
	}):getStar() - 1 do
		cloneTplTo(self.star, self.stars)
	end

	for iter_3_1 = 0, self.stars.childCount - 1 do
		self.stars:GetChild(iter_3_1).gameObject:SetActive(iter_3_1 < var_3_2.star)
	end

	if self.channel then
		self:UpdateChannel(arg_3_1)
	end

	self.headTF.color = Color.New(1, 1, 1, 0)

	LoadSpriteAsync("qicon/" .. var_3_1:getPainting(), function(arg_4_0)
		if not IsNil(self.headTF) then
			self.headTF.color = Color.white
			self.headTF.sprite = arg_4_0 or LoadSprite("heroicon/unknown")
		end

		return
	end)

	local var_3_5 = AttireFrame.attireFrameRes(var_3_1, var_3_0, AttireConst.TYPE_ICON_FRAME, var_3_3)

	PoolMgr.GetInstance():GetPrefab("IconFrame/" .. var_3_5, var_3_5, true, function(arg_5_0)
		if IsNil(self.tf) then
			return
		end

		if self.circle and self.data then
			arg_5_0.name = var_3_5
			findTF(arg_5_0.transform, "icon"):GetComponent(typeof(Image)).raycastTarget = false

			setParent(arg_5_0, self.circle, false)
		else
			PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_3_5, var_3_5, arg_5_0)
		end

		return
	end)

	if arg_3_1.emojiId then
		local var_3_6 = pg.emoji_template[arg_3_1.emojiId]

		PoolMgr.GetInstance():GetPrefab("emoji/" .. pg.emoji_template[arg_3_1.emojiId].pic, pg.emoji_template[arg_3_1.emojiId].pic, true, function(arg_6_0)
			if IsNil(self.tf) then
				return
			end

			if self.face and self.data then
				arg_6_0.name = var_3_6.pic

				local var_6_0 = arg_6_0:GetComponent("Animator")

				if var_6_0 then
					var_6_0.enabled = true
				end

				setParent(arg_6_0, self.face, false)

				rtf(arg_6_0).sizeDelta = Vector2.New(180, 180)
				rtf(arg_6_0).localPosition = var_3_0 and Vector3(-50, 0, 0) or Vector3(50, 0, 0)
			else
				PoolMgr.GetInstance():ReturnPrefab("emoji/" .. var_3_6.pic, var_3_6.pic, arg_6_0)
			end

			return
		end)
	else
		local var_3_7 = self:GetAttireFrameRes(var_3_1, var_3_0, var_3_3)

		PoolMgr.GetInstance():GetPrefab("ChatFrame/" .. var_3_7, var_3_7, true, function(arg_7_0)
			if IsNil(self.tf) then
				return
			end

			if self.tf and self.data then
				local var_7_0 = tf(arg_7_0):Find("Text"):GetComponent("RichText")

				var_7_0.supportRichText = false

				eachChild(tf(arg_7_0):Find("Text"), function(arg_8_0)
					Destroy(arg_8_0)

					return
				end)

				local var_7_1 = arg_3_1.content
				local var_7_2

				if not arg_3_1.content then
					var_7_1 = ""
					var_7_2 = false
				end

				for iter_7_0 in string.gmatch(var_7_1, ChatConst.EmojiIconCodeMatch) do
					if table.contains(pg.emoji_small_template.all, tonumber(iter_7_0)) then
						var_7_2 = true

						var_7_0:AddSprite(iter_7_0, (LoadSprite("emoji/" .. pg.emoji_small_template[tonumber(iter_7_0)].pic .. "_small", nil)))
					end
				end

				local var_7_3 = GetComponent(arg_7_0, "VerticalLayoutGroup")

				if var_7_2 then
					onNextTick(function()
						var_7_3.padding.bottom = 30

						Canvas.ForceUpdateCanvases()

						return
					end)
				else
					var_7_3.padding.bottom = var_7_3.padding.top
				end

				local var_7_5 = string.gsub((arg_3_1.needBanRichText or nil) and SwitchSpecialChar(arg_3_1.content), ChatConst.EmojiIconCodeMatch, function(arg_10_0)
					if table.contains(pg.emoji_small_template.all, tonumber(arg_10_0)) then
						return string.format("<icon name=%s w=1 h=1/>", arg_10_0)
					end

					return
				end)

				var_7_0.text = var_7_5

				self:UpdateContent(var_7_0, var_7_5)

				self.isLoadChatBg = true
				arg_7_0:GetComponent(typeof(LayoutElement)).preferredWidth = self.chatBgWidth
				arg_7_0.name = var_3_7

				setParent(arg_7_0, self.chatFrameTr, false)
				tf(arg_7_0):SetAsFirstSibling()
				Canvas.ForceUpdateCanvases()
				self:OnChatFrameLoaded(arg_7_0)
			else
				PoolMgr.GetInstance():ReturnPrefab("ChatFrame/" .. var_3_7, var_3_7, arg_7_0)
			end

			return
		end)
	end

	setActive(self.face.parent, arg_3_1.emojiId)

	return
end

function ChatBubble:UpdateContent(arg_11_1, arg_11_2)
	arg_11_1.text = arg_11_2

	return
end

function ChatBubble:GetAttireFrameRes(arg_12_1, arg_12_2, arg_12_3)
	return (AttireFrame.attireFrameRes(arg_12_1, arg_12_2, AttireConst.TYPE_CHAT_FRAME, arg_12_3))
end

function ChatBubble:UpdateDuty(arg_13_1)
	setActive(self.dutyTF, arg_13_1.duty)

	if arg_13_1.duty then
		setImageSprite(self.dutyTF, GetSpriteFromAtlas("dutyicon", arg_13_1.duty), true)
	end

	return
end

function ChatBubble:UpdateChannel(arg_14_1)
	setImageSprite(self.channel, GetSpriteFromAtlas("channel", ChatConst.GetChannelSprite(arg_14_1.type) .. "_1920"), true)

	return
end

function ChatBubble:dispose()
	if self.face.childCount > 0 then
		local var_15_0 = self.face:GetChild(0).gameObject

		PoolMgr.GetInstance():ReturnPrefab("emoji/" .. var_15_0.name, var_15_0.name, var_15_0)
	end

	if self.circle.childCount > 0 then
		local var_15_1 = self.circle:GetChild(0).gameObject

		PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_15_1.name, var_15_1.name, var_15_1)
	end

	if self.isLoadChatBg then
		local var_15_2 = self.chatFrameTr:GetChild(0).gameObject

		PoolMgr.GetInstance():ReturnPrefab("ChatFrame/" .. var_15_2.name, var_15_2.name, var_15_2)

		self.isLoadChatBg = false
	end

	self.data = nil

	return
end

function ChatBubble:OnChatFrameLoaded(arg_16_1)
	return
end

return ChatBubble
