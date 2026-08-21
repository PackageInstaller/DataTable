local var_0_0 = class("IslandChatBubblePlayer", import("Mgr.Story.model.animation.StoryAnimtion"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0)

	arg_1_0.tpl = arg_1_1
	arg_1_0.role = arg_1_2
	arg_1_0.contentTr = arg_1_0.tpl.transform:Find("content")
	arg_1_0.emojiContainer = arg_1_0.tpl.transform:Find("face")
	arg_1_0.expressionContainer = arg_1_0.tpl.transform:Find("expression")
	arg_1_0.contentTxt = arg_1_0.contentTr:Find("Text"):GetComponent("RichText")
	arg_1_0.isPlaying = false
	arg_1_0.canShowFlag = true

	return
end

function var_0_0.Play(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:Stop()

	arg_2_0.canShowFlag = true
	arg_2_0.isPlaying = true

	seriesAsync({
		function(arg_3_0)
			arg_2_0:ClearEmojiAndExpressionEmoji()
			arg_2_0:ShowOrHide(true)
			arg_2_0:UpdateBubble(arg_2_1, arg_3_0)

			return
		end,
		function(arg_4_0)
			arg_2_0:WaitForNextOne(arg_2_1, arg_4_0)

			return
		end,
		function(arg_5_0)
			arg_2_0:EneAction(arg_2_1)

			arg_2_0.isPlaying = false
			arg_2_0.canShowFlag = false

			arg_5_0()

			return
		end
	}, arg_2_2)

	return
end

function var_0_0.UpdateBubble(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:PlayCharatorAnimation(arg_6_1)

	local var_6_0 = arg_6_1:ExistEmoji()
	local var_6_1 = arg_6_1:GetEmojiType()

	setActive(arg_6_0.contentTr, not var_6_0)
	setActive(arg_6_0.emojiContainer, var_6_0 and var_6_1 == BubbleStep.EMOJI_TYPE_CHAT)
	setActive(arg_6_0.expressionContainer, var_6_0 and var_6_1 == BubbleStep.EMOJI_TYPE_EXPRESSION)

	if var_6_0 then
		arg_6_0:UpdateEmoji(arg_6_1, arg_6_2)
	else
		arg_6_0:UpdateContent(arg_6_1, arg_6_2)
	end

	return
end

function var_0_0.UpdateContent(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_1:GetSay()

	if var_7_0 == "" then
		if arg_7_2 then
			arg_7_2()
		end

		return
	end

	arg_7_0.contentTxt.text = arg_7_0:GetContent(arg_7_0.contentTr, var_7_0)

	arg_7_2()

	return
end

function var_0_0.GetContent(arg_8_0, arg_8_1, arg_8_2)
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

function var_0_0.UpdateEmoji(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0:ClearEmojiAndExpressionEmoji()

	local var_11_0, var_11_1 = arg_11_1:GetEmoji()

	if var_11_1 == BubbleStep.EMOJI_TYPE_CHAT then
		arg_11_0:UpdateChatTypeEmoji(var_11_0, arg_11_2)
	elseif var_11_1 == BubbleStep.EMOJI_TYPE_EXPRESSION then
		arg_11_0:UpdateExpressionTypeEmoji(var_11_0, arg_11_2)
	end

	return
end

function var_0_0.UpdateChatTypeEmoji(arg_12_0, arg_12_1, arg_12_2)
	PoolMgr.GetInstance():GetPrefab("emoji/" .. pg.emoji_template[arg_12_1].pic, pg.emoji_template[arg_12_1].pic, true, function(arg_13_0)
		local var_13_0 = arg_13_0:GetComponent("Animator")

		if var_13_0 then
			var_13_0.enabled = true
		end

		setParent(arg_13_0, arg_12_0.emojiContainer, false)

		arg_13_0.transform.localScale = (arg_13_0:GetComponent(typeof(CriManaEffectUI)) or var_13_0) and Vector3(0.72, 0.72, 1) or Vector3(0.72, 0.72, 1)

		setAnchoredPosition3D(arg_13_0, Vector3(0, 9, 0))

		if arg_13_0:GetComponent(typeof(Image)) then
			local var_13_1 = GetOrAddComponent(arg_13_0, typeof(Outline))

			var_13_1.effectColor = Color.NewHex("707275")
			var_13_1.effectDistance = Vector2(2, -2)
		end

		arg_12_0.emojiGo = arg_13_0
		arg_12_0.template = var_0

		arg_12_2()

		return
	end)

	return
end

function var_0_0.ClearExpressionEmoji(arg_14_0)
	if arg_14_0.expressionTr then
		Object.Destroy(arg_14_0.expressionTr)

		arg_14_0.expressionTr = nil
	end

	return
end

function var_0_0.UpdateExpressionTypeEmoji(arg_15_0, arg_15_1, arg_15_2)
	ResourceMgr.Inst:getAssetAsync("Island/emoji/" .. arg_15_1, "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_16_0)
		local var_16_0 = Object.Instantiate(arg_16_0)

		setParent(var_16_0, arg_15_0.expressionContainer, false)
		setAnchoredPosition3D(var_16_0, Vector3(0, 9, 0))

		arg_15_0.expressionTr = var_16_0

		arg_15_2()

		return
	end), true, true)

	return
end

function var_0_0.ClearEmoji(arg_17_0)
	if arg_17_0.emojiGo and arg_17_0.template then
		arg_17_0.emojiGo.transform.localPosition = Vector3(0, 0, 0)
		arg_17_0.emojiGo.transform.localScale = Vector3(1, 1, 1)

		local var_17_0 = GetOrAddComponent(arg_17_0.emojiGo, typeof(Outline))

		if var_17_0 then
			Object.Destroy(var_17_0)
		end

		PoolMgr.GetInstance():ReturnPrefab("emoji/" .. arg_17_0.template.pic, arg_17_0.template.pic, arg_17_0.emojiGo)
	end

	arg_17_0.emojiGo = nil
	arg_17_0.template = nil

	return
end

function var_0_0.WaitForNextOne(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0:UnscaleDelayCall(arg_18_1:GetTime(), arg_18_2)

	return
end

function var_0_0.PlayCharatorAnimation(arg_19_0, arg_19_1)
	if not arg_19_1:ExistAnimation() then
		return
	end

	local var_19_1 = arg_19_1:GetAnimation()
	local var_19_2 = arg_19_0.role:GetComponent(typeof(Animator))

	var_19_2 = var_19_2 or var_19_0.transform:GetChild(0):GetComponent(typeof(Animator))

	local var_19_3 = var_19_2:GetCurrentAnimatorStateInfo(0)

	if not var_19_3:IsName(var_19_1) then
		local var_19_4 = Animator.StringToHash(var_19_1)

		for iter_19_0 = 1, var_19_2.layerCount do
			var_19_2:CrossFadeInFixedTime(var_19_4, 0.2, iter_19_0 - 1)
		end
	end

	return
end

function var_0_0.EneAction(arg_20_0, arg_20_1)
	arg_20_0:RemnoveTimer()

	local var_20_0, var_20_1 = arg_20_1:GetHideType()

	if var_20_0 == BubbleStep.HIDE_TYPE_IMMEDIATELY then
		arg_20_0:ClearEmojiAndExpressionEmoji()
		arg_20_0:ShowOrHide(false)
	elseif var_20_0 == BubbleStep.HIDE_TYPE_NEVER then
		-- block empty
	elseif var_20_0 == BubbleStep.HIDE_TYPE_TIME then
		arg_20_0.timer = arg_20_0:CreateDelayTimer(var_20_1, function()
			if not IsNil(arg_20_0.tpl) then
				arg_20_0:ClearEmojiAndExpressionEmoji()
				arg_20_0:ShowOrHide(false)
			end

			return
		end)
	end

	return
end

function var_0_0.RemnoveTimer(arg_22_0)
	if arg_22_0.timer then
		arg_22_0.timer:Stop()

		arg_22_0.timer = nil
	end

	return
end

function var_0_0.ClearEmojiAndExpressionEmoji(arg_23_0)
	arg_23_0:ClearEmoji()
	arg_23_0:ClearExpressionEmoji()

	return
end

function var_0_0.Stop(arg_24_0)
	arg_24_0:RemnoveTimer()
	arg_24_0:ClearEmojiAndExpressionEmoji()
	arg_24_0:ClearAnimation()
	arg_24_0:ShowOrHide(show)

	arg_24_0.isPlaying = false
	arg_24_0.canShowFlag = true

	return
end

function var_0_0.IsPlaying(arg_25_0)
	return arg_25_0.isPlaying
end

function var_0_0.SetShowFlag(arg_26_0, arg_26_1)
	if arg_26_0:IsPlaying() then
		return
	end

	arg_26_0.canShowFlag = arg_26_1

	setActive(arg_26_0.tpl, arg_26_1)

	return
end

function var_0_0.ShowOrHide(arg_27_0, arg_27_1)
	if arg_27_1 and not arg_27_0.canShowFlag then
		return
	end

	setActive(arg_27_0.tpl, arg_27_1)

	return
end

function var_0_0.Dispose(arg_28_0)
	Object.Destroy(arg_28_0.tpl)

	arg_28_0.tpl = nil
	arg_28_0.role = nil
	arg_28_0.contentTxt = nil
	arg_28_0.isPlaying = false
	arg_28_0.canShowFlag = true

	arg_28_0:RemnoveTimer()
	arg_28_0:ClearAnimation()

	return
end

return var_0_0
