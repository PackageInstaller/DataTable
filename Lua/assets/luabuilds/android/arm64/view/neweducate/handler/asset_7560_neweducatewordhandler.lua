local NewEducateWordHandler = class("NewEducateWordHandler")

function NewEducateWordHandler:Ctor(arg_1_1)
	pg.DelegateInfo.New(self)

	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self._anim = self._tf:GetComponent(typeof(Animation))
	self.content = self._tf:Find("content")
	self.image = self.content:Find("Image")
	self.nameTF = self.content:Find("name_bg")
	self.nameText = self.nameTF:Find("name")
	self.next = self.content:Find("next")
	self.text = self.content:Find("Text")
	self.text2 = self.content:Find("Text2")
	self.resultTF = self.content:Find("result")
	self.resultTpl = self.content:Find("tpl")
	self.nextClickTF = self._tf:Find("click")
	self.speed = NewEducateConst.TYPEWRITE_SPEED

	return
end

function NewEducateWordHandler:Play(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	self.speed = NewEducateConst.TYPEWRITE_SPEED

	local var_2_0 = pg.child2_word[arg_2_1]

	assert(pg.child2_word[arg_2_1], "child2_word not exist id: " .. arg_2_1)
	self:CheckName()
	setActive(self._go, true)

	if not isActive(self._go) and self._anim then
		self._anim:Play()
	end

	self.needClick = arg_2_5

	setActive(self.next, arg_2_4)

	self.drops = arg_2_3 or {}

	local var_2_1 = var_2_0.char_type ~= NewEducateConst.WORD_TYPE.CHILD or var_2_0.char_type == NewEducateConst.WORD_TYPE.HIDE_IMAGE

	setActive(self.text, not (var_2_0.char_type ~= NewEducateConst.WORD_TYPE.CHILD or var_2_0.char_type == NewEducateConst.WORD_TYPE.HIDE_IMAGE))
	setActive(self.text2, var_2_1)
	setActive(self.image, not var_2_1)

	if not var_2_1 then
		setImageSprite(self.image, LoadSprite("storyicon/" .. getProxy(NewEducateProxy):GetCurChar():GetPaintingName()), true)
	end

	local var_2_2

	if var_2_1 then
		var_2_2 = self.text2 or self.text
	end

	setText(var_2_2, (string.gsub(var_2_0.word, "$1", self.callName)))
	setActive(self.nameTF, var_2_0.char_type ~= NewEducateConst.WORD_TYPE.ASIDE)

	if var_2_0.char_type ~= NewEducateConst.WORD_TYPE.ASIDE then
		local var_2_3 = ""

		if var_2_0.char_type == NewEducateConst.WORD_TYPE.CHILD or var_2_0.char_type == NewEducateConst.WORD_TYPE.HIDE_IMAGE then
			var_2_3 = self.name
		elseif var_2_0.char_type == NewEducateConst.WORD_TYPE.PLAYER then
			var_2_3 = self.playerName
		end

		setText(self.nameText, var_2_3)
	end

	local var_2_4 = GetComponent(var_2_2, typeof(Typewriter))

	function var_2_4.endFunc()
		setActive(self.resultTF, true)

		local var_3_0 = {}

		for iter_3_0 = 1, #self.drops do
			table.insert(var_3_0, function(arg_4_0)
				local var_4_0 = self.drops[iter_3_0]
				local var_4_1 = iter_3_0 < self.resultTF.childCount and self.resultTF:GetChild(iter_3_0 - 1) or cloneTplTo(self.resultTpl, self.resultTF)

				if self.drops[iter_3_0].type == NewEducateConst.DROP_TYPE.BUFF then
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

		seriesAsync(var_3_0, function()
			if not self.needClick then
				onDelayTick(function()
					setActive(self.resultTF, false)
					eachChild(self.resultTF, function(arg_8_0)
						setActive(arg_8_0, false)

						return
					end)
					existCall(arg_2_2)

					return
				end, 1)
			else
				onButton(self, self.nextClickTF, function()
					removeOnButton(self.nextClickTF)
					existCall(arg_2_2)

					return
				end, SFX_PANEL)
			end

			return
		end)

		return
	end

	var_2_4:setSpeed(self.speed)
	var_2_4:Play()

	if self.speed ~= NewEducateConst.TYPEWRITE_SPEED_UP then
		onButton(self, self.nextClickTF, function()
			removeOnButton(self.nextClickTF)

			self.speed = NewEducateConst.TYPEWRITE_SPEED_UP

			var_2_4:setSpeed(self.speed)

			return
		end)
	end

	return
end

function NewEducateWordHandler:PlayWordIds(arg_11_1, arg_11_2)
	self:CheckName()
	setActive(self._go, true)

	if not isActive(self._go) and self._anim then
		self._anim:Play()
	end

	self.needClick = true

	setActive(self.next, false)
	setActive(self.text, not true)
	setActive(self.text2, true)
	setActive(self.image, not true)
	setActive(self.nameTF, false)
	setActive(self.resultTF, false)

	if true then
		local var_11_0 = self.text2 or self.text
	end

	local var_11_1 = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		table.insert(var_11_1, function(arg_12_0)
			self.speed = NewEducateConst.TYPEWRITE_SPEED

			setText(var_11_0, (string.gsub(pg.child2_word[iter_11_1].word, "$1", self.callName)))
			setActive(self.next, iter_11_0 ~= #arg_11_1)

			local var_12_0 = GetComponent(var_11_0, typeof(Typewriter))

			function var_12_0.endFunc()
				if not self.needClick then
					onDelayTick(function()
						arg_12_0()

						return
					end, 1)
				else
					onButton(self, self.nextClickTF, function()
						removeOnButton(self.nextClickTF)
						arg_12_0()

						return
					end, SFX_PANEL)
				end

				return
			end

			var_12_0:setSpeed(self.speed)
			var_12_0:Play()

			if self.speed ~= NewEducateConst.TYPEWRITE_SPEED_UP then
				onButton(self, self.nextClickTF, function()
					removeOnButton(self.nextClickTF)

					self.speed = NewEducateConst.TYPEWRITE_SPEED_UP

					var_12_0:setSpeed(self.speed)

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

function NewEducateWordHandler:CheckName()
	self.callName = self.callName or getProxy(NewEducateProxy):GetCurChar():GetCallName()
	self.name = self.name or getProxy(NewEducateProxy):GetCurChar():GetName()
	self.playerName = self.playerName or getProxy(PlayerProxy):getRawData():GetName()

	return
end

function NewEducateWordHandler:Reset()
	setActive(self._go, false)
	removeOnButton(self.nextClickTF)

	self.speed = NewEducateConst.TYPEWRITE_SPEED

	return
end

function NewEducateWordHandler:UpdateCallName()
	self.callName = getProxy(NewEducateProxy):GetCurChar():GetCallName()

	return
end

function NewEducateWordHandler:Destroy()
	pg.DelegateInfo.Dispose(self)

	return
end

return NewEducateWordHandler
