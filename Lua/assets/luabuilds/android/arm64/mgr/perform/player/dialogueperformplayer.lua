local var_0_0 = class("DialoguePerformPlayer", import(".BasePerformPlayer"))

var_0_0.TYPEWRITE_SPEED = 0.05
var_0_0.TYPEWRITE_SPEED_UP = 0.01

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0.eventTipBig = arg_1_0._tf:Find("event_tip")
	arg_1_0.content = arg_1_0._tf:Find("content")
	arg_1_0.image = arg_1_0.content:Find("Image")
	arg_1_0.nameTF = arg_1_0.content:Find("name_bg")
	arg_1_0.nameText = arg_1_0.nameTF:Find("name")
	arg_1_0.next = arg_1_0.content:Find("next")
	arg_1_0.eventTipSmall = arg_1_0.content:Find("event_tip")
	arg_1_0.text = arg_1_0.content:Find("Text")
	arg_1_0.text2 = arg_1_0.content:Find("Text2")
	arg_1_0.resultTF = arg_1_0.content:Find("result")
	arg_1_0.resultTpl = arg_1_0.content:Find("tpl")
	arg_1_0.nextClickTF = arg_1_0._tf:Find("click")

	return
end

function var_0_0.Play(arg_2_0, arg_2_1, arg_2_2)
	setActive(arg_2_0.nextClickTF, true)
	arg_2_0:checkName()
	arg_2_0:Show()

	local var_2_0 = pg.child_word[arg_2_1.param[1]]

	assert(arg_2_1.param[1] and var_2_0, "child_word not exist id: " .. arg_2_1.param[1])
	setActive(arg_2_0.eventTipBig, arg_2_1.show_event == 1)

	if arg_2_1.show_event == 1 then
		onDelayTick(function()
			if arg_2_0._anim then
				arg_2_0._anim:Play()
			end

			arg_2_0:_play(arg_2_1, var_2_0, arg_2_2)

			return
		end, 0.66)
	else
		setActive(arg_2_0.eventTipBig, false)

		if arg_2_0._anim then
			arg_2_0._anim:Play()
		end

		arg_2_0:_play(arg_2_1, var_2_0, arg_2_2)
	end

	return
end

function var_0_0._play(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.speed = var_0_0.TYPEWRITE_SPEED

	setActive(arg_4_0.eventTipSmall, arg_4_1.show_event == 1)
	setActive(arg_4_0.next, arg_4_1.show_next == 1)

	if arg_4_1.show_drops == 1 then
		arg_4_0.drops = arg_4_1.drops or {}

		local var_4_0 = arg_4_2.char_type ~= EducateConst.WORD_TYPE_CHILD

		setActive(arg_4_0.text, not (arg_4_2.char_type ~= EducateConst.WORD_TYPE_CHILD))
		setActive(arg_4_0.text2, var_4_0)
		setActive(arg_4_0.image, not var_4_0)

		if not var_4_0 then
			setImageSprite(arg_4_0.image, LoadSprite("storyicon/" .. getProxy(EducateProxy):GetCharData():GetPaintingName()), true)
		end

		local var_4_2 = var_4_0 and arg_4_0.text2 or arg_4_0.text

		setText(var_4_0 and arg_4_0.text2 or arg_4_0.text, (string.gsub(arg_4_2.word, "$1", arg_4_0.callName)))

		local var_4_3 = GetComponent(var_4_2, typeof(Typewriter))

		if arg_4_2.char_type == EducateConst.WORD_TYPE_ASIDE then
			setActive(arg_4_0.nameTF, false)
		else
			setActive(arg_4_0.nameTF, true)

			local var_4_4 = ""

			if arg_4_2.char_type == EducateConst.WORD_TYPE_CHILD then
				var_4_4 = arg_4_0.name
			elseif arg_4_2.char_type == EducateConst.WORD_TYPE_PLAYER then
				var_4_4 = arg_4_0.playerName
			end

			setText(arg_4_0.nameText, var_4_4)
		end

		function var_4_3.endFunc()
			setActive(arg_4_0.resultTF, true)

			for iter_5_0 = 1, #arg_4_0.drops do
				table.insert({}, function(arg_6_0)
					arg_4_0.resultTF = arg_4_0.content:Find("result")
					arg_4_0.resultTpl = arg_4_0.content:Find("tpl")

					local var_6_0 = arg_4_0.drops[iter_5_0]
					local var_6_1 = iter_5_0 < arg_4_0.resultTF.childCount and arg_4_0.resultTF:GetChild(iter_5_0 - 1) or cloneTplTo(arg_4_0.resultTpl, arg_4_0.resultTF)

					if arg_4_0.drops[iter_5_0].type == EducateConst.DROP_TYPE_BUFF then
						setActive(var_6_1:Find("icon"), false)
						setText(var_6_1:Find("name"), pg.child_buff[var_6_0.id].name)
						setText(var_6_1:Find("value"), "")
					else
						setActive(var_6_1:Find("icon"), true)
						EducateHelper.UpdateDropShowForAttr(var_6_1, var_6_0)
					end

					setActive(var_6_1, true)
					var_6_1:GetComponent(typeof(Animation)):Play("anim_educate_attr_in")
					onDelayTick(function()
						arg_6_0()

						return
					end, 0.033)

					return
				end)
			end

			seriesAsync({}, function()
				arg_4_0.twId = LeanTween.delayedCall(1, System.Action(function()
					setActive(arg_4_0.resultTF, false)
					eachChild(arg_4_0.resultTF, function(arg_10_0)
						setActive(arg_10_0, false)

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

		var_4_3:setSpeed(arg_4_0.speed)
		var_4_3:Play()
		onButton(arg_4_0, arg_4_0.nextClickTF, function()
			if arg_4_0.speed == var_0_0.TYPEWRITE_SPEED_UP then
				if arg_4_0.twId then
					LeanTween.cancel(arg_4_0.twId)

					arg_4_0.twId = nil
				end

				setActive(arg_4_0.resultTF, false)
				eachChild(arg_4_0.resultTF, function(arg_12_0)
					setActive(arg_12_0, false)

					return
				end)

				if arg_4_3 then
					arg_4_3()
				end
			else
				arg_4_0.speed = var_0_0.TYPEWRITE_SPEED_UP

				var_4_3:setSpeed(arg_4_0.speed)
			end

			return
		end)

		return
	end
end

function var_0_0.checkName(arg_13_0)
	arg_13_0.callName = arg_13_0.callName or getProxy(EducateProxy):GetCharData():GetCallName()
	arg_13_0.name = arg_13_0.name or getProxy(EducateProxy):GetCharData():GetName()
	arg_13_0.playerName = arg_13_0.playerName or getProxy(PlayerProxy):getRawData():GetName()

	return
end

function var_0_0.Clear(arg_14_0)
	setText(arg_14_0.text, "")
	setText(arg_14_0.text2, "")
	setActive(arg_14_0.eventTipBig, false)
	setActive(arg_14_0.eventTipSmall, false)
	arg_14_0:Hide()

	return
end

function var_0_0.Dispose(arg_15_0)
	if arg_15_0.twId then
		LeanTween.cancel(arg_15_0.twId)

		arg_15_0.twId = nil
	end

	pg.DelegateInfo.Dispose(arg_15_0)

	return
end

return var_0_0
