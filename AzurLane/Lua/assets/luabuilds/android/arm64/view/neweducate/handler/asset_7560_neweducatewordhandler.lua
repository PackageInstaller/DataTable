class = var_0_10000

local var_0_0 = var_0_10000("NewEducateWordHandler")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pg = var_1_10002

	var_1_10002.DelegateInfo.New(arg_1_0)

	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_2.GetComponent

	typeof = var_1_10005
	Animation = var_1_10007
	arg_1_0._anim = var_1_1(var_1_0, var_1_10005(var_1_10007))

	local var_1_2 = arg_1_0._tf

	arg_1_0.content = var_2.Find(var_1_2, "content")

	local var_1_3 = arg_1_0.content

	arg_1_0.image = var_2.Find(var_1_3, "Image")

	local var_1_4 = arg_1_0.content

	arg_1_0.nameTF = var_2.Find(var_1_4, "name_bg")

	local var_1_5 = arg_1_0.nameTF

	arg_1_0.nameText = var_2.Find(var_1_5, "name")

	local var_1_6 = arg_1_0.content

	arg_1_0.next = var_2.Find(var_1_6, "next")

	local var_1_7 = arg_1_0.content

	arg_1_0.text = var_2.Find(var_1_7, "Text")

	local var_1_8 = arg_1_0.content

	arg_1_0.text2 = var_2.Find(var_1_8, "Text2")

	local var_1_9 = arg_1_0.content

	arg_1_0.resultTF = var_2.Find(var_1_9, "result")

	local var_1_10 = arg_1_0.content

	arg_1_0.resultTpl = var_2.Find(var_1_10, "tpl")

	local var_1_11 = arg_1_0._tf

	arg_1_0.nextClickTF = var_2.Find(var_1_11, "click")
	NewEducateConst = var_2
	arg_1_0.speed = var_2.TYPEWRITE_SPEED

	return
end

function var_0_0.Play(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	NewEducateConst = var_1_10006
	arg_2_0.speed = var_1_10006.TYPEWRITE_SPEED
	pg = var_6

	local var_2_0 = var_6.child2_word[arg_2_1]

	assert = var_1_10007

	var_1_10007(var_2_0, "child2_word not exist id: " .. arg_2_1)
	arg_2_0:CheckName()

	isActive = var_7

	local var_2_1 = not var_7(arg_2_0._go)

	setActive = var_1_10008

	var_1_10008(arg_2_0._go, true)

	if var_2_1 and arg_2_0._anim then
		local var_2_2 = arg_2_0._anim

		var_1_10008.Play(var_2_2)
	end

	arg_2_0.needClick = arg_2_5
	setActive = var_1_10008

	var_1_10008(arg_2_0.next, arg_2_4)

	arg_2_0.drops = arg_2_3 or {}

	local var_2_3 = var_2_0.char_type

	NewEducateConst = var_9

	local var_2_5

	if var_2_3 == var_9.WORD_TYPE.CHILD then
		local var_2_4 = var_2_0.char_type

		NewEducateConst = var_9

		if var_2_4 ~= var_9.WORD_TYPE.HIDE_IMAGE then
			var_2_5 = false

			goto label_2_0
		end
	end

	var_2_5 = true

	::label_2_0::

	setActive = var_9

	var_9(arg_2_0.text, not var_2_5)

	setActive = var_9

	var_9(arg_2_0.text2, var_2_5)

	setActive = var_9

	var_9(arg_2_0.image, not var_2_5)

	local var_2_6, var_2_8

	if not var_2_5 then
		getProxy = var_9
		NewEducateProxy = var_2_6
		var_2_6 = var_9(var_2_6)
		var_2_6 = var_9.GetCurChar(var_2_6)

		local var_2_7 = var_9.GetPaintingName(var_2_6)

		setImageSprite = var_10
		var_2_8 = arg_2_0.image
		LoadSprite = var_1_10013

		var_10(var_2_8, var_1_10013("storyicon/" .. var_2_7), true)
	end

	local var_2_9

	if not var_2_5 or not arg_2_0.text2 then
		var_2_9 = arg_2_0.text
	end

	local var_2_10 = var_2_0.word

	string = var_2_6

	local var_2_11 = var_2_6.gsub(var_2_10, "$1", arg_2_0.callName)

	setText = var_11

	var_11(var_2_9, var_2_11)

	setActive = var_11

	local var_2_12 = arg_2_0.nameTF
	local var_2_13 = var_2_0.char_type

	NewEducateConst = var_15

	var_11(var_2_12, var_2_13 ~= var_15.WORD_TYPE.ASIDE)

	local var_2_14 = var_2_0.char_type

	NewEducateConst = var_2_8

	if var_2_14 ~= var_2_8.WORD_TYPE.ASIDE then
		var_2_14 = ""

		local var_2_15 = var_2_0.char_type

		NewEducateConst = var_2_12

		if var_2_15 ~= var_2_12.WORD_TYPE.CHILD then
			var_2_15 = var_2_0.char_type
			NewEducateConst = var_13

			if var_2_15 == var_13.WORD_TYPE.HIDE_IMAGE then
				var_2_14 = arg_2_0.name
			else
				var_2_15 = var_2_0.char_type
				NewEducateConst = var_13

				if var_2_15 == var_13.WORD_TYPE.PLAYER then
					var_2_14 = arg_2_0.playerName
				end
			end

			setText = var_2_15

			var_2_15(arg_2_0.nameText, var_2_14)

			GetComponent = var_2_14

			local var_2_16 = var_2_9

			typeof = var_14
			Typewriter = var_1_10016

			local var_2_17 = var_2_14(var_2_16, var_14(var_1_10016))

			function var_2_17.endFunc()
				setActive = var_2_10000

				var_2_10000(arg_2_0.resultTF, true)

				local var_3_0 = {}

				for iter_3_0 = 1, #arg_2_0.drops do
					table = var_2_10005

					var_2_10005.insert(var_3_0, function(arg_4_0)
						local var_4_0 = arg_2_0.drops[iter_3_0]

						if iter_3_0 < arg_2_0.resultTF.childCount then
							var_3_10004 = arg_2_0.resultTF

							local var_4_1

							if not var_4_1.GetChild(var_3_10004, iter_3_0 - 1) then
								cloneTplTo = var_4_1
								var_4_1 = var_4_1(arg_2_0.resultTpl, arg_2_0.resultTF)
							end

							local var_4_2 = var_4_0.type

							NewEducateConst = var_3_10004

							if var_4_2 == var_3_10004.DROP_TYPE.BUFF then
								setActive = var_4_2

								var_4_2(var_4_1:Find("icon"), false)

								setText = var_4_2

								local var_4_3 = var_4_1:Find("name")

								pg = var_6

								var_4_2(var_4_3, var_6.child2_benefit_list[var_4_0.id].name)

								setText = var_4_2

								var_4_2(var_4_1:Find("value"), "")
							else
								setActive = var_4_2

								var_4_2(var_4_1:Find("icon"), true)

								NewEducateHelper = var_4_2

								var_4_2.UpdateVectorItem(var_4_1, var_4_0)
							end

							setActive = var_4_2

							var_4_2(var_4_1, true)

							local var_4_4 = var_4_1
							local var_4_5 = var_4_1.GetComponent

							typeof = var_6
							Animation = var_3_10008

							local var_4_6 = var_4_5(var_4_4, var_6(var_3_10008))

							var_3.Play(var_4_6, "anim_educate_attr_in")

							onDelayTick = var_4

							var_4(function()
								arg_4_0()

								return
							end, 0.033)

							return
						end
					end)
				end

				seriesAsync = var_1

				var_1(var_3_0, function()
					if not arg_2_0.needClick then
						onDelayTick = var_0

						var_0(function()
							setActive = var_4_10000

							var_4_10000(arg_2_0.resultTF, false)

							eachChild = var_4_10000

							var_4_10000(arg_2_0.resultTF, function(arg_8_0)
								setActive = var_5_10001

								var_5_10001(arg_8_0, false)

								return
							end)

							existCall = var_4_10000

							var_4_10000(arg_2_2)

							return
						end, 1)
					else
						onButton = var_0

						local var_6_0 = arg_2_0
						local var_6_1 = arg_2_0.nextClickTF

						local function var_6_2()
							removeOnButton = var_4_10000

							var_4_10000(arg_2_0.nextClickTF)

							existCall = var_4_10000

							var_4_10000(arg_2_2)

							return
						end

						SFX_PANEL = var_3_10005

						var_0(var_6_0, var_6_1, var_6_2, var_3_10005)
					end

					return
				end)

				return
			end

			var_2_17:setSpeed(arg_2_0.speed)
			var_2_17:Play()

			local var_2_18 = arg_2_0.speed

			NewEducateConst = var_2_16

			if var_2_18 ~= var_2_16.TYPEWRITE_SPEED_UP then
				onButton = var_2_18

				var_2_18(arg_2_0, arg_2_0.nextClickTF, function()
					removeOnButton = var_2_10000

					var_2_10000(arg_2_0.nextClickTF)

					local var_10_0 = arg_2_0

					NewEducateConst = var_2_10001
					var_10_0.speed = var_2_10001.TYPEWRITE_SPEED_UP

					local var_10_1 = var_2_17

					var_0.setSpeed(var_10_1, arg_2_0.speed)

					return
				end)
			end

			return
		end
	end
end

function var_0_0.PlayWordIds(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0:CheckName()

	isActive = var_3

	local var_11_0 = not var_3(arg_11_0._go)

	setActive = var_1_10004

	var_1_10004(arg_11_0._go, true)

	if var_11_0 and arg_11_0._anim then
		local var_11_1 = arg_11_0._anim

		var_4.Play(var_11_1)
	end

	arg_11_0.needClick = true
	setActive = var_4

	var_4(arg_11_0.next, false)

	local var_11_2 = true

	setActive = var_5

	var_5(arg_11_0.text, not var_11_2)

	setActive = var_5

	var_5(arg_11_0.text2, var_11_2)

	setActive = var_5

	var_5(arg_11_0.image, not var_11_2)

	setActive = var_5

	var_5(arg_11_0.nameTF, false)

	setActive = var_5

	var_5(arg_11_0.resultTF, false)

	local var_11_3

	if not var_11_2 or not arg_11_0.text2 then
		var_11_3 = arg_11_0.text
	end

	local var_11_4 = {}

	ipairs = var_7

	for iter_11_0, iter_11_1 in var_7(arg_11_1) do
		table = var_1_10012

		var_1_10012.insert(var_11_4, function(arg_12_0)
			local var_12_0 = arg_11_0

			NewEducateConst = var_2_10002
			var_12_0.speed = var_2_10002.TYPEWRITE_SPEED
			pg = var_12_0

			local var_12_1 = var_12_0.child2_word[iter_11_1].word

			string = var_2

			local var_12_2 = var_2.gsub(var_12_1, "$1", arg_11_0.callName)

			setText = var_2

			var_2(var_11_3, var_12_2)

			setActive = var_2

			var_2(arg_11_0.next, iter_11_0 ~= #arg_11_1)

			GetComponent = var_2

			local var_12_3 = var_11_3

			typeof = var_5
			Typewriter = var_2_10007

			local var_12_4 = var_2(var_12_3, var_5(var_2_10007))

			function var_12_4.endFunc()
				if not arg_11_0.needClick then
					onDelayTick = var_0

					var_0(function()
						arg_12_0()

						return
					end, 1)
				else
					onButton = var_0

					local var_13_0 = arg_11_0
					local var_13_1 = arg_11_0.nextClickTF

					local function var_13_2()
						removeOnButton = var_4_10000

						var_4_10000(arg_11_0.nextClickTF)
						arg_12_0()

						return
					end

					SFX_PANEL = var_3_10005

					var_0(var_13_0, var_13_1, var_13_2, var_3_10005)
				end

				return
			end

			var_12_4:setSpeed(arg_11_0.speed)
			var_12_4:Play()

			local var_12_5 = arg_11_0.speed

			NewEducateConst = var_12_3

			if var_12_5 ~= var_12_3.TYPEWRITE_SPEED_UP then
				onButton = var_12_5

				var_12_5(arg_11_0, arg_11_0.nextClickTF, function()
					removeOnButton = var_3_10000

					var_3_10000(arg_11_0.nextClickTF)

					local var_16_0 = arg_11_0

					NewEducateConst = var_3_10001
					var_16_0.speed = var_3_10001.TYPEWRITE_SPEED_UP

					local var_16_1 = var_12_4

					var_0.setSpeed(var_16_1, arg_11_0.speed)

					return
				end)
			end

			return
		end)
	end

	seriesAsync = var_7

	var_7(var_11_4, function()
		existCall = var_2_10000

		var_2_10000(arg_11_2)

		return
	end)

	return
end

function var_0_0.CheckName(arg_18_0)
	if not arg_18_0.callName then
		getProxy = var_1
		NewEducateProxy = var_1_10003
		var_1_10003 = var_1(var_1_10003)
		var_1_10003 = var_1.GetCurChar(var_1_10003)
		arg_18_0.callName = var_1.GetCallName(var_1_10003)
	end

	if not arg_18_0.name then
		getProxy = var_1
		NewEducateProxy = var_1_10003
		var_1_10003 = var_1(var_1_10003)
		var_1_10003 = var_1.GetCurChar(var_1_10003)
		arg_18_0.name = var_1.GetName(var_1_10003)
	end

	if not arg_18_0.playerName then
		getProxy = var_1
		PlayerProxy = var_1_10003

		local var_18_0 = var_1(var_1_10003)
		local var_18_1 = var_1.getRawData(var_18_0)

		arg_18_0.playerName = var_1.GetName(var_18_1)
	end

	return
end

function var_0_0.Reset(arg_19_0)
	setActive = var_1_10001

	var_1_10001(arg_19_0._go, false)

	removeOnButton = var_1_10001

	var_1_10001(arg_19_0.nextClickTF)

	NewEducateConst = var_1_10001
	arg_19_0.speed = var_1_10001.TYPEWRITE_SPEED

	return
end

function var_0_0.UpdateCallName(arg_20_0)
	getProxy = var_1_10001
	NewEducateProxy = var_1_10003

	local var_20_0 = var_1_10001(var_1_10003)
	local var_20_1 = var_1.GetCurChar(var_20_0)

	arg_20_0.callName = var_1.GetCallName(var_20_1)

	return
end

function var_0_0.Destroy(arg_21_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_21_0)

	return
end

return var_0_0
