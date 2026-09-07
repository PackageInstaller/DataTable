local IslandChatBubblePlayer = class("IslandChatBubblePlayer", import("Mgr.Story.model.animation.StoryAnimtion"))

function IslandChatBubblePlayer:Ctor(arg_1_1, arg_1_2)
	IslandChatBubblePlayer.super.Ctor(self)

	self.tpl = arg_1_1
	self.role = arg_1_2
	self.contentTr = self.tpl.transform:Find("content")
	self.emojiContainer = self.tpl.transform:Find("face")
	self.expressionContainer = self.tpl.transform:Find("expression")
	self.contentTxt = self.contentTr:Find("Text"):GetComponent("RichText")
	self.isPlaying = false
	self.canShowFlag = true

	return
end

function IslandChatBubblePlayer:Play(arg_2_1, arg_2_2)
	self:Stop()

	self.canShowFlag = true
	self.isPlaying = true

	seriesAsync({
		function(arg_3_0)
			self:ClearEmojiAndExpressionEmoji()
			self:ShowOrHide(true)
			self:UpdateBubble(arg_2_1, arg_3_0)

			return
		end,
		function(arg_4_0)
			self:WaitForNextOne(arg_2_1, arg_4_0)

			return
		end,
		function(arg_5_0)
			self:EneAction(arg_2_1)

			self.isPlaying = false
			self.canShowFlag = false

			arg_5_0()

			return
		end
	}, arg_2_2)

	return
end

function IslandChatBubblePlayer:UpdateBubble(arg_6_1, arg_6_2)
	self:PlayCharatorAnimation(arg_6_1)

	local var_6_0 = arg_6_1:ExistEmoji()
	local var_6_1 = arg_6_1:GetEmojiType()

	setActive(self.contentTr, not var_6_0)
	setActive(self.emojiContainer, var_6_0 and var_6_1 == BubbleStep.EMOJI_TYPE_CHAT)
	setActive(self.expressionContainer, var_6_0 and var_6_1 == BubbleStep.EMOJI_TYPE_EXPRESSION)

	if var_6_0 then
		self:UpdateEmoji(arg_6_1, arg_6_2)
	else
		self:UpdateContent(arg_6_1, arg_6_2)
	end

	return
end

function IslandChatBubblePlayer:UpdateContent(arg_7_1, arg_7_2)
	local var_7_0 = arg_7_1:GetSay()

	if var_7_0 == "" then
		if arg_7_2 then
			arg_7_2()
		end

		return
	end

	self.contentTxt.text = self:GetContent(self.contentTr, var_7_0)

	arg_7_2()

	return
end

function IslandChatBubblePlayer:GetContent(arg_8_1, arg_8_2)
	local var_8_0 = tf(arg_8_1):Find("Text"):GetComponent("RichText")

	var_8_0.supportRichText = false

	eachChild(tf(arg_8_1):Find("Text"), function(arg_9_0)
		Destroy(arg_9_0)

		return
	end)

	for iter_8_0 in string.gmatch(arg_8_2, ChatConst.EmojiIconCodeMatch) do
		if table.contains(pg.emoji_small_template.all, tonumber(iter_8_0)) then
			var_8_0:AddSprite(iter_8_0, (LoadSprite("emoji/" .. pg.emoji_small_template[tonumber(iter_8_0)].pic .. "_small", nil)))
		end
	end

	return (string.gsub(arg_8_2, ChatConst.EmojiIconCodeMatch, function(arg_10_0)
		if table.contains(pg.emoji_small_template.all, tonumber(arg_10_0)) then
			return string.format("<icon name=%s w=1 h=1/>", arg_10_0)
		end

		return
	end))
end

function IslandChatBubblePlayer:UpdateEmoji(arg_11_1, arg_11_2)
	self:ClearEmojiAndExpressionEmoji()

	local var_11_0, var_11_1 = arg_11_1:GetEmoji()

	if var_11_1 == BubbleStep.EMOJI_TYPE_CHAT then
		self:UpdateChatTypeEmoji(var_11_0, arg_11_2)
	elseif var_11_1 == BubbleStep.EMOJI_TYPE_EXPRESSION then
		self:UpdateExpressionTypeEmoji(var_11_0, arg_11_2)
	end

	return
end

function IslandChatBubblePlayer:UpdateChatTypeEmoji(arg_12_1, arg_12_2)
	local var_12_0 = pg.emoji_template[arg_12_1]

	PoolMgr.GetInstance():GetPrefab("emoji/" .. pg.emoji_template[arg_12_1].pic, pg.emoji_template[arg_12_1].pic, true, function(arg_13_0)
		local var_13_0 = arg_13_0:GetComponent("Animator")

		if var_13_0 then
			var_13_0.enabled = true
		end

		setParent(arg_13_0, self.emojiContainer, false)

		arg_13_0.transform.localScale = (arg_13_0:GetComponent(typeof(CriManaEffectUI)) or var_13_0) and Vector3(0.72, 0.72, 1) or Vector3(0.72, 0.72, 1)

		setAnchoredPosition3D(arg_13_0, Vector3(0, 9, 0))

		if arg_13_0:GetComponent(typeof(Image)) then
			local var_13_1 = GetOrAddComponent(arg_13_0, typeof(Outline))

			var_13_1.effectColor = Color.NewHex("707275")
			var_13_1.effectDistance = Vector2(2, -2)
		end

		self.emojiGo = arg_13_0
		self.template = var_12_0

		arg_12_2()

		return
	end)

	return
end

function IslandChatBubblePlayer:ClearExpressionEmoji()
	if self.expressionTr then
		Object.Destroy(self.expressionTr)

		self.expressionTr = nil
	end

	return
end

function IslandChatBubblePlayer:UpdateExpressionTypeEmoji(arg_15_1, arg_15_2)
	ResourceMgr.Inst:getAssetAsync("Island/emoji/" .. arg_15_1, "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_16_0)
		local var_16_0 = Object.Instantiate(arg_16_0)

		setParent(var_16_0, self.expressionContainer, false)
		setAnchoredPosition3D(var_16_0, Vector3(0, 9, 0))

		self.expressionTr = var_16_0

		arg_15_2()

		return
	end), true, true)

	return
end

function IslandChatBubblePlayer:ClearEmoji()
	if self.emojiGo and self.template then
		self.emojiGo.transform.localPosition = Vector3(0, 0, 0)
		self.emojiGo.transform.localScale = Vector3(1, 1, 1)

		local var_17_0 = GetOrAddComponent(self.emojiGo, typeof(Outline))

		if var_17_0 then
			Object.Destroy(var_17_0)
		end

		PoolMgr.GetInstance():ReturnPrefab("emoji/" .. self.template.pic, self.template.pic, self.emojiGo)
	end

	self.emojiGo = nil
	self.template = nil

	return
end

function IslandChatBubblePlayer:WaitForNextOne(arg_18_1, arg_18_2)
	self:UnscaleDelayCall(arg_18_1:GetTime(), arg_18_2)

	return
end

function IslandChatBubblePlayer:PlayCharatorAnimation(arg_19_1)
	if not arg_19_1:ExistAnimation() then
		return
	end

	local var_19_0 = self.role
	local var_19_1 = arg_19_1:GetAnimation()
	local var_19_2 = self.role:GetComponent(typeof(Animator))

	var_19_2 = var_19_2 or var_19_0.transform:GetChild(0):GetComponent(typeof(Animator))

	if not var_19_2:GetCurrentAnimatorStateInfo(0):IsName(var_19_1) then
		local var_19_3 = Animator.StringToHash(var_19_1)

		for iter_19_0 = 1, var_19_2.layerCount do
			var_19_2:CrossFadeInFixedTime(var_19_3, 0.2, iter_19_0 - 1)
		end
	end

	return
end

function IslandChatBubblePlayer:EneAction(arg_20_1)
	self:RemnoveTimer()

	local var_20_0, var_20_1 = arg_20_1:GetHideType()

	if var_20_0 == BubbleStep.HIDE_TYPE_IMMEDIATELY then
		self:ClearEmojiAndExpressionEmoji()
		self:ShowOrHide(false)
	elseif var_20_0 == BubbleStep.HIDE_TYPE_NEVER then
		-- block empty
	elseif var_20_0 == BubbleStep.HIDE_TYPE_TIME then
		self.timer = self:CreateDelayTimer(var_20_1, function()
			if not IsNil(self.tpl) then
				self:ClearEmojiAndExpressionEmoji()
				self:ShowOrHide(false)
			end

			return
		end)
	end

	return
end

function IslandChatBubblePlayer:RemnoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function IslandChatBubblePlayer:ClearEmojiAndExpressionEmoji()
	self:ClearEmoji()
	self:ClearExpressionEmoji()

	return
end

function IslandChatBubblePlayer:Stop()
	self:RemnoveTimer()
	self:ClearEmojiAndExpressionEmoji()
	self:ClearAnimation()
	self:ShowOrHide(show)

	self.isPlaying = false
	self.canShowFlag = true

	return
end

function IslandChatBubblePlayer:IsPlaying()
	return self.isPlaying
end

function IslandChatBubblePlayer:SetShowFlag(arg_26_1)
	if self:IsPlaying() then
		return
	end

	self.canShowFlag = arg_26_1

	setActive(self.tpl, arg_26_1)

	return
end

function IslandChatBubblePlayer:ShowOrHide(arg_27_1)
	if arg_27_1 and not self.canShowFlag then
		return
	end

	setActive(self.tpl, arg_27_1)

	return
end

function IslandChatBubblePlayer:Dispose()
	Object.Destroy(self.tpl)

	self.tpl = nil
	self.role = nil
	self.contentTxt = nil
	self.isPlaying = false
	self.canShowFlag = true

	self:RemnoveTimer()
	self:ClearAnimation()

	return
end

return IslandChatBubblePlayer
