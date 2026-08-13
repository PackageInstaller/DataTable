class = var_0_10000

local var_0_0 = var_0_10000("ChatBubble")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	tf = var_1_10002
	arg_1_0.tf = var_1_10002(arg_1_1)
	arg_1_0.isLoadChatBg = false

	arg_1_0:init()

	findTF = var_2
	arg_1_0.chatFrameTr = var_2(arg_1_0.tf, "chat_fram")
	IsNil = var_2

	if var_2(arg_1_0.chatFrameTr) then
		arg_1_0.chatFrameTr = arg_1_0.tf
	end

	return
end

function var_0_0.init(arg_2_0)
	findTF = var_1_10001

	local var_2_0 = var_1_10001(arg_2_0.tf, "desc/name")

	arg_2_0.nameTF = var_1.GetComponent(var_2_0, "Text")
	findTF = var_1
	arg_2_0.face = var_1(arg_2_0.tf, "face/content")
	findTF = var_1
	arg_2_0.circle = var_1(arg_2_0.tf, "shipicon/frame")
	findTF = var_1

	local var_2_1 = var_1(arg_2_0.tf, "time")

	arg_2_0.timeTF = var_1.GetComponent(var_2_1, "Text")
	findTF = var_1

	local var_2_2 = var_1(arg_2_0.tf, "shipicon/icon")

	arg_2_0.headTF = var_1.GetComponent(var_2_2, "Image")
	findTF = var_1
	arg_2_0.stars = var_1(arg_2_0.tf, "shipicon/stars")
	findTF = var_1
	arg_2_0.star = var_1(arg_2_0.stars, "star")
	findTF = var_1
	arg_2_0.dutyTF = var_1(arg_2_0.tf, "desc/duty")
	findTF = var_1
	arg_2_0.channel = var_1(arg_2_0.tf, "desc/channel")
	arg_2_0.chatBgWidth = 665

	return
end

function var_0_0.update(arg_3_0, arg_3_1)
	if arg_3_0.data == arg_3_1 then
		return
	end

	arg_3_0.data = arg_3_1

	local var_3_0 = arg_3_1.isSelf

	if arg_3_1.player.icon == 0 then
		var_3.icon = 101171
	end

	pg = var_4

	local var_3_1 = var_4.ship_data_statistics[var_3.icon]
	local var_3_2 = false

	if not var_3_0 then
		var_3_2 = var_3.propose
	elseif var_3.character then
		getProxy = var_1_10007
		BayProxy = var_1_10009

		local var_3_3 = var_1_10007(var_1_10009)

		if var_7.getShipById(var_3_3, var_6) then
			var_3_2 = var_7:ShowPropose()
		end
	end

	arg_3_0.nameTF.text = var_3.name

	local var_3_4 = arg_3_1.timestamp

	getOfflineTimeStamp = var_7

	local var_3_5 = var_7(var_3_4)

	arg_3_0.timeTF.text = var_3_5

	if arg_3_0.dutyTF then
		arg_3_0:UpdateDuty(var_3)
	end

	Ship = var_8

	local var_3_6 = var_8.New({
		configId = var_3_1.id
	})
	local var_3_7 = arg_3_0.stars.childCount
	local var_3_8 = var_3_6:getStar()

	for iter_3_0 = var_3_7, var_3_8 - 1 do
		cloneTplTo = var_1_10015

		var_1_10015(arg_3_0.star, arg_3_0.stars)
	end

	local var_3_9 = arg_3_0.stars.childCount

	for iter_3_1 = 0, var_3_9 - 1 do
		local var_3_10 = arg_3_0.stars
		local var_3_11 = var_15.GetChild(var_3_10, iter_3_1).gameObject

		var_16.SetActive(var_3_11, iter_3_1 < var_3_1.star)
	end

	if arg_3_0.channel then
		arg_3_0:UpdateChannel(arg_3_1)
	end

	local var_3_12 = arg_3_0.headTF

	Color = var_12
	var_3_12.color = var_12.New(1, 1, 1, 0)
	LoadSpriteAsync = var_3_12

	var_3_12("qicon/" .. var_3:getPainting(), function(arg_4_0)
		IsNil = var_2_10001

		if not var_2_10001(arg_3_0.headTF) then
			local var_4_0 = arg_3_0.headTF

			Color = var_2_10002
			var_4_0.color = var_2_10002.white

			local var_4_1 = arg_3_0.headTF
			local var_4_2

			if not arg_4_0 then
				::label_4_0::

				LoadSprite = var_4_2
				var_4_2 = var_4_2("heroicon/unknown")
			end

			var_4_1.sprite = var_4_2
		end

		return
	end)

	AttireFrame = var_3_12

	local var_3_13 = var_3_12.attireFrameRes
	local var_3_14 = var_3
	local var_3_15 = var_3_0

	AttireConst = var_15

	local var_3_16 = var_3_13(var_3_14, var_3_15, var_15.TYPE_ICON_FRAME, var_3_2)

	PoolMgr = var_12

	local var_3_17 = var_12.GetInstance()

	var_12.GetPrefab(var_3_17, "IconFrame/" .. var_3_16, var_3_16, true, function(arg_5_0)
		IsNil = var_2_10001

		if var_2_10001(arg_3_0.tf) then
			return
		end

		if arg_3_0.circle and arg_3_0.data then
			arg_5_0.name = var_3_16
			findTF = var_1

			local var_5_0 = var_1(arg_5_0.transform, "icon")
			local var_5_1 = var_1.GetComponent

			typeof = var_2_10005
			Image = var_2_10007
			var_5_1(var_5_0, var_2_10005(var_2_10007)).raycastTarget = false
			setParent = var_3

			var_3(arg_5_0, arg_3_0.circle, false)
		else
			PoolMgr = var_1

			local var_5_2 = var_1.GetInstance()

			var_1.ReturnPrefab(var_5_2, "IconFrame/" .. var_3_16, var_3_16, arg_5_0)
		end

		return
	end)

	local var_3_18

	if arg_3_1.emojiId then
		pg = var_3_18
		var_3_18 = var_3_18.emoji_template[arg_3_1.emojiId]
		PoolMgr = var_3_14

		local var_3_19 = var_3_14.GetInstance()

		var_3_14.GetPrefab(var_3_19, "emoji/" .. var_3_18.pic, var_3_18.pic, true, function(arg_6_0)
			IsNil = var_2_10001

			if var_2_10001(arg_3_0.tf) then
				return
			end

			if arg_3_0.face and arg_3_0.data then
				arg_6_0.name = var_3_18.pic

				local var_6_0 = arg_6_0

				if arg_6_0.GetComponent(var_6_0, "Animator") then
					var_1.enabled = true
				end

				setParent = var_2_10002

				var_2_10002(arg_6_0, arg_3_0.face, false)

				rtf = var_2_10002

				local var_6_1 = var_2_10002(arg_6_0)

				Vector2 = var_6_0
				var_6_1.sizeDelta = var_6_0.New(180, 180)
				rtf = var_6_1

				local var_6_2 = var_6_1(arg_6_0)

				if var_3_0 then
					Vector3 = var_6_3

					local var_6_3

					if not var_6_3(-50, 0, 0) then
						Vector3 = var_6_3
						var_6_3 = var_6_3(50, 0, 0)
					end

					var_6_2.localPosition = var_6_3

					if false then
						PoolMgr = var_1

						local var_6_4 = var_1.GetInstance()

						var_1.ReturnPrefab(var_6_4, "emoji/" .. var_3_18.pic, var_3_18.pic, arg_6_0)
					end

					return
				end
			end
		end)
	else
		var_3_18 = arg_3_0:GetAttireFrameRes(var_3, var_3_0, var_3_2)
		PoolMgr = var_3_14

		local var_3_20 = var_3_14.GetInstance()

		var_13.GetPrefab(var_3_20, "ChatFrame/" .. var_3_18, var_3_18, true, function(arg_7_0)
			IsNil = var_2_10001

			if var_2_10001(arg_3_0.tf) then
				return
			end

			local var_7_2

			if arg_3_0.tf and arg_3_0.data then
				tf = var_7_2

				local var_7_0 = var_7_2(arg_7_0)
				local var_7_1 = var_7_2.Find(var_7_0, "Text")

				var_7_2 = var_7_2.GetComponent(var_7_1, "RichText")
				var_7_2.supportRichText = false
				eachChild = var_2
				tf = var_4

				local var_7_3 = var_4(arg_7_0)

				var_2(var_4.Find(var_7_3, "Text"), function(arg_8_0)
					Destroy = var_3_10001

					var_3_10001(arg_8_0)

					return
				end)

				string = var_2

				local var_7_4 = var_2.gmatch
				local var_7_5

				if not arg_3_1.content then
					var_7_5 = ""
				end

				ChatConst = var_5

				local var_7_6 = var_7_4(var_7_5, var_5.EmojiIconCodeMatch)
				local var_7_7 = false

				for iter_7_0 in var_7_6 do
					table = var_2_10008
					var_2_10008 = var_2_10008.contains
					pg = var_2_10010
					var_2_10010 = var_2_10010.emoji_small_template.all
					tonumber = var_2_10011

					if var_2_10008(var_2_10010, var_2_10011(iter_7_0)) then
						var_7_7 = true
						pg = var_2_10008
						var_2_10008 = var_2_10008.emoji_small_template
						tonumber = var_2_10009
						var_2_10008 = var_2_10008[var_2_10009(iter_7_0)]
						LoadSprite = var_2_10009
						var_2_10009 = var_2_10009("emoji/" .. var_2_10008.pic .. "_small", nil)
						var_2_10012 = var_7_2

						var_7_2.AddSprite(var_2_10012, iter_7_0, var_2_10009)
					end
				end

				GetComponent = var_4

				local var_7_8 = var_4(arg_7_0, "VerticalLayoutGroup")

				if var_7_7 then
					onNextTick = var_5

					var_5(function()
						local var_9_0 = var_7_8.padding

						var_9_0.bottom = 30
						Canvas = var_9_0

						var_9_0.ForceUpdateCanvases()

						return
					end)
				else
					var_7_8.padding.bottom = var_7_8.padding.top
				end

				local var_7_9 = arg_3_1.content

				if arg_3_1.needBanRichText then
					SwitchSpecialChar = var_6
					var_7_9 = var_6(arg_3_1.content)
				end

				string = var_6

				local var_7_10 = var_6.gsub
				local var_7_11 = var_7_9

				ChatConst = var_2_10009
				var_7_2.text = var_7_10(var_7_11, var_2_10009.EmojiIconCodeMatch, function(arg_10_0)
					table = var_3_10001

					local var_10_0 = var_3_10001.contains

					pg = var_3_10003

					local var_10_1 = var_3_10003.emoji_small_template.all

					tonumber = var_3_10004

					if var_10_0(var_10_1, var_3_10004(arg_10_0)) then
						string = var_1

						return var_1.format("<icon name=%s w=1 h=1/>", arg_10_0)
					end

					return
				end)

				local var_7_12 = arg_3_0

				var_7.UpdateContent(var_7_12, var_7_2, var_6)

				arg_3_0.isLoadChatBg = true

				local var_7_13 = arg_7_0
				local var_7_14 = arg_7_0.GetComponent

				typeof = var_10
				LayoutElement = var_2_10012
				var_7_14(var_7_13, var_10(var_2_10012)).preferredWidth = arg_3_0.chatBgWidth
				arg_7_0.name = var_3_18
				setParent = var_7

				var_7(arg_7_0, arg_3_0.chatFrameTr, false)

				tf = var_7

				local var_7_15 = var_7(arg_7_0)

				var_7.SetAsFirstSibling(var_7_15)

				Canvas = var_7

				var_7.ForceUpdateCanvases()

				local var_7_16 = arg_3_0

				var_7.OnChatFrameLoaded(var_7_16, arg_7_0)
			else
				PoolMgr = var_7_2

				local var_7_17 = var_7_2.GetInstance()

				var_1.ReturnPrefab(var_7_17, "ChatFrame/" .. var_3_18, var_3_18, arg_7_0)
			end

			return
		end)
	end

	setActive = var_3_18

	var_3_18(arg_3_0.face.parent, arg_3_1.emojiId)

	return
end

function var_0_0.UpdateContent(arg_11_0, arg_11_1, arg_11_2)
	arg_11_1.text = arg_11_2

	return
end

function var_0_0.GetAttireFrameRes(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	AttireFrame = var_1_10004

	local var_12_0 = var_1_10004.attireFrameRes
	local var_12_1 = arg_12_1
	local var_12_2 = arg_12_2

	AttireConst = var_1_10008

	return (var_12_0(var_12_1, var_12_2, var_1_10008.TYPE_CHAT_FRAME, arg_12_3))
end

function var_0_0.UpdateDuty(arg_13_0, arg_13_1)
	setActive = var_1_10002

	var_1_10002(arg_13_0.dutyTF, arg_13_1.duty)

	if arg_13_1.duty then
		GetSpriteFromAtlas = var_2

		local var_13_0 = var_2("dutyicon", arg_13_1.duty)

		setImageSprite = var_1_10003

		var_1_10003(arg_13_0.dutyTF, var_13_0, true)
	end

	return
end

function var_0_0.UpdateChannel(arg_14_0, arg_14_1)
	GetSpriteFromAtlas = var_1_10002

	local var_14_0 = "channel"

	ChatConst = var_1_10005

	local var_14_1 = var_1_10002(var_14_0, var_1_10005.GetChannelSprite(arg_14_1.type) .. "_1920")

	setImageSprite = var_1_10003

	var_1_10003(arg_14_0.channel, var_14_1, true)

	return
end

function var_0_0.dispose(arg_15_0)
	local var_15_0 = arg_15_0.face.childCount

	if 0 < var_15_0 then
		local var_15_1 = arg_15_0.face
		local var_15_2 = var_1.GetChild(var_15_1, 0).gameObject

		PoolMgr = var_2

		local var_15_3 = var_2.GetInstance()

		var_2.ReturnPrefab(var_15_3, "emoji/" .. var_15_2.name, var_15_2.name, var_15_2)
	end

	local var_15_4 = arg_15_0.circle.childCount

	if 0 < var_15_4 then
		local var_15_5 = arg_15_0.circle
		local var_15_6 = var_1.GetChild(var_15_5, 0).gameObject

		PoolMgr = var_2

		local var_15_7 = var_2.GetInstance()

		var_2.ReturnPrefab(var_15_7, "IconFrame/" .. var_15_6.name, var_15_6.name, var_15_6)
	end

	if arg_15_0.isLoadChatBg then
		local var_15_8 = arg_15_0.chatFrameTr
		local var_15_9 = var_1.GetChild(var_15_8, 0).gameObject

		PoolMgr = var_2

		local var_15_10 = var_2.GetInstance()

		var_2.ReturnPrefab(var_15_10, "ChatFrame/" .. var_15_9.name, var_15_9.name, var_15_9)

		arg_15_0.isLoadChatBg = false
	end

	arg_15_0.data = nil

	return
end

function var_0_0.OnChatFrameLoaded(arg_16_0, arg_16_1)
	return
end

return var_0_0
