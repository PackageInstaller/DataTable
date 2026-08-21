local var_0_0 = class("NewEducateWordHandler")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0._anim = arg_1_0._tf:GetComponent(typeof(Animation))
	arg_1_0.content = arg_1_0._tf:Find("content")
	arg_1_0.image = arg_1_0.content:Find("Image")
	arg_1_0.nameTF = arg_1_0.content:Find("name_bg")
	arg_1_0.nameText = arg_1_0.nameTF:Find("name")
	arg_1_0.next = arg_1_0.content:Find("next")
	arg_1_0.text = arg_1_0.content:Find("Text")
	arg_1_0.text2 = arg_1_0.content:Find("Text2")
	arg_1_0.resultTF = arg_1_0.content:Find("result")
	arg_1_0.resultTpl = arg_1_0.content:Find("tpl")
	arg_1_0.nextClickTF = arg_1_0._tf:Find("click")
	arg_1_0.speed = NewEducateConst.TYPEWRITE_SPEED

	return
end

function var_0_0.Play(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	arg_2_0.speed = NewEducateConst.TYPEWRITE_SPEED

	local var_2_0 = pg.child2_word[arg_2_1]

	assert(pg.child2_word[arg_2_1], "child2_word not exist id: " .. arg_2_1)
	arg_2_0:CheckName()
	setActive(arg_2_0._go, true)

	if not isActive(arg_2_0._go) and arg_2_0._anim then
		arg_2_0._anim:Play()
	end

	arg_2_0.needClick = arg_2_5

	setActive(arg_2_0.next, arg_2_4)

	arg_2_0.drops = arg_2_3 or {}

	local var_2_1 = var_2_0.char_type ~= NewEducateConst.WORD_TYPE.CHILD or var_2_0.char_type == NewEducateConst.WORD_TYPE.HIDE_IMAGE

	setActive(arg_2_0.text, not (var_2_0.char_type ~= NewEducateConst.WORD_TYPE.CHILD or var_2_0.char_type == NewEducateConst.WORD_TYPE.HIDE_IMAGE))
	setActive(arg_2_0.text2, var_2_1)
	setActive(arg_2_0.image, not var_2_1)

	if not var_2_1 then
		setImageSprite(arg_2_0.image, LoadSprite("storyicon/" .. getProxy(NewEducateProxy):GetCurChar():GetPaintingName()), true)
	end

	if var_2_1 then
		local var_2_2 = arg_2_0.text2 or arg_2_0.text

		setText(var_2_2, (string.gsub(var_2_0.word, "$1", arg_2_0.callName)))
		setActive(arg_2_0.nameTF, var_2_0.char_type ~= NewEducateConst.WORD_TYPE.ASIDE)

		if var_2_0.char_type ~= NewEducateConst.WORD_TYPE.ASIDE then
			local var_2_3 = ""

			if var_2_0.char_type == NewEducateConst.WORD_TYPE.CHILD or var_2_0.char_type == NewEducateConst.WORD_TYPE.HIDE_IMAGE then
				var_2_3 = arg_2_0.name
			elseif var_2_0.char_type == NewEducateConst.WORD_TYPE.PLAYER then
				var_2_3 = arg_2_0.playerName
			end

			setText(arg_2_0.nameText, var_2_3)
		end

		local var_2_4 = GetComponent(var_2_2, typeof(Typewriter))

		function var_2_4.endFunc()
			setActive(arg_2_0.resultTF, true)

			for iter_3_0 = 1, #arg_2_0.drops do
				table.insert({}, function(arg_4_0)
					local var_4_0 = arg_2_0.drops[iter_3_0]
					local var_4_1 = iter_3_0 < arg_2_0.resultTF.childCount and arg_2_0.resultTF:GetChild(iter_3_0 - 1) or cloneTplTo(arg_2_0.resultTpl, arg_2_0.resultTF)

					if arg_2_0.drops[iter_3_0].type == NewEducateConst.DROP_TYPE.BUFF then
						setActive(var_4_1:Find("icon"), false)
						setText(var_4_1:Find("name"), pg.child2_benefit_list[var_4_0.id].name)
						setText(var_4_1:Find("value"), "")
					else
						setActive(var_4_1:Find("icon"), true)
						NewEducateHelper.UpdateVectorItem(var_4_1, var_4_0)
					end

					setActive(var_4_1, true)
					var_4_1:GetComponent(typeof(Animation)):Play("anim_educate_attr_in")
					onDelayTick(function()
						arg_4_0()

						return
					end, 0.033)

					return
				end)
			end

			seriesAsync({}, function()
				if not arg_2_0.needClick then
					onDelayTick(function()
						setActive(arg_2_0.resultTF, false)
						eachChild(arg_2_0.resultTF, function(arg_8_0)
							setActive(arg_8_0, false)

							return
						end)
						existCall(arg_2_2)

						return
					end, 1)
				else
					onButton(arg_2_0, arg_2_0.nextClickTF, function()
						removeOnButton(arg_2_0.nextClickTF)
						existCall(arg_2_2)

						return
					end, SFX_PANEL)
				end

				return
			end)

			return
		end

		var_2_4:setSpeed(arg_2_0.speed)
		var_2_4:Play()

		if arg_2_0.speed ~= NewEducateConst.TYPEWRITE_SPEED_UP then
			onButton(arg_2_0, arg_2_0.nextClickTF, function()
				removeOnButton(arg_2_0.nextClickTF)

				arg_2_0.speed = NewEducateConst.TYPEWRITE_SPEED_UP

				var_2_4:setSpeed(arg_2_0.speed)

				return
			end)
		end

		return
	end
end

function var_0_0.PlayWordIds(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0:CheckName()
	setActive(arg_11_0._go, true)

	if not isActive(arg_11_0._go) and arg_11_0._anim then
		arg_11_0._anim:Play()
	end

	arg_11_0.needClick = true

	setActive(arg_11_0.next, false)
	setActive(arg_11_0.text, not true)
	setActive(arg_11_0.text2, true)
	setActive(arg_11_0.image, not true)
	setActive(arg_11_0.nameTF, false)
	setActive(arg_11_0.resultTF, false)

	local var_11_0 = true and arg_11_0.text2 or arg_11_0.text
	local var_11_1 = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		table.insert(var_11_1, function(arg_12_0)
			arg_11_0.speed = NewEducateConst.TYPEWRITE_SPEED

			setText(var_11_0, (string.gsub(pg.child2_word[iter_11_1].word, "$1", arg_11_0.callName)))
			setActive(arg_11_0.next, iter_11_0 ~= #arg_11_1)

			local var_12_0 = GetComponent(var_11_0, typeof(Typewriter))

			function var_12_0.endFunc()
				if not arg_11_0.needClick then
					onDelayTick(function()
						arg_12_0()

						return
					end, 1)
				else
					onButton(arg_11_0, arg_11_0.nextClickTF, function()
						removeOnButton(arg_11_0.nextClickTF)
						arg_12_0()

						return
					end, SFX_PANEL)
				end

				return
			end

			var_12_0:setSpeed(arg_11_0.speed)
			var_12_0:Play()

			if arg_11_0.speed ~= NewEducateConst.TYPEWRITE_SPEED_UP then
				onButton(arg_11_0, arg_11_0.nextClickTF, function()
					removeOnButton(arg_11_0.nextClickTF)

					arg_11_0.speed = NewEducateConst.TYPEWRITE_SPEED_UP

					var_12_0:setSpeed(arg_11_0.speed)

					return
				end)
			end

			return
		end)
	end

	seriesAsync(var_11_1, function()
		existCall(arg_11_2)

		return
	end)

	return
end

function var_0_0.CheckName(arg_18_0)
	arg_18_0.callName = arg_18_0.callName or getProxy(NewEducateProxy):GetCurChar():GetCallName()
	arg_18_0.name = arg_18_0.name or getProxy(NewEducateProxy):GetCurChar():GetName()
	arg_18_0.playerName = arg_18_0.playerName or getProxy(PlayerProxy):getRawData():GetName()

	return
end

function var_0_0.Reset(arg_19_0)
	setActive(arg_19_0._go, false)
	removeOnButton(arg_19_0.nextClickTF)

	arg_19_0.speed = NewEducateConst.TYPEWRITE_SPEED

	return
end

function var_0_0.UpdateCallName(arg_20_0)
	arg_20_0.callName = getProxy(NewEducateProxy):GetCurChar():GetCallName()

	return
end

function var_0_0.Destroy(arg_21_0)
	pg.DelegateInfo.Dispose(arg_21_0)

	return
end

return var_0_0
