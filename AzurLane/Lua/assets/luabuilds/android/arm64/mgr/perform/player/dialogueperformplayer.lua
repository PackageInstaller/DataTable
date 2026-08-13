class = var_0_10000

local var_0_0 = "DialoguePerformPlayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BasePerformPlayer"))

var_0_1.TYPEWRITE_SPEED = 0.05
var_0_1.TYPEWRITE_SPEED_UP = 0.01

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	pg = var_2

	var_2.DelegateInfo.New(arg_1_0)

	local var_1_0 = arg_1_0._tf

	arg_1_0.eventTipBig = var_2.Find(var_1_0, "event_tip")

	local var_1_1 = arg_1_0._tf

	arg_1_0.content = var_2.Find(var_1_1, "content")

	local var_1_2 = arg_1_0.content

	arg_1_0.image = var_2.Find(var_1_2, "Image")

	local var_1_3 = arg_1_0.content

	arg_1_0.nameTF = var_2.Find(var_1_3, "name_bg")

	local var_1_4 = arg_1_0.nameTF

	arg_1_0.nameText = var_2.Find(var_1_4, "name")

	local var_1_5 = arg_1_0.content

	arg_1_0.next = var_2.Find(var_1_5, "next")

	local var_1_6 = arg_1_0.content

	arg_1_0.eventTipSmall = var_2.Find(var_1_6, "event_tip")

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

	return
end

function var_0_1.Play(arg_2_0, arg_2_1, arg_2_2)
	setActive = var_1_10003

	var_1_10003(arg_2_0.nextClickTF, true)
	arg_2_0:checkName()

	local var_2_0 = arg_2_0

	arg_2_0.Show(var_2_0)

	local var_2_1 = arg_2_1.param[1]

	pg = var_1_10004

	local var_2_2 = var_1_10004.child_word[var_2_1]

	assert = var_2_0

	var_2_0(var_2_1 and var_2_2, "child_word not exist id: " .. var_2_1)

	setActive = var_2_0

	var_2_0(arg_2_0.eventTipBig, arg_2_1.show_event == 1)

	if arg_2_1.show_event == 1 then
		onDelayTick = var_5

		var_5(function()
			if arg_2_0._anim then
				local var_3_0 = arg_2_0._anim

				var_0.Play(var_3_0)
			end

			local var_3_1 = arg_2_0

			var_0._play(var_3_1, arg_2_1, var_2_2, arg_2_2)

			return
		end, 0.66)
	else
		setActive = var_5

		var_5(arg_2_0.eventTipBig, false)

		if arg_2_0._anim then
			local var_2_3 = arg_2_0._anim

			var_5.Play(var_2_3)
		end

		arg_2_0:_play(arg_2_1, var_2_2, arg_2_2)
	end

	return
end

function var_0_1._play(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.speed = var_0_1.TYPEWRITE_SPEED
	setActive = var_4

	var_4(arg_4_0.eventTipSmall, arg_4_1.show_event == 1)

	setActive = var_4

	var_4(arg_4_0.next, arg_4_1.show_next == 1)

	local var_4_0

	if arg_4_1.show_drops ~= 1 or not arg_4_1.drops then
		var_4_0 = {}
	end

	arg_4_0.drops = var_4_0

	local var_4_1 = arg_4_2.char_type

	EducateConst = var_1_10005

	local var_4_2 = var_4_1 ~= var_1_10005.WORD_TYPE_CHILD
	local var_4_3 = arg_4_0.text

	setActive = var_6

	var_6(arg_4_0.text, not var_4_2)

	setActive = var_6

	var_6(arg_4_0.text2, var_4_2)

	setActive = var_6

	var_6(arg_4_0.image, not var_4_2)

	if not var_4_2 then
		getProxy = var_6
		EducateProxy = var_8

		local var_4_4 = var_6(var_8)
		local var_4_5 = var_6.GetCharData(var_4_4)
		local var_4_6 = var_6.GetPaintingName(var_4_5)

		setImageSprite = var_7

		local var_4_7 = arg_4_0.image

		LoadSprite = var_1_10010

		var_7(var_4_7, var_1_10010("storyicon/" .. var_4_6), true)
	end

	local var_4_8 = var_4_2 and arg_4_0.text2 or arg_4_0.text
	local var_4_9 = arg_4_2.word

	string = var_7

	local var_4_10 = var_7.gsub(var_4_9, "$1", arg_4_0.callName)

	setText = var_7

	var_7(var_4_8, var_4_10)

	GetComponent = var_7

	local var_4_11 = var_4_8

	typeof = var_10
	Typewriter = var_1_10012

	local var_4_12 = var_7(var_4_11, var_10(var_1_10012))
	local var_4_13 = arg_4_2.char_type

	EducateConst = var_4_11

	if var_4_13 == var_4_11.WORD_TYPE_ASIDE then
		setActive = var_4_13

		var_4_13(arg_4_0.nameTF, false)
	else
		setActive = var_4_13

		var_4_13(arg_4_0.nameTF, true)

		local var_4_14 = ""
		local var_4_15 = arg_4_2.char_type

		EducateConst = var_10

		if var_4_15 == var_10.WORD_TYPE_CHILD then
			var_4_14 = arg_4_0.name
		else
			var_4_15 = arg_4_2.char_type
			EducateConst = var_10

			if var_4_15 == var_10.WORD_TYPE_PLAYER then
				var_4_14 = arg_4_0.playerName
			end
		end

		setText = var_4_15

		var_4_15(arg_4_0.nameText, var_4_14)
	end

	function var_4_12.endFunc()
		setActive = var_2_10000

		var_2_10000(arg_4_0.resultTF, true)

		local var_5_0 = {}

		for iter_5_0 = 1, #arg_4_0.drops do
			table = var_2_10005

			var_2_10005.insert(var_5_0, function(arg_6_0)
				local var_6_0 = arg_4_0
				local var_6_1 = arg_4_0.content

				var_6_0.resultTF = var_2.Find(var_6_1, "result")

				local var_6_2 = arg_4_0
				local var_6_3 = arg_4_0.content

				var_6_2.resultTpl = var_2.Find(var_6_3, "tpl")

				local var_6_4 = arg_4_0.drops[iter_5_0]

				if iter_5_0 < arg_4_0.resultTF.childCount then
					var_6_3 = arg_4_0.resultTF

					local var_6_5

					if not var_6_5.GetChild(var_6_3, iter_5_0 - 1) then
						cloneTplTo = var_6_5
						var_6_5 = var_6_5(arg_4_0.resultTpl, arg_4_0.resultTF)
					end

					local var_6_6 = var_6_4.type

					EducateConst = var_6_3

					if var_6_6 == var_6_3.DROP_TYPE_BUFF then
						setActive = var_6_6

						var_6_6(var_6_5:Find("icon"), false)

						setText = var_6_6

						local var_6_7 = var_6_5:Find("name")

						pg = var_6

						var_6_6(var_6_7, var_6.child_buff[var_6_4.id].name)

						setText = var_6_6

						var_6_6(var_6_5:Find("value"), "")
					else
						setActive = var_6_6

						var_6_6(var_6_5:Find("icon"), true)

						EducateHelper = var_6_6

						var_6_6.UpdateDropShowForAttr(var_6_5, var_6_4)
					end

					setActive = var_6_6

					var_6_6(var_6_5, true)

					local var_6_8 = var_6_5
					local var_6_9 = var_6_5.GetComponent

					typeof = var_6
					Animation = var_3_10008

					local var_6_10 = var_6_9(var_6_8, var_6(var_3_10008))

					var_3.Play(var_6_10, "anim_educate_attr_in")

					onDelayTick = var_4

					var_4(function()
						arg_6_0()

						return
					end, 0.033)

					return
				end
			end)
		end

		seriesAsync = var_1

		var_1(var_5_0, function()
			local var_8_0 = arg_4_0

			LeanTween = var_3_10001

			local var_8_1 = var_3_10001.delayedCall
			local var_8_2 = 1

			System = var_3_10004
			var_8_0.twId = var_8_1(var_8_2, var_3_10004.Action(function()
				setActive = var_4_10000

				var_4_10000(arg_4_0.resultTF, false)

				eachChild = var_4_10000

				var_4_10000(arg_4_0.resultTF, function(arg_10_0)
					setActive = var_5_10001

					var_5_10001(arg_10_0, false)

					return
				end)

				if arg_4_3 then
					arg_4_3()
				end

				return
			end)).uniqueId

			return
		end)

		return
	end

	var_4_12:setSpeed(arg_4_0.speed)
	var_4_12:Play()

	onButton = var_8

	var_8(arg_4_0, arg_4_0.nextClickTF, function()
		if arg_4_0.speed == var_0_1.TYPEWRITE_SPEED_UP then
			local var_11_0

			if arg_4_0.twId then
				LeanTween = var_11_0

				var_11_0.cancel(arg_4_0.twId)

				var_11_0 = arg_4_0
				var_11_0.twId = nil
			end

			setActive = var_11_0

			var_11_0(arg_4_0.resultTF, false)

			eachChild = var_11_0

			var_11_0(arg_4_0.resultTF, function(arg_12_0)
				setActive = var_3_10001

				var_3_10001(arg_12_0, false)

				return
			end)

			if arg_4_3 then
				arg_4_3()
			end
		else
			arg_4_0.speed = var_0_1.TYPEWRITE_SPEED_UP

			local var_11_1 = var_4_12

			var_0.setSpeed(var_11_1, arg_4_0.speed)
		end

		return
	end)

	return
end

function var_0_1.checkName(arg_13_0)
	if not arg_13_0.callName then
		getProxy = var_1
		EducateProxy = var_1_10003
		var_1_10003 = var_1(var_1_10003)
		var_1_10003 = var_1.GetCharData(var_1_10003)
		arg_13_0.callName = var_1.GetCallName(var_1_10003)
	end

	if not arg_13_0.name then
		getProxy = var_1
		EducateProxy = var_1_10003
		var_1_10003 = var_1(var_1_10003)
		var_1_10003 = var_1.GetCharData(var_1_10003)
		arg_13_0.name = var_1.GetName(var_1_10003)
	end

	if not arg_13_0.playerName then
		getProxy = var_1
		PlayerProxy = var_1_10003

		local var_13_0 = var_1(var_1_10003)
		local var_13_1 = var_1.getRawData(var_13_0)

		arg_13_0.playerName = var_1.GetName(var_13_1)
	end

	return
end

function var_0_1.Clear(arg_14_0)
	setText = var_1_10001

	var_1_10001(arg_14_0.text, "")

	setText = var_1_10001

	var_1_10001(arg_14_0.text2, "")

	setActive = var_1_10001

	var_1_10001(arg_14_0.eventTipBig, false)

	setActive = var_1_10001

	var_1_10001(arg_14_0.eventTipSmall, false)
	arg_14_0:Hide()

	return
end

function var_0_1.Dispose(arg_15_0)
	if arg_15_0.twId then
		LeanTween = var_1

		var_1.cancel(arg_15_0.twId)

		arg_15_0.twId = nil
	end

	pg = var_1

	var_1.DelegateInfo.Dispose(arg_15_0)

	return
end

return var_0_1
