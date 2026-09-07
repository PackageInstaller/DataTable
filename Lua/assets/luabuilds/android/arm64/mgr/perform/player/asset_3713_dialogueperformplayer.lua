local DialoguePerformPlayer = class("DialoguePerformPlayer", import(".BasePerformPlayer"))

DialoguePerformPlayer.TYPEWRITE_SPEED = 0.05
DialoguePerformPlayer.TYPEWRITE_SPEED_UP = 0.01

function DialoguePerformPlayer:Ctor(arg_1_1)
	DialoguePerformPlayer.super.Ctor(self, arg_1_1)
	pg.DelegateInfo.New(self)

	self.eventTipBig = self._tf:Find("event_tip")
	self.content = self._tf:Find("content")
	self.image = self.content:Find("Image")
	self.nameTF = self.content:Find("name_bg")
	self.nameText = self.nameTF:Find("name")
	self.next = self.content:Find("next")
	self.eventTipSmall = self.content:Find("event_tip")
	self.text = self.content:Find("Text")
	self.text2 = self.content:Find("Text2")
	self.resultTF = self.content:Find("result")
	self.resultTpl = self.content:Find("tpl")
	self.nextClickTF = self._tf:Find("click")

	return
end

function DialoguePerformPlayer:Play(arg_2_1, arg_2_2)
	setActive(self.nextClickTF, true)
	self:checkName()
	self:Show()

	local var_2_0 = pg.child_word[arg_2_1.param[1]]

	assert(arg_2_1.param[1] and var_2_0, "child_word not exist id: " .. arg_2_1.param[1])
	setActive(self.eventTipBig, arg_2_1.show_event == 1)

	if arg_2_1.show_event == 1 then
		onDelayTick(function()
			if self._anim then
				self._anim:Play()
			end

			self:_play(arg_2_1, var_2_0, arg_2_2)

			return
		end, 0.66)
	else
		setActive(self.eventTipBig, false)

		if self._anim then
			self._anim:Play()
		end

		self:_play(arg_2_1, var_2_0, arg_2_2)
	end

	return
end

function DialoguePerformPlayer:_play(arg_4_1, arg_4_2, arg_4_3)
	self.speed = DialoguePerformPlayer.TYPEWRITE_SPEED

	setActive(self.eventTipSmall, arg_4_1.show_event == 1)
	setActive(self.next, arg_4_1.show_next == 1)

	if arg_4_1.show_drops == 1 then
		self.drops = arg_4_1.drops or {}
	end

	local var_4_0 = arg_4_2.char_type ~= EducateConst.WORD_TYPE_CHILD

	setActive(self.text, not (arg_4_2.char_type ~= EducateConst.WORD_TYPE_CHILD))
	setActive(self.text2, var_4_0)
	setActive(self.image, not var_4_0)

	if not var_4_0 then
		setImageSprite(self.image, LoadSprite("storyicon/" .. getProxy(EducateProxy):GetCharData():GetPaintingName()), true)
	end

	local var_4_2 = var_4_0 and self.text2 or self.text

	setText(var_4_0 and self.text2 or self.text, (string.gsub(arg_4_2.word, "$1", self.callName)))

	local var_4_3 = GetComponent(var_4_2, typeof(Typewriter))

	if arg_4_2.char_type == EducateConst.WORD_TYPE_ASIDE then
		setActive(self.nameTF, false)
	else
		setActive(self.nameTF, true)

		local var_4_4 = ""

		if arg_4_2.char_type == EducateConst.WORD_TYPE_CHILD then
			var_4_4 = self.name
		elseif arg_4_2.char_type == EducateConst.WORD_TYPE_PLAYER then
			var_4_4 = self.playerName
		end

		setText(self.nameText, var_4_4)
	end

	function var_4_3.endFunc()
		setActive(self.resultTF, true)

		local var_5_0 = {}

		for iter_5_0 = 1, #self.drops do
			table.insert(var_5_0, function(arg_6_0)
				self.resultTF = self.content:Find("result")
				self.resultTpl = self.content:Find("tpl")

				local var_6_0 = self.drops[iter_5_0]
				local var_6_1 = iter_5_0 < self.resultTF.childCount and self.resultTF:GetChild(iter_5_0 - 1) or cloneTplTo(self.resultTpl, self.resultTF)

				if self.drops[iter_5_0].type == EducateConst.DROP_TYPE_BUFF then
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

		seriesAsync(var_5_0, function()
			self.twId = LeanTween.delayedCall(1, System.Action(function()
				setActive(self.resultTF, false)
				eachChild(self.resultTF, function(arg_10_0)
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

	var_4_3:setSpeed(self.speed)
	var_4_3:Play()
	onButton(self, self.nextClickTF, function()
		if self.speed == DialoguePerformPlayer.TYPEWRITE_SPEED_UP then
			if self.twId then
				LeanTween.cancel(self.twId)

				self.twId = nil
			end

			setActive(self.resultTF, false)
			eachChild(self.resultTF, function(arg_12_0)
				setActive(arg_12_0, false)

				return
			end)

			if arg_4_3 then
				arg_4_3()
			end
		else
			self.speed = DialoguePerformPlayer.TYPEWRITE_SPEED_UP

			var_4_3:setSpeed(self.speed)
		end

		return
	end)

	return
end

function DialoguePerformPlayer:checkName()
	self.callName = self.callName or getProxy(EducateProxy):GetCharData():GetCallName()
	self.name = self.name or getProxy(EducateProxy):GetCharData():GetName()
	self.playerName = self.playerName or getProxy(PlayerProxy):getRawData():GetName()

	return
end

function DialoguePerformPlayer:Clear()
	setText(self.text, "")
	setText(self.text2, "")
	setActive(self.eventTipBig, false)
	setActive(self.eventTipSmall, false)
	self:Hide()

	return
end

function DialoguePerformPlayer:Dispose()
	if self.twId then
		LeanTween.cancel(self.twId)

		self.twId = nil
	end

	pg.DelegateInfo.Dispose(self)

	return
end

return DialoguePerformPlayer
