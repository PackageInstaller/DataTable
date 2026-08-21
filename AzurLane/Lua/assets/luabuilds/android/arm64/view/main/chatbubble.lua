local var_0_0 = class("ChatBubble")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.tf = tf(arg_1_1)
	arg_1_0.isLoadChatBg = false

	arg_1_0:init()

	arg_1_0.chatFrameTr = findTF(arg_1_0.tf, "chat_fram")

	if IsNil(arg_1_0.chatFrameTr) then
		arg_1_0.chatFrameTr = arg_1_0.tf
	end

	return
end

function var_0_0.init(arg_2_0)
	arg_2_0.nameTF = findTF(arg_2_0.tf, "desc/name"):GetComponent("Text")
	arg_2_0.face = findTF(arg_2_0.tf, "face/content")
	arg_2_0.circle = findTF(arg_2_0.tf, "shipicon/frame")
	arg_2_0.timeTF = findTF(arg_2_0.tf, "time"):GetComponent("Text")
	arg_2_0.headTF = findTF(arg_2_0.tf, "shipicon/icon"):GetComponent("Image")
	arg_2_0.stars = findTF(arg_2_0.tf, "shipicon/stars")
	arg_2_0.star = findTF(arg_2_0.stars, "star")
	arg_2_0.dutyTF = findTF(arg_2_0.tf, "desc/duty")
	arg_2_0.channel = findTF(arg_2_0.tf, "desc/channel")
	arg_2_0.chatBgWidth = 665

	return
end

function var_0_0.update(arg_3_0, arg_3_1)
	if arg_3_0.data == arg_3_1 then
		return
	end

	arg_3_0.data = arg_3_1

	local var_3_0 = arg_3_1.isSelf
	local var_3_1 = arg_3_1.player

	if arg_3_1.player.icon == 0 then
		var_3_1.icon = 101171
	end

	local var_3_2 = pg.ship_data_statistics[var_3_1.icon]
	local var_3_3 = false

	if not var_3_0 then
		var_3_3 = var_3_1.propose
	else
		local var_3_4 = var_3_1.character

		if var_3_1.character then
			local var_3_5 = getProxy(BayProxy):getShipById(var_3_4)

			if var_3_5 then
				var_3_3 = var_3_5:ShowPropose()
			end
		end
	end

	arg_3_0.nameTF.text = var_3_1.name
	arg_3_0.timeTF.text = getOfflineTimeStamp(arg_3_1.timestamp)

	if arg_3_0.dutyTF then
		arg_3_0:UpdateDuty(var_3_1)
	end

	local var_3_6 = Ship.New({
		configId = var_3_2.id
	})

	for iter_3_0 = arg_3_0.stars.childCount, var_3_6:getStar() - 1 do
		cloneTplTo(arg_3_0.star, arg_3_0.stars)
	end

	for iter_3_1 = 0, arg_3_0.stars.childCount - 1 do
		arg_3_0.stars:GetChild(iter_3_1).gameObject:SetActive(iter_3_1 < var_3_2.star)
	end

	if arg_3_0.channel then
		arg_3_0:UpdateChannel(arg_3_1)
	end

	arg_3_0.headTF.color = Color.New(1, 1, 1, 0)

	LoadSpriteAsync("qicon/" .. var_3_1:getPainting(), function(arg_4_0)
		if not IsNil(arg_3_0.headTF) then
			arg_3_0.headTF.color = Color.white
			arg_3_0.headTF.sprite = arg_4_0 or LoadSprite("heroicon/unknown")
		end

		return
	end)

	local var_3_7 = AttireFrame.attireFrameRes(var_3_1, var_3_0, AttireConst.TYPE_ICON_FRAME, var_3_3)

	PoolMgr.GetInstance():GetPrefab("IconFrame/" .. var_3_7, var_3_7, true, function(arg_5_0)
		if IsNil(arg_3_0.tf) then
			return
		end

		if arg_3_0.circle and arg_3_0.data then
			arg_5_0.name = var_3_7
			findTF(arg_5_0.transform, "icon"):GetComponent(typeof(Image)).raycastTarget = false

			setParent(arg_5_0, arg_3_0.circle, false)
		else
			PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_3_7, var_3_7, arg_5_0)
		end

		return
	end)

	if arg_3_1.emojiId then
		PoolMgr.GetInstance():GetPrefab("emoji/" .. pg.emoji_template[arg_3_1.emojiId].pic, pg.emoji_template[arg_3_1.emojiId].pic, true, function(arg_6_0)
			if IsNil(arg_3_0.tf) then
				return
			end

			if arg_3_0.face and arg_3_0.data then
				arg_6_0.name = var_0.pic

				local var_6_0 = arg_6_0:GetComponent("Animator")

				if var_6_0 then
					var_6_0.enabled = true
				end

				setParent(arg_6_0, arg_3_0.face, false)

				rtf(arg_6_0).sizeDelta = Vector2.New(180, 180)

				local var_6_1 = rtf(arg_6_0)

				var_6_1.localPosition = var_3_0 and Vector3(-50, 0, 0) or Vector3(50, 0, 0)
			else
				PoolMgr.GetInstance():ReturnPrefab("emoji/" .. var_0.pic, var_0.pic, arg_6_0)
			end

			return
		end)
	else
		local var_3_8 = arg_3_0:GetAttireFrameRes(var_3_1, var_3_0, var_3_3)

		PoolMgr.GetInstance():GetPrefab("ChatFrame/" .. var_3_8, var_3_8, true, function(arg_7_0)
			if IsNil(arg_3_0.tf) then
				return
			end

			if arg_3_0.tf and arg_3_0.data then
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

				local var_7_4 = arg_3_1.content

				if arg_3_1.needBanRichText then
					var_7_4 = SwitchSpecialChar(arg_3_1.content)
				end

				local var_7_5 = string.gsub(var_7_4, ChatConst.EmojiIconCodeMatch, function(arg_10_0)
					if table.contains(pg.emoji_small_template.all, tonumber(arg_10_0)) then
						return string.format("<icon name=%s w=1 h=1/>", arg_10_0)
					end

					return
				end)

				var_7_0.text = var_7_5

				arg_3_0:UpdateContent(var_7_0, var_7_5)

				arg_3_0.isLoadChatBg = true
				arg_7_0:GetComponent(typeof(LayoutElement)).preferredWidth = arg_3_0.chatBgWidth
				arg_7_0.name = var_3_8

				setParent(arg_7_0, arg_3_0.chatFrameTr, false)
				tf(arg_7_0):SetAsFirstSibling()
				Canvas.ForceUpdateCanvases()
				arg_3_0:OnChatFrameLoaded(arg_7_0)
			else
				PoolMgr.GetInstance():ReturnPrefab("ChatFrame/" .. var_3_8, var_3_8, arg_7_0)
			end

			return
		end)
	end

	setActive(arg_3_0.face.parent, arg_3_1.emojiId)

	return
end

function var_0_0.UpdateContent(arg_11_0, arg_11_1, arg_11_2)
	arg_11_1.text = arg_11_2

	return
end

function var_0_0.GetAttireFrameRes(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	return (AttireFrame.attireFrameRes(arg_12_1, arg_12_2, AttireConst.TYPE_CHAT_FRAME, arg_12_3))
end

function var_0_0.UpdateDuty(arg_13_0, arg_13_1)
	setActive(arg_13_0.dutyTF, arg_13_1.duty)

	if arg_13_1.duty then
		setImageSprite(arg_13_0.dutyTF, GetSpriteFromAtlas("dutyicon", arg_13_1.duty), true)
	end

	return
end

function var_0_0.UpdateChannel(arg_14_0, arg_14_1)
	setImageSprite(arg_14_0.channel, GetSpriteFromAtlas("channel", ChatConst.GetChannelSprite(arg_14_1.type) .. "_1920"), true)

	return
end

function var_0_0.dispose(arg_15_0)
	if arg_15_0.face.childCount > 0 then
		local var_15_0 = arg_15_0.face:GetChild(0).gameObject

		PoolMgr.GetInstance():ReturnPrefab("emoji/" .. var_15_0.name, var_15_0.name, var_15_0)
	end

	if arg_15_0.circle.childCount > 0 then
		local var_15_1 = arg_15_0.circle:GetChild(0).gameObject

		PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_15_1.name, var_15_1.name, var_15_1)
	end

	if arg_15_0.isLoadChatBg then
		local var_15_2 = arg_15_0.chatFrameTr:GetChild(0).gameObject

		PoolMgr.GetInstance():ReturnPrefab("ChatFrame/" .. var_15_2.name, var_15_2.name, var_15_2)

		arg_15_0.isLoadChatBg = false
	end

	arg_15_0.data = nil

	return
end

function var_0_0.OnChatFrameLoaded(arg_16_0, arg_16_1)
	return
end

return var_0_0
