class = var_0_10000

local var_0_0 = "EmojiLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

var_0_1.PageEmojiNums = 8
var_0_1.Frequently_Used_Emoji_Num = 6
var_0_1.True_Emoji_Num_Of_Page = 15

function var_0_1.getUIName(arg_1_0)
	return "EmojiUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.emojiGroup = var_1.Find(var_2_0, "frame/group")

	local var_2_1 = arg_2_0.emojiGroup

	arg_2_0.emojiType = var_1.Find(var_2_1, "type")

	local var_2_2 = arg_2_0._tf

	arg_2_0.emojiEvent = var_1.Find(var_2_2, "frame/bg/mask/event")

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "frame/bg/mask/event")

	arg_2_0.emojiSnap = var_1.GetComponent(var_2_4, "HScrollSnap")

	local var_2_5 = arg_2_0.emojiSnap

	var_1.Init(var_2_5)

	tf = var_1

	local var_2_6 = var_1(arg_2_0.emojiSnap)

	arg_2_0.emojiContent = var_1.Find(var_2_6, "content")
	tf = var_1

	local var_2_7 = var_1(arg_2_0.emojiSnap)

	arg_2_0.emojiItem = var_1.Find(var_2_7, "item")

	local var_2_8 = arg_2_0._tf

	arg_2_0.emojiDots = var_1.Find(var_2_8, "frame/dots")

	local var_2_9 = arg_2_0._tf

	arg_2_0.emojiIconDots = var_1.Find(var_2_9, "frame/emojiDots")
	tf = var_1

	local var_2_10 = var_1(arg_2_0.emojiSnap)

	arg_2_0.emojiDot = var_1.Find(var_2_10, "dot")
	setText = var_1

	local var_2_11 = arg_2_0.emojiEvent
	local var_2_12 = var_3.Find(var_2_11, "null_tpl/Text")

	i18n = var_4

	var_1(var_2_12, var_4("recently_sticker_placeholder"))

	setActive = var_1

	var_1(arg_2_0.emojiItem, false)

	setActive = var_1

	var_1(arg_2_0.emojiDot, false)

	local var_2_13 = arg_2_0._tf

	arg_2_0.emojiIconEvent = var_1.Find(var_2_13, "frame/bg/mask/emojiicon_event")

	local var_2_14 = arg_2_0._tf
	local var_2_15 = var_1.Find(var_2_14, "frame/bg/mask/emojiicon_event")

	arg_2_0.emojiIconSnap = var_1.GetComponent(var_2_15, "HScrollSnap")

	local var_2_16 = arg_2_0.emojiIconSnap

	var_1.Init(var_2_16)

	tf = var_1

	local var_2_17 = var_1(arg_2_0.emojiIconSnap)

	arg_2_0.emojiIconContent = var_1.Find(var_2_17, "content")
	tf = var_1

	local var_2_18 = var_1(arg_2_0.emojiIconSnap)

	arg_2_0.emojiIconItem = var_1.Find(var_2_18, "item_emojiicon")
	setActive = var_1

	var_1(arg_2_0.emojiIconItem, false)

	arg_2_0.parentTr = arg_2_0._tf.parent

	local var_2_19 = arg_2_0._tf

	arg_2_0.resource = var_1.Find(var_2_19, "frame/resource")

	local var_2_20 = arg_2_0._tf

	arg_2_0.frame = var_1.Find(var_2_20, "frame")

	local var_2_21 = arg_2_0.frame
	local var_2_22

	if not arg_2_0.contextData.pos then
		Vector3 = var_2_22
		var_2_22 = var_2_22(0, 0, 0)
	end

	var_2_21.position = var_2_22

	local var_2_23 = arg_2_0.frame

	Vector3 = var_2_22
	var_2_23.localPosition = var_2_22(arg_2_0.frame.localPosition.x, arg_2_0.frame.localPosition.y, 0)

	local var_2_24 = arg_2_0._tf

	arg_2_0.newTag = var_1.Find(var_2_24, "newtag")
	getProxy = var_1
	EmojiProxy = var_2_24
	arg_2_0.emojiProxy = var_1(var_2_24)

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.emit(var_4_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)
	arg_3_0:display()
	arg_3_0:OverlayPanel(arg_3_0._tf)

	return
end

function var_0_1.display(arg_5_0)
	UIItemList = var_1_10001

	local var_5_0 = var_1_10001.New(arg_5_0.emojiGroup, arg_5_0.emojiType)

	var_1.make(var_5_0, function(arg_6_0, arg_6_1, arg_6_2)
		UIItemList = var_2_10003

		if arg_6_0 == var_2_10003.EventUpdate then
			ChatConst = var_3

			local var_6_0 = var_3.EmojiTypes[arg_6_1 + 1]
			local var_6_1 = arg_5_0

			var_4.SetTagText(var_6_1, arg_6_2, var_6_0)

			local var_6_2 = arg_5_0.emojiProxy

			if var_4.fliteNewEmojiDataByType(var_6_2)[var_6_0] then
				setActive = var_5

				var_5(arg_6_2:Find("point"), true)
			else
				setActive = var_5

				var_5(arg_6_2:Find("point"), false)
			end

			onToggle = var_5

			local var_6_3 = arg_5_0
			local var_6_4 = arg_6_2

			local function var_6_5(arg_7_0)
				if arg_7_0 then
					setActive = var_3_10001

					local var_7_0 = arg_5_0.emojiDots
					local var_7_1 = var_6_0

					ChatConst = var_3_10005

					var_3_10001(var_7_0, var_7_1 ~= var_3_10005.EmojiIcon)

					setActive = var_3_10001

					local var_7_2 = arg_5_0.emojiIconDots
					local var_7_3 = var_6_0

					ChatConst = var_5

					var_3_10001(var_7_2, var_7_3 == var_5.EmojiIcon)

					setActive = var_3_10001

					local var_7_4 = arg_5_0.emojiEvent
					local var_7_5 = var_6_0

					ChatConst = var_5

					var_3_10001(var_7_4, var_7_5 ~= var_5.EmojiIcon)

					setActive = var_3_10001

					local var_7_6 = arg_5_0.emojiIconEvent
					local var_7_7 = var_6_0

					ChatConst = var_5

					var_3_10001(var_7_6, var_7_7 == var_5.EmojiIcon)

					local var_7_8 = var_6_0

					ChatConst = var_3_10002

					if var_7_8 ~= var_3_10002.EmojiIcon then
						local var_7_9 = arg_5_0

						var_1.filter(var_7_9, var_6_0)
					else
						local var_7_10 = var_6_0

						ChatConst = var_2

						if var_7_10 == var_2.EmojiIcon then
							local var_7_11 = arg_5_0

							var_1.emojiIconFliter(var_7_11)
						end
					end

					local var_7_12 = var_0
					local var_7_13 = var_1.align

					ChatConst = var_4

					var_7_13(var_7_12, #var_4.EmojiTypes)
				end

				return
			end

			SFX_PANEL = var_2_10010

			var_5(var_6_3, var_6_4, var_6_5, var_2_10010)
		end

		return
	end)

	local var_5_1 = var_1
	local var_5_2 = var_1.align

	ChatConst = var_5

	var_5_2(var_5_1, #var_5.EmojiTypes)

	triggerToggle = var_5_2

	local var_5_3 = arg_5_0.emojiGroup

	var_5_2(var_4.GetChild(var_5_3, 0), true)

	return
end

function var_0_1.SetTagText(arg_8_0, arg_8_1, arg_8_2)
	setText = var_1_10003

	local var_8_0 = arg_8_1:Find("Text")

	i18n = var_1_10006

	var_1_10003(var_8_0, var_1_10006("emoji_type_" .. arg_8_2))

	return
end

function var_0_1.filter(arg_9_0, arg_9_1)
	_ = var_1_10002

	local var_9_0 = var_1_10002.map

	pg = var_1_10004

	local var_9_1 = var_9_0(var_1_10004.emoji_template.all, function(arg_10_0)
		pg = var_2_10001

		if var_2_10001.emoji_template[arg_10_0].achieve == 0 then
			pg = var_1

			return var_1.emoji_template[arg_10_0]
		end

		return
	end)
	local var_9_2 = arg_9_0.emojiProxy
	local var_9_3 = var_3.getNewEmojiIDLIst(var_9_2)
	local var_9_4 = arg_9_0.emojiProxy
	local var_9_5 = var_4.fliteNewEmojiDataByType(var_9_4)
	local var_9_6 = arg_9_0.emojiProxy
	local var_9_7 = var_5.getExEmojiDataByType(var_9_6, arg_9_1)

	pairs = var_9_4

	for iter_9_0, iter_9_1 in var_9_4(var_9_7) do
		table = var_1_10011

		var_1_10011.insert(var_9_1, 1, iter_9_1)
	end

	table = var_6

	var_6.sort(var_9_1, function(arg_11_0, arg_11_1)
		if arg_11_0.index == arg_11_1.index then
			return arg_11_0.id < arg_11_1.id
		end

		return arg_11_0.index < arg_11_1.index
	end)

	ChatConst = var_6

	local var_9_9

	if arg_9_1 == var_6.EmojiCommon then
		getProxy = var_6
		ChatProxy = var_8

		local var_9_8 = var_6(var_8)

		var_9_9 = var_6.getUsedEmoji(var_9_8)

		local var_9_10 = {}

		pairs = var_9_8

		for iter_9_2, iter_9_3 in var_9_8(var_9_9) do
			table = var_1_10014

			var_1_10014.insert(var_9_10, {
				id = iter_9_2,
				count = iter_9_3
			})
		end

		table = var_9

		var_9.sort(var_9_10, function(arg_12_0, arg_12_1)
			if arg_12_0.count == arg_12_1.count then
				return arg_12_0.id < arg_12_1.id
			end

			return arg_12_0.count > arg_12_1.count
		end)

		_ = var_9
		var_9_1 = var_9.map(var_9_10, function(arg_13_0)
			pg = var_2_10001

			return var_2_10001.emoji_template[arg_13_0.id]
		end)
	else
		_ = var_6
		var_9_1 = var_6.filter(var_9_1, function(arg_14_0)
			table = var_2_10001

			return var_2_10001.contains(arg_14_0.type, arg_9_1)
		end)
	end

	if var_9_5[arg_9_1] then
		pairs = var_6

		for iter_9_4, iter_9_5 in var_6(var_9_5[arg_9_1]) do
			table = var_1_10011

			var_1_10011.insert(var_9_1, 1, iter_9_5)
		end
	end

	local var_9_11

	if not arg_9_0.tplCaches then
		var_9_11 = {}
	end

	arg_9_0.tplCaches = var_9_11
	math = var_9_11

	local var_9_12 = var_9_11.ceil(#var_9_1 / var_0_1.PageEmojiNums)

	setActive = var_9_9

	local var_9_13 = arg_9_0.emojiEvent

	var_9_9(var_9.Find(var_9_13, "null_tpl"), var_9_12 == 0)

	for iter_9_6 = arg_9_0.emojiContent.childCount - 1, var_9_12, -1 do
		Destroy = var_9_13

		local var_9_14 = arg_9_0.emojiDots

		var_9_13(var_13.GetChild(var_9_14, iter_9_6))

		local var_9_15 = arg_9_0.emojiSnap
		local var_9_16 = var_9_13.RemoveChild(var_9_15, iter_9_6).transform

		Vector3 = var_9_15
		var_9_16.localScale = var_9_15.one

		local var_9_17 = var_9_13.transform

		var_12.SetParent(var_9_17, arg_9_0._tf, false)

		setActive = var_12

		var_12(var_9_13, false)
		arg_9_0:clearItem(var_9_13)

		table = var_12

		var_12.insert(arg_9_0.tplCaches, var_9_13)
	end

	for iter_9_7 = arg_9_0.emojiContent.childCount + 1, var_9_12 do
		local var_9_18

		if #arg_9_0.tplCaches > 0 then
			table = var_12
			var_9_18 = var_12.remove(arg_9_0.tplCaches)
		else
			Instantiate = var_12
			var_9_18 = var_12(arg_9_0.emojiItem)
		end

		setActive = var_12

		var_12(var_9_18, true)

		local var_9_19 = arg_9_0.emojiSnap

		var_12.AddChild(var_9_19, var_9_18)

		cloneTplTo = var_12

		var_12(arg_9_0.emojiDot, arg_9_0.emojiDots)
	end

	if var_9_12 > 1 then
		local var_9_20 = arg_9_0.emojiSnap

		var_7.GoToScreen(var_9_20, 0)
	end

	for iter_9_8 = 0, arg_9_0.emojiContent.childCount - 1 do
		local var_9_21 = arg_9_0.emojiContent
		local var_9_22 = var_11.GetChild(var_9_21, iter_9_8)

		arg_9_0:clearItem(var_9_22)

		_ = var_12

		local var_9_23 = var_12.slice(var_9_1, iter_9_8 * var_0_1.PageEmojiNums + 1, var_0_1.PageEmojiNums)

		GetComponent = var_9_21

		local var_9_24 = var_9_22

		typeof = var_16
		GridLayoutGroup = var_1_10018

		local var_9_25 = var_9_21(var_9_24, var_16(var_1_10018))

		UIItemList = var_14

		local var_9_26 = var_14.New(var_9_22, var_9_22:Find("face"))

		var_14.make(var_9_26, function(arg_15_0, arg_15_1, arg_15_2)
			local var_15_0 = var_9_23[arg_15_1 + 1]

			UIItemList = var_4

			if arg_15_0 == var_4.EventUpdate then
				PoolMgr = var_4

				local var_15_1 = var_4.GetInstance()

				var_4.GetPrefab(var_15_1, "emoji/" .. var_15_0.pic, var_15_0.pic, true, function(arg_16_0)
					IsNil = var_3_10001

					local var_16_1

					if not var_3_10001(arg_15_2) then
						arg_16_0.name = var_15_0.pic

						local var_16_0 = arg_16_0

						var_16_1 = arg_16_0.GetComponent
						typeof = var_3_10004
						Image = var_3_10006

						if var_16_1(var_16_0, var_3_10004(var_3_10006)) then
							var_16_1.preserveAspect = true
						end

						tf = var_3_10002

						local var_16_2 = var_3_10002(arg_16_0)

						Vector2 = var_16_0
						var_16_2.sizeDelta = var_16_0(var_9_25.cellSize.x, var_9_25.cellSize.y)
						tf = var_16_2

						local var_16_3 = var_16_2(arg_16_0)

						Vector2 = var_3
						var_16_3.anchoredPosition = var_3.zero

						if arg_16_0:GetComponent("Animator") then
							var_2.enabled = false
						end

						if arg_16_0:GetComponent("CriManaEffectUI") then
							var_2:Pause(true)
						end

						setParent = var_3

						var_3(arg_16_0, arg_15_2, false)

						table = var_3

						if var_3.contains(var_9_3, var_15_0.id) then
							cloneTplTo = var_3

							var_3(arg_9_0.newTag, arg_15_2, "newtag")

							local var_16_4 = arg_9_0.emojiProxy

							var_3.removeNewEmojiID(var_16_4, var_15_0.id)
						end
					else
						PoolMgr = var_16_1

						local var_16_5 = var_16_1.GetInstance()

						var_1.ReturnPrefab(var_16_5, "emoji/" .. var_15_0.pic, var_15_0.pic, arg_16_0)
					end

					return
				end)

				onButton = var_4

				local var_15_2 = arg_9_0
				local var_15_3 = arg_15_2

				local function var_15_4()
					getProxy = var_3_10000
					ChatProxy = var_3_10002

					local var_17_0 = var_3_10000(var_3_10002)

					var_0.addUsedEmoji(var_17_0, var_15_0.id)
					arg_9_0.contextData.callback(var_15_0.id)

					triggerButton = var_1

					var_1(arg_9_0._tf)

					return
				end

				SFX_PANEL = var_9

				var_4(var_15_2, var_15_3, var_15_4, var_9)
			end

			return
		end)
		var_14:align(#var_9_23)
	end

	return
end

function var_0_1.emojiIconFliter(arg_18_0)
	_ = var_1_10001

	local var_18_0 = var_1_10001.map

	pg = var_1_10003

	local var_18_1 = var_18_0(var_1_10003.emoji_small_template.all, function(arg_19_0)
		pg = var_2_10001

		return var_2_10001.emoji_small_template[arg_19_0]
	end)
	local var_18_2 = {}

	getProxy = var_3
	ChatProxy = var_1_10005

	local var_18_3 = var_3(var_1_10005)
	local var_18_4 = var_3.getUsedEmojiIcon(var_18_3)

	ipairs = var_1_10005

	for iter_18_0, iter_18_1 in var_1_10005(var_18_4) do
		table = var_1_10010

		var_1_10010.insert(var_18_2, var_18_1[iter_18_1])
	end

	math = var_5

	local var_18_5 = var_5.min(9, #var_18_1)

	math = var_6

	local var_18_6 = 1 + var_6.ceil((#var_18_1 - var_18_5) / var_0_1.True_Emoji_Num_Of_Page)

	for iter_18_2 = arg_18_0.emojiIconContent.childCount + 1, var_18_6 do
		cloneTplTo = var_1_10011

		var_1_10011(arg_18_0.emojiDot, arg_18_0.emojiIconDots)
	end

	for iter_18_3 = arg_18_0.emojiIconContent.childCount + 1, var_18_6 do
		Instantiate = var_1_10011
		var_1_10011 = var_1_10011(arg_18_0.emojiIconItem)
		tf = var_1_10012

		local var_18_7 = var_1_10012(var_1_10011)
		local var_18_8 = var_1_10012.Find(var_18_7, "TitleCommom")
		local var_18_9 = var_1_10012:Find("TitleAll")
		local var_18_10 = var_1_10012
		local var_18_11 = var_1_10012.Find(var_18_10, "CommomIconContainer")
		local var_18_12 = var_1_10012
		local var_18_13 = var_1_10012.Find(var_18_12, "AllIconContainer")

		GetComponent = var_18_10

		local var_18_14 = var_18_10(var_18_13, "GridLayoutGroup")

		if iter_18_3 == 1 then
			var_18_12 = var_18_11:Find("Icon")
			UIItemList = var_19

			local var_18_15 = var_19.New(var_18_11, var_18_12)

			var_19.make(var_18_15, function(arg_20_0, arg_20_1, arg_20_2)
				local var_20_0 = var_18_2[arg_20_1 + 1]

				UIItemList = var_4

				if arg_20_0 == var_4.EventUpdate then
					PoolMgr = var_4

					local var_20_1 = var_4.GetInstance()

					var_4.GetPrefab(var_20_1, "emoji/" .. var_20_0.pic, var_20_0.pic, true, function(arg_21_0)
						IsNil = var_3_10001

						if not var_3_10001(arg_20_2) then
							arg_21_0.name = var_20_0.pic
							setParent = var_1

							var_1(arg_21_0, arg_20_2, false)

							onButton = var_1

							local var_21_0 = arg_18_0
							local var_21_1 = arg_21_0

							local function var_21_2()
								if arg_18_0.contextData.emojiIconCallback then
									getProxy = var_0
									ChatProxy = var_4_10002

									local var_22_0 = var_0(var_4_10002)

									var_0.addUsedEmojiIcon(var_22_0, var_20_0.id)
									arg_18_0.contextData.emojiIconCallback(var_20_0.id)
								end

								return
							end

							SFX_PANEL = var_3_10006

							var_1(var_21_0, var_21_1, var_21_2, var_3_10006)
						end

						return
					end)
				end

				return
			end)
			var_19:align(#var_18_2)

			var_18_14.padding.left = 20

			local var_18_16 = var_18_13:Find("Icon")

			UIItemList = var_21

			local var_18_17 = var_21.New(var_18_13, var_18_16)

			var_21.make(var_18_17, function(arg_23_0, arg_23_1, arg_23_2)
				local var_23_0 = var_18_1[arg_23_1 + 1]

				UIItemList = var_4

				if arg_23_0 == var_4.EventUpdate then
					PoolMgr = var_4

					local var_23_1 = var_4.GetInstance()

					var_4.GetPrefab(var_23_1, "emoji/" .. var_23_0.pic, var_23_0.pic, true, function(arg_24_0)
						IsNil = var_3_10001

						if not var_3_10001(arg_23_2) then
							arg_24_0.name = var_23_0.pic
							setParent = var_1

							var_1(arg_24_0, arg_23_2, false)

							onButton = var_1

							local var_24_0 = arg_18_0
							local var_24_1 = arg_24_0

							local function var_24_2()
								if arg_18_0.contextData.emojiIconCallback then
									getProxy = var_0
									ChatProxy = var_4_10002

									local var_25_0 = var_0(var_4_10002)

									var_0.addUsedEmojiIcon(var_25_0, var_23_0.id)
									arg_18_0.contextData.emojiIconCallback(var_23_0.id)
								end

								return
							end

							SFX_PANEL = var_3_10006

							var_1(var_24_0, var_24_1, var_24_2, var_3_10006)
						end

						return
					end)
				end

				return
			end)
			var_21:align(var_18_5)
		else
			var_18_12 = var_0_1.True_Emoji_Num_Of_Page - var_0_1.Frequently_Used_Emoji_Num
			_ = var_19

			local var_18_18 = var_19.slice(var_18_1, (iter_18_3 - 2) * var_0_1.True_Emoji_Num_Of_Page + var_18_5 + 1, var_0_1.True_Emoji_Num_Of_Page)

			var_18_14.padding.left = 60

			local var_18_19 = var_18_13:Find("Icon")

			UIItemList = var_21

			local var_18_20 = var_21.New(var_18_13, var_18_19)

			var_21.make(var_18_20, function(arg_26_0, arg_26_1, arg_26_2)
				local var_26_0 = var_18_18[arg_26_1 + 1]

				UIItemList = var_4

				if arg_26_0 == var_4.EventUpdate then
					PoolMgr = var_4

					local var_26_1 = var_4.GetInstance()

					var_4.GetPrefab(var_26_1, "emoji/" .. var_26_0.pic, var_26_0.pic, true, function(arg_27_0)
						IsNil = var_3_10001

						if not var_3_10001(arg_26_2) then
							arg_27_0.name = var_26_0.pic
							setParent = var_1

							var_1(arg_27_0, arg_26_2, false)

							onButton = var_1

							local var_27_0 = arg_18_0
							local var_27_1 = arg_27_0

							local function var_27_2()
								if arg_18_0.contextData.emojiIconCallback then
									getProxy = var_0
									ChatProxy = var_4_10002

									local var_28_0 = var_0(var_4_10002)

									var_0.addUsedEmojiIcon(var_28_0, var_26_0.id)
									arg_18_0.contextData.emojiIconCallback(var_26_0.id)
								end

								return
							end

							SFX_PANEL = var_3_10006

							var_1(var_27_0, var_27_1, var_27_2, var_3_10006)
						end

						return
					end)
				end

				return
			end)
			var_21:align(#var_18_18)
		end

		setActive = var_18_12

		var_18_12(var_18_8, iter_18_3 == 1)

		setActive = var_18_12

		var_18_12(var_18_9, iter_18_3 == 1)

		setActive = var_18_12

		var_18_12(var_18_11, iter_18_3 == 1)

		setActive = var_18_12

		var_18_12(var_1_10011, true)

		local var_18_21 = arg_18_0.emojiIconSnap

		var_18.AddChild(var_18_21, var_1_10011)
	end

	return
end

function var_0_1.onBackPressed(arg_29_0)
	pg = var_1_10001

	local var_29_0 = var_1_10001.CriMgr.GetInstance()
	local var_29_1 = var_1.PlaySoundEffect_V3

	SFX_CANCEL = var_1_10004

	var_29_1(var_29_0, var_1_10004)

	triggerButton = var_29_1

	var_29_1(arg_29_0._tf)

	return
end

function var_0_1.clearItem(arg_30_0, arg_30_1)
	eachChild = var_1_10002

	var_1_10002(arg_30_1, function(arg_31_0)
		local var_31_0 = arg_31_0.childCount

		if 0 < var_31_0 then
			local var_31_1 = arg_31_0

			if arg_31_0.Find(var_31_1, "newtag") then
				Destroy = var_2

				var_2(var_1)
			end

			local var_31_2 = arg_31_0:GetChild(0).gameObject

			PoolMgr = var_31_1

			local var_31_3 = var_31_1.GetInstance()

			var_3.ReturnPrefab(var_31_3, "emoji/" .. var_31_2.name, var_31_2.name, var_31_2)
		end

		return
	end)

	return
end

function var_0_1.willExit(arg_32_0)
	eachChild = var_1_10001

	var_1_10001(arg_32_0.emojiContent, function(arg_33_0)
		local var_33_0 = arg_32_0

		var_1.clearItem(var_33_0, arg_33_0)

		return
	end)

	_ = var_1_10001

	var_1_10001.each(arg_32_0.tplCaches, function(arg_34_0)
		local var_34_0 = arg_32_0

		var_1.clearItem(var_34_0, arg_34_0)

		return
	end)

	arg_32_0.tplCaches = {}

	arg_32_0:UnOverlayPanel(arg_32_0._tf)

	return
end

return var_0_1
